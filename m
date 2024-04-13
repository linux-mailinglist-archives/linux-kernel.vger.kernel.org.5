Return-Path: <linux-kernel+bounces-143909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428708A3F63
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0EA281F24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BA57864;
	Sat, 13 Apr 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cYmGkNLk"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BD156471
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713046486; cv=none; b=mPLtq/1fXQ1faHj3xXFGSe+5s0RoGj+/xojRbRRsn1Xi8iPxI912tx/8KZKvhTvcM5MVZgRhrbkaE6yKARA6CrvSV414spGIBlHTiQwEVpxh5P1h/HwcQyeY7QVy1HulQV/WVKgVcu7n51G4tnwYXTwm3xSr7HtGywl8tnWKLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713046486; c=relaxed/simple;
	bh=D4cHZTrBFs9Y8i1w0bHj0gtliPoYKudctyXTaCkiaCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L4BYN0PGw+3WXdj97OQ/b4z4Lov+2aRppGRjGdxGUCLU3kvQkfDSHzPIT+PUgiNUZ1kX/BqVTAy2HGKoccD+2x7hmbfACSm0w76e3/nvdI39h/vv4AuOhFPg8Bp8XWSeoKK2DQitqnZfWLp893NJ9bHDrhWADF5fT2IfEyTfSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cYmGkNLk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56fffb1d14bso2735960a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713046481; x=1713651281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxFqmOp3HshWN+SgF1tbY2QlrStlEk1IWrM1mFhMRAI=;
        b=cYmGkNLkC/Pyi3/rbbEMfKfekynsdQwk3Co/A5dhbkyMNnT0Z5H/5lsRIZFuny3eBN
         jrZue4RrcDj+/EsgV4e8bYDwuMcx6DPPBj6z70PPmRLyi3jop/4XyFbBNiosbf+B+6q1
         Ii1Mc2akZMWOi9eKsWifK98WWL0B2bQ7JwNdYDc7AxaHPruFfSZeaWsUQUBMPdxMe7e/
         zHK32zJSnTywMhA6QxEJC6cLh2gSOeWsc+QGEqWgz9n2WUjm0R7A1z9hxN4BQY0nQGOF
         D+5v0AwbB+LtXwUqQMddR2rQyS5cgLfAYmohwMh4tAeB0EDespvqvzkD9fizIx7k4Ult
         X5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713046481; x=1713651281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxFqmOp3HshWN+SgF1tbY2QlrStlEk1IWrM1mFhMRAI=;
        b=wz/7y8gMv+xK2Ro74tGnZYseb7y6FUx/j6EBDoJFeSYwAylQB4Zn43pavEe2whJ9/S
         YM9v/W/dD8BFQc1qyjhWpfnX+JmVN8X9g3Ll4lRy475aWC+Hj4PIC6E7P9jPZGMfmbqV
         Amo/Kb5sXSC3wAx1e6MoR0X3CqEHso3IalbDhX9RDA+0/tsbX2aqXiyqLuRIOnkEncLE
         sFQvg+2NoqjdY6pS7vnmgDQYGdBnpG/C3UIN7wbc4CmxtInbD3s+21utvNh5bmgm8LVk
         rVSd+DwIYG/MaEOA3DY+pP9FnYRK8IK8ieGhhWgKglpo79Pr4RZmx0w02V00MLPe6rKM
         9cow==
X-Forwarded-Encrypted: i=1; AJvYcCV3a+Ryyoh2SQckncEZ47xcjtdwOGDDxUBX+UwLGJLLD1bit/5ZlbYF6B0ueo6V8dG0DUD/YQFC0SCPzp3bXzYfMrU8gPEnYfeZP5+d
X-Gm-Message-State: AOJu0Yzx/sccnS7Az84MljiMacpheVJaHsSh4+xaAeo8JUdZ4z/LWV6W
	JeoJmbDA5K5MYNSQ4XBJNu2BVEcAWHM3eHPlNKPbZ/H2iQV1EDuiR/pG5P4wJMo=
