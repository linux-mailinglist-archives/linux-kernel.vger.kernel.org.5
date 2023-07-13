Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76EF751A70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjGMHzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjGMHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:55:13 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D0170E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:55:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CAF30C0014;
        Thu, 13 Jul 2023 07:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689234910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfMfKPkntdHDW0sVYPIRqZGSzZ5pCxH34lQ77nS039A=;
        b=gIKQFqV7w/iP9I4Dxnqq19gV3bMnRitqzd8uLwTUvSVgYuR3h2mWDjQHaPXvJ9J72LG8v8
        n//3ZSg1WJMETukogrqvaRl0Lkx7H6Jj5/MAvhrIm8cgY6uTguPJMFV8UhSwq/7hHaH7xG
        kB0Rlk43+eq6I+0/ljLRd5lJ58loAfkb3VAz5Hvob5qdeZAcQF5PqRIcnxI+/4wou22jHp
        sdkDlpqp7Z8TwJTEkPu8gd5Mb+/bCMUVPGwBmRuVZ7K/D4Q+5Dc4C5ebrBPMayZniP+Trm
        Gd6GQh/+yQK22QZZq/1BV4DDxiuqFvxUodc3HHBC0WLpsAjZm5k2jokXeUuCvw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH RESEND v5 1/3] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Date:   Thu, 13 Jul 2023 09:55:05 +0200
Message-Id: <20230713075508.485072-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713075508.485072-1-miquel.raynal@bootlin.com>
References: <20230713075508.485072-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells

diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
new file mode 100644
index 000000000000..641a7d7dad76
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-nvmem-cells
@@ -0,0 +1,19 @@
+What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
+Description:
+		The cells/ folder contains one file per cell exposed by
+		the nvmem device. The name of the file is the cell name.
+		The length of the file is the size of the cell (when
+		known). The content of the file is the binary content of
+		the cell (may sometimes be ASCII, likely without
+		trailing character).
+		Note: This file is only present if CONFIG_NVMEM_SYSFS
+		is enabled
+
+		ex::
+
+		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name
+		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
+		  0000000a
-- 
2.34.1

