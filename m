Return-Path: <linux-kernel+bounces-96273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFB87598E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865391F20622
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82DE13B7A3;
	Thu,  7 Mar 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsDbd/la"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791A18B1B;
	Thu,  7 Mar 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847793; cv=none; b=h+en8e3k09tP2NkZdF1cJuXurRKNnVEV2y308xrRNTB22Jzuxsvma+MDVGY6QXV8PNCfTNO/o1M0C9fioHrQbVGabsntjbuoeTzhwXJOcXJNHJ7k1LztoMIzEjJavFSFLyOTT4k2fu6xNSc0l6XQJ0xsHWGcwbpdDGTez5MsI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847793; c=relaxed/simple;
	bh=80M8NjbIjYoL/onQSzHxeq0H7eHvyEkUJPoIAW4HmYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7zviGbweTz5cRqenTwCbmlVUBWvxRcKdokVQ89YO7DEiYAbyqtS3OGtJ+yhHbt01AqU6f+tzSmv32bc2CSgpc0dsEcCKpIpu8Pi4HNZqPMwalESLLPxaVx7S1MMq4crWwGEem3z+CdJCBe27WYMispZ5khCYbMN+UgFk/oPAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsDbd/la; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-568107a9ff2so1627378a12.3;
        Thu, 07 Mar 2024 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709847790; x=1710452590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Tf/utQAGrXJiwwCktTXSiNfcX33NE8VCZTiMoCOxs4=;
        b=PsDbd/land/1S4SJPSXikcyY1Qxl/JEgVRNbfQeJZS1/rFCtr8zJyfVcEHH2K1yckZ
         rAMe+rOAr1S+EcYvmXx0PYsk+0tNsDPyrx80LrVf+bGFn6+lHBm0RsYrf+37YGfx4f8I
         YRhvYyrLoMNWpxsXrIMLdZKNahab1BGgFksRsnFVlRduxstPB2A+N3HrUpmwyaeta1cc
         ww6KXmvQ6VHWEoCgjKQ3S8Wj4Lw/uPX64qU9KfwZRB+kW+1f0JSkiCrUWpLPqNV867ES
         HtQYyV0pBAWpzjI4/kuzi3SrYCMPiDQmAEhawqDoH3VKS8nu3BIiZo+ob90ntFSlTA4I
         ALow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847790; x=1710452590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Tf/utQAGrXJiwwCktTXSiNfcX33NE8VCZTiMoCOxs4=;
        b=PUcESiWhFyn14rVFhFWF1ad5qDDLNO7p8USSqDKFWlTTQ0dAZ8RAD5agmvfIpXrgO2
         iFRE5hGwxL02BopEYZXF+orXarfSqUfhdd7XoQHInLl8Jh8P86QMbFbG/jtlzCwEpOJE
         V6WURRjaEch7WRQMP42w6vxDbOOyr+2SamaRRR+Ok4+UjrsdH624T/BXiwCSjodSRF2W
         sV/arQV8MEd+HCnMWJSZbsUv3O1t+5OKpWIxVCpI/pFO7JxFQUUwfDr8Dxn9TApBy5Iz
         Q4i9kAK2EVdqzrbKKzPOotjj4Md1lrYa3vt+ueQoK6xUbXEXmbdfcbZRyJX76R98kzGa
         0K7A==
X-Forwarded-Encrypted: i=1; AJvYcCW6A3kZ7kk3IdPkKd0A5IDD8FNsqGWedUYSDk6V8xgWiCyookcX2QR8UZJ7Qs5UdZ54NMYEpJxv5TfwG1neU3M8CjKT42wkc0/agHeB
X-Gm-Message-State: AOJu0YybK8P4fvnLDWfe1s9mo3pMmfhkC3JVLRz6lpcCuudo6ACrgWa1
	SR0r4TnKew6TDGW3EFDv7r/m6vZErjWd2L4Sx94XiWgNzXhX/fRnQRoFVrAO
X-Google-Smtp-Source: AGHT+IGobn1aO2RSPYSmZnXC3eicyLV0+u9GGx5+WP9WuTBfdRZHQB0krYlAJXFN189RWO81feREdw==
X-Received: by 2002:a17:906:fb93:b0:a45:9347:e3d6 with SMTP id lr19-20020a170906fb9300b00a459347e3d6mr5534427ejb.66.1709847789524;
        Thu, 07 Mar 2024 13:43:09 -0800 (PST)
Received: from localhost ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id js20-20020a170906ca9400b00a3e643e61e1sm8623634ejb.214.2024.03.07.13.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 13:43:08 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: sysfs: repair export returning -EPERM on 1st attempt
Date: Thu,  7 Mar 2024 22:43:16 +0100
Message-ID: <20240307214317.2914835-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It would make sense to return -EPERM if the bit was already set (already
used), not if it was cleared. Before this fix pins can only be exported on
the 2nd attempt:

$ echo 522 > /sys/class/gpio/export 
sh: write error: Operation not permitted
$ echo 522 > /sys/class/gpio/export 

Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/gpio/gpiolib-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 67fc09a57f26..6853ecd98bcb 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -593,7 +593,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	if (!guard.gc)
 		return -ENODEV;
 
-	if (!test_and_set_bit(FLAG_EXPORT, &desc->flags))
+	if (test_and_set_bit(FLAG_EXPORT, &desc->flags))
 		return -EPERM;
 
 	gdev = desc->gdev;
-- 
2.43.2


