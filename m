Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D967ADCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjIYQWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIYQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:22:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA5E8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:22:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PECMDl017661;
        Mon, 25 Sep 2023 16:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=80bWNtyVFFb+A7R10PXNfmbF2WAi7Ns30GPR0ShRTfM=;
 b=WY7aM8eevvIjOAFmJcvH681GQyveku4rM3CT4PhV9SYfqIvze4+ueMfNfbZ4jM2dq6vT
 OYAEWZX+gtCa8ZNW20257ipvXUkn6159/RpQ+FUZoEfT6P+qt3iOVB9ItYyQx33peW2p
 SajrmuqfplV6pluA/iNNSmw+tPd8ENR/TolhjE8Q+AUEolS+HWPDkMeiY2T2tCi+NIwm
 2RBkfiiCJaQ6hgSOzatKoJDDuk8DiBSgIn4Rjk/sJU8Cg/+FbTVMWgZS0+d5k0HxV154
 EMD348MBTY0nRfNEQfiem3lyhpNQ2Z0JJlZk8gbJjCebFcClCEZjoxPzKLpPxBYQW44C hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3m4t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:22:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PG8HfV034986;
        Mon, 25 Sep 2023 16:22:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4ye89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:22:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PGLi22024071;
        Mon, 25 Sep 2023 16:22:20 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-170-37.vpn.oracle.com [10.175.170.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t9pf4ycur-3;
        Mon, 25 Sep 2023 16:22:20 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Cc:     miguel.luis@oracle.com
Subject: [PATCH v2 2/2] arm64/kvm: Fine grain _EL2 system registers list that affect nested virtualization
Date:   Mon, 25 Sep 2023 16:20:57 +0000
Message-Id: <20230925162057.27548-3-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925162057.27548-1-miguel.luis@oracle.com>
References: <20230925162057.27548-1-miguel.luis@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_13,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250126
X-Proofpoint-ORIG-GUID: 0at01WG6PMWVVC80OzCSmus-Wdc347wc
X-Proofpoint-GUID: 0at01WG6PMWVVC80OzCSmus-Wdc347wc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some _EL1 registers got included in the _EL2 ranges, which are not
affected by NV. Remove them, fine grain the ranges to exclusively
include the _EL2 ones and fold SPSR/ELR _EL2 registers into the
existing range.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 arch/arm64/kvm/emulate-nested.c | 44 ++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 9ced1bf0c2b7..f6d0c87803f4 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -649,14 +649,46 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_APGAKEYHI_EL1,	CGT_HCR_APK),
 	/* All _EL2 registers */
 	SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
-		      sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
+		      sys_reg(3, 4, 4, 0, 1), CGT_HCR_NV),
 	/* Skip the SP_EL1 encoding... */
-	SR_TRAP(SYS_SPSR_EL2,		CGT_HCR_NV),
-	SR_TRAP(SYS_ELR_EL2,		CGT_HCR_NV),
-	SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
-		      sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
+		      sys_reg(3, 4, 10, 6, 7), CGT_HCR_NV),
+	/*
+	 * Note that the spec. describes a group of MEC registers
+	 * whose access should not trap, therefore skip the following:
+	 * MECID_A0_EL2, MECID_A1_EL2, MECID_P0_EL2,
+	 * MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2,
+	 * VMECID_P_EL2.
+	 */
 	SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
-		      sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
+		      sys_reg(3, 4, 12, 1, 1), CGT_HCR_NV),
+	/* ICH_AP0R<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_AP0R0_EL2,
+		      SYS_ICH_AP0R3_EL2, CGT_HCR_NV),
+	/* ICH_AP1R<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_AP1R0_EL2,
+		      SYS_ICH_AP1R3_EL2, CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 12, 9, 5),
+		      sys_reg(3, 4, 12, 11, 7), CGT_HCR_NV),
+	/* ICH_LR<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_LR0_EL2,
+		      SYS_ICH_LR7_EL2, CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_ICH_LR8_EL2,
+		      SYS_ICH_LR15_EL2, CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 13, 0, 1),
+		      sys_reg(3, 4, 13, 0, 7), CGT_HCR_NV),
+	/* AMEVCNTVOFF0<n>_EL2 */
+	SR_RANGE_TRAP(sys_reg(3, 4, 13, 8, 0),
+		      sys_reg(3, 4, 13, 8, 7), CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 13, 9, 0),
+		      sys_reg(3, 4, 13, 9, 7), CGT_HCR_NV),
+	/* AMEVCNTVOFF1<n>_EL2 */
+	SR_RANGE_TRAP(sys_reg(3, 4, 13, 10, 0),
+		      sys_reg(3, 4, 13, 10, 7), CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 13, 11, 0),
+		      sys_reg(3, 4, 13, 11, 7), CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 14, 0, 3),
+		      sys_reg(3, 4, 14, 5, 2), CGT_HCR_NV),
 	/* All _EL02, _EL12 registers */
 	SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
 		      sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
-- 
2.39.2

