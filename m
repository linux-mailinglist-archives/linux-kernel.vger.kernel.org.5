Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA437568C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjGQQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGQQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:13:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 490A211C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:13:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717C111FB;
        Mon, 17 Jul 2023 09:14:06 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20DA33F738;
        Mon, 17 Jul 2023 09:13:20 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        aidapala@qti.qualcomm.com, souvik.chakravarty@arm.com,
        satyakim@qti.qualcomm.com, atouzni@qti.qualcomm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/2] firmware: arm_scmi: Add v3.2 PERF Level Indexing mode support
Date:   Mon, 17 Jul 2023 17:12:46 +0100
Message-ID: <20230717161246.1761777-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717161246.1761777-1-cristian.marussi@arm.com>
References: <20230717161246.1761777-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v3.2 adds PERF protocol support to optionally define performance
domains that cannot be represented on a linear scale; the platform firmware
can declare the performance levels of a domain as being 'level indexed' and
provide an indicative frequency associated to each of those levels, with
such indexes not required anymore to be contiguous nor to satisfy any
linear-scaling constraint: when level-indexing is available for a domain,
the platform will expect to deal with SCMI requests using indexes instead
of performance levels for that domain.

Add level-indexing mode support to the PERF protocol implementation while
maintaining unchanged the protocol operations interface exposed by PERF;
all the required mapping from performamce levels/frequencies to the
corresponding level indexes is carried out transparently by the core PERF
protocol support: as a consequence no change is either required in any
SCMI driver using the PERF protocol, even when using level indexing.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 367 +++++++++++++++++++++++++------
 1 file changed, 297 insertions(+), 70 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 43dd242ecc49..c0cd556fbaae 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -2,19 +2,22 @@
 /*
  * System Control and Management Interface (SCMI) Performance Protocol
  *
- * Copyright (C) 2018-2022 ARM Ltd.
+ * Copyright (C) 2018-2023 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications PERF - " fmt
 
 #include <linux/bits.h>
-#include <linux/of.h>
+#include <linux/hashtable.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/scmi_protocol.h>
 #include <linux/sort.h>
+#include <linux/xarray.h>
 
 #include <trace/events/scmi.h>
 
@@ -46,6 +49,9 @@ struct scmi_opp {
 	u32 perf;
 	u32 power;
 	u32 trans_latency_us;
+	u32 indicative_freq;
+	u32 level_index;
+	struct hlist_node hash;
 };
 
 struct scmi_msg_resp_perf_attributes {
@@ -66,6 +72,7 @@ struct scmi_msg_resp_perf_domain_attributes {
 #define SUPPORTS_PERF_LEVEL_NOTIFY(x)	((x) & BIT(28))
 #define SUPPORTS_PERF_FASTCHANNELS(x)	((x) & BIT(27))
 #define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(26))
+#define SUPPORTS_LEVEL_INDEXING(x)	((x) & BIT(25))
 	__le32 rate_limit_us;
 	__le32 sustained_freq_khz;
 	__le32 sustained_perf_level;
@@ -122,12 +129,27 @@ struct scmi_msg_resp_perf_describe_levels {
 	} opp[];
 };
 
+struct scmi_msg_resp_perf_describe_levels_v4 {
+	__le16 num_returned;
+	__le16 num_remaining;
+	struct {
+		__le32 perf_val;
+		__le32 power;
+		__le16 transition_latency_us;
+		__le16 reserved;
+		__le32 indicative_freq;
+		__le32 level_index;
+	} opp[];
+};
+
 struct perf_dom_info {
+	u32 id;
 	bool set_limits;
 	bool set_perf;
 	bool perf_limit_notify;
 	bool perf_level_notify;
 	bool perf_fastchannels;
+	bool level_indexing_mode;
 	u32 opp_count;
 	u32 sustained_freq_khz;
 	u32 sustained_perf_level;
@@ -135,8 +157,23 @@ struct perf_dom_info {
 	char name[SCMI_MAX_STR_SIZE];
 	struct scmi_opp opp[MAX_OPPS];
 	struct scmi_fc_info *fc_info;
+	struct xarray opps_by_idx;
+	struct xarray opps_by_lvl;
+	DECLARE_HASHTABLE(opps_by_freq, ilog2(MAX_OPPS));
 };
 
+#define LOOKUP_BY_FREQ(__htp, __freq)					\
+({									\
+		/* u32 cast is needed to pick right hash func */	\
+		u32 f_ = (u32)(__freq);					\
+		struct scmi_opp *_opp;					\
+									\
+		hash_for_each_possible((__htp), _opp, hash, f_)		\
+			if (_opp->indicative_freq == f_)		\
+				break;					\
+		_opp;							\
+})
+
 struct scmi_perf_info {
 	u32 version;
 	u16 num_domains;
@@ -186,9 +223,20 @@ static int scmi_perf_attributes_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static void scmi_perf_xa_destroy(void *data)
+{
+	int domain;
+	struct scmi_perf_info *pinfo = data;
+
+	for (domain = 0; domain < pinfo->num_domains; domain++) {
+		xa_destroy(&((pinfo->dom_info + domain)->opps_by_idx));
+		xa_destroy(&((pinfo->dom_info + domain)->opps_by_lvl));
+	}
+}
+
 static int
 scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
-				u32 domain, struct perf_dom_info *dom_info,
+				struct perf_dom_info *dom_info,
 				u32 version)
 {
 	int ret;
@@ -197,11 +245,11 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	struct scmi_msg_resp_perf_domain_attributes *attr;
 
 	ret = ph->xops->xfer_get_init(ph, PERF_DOMAIN_ATTRIBUTES,
-				     sizeof(domain), sizeof(*attr), &t);
+				      sizeof(dom_info->id), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
-	put_unaligned_le32(domain, t->tx.buf);
+	put_unaligned_le32(dom_info->id, t->tx.buf);
 	attr = t->rx.buf;
 
 	ret = ph->xops->do_xfer(ph, t);
@@ -213,6 +261,9 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		dom_info->perf_limit_notify = SUPPORTS_PERF_LIMIT_NOTIFY(flags);
 		dom_info->perf_level_notify = SUPPORTS_PERF_LEVEL_NOTIFY(flags);
 		dom_info->perf_fastchannels = SUPPORTS_PERF_FASTCHANNELS(flags);
+		if (PROTOCOL_REV_MAJOR(version) >= 0x4)
+			dom_info->level_indexing_mode =
+				SUPPORTS_LEVEL_INDEXING(flags);
 		dom_info->sustained_freq_khz =
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
@@ -236,8 +287,15 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	 */
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags))
-		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET,
+					    dom_info->id, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
+
+	if (dom_info->level_indexing_mode) {
+		xa_init(&dom_info->opps_by_idx);
+		xa_init(&dom_info->opps_by_lvl);
+		hash_init(dom_info->opps_by_freq);
+	}
 
 	return ret;
 }
