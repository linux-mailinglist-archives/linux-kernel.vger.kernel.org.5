Return-Path: <linux-kernel+bounces-42688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F4840503
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A048AB22B50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B36605B2;
	Mon, 29 Jan 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RblHS8Df"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E1605A6;
	Mon, 29 Jan 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531320; cv=none; b=teFGFiJRdGgMI921AnHaw8pXhb6O2XLJTOVba9ote4oAWxHiaJHsOqF0sQf5pdS9oE7NTlJdq2J2okwZl+t2Qy0BHvTbtgUCjAhYwES79VnpKc5mw7Qxj6fPl9VamaNSBXZ2N2GaMlA2k0bvttNec0VmVBZ8GJ84SUB8oytq1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531320; c=relaxed/simple;
	bh=mcInd08XvyCy6zd1QuAT3wWVCaUJDJbn6lvFceUBXvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bna8+6Y5N/cA9zwynwAIhmZ5pt+2nww4SlFAtjn3WdYFlOH9EHVNJ9IEWAM4mPUkRwJcynLm+7CoMbdlydS2FK++yvOFDTnckpSZ2ng8pj6fpS3nhPvwFJ8+jdLExH0QKqJm6i4WuoBS5VNEChUUcDMGKeescZ2wkZA6eodCi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RblHS8Df; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd72353d9fso2239796b6e.3;
        Mon, 29 Jan 2024 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706531318; x=1707136118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ1Xaz14ZyQBYq37o+9XH+aMANQ9nM3T0nzw2efla60=;
        b=RblHS8Dfk+R1ZL9f26honvvqAAIGuuSITBCoW2XBb+F7TDSs4wjgryVp8kvmI8XCls
         vI+uInVeX7kQQ9/c2WW/SHuWtjQHtdFFFEAwThi/1p8I6qk32JCrRHDinJyeiUbrccsx
         kEO1byYi0+gVGEazdfizQazTGCGupOqzCd3bB6vEzfmkq/OJI6qB1LyA+lwtKVklogHu
         +YNuIcZtKOOGiMG/MLSbutSRXZEFlk5BOqrfJAxftDU81113Tj6ptEIsFLKYLHipWXvU
         EtW5aXO5/KAFsgpvuf/77p5W9QHYayYdIe3kCxmhWvLvZXkKi8V5PL6uwksCsWUCozGq
         ya3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706531318; x=1707136118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQ1Xaz14ZyQBYq37o+9XH+aMANQ9nM3T0nzw2efla60=;
        b=PRvtzVInm3svcwIFOjur9fuThoMr6ZhoE8Xgz1KFLPV6fcD8PsPT/hg/oV+NFjh4UK
         ry6T99xXFbP0aZ4aSGLs6cW09VF/HC4fkN0nKgbJQgfbO2ai22uMd9oNc7eowOb7nmJB
         LZYpknD3u0lYf70uabCC2fYS4d78OrFOlNVz3XXp+zW6KxRo8d/aRwYBiXhSG0JsjTqx
         0PGRmtXaHWRZi1NmsDD1SYGXkWHPvwz/Ypkd+ernVdF7CpB/JpwCp1P15oUuly4znXLa
         PP7Z3WkBxz9phmc6qABoHGg6bOSXX/kIV/ft+2S/4hHgMpe2OyeCrrGKIxbPSpgxdKtO
         hE9Q==
X-Gm-Message-State: AOJu0YxsUy5Q0fIheKsp7tb2dyI1p7vKYgxcX0BaPivMp5lNxgTPDvv7
	w5K94ioOfmOFoywiuCrAZyeeRFoz5j4OUk0xsA2HftyxfEnncI7w
X-Google-Smtp-Source: AGHT+IEpxyGkK3I2qfH0QfxhhGtyGzTOgWR/vf9S3KraxhEmCgG+oBGIvP2QSme6hM9sn60woT/VlQ==
X-Received: by 2002:a05:6808:114d:b0:3bd:bba6:9b14 with SMTP id u13-20020a056808114d00b003bdbba69b14mr9693174oiu.27.1706531317785;
        Mon, 29 Jan 2024 04:28:37 -0800 (PST)
Received: from 192.168.10.7 ([2409:8a6a:542c:83f1:d1e7:d095:b7df:289d])
        by smtp.gmail.com with ESMTPSA id c38-20020a630d26000000b005cfb6b8e471sm5833300pgl.14.2024.01.29.04.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:28:37 -0800 (PST)
From: Jianhua Lu <lujianhua000@gmail.com>
To: Jianhua Lu <lujianhua000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: ktz8866: Correct the check for of_property_read_u32
Date: Mon, 29 Jan 2024 20:28:29 +0800
Message-ID: <20240129122829.16248-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_u32 returns 0 when success, so reverse the
return value to get the true value.

Fixes: f8449c8f7355 ("backlight: ktz8866: Add support for Kinetic KTZ8866 backlight")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 drivers/video/backlight/ktz8866.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
index 9c980f2571ee..014877b5a984 100644
--- a/drivers/video/backlight/ktz8866.c
+++ b/drivers/video/backlight/ktz8866.c
@@ -97,20 +97,20 @@ static void ktz8866_init(struct ktz8866 *ktz)
 {
 	unsigned int val = 0;
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
+	if (!of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
 		ktz8866_write(ktz, BL_EN, BIT(val) - 1);
 	else
 		/* Enable all 6 current sinks if the number of current sinks isn't specified. */
 		ktz8866_write(ktz, BL_EN, BIT(6) - 1);
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "kinetic,current-ramp-delay-ms", &val)) {
+	if (!of_property_read_u32(ktz->client->dev.of_node, "kinetic,current-ramp-delay-ms", &val)) {
 		if (val <= 128)
 			ktz8866_write(ktz, BL_CFG2, BIT(7) | (ilog2(val) << 3) | PWM_HYST);
 		else
 			ktz8866_write(ktz, BL_CFG2, BIT(7) | ((5 + val / 64) << 3) | PWM_HYST);
 	}
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "kinetic,led-enable-ramp-delay-ms", &val)) {
+	if (!of_property_read_u32(ktz->client->dev.of_node, "kinetic,led-enable-ramp-delay-ms", &val)) {
 		if (val == 0)
 			ktz8866_write(ktz, BL_DIMMING, 0);
 		else {
-- 
2.43.0


