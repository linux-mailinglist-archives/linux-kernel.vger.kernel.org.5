Return-Path: <linux-kernel+bounces-51836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92DF848FD6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B411C2192A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC93249FC;
	Sun,  4 Feb 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW4ww6KH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F052249E4;
	Sun,  4 Feb 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707069976; cv=none; b=nOanSnxLjADU5ybbjkZcI9/nambs3DNLiQSDy1CpbCaD1lavyW3LYsgLVbNcZLGJ2XL1se1fCQ+9/sFKqShvMHnmh/wYtsZ54braFQ/X9cplP3tOny1gpVM7NQUQssgzMBBUIsc0TX+AOcSd3QKDes6KhQ+QiNpqR2M+lkM6t80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707069976; c=relaxed/simple;
	bh=zhWgpnSWsECnYKzqt5QEo25LmK4DE2O6E6emB/IKQw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0oW2i3WiPifAKfC81RCdQphtLVIGNnsGv9Ab9GcvoQT8bXjJzfe9mnaiEhvcsxEiovHrRaqythanJGoNTf39XVHm7IQZGKJLWwe9gbduSX5T3txgyQfhG6u2lKBLaKEz0NqxabpoBjTJ5U1v+3f2FmO+5SBRJ6a7wOinxCryrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW4ww6KH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so3422213a12.3;
        Sun, 04 Feb 2024 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707069973; x=1707674773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR2Mad6pkmr/AJ3t4bNKbdRchZ97UqQJGhJvLfb3DsE=;
        b=CW4ww6KHWdRtqe06zPdafqYUEi5FAtJ8+ZUZF7/LZ5c5h/AfLQrxVS9xrkXKEZwqdd
         +wtmIkilfaowq9dphN37oaJZMhpTTOfJ5tt+MbYotKBwh0hvzu7UX85rbco3hGEjGeO/
         AjR5atY5HuZxdOzoeze5pL/kP9snxHGUA3SgQWzw9GR7sQLmAvZxM4sm5Ehd3xqj6ol/
         DCLwklOQVMPHAQsaZgemCuLHoxFhqAI3+TE2Aj9ryhA8zrNxsBslI5XmXOSTXyg2PYxh
         odJPcVLsBlm1WEBnXUt8Qa01YAvGEIzG73BzboISKu+IeObphTw+xjg+1pXzBNZwbWaS
         yObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707069973; x=1707674773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR2Mad6pkmr/AJ3t4bNKbdRchZ97UqQJGhJvLfb3DsE=;
        b=ZxXshJYJ/Gy2wpjRNjE/LTjUlPAPbgFqX6TsknQMbkARlEOYJONC4Gs3qtYS+ySzbU
         eoT096GIGlr+qktMMYKwY4EWD8RBLlj6PnUwe7WzVX0loRboSltqkGoFpCiiZZqz4qoW
         PLjnOP9dwjBfyPkSdwkE5mM/KiZMLvQealU0Y76sJNShnVbMHSqliTpv+2zy4EoDH55Q
         jolIq7C2F/YuEXejEUR3o1QPUmBNgMzxp114Q4jWTiZSRPFv0SgmHKHRwXA9lK865CIk
         zodNe9uUYBogLqpiWIHkEtS0pl7WVA9QMtNGS6Bwc5/Tgpi1IIKRNp8YgkLzN9phE9XV
         bSag==
X-Gm-Message-State: AOJu0YyMsk5YNXY8wGcg4VP9geNlTUA+cPg7mhlPGdGTMZ1mxSj3SB8W
	NyzCg95yc0aGxi/yPWAphbseGkcj18pWNh50lI/zVi38soSpH1zU
X-Google-Smtp-Source: AGHT+IEXZbqGJd5fIminHWlMukZ7W8157qnGxVLJxrEGYhw1bHz5uDq2w7/hHeaK3VtuU3LLSWzgyw==
X-Received: by 2002:a17:906:f918:b0:a37:bf8a:5608 with SMTP id lc24-20020a170906f91800b00a37bf8a5608mr187332ejb.12.1707069973203;
        Sun, 04 Feb 2024 10:06:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4MNbqs/2LXNvZ71EbrEG29FrVB4wm+G0+98fBCIB9mKR38ZSBXagMxBI29MI+IOeCbL5cnnMWwdiuq/ILzuXP9xORQejEC70cspIv8OpyYbhz4r5steZJdyFcJdiXeHDP+X68iMVa1uPfqW3zh6YoCw==
Received: from localhost.localdomain (i577B6AA2.versanet.de. [87.123.106.162])
        by smtp.gmail.com with ESMTPSA id vg11-20020a170907d30b00b00a37669280d1sm1660638ejc.141.2024.02.04.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 10:06:12 -0800 (PST)
From: Jesus Gonzalez <jesusmgh@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesus Gonzalez <jesusmgh@gmail.com>
Subject: [PATCH 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices
Date: Sun,  4 Feb 2024 19:05:37 +0100
Message-ID: <20240204180536.30617-2-jesusmgh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204140010.7edaa782@jic23-huawei>
References: <20240204140010.7edaa782@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and 
probably others) in their ACPI table as the ID for the bmi160 IMU. This 
means the bmi160_i2c driver won't bind to it, and the IMU is unavailable 
to the user. Manufacturers have been approached on several occasions to 
try getting a BIOS with a fixed ID, mostly without actual positive 
results, and since affected devices are already a few years old, this is 
not expected to change. This patch enables using the bmi160_i2c driver for 
the bmi160 IMU on these devices.

Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160_spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 8b573ea99af2..0df961a129bb 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -41,6 +41,14 @@ MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
 	{"BMI0160", 0},
+	/* FIRMWARE BUG WORKAROUND
+	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
+	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
+	 * available as of Feb 2024 after trying to work with OEMs, and
+	 * this is not expected to change anymore since at least some of
+	 * the affected devices are from 2021/2022.
+	 */
+	{"10EC5280", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
-- 
2.43.0


