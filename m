Return-Path: <linux-kernel+bounces-163942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A18B7661
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33561C22BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62205171E4B;
	Tue, 30 Apr 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S4CF5NqS"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0D17164A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481748; cv=none; b=uokG/WtGM+yqOzEb9zqCjxk3ZroMJjXfjtPtK9l0vGtXzWxpG6fePY5CPP/t0nzGRpXBOGWRG7T84Qe47hYONhlX6kvE6045qejg9e0MJGpE8vvI3NT3D5BzNA4nnbhZYK39AYRou0peBobXRv9lr4U/VksfT+B2R6qAAaHQG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481748; c=relaxed/simple;
	bh=oYyX5A2u0qlsJz3Khs22Q9EKJnbR1seZtA56i5V7sUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5f0g6HzXcY71C2DWgQB+uhoNe17l+L2b/whY6hZ4Dm13vP7pMR9ACPpPqO8NAFSpDcmV2P7oiwvoyD5hMjEuyVC6oHaqKK5UwIyOpFqkItynGzN5pfoshCU8mv13NDGhLlQWqg1Jy3sOsLfY0RkN5DxgvFqspDW2CB5gpDjlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S4CF5NqS; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ee2fb4ec57so1191663a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714481746; x=1715086546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjV8GfCP2WHHQ01Aqc8mQQXzl2eD7DwGYj59FGy18+c=;
        b=S4CF5NqSV/7sgOb3QnBMrMwTsDvF2yVdSw75bDWzsB7HH/rCZpRYZROh2fl3msiXyh
         vr0teOHwY0GR+uCv2QaZ6kTgSRL9p2Ya7yMzlJvPJBNgUJISeAMlhFk5wlFllXp9ZEHY
         1UQpbe0SRJoTRkYZHcq54R+0JNI+rYZdFpduM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481746; x=1715086546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjV8GfCP2WHHQ01Aqc8mQQXzl2eD7DwGYj59FGy18+c=;
        b=YbH1RkUdD3KBTpiAMvLad9KvvEaG8nwxB/48bi6r8mbIpS/n3FO6pMsPhqxNsLCWjq
         KgQsibHsLt4vKbVlu2EBsDQSS2bQQ8kpKx3b0zam8fqGFWvsettlc3zWaQ+YDHvgW2aF
         XwFZ8+zEBU0o7hKUE0Zbhc60nrwZ8258b1X20kSt5bNyzLruq2uTtOMfvufkKM0+S4vp
         AjpPen3WNcuiobyT8DbvoUoNQ77lcEj8l+m4EoK4v4HZOXgcFQ4s+7FRsp1fFk+r9G0J
         nDBOcUaTn9YhbIOXQ1q6uq2z58mYYJ3Ml9s2pjWiwLphuXSEnH0Z3PAQBgw30oCD1lZh
         hVBg==
X-Forwarded-Encrypted: i=1; AJvYcCVijL537HUroLLAF6wMmaNMU4VzUFfX901gfCJM71s14PWLcgfG31R4/gMrf0O6cH9fPwdFK+cBgj45/4M5Pf9lMTGQ4CZWGk7dOzHy
X-Gm-Message-State: AOJu0Yybj5BJ4yUtNEEG/cS/gzFLxGiEBnXheTzYSzEIarqytu06NPeh
	lJNJDW7TWqYMIGPNjpMFoZQ6NSDAbzQzn2lzjrhfGkqt5rSriQ/L3HLJJN25rw==
X-Google-Smtp-Source: AGHT+IEgUWZ5sviYRGNJaeAywK807QZ4gEbNChyUYkiHWKS+u2I4svAfqrFMNl4wY8mlmeEBL/dfjQ==
X-Received: by 2002:a9d:7dd5:0:b0:6eb:e0a2:bbb4 with SMTP id k21-20020a9d7dd5000000b006ebe0a2bbb4mr2938580otn.16.1714481746548;
        Tue, 30 Apr 2024 05:55:46 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a111000b00790f90ffc32sm1553667qkk.22.2024.04.30.05.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:55:45 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Apr 2024 12:55:33 +0000
Subject: [PATCH 1/4] media: bcm2835-unicam: Fix build with !PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240430-fix-ipu6-v1-1-9b31fbbce6e4@chromium.org>
References: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
In-Reply-To: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The driver can only match the device vide the DT table, so the table
should always be used, of_match_ptr does not make sense here.

Fixes:
drivers/media/platform/broadcom/bcm2835-unicam.c:2724:34: warning: ‘unicam_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index bd2bbb53070e..c590e26fe2cf 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -2733,7 +2733,7 @@ static struct platform_driver unicam_driver = {
 	.driver = {
 		.name	= UNICAM_MODULE_NAME,
 		.pm	= pm_ptr(&unicam_pm_ops),
-		.of_match_table = of_match_ptr(unicam_of_match),
+		.of_match_table = unicam_of_match,
 	},
 };
 

-- 
2.44.0.769.g3c40516874-goog


