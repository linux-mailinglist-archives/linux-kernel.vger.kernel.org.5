Return-Path: <linux-kernel+bounces-41445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A187783F1DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BBB1F23453
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8E2377D;
	Sat, 27 Jan 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ICRNnsSn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B42033F;
	Sat, 27 Jan 2024 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398004; cv=none; b=Xhlc05H/S3Q/gTsgcjlvo4r1yUcmd5cPCVtMHgJtit5BPdcN4VmrNsBq4JEDuVw/iOma6gsi5lHPOOOX/cnPfznNI3+XnLPpUVhaUv0e/6mMvqtqsvmMyzMn0caYe6MESg9uWWX7+PLswol86P/b1ya0nFLJl75+yd9U9leXOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398004; c=relaxed/simple;
	bh=5/PQ5Dxcz1cJpfd6v79f/A1c4iMsg9knSU5gInlGOYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3/9UMGrFIvGeSp6Lbu8xCX0X4UKCjCBE5+dRDSLyo3GuyJuH3qHpTP8xb5XgRRLSWQrTZx5B6qCKH8wePqiUtiIqJq+5mUyxcsiZinwcNED6I3Hm7genTpOKF2bBOCFqwNjZ7CU9liQUllYVR2tmqRsSacbA3ZTNFVFTpeCsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ICRNnsSn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNIJFm024936;
	Sat, 27 Jan 2024 23:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=V/WSb8MXBgXwe8boYs+WZ6hn7AA2Zq0V47PBuWTpSgQ=; b=IC
	RNnsSnb+thnicVz7epRNHiHhLk1b0kNkCcnMbnCfeXdAWLGdyS0qKUhste9ZZtjA
	A9LS6lnK8l7wswWyLLlLIMhkMFcxZPCKQLmUuPBto2SInQMgqX5lX0DMGfioXzZw
	4Wf79fB5UAzR0Gl+De94K++J8jRhCRshtNP/OKdzPLHW/q++rLURU+bKvP4otHop
	HDrCrcAShZz55w8aPh+4ct/J+I/TvrdJEtZoDeEa9zzwaBNwkdH/iJPyFc1fNebP
	5+C3Jm/9/gFuPjmtAPA336oG6mVd7jjiiA9+xfc1X1Wq+DRp5BGFGpeyYRimMdfH
	bV+vD61XSk/oTf0F0p+A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvt7c141a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQJmU031151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:19 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:16 -0800
From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_omprsing@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: [PATCH v4 01/15] ice, ufs, mmc: use blk_crypto_key for program_key
Date: Sat, 27 Jan 2024 15:13:59 -0800
Message-ID: <20240127232436.2632187-2-quic_gaurkash@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0ICP5faZcDbNxhWSPbWgjDz2zliBECt1
X-Proofpoint-GUID: 0ICP5faZcDbNxhWSPbWgjDz2zliBECt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

The program key ops in the storage controller does not
pass on the blk crypto key structure to ice, this is okay
when wrapped keys are not supported and keys are standard
AES XTS sizes. However, wrapped keyblobs can be of any size
and in preparation for that, modify the ICE and storage
controller APIs to accept blk_crypto_key.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/mmc/host/cqhci-crypto.c  | 7 ++++---
 drivers/mmc/host/cqhci.h         | 2 ++
 drivers/mmc/host/sdhci-msm.c     | 6 ++++--
 drivers/soc/qcom/ice.c           | 6 +++---
 drivers/ufs/core/ufshcd-crypto.c | 7 ++++---
 drivers/ufs/host/ufs-qcom.c      | 6 ++++--
 include/soc/qcom/ice.h           | 5 +++--
 include/ufs/ufshcd.h             | 1 +
 8 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/cqhci-crypto.c b/drivers/mmc/host/cqhci-crypto.c
index 6652982410ec..91da6de1d650 100644
--- a/drivers/mmc/host/cqhci-crypto.c
+++ b/drivers/mmc/host/cqhci-crypto.c
@@ -32,6 +32,7 @@ cqhci_host_from_crypto_profile(struct blk_crypto_profile *profile)
 }
 
 static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
