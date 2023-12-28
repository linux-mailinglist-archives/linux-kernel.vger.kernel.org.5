Return-Path: <linux-kernel+bounces-12599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15CE81F76D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821621F21D48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453116FCF;
	Thu, 28 Dec 2023 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fZBk20e2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6C6FC3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d4751dcb56so8580055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703761049; x=1704365849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snYrry9zLuh+jWtvPEimeAzwraocI1J6hz5mOunhcYM=;
        b=fZBk20e2nKa6rWmA3/7Vyt2SxtfIPDgl3TUA1cd59pOkHyTP76UsPINd8B1+G0a6AL
         iOHNGlpn6BFUEW9bJicVY+jYW2nwF6t2iug+gACEN6siVT38tTO0/dJujeH2sTqtVO+G
         29zOkTPee3CwuJvQv0TWP+2DL7s+gYuDP+p6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703761049; x=1704365849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snYrry9zLuh+jWtvPEimeAzwraocI1J6hz5mOunhcYM=;
        b=Eax8g+2b7fE43Uxhu8SbhY9tkBv5Rk+W+XQwVTkWknB3seYxdsi8z3wEvy5fUkJ5EW
         uJjdeY8vKcTNFknRGrksbzTLETUb8l160JCmE4Qyvb20P/uZAozLKpuyjSixJeJR4ycw
         g2p4ucmKzTy66GxoeB8hcjYx0cm56zVdRhdyOM3iRi63XGb5HWmbDV9L8N1GugXqqSDC
         0tacOy3LB0Yj8rMzTmOSB2cqrMtGHT3n3OMqscKRsIWqB76IbANUiUaY7YhdMl57K8Rk
         lKga4oKHr7bxfwHX1S0hMp+pyybghJudlanUxJCjbYWJVCpp8Lq2N1V2i0m9jtbq5OKo
         xgzg==
X-Gm-Message-State: AOJu0YzHegITmThw0P+CLW+gNMTT1LG3ktU39y32hyECz0qGc1H08Lie
	/PdEQyyf2BkFf/nx8M6QnaVnlBKELnFr
X-Google-Smtp-Source: AGHT+IFYsn9RDhTGSpo0c14KN3+HIjTHoXc3vMmiykGJJrVm4NBUKlRdW2Q19ABY3KG4K+gPwIsavg==
X-Received: by 2002:a17:902:b58b:b0:1d3:442e:f0a2 with SMTP id a11-20020a170902b58b00b001d3442ef0a2mr5009163pls.139.1703761049479;
        Thu, 28 Dec 2023 02:57:29 -0800 (PST)
Received: from yuanhsinte-p1g4.corp.google.com ([2401:fa00:1:14:497f:b57b:3927:7371])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902aa8e00b001bf52834696sm13542193plr.207.2023.12.28.02.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 02:57:29 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND v2] arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
Date: Thu, 28 Dec 2023 18:57:01 +0800
Message-ID: <20231228105717.719624-1-yuanhsinte@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The external output reset signal was originally disabled and sent from
firmware. However, an unfixed bug in the firmware on tomato prevents
the signal from being sent, causing the device to fail to boot. To fix
this, enable external output reset signal to allow the device to reboot
normally.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

---

Changes in v2:
- Limit the effect only on tomato.

---
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 2d5e8f371b6d..a82d716f10d4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -23,3 +23,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 2586c32ce6e6..2fe20e0dad83 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -43,3 +43,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index f54f9477b99d..dd294ca98194 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -44,3 +44,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
-- 
2.43.0.472.g3155946c3a-goog


