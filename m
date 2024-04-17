Return-Path: <linux-kernel+bounces-148051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C670E8A7D13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6461F214AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB976BB21;
	Wed, 17 Apr 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D+QQ3u3C"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341E6A8A4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339107; cv=none; b=WNZL8NjMF7skloEmfpDJIf2Vo8C0oJZ1Jr80iNlFioXT3JvdkhjihZeucyCM/DihBTG5S2MQsk3eQAC6E2RzgZtcE72rPVbtBe+0feiK0VRQjN8aEC6tSz9GRG37M5qU50dU044WjuwW1OKoaX5MmYpXUabQnicrTeCsvyGKS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339107; c=relaxed/simple;
	bh=egKjOTjN1NuR2HibTR7hhA+DkHBoexwK+DJA/m/a18Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KryrQozTV3nUX8k8YVWxl3EjvbSOu+w2b/MJUn5GXzPXgikg5nJt4NCMk1+I/OUhhILR+r8SeEYHSoth3YJT3DVSH7n93tpofcfT/qVWXnG16bKGii6P95aJ/KzLIL0QToQlWht31aXeQTpgqNKdOD85avg4l07ooUrlmaRuCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D+QQ3u3C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5708d8a773aso87144a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713339102; x=1713943902; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHpdxbgBqbjjLw3ojUZ8P8pYWYlVPMw1tpCYeedIry4=;
        b=D+QQ3u3CLjmqiKmXi4TMUrl3EqZ5zZU8HbTiuXpLnf2G/q5appFlbd3e84L6AKFlkH
         qg2kTXhfHkyd2QgpZ5Deqv7up9vMn1rZhrtupFnVn2kxPFe4XluQi/GFipdT4Ks0p+Qz
         +UUIGLILWtFg/Tl9UbGiaXgPDBxkfxUcFOK4+MelNOPvYX+LXuq9mOK/i1yNkr1gNj9B
         32G8tR3lF9gdAYbEOgrkxQic81/hfS+rcOwFNcgbfGC2DyayfiPYM4OnuOB8CFXqEvxg
         QyvL1veqKPr8YPo66kZ8I6c4uczRYUcLYAGH6rWejDWK8qtmcXHzKPx6E5eJDy5lxHYr
         9SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339102; x=1713943902;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHpdxbgBqbjjLw3ojUZ8P8pYWYlVPMw1tpCYeedIry4=;
        b=wtNy/s+4eQrSixJvTMpuZSy3LxUFf/m1deuuq5SlwlDjVLdhSyhFhKRI5PFvlOLy/V
         KtZsZzi9ts756Po6cTeSyi5ct2T+HylvRDO66XE2FVzzK9E209Ji4vpd9aTs6N6HCGKi
         eRaXDmPqXHIxH5MyDSycwd275GT6Do2GNkvU3sh3nLjaFg8pdEDq0zY6H3GpSxSlj4Jv
         s/WPj7a/McSp9A50+KqFBChdwg9GRDhUw7Qd0m1jd94i7e+ktNhYwqZ8+L/ET+YQ2zbv
         MFQvwF8phtlJ90AWDob2ktV1oNsnWuycW1cZAi0YkK6oJoddLldunoPDayYg6HR8THfq
         howw==
X-Forwarded-Encrypted: i=1; AJvYcCUd3DvHUJFLlpONKvKYPHONMheG7h2AQOTfaMiUWyWrnr5PmrELAlqfusnZHibn22Iz9AutxRypaAevnDdLViWbaD5lU1sSkKroDn1+
X-Gm-Message-State: AOJu0YwlV3g/OLHqa33f57JadKwI/vZHVKiXEd+DTytNy2RDkyOd5LXY
	Pzp/0Y9gxqnW8ZBljJkQUuDjcpxy33AfDCw4JMBpPlo8bWebiBOolOQ5G/jgyrk=
X-Google-Smtp-Source: AGHT+IFvAhadrzFCRrSpUW8E3Bm/aiI3YT8XkF3xXVc+nLVwbcIdXh+dGQ+6hpVt0PkC67qGE3VWPg==
X-Received: by 2002:a17:906:3756:b0:a55:3240:ba3b with SMTP id e22-20020a170906375600b00a553240ba3bmr3748747ejc.8.1713339102044;
        Wed, 17 Apr 2024 00:31:42 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id en5-20020a17090728c500b00a51b8e8c8besm7811373ejc.86.2024.04.17.00.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:31:41 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Wed, 17 Apr 2024 09:31:41 +0200
