Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1B17CA689
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjJPLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjJPLS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:18:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A5E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:18:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G6mxqg021265;
        Mon, 16 Oct 2023 11:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=KUqvOZJ7MAF9Eknvr5YhswSeBa1LY/YRGA7IQhsUCd4=;
 b=K1FvJWW0dqXQkokV5qOyO2POw2R9qXYdJpzR2XF8q5zdpfRnHdBhIdsALqa66U+nKYWQ
 rySNPNspFOjpqD9MHqJQf+Q5NQ/345ZwcpF4a7VlZublLYJ4oPcCdesQDkgOvysU8SdT
 xT4C26aPSean2mdMKR5xDnJ9pJGHsr2upldsDmqDAXtW+N+pLMxzydF2GXuaE7KrAE3e
 NM9J5YQPRvc3nXko9+lcLuWpVSE+mTWzHi9eT72PWWN1WXf6Wzzo6TaZb25iMf/KN7Xj
 8FgOi2SmLC3sJ3tnSazIhOD6aCwW8QLpKNR2oEq1phJbCuV7QQcUQSbQeOE2oFok5uk8 dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jjewq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 11:18:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39G9MUvm027313;
        Mon, 16 Oct 2023 11:18:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg529h6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 11:18:01 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GBHqSC040637;
        Mon, 16 Oct 2023 11:18:01 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-197-167.vpn.oracle.com [10.175.197.167])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3trg529gvb-3;
        Mon, 16 Oct 2023 11:18:01 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Cc:     miguel.luis@oracle.com
Subject: [PATCH v4 2/3] arm64: Add missing _EL2 encodings
Date:   Mon, 16 Oct 2023 11:17:41 +0000
Message-Id: <20231016111743.30331-3-miguel.luis@oracle.com>
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
X-Proofpoint-GUID: abLUBznVdJJ09M_CnTTiv7L6pWIdek6A
X-Proofpoint-ORIG-GUID: abLUBznVdJJ09M_CnTTiv7L6pWIdek6A
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some _EL2 encodings are missing. Add them.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 arch/arm64/include/asm/sysreg.h | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ba5db50effec..8653fb67a339 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -270,6 +270,8 @@
 /* ETM */
 #define SYS_TRCOSLAR			sys_reg(2, 1, 1, 0, 4)
 
+#define SYS_BRBCR_EL2			sys_reg(2, 4, 9, 0, 0)
+
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
@@ -484,6 +486,7 @@
 
 #define SYS_SCTLR_EL2			sys_reg(3, 4, 1, 0, 0)
 #define SYS_ACTLR_EL2			sys_reg(3, 4, 1, 0, 1)
+#define SYS_SCTLR2_EL2			sys_reg(3, 4, 1, 0, 3)
 #define SYS_HCR_EL2			sys_reg(3, 4, 1, 1, 0)
 #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
 #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
@@ -497,6 +500,10 @@
 #define SYS_VTCR_EL2			sys_reg(3, 4, 2, 1, 2)
 
 #define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
+#define SYS_SDER32_EL2			sys_reg(3, 4, 1, 3, 1)
+#define SYS_VNCR_EL2			sys_reg(3, 4, 2, 2, 0)
+#define SYS_VSTTBR_EL2			sys_reg(3, 4, 2, 6, 0)
+#define SYS_VSTCR_EL2			sys_reg(3, 4, 2, 6, 2)
 #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
 #define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
 #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
@@ -514,6 +521,18 @@
 
 #define SYS_MAIR_EL2			sys_reg(3, 4, 10, 2, 0)
 #define SYS_AMAIR_EL2			sys_reg(3, 4, 10, 3, 0)
