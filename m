Return-Path: <linux-kernel+bounces-104804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD887D3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272F52852BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35D3EA77;
	Fri, 15 Mar 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTfsisbc"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE01DA5E;
	Fri, 15 Mar 2024 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528573; cv=none; b=V0EUZQwIJfyYLW53XceSuZv+HgkggsQ2O4kycH8ouzuESfee3X21vJR3Ms4SOmbSn8nRWf2b9s1vJAVoYQJ68E9zrvmKdxogqNG54F2Gxu/gXI8n0S01TgabT1sNEyCc6sfVqR74OW/h+aRxFkNRYu9Thwm1QUFbKsheL47H68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528573; c=relaxed/simple;
	bh=TUaLTjMHi0ATSdYVSTcztH1hOv53rJUBBNITH8jgPQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtPQW8+ObUjMiUNSbiyO4upTK5f9ndP4Dd8xJOGXkuJ65L9LXWn54cCe1d7VZm4sD4+TuJqZawKVX/A8R0cUOPX3c8FEexTsx0q6JI5GnfXDWGpVr5ViIuT7arMNshXYareFsZErHP00vvP7Uco60cnbwpubJwebSZkVYTIWTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTfsisbc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso1337433b3a.1;
        Fri, 15 Mar 2024 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528569; x=1711133369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkr1Nn4aLr68egb6cv/rvXMAargek6kpQuKuYfi/gnw=;
        b=CTfsisbcFempEX5ONfKMP3hJmH+b5KNNmfGP3UqilH5HSe7H3MccQOMe5aHNVxWfzi
         xCmwS738o42dCG5YudcwCaEHqyvnQgAtDdv7WRN7uLr/TTP/cRNdpMVBpqkMxWPP4DfI
         ZcENRWTG2nOCHfoOIdxqGGXvdfTROxSG4Bq6XXy6gAhWjzLesMbbEyiu9WGLlVTxqGn2
         iiERDmmBehMrS3txf3jOI/eMV8sqjZde5lrjwu39njdMRiNyMJoICG8FKYkx6LgvrHNH
         BFenQfoJYOP2TT2FPVZbY6BqQuTTLqHdnWwo86K3jYxFXEHYQOqDz2s8skg/7jHEGABP
         txDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528569; x=1711133369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vkr1Nn4aLr68egb6cv/rvXMAargek6kpQuKuYfi/gnw=;
        b=j3+JwJsod2B37WUf++jngcIc9jfomttUVTiWihVuWDfpEr4g8kMgpZ+a8G3HjeU+jj
         NqTkt7RrAvmo5CoQkRaFkghTCn2rncqoOYcL3YC16C+JA+MJM5euRpzA1k4mrSm6aRNn
         V+Q9Wptx3RyDla3PmkSktE7RRzkClzKWufFsulkIj1WV5IZeKVBeQoBXdDNjk++ZlET5
         gAlyM0lj1J8+FBpvv2YgNgq00rL1pJsdriv1sYtEBaRtj4B4IMH27b853NeknQsEsAIt
         E2FsDSnRixFyT7bJP8kL2c9+k0LA2mSRvw6PQAzRt+NiqBWIrjN0+1a6nnsSHZPfAWYM
         sgDA==
X-Forwarded-Encrypted: i=1; AJvYcCUc32k3ev1bX5kO9ldb+B/ywASMrD1zpx/0NEWAYd06Ne2hPG+aKQMua4SgGp5tWZFp5asR14s2SEhkcJF0GH+J4czMXSngnfssuP9MVyeiISPdgKF9CPs4+r5B05JRaRcNUvl6refO+LnlJSO/VJW7Dvskx/3/w8Zm477MkMuNYYnP5g==
X-Gm-Message-State: AOJu0YxxxbmCCHtMbXGOHpmzveeRGiHotrGNBZ4BVNegmW4nWl6JLWGp
	NukFmY8Zkvcc4rGjyXD8W51h4cj3j/k6DRQN37OQCJLHgPX0fuRrxrN5jYhdUKTODA==
X-Google-Smtp-Source: AGHT+IHsm+HO3GDXSv/GZ4EFy5jwTiMdLS+yIDpRIDjfiLH/zmrN5f9qf6zHblX1mbdu531OocugkQ==
X-Received: by 2002:a05:6a00:a18:b0:6e5:1196:6cf5 with SMTP id p24-20020a056a000a1800b006e511966cf5mr14112902pfh.3.1710528568856;
        Fri, 15 Mar 2024 11:49:28 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:49:28 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH v3 0/8] misc: Add mikroBUS driver
Date: Sat, 16 Mar 2024 00:18:58 +0530
Message-ID: <20240315184908.500352-1-ayushdevel1325@gmail.com>
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
parse, and flash mikroBUS manifest and register the mikroBUS board.

The v1 and v2 of this patchset was submitted by Vaishnav M A back in
2020. This patchset also includes changes made over the years as part of
BeagleBoards kernel.

Link: https://www.mikroe.com/mikrobus
Link: https://docs.beagleboard.org/latest/boards/beagleplay/
Link: https://lore.kernel.org/lkml/20200818124815.11029-1-vaishnav@beagleboard.org/ Patch v2

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

Ayush Singh (7):
  dt-bindings: misc: Add mikrobus-connector
  w1: Add w1_find_master_device
  spi: Make of_find_spi_controller_by_node() available
  regulator: fixed-helper: export regulator_register_always_on
  greybus: Add mikroBUS manifest types
  mikrobus: Add mikrobus driver
  dts: ti: k3-am625-beagleplay: Add mikroBUS

Vaishnav M A (1):
  serdev: add of_ helper to get serdev controller

 .../bindings/misc/mikrobus-connector.yaml     | 110 ++
 MAINTAINERS                                   |   7 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  76 +-
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/mikrobus/Kconfig                 |  19 +
 drivers/misc/mikrobus/Makefile                |   6 +
 drivers/misc/mikrobus/mikrobus_core.c         | 942 ++++++++++++++++++
 drivers/misc/mikrobus/mikrobus_core.h         | 201 ++++
 drivers/misc/mikrobus/mikrobus_id.c           | 229 +++++
 drivers/misc/mikrobus/mikrobus_manifest.c     | 502 ++++++++++
 drivers/misc/mikrobus/mikrobus_manifest.h     |  20 +
 drivers/regulator/fixed-helper.c              |   1 +
 drivers/spi/spi.c                             | 206 ++--
 drivers/tty/serdev/core.c                     |  19 +
 drivers/w1/w1.c                               |   6 +-
 drivers/w1/w1_int.c                           |  27 +
 include/linux/greybus/greybus_manifest.h      |  49 +
 include/linux/serdev.h                        |   4 +
 include/linux/spi/spi.h                       |   4 +
 include/linux/w1.h                            |   1 +
 21 files changed, 2318 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
 create mode 100644 drivers/misc/mikrobus/Kconfig
 create mode 100644 drivers/misc/mikrobus/Makefile
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_id.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h


base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
-- 
2.44.0