+				    const struct blk_crypto_key *bkey,
 				    const union cqhci_crypto_cfg_entry *cfg,
 				    int slot)
 {
@@ -39,7 +40,7 @@ static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
 	int i;
 
 	if (cq_host->ops->program_key)
-		return cq_host->ops->program_key(cq_host, cfg, slot);
+		return cq_host->ops->program_key(cq_host, bkey, cfg, slot);
 
 	/* Clear CFGE */
 	cqhci_writel(cq_host, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
@@ -99,7 +100,7 @@ static int cqhci_crypto_keyslot_program(struct blk_crypto_profile *profile,
 		memcpy(cfg.crypto_key, key->raw, key->size);
 	}
 
-	err = cqhci_crypto_program_key(cq_host, &cfg, slot);
+	err = cqhci_crypto_program_key(cq_host, key, &cfg, slot);
 
 	memzero_explicit(&cfg, sizeof(cfg));
 	return err;
@@ -113,7 +114,7 @@ static int cqhci_crypto_clear_keyslot(struct cqhci_host *cq_host, int slot)
 	 */
 	union cqhci_crypto_cfg_entry cfg = {};
 
-	return cqhci_crypto_program_key(cq_host, &cfg, slot);
+	return cqhci_crypto_program_key(cq_host, NULL, &cfg, slot);
 }
 
 static int cqhci_crypto_keyslot_evict(struct blk_crypto_profile *profile,
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 1a12e40a02e6..949ebbe05773 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/wait.h>
 #include <linux/irqreturn.h>
+#include <linux/blk-crypto.h>
 #include <asm/io.h>
 
 /* registers */
@@ -291,6 +292,7 @@ struct cqhci_host_ops {
 	void (*post_disable)(struct mmc_host *mmc);
 #ifdef CONFIG_MMC_CRYPTO
 	int (*program_key)(struct cqhci_host *cq_host,
+			   const struct blk_crypto_key *bkey,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
 #endif
 };
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 668e0aceeeba..529ea9f4fa07 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1859,6 +1859,7 @@ static __maybe_unused int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
  * vendor-specific SCM calls for this; it doesn't support the standard way.
  */
 static int sdhci_msm_program_key(struct cqhci_host *cq_host,
+				 const struct blk_crypto_key *bkey,
 				 const union cqhci_crypto_cfg_entry *cfg,
 				 int slot)
 {
@@ -1866,6 +1867,7 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	union cqhci_crypto_cap_entry cap;
+	u8 ice_key_size;
 
 	/* Only AES-256-XTS has been tested so far. */
 	cap = cq_host->crypto_cap_array[cfg->crypto_cap_idx];
@@ -1873,11 +1875,11 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
 		cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256)
 		return -EINVAL;
 
+	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
 	if (cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE)
 		return qcom_ice_program_key(msm_host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
-					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
-					    cfg->crypto_key,
+					    ice_key_size, bkey,
 					    cfg->data_unit_size, slot);
 	else
 		return qcom_ice_evict_key(msm_host->ice, slot);
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index fbab7fe5c652..6f941d32fffb 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -163,8 +163,8 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
-			 const u8 crypto_key[], u8 data_unit_size,
-			 int slot)
+			 const struct blk_crypto_key *bkey,
+			 u8 data_unit_size, int slot)
 {
 	struct device *dev = ice->dev;
 	union {
@@ -183,7 +183,7 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 		return -EINVAL;
 	}
 
-	memcpy(key.bytes, crypto_key, AES_256_XTS_KEY_SIZE);
+	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
 
 	/* The SCM call requires that the key words are encoded in big endian */
 	for (i = 0; i < ARRAY_SIZE(key.words); i++)
diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index f4cc54d82281..34537cbac622 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -18,6 +18,7 @@ static const struct ufs_crypto_alg_entry {
 };
 
 static int ufshcd_program_key(struct ufs_hba *hba,
+			      const struct blk_crypto_key *bkey,
 			      const union ufs_crypto_cfg_entry *cfg, int slot)
 {
 	int i;
@@ -27,7 +28,7 @@ static int ufshcd_program_key(struct ufs_hba *hba,
 	ufshcd_hold(hba);
 
 	if (hba->vops && hba->vops->program_key) {
-		err = hba->vops->program_key(hba, cfg, slot);
+		err = hba->vops->program_key(hba, bkey, cfg, slot);
 		goto out;
 	}
 
@@ -89,7 +90,7 @@ static int ufshcd_crypto_keyslot_program(struct blk_crypto_profile *profile,
 		memcpy(cfg.crypto_key, key->raw, key->size);
 	}
 
-	err = ufshcd_program_key(hba, &cfg, slot);
+	err = ufshcd_program_key(hba, key, &cfg, slot);
 
 	memzero_explicit(&cfg, sizeof(cfg));
 	return err;
@@ -103,7 +104,7 @@ static int ufshcd_clear_keyslot(struct ufs_hba *hba, int slot)
 	 */
 	union ufs_crypto_cfg_entry cfg = {};
 
-	return ufshcd_program_key(hba, &cfg, slot);
+	return ufshcd_program_key(hba, NULL, &cfg, slot);
 }
 
 static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa..acf352594362 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -144,6 +144,7 @@ static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
 }
 
 static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
+				    const struct blk_crypto_key *bkey,
 				    const union ufs_crypto_cfg_entry *cfg,
 				    int slot)
 {
@@ -151,6 +152,7 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	union ufs_crypto_cap_entry cap;
 	bool config_enable =
 		cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE;
+	u8 ice_key_size;
 
 	/* Only AES-256-XTS has been tested so far. */
 	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
@@ -158,11 +160,11 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
 		return -EOPNOTSUPP;
 
+	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
 	if (config_enable)
 		return qcom_ice_program_key(host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
-					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
-					    cfg->crypto_key,
+					    ice_key_size, bkey,
 					    cfg->data_unit_size, slot);
 	else
 		return qcom_ice_evict_key(host->ice, slot);
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 5870a94599a2..9dd835dba2a7 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -7,6 +7,7 @@
 #define __QCOM_ICE_H__
 
 #include <linux/types.h>
+#include <linux/blk-crypto.h>
 
 struct qcom_ice;
 
@@ -30,8 +31,8 @@ int qcom_ice_resume(struct qcom_ice *ice);
 int qcom_ice_suspend(struct qcom_ice *ice);
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
-			 const u8 crypto_key[], u8 data_unit_size,
-			 int slot);
+			 const struct blk_crypto_key *bkey,
+			 u8 data_unit_size, int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index cb2afcebbdf5..582d5a747e84 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -363,6 +363,7 @@ struct ufs_hba_variant_ops {
 				struct devfreq_dev_profile *profile,
 				struct devfreq_simple_ondemand_data *data);
 	int	(*program_key)(struct ufs_hba *hba,
+			       const struct blk_crypto_key *bkey,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
-- 
2.43.0


