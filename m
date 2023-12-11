Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5135880C070
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjLKEq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:46:24 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9CA9;
        Sun, 10 Dec 2023 20:46:30 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BAMu0wK008719;
        Sun, 10 Dec 2023 20:46:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=pfpt0220; bh=rmOAQIEd
        ieVdx5+rp4pT1UDU/nxmZYB+S2OAWKR3IWk=; b=Z4Ale+eyUsyi6z8nXx10DL4+
        0PLo9rPRNSW6WaeW0w1ehpb0ySBxOGcnpn85AH3cNtwWzz7yYacWF7XUWgUOr2I0
        oqfvbO7XT8IRRYgFrD6ExugOu9l9lmA4dG0OxnmunYuDImaOlaOImipR88hnWZd6
        ZHJJfztkvFi3b1qSqLPVhskND1KkeIWi0d7wPUDCH3NrpYN329OdiaXFeLvqr1Vn
        Y85Vg3N9HXgRrZUvu7CO4iMyCpXgLrXRHzB9bvHeSIVNaPiqgOhRG9O+mqOK7JyN
        wsAqcx/jYdHTyjGePq2m16Whf9ZQB5JjWcORLAxxMOUq8IzWws3tc1T+CswURA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uw8xq9w9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 10 Dec 2023 20:46:08 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Dec
 2023 20:46:06 -0800
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.48 via Frontend Transport; Sun, 10 Dec 2023 20:46:03 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <bbrezillon@kernel.org>, <arno@natisbad.org>,
        <schalla@marvell.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <alobakin@pm.me>, <masahiroy@kernel.org>,
        <tj@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH] crypto: octeontx2: Fix cptvf driver cleanup
Date:   Mon, 11 Dec 2023 10:15:58 +0530
Message-ID: <20231211044558.41461-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pXhAW1gWTPfBj9PqvrkfytE0Fqrqsbi8
X-Proofpoint-ORIG-GUID: pXhAW1gWTPfBj9PqvrkfytE0Fqrqsbi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes following cleanup issues:
 - Missing instruction queue free on cleanup. This
   will lead to memory leak.
 - lfs->lfs_num is set to zero before cleanup, which
   will lead to improper cleanup.
 - Missing otx2_cptlf_shutdown() from cptvf driver cleanup

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      |  6 ++++--
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 10 ++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
index 6edd27ff8c4e..e4bd3f030cec 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
@@ -419,8 +419,8 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 	return 0;
 
 free_iq:
-	otx2_cpt_free_instruction_queues(lfs);
 	cptlf_hw_cleanup(lfs);
+	otx2_cpt_free_instruction_queues(lfs);
 detach_rsrcs:
 	otx2_cpt_detach_rsrcs_msg(lfs);
 clear_lfs_num:
@@ -431,11 +431,13 @@ EXPORT_SYMBOL_NS_GPL(otx2_cptlf_init, CRYPTO_DEV_OCTEONTX2_CPT);
 
 void otx2_cptlf_shutdown(struct otx2_cptlfs_info *lfs)
 {
-	lfs->lfs_num = 0;
 	/* Cleanup LFs hardware side */
 	cptlf_hw_cleanup(lfs);
+	/* Free instruction queues */
+	otx2_cpt_free_instruction_queues(lfs);
 	/* Send request to detach LFs */
 	otx2_cpt_detach_rsrcs_msg(lfs);
+	lfs->lfs_num = 0;
 }
 EXPORT_SYMBOL_NS_GPL(otx2_cptlf_shutdown, CRYPTO_DEV_OCTEONTX2_CPT);
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 69a447d3702c..123ad147545e 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -239,18 +239,16 @@ static void cptvf_lf_shutdown(struct otx2_cptlfs_info *lfs)
 {
 	atomic_set(&lfs->state, OTX2_CPTLF_IN_RESET);
 
-	/* Remove interrupts affinity */
-	otx2_cptlf_free_irqs_affinity(lfs);
-	/* Disable instruction queue */
-	otx2_cptlf_disable_iqueues(lfs);
 	/* Unregister crypto algorithms */
 	otx2_cpt_crypto_exit(lfs->pdev, THIS_MODULE);
+	/* Remove interrupts affinity */
+	otx2_cptlf_free_irqs_affinity(lfs);
 	/* Unregister LFs interrupts */
 	otx2_cptlf_unregister_interrupts(lfs);
 	/* Cleanup LFs software side */
 	lf_sw_cleanup(lfs);
-	/* Send request to detach LFs */
-	otx2_cpt_detach_rsrcs_msg(lfs);
+	/* CPT LFs cleanup */
+	otx2_cptlf_shutdown(lfs);
 }
 
 static int cptvf_lf_init(struct otx2_cptvf_dev *cptvf)
-- 
2.34.1

