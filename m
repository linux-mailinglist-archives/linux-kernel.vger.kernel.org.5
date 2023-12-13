Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F08115CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442103AbjLMPHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442073AbjLMPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:07:44 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAE0B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:07:49 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDETVOQ002775;
        Wed, 13 Dec 2023 07:07:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=pfptdkimsnps; bh=Tr7IYPITuxAPWl4EK
        zGwdZNRtItdCX54g+L6fr6UUJQ=; b=vGu3Yx/yzm/mY6SOHOT/o42XwXl1I5Uo+
        hfS52RQiNOfK+Vxyp0znaDAm2WjaZyGU16y639I5rDIFhr6JQEFKPlZarFNjJIn5
        nRY451Wh6pXjiuzG4kMinH4qpznkPC4ow99keg3xIfeCL5uveVcyHYexW8pryjKn
        ootwCGgWXRRxrSj9PtJ7pMYbcB8gcDx6FxVwjefNMBKfCrLhsNQHijUCdoBhZ72H
        VhrwWyOak+hzPk758l96tQMVcJQWgVOA6aVy36050UarQR+lOS+By/ArfQfK5I/B
        NJaIXAAPf7TALcOAtWm7BPxJ00WoQxRvej2X3dzvTKKO9iairVz6A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uxnyx0dqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 07:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702480052; bh=7RvO1yPLoi3+j1sn4inWAZ+9901WN8LfuW7qtiFW94E=;
        h=From:To:Cc:Subject:Date:From;
        b=bUaHVxQodscb9VOuNT/T1ioZ3/filOfVm154k30A8sKlqgvITySxh2hfIL/e+xATf
         aGEKBcew/jelR4p8pt6Oeag8PSZF+G1Bg7679cAgcvaF8oZldCS7y7Lzczmu+7BO8/
         2kL1ApMIJhW8ToeGdLcr+xzOdfwN/dmKKKlpoLH6H/9pDk+RN1+Q1XrSk4MVB8VGs3
         g0ZvM9P7hkUePVWue+OZ1PkCQkaM9TAovtzCIwJVhPsLbw2/XV+UvUlBLkkndSoolG
         Gt/HqDu5fAzlyG53nVD7SrprFmByZBjDY+pfMfnYUq5kgqpoj1BhyqBqNqTFjI619R
         lQnvWaNOxW5bQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6357A4048E;
        Wed, 13 Dec 2023 15:07:31 +0000 (UTC)
Received: from SNPS-o0WHuHJU73.internal.synopsys.com (snps-o0whuhju73.internal.synopsys.com [10.116.105.128])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 79F02A0073;
        Wed, 13 Dec 2023 15:07:29 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Pavel Kozlov <Pavel.Kozlov@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
        Pavel Kozlov <Pavel.Kozlov@synopsys.com>
Subject: [PATCH] ARC: add hugetlb definitions
Date:   Wed, 13 Dec 2023 19:07:10 +0400
Message-Id: <20231213150710.13574-1-kozlov@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8TCG7J6bXDDtw1NvaVsrMf5Zc-vH120n
X-Proofpoint-ORIG-GUID: 8TCG7J6bXDDtw1NvaVsrMf5Zc-vH120n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=539 mlxscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312130107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Kozlov <pavel.kozlov@synopsys.com>

Add hugetlb definitions if THP enabled. ARC doesn't support
HugeTLB FS but it supports THP. Some kernel code such as pagemap
uses hugetlb definitions with THP.

This patch fixes ARC build issue (HPAGE_SIZE undeclared error) with
TRANSPARENT_HUGEPAGE enabled.

Signed-off-by: Pavel Kozlov <pavel.kozlov@synopsys.com>
---
 arch/arc/include/asm/hugepage.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugepage.h
index ef8d4166370c..8a2441670a8f 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -10,6 +10,13 @@
 #include <linux/types.h>
 #include <asm-generic/pgtable-nopmd.h>
 
+/*
+ * Hugetlb definitions.
+ */
+#define HPAGE_SHIFT		PMD_SHIFT
+#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
+
 static inline pte_t pmd_pte(pmd_t pmd)
 {
 	return __pte(pmd_val(pmd));
-- 
2.25.1

