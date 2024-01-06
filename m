Return-Path: <linux-kernel+bounces-18710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D4826177
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC2F1F21F1D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0FF507;
	Sat,  6 Jan 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAAAo91a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933FF4EA;
	Sat,  6 Jan 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so71605e9.1;
        Sat, 06 Jan 2024 12:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704572852; x=1705177652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qZcxiKBLoslTbSETaLsQdzVkOAcIfS6HTz3Ex8jpyI=;
        b=gAAAo91asu00xcGu9p6IfphTTFcXnYgm38pgjgwNEv7VzEG8MtWyUtId7CNyzk/xLY
         0APuhFTAjR5iy38xQJaGZZyJGkvTQ87kgHaw2gjnhgx5KMDmQdOSSP6ZT3E//AfNkfP5
         EmlfBmTBUFN1aT5cmrUAO9M0GfTcl7WCk6lxIEpm1fOgDRb7vUHbo0GDMBSEsTShn5v5
         /V9iPAh955zDxzjPd+bYxtQdKFaScoJW2kP0wzlmJoAouW/0DxYpTLzMjGnZaTnzdwtj
         Ekd5+vQSEMfQ9BOmVATU6Z4j8vmefnrr4LwXbZWGRTk9wAe5AO2yoByFXg7E1puvRVrf
         7Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704572852; x=1705177652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qZcxiKBLoslTbSETaLsQdzVkOAcIfS6HTz3Ex8jpyI=;
        b=H86PfwMZY653/iM3jPZRFBYURw8i7zlO+1RcWGuIpckfIn73sGHzx+GFXX8ChoJb5w
         5ISR397NnbpZnQE8laSwZJRBu6FaVt5UaCIZIOP77odvLcvqs8u2eD28QA/tS61yRhZB
         jchauQXDAlZ1FVrDf6p2gL1r97mQb6GX7gmbxtW9bDxoZa9l4SyTi8zKu81CdSKVvUUS
         XXyooKC0ASNmXjbJ+U2SEie7F+I6j6gouZfJK3gBvfLlbKT0XRco+/MDvAA66/pPOGXj
         FM4XTiAwYxS0PHbWhrxHguPIyAV2jdGIuAWVPptEfKFHY224VdaPBWQHxAbt7ln5rRti
         3DzQ==
X-Gm-Message-State: AOJu0Yx7ZruK/2AjvzDcfEsi1OhiTxH/odLJF9Ph1tqDf2oLMsNmiDEP
	iffdkWC1ReFiVtW350PH+H1TbGNFrzR9rw==
X-Google-Smtp-Source: AGHT+IF5iAofWhWU64cSQMRwO2U7enBcruZdFFzhEg/Z1fcKWSrXAkhwpvhmzOYS1vOSXDKhsckfwA==
X-Received: by 2002:a05:600c:cc6:b0:40e:3ce8:a5be with SMTP id fk6-20020a05600c0cc600b0040e3ce8a5bemr695925wmb.164.1704572852308;
        Sat, 06 Jan 2024 12:27:32 -0800 (PST)
Received: from latitude-fedora.lan ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b0040e418494absm1707955wms.46.2024.01.06.12.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 12:27:31 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Christopher Obbard <chris.obbard@collabora.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: add rfkill node for M.2 Key E WiFi on rock-5b
Date: Sun,  7 Jan 2024 00:26:45 +0400
Message-ID: <20240106202650.22310-1-alchark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default the GPIO pin that connects to the WiFi enable signal
inside the M.2 Key E slot is driven low, resulting in impossibility
to connect to any network. Add a DT node to expose it as an RFKILL
device, which lets the WiFi driver or userspace toggle it as
required.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 741f631db345..a5a104131403 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -59,6 +59,13 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 	};
 
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-pcie-wlan";
+		radio-type = "wlan";
+		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	};
+
 	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-- 
2.43.0


