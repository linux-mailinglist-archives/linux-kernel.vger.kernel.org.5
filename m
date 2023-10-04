Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F27B97EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjJDWXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjJDWXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:23:01 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD610F;
        Wed,  4 Oct 2023 15:22:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 664391C0006;
        Wed,  4 Oct 2023 22:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696458175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfOp8t/SWXoAMbVxsmdWr6p/Yay0CylcPPBrARczmbM=;
        b=clzmPzVFVf89AykIKBa1Jei5WFbi6RaZdA04K8dmqtHHD9JYr1WRT+l6ekSwU4VadGsfHV
        xw8Q6S9IB8kfK5yLAo9UsXwIr0159hMbyBU9VPO5iI2WxsQ6D/PVqGjxKWpy6PeRMnOdXe
        yA4oxOO8L1qdRPIJVXmLWxokyQvCF3y1+obtnEYkB9n/jK1hwGeLhvpi6V2J6D60v/ZZG/
        h+jYZQsgi7jSPUo7kZ5fQ4SSoNND2+dkBkZ5IeYSmkbxJAxvKhOEnPiX9yH4E7pw7MiRrq
        83fmb4fxXptRJ7wGOxGvAe1DG5XfJQt7psHim2krZBao1pkp3KBXoUfoMbongw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v11 6/7] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Date:   Thu,  5 Oct 2023 00:22:35 +0200
Message-Id: <20231004222236.411248-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004222236.411248-1-miquel.raynal@bootlin.com>
References: <20231004222236.411248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binary content of nvmem devices is available to the user so in the
easiest cases, finding the content of a cell is rather easy as it is
just a matter of looking at a known and fixed offset. However, nvmem
layouts have been recently introduced to cope with more advanced
situations, where the offset and size of the cells is not known in
advance or is dynamic. When using layouts, more advanced parsers are
used by the kernel in order to give direct access to the content of each
cell regardless of their position/size in the underlying device, but
these information were not accessible to the user.

By exposing the nvmem cells to the user through a dedicated cell/ folder
containing one file per cell, we provide a straightforward access to
useful user information without the need for re-writing a userland
parser. Content of nvmem cells is usually: product names, manufacturing
date, MAC addresses, etc,

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-nvmem-cells | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells

diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
new file mode 100644
index 000000000000..7af70adf3690
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-nvmem-cells
@@ -0,0 +1,21 @@
+What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
+Description:
+		The "cells" folder contains one file per cell exposed by the
+		NVMEM device. The name of the file is: <name>@<where>, with
+		<name> being the cell name and <where> its location in the NVMEM
+		device, in hexadecimal (without the '0x' prefix, to mimic device
+		tree node names). The length of the file is the size of the cell
+		(when known). The content of the file is the binary content of
+		the cell (may sometimes be ASCII, likely without trailing
+		character).
+		Note: This file is only present if CONFIG_NVMEM_SYSFS
+		is enabled.
+
+		Example::
+
+		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name@d
+		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
+		  0000000a
-- 
2.34.1

