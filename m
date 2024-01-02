Return-Path: <linux-kernel+bounces-13981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5701821675
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C472B21393
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE214C7C;
	Tue,  2 Jan 2024 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lmpQ2aUR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FA468C;
	Tue,  2 Jan 2024 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4022NrNt006991;
	Tue, 2 Jan 2024 02:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=LJOUtUc
	TF/R4WfEckhIyQSw22FUju7HZ22zDBTo2u28=; b=lmpQ2aUR7Q+eSqSYFqfzwQQ
	5gPo4SMyRvZG6VOKWlhU9/rsTEedVZ/3g3CLtweHP6ULdHj0fYtLnBep4Yb1Yksb
	/rWEXm2FFWrA586V1zOUwia+UlrCXPQvw6MuBCIYNAxBz70UAp2w9tl23KqND9d8
	8LQHVnbUY39plKsP9HaTf+Z/xqufNVOJeXBAQVQspU797NESl/lU9SDKMdVOf2ec
	mnaTsRsWjK+3pocZr0pA7FlYHzOJZ19Sqtk9TEgtKIxl+JgUjeNiUYHH3p5EF95E
	2SRBWp67IV94ri7AUai+YvD5yAyEFiyCBIoPrNKzvp6nRyWVQtKEcNl3bl7oevA=
	=
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vabkbbv6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 02:25:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4022PQEB004756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 02:25:26 GMT
Received: from hu-taozhan-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 18:25:21 -0800
From: Tao Zhang <quic_taozhan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
Subject: [PATCH] qcom: smem: remove hwspinlock from item get routine
Date: Tue, 2 Jan 2024 07:55:12 +0530
Message-ID: <20240102022512.999635-1-quic_taozhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TmWLeD2LZ-zk7hICnCegMN8T8WHfXKhv
X-Proofpoint-GUID: TmWLeD2LZ-zk7hICnCegMN8T8WHfXKhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401020017

During an SSR(Sub-System Restart) process, the remoteproc driver will
try to read the crash reason from SMEM. The qcom_smem_get() backing such
operations does however take the hwspinlock (tcsr mutex), which might be
held by the dying remoteproc.

The associated timeout on the hwspin_lock_timeout_irqsave() would take
care of the system not hanging forever, but the get operation will fail,
unnecessarily delaying the process for the 'HWSPINLOCK_TIMEOUT' duration
(currently is '1s'), and finally resulting in failure to get crash
information from SMEM.

This timeout can be avoided by removing the hwspinlock in the
qcom_smem_get routine. SMEM ensures that the allocated item will only be
visible after the new item is safe to use by following a specific order
of updates.

In the private partition case, qcom_smem_get_private() will use
'offset_free_uncached' as a loop boundary when looking for existing
allocated items. The corresponding allocation will only update
offset_free_uncached once the item is fully initialized.

    hdr->canary = SMEM_PRIVATE_CANARY;
    hdr->item = cpu_to_le16(item);
    hdr->size = cpu_to_le32(ALIGN(size, 8));
    hdr->padding_data = cpu_to_le16(le32_to_cpu(hdr->size) - size);
    hdr->padding_hdr = 0;

    wmb();
    le32_add_cpu(&phdr->offset_free_uncached, alloc_size);

The global partition is similar but uses the "entry->allocated" variable
to ensure the item is not visible to qcom_smem_get_global().

Signed-off-by: Tao Zhang <quic_taozhan@quicinc.com>
---
 drivers/soc/qcom/smem.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 690afc9a12f4..7191fa0c087f 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -655,8 +655,6 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 {
 	struct smem_partition *part;
-	unsigned long flags;
-	int ret;
 	void *ptr = ERR_PTR(-EPROBE_DEFER);
 
 	if (!__smem)
@@ -665,12 +663,6 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 	if (WARN_ON(item >= __smem->item_count))
 		return ERR_PTR(-EINVAL);
 
-	ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
-					  HWSPINLOCK_TIMEOUT,
-					  &flags);
-	if (ret)
-		return ERR_PTR(ret);
-
 	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
 		part = &__smem->partitions[host];
 		ptr = qcom_smem_get_private(__smem, part, item, size);
@@ -681,10 +673,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 		ptr = qcom_smem_get_global(__smem, item, size);
 	}
 
-	hwspin_unlock_irqrestore(__smem->hwlock, &flags);
-
 	return ptr;
-
 }
 EXPORT_SYMBOL_GPL(qcom_smem_get);
 

base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
-- 
2.25.1


