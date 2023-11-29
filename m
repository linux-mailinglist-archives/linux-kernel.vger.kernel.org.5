Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5617FDBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbjK2Plw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjK2Plv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:41:51 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC105D46;
        Wed, 29 Nov 2023 07:41:57 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATFABW7011752;
        Wed, 29 Nov 2023 07:41:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=uDTkRMfs9Qm60lNSIgRLVb/C/VJq9P7BSiKI4joTZxw=;
 b=FFNQH6HwumzIcB+CJRj8YrHOdbcvWMk5hBRq4wKCrom8ecjKU2FKo23miePA5XHuqNxa
 y7wuZcEiphVBoS7lCPvnZRlXDXhL3t7oslfkNq2lcp11GW8jeTnKE2qtRra5rD3WQjGE
 JDevQTKMrCbW2sCqO6TrgjvM1FFS3Q4A8ZrWH6u5D8ul+YISw5/5OcNoiBZ2MMuQNWuS
 DZjevm+DwV6sKBcG9Tvyq8O7MVIKomJcV81GVb88lKF5jnUsFcEanr/+wu9yefRrF6Jd
 LlJ1c6ENkMJgkYbbTqY0U5B/YpqccdKXQmVRFmXFqTFjmFH2p6imBkSpQjMJoiHrdkvp PA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3up4x195e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 07:41:40 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 07:41:39 -0800
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.48 via Frontend Transport; Wed, 29 Nov 2023 07:41:35 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <bbrezillon@kernel.org>, <arno@natisbad.org>,
        <schalla@marvell.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <alobakin@pm.me>, <tj@kernel.org>,
        <masahiroy@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH] crypto/octeontx2: By default allocate one CPT LF per CPT VF
Date:   Wed, 29 Nov 2023 21:11:33 +0530
Message-ID: <20231129154133.1529898-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zbAX0USzo1Ti34vsFOnbJWog6Q7QpWXx
X-Proofpoint-ORIG-GUID: zbAX0USzo1Ti34vsFOnbJWog6Q7QpWXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_13,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are limited number CPT LFs (example 64 LFs on cn10k) and
these LFs are allocated/attached to CPT VF on its creation.
cptpf sysfs parameter "kvf_limits" defines number of CPT LFs
per CPT VF. Default "kvf_limits" is initialized to zero and if
kvf_limits is zero then number of LF allocated are equal to
online cpus in system.

For example on 24 core system, 24 CPT LFs will be attached per VF.
That means no CPT LF available when creating more than 2 CPT VFs
on system which have total 64 LFs. Although VFs gets created but
no LF attached to it.

There seems no reason to default allocate as many LFs as many
online cpus in system. This patch initializes "kvf_limits" to
one to limit one LF allocated per CPT VF. "kvf_limits" can
be changed in range of 1 to number-of-online-cpus via sysfs.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 1 +
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index e34223daa327..b13df6a49644 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -797,6 +797,7 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 		goto destroy_afpf_mbox;
 
 	cptpf->max_vfs = pci_sriov_get_totalvfs(pdev);
+	cptpf->kvf_limits = 1;
 
 	err = cn10k_cptpf_lmtst_init(cptpf);
 	if (err)
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index bac729c885f9..69a447d3702c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -277,8 +277,7 @@ static int cptvf_lf_init(struct otx2_cptvf_dev *cptvf)
 	if (ret)
 		return ret;
 
-	lfs_num = cptvf->lfs.kvf_limits ? cptvf->lfs.kvf_limits :
-		  num_online_cpus();
+	lfs_num = cptvf->lfs.kvf_limits;
 
 	otx2_cptlf_set_dev_info(lfs, cptvf->pdev, cptvf->reg_base,
 				&cptvf->pfvf_mbox, cptvf->blkaddr);
-- 
2.34.1

