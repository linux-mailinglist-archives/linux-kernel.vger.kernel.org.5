Return-Path: <linux-kernel+bounces-42965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3F84095F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AC828DDD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED0153501;
	Mon, 29 Jan 2024 15:10:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6260DEF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541026; cv=none; b=VNc32Zn07uMiOWVaXXzd28QN8boZCgVbqVtimkcJwZIIIDysckWpZioFgwOuuF1ZbPvUUNoONIP+J8woMAo2AjvCjyPjXfxnaKmI//Aj2PvSMYt0cBVWIObFnGiQR5VEiclf+tZQyKISmG6aEUa1Epcnp1SIIcaJlbN0PlWaHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541026; c=relaxed/simple;
	bh=k/j/A69Qa3nvCVAPsYPbUiKo+co0EeBPptPOE3Lb5zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5sg+SRflL3/qzM9tHbAF8uJP+/sKvh/KvpRotJ3VVoYkPMLzZimRIyiJbZus7dowJu93pC6WZvOjsCZssyXQazofrM6PZ70B1Ry09nrPiCT/tkV+UEyH0c8DUDojVqCEv//oCNjo9Mk8+HWDMi9C+odW0fKtN5fbWT0KcQN3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600E5DA7;
	Mon, 29 Jan 2024 07:11:06 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34663F738;
	Mon, 29 Jan 2024 07:10:21 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Expose Perf protocol domains info
Date: Mon, 29 Jan 2024 15:10:02 +0000
Message-ID: <20240129151002.1215333-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to other existing SCMI protocols, expose Perf protocol domains
information to ease access from interested drivers and avoid adding an
endless stream of ad-hoc accessors.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Apply on sudeep/for-next/scmi/updates
---
 drivers/firmware/arm_scmi/perf.c      | 98 +++++++++------------------
 drivers/firmware/arm_scmi/protocols.h | 13 ----
 include/linux/scmi_protocol.h         | 44 +++++++++++-
 3 files changed, 76 insertions(+), 79 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 9e7b1ee94940..59089d212cbb 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -10,7 +10,6 @@
 #include <linux/bits.h>
 #include <linux/hashtable.h>
 #include <linux/io.h>
-#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -27,8 +26,6 @@
 /* Updated only after ALL the mandatory features for that version are merged */
 #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x40000
 
-#define MAX_OPPS		32
-
 enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_ATTRIBUTES = 0x3,
 	PERF_DESCRIBE_LEVELS = 0x4,
@@ -48,15 +45,6 @@ enum {
 	PERF_FC_MAX,
 };
 
-struct scmi_opp {
-	u32 perf;
-	u32 power;
-	u32 trans_latency_us;
-	u32 indicative_freq;
-	u32 level_index;
-	struct hlist_node hash;
-};
-
 struct scmi_msg_resp_perf_attributes {
 	__le16 num_domains;
 	__le16 flags;
@@ -145,25 +133,6 @@ struct scmi_msg_resp_perf_describe_levels_v4 {
 	} opp[];
 };
 
