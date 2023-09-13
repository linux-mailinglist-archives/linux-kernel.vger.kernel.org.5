Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895B779F16A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjIMSxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjIMSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:53:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5ED1985
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:53:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DG0Awj015441;
        Wed, 13 Sep 2023 18:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Zk8F3NwTpSlJTJNRWp7Z/CPcOvwP0TogqcqsVm1ZAWo=;
 b=EyT9M0xrBxgbbEifS4Ab75tRq+kizVB4kd9dfKFTi0zI6zQF5Tmn03gYwyosx5RdEl6p
 CEHCFmVkKo/ATZv/ifH23oDRvqXkhr4bo+1/I5Lrd1TxePkRMysOwn0cvUJzHtezmm40
 fZtITLNNYiGGhk2ops0dlmJcGf9c+H1N/jQ5GN6quI9/o+WSc3TjCKyd2m9WcLeDY65U
 zcNh2rK0vfbVNW2Vbj5SvZOuyYC0Heraofd97aQXW4T1QGqEsk/vPuvA6U9Cq2WXvrdR
 /SIXkrnP6ZmOu9qPvScEJgOQF23SdeJ5Qh5WbCysYd7pXJ0/bIZwAjETk4+fMuL/yPWw 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t37jr29w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 18:53:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DHUJLw033661;
        Wed, 13 Sep 2023 18:53:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkgxr9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 18:53:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DIqnis015352;
        Wed, 13 Sep 2023 18:53:04 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-187-203.vpn.oracle.com [10.175.187.203])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t0wkgxqyp-3;
        Wed, 13 Sep 2023 18:53:04 +0000
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
Subject: [PATCH 2/3] arm64/kvm: Fine grain _EL2 system registers list that affect nested virtualization
Date:   Wed, 13 Sep 2023 18:52:07 +0000
Message-Id: <20230913185209.32282-3-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913185209.32282-1-miguel.luis@oracle.com>
References: <20230913185209.32282-1-miguel.luis@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_13,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130158
X-Proofpoint-ORIG-GUID: Dh1TksJyigA7T7y8HD447THG5JQIwbWt
X-Proofpoint-GUID: Dh1TksJyigA7T7y8HD447THG5JQIwbWt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some _EL1 registers got included in the _EL2 ranges, which are not
affected by NV. Remove them and fine grain the ranges to exclusively
include the _EL2 ones.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 arch/arm64/kvm/emulate-nested.c | 44 ++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 9ced1bf0c2b7..9aa1c06abdb7 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -649,14 +649,46 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_APGAKEYHI_EL1,	CGT_HCR_APK),
 	/* All _EL2 registers */
 	SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
-		      sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
+			sys_reg(3, 4, 4, 0, 1), CGT_HCR_NV),
 	/* Skip the SP_EL1 encoding... */
-	SR_TRAP(SYS_SPSR_EL2,		CGT_HCR_NV),
-	SR_TRAP(SYS_ELR_EL2,		CGT_HCR_NV),
-	SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
-		      sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
+			sys_reg(3, 4, 10, 6, 7), CGT_HCR_NV),
+	/* skip MECID_A0_EL2, MECID_A1_EL2, MECID_P0_EL2,
+	 *      MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2,
+	 *      VMECID_P_EL2.
+	 */
 	SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
-		      sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
+			sys_reg(3, 4, 12, 1, 1), CGT_HCR_NV),
+	/* ICH_AP0R<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_AP0R0_EL2,
+			SYS_ICH_AP0R3_EL2, CGT_HCR_NV),
+	/* ICH_AP1R<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_AP1R0_EL2,
+			SYS_ICH_AP1R3_EL2, CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 12, 9, 5),
+			sys_reg(3, 4, 12, 11, 7), CGT_HCR_NV),
+	/* ICH_LR<m>_EL2 */
+	SR_TRAP(SYS_ICH_LR0_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR1_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR2_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR3_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR4_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR5_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR6_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR7_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR8_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR9_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR10_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR11_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR12_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR13_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR14_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_LR15_EL2,	CGT_HCR_NV),
+	SR_RANGE_TRAP(sys_reg(3, 4, 13, 0, 1),
+			sys_reg(3, 4, 13, 0, 7), CGT_HCR_NV),
+	/* skip AMEVCNTVOFF0<n>_EL2 and AMEVCNTVOFF1<n>_EL2 */
+	SR_RANGE_TRAP(sys_reg(3, 4, 14, 0, 3),
+			sys_reg(3, 4, 14, 5, 2), CGT_HCR_NV),
 	/* All _EL02, _EL12 registers */
 	SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
 		      sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
-- 
2.39.2

