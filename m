Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2152A7A98BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjIURvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIURv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E3E6A4F;
        Thu, 21 Sep 2023 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+GqK9nIH4JMvkwqjWovkNfDPm8gLz4+0kcQHvxgQK7c=;
        t=1695316173; x=1696525773; b=hfLzyQE+WLIlacNFWoSUHIDtrcbN7yLr/2lefzwXQS+b9/D
        vT6FHChv0AaYBFMryeKkr49rZFPJcG1O0qGyCql0ue/gMeJj0PJH+sM4s4PRQPDqeTUoqh1UasO6g
        EmhU3IgX/YfTrg6tJGPOlPS99UxOV9BQXi7/CUlEa/LRg5/laO6IwWfC/pdu4hLz6kFfhkaMJBdAN
        2CDzoRlC3Z1ttsPOXOa0POfXIw12k1CNdOwMgRyPK30ju06siYlpLujGc4lOy3BwYbt+ihuUHWdV0
        PoBY84MOxD+5bzRmJa5P6lRUzScr2hSAnOHsPcpfrSARAc0FGwbp1ggC52V1lmdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qjFPn-00D3lb-1V;
        Thu, 21 Sep 2023 10:52:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 3/4] net: drop_monitor: use drop_reason_lookup()
Date:   Thu, 21 Sep 2023 10:51:33 +0200
Message-ID: <20230921105129.c6e7e803398d.Idc122c3395bea9652f34ccaa678e918bfd4fae75@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921085129.261556-5-johannes@sipsolutions.net>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index aff31cd944c2..d110a16cde46 100644
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
index 415329b76921..9efde769949d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -126,13 +126,11 @@ static const struct drop_reason_list drop_reasons_core = {
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
@@ -149,7 +147,9 @@ const char *drop_reason_lookup(unsigned long long value)
 		return NULL;
 	return subsys->reasons[reason];
 }
+EXPORT_SYMBOL(drop_reason_lookup);
 
+#ifdef CONFIG_TRACEPOINTS
 void drop_reason_show(struct seq_file *m)
 {
 	u32 subsys_id;
-- 
2.41.0

