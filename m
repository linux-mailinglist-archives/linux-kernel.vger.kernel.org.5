Return-Path: <linux-kernel+bounces-163502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F68D8B6C31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6248283650
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9D82C8E;
	Tue, 30 Apr 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTk6PAD8"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBD45BE8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463496; cv=none; b=ogvuvlfimFz59QJNE/lvqhvWbXewPrKx48YrRupCI7J8bW4ReQISr6vZxRjA8zIyfs4D9U5NskVPmPR4mNZC5P7yvfKkvPi/rGQiKIDvlLpje9HDOnO2WnLf2S4k4U8axHL9hPIxcbobgCZgiGEeBb4skXJ2jyVNVj2M1zEXNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463496; c=relaxed/simple;
	bh=tZr2bao3WLdMwTCauupdLvKoK/nOZz2ObARGCJxQaCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBeQQWGl+/4dYdebrwkEDCLB569s7zFhAKw7kLICyP/TwtFNrlKFxVsbDMZyVJvX/2TTnNKqzc2zjwNsq/HQezPQQOEkplPUcl6nHC78rJiaTK0rpn9hAVHrLZE9R9krXPD5vWShblsB8nS1Q/se3osjhMoBMfcng5dhARaMpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NTk6PAD8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43716ff5494so57188971cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714463494; x=1715068294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cXQjmuyZkvWHadrmTQe5KOC06n35bYtQrARXW4y+Vw=;
        b=NTk6PAD8bP1NbEspcS8TzdIrpDY5MbqefDtzOarY0OyA/HZR/vBHcqtomVk30wi1mj
         RHAasUNfPH/wYJOksReH/wO/HDnLei2f5FI6YlPakKhllVHnRtkGWw49GQqgiONVZ53l
         lYDrXgI6G9VWf7UENAGm29bCDZPcpYOxogMq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463494; x=1715068294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cXQjmuyZkvWHadrmTQe5KOC06n35bYtQrARXW4y+Vw=;
        b=G8YxmYVrQCGVnKYPM+30Xzjy+wIhJ1QtXikDM5EwGtOC7OrJvGualAdayUDrIvg7UP
         AVcVhWp8DGcOdMew1if1BdwVruUUcijaoc2gDEWnGFuZ3/NidgCOwW/0YBO+ho9xi54y
         QDa1tISIqZpnlKvGKY3esbk2CM3AB5r7IWHvv5TaZeO3fLwr5zuBPj/Jfd02JtHCU9W/
         dWz9eoes1uysHkrZA8OIURXHWydhAdmvW4x6a/3SVJN1DFqZ9gK0Fl95T/5SsfUCR7kB
         U0qbfii1lbq55Jox2EfFzdvGgkNXO0BfxNkaJfGaj640sp0VoIIsxVt17BtLdJVCORLX
         ngrA==
X-Forwarded-Encrypted: i=1; AJvYcCWGGPuZyYP52ou8+iZ24aJ8VaSjOjMkf5dQFthXPqnRJLoF9+HwBZ4n+vlvRv/jaAVbRjALk+BO2FpM1P6ibULcnrrW5AI9uwNut5Fp
X-Gm-Message-State: AOJu0YzjqojtLwsLA8zB56Boe6fA0SFcaT4yNPvNFy+pjPldQEakkHs2
	bm8DH3RaUFfaeCPP8Bp94rIJZMe0ogixwD3qAZ2wTbC5lBxAwHUSz01YVb7Skg==
X-Google-Smtp-Source: AGHT+IHJbt+AhqT6dvcQLRTeZ4YlJCvCSrE+7BncIk5ueTVJMqXmIFfvv1LVEly8aKIAOwJjytQtBA==
X-Received: by 2002:a05:622a:1895:b0:43a:c90b:34e5 with SMTP id v21-20020a05622a189500b0043ac90b34e5mr3440108qtc.34.1714463494446;
        Tue, 30 Apr 2024 00:51:34 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b00437b4048972sm10634547qtx.18.2024.04.30.00.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:51:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Apr 2024 07:51:28 +0000
Subject: [PATCH 3/3] media: bcm2835-unicam: Do not replace IRQ retcode
 during probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-fix-broad-v1-3-cf3b81bf97ff@chromium.org>
References: <20240430-fix-broad-v1-0-cf3b81bf97ff@chromium.org>
In-Reply-To: <20240430-fix-broad-v1-0-cf3b81bf97ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Use the error code generated by platform_get_irq() and
devm_request_irq() as the error code of probe().

It will give a more accurate reason of why it failed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index b2b23d24da19..0b2729bf4a36 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -2660,17 +2660,13 @@ static int unicam_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			ret = -EINVAL;
+	if (ret < 0)
 		goto err_unicam_put;
-	}
 
 	ret = devm_request_irq(&pdev->dev, ret, unicam_isr, 0,
 			       "unicam_capture0", unicam);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to request interrupt\n");
-		ret = -EINVAL;
 		goto err_unicam_put;
 	}
 

-- 
2.44.0.769.g3c40516874-goog