@@ -250,7 +308,7 @@ static int opp_cmp_func(const void *opp1, const void *opp2)
 }
 
 struct scmi_perf_ipriv {
-	u32 domain;
+	u32 version;
 	struct perf_dom_info *perf_dom;
 };
 
@@ -261,7 +319,7 @@ static void iter_perf_levels_prepare_message(void *message,
 	struct scmi_msg_perf_describe_levels *msg = message;
 	const struct scmi_perf_ipriv *p = priv;
 
-	msg->domain = cpu_to_le32(p->domain);
+	msg->domain = cpu_to_le32(p->perf_dom->id);
 	/* Set the number of OPPs to be skipped/already read */
 	msg->level_index = cpu_to_le32(desc_index);
 }
@@ -277,31 +335,63 @@ static int iter_perf_levels_update_state(struct scmi_iterator_state *st,
 	return 0;
 }
 
+static inline void
+process_response_opp(struct scmi_opp *opp, unsigned int loop_idx,
+		     const struct scmi_msg_resp_perf_describe_levels *r)
+{
+	opp->perf = le32_to_cpu(r->opp[loop_idx].perf_val);
+	opp->power = le32_to_cpu(r->opp[loop_idx].power);
+	opp->trans_latency_us =
+		le16_to_cpu(r->opp[loop_idx].transition_latency_us);
+}
+
+static inline void
+process_response_opp_v4(struct perf_dom_info *dom, struct scmi_opp *opp,
+			unsigned int loop_idx,
+			const struct scmi_msg_resp_perf_describe_levels_v4 *r)
+{
+	opp->perf = le32_to_cpu(r->opp[loop_idx].perf_val);
+	opp->power = le32_to_cpu(r->opp[loop_idx].power);
+	opp->trans_latency_us =
+		le16_to_cpu(r->opp[loop_idx].transition_latency_us);
+
+	/* Note that PERF v4 reports always five 32-bit words */
+	opp->indicative_freq = le32_to_cpu(r->opp[loop_idx].indicative_freq);
+	if (dom->level_indexing_mode) {
+		opp->level_index = le32_to_cpu(r->opp[loop_idx].level_index);
+
+		xa_store(&dom->opps_by_idx, opp->level_index, opp, GFP_KERNEL);
+		xa_store(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
+		hash_add(dom->opps_by_freq, &opp->hash, opp->indicative_freq);
+	}
+}
+
 static int
 iter_perf_levels_process_response(const struct scmi_protocol_handle *ph,
 				  const void *response,
 				  struct scmi_iterator_state *st, void *priv)
 {
 	struct scmi_opp *opp;
-	const struct scmi_msg_resp_perf_describe_levels *r = response;
 	struct scmi_perf_ipriv *p = priv;
 
 	opp = &p->perf_dom->opp[st->desc_index + st->loop_idx];
-	opp->perf = le32_to_cpu(r->opp[st->loop_idx].perf_val);
-	opp->power = le32_to_cpu(r->opp[st->loop_idx].power);
-	opp->trans_latency_us =
-		le16_to_cpu(r->opp[st->loop_idx].transition_latency_us);
+	if (PROTOCOL_REV_MAJOR(p->version) <= 0x3)
+		process_response_opp(opp, st->loop_idx, response);
+	else
+		process_response_opp_v4(p->perf_dom, opp, st->loop_idx,
+					response);
 	p->perf_dom->opp_count++;
 
-	dev_dbg(ph->dev, "Level %d Power %d Latency %dus\n",
-		opp->perf, opp->power, opp->trans_latency_us);
+	dev_dbg(ph->dev, "Level %d Power %d Latency %dus Ifreq %d Index %d\n",
+		opp->perf, opp->power, opp->trans_latency_us,
+		opp->indicative_freq, opp->level_index);
 
 	return 0;
 }
 
 static int
-scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
-			      struct perf_dom_info *perf_dom)
+scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph,
+			      struct perf_dom_info *perf_dom, u32 version)
 {
 	int ret;
 	void *iter;
@@ -311,7 +401,7 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 		.process_response = iter_perf_levels_process_response,
 	};
 	struct scmi_perf_ipriv ppriv = {
-		.domain = domain,
+		.version = version,
 		.perf_dom = perf_dom,
 	};
 
