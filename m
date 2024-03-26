Return-Path: <linux-kernel+bounces-120043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA2488D0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905961C327EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753C13DDB1;
	Tue, 26 Mar 2024 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYHx7x47"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894813D88B;
	Tue, 26 Mar 2024 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492201; cv=none; b=Xt8QN+WYcE1l5J6D1agZ3yYMjFdOoBd4JRJr3LcUWPD4p+H0wRVHOlaFKepEMOF+Ox0F4mfpgXWA4nOB8efkKmgXqwZLW9SL8Xz3ZQag3CXSqr/e/z3h4Equ99dFDuDBv9pasZtQY9a4R2vaHLuSSBXnfzam37noIf39JoB+wuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492201; c=relaxed/simple;
	bh=lPe0mWWCvij0Z4wl+kHtggQQlU7f7OnUfy3p5nPzaGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RpBGpNqUuyQDWjS7wWqk24hjNPtZPlTtwCQUPngsiWRCNpvc0rJF110jv8PaPqJ/ZPXFPLgKxqrHB1wlk1JwB4c5HrwjP12wJTuCQ0Rstn9rYD5bU6loEsoAgAkB58wHIVDi+Ul6FFSJXPPmu7knuusQbCM7ZF9FkyT3uRuMSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYHx7x47; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41494745775so104395e9.2;
        Tue, 26 Mar 2024 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492198; x=1712096998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbPt5ntP/CxLfYWp8zy6p/zJwX6nqgrJF6QZz86Xn8g=;
        b=YYHx7x47+dL65xmY4gQ00aE6emBZxwhQAciua6O0F5QkylrhRVIXMfUR2WrupTlgzL
         8mXS7AlFkNZzKY7yM6+Xqn1Xqrb4j0OEn7MEJNjRRPCPG8GxrehN7IbuHq62MroDBNS/
         PtnSXg9FmTFbvdFPESLyZxj1J2UXQMfA4UnkiUvdAoPa36Hhrcw0cKaZyymiTMd1IlgX
         hcBvjPyhX5X2OK4UexRIFhjI9n/ctWw4IHXtLxDWKMPGUz4jma1yAFBtEJiqxDQXi2x7
         DhsXQB3mIb2NYsgpZEcvjCMhlv8S7HAfrmFdFkaG+Yak0H/yZklwjBz6RKHy0NwuHQkn
         UJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492198; x=1712096998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbPt5ntP/CxLfYWp8zy6p/zJwX6nqgrJF6QZz86Xn8g=;
        b=HGgONfPRQjPuDYNTHuhbXerZcefzhyzdMZ5yIqBnflr9jDo2I+DKUecoZCqMTiwssV
         jWDbW6MYX7XY+BG5FL+P5atT95vBp3RsslZyBiufTWznU6X5Yuk4dpTj+YixsiAXZaMJ
         PhrD7PPtHCfrsuX/JLX6DNbbJRxEbbdnmezSAogW31CMaMMxp08nmwMOz9Z5pbqctaco
         pEBG+f8nkUH4lYbmFnXoz0ggNuZsE1iWjAViOsnNt7jjCoB7rlf9Ow88AM57PsIjM4Gi
         dPzd2ROedpcoXP7TTXrlVPDhAyXyjDQb1Jx694YBhyWKi+Fjob525MicZiPMZCr6W7a4
         Jl6w==
X-Forwarded-Encrypted: i=1; AJvYcCW9RUJuAkNK/jDeEe6Hxo4qjtXyZt7qKnuognBjNcM9n9vmMVZYYGjPi9p+zBVP9EI3U/KUYbQs1jeb/fSptQrhksz3g5t23xhUQ3rIEXhOL9efNt2KRChOE9dVSoz4q7YPlpSp2C49Ausea/48ao5mqoYOnmbk7Mpb2A57axgUwS91HLM=
X-Gm-Message-State: AOJu0YwA7rNT89d/Qxk4+4GkPzJ8Z8xB79V+C6Csc0rpCgoFWtzJIBNX
	TZixqhOvOOS0pJHL5Hsj9K6pAB0rPPIdvtQ4p9pteurSNCVcdEOr