-struct perf_dom_info {
-	u32 id;
-	bool set_limits;
-	bool perf_limit_notify;
-	bool perf_level_notify;
-	bool perf_fastchannels;
-	bool level_indexing_mode;
-	u32 opp_count;
-	u32 sustained_freq_khz;
-	u32 sustained_perf_level;
-	unsigned long mult_factor;
-	struct scmi_perf_domain_info info;
-	struct scmi_opp opp[MAX_OPPS];
-	struct scmi_fc_info *fc_info;
-	struct xarray opps_by_idx;
-	struct xarray opps_by_lvl;
-	DECLARE_HASHTABLE(opps_by_freq, ilog2(MAX_OPPS));
-};
-
 #define LOOKUP_BY_FREQ(__htp, __freq)					\
 ({									\
 		/* u32 cast is needed to pick right hash func */	\
@@ -182,7 +151,7 @@ struct scmi_perf_info {
 	enum scmi_power_scale power_scale;
 	u64 stats_addr;
 	u32 stats_size;
-	struct perf_dom_info *dom_info;
+	struct scmi_perf_domain_info *dom_info;
 };
 
 static enum scmi_performance_protocol_cmd evt_2_cmd[] = {
@@ -238,7 +207,7 @@ static void scmi_perf_xa_destroy(void *data)
 
 static int
 scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
-				struct perf_dom_info *dom_info,
+				struct scmi_perf_domain_info *dom_info,
 				u32 version)
 {
 	int ret;
@@ -259,7 +228,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		flags = le32_to_cpu(attr->flags);
 
 		dom_info->set_limits = SUPPORTS_SET_LIMITS(flags);
-		dom_info->info.set_perf = SUPPORTS_SET_PERF_LVL(flags);
+		dom_info->set_perf = SUPPORTS_SET_PERF_LVL(flags);
 		dom_info->perf_limit_notify = SUPPORTS_PERF_LIMIT_NOTIFY(flags);
 		dom_info->perf_level_notify = SUPPORTS_PERF_LEVEL_NOTIFY(flags);
 		dom_info->perf_fastchannels = SUPPORTS_PERF_FASTCHANNELS(flags);
@@ -294,8 +263,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			         "Wrong sustained perf/frequency(domain %d)\n",
 				 dom_info->id);
 
-		strscpy(dom_info->info.name, attr->name,
-			SCMI_SHORT_NAME_MAX_SIZE);
+		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -307,7 +275,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET,
-					    dom_info->id, NULL, dom_info->info.name,
+					    dom_info->id, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
 
 	if (dom_info->level_indexing_mode) {
@@ -328,7 +296,7 @@ static int opp_cmp_func(const void *opp1, const void *opp2)
 
 struct scmi_perf_ipriv {
 	u32 version;
-	struct perf_dom_info *perf_dom;
+	struct scmi_perf_domain_info *perf_dom;
 };
 
 static void iter_perf_levels_prepare_message(void *message,
@@ -365,7 +333,7 @@ process_response_opp(struct scmi_opp *opp, unsigned int loop_idx,
 }
 
 static inline void
-process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
+process_response_opp_v4(struct device *dev, struct scmi_perf_domain_info *dom,
 			struct scmi_opp *opp, unsigned int loop_idx,
 			const struct scmi_msg_resp_perf_describe_levels_v4 *r)
 {
@@ -423,7 +391,7 @@ iter_perf_levels_process_response(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph,
-			      struct perf_dom_info *perf_dom, u32 version)
+			      struct scmi_perf_domain_info *perf_dom, u32 version)
 {
 	int ret;
 	void *iter;
@@ -437,7 +405,7 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph,
 		.perf_dom = perf_dom,
 	};
 
-	iter = ph->hops->iter_response_init(ph, &ops, MAX_OPPS,
+	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_OPPS,
 					    PERF_DESCRIBE_LEVELS,
 					    sizeof(struct scmi_msg_perf_describe_levels),
 					    &ppriv);
@@ -462,7 +430,7 @@ static int scmi_perf_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
-static inline struct perf_dom_info *
+static inline struct scmi_perf_domain_info *
 scmi_perf_domain_lookup(const struct scmi_protocol_handle *ph, u32 domain)
 {
 	struct scmi_perf_info *pi = ph->get_priv(ph);
@@ -474,15 +442,15 @@ scmi_perf_domain_lookup(const struct scmi_protocol_handle *ph, u32 domain)
 }
 
 static const struct scmi_perf_domain_info *
-scmi_perf_info_get(const struct scmi_protocol_handle *ph, u32 domain)
+scmi_perf_domain_info_get(const struct scmi_protocol_handle *ph, u32 domain)
 {
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return ERR_PTR(-EINVAL);
 
-	return &dom->info;
+	return dom;
 }
 
 static int scmi_perf_msg_limits_set(const struct scmi_protocol_handle *ph,
@@ -509,7 +477,7 @@ static int scmi_perf_msg_limits_set(const struct scmi_protocol_handle *ph,
 }
 
 static int __scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
-				  struct perf_dom_info *dom, u32 max_perf,
+				  struct scmi_perf_domain_info *dom, u32 max_perf,
 				  u32 min_perf)
 {
 	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].set_addr) {
@@ -530,7 +498,7 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 max_perf, u32 min_perf)
 {
 	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -592,7 +560,7 @@ static int scmi_perf_msg_limits_get(const struct scmi_protocol_handle *ph,
 }
 
 static int __scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
-				  struct perf_dom_info *dom, u32 *max_perf,
+				  struct scmi_perf_domain_info *dom, u32 *max_perf,
 				  u32 *min_perf)
 {
 	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].get_addr) {
@@ -612,7 +580,7 @@ static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 *max_perf, u32 *min_perf)
 {
 	int ret;
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -664,7 +632,7 @@ static int scmi_perf_msg_level_set(const struct scmi_protocol_handle *ph,
 }
 
 static int __scmi_perf_level_set(const struct scmi_protocol_handle *ph,
-				 struct perf_dom_info *dom, u32 level,
+				 struct scmi_perf_domain_info *dom, u32 level,
 				 bool poll)
 {
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
@@ -683,13 +651,13 @@ static int __scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 level, bool poll)
 {
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
-	if (!dom->info.set_perf)
+	if (!dom->set_perf)
 		return -EOPNOTSUPP;
 
 	if (dom->level_indexing_mode) {
@@ -728,7 +696,7 @@ static int scmi_perf_msg_level_get(const struct scmi_protocol_handle *ph,
 }
 
 static int __scmi_perf_level_get(const struct scmi_protocol_handle *ph,
-				 struct perf_dom_info *dom, u32 *level,
+				 struct scmi_perf_domain_info *dom, u32 *level,
 				 bool poll)
 {
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
@@ -745,7 +713,7 @@ static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 *level, bool poll)
 {
 	int ret;
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -791,7 +759,7 @@ static int scmi_perf_level_limits_notify(const struct scmi_protocol_handle *ph,
 }
 
 static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
-				     struct perf_dom_info *dom)
+				     struct scmi_perf_domain_info *dom)
 {
 	struct scmi_fc_info *fc;
 
@@ -807,7 +775,7 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 				   PERF_LIMITS_GET, 8, dom->id,
 				   &fc[PERF_FC_LIMIT].get_addr, NULL);
 
-	if (dom->info.set_perf)
+	if (dom->set_perf)
 		ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
 					   PERF_LEVEL_SET, 4, dom->id,
 					   &fc[PERF_FC_LEVEL].set_addr,
@@ -828,7 +796,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	int idx, ret;
 	unsigned long freq;
 	struct dev_pm_opp_data data = {};
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -851,7 +819,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 		}
 
 		dev_dbg(dev, "[%d][%s]:: Registered OPP[%d] %lu\n",
-			domain, dom->info.name, idx, freq);
+			domain, dom->name, idx, freq);
 	}
 	return 0;
 }
