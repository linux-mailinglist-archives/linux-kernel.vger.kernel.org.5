Return-Path: <linux-kernel+bounces-93895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E007873679
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E0C283C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9210D84FB3;
	Wed,  6 Mar 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flums+Ot"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CC84A2A;
	Wed,  6 Mar 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728268; cv=none; b=VgvEuHFY3d6QwJSRHJ14X2yRGWWMjQRJW32CYI90rvh6cy8qmjkxqGbHEBXy3gFS75Mr1Et1JfgdZa1V/uXq1ly1b7PF/ysWTbF62+hkk+npMppZ6De99YLKLZHqFdgs8QFaQa+cdqu/0c/1IUk7XTP2drnb5sk/HeaIkojb/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728268; c=relaxed/simple;
	bh=uKV+klLUjkMD5Ca8wpkNsN1iWWbCl3KEGL9BFSa3GBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcauqCOipTHW9rH5DJwPKsNqJamah6cEY6W0T/6QPUui4UMUhcPIiiZQfVnffueKXzjuEJWi9jYW/FvbCKxdzGJ8uJs6NhM5xcnhhqJFttMCSnekrY9uqo/ydcTWQ9E47/xAEvPkcYjFmb0qxIYgUWEuvEgHigQ0A9AwrdXLSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flums+Ot; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5135540c40dso2077450e87.3;
        Wed, 06 Mar 2024 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709728265; x=1710333065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGNo45CWdeWI1ssvFsIg1kI6YA8MzwdKzzHMhRiBLfo=;
        b=flums+OtCdmFpp6EjeMQ5Ua6uWwyRDH6pAZApsZP38VhPxN2wlDzYsByCKPtsa0vxF
         +Hcj/5XJus8ZKGbuDIrf22r/2qGzSkksSoP7QCujTGzd7kctVoXNBGmG4j3efyw+l7xW
         JdP4Bb7LYBth9/yewmCicfFnWs33K+HKxqYyGkdw09DOaZ6ZKZAMF5EC8l8QedBTsU5y
         B0eb+VQEnoJQPPNS8DYPZX2p7PAVYy5G+23bt0FMDVs1VUFRvb5y7uym0/vT/9nrKy4E
         OFmmPbE68T7p7n5rzrzUc9LGJHmF3h1Wpp6dx1WKMs+mkwR+cnGdePJ7R6f4K9zeTt7h
         1U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728265; x=1710333065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGNo45CWdeWI1ssvFsIg1kI6YA8MzwdKzzHMhRiBLfo=;
        b=PNp4VaMXI/jJzmPLiuzX3alAkX+6wCZ9lxgVtQ6VYlq0PuOj1KeLRw5Nq9u3bECyO4
         7t2MJ9dipci12VKVhWN8/9YqOQuO5ZPSNHa1TaQ5ozPLjKQo+W95NvN3FmZcG9MyWMTU
         KdnvmlfPE6TWMXQmt6ddzqcKWrYLlWJsoYRiAbKfyJis+tgUinlWWHSgb8XimOnMlUsR
         GW2zaoyUNb0P1b3JJwuFX1iWQjTqT2vUYjA3fulPUfGI+pmOtGBMXwt6Z+k0j7cxJ1VL
         s5IaWpeENdlQ9CVZ/J0e2DuOqRm6vmpa9aCCdk8rLcE0JmBRrF5EtkUNCc3ysYaue5pv
         8Zjg==
X-Forwarded-Encrypted: i=1; AJvYcCWPYxXALY97QDi3WYpbg8EG/WzdMkWKRj8j7a2b6JXvy1u7rsNPbxYm+WT/n8ZlaM0/6Vg3XSuUsI6h3DnwX+6g8TG8DEFQerhyoHcdiys5ZHQgqUpNaE5HKX6ohOB/0EkAryuhVZyybSNuxGE=
X-Gm-Message-State: AOJu0YxHs1G+E7NZpmi7QqHLSZ1PaUhu6HQoFc8lbbciY2zFDdnGpg49
	5AvRHAJOJ3bK8D5DdNTkkwme2/z4T2VK7s1j5XA9Gh7aoEHr3pjg
X-Google-Smtp-Source: AGHT+IGwie5Q/XJc5mrS0q4+BJSoNAr3cKEGAzJ+WWlnYZEyDkgNJdn1aznuS39VLrrzrMzBfC7DFw==
X-Received: by 2002:a05:6512:1191:b0:513:42e:ddf0 with SMTP id g17-20020a056512119100b00513042eddf0mr3852061lfr.36.1709728265125;
        Wed, 06 Mar 2024 04:31:05 -0800 (PST)
Received: from rand-ubuntu-development.dl.local ([79.99.106.86])
        by smtp.gmail.com with ESMTPSA id z14-20020ac25dee000000b0051345b2b0d6sm475989lfq.258.2024.03.06.04.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:31:04 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Michael Buesch <m@bues.ch>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kvalo@kernel.org,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	khoroshilov@ispras.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
Date: Wed,  6 Mar 2024 15:30:28 +0300
Message-Id: <20240306123028.164155-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ssb_device_uevent function first attempts to convert the 'dev' pointer
to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
performing the NULL check, potentially leading to a NULL pointer
dereference if 'dev' is NULL.

To fix this issue, this patch moves the NULL check before dereferencing the
'dev' pointer, ensuring that the pointer is valid before attempting to use
it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/ssb/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index b9934b9c2d70..070a99a4180c 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 
 static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	const struct ssb_device *ssb_dev;
 
 	if (!dev)
 		return -ENODEV;
 
+	ssb_dev = dev_to_ssb_dev(dev);
+
 	return add_uevent_var(env,
 			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
 			     ssb_dev->id.vendor, ssb_dev->id.coreid,
-- 
2.34.1


