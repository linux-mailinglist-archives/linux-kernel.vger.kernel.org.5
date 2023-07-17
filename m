Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CED7568C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGQQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGQQNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:13:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1239511C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:13:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A9F8D75;
        Mon, 17 Jul 2023 09:14:04 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044863F738;
        Mon, 17 Jul 2023 09:13:18 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        aidapala@qti.qualcomm.com, souvik.chakravarty@arm.com,
        satyakim@qti.qualcomm.com, atouzni@qti.qualcomm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/2] firmware: arm_scmi: Harden PERF domain info access
Date:   Mon, 17 Jul 2023 17:12:45 +0100
Message-ID: <20230717161246.1761777-2-cristian.marussi@arm.com>
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

Harden internal accesses to domain info in PERF protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 89 +++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ecf5c4de851b..43dd242ecc49 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -139,7 +139,7 @@ struct perf_dom_info {
 
 struct scmi_perf_info {
 	u32 version;
-	int num_domains;
+	u16 num_domains;
 	enum scmi_power_scale power_scale;
 	u64 stats_addr;
 	u32 stats_size;
@@ -356,11 +356,26 @@ static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static inline struct perf_dom_info *
+scmi_perf_domain_lookup(const struct scmi_protocol_handle *ph, u32 domain)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+
+	if (domain >= pi->num_domains)
+		return ERR_PTR(-EINVAL);
+
+	return pi->dom_info + domain;
+}
+
 static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 max_perf, u32 min_perf)
 {
 	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3 && !max_perf && !min_perf)
 		return -EINVAL;
@@ -408,8 +423,11 @@ static int scmi_perf_mb_limits_get(const struct scmi_protocol_handle *ph,
 static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 *max_perf, u32 *min_perf)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].get_addr) {
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
@@ -449,8 +467,11 @@ static int scmi_perf_mb_level_set(const struct scmi_protocol_handle *ph,
 static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 level, bool poll)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
@@ -490,8 +511,11 @@ static int scmi_perf_mb_level_get(const struct scmi_protocol_handle *ph,
 static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 *level, bool poll)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
 		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
@@ -574,13 +598,14 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
-		return domain;
+		return -EINVAL;
 
-	dom = pi->dom_info + domain;
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
 		freq = opp->perf * dom->mult_factor;
@@ -603,14 +628,17 @@ static int
 scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 				 struct device *dev)
 {
+	int domain;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	int domain = scmi_dev_domain_id(dev);
 
+	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
-		return domain;
+		return -EINVAL;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
-	dom = pi->dom_info + domain;
 	/* uS to nS */
 	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
 }
@@ -618,8 +646,11 @@ scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	return scmi_perf_level_set(ph, domain, freq / dom->mult_factor, poll);
 }
@@ -630,11 +661,14 @@ static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 	int ret;
 	u32 level;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	ret = scmi_perf_level_get(ph, domain, &level, poll);
-	if (!ret)
+	if (!ret) {
+		struct perf_dom_info *dom = pi->dom_info + domain;
+
+		/* Note domain is validated implicitly by scmi_perf_level_get */
 		*freq = level * dom->mult_factor;
+	}
 
 	return ret;
 }
@@ -643,15 +677,14 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 				   u32 domain, unsigned long *freq,
 				   unsigned long *power)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
 	struct scmi_opp *opp;
 
-	dom = pi->dom_info + domain;
-	if (!dom)
-		return -EIO;
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
 		opp_freq = opp->perf * dom->mult_factor;
@@ -670,10 +703,16 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 				      struct device *dev)
 {
+	int domain;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = ph->get_priv(ph);
 
-	dom = pi->dom_info + scmi_dev_domain_id(dev);
+	domain = scmi_dev_domain_id(dev);
+	if (domain < 0)
+		return false;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return false;
 
 	return dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr;
 }
-- 
2.41.0

