Return-Path: <linux-kernel+bounces-76318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F4685F595
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EA4285E29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBD3B18C;
	Thu, 22 Feb 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="REdHaxQY"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1239FDB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597526; cv=none; b=e+MNu0JpfNcnB0X7YbNrVKCYE4FvvI1lQt40wzxzbOzgMAzau1n//6/edNXsPCwfOAGStIAZlwavqCuFdFqBUF03on9P85cLVJ2rR0sDVNlz1FFSXWBMY22X7RgEnttfL8K1Ga4CTqNYuKx3D1SWyWhbUxFU0TUs+AEvVb5vl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597526; c=relaxed/simple;
	bh=KJJPX0IkT/cG2OddkyPCOKcbTRd6TfGmDrRJ3DGkUeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aP3XfsSHXzLo1Vy7XfcIvLhW3dU7Y2QuPmDcNFmkTyiWccc6jaiiOfA/gUnWpOCA1b1hDz8WRKc4g8uM5d9EoSnC5cg+GvPZaCHr4xW4NpvFmaCVvNTwLafYERIeIeprjXoJoinnGKgWltHHNf6TfczsUJSwrYdpWVcckL2QeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=REdHaxQY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410e820a4feso3910905e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708597523; x=1709202323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyffHNsivj82P1pv+S3iGiZ7yfsGQjKP2uvBVMCZ2j8=;
        b=REdHaxQY9lXoNrVn4l5clBN2oyNzrEfyijfigs9ICLiRDUMkdCmxHA5RR41Lyw9eog
         EKF7RnyRnudkIDZlRB+YLWVj+3O1x1TJXC7nCF8WU127Kppkqjrkq45/WKM9GCgij/mk
         M11djPbgYPi/J4Zc6Q41FztyUSthNmRqGEWFofsZAkrc+wfq6Nq4urB8xQIo5xExTtP6
         Wj55E+j8bQXzDwbgHACEBL1D8oI1vVPSBbqrYmUQHPubV/KgY4NBMOLpVsuj0OcVDLQ5
         ICjUpoxdBv1QZpysb9mvvRr9lJWraEYoFQVTjAwL8beEg42x4ORxJW/ScDJ+9j5LfXy4
         d32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597523; x=1709202323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyffHNsivj82P1pv+S3iGiZ7yfsGQjKP2uvBVMCZ2j8=;
        b=aDUVhHHk+yBAqTADOsom5IPhRjZOeT6cRuAR0jcx1oAyxB9tvZUHvrq89LS2uoNxz/
         Iir2YdB1PcG0eaAZeaCCvflKAaRxKapylIcuRvTxQzAJ40hnl80Xi71w3L65FVnM7wjz
         sls5l5hXK6zsSMZO2sU7BYlavsXQ75/Ri0fnfF6HxZl+UlP1We4eU21I/jFvb5BaS9WQ
         Q6t2Uw/ECuHOvMQOyM3L/YNr66twLsTacZtg2D/wA3JluekP4kzrE8iGkwigwEnumXfG
         KbgcP3c0/GXbx8gDKwCp4x9EfdXK5Fo8HRZvL5kYzocHRuwnH2k4kznd650h12RjyFRa
         XTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuIL0BQxwXsjTFLlONfEYSDlJB39gPoUcweM4yIeDTRJpUCJxreuwzMkKFAmW/NkzNkUk3/EJmN2NQrZpXcY/YAatK0h2PxGtfZOt2
X-Gm-Message-State: AOJu0Yz29xhN7qVU2akbHPhUKfUJIBRwbKJHrcPmY94MLs1xMmtO3PXr
	pwBSVTiJztSRFcgcy8a3bjyz6gwBy9KY9wNEHVDTuB+EQA3QoDboFy1B1a5sXzzIGp3bhenTOlu
	I
X-Google-Smtp-Source: AGHT+IGnQzoZ1jXAmvbq8+OELFRcBxY35KuYkhIW+1qhcSWumQpuDUVZoqDUj/84Va8hINnZJaiZ+Q==
X-Received: by 2002:a5d:5383:0:b0:33d:63b6:defd with SMTP id d3-20020a5d5383000000b0033d63b6defdmr1935896wrv.31.1708597523364;
        Thu, 22 Feb 2024 02:25:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:465e:5c78:c1d5:890b])
        by smtp.gmail.com with ESMTPSA id ay3-20020a5d6f03000000b0033d1b760125sm20632623wrb.92.2024.02.22.02.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:25:22 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/2] gpio: sim: use for_each_hwgpio()
Date: Thu, 22 Feb 2024 11:25:13 +0100
Message-Id: <20240222102513.16975-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240222102513.16975-1-brgl@bgdev.pl>
References: <20240222102513.16975-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Display debugfs information about all simulated GPIOs, not only the
requested ones.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index c4106e37e6db..88fc3712811c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -234,10 +234,10 @@ static void gpio_sim_dbg_show(struct seq_file *seq, struct gpio_chip *gc)
 
 	guard(mutex)(&chip->lock);
 
-	for_each_requested_gpio(gc, i, label)
+	for_each_hwgpio(gc, i, label)
 		seq_printf(seq, " gpio-%-3d (%s) %s,%s\n",
 			   gc->base + i,
-			   label,
+			   label ?: "<unused>",
 			   test_bit(i, chip->direction_map) ? "input" :
 				test_bit(i, chip->value_map) ? "output-high" :
 							       "output-low",
-- 
2.40.1