X-Google-Smtp-Source: AGHT+IGsEeBqOJnPc3xpL9Ek085E+R0FMxFGIL4PMQghUzXVb0aO/bDtXZocK3S2xNvOyGXIZoxf2g==
X-Received: by 2002:a05:600c:4ec6:b0:414:8c04:23d7 with SMTP id g6-20020a05600c4ec600b004148c0423d7mr3924257wmq.12.1711492197753;
        Tue, 26 Mar 2024 15:29:57 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:29:56 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 00/13] Add PFC support for Renesas RZ/V2H(P) SoC
Date: Tue, 26 Mar 2024 22:28:31 +0000
Message-Id: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series aims to add PFC (Pin Function Controller) support for
Renesas RZ/V2H(P) SoC. The PFC block on RZ/V2H(P) is almost similar to
one found on the RZ/G2L family with couple of differences. To able to
re-use the use the existing driver for RZ/V2H(P) SoC function pointers
are introduced based on the SoC changes.

Sending this patch series as an RFC mainly as we are introducing a
SoC specific 'renesas-rzv2h,output-impedance' property to configure
the output impedance on the pins. Drive strength setting on RZ/V2H(P)
depends on the different power rails which are coming out from the PMIC
(connected via i2c). These power rails (required for drive strength) can
be 1.2/1.8/3.3V. Pin are grouped into 4 groups,

Group1: Impedance
- 150/75/38/25 ohms (at 3.3 V)
- 130/65/33/22 ohms (at 1.8 V)

Group2: Impedance
- 50/40/33/25 ohms (at 1.8 V)

Group3: Impedance
- 150/75/37.5/25 ohms (at 3.3 V)
- 130/65/33/22 ohms (at 1.8 V)

Group4: Impedance
- 110/55/30/20 ohms (at 1.8 V)
- 150/75/38/25 ohms (at 1.2 V)

The existing property 'output-impedance-ohms' cannot be used to specify
the output impedance setting on the pin mainly because,
1] The regulator information will not be available very earlier in boot process
2] The power rails info will be coming from the PMIC connected to I2C chip, as
   i2c will also require configuring the PFC there will be an interdependence
   of this two nodes.
3] We cannot use 'power-source' property for each pin as DTB's dont use up all
   the pins on SoC and when dumping the pinconf-pins from debugfs we wont be
   able to print the output-impedance of pins which are unused.

Due to above cons 'renesas-rzv2h,output-impedance' property is introduced where
it allows user to specify values [ x1 x2 x4 x6 ] which internally configures
the IOLH bits to value [ 0 1 2 3 ] respectively, and does not depend on the
actual voltage setting.

Cheers,
Prabhakar

Lad Prabhakar (13):
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the
    object
  dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
  pinctrl: renesas: pinctrl-rzg2l: Remove extra space in function
    parameter
  pinctrl: renesas: pinctrl-rzg2l: Allow more bits for pin configuration
  pinctrl: renesas: pinctrl-rzg2l: Allow parsing of variable
    configuration for all architectures
  pinctrl: renesas: pinctrl-rzg2l: Make cfg to u64 in struct
    rzg2l_variable_pin_cfg
  pinctrl: renesas: pinctrl-rzg2l: Validate power registers for SD and
    ETH
  pinctrl: renesas: pinctrl-rzg2l: Add function pointers for writing to
    PFC
  pinctrl: renesas: pinctrl-rzg2l: Add function pointer for writing to
    PMC register
  pinctrl: renesas: pinctrl-rzg2l: Add function pointers for
    reading/writing OEN register
  pinctrl: renesas: pinctrl-rzg2l: Pass pincontrol device pointer to
    pinconf_generic_parse_dt_config()
  pinctrl: renesas: pinctrl-rzg2l: Add support to pass custom params
  pinctrl: renesas: pinctrl-rzg2l: Add support for RZ/V2H SoC

 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  37 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 566 +++++++++++++++++-
 2 files changed, 560 insertions(+), 43 deletions(-)

-- 
2.34.1


