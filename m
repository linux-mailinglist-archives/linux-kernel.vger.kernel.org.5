Return-Path: <linux-kernel+bounces-20521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020D828017
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A926284F13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E403125A1;
	Tue,  9 Jan 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARGuJp1y"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9422063
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so2315525b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704787794; x=1705392594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BTtnGyw1QeZICEXzNWj/b3uZp4Ky6rxO+ouhWgqdio=;
        b=ARGuJp1yr2WRY/2avNDJ94eF1kyXOMlHE9o0Kswd2CUq8/+mbhLRjSYKSv30UpjDfO
         8R6/ySIz+UOYP9/TjKGD0fRx1+K8NN2tGf1h037HW+iY5YwGead4XlyXpiCUN0uqr/C7
         AgKdwvFf6vZOHcHkZ31I+4nYENGCGb9lZM4w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704787794; x=1705392594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BTtnGyw1QeZICEXzNWj/b3uZp4Ky6rxO+ouhWgqdio=;
        b=WmeLphrQ4/RTOMfr+LywAoFm1deVu/HF/3U4bA6tknE6m4AcVJj81hl9+LN4bZCYfO
         sxN/642jmFnVKWrmxvCAygyZnI1H4RJKgHkRH8eDXPDxIiGwkaS17r2BhvbUFIuN4B3w
         FYQQf+g+qWdu4qJiaB4QiyntffSooOVYB/3s8NYDXy58iK9+0HJE3OLHsXgWUxyR2Xo8
         5OqgihUwO1Lw4TLBFAat0lSs0QCbYISkMIxy+gEBNjKGfSCaXRJOQCVU86ZKRQbel1ys
         ybYpz+4/KeHo0hRuVTkKI74ivHUVD9eC9uG1Mozup2Xg3yDAQgyeYv5sADi1J0E1UrXE
         ZTTQ==
X-Gm-Message-State: AOJu0YyMsqKYvS4YV4NFq7sKr4HmOZydEnPtatd6ydqANOYKkPey7cUx
	8UKVli9MYg3WsC3g+5T4eTPIDxIFqjae
X-Google-Smtp-Source: AGHT+IFmkVNBkgtp8ul2fu9yxEhoX7/JSX9fBb/VBWL3OB6woWAa7wzZyq3DfGOV+wd/NLYCkT9E0w==
X-Received: by 2002:a05:6a20:918a:b0:199:f43d:6cde with SMTP id v10-20020a056a20918a00b00199f43d6cdemr513287pzd.67.1704787793820;
        Tue, 09 Jan 2024 00:09:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:7b29:709a:867f:fec5])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b006d9a6953f08sm1072963pfh.103.2024.01.09.00.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:09:53 -0800 (PST)
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yong Zhi <yong.zhi@intel.com>
Cc: Hidenori Kobayashi <hidenorik@chromium.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: staging: ipu3-imgu: Set fields before media_entity_pads_init()
Date: Tue,  9 Jan 2024 17:09:09 +0900
Message-ID: <20240109080910.2859780-1-hidenorik@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imgu driver fails to probe with the following message because it
does not set the pad's flags before calling media_entity_pads_init().

[   14.596315] ipu3-imgu 0000:00:05.0: failed initialize subdev media entity (-22)
[   14.596322] ipu3-imgu 0000:00:05.0: failed to register subdev0 ret (-22)
[   14.596327] ipu3-imgu 0000:00:05.0: failed to register pipes (-22)
[   14.596331] ipu3-imgu 0000:00:05.0: failed to create V4L2 devices (-22)

Fix the initialization order so that the driver probe succeeds. The ops
initialization is also moved together for readability.

Fixes: a0ca1627b450 ("media: staging/intel-ipu3: Add v4l2 driver based on media framework")
Cc: <stable@vger.kernel.org> # 6.7
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
---
Changes in v3:
- Add error output to commit message (Thanks again Dan!)
- Link to v2: https://lore.kernel.org/lkml/20240109041500.2790754-1-hidenorik@chromium.org

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


