Return-Path: <linux-kernel+bounces-132736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5389996A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EED91C20FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105ED16079D;
	Fri,  5 Apr 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kbm2uxwo"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75A15FCEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309307; cv=none; b=uQjSd7CetCJpJ4bQ8M4hlUBogT6ikybIOkQoSeEwbTtYE5tMZ5hc4jmrAhqQXQy3jvGZruks1c5mCXsFSWtI+hgpKoQii58eDiwGgEfRikNRtfNQqkd9ZBK7WzdNgz8HbG3skxFXTunqaktI4il30gJ/1CxsiikGT9T3DyA2pQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309307; c=relaxed/simple;
	bh=WTJy+7FRvsutUwAUfsNeE7+OA0WIOtieEtgmSkwuNwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTfjhYZwe0rqkhfoUp/tknwLWpH0ZifDSn1NpcnRjcGX1Mi20d4SyjPqaU5WeHsEHvszGgsbcIb8U/5xJHi1aDgEah+oMNXvCBmVqfMelf2NMQMT5ZisjsRs2ej3p+PJPIlYSbXWgKI/8h2i65xnHFZF/ShWXemEGPWZPgRjH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kbm2uxwo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e030624d1so3197029a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712309304; x=1712914104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3UhqttEClAp302E8PBewqsaaK/r2DdYnzrvOqVi/vc=;
        b=Kbm2uxwoHbzYXlN0BD0oW7Nya+TYLVcMfxwVPt5oZLDoeLW4qUhkOq0+CsX7/lNbwy
         KmwHghlLsQ7L+7NAVj93d1p7nfyNKoRG0XtOi71Q/cKWziODBH7pT4prLW4YoWoB3DnY
         hiOM0zvhEFjQMLx/bO4fu8SfZnSthnHxuvfIaOo18FQJSWm+F7YQoT4yNvQ/hdyObC4L
         C2n+aCtVvGlw4ylcBDOe3W+EbtJTXbfmB0F2CmMqpFtz9vgPB6b/+73UI4hc1HBj9MOj
         nOcogrz2PGtnXOdsMRFSiry5pPAx8zgIUmGH82f6cVFliiw4J22NOq2FADoxR+W7aPn8
         mDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309304; x=1712914104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3UhqttEClAp302E8PBewqsaaK/r2DdYnzrvOqVi/vc=;
        b=TFy2PCIqHP9HClnOHx7CRGBmz8TThG641TmJEquzwznxrrFRzPEdsL9rKg1cx4OXK7
         Xq5Dlyxlq+3WYpzd/Qu9OUO6L/5xUrc9kU8rlfT0IZ7iTA6/INyzDoA9hlbNArdTwd7W
         oZmdr1Fo0hd5dhZcWSeY0EHm9IzKh/XfIBNbVMvRk1zhkodjiK1BJQ6NRxCgwDApH1/B
         iJNGYe8lbc3gvpUU4IRRyR464v26d3IxqAXc05vq0ObvliKjVShdclFMTyp/CwaLjRA1
         5W6Nt8RAZ+d/nIGWPgzSwabDOQ+420fT6rYm6JlQTyX6O+ud1Vs014lwff+A0XOoJ7JA
         eSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjnxuiXftxDafnUbF2U2J/NXspQRmnZCPectWiI9KRnD4405BSIS/HUj7XSeMZAjxzEH3lzxL3QvNK3vxzi8ko6LfGISgHcwp4Paj+
X-Gm-Message-State: AOJu0YytDH9nRhGv16qaDRtqTern9WPf+2o4y8DOvcp1ruyhfoqbiS24
	8xMRno+OmOrBdHXY7nDQDX41mkNKukWNB1voN9ttJJb+QI2d5LPyN+qyuCnRLIw=
X-Google-Smtp-Source: AGHT+IFf+KfG1bg7CyXkWbKGh/vtgLwxUWHUP/Muu0AkBFdAliGje48fHgb5Bsgjbbw0qTiPH+opoQ==
X-Received: by 2002:a50:9f21:0:b0:56e:2abd:9d13 with SMTP id b30-20020a509f21000000b0056e2abd9d13mr897099edf.7.1712309304235;
        Fri, 05 Apr 2024 02:28:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id a1-20020a508581000000b0056e2432d10bsm587750edh.70.2024.04.05.02.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 02:28:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: imx8mn-var-som-symphony: drop redundant status from typec
Date: Fri,  5 Apr 2024 11:28:19 +0200
Message-Id: <20240405092819.40994-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405092819.40994-1-krzysztof.kozlowski@linaro.org>
References: <20240405092819.40994-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"okay" is the default status, so drop redundant property from the typec
node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
index a6b94d1957c9..3434b189fa58 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -126,7 +126,6 @@ extcon_usbotg1: typec@3d {
 		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ptn5150>;
-		status = "okay";
 
 		port {
 			typec1_dr_sw: endpoint {
-- 
2.34.1


