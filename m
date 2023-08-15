Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E375477CF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbjHOP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbjHOP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:08 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63C59C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:07 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEFVPe008845;
        Tue, 15 Aug 2023 08:27:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Uk3A5P7WfGa23MOhtDO8rNOCRZXqtO0eZxiTOWLUHWc=;
 b=CjalgO9dVZ0Yyei/AVn7TJJjGpMTbCUTAC7AwC1tc0Mg8mYbgYTknV6HsbsAkYNiEmKP
 q2J9u6xwNJyFq7Ne5C4fZ89ocrpWtkDePvLYrPsWKJzqKLJYRDIs60tO9jyuv210MJu5
 QGLZZSMooMy2ObpMsvGMbMdx08ihJouetiHwGA+h6pifh5iOYLbn7Gt4u4PN5W6YQy6B
 3qIjhLA1ef+/1nRVID+8DmYe7/o7KbtwLrG4oxW5d8bYG3CGsfEM9VlbT8W09RTKtI6J
 qICidWddCr6WtXnVWyPeU8sGd6rqIskghfdQpCXWY1UxTtBU1V+su3oSe7uDxisIji5N iw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sgaydr89a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:27:44 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:27:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:27:42 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id D33C43F704D;
        Tue, 15 Aug 2023 08:27:39 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 01/12] arm_mpam: Handle resource instances mapped to different controls
Date:   Tue, 15 Aug 2023 20:57:01 +0530
Message-ID: <20230815152712.1760046-2-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EDEfHLYgAD4deGl_cpTtBhjtMuOQekxK
X-Proofpoint-ORIG-GUID: EDEfHLYgAD4deGl_cpTtBhjtMuOQekxK
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

At the moment, configuring multiple resource instances (mapped to same
control) under a resource class is not supported. For instance, on MARVELL
SoC MPAMF_IDR_NS[RIS_MAX] (under LLC MSC) is 0x2, and there are three
different resource at index 0,1,2. These are enumerated in
TAD_CMN_MPAM_RIS_E:

0: MSC
1: LTG
2: DTG

LLC MSC resource at index 1, and 2 have cache portion partitioning
feature, i.e., If MPAMCFG_PART_SEL_NS[RIS] is set to 1 (LTG) or to 2 (DTG),
then MPAMF_IDR_NS[HAS_CPOR_PART] is set to 1. LTG resource has 16
portion bitmap, and DTG has 18 portion bitmap (mapped to same
CPOR control), and only one can be configured.

LLC MSC resource at index 0 has the Priority partitioning features.
If MPAMCFG_PART_SEL_NS[RIS] is set to 0 (MSC), then MPAMF_IDR_NS[HAS_PRI_PART]
is set to 1, leaving HAS_CPOR_PART bit to 0. CPOR and PRI_PART are
mutually exclusive resources as far configuration is concerned.

With this change, multiple resource instances that maps to different
control, say LTG for CPOR, and MSC for PRI_PART is handled properly.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_devices.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index 589ff1ef2b6b..137cbff925ba 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -1829,6 +1829,19 @@ static void mpam_enable_init_class_features(struct mpam_class *class)
 	class->props = ris->props;
 }
 
+/* Club different resource properties under a class that resctrl uses,
+ * for instance, L3 cache that supports both CPOR, and DSPRI need to have
+ * knowledge of both cpbm_wd and dspri_wd.
+ */
+static void mpam_enable_club_class_features(struct mpam_class *class,
+					    struct mpam_msc_ris *ris)
+{
+	class->props.features |= ris->props.features;
+	class->props.cpbm_wd |= ris->props.cpbm_wd;
+	class->props.dspri_wd |= ris->props.dspri_wd;
+	class->props.num_csu_mon |= ris->props.num_csu_mon;
+}
+
 /* Merge all the common resource features into class. */
 static void mpam_enable_merge_features(void)
 {
@@ -1843,7 +1856,16 @@ static void mpam_enable_merge_features(void)
 
 		list_for_each_entry(comp, &class->components, class_list) {
 			list_for_each_entry(ris, &comp->ris, comp_list) {
-				__resource_props_mismatch(ris, class);
+				/* There can be multiple resources under a class which is
+				 * mapped to different controls, for instance L3 cache
+				 * can have both CPOR and DSPRI implemented, and following
+				 * would avoid property mismatch later on when different
+				 * resources are present.
+				 */
+				if (class->props.features != ris->props.features)
+					mpam_enable_club_class_features(class, ris);
+				else
+					__resource_props_mismatch(ris, class);
 
 				class->nrdy_usec = max(class->nrdy_usec,
 						     ris->msc->nrdy_usec);
-- 
2.25.1

