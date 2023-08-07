Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C02771C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjHGIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjHGIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:32 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FD1721
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3D50E000C;
        Mon,  7 Aug 2023 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfOp8t/SWXoAMbVxsmdWr6p/Yay0CylcPPBrARczmbM=;
        b=kjUDxNyS0uxFR0kzo+cDIBNqOC7LUzEn02ykcHbnNSze025tvzy0QDcE4EGC619pvA9rLd
        Qw4G81M2oHmkRSfdPHeOGK0hnZT5oDWD/NMjHhpxR8VgKbfcHmMXfcdk3nVS6W/9ht0Ol3
        7jwQaFF0HQrvZMZQqcmmDav2NYYW4jzbRLsmhWzh80IO7p8r2NkS5Ik6GPdyB6A771sO5e
        pxo8VfM8Gcq+mx6FCvGxTcIivij6NHOFwdfdUQJs7WxuvrjATWkio34auJm/CGnS4SBr6H
        n+J1V4Fjxh3+ZOkcOyWWK3a17Ea1x7a08QFR2sE+9oXaEXLQcpzyuGAug5q5JQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v8 7/8] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Date:   Mon,  7 Aug 2023 10:24:18 +0200
Message-Id: <20230807082419.38780-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807082419.38780-1-miquel.raynal@bootlin.com>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

