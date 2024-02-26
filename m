Return-Path: <linux-kernel+bounces-82447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876188684B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4BC1C2273B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C13135A78;
	Mon, 26 Feb 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOEEIWd3"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A43135A46;
	Mon, 26 Feb 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991145; cv=none; b=OjD29ngl2hE6qYc/ZSObyLiS1yITjRhbu+lxjx9zIVMlQDoOY0ARxB3Isz+psXFQqaMkANMerWzJdVctbHpu5/yTbxwASzJIIj56Wxg66rUsTMwlCI7BGAAcMDqAtdAGaaAl/So5y7bRwS9LvaUcg21QjUsVwRNGcRu4LZwNKLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991145; c=relaxed/simple;
	bh=TtompIHgbeY/OA3WXAshQm3+E9k8UAMGdrcANzV0VD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LeNRka4+D/pisGjpIn50ajGLPOpZasPIRtnZQRNsOJ97s6XAcwDZAAZ/LaqwGdQZqOq5nVykmzlsiRXc7ueLeSigYTSQMigsVnchW9jglWFuyNexPWPeTCvUSyll8GSe1/bl1L/NpapQe3cqossLL1JKA/76KKcsFoiQNukYir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOEEIWd3; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c7964d109aso143349839f.2;
        Mon, 26 Feb 2024 15:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708991137; x=1709595937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWIbvre+rElW1Hi4Tns90pWqujeQfsqDKyIvXn+Wd7Y=;
        b=fOEEIWd3086f1u4xx4mKSytKgBkEHsP1A4cNmsfb9LmOwWL+UO/DUAHNMLmdf/PnMr
         crVfgaTuNrk7R9Ts6jWRs2yIwqV9DF4+dkboPyyFf9td4QsxnCJ2Yzum8l4fC+PJna7f
         xAo4FqU01JkAJGLyyguJrKygpkiTE+JiRb+PITD3M98ZR8/Qg/zvYwbisM7lbA5Idsbz
         AZ+aCEIVcexK4Ugbf9GjdVV0kt35BBSOJwaY2ot9nHEftHXeAhK6T3U1Z6w71q76+tWB
         /dOAkOzvWxyZk4jZu2bZ7JkrC9ljChBvEGCuiXOy1bdOGnLGS9vuUgEcnFC4A9w5yOBe
         uCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991137; x=1709595937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWIbvre+rElW1Hi4Tns90pWqujeQfsqDKyIvXn+Wd7Y=;
        b=cflUdTP4bNa58z5PEwYkfsUeKWNWoLubiCM+zNxFBvi9XvKZt+amyI5c4oeTcbhSNF
         KGvCvTVhQ+GaDN8BX2kXXr3zCPQX4iEj//TjYQ/h+Zb64hDLHdOxIz5T/gyELeyb2Jf6
         vrVmM+V+kOGljgKjZeaGsxbmXM+tOXnnaTYk2kXdwqfuagUKCBMiq6H0Jpq1cSRUdYq/
         fAg41CCLbhNw+aFdsP7SYr/PpYUnLLlxUr8S0zhkbC4BR8EAbbUkmTfkr6h/tcwj7EnB
         o+koZSN9biBvxHa6XL69XIF9mUNr29JmZLyk75TrSvBMfrFRAteviY1aUUuZ2r0J5QsX
         xHFg==
X-Forwarded-Encrypted: i=1; AJvYcCXmWipvJLHX/AOthJl77YI21ruK4f/mHS5y1uJnNArAQP+LPsvdIuwhZvdlYrXYN2zi35nI8KVKe/RDmxqd6Q+7/50Thi/Xv/0Lb1JccZhvwzQaJO/dRTUHfPDo3sh3GzXyo2KVWBiURQ==
X-Gm-Message-State: AOJu0Yy0F6gNYuaOY7udtskAuMKC7LPeQ6CCnj6FYO9JRdN1T//yEF8S
	ZibW49Zr2s1AZwsU/+lthIySx+Bi0vjkYj9jMXzFgDkDh+vibGsC
X-Google-Smtp-Source: AGHT+IEFd1YNIU2pFTFYWayiyy5owHCUX8d2oFahEMWR2wOBYQt4gvySx+O01SGAjDhoU7jBjgwbnA==
X-Received: by 2002:a05:6602:1d01:b0:7c7:da5e:3a61 with SMTP id hh1-20020a0566021d0100b007c7da5e3a61mr2215880iob.9.1708991136677;
        Mon, 26 Feb 2024 15:45:36 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9c95:d061:819a:2ab2])
        by smtp.gmail.com with ESMTPSA id c25-20020a023319000000b004741cf1e95esm1545317jae.11.2024.02.26.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:45:36 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 0/6] soc: imx8mp: Finish support for HDMI
Date: Mon, 26 Feb 2024 17:45:11 -0600
Message-ID: <20240226234532.80114-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Adam Ford <aford173@gmail.com>
Sat, Feb 17, 10:16 PM (9 days ago)
to linux-arm-kernel, linux-phy, aford, me, Vinod, Kishon, Rob, Krzysztof, Conor, Shawn, Sascha, Pengutronix, Fabio, NXP, Catalin, Will, Lucas, devicetree, linux-kernel

The i.MX8M Plus has an HDMI controller, which depends on several
other systems.  The Parallel Video Interface (PVI) and the
HDMI-TX are already in the Linux-Next staging area 20240209, but
the HDMI PHY driver and several device trees updates are still needed.

This series is adapted from multiple series from Lucas Stach with
edits and suggestions from feedback from various attemps, but it
since it's difficult to use and test them independently,
I merged them into on unified series.  The version history is a
bit ambiguous since different components were submitted at different
times and had different amount of attempts.

The previous attempt I did used the wrong starting point for the PHY,
so this update includes a newer starting point with tags from that version
and fixes from various people's feedback.  I hope I caught them all, but
I apologize if I missed something. Any tags from the previous attempt I
made were intentionally dropped, because of the significant change,
but I kept tags from the newer version I grabbed from patchwork.

Because several items from the last attempt were merged, this
series is only focussed on adding the HDMI PHY driver, and enabling
the power domain, irqsteer interrupt controller, and HDMI pipeline
in the device tree. The version numbers are a bit strange since
these all got pulled from various attempts with different versions,
but I wanted to push them together as a series to complete the pending
work.

This series restarted at V4 based on the version of the PHY driver and
the other drivers and power-domain changes have been applied already.

V6:  Make the PHY driver depend on COMMON_CLK to fix build errors
     Make LCDIF3 disabled by default since it depends on hardware.

V5 primarily updates feedback from the PHY driver itself, but a small
   adjustment was made to the register size in the device tree.
Adam Ford (1):
  arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
  
  

Adam Ford (1):
  arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module

Lucas Stach (5):
  dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
  phy: freescale: add Samsung HDMI PHY
  arm64: dts: imx8mp: add HDMI power-domains
  arm64: dts: imx8mp: add HDMI irqsteer
  arm64: dts: imx8mp: add HDMI display pipeline

 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |  62 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 146 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/phy/freescale/Kconfig                 |   6 +
 drivers/phy/freescale/Makefile                |   1 +
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 720 ++++++++++++++++++
 6 files changed, 936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c

-- 
2.43.0


