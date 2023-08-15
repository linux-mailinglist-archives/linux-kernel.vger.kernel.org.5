Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9990477CF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjHOP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjHOP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:11 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B97EE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:10 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEFVPf008845;
        Tue, 15 Aug 2023 08:27:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=QpHIOHGP5iCgR5XpTWXZwTOBtb2YGEhP4AC2OvY5k1g=;
 b=RNHdf+jpJw4t3LHQfQ2POwShgqMtdKZ8GNz0zUa1DyDVRObRJLRlUOX+SpQNhnHdU5gi
 CJgQ74Vb7TIFFAJqOAOtIU/qZpwpKnofrUIplVDSciGIhfNYaoP1IdDbuL1oTqnIVSD5
 OdayeHATVLFZ0iJ2hvBqhctAB2cEroY2LWUe7bkfccmc7HTW5aIxi3ms1mhJh8plgvan
 v6emCMH3pUiuFhrZEBe/xonVe9tQDr/LVk1932BMC0dRiFbhPjO2YqkREzW2INNwlZd8
 pbkrVOxWChXE5PCEuL+f/7GoQS1C/eeCO4DsTRuo3s3cK2KjB2REnylI8FYvFGP3XpQc Eg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sgaydr89s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:27:58 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:27:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:27:56 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 01ECC3F704D;
        Tue, 15 Aug 2023 08:27:53 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 05/12] fs/resctrl: Set-up downstream priority partition resources
Date:   Tue, 15 Aug 2023 20:57:05 +0530
Message-ID: <20230815152712.1760046-6-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mB1E9UfRmfxlx-F-JVpPYRgQOdmSoHik
X-Proofpoint-ORIG-GUID: mB1E9UfRmfxlx-F-JVpPYRgQOdmSoHik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon resource control group creation, Cache portion bitmap, and Memory
bandwidth allocation gets initialized to the default/maximum values,
obtained from resource control code.

Let's replicate it for priority partition resource, and setup the default
downstream priority value.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_resctrl.c |  4 +++-
 fs/resctrl/rdtgroup.c                | 30 ++++++++++++++++++++++++++++
 include/linux/resctrl.h              |  4 ++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 1081ceac41a8..cc843f1b0fb7 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -733,8 +733,10 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 			exposed_alloc_capable = true;
 		}
 
-		if (has_ppart)
+		if (has_ppart) {
 			r->priority_cap = true;
+			r->dspri_default_ctrl = BIT_MASK(class->props.dspri_wd) - 1;
+		}
 
 		/*
 		 * MBWU counters may be 'local' or 'total' depending on where
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9c5dfaaa7fa2..bc5fb246ba68 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3045,6 +3045,21 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 	return 0;
 }
 
+static int rdtgroup_init_dspri(struct rdt_resource *r, u32 closid)
+{
+	struct resctrl_staged_config *cfg;
+	struct rdt_domain *d;
+
+	list_for_each_entry(d, &r->domains, list) {
+		cfg = &d->staged_config[CDP_NONE];
+		cfg->new_ctrl = r->dspri_default_ctrl;
+		cfg->have_new_ctrl = true;
+		r->dspri_store = true;
+	}
+
+	return 0;
+}
+
 /* Initialize MBA resource with default values. */
 static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 {
@@ -3082,12 +3097,27 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 				return ret;
 		}
 
+		if (r->priority_cap)
+			r->dspri_store = false;
+
 		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
 		}
 
+		if (r->priority_cap) {
+			ret = rdtgroup_init_dspri(r, rdtgrp->closid);
+			if (ret < 0)
+				return ret;
+
+			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
+			if (ret < 0) {
+				rdt_last_cmd_puts("Failed to initialize allocations\n");
+				return ret;
+			}
+			r->dspri_store = false;
+		}
 	}
 
 	rdtgrp->mode = RDT_MODE_SHAREABLE;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a98ba5828211..d5b0661c0f70 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -198,6 +198,7 @@ struct resctrl_membw {
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
  * @priority_capable:   Is priority partitioning feature available on this machine
+ * @dspri_store:
  * @num_rmid:		Number of RMIDs available
  * @cache_level:	Which cache level defines scope of this resource
  * @cache:		Cache allocation related data
@@ -206,6 +207,7 @@ struct resctrl_membw {
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * @dspri_default_ctrl: Specifies default downstream priority value.
  * @format_str:		Per resource format string to show domain value
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
@@ -216,6 +218,7 @@ struct rdt_resource {
 	bool			alloc_capable;
 	bool			mon_capable;
 	bool                    priority_cap;
+	bool			dspri_store;
 	int			num_rmid;
 	int			cache_level;
 	struct resctrl_cache	cache;
@@ -224,6 +227,7 @@ struct rdt_resource {
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
+	u32			dspri_default_ctrl;
 	const char		*format_str;
 	struct list_head	evt_list;
 	unsigned long		fflags;
-- 
2.25.1

