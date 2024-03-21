Return-Path: <linux-kernel+bounces-110590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A20886103
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6B41C21ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E081013442F;
	Thu, 21 Mar 2024 19:33:14 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A58133422;
	Thu, 21 Mar 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049594; cv=none; b=ryITxzUdfJx3jeZCe/RC6Kck6UZqYgN+XucNGrEIWcMmlS6sWxhcmB30e+la5gtnDx+o8+ahCBDkpQypaX8cccQddqiXJghs+RhumizlI84ycFbmIQFO/4jAEXVfGwM+p8dXaaXuOQkeMy50SfQFDuZ5i/u2I802ex9mDiEqjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049594; c=relaxed/simple;
	bh=xXa4FF7nQG3CwW6ptYwxB1tD6/Yh0AKEy2Pi0Dfq8GU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ANwf1zngs/Np/yvc7/UYXQjVhFuisgFIbZ+AVgckrIixMgkQsDmQ9pj860Ma0DuRMPzkkxjhF4uvAnOXfbkyJstOP5YmDc1fC6mTTjuHVB2CZqxiGfZGtXBgKVDwhCaPCIojrQVeC1t+5qpcJMqbvNwh2TkgjDG5C2/3W+/1U+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnO9R-0000Cf-2Z;
	Thu, 21 Mar 2024 19:32:33 +0000
Date: Thu, 21 Mar 2024 19:31:48 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 0/8] block: implement NVMEM provider
Message-ID: <cover.1711048433.git.daniel@makrotopia.org>
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

Implement an NVMEM provider backed by a block device as typically the
NVMEM framework is used to have kernel drivers read and use binary data
from EEPROMs, efuses, flash memory (MTD), ...

In order to be able to reference hardware partitions on an eMMC, add code
to bind each hardware partition to a specific firmware subnode.

Overall, this enables uniform handling across practially all flash
storage types used for this purpose (MTD, UBI, and now also MMC).

As part of this series it was necessary to define a device tree schema
for block devices and partitions on them, which (similar to how it now
works also for UBI volumes) can be matched by one or more properties.

---
This series has previously been submitted as RFC on July 19th 2023[1]
and most of the basic idea did not change since. Another round of RFC
was submitted on March 5th 2024[2] which has received overall positive
feedback and only minor corrections have been done since (see
changelog below).

[1]: https://patchwork.kernel.org/project/linux-block/list/?series=767565
[2]: https://patchwork.kernel.org/project/linux-block/list/?series=832705

Changes since RFC:
 * Use 'partuuid' instead of reserved 'uuid' keyword to match against
   PARTUUID.
 * Simplify blk_nvmem_init(void) function.

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
 .../devicetree/bindings/block/partition.yaml  |  51 ++++++
 .../devicetree/bindings/block/partitions.yaml |  20 +++
 .../devicetree/bindings/mmc/mmc-card.yaml     |  45 +++++
 MAINTAINERS                                   |   5 +
 block/Kconfig                                 |   9 +
 block/Makefile                                |   1 +
 block/blk-nvmem.c                             | 169 ++++++++++++++++++
 block/partitions/core.c                       |  41 +++++
 drivers/mmc/core/block.c                      |   8 +
 drivers/mmc/core/bus.c                        |   2 +
 include/linux/blkdev.h                        |   2 +
 12 files changed, 375 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml
 create mode 100644 block/blk-nvmem.c

-- 
2.44.0

