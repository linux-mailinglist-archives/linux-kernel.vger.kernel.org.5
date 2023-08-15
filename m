Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C8677CF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbjHOP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjHOP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:08 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F09BE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:08 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEFUMl008839;
        Tue, 15 Aug 2023 08:27:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=2AcGndNsb0mA20+rk92QjaYDMCbdWb3nhdSfrUTAJqc=;
 b=evhp6I1Sum2FPwRGJl/w7xslgmMPLdEO+EM/Iqjdf6zqNXw/8/V/WsAeLFVsLRsP4n0F
 G8wpMhnppdCzXzhbjbv25fhbn3ih5uWJW04HqLZ3dI/lhfC+M0dWhgxZ5BnsOnYAXnrZ
 AbD/NBhOfCd/C9FoAF5mkMb02JG3oS7/tTn121vqbvtQ82g2zZEw/IMlmAx4w+wvonCB
 gbhQDOntpsc9GZEaTbuC4jcLNz5bOwRiCP+1PRTPtTtyLsb2RCH48kn2Cqg8vflOY6lN
 t15dhq2XpdtkQf6QC7M66ftTVFZAtt2GH87Sn/r03wDxyzvITNqL2Hs3VcbwE+y/iTw1 BA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sgaydr89c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:27:47 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:27:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:27:46 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 5D6833F703F;
        Tue, 15 Aug 2023 08:27:43 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 02/12] arm_mpam: resctrl: Detect priority partitioning capability
Date:   Tue, 15 Aug 2023 20:57:02 +0530
Message-ID: <20230815152712.1760046-3-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LytoDMRjzmYmG-5KbYRh7H8fMQPZWMAY
X-Proofpoint-ORIG-GUID: LytoDMRjzmYmG-5KbYRh7H8fMQPZWMAY
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

ARM MPAM supports different control that can be applied to different
resources in the system, for instance priority partitioning control
where priority value is generated from one MSC, propagates over
interconnect to other MSC (known as downstream priority), or can be
applied within an MSC for internal operations.

This change lets the resctrl know the about MSC's priority partitioning
capability.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_resctrl.c | 14 ++++++++++++++
 include/linux/resctrl.h              |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 1dbfb6f6dd34..09618d9ceb1d 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -435,6 +435,16 @@ static bool cache_has_usable_cpor(struct mpam_class *class)
 	return (class->props.cpbm_wd <= RESCTRL_MAX_CBM);
 }
 
+static bool cache_has_usable_priority_part(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (!mpam_has_feature(mpam_feat_dspri_part, cprops))
+		return false;
+
+	return (class->props.dspri_wd <= RESCTRL_MAX_DSPRI);
+}
+
 static bool cache_has_usable_csu(struct mpam_class *class)
 {
 	struct mpam_props *cprops;
@@ -691,6 +701,7 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 	    res->resctrl_res.rid == RDT_RESOURCE_L3) {
 		bool has_csu = cache_has_usable_csu(class);
 		bool has_mbwu = class_has_usable_mbwu(class);
+		bool has_ppart = cache_has_usable_priority_part(class);
 
 		/* TODO: Scaling is not yet supported */
 		r->cache.cbm_len = class->props.cpbm_wd;
@@ -718,6 +729,9 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 			exposed_alloc_capable = true;
 		}
 
+		if (has_ppart)
+			r->priority_cap = true;
+
 		/*
 		 * MBWU counters may be 'local' or 'total' depending on where
 		 * they are in the topology. If The counter is on the L3, its
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3ad308e9e226..a98ba5828211 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -38,6 +38,8 @@ int proc_resctrl_show(struct seq_file *m,
  */
 #define RESCTRL_MAX_CBM			32
 
+#define RESCTRL_MAX_DSPRI               63
+
 /* The format for packing fields into the u64 'id' exposed to user-space */
 #define RESCTRL_ID_CLOSID	GENMASK_ULL(31, 0)
 #define RESCTRL_ID_RMID		GENMASK_ULL(63, 32)
@@ -195,6 +197,7 @@ struct resctrl_membw {
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
+ * @priority_capable:   Is priority partitioning feature available on this machine
  * @num_rmid:		Number of RMIDs available
  * @cache_level:	Which cache level defines scope of this resource
  * @cache:		Cache allocation related data
@@ -212,6 +215,7 @@ struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
+	bool                    priority_cap;
 	int			num_rmid;
 	int			cache_level;
 	struct resctrl_cache	cache;
-- 
2.25.1

