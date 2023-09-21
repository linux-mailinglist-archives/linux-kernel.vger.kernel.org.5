Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F271A7AA26E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjIUVQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjIUVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DAE3A4;
        Thu, 21 Sep 2023 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KcbEGqZWRjDRIS84NcPwJ70wJrRePDMy7FnnB2l/XTc=;
        t=1695316084; x=1696525684; b=IQW96roGNxzONuN9PjcFsaqTedRIWrD2bO14nXq8M2es3l8
        bnZzAgnlNO6iaNG8dZUfCxVtzGQIk7LmP08aymBYLKrVBRpBMA070wDeZbXvgFBJtc1e8tMHt8hE+
        HKYHvfTAa1XJVyjEPdBJT4NVHQBbX1kiKr8XZxsNK7qVjLpfa5rJn2wsMYeuoqj24HR603rRzp0vx
        WeVqVWhCvy2IAjHVj0dFk4AEnkppQMzs3yUq0/1LQMyGb16wbeJ7NDcibUv1pgYG0IUANitDQPVCU
        kgDCgNuXOBRi7p5RKLqVnYBNBe/V6nNAB9yQWy0R4gQT+O6ZIiv44a76jalixKbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qjFPm-00D3lb-0E;
        Thu, 21 Sep 2023 10:52:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/4] net: dropreason: use new __print_sym() in tracing
Date:   Thu, 21 Sep 2023 10:51:32 +0200
Message-ID: <20230921105129.2f2774a87760.I075de1ac698b47710b94c631afdfb328f07be961@changeid>
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

The __print_symbolic() could only ever print the core
drop reasons, since that's the way the infrastructure
works. Now that we have __print_sym() with all the
advantages mentioned in that commit, convert to that
and get all the drop reasons from all subsystems. As
we already have a list of them, that's really easy.

This is a little bit of .text (~100 bytes in my build)
and saves a lot of .data (~17k).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/dropreason.h   |  5 +++++
 include/trace/events/skb.h | 16 +++-----------
 net/core/skbuff.c          | 43 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 56cb7be92244..c157070b5303 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -42,6 +42,11 @@ struct drop_reason_list {
 extern const struct drop_reason_list __rcu *
 drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
 
+#ifdef CONFIG_TRACEPOINTS
+const char *drop_reason_lookup(unsigned long long value);
+void drop_reason_show(struct seq_file *m);
+#endif
+
 void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
 				  const struct drop_reason_list *list);
 void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys);
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 07e0715628ec..8a1a63f9e796 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -8,15 +8,9 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/tracepoint.h>
+#include <net/dropreason.h>
 
-#undef FN
-#define FN(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
-DEFINE_DROP_REASON(FN, FN)
-
-#undef FN
-#undef FNe
-#define FN(reason)	{ SKB_DROP_REASON_##reason, #reason },
-#define FNe(reason)	{ SKB_DROP_REASON_##reason, #reason }
+TRACE_DEFINE_SYM_FNS(drop_reason, drop_reason_lookup, drop_reason_show);
 
 /*
  * Tracepoint for free an sk_buff:
@@ -44,13 +38,9 @@ TRACE_EVENT(kfree_skb,
 
 	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s",
 		  __entry->skbaddr, __entry->protocol, __entry->location,
-		  __print_symbolic(__entry->reason,
-				   DEFINE_DROP_REASON(FN, FNe)))
+		  __print_sym(__entry->reason, drop_reason ))
 );
 
-#undef FN
-#undef FNe
-
 TRACE_EVENT(consume_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location),
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4eaf7ed0d1f4..415329b76921 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -132,6 +132,49 @@ drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
 };
 EXPORT_SYMBOL(drop_reasons_by_subsys);
 
+#ifdef CONFIG_TRACEPOINTS
+const char *drop_reason_lookup(unsigned long long value)
+{
+	unsigned long long subsys_id = value >> SKB_DROP_REASON_SUBSYS_SHIFT;
+	u32 reason = value & ~SKB_DROP_REASON_SUBSYS_MASK;
+	const struct drop_reason_list *subsys;
+
+	if (subsys_id >= SKB_DROP_REASON_SUBSYS_NUM)
+		return NULL;
+
+	subsys = rcu_dereference(drop_reasons_by_subsys[subsys_id]);
+	if (!subsys)
+		return NULL;
+	if (reason >= subsys->n_reasons)
+		return NULL;
+	return subsys->reasons[reason];
+}
+
+void drop_reason_show(struct seq_file *m)
+{
+	u32 subsys_id;
+
+	rcu_read_lock();
+	for (subsys_id = 0; subsys_id < SKB_DROP_REASON_SUBSYS_NUM; subsys_id++) {
+		const struct drop_reason_list *subsys;
+		u32 i;
+
+		subsys = rcu_dereference(drop_reasons_by_subsys[subsys_id]);
+		if (!subsys)
+			continue;
+
+		for (i = 0; i < subsys->n_reasons; i++) {
+			if (!subsys->reasons[i])
+				continue;
+			seq_printf(m, ", { %u, \"%s\" }",
+				   (subsys_id << SKB_DROP_REASON_SUBSYS_SHIFT) | i,
+				   subsys->reasons[i]);
+		}
+	}
+	rcu_read_unlock();
+}
+#endif
+
 /**
  * drop_reasons_register_subsys - register another drop reason subsystem
  * @subsys: the subsystem to register, must not be the core
-- 
2.41.0