+#define SYS_MPAMHCR_EL2			sys_reg(3, 4, 10, 4, 0)
+#define SYS_MPAMVPMV_EL2		sys_reg(3, 4, 10, 4, 1)
+#define SYS_MPAM2_EL2			sys_reg(3, 4, 10, 5, 0)
+#define __SYS__MPAMVPMx_EL2(x)		sys_reg(3, 4, 10, 6, x)
+#define SYS_MPAMVPM0_EL2		__SYS__MPAMVPMx_EL2(0)
+#define SYS_MPAMVPM1_EL2		__SYS__MPAMVPMx_EL2(1)
+#define SYS_MPAMVPM2_EL2		__SYS__MPAMVPMx_EL2(2)
+#define SYS_MPAMVPM3_EL2		__SYS__MPAMVPMx_EL2(3)
+#define SYS_MPAMVPM4_EL2		__SYS__MPAMVPMx_EL2(4)
+#define SYS_MPAMVPM5_EL2		__SYS__MPAMVPMx_EL2(5)
+#define SYS_MPAMVPM6_EL2		__SYS__MPAMVPMx_EL2(6)
+#define SYS_MPAMVPM7_EL2		__SYS__MPAMVPMx_EL2(7)
 
 #define SYS_VBAR_EL2			sys_reg(3, 4, 12, 0, 0)
 #define SYS_RVBAR_EL2			sys_reg(3, 4, 12, 0, 1)
@@ -562,9 +581,29 @@
 
 #define SYS_CONTEXTIDR_EL2		sys_reg(3, 4, 13, 0, 1)
 #define SYS_TPIDR_EL2			sys_reg(3, 4, 13, 0, 2)
+#define SYS_SCXTNUM_EL2			sys_reg(3, 4, 13, 0, 7)
+
+#define __AMEV_op2(m)			(m & 0x7)
+#define __AMEV_CRm(n, m)		(n | ((m & 0x8) >> 3))
+#define __SYS__AMEVCNTVOFF0n_EL2(m)	sys_reg(3, 4, 13, __AMEV_CRm(0x8, m), __AMEV_op2(m))
+#define SYS_AMEVCNTVOFF0n_EL2(m)	__SYS__AMEVCNTVOFF0n_EL2(m)
+#define __SYS__AMEVCNTVOFF1n_EL2(m)	sys_reg(3, 4, 13, __AMEV_CRm(0xA, m), __AMEV_op2(m))
+#define SYS_AMEVCNTVOFF1n_EL2(m)	__SYS__AMEVCNTVOFF1n_EL2(m)
 
 #define SYS_CNTVOFF_EL2			sys_reg(3, 4, 14, 0, 3)
 #define SYS_CNTHCTL_EL2			sys_reg(3, 4, 14, 1, 0)
+#define SYS_CNTHP_TVAL_EL2		sys_reg(3, 4, 14, 2, 0)
+#define SYS_CNTHP_CTL_EL2		sys_reg(3, 4, 14, 2, 1)
+#define SYS_CNTHP_CVAL_EL2		sys_reg(3, 4, 14, 2, 2)
+#define SYS_CNTHV_TVAL_EL2		sys_reg(3, 4, 14, 3, 0)
+#define SYS_CNTHV_CTL_EL2		sys_reg(3, 4, 14, 3, 1)
+#define SYS_CNTHV_CVAL_EL2		sys_reg(3, 4, 14, 3, 2)
+#define SYS_CNTHVS_TVAL_EL2		sys_reg(3, 4, 14, 4, 0)
+#define SYS_CNTHVS_CTL_EL2		sys_reg(3, 4, 14, 4, 1)
+#define SYS_CNTHVS_CVAL_EL2		sys_reg(3, 4, 14, 4, 2)
+#define SYS_CNTHPS_TVAL_EL2		sys_reg(3, 4, 14, 5, 0)
+#define SYS_CNTHPS_CTL_EL2		sys_reg(3, 4, 14, 5, 1)
+#define SYS_CNTHPS_CVAL_EL2		sys_reg(3, 4, 14, 5, 2)
 
 /* VHE encodings for architectural EL0/1 system registers */
 #define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)
-- 
2.39.2

