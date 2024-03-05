Return-Path: <linux-kernel+bounces-91493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B8871256
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A761F2303E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65712E47;
	Tue,  5 Mar 2024 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="cifhY5Eh"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977D125C7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601979; cv=none; b=lJL2cNrDjFrjPsU0llNKksr7cN3OJIb/0bIGdz+F7VnldUqd2A5La8xcMpw4UvBP28HrPr0i4p23eAntv14p/73/ejLqGieKQvNoPWA0rRYEY/xh0kFpouPktCal278Fmk2dkERo7oH+VRm8YTdkfzXCEEfT7avfGSHxxdiYdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601979; c=relaxed/simple;
	bh=v6v9rdi0NaBtdH5uaFls6ao7F7yFXQTD+dGYq5SNjCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jcw9ZCWij4eEko27l8inG30gFZebbowQ81dtIRD9o6QsmBGLOpBmPYhu4Kn0XF898CF1x4uqVXzzfjTU3TF3yJI6gHB8z7yCq/ZhQXkok+k3JGoSBSe4sdVwJcnUe1K3km9kjg7hnr53qEV2X+kPjM3S7eNyCutSK1Fy7GGIE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=cifhY5Eh; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22007fe465bso3075824fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 17:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709601976; x=1710206776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCqXLrmsXLG2D4x9zpckaAUzUAFfK9PrDtc1e9Xqif0=;
        b=cifhY5EhNytLhBzxgk30+L6CSa5cj7d6FofP+C2wGnPlhaA+AgGbm3kqRkUTQ6fCK5
         bSoYCv7BIcgbg3fSVatw2sIaB9rf4DmXmz7RDVETD4/QwYDzgPrH0nD5Sqw+ddPaIKPx
         EeVpfn/GHTimTOCIrnv0A6i6uXV8dJdtwoqj47HW/ixcBwma3ca1H7Y0Wu+KZpP2MEEE
         boyxMYyRWBfi5VGjkLg5OwOsgLRPsW5Xuucrb6f2wuGj95UcH4KG4ds+yoQWptmWqDGN
         yVPCdkE/oAHYYwM3ZmBQ8leHLNHB0gM8xxD2sSA/fxdKbGnYD+4QxSYHDZQZ8hDdZ0li
         VgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601976; x=1710206776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCqXLrmsXLG2D4x9zpckaAUzUAFfK9PrDtc1e9Xqif0=;
        b=gedBB3Eu8i/IjrbrN75O4aSDJFgCMhM8zls6lw8+++nshD/GwtFnscrdYFKG7Yi9gq
         gubd5+YVXNaVsL5/gtFoSK53M9S0cN2T6FjfqWUhmnaQKI7WEHUgIUV5f6JBnRK1nbhr
         X0uC1pIQN08wAKGIW/0bu78/FSIQ/LhaWlXdrkUsB3IzU7I6gBUtJmmQbQI8hfEy6YdT
         TW7gexZjn0h8A+iTXNxdBauOIbDKHeJ5io0q+uEq2lXOOk0pcbdW3qMTEG/87Hcm0heP
         iJNmMP1UdqqdIZAStlU7zsRYtrrjWsKuqPmBX16pSkVamAPy9H54kN67nGWX36PEtBim
         Tu3g==
X-Forwarded-Encrypted: i=1; AJvYcCVfzwd0F9WxmZdpFb3/H9HspX7IbllSrXbpGbb2QeYfkG1XobxLfAvlyqdvMilsQrtwx5XYwe6wS8GgK5qX1IqnJ2hXmcWM3as33AtI
X-Gm-Message-State: AOJu0Yx/KJ2eZ3m5aYFKZ9ajVBnYRnyniDZHMS93jvDX8X7egAZ9M2b+
	fFoBnYLhTxwLopbwAtIgiWQrJ1wMlipk4rsriHY5mFxPW0TN82ElTXY3oGEhewM=
X-Google-Smtp-Source: AGHT+IHyQxOyfE25xAVDnFGbiegMVyflG/2eJe8BkB+GsFEu5dvJBtmADvmtxwigO1e3MzoCQL1vWw==
X-Received: by 2002:a05:6870:6c12:b0:220:c885:b817 with SMTP id na18-20020a0568706c1200b00220c885b817mr495468oab.10.1709601976584;
        Mon, 04 Mar 2024 17:26:16 -0800 (PST)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id ka16-20020a056a00939000b006e559c41679sm94655pfb.2.2024.03.04.17.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 17:26:15 -0800 (PST)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	hsinyi@chromium.org,
	swboyd@chromium.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH V2] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and HBP (again)
Date: Tue,  5 Mar 2024 09:26:04 +0800
Message-Id: <20240305012604.3869593-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current measured frame rate is 59.95Hz, which does not meet the
requirements of touch-stylus and stylus cannot work normally. After
adjustment, the actual measurement is 60.001Hz. Now this panel looks
like it's only used by me on the MTK platform, so let's change this
set of parameters.

Fixes: cea7008190ad ("drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and HBP")
Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index bc08814954f9..0ffe8f8c01de 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1768,11 +1768,11 @@ static const struct panel_desc starry_qfh032011_53g_desc = {
 };
 
 static const struct drm_display_mode starry_himax83102_j02_default_mode = {
-	.clock = 162850,
+	.clock = 162680,
 	.hdisplay = 1200,
-	.hsync_start = 1200 + 50,
-	.hsync_end = 1200 + 50 + 20,
-	.htotal = 1200 + 50 + 20 + 50,
+	.hsync_start = 1200 + 60,
+	.hsync_end = 1200 + 60 + 20,
+	.htotal = 1200 + 60 + 20 + 40,
 	.vdisplay = 1920,
 	.vsync_start = 1920 + 116,
 	.vsync_end = 1920 + 116 + 8,
-- 
2.25.1


