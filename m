Return-Path: <linux-kernel+bounces-136511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27F789D4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7C1F2168C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654257F46C;
	Tue,  9 Apr 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN/ulS46"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEF3BBD8;
	Tue,  9 Apr 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653123; cv=none; b=IkezKwz5Z2Rs+/3bvV0NAOtdeW/SRQWwSgLZvWFXVvYYK5MfBNqa5JeIRvx9lBzbcG0p/FeTFyxhpOO7FI6wZKu6D049pR0snnBwecDkjlDGhVdwAAAam4EuIv+aEm9EyGIEv1hS0oAVZgCZtHCcqWahJhSip1sveqifFYxHz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653123; c=relaxed/simple;
	bh=JDxyj/NgzAYMyhn1+wlwKA00gRutP6a+/Ptcd7/a/Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dub6HAVhO177+XsEpez46hn3QJNTtI1Xra1R5TxAzT+A7aUFkTvoa9hrnGkUBdmOI4s1QozG/RzK0Xy9aB10jiYB0+HqDD5sAwJ8NDBkB5i6/mZNsPjScS9mOGmk7QoxyGeau++dJEUROk8vpcHuWgh+I2AOLvUkHjeAmkiTNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN/ulS46; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d87660d5dbso31511201fa.3;
        Tue, 09 Apr 2024 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712653120; x=1713257920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wA4gp3d79zniHSDsbeCG83X8AoE16ampJ2TK82Zm3A=;
        b=gN/ulS46ndJbELXoAr+iOT9QpZQvtagXXaHuTYWaBfb2UHvw1UbJrirAflnuk8GuQs
         aHOoNrcB5a6Uf4bRD4e98IGao6cRGzAf6eoi4ACdoe4ZPipQGNpgDVFrw5L9/Z0Hj6BW
         HL/DEmsb/FCC3b+grt50O1+312dkWeIzLJsCGzaHJrCYKonJdylQQ4ip/CPDOaxU28U1
         lGBzpWxeTcf/LkaUankCRriOZk0H5WMrCgQKGxELYCARK2P8EPEnO74lBFIiIuTOW6El
         ZiL7mOhsrpiBvKD933idU/LTxfHo714CvgroqjHIjOz/SQD+ejkqYRKUunDEyaYbNWwa
         sP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712653120; x=1713257920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wA4gp3d79zniHSDsbeCG83X8AoE16ampJ2TK82Zm3A=;
        b=uB5HnijO8VL+rHvFS8sUEVaFgZ1EDs5piI16Ogb1ackA56ypU1HikyTiBAc33dsOye
         HtjJTkF+Ksm5i9/1PSYficXKkXp5QpaoduXiROMszhjUrXwMiTYOa+3Cfcnp1lJbLmPT
         G+Y4bnAhCerS/jTnd8BPXXTkMH7zEy005K7lP7+iIp3FOxeeOGxvAW4pJ6xRGco75yyb
         6LLYg6/xQNrSkAz05Cu+0hzUMgBDl7MmvZ0JL4NKwg+OXnw3CSQcjRIe2G9MFV3lVwZ1
         /ngIUP6GJsvneJWTR9KT09q0o7Ow7m0HxdllX4/LDlPBUt9EcTunJzuXi0/9CMRL929w
         qwRA==
X-Forwarded-Encrypted: i=1; AJvYcCXHKdUIwJybqVEKVCkrlDkUx4QeJVeQD+0eK7Em6Em3EAvCWfuemx57c11d+GJLsQ1+kn37j6aznMfdaxoleyVvbjxF/FbM/Jf1yyWjLHBrfp7tUExBZXSkWs4I57fATjj191Ofls/LXSFJAkMRy4yW5TUmLExjPPJvtwq1q3Sr0w==
X-Gm-Message-State: AOJu0YwSv+UfpR+LXGz7H1G+wBPMYHRIiHcAcGslRIGRs+lWCTz/ZxzK
	4VtYjh3/9RLKWuFh2aOZUfus1iV9K+a+Tn5bavrGtSYPUg16t1ah
X-Google-Smtp-Source: AGHT+IEjfbApJzDOYJitN5OvVuZobmLyPYbuqFDauaji15QV2g9+W2qksUw6WlXX6jS03WEbDawyiw==
X-Received: by 2002:a2e:9b85:0:b0:2d8:4890:c0fa with SMTP id z5-20020a2e9b85000000b002d84890c0famr7754716lji.35.1712653119923;
        Tue, 09 Apr 2024 01:58:39 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:2455:df03:b036:54c9])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b0041665d968f1sm7688160wmq.47.2024.04.09.01.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:58:39 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power domain parent
Date: Tue,  9 Apr 2024 09:58:02 +0100
Message-Id: <20240409085802.290439-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

The pgc_vpu_* nodes miss the reference to the power domain parent,
leading the system to hang during the resume.

As these PU domains are nested inside the vpumix domain, let's reference
it accordingly. After this change, the suspend/resume is working.

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: <stable@vger.kernel.org>
Closes: https://lore.kernel.org/all/fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com/
Fixes: d39d4bb15310 ("arm64: dts: imx8mm: add GPC node")
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 8a1b42b94dce..97d0c6d23ad8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -739,16 +739,19 @@ pgc_vpumix: power-domain@6 {
 					pgc_vpu_g1: power-domain@7 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MM_POWER_DOMAIN_VPUG1>;
+						power-domains = <&pgc_vpumix>;
 					};
 
 					pgc_vpu_g2: power-domain@8 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MM_POWER_DOMAIN_VPUG2>;
+						power-domains = <&pgc_vpumix>;
 					};
 
 					pgc_vpu_h1: power-domain@9 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MM_POWER_DOMAIN_VPUH1>;
+						power-domains = <&pgc_vpumix>;
 					};
 
 					pgc_dispmix: power-domain@10 {
-- 
2.34.1