Subject: [PATCH v6] arm64: defconfig: enable STARTEK KD070FHFID015 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v6-1-9443e0c826fd@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANx6H2YC/4XNTW7DIBQE4KtErEvEjwGTVe5RRRUPHjWqY0fgW
 rEi370ky8iVlzPSfPMgBXPCQk6HB8k4p5LGoQb9cSC+c8M30hRqJoIJyQzntEwuT/jzFVK59W6
 hVrVBaBU1OEfqClxBCtkNvqu74bfva3nLGNP9dfN5qblLZRrz8nqd+bP9/2DmlFGupeUGMMhWn
 cEtfYKMRz9eyZObxQ4hKtEa8AYCeo12g5A7hKxE8G1jUINUFjaIZodoKhGBByUhBox6g1A7hKK
 cGi+YBaWZj+GNWNf1D32nWxrSAQAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=egKjOTjN1NuR2HibTR7hhA+DkHBoexwK+DJA/m/a18Q=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmH3rdjzZZ4sen02dFcQJ/1ZIBh++tmRptfxge5qOI
 9FSMOGuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh963QAKCRArRkmdfjHURfDTD/
 9S9uQ+WvVwGRqCy3m3DuKrAU32rZZzeV7Ky9vnpm5YIr64BjjJ7GxUmRyCN6oNUXW+B5KYtVvEw7tq
 SJGk2bW+zKUQfH9B46CHn62r/G6HK36pnvTywVNIE3DOzdwRsMqY+8dgrCJ5xyOCtNnd4BXX9Y6bQV
 1yUBmf14L05qD3qcdgtb0mB4ouJ9R+K5DKsI4Vu9JsCl1ykqwfwK+WFBJjtnoyqySahrdDC/QFAZB6
 24+xOpxlqwmMDyyapoD7LRZj52m5BRlmcg/mHRzWLRidU1gIgdbXOQy8G48sWZoIRXU18GoH+Tzi63
 XUFm3+mlEMrKSkgziw5RgQ+KY8NRHCyQ8a5ChjMZsnFb+0jYyQ4Ruq0NDUaMh2Hl3KGR6c4mG4XnMj
 RkoGlPnZd7F31J0UKJ1lmhWQ0qWOjrK55o+vYkeIbRAiOtqiMWYIS5DGskSa8PvbprJC9HeiwSvYjU
 IPG5H+8AHos2mfAFYGsOv24c3UKafAFq+M2PBbVECNSfIQ2NIiVoYB9lKi7eN2XcsESmivdvTvHWh8
 d+yDoSJx2L13EFgBco9iRmzdVWXdqSapQKXciTSYdK6APK8pSHuniZVLsfdplhBJw+M8IXrLxVznbf
 BaVIH6qfhqG0LPj90Pb6Cr+YeIY5DjfgEEpqYMBEVkh6vVsKZzXWzbLCf0Jw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Build Startek KD070FHFID015 panel driver. This MIPI-DSI display
can be used for the mt8365-evk board for example.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Add the support of the Startek KD070FHFID015 panel.
It's a 7-inch TFT LCD display with a resolution of 1024 x 600 pixels.

I use this display plugged to my mt8365-evk board.

This serie come from a bigger one [1]. Then I addressed the previous
comments for the related commits here.

[1]: https://lore.kernel.org/all/20230220-display-v1-0-45cbc68e188b@baylibre.com/
---
Changes in v6:
- Rebase to 6.9-rc4
- Link to v5: https://lore.kernel.org/r/20230711-startek_display-v5-1-7c209b560cfd@baylibre.com

Changes in v5:
- Rebase to 6.6-rc2
- Remove merged patches: dt-bindings and driver.
- Link to v4: https://lore.kernel.org/r/20230711-startek_display-v4-0-fb1d53bfdef6@baylibre.com

Changes in v4:
- Remove useless function: stk_panel_shutdown.
- Align parenthesis for readability.
- Link to v3: https://lore.kernel.org/r/20230711-startek_display-v3-0-dc847e6b359b@baylibre.com

Changes in v3:
- Remove spurious line.
- Remove useless ops (enable and disable).
- Remove brightness value init because it is set right after
  using mipi_dsi_dcs_get_display_brightness(...).
- Link to v2: https://lore.kernel.org/r/20230711-startek_display-v2-0-87bc7bdec6e9@baylibre.com

Changes in v2:
- Replace "dcdc-gpio" by "enable-gpio" because this pin enable the
  Power IC supply. Also, this property come from panel-common.
- Remove height-mm and width-mm since they are useless here.
- Re-order elements in the stk_panel structure for readability.
- Link to v1: https://lore.kernel.org/r/20230711-startek_display-v1-0-163917bed385@baylibre.com

Changes in v1:
- Fix typos in the driver.
- Merge 2 regulators in one bulk variable in the driver.
- Remove backlight enable/disable from the driver because it's already
  managed by the backlight core.
- Move hardcoded values from function to the generic structure in the
  driver.
- Remove unnecessary function (stk_panel_del).
- Replace some functions by macro to increase the readability.
- Link to parent serie: [1]
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..fce98a150014 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -868,6 +868,7 @@ CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
+CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_FSL_LDB=m

---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20230711-startek_display-958d265f6baa

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


