Return-Path: <linux-kernel+bounces-160892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F18B4425
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AA11C21559
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333253DBB3;
	Sat, 27 Apr 2024 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlOIdtuB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02419EEBF
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714193433; cv=none; b=jYbFUdxjwyD/QLBYQ5Cu8O9A57jk1mqkeXoQJgW/H8x97GcFhZlbWvYm8rWygD4UeOjC61GygT3KjTEZ2GjHCPIQXdA0OlvS5HUszevWJ7S1tXKqA2FCeImortdQzjoklELP0iMRWoWkSvkB6uQikTXRdqxRnOKD9dJII2cC20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714193433; c=relaxed/simple;
	bh=EzPpUIA3bPnXoVpaPB73VE1/lw6acU8vZcKCByOKoKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qf3OcPl79lTcqIYJDLk/XgROquBCiUaq/0dy7RLQ25BhUT18r+qN2rz49RvPgqTdbjWEy0dYe22m33AyWnw33Xu+P/F8qmkLEbzC0aH1+F0B4siL+JXcxoKxAKY4LrUgLFWK/hmcQrhwBoHogS/PXeIzQkqDTfeZrUsF0EBFmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlOIdtuB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso2590689b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714193431; x=1714798231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTTqh4tVK7J4k/2+rdaNwgcyYffbEPxsziKQodGk2xA=;
        b=nlOIdtuB1PYgsGIio7jdj30KxjIzlrDj0B3s6/0C4mtE4jXtouH6QGTt4ZqJvjjowp
         F87LAzrMTEnKtaJI/dAJFoGTBv5VQzbsvFt7e+MMWQmbxyAv10O0/ERONv01fdgvhTyo
         WdkLVsi+W6PTvlLOmkDfb+Efo6657W2XKok17RMEhEuscTDT4K0IdwdbKbhduoWhk7JK
         LgB4ohUr9ptnVWEMftNyZ9RvY5og72477qOZGPKi/e8yovEhjjh8aSUC8ZmP8qrsHmF8
         xvkM7qavv00NUfmR/NUTYXY7oChuqFdA9uB27FaGx/2j53lj4YfIwgM8At+VFfGK/b64
         RxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714193431; x=1714798231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTTqh4tVK7J4k/2+rdaNwgcyYffbEPxsziKQodGk2xA=;
        b=UDoIDG5vYPQ4ohmrHKE9Xi4XSB1eEgyWYERjmoIT00ZCmRN/mf7yoP28DUdtOmgCuR
         3ntoheaKFDpmoUHPVBu8txI36Imzi40VU4lySYWc1NohhjzKTrBpOilx4eNyqTGFl4iq
         tVuhzogIfb8mAjqYFj++62nJzYnio9UxV7JZtlCzJ7yRr4PKQhqmylhYO6pPJgxsfy3a
         W+eZ4RO9j8N085JzxR7ywE88Y70p3xSZK6KTv2pCWZxZ7R1JGF9mlrijFoUFGfGAk4Kh
         OnQa1ze0iUDZswJl2zDNwcK/P4PISkSe1vfjx/r+mHBXrLdlDgS3QoRHwxB8pZxcI2Fk
         uFLw==
X-Forwarded-Encrypted: i=1; AJvYcCXNoB4TKEaoINyr94/YMknFyL5VopuoF99gxjMXqZnyORDy+i/56QjLc8HlIItcZE7VX6lMudcpZ+5yiXGAfV+F9+50Hh4NQMBQ79i2
X-Gm-Message-State: AOJu0YxXbVA4pTH5OfEjFkJOcTwlJGW7fFvuoRDLIfOiiGvKQwmAGgSb
	uxwKXTLc6nLCLxPPnWElO2q+J2mQFi2uCLtJMPdF2J+Ty2f7cXzr
X-Google-Smtp-Source: AGHT+IGRzOBwYBTkwB3GLPM/O5/vOt1JZivbu5JwYnjc5fI0/FJvzIH5Gqb/07IY7GZt3+GyL3NGZg==
X-Received: by 2002:a05:6a20:1050:b0:1ad:7c58:6a74 with SMTP id gt16-20020a056a20105000b001ad7c586a74mr5122050pzc.23.1714193431154;
        Fri, 26 Apr 2024 21:50:31 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:d75f:35bf:3e3a:ae80])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090a5d0c00b002a005778f51sm9611928pji.50.2024.04.26.21.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 21:50:30 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	R Sundar <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] gpu:ipu-v3:pre: replace of_node_put() with __free
Date: Sat, 27 Apr 2024 10:20:24 +0530
Message-Id: <20240427045024.7083-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release when they get out of scope.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-pre.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
index aef984a43190..95830cf8fa3e 100644
--- a/drivers/gpu/ipu-v3/ipu-pre.c
+++ b/drivers/gpu/ipu-v3/ipu-pre.c
@@ -113,8 +113,8 @@ int ipu_pre_get_available_count(void)
 struct ipu_pre *
 ipu_pre_lookup_by_phandle(struct device *dev, const char *name, int index)
 {
-	struct device_node *pre_node = of_parse_phandle(dev->of_node,
-							name, index);
+	struct device_node *pre_node __free(device_node) =
+		of_parse_phandle(dev->of_node, name, index);
 	struct ipu_pre *pre;
 
 	mutex_lock(&ipu_pre_list_mutex);
@@ -123,14 +123,11 @@ ipu_pre_lookup_by_phandle(struct device *dev, const char *name, int index)
 			mutex_unlock(&ipu_pre_list_mutex);
 			device_link_add(dev, pre->dev,
 					DL_FLAG_AUTOREMOVE_CONSUMER);
-			of_node_put(pre_node);
 			return pre;
 		}
 	}
 	mutex_unlock(&ipu_pre_list_mutex);
 
-	of_node_put(pre_node);
-
 	return NULL;
 }
 
-- 
2.34.1


