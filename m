Return-Path: <linux-kernel+bounces-105524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D287DFB1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A570EB20B45
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62D1EB4A;
	Sun, 17 Mar 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4HNCFHL"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0F1EA6E;
	Sun, 17 Mar 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704284; cv=none; b=PsQ5iob57PnEkP99ScVzGEpVzCY7aFFRmDTpZPW1v1RP363YpKfiIQjh7kpiwexrwpEXVsABZo6PbUt/SV1+LCLTJZv7Gxk+9X3a/Lk9bkkL6Z+u6sC10g/rvXMO1anNiFXBZ/73SbWDhduNNQuzCdgvDeHv+VIANZQANB3qo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704284; c=relaxed/simple;
	bh=BfRnG96EKVJ32TPtvQxV/YNSmfSZ4BBPPWl/rMBySTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSv2siqc63MqRItDic3IIBfuqRXZa9n68OBoKGrK/jG1EkHyWePkK/U6lG+T8jkEr1myfSXIxcUSKJMwwm3jHEzfKKfpGwKa9/D3FkurwPS4xGDASAzUUryyrwECf5/MksfTkw+X2zUBYkJ1r6Y/LNx3XQsShkRegN0QO+SBgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4HNCFHL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so3088073b3a.2;
        Sun, 17 Mar 2024 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704282; x=1711309082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOuQoK+aCpD9BndP2a56795Q5pkcrTD7MkJhQYgQRRE=;
        b=M4HNCFHL4Fp3h2z7sAVHrERg4O2pAtPWuil5E9C8yEM7oNUBLSmnEIzx7BE+zcIuen
         4xqCU7I3WGD71OwNGFpJWrK35ccAqx0+M6ShfoamACVYDxaiBKsgX/CO7TnlZ/NZDpas
         4WMRC9nQwCQtLBw7yLRcH8rcPwtbhcAOOEDvEyaSL2cMhehROi+l5OpF+Q5mmPAtstxf
         oLNnA10FWuMrYtkNKQWVI0dvuSHsII7qaPWWX6NVSgdLS+pqHXwuXtoP/rJFUTrUhObK
         1D+Po0ZZ0Nk3NnwFBJ+D7guDx3l7awAB/+OL3cXHNXX9G7RCm6cqith9drCxneIYB/vP
         cRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704282; x=1711309082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOuQoK+aCpD9BndP2a56795Q5pkcrTD7MkJhQYgQRRE=;
        b=I8vU5SD0KQjitGCms7QpAARu6PM8D6eqczWjXfMF9R2V5vSyWf89HPhBgdXU56WCWT
         Vg9JVm+xr8wB2M3fih8Yc4OtQ/rQJjLnmJkkqkvNl+/U70KaKDDUcoyCV/QQjJPAvVi3
         byhiKYyOspT7EM2ekNF8QvRRM1Ue4wASEtil1IMtKn2Yp85as/OvIWws7b8ksRp5tE/s
         YP9Jg4Sx5vpzVBbC6lYpyzDKkY+VOsC4HuLxhIcTym4J9IvKuw0jnh1TF+1DDWD3DwHt
         BYm4UdC8rNaSHR5ddHfU/Htqg9KJWRh8PxjUDR5UWJlDuRy73gqBkvVbVg4ZZ5HAPW0F
         zZDg==
X-Forwarded-Encrypted: i=1; AJvYcCUDrvRuQL8ryltRPMsJAanb/UA5AqdPWXL95BLnwV4xetKlJilbW/j9BKUDCgeo75xK9p2Ccz4qDZmSuV3e/618vEcWZrkhc7h3hzomPQY8h4wWSoiQMQgTtxnFdZLMr+3M0omFjg==
X-Gm-Message-State: AOJu0Yx5M6eXwfuFJfIXKJt90G3ectOwKmIElaVL9SkdsLnJ5lObsjZF
	OvJeB1d+qGON+4CUQu4tCL5dtKASEPtIGM7X8VhNi09L+TacYfh3tU2EZYfNP8A=
X-Google-Smtp-Source: AGHT+IF36PtWXGUyktoxAgcK72f91CpSjqHRlGCFk/zUs9CV8FTiGRE9UbHnhk653DcJjP0P++a9rA==
X-Received: by 2002:a05:6a21:3945:b0:1a3:5f13:e43d with SMTP id ac5-20020a056a21394500b001a35f13e43dmr2179598pzc.25.1710704281676;
        Sun, 17 Mar 2024 12:38:01 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6125995pjb.44.2024.03.17.12.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:38:01 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org (open list)
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM)
Subject: [PATCH v4 0/5] misc: Add mikroBUS driver
Date: Mon, 18 Mar 2024 01:07:08 +0530
Message-ID: <20240317193714.403132-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MikroBUS is an open standard  developed by MikroElektronika for connecting
add-on boards to microcontrollers or microprocessors. It essentially
allows you to easily expand the functionality of your main boards using
these add-on boards.

This patchset adds mikroBUS as a Linux bus type and provides a driver to
parse and register the mikroBUS board using mikroBUS manifest.

The patchset is based on work originally done by Vaishnav.

Link: https://www.mikroe.com/mikrobus
Link: https://docs.beagleboard.org/latest/boards/beagleplay/
Link: https://lore.kernel.org/lkml/20240315184908.500352-1-ayushdevel1325@gmail.com/ Patch v3

Changes v4:
- Better commit messages
- Remove clickID, serdev, pwm, regulator, clocks etc. Just the basic
  mikroBUS driver.
- Fix a lot of memory leaks, unused variables, etc.
- Create accompanying PR in Greybus Spec repository
- Switch to 80 columns formatting
- Some other fixes pointed out in v3

Changes in v3:
- Use phandle instead of busname for spi
- Use spi board info for registering new device
- Convert dt bindings to yaml
- Add support for clickID
- Code cleanup and style changes
- Additions required to spi, serdev, w1 and regulator subsystems

Changes in v2:
- support for adding mikroBUS ports from DT overlays,
- remove debug sysFS interface for adding mikrobus ports,
- consider extended pin usage/deviations from mikrobus standard
  specifications
- use greybus CPort protocol enum instead of new protocol enums
- Fix cases of wrong indentation, ignoring return values, freeing allocated
  resources in case of errors and other style suggestions in v1 review.

Ayush Singh (5):
  dt-bindings: misc: Add mikrobus-connector
  spi: Make of_find_spi_controller_by_node() available
  greybus: Add mikroBUS manifest types
  mikrobus: Add mikroBUS driver
  dts: ti: k3-am625-beagleplay: Add mikroBUS

 .../connector/mikrobus-connector.yaml         | 113 +++
 MAINTAINERS                                   |   7 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  80 +-
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/mikrobus/Kconfig                 |  15 +
 drivers/misc/mikrobus/Makefile                |   5 +
 drivers/misc/mikrobus/mikrobus_core.c         | 696 ++++++++++++++++++
 drivers/misc/mikrobus/mikrobus_core.h         | 151 ++++
 drivers/misc/mikrobus/mikrobus_manifest.c     | 503 +++++++++++++
 drivers/misc/mikrobus/mikrobus_manifest.h     |  29 +
 drivers/spi/spi.c                             | 206 +++---
 include/linux/greybus/greybus_manifest.h      |  49 ++
 include/linux/spi/spi.h                       |   4 +
 14 files changed, 1750 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
 create mode 100644 drivers/misc/mikrobus/Kconfig
 create mode 100644 drivers/misc/mikrobus/Makefile
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h


base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
-- 
2.44.0


