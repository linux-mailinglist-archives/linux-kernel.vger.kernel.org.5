Return-Path: <linux-kernel+bounces-142184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 961558A2893
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE05CB21CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915C4DA10;
	Fri, 12 Apr 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aeLZh0Vx"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5414DA04
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908524; cv=none; b=ij3ft1JdUgU1WeEolRqELGSAqZkuuzYJyR95nuKUEyrYTmXOC5HzF6dALxHwh/MlwasAwlov3SJyv9vDcxSngcScteXg2ijzwPmzQLfqkHTc32jJSDlsPeSteiw7XPV7OByLrsWB8ig1sTFU4dbLkLQSY9JlgL7H56QVpNp1CPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908524; c=relaxed/simple;
	bh=h/mnaTxvIYTXlw1hUjjSh/ba8UQQ+pFVoTTvYSSuFSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYSb9pLQ27T7rpidyxlqp1xbXrJKmFgfpVi91/U4SwkRrWkrecBXlwMeoJgKNFSH46MESst4BK75NXE0nflXet9URaDo2ets4n/3Um6u3Rw/i6a014Y4ZJeaSnHJQY/EHPTRZ8S9OJ72CgKREqWg+LCZF0IqLD1+geH+A7PpN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aeLZh0Vx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e419d203bdso4690935ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712908521; x=1713513321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoKTfqB+9Kxj81GfGGjmk4oDRtO/OYcUX57xxWs37P0=;
        b=aeLZh0Vxx7mR+IQbk3Tzje00RQuFn5iJ7pls7iF2CRA8s7JEKkqH9ufXbj2l2KILzj
         rB//K4KAORFYR3kgapy5YseGDz/R3Xes0XqDLvoKNVBbhpGuxAuZn23Bzs4x3HshcuSc
         L38YFAuo2wK5HGPqp6m4n+LFnVPlYse4Zp/m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908521; x=1713513321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoKTfqB+9Kxj81GfGGjmk4oDRtO/OYcUX57xxWs37P0=;
        b=j8NioC5UcUogG/qeRuC75/SIuhqp9AbaEBwjo4mPX+31IOucH+2EVarZ3W3rasWpQG
         Zefem6wnOQ3KL0eeDcA3apUiOPy+bGxQSWRnQETDpsWCgKtTiKWy3Ae7KVqR4LU19QFU
         cd5D5s7k5LPI/V7gQcsaZjTe3eD3YLzQYX55sjtmXeiTTs0ZKV+RNQ3EFtfLzHYzO28s
         ml5J2o8FEctU8v2t4PbDVLmFtKhfyzyAKqd9Qc+WPQ+cw0vbFnSxxM8D0nk1OCgaX9ji
         G39DLa5OXQVxIfPnxPJsQfDS8IH7AzznTtUu18xO2u9jQ0sybxcHN3LFuFsVGWH4+0oZ
         I2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWVVPBnxHqq/aOAoIU/OK90IvJJDp3W6wlmZKxGmC+xaS4NYQA/0i0Z6s8lvq8FX8mvpGgnCOi+nHZ954XJh2kLvqp0kPD8i/1ohF5R
X-Gm-Message-State: AOJu0YzR1N5mR0j2hFpaanwxNXJrRSifToim7ot1QUeKOD/ZKaBzGsQ4
	Uny0Svc/8HgRHJm7jcSwBjzfv0RoZGkwKo3FE+llSiyyYic85/a0zAYVfRxaLw==
X-Google-Smtp-Source: AGHT+IHE2tYRZruKtCquqvFgIZalHtBB+3XJOjw2G+9dr8fCHuWkp9Xv3DSW1Uvn5QjEcWGx8LbRnQ==
X-Received: by 2002:a17:902:e950:b0:1e4:b1a2:b47a with SMTP id b16-20020a170902e95000b001e4b1a2b47amr2262198pll.0.1712908521272;
        Fri, 12 Apr 2024 00:55:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e3c8:6e1:dcfa:3e8c])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902868300b001e2c1e56f3bsm2377710plo.104.2024.04.12.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:55:20 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: Drop mediatek,drive-strength-adv usage
Date: Fri, 12 Apr 2024 15:55:14 +0800
Message-ID: <20240412075516.1199846-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "mediatek,drive-strength-adv" pin config property has been
deprecated in favor of the generic "drive-strength-microamp" property.

Drop or convert all instances. A value of 0 disables the advanced
mode, which is the hardware default.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts     | 6 ------
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi  | 6 ------
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 6 ------
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts     | 4 +---
 4 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 681deddffc2a..f04baea5d6cb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -160,7 +160,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -169,7 +168,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -178,7 +176,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -187,7 +184,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -196,7 +192,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -205,7 +200,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 75c799a6adb4..989c979c99c1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -527,7 +527,6 @@ pins-bus {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -536,7 +535,6 @@ pins-bus {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -545,7 +543,6 @@ pins-bus {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			bias-disable;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -554,7 +551,6 @@ pins-bus {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -563,7 +559,6 @@ pins-bus {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			bias-disable;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -572,7 +567,6 @@ pins-bus {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 333c516af490..81f6c205fa98 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -197,7 +197,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -206,7 +205,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -215,7 +213,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -224,7 +221,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -233,7 +229,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
@@ -242,7 +237,6 @@ pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
-			mediatek,drive-strength-adv = <00>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
index 341b6e074139..83456d649ff7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
@@ -74,7 +74,6 @@ pins {
 			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
 				 <PINMUX_GPIO9__FUNC_SCL0>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-			mediatek,drive-strength-adv = <0>;
 			drive-strength = <6>;
 		};
 	};
@@ -84,7 +83,6 @@ pins {
 			pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
 				 <PINMUX_GPIO11__FUNC_SCL1>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-			mediatek,drive-strength-adv = <0>;
 			drive-strength = <6>;
 		};
 	};
@@ -94,7 +92,7 @@ pins {
 			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
 				 <PINMUX_GPIO17__FUNC_SCL4>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-			mediatek,drive-strength-adv = <7>;
+			drive-strength-microamp = <1000>;
 		};
 	};
 
-- 
2.44.0.683.g7961c838ac-goog


