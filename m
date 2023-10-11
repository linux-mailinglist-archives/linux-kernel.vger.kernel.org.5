Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987A7C5AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbjJKSCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjJKSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:02:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6031A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:02:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BHEXxs008938;
        Wed, 11 Oct 2023 18:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=LQD2EetfkBTJWECVsOuu7oX2KWF9Y6xgxdXIpIDsyrQ=;
 b=Si+QIgc9Sah/2/w516iQw9HCbMMoWiJ4iWh5PeL2a5Ai1m6gkLWRRvYf10zeVypp870G
 SbG2bVQg4QUTtbFZ1sj13GKeqrqCXYH/Yv9/BMKKp0WtjvIfWIpxP5OiFjUTTj7COzol
 2zQvjv0T9KhtVwlKb5eRHuB+uRshctoXLXXlcGAzQIna3ksdJ1xupA6uf6Lhzeiu9Bg5
 9vhoqgFsAyzPpGKaKD0/+U/7KLboNWd1Pbc/bvgq99mZpJj0v2z+UoPDBAvTxcHl7o6p
 oKFgH5Lrrwk2F43gsLPJTW4r1DE9GjBcw8/wR+F8J4fbcQ/tTfzH9VrI2H7xtOvuOe6k zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvurymh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 18:01:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BGjvHx002574;
        Wed, 11 Oct 2023 18:01:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwseds2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 18:01:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BI1eE2029797;
        Wed, 11 Oct 2023 18:01:56 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-192-63.vpn.oracle.com [10.175.192.63])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tjwsedrg7-2;
        Wed, 11 Oct 2023 18:01:56 +0000
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
Subject: [PATCH v3 1/3] arm64: Add missing _EL12 encodings
Date:   Wed, 11 Oct 2023 18:01:00 +0000
Message-Id: <20231011180103.91774-2-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011180103.91774-1-miguel.luis@oracle.com>
References: <20231011180103.91774-1-miguel.luis@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110159
X-Proofpoint-ORIG-GUID: GGwcpKQLkF_i5uim00fukHQcXoIeRCx7
X-Proofpoint-GUID: GGwcpKQLkF_i5uim00fukHQcXoIeRCx7
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 arch/arm64/include/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 38296579a4fd..ba5db50effec 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -567,19 +567,30 @@
 #define SYS_CNTHCTL_EL2			sys_reg(3, 4, 14, 1, 0)
 
 /* VHE encodings for architectural EL0/1 system registers */
+#define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)
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

