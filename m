Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4257177CF20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjHOP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbjHOP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C4172A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:16 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAXQ1H003906;
        Tue, 15 Aug 2023 08:28:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=14mdTkkbewJtr+++SfUne9QWQCLp6Yk4HKCHhy3bbis=;
 b=bE2jccDgOQadwNuB+w53hfjvRSIuVwqO+UTJNa05EZX6pnd0q0gVifMRcELQGmPEC8NZ
 2trVVKqEGptUKy8qfo5dCnEVRjhlHpheH+Kxp/WHfDhQF0eYezk5+Mo3XgenwA8fHsAr
 m88pLtd0vruCpv+ID6yu/gyK8GSpqNw5VoqhPo4pZko6dAo1K7VZquJQeeWMCxVvrbhW
 1XiXexnVGSxV0NXnwza5zG+aIP6mdITgfEWWtUJDg5k1O2Y50RbYF5CEtzydDEbfc7RG
 7WQi/Gu6qk2ZEKTbG8xazO08+LoO5hdcWfzqF7rY4ecjw8PGWCImIfCszD+B0A4SI0hR vA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kjajvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:28:05 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:28:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:28:04 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 06E0B3F704D;
        Tue, 15 Aug 2023 08:28:00 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 07/12] arm_mpam: resctrl: Retrieve priority values from arch code
Date:   Tue, 15 Aug 2023 20:57:07 +0530
Message-ID: <20230815152712.1760046-8-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DKSk5JJsr6hJjIbXHEPrzC0C1NPYmTVZ
X-Proofpoint-ORIG-GUID: DKSk5JJsr6hJjIbXHEPrzC0C1NPYmTVZ
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

Downstream priority values can be read from the "schemata" file, which is
fetched from mpam_config structure.

This change does the necessary modifications in arch specific code to
facilitate reading priority values.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_internal.h |  1 +
 drivers/platform/mpam/mpam_resctrl.c  | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mpam/mpam_internal.h b/drivers/platform/mpam/mpam_internal.h
index 30e32389d394..45552ae6548b 100644
--- a/drivers/platform/mpam/mpam_internal.h
+++ b/drivers/platform/mpam/mpam_internal.h
@@ -160,6 +160,7 @@ struct mpam_config {
 	u32	cpbm;
 	u32	mbw_pbm;
 	u16	mbw_max;
+	u16	dspri;
 };
 
 struct mpam_component
diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index b491a0f897fd..dc710c90cfc2 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -864,7 +864,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 	lockdep_assert_cpus_held();
 
 	if (!mpam_is_enabled())
-		return r->default_ctrl;
+		return r->dspri_show ? r->dspri_default_ctrl : r->default_ctrl;
 
 	res = container_of(r, struct mpam_resctrl_res, resctrl_res);
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_dom);
@@ -876,7 +876,10 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 	switch (r->rid) {
 	case RDT_RESOURCE_L2:
 	case RDT_RESOURCE_L3:
-		configured_by = mpam_feat_cpor_part;
+		if (r->dspri_show)
+			configured_by = mpam_feat_dspri_part;
+		else
+			configured_by = mpam_feat_cpor_part;
 		break;
 	case RDT_RESOURCE_MBA:
 		if (mba_class_use_mbw_part(cprops)) {
@@ -893,12 +896,14 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 
 	if (!r->alloc_capable || partid >= resctrl_arch_get_num_closid(r) ||
 	    !mpam_has_feature(configured_by, cfg))
-		return r->default_ctrl;
+		return r->dspri_show ? r->dspri_default_ctrl : r->default_ctrl;
 
 	switch (configured_by) {
 	case mpam_feat_cpor_part:
 		/* TODO: Scaling is not yet supported */
 		return cfg->cpbm;
+	case mpam_feat_dspri_part:
+		return cfg->dspri;
 	case mpam_feat_mbw_part:
 		/* TODO: Scaling is not yet supported */
 		return mbw_pbm_to_percent(cfg->mbw_pbm, cprops);
-- 
2.25.1

