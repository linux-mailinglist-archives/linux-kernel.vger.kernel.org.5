Return-Path: <linux-kernel+bounces-74424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FD85D3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE5D1F2507F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202923D552;
	Wed, 21 Feb 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2yWFv6P"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230803D3A1;
	Wed, 21 Feb 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508490; cv=none; b=OCX+HvVgO4OltOLoY+NGmYSZ1fV7/L0xMACRU3nC0JvyqO/3xMnhAg/R9/QHxa0TX8VstZ4ONoEJhK/+ekJ8ugV0cnSK8n+63X/iSpm8RXXKcSlcLLGF9I5WYMTpmji/Nxj7U1IKpTqTLmHzd3330Xw1jCaSXtoPqFe09squQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508490; c=relaxed/simple;
	bh=yzhPkGmyhDClujHspv4zU8ozbniJXsmsLHFQtn3+hB4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nSc1zlQt1Z2N16RvOFwkJa+npzpmMukig2xvm8gwLmCFAkwdPul+1ju1ZtuHxbruxxEXp5GwpgRYGcN4Q6meJvWaIYyNhNxmiKAonBQR2ka40x/jaWqU+syvQDohzzeQAKdWJ2lTbwPZIF/pEciw72fjjMnXVfVQj8wFoWZdN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2yWFv6P; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6de3141f041so4480503b3a.0;
        Wed, 21 Feb 2024 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508488; x=1709113288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxPgBDv3C3dcuReLG+Pr4kZ7NGxk76ia560ll/5bMEk=;
        b=X2yWFv6PPs7MO/iVMQFvFoNF/k1N4qzpQ7Et3K3IBd+kGmFod8nmBB1snnx/chLeif
         6vqJMx0Z8PWNbmQSuCi6NPqh1BLCwpkbWOOOZFbKNqi8xBl7BpVA+4QMTqO1R+yj4QUQ
         oaSZLBUaUqGIh8QhgnSqH6NgjhSESFwBpcCbHVATW7Nkx2pl9acFxwhG6rR7kl85/aBX
         55ovLBIFDq3K/Sjsg7SVb2n06/MhRE+WTrJiW07uCqEjDeozc3Ck5yKMzOemozxhqex5
         NxPDwjBezjsNk4rfqlNlAD13VzjibxgPxMWaF3Qrzi9N8N13amm5scM20w6J2nL9L6QH
         hkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508488; x=1709113288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxPgBDv3C3dcuReLG+Pr4kZ7NGxk76ia560ll/5bMEk=;
        b=fC4u5Gr9eo7uI0OXIHHV7er+cMM/MiMVKgjG3Qm2cRaZIX89JQqSYIZAZXVL6Xzsqk
         h171zY2VGZu9gcvbVc24yLen/A0HgWr5Rci1hE5tyzPOq6liESIslWK1g6QEPH5L0+zV
         wedQAcu6NrLRD4bLOQ3u4a79HV3n8abZ0F4aDssEPC4jOaG3VTI9WCcCRwsXjhNL7+Mc
         EgHjOYE09Wj7BoKuUB56XnkRLCkRejcVHiwCsbAhjFEUMVBLJlQDbsy5pXbTQwHXW6EQ
         DeWh6mfhmMCjwABYKc2m+Hq5TanMEsceZcS5K7dhX6GLhVlIVLO7FUO6cgIur2eom5yx
         KWbw==
X-Forwarded-Encrypted: i=1; AJvYcCUXFALdeA5LDapNeZ1t4JNR5NUlSBgfvfLd7RHqYMGbg+kZZOAMDe4VWM1UdAZcDQl++u7WtiUmouqnpNDRbMuJ5xNIR3F88fICVCu/fgL+1Kpe4eYW2llwys4pAHUOWX2dEPVlKP1ybw==
X-Gm-Message-State: AOJu0Yw56/wzdrqeDUV+II3e+H41f9RAKowL7ZJaMWmmFonmNl0xb3Xc
	dk3fAh9Ofk+0sq84cqT8xDjmapzDkNFIFY7cUUL3qpESmL/s7Qd1
X-Google-Smtp-Source: AGHT+IEpYDF/aIErFO50W/tttHeceZ9QK7f/ypdE9/vLUtf1QQi2UI/UoCC3API4C5Z9wcpvGwoo9g==
X-Received: by 2002:a05:6a00:2d0d:b0:6e4:5cf5:1b5b with SMTP id fa13-20020a056a002d0d00b006e45cf51b5bmr10524465pfb.30.1708508488450;
        Wed, 21 Feb 2024 01:41:28 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:28 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Wed, 21 Feb 2024 17:39:15 +0800
Message-Id: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw@mail.gmail.com/

Change log:

v2 -> v3
  - Patch 0007 - Revise max31790 address
  - Patch 0008 - Harma: Add NIC Fru device
  - Patch 0009 - Add ltc4286 device

v1 -> v2
  - Add infineon,slb9670 information for tpm.
  - Patch 0006 - Add PDB temperature.

v1
  - Patch 0001 - Revise SGPIO line name.
  - Patch 0002 - Mapping ttyS2 to UART4.
  - Patch 0003 - Remove Vuart.
  - Patch 0004 - Add cpu power good line name.
  - Patch 0005 - Add spi-gpio.

Peter Yin (9):
  ARM: dts: aspeed: Harma: Revise SGPIO line name.
  ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
  ARM: dts: aspeed: Harma: Remove Vuart
  ARM: dts: aspeed: Harma: Add cpu power good line name
  ARM: dts: aspeed: Harma: Add spi-gpio
  ARM: dts: aspeed: Harma: Add PDB temperature
  ARM: dts: aspeed: Harma: Revise max31790 address
  ARM: dts: aspeed: Harma: Add NIC Fru device
  ARM: dts: aspeed: Harma: Add ltc4286 device

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 59 +++++++++++++++----
 1 file changed, 47 insertions(+), 12 deletions(-)

-- 
2.25.1


