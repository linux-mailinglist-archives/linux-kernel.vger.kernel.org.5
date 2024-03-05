Return-Path: <linux-kernel+bounces-92953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EC87288D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22AE294B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671C129A99;
	Tue,  5 Mar 2024 20:24:05 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713381272CC;
	Tue,  5 Mar 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670244; cv=none; b=MH8kBei/SGd/7zUQhhdaLrNiPo9GDPlmrXx8kOuAsEfR0D7RT87MohBQ1OfYrOkV/huXxYXU/nrfZpsT8Tmt1fqN33R36iKDAaUdI67qUNeJ5GBZvNgFq9sSomuNLhK72jX60L0HQVHW+tiVtUPuv4PN1BB+BI/3zR+Iw9x3NnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670244; c=relaxed/simple;
	bh=2Xnx+UxJNe1jbb9epdvb8xlWEdXQg0apHljlHnmwwvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AlTbf7m84sbw0hzBNhWiVcVW9qHO4+kLt6cw4F0Q9mZWR4gaZQQu4sKOFXe+9J8ti+fnGBFeUjTfcvqdUFPw9x2TxaT2CGWHsZsq7lSwf+NwA+B/gczJfNwpoHla7YgdE/mOOvgHQNg+gUTYNIUQG0yvB/tP5lMl4nClbeGTLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rhbJf-0001Ly-1n;
	Tue, 05 Mar 2024 20:23:11 +0000
Date: Tue, 5 Mar 2024 20:23:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
	Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Cc: Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: [RFC PATCH v2 0/8] nvmem: add block device NVMEM provider
Message-ID: <cover.1709667858.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On embedded devices using an eMMC it is common that one or more (hw/sw)
partitions on the eMMC are used to store MAC addresses and Wi-Fi
calibration EEPROM data.

Implement an NVMEM provider backed by block devices as typically the
NVMEM framework is used to have kernel drivers read and use binary data
from EEPROMs, efuses, flash memory (MTD), ...

In order to be able to reference hardware partitions on an eMMC, add code
to bind each hardware partition to a specific firmware subnode.

This series is meant to open the discussion on how exactly the device
tree schema for block devices and partitions may look like, and even
if using the block layer to back the NVMEM device is at all the way to
go -- to me it seemed to be a good solution because it will be reuable
e.g. for (normal, software GPT or MBR) partitions of an NVMe SSD.

This series has previously been submitted on July 19th 2023[1] and most of
the basic idea did not change since.

However, the recent introduction of bdev_file_open_by_dev() allow to
get rid of most use of block layer internals which supposedly was the
main objection raised by Christoph Hellwig back then.

Most of the other comments received for in the first RFC have also
been addressed, however, what remains is the use of class_interface
(lacking an alternative way to get notifications about addition or
removal of block devices from the system). As this has been criticized
in the past I'm specifically interested in suggestions on how to solve
this in another way -- ideally without having to implement a whole new
way for in-kernel notifications of appearing or disappearing block
devices...

And, in a way just like in case of MTD and UBI, I believe acting as an
NVMEM provider *is* a functionality which belongs to the block layer
itself and, other than e.g. filesystems, is inconvenient to implement
elsewhere.

[1]: https://patchwork.kernel.org/project/linux-block/list/?series=767565

Daniel Golle (8):
  dt-bindings: block: add basic bindings for block devices
  block: partitions: populate fwnode
  block: add new genhd flag GENHD_FL_NVMEM
  block: implement NVMEM provider
  dt-bindings: mmc: mmc-card: add block device nodes
  mmc: core: set card fwnode_handle
  mmc: block: set fwnode of disk devices
  mmc: block: set GENHD_FL_NVMEM

 .../bindings/block/block-device.yaml          |  22 +++
 .../devicetree/bindings/block/partition.yaml  |  51 +++++
 .../devicetree/bindings/block/partitions.yaml |  20 ++
 .../devicetree/bindings/mmc/mmc-card.yaml     |  45 +++++
 block/Kconfig                                 |   9 +
 block/Makefile                                |   1 +
 block/blk-nvmem.c                             | 175 ++++++++++++++++++
 block/partitions/core.c                       |  41 ++++
 drivers/mmc/core/block.c                      |   8 +
 drivers/mmc/core/bus.c                        |   2 +
 include/linux/blkdev.h                        |   2 +
 11 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml
 create mode 100644 block/blk-nvmem.c

-- 
2.44.0

