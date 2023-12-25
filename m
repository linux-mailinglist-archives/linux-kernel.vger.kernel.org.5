Return-Path: <linux-kernel+bounces-11182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6031981E298
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3CF2824BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F651E52D;
	Mon, 25 Dec 2023 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYcuzIjY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D111D68D;
	Mon, 25 Dec 2023 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67fb9df3699so21491886d6.2;
        Mon, 25 Dec 2023 14:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703543554; x=1704148354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9AXVgWVsZaXTaZ2MYrLDbeRzFgb65vHx3yvBMYSyN7I=;
        b=mYcuzIjY7U1Yq0FYAej9TdHfSwMrRKFTXh0339yt9qTkQw3sV/DIgmT4k4fZ5eJJAd
         Hr1HoqCJ0+NGYe3inBZynkEYaUt7fAtEdLUeSrfmm6EfjnamPODVIDwYqWGpUGFZcqJI
         88xKM5Zr2PYPMTa0nZUwhrRurhpmcndw4MF931hmZPYcBi0+dbG8Dcybape+xWo724I0
         nz1PEd5BadRy7BgdWBwJuk5aq0e3kNDsiK1xabnkz3pfZC6AAjzQ+heBUfx1BAU4TkFY
         gg/aV+dSIbkLLGN6sYKHypdSURCEjdExJ+GLdxZG1ytS5DLQTuA7YLwFxUtJvE8qh0wl
         vrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703543554; x=1704148354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AXVgWVsZaXTaZ2MYrLDbeRzFgb65vHx3yvBMYSyN7I=;
        b=ATXBc/DtHdLuOxFmiWQ68F0gG6LIuaKusCUanaxpGzTVbpkaNBcKR74R0hIbaPYGAx
         sRYFnG/EGC5ifacg/Cn+fLeBt4RQwAGMQOG6ddKO1xdpBVWgaICfxm0cttbzx9Qmac1X
         fDmL9RTBqjlJ4hTx603lguTy04DHXpGr79ny6dX+ztSpdtmY4wEmkkxeXMSplDWR5Ez4
         jCCdJZk82YTXC03Ay+3cw/d0/ntTB7U1bzR+8s8vu/43Bin26N+dQSRGZ+GeOINDirjS
         2nYiVENwMrPO/TLuFqETAh67BdyMhh2mAKZBIdYwArEAJCB7UINdF+iTCO1n8XftOucY
         OFBQ==
X-Gm-Message-State: AOJu0YzWBj2U7dsG6oI2brP84cFTT/iI1NVtChF/qJa2lA4384cN5xpy
	Z3Udw7qcDulhZwwma3uQBWM=
X-Google-Smtp-Source: AGHT+IF525M1SC2MBZdNWTYLYvaOFmLvhK/WeGaLidoL7771wvZqYFubfDK0gB87y3l2paGzoVQTMw==
X-Received: by 2002:a37:e112:0:b0:781:c38:8e60 with SMTP id c18-20020a37e112000000b007810c388e60mr7727978qkm.102.1703543554520;
        Mon, 25 Dec 2023 14:32:34 -0800 (PST)
Received: from localhost.localdomain (107-015-241-140.res.spectrum.com. [107.15.241.140])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b0077edde498d3sm3856151qkb.89.2023.12.25.14.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 14:32:34 -0800 (PST)
From: John Clark <inindev@gmail.com>
To: "Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Heiko Stuebner" <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: "Thomas McKahan" <tmckahan@singleboardsolutions.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Clark <inindev@gmail.com>
Subject: [PATCH v2] arm64: dts: rockchip: correct gpio_pwrctrl1 typo
Date: Mon, 25 Dec 2023 22:32:16 +0000
Message-ID: <20231225223226.17690-1-inindev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both rk806_dvs1_null and rk806_dvs2_null duplicate gpio_pwrctrl2 and
gpio_pwrctrl1 is not set. This patch sets gpio_pwrctrl1.

Signed-off-by: John Clark <inindev@gmail.com>
---
Changes since v1:
 - added commit message with additional patch detail

---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index 0fc48fb0d34d..e83b71510a47 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -591,7 +591,7 @@ pmic@0 {
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
-- 
2.43.0


