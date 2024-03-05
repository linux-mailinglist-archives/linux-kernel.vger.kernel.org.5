Return-Path: <linux-kernel+bounces-92216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C15871CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7531F22930
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3615B685;
	Tue,  5 Mar 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI7o8Snd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F935B671;
	Tue,  5 Mar 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636692; cv=none; b=MnHxqphvn6L9BbZrcyJm6nUt9heVxAYNXbmKMKZAZ5EukDYgTsA0QfP67aYhzsMhsEGY7V2zRGCNAjrSJnGQQkvrBj2HmhoozGZJMnM4hPItGTfZXoNkrDYDr/PUpng923AxZL9uDZHInalyUolMiMr97PZgJUEj5FIEbqiWZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636692; c=relaxed/simple;
	bh=VrgfVfXGL+bniwIr+Gqdl6c583H+xRtQ0rR4oYPIcrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JB/+MobWQqzX2+5BMgJBuDxDoPFtapMyCEGoz7wdIo4kfxX+fCkzjBdM6RpPpX6dnwIaeBRzII6hdCmBkbiVSElrv68AwJPF4D4I8ROwppehWTorQyuJZugMzi4iHhAy2OnTpTUDTjCZoW9dq1y5E+j7rJ3BFsLsxGuWMh4FTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI7o8Snd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D97C43399;
	Tue,  5 Mar 2024 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709636692;
	bh=VrgfVfXGL+bniwIr+Gqdl6c583H+xRtQ0rR4oYPIcrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KI7o8SndIscczSWBa0jSe5sXWiSDqkpwTMxTvZHwnyBl2vOBXKsC7mzoELrAIJ8AP
	 Aus7KDMJTEtC4yWqTzrTtKsjX734wFEKPepsIp/n4O6xK/dj8/Qrf6aNqy1G5HxEFK
	 kWXboG3D5EchpXWmm4UFeX9b7ljgIYbf2ONyBWa/4qN4kndKsleTxNMyExN/kTnrwV
	 jHQ7PkSvg1QNLQ3eee6z7ubdgK+3jFW5QtJdvNomxv6hG1JdxNXv1FOdufJXDH/xgg
	 5FDUGqHvB+Mnz/5o3LvkkN1PlqxIgiiHlqpQdfXYhHaaTfkPFn7o4liwc/C7XcqTds
	 aCqtndlWcFu2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 12:04:33 +0100
Subject: [PATCH net-next 4/4] mptcp: drop lookup_by_id in lookup_addr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-4-c436ba5e569b@kernel.org>
References: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IRouLJLzOQvuPh1nmmYUU3MxKdU5480lf2zN3s0oVSE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vxDaCTvgU0QiI3890Plw4yMOhTvTcmFlgLYX
 g0H4OYsbQeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb8QwAKCRD2t4JPQmmg
 c/eFD/9U61UobHCI0eQctMtjgjY/zwtcGDFKiKx0mdpkxf70WmgWiSJIZYaqJTZYDwJQlEFzhEK
 tUs5/vXMS5KLs+1cHEzEg4gJrbuXCA5MqnfiBT8cTX0ERQTityTNiyAQbijClmBO3r32qidykpA
 b0OKdFDbu83C+pa9NYwrkPm/IDkTkgGwRYEPLLEGxUUf+znTaf6cLQCrdVHfkk6P/8Y9QSe9N2q
 xTSMEr8Z3s1MlbIvlEMztm+tvsb3tiFaUoYxdtFRiWyiFBimYdFT5B99yT4eLyJeZ59QMsT9Gdy
 fLDZZ9MG9P4zRjodU/bkZD+07B38W9Q8QfVVnTaIT3eHs6PDGLpcavRVgsLJInpRrrsilvClkLb
 SqvmQhibf0rin8ZEYvkVTMNGxY9K1Dlk9CvJydtTpz3zpLreW/WIqVWWiE5h3c9EmRaHUxKdov5
 GOgFUEQ38wP+5nR76MHCNYtar0KfLIDWTOe8oO7NO04T6EuFr3/NX7HaL0tVPRIHg4pR5prxkDD
 GgsTp1eQONh5GHeLG5oepkHMhp4ROlt1rkQ0jaSZBXdD3cyLISuxCPtrTsfGIslTxlUkR0Bq0pd
 7GNc5+umCmR47oktMO776uqO+cAOT0zi8JDuyo02EriDQl7eNdztQ7XbJ78sXw0YfJY9nNbwrMx
 sdS/9uSd6pgV/fw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 354083b8386f..5c17d39146ea 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -499,15 +499,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -537,7 +534,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1918,7 +1915,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
+			       __lookup_addr(pernet, &addr.addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "address not found");

-- 
2.43.0