@@ -333,8 +423,8 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 	return ret;
 }
 
-static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
-				   u32 domain, u32 max_perf, u32 min_perf)
+static int scmi_perf_msg_limits_set(const struct scmi_protocol_handle *ph,
+				    u32 domain, u32 max_perf, u32 min_perf)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -367,6 +457,24 @@ scmi_perf_domain_lookup(const struct scmi_protocol_handle *ph, u32 domain)
 	return pi->dom_info + domain;
 }
 
+static int __scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
+				  struct perf_dom_info *dom, u32 max_perf,
+				  u32 min_perf)
+{
+	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].set_addr) {
+		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
+
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_SET,
+				   dom->id, min_perf, max_perf);
+		iowrite32(max_perf, fci->set_addr);
+		iowrite32(min_perf, fci->set_addr + 4);
+		ph->hops->fastchannel_db_ring(fci->set_db);
+		return 0;
+	}
+
+	return scmi_perf_msg_limits_set(ph, dom->id, max_perf, min_perf);
+}
+
 static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -380,22 +488,31 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3 && !max_perf && !min_perf)
 		return -EINVAL;
 
-	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].set_addr) {
-		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
+	if (dom->level_indexing_mode) {
+		struct scmi_opp *opp;
 
-		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_SET,
-				   domain, min_perf, max_perf);
-		iowrite32(max_perf, fci->set_addr);
-		iowrite32(min_perf, fci->set_addr + 4);
-		ph->hops->fastchannel_db_ring(fci->set_db);
-		return 0;
+		if (min_perf) {
+			opp = xa_load(&dom->opps_by_lvl, min_perf);
+			if (!opp)
+				return -EIO;
+
+			min_perf = opp->level_index;
+		}
+
+		if (max_perf) {
+			opp = xa_load(&dom->opps_by_lvl, max_perf);
+			if (!opp)
+				return -EIO;
+
+			max_perf = opp->level_index;
+		}
 	}
 
