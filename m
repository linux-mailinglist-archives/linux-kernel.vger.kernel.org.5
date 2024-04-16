Return-Path: <linux-kernel+bounces-147204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683D8A70F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD81C21CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E80131BDE;
	Tue, 16 Apr 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgeZcO62"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857D13172A;
	Tue, 16 Apr 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283976; cv=none; b=eIC+flYH6RJxox+AztmDUIIE6gI7iUt/3weDW51cjNomRjKPOf8RVJNtF22kG3aeG6TSeVrT2wM6LxvrVsnc0W8P7Fb9B5UL4KbEAWzu84LcVTsiaeL4SFTmm/JkjaAQo4kx5r8ly1UklEpbbjPeI17pHM/fCxJ6QvcderjpYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283976; c=relaxed/simple;
	bh=/Y3zo1KcddHRAAx9chnFCnaj6B+PNjuHwGVWXwXYUVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZinnrcTH9gnM5Dvr0jVKLXTGk7zRdDS/oywH/12LQ49YOeHkAsxVbFOE0wRhUJ37HhP6LM4EbVlN6FeCyvCVckNiA75M3TxwGsVRB8TW1k6FgwgL5d6XPEhtBTmL4GMqZS2bNYYCRT23j15gfL0vtEVSKGy8d5qiFe5Dpy9Ezpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgeZcO62; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3499f1bed15so214899f8f.1;
        Tue, 16 Apr 2024 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283973; x=1713888773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lE0iIAKwN26IHZrOzJQ+UkxUYWi8S6bm+npmiEEpfoU=;
        b=jgeZcO62rlTkt2EpF+NykjONmJN1O/oMswfDCZfhs6kV+cDDesdn62aKBLNcKE0pYG
         vC7Ebo+AVHi6MFrfopLw1WhrJ4tfSdfhuDdobCkriHs5DpO6mr6t9vJeHFULFHuOHg2Z
         iAZ/pbQj6uf1P6p48UMmI6UOG2d56h6ky5OiNQgNcWZ0l/BALsKP5iXWYLEVLaTC7hPx
         x7yKURhXNTw91spy/E/n/TJJmctYIX+WX3ikIbj4FslD6gwcKceGs6++yXlWaGKm9f6c
         e+dCCdF7+W8XhrBpr8nXOxHGyXYy6S/WFWEYCintqIDv6i3FaP3PRzL5kxzAxmzF6Kgh
         duPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283973; x=1713888773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE0iIAKwN26IHZrOzJQ+UkxUYWi8S6bm+npmiEEpfoU=;
        b=gSsDaq/QD6TGcfKm6n9XYeSRkg00S56kjDmsWcrqtL5JizFaAtRj3jzt6ePpNsNGBJ
         z/jvpQ/L2sSANDc+7/xSNZ4k0mcu4/8nF6Pv+LJhYiJIeBLTKnQ6caaQftpcyBsUdMYJ
         nxA0e4d8sVQX48AORWUz5ZTPXaSkAob2IbdWYwiREuF3xlD1LBwZjSLJMPASqa7wputd
         m7SmRvQU2h72EQpIqsTRq34YmQhTzlI2TNK4g35Jsh4nfyTvxKblEg1veSgetYFbIds9
         rN7r6vntQT4YWzBEPvG4esvxR/BRHC3PJuhzURn1fLyehpOZqRizEgdR5seUn66BY9Fl
         CTjA==
X-Forwarded-Encrypted: i=1; AJvYcCVWBzdsxe9Bz8BYl2PG0i7F3BffyzlY93L+HTW8i49IU52fGQpeaJfEwhC1JvcdWwYMZ+JRWY1cPuOwglMXBInWbwr7gFplmsshzpWeVQI/0w2RMB/Z76w22/FVQBR0CHky3LR5ytJ8ei64hki7TPcBa3zmtMEQM8a4VWZiCLWftyzu+os=
X-Gm-Message-State: AOJu0Yyh0vJUIWPGH5qckW1wIhuhdMFGXjP+Y9+C0+jlVnVPlA5TgvNA
	gp/tZcvEi6eGNeUFiNzFkV2OTmKg7sMt2U/vFW8RQvSQU4yO3l+7075W
