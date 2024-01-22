Return-Path: <linux-kernel+bounces-33607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F531836D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684BCB2953A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD747A53;
	Mon, 22 Jan 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huiK570m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADB47A47;
	Mon, 22 Jan 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937692; cv=none; b=L8bVFcc9rfRQqUlz9MSt3llx5LxBwIylDiG8ZbaguVu8pbHYFQ1BiSlY1+gBoroIZ4yXwL4wASbeV/Mf8Fn5CLGhB7QzBwaPgKg0MOoSSnm2xP6EcLTERkO6LpFeH5Kdp4feWQLXNt3lTwEPv/jG/MM1gWlrZvtGZFy4xn70XhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937692; c=relaxed/simple;
	bh=Jks5sf/UfPE0bYDwUpkmUHjITugaPt2CLUuUwk0Ne4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qiQfDLNRG8vA90XamcSaCrjN/h+Y8bnPQFtiWFlAHAR4sFD1wZyiOh4vHJtoHwuUoOVHY8xs1xTj31Cu/wDXusXGoK9LTX2nSGxhOWPZyUY5p6uT7hOfmNsgP6A5IBb2aey+oREqoNPQoQI2Y2n2TYVHAQJke9TTc+QELcpCStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huiK570m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D6BC433C7;
	Mon, 22 Jan 2024 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937691;
	bh=Jks5sf/UfPE0bYDwUpkmUHjITugaPt2CLUuUwk0Ne4A=;
	h=From:To:Cc:Subject:Date:From;
	b=huiK570mOH2h2AcKfWF6+I6+iHy0eqELtLOlXfgkqbUkalmjp7gTjSYRQFhl+8UqA
	 JKYICN4RyC4VmfB4jqSZwICt5JgZplL+s2uFDm71LSLgwyBxRpXGMrLPJw5p6tVWy5
	 TSGJyPWHenFW3ya/5L9CPlIIV+ThDVVB+E/s7eqnQVyyPjkMm8thaQuYHIYjgtHN9e
	 Rpy7AI1yVpPxgxWXPMlKU6WSJ/cLOfCHxAg9YEsIQzWnNdw28wWXtKUwFQILGST+DK
	 jS6iyx18Ul+l8I78SQSLkbpqCwKmVlFbodVTgiMmFAqq8lGuzleWufjpFvoGlfscoo
	 9H775j0OtARKA==
From: Arnd Bergmann <arnd@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	regressions@lists.linux.dev,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	asahi@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>,
	Michael Walle <michael@walle.cc>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: include bit index in cell sysfs file name
Date: Mon, 22 Jan 2024 16:34:10 +0100
Message-Id: <20240122153442.7250-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Creating sysfs files for all Cells caused a boot failure for linux-6.8-rc1 on
Apple M1, which (in downstream dts files) has multiple nvmem cells that use the
same byte address. This causes the device probe to fail with

[    0.605336] sysfs: cannot create duplicate filename '/devices/platform/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
[    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S                 6.8.0-rc1-arnd-5+ #133
[    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
[    0.605362] Call trace:
[    0.605365]  show_stack+0x18/0x2c
[    0.605374]  dump_stack_lvl+0x60/0x80
[    0.605383]  dump_stack+0x18/0x24
[    0.605388]  sysfs_warn_dup+0x64/0x80
[    0.605395]  sysfs_add_bin_file_mode_ns+0xb0/0xd4
[    0.605402]  internal_create_group+0x268/0x404
[    0.605409]  sysfs_create_groups+0x38/0x94
[    0.605415]  devm_device_add_groups+0x50/0x94
[    0.605572]  nvmem_populate_sysfs_cells+0x180/0x1b0
[    0.605682]  nvmem_register+0x38c/0x470
[    0.605789]  devm_nvmem_register+0x1c/0x6c
[    0.605895]  apple_efuses_probe+0xe4/0x120
[    0.606000]  platform_probe+0xa8/0xd0

As far as I can tell, this is a problem for any device with multiple cells on
different bits of the same address. Avoid the issue by changing the file name
to include the first bit number.

Fixes: 0088cbc19276 ("nvmem: core: Expose cells through sysfs")
Link: https://github.com/AsahiLinux/linux/blob/bd0a1a7d4/arch/arm64/boot/dts/apple/t600x-dieX.dtsi#L156
Cc: regressions@lists.linux.dev
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rafał Miłecki <rafal@milecki.pl>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: asahi@lists.linux.dev
Cc: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This might not be the fix we want upstream, but it illustrates the issue and
I have successfully tested that this lets me boot v6.8-rc1 on my workstation
again.

Feel free to just treat this as a bug report and suggest a different fix.
As the ABI was only introduced in 6.8-rc1, it can still be changed without
causing other regressions for users, but time is running out for that.
---
 Documentation/ABI/testing/sysfs-nvmem-cells | 16 ++++++++--------
 drivers/nvmem/core.c                        |  5 +++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
index 7af70adf3690..c7c9444f92a8 100644
--- a/Documentation/ABI/testing/sysfs-nvmem-cells
+++ b/Documentation/ABI/testing/sysfs-nvmem-cells
@@ -4,18 +4,18 @@ KernelVersion:	6.5
 Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
 Description:
 		The "cells" folder contains one file per cell exposed by the
-		NVMEM device. The name of the file is: <name>@<where>, with
-		<name> being the cell name and <where> its location in the NVMEM
-		device, in hexadecimal (without the '0x' prefix, to mimic device
-		tree node names). The length of the file is the size of the cell
-		(when known). The content of the file is the binary content of
-		the cell (may sometimes be ASCII, likely without trailing
-		character).
+		NVMEM device. The name of the file is: "<name>@<byte>,<bit>",
+		with <name> being the cell name and <where> its location in
+		the NVMEM device, in hexadecimal bytes and bits (without the
+		'0x' prefix, to mimic device tree node names). The length of
+		the file is the size of the cell (when known). The content of
+		the file is the binary content of the cell (may sometimes be
+		ASCII, likely without trailing character).
 		Note: This file is only present if CONFIG_NVMEM_SYSFS
 		is enabled.
 
 		Example::
 
-		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name@d
+		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name@d,0
 		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
 		  0000000a
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1d77724f367d..9616c6001b3c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -460,8 +460,9 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 	list_for_each_entry(entry, &nvmem->cells, node) {
 		sysfs_bin_attr_init(&attrs[i]);
 		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
-						    "%s@%x", entry->name,
-						    entry->offset);
+						    "%s@%x,%x", entry->name,
+						    entry->offset,
+						    entry->bit_offset);
 		attrs[i].attr.mode = 0444;
 		attrs[i].size = entry->bytes;
 		attrs[i].read = &nvmem_cell_attr_read;
-- 
2.39.2


