Return-Path: <linux-kernel+bounces-73244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815485BFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3C81C2140B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EDC76409;
	Tue, 20 Feb 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDpaT6P7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114B762E5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443024; cv=none; b=kfNAqrGVHKsW1dCDmkR7Z6lcI2K+Nh2ChZ884k2cRqiK5CiL89D/ivLBzOrayMhF/9/6QPyydVfAIc+EGWvMWzEAxj5VLo7iPNMeVKaDmXn5ZjWBiBRpO80toGrQXPN0GqEBmXBV5/gGO30W0g1I2qC4swQTSb25SY5pHE2pdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443024; c=relaxed/simple;
	bh=Bdr6esLRbtemkpFIIDa1y5ugHKxf8AG0iRZ2eQuhhuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/HYxGKUhSpoGx4ZHvibWTc2Pv/t1WL7/jDkf6pYU7n14dLKw8QQCDtFX2pzZtUqjZp/lvETL4n58e9fcvkRUxMKBPOjVzJsm9bqz3MHS0Xvivj1kX+ptnsirsElAwUIBYu1c4T4HiTVFR5hrlYYAf/tdAGrkqh8RJJg/wHJVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDpaT6P7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41270d3ce26so3569785e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443021; x=1709047821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcW5EHUKgbIlTJ9AkvlcTH/1qNEKLD/WUfYuV6zpMeg=;
        b=BDpaT6P7UUbukpukR68XrAiSptr9PbQ3cDoVsbaLt+4JDqLwWvhDee/XGvf+A+d3tB
         KozFzOqrLfrvAQej5BtBLtp/GV4kqZHlzE6iumVRqnRTJjYyAUSW2h/8sYIoSF2Uanhn
         c6yzyMPMPZuAx4gqnrQ/dS8drqsDCpER9gkwfLNBB3phvWIrnAj1HqA/y7Gs8NfMb1JS
         g7mW6rguM6BeSwhMXeHYdTtsvFMfHvBzIdy9j+/tUHqQ8H7kfXNeu7b9kdNwVtlg2zPm
         F+RQidGPPsav8KDm64q+1NYt6RYgrTJAKbm/RtEtjIqHMpj9gCZEohafg7Pq3lrL1Z8F
         14yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443021; x=1709047821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcW5EHUKgbIlTJ9AkvlcTH/1qNEKLD/WUfYuV6zpMeg=;
        b=eUQBCOSMxYHezWZI7m2YFUyTIIMavtZNCNc7ByE8uLkgCx1rzp0a+vIlkRIFeP/Zym
         mis/8mhKzyP3hWuB4/5adJBzQuNI/6aVT/JSLbmxVoGxem06R767+eqzG6Zz0XrM8GrF
         dkcAVu0Dwat4jqiMoMmWveEMfCTlKFe+iJQUgaXxDtyCBgAxpVesFFUmn8qXZERLrtxO
         q9pEgHtfzOCizohNzul+6fPYgjVkBVHX/9PzGeSV6SlRAkexozWOuxOBRNMBhRQvc3T5
         7udF7RmJVUbk0mgtvDMJqcEYXKoO9OKf618vlfwMp7MynwGi8vHdyHnZ/UpCbJK7Y5Wr
         TR4g==
X-Forwarded-Encrypted: i=1; AJvYcCVCEaDM77bidDKuUxDiL2isYL3kdNUYBCXSe4S4kBqYi2zX3Opm7kC8u0QvIub/e88gets1afTlsTuSB0+w/GqIzSrP0wH3+hbWr1P1
X-Gm-Message-State: AOJu0YznzB65ibN0SUmI9JA6q/0YCQiUWUMJE8DWdn04rLHbj5Y79EIm
	Pan2PCbA3Ui8KqiCAw74Ij4ascq8oqrT7EJ0XLgUZ0SV7QaYWO46y2eeFRSuJ+I=
X-Google-Smtp-Source: AGHT+IFRnEcCOrYMH/Z6LuCcovUr2mE5uwVOXe9d/ihECMTEDLLMcUoqMuZPky/aASEJWkUNQz7xAQ==
X-Received: by 2002:a05:600c:1e01:b0:412:5f1f:fd0e with SMTP id ay1-20020a05600c1e0100b004125f1ffd0emr6114959wmb.0.1708443020878;
        Tue, 20 Feb 2024 07:30:20 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14691564wmb.24.2024.02.20.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:30:19 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:30:07 +0000
Message-ID: <20240220153010.76238-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153010.76238-1-daniel.thompson@linaro.org>
References: <20240220153010.76238-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: c5a51053cf3b ("backlight: add new lp8788 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/lp8788_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index d1a14b0db265b..31f97230ee506 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0