-	return scmi_perf_mb_limits_set(ph, domain, max_perf, min_perf);
+	return __scmi_perf_limits_set(ph, dom, max_perf, min_perf);
 }
 
-static int scmi_perf_mb_limits_get(const struct scmi_protocol_handle *ph,
-				   u32 domain, u32 *max_perf, u32 *min_perf)
+static int scmi_perf_msg_limits_get(const struct scmi_protocol_handle *ph,
+				    u32 domain, u32 *max_perf, u32 *min_perf)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -420,30 +537,58 @@ static int scmi_perf_mb_limits_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int __scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
+				  struct perf_dom_info *dom, u32 *max_perf,
+				  u32 *min_perf)
+{
+	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].get_addr) {
+		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
+
+		*max_perf = ioread32(fci->get_addr);
+		*min_perf = ioread32(fci->get_addr + 4);
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_GET,
+				   dom->id, *min_perf, *max_perf);
+		return 0;
+	}
+
+	return scmi_perf_msg_limits_get(ph, dom->id, max_perf, min_perf);
+}
+
 static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 *max_perf, u32 *min_perf)
 {
+	int ret;
 	struct perf_dom_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
-	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].get_addr) {
-		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
+	ret = __scmi_perf_limits_get(ph, dom, max_perf, min_perf);
+	if (ret)
+		return ret;
 
-		*max_perf = ioread32(fci->get_addr);
-		*min_perf = ioread32(fci->get_addr + 4);
-		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_GET,
-				   domain, *min_perf, *max_perf);
-		return 0;
+	if (dom->level_indexing_mode) {
+		struct scmi_opp *opp;
+
+		opp = xa_load(&dom->opps_by_idx, *min_perf);
+		if (!opp)
+			return -EIO;
+
+		*min_perf = opp->perf;
+
+		opp = xa_load(&dom->opps_by_idx, *max_perf);
+		if (!opp)
+			return -EIO;
+
+		*max_perf = opp->perf;
 	}
 
-	return scmi_perf_mb_limits_get(ph, domain, max_perf, min_perf);
+	return 0;
 }
 
-static int scmi_perf_mb_level_set(const struct scmi_protocol_handle *ph,
-				  u32 domain, u32 level, bool poll)
+static int scmi_perf_msg_level_set(const struct scmi_protocol_handle *ph,
+				   u32 domain, u32 level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -464,6 +609,23 @@ static int scmi_perf_mb_level_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int __scmi_perf_level_set(const struct scmi_protocol_handle *ph,
+				 struct perf_dom_info *dom, u32 level,
+				 bool poll)
+{
+	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
+		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
+
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_SET,
+				   dom->id, level, 0);
+		iowrite32(level, fci->set_addr);
+		ph->hops->fastchannel_db_ring(fci->set_db);
+		return 0;
+	}
+
+	return scmi_perf_msg_level_set(ph, dom->id, level, poll);
+}
+
 static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 level, bool poll)
 {
@@ -473,21 +635,21 @@ static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
-	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
-		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
+	if (dom->level_indexing_mode) {
+		struct scmi_opp *opp;
 
-		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_SET,
-				   domain, level, 0);
-		iowrite32(level, fci->set_addr);
-		ph->hops->fastchannel_db_ring(fci->set_db);
-		return 0;
+		opp = xa_load(&dom->opps_by_lvl, level);
+		if (!opp)
+			return -EIO;
+
+		level = opp->level_index;
 	}
 
-	return scmi_perf_mb_level_set(ph, domain, level, poll);
+	return __scmi_perf_level_set(ph, dom, level, poll);
 }
 
-static int scmi_perf_mb_level_get(const struct scmi_protocol_handle *ph,
-				  u32 domain, u32 *level, bool poll)
+static int scmi_perf_msg_level_get(const struct scmi_protocol_handle *ph,
+				   u32 domain, u32 *level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -508,23 +670,45 @@ static int scmi_perf_mb_level_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int __scmi_perf_level_get(const struct scmi_protocol_handle *ph,
+				 struct perf_dom_info *dom, u32 *level,
+				 bool poll)
+{
+	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
+		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_GET,
+				   dom->id, *level, 0);
+		return 0;
+	}
+
+	return scmi_perf_msg_level_get(ph, dom->id, level, poll);
+}
+
 static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 *level, bool poll)
 {
+	int ret;
 	struct perf_dom_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
-	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
-		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
-		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_GET,
-				   domain, *level, 0);
-		return 0;
+	ret = __scmi_perf_level_get(ph, dom, level, poll);
+	if (ret)
+		return ret;
+
+	if (dom->level_indexing_mode) {
+		struct scmi_opp *opp;
+
+		opp = xa_load(&dom->opps_by_idx, *level);
+		if (!opp)
+			return -EIO;
+
+		*level = opp->perf;
 	}
 
