Return-Path: <linux-kernel+bounces-71960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F023C85AD14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863132830DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD1454F88;
	Mon, 19 Feb 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lk50Vlzo"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52253E14
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374214; cv=none; b=ip9tpnIVj4TLhD/fZ5/fkqudZDdLbab5wLcgL0xHteyhqpR2kMPBnBAPgCQKTZsz8fI2blGqiT0Al6BK1ZyPLozKCGLBdQawQvAh0KhJu8VdC08RC5i3TIWwrgEr+ERcXh28UWv8afNdgJ4dqquTWkFzWTKE9Sj2x699Laqox6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374214; c=relaxed/simple;
	bh=1LpOcOPE8NF67KY2Om+0rc+yLxqoD9d+aNt1OJgcsWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO4oBSAD0cePSSAcqfRE8RVltapFDOVBdk3izsRSz+GaxYlPqeuDgheHgD7PCi10ApocdX+Y6UwP3AjryYZPeIjGchASxS8d+iLUlRx0FwmfbsqYJlDMUJMG3NCDzXSfPJob4DW0pvTR5omszD68BObczgkIrAoMDbvQTeED1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lk50Vlzo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2998950e951so787629a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708374212; x=1708979012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaHCMRLTHpVjbQpn0nm8Soa0CT5I0pTuDvK1Y4TvoOs=;
        b=Lk50VlzoWwTHtFvsPUYJhB0ed6Lu8/AhLLfJdlMIo9L1kEo4eRRXLbizWAzh6sxvEg
         QKEwNOSbmbqU9nGjbgF8hIdcKiTncogBz7a/OzxyuXHYb3TQLc4sC+lHI/4HG2IS5e4L
         2yqr7pUjTYKhuvVEgCCH6sR80EsP5jyH/K1rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708374212; x=1708979012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaHCMRLTHpVjbQpn0nm8Soa0CT5I0pTuDvK1Y4TvoOs=;
        b=lajnjEM6QM3Ll1LrSHI8ElI3pZYTfVTTYhcyD+q1ZTc7BxHTphy6DHYDDZ7+hVYmZM
         itk3yKhWk7dTTa2ccSfnJE0UXZp+skpcS3nJF1tiQsTAgBh6c7fYJUjSryiwYhrIvrH1
         4NKd825mrvsMALrwArG2lCnhiAikKU+UgZa4Qeg4ARsHDda22vzJv8BJdRmGaiGc++9y
         FjYMwg3Fxw/BLk0tMEl8RPxcrw47zB+CQNnssUovdxVF06aE95s2fjzTjl28LYhgXUxb
         h08m0yX2aNcqRYtLUXd5j1wjq1tnZOVGAZ3d476Df8JJMlDcDuzWe2++IerNlTwtIN2o
         7Qgw==
X-Gm-Message-State: AOJu0Yxg7DVlMWP889sOHZZGizWerptujTYuvwSTcKBHonzjmjSdD6Jt
	vou+CnEWNT3SoXHGeKP2Abdsx7oVWo0OMVlqVsvDZKAcMUzBalkY9fcdt90E0g==
X-Google-Smtp-Source: AGHT+IEAUG2tvGVJGd+hj3U8ybO/DpLRVg66FdpMvbg2eIV6gnVcioXBOcc/U9zxzq4OgB0t7uZbUg==
X-Received: by 2002:a17:90a:b382:b0:299:3e54:83f3 with SMTP id e2-20020a17090ab38200b002993e5483f3mr6532900pjr.38.1708374212270;
        Mon, 19 Feb 2024 12:23:32 -0800 (PST)
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id e21-20020a17090ac21500b00298dd684b8csm5810598pjt.32.2024.02.19.12.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 12:23:31 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/2] mfd: cros_ec_dev: Add gpio device if feature present on EC
Date: Mon, 19 Feb 2024 12:23:24 -0800
Message-ID: <20240219202325.4095816-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240219202325.4095816-1-swboyd@chromium.org>
References: <20240219202325.4095816-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ChromeOS embedded controller (EC) supports setting the state of
GPIOs when the system is unlocked, and getting the state of GPIOs in all
cases. Check for the feature support by checking for the GPIO feature
and then populate a sub-device for the gpio hardware on the EC.

Cc: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 603b1cd52785..9c3f8488b416 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -74,6 +74,10 @@ static const struct mfd_cell cros_ec_cec_cells[] = {
 	{ .name = "cros-ec-cec", },
 };
 
+static const struct mfd_cell cros_ec_gpio_cells[] = {
+	{ .name = "cros-ec-gpio", },
+};
+
 static const struct mfd_cell cros_ec_rtc_cells[] = {
 	{ .name = "cros-ec-rtc", },
 };
@@ -97,6 +101,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_ec_cec_cells,
 		.num_cells	= ARRAY_SIZE(cros_ec_cec_cells),
 	},
+	{
+		.id		= EC_FEATURE_GPIO,
+		.mfd_cells	= cros_ec_gpio_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_gpio_cells),
+	},
 	{
 		.id		= EC_FEATURE_RTC,
 		.mfd_cells	= cros_ec_rtc_cells,
-- 
https://chromeos.dev