X-Google-Smtp-Source: AGHT+IFcFugdj9bcTWs2YQtc+IVEziRNNY4/ZWW62w81MoufOnOsTtn3loVBBMBQBvaAMW24sH/sXw==
X-Received: by 2002:a05:6402:3895:b0:56f:db50:f2ca with SMTP id fd21-20020a056402389500b0056fdb50f2camr8490302edb.4.1713046481310;
        Sat, 13 Apr 2024 15:14:41 -0700 (PDT)
Received: from localhost (host-87-4-160-102.retail.telecomitalia.it. [87.4.160.102])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7c6cb000000b0056e7ba0497dsm2976956eds.28.2024.04.13.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:14:41 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	della Porta <andrea.porta@suse.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 0/6] Add support for BCM2712 SD card controller
Date: Sun, 14 Apr 2024 00:14:22 +0200
Message-ID: <cover.1713036964.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset adds support for the SDHCI controller on Broadcom BCM2712
SoC in order to make it possible to boot (particularly) Raspberry Pi 5
from SD card. This work is heavily based on downstream contributions.

Patch #1 and 2: introduce the dt binding definitions for, respectively,
the new pin cfg/mux controller and the SD host controller as a preparatory
step for the upcoming dts.

Patch #3: add a somewhat reasonable (*almost* bare-minimum) dts to be used
to boot Rpi5 boards. Since till now there was no support at all for any
2712 based chipset, both the SoC and board dts plus definitions for the
new Pin and SD host controller have been added.

Patch #4: the driver supporting the pin controller. Based on [1] and
successive fix commits.

Patch #5: add SDHCI support. Based on [2] and the next 2 fix commits.
Drop the SD Express implementation for now, that will be added by patch
#6.

Patch #6: this patch offers SD Express support and can be considered totally
optional. The callback plumbing is slightly different w.r.t. the downstream
approach (see [3]), as explained in the patch comment. Not sure what is the best,
any comment is highly appreciated.

Tested succesfully on Raspberry Pi 5 using an SDxC card as the boot device.

Still untested:
- SD Express due to the lack of an Express capable card.
  Also, it will need PCIe support first.
- card detection pin, since the sd was the booting and root fs device.

Many thanks,
Andrea

Links:
[1] - https://github.com/raspberrypi/linux/commit/d9b655314a826724538867bf9b6c229d04c25d84
[2] - https://github.com/raspberrypi/linux/commit/e3aa070496e840e72a4dc384718690ea4125fa6a
[3] - https://github.com/raspberrypi/linux/commit/eb1df34db2a9a5b752eba40ee298c4ae87e26e87

Andrea della Porta (6):
  dt-bindings: pinctrl: Add support for BCM2712 pin controller
  dt-bindings: mmc: Add support for BCM2712 SD host controller
  arm64: dts: broadcom: Add support for BCM2712
  pinctrl: bcm: Add pinconf/pinmux controller driver for BCM2712
  mmc: sdhci-brcmstb: Add BCM2712 support
  mmc: sdhci-brcmstb: Add BCM2712 SD Express support

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   51 +-
 .../pinctrl/brcm,bcm2712-pinctrl.yaml         |   99 ++
 arch/arm64/boot/dts/broadcom/Makefile         |    1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  313 +++++
 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |   81 ++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  841 +++++++++++
 drivers/mmc/host/Kconfig                      |    1 +
 drivers/mmc/host/sdhci-brcmstb.c              |  275 ++++
 drivers/pinctrl/bcm/Kconfig                   |    9 +
 drivers/pinctrl/bcm/Makefile                  |    1 +
 drivers/pinctrl/bcm/pinctrl-bcm2712.c         | 1247 +++++++++++++++++
 11 files changed, 2918 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
 create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2712.c

-- 
2.35.3


