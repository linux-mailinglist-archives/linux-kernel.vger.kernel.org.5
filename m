Return-Path: <linux-kernel+bounces-150692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95C8AA31D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDF5283254
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED73199E8D;
	Thu, 18 Apr 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYjvgj4p"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA8194C99;
	Thu, 18 Apr 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469395; cv=none; b=Ll2qLMpq+QTcUbXQ9ODFVpFQJdPWddW6xScNrEUYkf4ynMwOu81YI2HelC7Cs+bK1R02FP+n4DOeQ0c/5sR9OtfRkK57wA+/wjsRocGTKC86tJHLgqmwN/9F3O06mlAYKd7yYykah9yG8WLjqyAtvM1LzmyXfOuLZ3V4FGanjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469395; c=relaxed/simple;
	bh=MRNTrJBsF17use9WkK4TN13OK8uoCL9+cnCZ1MkhyUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzrDhaZqQlXdjEPX7dlO/U6wC+eZpytWjfGLJggqR2iax/VF7XT5dG8FjFxDxDq5FX6LZRXlQlPSeGZtDNrUwH4AP7fcQFnIqJPCRTbpi8rq0YOG3feWKgsDimAf2GkphnBDxEtB7GFBPb2R+byYzP+4qnOx1RHZ/p42pWLj4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYjvgj4p; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cedfc32250so837233a12.0;
        Thu, 18 Apr 2024 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713469393; x=1714074193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38lT2Q9/Wtu/x/mwT7pRtKT/XjJGw1DkTWZ0TLbddro=;
        b=QYjvgj4pxOtj83a5qdh2tYbszSgpIqhx83tuNucLK2vFnEENQfvFXxzdrbuiUJTSiA
         UXtitUOdKDBpt1O4smOBQil/zdeNlHmouelLiaisJKFzaQ40inHewFTXw4OpZZg/Boh1
         dHKHWkF6k+7H1t+gY043GwTJr1uwOQJLEQn8m2xaRKi/x3oPyTzczU79EgLa5NaL0MaN
         ZI1XP9HCjgxcftIMl8Wd7aTeAq2mNtaE9icv0pm4yCr1+RltE7H835k+7EyEgfh31vjL
         Ulea9DCdHLyX6OKCkjSixHyUWKB4Z+xTo+twqepf/v/MLkKJScEavCixdAnwjZ/gb2DF
         tUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469393; x=1714074193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38lT2Q9/Wtu/x/mwT7pRtKT/XjJGw1DkTWZ0TLbddro=;
        b=OZ8q25xGZ9HNI/0qBDIRgfgjXbvEwj1nilpvhk1heZU1MhtvEArmylYU1GL5Y6uzHE
         5Bdvuo/ekCNXkJZt6SEaWKK3csmDVoyOS3R8BmkR6TDe/uHDIsijdVAV614JvQ5vhg3Y
         jxQPh12PPkYKQUDOqWvdA0z05n562ZROFgRsv3sah6tgAPFVe0IVIxs0K3AuO4L0faN1
         EnPToIZyIfhqo77t8e9ABWZHKnPqwcC2OLgJRKnqRZCtfuehsGYfW0i+WTIhqAuHCgZL
         90V+1RX8H8xp18ulnAZCW9Z27U1SQLpyBaCIKOWsi54f36hmoojSG7P6sk4yaRL+9af4
         ZhjA==
X-Forwarded-Encrypted: i=1; AJvYcCX9OM8gQ5LV69Jx/w7H0Zka9+tj4fQ79zLETGBBfd2CFolfNvhCvma0bFgPPa9hrV4BAiutENDva/UUFPljYhOeYD5pc7wY6O5zg3m8tyjw5IjNNOPOjFNoemsoY4j1Si88nRSDsjE2E5Q=
X-Gm-Message-State: AOJu0Yy+51bzK6PMnmuRAGXilbIs/95B6iCG10qhCUsa8u5IPJ6gViUH
	pYTEuOc/GsuPIouEDlFOi1VlrWmJz0aveFgN0vBxegN1M+k+ytPR
X-Google-Smtp-Source: AGHT+IFL5Cd2jMq39QbvOOpOS8FadIfe4V5Nx3bG2ekmukhNfIWjmkm1cizoU6hL1T9tr5VD1xV4Pw==
X-Received: by 2002:a17:90b:3108:b0:2ab:e1ae:d4c6 with SMTP id gc8-20020a17090b310800b002abe1aed4c6mr145328pjb.32.1713469393079;
        Thu, 18 Apr 2024 12:43:13 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8099:de35:15c0:2623:bd0c:2046])
        by smtp.gmail.com with ESMTPSA id b24-20020a17090aa59800b002a67b6f4417sm3556327pjq.24.2024.04.18.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:43:12 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH][next] drivers: video: Simplify device_node cleanup using __free
Date: Fri, 19 Apr 2024 01:13:02 +0530
Message-ID: <20240418194302.1466-1-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `__free` function attribute to `np` device_node pointer
initialisation and remove of_node_put cleanup for this pointer.

The `__free` attribute is used for scope based cleanup instead of
manually freeing the resource using `of_node_put`, making cleanup
simpler and safer.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
 drivers/video/backlight/sky81452-backlight.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index eb18c6eb0ff0..3c5d8125080c 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -182,7 +182,7 @@ static const struct attribute_group sky81452_bl_attr_group = {
 static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 							struct device *dev)
 {
-	struct device_node *np = of_node_get(dev->of_node);
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	struct sky81452_bl_platform_data *pdata;
 	int num_entry;
 	unsigned int sources[6];
@@ -194,10 +194,8 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	}
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		of_node_put(np);
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	of_property_read_string(np, "name", &pdata->name);
 	pdata->ignore_pwm = of_property_read_bool(np, "skyworks,ignore-pwm");
@@ -217,7 +215,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 					num_entry);
 		if (ret < 0) {
 			dev_err(dev, "led-sources node is invalid.\n");
-			of_node_put(np);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -237,7 +234,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	if (ret < 0)
 		pdata->boost_current_limit = 2750;
 
-	of_node_put(np);
 	return pdata;
 }
 #else
-- 
2.44.0


