Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB431753FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjGNQXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjGNQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:23:03 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A11FD4;
        Fri, 14 Jul 2023 09:23:02 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EF3emo005045;
        Fri, 14 Jul 2023 09:22:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=9O3+jtcAJ/FeEsOkjfIEhBibJs4Hdmm3In9upYFaKIM=;
 b=GCBecp1bwD4wjMVBkrMu8EFvyzT6M2BhHQko0IlbmwlAWK8ymeABjqmjDuMD5ohSLZnm
 a/aeDnYxUC7jMpVbfkzgnLQ3CxgkGM1Vy+Mddjytyk1wwrVZrudqpCOqUYYp5/+vScOo
 t7wJfmH3KgYBWFcPZ/PmV/EHHnsNcoMUsGRhCddg24ksm4iSKpOgJlB0UKXMyolfXkdv
 3wUjBJ9+UdkNN/FQEZtzsiTSNgOnA1wzh+HmUjVfSIMvvUeGCTQ8CKdPC8UNf9NDP6b5
 IFggDYJc437yQDtnhz8r8pbX4F9lHH+yTuV2WKFggLI7Nr4DmW1NKD8n4DmjpWD8k33d bw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ru8p0r88t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:22:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 09:22:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Jul 2023 09:22:53 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
        by maili.marvell.com (Postfix) with ESMTP id 1FA8F3F7064;
        Fri, 14 Jul 2023 09:22:49 -0700 (PDT)
From:   Subbaraya Sundeep <sbhatta@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH] octeontx2-pf: mcs: Generate hash key using ecb(aes)
Date:   Fri, 14 Jul 2023 21:52:48 +0530
Message-ID: <1689351768-3733-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: zwpVoO7xsVuYy6eHPp-Ol11iMhoXJJRL
X-Proofpoint-ORIG-GUID: zwpVoO7xsVuYy6eHPp-Ol11iMhoXJJRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_07,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware generated encryption and ICV tags are found to
be wrong when tested with IEEE MACSEC test vectors.
This is because as per the HRM, the hash key (derived by
AES-ECB block encryption of an all 0s block with the SAK)
has to be programmed by the software in
MCSX_RS_MCS_CPM_TX_SLAVE_SA_PLCY_MEM_4X register.
Hence fix this by generating hash key in software and
configuring in hardware.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  | 132 +++++++++++++++------
 1 file changed, 95 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 6e2fb24..9f23118 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 Marvell.
  */
 
+#include <crypto/skcipher.h>
 #include <linux/rtnetlink.h>
 #include <linux/bitfield.h>
 #include "otx2_common.h"
@@ -42,6 +43,51 @@
 #define MCS_TCI_E			0x08 /* encryption */
 #define MCS_TCI_C			0x04 /* changed text */
 
