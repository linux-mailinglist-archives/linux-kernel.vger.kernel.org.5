Return-Path: <linux-kernel+bounces-26684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B982E52C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A0B236E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3DA241E3;
	Tue, 16 Jan 2024 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmW5uz+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375023772;
	Tue, 16 Jan 2024 00:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C591C43394;
	Tue, 16 Jan 2024 00:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364101;
	bh=uwojOkSRfGaW6eah0IpP53DK5E7SRGTo5G4Znq8Fw/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmW5uz+TxrzA+K5wXgEc7YlY+IJ/ANBw+V07NpoiqgsS35GVkDoEt0JxAMcXE6+CV
	 HqQOEuIuXv2xOm/uQhKjU5g8vhE65zUzq57xkO9JZvtiBJ2Y4St95Yi1BvwBL9HaT4
	 MUQkmBNVZk9qyi/fFFGIPm6Mg6k2/tuFMN1yXaGvjt99/b5TYo0EkykVq8V+XLuP7n
	 NSUFPWuW20R7derS+BVzCNzDEDXDijNE/2kwaln5BUzlyqi81vf43oyuvcIBBEJ8lc
	 Zuoj7wHG/Aw2refrR3HKG2CQrRx7krmaj5K3dChVpXPrummipkIJ06sTiN3mH9a+D7
	 MK3TSHpsqkShw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Riches <chris.riches@nutanix.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>,
	eparis@redhat.com,
	audit@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/8] audit: Send netlink ACK before setting connection in auditd_set
Date: Mon, 15 Jan 2024 19:14:48 -0500
Message-ID: <20240116001457.214018-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001457.214018-1-sashal@kernel.org>
References: <20240116001457.214018-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Chris Riches <chris.riches@nutanix.com>

[ Upstream commit 022732e3d846e197539712e51ecada90ded0572a ]

When auditd_set sets the auditd_conn pointer, audit messages can
immediately be put on the socket by other kernel threads. If the backlog
is large or the rate is high, this can immediately fill the socket
buffer. If the audit daemon requested an ACK for this operation, a full
socket buffer causes the ACK to get dropped, also setting ENOBUFS on the
socket.

To avoid this race and ensure ACKs get through, fast-track the ACK in
this specific case to ensure it is sent before auditd_conn is set.

Signed-off-by: Chris Riches <chris.riches@nutanix.com>
[PM: fix some tab vs space damage]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index aeec86ed4708..2ab04e0a7441 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -490,15 +490,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
  * @pid: auditd PID
  * @portid: auditd netlink portid
  * @net: auditd network namespace pointer
+ * @skb: the netlink command from the audit daemon
+ * @ack: netlink ack flag, cleared if ack'd here
  *
  * Description:
  * This function will obtain and drop network namespace references as
  * necessary.  Returns zero on success, negative values on failure.
  */
-static int auditd_set(struct pid *pid, u32 portid, struct net *net)
+static int auditd_set(struct pid *pid, u32 portid, struct net *net,
+		      struct sk_buff *skb, bool *ack)
 {
 	unsigned long flags;
 	struct auditd_connection *ac_old, *ac_new;
+	struct nlmsghdr *nlh;
 
 	if (!pid || !net)
 		return -EINVAL;
@@ -510,6 +514,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
+	/* send the ack now to avoid a race with the queue backlog */
+	if (*ack) {
+		nlh = nlmsg_hdr(skb);
+		netlink_ack(skb, nlh, 0, NULL);
+		*ack = false;
+	}
+
 	spin_lock_irqsave(&auditd_conn_lock, flags);
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
@@ -1203,7 +1214,8 @@ static int audit_replace(struct pid *pid)
 	return auditd_send_unicast_skb(skb);
 }
 
-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+			     bool *ack)
 {
 	u32			seq;
 	void			*data;
@@ -1296,7 +1308,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* register a new auditd connection */
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
-						 sock_net(NETLINK_CB(skb).sk));
+						 sock_net(NETLINK_CB(skb).sk),
+						 skb, ack);
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
@@ -1541,9 +1554,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
  * Parse the provided skb and deal with any messages that may be present,
  * malformed skbs are discarded.
  */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
 {
 	struct nlmsghdr *nlh;
+	bool ack;
 	/*
 	 * len MUST be signed for nlmsg_next to be able to dec it below 0
 	 * if the nlmsg_len was not aligned
@@ -1556,9 +1570,12 @@ static void audit_receive(struct sk_buff  *skb)
 
 	audit_ctl_lock();
 	while (nlmsg_ok(nlh, len)) {
-		err = audit_receive_msg(skb, nlh);
-		/* if err or if this message says it wants a response */
-		if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+		ack = nlh->nlmsg_flags & NLM_F_ACK;
+		err = audit_receive_msg(skb, nlh, &ack);
+
+		/* send an ack if the user asked for one and audit_receive_msg
+		 * didn't already do it, or if there was an error. */
+		if (ack || err)
 			netlink_ack(skb, nlh, err, NULL);
 
 		nlh = nlmsg_next(nlh, &len);
-- 
2.43.0


