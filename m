Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1C79C0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347654AbjIKVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbjIKM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:59:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A261E67;
        Mon, 11 Sep 2023 05:59:47 -0700 (PDT)
X-UUID: 12be2d8250a311eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dIRe74TYCLjaq9wviyrRI/aMg0ZS6PQ9Eb7/EwRV9LQ=;
        b=VARvlywUsVPIaz+AeFb9wQr6BJdmuHLXNi8xuEvOqGQqVO+krCGClyxB6ffdg/OETP2ug4uAOcCUjV443CSaMqn671jdTQAT68vR+o80OqN+CyF/qyZDibtGn8WUeKcMK7d9KhxtZAuLChpB2pBEzDgn5EdLL45lKpC5Q9WeKhY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:165a37fb-a613-48ca-a52c-8bf6143eff5f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:686b90ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 12be2d8250a311eea33bb35ae8d461a2-20230911
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1904092212; Mon, 11 Sep 2023 20:59:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 20:59:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 20:59:39 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
CC:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 02/14] media: mediatek: vcodec: allocate tee share memory
Date:   Mon, 11 Sep 2023 20:59:24 +0800
Message-ID: <20230911125936.10648-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911125936.10648-1-yunfei.dong@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate two share memory for each lat and core hardware used to share
information with optee-os. Msg buffer used to send ipi command and get ack
command with optee-os, data buffer used to store vsi information which
used for hardware decode.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_optee.c     | 79 ++++++++++++++++++-
 .../vcodec/decoder/mtk_vcodec_dec_optee.h     | 32 ++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
index 3ee9039d2a5b..806ca87c8de7 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
@@ -47,12 +47,67 @@ int mtk_vcodec_dec_optee_private_init(struct mtk_vcodec_dec_dev *vcodec_dev)
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dec_optee_private_init);
 
