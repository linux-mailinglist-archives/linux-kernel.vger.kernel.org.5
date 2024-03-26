Return-Path: <linux-kernel+bounces-119793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E688CD21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534C4B2A188
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D813D29E;
	Tue, 26 Mar 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wUcVvffb"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701713CF8A;
	Tue, 26 Mar 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480901; cv=none; b=sSgd2asB9n649hdPJscM6te1nlYQWdUAunA8PgBgxIZUdvR9sBpjefwRsl48IMe020XmWwzo7ELPAROnCTeZJxX4BnqN9L7MogmbaMR+A12slJsiw4WKgkkvvs9Ts2mYLyI9lTNRhIEhM/+EehpgxDOWzj+8/E28SWkURyMg5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480901; c=relaxed/simple;
	bh=uSs11ecjpgeDVqx2WavChqveazw3qSi8rFo6RbMu0Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSAuM/tW0I4S1ZKxL07c2WwUHEbWUwUV+kbE84agsKhqHSMFRtkN5cwu6tkShbvxeng3ZJi7wzIXNwO96UdWMdCCDyUVvw1dYWLhZhq+ejjd4nKdcIRQaUwnLoJeerSOkhCy023ZfZCEoyh2+AO6JozhTrksS4D8+C5YzW62jA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wUcVvffb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WkRKV3yR6IEr4VIV4AmMyNoDfYPPGMrONmoxJb/nN94=;
	t=1711480899; x=1712690499; b=wUcVvffbFXFy5ahGZ9AP8yn4jiuM4cQQKLOIQ8v09fVjZA2
	QDFwbhI125ZSxDXbHgGIj+1OvU/CAk9+FaWQ5tbef/143bBQhWUUkNI/joIP7qOIBdHvrB8nuVA+Q
	1FAORe94g6I8UgM9oTVTzNOc3wFf+I+kQBMFq1Sbv2VMghtqepOa4AdNwbP7z+iYA2U2C3U2p6qAy
	BLAlPkBQGtqX/PgxZEOcT8t2Wd7HEIkld3J8nh2vOTMzc4Ccgm9iujzBJT5Sc5ZKIU/DqtwQBNPPo
	EvdvkYH1KRESP4eQIwlZ1RVDHa9Ur7HgrwqGFi7t5Gi13AN565RdhP1wlbjFGIZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpCMa-0000000FvLV-1XHM;
	Tue, 26 Mar 2024 20:21:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 2/4] net: dropreason: use new __print_sym() in tracing
Date: Tue, 26 Mar 2024 20:15:57 +0100
Message-ID: <20240326202131.fcbc8a528439.I075de1ac698b47710b94c631afdfb328f07be961@changeid>
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
index b99127712e67..012b48da8810 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -147,6 +147,49 @@ drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
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
2.44.0


