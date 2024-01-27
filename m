Return-Path: <linux-kernel+bounces-41244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5C83EDEF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023171C2156A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302629417;
	Sat, 27 Jan 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pTJVZJq7"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6529410
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369340; cv=none; b=m/r4p5Cd6wE/5zlc+oz/+Xlnyl5v/gzjgQu8xs5mXsAzP/xn0wfKIrgabYoImb6rsWmWg9F5POuCD7jJ1sANIYD6vJGKFA9GfIn76W8fQM63d8DDtP64QjZVxLYD2AsCLym9kVVESTwxE+sK4Uh4qt6R/9VNot2Kmn5qQ4r8xIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369340; c=relaxed/simple;
	bh=T/LaklkaAhFaHxuCeMcQ7m4rl7Bdpzgkrqz/t1RBxk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4Cf1KJPokcMO1mwdHW9wjs3NFKMM25KAcSnNmE0IETBb2h/7IJV8lhwNhRif0AYqM/h+qFeL+qQUj/iQbbsmbTvFFFapb0J3sPHJplrO99u9PXFCIVHQtAWLKr7ZklG0gCiDegBaFIdLnmZOCSwosjl0tQV4ZnSMni0qo7Nr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=pTJVZJq7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so2392006a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706369337; x=1706974137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9qOpvovQxTeO30aF5mISOGXWyu7pY+UB92+iH0umaM=;
        b=pTJVZJq7LPg0ycNtIyBnzyTBhgKX6usWEN0bD2ZcUPL2p1Rub4ZoeJtoMPRH9+mUFB
         XLY86R+DHEmKQ1o+fHkzjjccN6vGGJKr3OuWFulg+Rbt4a89KawhsskcKPJ7H9qUiq93
         2x2HvRuXb77Q8UpH41xThfFeWanMCPxtVIFSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706369337; x=1706974137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9qOpvovQxTeO30aF5mISOGXWyu7pY+UB92+iH0umaM=;
        b=ZR76BdnQRMbEnEcij9XLLUzjsqqV9NVz+tmo98DAYSWylcvzfNruKWmm8OGRvBolHw
         27KqnBJv6QD0NNhEYuAQDne87BjZsZtTBAPQ11v5LYssZaj7CFh445fi9sf935xhyXxY
         joMOkEOJY+3LwE+P6iiWx8ZuGslPmYa4ccGkcFQLFIgT81P2DEuHhurlm3BwCu5Rnuz1
         bxZzIi7+bfEIYvg/jcy2DyzWna4yDszJJmaFA8V2GccYm7I8iQTNsgzaoNIOtsXrZg5D
         NtNw8dgCx13yDQqW6YPDT4VVuHLakfEZ0T8pBWs82pryGO1tlt5YlpUCEwA1S2ZQAOFY
         U2PA==
X-Gm-Message-State: AOJu0YyExDR/OOm1IimRCKh3/FTGzI4fdjAhA5bxhfkcPs38wxmKuIPY
	6W0oP+QgWVDNuyG6qdIjgplzzA1ZPuiHoxENk3zXht+DyrjU2JsUU95Ja0HP1Ke8w0Hgzw94FiD
	u
X-Google-Smtp-Source: AGHT+IGmnblWXBThT/arNwzFsq5cI0uqWhD1N8OmGQ1IBaVswSAky7d8phVyRODGghXdbxr92kxmfw==
X-Received: by 2002:aa7:c418:0:b0:55e:b014:da62 with SMTP id j24-20020aa7c418000000b0055eb014da62mr1710923edq.16.1706369336400;
        Sat, 27 Jan 2024 07:28:56 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-21-103-141.retail.telecomitalia.it. [79.21.103.141])
        by smtp.gmail.com with ESMTPSA id l5-20020a056402344500b0055974a2a2d4sm1745220edc.39.2024.01.27.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 07:28:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Lee Jones <lee@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v10 0/5] Add display support for stm32f769-disco board
Date: Sat, 27 Jan 2024 16:28:44 +0100
Message-ID: <20240127152853.65937-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series adds display support for the stm32f769-disco board. It has been
tested on hardware revisions MB1225-B03 and MB1166-A09. This required
modifications to the nt35510 driver that have already been applied.

Changes in v10:
- Drop backlight. From a closer analysis of the schematics
  en.MB1225-F769I-B01_Schematic.pdf and en.mb1166-default-a09-schematic.pdf,
  it is noticed that the GPIO I14 is connected to an unmounted
  resistor (n/a), making the backlight functionality via GPIO unusable.
- Drop backlight references

Changes in v9:
- Drop 'interrupts' property to fix yaml checks
- Rename vcc_3v3 to to vcc-3v3
- Rename panel-dsi@0 to panel@0 to fix yaml warnings
- Change commit message
- Rename stm32f769-disco-mb1225-revb03-mb1166-reva09 to
  stm32f769-disco-mb1166-reva09

Changes in v8:
- Add Acked-by tag of Lee Jones
- Add Reviewed-by tag of Raphael Gallais-Pou
- Add Reviewed-by tag of Raphael Gallais-Pou
- Remove unit name from 'ltdc/port/endpoint@0' to fix the compiling
  warning:
  ../arch/arm/boot/dts/st/stm32f769-disco.dts:189.28-191.5: Warning
  (unit_address_vs_reg): /soc/display-controller@40016800/port/endpoint@0: node
  has a unit name, but no reg or ranges property
- Add Reviewed-by tag of Linus Walleij
- Add Reviewed-by tag of Raphael Gallais-Pou

Changes in v7:
- Replace .dts with .dtb in the Makefile

Changes in v6:
- Drop patches
  - [5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
  - [7/8] drm/panel: nt35510: move hardwired parameters to configuration
  - [8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
  because applied by the maintainer Linus Walleij

Changes in v5:
- Replace GPIOD_ASIS with GPIOD_OUT_HIGH in the call to devm_gpiod_get_optional().

Changes in v2:
- Add Acked-by tag of Conor Dooley
- Change the status of panel_backlight node to "disabled"
- Delete backlight property from panel0 node.
- Re-write the patch [8/8] "drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK"
  in the same style as the original driver.

Dario Binacchi (5):
  dt-bindings: mfd: stm32f7: Add binding definition for DSI
  ARM: dts: stm32: add DSI support on stm32f769
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
  ARM: dts: stm32: add display support on stm32f769-disco
  ARM: dts: add stm32f769-disco-mb1166-reva09

 arch/arm/boot/dts/st/Makefile                 |  1 +
 .../dts/st/stm32f769-disco-mb1166-reva09.dts  | 13 ++++
 arch/arm/boot/dts/st/stm32f769-disco.dts      | 70 +++++++++++++++++--
 arch/arm/boot/dts/st/stm32f769.dtsi           | 20 ++++++
 include/dt-bindings/mfd/stm32f7-rcc.h         |  1 +
 5 files changed, 101 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
 create mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi

-- 
2.43.0


