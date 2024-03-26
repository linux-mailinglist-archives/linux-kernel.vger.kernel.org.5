Return-Path: <linux-kernel+bounces-119794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A0288CD16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5067B2A2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6813D2B0;
	Tue, 26 Mar 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iTYqtSHi"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5013D24D;
	Tue, 26 Mar 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480901; cv=none; b=F3fC6ktsH639brT/UgJltAOBmV6ZBBatWPM1Rq33QD4D21rCBR5EyPs7IOt5bWfnhE3fEfZ/EuJR/ljPVhmvM0jwrKRHOJRDrbMQ4hZMTAUfQQ45vPmdi8m6cehY7WRTg3H0tux+7U/gEgsXbYWf0faEE18UZ9cHbt71qqSxzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480901; c=relaxed/simple;
	bh=pgAF6n/XsfPqLvbQWoNgOzZcflFOkErTv2riHmfPA6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ekb1Hl9R8Zrn0oFeFFb43lJkP3So/EjO+f9A0yTEhA2SonoVaRrgXiQODwHfeNR1EGWEWYXGhkt/YdosLFo6NcLbzWceJbiBMRIeZB2gpRQtP6//3G4LC4grc+1ReusvoWephMK2g1A6BLcEisQ5Hcos7sc4B4pT0HFrszWO9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iTYqtSHi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SJSbxOBoK5TZinlAuHzVNbCyNDbHN1Mo6Oj++lt28kg=;
	t=1711480900; x=1712690500; b=iTYqtSHifOwvEUgTrix6Cz2gb6Kh452cG2N97fHCEBohDWA
	oHEOYsWVA9vL4eM9Q1ljBw9FHc6bCqgiudXGs4q+YssmTGKGhPEdZtgBQEdPvDx9ha0pAscNAaqJE
	w0pLv2EfVsFLwDhG/lzdEegOevqEkTOh/cbbuQHt7bDkqzy73N2EnR1kMOSePDs933yjVch2JnJtn
	gFzXv1dyunpDYZlvJX1U+PfkoUuPViav3qW74d7UNCHaDUzncEm1iyfKTP1h1iePbcjc9Q/Gbi3yg
	Ur5hrV+mxML+yXMnU+wSARqbB15PX7Dzccpz6DMURT9KZWyIvGHPEmuV6SMXXpLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpCMb-0000000FvLV-12vZ;
	Tue, 26 Mar 2024 20:21:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 3/4] net: drop_monitor: use drop_reason_lookup()
Date: Tue, 26 Mar 2024 20:15:58 +0100
Message-ID: <20240326202131.3ca898497886.Idc122c3395bea9652f34ccaa678e918bfd4fae75@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326192131.438648-6-johannes@sipsolutions.net>
References: <20240326192131.438648-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Now that we have drop_reason_lookup(), we can just use it for
drop_monitor as well, rather than exporting the list itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/dropreason.h |  4 ----
 net/core/drop_monitor.c  | 18 +++---------------
 net/core/skbuff.c        |  6 +++---
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index c157070b5303..0e2195ccf2cd 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -38,10 +38,6 @@ struct drop_reason_list {
 	size_t n_reasons;
 };
 
-/* Note: due to dynamic registrations, access must be under RCU */
-extern const struct drop_reason_list __rcu *
-drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
-
 #ifdef CONFIG_TRACEPOINTS
 const char *drop_reason_lookup(unsigned long long value);
 void drop_reason_show(struct seq_file *m);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index b0f221d658be..185c43e5b501 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -610,9 +610,8 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 				     size_t payload_len)
 {
 	struct net_dm_skb_cb *cb = NET_DM_SKB_CB(skb);
-	const struct drop_reason_list *list = NULL;
-	unsigned int subsys, subsys_reason;
 	char buf[NET_DM_MAX_SYMBOL_LEN];
+	const char *reason_str;
 	struct nlattr *attr;
 	void *hdr;
 	int rc;
@@ -630,19 +629,8 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 		goto nla_put_failure;
 
 	rcu_read_lock();
-	subsys = u32_get_bits(cb->reason, SKB_DROP_REASON_SUBSYS_MASK);
-	if (subsys < SKB_DROP_REASON_SUBSYS_NUM)
-		list = rcu_dereference(drop_reasons_by_subsys[subsys]);
-	subsys_reason = cb->reason & ~SKB_DROP_REASON_SUBSYS_MASK;
-	if (!list ||
-	    subsys_reason >= list->n_reasons ||
-	    !list->reasons[subsys_reason] ||
-	    strlen(list->reasons[subsys_reason]) > NET_DM_MAX_REASON_LEN) {
-		list = rcu_dereference(drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_CORE]);
-		subsys_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	}
-	if (nla_put_string(msg, NET_DM_ATTR_REASON,
-			   list->reasons[subsys_reason])) {
+	reason_str = drop_reason_lookup(cb->reason);
+	if (nla_put_string(msg, NET_DM_ATTR_REASON, reason_str)) {
 		rcu_read_unlock();
 		goto nla_put_failure;
 	}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 012b48da8810..a8065c40a270 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -141,13 +141,11 @@ static const struct drop_reason_list drop_reasons_core = {
 	.n_reasons = ARRAY_SIZE(drop_reasons),
 };
 
-const struct drop_reason_list __rcu *
+static const struct drop_reason_list __rcu *
 drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
 	[SKB_DROP_REASON_SUBSYS_CORE] = RCU_INITIALIZER(&drop_reasons_core),
 };
-EXPORT_SYMBOL(drop_reasons_by_subsys);
 
-#ifdef CONFIG_TRACEPOINTS
 const char *drop_reason_lookup(unsigned long long value)
 {
 	unsigned long long subsys_id = value >> SKB_DROP_REASON_SUBSYS_SHIFT;
@@ -164,7 +162,9 @@ const char *drop_reason_lookup(unsigned long long value)
 		return NULL;
 	return subsys->reasons[reason];
 }
+EXPORT_SYMBOL(drop_reason_lookup);
 
+#ifdef CONFIG_TRACEPOINTS
 void drop_reason_show(struct seq_file *m)
 {
 	u32 subsys_id;
-- 
2.44.0