X-Google-Smtp-Source: AGHT+IG9ARM425fPZMKoPQYcOH+P46IbQ6VFXNx/9g39D202o1HbwRny8IvK1x5SH0HBZINbFbyuOg==
X-Received: by 2002:a05:6000:1041:b0:33e:d139:412c with SMTP id c1-20020a056000104100b0033ed139412cmr2499659wrx.30.1713283972768;
        Tue, 16 Apr 2024 09:12:52 -0700 (PDT)
Received: from U4.lan ([91.66.160.190])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe447000000b00343eac2acc4sm15350743wrm.111.2024.04.16.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:12:52 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v4 0/5] Add RK816 PMIC support
Date: Tue, 16 Apr 2024 18:12:32 +0200
Message-ID: <20240416161237.2500037-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to add support for Rockchip RK816 PMIC series. As per
datasheet it's targeted for RK3126/RK3128 (RK816-1), RK1108 (RK816-2) and
PX3-SE (RK816-3) but might be used for other SoCs as well. The MFD consists
of an integrated RTC, a GPIO controller, two 32k clock outputs, a power
key, 3 buck- and 6 ldo regulators, 3 regulator-switches, and charger with
integrated fuel gauge. Charger and fuel gauge are not part of this series.
Two of the switches (otg/boost) are part of the binding, but not of
the driver. They must only ever be enabled if no battery charging is
happening, but it will be enabled automatically if a battery is attached
and an external power source is connected. Thus that needs some
incorporation of a yet to be added charger driver.
Integration in the existing rk8xx-infrastructure was pretty straightforward
and only needed very little tweaking. In order to not further bloat the
driver(s) too much with additional `#define`s I tried to re-use existing
ones wherever possible.

The patches are loosely based on the vendor's implementation, verified
against the datasheet and tested/measured on a RK3126 board.

I'd like to gently ping pinctrl and regulator maintainers: please have a
look at this series. I've now added Sebastian Reichel to the recipients, as
he recently added RK806 support and re-worked parts of the rk8xx drivers.

changes since v1:
  - integrated Krzysztof's feedback for the bindings and the resulting
    driver changes
  - fixed a sparse warning 

link to v1:
https://lore.kernel.org/lkml/20240321143911.90210-2-knaerzche@gmail.com/

changes since v2:
  - integrated Krzysztof's feedback to v2 of the bindings and the resulting
    driver changes

link to v2:
https://lore.kernel.org/lkml/20240323085852.116756-1-knaerzche@gmail.com/

changes since v3:
  - integrated Krzysztof's feedback to the bindings of v3 
  - integrated Lee's feedback to the mfd part of v3 

link to v3:
https://lore.kernel.org/lkml/20240323132757.141861-2-knaerzche@gmail.com/

Please see individual patches for details about the changes.

Alex Bee (5):
  dt-bindings: mfd: Add rk816 binding
  mfd: rk8xx: Add RK816 support
  pinctrl: rk805: Add rk816 pinctrl support
  regulator: rk808: Support apply_bit for
    rk808_set_suspend_voltage_range
  regulator: rk808: Add RK816 support

 .../bindings/mfd/rockchip,rk816.yaml          | 274 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   4 +-
 drivers/mfd/rk8xx-core.c                      | 104 +++++++
 drivers/mfd/rk8xx-i2c.c                       |  45 ++-
 drivers/pinctrl/pinctrl-rk805.c               |  69 +++++
 drivers/regulator/rk808-regulator.c           | 218 +++++++++++++-
 include/linux/mfd/rk808.h                     | 144 +++++++++
 7 files changed, 851 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

-- 
2.43.2


