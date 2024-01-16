Return-Path: <linux-kernel+bounces-26653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3F782E493
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7FB22582
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99A1CABF;
	Tue, 16 Jan 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMQQ07kW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD681C698;
	Tue, 16 Jan 2024 00:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8F6C43390;
	Tue, 16 Jan 2024 00:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364031;
	bh=CTpkAvVfwOa7xjZBkAHgE49jU8TOjOiaiOkFenis8/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMQQ07kWQFGlzU9P4X/A2jAuK3QTGapTaQvtVV6mlxK7ECkoula4PqpeOXdIJhmxp
	 HESnVGGyWF0cfS/UhMmuUig1FQ4NCpz2SCcH4yQbluoael/YqlaAsziEwbkjEB4rux
	 v7MKxpSUMltu+FpXBFfT+AGD8sm9JoX0wdE9psHQDIRf0oKa5SbKL9CxkplRlSrRFh
	 x62pGnVrfTH75mKUmwADcVcDiDeGCb8Jt2kN/aSgtJl4kwBrdM1w8KyxuVdqlAgGtS
	 NO8WnDEBkvomjjXug/ZizC22OKglrYw73pg4WBMM0Kj5pm4L3Fpph/hJxHHjOd2djh
	 7rH81xWLewyfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Riches <chris.riches@nutanix.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>,
	eparis@redhat.com,
	audit@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/14] audit: Send netlink ACK before setting connection in auditd_set
Date: Mon, 15 Jan 2024 19:13:28 -0500
Message-ID: <20240116001347.213328-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001347.213328-1-sashal@kernel.org>
References: <20240116001347.213328-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 16205dd29843..9c8e5f732c4c 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -487,15 +487,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
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
@@ -507,6 +511,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
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
@@ -1200,7 +1211,8 @@ static int audit_replace(struct pid *pid)
 	return auditd_send_unicast_skb(skb);
 }
 
-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+			     bool *ack)
 {
 	u32			seq;
 	void			*data;
@@ -1293,7 +1305,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* register a new auditd connection */
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
-						 sock_net(NETLINK_CB(skb).sk));
+						 sock_net(NETLINK_CB(skb).sk),
+						 skb, ack);
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
@@ -1538,9 +1551,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
@@ -1553,9 +1567,12 @@ static void audit_receive(struct sk_buff  *skb)
 
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


