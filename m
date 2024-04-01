Return-Path: <linux-kernel+bounces-127145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742F89476C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2BB1F22679
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C4557305;
	Mon,  1 Apr 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpq6YpyV"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB155644E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011422; cv=none; b=E7GvnRIB4iKZ27klA8GYY7RI6Maoa5sn1n7iA/X0FiYLe1haY1droh3pmaYMo2il1fM8lcvD5jY6/HmAli5FKN7kbrxXsxeBpohzxl2TrtNqXkeNsjoQSydpXe/XlHfIq0nRnkxFT2k35zMhQEOlDkfn8pMrzwSf4Zbo/9hgfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011422; c=relaxed/simple;
	bh=jBpaN/YpdE0GgaxsMc4l47/AyQPX9iCV5Yg0+fXm+YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBRdZ+7PGi6jgmG6FJ8IEPpSR0UF8Sh7PKiEJ0JtPBnRLbnQ2XxLTUgrDNpFFaPIAwk+wE1UTWU37I3ZbLuX7aL8QslfLAWYn/6w/qavUBsIqGX5RU0vF3xZCE8kmulU+aU41obvPodEga6ngRR8kdWPvh+SJGRC8c9eIT7paN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpq6YpyV; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513dc9d6938so5475089e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712011419; x=1712616219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1HRSs16ZaqWirPKX2Q82tz4rJe4xnCWFUzWP+U9GaI=;
        b=hpq6YpyVV9sIW3gson3PUTFTrM4962pzTGFmUHAzBEtdH6OYrTj7c4EGsyAP24Y7sn
         19pkr7O4gGWN0eiJ0UD2P8pt6CsxV7LFLT3IZdmHQMBUG9NJPcCmY4M2jvXnlH3MJ/xU
         16Ehfa7xaRcj6lTnJ1u8g2C2Aa+VKAoWr/0k6OKm8ayzISDzTipPaIN0KTuhtYl0Wt74
         RT9EB9mRzrCQS9fIaougR3HcQYSWGspKOGgyl3Hh94UzaYeu+Xv+KwA5M+39LNmdBeEW
         fNcd7PuYFuN2P2oXw33Dwlg6YNBID2OIpD955xFcbdsuQs9JENRwvgxVLP7IQqnB21GM
         Zddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712011419; x=1712616219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1HRSs16ZaqWirPKX2Q82tz4rJe4xnCWFUzWP+U9GaI=;
        b=lGZYnMTarE7TDtJY8q7PWTAI0smyUPgVzZzpsAorLgr1P3Uz85bCTsnv/rvypd//XW
         46o3t3ssazs2U1zGpHkJMZmELU4WHeJXOhB0esII1ciB0j20q2lRyAC/Ik8JUjjO8hky
         Nn7loEG3/8y47PBWrNyI/XDTcnlIvAehUAajvYti5JU4FsqjqYjpF1/rYnk8yuLfiUde
         Oa5HIRLpzayEc4Bx9nCVW96cx+WmupbW+k6i5IgHUTppqtoi3SqwsX4b43BggeaikZ87
         euOuT0yvUFVydR2EnRBx1TZ6hx7gNLxrlgLrpyqjuXPEMQtvQ2dFyENEvyirWATFNhWu
         yjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkeBh6QAI+cNFSqtH727g+VBh/LN8KT6VRJ/IvzPOYQkb6agfYVSKjxSNy1f/Sz3RHgJuHzUsnWziXj8dGKkmhGu6KqX5xUU9gCp01
X-Gm-Message-State: AOJu0YwwpV4nivx6mUvtriXuaIfmUZL7LlrLYh4xb3jDU6ARk2xWRY8o
	Up5fIVi++5iEndc+Ud60Uu+i0lN4H0iRiPRJqVSYA7hT3Jc3LAec
X-Google-Smtp-Source: AGHT+IF5AAFDiHU2c7BlOH2GKKUyK+ACmqIyuoBaH5uCfBfF8+qL4PRYFYq9gmLKpIuJjrRfZZOWXA==
X-Received: by 2002:a05:6512:3191:b0:513:d524:3790 with SMTP id i17-20020a056512319100b00513d5243790mr8255946lfe.43.1712011419012;
        Mon, 01 Apr 2024 15:43:39 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b00a4739efd7cesm5796808ejb.60.2024.04.01.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 15:43:38 -0700 (PDT)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 2/2] drm/lima: fix void pointer to enum lima_gpu_id cast warning
Date: Tue,  2 Apr 2024 00:43:29 +0200
Message-ID: <20240401224329.1228468-3-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401224329.1228468-1-nunes.erico@gmail.com>
References: <20240401224329.1228468-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a simple data struct to hold compatible data so that we don't
have to do the casts to void pointer to hold data.
Fixes the following warning:
  drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller integer
  type 'enum lima_gpu_id' from 'const void *'

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_drv.c | 21 ++++++++++++++++++---
 drivers/gpu/drm/lima/lima_drv.h |  5 +++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 10fd9154cc46..739c865b556f 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -371,6 +371,7 @@ static int lima_pdev_probe(struct platform_device *pdev)
 {
 	struct lima_device *ldev;
 	struct drm_device *ddev;
+	const struct lima_compatible *comp;
 	int err;
 
 	err = lima_sched_slab_init();
@@ -384,7 +385,13 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	}
 
 	ldev->dev = &pdev->dev;
-	ldev->id = (enum lima_gpu_id)of_device_get_match_data(&pdev->dev);
+	comp = of_device_get_match_data(&pdev->dev);
+	if (!comp) {
+		err = -ENODEV;
+		goto err_out0;
+	}
+
+	ldev->id = comp->id;
 
 	platform_set_drvdata(pdev, ldev);
 
@@ -459,9 +466,17 @@ static void lima_pdev_remove(struct platform_device *pdev)
 	lima_sched_slab_fini();
 }
 
+static const struct lima_compatible lima_mali400_data = {
+	.id = lima_gpu_mali400,
+};
+
+static const struct lima_compatible lima_mali450_data = {
+	.id = lima_gpu_mali450,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "arm,mali-400", .data = (void *)lima_gpu_mali400 },
-	{ .compatible = "arm,mali-450", .data = (void *)lima_gpu_mali450 },
+	{ .compatible = "arm,mali-400", .data = &lima_mali400_data },
+	{ .compatible = "arm,mali-450", .data = &lima_mali450_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
index c738d288547b..6706c19b166e 100644
--- a/drivers/gpu/drm/lima/lima_drv.h
+++ b/drivers/gpu/drm/lima/lima_drv.h
@@ -7,6 +7,7 @@
 #include <drm/drm_file.h>
 
 #include "lima_ctx.h"
+#include "lima_device.h"
 
 extern int lima_sched_timeout_ms;
 extern uint lima_heap_init_nr_pages;
@@ -39,6 +40,10 @@ struct lima_submit {
 	struct lima_sched_task *task;
 };
 
+struct lima_compatible {
+	enum lima_gpu_id id;
+};
+
 static inline struct lima_drm_priv *
 to_lima_drm_priv(struct drm_file *file)
 {
-- 
2.44.0