-	return scmi_perf_mb_level_get(ph, domain, level, poll);
+	return 0;
 }
 
 static int scmi_perf_level_limits_notify(const struct scmi_protocol_handle *ph,
@@ -608,18 +792,27 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 		return PTR_ERR(dom);
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
-		freq = opp->perf * dom->mult_factor;
+		if (!dom->level_indexing_mode)
+			freq = opp->perf * dom->mult_factor;
+		else
+			freq = opp->indicative_freq * 1000;
 
 		ret = dev_pm_opp_add(dev, freq, 0);
 		if (ret) {
 			dev_warn(dev, "failed to add opp %luHz\n", freq);
 
 			while (idx-- > 0) {
-				freq = (--opp)->perf * dom->mult_factor;
+				if (!dom->level_indexing_mode)
+					freq = (--opp)->perf * dom->mult_factor;
+				else
+					freq = (--opp)->indicative_freq * 1000;
 				dev_pm_opp_remove(dev, freq);
 			}
 			return ret;
 		}
+
+		dev_dbg(dev, "[%d][%s]:: Registered OPP[%d] %lu\n",
+			domain, dom->name, idx, freq);
 	}
 	return 0;
 }
@@ -646,13 +839,26 @@ scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
+	unsigned int level;
 	struct perf_dom_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
-	return scmi_perf_level_set(ph, domain, freq / dom->mult_factor, poll);
+	if (!dom->level_indexing_mode) {
+		level = freq / dom->mult_factor;
+	} else {
+		struct scmi_opp *opp;
+
+		opp = LOOKUP_BY_FREQ(dom->opps_by_freq, freq / 1000);
+		if (!opp)
+			return -EIO;
+
+		level = opp->level_index;
+	}
+
+	return __scmi_perf_level_set(ph, dom, level, poll);
 }
 
 static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
@@ -660,14 +866,26 @@ static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 {
 	int ret;
 	u32 level;
-	struct scmi_perf_info *pi = ph->get_priv(ph);
+	struct perf_dom_info *dom;
 
-	ret = scmi_perf_level_get(ph, domain, &level, poll);
-	if (!ret) {
-		struct perf_dom_info *dom = pi->dom_info + domain;
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
+
+	ret = __scmi_perf_level_get(ph, dom, &level, poll);
+	if (ret)
+		return ret;
 
-		/* Note domain is validated implicitly by scmi_perf_level_get */
+	if (!dom->level_indexing_mode) {
 		*freq = level * dom->mult_factor;
+	} else {
+		struct scmi_opp *opp;
+
+		opp = xa_load(&dom->opps_by_idx, level);
+		if (!opp)
+			return -EIO;
+
+		*freq = opp->indicative_freq * 1000;
 	}
 
 	return ret;
@@ -687,7 +905,11 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 		return PTR_ERR(dom);
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
-		opp_freq = opp->perf * dom->mult_factor;
+		if (!dom->level_indexing_mode)
+			opp_freq = opp->perf * dom->mult_factor;
+		else
+			opp_freq = opp->indicative_freq * 1000;
+
 		if (opp_freq < *freq)
 			continue;
 
@@ -870,13 +1092,18 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct perf_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_perf_domain_attributes_get(ph, domain, dom, version);
-		scmi_perf_describe_levels_get(ph, domain, dom);
+		dom->id = domain;
+		scmi_perf_domain_attributes_get(ph, dom, version);
+		scmi_perf_describe_levels_get(ph, dom, version);
 
 		if (dom->perf_fastchannels)
-			scmi_perf_domain_init_fc(ph, domain, &dom->fc_info);
+			scmi_perf_domain_init_fc(ph, dom->id, &dom->fc_info);
 	}
 
+	ret = devm_add_action_or_reset(ph->dev, scmi_perf_xa_destroy, pinfo);
+	if (ret)
+		return ret;
+
 	pinfo->version = version;
 
 	return ph->set_priv(ph, pinfo);
-- 
2.41.0

