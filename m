Return-Path: <linux-kernel+bounces-142187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27528A2898
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B8C1F24E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7224E1B3;
	Fri, 12 Apr 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BdtJWDTj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB14D9F6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908580; cv=none; b=P1kI1RQTJaTsuI0whFWm4H4U4xCEcQytiB9+HhF09e8qTq0ibuwp/kAJWj12uWjtEQQbR413ycmMWAow8gap7TyioQP9+c5HTD5xwN44e7H+Ku+LdosdppnAleB0DgJdkg4KaR9/5OoHLxOpLzaH6mC/O8XjGpENeSMRGpkApE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908580; c=relaxed/simple;
	bh=JoYL04ALanw2VsbDpSLIZJX1t8kW9YWCZT6CNOsQYOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1GrDx+mkroXTmxquTCLHI/CV9o3ORv6B/aNXsOPotZaY3E8t10rssnWzfv4WHMexmYaAWLJWICLteOZqhtFe/SgMBiHA+TkH1ZTXFokreeql1lAX0RthBtF5q+zjeadv/GpG9/ZP/Jj470uPRwbcok5VH7jBfp8E2K8K8bzKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BdtJWDTj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so627936b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712908578; x=1713513378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxWqscFAwOXHq3LZxwoyO2yB+rY65Bz7waDbYHO6nwc=;
        b=BdtJWDTjWiYu7NRwZButqfeg1IuRo4pxtD9fzpG1klqTC5x5l4eGJN+M1YMqXjov7m
         4a0DO3CTF2V6RZsPRZekvc/yLWY9UjoysXKhhK4fR2OdZ92aaDvZRLHJrQebMsnoRHYG
         ViRG1kR+mEOFApw3V9/642Rwf8LqFUAEXcQb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908578; x=1713513378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxWqscFAwOXHq3LZxwoyO2yB+rY65Bz7waDbYHO6nwc=;
        b=AVqTJjnxz9BCt5FwwWTAvKxnL4IyFTzSt1yaBFO9HdOWFpIa7+36kukeGGOdE5pVqk
         SfY4hiJjP2YdWvb2m90A3W24lEH+IQGOdFUkkGDdtqfMWgMp+16T3wTuf3JHxnTnSPu4
         xZzD/s3ricQjxVfZ+tBxZpUbqrhd7wl9ZAbBLOXOe70P6mQR/GRDCXT7BBfHIocN55t+
         nvZcVcWcVwt8tjeUk3K/6Ow4jYqh2CL+tNGSu4cF+kup912xFKUCdZ5OmdUy+qOHVSjL
         KlBngy/xkr8yeO0lSbm5H+aN4i1eXej3l1MFzz7DnXKiJRCdvtnEA4d9yV6WZHBO/i8z
         s/cw==
X-Forwarded-Encrypted: i=1; AJvYcCWaDfDE7wvWoGmlw5cITmHH7DGCWzgLpfxqyjwmERzyXOXYV/J4CrI0hGhmKj5ZVk4X1f86wHGIEW/qW/Dgs5hu9j8KG3cbyBKYXaik
X-Gm-Message-State: AOJu0YxCmyOw8t8BB6+2FaujTH6t2ukibQ9VcyPg4Mf5aUTb7ri112hF
	P/sHswE5Dt9Ul2SAaQzXx8gOS95GQPijxwZNBqvfJf5KC/h6cKUx0c88gNwrHw==
X-Google-Smtp-Source: AGHT+IG0DmvzYgyMD+UbukYpONvIvOQUtcBV4koLz8bJwFW8nLfKTZSqtZ4kjpkCtUaJ4FQxsGFS1Q==
X-Received: by 2002:a05:6a20:2450:b0:1a7:136c:c940 with SMTP id t16-20020a056a20245000b001a7136cc940mr2635499pzc.17.1712908578374;
        Fri, 12 Apr 2024 00:56:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e3c8:6e1:dcfa:3e8c])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001e0c91d448fsm1229006plh.112.2024.04.12.00.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:56:17 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: mediatek: mt8183-kukui: Drop bogus output-enable property
Date: Fri, 12 Apr 2024 15:56:12 +0800
Message-ID: <20240412075613.1200048-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "output-enable" property is set on uart1's RTS pin. This is bogus
because the hardware does not actually have a controllable output
buffer. Secondly, the implementation incorrectly treats this property
as a request to switch the pin to GPIO output. This does not fit the
intended semantic of "output-enable" and it does not have any affect
either because the pin is muxed to the UART function, not the GPIO
function.

Drop the property.

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index f934b8aad3ed..75c799a6adb4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -797,7 +797,6 @@ pins-tx {
 		};
 		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
-			output-enable;
 		};
 		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
@@ -816,7 +815,6 @@ pins-tx {
 		};
 		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
-			output-enable;
 		};
 		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
-- 
2.44.0.683.g7961c838ac-goog


