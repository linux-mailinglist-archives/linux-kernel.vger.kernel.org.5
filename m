Return-Path: <linux-kernel+bounces-128374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20711895A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10CB1F26F18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E6515B12A;
	Tue,  2 Apr 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aafQCBHQ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8615B10A;
	Tue,  2 Apr 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076387; cv=none; b=hxnOaysxPt24+uGkewwztagnFJQ5NSspfii/KNlc77GIFdrys0duFsrDyu2CONsIFSPXcljJYKKvkb2044Zr7ltIcVZokMAy5lg46jNp7A5IK5ay28DwYSnunoCQRX5DfTMq23M1tuY08oq6AupE4y0Vchd22zLmRsh+5mAZjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076387; c=relaxed/simple;
	bh=syKC/lmNqu+Wo7UMZrahrtjFMH+UOJOs9yLduQt5TTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp4TaYtCp2LlyWzKyJSWHTIz2WhtQ/BUQlBUTpjysxe3orTgLfctHEJE90q+r7ar6YQHtMCAUujf+tOIT1uhFE7Zab7Q+7WNHQAg9X3sUjdzJNnE5LfMnm39Y3Zfjyb8uP0peIyFRwmbLNq36iHnjMVcKkRMLpksAi5ihBOZO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aafQCBHQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516afb04ec7so1931336e87.2;
        Tue, 02 Apr 2024 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076382; x=1712681182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8eAyIV1AX0Cdyf1zBdPe9cbHcBl+4k6LrmpiHySYds=;
        b=aafQCBHQHlQfkxuurw5acepnaNZsrVVsCteTPCqHcdUhb1pTADX5o788SLPCOXsF9M
         sIxuJZV1e7BmH4qD/00LVsZIGmwajm9FVHSFQwQ1pgWyzfpcluV7C+iEUO4bkQ43H5bg
         h4V6ty6PUpPE7SJu9iqvE2mzGPsygQJmLFANo/areAkZy/RHo1Na94mW9O9rPxgJUdzL
         VHILQJhsaK2Q0q+EO4Enwr0gi/BIu+lFX6j2kgOyAc/Jid4CMGtIFUKde7TsmH7KuXf7
         nvs9v77VduInH7lwHtaU6giteuSDtq2hBp7bIu7YV1phZrDMGSgsNxwpMzcRKdYCWNrc
         Tzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076382; x=1712681182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8eAyIV1AX0Cdyf1zBdPe9cbHcBl+4k6LrmpiHySYds=;
        b=JsdSPDrSrxOi31Hi9kATrNMj2Et+Y0uxBUFMM74xiUwwBZ05ilmg4l3BUYotzv693o
         yeShC3LMmPRdgzpLNXioNvXe8uAUHScXtp9O5t7Tjuu2NxAyc8xtnIRSrsVGvSxJnLBm
         9YnZyDT4wUD+jDB3M0h0exURpBQ0P3ygX+Vm+Jvxob5jT5H8cgY1QnRj8WoDN6lqkSda
         AC+rT78VznDjcsCBUFRGO1nBmbEwLRltZjDgaVec1D5HJx3rUOf3e42rjnGwSCjQgUZ2
         BuzoDEoP99RatwDKFzCkwOvNXDmNs2/2q3L7PIjOk8LWmMzGS96mYOXwmygg9ZFbZPQh
         S0+w==
X-Forwarded-Encrypted: i=1; AJvYcCWsMjUsOcZuo/yIy+ygAV29bXZaKJZ/fXpWbgizDSQre9k7148VdM11iQ6Bok0NXISjpcJkt502jCkh1GkBB61mn1g6ptOe8yMVMM9r
X-Gm-Message-State: AOJu0YzsZi+VGUSBpdjXdVFJdxbBSDfvRZr8jV+Fg/caaXOYk+jVf34N
	eDiyjlfqoobabRnWxdkOaaXRT5esE4XAqo1rAk4w6ZFDUok9okHVQXfjPl2G9NKF7w==
X-Google-Smtp-Source: AGHT+IE7bkoodyNXSz6+EqFKVdQ+OxmFH8pZEeS6dQIKa8N1+77+giivymAbrLvQGhQra3004839rQ==
X-Received: by 2002:a05:6512:3f1c:b0:513:c9a6:46ce with SMTP id y28-20020a0565123f1c00b00513c9a646cemr11683731lfa.9.1712076382475;
        Tue, 02 Apr 2024 09:46:22 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id q18-20020ac25292000000b00513cdfff70fsm643674lfm.45.2024.04.02.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:22 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 08/20] media: i2c: ov4689: Enable runtime PM before registering sub-device
Date: Tue,  2 Apr 2024 19:45:39 +0300
Message-ID: <20240402164552.19171-9-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the sensor may be accessible right after its async sub-device is
registered, enable runtime PM before doing so.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 47feb6b5ede8..0e0e694510aa 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -875,19 +875,21 @@ static int ov4689_probe(struct i2c_client *client)
 		goto err_clean_entity;
 	}
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
 		dev_err(dev, "v4l2 async register subdev failed\n");
-		goto err_clean_subdev;
+		goto err_clean_subdev_pm;
 	}
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
-
 	return 0;
 
-err_clean_subdev:
+err_clean_subdev_pm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 	v4l2_subdev_cleanup(sd);
 err_clean_entity:
 	media_entity_cleanup(&sd->entity);
-- 
2.44.0


