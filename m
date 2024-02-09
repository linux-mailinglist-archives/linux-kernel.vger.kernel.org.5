Return-Path: <linux-kernel+bounces-59331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D284F583
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA98E1F257CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835E376F9;
	Fri,  9 Feb 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYYxFBJu"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7134376E5;
	Fri,  9 Feb 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483742; cv=none; b=KL0JVbwLNNvqgwUgQUduy4IF9eidK3D6IaS01TVbrQgooSOK0QYIc5oF4OgGqhMbzgRqQcaLMXkq+NGLRYOoO2DdUbXhBvTJnYzNYIxNa1K5V1zg0XB2Y8/8GN4mWUJZEk14Guy83uRS0JodCu6EkcojnMLuHTtZKpMLmSIfy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483742; c=relaxed/simple;
	bh=ShrkR1d/+57C+ph4fmfFsBp7stRH/DRbVwhenrS8ZT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWkoWCEKK1gtffJh6cYG7bqscYjyY0qzCuhNBvyHPUsYKLvIi8p6sP/B5TBIMzn2n5mPI8oi+LIB/Hj3HzByME4RL6KV70MIepvAZmrF6wPBZDhGUuLED+DmuFGJQMydrW+b3RlbAhlguJEplmxhjBb/v4WDRrRP/VNhZ9R+YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYYxFBJu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so1110684a12.3;
        Fri, 09 Feb 2024 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707483739; x=1708088539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=koBRC2vHC5l/EMfPG8n4Eafgz25Uj1Kl9qaBZCE0qYo=;
        b=CYYxFBJuZRz0E2vaWtmzVJIFBHl2e2FQkLn+/mWNIy3/7wUOFhZ8vkJSvdbgJDdssn
         B48aVbFNLOVJSTCHUKRC/z68hGPrdBRCu/E0p3MVykNxpUzClYPtCUrSiTxVHdkfB8Fb
         Yg1UvLSznV+++uFhMRuVlnxgNaJcLJwZdWwZLyVU1vdLVFFSp9S4ql8Kd6vpqtJT9Fvp
         8XANhbI/cTCoogISg65+JmncjBJ6q/3OM6gHt2yl74FYF5AQlo1+LOUgxh1c1xNC/ra7
         Ui/sFwtJ5qaNiyzBq8tFcr6mHeLnrT0ti3nAiATUByODB8Rc6z7nOY2a6P6wyOyBYQWg
         1GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483739; x=1708088539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koBRC2vHC5l/EMfPG8n4Eafgz25Uj1Kl9qaBZCE0qYo=;
        b=V4nXEMofaAJi7Vo9/iWNm1+KjVukjxxq3wSICHO38yuof1JNEE+mZ4na02yL3CwsgV
         hpBAZxZBqYnPRDr0CiwX+EVx7uKNkJ17lWNQVZ7MXC/WBkG0OXDmjXK/q3T9f1EPHYws
         qpn+AHpMdJ9/4l1UImRdRLQ5vTaV/Ef64cJ+rfCJ5O2db3XuruBNGp2m+FoYEeWbrJc2
         azReTm31DNvX7bVr2WTIILTN09Bz8lKoQlatgZM5xR5y4OWyF/LIQMsy1bgBLJjlDLsJ
         etChT59Yvm8nthClhIqh3yBB4xt2cSOENqK2JKxDO+Kwwbxt1SjLXnOEv3f9FDOgh2Y5
         1JhA==
X-Gm-Message-State: AOJu0YwOfyT0KglF4cr8nkQdv7XqFP2oSG/u4ackwDnjm0O7wK1iisio
	8hYBL2PrNLS2sZoOxGGTEYwfra3bL9asYLHg0NSRLThlsOVzpRDs
X-Google-Smtp-Source: AGHT+IFuPQHSbzt6oeQqfhwFVQoPrPesdZt5WdUR7R3AyvlDILYvAsz2l1wsPMzQy1qLJsbf48VnVw==
X-Received: by 2002:aa7:c383:0:b0:560:1c3:e23d with SMTP id k3-20020aa7c383000000b0056001c3e23dmr1399589edq.16.1707483738921;
        Fri, 09 Feb 2024 05:02:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGtS6HRK/ROjy/1bVrzVpSvSAsxwnTnINr6ZtXSzRGUOxQDaOfXe12gV82LEdhRk86I2d4bcrBc6QAOSyUxezVaPZuxIpTLrXmMk6HGZKSXEvnUhSZrT8GtUWflhOAdb7lFuCU+kTiLHlB5ivCoDooj0mzBCPEP2hwzE8qXDsdnkFXHMKQwsTeeEtr4nJBK+BxdhsKZyD1xEzpANrrVUU9vXU4EhY2BBb+BeldmPJ4xCmerSU+aAbd+DISOMmewCxHTdlji3FBpIOUrB3ThrHlyM55DiQ9OCSn66+gDYSfdiqSNP2mdRN/VvXZRqKuP1cXmLfp3mVsnZSnVFmzFP+fbrnYfgkL4mwfLtb9CqUU6mc5yWQpP46g5D1nIAKCBakkwvZdsRIEtSU=
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id t2-20020aa7d702000000b0056038077ffasm756130edq.38.2024.02.09.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:02:18 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Sjoerd Simons <sjoerd@collabora.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
Date: Fri,  9 Feb 2024 14:02:12 +0100
Message-Id: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

AM62 USB works with some devices, while failing to operate with others.

[  560.189822] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[  560.195631] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 2
[  574.388509] xhci-hcd xhci-hcd.4.auto: can't setup: -110
[  574.393814] xhci-hcd xhci-hcd.4.auto: USB bus 2 deregistered
[  574.399544] xhci-hcd: probe of xhci-hcd.4.auto failed with error -110

This seems to be related to LPM (Link Power Management), and disabling it
turns USB into reliable working state.

As per AM62 reference manual:

> 4.8.2.1 USB2SS Unsupported Features
>
> The following features are not supported on this family of devices:
> ...
> - USB 2.0 ECN: Link Power Management (LPM)
> ...

Fixes: 2240f96cf3cd ("arm64: dts: ti: k3-am62-main: Add support for USB")
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 464b7565d085..c49fbce5cb70 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -640,6 +640,8 @@ usb0: usb@31000000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
@@ -663,6 +665,8 @@ usb1: usb@31100000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
-- 
2.34.1


