Return-Path: <linux-kernel+bounces-111798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9FE887119
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA4828387B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B225D494;
	Fri, 22 Mar 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqaOOakl"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5BF5674C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125933; cv=none; b=miANn8quFHnRyTAeVrco1dMBeJtQDeDdXdBaDMf7QElvmYGQqBUSdaVH1d7qt3eCzffs9uPkxFlxM+GwuIt7jdszTcbh5PbQjMFjs7sKGHbJFOAy2pP/AH4ZSKVWU/tzs1+gE8JsiwCxIRJeNSqz4SG+xa/aEGnFU/reb8SdICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125933; c=relaxed/simple;
	bh=P7H87swXVhT1Zwwck0wCdolNVND6O7lvGEuL88MUnUA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EbHtYcLPW10Se5MC+3L3wT7TZeBGgzvFKzilENPLtuWUg1lkf/AapXLhQ2RXrzy8XPDACTO5ttqWgv1PqvtFjrc4sbivUJnm8HIoVUmrRyykCtsJUYGAHTCt58rLl9WH7+CwZMCTvBpPu9uCEUI4o5GusiR3+t5YWCz1fm5je6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqaOOakl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341b9f6fb2eso381566f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125930; x=1711730730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkckiT/MUZpay/oqQb7f/JkIe5zR2ftgXQzhuQxI+RM=;
        b=SqaOOakl5T+qzo77l8M+o8H6Zkre1r1GO5FIKLN9b7EyelMxnbYk1uKB96QyuDmleM
         8SY+FCdbF+nARPRrkt4+oDfqCzlRTzvArQuo81zG4XDpVHMJJcKL7Pt4MbeK88r664In
         ZcXQ6lqVPXstNOngx+oPqno7qHxq4EI31VsyETJvHCXvCJwwqZvBTlpUTHtK/onIWrsJ
         A2nowMAXKnWUgYj2NOFg9cOL/VbvSSj38wORRQED7OQfGZ9duBeQ4pkcC/feRnO8/di5
         bAsw4UKYbLDSXdbZfCADu54hKiPSX2Xz4wkWi2cLRx4XxYIyMS9yNNQdgGPss4yFpUcs
         5IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125930; x=1711730730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkckiT/MUZpay/oqQb7f/JkIe5zR2ftgXQzhuQxI+RM=;
        b=qzz6psjsFCxfdqaSuG6Aj1jEly4FbcxljWHKZDcd+hUg0Wi/A+OBoAZf5V2mXamB2I
         /SYgYaDfSeBmjqlH8aoHR//AFCelRo71XI3NKgdiqJxWrswmlZNu+RbSAm5pyJUodxcP
         vbiP2Qf2rKwCaJOz9RxRQmoOWUW05lcJO96qB3xPzYPVNiGahyLDbBdL2zTjMQQPnmKe
         XZzmhUnWyQyskmcjhj76uHjIKjCjBlXv3DLaEVYxUehTBrMLjfBj0Q7Z/veLEoeiKFfw
         ICRcIsAQOMdJHygixXvrl1G31KcKxao2FuFt4NeaBgPvphLQcWIp273xpbWsrqIUkaK4
         zvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGxGin0Rj5gcgVLuABaKo5n1pt1TuGA0jRVvlJqZbVHlRCmS5vIMcnqGeDMhP/ZPDIzHeLtRweQrfi1xhh9wJltgUUjj30A0sNrzAa
X-Gm-Message-State: AOJu0YzFNwZ3tc8R5/hAvOvrSJcMrO87iRWVv7/Frl/f6GoTi91TLpM/
	DjSCVex+mj8L2KIUGx0O/S+P/JExKswU4cCcnmKqyHpV8bjIGTTE
X-Google-Smtp-Source: AGHT+IHSQaiEfEpnVF4LlimL5r8Q0Mx7e+wj/Pb+bz/9C3rX0Vqa6m/VTajZzg5PovyOp4+g+1id6Q==
X-Received: by 2002:a05:6000:245:b0:33e:7a71:1a34 with SMTP id m5-20020a056000024500b0033e7a711a34mr1922893wrz.57.1711125930074;
        Fri, 22 Mar 2024 09:45:30 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id bq3-20020a5d5a03000000b0033e9f6997c7sm1989107wrb.66.2024.03.22.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:45:29 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: fix power transition timeout warnings
Date: Fri, 22 Mar 2024 16:45:25 +0000
Message-Id: <20240322164525.2617508-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase the timeout value to prevent system logs on Amlogic boards flooding
with power transition warnings:

[   13.047638] panfrost ffe40000.gpu: shader power transition timeout
[   13.048674] panfrost ffe40000.gpu: l2 power transition timeout
[   13.937324] panfrost ffe40000.gpu: shader power transition timeout
[   13.938351] panfrost ffe40000.gpu: l2 power transition timeout
..
[39829.506904] panfrost ffe40000.gpu: shader power transition timeout
[39829.507938] panfrost ffe40000.gpu: l2 power transition timeout
[39949.508369] panfrost ffe40000.gpu: shader power transition timeout
[39949.509405] panfrost ffe40000.gpu: l2 power transition timeout

The 2000 value has been found through trial and error testing with devices
using G52 and G31 GPUs.

Fixes: 22aa1a209018 ("drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 9063ce254642..fd8e44992184 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -441,19 +441,19 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
 
 	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
-					 val, !val, 1, 1000);
+					 val, !val, 1, 2000);
 	if (ret)
 		dev_err(pfdev->dev, "shader power transition timeout");
 
 	gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_PWRTRANS_LO,
-					 val, !val, 1, 1000);
+					 val, !val, 1, 2000);
 	if (ret)
 		dev_err(pfdev->dev, "tiler power transition timeout");
 
 	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
 	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
-				 val, !val, 0, 1000);
+				 val, !val, 0, 2000);
 	if (ret)
 		dev_err(pfdev->dev, "l2 power transition timeout");
 }
-- 
2.34.1


