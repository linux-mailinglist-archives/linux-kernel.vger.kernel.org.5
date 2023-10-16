Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DA27CA68A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjJPLSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjJPLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:18:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12709E3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:18:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G6n0Zl021543;
        Mon, 16 Oct 2023 11:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Zk249fiF/iSFO94QT/3miQcSmsGWrvekgwFOzDA+JQY=;
 b=wKFUsoZpSkTe6i5C/UpWtWLJsD9JWlfSQmutgQiMgcAU6Dtk782Yznqe67eJCqVpi5dM
 1prfQ24Vd49Ztj3PbhXnsFYrGyiFKPu/2+gle6Z7FyqM+o/lWhnQJHBIRnglPG5CjB5G
 rbGkXSiFGg2roOQ4SS5KKuJGIY1GpbdBcfshQeJgHf/PwEnDNNbuOp+UFJuR4AIfX1ZU
 kBbcO5luTlHNmjYZ0s0M0jh8lcUdhLlb3WpDOHazS6Zdp6Y5uJ/5Btcp+FNPFuQlVjvo
 ylMa9pKGaw4D2BGVMK06WHoAW9jannR02tjsYSfy94DPPnwAzEHhzNGTW86FomEHvhEz KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jjewt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 11:18:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39G9IHXf027160;
        Mon, 16 Oct 2023 11:18:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg529h8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 11:18:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GBHqSE040637;
        Mon, 16 Oct 2023 11:18:05 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-197-167.vpn.oracle.com [10.175.197.167])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3trg529gvb-4;
        Mon, 16 Oct 2023 11:18:05 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Cc:     miguel.luis@oracle.com
Subject: [PATCH v4 3/3] arm64/kvm: Fine grain _EL2 system registers list that affect nested virtualization
Date:   Mon, 16 Oct 2023 11:17:42 +0000
Message-Id: <20231016111743.30331-4-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016111743.30331-1-miguel.luis@oracle.com>
References: <20231016111743.30331-1-miguel.luis@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160099
X-Proofpoint-GUID: xhYtxXL_PpdZV9scRdEiCoFCZ1R8sJz2
X-Proofpoint-ORIG-GUID: xhYtxXL_PpdZV9scRdEiCoFCZ1R8sJz2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a fine grained approach in the _EL2 sysreg ranges.

Fixes: d0fc0a2519a6 ("KVM: arm64: nv: Add trap forwarding for HCR_EL2")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 arch/arm64/kvm/emulate-nested.c | 89 ++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 9ced1bf0c2b7..3a7d4003fc2b 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -648,15 +648,92 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_APGAKEYLO_EL1,	CGT_HCR_APK),
 	SR_TRAP(SYS_APGAKEYHI_EL1,	CGT_HCR_APK),
 	/* All _EL2 registers */
-	SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
-		      sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
+	SR_TRAP(SYS_BRBCR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_VPIDR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_VMPIDR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_SCTLR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_ACTLR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_SCTLR2_EL2,		CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_HCR_EL2,
+		      SYS_HCRX_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_SMPRIMAP_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_SMCR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_SDER32_EL2,		CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_TTBR0_EL2,
+		      SYS_TCR2_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_VTTBR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_VTCR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_VNCR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_VSTTBR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_VSTCR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_DACR32_EL2,		CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_HDFGRTR_EL2,
+		      SYS_HAFGRTR_EL2,	CGT_HCR_NV),
 	/* Skip the SP_EL1 encoding... */
 	SR_TRAP(SYS_SPSR_EL2,		CGT_HCR_NV),
 	SR_TRAP(SYS_ELR_EL2,		CGT_HCR_NV),
-	SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
-		      sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
-	SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
-		      sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
+	/* SPSR_irq, SPSR_abt, SPSR_und, SPSR_fiq */
+	SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
+		      sys_reg(3, 4, 4, 3, 3), CGT_HCR_NV),
+	SR_TRAP(SYS_IFSR32_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_AFSR0_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_AFSR1_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_ESR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_VSESR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_FPEXC32_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_TFSR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_FAR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_HPFAR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_PMSCR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_MAIR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_AMAIR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_MPAMHCR_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_MPAMVPMV_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_MPAM2_EL2,		CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_MPAMVPM0_EL2,
+		      SYS_MPAMVPM7_EL2,	CGT_HCR_NV),
+	/*
+	 * Note that the spec. describes a group of MEC registers
+	 * whose access should not trap, therefore skip the following:
+	 * MECID_A0_EL2, MECID_A1_EL2, MECID_P0_EL2,
+	 * MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2,
+	 * VMECID_P_EL2.
+	 */
+	SR_RANGE_TRAP(SYS_VBAR_EL2,
+		      SYS_RMR_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_VDISR_EL2,		CGT_HCR_NV),
+	/* ICH_AP0R<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_AP0R0_EL2,
+		      SYS_ICH_AP0R3_EL2, CGT_HCR_NV),
+	/* ICH_AP1R<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_AP1R0_EL2,
+		      SYS_ICH_AP1R3_EL2, CGT_HCR_NV),
+	SR_TRAP(SYS_ICC_SRE_EL2,	CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_ICH_HCR_EL2,
+		      SYS_ICH_EISR_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_ELRSR_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_ICH_VMCR_EL2,	CGT_HCR_NV),
+	/* ICH_LR<m>_EL2 */
+	SR_RANGE_TRAP(SYS_ICH_LR0_EL2,
+		      SYS_ICH_LR15_EL2, CGT_HCR_NV),
+	SR_TRAP(SYS_CONTEXTIDR_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_TPIDR_EL2,		CGT_HCR_NV),
+	SR_TRAP(SYS_SCXTNUM_EL2,	CGT_HCR_NV),
+	/* AMEVCNTVOFF0<n>_EL2, AMEVCNTVOFF1<n>_EL2  */
+	SR_RANGE_TRAP(SYS_AMEVCNTVOFF0n_EL2(0),
+		      SYS_AMEVCNTVOFF1n_EL2(15), CGT_HCR_NV),
+	/* CNT*_EL2 */
+	SR_TRAP(SYS_CNTVOFF_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_CNTPOFF_EL2,	CGT_HCR_NV),
+	SR_TRAP(SYS_CNTHCTL_EL2,	CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_CNTHP_TVAL_EL2,
+		      SYS_CNTHP_CVAL_EL2, CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_CNTHV_TVAL_EL2,
+		      SYS_CNTHV_CVAL_EL2, CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_CNTHVS_TVAL_EL2,
+		      SYS_CNTHVS_CVAL_EL2, CGT_HCR_NV),
+	SR_RANGE_TRAP(SYS_CNTHPS_TVAL_EL2,
+		      SYS_CNTHPS_CVAL_EL2, CGT_HCR_NV),
 	/* All _EL02, _EL12 registers */
 	SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
 		      sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
-- 
2.39.2

