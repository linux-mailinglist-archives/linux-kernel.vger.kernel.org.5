Return-Path: <linux-kernel+bounces-87114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF9586CFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E00285339
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3A7A15F;
	Thu, 29 Feb 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eap9U6Ww"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA03771E;
	Thu, 29 Feb 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225641; cv=none; b=Fl5tO5l/CmDtQLc5cJdD+T4v6QE31jwxgd4JFB4paxs5ImJx1aMKpD4eUP79JMFz4j5f9Oh6BuT+MgA/UwTn9gpqg3+R4ht20AA4A0qz6OsHudQR/eezhNnzm77RIdJjo9XaPjQVI98YMJf+HTQvezbxo76z8U1yGhh9hTSbIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225641; c=relaxed/simple;
	bh=jODaE8bNQdgWYIBa/UL+z1/OzlLcc4wPCUOxYS1KWz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO3p5t+Kiq/kvwYZLGhLFCbeLuJpLvIepjx9Jd9NkhfItN4KG4AxUDDVXJcuuG/NQ651r1LVyr1LwNhiFcjiTE07Aqzo5W9ZFxJmMnRRWg033snA75Ro6kXE9fODV7fmzRl5iM0nJkxoDy+I/IVvltj9PeuaMk2xINtg5+5VWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eap9U6Ww; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512bd533be0so1387572e87.0;
        Thu, 29 Feb 2024 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225638; x=1709830438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuxhRi+cO3aYPKrc+1v3iUal/8f5kBZLAU/GOUax1jA=;
        b=Eap9U6WwEtfTtrdZXqE1zzDVy2Ea8Y2Mjasv4IpvEWRrEdyX0e6TTDsqwY9SAqHi1w
         GMJP4zko6vmQEjjfR0yHFZw46UnVOJM+xow3kdyiASb+Vx1O7qbTdSIUujoaVqawuYX7
         kgXfaI8Wm9JeGEitbZYNUOc5BTJqiB7BI3esxlMdkw/1O5lBFYZS0eH2ZR8J//Jbp2KN
         BlSfVVBQznq/N5CIMRjljVAEbaU7vgYP9hwpGtT/QuckgVCwTNsNwghihnTB+8VJIytA
         NJLcuIDxnC0s2l2fX6f/VJC0lOHz7Vh+fXcQYSW8V8rzJZ3AB53L02Q6WCcvnDHgUhqF
         4ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225638; x=1709830438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuxhRi+cO3aYPKrc+1v3iUal/8f5kBZLAU/GOUax1jA=;
        b=XNdBz5yb1df6ry889b1so2tJa9LedkTaX0Cxy1bbdwhz9EaAEkFRH0DsoNaJfvHMEE
         8xEse78qOpznwN3cTue3I7ThQl3g+qjryAom8HFPMlo2YRmjRJx9iXzYVmhcGTwDoDTe
         WiyTB3o9n5jmEo9m4bS/ynOjoi0JfYGq7JTrvmybEje18FUNXKZFjiNcw92Vdu8hxr1x
         Pd3lVMcUpM99flWE5TGaqGG7bDKk3yT9OJDFJv9v5t0v/L49ycCSxKViWGb2QawsfZls
         Yyfw5t72zfeCHe6kz/hKkDn8daX5DquUyJ3Un3XYOUz5hMlw7fUQDg6Ct7/QLs990kTi
         mWfA==
X-Forwarded-Encrypted: i=1; AJvYcCUCcbEhxyX7J9eKrb1U/gHvw5dhgUiJDuOsuciWFiKuNbe++rHOBIezV0JPqCd5M3uFbeOh14BJ+Vs0zTmu7T1pqX6NqnryzCZzyM5f
X-Gm-Message-State: AOJu0Yw7SDwhI8Hx2OLVgpiA4ZlbAQfaHi8+fC+dlX3ePWR1qpDQi6+C
	oCCXY/e0Ul7Lc13zZvVIt9pe62kSM18Pz9wJGhXifMSaaY940T7yN9RBsLhiPvo=
X-Google-Smtp-Source: AGHT+IEajL316uZt/nReFBqnf9MjdphugjxgOK1hbnddLQgsVsJURWAfsXM8z17ZQ5TvMYp5E79ZlQ==
X-Received: by 2002:ac2:446b:0:b0:513:1cde:a1a1 with SMTP id y11-20020ac2446b000000b005131cdea1a1mr1779619lfl.38.1709225637648;
        Thu, 29 Feb 2024 08:53:57 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id h18-20020ac24db2000000b00513142744d4sm304250lfe.191.2024.02.29.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:57 -0800 (PST)
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
Subject: [PATCH v3 08/20] media: i2c: ov4689: Enable runtime PM before registering sub-device
Date: Thu, 29 Feb 2024 19:53:21 +0300
Message-ID: <20240229165333.227484-9-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
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
2.43.0


