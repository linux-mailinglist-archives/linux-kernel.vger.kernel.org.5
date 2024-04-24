Return-Path: <linux-kernel+bounces-156142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E0C8AFE77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9CFB222D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174B12AADB;
	Wed, 24 Apr 2024 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="iPpR3Oig"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CC7868B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925844; cv=none; b=d53ZSL/cVbdKy7eX8LxpolXwFrTSDtoy6Gp0wK2f6MwBQpgC587CUQGgpuFIi/nx1HeTiReTlexlXh0rcVJAWjhOyN+UUzIjUOH0PAyqkGXLkEm1ssvhs2fPKZgxv662SkN3OTp7hAd6O4iX1B7j/2YvTr2MCJBVCkR2E981aW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925844; c=relaxed/simple;
	bh=4fLHwQPGk0QeNw9l9ZAq3BhROY3TA9pGgOZXf/44uJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3fmbzdR1dog4ebxDaz6hfTwBxJPFcgbUoylXNOYxkvCz+7K90JgC6v7I69XOoM0IdBgWbnuUx70+MP/gjWgmR+17+/ESf0mbU7BOYOVMlZywKuzNMBenTSqV936nTXA+R0PE8eWpon2vPhEIaRD7AxGJxm+CfIBG2D+1dd8bAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=iPpR3Oig; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ea2ac4607aso2980990a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713925839; x=1714530639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdgMcjk2SUhSnewSfUlS0/MTnaKK3tPj0hOvx8EtZQk=;
        b=iPpR3Oig3SF200Mp9fNpOQaa7Zmb7IKtPMk3nRr1LSDh0lsh+wie5HNUHPWu5DachL
         NWntQqo71MrUVAvu80EnapXQ7NWBXZj0LOAiu3ztqP33OpMIPqj3rch4/kLIk6r+6geb
         Ldq5Xc3j9BGqvw//hglHY4eDiKnGLTN6FrPsWRGPDYKy6E4h0lpFVPuewBxde06booGt
         8wu2i8jltTu2QbIzxal+jpUvHdQ9lcetYnLqoHEvkxju7hQWh5I71t0ijhhBCj4w6i37
         0MGlnd+Vv5hrYDNNg0qTDUKGOWG0wGgfHoim9x62104fNLWjGxi6OqWbfMVZLx5pqXlJ
         xrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925839; x=1714530639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdgMcjk2SUhSnewSfUlS0/MTnaKK3tPj0hOvx8EtZQk=;
        b=JgCg4wO8GHY6xvGsZ2WF/Tpt/bI2wZWA2Jev1nRXy8fUV4d0kC5Nhp1owVw6Gx0KbQ
         zRcsP7JU3HFZbJCD33ui6jiquk1rWgbgoLdCvZe2HCm0XXJDqKCuACtRwH7GmI2rSnOy
         mz4fa1iz/1y9zVLkJZMuiZt/Mrd/gpHF1mKsnCGQ7c4m+7uEQ1Gu6GFxtQtQYGXKgHU1
         ARcgNDPrRcoJk02X5IKSmiKI25JvcYPrw6semEEo06/Tc8rrWhEHjidXymJFC6W/sk14
         xJ6opGBIfq3oovj5SOXiNqd+9Ew77STZvMV88jAW1J4sn+s+7poj8ASLTZuCVmefXxSk
         4OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIQuXVwEQ+hFaYjTyReswTJGQP+eeUwfFBBierO0nvS5g03LzQcMNcDVAXDyV+CqUHg49GBwS2NNFbaF3UoN8c5GZ1qlDVS4h4SlWO
X-Gm-Message-State: AOJu0YwjP4cq7DAo1ufChUK6ME3qz23NCXFUVugmKXtJ2LP5+bllIdLz
	xlQEgfAtN5eXaINQDzXe6ejESOVzNzUe+Gnpiy8L6v1/8FK+whBPKtkhmm8TTcI=
X-Google-Smtp-Source: AGHT+IF+H/psnQOqgjI5FBt3w3oeQ9GZc171xd/LPRweALS55ze4i2g8pxZNH9RrfxIpXP9njz3+nQ==
X-Received: by 2002:a9d:6d0e:0:b0:6ea:126a:bbd0 with SMTP id o14-20020a9d6d0e000000b006ea126abbd0mr1542792otp.14.1713925838979;
        Tue, 23 Apr 2024 19:30:38 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm10179385pgd.56.2024.04.23.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:30:38 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v3 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
Date: Wed, 24 Apr 2024 10:30:06 +0800
Message-Id: <20240424023010.2099949-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WUM_NL6.
Since the arm64 defconfig had the BOE panel driver enabled, let's also
enable the himax driver.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..687c86ddaece 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_PANEL_EDP=m
+CONFIG_DRM_PANEL_HIMAX_HX83102=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
-- 
2.25.1


