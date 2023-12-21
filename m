Return-Path: <linux-kernel+bounces-8114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1BD81B24E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A61C211A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517D4B144;
	Thu, 21 Dec 2023 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMo0qkLf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80374CE11
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d6d48354ccso290522b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703150609; x=1703755409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRGqB+rpK2JtTATUiTfsiyokzdHpJCMrcXkOJidY/3Y=;
        b=jMo0qkLfG7olI5hdqNNW0qUeXBF6d+1PylmgolOoACRMxLiDnURJUzR307WQLREZG5
         Ie+uP5FCeL4q2hPE7L/fpYs7PqRX52UmQKSIsAmANKNJdYh/skpIT/40lufs22LJTZeg
         Uu2r5HvnZ6nks35A+DXGrRJBIX9PmKA2ZDv6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150609; x=1703755409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRGqB+rpK2JtTATUiTfsiyokzdHpJCMrcXkOJidY/3Y=;
        b=KBSrGo1SMWSlmgO4Qzhu/0rzYxkVc1HYNHYx/7TD06vovRd6cRUQrbQFCo/fE9uoUf
         Iyb2Z7TmX9JYmXTYHkd5wt8VSJWcWwvh1GigPT5E7EtzdUM/8z9Tej3fUZtvNQ7ZopBn
         aD69MCS/rxgF1CLGWVSJbMDVMUbTABT7Nf8Of4GGMI+qd5kklZ8m26+b/msCw42zhBGT
         HuiXN/3GdxtNv1gqmD7rxNreU+9onm8WTEHGEv4GTPolscmJM7bIti7nIQiN9H6E1Ayv
         7dI4JJS2pKiaxqwQPB5YZdpi55/1RX2FkryOhcHaPNGm8W+ev0vioTgACwMls9JFuWdy
         XbwA==
X-Gm-Message-State: AOJu0Yxe+Y+Fq6wOunATvxHUe8dTshGGPLF1DKQm2YN4a/65LKCFIdLP
	56wHLDQuFCBw2iZuw3MSjh5yAQ==
X-Google-Smtp-Source: AGHT+IGFWfj7wEYiXCBut673fAaKAyWsuJBDh1gl52c86wCwAWY5yMXd3rwbFvkIALXsD38i5TLGMw==
X-Received: by 2002:a05:6a20:8f1c:b0:190:7b07:b7c9 with SMTP id b28-20020a056a208f1c00b001907b07b7c9mr659230pzk.66.1703150608903;
        Thu, 21 Dec 2023 01:23:28 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:5d8a:fab1:933a:9ae9])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090add8600b00274b035246esm1001915pjv.1.2023.12.21.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:23:28 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 4/4] media: mediatek: vcodec: Only free buffer VA that is not NULL
Date: Thu, 21 Dec 2023 17:17:46 +0800
Message-ID: <20231221092226.1395427-4-fshao@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231221092226.1395427-1-fshao@chromium.org>
References: <20231221092226.1395427-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the MediaTek vcodec driver, while mtk_vcodec_mem_free() is mostly
called only when the buffer to free exists, there are some instances
that didn't do the check and triggered warnings in practice.

We believe those checks were forgotten unintentionally. Add the checks
back to fix the warnings.

Signed-off-by: Fei Shao <fshao@chromium.org>
---
I had discussion with Yunfei, and he also thinks that the developers
just forgot to wrap mtk_vcodec_mem_free() with the checks back then.
We believe it's safe to add those checks.


 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 22 +++++++++++++------
 .../vcodec/encoder/venc/venc_h264_if.c        |  5 +++--
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
index 2b6a5adbc419..b0e2e59f61b5 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
@@ -1023,18 +1023,26 @@ static void vdec_av1_slice_free_working_buffer(struct vdec_av1_slice_instance *i
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(instance->mv); i++)
-		mtk_vcodec_mem_free(ctx, &instance->mv[i]);
+		if (instance->mv[i].va)
+			mtk_vcodec_mem_free(ctx, &instance->mv[i]);
 
 	for (i = 0; i < ARRAY_SIZE(instance->seg); i++)
-		mtk_vcodec_mem_free(ctx, &instance->seg[i]);
+		if (instance->seg[i].va)
+			mtk_vcodec_mem_free(ctx, &instance->seg[i]);
 
 	for (i = 0; i < ARRAY_SIZE(instance->cdf); i++)
-		mtk_vcodec_mem_free(ctx, &instance->cdf[i]);
+		if (instance->cdf[i].va)
+			mtk_vcodec_mem_free(ctx, &instance->cdf[i]);
+
 
-	mtk_vcodec_mem_free(ctx, &instance->tile);
-	mtk_vcodec_mem_free(ctx, &instance->cdf_temp);
-	mtk_vcodec_mem_free(ctx, &instance->cdf_table);
-	mtk_vcodec_mem_free(ctx, &instance->iq_table);
+	if (instance->tile.va)
+		mtk_vcodec_mem_free(ctx, &instance->tile);
+	if (instance->cdf_temp.va)
+		mtk_vcodec_mem_free(ctx, &instance->cdf_temp);
+	if (instance->cdf_table.va)
+		mtk_vcodec_mem_free(ctx, &instance->cdf_table);
+	if (instance->iq_table.va)
+		mtk_vcodec_mem_free(ctx, &instance->iq_table);
 
 	instance->level = AV1_RES_NONE;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
index a68dac72c4e4..f8145998fcaf 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
@@ -301,11 +301,12 @@ static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 	 * other buffers need to be freed by AP.
 	 */
 	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
-		if (i != VENC_H264_VPU_WORK_BUF_SKIP_FRAME)
+		if (i != VENC_H264_VPU_WORK_BUF_SKIP_FRAME && inst->work_bufs[i].va)
 			mtk_vcodec_mem_free(inst->ctx, &inst->work_bufs[i]);
 	}
 
-	mtk_vcodec_mem_free(inst->ctx, &inst->pps_buf);
+	if (inst->pps_buf.va)
+		mtk_vcodec_mem_free(inst->ctx, &inst->pps_buf);
 }
 
 static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
-- 
2.43.0.472.g3155946c3a-goog


