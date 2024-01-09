Return-Path: <linux-kernel+bounces-20371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2E827DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE02B22ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B87497;
	Tue,  9 Jan 2024 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ksbCsVGY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5613AE3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3ed1ca402so22340875ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 20:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704773726; x=1705378526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnmP9HCW0xFGvAZ+PSrTWWszc0HwZwOSM+5mszcUNAM=;
        b=ksbCsVGYZ5Djhduu9K5DQ5WbC00hIJo1XMogbR+xXh1mcPIxS6tcrz00O3nNDdvbcq
         eUeV6SlLxE8pYFv/4iZPc9ddJnSVluZUqplKqowGHwtfdyBpcP81GdtSj4V2xMDpMsIJ
         S7+hni+qABt8d0hSx5G9M5FKDq40rqM8b4FRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704773726; x=1705378526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnmP9HCW0xFGvAZ+PSrTWWszc0HwZwOSM+5mszcUNAM=;
        b=AOuS6X/kFYjtOgMzYetYhy3zFRMr8LjDVhRZ6KQmLZfFTwfgNE8QBHIhsEHVz/2MbQ
         ES7EMcA85qkIZHA5gOWYD8bxh1LMqOZTDV7TM29gAFiSUcsC4/H2Q6tBQ1fPKvJnpZC8
         vQSaiMr5hMDatDOWuDp81NFyOQbs7YiTpKz7djXIVdIU4pRKZ3YjSNjfe9Dm59Xmnmgf
         mL0pkYB/LH45tqXcGcL88SxIvB+rkGqudXmTOjq9LwJJ+dXkdmPs7dXHJA7wvXoH/9g9
         EjWqqCTukDSEENhtv+/UMR+0XIX4Hsjp9sGEAuQo4SdkeiyCVwyGG3GF8LTxZSWIid4u
         iHEw==
X-Gm-Message-State: AOJu0YxKEAVcGGwPRrHa0jS37umwwDeKa+eOF++uL/q0PzeIg4677dWo
	2hDvi/5zgjnPKFGm2rBg0AFwW+Vo/8Yk
X-Google-Smtp-Source: AGHT+IF3uJr4ZPBFgHi2TnCaHhnHGSyb45pHnnaiRhbevj48cA0aVAd55nYw45YSBxFM48EXSUaCAQ==
X-Received: by 2002:a17:902:7d88:b0:1d0:737d:2ae5 with SMTP id a8-20020a1709027d8800b001d0737d2ae5mr4724686plm.87.1704773725815;
        Mon, 08 Jan 2024 20:15:25 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:7b29:709a:867f:fec5])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001d3dff2575fsm676499plq.52.2024.01.08.20.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 20:15:25 -0800 (PST)
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yong Zhi <yong.zhi@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Hidenori Kobayashi <hidenorik@chromium.org>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: staging: ipu3-imgu: Set fields before media_entity_pads_init()
Date: Tue,  9 Jan 2024 13:14:59 +0900
Message-ID: <20240109041500.2790754-1-hidenorik@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imgu driver fails to probe because it does not set the pad's flags
before calling media_entity_pads_init(). Fix the initialization order so
that the driver probe succeeds. The ops initialization is also moved
together for readability.

Fixes: a0ca1627b450 ("media: staging/intel-ipu3: Add v4l2 driver based on media framework")
Cc: <stable@vger.kernel.org> # 6.7
Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
---
Changes in v2:
- Add Fixes tag and revise commit message (Thanks Dan!)
- Link to v1: https://lore.kernel.org/lkml/20231228093926.748001-1-hidenorik@chromium.org
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index a66f034380c0..3df58eb3e882 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1069,6 +1069,11 @@ static int imgu_v4l2_subdev_register(struct imgu_device *imgu,
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
 
 	/* Initialize subdev media entity */
+	imgu_sd->subdev.entity.ops = &imgu_media_ops;
+	for (i = 0; i < IMGU_NODE_NUM; i++) {
+		imgu_sd->subdev_pads[i].flags = imgu_pipe->nodes[i].output ?
+			MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
+	}
 	r = media_entity_pads_init(&imgu_sd->subdev.entity, IMGU_NODE_NUM,
 				   imgu_sd->subdev_pads);
 	if (r) {
@@ -1076,11 +1081,6 @@ static int imgu_v4l2_subdev_register(struct imgu_device *imgu,
 			"failed initialize subdev media entity (%d)\n", r);
 		return r;
 	}
-	imgu_sd->subdev.entity.ops = &imgu_media_ops;
-	for (i = 0; i < IMGU_NODE_NUM; i++) {
-		imgu_sd->subdev_pads[i].flags = imgu_pipe->nodes[i].output ?
-			MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
-	}
 
 	/* Initialize subdev */
 	v4l2_subdev_init(&imgu_sd->subdev, &imgu_subdev_ops);
@@ -1177,15 +1177,15 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 	}
 
 	/* Initialize media entities */
+	node->vdev_pad.flags = node->output ?
+		MEDIA_PAD_FL_SOURCE : MEDIA_PAD_FL_SINK;
+	vdev->entity.ops = NULL;
 	r = media_entity_pads_init(&vdev->entity, 1, &node->vdev_pad);
 	if (r) {
 		dev_err(dev, "failed initialize media entity (%d)\n", r);
 		mutex_destroy(&node->lock);
 		return r;
 	}
-	node->vdev_pad.flags = node->output ?
-		MEDIA_PAD_FL_SOURCE : MEDIA_PAD_FL_SINK;
-	vdev->entity.ops = NULL;
 
 	/* Initialize vbq */
 	vbq->type = node->vdev_fmt.type;
-- 
2.43.0.472.g3155946c3a-goog