+static void mtk_vcodec_dec_optee_deinit_memref(struct mtk_vdec_optee_ca_info *ca_info,
+					       enum mtk_vdec_optee_data_index data_index)
+{
+	tee_shm_free(ca_info->shm_memref[data_index].msg_shm);
+}
+
+static int mtk_vcodec_dec_optee_init_memref(struct tee_context *tee_vdec_ctx,
+					    struct mtk_vdec_optee_ca_info *ca_info,
+					    enum mtk_vdec_optee_data_index data_index)
+{
+	struct mtk_vdec_optee_shm_memref *shm_memref;
+	int alloc_size = 0, err = 0;
+	u64 shm_param_type = 0;
+	bool copy_buffer;
+
+	if (data_index >= OPTEE_MAX_INDEX) {
+		pr_err(MTK_DBG_VCODEC_STR "tee invalid data_index: %d.\n", data_index);
+		return -EINVAL;
+	} else if (data_index == OPTEE_MSG_INDEX) {
+		shm_param_type = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+		alloc_size = MTK_VDEC_OPTEE_MSG_SIZE;
+		copy_buffer = true;
+	} else {
+		shm_param_type = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+		alloc_size = MTK_VDEC_OPTEE_HW_SIZE;
+		copy_buffer = false;
+	}
+
+	shm_memref = &ca_info->shm_memref[data_index];
+
+	/* Allocate dynamic shared memory with decoder TA */
+	shm_memref->msg_shm_size = alloc_size;
+	shm_memref->param_type = shm_param_type;
+	shm_memref->copy_to_ta = copy_buffer;
+	shm_memref->msg_shm =
+		tee_shm_alloc_kernel_buf(tee_vdec_ctx, shm_memref->msg_shm_size);
+	if (IS_ERR(shm_memref->msg_shm)) {
+		pr_err(MTK_DBG_VCODEC_STR "tee alloc buf fail: data_index:%d.\n", data_index);
+		return -ENOMEM;
+	}
+
+	shm_memref->msg_shm_ca_buf = tee_shm_get_va(shm_memref->msg_shm, 0);
+	if (IS_ERR(shm_memref->msg_shm_ca_buf)) {
+		pr_err(MTK_DBG_VCODEC_STR "tee get shm va fail: data_index:%d.\n", data_index);
+		err = PTR_ERR(shm_memref->msg_shm_ca_buf);
+		goto err_get_msg_va;
+	}
+
+	return err;
+
+err_get_msg_va:
+	tee_shm_free(shm_memref->msg_shm);
+	return err;
+}
+
 static int mtk_vcodec_dec_optee_init_hw_info(struct mtk_vdec_optee_private *optee_private,
 					     enum mtk_vdec_hw_id hardware_index)
 {
 	struct tee_ioctl_open_session_arg session_arg;
 	struct mtk_vdec_optee_ca_info *ca_info;
-	int err = 0, session_func;
+	int err = 0, i = 0, j = 0, session_func;
 
 	/* Open lat and core session with vdec TA. */
 	if (hardware_index == MTK_VDEC_LAT0) {
@@ -81,6 +136,24 @@ static int mtk_vcodec_dec_optee_init_hw_info(struct mtk_vdec_optee_private *opte
 	pr_debug(MTK_DBG_VCODEC_STR "open vdec tee session: hw_id(%d) session_id=%x.\n",
 		 hardware_index, ca_info->vdec_session_id);
 
+	/* Allocate dynamic shared memory with decoder TA */
+	for (; i < OPTEE_MAX_INDEX; i++) {
+		err = mtk_vcodec_dec_optee_init_memref(optee_private->tee_vdec_ctx, ca_info, i);
+		if (err) {
+			pr_err(MTK_DBG_VCODEC_STR "init vdec memref failed: %d.\n", i);
+			goto err_init_memref;
+		}
+	}
+
+	return err;
+err_init_memref:
+	if (i != 0) {
+		for (; j < i; j++)
+			mtk_vcodec_dec_optee_deinit_memref(ca_info, j);
+	}
+
+	tee_client_close_session(optee_private->tee_vdec_ctx, ca_info->vdec_session_id);
+
 	return err;
 }
 
@@ -88,12 +161,16 @@ static void mtk_vcodec_dec_optee_deinit_hw_info(struct mtk_vdec_optee_private *o
 						enum mtk_vdec_hw_id hw_id)
 {
 	struct mtk_vdec_optee_ca_info *ca_info;
+	int i = 0;
 
 	if (hw_id == MTK_VDEC_LAT0)
 		ca_info = &optee_private->lat_ca;
 	else
 		ca_info = &optee_private->core_ca;
 
+	for (; i < OPTEE_MAX_INDEX; i++)
+		mtk_vcodec_dec_optee_deinit_memref(ca_info, i);
+
 	tee_client_close_session(optee_private->tee_vdec_ctx, ca_info->vdec_session_id);
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h
index 8b1dca49331e..79b4ec890655 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h
@@ -18,16 +18,48 @@
 
 #define MTK_OPTEE_MAX_TEE_PARAMS 4
 
+#define MTK_VDEC_OPTEE_MSG_SIZE     128
+#define MTK_VDEC_OPTEE_HW_SIZE      (8 * SZ_1K)
+
+/**
+ * struct mtk_vdec_optee_shm_memref - share memory reference params
+ * @msg_shm:        message shared with TA in TEE.
+ * @msg_shm_ca_buf: ca buffer.
+ *
+ * @msg_shm_size:   share message size.
+ * @param_type:     each tee param types.
+ * @copy_to_ta:     need to copy data from ca to share memory.
+ */
+struct mtk_vdec_optee_shm_memref {
+	struct tee_shm *msg_shm;
+	u8 *msg_shm_ca_buf;
+
+	u32 msg_shm_size;
+	u64 param_type;
+	bool copy_to_ta;
+};
+
 /**
  * struct mtk_vdec_optee_ca_info - ca related param
  * @vdec_session_id:   optee TA session identifier.
  * @hw_id:             hardware index.
  * @vdec_session_func: trusted application function id used specific to the TA.
+ * @shm_memref:        share memory reference params.
  */
 struct mtk_vdec_optee_ca_info {
 	u32 vdec_session_id;
 	enum mtk_vdec_hw_id hw_id;
 	u32 vdec_session_func;
+	struct mtk_vdec_optee_shm_memref shm_memref[MTK_OPTEE_MAX_TEE_PARAMS];
+};
+
+/*
+ * enum mtk_vdec_optee_data_index - used to indentify each share memory informaiton
+ */
+enum mtk_vdec_optee_data_index {
+	OPTEE_MSG_INDEX = 0,
+	OPTEE_DATA_INDEX,
+	OPTEE_MAX_INDEX,
 };
 
 /**
-- 
2.18.0

