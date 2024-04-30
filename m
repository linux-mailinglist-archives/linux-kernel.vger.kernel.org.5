Return-Path: <linux-kernel+bounces-163270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D38B6808
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF680282A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBDEDDD4;
	Tue, 30 Apr 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJg4OugD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D4D529;
	Tue, 30 Apr 2024 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714444871; cv=none; b=j5TqzLrhMc8UOmv8gf1fSM7hgjXvLQKC0mO1t0b+UkcV3OWGUDx1MfCn/D92D/Wo7sXPcgJvdeQe0IYeNC3MVRNq8nYRJOBT91kl17XIKvAn3hjRaN9Dzy5XeOg437RqnldHONttJH+FBs4VxdcobP+71kN5HiXGn4t+biIeOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714444871; c=relaxed/simple;
	bh=xfXA+XYI4fplRPgwcNuRoQF8Y24bz3B6Mi80kAQVs5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gja77Jd81NLW1rSsab4fNgHGtXEvbOk8FFr/gY/6ay1hXd6HoA/VIIP66jTur7jC7WOSqtrj5ssGrvkpIF2yYjP5xIPECy7INCdP+oEVqUwlmf1Zd1mGNCdvQcAhHhQkv6QD7Jz8hBYDCvlULu3iyqC3sfhUrWCCAxMwRMtKybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJg4OugD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e51398cc4eso46663645ad.2;
        Mon, 29 Apr 2024 19:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714444869; x=1715049669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eso4ARCm72QdAVSfiatUmFnG0dBC92pYQJkl3ko9Fxc=;
        b=FJg4OugDzxhPLZWJA0ArRqHPpuQg5V4N8B+CZLZdoT0kELWTAwoFllSVxEPbmmEIBK
         4TbAk9PKi1RCRDHJnJlioKaAWr38QQG1Ede4FGP2yYAkOkqY9PEn9QY9BwCTeEHL7snp
         6lqOr/basfSKt64qduQTM/3hcda1hBcdtSxPBHtjl7aQp3RrHzfEh92SScQTOBRb03Q3
         UxHUZDj/b3AfMzzbh5TWZzVRE3RgkQTi26LYyjiiBWcEyseDrBb+YhTJhfL/PUmdaxKl
         3FgesCT0qpaf9WuzpAXqp09Rnx12lwS1xJUOeEQFapEL0YiPUIVukLerylwskEqr1qUZ
         Wt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714444869; x=1715049669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eso4ARCm72QdAVSfiatUmFnG0dBC92pYQJkl3ko9Fxc=;
        b=D0X/WDFBl/y5azONkbIS15cNZ5TKaHUIRSXcBQwaH97WzUdqrHSpJGWGV5gwg0L6qX
         OPyS39BqbGy92OV6JoMcCQaJnGXU8dsMcPmjPpww1DpAhsxtDM/BtHhB78hWR0ACMrnW
         xam+rZpRTdiUgfzNXLRkAWCBnu/rJyYQVzrWp03Oq+S8Wbli7iI+NloShCkQhN3vCeGJ
         asN1B5MD+0fYCX5d/+Pjcmpli5tGnEEXorL4JGIoBn6txGu7Mk2cWXWmYQJXvy3ZvxnO
         M5Q4aXpDEaeMta/hpSsGbMHdRu/LDYGULz1Pkvotu5/fF7AVl89t07ZSs2O21GjSHKqK
         OQNA==
X-Forwarded-Encrypted: i=1; AJvYcCXEyvNpvsMfL0K6dPUITG7bNp0EkVZhoAVCGQ7jiuW6dMAGURhbwafOTIehqZf7zbedsKgcpcbZ2B+A5O7XTDEDG2Z9oVBAwMvSdHuh9Fu6nUBM0XyUClbdzNtD0UmdS3GAV3VzDiMiLw==
X-Gm-Message-State: AOJu0YwLpA0g83rwpbhZ6o6P6CcLbFpJUVWJLdT7WpfdQyAPlAa+Yap1
	+E4D104pTUEuahWfQwHzCCOKVATIxENV8zLspSV/DQHhOxh5ZzWuw2DrUrNZa6M=
X-Google-Smtp-Source: AGHT+IFcX43HEpbg0J5y68Nceakg6ZWP+vZGNSqE6JNf4XEeKnHfyk4h8JG/DM/CW+eONVEaJV2mcQ==
X-Received: by 2002:a17:902:f648:b0:1eb:7ba:a4c3 with SMTP id m8-20020a170902f64800b001eb07baa4c3mr16274996plg.48.1714444868887;
        Mon, 29 Apr 2024 19:41:08 -0700 (PDT)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001eac94472f6sm8400379plg.93.2024.04.29.19.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 19:41:08 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	sigmaris@gmail.com,
	nicolas@ndufresne.ca,
	linkmauve@linkmauve.fr
Subject: [PATCH v7 2/2] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Tue, 30 Apr 2024 10:40:02 +0800
Message-Id: <20240430024002.708227-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430024002.708227-1-liujianfeng1994@gmail.com>
References: <20240430024002.708227-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Hantro G1 video decoder in RK3588's devicetree.

Tested with FFmpeg v4l2_request code taken from [1]
with MPEG2, H.264 and VP8 samples.

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index b0a59ec51..da10df7d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1135,6 +1135,27 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};

+	vpu: video-codec@fdb50000 {
+		compatible = "rockchip,rk3588-vpu121", "rockchip,rk3568-vpu";
+		reg = <0x0 0xfdb50000 0x0 0x800>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vdpu";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk", "hclk";
+		iommus = <&vpu_mmu>;
+		power-domains = <&power RK3588_PD_VDPU>;
+	};
+
+	vpu_mmu: iommu@fdb50800 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdb50800 0x0 0x40>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		power-domains = <&power RK3588_PD_VDPU>;
+		#iommu-cells = <0>;
+	};
+
 	av1d: video-codec@fdc70000 {
 		compatible = "rockchip,rk3588-av1-vpu";
 		reg = <0x0 0xfdc70000 0x0 0x800>;
--
2.34.1


