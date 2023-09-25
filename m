Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEFD7ADCF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjIYQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjIYQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:22:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F0BE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:22:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PECECD002029;
        Mon, 25 Sep 2023 16:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=tvy6Z6szTq1bAkmZQeSWwGo173Ev+55Y3onQnABhxWE=;
 b=0b4AwQ0qGeBCDjIUBsIw+iJIfPLliB4+j5+kmZOHZwCnFvA6N/7pL5VeFc9GG05/q52E
 BzVqVF04dftXPZqhSH49fTHLP2lSZ1w1EFa0C9f5X4zP4KnmEuO2+q8VDZOS6s+Gs90w
 RpKwWMiFTGubE0NTwI9gC0s/i2cKDrG0kKxZg9Zoyv6MnN11T0X0oFQvXx1FtH0taG7S
 PvZkigoT359Z9oVmOiDKh47xZb7R5oKWV+BVE3vKVVo7z33ZYHb7D0HsiZYW1FzYw5eZ
 xnY8TwFDMzKS2aO23d7KgU9DwikrKYwbajY0oMhP2B42iJ/5r1VSDGF/puwH4NIHT0Aq rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuc48f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:22:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PFZV6T034921;
        Mon, 25 Sep 2023 16:22:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4ydsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:22:05 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PGLi20024071;
        Mon, 25 Sep 2023 16:22:04 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-170-37.vpn.oracle.com [10.175.170.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t9pf4ycur-2;
        Mon, 25 Sep 2023 16:22:04 +0000
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
Subject: [PATCH v2 1/2] arm64: Add missing _EL12 encodings
Date:   Mon, 25 Sep 2023 16:20:56 +0000
Message-Id: <20230925162057.27548-2-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925162057.27548-1-miguel.luis@oracle.com>
References: <20230925162057.27548-1-miguel.luis@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_13,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=984 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250126
X-Proofpoint-ORIG-GUID: mPV9hicQh9mSiFp7cSPhziEQ-GfnxV-A
X-Proofpoint-GUID: mPV9hicQh9mSiFp7cSPhziEQ-GfnxV-A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some _EL12 encodings are missing. Add them.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 arch/arm64/include/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 38296579a4fd..6e167bbf44ff 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -568,18 +568,29 @@
 
 /* VHE encodings for architectural EL0/1 system registers */
 #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
+#define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
+#define SYS_SCTLR2_EL12			sys_reg(3, 5, 1, 0, 3)
+#define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
+#define SYS_TRFCR_EL12			sys_reg(3, 5, 1, 2, 1)
+#define SYS_SMCR_EL12			sys_reg(3, 5, 1, 2, 6)
 #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
 #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
 #define SYS_TCR_EL12			sys_reg(3, 5, 2, 0, 2)
+#define SYS_TCR2_EL12			sys_reg(3, 5, 2, 0, 3)
 #define SYS_SPSR_EL12			sys_reg(3, 5, 4, 0, 0)
 #define SYS_ELR_EL12			sys_reg(3, 5, 4, 0, 1)
 #define SYS_AFSR0_EL12			sys_reg(3, 5, 5, 1, 0)
 #define SYS_AFSR1_EL12			sys_reg(3, 5, 5, 1, 1)
 #define SYS_ESR_EL12			sys_reg(3, 5, 5, 2, 0)
 #define SYS_TFSR_EL12			sys_reg(3, 5, 5, 6, 0)
+#define SYS_FAR_EL12			sys_reg(3, 5, 6, 0, 0)
+#define SYS_BRBCR_EL12			sys_reg(3, 5, 9, 0, 0)
+#define SYS_PMSCR_EL12			sys_reg(3, 5, 9, 9, 0)
 #define SYS_MAIR_EL12			sys_reg(3, 5, 10, 2, 0)
 #define SYS_AMAIR_EL12			sys_reg(3, 5, 10, 3, 0)
 #define SYS_VBAR_EL12			sys_reg(3, 5, 12, 0, 0)
+#define SYS_CONTEXTIDR_EL12		sys_reg(3, 5, 13, 0, 1)
+#define SYS_SCXTNUM_EL12		sys_reg(3, 5, 13, 0, 7)
 #define SYS_CNTKCTL_EL12		sys_reg(3, 5, 14, 1, 0)
 #define SYS_CNTP_TVAL_EL02		sys_reg(3, 5, 14, 2, 0)
 #define SYS_CNTP_CTL_EL02		sys_reg(3, 5, 14, 2, 1)
-- 
2.39.2

