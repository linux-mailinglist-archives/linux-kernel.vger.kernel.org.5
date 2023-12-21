Return-Path: <linux-kernel+bounces-7721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF581AC1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8669A286822
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10C1864;
	Thu, 21 Dec 2023 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpQHKdco"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2F441E;
	Thu, 21 Dec 2023 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d939e2f594so279749b3a.3;
        Wed, 20 Dec 2023 17:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703121703; x=1703726503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G9xQuVfP3PvQMdAXCehswOfS0hQP216b/ZuRf+VAvA=;
        b=UpQHKdcoXOEWAcWuDy31PP25zJVptPd+LUeGrfIi3iVEd/PE2/YLCprDGR5UIj6Hal
         l9AFsVLl1mp+WHsHQ1UeSLrhPO8+8JSrNcrs4FMWu82a1Y/9BD2O3xkQmSYru4mDAYug
         /ighy7zw/2h1CDr4mi3n8XZnTO7GWgmwjgjGEDptlVoHAn0xV+gXDi2Aw9y6IA3bpubX
         P/E8SCvZKs3HaLmsJch1huEk12CoWRyzAxvkTBmZU+3CxqqwY/JJHnT/66fIo14DykEC
         LoTxZdc7z8DsjZxXxa1/uYjC+7ljVwPqbPIAxZ/SSpHTIXjn5bBTXp8+MoOXl/sdGeM1
         lqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703121703; x=1703726503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G9xQuVfP3PvQMdAXCehswOfS0hQP216b/ZuRf+VAvA=;
        b=jQyy+Hwq/6UK28qHB0JRmE3UvIVH9DjlfO3OPSp2YlWcKybWsOQfZxySQuZRMw0J7x
         DJ783CNaCjeQcj0pf0RZJSLHEHSR9oLYfE8/OwhuY6gedPLaoL1907JjuMvFG8eotlgE
         uQwACUe1SUDjCUg4Fn7mqdJBXHDDBhG7N479/AACETnBQ8yJZB1UCzUQs4072I9eiLtR
         kRrQ/AXiznriZowbQei+V8+9O/UjHQMFuR7rAi5/F/WD2pOpUWyidzl5z61Ot3IS+JRs
         a824tCtwcj3FjnWCSe2dnp3jIf2TShitgaewqmzPmY3eilPqDMmjdNPkF4W1oyGz/k7y
         ODZQ==
X-Gm-Message-State: AOJu0YzmTTaFnsH2VVylnSzt4Ap4WQdDiVF49cDPpwlKjhbsmFIh9/mh
	Dy/PqsjdUJvb981RCf4eJlbYBDNEYwE=
X-Google-Smtp-Source: AGHT+IGaXPh8OyVDZdKii9OHBFSWscknH+m41jrQOdLjMqxtaMJ7/pHaKVR5fBc2ByL8/fa5OCCwlg==
X-Received: by 2002:a05:6a20:7da4:b0:194:dd52:bdc7 with SMTP id v36-20020a056a207da400b00194dd52bdc7mr856347pzj.56.1703121703104;
        Wed, 20 Dec 2023 17:21:43 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id x1-20020a056a00270100b006d088356541sm375959pfv.104.2023.12.20.17.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:21:42 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 3/5] gpiolib: cdev: allocate linereq using kvzalloc()
Date: Thu, 21 Dec 2023 09:20:38 +0800
Message-Id: <20231221012040.17763-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221012040.17763-1-warthog618@gmail.com>
References: <20231221012040.17763-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of struct linereq may exceed a page, so allocate space for
it using kvzalloc() instead of kzalloc() to handle the case where
memory is heavily fragmented and kzalloc() cannot find a sufficient
contiguous region.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 942fe115b726..5424c878627e 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1723,7 +1723,7 @@ static void linereq_free(struct linereq *lr)
 	kfifo_free(&lr->events);
 	kfree(lr->label);
 	gpio_device_put(lr->gdev);
-	kfree(lr);
+	kvfree(lr);
 }
 
 static int linereq_release(struct inode *inode, struct file *file)
@@ -1788,7 +1788,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		return ret;
 
-	lr = kzalloc(struct_size(lr, lines, ulr.num_lines), GFP_KERNEL);
+	lr = kvzalloc(struct_size(lr, lines, ulr.num_lines), GFP_KERNEL);
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
-- 
2.39.2


