Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5B77CF25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjHOP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbjHOP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:28 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211C9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:27 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FA8Olj003829;
        Tue, 15 Aug 2023 08:28:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=ndl9VeZw0l4vQTDQTqKf66NByql2cT6+zlyYa1ZDAgE=;
 b=hnLcpIZODnRUEjXiCiHmvKsZ4MAFb7Tpj9z7DogGjsht03bRlOlUDdOk4DEnzoH7gkJx
 I2Z9FmuS+0muMUokSU1NQAmCpW5JBOY0XwzHbv5b7xiL12CWCrf06cX6V+s3Qaij/61L
 9ZpcLdX3T9yHSGB3sGQbRM2l07lixnrGvn9B/Yyu+ofCAFE/u/aM+XgEICE78q4arP/I
 Md2l4SFJ/6p2QUhB84UO78GArDiaKdnA44UFK0UliNOq/LkC2AVvIAW5BaVBVWGFiiAV
 lHcEr+BXa0fxA7vDqAO8kVM/GkiFGB3ur57A8t8CRErYCBBcNd7QFJLFtaUZYAbt+PGW mA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kjajw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:28:16 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:28:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:28:14 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 922BE3F703F;
        Tue, 15 Aug 2023 08:28:11 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 10/12] arm_mpam: resctrl: Facilitate writing downstream priority value
Date:   Tue, 15 Aug 2023 20:57:10 +0530
Message-ID: <20230815152712.1760046-11-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9D23bdYHyp_wW0TPHsM4042SX3fjGDP-
X-Proofpoint-ORIG-GUID: 9D23bdYHyp_wW0TPHsM4042SX3fjGDP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change provides a way to write downstream priority value (passed from
schemata file) to arch specific resource control code. The priority value
is stored in mpam_config structure, and eventually gets programmed into
MPAMCFG_PRI register.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_devices.c |  4 ----
 drivers/platform/mpam/mpam_resctrl.c | 27 +++++++++++++++++----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index 137cbff925ba..c0c83c04c77c 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -2351,10 +2351,6 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 	lockdep_assert_cpus_held();
 
-	if (!memcmp(&comp->cfg[partid], cfg, sizeof(*cfg)))
-		return 0;
-
-	comp->cfg[partid] = *cfg;
 	arg.comp = comp;
 	arg.partid = partid;
 
diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index dc710c90cfc2..ffd0fa84d37d 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -919,7 +919,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 {
 	int err;
 	u32 partid;
-	struct mpam_config cfg;
+	struct mpam_config *cfg;
 	struct mpam_props *cprops;
 	struct mpam_resctrl_res *res;
 	struct mpam_resctrl_dom *dom;
@@ -934,6 +934,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	cprops = &res->class->props;
 
 	partid = resctrl_get_config_index(closid, t);
+	cfg = &dom->comp->cfg[partid];
 	if (!r->alloc_capable || partid >= resctrl_arch_get_num_closid(r))
 		return -EINVAL;
 
@@ -941,17 +942,22 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	case RDT_RESOURCE_L2:
 	case RDT_RESOURCE_L3:
 		/* TODO: Scaling is not yet supported */
-		cfg.cpbm = cfg_val;
-		mpam_set_feature(mpam_feat_cpor_part, &cfg);
+		if (r->dspri_store) {
+			cfg->dspri = cfg_val;
+			mpam_set_feature(mpam_feat_dspri_part, cfg);
+		} else {
+			cfg->cpbm = cfg_val;
+			mpam_set_feature(mpam_feat_cpor_part, cfg);
+		}
 		break;
 	case RDT_RESOURCE_MBA:
 		if (mba_class_use_mbw_part(cprops)) {
-			cfg.mbw_pbm = percent_to_mbw_pbm(cfg_val, cprops);
-			mpam_set_feature(mpam_feat_mbw_part, &cfg);
+			cfg->mbw_pbm = percent_to_mbw_pbm(cfg_val, cprops);
+			mpam_set_feature(mpam_feat_mbw_part, cfg);
 			break;
 		} else if (mpam_has_feature(mpam_feat_mbw_max, cprops)) {
-			cfg.mbw_max = percent_to_mbw_max(cfg_val, cprops);
-			mpam_set_feature(mpam_feat_mbw_max, &cfg);
+			cfg->mbw_max = percent_to_mbw_max(cfg_val, cprops);
+			mpam_set_feature(mpam_feat_mbw_max, cfg);
 			break;
 		}
 		fallthrough;
@@ -965,15 +971,15 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	 */
 	if (mpam_resctrl_hide_cdp(r->rid)) {
 		partid = resctrl_get_config_index(closid, CDP_CODE);
-		err = mpam_apply_config(dom->comp, partid, &cfg);
+		err = mpam_apply_config(dom->comp, partid, cfg);
 		if (err)
 			return err;
 
 		partid = resctrl_get_config_index(closid, CDP_DATA);
-		return mpam_apply_config(dom->comp, partid, &cfg);
+		return mpam_apply_config(dom->comp, partid, cfg);
 
 	} else {
-		return mpam_apply_config(dom->comp, partid, &cfg);
+		return mpam_apply_config(dom->comp, partid, cfg);
 	}
 }
 
@@ -998,6 +1004,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 						      cfg->new_ctrl);
 			if (err)
 				return err;
+			cfg->have_new_ctrl = false;
 		}
 	}
 
-- 
2.25.1