+#define CN10K_MAX_HASH_LEN		16
+#define CN10K_MAX_SAK_LEN		32
+
+static int cn10k_ecb_aes_encrypt(struct otx2_nic *pfvf, u8 *sak,
+				 u16 sak_len, u8 *hash)
+{
+	u8 data[CN10K_MAX_HASH_LEN] = { 0 };
+	struct skcipher_request *req = NULL;
+	struct scatterlist sg_src, sg_dst;
+	struct crypto_skcipher *tfm;
+	DECLARE_CRYPTO_WAIT(wait);
+	int err;
+
+	tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
+	if (IS_ERR(tfm)) {
+		dev_err(pfvf->dev, "failed to allocate transform for ecb-aes\n");
+		return PTR_ERR(tfm);
+	}
+
+	req = skcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		dev_err(pfvf->dev, "failed to allocate request for skcipher\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = crypto_skcipher_setkey(tfm, sak, sak_len);
+
+	/* build sg list */
+	sg_init_one(&sg_src, data, CN10K_MAX_HASH_LEN);
+	sg_init_one(&sg_dst, hash, CN10K_MAX_HASH_LEN);
+
+	skcipher_request_set_callback(req, 0, crypto_req_done, &wait);
+	skcipher_request_set_crypt(req, &sg_src, &sg_dst,
+				   CN10K_MAX_HASH_LEN, NULL);
+
+	err = crypto_skcipher_encrypt(req);
+	err = crypto_wait_req(err, &wait);
+
+out:
+	skcipher_request_free(req);
+	crypto_free_skcipher(tfm);
+	return err;
+}
+
 static struct cn10k_mcs_txsc *cn10k_mcs_get_txsc(struct cn10k_mcs_cfg *cfg,
 						 struct macsec_secy *secy)
 {
@@ -330,19 +376,53 @@ static int cn10k_mcs_write_sc_cam(struct otx2_nic *pfvf,
 	return ret;
 }
 
+static int cn10k_mcs_write_keys(struct otx2_nic *pfvf,
+				struct macsec_secy *secy,
+				struct mcs_sa_plcy_write_req *req,
+				u8 *sak, u8 *salt, ssci_t ssci)
+{
+	u8 hash_rev[CN10K_MAX_HASH_LEN] = { 0 };
+	u8 sak_rev[CN10K_MAX_SAK_LEN] = { 0 };
+	u8 salt_rev[MACSEC_SALT_LEN] = { 0 };
+	u8 hash[CN10K_MAX_HASH_LEN] = { 0 };
+	u32 ssci_63_32;
+	int err, i;
+
+	err = cn10k_ecb_aes_encrypt(pfvf, sak, secy->key_len, hash);
+	if (err) {
+		dev_err(pfvf->dev, "Generating hash using ECB(AES) failed\n");
+		return err;
+	}
+
+	for (i = 0; i < secy->key_len; i++)
+		sak_rev[i] = sak[secy->key_len - 1 - i];
+
+	for (i = 0; i < CN10K_MAX_HASH_LEN; i++)
+		hash_rev[i] = hash[CN10K_MAX_HASH_LEN - 1 - i];
+
+	for (i = 0; i < MACSEC_SALT_LEN; i++)
+		salt_rev[i] = salt[MACSEC_SALT_LEN - 1 - i];
+
+	ssci_63_32 = (__force u32)cpu_to_be32((__force u32)ssci);
+
+	memcpy(&req->plcy[0][0], sak_rev, secy->key_len);
+	memcpy(&req->plcy[0][4], hash_rev, CN10K_MAX_HASH_LEN);
+	memcpy(&req->plcy[0][6], salt_rev, MACSEC_SALT_LEN);
+	req->plcy[0][7] |= (u64)ssci_63_32 << 32;
+
+	return 0;
+}
+
 static int cn10k_mcs_write_rx_sa_plcy(struct otx2_nic *pfvf,
 				      struct macsec_secy *secy,
 				      struct cn10k_mcs_rxsc *rxsc,
 				      u8 assoc_num, bool sa_in_use)
 {
-	unsigned char *src = rxsc->sa_key[assoc_num];
 	struct mcs_sa_plcy_write_req *plcy_req;
-	u8 *salt_p = rxsc->salt[assoc_num];
+	u8 *sak = rxsc->sa_key[assoc_num];
+	u8 *salt = rxsc->salt[assoc_num];
 	struct mcs_rx_sc_sa_map *map_req;
 	struct mbox *mbox = &pfvf->mbox;
-	u64 ssci_salt_95_64 = 0;
-	u8 reg, key_len;
-	u64 salt_63_0;
 	int ret;
 
 	mutex_lock(&mbox->lock);
@@ -360,20 +440,10 @@ static int cn10k_mcs_write_rx_sa_plcy(struct otx2_nic *pfvf,
 		goto fail;
 	}
 
-	for (reg = 0, key_len = 0; key_len < secy->key_len; key_len += 8) {
-		memcpy((u8 *)&plcy_req->plcy[0][reg],
-		       (src + reg * 8), 8);
-		reg++;
-	}
-
-	if (secy->xpn) {
-		memcpy((u8 *)&salt_63_0, salt_p, 8);
-		memcpy((u8 *)&ssci_salt_95_64, salt_p + 8, 4);
-		ssci_salt_95_64 |= (__force u64)rxsc->ssci[assoc_num] << 32;
-
-		plcy_req->plcy[0][6] = salt_63_0;
-		plcy_req->plcy[0][7] = ssci_salt_95_64;
-	}
+	ret = cn10k_mcs_write_keys(pfvf, secy, plcy_req, sak,
+				   salt, rxsc->ssci[assoc_num]);
+	if (ret)
+		goto fail;
 
 	plcy_req->sa_index[0] = rxsc->hw_sa_id[assoc_num];
 	plcy_req->sa_cnt = 1;
@@ -586,13 +656,10 @@ static int cn10k_mcs_write_tx_sa_plcy(struct otx2_nic *pfvf,
 				      struct cn10k_mcs_txsc *txsc,
 				      u8 assoc_num)
 {
-	unsigned char *src = txsc->sa_key[assoc_num];
 	struct mcs_sa_plcy_write_req *plcy_req;
-	u8 *salt_p = txsc->salt[assoc_num];
+	u8 *sak = txsc->sa_key[assoc_num];
+	u8 *salt = txsc->salt[assoc_num];
 	struct mbox *mbox = &pfvf->mbox;
-	u64 ssci_salt_95_64 = 0;
-	u8 reg, key_len;
-	u64 salt_63_0;
 	int ret;
 
 	mutex_lock(&mbox->lock);
@@ -603,19 +670,10 @@ static int cn10k_mcs_write_tx_sa_plcy(struct otx2_nic *pfvf,
 		goto fail;
 	}
 
-	for (reg = 0, key_len = 0; key_len < secy->key_len; key_len += 8) {
-		memcpy((u8 *)&plcy_req->plcy[0][reg], (src + reg * 8), 8);
-		reg++;
-	}
-
-	if (secy->xpn) {
-		memcpy((u8 *)&salt_63_0, salt_p, 8);
-		memcpy((u8 *)&ssci_salt_95_64, salt_p + 8, 4);
-		ssci_salt_95_64 |= (__force u64)txsc->ssci[assoc_num] << 32;
-
-		plcy_req->plcy[0][6] = salt_63_0;
-		plcy_req->plcy[0][7] = ssci_salt_95_64;
-	}
+	ret = cn10k_mcs_write_keys(pfvf, secy, plcy_req, sak,
+				   salt, txsc->ssci[assoc_num]);
+	if (ret)
+		goto fail;
 
 	plcy_req->plcy[0][8] = assoc_num;
 	plcy_req->sa_index[0] = txsc->hw_sa_id[assoc_num];
-- 
2.7.4

