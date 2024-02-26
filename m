Return-Path: <linux-kernel+bounces-80354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFEA86674B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCFCB20E71
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2911C36;
	Mon, 26 Feb 2024 00:22:56 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56519F;
	Mon, 26 Feb 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708906975; cv=none; b=tG2S6OH83wiqxbTEcWxa8EIl6XgbqZgWtIrDT0B1UBlFRdIMDzYGofFZotZRY5fkjeRsTEsFCvB22YWfIUmTOHfWASl34yMzeuy24tHV6DqvFf6lmdPNr6109U9cXbqqAV5UGJYiIZlrPPcb5qMbEl4ll95qDbDCRVxM97Mpe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708906975; c=relaxed/simple;
	bh=XgpawS2kecmzLSDpMZ/VLjdoFInp94yEmYbRTjat95w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oWBL1eatTYhJbwbhnV/gCdzrIPi8LDmYHjqrhHjB0wLfLf4FnW8ahXdJnyJTocPM2/k2yIL4DL/wQN0E9TBFWIFpD3y9iVGUNr/osUz87G5ufSPYqRYnTFfZRBt0EYBoVtX5uNVZVDui2W3u1+W/z6/IsMFNysx7Q/O4q278v7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1reOlW-0001nE-1i;
	Mon, 26 Feb 2024 00:22:42 +0000
Date: Mon, 26 Feb 2024 00:22:39 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/7] mtd: ubi: allow UBI volumes to provide NVMEM
Message-ID: <cover.1708906456.git.daniel@makrotopia.org>
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

As lots of time has passed NVMEM-on-UBI is by now already in-use
downstream at OpenWrt to support reading WiFi EEPROMs and MAC
addresses on a bunch of ASUS devices[2], [3] which laudably store all
in UBI. That also exposed a possible issue on 32-bit platforms which
has now been addressed in v8.

[1]: https://patchwork.ozlabs.org/project/linux-mtd/list/?series=353177&state=%2A&archive=both
[2]: https://github.com/openwrt/openwrt/pull/14676 (merged)
[3]: https://github.com/openwrt/openwrt/pull/14729 (pending)

Changes since v7:
 * use integer types with well-defined size for use with do_div(n, base)
   (addresses compiler warning when building on 32-bit platforms)

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
 drivers/mtd/ubi/Kconfig                       |  13 ++
 drivers/mtd/ubi/Makefile                      |   1 +
 drivers/mtd/ubi/block.c                       | 136 ++++++-------
 drivers/mtd/ubi/build.c                       | 154 ++++++++++----
 drivers/mtd/ubi/kapi.c                        |  56 +++--
 drivers/mtd/ubi/nvmem.c                       | 191 ++++++++++++++++++
 drivers/mtd/ubi/ubi.h                         |   3 +
 drivers/mtd/ubi/vmt.c                         |  44 +++-
 include/linux/mtd/ubi.h                       |   2 +
 11 files changed, 583 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
 create mode 100644 drivers/mtd/ubi/nvmem.c

-- 
2.44.0

