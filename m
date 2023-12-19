Return-Path: <linux-kernel+bounces-4599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1921817FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BD91F23C06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE654C78;
	Tue, 19 Dec 2023 02:32:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6F7AD47;
	Tue, 19 Dec 2023 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rFPte-0008Gy-2m;
	Tue, 19 Dec 2023 02:31:52 +0000
Date: Tue, 19 Dec 2023 02:31:44 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/7] mtd: ubi: allow UBI volumes to provide NVMEM
Message-ID: <cover.1702952891.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Similar to how MAC addresses and Wi-Fi calibration data would be
stored inside an MTD partition on devices coming with NOR flash, a UBI
volume is used by some vendors in the same way on devices with NAND
flash.

The goal of this series is to support such embedded Linux devices which
got NVMEM bits stored inside a UBI volume.

Representing the UBI volume in the Device Tree and adding a phandle to
be referenced by NVMEM consumers allows such devices to come up with
their correct MAC addresses and device-specific Wi-Fi calibration data
loaded.

In order for NVMEM bits to be available for other drivers, attaching
UBI devices has to be moved from late_initcall (which is too late for
other drivers) to happen earlier. As an alternative to the existing
kernel cmdline parameter the Device Tree property 'compatible =
"linux,ubi";' inside an MTD partition can be used to have that MTD
device attached as UBI device. MTD partitions which serve as UBI
devices may have a "volumes" subnode with volumes, and volumes may
have an "nvmem-layout" object which will trigger the creation of an
emulated NVMEM device on top of the UBI volume.

In this way, other drivers (think: Ethernet, Wi-Fi) can resolve and
acquire NVMEM bits using the usual device tree phandle, just this time
the NVMEM content is read from a UBI volume.

This series is a follow-up and contains most patches of the previous
series "mtd: ubi: behave like a good MTD citizen"[1] which was meant in
preparation for implementing the NVMEM provider.

[1]: https://patchwork.ozlabs.org/project/linux-mtd/list/?series=353177&state=%2A&archive=both

Changes since v6:
 * dt-bindings fixes got squashed into the wrong patch, fix that and
   newly introduced YAML white space issues

Changes since v5:
 * fix whitespace problems in dt-schema additions

Changes since v4:
 * split ubi_open_volume_path() breaking out reusable parts for
   new match_volume_desc() function as suggested by Richard Weinberger.
   Doing the same for ubi_open_volume_nm() doesn't work as we are working
   on struct ubi_volume_info in match_volume_desc() while ubi_open_volume_nm()
   is working on struct ubi_volume. That reduces the common part to a string
   comparision and length check which doesn't seem worth breaking out of the
   existing function.
 * drop patches and changes not strictly needed for NVMEM use-case:
   - don't handle ubi detach on MTD removal notification. It was not done
     until now and the locking hell I was facing when trying to implement
     that is non trivial.
   - don't relocate the call to ubiblock device creation to the
     notification handler
   - change ubiblock only as far as needed to handle creation from cmdline
     parameter when a volume is added.
 * improve commit messages and comments

Changes since v3:
 * dt-bindings fixes as requested

Changes since v2:
 * include dt-bindings additions

Changes since v1:
 * include patch to fix exiting Kconfig formatting issues
 * fix typo and indentation in Kconfig



Daniel Golle (7):
  dt-bindings: mtd: add basic bindings for UBI
  dt-bindings: mtd: ubi-volume: allow UBI volumes to provide NVMEM
  mtd: ubi: block: use notifier to create ubiblock from parameter
  mtd: ubi: attach from device tree
  mtd: ubi: introduce pre-removal notification for UBI volumes
  mtd: ubi: populate ubi volume fwnode
  mtd: ubi: provide NVMEM layer over UBI volumes

 .../bindings/mtd/partitions/linux,ubi.yaml    |  75 +++++++
 .../bindings/mtd/partitions/ubi-volume.yaml   |  40 ++++
 drivers/mtd/ubi/Kconfig                       |  12 ++
 drivers/mtd/ubi/Makefile                      |   1 +
 drivers/mtd/ubi/block.c                       | 136 ++++++-------
 drivers/mtd/ubi/build.c                       | 154 ++++++++++----
 drivers/mtd/ubi/kapi.c                        |  56 ++++--
 drivers/mtd/ubi/nvmem.c                       | 188 ++++++++++++++++++
 drivers/mtd/ubi/ubi.h                         |   3 +
 drivers/mtd/ubi/vmt.c                         |  44 +++-
 include/linux/mtd/ubi.h                       |   2 +
 11 files changed, 579 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
 create mode 100644 drivers/mtd/ubi/nvmem.c

-- 
2.43.0