@@ -860,7 +828,7 @@ static int
 scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 				 u32 domain)
 {
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -874,7 +842,7 @@ static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
 	unsigned int level;
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -901,7 +869,7 @@ static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 {
 	int ret;
 	u32 level;
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -930,7 +898,7 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 				   u32 domain, unsigned long *freq,
 				   unsigned long *power)
 {
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
 	struct scmi_opp *opp;
@@ -960,7 +928,7 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 				      u32 domain)
 {
-	struct perf_dom_info *dom;
+	struct scmi_perf_domain_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
@@ -979,7 +947,7 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
-	.info_get = scmi_perf_info_get,
+	.info_get = scmi_perf_domain_info_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
@@ -1123,7 +1091,7 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 		return -ENOMEM;
 
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
-		struct perf_dom_info *dom = pinfo->dom_info + domain;
+		struct scmi_perf_domain_info *dom = pinfo->dom_info + domain;
 
 		dom->id = domain;
 		scmi_perf_domain_attributes_get(ph, dom, version);
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index e683c26f24eb..cecb9b8f7faa 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -223,19 +223,6 @@ struct scmi_iterator_ops {
 				struct scmi_iterator_state *st, void *priv);
 };
 
-struct scmi_fc_db_info {
-	int width;
-	u64 set;
-	u64 mask;
-	void __iomem *addr;
-};
-
-struct scmi_fc_info {
-	void __iomem *set_addr;
-	void __iomem *get_addr;
-	struct scmi_fc_db_info *set_db;
-};
-
 /**
  * struct scmi_proto_helpers_ops  - References to common protocol helpers
  * @extended_name_get: A common helper function to retrieve extended naming
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0cc40af5519a..e0e79ce297b2 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -10,8 +10,11 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/hashtable.h>
+#include <linux/log2.h>
 #include <linux/notifier.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #define SCMI_MAX_STR_SIZE		64
 #define SCMI_SHORT_NAME_MAX_SIZE	16
@@ -115,9 +118,48 @@ struct scmi_clk_proto_ops {
 	int (*parent_set)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 parent_id);
 };
 
+#define SCMI_MAX_OPPS		32
+
+struct scmi_opp {
+	u32 perf;
+	u32 power;
+	u32 trans_latency_us;
+	u32 indicative_freq;
+	u32 level_index;
+	struct hlist_node hash;
+};
+
+struct scmi_fc_db_info {
+	int width;
+	u64 set;
+	u64 mask;
+	void __iomem *addr;
+};
+
+struct scmi_fc_info {
+	void __iomem *set_addr;
+	void __iomem *get_addr;
+	struct scmi_fc_db_info *set_db;
+};
+
 struct scmi_perf_domain_info {
-	char name[SCMI_MAX_STR_SIZE];
+	u32 id;
+	bool set_limits;
 	bool set_perf;
+	bool perf_limit_notify;
+	bool perf_level_notify;
+	bool perf_fastchannels;
+	bool level_indexing_mode;
+	u32 opp_count;
+	u32 sustained_freq_khz;
+	u32 sustained_perf_level;
+	unsigned long mult_factor;
+	char name[SCMI_MAX_STR_SIZE];
+	struct scmi_opp opp[SCMI_MAX_OPPS];
+	struct scmi_fc_info *fc_info;
+	struct xarray opps_by_idx;
+	struct xarray opps_by_lvl;
+	DECLARE_HASHTABLE(opps_by_freq, ilog2(SCMI_MAX_OPPS));
 };
 
 /**
-- 
2.43.0


