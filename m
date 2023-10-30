Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4637DBC5D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjJ3PGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjJ3PGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:06:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B5BD3;
        Mon, 30 Oct 2023 08:06:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66cfd35f595so27073166d6.2;
        Mon, 30 Oct 2023 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698678383; x=1699283183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ5qBED3ygWdGO3xdSM6YS671mt3lajNNDxFKY7zCok=;
        b=Pra8ZuqiXOjFAXs8pWVM1kbP8RKRCwLzZw0kvFK45pgCNtVoCCNsm8YDhMQSWfjcoU
         5xXHm8LCi8GJiOgso3aZHIUdx+hMMnK3LmjBMkHDT0xPXxx2FbmBIUNQgOnzgfBXFQt4
         tnu3LVAJDjQ/efe8dDSEWh8+YmzMjpbhYNDccLK7JrehJx/C2YT4s9wLvgp/HytudQ14
         x32KexNrXxdp3AUuPWd5dAaIy9hvWayDpFc+/y1Z+bgodTmuhJtbU+r90XqPIf6rd7xh
         ldnw789LrNfUADKvx0HYRQu074xyhHe+0sFeSE0iLK8nVtI2oSdTQO5YIEi2vhW4k7+C
         Sd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698678383; x=1699283183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ5qBED3ygWdGO3xdSM6YS671mt3lajNNDxFKY7zCok=;
        b=kOgQKdQFAxci3uYS+vQcGrEtcudhJ0FgZq1qMLXMBnfy2hqtuea4ljwhSTvvkl84Ry
         8pjOon1oTQPcTi+oWuDzhj5q3BEUJDEHN4oBCXwpb+q7d3uAJ1c8HkNo9Jzr/8qdjzh6
         FdNhBGwmI54qp6I5FIIa4mbHV7rgvkPAQU+RiS6L6D9f788AAziVxoa2TYCFUyq6vPnY
         8zBWiF7LLw+RrtoXfxsLBTOtnhzf7JoJV7+diJGvGsL+xjCLKzggs7OfgXRGirZy3RF0
         PZxiMaApEn7l6mnsRj0w+n9V9ulABmmMQD1VjvnDgC0AM/E2H5ohMP1qSvSjD/YziPWw
         xqaA==
X-Gm-Message-State: AOJu0Yw9aLQba+mv4xZr6JGPFqM44/9MVsbos1ihGqA4zgGy5K9jQxtK
        2H9MF5IRLIg+HE3RFDzAFMc=
X-Google-Smtp-Source: AGHT+IEdAOpY0wR3YfIXqjFXUtAvH5mepR/S+TgVVgjczFOrF/pa/SMW4mgsdDQUxKRfRp6b1G2vTg==
X-Received: by 2002:ad4:5c45:0:b0:670:ea1b:967d with SMTP id a5-20020ad45c45000000b00670ea1b967dmr6857005qva.2.1698678381686;
        Mon, 30 Oct 2023 08:06:21 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id y8-20020a0cf148000000b0065cfec43097sm3489466qvl.39.2023.10.30.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:06:21 -0700 (PDT)
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kira <nyakov13@gmail.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com, Coiby Xu <coiby.xu@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Poirier <benjamin.poirier@gmail.com>,
        Sven Joachim <svenjoac@gmx.de>, Ian Kent <raven@themaw.net>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: Revert "staging: qlge: Retire the driver"
Date:   Tue, 31 Oct 2023 02:04:00 +1100
Message-ID: <20231030150400.74178-1-benjamin.poirier@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 875be090928d19ff4ae7cbaadb54707abb3befdf.

On All Hallows' Eve, fear and cower for it is the return of the undead
driver.

There was a report [1] from a user of a QLE8142 device. They would like for
the driver to remain in the kernel. Therefore, revert the removal of the
qlge driver.

[1] https://lore.kernel.org/netdev/566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com/

Reported by: Kira <nyakov13@gmail.com>
Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
---

Notes:
    Once the removal and revert show up in the net-next tree, I plan to send a
    followup patch to move the driver to drivers/net/ as discussed earlier:
    https://lore.kernel.org/netdev/20231019074237.7ef255d7@kernel.org/

 .../networking/device_drivers/index.rst       |    1 +
 .../device_drivers/qlogic/index.rst           |   18 +
 .../networking/device_drivers/qlogic/qlge.rst |  118 +
 MAINTAINERS                                   |    9 +
 arch/parisc/configs/generic-64bit_defconfig   |    1 +
 drivers/staging/Kconfig                       |    2 +
 drivers/staging/Makefile                      |    1 +
 drivers/staging/qlge/Kconfig                  |   11 +
 drivers/staging/qlge/Makefile                 |    8 +
 drivers/staging/qlge/TODO                     |   28 +
 drivers/staging/qlge/qlge.h                   | 2293 ++++++++
 drivers/staging/qlge/qlge_dbg.c               | 1311 +++++
 drivers/staging/qlge/qlge_devlink.c           |  167 +
 drivers/staging/qlge/qlge_devlink.h           |    9 +
 drivers/staging/qlge/qlge_ethtool.c           |  746 +++
 drivers/staging/qlge/qlge_main.c              | 4845 +++++++++++++++++
 drivers/staging/qlge/qlge_mpi.c               | 1273 +++++
 17 files changed, 10841 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/qlogic/index.rst
 create mode 100644 Documentation/networking/device_drivers/qlogic/qlge.rst
 create mode 100644 drivers/staging/qlge/Kconfig
 create mode 100644 drivers/staging/qlge/Makefile
 create mode 100644 drivers/staging/qlge/TODO
 create mode 100644 drivers/staging/qlge/qlge.h
 create mode 100644 drivers/staging/qlge/qlge_dbg.c
 create mode 100644 drivers/staging/qlge/qlge_devlink.c
 create mode 100644 drivers/staging/qlge/qlge_devlink.h
 create mode 100644 drivers/staging/qlge/qlge_ethtool.c
 create mode 100644 drivers/staging/qlge/qlge_main.c
 create mode 100644 drivers/staging/qlge/qlge_mpi.c

diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
index 1ab70c94e1aa..601eacaf12f3 100644
--- a/Documentation/networking/device_drivers/index.rst
+++ b/Documentation/networking/device_drivers/index.rst
@@ -16,6 +16,7 @@ Contents:
    ethernet/index
    fddi/index
    hamradio/index
+   qlogic/index
    wifi/index
    wwan/index
 
diff --git a/Documentation/networking/device_drivers/qlogic/index.rst b/Documentation/networking/device_drivers/qlogic/index.rst
new file mode 100644
index 000000000000..ad05b04286e4
--- /dev/null
+++ b/Documentation/networking/device_drivers/qlogic/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+QLogic QLGE Device Drivers
+===============================================
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+   qlge
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/networking/device_drivers/qlogic/qlge.rst b/Documentation/networking/device_drivers/qlogic/qlge.rst
new file mode 100644
index 000000000000..0b888253d152
--- /dev/null
+++ b/Documentation/networking/device_drivers/qlogic/qlge.rst
@@ -0,0 +1,118 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+QLogic QLGE 10Gb Ethernet device driver
+=======================================
+
+This driver use drgn and devlink for debugging.
+
+Dump kernel data structures in drgn
+-----------------------------------
+
+To dump kernel data structures, the following Python script can be used
+in drgn:
+
+.. code-block:: python
+
+	def align(x, a):
+	    """the alignment a should be a power of 2
+	    """
+	    mask = a - 1
+	    return (x+ mask) & ~mask
+
+	def struct_size(struct_type):
+	    struct_str = "struct {}".format(struct_type)
+	    return sizeof(Object(prog, struct_str, address=0x0))
+
+	def netdev_priv(netdevice):
+	    NETDEV_ALIGN = 32
+	    return netdevice.value_() + align(struct_size("net_device"), NETDEV_ALIGN)
+
+	name = 'xxx'
+	qlge_device = None
+	netdevices = prog['init_net'].dev_base_head.address_of_()
+	for netdevice in list_for_each_entry("struct net_device", netdevices, "dev_list"):
+	    if netdevice.name.string_().decode('ascii') == name:
+	        print(netdevice.name)
+
+	ql_adapter = Object(prog, "struct ql_adapter", address=netdev_priv(qlge_device))
+
+The struct ql_adapter will be printed in drgn as follows,
+
+    >>> ql_adapter
+    (struct ql_adapter){
+            .ricb = (struct ricb){
+                    .base_cq = (u8)0,
+                    .flags = (u8)120,
+                    .mask = (__le16)26637,
+                    .hash_cq_id = (u8 [1024]){ 172, 142, 255, 255 },
+                    .ipv6_hash_key = (__le32 [10]){},
+                    .ipv4_hash_key = (__le32 [4]){},
+            },
+            .flags = (unsigned long)0,
+            .wol = (u32)0,
+            .nic_stats = (struct nic_stats){
+                    .tx_pkts = (u64)0,
+                    .tx_bytes = (u64)0,
+                    .tx_mcast_pkts = (u64)0,
+                    .tx_bcast_pkts = (u64)0,
+                    .tx_ucast_pkts = (u64)0,
+                    .tx_ctl_pkts = (u64)0,
+                    .tx_pause_pkts = (u64)0,
+                    ...
+            },
+            .active_vlans = (unsigned long [64]){
+                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52780853100545, 18446744073709551615,
+                    18446619461681283072, 0, 42949673024, 2147483647,
+            },
+            .rx_ring = (struct rx_ring [17]){
+                    {
+                            .cqicb = (struct cqicb){
+                                    .msix_vect = (u8)0,
+                                    .reserved1 = (u8)0,
+                                    .reserved2 = (u8)0,
+                                    .flags = (u8)0,
+                                    .len = (__le16)0,
+                                    .rid = (__le16)0,
+                                    ...
+                            },
+                            .cq_base = (void *)0x0,
+                            .cq_base_dma = (dma_addr_t)0,
+                    }
+                    ...
+            }
+    }
+
+coredump via devlink
+--------------------
+
+
+And the coredump obtained via devlink in json format looks like,
+
+.. code:: shell
+
+	$ devlink health dump show DEVICE reporter coredump -p -j
+	{
+	    "Core Registers": {
+	        "segment": 1,
+	        "values": [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ]
+	    },
+	    "Test Logic Regs": {
+	        "segment": 2,
+	        "values": [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ]
+	    },
+	    "RMII Registers": {
+	        "segment": 3,
+	        "values": [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ]
+	    },
+	    ...
+	    "Sem Registers": {
+	        "segment": 50,
+	        "values": [ 0,0,0,0 ]
+	    }
+	}
+
+When the module parameter qlge_force_coredump is set to be true, the MPI
+RISC reset before coredumping. So coredumping will much longer since
+devlink tool has to wait for 5 secs for the resetting to be
+finished.
diff --git a/MAINTAINERS b/MAINTAINERS
index ea11a810a92a..90f13281d297 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17540,6 +17540,15 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/qlogic/qlcnic/
 
+QLOGIC QLGE 10Gb ETHERNET DRIVER
+M:	Manish Chopra <manishc@marvell.com>
+M:	GR-Linux-NIC-Dev@marvell.com
+M:	Coiby Xu <coiby.xu@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/networking/device_drivers/qlogic/qlge.rst
+F:	drivers/staging/qlge/
+
 QM1D1B0004 MEDIA DRIVER
 M:	Akihiro Tsukada <tskd08@gmail.com>
 L:	linux-media@vger.kernel.org
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index 19a804860ed5..f6ded7147b4d 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -248,6 +248,7 @@ CONFIG_UIO_AEC=m
 CONFIG_UIO_SERCOS3=m
 CONFIG_UIO_PCI_GENERIC=m
 CONFIG_STAGING=y
+CONFIG_QLGE=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_SECURITY=y
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 784b9f673ead..21a158dabe6c 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -72,6 +72,8 @@ source "drivers/staging/axis-fifo/Kconfig"
 
 source "drivers/staging/fieldbus/Kconfig"
 
+source "drivers/staging/qlge/Kconfig"
+
 source "drivers/staging/vme_user/Kconfig"
 
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 2ea99c7b05d9..0f6379436443 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
 obj-$(CONFIG_PI433)		+= pi433/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
+obj-$(CONFIG_QLGE)		+= qlge/
diff --git a/drivers/staging/qlge/Kconfig b/drivers/staging/qlge/Kconfig
new file mode 100644
index 000000000000..6d831ed67965
--- /dev/null
+++ b/drivers/staging/qlge/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config QLGE
+	tristate "QLogic QLGE 10Gb Ethernet Driver Support"
+	depends on ETHERNET && PCI
+	select NET_DEVLINK
+	help
+	This driver supports QLogic ISP8XXX 10Gb Ethernet cards.
+
+	To compile this driver as a module, choose M here. The module will be
+	called qlge.
diff --git a/drivers/staging/qlge/Makefile b/drivers/staging/qlge/Makefile
new file mode 100644
index 000000000000..07c1898a512e
--- /dev/null
+++ b/drivers/staging/qlge/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Qlogic 10GbE PCI Express ethernet driver
+#
+
+obj-$(CONFIG_QLGE) += qlge.o
+
+qlge-objs := qlge_main.o qlge_dbg.o qlge_mpi.o qlge_ethtool.o qlge_devlink.o
diff --git a/drivers/staging/qlge/TODO b/drivers/staging/qlge/TODO
new file mode 100644
index 000000000000..7e277407033e
--- /dev/null
+++ b/drivers/staging/qlge/TODO
@@ -0,0 +1,28 @@
+* commit 7c734359d350 ("qlge: Size RX buffers based on MTU.", v2.6.33-rc1)
+  introduced dead code in the receive routines, which should be rewritten
+  anyways by the admission of the author himself, see the comment above
+  qlge_build_rx_skb(). That function is now used exclusively to handle packets
+  that underwent header splitting but it still contains code to handle non
+  split cases.
+* truesize accounting is incorrect (ex: a 9000B frame has skb->truesize 10280
+  while containing two frags of order-1 allocations, ie. >16K)
+* while in that area, using two 8k buffers to store one 9k frame is a poor
+  choice of buffer size.
+* in the "chain of large buffers" case, the driver uses an skb allocated with
+  head room but only puts data in the frags.
+* rename "rx" queues to "completion" queues. Calling tx completion queues "rx
+  queues" is confusing.
+* struct rx_ring is used for rx and tx completions, with some members relevant
+  to one case only
+* the flow control implementation in firmware is buggy (sends a flood of pause
+  frames, resets the link, device and driver buffer queues become
+  desynchronized), disable it by default
+* the driver has a habit of using runtime checks where compile time checks are
+  possible (ex. qlge_free_rx_buffers())
+* reorder struct members to avoid holes if it doesn't impact performance
+* use better-suited apis (ex. use pci_iomap() instead of ioremap())
+* remove duplicate and useless comments
+* fix weird line wrapping (all over, ex. the qlge_set_routing_reg() calls in
+  qlge_set_multicast_list()).
+* remove useless casts (ex. memset((void *)mac_iocb_ptr, ...))
+* fix checkpatch issues
diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
new file mode 100644
index 000000000000..69c5b332fd7c
--- /dev/null
+++ b/drivers/staging/qlge/qlge.h
@@ -0,0 +1,2293 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * QLogic QLA41xx NIC HBA Driver
+ * Copyright (c)  2003-2006 QLogic Corporation
+ */
+#ifndef _QLGE_H_
+#define _QLGE_H_
+
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_vlan.h>
+
+/*
+ * General definitions...
+ */
+#define DRV_NAME	"qlge"
+#define DRV_STRING	"QLogic 10 Gigabit PCI-E Ethernet Driver "
+#define DRV_VERSION	"1.00.00.35"
+
+#define WQ_ADDR_ALIGN	0x3	/* 4 byte alignment */
+
+#define QLGE_VENDOR_ID    0x1077
+#define QLGE_DEVICE_ID_8012	0x8012
+#define QLGE_DEVICE_ID_8000	0x8000
+#define QLGE_MEZZ_SSYS_ID_068	0x0068
+#define QLGE_MEZZ_SSYS_ID_180	0x0180
+#define MAX_CPUS 8
+#define MAX_TX_RINGS MAX_CPUS
+#define MAX_RX_RINGS ((MAX_CPUS * 2) + 1)
+
+#define NUM_TX_RING_ENTRIES	256
+#define NUM_RX_RING_ENTRIES	256
+
+/* Use the same len for sbq and lbq. Note that it seems like the device might
+ * support different sizes.
+ */
+#define QLGE_BQ_SHIFT 9
+#define QLGE_BQ_LEN BIT(QLGE_BQ_SHIFT)
+#define QLGE_BQ_SIZE (QLGE_BQ_LEN * sizeof(__le64))
+
+#define DB_PAGE_SIZE 4096
+
+/* Calculate the number of (4k) pages required to
+ * contain a buffer queue of the given length.
+ */
+#define MAX_DB_PAGES_PER_BQ(x) \
+		(((x * sizeof(u64)) / DB_PAGE_SIZE) + \
+		(((x * sizeof(u64)) % DB_PAGE_SIZE) ? 1 : 0))
+
+#define RX_RING_SHADOW_SPACE	(sizeof(u64) + \
+		MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN) * sizeof(u64) + \
+		MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN) * sizeof(u64))
+#define LARGE_BUFFER_MAX_SIZE 8192
+#define LARGE_BUFFER_MIN_SIZE 2048
+
+#define MAX_CQ 128
+#define DFLT_COALESCE_WAIT 100	/* 100 usec wait for coalescing */
+#define MAX_INTER_FRAME_WAIT 10	/* 10 usec max interframe-wait for coalescing */
+#define DFLT_INTER_FRAME_WAIT (MAX_INTER_FRAME_WAIT / 2)
+#define UDELAY_COUNT 3
+#define UDELAY_DELAY 100
+
+#define TX_DESC_PER_IOCB 8
+
+#if ((MAX_SKB_FRAGS - TX_DESC_PER_IOCB) + 2) > 0
+#define TX_DESC_PER_OAL ((MAX_SKB_FRAGS - TX_DESC_PER_IOCB) + 2)
+#else /* all other page sizes */
+#define TX_DESC_PER_OAL 0
+#endif
+
+/* Word shifting for converting 64-bit
+ * address to a series of 16-bit words.
+ * This is used for some MPI firmware
+ * mailbox commands.
+ */
+#define LSW(x)  ((u16)(x))
+#define MSW(x)  ((u16)((u32)(x) >> 16))
+#define LSD(x)  ((u32)((u64)(x)))
+#define MSD(x)  ((u32)((((u64)(x)) >> 32)))
+
+/* In some cases, the device interprets a value of 0x0000 as 65536. These
+ * cases are marked using the following macro.
+ */
+#define QLGE_FIT16(value) ((u16)(value))
+
+/* MPI test register definitions. This register
+ * is used for determining alternate NIC function's
+ * PCI->func number.
+ */
+enum {
+	MPI_TEST_FUNC_PORT_CFG = 0x1002,
+	MPI_TEST_FUNC_PRB_CTL = 0x100e,
+		MPI_TEST_FUNC_PRB_EN = 0x18a20000,
+	MPI_TEST_FUNC_RST_STS = 0x100a,
+		MPI_TEST_FUNC_RST_FRC = 0x00000003,
+	MPI_TEST_NIC_FUNC_MASK = 0x00000007,
+	MPI_TEST_NIC1_FUNCTION_ENABLE = (1 << 0),
+	MPI_TEST_NIC1_FUNCTION_MASK = 0x0000000e,
+	MPI_TEST_NIC1_FUNC_SHIFT = 1,
+	MPI_TEST_NIC2_FUNCTION_ENABLE = (1 << 4),
+	MPI_TEST_NIC2_FUNCTION_MASK = 0x000000e0,
+	MPI_TEST_NIC2_FUNC_SHIFT = 5,
+	MPI_TEST_FC1_FUNCTION_ENABLE = (1 << 8),
+	MPI_TEST_FC1_FUNCTION_MASK	= 0x00000e00,
+	MPI_TEST_FC1_FUNCTION_SHIFT = 9,
+	MPI_TEST_FC2_FUNCTION_ENABLE = (1 << 12),
+	MPI_TEST_FC2_FUNCTION_MASK = 0x0000e000,
+	MPI_TEST_FC2_FUNCTION_SHIFT = 13,
+
+	MPI_NIC_READ = 0x00000000,
+	MPI_NIC_REG_BLOCK = 0x00020000,
+	MPI_NIC_FUNCTION_SHIFT = 6,
+};
+
+/*
+ * Processor Address Register (PROC_ADDR) bit definitions.
+ */
+enum {
+	/* Misc. stuff */
+	MAILBOX_COUNT = 16,
+	MAILBOX_TIMEOUT = 5,
+
+	PROC_ADDR_RDY = (1 << 31),
+	PROC_ADDR_R = (1 << 30),
+	PROC_ADDR_ERR = (1 << 29),
+	PROC_ADDR_DA = (1 << 28),
+	PROC_ADDR_FUNC0_MBI = 0x00001180,
+	PROC_ADDR_FUNC0_MBO = (PROC_ADDR_FUNC0_MBI + MAILBOX_COUNT),
+	PROC_ADDR_FUNC0_CTL = 0x000011a1,
+	PROC_ADDR_FUNC2_MBI = 0x00001280,
+	PROC_ADDR_FUNC2_MBO = (PROC_ADDR_FUNC2_MBI + MAILBOX_COUNT),
+	PROC_ADDR_FUNC2_CTL = 0x000012a1,
+	PROC_ADDR_MPI_RISC = 0x00000000,
+	PROC_ADDR_MDE = 0x00010000,
+	PROC_ADDR_REGBLOCK = 0x00020000,
+	PROC_ADDR_RISC_REG = 0x00030000,
+};
+
+/*
+ * System Register (SYS) bit definitions.
+ */
+enum {
+	SYS_EFE = (1 << 0),
+	SYS_FAE = (1 << 1),
+	SYS_MDC = (1 << 2),
+	SYS_DST = (1 << 3),
+	SYS_DWC = (1 << 4),
+	SYS_EVW = (1 << 5),
+	SYS_OMP_DLY_MASK = 0x3f000000,
+	/*
+	 * There are no values defined as of edit #15.
+	 */
+	SYS_ODI = (1 << 14),
+};
+
+/*
+ *  Reset/Failover Register (RST_FO) bit definitions.
+ */
+enum {
+	RST_FO_TFO = (1 << 0),
+	RST_FO_RR_MASK = 0x00060000,
+	RST_FO_RR_CQ_CAM = 0x00000000,
+	RST_FO_RR_DROP = 0x00000002,
+	RST_FO_RR_DQ = 0x00000004,
+	RST_FO_RR_RCV_FUNC_CQ = 0x00000006,
+	RST_FO_FRB = (1 << 12),
+	RST_FO_MOP = (1 << 13),
+	RST_FO_REG = (1 << 14),
+	RST_FO_FR = (1 << 15),
+};
+
+/*
+ * Function Specific Control Register (FSC) bit definitions.
+ */
+enum {
+	FSC_DBRST_MASK = 0x00070000,
+	FSC_DBRST_256 = 0x00000000,
+	FSC_DBRST_512 = 0x00000001,
+	FSC_DBRST_768 = 0x00000002,
+	FSC_DBRST_1024 = 0x00000003,
+	FSC_DBL_MASK = 0x00180000,
+	FSC_DBL_DBRST = 0x00000000,
+	FSC_DBL_MAX_PLD = 0x00000008,
+	FSC_DBL_MAX_BRST = 0x00000010,
+	FSC_DBL_128_BYTES = 0x00000018,
+	FSC_EC = (1 << 5),
+	FSC_EPC_MASK = 0x00c00000,
+	FSC_EPC_INBOUND = (1 << 6),
+	FSC_EPC_OUTBOUND = (1 << 7),
+	FSC_VM_PAGESIZE_MASK = 0x07000000,
+	FSC_VM_PAGE_2K = 0x00000100,
+	FSC_VM_PAGE_4K = 0x00000200,
+	FSC_VM_PAGE_8K = 0x00000300,
+	FSC_VM_PAGE_64K = 0x00000600,
+	FSC_SH = (1 << 11),
+	FSC_DSB = (1 << 12),
+	FSC_STE = (1 << 13),
+	FSC_FE = (1 << 15),
+};
+
+/*
+ *  Host Command Status Register (CSR) bit definitions.
+ */
+enum {
+	CSR_ERR_STS_MASK = 0x0000003f,
+	/*
+	 * There are no valued defined as of edit #15.
+	 */
+	CSR_RR = (1 << 8),
+	CSR_HRI = (1 << 9),
+	CSR_RP = (1 << 10),
+	CSR_CMD_PARM_SHIFT = 22,
+	CSR_CMD_NOP = 0x00000000,
+	CSR_CMD_SET_RST = 0x10000000,
+	CSR_CMD_CLR_RST = 0x20000000,
+	CSR_CMD_SET_PAUSE = 0x30000000,
+	CSR_CMD_CLR_PAUSE = 0x40000000,
+	CSR_CMD_SET_H2R_INT = 0x50000000,
+	CSR_CMD_CLR_H2R_INT = 0x60000000,
+	CSR_CMD_PAR_EN = 0x70000000,
+	CSR_CMD_SET_BAD_PAR = 0x80000000,
+	CSR_CMD_CLR_BAD_PAR = 0x90000000,
+	CSR_CMD_CLR_R2PCI_INT = 0xa0000000,
+};
+
+/*
+ *  Configuration Register (CFG) bit definitions.
+ */
+enum {
+	CFG_LRQ = (1 << 0),
+	CFG_DRQ = (1 << 1),
+	CFG_LR = (1 << 2),
+	CFG_DR = (1 << 3),
+	CFG_LE = (1 << 5),
+	CFG_LCQ = (1 << 6),
+	CFG_DCQ = (1 << 7),
+	CFG_Q_SHIFT = 8,
+	CFG_Q_MASK = 0x7f000000,
+};
+
+/*
+ *  Status Register (STS) bit definitions.
+ */
+enum {
+	STS_FE = (1 << 0),
+	STS_PI = (1 << 1),
+	STS_PL0 = (1 << 2),
+	STS_PL1 = (1 << 3),
+	STS_PI0 = (1 << 4),
+	STS_PI1 = (1 << 5),
+	STS_FUNC_ID_MASK = 0x000000c0,
+	STS_FUNC_ID_SHIFT = 6,
+	STS_F0E = (1 << 8),
+	STS_F1E = (1 << 9),
+	STS_F2E = (1 << 10),
+	STS_F3E = (1 << 11),
+	STS_NFE = (1 << 12),
+};
+
+/*
+ * Interrupt Enable Register (INTR_EN) bit definitions.
+ */
+enum {
+	INTR_EN_INTR_MASK = 0x007f0000,
+	INTR_EN_TYPE_MASK = 0x03000000,
+	INTR_EN_TYPE_ENABLE = 0x00000100,
+	INTR_EN_TYPE_DISABLE = 0x00000200,
+	INTR_EN_TYPE_READ = 0x00000300,
+	INTR_EN_IHD = (1 << 13),
+	INTR_EN_IHD_MASK = (INTR_EN_IHD << 16),
+	INTR_EN_EI = (1 << 14),
+	INTR_EN_EN = (1 << 15),
+};
+
+/*
+ * Interrupt Mask Register (INTR_MASK) bit definitions.
+ */
+enum {
+	INTR_MASK_PI = (1 << 0),
+	INTR_MASK_HL0 = (1 << 1),
+	INTR_MASK_LH0 = (1 << 2),
+	INTR_MASK_HL1 = (1 << 3),
+	INTR_MASK_LH1 = (1 << 4),
+	INTR_MASK_SE = (1 << 5),
+	INTR_MASK_LSC = (1 << 6),
+	INTR_MASK_MC = (1 << 7),
+	INTR_MASK_LINK_IRQS = INTR_MASK_LSC | INTR_MASK_SE | INTR_MASK_MC,
+};
+
+/*
+ *  Register (REV_ID) bit definitions.
+ */
+enum {
+	REV_ID_MASK = 0x0000000f,
+	REV_ID_NICROLL_SHIFT = 0,
+	REV_ID_NICREV_SHIFT = 4,
+	REV_ID_XGROLL_SHIFT = 8,
+	REV_ID_XGREV_SHIFT = 12,
+	REV_ID_CHIPREV_SHIFT = 28,
+};
+
+/*
+ *  Force ECC Error Register (FRC_ECC_ERR) bit definitions.
+ */
+enum {
+	FRC_ECC_ERR_VW = (1 << 12),
+	FRC_ECC_ERR_VB = (1 << 13),
+	FRC_ECC_ERR_NI = (1 << 14),
+	FRC_ECC_ERR_NO = (1 << 15),
+	FRC_ECC_PFE_SHIFT = 16,
+	FRC_ECC_ERR_DO = (1 << 18),
+	FRC_ECC_P14 = (1 << 19),
+};
+
+/*
+ *  Error Status Register (ERR_STS) bit definitions.
+ */
+enum {
+	ERR_STS_NOF = (1 << 0),
+	ERR_STS_NIF = (1 << 1),
+	ERR_STS_DRP = (1 << 2),
+	ERR_STS_XGP = (1 << 3),
+	ERR_STS_FOU = (1 << 4),
+	ERR_STS_FOC = (1 << 5),
+	ERR_STS_FOF = (1 << 6),
+	ERR_STS_FIU = (1 << 7),
+	ERR_STS_FIC = (1 << 8),
+	ERR_STS_FIF = (1 << 9),
+	ERR_STS_MOF = (1 << 10),
+	ERR_STS_TA = (1 << 11),
+	ERR_STS_MA = (1 << 12),
+	ERR_STS_MPE = (1 << 13),
+	ERR_STS_SCE = (1 << 14),
+	ERR_STS_STE = (1 << 15),
+	ERR_STS_FOW = (1 << 16),
+	ERR_STS_UE = (1 << 17),
+	ERR_STS_MCH = (1 << 26),
+	ERR_STS_LOC_SHIFT = 27,
+};
+
+/*
+ *  RAM Debug Address Register (RAM_DBG_ADDR) bit definitions.
+ */
+enum {
+	RAM_DBG_ADDR_FW = (1 << 30),
+	RAM_DBG_ADDR_FR = (1 << 31),
+};
+
+/*
+ * Semaphore Register (SEM) bit definitions.
+ */
+enum {
+	/*
+	 * Example:
+	 * reg = SEM_XGMAC0_MASK | (SEM_SET << SEM_XGMAC0_SHIFT)
+	 */
+	SEM_CLEAR = 0,
+	SEM_SET = 1,
+	SEM_FORCE = 3,
+	SEM_XGMAC0_SHIFT = 0,
+	SEM_XGMAC1_SHIFT = 2,
+	SEM_ICB_SHIFT = 4,
+	SEM_MAC_ADDR_SHIFT = 6,
+	SEM_FLASH_SHIFT = 8,
+	SEM_PROBE_SHIFT = 10,
+	SEM_RT_IDX_SHIFT = 12,
+	SEM_PROC_REG_SHIFT = 14,
+	SEM_XGMAC0_MASK = 0x00030000,
+	SEM_XGMAC1_MASK = 0x000c0000,
+	SEM_ICB_MASK = 0x00300000,
+	SEM_MAC_ADDR_MASK = 0x00c00000,
+	SEM_FLASH_MASK = 0x03000000,
+	SEM_PROBE_MASK = 0x0c000000,
+	SEM_RT_IDX_MASK = 0x30000000,
+	SEM_PROC_REG_MASK = 0xc0000000,
+};
+
+/*
+ *  10G MAC Address  Register (XGMAC_ADDR) bit definitions.
+ */
+enum {
+	XGMAC_ADDR_RDY = (1 << 31),
+	XGMAC_ADDR_R = (1 << 30),
+	XGMAC_ADDR_XME = (1 << 29),
+
+	/* XGMAC control registers */
+	PAUSE_SRC_LO = 0x00000100,
+	PAUSE_SRC_HI = 0x00000104,
+	GLOBAL_CFG = 0x00000108,
+	GLOBAL_CFG_RESET = (1 << 0),
+	GLOBAL_CFG_JUMBO = (1 << 6),
+	GLOBAL_CFG_TX_STAT_EN = (1 << 10),
+	GLOBAL_CFG_RX_STAT_EN = (1 << 11),
+	TX_CFG = 0x0000010c,
+	TX_CFG_RESET = (1 << 0),
+	TX_CFG_EN = (1 << 1),
+	TX_CFG_PREAM = (1 << 2),
+	RX_CFG = 0x00000110,
+	RX_CFG_RESET = (1 << 0),
+	RX_CFG_EN = (1 << 1),
+	RX_CFG_PREAM = (1 << 2),
+	FLOW_CTL = 0x0000011c,
+	PAUSE_OPCODE = 0x00000120,
+	PAUSE_TIMER = 0x00000124,
+	PAUSE_FRM_DEST_LO = 0x00000128,
+	PAUSE_FRM_DEST_HI = 0x0000012c,
+	MAC_TX_PARAMS = 0x00000134,
+	MAC_TX_PARAMS_JUMBO = (1 << 31),
+	MAC_TX_PARAMS_SIZE_SHIFT = 16,
+	MAC_RX_PARAMS = 0x00000138,
+	MAC_SYS_INT = 0x00000144,
+	MAC_SYS_INT_MASK = 0x00000148,
+	MAC_MGMT_INT = 0x0000014c,
+	MAC_MGMT_IN_MASK = 0x00000150,
+	EXT_ARB_MODE = 0x000001fc,
+
+	/* XGMAC TX statistics  registers */
+	TX_PKTS = 0x00000200,
+	TX_BYTES = 0x00000208,
+	TX_MCAST_PKTS = 0x00000210,
+	TX_BCAST_PKTS = 0x00000218,
+	TX_UCAST_PKTS = 0x00000220,
+	TX_CTL_PKTS = 0x00000228,
+	TX_PAUSE_PKTS = 0x00000230,
+	TX_64_PKT = 0x00000238,
+	TX_65_TO_127_PKT = 0x00000240,
+	TX_128_TO_255_PKT = 0x00000248,
+	TX_256_511_PKT = 0x00000250,
+	TX_512_TO_1023_PKT = 0x00000258,
+	TX_1024_TO_1518_PKT = 0x00000260,
+	TX_1519_TO_MAX_PKT = 0x00000268,
+	TX_UNDERSIZE_PKT = 0x00000270,
+	TX_OVERSIZE_PKT = 0x00000278,
+
+	/* XGMAC statistics control registers */
+	RX_HALF_FULL_DET = 0x000002a0,
+	TX_HALF_FULL_DET = 0x000002a4,
+	RX_OVERFLOW_DET = 0x000002a8,
+	TX_OVERFLOW_DET = 0x000002ac,
+	RX_HALF_FULL_MASK = 0x000002b0,
+	TX_HALF_FULL_MASK = 0x000002b4,
+	RX_OVERFLOW_MASK = 0x000002b8,
+	TX_OVERFLOW_MASK = 0x000002bc,
+	STAT_CNT_CTL = 0x000002c0,
+	STAT_CNT_CTL_CLEAR_TX = (1 << 0),
+	STAT_CNT_CTL_CLEAR_RX = (1 << 1),
+	AUX_RX_HALF_FULL_DET = 0x000002d0,
+	AUX_TX_HALF_FULL_DET = 0x000002d4,
+	AUX_RX_OVERFLOW_DET = 0x000002d8,
+	AUX_TX_OVERFLOW_DET = 0x000002dc,
+	AUX_RX_HALF_FULL_MASK = 0x000002f0,
+	AUX_TX_HALF_FULL_MASK = 0x000002f4,
+	AUX_RX_OVERFLOW_MASK = 0x000002f8,
+	AUX_TX_OVERFLOW_MASK = 0x000002fc,
+
+	/* XGMAC RX statistics  registers */
+	RX_BYTES = 0x00000300,
+	RX_BYTES_OK = 0x00000308,
+	RX_PKTS = 0x00000310,
+	RX_PKTS_OK = 0x00000318,
+	RX_BCAST_PKTS = 0x00000320,
+	RX_MCAST_PKTS = 0x00000328,
+	RX_UCAST_PKTS = 0x00000330,
+	RX_UNDERSIZE_PKTS = 0x00000338,
+	RX_OVERSIZE_PKTS = 0x00000340,
+	RX_JABBER_PKTS = 0x00000348,
+	RX_UNDERSIZE_FCERR_PKTS = 0x00000350,
+	RX_DROP_EVENTS = 0x00000358,
+	RX_FCERR_PKTS = 0x00000360,
+	RX_ALIGN_ERR = 0x00000368,
+	RX_SYMBOL_ERR = 0x00000370,
+	RX_MAC_ERR = 0x00000378,
+	RX_CTL_PKTS = 0x00000380,
+	RX_PAUSE_PKTS = 0x00000388,
+	RX_64_PKTS = 0x00000390,
+	RX_65_TO_127_PKTS = 0x00000398,
+	RX_128_255_PKTS = 0x000003a0,
+	RX_256_511_PKTS = 0x000003a8,
+	RX_512_TO_1023_PKTS = 0x000003b0,
+	RX_1024_TO_1518_PKTS = 0x000003b8,
+	RX_1519_TO_MAX_PKTS = 0x000003c0,
+	RX_LEN_ERR_PKTS = 0x000003c8,
+
+	/* XGMAC MDIO control registers */
+	MDIO_TX_DATA = 0x00000400,
+	MDIO_RX_DATA = 0x00000410,
+	MDIO_CMD = 0x00000420,
+	MDIO_PHY_ADDR = 0x00000430,
+	MDIO_PORT = 0x00000440,
+	MDIO_STATUS = 0x00000450,
+
+	XGMAC_REGISTER_END = 0x00000740,
+};
+
+/*
+ *  Enhanced Transmission Schedule Registers (NIC_ETS,CNA_ETS) bit definitions.
+ */
+enum {
+	ETS_QUEUE_SHIFT = 29,
+	ETS_REF = (1 << 26),
+	ETS_RS = (1 << 27),
+	ETS_P = (1 << 28),
+	ETS_FC_COS_SHIFT = 23,
+};
+
+/*
+ *  Flash Address Register (FLASH_ADDR) bit definitions.
+ */
+enum {
+	FLASH_ADDR_RDY = (1 << 31),
+	FLASH_ADDR_R = (1 << 30),
+	FLASH_ADDR_ERR = (1 << 29),
+};
+
+/*
+ *  Stop CQ Processing Register (CQ_STOP) bit definitions.
+ */
+enum {
+	CQ_STOP_QUEUE_MASK = (0x007f0000),
+	CQ_STOP_TYPE_MASK = (0x03000000),
+	CQ_STOP_TYPE_START = 0x00000100,
+	CQ_STOP_TYPE_STOP = 0x00000200,
+	CQ_STOP_TYPE_READ = 0x00000300,
+	CQ_STOP_EN = (1 << 15),
+};
+
+/*
+ *  MAC Protocol Address Index Register (MAC_ADDR_IDX) bit definitions.
+ */
+enum {
+	MAC_ADDR_IDX_SHIFT = 4,
+	MAC_ADDR_TYPE_SHIFT = 16,
+	MAC_ADDR_TYPE_COUNT = 10,
+	MAC_ADDR_TYPE_MASK = 0x000f0000,
+	MAC_ADDR_TYPE_CAM_MAC = 0x00000000,
+	MAC_ADDR_TYPE_MULTI_MAC = 0x00010000,
+	MAC_ADDR_TYPE_VLAN = 0x00020000,
+	MAC_ADDR_TYPE_MULTI_FLTR = 0x00030000,
+	MAC_ADDR_TYPE_FC_MAC = 0x00040000,
+	MAC_ADDR_TYPE_MGMT_MAC = 0x00050000,
+	MAC_ADDR_TYPE_MGMT_VLAN = 0x00060000,
+	MAC_ADDR_TYPE_MGMT_V4 = 0x00070000,
+	MAC_ADDR_TYPE_MGMT_V6 = 0x00080000,
+	MAC_ADDR_TYPE_MGMT_TU_DP = 0x00090000,
+	MAC_ADDR_ADR = (1 << 25),
+	MAC_ADDR_RS = (1 << 26),
+	MAC_ADDR_E = (1 << 27),
+	MAC_ADDR_MR = (1 << 30),
+	MAC_ADDR_MW = (1 << 31),
+	MAX_MULTICAST_ENTRIES = 32,
+
+	/* Entry count and words per entry
+	 * for each address type in the filter.
+	 */
+	MAC_ADDR_MAX_CAM_ENTRIES = 512,
+	MAC_ADDR_MAX_CAM_WCOUNT = 3,
+	MAC_ADDR_MAX_MULTICAST_ENTRIES = 32,
+	MAC_ADDR_MAX_MULTICAST_WCOUNT = 2,
+	MAC_ADDR_MAX_VLAN_ENTRIES = 4096,
+	MAC_ADDR_MAX_VLAN_WCOUNT = 1,
+	MAC_ADDR_MAX_MCAST_FLTR_ENTRIES = 4096,
+	MAC_ADDR_MAX_MCAST_FLTR_WCOUNT = 1,
+	MAC_ADDR_MAX_FC_MAC_ENTRIES = 4,
+	MAC_ADDR_MAX_FC_MAC_WCOUNT = 2,
+	MAC_ADDR_MAX_MGMT_MAC_ENTRIES = 8,
+	MAC_ADDR_MAX_MGMT_MAC_WCOUNT = 2,
+	MAC_ADDR_MAX_MGMT_VLAN_ENTRIES = 16,
+	MAC_ADDR_MAX_MGMT_VLAN_WCOUNT = 1,
+	MAC_ADDR_MAX_MGMT_V4_ENTRIES = 4,
+	MAC_ADDR_MAX_MGMT_V4_WCOUNT = 1,
+	MAC_ADDR_MAX_MGMT_V6_ENTRIES = 4,
+	MAC_ADDR_MAX_MGMT_V6_WCOUNT = 4,
+	MAC_ADDR_MAX_MGMT_TU_DP_ENTRIES = 4,
+	MAC_ADDR_MAX_MGMT_TU_DP_WCOUNT = 1,
+};
+
+/*
+ *  MAC Protocol Address Index Register (SPLT_HDR) bit definitions.
+ */
+enum {
+	SPLT_HDR_EP = (1 << 31),
+};
+
+/*
+ *  FCoE Receive Configuration Register (FC_RCV_CFG) bit definitions.
+ */
+enum {
+	FC_RCV_CFG_ECT = (1 << 15),
+	FC_RCV_CFG_DFH = (1 << 20),
+	FC_RCV_CFG_DVF = (1 << 21),
+	FC_RCV_CFG_RCE = (1 << 27),
+	FC_RCV_CFG_RFE = (1 << 28),
+	FC_RCV_CFG_TEE = (1 << 29),
+	FC_RCV_CFG_TCE = (1 << 30),
+	FC_RCV_CFG_TFE = (1 << 31),
+};
+
+/*
+ *  NIC Receive Configuration Register (NIC_RCV_CFG) bit definitions.
+ */
+enum {
+	NIC_RCV_CFG_PPE = (1 << 0),
+	NIC_RCV_CFG_VLAN_MASK = 0x00060000,
+	NIC_RCV_CFG_VLAN_ALL = 0x00000000,
+	NIC_RCV_CFG_VLAN_MATCH_ONLY = 0x00000002,
+	NIC_RCV_CFG_VLAN_MATCH_AND_NON = 0x00000004,
+	NIC_RCV_CFG_VLAN_NONE_AND_NON = 0x00000006,
+	NIC_RCV_CFG_RV = (1 << 3),
+	NIC_RCV_CFG_DFQ_MASK = (0x7f000000),
+	NIC_RCV_CFG_DFQ_SHIFT = 8,
+	NIC_RCV_CFG_DFQ = 0,	/* HARDCODE default queue to 0. */
+};
+
+/*
+ *   Mgmt Receive Configuration Register (MGMT_RCV_CFG) bit definitions.
+ */
+enum {
+	MGMT_RCV_CFG_ARP = (1 << 0),
+	MGMT_RCV_CFG_DHC = (1 << 1),
+	MGMT_RCV_CFG_DHS = (1 << 2),
+	MGMT_RCV_CFG_NP = (1 << 3),
+	MGMT_RCV_CFG_I6N = (1 << 4),
+	MGMT_RCV_CFG_I6R = (1 << 5),
+	MGMT_RCV_CFG_DH6 = (1 << 6),
+	MGMT_RCV_CFG_UD1 = (1 << 7),
+	MGMT_RCV_CFG_UD0 = (1 << 8),
+	MGMT_RCV_CFG_BCT = (1 << 9),
+	MGMT_RCV_CFG_MCT = (1 << 10),
+	MGMT_RCV_CFG_DM = (1 << 11),
+	MGMT_RCV_CFG_RM = (1 << 12),
+	MGMT_RCV_CFG_STL = (1 << 13),
+	MGMT_RCV_CFG_VLAN_MASK = 0xc0000000,
+	MGMT_RCV_CFG_VLAN_ALL = 0x00000000,
+	MGMT_RCV_CFG_VLAN_MATCH_ONLY = 0x00004000,
+	MGMT_RCV_CFG_VLAN_MATCH_AND_NON = 0x00008000,
+	MGMT_RCV_CFG_VLAN_NONE_AND_NON = 0x0000c000,
+};
+
+/*
+ *  Routing Index Register (RT_IDX) bit definitions.
+ */
+enum {
+	RT_IDX_IDX_SHIFT = 8,
+	RT_IDX_TYPE_MASK = 0x000f0000,
+	RT_IDX_TYPE_SHIFT = 16,
+	RT_IDX_TYPE_RT = 0x00000000,
+	RT_IDX_TYPE_RT_INV = 0x00010000,
+	RT_IDX_TYPE_NICQ = 0x00020000,
+	RT_IDX_TYPE_NICQ_INV = 0x00030000,
+	RT_IDX_DST_MASK = 0x00700000,
+	RT_IDX_DST_RSS = 0x00000000,
+	RT_IDX_DST_CAM_Q = 0x00100000,
+	RT_IDX_DST_COS_Q = 0x00200000,
+	RT_IDX_DST_DFLT_Q = 0x00300000,
+	RT_IDX_DST_DEST_Q = 0x00400000,
+	RT_IDX_RS = (1 << 26),
+	RT_IDX_E = (1 << 27),
+	RT_IDX_MR = (1 << 30),
+	RT_IDX_MW = (1 << 31),
+
+	/* Nic Queue format - type 2 bits */
+	RT_IDX_BCAST = (1 << 0),
+	RT_IDX_MCAST = (1 << 1),
+	RT_IDX_MCAST_MATCH = (1 << 2),
+	RT_IDX_MCAST_REG_MATCH = (1 << 3),
+	RT_IDX_MCAST_HASH_MATCH = (1 << 4),
+	RT_IDX_FC_MACH = (1 << 5),
+	RT_IDX_ETH_FCOE = (1 << 6),
+	RT_IDX_CAM_HIT = (1 << 7),
+	RT_IDX_CAM_BIT0 = (1 << 8),
+	RT_IDX_CAM_BIT1 = (1 << 9),
+	RT_IDX_VLAN_TAG = (1 << 10),
+	RT_IDX_VLAN_MATCH = (1 << 11),
+	RT_IDX_VLAN_FILTER = (1 << 12),
+	RT_IDX_ETH_SKIP1 = (1 << 13),
+	RT_IDX_ETH_SKIP2 = (1 << 14),
+	RT_IDX_BCAST_MCAST_MATCH = (1 << 15),
+	RT_IDX_802_3 = (1 << 16),
+	RT_IDX_LLDP = (1 << 17),
+	RT_IDX_UNUSED018 = (1 << 18),
+	RT_IDX_UNUSED019 = (1 << 19),
+	RT_IDX_UNUSED20 = (1 << 20),
+	RT_IDX_UNUSED21 = (1 << 21),
+	RT_IDX_ERR = (1 << 22),
+	RT_IDX_VALID = (1 << 23),
+	RT_IDX_TU_CSUM_ERR = (1 << 24),
+	RT_IDX_IP_CSUM_ERR = (1 << 25),
+	RT_IDX_MAC_ERR = (1 << 26),
+	RT_IDX_RSS_TCP6 = (1 << 27),
+	RT_IDX_RSS_TCP4 = (1 << 28),
+	RT_IDX_RSS_IPV6 = (1 << 29),
+	RT_IDX_RSS_IPV4 = (1 << 30),
+	RT_IDX_RSS_MATCH = (1 << 31),
+
+	/* Hierarchy for the NIC Queue Mask */
+	RT_IDX_ALL_ERR_SLOT = 0,
+	RT_IDX_MAC_ERR_SLOT = 0,
+	RT_IDX_IP_CSUM_ERR_SLOT = 1,
+	RT_IDX_TCP_UDP_CSUM_ERR_SLOT = 2,
+	RT_IDX_BCAST_SLOT = 3,
+	RT_IDX_MCAST_MATCH_SLOT = 4,
+	RT_IDX_ALLMULTI_SLOT = 5,
+	RT_IDX_UNUSED6_SLOT = 6,
+	RT_IDX_UNUSED7_SLOT = 7,
+	RT_IDX_RSS_MATCH_SLOT = 8,
+	RT_IDX_RSS_IPV4_SLOT = 8,
+	RT_IDX_RSS_IPV6_SLOT = 9,
+	RT_IDX_RSS_TCP4_SLOT = 10,
+	RT_IDX_RSS_TCP6_SLOT = 11,
+	RT_IDX_CAM_HIT_SLOT = 12,
+	RT_IDX_UNUSED013 = 13,
+	RT_IDX_UNUSED014 = 14,
+	RT_IDX_PROMISCUOUS_SLOT = 15,
+	RT_IDX_MAX_RT_SLOTS = 8,
+	RT_IDX_MAX_NIC_SLOTS = 16,
+};
+
+/*
+ * Serdes Address Register (XG_SERDES_ADDR) bit definitions.
+ */
+enum {
+	XG_SERDES_ADDR_RDY = (1 << 31),
+	XG_SERDES_ADDR_R = (1 << 30),
+
+	XG_SERDES_ADDR_STS = 0x00001E06,
+	XG_SERDES_ADDR_XFI1_PWR_UP = 0x00000005,
+	XG_SERDES_ADDR_XFI2_PWR_UP = 0x0000000a,
+	XG_SERDES_ADDR_XAUI_PWR_DOWN = 0x00000001,
+
+	/* Serdes coredump definitions. */
+	XG_SERDES_XAUI_AN_START = 0x00000000,
+	XG_SERDES_XAUI_AN_END = 0x00000034,
+	XG_SERDES_XAUI_HSS_PCS_START = 0x00000800,
+	XG_SERDES_XAUI_HSS_PCS_END = 0x0000880,
+	XG_SERDES_XFI_AN_START = 0x00001000,
+	XG_SERDES_XFI_AN_END = 0x00001034,
+	XG_SERDES_XFI_TRAIN_START = 0x10001050,
+	XG_SERDES_XFI_TRAIN_END = 0x1000107C,
+	XG_SERDES_XFI_HSS_PCS_START = 0x00001800,
+	XG_SERDES_XFI_HSS_PCS_END = 0x00001838,
+	XG_SERDES_XFI_HSS_TX_START = 0x00001c00,
+	XG_SERDES_XFI_HSS_TX_END = 0x00001c1f,
+	XG_SERDES_XFI_HSS_RX_START = 0x00001c40,
+	XG_SERDES_XFI_HSS_RX_END = 0x00001c5f,
+	XG_SERDES_XFI_HSS_PLL_START = 0x00001e00,
+	XG_SERDES_XFI_HSS_PLL_END = 0x00001e1f,
+};
+
+/*
+ *  NIC Probe Mux Address Register (PRB_MX_ADDR) bit definitions.
+ */
+enum {
+	PRB_MX_ADDR_ARE = (1 << 16),
+	PRB_MX_ADDR_UP = (1 << 15),
+	PRB_MX_ADDR_SWP = (1 << 14),
+
+	/* Module select values. */
+	PRB_MX_ADDR_MAX_MODS = 21,
+	PRB_MX_ADDR_MOD_SEL_SHIFT = 9,
+	PRB_MX_ADDR_MOD_SEL_TBD = 0,
+	PRB_MX_ADDR_MOD_SEL_IDE1 = 1,
+	PRB_MX_ADDR_MOD_SEL_IDE2 = 2,
+	PRB_MX_ADDR_MOD_SEL_FRB = 3,
+	PRB_MX_ADDR_MOD_SEL_ODE1 = 4,
+	PRB_MX_ADDR_MOD_SEL_ODE2 = 5,
+	PRB_MX_ADDR_MOD_SEL_DA1 = 6,
+	PRB_MX_ADDR_MOD_SEL_DA2 = 7,
+	PRB_MX_ADDR_MOD_SEL_IMP1 = 8,
+	PRB_MX_ADDR_MOD_SEL_IMP2 = 9,
+	PRB_MX_ADDR_MOD_SEL_OMP1 = 10,
+	PRB_MX_ADDR_MOD_SEL_OMP2 = 11,
+	PRB_MX_ADDR_MOD_SEL_ORS1 = 12,
+	PRB_MX_ADDR_MOD_SEL_ORS2 = 13,
+	PRB_MX_ADDR_MOD_SEL_REG = 14,
+	PRB_MX_ADDR_MOD_SEL_MAC1 = 16,
+	PRB_MX_ADDR_MOD_SEL_MAC2 = 17,
+	PRB_MX_ADDR_MOD_SEL_VQM1 = 18,
+	PRB_MX_ADDR_MOD_SEL_VQM2 = 19,
+	PRB_MX_ADDR_MOD_SEL_MOP = 20,
+	/* Bit fields indicating which modules
+	 * are valid for each clock domain.
+	 */
+	PRB_MX_ADDR_VALID_SYS_MOD = 0x000f7ff7,
+	PRB_MX_ADDR_VALID_PCI_MOD = 0x000040c1,
+	PRB_MX_ADDR_VALID_XGM_MOD = 0x00037309,
+	PRB_MX_ADDR_VALID_FC_MOD = 0x00003001,
+	PRB_MX_ADDR_VALID_TOTAL = 34,
+
+	/* Clock domain values. */
+	PRB_MX_ADDR_CLOCK_SHIFT = 6,
+	PRB_MX_ADDR_SYS_CLOCK = 0,
+	PRB_MX_ADDR_PCI_CLOCK = 2,
+	PRB_MX_ADDR_FC_CLOCK = 5,
+	PRB_MX_ADDR_XGM_CLOCK = 6,
+
+	PRB_MX_ADDR_MAX_MUX = 64,
+};
+
+/*
+ * Control Register Set Map
+ */
+enum {
+	PROC_ADDR = 0,		/* Use semaphore */
+	PROC_DATA = 0x04,	/* Use semaphore */
+	SYS = 0x08,
+	RST_FO = 0x0c,
+	FSC = 0x10,
+	CSR = 0x14,
+	LED = 0x18,
+	ICB_RID = 0x1c,		/* Use semaphore */
+	ICB_L = 0x20,		/* Use semaphore */
+	ICB_H = 0x24,		/* Use semaphore */
+	CFG = 0x28,
+	BIOS_ADDR = 0x2c,
+	STS = 0x30,
+	INTR_EN = 0x34,
+	INTR_MASK = 0x38,
+	ISR1 = 0x3c,
+	ISR2 = 0x40,
+	ISR3 = 0x44,
+	ISR4 = 0x48,
+	REV_ID = 0x4c,
+	FRC_ECC_ERR = 0x50,
+	ERR_STS = 0x54,
+	RAM_DBG_ADDR = 0x58,
+	RAM_DBG_DATA = 0x5c,
+	ECC_ERR_CNT = 0x60,
+	SEM = 0x64,
+	GPIO_1 = 0x68,		/* Use semaphore */
+	GPIO_2 = 0x6c,		/* Use semaphore */
+	GPIO_3 = 0x70,		/* Use semaphore */
+	RSVD2 = 0x74,
+	XGMAC_ADDR = 0x78,	/* Use semaphore */
+	XGMAC_DATA = 0x7c,	/* Use semaphore */
+	NIC_ETS = 0x80,
+	CNA_ETS = 0x84,
+	FLASH_ADDR = 0x88,	/* Use semaphore */
+	FLASH_DATA = 0x8c,	/* Use semaphore */
+	CQ_STOP = 0x90,
+	PAGE_TBL_RID = 0x94,
+	WQ_PAGE_TBL_LO = 0x98,
+	WQ_PAGE_TBL_HI = 0x9c,
+	CQ_PAGE_TBL_LO = 0xa0,
+	CQ_PAGE_TBL_HI = 0xa4,
+	MAC_ADDR_IDX = 0xa8,	/* Use semaphore */
+	MAC_ADDR_DATA = 0xac,	/* Use semaphore */
+	COS_DFLT_CQ1 = 0xb0,
+	COS_DFLT_CQ2 = 0xb4,
+	ETYPE_SKIP1 = 0xb8,
+	ETYPE_SKIP2 = 0xbc,
+	SPLT_HDR = 0xc0,
+	FC_PAUSE_THRES = 0xc4,
+	NIC_PAUSE_THRES = 0xc8,
+	FC_ETHERTYPE = 0xcc,
+	FC_RCV_CFG = 0xd0,
+	NIC_RCV_CFG = 0xd4,
+	FC_COS_TAGS = 0xd8,
+	NIC_COS_TAGS = 0xdc,
+	MGMT_RCV_CFG = 0xe0,
+	RT_IDX = 0xe4,
+	RT_DATA = 0xe8,
+	RSVD7 = 0xec,
+	XG_SERDES_ADDR = 0xf0,
+	XG_SERDES_DATA = 0xf4,
+	PRB_MX_ADDR = 0xf8,	/* Use semaphore */
+	PRB_MX_DATA = 0xfc,	/* Use semaphore */
+};
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#define SMALL_BUFFER_SIZE 256
+#define SMALL_BUF_MAP_SIZE SMALL_BUFFER_SIZE
+#define SPLT_SETTING  FSC_DBRST_1024
+#define SPLT_LEN 0
+#define QLGE_SB_PAD 0
+#else
+#define SMALL_BUFFER_SIZE 512
+#define SMALL_BUF_MAP_SIZE (SMALL_BUFFER_SIZE / 2)
+#define SPLT_SETTING  FSC_SH
+#define SPLT_LEN (SPLT_HDR_EP | \
+	min(SMALL_BUF_MAP_SIZE, 1023))
+#define QLGE_SB_PAD 32
+#endif
+
+/*
+ * CAM output format.
+ */
+enum {
+	CAM_OUT_ROUTE_FC = 0,
+	CAM_OUT_ROUTE_NIC = 1,
+	CAM_OUT_FUNC_SHIFT = 2,
+	CAM_OUT_RV = (1 << 4),
+	CAM_OUT_SH = (1 << 15),
+	CAM_OUT_CQ_ID_SHIFT = 5,
+};
+
+/*
+ * Mailbox  definitions
+ */
+enum {
+	/* Asynchronous Event Notifications */
+	AEN_SYS_ERR = 0x00008002,
+	AEN_LINK_UP = 0x00008011,
+	AEN_LINK_DOWN = 0x00008012,
+	AEN_IDC_CMPLT = 0x00008100,
+	AEN_IDC_REQ = 0x00008101,
+	AEN_IDC_EXT = 0x00008102,
+	AEN_DCBX_CHG = 0x00008110,
+	AEN_AEN_LOST = 0x00008120,
+	AEN_AEN_SFP_IN = 0x00008130,
+	AEN_AEN_SFP_OUT = 0x00008131,
+	AEN_FW_INIT_DONE = 0x00008400,
+	AEN_FW_INIT_FAIL = 0x00008401,
+
+	/* Mailbox Command Opcodes. */
+	MB_CMD_NOP = 0x00000000,
+	MB_CMD_EX_FW = 0x00000002,
+	MB_CMD_MB_TEST = 0x00000006,
+	MB_CMD_CSUM_TEST = 0x00000007,	/* Verify Checksum */
+	MB_CMD_ABOUT_FW = 0x00000008,
+	MB_CMD_COPY_RISC_RAM = 0x0000000a,
+	MB_CMD_LOAD_RISC_RAM = 0x0000000b,
+	MB_CMD_DUMP_RISC_RAM = 0x0000000c,
+	MB_CMD_WRITE_RAM = 0x0000000d,
+	MB_CMD_INIT_RISC_RAM = 0x0000000e,
+	MB_CMD_READ_RAM = 0x0000000f,
+	MB_CMD_STOP_FW = 0x00000014,
+	MB_CMD_MAKE_SYS_ERR = 0x0000002a,
+	MB_CMD_WRITE_SFP = 0x00000030,
+	MB_CMD_READ_SFP = 0x00000031,
+	MB_CMD_INIT_FW = 0x00000060,
+	MB_CMD_GET_IFCB = 0x00000061,
+	MB_CMD_GET_FW_STATE = 0x00000069,
+	MB_CMD_IDC_REQ = 0x00000100,	/* Inter-Driver Communication */
+	MB_CMD_IDC_ACK = 0x00000101,	/* Inter-Driver Communication */
+	MB_CMD_SET_WOL_MODE = 0x00000110,	/* Wake On Lan */
+	MB_WOL_DISABLE = 0,
+	MB_WOL_MAGIC_PKT = (1 << 1),
+	MB_WOL_FLTR = (1 << 2),
+	MB_WOL_UCAST = (1 << 3),
+	MB_WOL_MCAST = (1 << 4),
+	MB_WOL_BCAST = (1 << 5),
+	MB_WOL_LINK_UP = (1 << 6),
+	MB_WOL_LINK_DOWN = (1 << 7),
+	MB_WOL_MODE_ON = (1 << 16),		/* Wake on Lan Mode on */
+	MB_CMD_SET_WOL_FLTR = 0x00000111,	/* Wake On Lan Filter */
+	MB_CMD_CLEAR_WOL_FLTR = 0x00000112, /* Wake On Lan Filter */
+	MB_CMD_SET_WOL_MAGIC = 0x00000113,	/* Wake On Lan Magic Packet */
+	MB_CMD_CLEAR_WOL_MAGIC = 0x00000114,/* Wake On Lan Magic Packet */
+	MB_CMD_SET_WOL_IMMED = 0x00000115,
+	MB_CMD_PORT_RESET = 0x00000120,
+	MB_CMD_SET_PORT_CFG = 0x00000122,
+	MB_CMD_GET_PORT_CFG = 0x00000123,
+	MB_CMD_GET_LINK_STS = 0x00000124,
+	MB_CMD_SET_LED_CFG = 0x00000125, /* Set LED Configuration Register */
+		QL_LED_BLINK = 0x03e803e8,
+	MB_CMD_GET_LED_CFG = 0x00000126, /* Get LED Configuration Register */
+	MB_CMD_SET_MGMNT_TFK_CTL = 0x00000160, /* Set Mgmnt Traffic Control */
+	MB_SET_MPI_TFK_STOP = (1 << 0),
+	MB_SET_MPI_TFK_RESUME = (1 << 1),
+	MB_CMD_GET_MGMNT_TFK_CTL = 0x00000161, /* Get Mgmnt Traffic Control */
+	MB_GET_MPI_TFK_STOPPED = (1 << 0),
+	MB_GET_MPI_TFK_FIFO_EMPTY = (1 << 1),
+	/* Sub-commands for IDC request.
+	 * This describes the reason for the
+	 * IDC request.
+	 */
+	MB_CMD_IOP_NONE = 0x0000,
+	MB_CMD_IOP_PREP_UPDATE_MPI	= 0x0001,
+	MB_CMD_IOP_COMP_UPDATE_MPI	= 0x0002,
+	MB_CMD_IOP_PREP_LINK_DOWN	= 0x0010,
+	MB_CMD_IOP_DVR_START	 = 0x0100,
+	MB_CMD_IOP_FLASH_ACC	 = 0x0101,
+	MB_CMD_IOP_RESTART_MPI	= 0x0102,
+	MB_CMD_IOP_CORE_DUMP_MPI	= 0x0103,
+
+	/* Mailbox Command Status. */
+	MB_CMD_STS_GOOD = 0x00004000,	/* Success. */
+	MB_CMD_STS_INTRMDT = 0x00001000,	/* Intermediate Complete. */
+	MB_CMD_STS_INVLD_CMD = 0x00004001,	/* Invalid. */
+	MB_CMD_STS_XFC_ERR = 0x00004002,	/* Interface Error. */
+	MB_CMD_STS_CSUM_ERR = 0x00004003,	/* Csum Error. */
+	MB_CMD_STS_ERR = 0x00004005,	/* System Error. */
+	MB_CMD_STS_PARAM_ERR = 0x00004006,	/* Parameter Error. */
+};
+
+struct mbox_params {
+	u32 mbox_in[MAILBOX_COUNT];
+	u32 mbox_out[MAILBOX_COUNT];
+	int in_count;
+	int out_count;
+};
+
+struct flash_params_8012 {
+	u8 dev_id_str[4];
+	__le16 size;
+	__le16 csum;
+	__le16 ver;
+	__le16 sub_dev_id;
+	u8 mac_addr[6];
+	__le16 res;
+};
+
+/* 8000 device's flash is a different structure
+ * at a different offset in flash.
+ */
+#define FUNC0_FLASH_OFFSET 0x140200
+#define FUNC1_FLASH_OFFSET 0x140600
+
+/* Flash related data structures. */
+struct flash_params_8000 {
+	u8 dev_id_str[4];	/* "8000" */
+	__le16 ver;
+	__le16 size;
+	__le16 csum;
+	__le16 reserved0;
+	__le16 total_size;
+	__le16 entry_count;
+	u8 data_type0;
+	u8 data_size0;
+	u8 mac_addr[6];
+	u8 data_type1;
+	u8 data_size1;
+	u8 mac_addr1[6];
+	u8 data_type2;
+	u8 data_size2;
+	__le16 vlan_id;
+	u8 data_type3;
+	u8 data_size3;
+	__le16 last;
+	u8 reserved1[464];
+	__le16	subsys_ven_id;
+	__le16	subsys_dev_id;
+	u8 reserved2[4];
+};
+
+union flash_params {
+	struct flash_params_8012 flash_params_8012;
+	struct flash_params_8000 flash_params_8000;
+};
+
+/*
+ * doorbell space for the rx ring context
+ */
+struct rx_doorbell_context {
+	u32 cnsmr_idx;		/* 0x00 */
+	u32 valid;		/* 0x04 */
+	u32 reserved[4];	/* 0x08-0x14 */
+	u32 lbq_prod_idx;	/* 0x18 */
+	u32 sbq_prod_idx;	/* 0x1c */
+};
+
+/*
+ * doorbell space for the tx ring context
+ */
+struct tx_doorbell_context {
+	u32 prod_idx;		/* 0x00 */
+	u32 valid;		/* 0x04 */
+	u32 reserved[4];	/* 0x08-0x14 */
+	u32 lbq_prod_idx;	/* 0x18 */
+	u32 sbq_prod_idx;	/* 0x1c */
+};
+
+/* DATA STRUCTURES SHARED WITH HARDWARE. */
+struct tx_buf_desc {
+	__le64 addr;
+	__le32 len;
+#define TX_DESC_LEN_MASK	0x000fffff
+#define TX_DESC_C	0x40000000
+#define TX_DESC_E	0x80000000
+} __packed;
+
+/*
+ * IOCB Definitions...
+ */
+
+#define OPCODE_OB_MAC_IOCB		0x01
+#define OPCODE_OB_MAC_TSO_IOCB		0x02
+#define OPCODE_IB_MAC_IOCB		0x20
+#define OPCODE_IB_MPI_IOCB		0x21
+#define OPCODE_IB_AE_IOCB		0x3f
+
+struct qlge_ob_mac_iocb_req {
+	u8 opcode;
+	u8 flags1;
+#define OB_MAC_IOCB_REQ_OI	0x01
+#define OB_MAC_IOCB_REQ_I	0x02
+#define OB_MAC_IOCB_REQ_D	0x08
+#define OB_MAC_IOCB_REQ_F	0x10
+	u8 flags2;
+	u8 flags3;
+#define OB_MAC_IOCB_DFP	0x02
+#define OB_MAC_IOCB_V	0x04
+	__le32 reserved1[2];
+	__le16 frame_len;
+#define OB_MAC_IOCB_LEN_MASK 0x3ffff
+	__le16 reserved2;
+	u32 tid;
+	u32 txq_idx;
+	__le32 reserved3;
+	__le16 vlan_tci;
+	__le16 reserved4;
+	struct tx_buf_desc tbd[TX_DESC_PER_IOCB];
+} __packed;
+
+struct qlge_ob_mac_iocb_rsp {
+	u8 opcode;		/* */
+	u8 flags1;		/* */
+#define OB_MAC_IOCB_RSP_OI	0x01	/* */
+#define OB_MAC_IOCB_RSP_I	0x02	/* */
+#define OB_MAC_IOCB_RSP_E	0x08	/* */
+#define OB_MAC_IOCB_RSP_S	0x10	/* too Short */
+#define OB_MAC_IOCB_RSP_L	0x20	/* too Large */
+#define OB_MAC_IOCB_RSP_P	0x40	/* Padded */
+	u8 flags2;		/* */
+	u8 flags3;		/* */
+#define OB_MAC_IOCB_RSP_B	0x80	/* */
+	u32 tid;
+	u32 txq_idx;
+	__le32 reserved[13];
+} __packed;
+
+struct qlge_ob_mac_tso_iocb_req {
+	u8 opcode;
+	u8 flags1;
+#define OB_MAC_TSO_IOCB_OI	0x01
+#define OB_MAC_TSO_IOCB_I	0x02
+#define OB_MAC_TSO_IOCB_D	0x08
+#define OB_MAC_TSO_IOCB_IP4	0x40
+#define OB_MAC_TSO_IOCB_IP6	0x80
+	u8 flags2;
+#define OB_MAC_TSO_IOCB_LSO	0x20
+#define OB_MAC_TSO_IOCB_UC	0x40
+#define OB_MAC_TSO_IOCB_TC	0x80
+	u8 flags3;
+#define OB_MAC_TSO_IOCB_IC	0x01
+#define OB_MAC_TSO_IOCB_DFP	0x02
+#define OB_MAC_TSO_IOCB_V	0x04
+	__le32 reserved1[2];
+	__le32 frame_len;
+	u32 tid;
+	u32 txq_idx;
+	__le16 total_hdrs_len;
+	__le16 net_trans_offset;
+#define OB_MAC_TRANSPORT_HDR_SHIFT 6
+	__le16 vlan_tci;
+	__le16 mss;
+	struct tx_buf_desc tbd[TX_DESC_PER_IOCB];
+} __packed;
+
+struct qlge_ob_mac_tso_iocb_rsp {
+	u8 opcode;
+	u8 flags1;
+#define OB_MAC_TSO_IOCB_RSP_OI	0x01
+#define OB_MAC_TSO_IOCB_RSP_I	0x02
+#define OB_MAC_TSO_IOCB_RSP_E	0x08
+#define OB_MAC_TSO_IOCB_RSP_S	0x10
+#define OB_MAC_TSO_IOCB_RSP_L	0x20
+#define OB_MAC_TSO_IOCB_RSP_P	0x40
+	u8 flags2;		/* */
+	u8 flags3;		/* */
+#define OB_MAC_TSO_IOCB_RSP_B	0x8000
+	u32 tid;
+	u32 txq_idx;
+	__le32 reserved2[13];
+} __packed;
+
+struct qlge_ib_mac_iocb_rsp {
+	u8 opcode;		/* 0x20 */
+	u8 flags1;
+#define IB_MAC_IOCB_RSP_OI	0x01	/* Override intr delay */
+#define IB_MAC_IOCB_RSP_I	0x02	/* Disable Intr Generation */
+#define IB_MAC_CSUM_ERR_MASK	0x1c	/* A mask to use for csum errs */
+#define IB_MAC_IOCB_RSP_TE	0x04	/* Checksum error */
+#define IB_MAC_IOCB_RSP_NU	0x08	/* No checksum rcvd */
+#define IB_MAC_IOCB_RSP_IE	0x10	/* IPv4 checksum error */
+#define IB_MAC_IOCB_RSP_M_MASK	0x60	/* Multicast info */
+#define IB_MAC_IOCB_RSP_M_NONE	0x00	/* Not mcast frame */
+#define IB_MAC_IOCB_RSP_M_HASH	0x20	/* HASH mcast frame */
+#define IB_MAC_IOCB_RSP_M_REG	0x40	/* Registered mcast frame */
+#define IB_MAC_IOCB_RSP_M_PROM	0x60	/* Promiscuous mcast frame */
+#define IB_MAC_IOCB_RSP_B	0x80	/* Broadcast frame */
+	u8 flags2;
+#define IB_MAC_IOCB_RSP_P	0x01	/* Promiscuous frame */
+#define IB_MAC_IOCB_RSP_V	0x02	/* Vlan tag present */
+#define IB_MAC_IOCB_RSP_ERR_MASK	0x1c	/*  */
+#define IB_MAC_IOCB_RSP_ERR_CODE_ERR	0x04
+#define IB_MAC_IOCB_RSP_ERR_OVERSIZE	0x08
+#define IB_MAC_IOCB_RSP_ERR_UNDERSIZE	0x10
+#define IB_MAC_IOCB_RSP_ERR_PREAMBLE	0x14
+#define IB_MAC_IOCB_RSP_ERR_FRAME_LEN	0x18
+#define IB_MAC_IOCB_RSP_ERR_CRC		0x1c
+#define IB_MAC_IOCB_RSP_U	0x20	/* UDP packet */
+#define IB_MAC_IOCB_RSP_T	0x40	/* TCP packet */
+#define IB_MAC_IOCB_RSP_FO	0x80	/* Failover port */
+	u8 flags3;
+#define IB_MAC_IOCB_RSP_RSS_MASK	0x07	/* RSS mask */
+#define IB_MAC_IOCB_RSP_M_NONE		0x00	/* No RSS match */
+#define IB_MAC_IOCB_RSP_M_IPV4		0x04	/* IPv4 RSS match */
+#define IB_MAC_IOCB_RSP_M_IPV6		0x02	/* IPv6 RSS match */
+#define IB_MAC_IOCB_RSP_M_TCP_V4	0x05	/* TCP with IPv4 */
+#define IB_MAC_IOCB_RSP_M_TCP_V6	0x03	/* TCP with IPv6 */
+#define IB_MAC_IOCB_RSP_V4		0x08	/* IPV4 */
+#define IB_MAC_IOCB_RSP_V6		0x10	/* IPV6 */
+#define IB_MAC_IOCB_RSP_IH		0x20	/* Split after IP header */
+#define IB_MAC_IOCB_RSP_DS		0x40	/* data is in small buffer */
+#define IB_MAC_IOCB_RSP_DL		0x80	/* data is in large buffer */
+	__le32 data_len;	/* */
+	__le64 data_addr;	/* */
+	__le32 rss;		/* */
+	__le16 vlan_id;		/* 12 bits */
+#define IB_MAC_IOCB_RSP_C	0x1000	/* VLAN CFI bit */
+#define IB_MAC_IOCB_RSP_COS_SHIFT	12	/* class of service value */
+#define IB_MAC_IOCB_RSP_VLAN_MASK	0x0ffff
+
+	__le16 reserved1;
+	__le32 reserved2[6];
+	u8 reserved3[3];
+	u8 flags4;
+#define IB_MAC_IOCB_RSP_HV	0x20
+#define IB_MAC_IOCB_RSP_HS	0x40
+#define IB_MAC_IOCB_RSP_HL	0x80
+	__le32 hdr_len;		/* */
+	__le64 hdr_addr;	/* */
+} __packed;
+
+struct qlge_ib_ae_iocb_rsp {
+	u8 opcode;
+	u8 flags1;
+#define IB_AE_IOCB_RSP_OI		0x01
+#define IB_AE_IOCB_RSP_I		0x02
+	u8 event;
+#define LINK_UP_EVENT			0x00
+#define LINK_DOWN_EVENT			0x01
+#define CAM_LOOKUP_ERR_EVENT		0x06
+#define SOFT_ECC_ERROR_EVENT		0x07
+#define MGMT_ERR_EVENT			0x08
+#define TEN_GIG_MAC_EVENT		0x09
+#define GPI0_H2L_EVENT			0x10
+#define GPI0_L2H_EVENT			0x20
+#define GPI1_H2L_EVENT			0x11
+#define GPI1_L2H_EVENT			0x21
+#define PCI_ERR_ANON_BUF_RD		0x40
+	u8 q_id;
+	__le32 reserved[15];
+} __packed;
+
+/*
+ * These three structures are for generic
+ * handling of ib and ob iocbs.
+ */
+struct qlge_net_rsp_iocb {
+	u8 opcode;
+	u8 flags0;
+	__le16 length;
+	__le32 tid;
+	__le32 reserved[14];
+} __packed;
+
+struct qlge_net_req_iocb {
+	u8 opcode;
+	u8 flags0;
+	__le16 flags1;
+	__le32 tid;
+	__le32 reserved1[30];
+} __packed;
+
+/*
+ * tx ring initialization control block for chip.
+ * It is defined as:
+ * "Work Queue Initialization Control Block"
+ */
+struct wqicb {
+	__le16 len;
+#define Q_LEN_V		BIT(4)
+#define Q_LEN_CPP_CONT	0x0000
+#define Q_LEN_CPP_16	0x0001
+#define Q_LEN_CPP_32	0x0002
+#define Q_LEN_CPP_64	0x0003
+#define Q_LEN_CPP_512	0x0006
+	__le16 flags;
+#define Q_PRI_SHIFT	1
+#define Q_FLAGS_LC	0x1000
+#define Q_FLAGS_LB	0x2000
+#define Q_FLAGS_LI	0x4000
+#define Q_FLAGS_LO	0x8000
+	__le16 cq_id_rss;
+#define Q_CQ_ID_RSS_RV 0x8000
+	__le16 rid;
+	__le64 addr;
+	__le64 cnsmr_idx_addr;
+} __packed;
+
+/*
+ * rx ring initialization control block for chip.
+ * It is defined as:
+ * "Completion Queue Initialization Control Block"
+ */
+struct cqicb {
+	u8 msix_vect;
+	u8 reserved1;
+	u8 reserved2;
+	u8 flags;
+#define FLAGS_LV	0x08
+#define FLAGS_LS	0x10
+#define FLAGS_LL	0x20
+#define FLAGS_LI	0x40
+#define FLAGS_LC	0x80
+	__le16 len;
+#define LEN_V		BIT(4)
+#define LEN_CPP_CONT	0x0000
+#define LEN_CPP_32	0x0001
+#define LEN_CPP_64	0x0002
+#define LEN_CPP_128	0x0003
+	__le16 rid;
+	__le64 addr;
+	__le64 prod_idx_addr;
+	__le16 pkt_delay;
+	__le16 irq_delay;
+	__le64 lbq_addr;
+	__le16 lbq_buf_size;
+	__le16 lbq_len;		/* entry count */
+	__le64 sbq_addr;
+	__le16 sbq_buf_size;
+	__le16 sbq_len;		/* entry count */
+} __packed;
+
+struct ricb {
+	u8 base_cq;
+#define RSS_L4K 0x80
+	u8 flags;
+#define RSS_L6K 0x01
+#define RSS_LI  0x02
+#define RSS_LB  0x04
+#define RSS_LM  0x08
+#define RSS_RI4 0x10
+#define RSS_RT4 0x20
+#define RSS_RI6 0x40
+#define RSS_RT6 0x80
+	__le16 mask;
+	u8 hash_cq_id[1024];
+	__le32 ipv6_hash_key[10];
+	__le32 ipv4_hash_key[4];
+} __packed;
+
+/* SOFTWARE/DRIVER DATA STRUCTURES. */
+
+struct qlge_oal {
+	struct tx_buf_desc oal[TX_DESC_PER_OAL];
+};
+
+struct map_list {
+	DEFINE_DMA_UNMAP_ADDR(mapaddr);
+	DEFINE_DMA_UNMAP_LEN(maplen);
+};
+
+struct tx_ring_desc {
+	struct sk_buff *skb;
+	struct qlge_ob_mac_iocb_req *queue_entry;
+	u32 index;
+	struct qlge_oal oal;
+	struct map_list map[MAX_SKB_FRAGS + 2];
+	int map_cnt;
+	struct tx_ring_desc *next;
+};
+
+#define QL_TXQ_IDX(qdev, skb) (smp_processor_id() % (qdev->tx_ring_count))
+
+struct tx_ring {
+	/*
+	 * queue info.
+	 */
+	struct wqicb wqicb;	/* structure used to inform chip of new queue */
+	void *wq_base;		/* pci_alloc:virtual addr for tx */
+	dma_addr_t wq_base_dma;	/* pci_alloc:dma addr for tx */
+	__le32 *cnsmr_idx_sh_reg;	/* shadow copy of consumer idx */
+	dma_addr_t cnsmr_idx_sh_reg_dma;	/* dma-shadow copy of consumer */
+	u32 wq_size;		/* size in bytes of queue area */
+	u32 wq_len;		/* number of entries in queue */
+	void __iomem *prod_idx_db_reg;	/* doorbell area index reg at offset 0x00 */
+	void __iomem *valid_db_reg;	/* doorbell area valid reg at offset 0x04 */
+	u16 prod_idx;		/* current value for prod idx */
+	u16 cq_id;		/* completion (rx) queue for tx completions */
+	u8 wq_id;		/* queue id for this entry */
+	u8 reserved1[3];
+	struct tx_ring_desc *q;	/* descriptor list for the queue */
+	spinlock_t lock;
+	atomic_t tx_count;	/* counts down for every outstanding IO */
+	struct delayed_work tx_work;
+	struct qlge_adapter *qdev;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_errors;
+};
+
+struct qlge_page_chunk {
+	struct page *page;
+	void *va; /* virt addr including offset */
+	unsigned int offset;
+};
+
+struct qlge_bq_desc {
+	union {
+		/* for large buffers */
+		struct qlge_page_chunk pg_chunk;
+		/* for small buffers */
+		struct sk_buff *skb;
+	} p;
+	dma_addr_t dma_addr;
+	/* address in ring where the buffer address is written for the device */
+	__le64 *buf_ptr;
+	u32 index;
+};
+
+/* buffer queue */
+struct qlge_bq {
+	__le64 *base;
+	dma_addr_t base_dma;
+	__le64 *base_indirect;
+	dma_addr_t base_indirect_dma;
+	struct qlge_bq_desc *queue;
+	/* prod_idx is the index of the first buffer that may NOT be used by
+	 * hw, ie. one after the last. Advanced by sw.
+	 */
+	void __iomem *prod_idx_db_reg;
+	/* next index where sw should refill a buffer for hw */
+	u16 next_to_use;
+	/* next index where sw expects to find a buffer filled by hw */
+	u16 next_to_clean;
+	enum {
+		QLGE_SB,		/* small buffer */
+		QLGE_LB,		/* large buffer */
+	} type;
+};
+
+#define QLGE_BQ_CONTAINER(bq) \
+({ \
+	typeof(bq) _bq = bq; \
+	(struct rx_ring *)((char *)_bq - (_bq->type == QLGE_SB ? \
+					  offsetof(struct rx_ring, sbq) : \
+					  offsetof(struct rx_ring, lbq))); \
+})
+
+/* Experience shows that the device ignores the low 4 bits of the tail index.
+ * Refill up to a x16 multiple.
+ */
+#define QLGE_BQ_ALIGN(index) ALIGN_DOWN(index, 16)
+
+#define QLGE_BQ_WRAP(index) ((index) & (QLGE_BQ_LEN - 1))
+
+#define QLGE_BQ_HW_OWNED(bq) \
+({ \
+	typeof(bq) _bq = bq; \
+	QLGE_BQ_WRAP(QLGE_BQ_ALIGN((_bq)->next_to_use) - \
+		     (_bq)->next_to_clean); \
+})
+
+struct rx_ring {
+	struct cqicb cqicb;	/* The chip's completion queue init control block. */
+
+	/* Completion queue elements. */
+	void *cq_base;
+	dma_addr_t cq_base_dma;
+	u32 cq_size;
+	u32 cq_len;
+	u16 cq_id;
+	__le32 *prod_idx_sh_reg;	/* Shadowed producer register. */
+	dma_addr_t prod_idx_sh_reg_dma;
+	void __iomem *cnsmr_idx_db_reg;	/* PCI doorbell mem area + 0 */
+	u32 cnsmr_idx;		/* current sw idx */
+	struct qlge_net_rsp_iocb *curr_entry;	/* next entry on queue */
+	void __iomem *valid_db_reg;	/* PCI doorbell mem area + 0x04 */
+
+	/* Large buffer queue elements. */
+	struct qlge_bq lbq;
+	struct qlge_page_chunk master_chunk;
+	dma_addr_t chunk_dma_addr;
+
+	/* Small buffer queue elements. */
+	struct qlge_bq sbq;
+
+	/* Misc. handler elements. */
+	u32 irq;		/* Which vector this ring is assigned. */
+	u32 cpu;		/* Which CPU this should run on. */
+	struct delayed_work refill_work;
+	char name[IFNAMSIZ + 5];
+	struct napi_struct napi;
+	u8 reserved;
+	struct qlge_adapter *qdev;
+	u64 rx_packets;
+	u64 rx_multicast;
+	u64 rx_bytes;
+	u64 rx_dropped;
+	u64 rx_errors;
+};
+
+/*
+ * RSS Initialization Control Block
+ */
+struct hash_id {
+	u8 value[4];
+};
+
+struct nic_stats {
+	/*
+	 * These stats come from offset 200h to 278h
+	 * in the XGMAC register.
+	 */
+	u64 tx_pkts;
+	u64 tx_bytes;
+	u64 tx_mcast_pkts;
+	u64 tx_bcast_pkts;
+	u64 tx_ucast_pkts;
+	u64 tx_ctl_pkts;
+	u64 tx_pause_pkts;
+	u64 tx_64_pkt;
+	u64 tx_65_to_127_pkt;
+	u64 tx_128_to_255_pkt;
+	u64 tx_256_511_pkt;
+	u64 tx_512_to_1023_pkt;
+	u64 tx_1024_to_1518_pkt;
+	u64 tx_1519_to_max_pkt;
+	u64 tx_undersize_pkt;
+	u64 tx_oversize_pkt;
+
+	/*
+	 * These stats come from offset 300h to 3C8h
+	 * in the XGMAC register.
+	 */
+	u64 rx_bytes;
+	u64 rx_bytes_ok;
+	u64 rx_pkts;
+	u64 rx_pkts_ok;
+	u64 rx_bcast_pkts;
+	u64 rx_mcast_pkts;
+	u64 rx_ucast_pkts;
+	u64 rx_undersize_pkts;
+	u64 rx_oversize_pkts;
+	u64 rx_jabber_pkts;
+	u64 rx_undersize_fcerr_pkts;
+	u64 rx_drop_events;
+	u64 rx_fcerr_pkts;
+	u64 rx_align_err;
+	u64 rx_symbol_err;
+	u64 rx_mac_err;
+	u64 rx_ctl_pkts;
+	u64 rx_pause_pkts;
+	u64 rx_64_pkts;
+	u64 rx_65_to_127_pkts;
+	u64 rx_128_255_pkts;
+	u64 rx_256_511_pkts;
+	u64 rx_512_to_1023_pkts;
+	u64 rx_1024_to_1518_pkts;
+	u64 rx_1519_to_max_pkts;
+	u64 rx_len_err_pkts;
+	/* Receive Mac Err stats */
+	u64 rx_code_err;
+	u64 rx_oversize_err;
+	u64 rx_undersize_err;
+	u64 rx_preamble_err;
+	u64 rx_frame_len_err;
+	u64 rx_crc_err;
+	u64 rx_err_count;
+	/*
+	 * These stats come from offset 500h to 5C8h
+	 * in the XGMAC register.
+	 */
+	u64 tx_cbfc_pause_frames0;
+	u64 tx_cbfc_pause_frames1;
+	u64 tx_cbfc_pause_frames2;
+	u64 tx_cbfc_pause_frames3;
+	u64 tx_cbfc_pause_frames4;
+	u64 tx_cbfc_pause_frames5;
+	u64 tx_cbfc_pause_frames6;
+	u64 tx_cbfc_pause_frames7;
+	u64 rx_cbfc_pause_frames0;
+	u64 rx_cbfc_pause_frames1;
+	u64 rx_cbfc_pause_frames2;
+	u64 rx_cbfc_pause_frames3;
+	u64 rx_cbfc_pause_frames4;
+	u64 rx_cbfc_pause_frames5;
+	u64 rx_cbfc_pause_frames6;
+	u64 rx_cbfc_pause_frames7;
+	u64 rx_nic_fifo_drop;
+};
+
+/* Firmware coredump internal register address/length pairs. */
+enum {
+	MPI_CORE_REGS_ADDR = 0x00030000,
+	MPI_CORE_REGS_CNT = 127,
+	MPI_CORE_SH_REGS_CNT = 16,
+	TEST_REGS_ADDR = 0x00001000,
+	TEST_REGS_CNT = 23,
+	RMII_REGS_ADDR = 0x00001040,
+	RMII_REGS_CNT = 64,
+	FCMAC1_REGS_ADDR = 0x00001080,
+	FCMAC2_REGS_ADDR = 0x000010c0,
+	FCMAC_REGS_CNT = 64,
+	FC1_MBX_REGS_ADDR = 0x00001100,
+	FC2_MBX_REGS_ADDR = 0x00001240,
+	FC_MBX_REGS_CNT = 64,
+	IDE_REGS_ADDR = 0x00001140,
+	IDE_REGS_CNT = 64,
+	NIC1_MBX_REGS_ADDR = 0x00001180,
+	NIC2_MBX_REGS_ADDR = 0x00001280,
+	NIC_MBX_REGS_CNT = 64,
+	SMBUS_REGS_ADDR = 0x00001200,
+	SMBUS_REGS_CNT = 64,
+	I2C_REGS_ADDR = 0x00001fc0,
+	I2C_REGS_CNT = 64,
+	MEMC_REGS_ADDR = 0x00003000,
+	MEMC_REGS_CNT = 256,
+	PBUS_REGS_ADDR = 0x00007c00,
+	PBUS_REGS_CNT = 256,
+	MDE_REGS_ADDR = 0x00010000,
+	MDE_REGS_CNT = 6,
+	CODE_RAM_ADDR = 0x00020000,
+	CODE_RAM_CNT = 0x2000,
+	MEMC_RAM_ADDR = 0x00100000,
+	MEMC_RAM_CNT = 0x2000,
+};
+
+#define MPI_COREDUMP_COOKIE 0x5555aaaa
+struct mpi_coredump_global_header {
+	u32	cookie;
+	u8	id_string[16];
+	u32	time_lo;
+	u32	time_hi;
+	u32	image_size;
+	u32	header_size;
+	u8	info[220];
+};
+
+struct mpi_coredump_segment_header {
+	u32	cookie;
+	u32	seg_num;
+	u32	seg_size;
+	u32	extra;
+	u8	description[16];
+};
+
+/* Firmware coredump header segment numbers. */
+enum {
+	CORE_SEG_NUM = 1,
+	TEST_LOGIC_SEG_NUM = 2,
+	RMII_SEG_NUM = 3,
+	FCMAC1_SEG_NUM = 4,
+	FCMAC2_SEG_NUM = 5,
+	FC1_MBOX_SEG_NUM = 6,
+	IDE_SEG_NUM = 7,
+	NIC1_MBOX_SEG_NUM = 8,
+	SMBUS_SEG_NUM = 9,
+	FC2_MBOX_SEG_NUM = 10,
+	NIC2_MBOX_SEG_NUM = 11,
+	I2C_SEG_NUM = 12,
+	MEMC_SEG_NUM = 13,
+	PBUS_SEG_NUM = 14,
+	MDE_SEG_NUM = 15,
+	NIC1_CONTROL_SEG_NUM = 16,
+	NIC2_CONTROL_SEG_NUM = 17,
+	NIC1_XGMAC_SEG_NUM = 18,
+	NIC2_XGMAC_SEG_NUM = 19,
+	WCS_RAM_SEG_NUM = 20,
+	MEMC_RAM_SEG_NUM = 21,
+	XAUI_AN_SEG_NUM = 22,
+	XAUI_HSS_PCS_SEG_NUM = 23,
+	XFI_AN_SEG_NUM = 24,
+	XFI_TRAIN_SEG_NUM = 25,
+	XFI_HSS_PCS_SEG_NUM = 26,
+	XFI_HSS_TX_SEG_NUM = 27,
+	XFI_HSS_RX_SEG_NUM = 28,
+	XFI_HSS_PLL_SEG_NUM = 29,
+	MISC_NIC_INFO_SEG_NUM = 30,
+	INTR_STATES_SEG_NUM = 31,
+	CAM_ENTRIES_SEG_NUM = 32,
+	ROUTING_WORDS_SEG_NUM = 33,
+	ETS_SEG_NUM = 34,
+	PROBE_DUMP_SEG_NUM = 35,
+	ROUTING_INDEX_SEG_NUM = 36,
+	MAC_PROTOCOL_SEG_NUM = 37,
+	XAUI2_AN_SEG_NUM = 38,
+	XAUI2_HSS_PCS_SEG_NUM = 39,
+	XFI2_AN_SEG_NUM = 40,
+	XFI2_TRAIN_SEG_NUM = 41,
+	XFI2_HSS_PCS_SEG_NUM = 42,
+	XFI2_HSS_TX_SEG_NUM = 43,
+	XFI2_HSS_RX_SEG_NUM = 44,
+	XFI2_HSS_PLL_SEG_NUM = 45,
+	SEM_REGS_SEG_NUM = 50
+
+};
+
+/* There are 64 generic NIC registers. */
+#define NIC_REGS_DUMP_WORD_COUNT		64
+/* XGMAC word count. */
+#define XGMAC_DUMP_WORD_COUNT		(XGMAC_REGISTER_END / 4)
+/* Word counts for the SERDES blocks. */
+#define XG_SERDES_XAUI_AN_COUNT		14
+#define XG_SERDES_XAUI_HSS_PCS_COUNT	33
+#define XG_SERDES_XFI_AN_COUNT		14
+#define XG_SERDES_XFI_TRAIN_COUNT		12
+#define XG_SERDES_XFI_HSS_PCS_COUNT	15
+#define XG_SERDES_XFI_HSS_TX_COUNT		32
+#define XG_SERDES_XFI_HSS_RX_COUNT		32
+#define XG_SERDES_XFI_HSS_PLL_COUNT	32
+
+/* There are 2 CNA ETS and 8 NIC ETS registers. */
+#define ETS_REGS_DUMP_WORD_COUNT		10
+
+/* Each probe mux entry stores the probe type plus 64 entries
+ * that are each 64-bits in length. There are a total of
+ * 34 (PRB_MX_ADDR_VALID_TOTAL) valid probes.
+ */
+#define PRB_MX_ADDR_PRB_WORD_COUNT		(1 + (PRB_MX_ADDR_MAX_MUX * 2))
+#define PRB_MX_DUMP_TOT_COUNT		(PRB_MX_ADDR_PRB_WORD_COUNT * \
+							PRB_MX_ADDR_VALID_TOTAL)
+/* Each routing entry consists of 4 32-bit words.
+ * They are route type, index, index word, and result.
+ * There are 2 route blocks with 8 entries each and
+ *  2 NIC blocks with 16 entries each.
+ * The totol entries is 48 with 4 words each.
+ */
+#define RT_IDX_DUMP_ENTRIES			48
+#define RT_IDX_DUMP_WORDS_PER_ENTRY	4
+#define RT_IDX_DUMP_TOT_WORDS		(RT_IDX_DUMP_ENTRIES * \
+						RT_IDX_DUMP_WORDS_PER_ENTRY)
+/* There are 10 address blocks in filter, each with
+ * different entry counts and different word-count-per-entry.
+ */
+#define MAC_ADDR_DUMP_ENTRIES \
+	((MAC_ADDR_MAX_CAM_ENTRIES * MAC_ADDR_MAX_CAM_WCOUNT) + \
+	(MAC_ADDR_MAX_MULTICAST_ENTRIES * MAC_ADDR_MAX_MULTICAST_WCOUNT) + \
+	(MAC_ADDR_MAX_VLAN_ENTRIES * MAC_ADDR_MAX_VLAN_WCOUNT) + \
+	(MAC_ADDR_MAX_MCAST_FLTR_ENTRIES * MAC_ADDR_MAX_MCAST_FLTR_WCOUNT) + \
+	(MAC_ADDR_MAX_FC_MAC_ENTRIES * MAC_ADDR_MAX_FC_MAC_WCOUNT) + \
+	(MAC_ADDR_MAX_MGMT_MAC_ENTRIES * MAC_ADDR_MAX_MGMT_MAC_WCOUNT) + \
+	(MAC_ADDR_MAX_MGMT_VLAN_ENTRIES * MAC_ADDR_MAX_MGMT_VLAN_WCOUNT) + \
+	(MAC_ADDR_MAX_MGMT_V4_ENTRIES * MAC_ADDR_MAX_MGMT_V4_WCOUNT) + \
+	(MAC_ADDR_MAX_MGMT_V6_ENTRIES * MAC_ADDR_MAX_MGMT_V6_WCOUNT) + \
+	(MAC_ADDR_MAX_MGMT_TU_DP_ENTRIES * MAC_ADDR_MAX_MGMT_TU_DP_WCOUNT))
+#define MAC_ADDR_DUMP_WORDS_PER_ENTRY	2
+#define MAC_ADDR_DUMP_TOT_WORDS		(MAC_ADDR_DUMP_ENTRIES * \
+						MAC_ADDR_DUMP_WORDS_PER_ENTRY)
+/* Maximum of 4 functions whose semaphore registeres are
+ * in the coredump.
+ */
+#define MAX_SEMAPHORE_FUNCTIONS		4
+/* Defines for access the MPI shadow registers. */
+#define RISC_124		0x0003007c
+#define RISC_127		0x0003007f
+#define SHADOW_OFFSET	0xb0000000
+#define SHADOW_REG_SHIFT	20
+
+struct qlge_nic_misc {
+	u32 rx_ring_count;
+	u32 tx_ring_count;
+	u32 intr_count;
+	u32 function;
+};
+
+struct qlge_reg_dump {
+	/* segment 0 */
+	struct mpi_coredump_global_header mpi_global_header;
+
+	/* segment 16 */
+	struct mpi_coredump_segment_header nic_regs_seg_hdr;
+	u32 nic_regs[64];
+
+	/* segment 30 */
+	struct mpi_coredump_segment_header misc_nic_seg_hdr;
+	struct qlge_nic_misc misc_nic_info;
+
+	/* segment 31 */
+	/* one interrupt state for each CQ */
+	struct mpi_coredump_segment_header intr_states_seg_hdr;
+	u32 intr_states[MAX_CPUS];
+
+	/* segment 32 */
+	/* 3 cam words each for 16 unicast,
+	 * 2 cam words for each of 32 multicast.
+	 */
+	struct mpi_coredump_segment_header cam_entries_seg_hdr;
+	u32 cam_entries[(16 * 3) + (32 * 3)];
+
+	/* segment 33 */
+	struct mpi_coredump_segment_header nic_routing_words_seg_hdr;
+	u32 nic_routing_words[16];
+
+	/* segment 34 */
+	struct mpi_coredump_segment_header ets_seg_hdr;
+	u32 ets[8 + 2];
+};
+
+struct qlge_mpi_coredump {
+	/* segment 0 */
+	struct mpi_coredump_global_header mpi_global_header;
+
+	/* segment 1 */
+	struct mpi_coredump_segment_header core_regs_seg_hdr;
+	u32 mpi_core_regs[MPI_CORE_REGS_CNT];
+	u32 mpi_core_sh_regs[MPI_CORE_SH_REGS_CNT];
+
+	/* segment 2 */
+	struct mpi_coredump_segment_header test_logic_regs_seg_hdr;
+	u32 test_logic_regs[TEST_REGS_CNT];
+
+	/* segment 3 */
+	struct mpi_coredump_segment_header rmii_regs_seg_hdr;
+	u32 rmii_regs[RMII_REGS_CNT];
+
+	/* segment 4 */
+	struct mpi_coredump_segment_header fcmac1_regs_seg_hdr;
+	u32 fcmac1_regs[FCMAC_REGS_CNT];
+
+	/* segment 5 */
+	struct mpi_coredump_segment_header fcmac2_regs_seg_hdr;
+	u32 fcmac2_regs[FCMAC_REGS_CNT];
+
+	/* segment 6 */
+	struct mpi_coredump_segment_header fc1_mbx_regs_seg_hdr;
+	u32 fc1_mbx_regs[FC_MBX_REGS_CNT];
+
+	/* segment 7 */
+	struct mpi_coredump_segment_header ide_regs_seg_hdr;
+	u32 ide_regs[IDE_REGS_CNT];
+
+	/* segment 8 */
+	struct mpi_coredump_segment_header nic1_mbx_regs_seg_hdr;
+	u32 nic1_mbx_regs[NIC_MBX_REGS_CNT];
+
+	/* segment 9 */
+	struct mpi_coredump_segment_header smbus_regs_seg_hdr;
+	u32 smbus_regs[SMBUS_REGS_CNT];
+
+	/* segment 10 */
+	struct mpi_coredump_segment_header fc2_mbx_regs_seg_hdr;
+	u32 fc2_mbx_regs[FC_MBX_REGS_CNT];
+
+	/* segment 11 */
+	struct mpi_coredump_segment_header nic2_mbx_regs_seg_hdr;
+	u32 nic2_mbx_regs[NIC_MBX_REGS_CNT];
+
+	/* segment 12 */
+	struct mpi_coredump_segment_header i2c_regs_seg_hdr;
+	u32 i2c_regs[I2C_REGS_CNT];
+	/* segment 13 */
+	struct mpi_coredump_segment_header memc_regs_seg_hdr;
+	u32 memc_regs[MEMC_REGS_CNT];
+
+	/* segment 14 */
+	struct mpi_coredump_segment_header pbus_regs_seg_hdr;
+	u32 pbus_regs[PBUS_REGS_CNT];
+
+	/* segment 15 */
+	struct mpi_coredump_segment_header mde_regs_seg_hdr;
+	u32 mde_regs[MDE_REGS_CNT];
+
+	/* segment 16 */
+	struct mpi_coredump_segment_header nic_regs_seg_hdr;
+	u32 nic_regs[NIC_REGS_DUMP_WORD_COUNT];
+
+	/* segment 17 */
+	struct mpi_coredump_segment_header nic2_regs_seg_hdr;
+	u32 nic2_regs[NIC_REGS_DUMP_WORD_COUNT];
+
+	/* segment 18 */
+	struct mpi_coredump_segment_header xgmac1_seg_hdr;
+	u32 xgmac1[XGMAC_DUMP_WORD_COUNT];
+
+	/* segment 19 */
+	struct mpi_coredump_segment_header xgmac2_seg_hdr;
+	u32 xgmac2[XGMAC_DUMP_WORD_COUNT];
+
+	/* segment 20 */
+	struct mpi_coredump_segment_header code_ram_seg_hdr;
+	u32 code_ram[CODE_RAM_CNT];
+
+	/* segment 21 */
+	struct mpi_coredump_segment_header memc_ram_seg_hdr;
+	u32 memc_ram[MEMC_RAM_CNT];
+
+	/* segment 22 */
+	struct mpi_coredump_segment_header xaui_an_hdr;
+	u32 serdes_xaui_an[XG_SERDES_XAUI_AN_COUNT];
+
+	/* segment 23 */
+	struct mpi_coredump_segment_header xaui_hss_pcs_hdr;
+	u32 serdes_xaui_hss_pcs[XG_SERDES_XAUI_HSS_PCS_COUNT];
+
+	/* segment 24 */
+	struct mpi_coredump_segment_header xfi_an_hdr;
+	u32 serdes_xfi_an[XG_SERDES_XFI_AN_COUNT];
+
+	/* segment 25 */
+	struct mpi_coredump_segment_header xfi_train_hdr;
+	u32 serdes_xfi_train[XG_SERDES_XFI_TRAIN_COUNT];
+
+	/* segment 26 */
+	struct mpi_coredump_segment_header xfi_hss_pcs_hdr;
+	u32 serdes_xfi_hss_pcs[XG_SERDES_XFI_HSS_PCS_COUNT];
+
+	/* segment 27 */
+	struct mpi_coredump_segment_header xfi_hss_tx_hdr;
+	u32 serdes_xfi_hss_tx[XG_SERDES_XFI_HSS_TX_COUNT];
+
+	/* segment 28 */
+	struct mpi_coredump_segment_header xfi_hss_rx_hdr;
+	u32 serdes_xfi_hss_rx[XG_SERDES_XFI_HSS_RX_COUNT];
+
+	/* segment 29 */
+	struct mpi_coredump_segment_header xfi_hss_pll_hdr;
+	u32 serdes_xfi_hss_pll[XG_SERDES_XFI_HSS_PLL_COUNT];
+
+	/* segment 30 */
+	struct mpi_coredump_segment_header misc_nic_seg_hdr;
+	struct qlge_nic_misc misc_nic_info;
+
+	/* segment 31 */
+	/* one interrupt state for each CQ */
+	struct mpi_coredump_segment_header intr_states_seg_hdr;
+	u32 intr_states[MAX_RX_RINGS];
+
+	/* segment 32 */
+	/* 3 cam words each for 16 unicast,
+	 * 2 cam words for each of 32 multicast.
+	 */
+	struct mpi_coredump_segment_header cam_entries_seg_hdr;
+	u32 cam_entries[(16 * 3) + (32 * 3)];
+
+	/* segment 33 */
+	struct mpi_coredump_segment_header nic_routing_words_seg_hdr;
+	u32 nic_routing_words[16];
+	/* segment 34 */
+	struct mpi_coredump_segment_header ets_seg_hdr;
+	u32 ets[ETS_REGS_DUMP_WORD_COUNT];
+
+	/* segment 35 */
+	struct mpi_coredump_segment_header probe_dump_seg_hdr;
+	u32 probe_dump[PRB_MX_DUMP_TOT_COUNT];
+
+	/* segment 36 */
+	struct mpi_coredump_segment_header routing_reg_seg_hdr;
+	u32 routing_regs[RT_IDX_DUMP_TOT_WORDS];
+
+	/* segment 37 */
+	struct mpi_coredump_segment_header mac_prot_reg_seg_hdr;
+	u32 mac_prot_regs[MAC_ADDR_DUMP_TOT_WORDS];
+
+	/* segment 38 */
+	struct mpi_coredump_segment_header xaui2_an_hdr;
+	u32 serdes2_xaui_an[XG_SERDES_XAUI_AN_COUNT];
+
+	/* segment 39 */
+	struct mpi_coredump_segment_header xaui2_hss_pcs_hdr;
+	u32 serdes2_xaui_hss_pcs[XG_SERDES_XAUI_HSS_PCS_COUNT];
+
+	/* segment 40 */
+	struct mpi_coredump_segment_header xfi2_an_hdr;
+	u32 serdes2_xfi_an[XG_SERDES_XFI_AN_COUNT];
+
+	/* segment 41 */
+	struct mpi_coredump_segment_header xfi2_train_hdr;
+	u32 serdes2_xfi_train[XG_SERDES_XFI_TRAIN_COUNT];
+
+	/* segment 42 */
+	struct mpi_coredump_segment_header xfi2_hss_pcs_hdr;
+	u32 serdes2_xfi_hss_pcs[XG_SERDES_XFI_HSS_PCS_COUNT];
+
+	/* segment 43 */
+	struct mpi_coredump_segment_header xfi2_hss_tx_hdr;
+	u32 serdes2_xfi_hss_tx[XG_SERDES_XFI_HSS_TX_COUNT];
+
+	/* segment 44 */
+	struct mpi_coredump_segment_header xfi2_hss_rx_hdr;
+	u32 serdes2_xfi_hss_rx[XG_SERDES_XFI_HSS_RX_COUNT];
+
+	/* segment 45 */
+	struct mpi_coredump_segment_header xfi2_hss_pll_hdr;
+	u32 serdes2_xfi_hss_pll[XG_SERDES_XFI_HSS_PLL_COUNT];
+
+	/* segment 50 */
+	/* semaphore register for all 5 functions */
+	struct mpi_coredump_segment_header sem_regs_seg_hdr;
+	u32 sem_regs[MAX_SEMAPHORE_FUNCTIONS];
+};
+
+/*
+ * intr_context structure is used during initialization
+ * to hook the interrupts.  It is also used in a single
+ * irq environment as a context to the ISR.
+ */
+struct intr_context {
+	struct qlge_adapter *qdev;
+	u32 intr;
+	u32 irq_mask;		/* Mask of which rings the vector services. */
+	u32 hooked;
+	u32 intr_en_mask;	/* value/mask used to enable this intr */
+	u32 intr_dis_mask;	/* value/mask used to disable this intr */
+	u32 intr_read_mask;	/* value/mask used to read this intr */
+	char name[IFNAMSIZ * 2];
+	irq_handler_t handler;
+};
+
+/* adapter flags definitions. */
+enum {
+	QL_ADAPTER_UP = 0,	/* Adapter has been brought up. */
+	QL_LEGACY_ENABLED = 1,
+	QL_MSI_ENABLED = 2,
+	QL_MSIX_ENABLED = 3,
+	QL_DMA64 = 4,
+	QL_PROMISCUOUS = 5,
+	QL_ALLMULTI = 6,
+	QL_PORT_CFG = 7,
+	QL_CAM_RT_SET = 8,
+	QL_SELFTEST = 9,
+	QL_LB_LINK_UP = 10,
+	QL_FRC_COREDUMP = 11,
+	QL_EEH_FATAL = 12,
+	QL_ASIC_RECOVERY = 14, /* We are in ascic recovery. */
+};
+
+/* link_status bit definitions */
+enum {
+	STS_LOOPBACK_MASK = 0x00000700,
+	STS_LOOPBACK_PCS = 0x00000100,
+	STS_LOOPBACK_HSS = 0x00000200,
+	STS_LOOPBACK_EXT = 0x00000300,
+	STS_PAUSE_MASK = 0x000000c0,
+	STS_PAUSE_STD = 0x00000040,
+	STS_PAUSE_PRI = 0x00000080,
+	STS_SPEED_MASK = 0x00000038,
+	STS_SPEED_100Mb = 0x00000000,
+	STS_SPEED_1Gb = 0x00000008,
+	STS_SPEED_10Gb = 0x00000010,
+	STS_LINK_TYPE_MASK = 0x00000007,
+	STS_LINK_TYPE_XFI = 0x00000001,
+	STS_LINK_TYPE_XAUI = 0x00000002,
+	STS_LINK_TYPE_XFI_BP = 0x00000003,
+	STS_LINK_TYPE_XAUI_BP = 0x00000004,
+	STS_LINK_TYPE_10GBASET = 0x00000005,
+};
+
+/* link_config bit definitions */
+enum {
+	CFG_JUMBO_FRAME_SIZE = 0x00010000,
+	CFG_PAUSE_MASK = 0x00000060,
+	CFG_PAUSE_STD = 0x00000020,
+	CFG_PAUSE_PRI = 0x00000040,
+	CFG_DCBX = 0x00000010,
+	CFG_LOOPBACK_MASK = 0x00000007,
+	CFG_LOOPBACK_PCS = 0x00000002,
+	CFG_LOOPBACK_HSS = 0x00000004,
+	CFG_LOOPBACK_EXT = 0x00000006,
+	CFG_DEFAULT_MAX_FRAME_SIZE = 0x00002580,
+};
+
+struct nic_operations {
+	int (*get_flash)(struct qlge_adapter *qdev);
+	int (*port_initialize)(struct qlge_adapter *qdev);
+};
+
+struct qlge_netdev_priv {
+	struct qlge_adapter *qdev;
+	struct net_device *ndev;
+};
+
+static inline
+struct qlge_adapter *netdev_to_qdev(struct net_device *ndev)
+{
+	struct qlge_netdev_priv *ndev_priv = netdev_priv(ndev);
+
+	return ndev_priv->qdev;
+}
+
+/*
+ * The main Adapter structure definition.
+ * This structure has all fields relevant to the hardware.
+ */
+struct qlge_adapter {
+	struct ricb ricb;
+	unsigned long flags;
+	u32 wol;
+
+	struct nic_stats nic_stats;
+
+	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+
+	/* PCI Configuration information for this device */
+	struct pci_dev *pdev;
+	struct net_device *ndev;	/* Parent NET device */
+
+	struct devlink_health_reporter *reporter;
+	/* Hardware information */
+	u32 chip_rev_id;
+	u32 fw_rev_id;
+	u32 func;		/* PCI function for this adapter */
+	u32 alt_func;		/* PCI function for alternate adapter */
+	u32 port;		/* Port number this adapter */
+
+	spinlock_t adapter_lock;
+	spinlock_t stats_lock;
+
+	/* PCI Bus Relative Register Addresses */
+	void __iomem *reg_base;
+	void __iomem *doorbell_area;
+	u32 doorbell_area_size;
+
+	u32 msg_enable;
+
+	/* Page for Shadow Registers */
+	void *rx_ring_shadow_reg_area;
+	dma_addr_t rx_ring_shadow_reg_dma;
+	void *tx_ring_shadow_reg_area;
+	dma_addr_t tx_ring_shadow_reg_dma;
+
+	u32 mailbox_in;
+	u32 mailbox_out;
+	struct mbox_params idc_mbc;
+	struct mutex	mpi_mutex;
+
+	int tx_ring_size;
+	int rx_ring_size;
+	u32 intr_count;
+	struct msix_entry *msi_x_entry;
+	struct intr_context intr_context[MAX_RX_RINGS];
+
+	int tx_ring_count;	/* One per online CPU. */
+	u32 rss_ring_count;	/* One per irq vector.  */
+	/*
+	 * rx_ring_count =
+	 *  (CPU count * outbound completion rx_ring) +
+	 *  (irq_vector_cnt * inbound (RSS) completion rx_ring)
+	 */
+	int rx_ring_count;
+	int ring_mem_size;
+	void *ring_mem;
+
+	struct rx_ring rx_ring[MAX_RX_RINGS];
+	struct tx_ring tx_ring[MAX_TX_RINGS];
+	unsigned int lbq_buf_order;
+	u32 lbq_buf_size;
+
+	int rx_csum;
+	u32 default_rx_queue;
+
+	u16 rx_coalesce_usecs;	/* cqicb->int_delay */
+	u16 rx_max_coalesced_frames;	/* cqicb->pkt_int_delay */
+	u16 tx_coalesce_usecs;	/* cqicb->int_delay */
+	u16 tx_max_coalesced_frames;	/* cqicb->pkt_int_delay */
+
+	u32 xg_sem_mask;
+	u32 port_link_up;
+	u32 port_init;
+	u32 link_status;
+	struct qlge_mpi_coredump *mpi_coredump;
+	u32 link_config;
+	u32 led_config;
+	u32 max_frame_size;
+
+	union flash_params flash;
+
+	struct workqueue_struct *workqueue;
+	struct delayed_work asic_reset_work;
+	struct delayed_work mpi_reset_work;
+	struct delayed_work mpi_work;
+	struct delayed_work mpi_port_cfg_work;
+	struct delayed_work mpi_idc_work;
+	struct completion ide_completion;
+	const struct nic_operations *nic_ops;
+	u16 device_id;
+	struct timer_list timer;
+	atomic_t lb_count;
+	/* Keep local copy of current mac address. */
+	char current_mac_addr[ETH_ALEN];
+};
+
+/*
+ * Typical Register accessor for memory mapped device.
+ */
+static inline u32 qlge_read32(const struct qlge_adapter *qdev, int reg)
+{
+	return readl(qdev->reg_base + reg);
+}
+
+/*
+ * Typical Register accessor for memory mapped device.
+ */
+static inline void qlge_write32(const struct qlge_adapter *qdev, int reg, u32 val)
+{
+	writel(val, qdev->reg_base + reg);
+}
+
+/*
+ * Doorbell Registers:
+ * Doorbell registers are virtual registers in the PCI memory space.
+ * The space is allocated by the chip during PCI initialization.  The
+ * device driver finds the doorbell address in BAR 3 in PCI config space.
+ * The registers are used to control outbound and inbound queues. For
+ * example, the producer index for an outbound queue.  Each queue uses
+ * 1 4k chunk of memory.  The lower half of the space is for outbound
+ * queues. The upper half is for inbound queues.
+ */
+static inline void qlge_write_db_reg(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+
+/*
+ * Doorbell Registers:
+ * Doorbell registers are virtual registers in the PCI memory space.
+ * The space is allocated by the chip during PCI initialization.  The
+ * device driver finds the doorbell address in BAR 3 in PCI config space.
+ * The registers are used to control outbound and inbound queues. For
+ * example, the producer index for an outbound queue.  Each queue uses
+ * 1 4k chunk of memory.  The lower half of the space is for outbound
+ * queues. The upper half is for inbound queues.
+ * Caller has to guarantee ordering.
+ */
+static inline void qlge_write_db_reg_relaxed(u32 val, void __iomem *addr)
+{
+	writel_relaxed(val, addr);
+}
+
+/*
+ * Shadow Registers:
+ * Outbound queues have a consumer index that is maintained by the chip.
+ * Inbound queues have a producer index that is maintained by the chip.
+ * For lower overhead, these registers are "shadowed" to host memory
+ * which allows the device driver to track the queue progress without
+ * PCI reads. When an entry is placed on an inbound queue, the chip will
+ * update the relevant index register and then copy the value to the
+ * shadow register in host memory.
+ */
+static inline u32 qlge_read_sh_reg(__le32  *addr)
+{
+	u32 reg;
+
+	reg =  le32_to_cpu(*addr);
+	rmb();
+	return reg;
+}
+
+extern char qlge_driver_name[];
+extern const char qlge_driver_version[];
+extern const struct ethtool_ops qlge_ethtool_ops;
+
+int qlge_sem_spinlock(struct qlge_adapter *qdev, u32 sem_mask);
+void qlge_sem_unlock(struct qlge_adapter *qdev, u32 sem_mask);
+int qlge_read_xgmac_reg(struct qlge_adapter *qdev, u32 reg, u32 *data);
+int qlge_get_mac_addr_reg(struct qlge_adapter *qdev, u32 type, u16 index,
+			  u32 *value);
+int qlge_get_routing_reg(struct qlge_adapter *qdev, u32 index, u32 *value);
+int qlge_write_cfg(struct qlge_adapter *qdev, void *ptr, int size, u32 bit,
+		   u16 q_id);
+void qlge_queue_fw_error(struct qlge_adapter *qdev);
+void qlge_mpi_work(struct work_struct *work);
+void qlge_mpi_reset_work(struct work_struct *work);
+int qlge_wait_reg_rdy(struct qlge_adapter *qdev, u32 reg, u32 bit, u32 ebit);
+void qlge_queue_asic_error(struct qlge_adapter *qdev);
+void qlge_set_ethtool_ops(struct net_device *ndev);
+int qlge_read_xgmac_reg64(struct qlge_adapter *qdev, u32 reg, u64 *data);
+void qlge_mpi_idc_work(struct work_struct *work);
+void qlge_mpi_port_cfg_work(struct work_struct *work);
+int qlge_mb_get_fw_state(struct qlge_adapter *qdev);
+int qlge_cam_route_initialize(struct qlge_adapter *qdev);
+int qlge_read_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 *data);
+int qlge_write_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 data);
+int qlge_unpause_mpi_risc(struct qlge_adapter *qdev);
+int qlge_pause_mpi_risc(struct qlge_adapter *qdev);
+int qlge_hard_reset_mpi_risc(struct qlge_adapter *qdev);
+int qlge_soft_reset_mpi_risc(struct qlge_adapter *qdev);
+int qlge_dump_risc_ram_area(struct qlge_adapter *qdev, void *buf, u32 ram_addr,
+			    int word_count);
+int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_coredump);
+int qlge_mb_about_fw(struct qlge_adapter *qdev);
+int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol);
+int qlge_mb_wol_mode(struct qlge_adapter *qdev, u32 wol);
+int qlge_mb_set_led_cfg(struct qlge_adapter *qdev, u32 led_config);
+int qlge_mb_get_led_cfg(struct qlge_adapter *qdev);
+void qlge_link_on(struct qlge_adapter *qdev);
+void qlge_link_off(struct qlge_adapter *qdev);
+int qlge_mb_set_mgmnt_traffic_ctl(struct qlge_adapter *qdev, u32 control);
+int qlge_mb_get_port_cfg(struct qlge_adapter *qdev);
+int qlge_mb_set_port_cfg(struct qlge_adapter *qdev);
+int qlge_wait_fifo_empty(struct qlge_adapter *qdev);
+void qlge_get_dump(struct qlge_adapter *qdev, void *buff);
+netdev_tx_t qlge_lb_send(struct sk_buff *skb, struct net_device *ndev);
+void qlge_check_lb_frame(struct qlge_adapter *qdev, struct sk_buff *skb);
+int qlge_own_firmware(struct qlge_adapter *qdev);
+int qlge_clean_lb_rx_ring(struct rx_ring *rx_ring, int budget);
+
+#endif /* _QLGE_H_ */
diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
new file mode 100644
index 000000000000..5f08a8492da4
--- /dev/null
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -0,0 +1,1311 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+
+#include "qlge.h"
+
+/* Read a NIC register from the alternate function. */
+static u32 qlge_read_other_func_reg(struct qlge_adapter *qdev,
+				    u32 reg)
+{
+	u32 register_to_read;
+	u32 reg_val;
+	unsigned int status = 0;
+
+	register_to_read = MPI_NIC_REG_BLOCK
+				| MPI_NIC_READ
+				| (qdev->alt_func << MPI_NIC_FUNCTION_SHIFT)
+				| reg;
+	status = qlge_read_mpi_reg(qdev, register_to_read, &reg_val);
+	if (status != 0)
+		return 0xffffffff;
+
+	return reg_val;
+}
+
+/* Write a NIC register from the alternate function. */
+static int qlge_write_other_func_reg(struct qlge_adapter *qdev,
+				     u32 reg, u32 reg_val)
+{
+	u32 register_to_read;
+
+	register_to_read = MPI_NIC_REG_BLOCK
+				| MPI_NIC_READ
+				| (qdev->alt_func << MPI_NIC_FUNCTION_SHIFT)
+				| reg;
+
+	return qlge_write_mpi_reg(qdev, register_to_read, reg_val);
+}
+
+static int qlge_wait_other_func_reg_rdy(struct qlge_adapter *qdev, u32 reg,
+					u32 bit, u32 err_bit)
+{
+	u32 temp;
+	int count;
+
+	for (count = 10; count; count--) {
+		temp = qlge_read_other_func_reg(qdev, reg);
+
+		/* check for errors */
+		if (temp & err_bit)
+			return -1;
+		else if (temp & bit)
+			return 0;
+		mdelay(10);
+	}
+	return -1;
+}
+
+static int qlge_read_other_func_serdes_reg(struct qlge_adapter *qdev, u32 reg,
+					   u32 *data)
+{
+	int status;
+
+	/* wait for reg to come ready */
+	status = qlge_wait_other_func_reg_rdy(qdev, XG_SERDES_ADDR / 4,
+					      XG_SERDES_ADDR_RDY, 0);
+	if (status)
+		goto exit;
+
+	/* set up for reg read */
+	qlge_write_other_func_reg(qdev, XG_SERDES_ADDR / 4, reg | PROC_ADDR_R);
+
+	/* wait for reg to come ready */
+	status = qlge_wait_other_func_reg_rdy(qdev, XG_SERDES_ADDR / 4,
+					      XG_SERDES_ADDR_RDY, 0);
+	if (status)
+		goto exit;
+
+	/* get the data */
+	*data = qlge_read_other_func_reg(qdev, (XG_SERDES_DATA / 4));
+exit:
+	return status;
+}
+
+/* Read out the SERDES registers */
+static int qlge_read_serdes_reg(struct qlge_adapter *qdev, u32 reg, u32 *data)
+{
+	int status;
+
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev, XG_SERDES_ADDR, XG_SERDES_ADDR_RDY, 0);
+	if (status)
+		goto exit;
+
+	/* set up for reg read */
+	qlge_write32(qdev, XG_SERDES_ADDR, reg | PROC_ADDR_R);
+
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev, XG_SERDES_ADDR, XG_SERDES_ADDR_RDY, 0);
+	if (status)
+		goto exit;
+
+	/* get the data */
+	*data = qlge_read32(qdev, XG_SERDES_DATA);
+exit:
+	return status;
+}
+
+static void qlge_get_both_serdes(struct qlge_adapter *qdev, u32 addr,
+				 u32 *direct_ptr, u32 *indirect_ptr,
+				 bool direct_valid, bool indirect_valid)
+{
+	unsigned int status;
+
+	status = 1;
+	if (direct_valid)
+		status = qlge_read_serdes_reg(qdev, addr, direct_ptr);
+	/* Dead fill any failures or invalids. */
+	if (status)
+		*direct_ptr = 0xDEADBEEF;
+
+	status = 1;
+	if (indirect_valid)
+		status = qlge_read_other_func_serdes_reg(qdev, addr,
+							 indirect_ptr);
+	/* Dead fill any failures or invalids. */
+	if (status)
+		*indirect_ptr = 0xDEADBEEF;
+}
+
+static int qlge_get_serdes_regs(struct qlge_adapter *qdev,
+				struct qlge_mpi_coredump *mpi_coredump)
+{
+	int status;
+	bool xfi_direct_valid = false, xfi_indirect_valid = false;
+	bool xaui_direct_valid = true, xaui_indirect_valid = true;
+	unsigned int i;
+	u32 *direct_ptr, temp;
+	u32 *indirect_ptr;
+
+	/* The XAUI needs to be read out per port */
+	status = qlge_read_other_func_serdes_reg(qdev,
+						 XG_SERDES_XAUI_HSS_PCS_START,
+						 &temp);
+	if (status)
+		temp = XG_SERDES_ADDR_XAUI_PWR_DOWN;
+
+	if ((temp & XG_SERDES_ADDR_XAUI_PWR_DOWN) ==
+				XG_SERDES_ADDR_XAUI_PWR_DOWN)
+		xaui_indirect_valid = false;
+
+	status = qlge_read_serdes_reg(qdev, XG_SERDES_XAUI_HSS_PCS_START, &temp);
+
+	if (status)
+		temp = XG_SERDES_ADDR_XAUI_PWR_DOWN;
+
+	if ((temp & XG_SERDES_ADDR_XAUI_PWR_DOWN) ==
+				XG_SERDES_ADDR_XAUI_PWR_DOWN)
+		xaui_direct_valid = false;
+
+	/*
+	 * XFI register is shared so only need to read one
+	 * functions and then check the bits.
+	 */
+	status = qlge_read_serdes_reg(qdev, XG_SERDES_ADDR_STS, &temp);
+	if (status)
+		temp = 0;
+
+	if ((temp & XG_SERDES_ADDR_XFI1_PWR_UP) ==
+					XG_SERDES_ADDR_XFI1_PWR_UP) {
+		/* now see if i'm NIC 1 or NIC 2 */
+		if (qdev->func & 1)
+			/* I'm NIC 2, so the indirect (NIC1) xfi is up. */
+			xfi_indirect_valid = true;
+		else
+			xfi_direct_valid = true;
+	}
+	if ((temp & XG_SERDES_ADDR_XFI2_PWR_UP) ==
+					XG_SERDES_ADDR_XFI2_PWR_UP) {
+		/* now see if i'm NIC 1 or NIC 2 */
+		if (qdev->func & 1)
+			/* I'm NIC 2, so the indirect (NIC1) xfi is up. */
+			xfi_direct_valid = true;
+		else
+			xfi_indirect_valid = true;
+	}
+
+	/* Get XAUI_AN register block. */
+	if (qdev->func & 1) {
+		/* Function 2 is direct	*/
+		direct_ptr = mpi_coredump->serdes2_xaui_an;
+		indirect_ptr = mpi_coredump->serdes_xaui_an;
+	} else {
+		/* Function 1 is direct	*/
+		direct_ptr = mpi_coredump->serdes_xaui_an;
+		indirect_ptr = mpi_coredump->serdes2_xaui_an;
+	}
+
+	for (i = 0; i <= 0x000000034; i += 4, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xaui_direct_valid, xaui_indirect_valid);
+
+	/* Get XAUI_HSS_PCS register block. */
+	if (qdev->func & 1) {
+		direct_ptr =
+			mpi_coredump->serdes2_xaui_hss_pcs;
+		indirect_ptr =
+			mpi_coredump->serdes_xaui_hss_pcs;
+	} else {
+		direct_ptr =
+			mpi_coredump->serdes_xaui_hss_pcs;
+		indirect_ptr =
+			mpi_coredump->serdes2_xaui_hss_pcs;
+	}
+
+	for (i = 0x800; i <= 0x880; i += 4, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xaui_direct_valid, xaui_indirect_valid);
+
+	/* Get XAUI_XFI_AN register block. */
+	if (qdev->func & 1) {
+		direct_ptr = mpi_coredump->serdes2_xfi_an;
+		indirect_ptr = mpi_coredump->serdes_xfi_an;
+	} else {
+		direct_ptr = mpi_coredump->serdes_xfi_an;
+		indirect_ptr = mpi_coredump->serdes2_xfi_an;
+	}
+
+	for (i = 0x1000; i <= 0x1034; i += 4, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xfi_direct_valid, xfi_indirect_valid);
+
+	/* Get XAUI_XFI_TRAIN register block. */
+	if (qdev->func & 1) {
+		direct_ptr = mpi_coredump->serdes2_xfi_train;
+		indirect_ptr =
+			mpi_coredump->serdes_xfi_train;
+	} else {
+		direct_ptr = mpi_coredump->serdes_xfi_train;
+		indirect_ptr =
+			mpi_coredump->serdes2_xfi_train;
+	}
+
+	for (i = 0x1050; i <= 0x107c; i += 4, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xfi_direct_valid, xfi_indirect_valid);
+
+	/* Get XAUI_XFI_HSS_PCS register block. */
+	if (qdev->func & 1) {
+		direct_ptr =
+			mpi_coredump->serdes2_xfi_hss_pcs;
+		indirect_ptr =
+			mpi_coredump->serdes_xfi_hss_pcs;
+	} else {
+		direct_ptr =
+			mpi_coredump->serdes_xfi_hss_pcs;
+		indirect_ptr =
+			mpi_coredump->serdes2_xfi_hss_pcs;
+	}
+
+	for (i = 0x1800; i <= 0x1838; i += 4, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xfi_direct_valid, xfi_indirect_valid);
+
+	/* Get XAUI_XFI_HSS_TX register block. */
+	if (qdev->func & 1) {
+		direct_ptr =
+			mpi_coredump->serdes2_xfi_hss_tx;
+		indirect_ptr =
+			mpi_coredump->serdes_xfi_hss_tx;
+	} else {
+		direct_ptr = mpi_coredump->serdes_xfi_hss_tx;
+		indirect_ptr =
+			mpi_coredump->serdes2_xfi_hss_tx;
+	}
+	for (i = 0x1c00; i <= 0x1c1f; i++, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xfi_direct_valid, xfi_indirect_valid);
+
+	/* Get XAUI_XFI_HSS_RX register block. */
+	if (qdev->func & 1) {
+		direct_ptr =
+			mpi_coredump->serdes2_xfi_hss_rx;
+		indirect_ptr =
+			mpi_coredump->serdes_xfi_hss_rx;
+	} else {
+		direct_ptr = mpi_coredump->serdes_xfi_hss_rx;
+		indirect_ptr =
+			mpi_coredump->serdes2_xfi_hss_rx;
+	}
+
+	for (i = 0x1c40; i <= 0x1c5f; i++, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xfi_direct_valid, xfi_indirect_valid);
+
+	/* Get XAUI_XFI_HSS_PLL register block. */
+	if (qdev->func & 1) {
+		direct_ptr =
+			mpi_coredump->serdes2_xfi_hss_pll;
+		indirect_ptr =
+			mpi_coredump->serdes_xfi_hss_pll;
+	} else {
+		direct_ptr =
+			mpi_coredump->serdes_xfi_hss_pll;
+		indirect_ptr =
+			mpi_coredump->serdes2_xfi_hss_pll;
+	}
+	for (i = 0x1e00; i <= 0x1e1f; i++, direct_ptr++, indirect_ptr++)
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+				     xfi_direct_valid, xfi_indirect_valid);
+	return 0;
+}
+
+static int qlge_read_other_func_xgmac_reg(struct qlge_adapter *qdev, u32 reg,
+					  u32 *data)
+{
+	int status = 0;
+
+	/* wait for reg to come ready */
+	status = qlge_wait_other_func_reg_rdy(qdev, XGMAC_ADDR / 4,
+					      XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
+	if (status)
+		goto exit;
+
+	/* set up for reg read */
+	qlge_write_other_func_reg(qdev, XGMAC_ADDR / 4, reg | XGMAC_ADDR_R);
+
+	/* wait for reg to come ready */
+	status = qlge_wait_other_func_reg_rdy(qdev, XGMAC_ADDR / 4,
+					      XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
+	if (status)
+		goto exit;
+
+	/* get the data */
+	*data = qlge_read_other_func_reg(qdev, XGMAC_DATA / 4);
+exit:
+	return status;
+}
+
+/* Read the 400 xgmac control/statistics registers
+ * skipping unused locations.
+ */
+static int qlge_get_xgmac_regs(struct qlge_adapter *qdev, u32 *buf,
+			       unsigned int other_function)
+{
+	int status = 0;
+	int i;
+
+	for (i = PAUSE_SRC_LO; i < XGMAC_REGISTER_END; i += 4, buf++) {
+		/* We're reading 400 xgmac registers, but we filter out
+		 * several locations that are non-responsive to reads.
+		 */
+		if ((i == 0x00000114) || (i == 0x00000118) ||
+		    (i == 0x0000013c) || (i == 0x00000140) ||
+		    (i > 0x00000150 && i < 0x000001fc) ||
+		    (i > 0x00000278 && i < 0x000002a0) ||
+		    (i > 0x000002c0 && i < 0x000002cf) ||
+		    (i > 0x000002dc && i < 0x000002f0) ||
+		    (i > 0x000003c8 && i < 0x00000400) ||
+		    (i > 0x00000400 && i < 0x00000410) ||
+		    (i > 0x00000410 && i < 0x00000420) ||
+		    (i > 0x00000420 && i < 0x00000430) ||
+		    (i > 0x00000430 && i < 0x00000440) ||
+		    (i > 0x00000440 && i < 0x00000450) ||
+		    (i > 0x00000450 && i < 0x00000500) ||
+		    (i > 0x0000054c && i < 0x00000568) ||
+		    (i > 0x000005c8 && i < 0x00000600)) {
+			if (other_function)
+				status = qlge_read_other_func_xgmac_reg(qdev, i, buf);
+			else
+				status = qlge_read_xgmac_reg(qdev, i, buf);
+
+			if (status)
+				*buf = 0xdeadbeef;
+			break;
+		}
+	}
+	return status;
+}
+
+static int qlge_get_ets_regs(struct qlge_adapter *qdev, u32 *buf)
+{
+	int i;
+
+	for (i = 0; i < 8; i++, buf++) {
+		qlge_write32(qdev, NIC_ETS, i << 29 | 0x08000000);
+		*buf = qlge_read32(qdev, NIC_ETS);
+	}
+
+	for (i = 0; i < 2; i++, buf++) {
+		qlge_write32(qdev, CNA_ETS, i << 29 | 0x08000000);
+		*buf = qlge_read32(qdev, CNA_ETS);
+	}
+
+	return 0;
+}
+
+static void qlge_get_intr_states(struct qlge_adapter *qdev, u32 *buf)
+{
+	int i;
+
+	for (i = 0; i < qdev->rx_ring_count; i++, buf++) {
+		qlge_write32(qdev, INTR_EN,
+			     qdev->intr_context[i].intr_read_mask);
+		*buf = qlge_read32(qdev, INTR_EN);
+	}
+}
+
+static int qlge_get_cam_entries(struct qlge_adapter *qdev, u32 *buf)
+{
+	int i, status;
+	u32 value[3];
+
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	if (status)
+		return status;
+
+	for (i = 0; i < 16; i++) {
+		status = qlge_get_mac_addr_reg(qdev,
+					       MAC_ADDR_TYPE_CAM_MAC, i, value);
+		if (status) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "Failed read of mac index register\n");
+			goto err;
+		}
+		*buf++ = value[0];	/* lower MAC address */
+		*buf++ = value[1];	/* upper MAC address */
+		*buf++ = value[2];	/* output */
+	}
+	for (i = 0; i < 32; i++) {
+		status = qlge_get_mac_addr_reg(qdev, MAC_ADDR_TYPE_MULTI_MAC,
+					       i, value);
+		if (status) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "Failed read of mac index register\n");
+			goto err;
+		}
+		*buf++ = value[0];	/* lower Mcast address */
+		*buf++ = value[1];	/* upper Mcast address */
+	}
+err:
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	return status;
+}
+
+static int qlge_get_routing_entries(struct qlge_adapter *qdev, u32 *buf)
+{
+	int status;
+	u32 value, i;
+
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	if (status)
+		return status;
+
+	for (i = 0; i < 16; i++) {
+		status = qlge_get_routing_reg(qdev, i, &value);
+		if (status) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "Failed read of routing index register\n");
+			goto err;
+		} else {
+			*buf++ = value;
+		}
+	}
+err:
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	return status;
+}
+
+/* Read the MPI Processor shadow registers */
+static int qlge_get_mpi_shadow_regs(struct qlge_adapter *qdev, u32 *buf)
+{
+	u32 i;
+	int status;
+
+	for (i = 0; i < MPI_CORE_SH_REGS_CNT; i++, buf++) {
+		status = qlge_write_mpi_reg(qdev,
+					    RISC_124,
+					    (SHADOW_OFFSET | i << SHADOW_REG_SHIFT));
+		if (status)
+			goto end;
+		status = qlge_read_mpi_reg(qdev, RISC_127, buf);
+		if (status)
+			goto end;
+	}
+end:
+	return status;
+}
+
+/* Read the MPI Processor core registers */
+static int qlge_get_mpi_regs(struct qlge_adapter *qdev, u32 *buf,
+			     u32 offset, u32 count)
+{
+	int i, status = 0;
+
+	for (i = 0; i < count; i++, buf++) {
+		status = qlge_read_mpi_reg(qdev, offset + i, buf);
+		if (status)
+			return status;
+	}
+	return status;
+}
+
+/* Read the ASIC probe dump */
+static unsigned int *qlge_get_probe(struct qlge_adapter *qdev, u32 clock,
+				    u32 valid, u32 *buf)
+{
+	u32 module, mux_sel, probe, lo_val, hi_val;
+
+	for (module = 0; module < PRB_MX_ADDR_MAX_MODS; module++) {
+		if (!((valid >> module) & 1))
+			continue;
+		for (mux_sel = 0; mux_sel < PRB_MX_ADDR_MAX_MUX; mux_sel++) {
+			probe = clock
+				| PRB_MX_ADDR_ARE
+				| mux_sel
+				| (module << PRB_MX_ADDR_MOD_SEL_SHIFT);
+			qlge_write32(qdev, PRB_MX_ADDR, probe);
+			lo_val = qlge_read32(qdev, PRB_MX_DATA);
+			if (mux_sel == 0) {
+				*buf = probe;
+				buf++;
+			}
+			probe |= PRB_MX_ADDR_UP;
+			qlge_write32(qdev, PRB_MX_ADDR, probe);
+			hi_val = qlge_read32(qdev, PRB_MX_DATA);
+			*buf = lo_val;
+			buf++;
+			*buf = hi_val;
+			buf++;
+		}
+	}
+	return buf;
+}
+
+static int qlge_get_probe_dump(struct qlge_adapter *qdev, unsigned int *buf)
+{
+	/* First we have to enable the probe mux */
+	qlge_write_mpi_reg(qdev, MPI_TEST_FUNC_PRB_CTL, MPI_TEST_FUNC_PRB_EN);
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_SYS_CLOCK,
+			     PRB_MX_ADDR_VALID_SYS_MOD, buf);
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_PCI_CLOCK,
+			     PRB_MX_ADDR_VALID_PCI_MOD, buf);
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_XGM_CLOCK,
+			     PRB_MX_ADDR_VALID_XGM_MOD, buf);
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_FC_CLOCK,
+			     PRB_MX_ADDR_VALID_FC_MOD, buf);
+	return 0;
+}
+
+/* Read out the routing index registers */
+static int qlge_get_routing_index_registers(struct qlge_adapter *qdev, u32 *buf)
+{
+	int status;
+	u32 type, index, index_max;
+	u32 result_index;
+	u32 result_data;
+	u32 val;
+
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	if (status)
+		return status;
+
+	for (type = 0; type < 4; type++) {
+		if (type < 2)
+			index_max = 8;
+		else
+			index_max = 16;
+		for (index = 0; index < index_max; index++) {
+			val = RT_IDX_RS
+				| (type << RT_IDX_TYPE_SHIFT)
+				| (index << RT_IDX_IDX_SHIFT);
+			qlge_write32(qdev, RT_IDX, val);
+			result_index = 0;
+			while ((result_index & RT_IDX_MR) == 0)
+				result_index = qlge_read32(qdev, RT_IDX);
+			result_data = qlge_read32(qdev, RT_DATA);
+			*buf = type;
+			buf++;
+			*buf = index;
+			buf++;
+			*buf = result_index;
+			buf++;
+			*buf = result_data;
+			buf++;
+		}
+	}
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	return status;
+}
+
+/* Read out the MAC protocol registers */
+static void qlge_get_mac_protocol_registers(struct qlge_adapter *qdev, u32 *buf)
+{
+	u32 result_index, result_data;
+	u32 type;
+	u32 index;
+	u32 offset;
+	u32 val;
+	u32 initial_val = MAC_ADDR_RS;
+	u32 max_index;
+	u32 max_offset;
+
+	for (type = 0; type < MAC_ADDR_TYPE_COUNT; type++) {
+		switch (type) {
+		case 0: /* CAM */
+			initial_val |= MAC_ADDR_ADR;
+			max_index = MAC_ADDR_MAX_CAM_ENTRIES;
+			max_offset = MAC_ADDR_MAX_CAM_WCOUNT;
+			break;
+		case 1: /* Multicast MAC Address */
+			max_index = MAC_ADDR_MAX_CAM_WCOUNT;
+			max_offset = MAC_ADDR_MAX_CAM_WCOUNT;
+			break;
+		case 2: /* VLAN filter mask */
+		case 3: /* MC filter mask */
+			max_index = MAC_ADDR_MAX_CAM_WCOUNT;
+			max_offset = MAC_ADDR_MAX_CAM_WCOUNT;
+			break;
+		case 4: /* FC MAC addresses */
+			max_index = MAC_ADDR_MAX_FC_MAC_ENTRIES;
+			max_offset = MAC_ADDR_MAX_FC_MAC_WCOUNT;
+			break;
+		case 5: /* Mgmt MAC addresses */
+			max_index = MAC_ADDR_MAX_MGMT_MAC_ENTRIES;
+			max_offset = MAC_ADDR_MAX_MGMT_MAC_WCOUNT;
+			break;
+		case 6: /* Mgmt VLAN addresses */
+			max_index = MAC_ADDR_MAX_MGMT_VLAN_ENTRIES;
+			max_offset = MAC_ADDR_MAX_MGMT_VLAN_WCOUNT;
+			break;
+		case 7: /* Mgmt IPv4 address */
+			max_index = MAC_ADDR_MAX_MGMT_V4_ENTRIES;
+			max_offset = MAC_ADDR_MAX_MGMT_V4_WCOUNT;
+			break;
+		case 8: /* Mgmt IPv6 address */
+			max_index = MAC_ADDR_MAX_MGMT_V6_ENTRIES;
+			max_offset = MAC_ADDR_MAX_MGMT_V6_WCOUNT;
+			break;
+		case 9: /* Mgmt TCP/UDP Dest port */
+			max_index = MAC_ADDR_MAX_MGMT_TU_DP_ENTRIES;
+			max_offset = MAC_ADDR_MAX_MGMT_TU_DP_WCOUNT;
+			break;
+		default:
+			netdev_err(qdev->ndev, "Bad type!!! 0x%08x\n", type);
+			max_index = 0;
+			max_offset = 0;
+			break;
+		}
+		for (index = 0; index < max_index; index++) {
+			for (offset = 0; offset < max_offset; offset++) {
+				val = initial_val
+					| (type << MAC_ADDR_TYPE_SHIFT)
+					| (index << MAC_ADDR_IDX_SHIFT)
+					| (offset);
+				qlge_write32(qdev, MAC_ADDR_IDX, val);
+				result_index = 0;
+				while ((result_index & MAC_ADDR_MR) == 0) {
+					result_index = qlge_read32(qdev,
+								   MAC_ADDR_IDX);
+				}
+				result_data = qlge_read32(qdev, MAC_ADDR_DATA);
+				*buf = result_index;
+				buf++;
+				*buf = result_data;
+				buf++;
+			}
+		}
+	}
+}
+
+static void qlge_get_sem_registers(struct qlge_adapter *qdev, u32 *buf)
+{
+	u32 func_num, reg, reg_val;
+	int status;
+
+	for (func_num = 0; func_num < MAX_SEMAPHORE_FUNCTIONS ; func_num++) {
+		reg = MPI_NIC_REG_BLOCK
+			| (func_num << MPI_NIC_FUNCTION_SHIFT)
+			| (SEM / 4);
+		status = qlge_read_mpi_reg(qdev, reg, &reg_val);
+		*buf = reg_val;
+		/* if the read failed then dead fill the element. */
+		if (!status)
+			*buf = 0xdeadbeef;
+		buf++;
+	}
+}
+
+/* Create a coredump segment header */
+static void qlge_build_coredump_seg_header(struct mpi_coredump_segment_header *seg_hdr,
+					   u32 seg_number, u32 seg_size, u8 *desc)
+{
+	memset(seg_hdr, 0, sizeof(struct mpi_coredump_segment_header));
+	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
+	seg_hdr->seg_num = seg_number;
+	seg_hdr->seg_size = seg_size;
+	strscpy(seg_hdr->description, desc, sizeof(seg_hdr->description));
+}
+
+/*
+ * This function should be called when a coredump / probedump
+ * is to be extracted from the HBA. It is assumed there is a
+ * qdev structure that contains the base address of the register
+ * space for this function as well as a coredump structure that
+ * will contain the dump.
+ */
+int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_coredump)
+{
+	int status;
+	int i;
+
+	if (!mpi_coredump) {
+		netif_err(qdev, drv, qdev->ndev, "No memory allocated\n");
+		return -EINVAL;
+	}
+
+	/* Try to get the spinlock, but dont worry if
+	 * it isn't available.  If the firmware died it
+	 * might be holding the sem.
+	 */
+	qlge_sem_spinlock(qdev, SEM_PROC_REG_MASK);
+
+	status = qlge_pause_mpi_risc(qdev);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed RISC pause. Status = 0x%.08x\n", status);
+		goto err;
+	}
+
+	/* Insert the global header */
+	memset(&mpi_coredump->mpi_global_header, 0,
+	       sizeof(struct mpi_coredump_global_header));
+	mpi_coredump->mpi_global_header.cookie = MPI_COREDUMP_COOKIE;
+	mpi_coredump->mpi_global_header.header_size =
+		sizeof(struct mpi_coredump_global_header);
+	mpi_coredump->mpi_global_header.image_size =
+		sizeof(struct qlge_mpi_coredump);
+	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
+		sizeof(mpi_coredump->mpi_global_header.id_string));
+
+	/* Get generic NIC reg dump */
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_regs_seg_hdr,
+				       NIC1_CONTROL_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->nic_regs), "NIC1 Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->nic2_regs_seg_hdr,
+				       NIC2_CONTROL_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->nic2_regs), "NIC2 Registers");
+
+	/* Get XGMac registers. (Segment 18, Rev C. step 21) */
+	qlge_build_coredump_seg_header(&mpi_coredump->xgmac1_seg_hdr,
+				       NIC1_XGMAC_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->xgmac1), "NIC1 XGMac Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xgmac2_seg_hdr,
+				       NIC2_XGMAC_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->xgmac2), "NIC2 XGMac Registers");
+
+	if (qdev->func & 1) {
+		/* Odd means our function is NIC 2 */
+		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
+			mpi_coredump->nic2_regs[i] =
+				qlge_read32(qdev, i * sizeof(u32));
+
+		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
+			mpi_coredump->nic_regs[i] =
+				qlge_read_other_func_reg(qdev, (i * sizeof(u32)) / 4);
+
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac2[0], 0);
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac1[0], 1);
+	} else {
+		/* Even means our function is NIC 1 */
+		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
+			mpi_coredump->nic_regs[i] =
+				qlge_read32(qdev, i * sizeof(u32));
+		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
+			mpi_coredump->nic2_regs[i] =
+				qlge_read_other_func_reg(qdev, (i * sizeof(u32)) / 4);
+
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac1[0], 0);
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac2[0], 1);
+	}
+
+	/* Rev C. Step 20a */
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui_an_hdr,
+				       XAUI_AN_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xaui_an),
+				       "XAUI AN Registers");
+
+	/* Rev C. Step 20b */
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui_hss_pcs_hdr,
+				       XAUI_HSS_PCS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xaui_hss_pcs),
+				       "XAUI HSS PCS Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_an_hdr, XFI_AN_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xfi_an),
+				       "XFI AN Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_train_hdr,
+				       XFI_TRAIN_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xfi_train),
+				       "XFI TRAIN Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_pcs_hdr,
+				       XFI_HSS_PCS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xfi_hss_pcs),
+				       "XFI HSS PCS Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_tx_hdr,
+				       XFI_HSS_TX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xfi_hss_tx),
+				       "XFI HSS TX Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_rx_hdr,
+				       XFI_HSS_RX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xfi_hss_rx),
+				       "XFI HSS RX Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_pll_hdr,
+				       XFI_HSS_PLL_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes_xfi_hss_pll),
+				       "XFI HSS PLL Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui2_an_hdr,
+				       XAUI2_AN_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xaui_an),
+				       "XAUI2 AN Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui2_hss_pcs_hdr,
+				       XAUI2_HSS_PCS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xaui_hss_pcs),
+				       "XAUI2 HSS PCS Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_an_hdr,
+				       XFI2_AN_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xfi_an),
+				       "XFI2 AN Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_train_hdr,
+				       XFI2_TRAIN_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xfi_train),
+				       "XFI2 TRAIN Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_pcs_hdr,
+				       XFI2_HSS_PCS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xfi_hss_pcs),
+				       "XFI2 HSS PCS Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_tx_hdr,
+				       XFI2_HSS_TX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xfi_hss_tx),
+				       "XFI2 HSS TX Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_rx_hdr,
+				       XFI2_HSS_RX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xfi_hss_rx),
+				       "XFI2 HSS RX Registers");
+
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_pll_hdr,
+				       XFI2_HSS_PLL_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->serdes2_xfi_hss_pll),
+				       "XFI2 HSS PLL Registers");
+
+	status = qlge_get_serdes_regs(qdev, mpi_coredump);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed Dump of Serdes Registers. Status = 0x%.08x\n",
+			  status);
+		goto err;
+	}
+
+	qlge_build_coredump_seg_header(&mpi_coredump->core_regs_seg_hdr,
+				       CORE_SEG_NUM,
+				       sizeof(mpi_coredump->core_regs_seg_hdr) +
+				       sizeof(mpi_coredump->mpi_core_regs) +
+				       sizeof(mpi_coredump->mpi_core_sh_regs),
+				       "Core Registers");
+
+	/* Get the MPI Core Registers */
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->mpi_core_regs[0],
+				   MPI_CORE_REGS_ADDR, MPI_CORE_REGS_CNT);
+	if (status)
+		goto err;
+	/* Get the 16 MPI shadow registers */
+	status = qlge_get_mpi_shadow_regs(qdev,
+					  &mpi_coredump->mpi_core_sh_regs[0]);
+	if (status)
+		goto err;
+
+	/* Get the Test Logic Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->test_logic_regs_seg_hdr,
+				       TEST_LOGIC_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->test_logic_regs),
+				       "Test Logic Regs");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->test_logic_regs[0],
+				   TEST_REGS_ADDR, TEST_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the RMII Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->rmii_regs_seg_hdr,
+				       RMII_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->rmii_regs),
+				       "RMII Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->rmii_regs[0],
+				   RMII_REGS_ADDR, RMII_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the FCMAC1 Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->fcmac1_regs_seg_hdr,
+				       FCMAC1_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->fcmac1_regs),
+				       "FCMAC1 Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fcmac1_regs[0],
+				   FCMAC1_REGS_ADDR, FCMAC_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the FCMAC2 Registers */
+
+	qlge_build_coredump_seg_header(&mpi_coredump->fcmac2_regs_seg_hdr,
+				       FCMAC2_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->fcmac2_regs),
+				       "FCMAC2 Registers");
+
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fcmac2_regs[0],
+				   FCMAC2_REGS_ADDR, FCMAC_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the FC1 MBX Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->fc1_mbx_regs_seg_hdr,
+				       FC1_MBOX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->fc1_mbx_regs),
+				       "FC1 MBox Regs");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fc1_mbx_regs[0],
+				   FC1_MBX_REGS_ADDR, FC_MBX_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the IDE Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->ide_regs_seg_hdr,
+				       IDE_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->ide_regs),
+				       "IDE Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->ide_regs[0],
+				   IDE_REGS_ADDR, IDE_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the NIC1 MBX Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->nic1_mbx_regs_seg_hdr,
+				       NIC1_MBOX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->nic1_mbx_regs),
+				       "NIC1 MBox Regs");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->nic1_mbx_regs[0],
+				   NIC1_MBX_REGS_ADDR, NIC_MBX_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the SMBus Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->smbus_regs_seg_hdr,
+				       SMBUS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->smbus_regs),
+				       "SMBus Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->smbus_regs[0],
+				   SMBUS_REGS_ADDR, SMBUS_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the FC2 MBX Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->fc2_mbx_regs_seg_hdr,
+				       FC2_MBOX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->fc2_mbx_regs),
+				       "FC2 MBox Regs");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fc2_mbx_regs[0],
+				   FC2_MBX_REGS_ADDR, FC_MBX_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the NIC2 MBX Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->nic2_mbx_regs_seg_hdr,
+				       NIC2_MBOX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->nic2_mbx_regs),
+				       "NIC2 MBox Regs");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->nic2_mbx_regs[0],
+				   NIC2_MBX_REGS_ADDR, NIC_MBX_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the I2C Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->i2c_regs_seg_hdr,
+				       I2C_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->i2c_regs),
+				       "I2C Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->i2c_regs[0],
+				   I2C_REGS_ADDR, I2C_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the MEMC Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->memc_regs_seg_hdr,
+				       MEMC_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->memc_regs),
+				       "MEMC Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->memc_regs[0],
+				   MEMC_REGS_ADDR, MEMC_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the PBus Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->pbus_regs_seg_hdr,
+				       PBUS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->pbus_regs),
+				       "PBUS Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->pbus_regs[0],
+				   PBUS_REGS_ADDR, PBUS_REGS_CNT);
+	if (status)
+		goto err;
+
+	/* Get the MDE Registers */
+	qlge_build_coredump_seg_header(&mpi_coredump->mde_regs_seg_hdr,
+				       MDE_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->mde_regs),
+				       "MDE Registers");
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->mde_regs[0],
+				   MDE_REGS_ADDR, MDE_REGS_CNT);
+	if (status)
+		goto err;
+
+	qlge_build_coredump_seg_header(&mpi_coredump->misc_nic_seg_hdr,
+				       MISC_NIC_INFO_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->misc_nic_info),
+				       "MISC NIC INFO");
+	mpi_coredump->misc_nic_info.rx_ring_count = qdev->rx_ring_count;
+	mpi_coredump->misc_nic_info.tx_ring_count = qdev->tx_ring_count;
+	mpi_coredump->misc_nic_info.intr_count = qdev->intr_count;
+	mpi_coredump->misc_nic_info.function = qdev->func;
+
+	/* Segment 31 */
+	/* Get indexed register values. */
+	qlge_build_coredump_seg_header(&mpi_coredump->intr_states_seg_hdr,
+				       INTR_STATES_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->intr_states),
+				       "INTR States");
+	qlge_get_intr_states(qdev, &mpi_coredump->intr_states[0]);
+
+	qlge_build_coredump_seg_header(&mpi_coredump->cam_entries_seg_hdr,
+				       CAM_ENTRIES_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->cam_entries),
+				       "CAM Entries");
+	status = qlge_get_cam_entries(qdev, &mpi_coredump->cam_entries[0]);
+	if (status)
+		goto err;
+
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_routing_words_seg_hdr,
+				       ROUTING_WORDS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->nic_routing_words),
+				       "Routing Words");
+	status = qlge_get_routing_entries(qdev,
+					  &mpi_coredump->nic_routing_words[0]);
+	if (status)
+		goto err;
+
+	/* Segment 34 (Rev C. step 23) */
+	qlge_build_coredump_seg_header(&mpi_coredump->ets_seg_hdr,
+				       ETS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->ets),
+				       "ETS Registers");
+	status = qlge_get_ets_regs(qdev, &mpi_coredump->ets[0]);
+	if (status)
+		goto err;
+
+	qlge_build_coredump_seg_header(&mpi_coredump->probe_dump_seg_hdr,
+				       PROBE_DUMP_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->probe_dump),
+				       "Probe Dump");
+	qlge_get_probe_dump(qdev, &mpi_coredump->probe_dump[0]);
+
+	qlge_build_coredump_seg_header(&mpi_coredump->routing_reg_seg_hdr,
+				       ROUTING_INDEX_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->routing_regs),
+				       "Routing Regs");
+	status = qlge_get_routing_index_registers(qdev,
+						  &mpi_coredump->routing_regs[0]);
+	if (status)
+		goto err;
+
+	qlge_build_coredump_seg_header(&mpi_coredump->mac_prot_reg_seg_hdr,
+				       MAC_PROTOCOL_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->mac_prot_regs),
+				       "MAC Prot Regs");
+	qlge_get_mac_protocol_registers(qdev, &mpi_coredump->mac_prot_regs[0]);
+
+	/* Get the semaphore registers for all 5 functions */
+	qlge_build_coredump_seg_header(&mpi_coredump->sem_regs_seg_hdr,
+				       SEM_REGS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header) +
+				       sizeof(mpi_coredump->sem_regs),	"Sem Registers");
+
+	qlge_get_sem_registers(qdev, &mpi_coredump->sem_regs[0]);
+
+	/* Prevent the mpi restarting while we dump the memory.*/
+	qlge_write_mpi_reg(qdev, MPI_TEST_FUNC_RST_STS, MPI_TEST_FUNC_RST_FRC);
+
+	/* clear the pause */
+	status = qlge_unpause_mpi_risc(qdev);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed RISC unpause. Status = 0x%.08x\n", status);
+		goto err;
+	}
+
+	/* Reset the RISC so we can dump RAM */
+	status = qlge_hard_reset_mpi_risc(qdev);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed RISC reset. Status = 0x%.08x\n", status);
+		goto err;
+	}
+
+	qlge_build_coredump_seg_header(&mpi_coredump->code_ram_seg_hdr,
+				       WCS_RAM_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->code_ram),
+				       "WCS RAM");
+	status = qlge_dump_risc_ram_area(qdev, &mpi_coredump->code_ram[0],
+					 CODE_RAM_ADDR, CODE_RAM_CNT);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed Dump of CODE RAM. Status = 0x%.08x\n",
+			  status);
+		goto err;
+	}
+
+	/* Insert the segment header */
+	qlge_build_coredump_seg_header(&mpi_coredump->memc_ram_seg_hdr,
+				       MEMC_RAM_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->memc_ram),
+				       "MEMC RAM");
+	status = qlge_dump_risc_ram_area(qdev, &mpi_coredump->memc_ram[0],
+					 MEMC_RAM_ADDR, MEMC_RAM_CNT);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed Dump of MEMC RAM. Status = 0x%.08x\n",
+			  status);
+		goto err;
+	}
+err:
+	qlge_sem_unlock(qdev, SEM_PROC_REG_MASK); /* does flush too */
+	return status;
+}
+
+static void qlge_get_core_dump(struct qlge_adapter *qdev)
+{
+	if (!qlge_own_firmware(qdev)) {
+		netif_err(qdev, drv, qdev->ndev, "Don't own firmware!\n");
+		return;
+	}
+
+	if (!netif_running(qdev->ndev)) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Force Coredump can only be done from interface that is up\n");
+		return;
+	}
+	qlge_queue_fw_error(qdev);
+}
+
+static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
+			      struct qlge_reg_dump *mpi_coredump)
+{
+	int i, status;
+
+	memset(&mpi_coredump->mpi_global_header, 0,
+	       sizeof(struct mpi_coredump_global_header));
+	mpi_coredump->mpi_global_header.cookie = MPI_COREDUMP_COOKIE;
+	mpi_coredump->mpi_global_header.header_size =
+		sizeof(struct mpi_coredump_global_header);
+	mpi_coredump->mpi_global_header.image_size =
+		sizeof(struct qlge_reg_dump);
+	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
+		sizeof(mpi_coredump->mpi_global_header.id_string));
+
+	/* segment 16 */
+	qlge_build_coredump_seg_header(&mpi_coredump->misc_nic_seg_hdr,
+				       MISC_NIC_INFO_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->misc_nic_info),
+				       "MISC NIC INFO");
+	mpi_coredump->misc_nic_info.rx_ring_count = qdev->rx_ring_count;
+	mpi_coredump->misc_nic_info.tx_ring_count = qdev->tx_ring_count;
+	mpi_coredump->misc_nic_info.intr_count = qdev->intr_count;
+	mpi_coredump->misc_nic_info.function = qdev->func;
+
+	/* Segment 16, Rev C. Step 18 */
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_regs_seg_hdr,
+				       NIC1_CONTROL_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->nic_regs),
+				       "NIC Registers");
+	/* Get generic reg dump */
+	for (i = 0; i < 64; i++)
+		mpi_coredump->nic_regs[i] = qlge_read32(qdev, i * sizeof(u32));
+
+	/* Segment 31 */
+	/* Get indexed register values. */
+	qlge_build_coredump_seg_header(&mpi_coredump->intr_states_seg_hdr,
+				       INTR_STATES_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->intr_states),
+				       "INTR States");
+	qlge_get_intr_states(qdev, &mpi_coredump->intr_states[0]);
+
+	qlge_build_coredump_seg_header(&mpi_coredump->cam_entries_seg_hdr,
+				       CAM_ENTRIES_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->cam_entries),
+				       "CAM Entries");
+	status = qlge_get_cam_entries(qdev, &mpi_coredump->cam_entries[0]);
+	if (status)
+		return;
+
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_routing_words_seg_hdr,
+				       ROUTING_WORDS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->nic_routing_words),
+				       "Routing Words");
+	status = qlge_get_routing_entries(qdev,
+					  &mpi_coredump->nic_routing_words[0]);
+	if (status)
+		return;
+
+	/* Segment 34 (Rev C. step 23) */
+	qlge_build_coredump_seg_header(&mpi_coredump->ets_seg_hdr,
+				       ETS_SEG_NUM,
+				       sizeof(struct mpi_coredump_segment_header)
+				       + sizeof(mpi_coredump->ets),
+				       "ETS Registers");
+	status = qlge_get_ets_regs(qdev, &mpi_coredump->ets[0]);
+	if (status)
+		return;
+}
+
+void qlge_get_dump(struct qlge_adapter *qdev, void *buff)
+{
+	/*
+	 * If the dump has already been taken and is stored
+	 * in our internal buffer and if force dump is set then
+	 * just start the spool to dump it to the log file
+	 * and also, take a snapshot of the general regs
+	 * to the user's buffer or else take complete dump
+	 * to the user's buffer if force is not set.
+	 */
+
+	if (!test_bit(QL_FRC_COREDUMP, &qdev->flags)) {
+		if (!qlge_core_dump(qdev, buff))
+			qlge_soft_reset_mpi_risc(qdev);
+		else
+			netif_err(qdev, drv, qdev->ndev, "coredump failed!\n");
+	} else {
+		qlge_gen_reg_dump(qdev, buff);
+		qlge_get_core_dump(qdev);
+	}
+}
diff --git a/drivers/staging/qlge/qlge_devlink.c b/drivers/staging/qlge/qlge_devlink.c
new file mode 100644
index 000000000000..0ab02d6d3817
--- /dev/null
+++ b/drivers/staging/qlge/qlge_devlink.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "qlge.h"
+#include "qlge_devlink.h"
+
+static int qlge_fill_seg_(struct devlink_fmsg *fmsg,
+			  struct mpi_coredump_segment_header *seg_header,
+			  u32 *reg_data)
+{
+	int regs_num = (seg_header->seg_size
+			- sizeof(struct mpi_coredump_segment_header)) / sizeof(u32);
+	int err;
+	int i;
+
+	err = devlink_fmsg_pair_nest_start(fmsg, seg_header->description);
+	if (err)
+		return err;
+	err = devlink_fmsg_obj_nest_start(fmsg);
+	if (err)
+		return err;
+	err = devlink_fmsg_u32_pair_put(fmsg, "segment", seg_header->seg_num);
+	if (err)
+		return err;
+	err = devlink_fmsg_arr_pair_nest_start(fmsg, "values");
+	if (err)
+		return err;
+	for (i = 0; i < regs_num; i++) {
+		err = devlink_fmsg_u32_put(fmsg, *reg_data);
+		if (err)
+			return err;
+		reg_data++;
+	}
+	err = devlink_fmsg_obj_nest_end(fmsg);
+	if (err)
+		return err;
+	err = devlink_fmsg_arr_pair_nest_end(fmsg);
+	if (err)
+		return err;
+	err = devlink_fmsg_pair_nest_end(fmsg);
+	return err;
+}
+
+#define FILL_SEG(seg_hdr, seg_regs)			                    \
+	do {                                                                \
+		err = qlge_fill_seg_(fmsg, &dump->seg_hdr, dump->seg_regs); \
+		if (err) {					            \
+			kvfree(dump);                                       \
+			return err;				            \
+		}                                                           \
+	} while (0)
+
+static int qlge_reporter_coredump(struct devlink_health_reporter *reporter,
+				  struct devlink_fmsg *fmsg, void *priv_ctx,
+				  struct netlink_ext_ack *extack)
+{
+	int err = 0;
+
+	struct qlge_adapter *qdev = devlink_health_reporter_priv(reporter);
+	struct qlge_mpi_coredump *dump;
+	wait_queue_head_t wait;
+
+	if (!netif_running(qdev->ndev))
+		return 0;
+
+	if (test_bit(QL_FRC_COREDUMP, &qdev->flags)) {
+		if (qlge_own_firmware(qdev)) {
+			qlge_queue_fw_error(qdev);
+			init_waitqueue_head(&wait);
+			wait_event_timeout(wait, 0, 5 * HZ);
+		} else {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Force Coredump failed because this NIC function doesn't own the firmware\n");
+			return -EPERM;
+		}
+	}
+
+	dump = kvmalloc(sizeof(*dump), GFP_KERNEL);
+	if (!dump)
+		return -ENOMEM;
+
+	err = qlge_core_dump(qdev, dump);
+	if (err) {
+		kvfree(dump);
+		return err;
+	}
+
+	qlge_soft_reset_mpi_risc(qdev);
+
+	FILL_SEG(core_regs_seg_hdr, mpi_core_regs);
+	FILL_SEG(test_logic_regs_seg_hdr, test_logic_regs);
+	FILL_SEG(rmii_regs_seg_hdr, rmii_regs);
+	FILL_SEG(fcmac1_regs_seg_hdr, fcmac1_regs);
+	FILL_SEG(fcmac2_regs_seg_hdr, fcmac2_regs);
+	FILL_SEG(fc1_mbx_regs_seg_hdr, fc1_mbx_regs);
+	FILL_SEG(ide_regs_seg_hdr, ide_regs);
+	FILL_SEG(nic1_mbx_regs_seg_hdr, nic1_mbx_regs);
+	FILL_SEG(smbus_regs_seg_hdr, smbus_regs);
+	FILL_SEG(fc2_mbx_regs_seg_hdr, fc2_mbx_regs);
+	FILL_SEG(nic2_mbx_regs_seg_hdr, nic2_mbx_regs);
+	FILL_SEG(i2c_regs_seg_hdr, i2c_regs);
+	FILL_SEG(memc_regs_seg_hdr, memc_regs);
+	FILL_SEG(pbus_regs_seg_hdr, pbus_regs);
+	FILL_SEG(mde_regs_seg_hdr, mde_regs);
+	FILL_SEG(nic_regs_seg_hdr, nic_regs);
+	FILL_SEG(nic2_regs_seg_hdr, nic2_regs);
+	FILL_SEG(xgmac1_seg_hdr, xgmac1);
+	FILL_SEG(xgmac2_seg_hdr, xgmac2);
+	FILL_SEG(code_ram_seg_hdr, code_ram);
+	FILL_SEG(memc_ram_seg_hdr, memc_ram);
+	FILL_SEG(xaui_an_hdr, serdes_xaui_an);
+	FILL_SEG(xaui_hss_pcs_hdr, serdes_xaui_hss_pcs);
+	FILL_SEG(xfi_an_hdr, serdes_xfi_an);
+	FILL_SEG(xfi_train_hdr, serdes_xfi_train);
+	FILL_SEG(xfi_hss_pcs_hdr, serdes_xfi_hss_pcs);
+	FILL_SEG(xfi_hss_tx_hdr, serdes_xfi_hss_tx);
+	FILL_SEG(xfi_hss_rx_hdr, serdes_xfi_hss_rx);
+	FILL_SEG(xfi_hss_pll_hdr, serdes_xfi_hss_pll);
+
+	err = qlge_fill_seg_(fmsg, &dump->misc_nic_seg_hdr,
+			     (u32 *)&dump->misc_nic_info);
+	if (err) {
+		kvfree(dump);
+		return err;
+	}
+
+	FILL_SEG(intr_states_seg_hdr, intr_states);
+	FILL_SEG(cam_entries_seg_hdr, cam_entries);
+	FILL_SEG(nic_routing_words_seg_hdr, nic_routing_words);
+	FILL_SEG(ets_seg_hdr, ets);
+	FILL_SEG(probe_dump_seg_hdr, probe_dump);
+	FILL_SEG(routing_reg_seg_hdr, routing_regs);
+	FILL_SEG(mac_prot_reg_seg_hdr, mac_prot_regs);
+	FILL_SEG(xaui2_an_hdr, serdes2_xaui_an);
+	FILL_SEG(xaui2_hss_pcs_hdr, serdes2_xaui_hss_pcs);
+	FILL_SEG(xfi2_an_hdr, serdes2_xfi_an);
+	FILL_SEG(xfi2_train_hdr, serdes2_xfi_train);
+	FILL_SEG(xfi2_hss_pcs_hdr, serdes2_xfi_hss_pcs);
+	FILL_SEG(xfi2_hss_tx_hdr, serdes2_xfi_hss_tx);
+	FILL_SEG(xfi2_hss_rx_hdr, serdes2_xfi_hss_rx);
+	FILL_SEG(xfi2_hss_pll_hdr, serdes2_xfi_hss_pll);
+	FILL_SEG(sem_regs_seg_hdr, sem_regs);
+
+	kvfree(dump);
+	return err;
+}
+
+static const struct devlink_health_reporter_ops qlge_reporter_ops = {
+	.name = "coredump",
+	.dump = qlge_reporter_coredump,
+};
+
+long qlge_health_create_reporters(struct qlge_adapter *priv)
+{
+	struct devlink *devlink;
+	long err = 0;
+
+	devlink = priv_to_devlink(priv);
+	priv->reporter =
+		devlink_health_reporter_create(devlink, &qlge_reporter_ops,
+					       0, priv);
+	if (IS_ERR(priv->reporter)) {
+		err = PTR_ERR(priv->reporter);
+		netdev_warn(priv->ndev,
+			    "Failed to create reporter, err = %ld\n",
+			    err);
+	}
+	return err;
+}
diff --git a/drivers/staging/qlge/qlge_devlink.h b/drivers/staging/qlge/qlge_devlink.h
new file mode 100644
index 000000000000..94538e923f2f
--- /dev/null
+++ b/drivers/staging/qlge/qlge_devlink.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QLGE_DEVLINK_H
+#define QLGE_DEVLINK_H
+
+#include <net/devlink.h>
+
+long qlge_health_create_reporters(struct qlge_adapter *priv);
+
+#endif /* QLGE_DEVLINK_H */
diff --git a/drivers/staging/qlge/qlge_ethtool.c b/drivers/staging/qlge/qlge_ethtool.c
new file mode 100644
index 000000000000..12efcd1057ba
--- /dev/null
+++ b/drivers/staging/qlge/qlge_ethtool.c
@@ -0,0 +1,746 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/pagemap.h>
+#include <linux/sched.h>
+#include <linux/dmapool.h>
+#include <linux/mempool.h>
+#include <linux/spinlock.h>
+#include <linux/kthread.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_vlan.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+
+#include "qlge.h"
+
+struct qlge_stats {
+	char stat_string[ETH_GSTRING_LEN];
+	int sizeof_stat;
+	int stat_offset;
+};
+
+#define QL_SIZEOF(m) sizeof_field(struct qlge_adapter, m)
+#define QL_OFF(m) offsetof(struct qlge_adapter, m)
+
+static const struct qlge_stats qlge_gstrings_stats[] = {
+	{"tx_pkts", QL_SIZEOF(nic_stats.tx_pkts), QL_OFF(nic_stats.tx_pkts)},
+	{"tx_bytes", QL_SIZEOF(nic_stats.tx_bytes), QL_OFF(nic_stats.tx_bytes)},
+	{"tx_mcast_pkts", QL_SIZEOF(nic_stats.tx_mcast_pkts),
+					QL_OFF(nic_stats.tx_mcast_pkts)},
+	{"tx_bcast_pkts", QL_SIZEOF(nic_stats.tx_bcast_pkts),
+					QL_OFF(nic_stats.tx_bcast_pkts)},
+	{"tx_ucast_pkts", QL_SIZEOF(nic_stats.tx_ucast_pkts),
+					QL_OFF(nic_stats.tx_ucast_pkts)},
+	{"tx_ctl_pkts", QL_SIZEOF(nic_stats.tx_ctl_pkts),
+					QL_OFF(nic_stats.tx_ctl_pkts)},
+	{"tx_pause_pkts", QL_SIZEOF(nic_stats.tx_pause_pkts),
+					QL_OFF(nic_stats.tx_pause_pkts)},
+	{"tx_64_pkts", QL_SIZEOF(nic_stats.tx_64_pkt),
+					QL_OFF(nic_stats.tx_64_pkt)},
+	{"tx_65_to_127_pkts", QL_SIZEOF(nic_stats.tx_65_to_127_pkt),
+					QL_OFF(nic_stats.tx_65_to_127_pkt)},
+	{"tx_128_to_255_pkts", QL_SIZEOF(nic_stats.tx_128_to_255_pkt),
+					QL_OFF(nic_stats.tx_128_to_255_pkt)},
+	{"tx_256_511_pkts", QL_SIZEOF(nic_stats.tx_256_511_pkt),
+					QL_OFF(nic_stats.tx_256_511_pkt)},
+	{"tx_512_to_1023_pkts",	QL_SIZEOF(nic_stats.tx_512_to_1023_pkt),
+					QL_OFF(nic_stats.tx_512_to_1023_pkt)},
+	{"tx_1024_to_1518_pkts", QL_SIZEOF(nic_stats.tx_1024_to_1518_pkt),
+					QL_OFF(nic_stats.tx_1024_to_1518_pkt)},
+	{"tx_1519_to_max_pkts",	QL_SIZEOF(nic_stats.tx_1519_to_max_pkt),
+					QL_OFF(nic_stats.tx_1519_to_max_pkt)},
+	{"tx_undersize_pkts", QL_SIZEOF(nic_stats.tx_undersize_pkt),
+					QL_OFF(nic_stats.tx_undersize_pkt)},
+	{"tx_oversize_pkts", QL_SIZEOF(nic_stats.tx_oversize_pkt),
+					QL_OFF(nic_stats.tx_oversize_pkt)},
+	{"rx_bytes", QL_SIZEOF(nic_stats.rx_bytes), QL_OFF(nic_stats.rx_bytes)},
+	{"rx_bytes_ok",	QL_SIZEOF(nic_stats.rx_bytes_ok),
+					QL_OFF(nic_stats.rx_bytes_ok)},
+	{"rx_pkts", QL_SIZEOF(nic_stats.rx_pkts), QL_OFF(nic_stats.rx_pkts)},
+	{"rx_pkts_ok", QL_SIZEOF(nic_stats.rx_pkts_ok),
+					QL_OFF(nic_stats.rx_pkts_ok)},
+	{"rx_bcast_pkts", QL_SIZEOF(nic_stats.rx_bcast_pkts),
+					QL_OFF(nic_stats.rx_bcast_pkts)},
+	{"rx_mcast_pkts", QL_SIZEOF(nic_stats.rx_mcast_pkts),
+					QL_OFF(nic_stats.rx_mcast_pkts)},
+	{"rx_ucast_pkts", QL_SIZEOF(nic_stats.rx_ucast_pkts),
+					QL_OFF(nic_stats.rx_ucast_pkts)},
+	{"rx_undersize_pkts", QL_SIZEOF(nic_stats.rx_undersize_pkts),
+					QL_OFF(nic_stats.rx_undersize_pkts)},
+	{"rx_oversize_pkts", QL_SIZEOF(nic_stats.rx_oversize_pkts),
+					QL_OFF(nic_stats.rx_oversize_pkts)},
+	{"rx_jabber_pkts", QL_SIZEOF(nic_stats.rx_jabber_pkts),
+					QL_OFF(nic_stats.rx_jabber_pkts)},
+	{"rx_undersize_fcerr_pkts",
+		QL_SIZEOF(nic_stats.rx_undersize_fcerr_pkts),
+				QL_OFF(nic_stats.rx_undersize_fcerr_pkts)},
+	{"rx_drop_events", QL_SIZEOF(nic_stats.rx_drop_events),
+					QL_OFF(nic_stats.rx_drop_events)},
+	{"rx_fcerr_pkts", QL_SIZEOF(nic_stats.rx_fcerr_pkts),
+					QL_OFF(nic_stats.rx_fcerr_pkts)},
+	{"rx_align_err", QL_SIZEOF(nic_stats.rx_align_err),
+					QL_OFF(nic_stats.rx_align_err)},
+	{"rx_symbol_err", QL_SIZEOF(nic_stats.rx_symbol_err),
+					QL_OFF(nic_stats.rx_symbol_err)},
+	{"rx_mac_err", QL_SIZEOF(nic_stats.rx_mac_err),
+					QL_OFF(nic_stats.rx_mac_err)},
+	{"rx_ctl_pkts",	QL_SIZEOF(nic_stats.rx_ctl_pkts),
+					QL_OFF(nic_stats.rx_ctl_pkts)},
+	{"rx_pause_pkts", QL_SIZEOF(nic_stats.rx_pause_pkts),
+					QL_OFF(nic_stats.rx_pause_pkts)},
+	{"rx_64_pkts", QL_SIZEOF(nic_stats.rx_64_pkts),
+					QL_OFF(nic_stats.rx_64_pkts)},
+	{"rx_65_to_127_pkts", QL_SIZEOF(nic_stats.rx_65_to_127_pkts),
+					QL_OFF(nic_stats.rx_65_to_127_pkts)},
+	{"rx_128_255_pkts", QL_SIZEOF(nic_stats.rx_128_255_pkts),
+					QL_OFF(nic_stats.rx_128_255_pkts)},
+	{"rx_256_511_pkts", QL_SIZEOF(nic_stats.rx_256_511_pkts),
+					QL_OFF(nic_stats.rx_256_511_pkts)},
+	{"rx_512_to_1023_pkts",	QL_SIZEOF(nic_stats.rx_512_to_1023_pkts),
+					QL_OFF(nic_stats.rx_512_to_1023_pkts)},
+	{"rx_1024_to_1518_pkts", QL_SIZEOF(nic_stats.rx_1024_to_1518_pkts),
+					QL_OFF(nic_stats.rx_1024_to_1518_pkts)},
+	{"rx_1519_to_max_pkts",	QL_SIZEOF(nic_stats.rx_1519_to_max_pkts),
+					QL_OFF(nic_stats.rx_1519_to_max_pkts)},
+	{"rx_len_err_pkts", QL_SIZEOF(nic_stats.rx_len_err_pkts),
+					QL_OFF(nic_stats.rx_len_err_pkts)},
+	{"rx_code_err",	QL_SIZEOF(nic_stats.rx_code_err),
+					QL_OFF(nic_stats.rx_code_err)},
+	{"rx_oversize_err", QL_SIZEOF(nic_stats.rx_oversize_err),
+					QL_OFF(nic_stats.rx_oversize_err)},
+	{"rx_undersize_err", QL_SIZEOF(nic_stats.rx_undersize_err),
+					QL_OFF(nic_stats.rx_undersize_err)},
+	{"rx_preamble_err", QL_SIZEOF(nic_stats.rx_preamble_err),
+					QL_OFF(nic_stats.rx_preamble_err)},
+	{"rx_frame_len_err", QL_SIZEOF(nic_stats.rx_frame_len_err),
+					QL_OFF(nic_stats.rx_frame_len_err)},
+	{"rx_crc_err", QL_SIZEOF(nic_stats.rx_crc_err),
+					QL_OFF(nic_stats.rx_crc_err)},
+	{"rx_err_count", QL_SIZEOF(nic_stats.rx_err_count),
+					QL_OFF(nic_stats.rx_err_count)},
+	{"tx_cbfc_pause_frames0", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames0),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames0)},
+	{"tx_cbfc_pause_frames1", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames1),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames1)},
+	{"tx_cbfc_pause_frames2", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames2),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames2)},
+	{"tx_cbfc_pause_frames3", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames3),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames3)},
+	{"tx_cbfc_pause_frames4", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames4),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames4)},
+	{"tx_cbfc_pause_frames5", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames5),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames5)},
+	{"tx_cbfc_pause_frames6", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames6),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames6)},
+	{"tx_cbfc_pause_frames7", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames7),
+				QL_OFF(nic_stats.tx_cbfc_pause_frames7)},
+	{"rx_cbfc_pause_frames0", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames0),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames0)},
+	{"rx_cbfc_pause_frames1", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames1),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames1)},
+	{"rx_cbfc_pause_frames2", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames2),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames2)},
+	{"rx_cbfc_pause_frames3", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames3),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames3)},
+	{"rx_cbfc_pause_frames4", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames4),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames4)},
+	{"rx_cbfc_pause_frames5", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames5),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames5)},
+	{"rx_cbfc_pause_frames6", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames6),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames6)},
+	{"rx_cbfc_pause_frames7", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames7),
+				QL_OFF(nic_stats.rx_cbfc_pause_frames7)},
+	{"rx_nic_fifo_drop", QL_SIZEOF(nic_stats.rx_nic_fifo_drop),
+					QL_OFF(nic_stats.rx_nic_fifo_drop)},
+};
+
+static const char qlge_gstrings_test[][ETH_GSTRING_LEN] = {
+	"Loopback test  (offline)"
+};
+
+#define QLGE_TEST_LEN (sizeof(qlge_gstrings_test) / ETH_GSTRING_LEN)
+#define QLGE_STATS_LEN ARRAY_SIZE(qlge_gstrings_stats)
+#define QLGE_RCV_MAC_ERR_STATS	7
+
+static int qlge_update_ring_coalescing(struct qlge_adapter *qdev)
+{
+	int i, status = 0;
+	struct rx_ring *rx_ring;
+	struct cqicb *cqicb;
+
+	if (!netif_running(qdev->ndev))
+		return status;
+
+	/* Skip the default queue, and update the outbound handler
+	 * queues if they changed.
+	 */
+	cqicb = (struct cqicb *)&qdev->rx_ring[qdev->rss_ring_count];
+	if (le16_to_cpu(cqicb->irq_delay) != qdev->tx_coalesce_usecs ||
+	    le16_to_cpu(cqicb->pkt_delay) != qdev->tx_max_coalesced_frames) {
+		for (i = qdev->rss_ring_count; i < qdev->rx_ring_count; i++) {
+			rx_ring = &qdev->rx_ring[i];
+			cqicb = (struct cqicb *)rx_ring;
+			cqicb->irq_delay = cpu_to_le16(qdev->tx_coalesce_usecs);
+			cqicb->pkt_delay =
+				cpu_to_le16(qdev->tx_max_coalesced_frames);
+			cqicb->flags = FLAGS_LI;
+			status = qlge_write_cfg(qdev, cqicb, sizeof(*cqicb),
+						CFG_LCQ, rx_ring->cq_id);
+			if (status) {
+				netif_err(qdev, ifup, qdev->ndev,
+					  "Failed to load CQICB.\n");
+				goto exit;
+			}
+		}
+	}
+
+	/* Update the inbound (RSS) handler queues if they changed. */
+	cqicb = (struct cqicb *)&qdev->rx_ring[0];
+	if (le16_to_cpu(cqicb->irq_delay) != qdev->rx_coalesce_usecs ||
+	    le16_to_cpu(cqicb->pkt_delay) != qdev->rx_max_coalesced_frames) {
+		for (i = 0; i < qdev->rss_ring_count; i++, rx_ring++) {
+			rx_ring = &qdev->rx_ring[i];
+			cqicb = (struct cqicb *)rx_ring;
+			cqicb->irq_delay = cpu_to_le16(qdev->rx_coalesce_usecs);
+			cqicb->pkt_delay =
+				cpu_to_le16(qdev->rx_max_coalesced_frames);
+			cqicb->flags = FLAGS_LI;
+			status = qlge_write_cfg(qdev, cqicb, sizeof(*cqicb),
+						CFG_LCQ, rx_ring->cq_id);
+			if (status) {
+				netif_err(qdev, ifup, qdev->ndev,
+					  "Failed to load CQICB.\n");
+				goto exit;
+			}
+		}
+	}
+exit:
+	return status;
+}
+
+static void qlge_update_stats(struct qlge_adapter *qdev)
+{
+	u32 i;
+	u64 data;
+	u64 *iter = &qdev->nic_stats.tx_pkts;
+
+	spin_lock(&qdev->stats_lock);
+	if (qlge_sem_spinlock(qdev, qdev->xg_sem_mask)) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Couldn't get xgmac sem.\n");
+		goto quit;
+	}
+	/*
+	 * Get TX statistics.
+	 */
+	for (i = 0x200; i < 0x280; i += 8) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "Error reading status register 0x%.04x.\n",
+				  i);
+			goto end;
+		} else {
+			*iter = data;
+		}
+		iter++;
+	}
+
+	/*
+	 * Get RX statistics.
+	 */
+	for (i = 0x300; i < 0x3d0; i += 8) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "Error reading status register 0x%.04x.\n",
+				  i);
+			goto end;
+		} else {
+			*iter = data;
+		}
+		iter++;
+	}
+
+	/* Update receive mac error statistics */
+	iter += QLGE_RCV_MAC_ERR_STATS;
+
+	/*
+	 * Get Per-priority TX pause frame counter statistics.
+	 */
+	for (i = 0x500; i < 0x540; i += 8) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "Error reading status register 0x%.04x.\n",
+				  i);
+			goto end;
+		} else {
+			*iter = data;
+		}
+		iter++;
+	}
+
+	/*
+	 * Get Per-priority RX pause frame counter statistics.
+	 */
+	for (i = 0x568; i < 0x5a8; i += 8) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "Error reading status register 0x%.04x.\n",
+				  i);
+			goto end;
+		} else {
+			*iter = data;
+		}
+		iter++;
+	}
+
+	/*
+	 * Get RX NIC FIFO DROP statistics.
+	 */
+	if (qlge_read_xgmac_reg64(qdev, 0x5b8, &data)) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Error reading status register 0x%.04x.\n", i);
+		goto end;
+	} else {
+		*iter = data;
+	}
+end:
+	qlge_sem_unlock(qdev, qdev->xg_sem_mask);
+quit:
+	spin_unlock(&qdev->stats_lock);
+}
+
+static void qlge_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	int index;
+
+	switch (stringset) {
+	case ETH_SS_TEST:
+		memcpy(buf, *qlge_gstrings_test, QLGE_TEST_LEN * ETH_GSTRING_LEN);
+		break;
+	case ETH_SS_STATS:
+		for (index = 0; index < QLGE_STATS_LEN; index++) {
+			memcpy(buf + index * ETH_GSTRING_LEN,
+			       qlge_gstrings_stats[index].stat_string,
+			       ETH_GSTRING_LEN);
+		}
+		break;
+	}
+}
+
+static int qlge_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_TEST:
+		return QLGE_TEST_LEN;
+	case ETH_SS_STATS:
+		return QLGE_STATS_LEN;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void
+qlge_get_ethtool_stats(struct net_device *ndev,
+		       struct ethtool_stats *stats, u64 *data)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	int index, length;
+
+	length = QLGE_STATS_LEN;
+	qlge_update_stats(qdev);
+
+	for (index = 0; index < length; index++) {
+		char *p = (char *)qdev +
+			qlge_gstrings_stats[index].stat_offset;
+		*data++ = (qlge_gstrings_stats[index].sizeof_stat ==
+			   sizeof(u64)) ? *(u64 *)p : (*(u32 *)p);
+	}
+}
+
+static int qlge_get_link_ksettings(struct net_device *ndev,
+				   struct ethtool_link_ksettings *ecmd)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	u32 supported, advertising;
+
+	supported = SUPPORTED_10000baseT_Full;
+	advertising = ADVERTISED_10000baseT_Full;
+
+	if ((qdev->link_status & STS_LINK_TYPE_MASK) ==
+	    STS_LINK_TYPE_10GBASET) {
+		supported |= (SUPPORTED_TP | SUPPORTED_Autoneg);
+		advertising |= (ADVERTISED_TP | ADVERTISED_Autoneg);
+		ecmd->base.port = PORT_TP;
+		ecmd->base.autoneg = AUTONEG_ENABLE;
+	} else {
+		supported |= SUPPORTED_FIBRE;
+		advertising |= ADVERTISED_FIBRE;
+		ecmd->base.port = PORT_FIBRE;
+	}
+
+	ecmd->base.speed = SPEED_10000;
+	ecmd->base.duplex = DUPLEX_FULL;
+
+	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
+						supported);
+	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.advertising,
+						advertising);
+
+	return 0;
+}
+
+static void qlge_get_drvinfo(struct net_device *ndev,
+			     struct ethtool_drvinfo *drvinfo)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	strscpy(drvinfo->driver, qlge_driver_name, sizeof(drvinfo->driver));
+	strscpy(drvinfo->version, qlge_driver_version,
+		sizeof(drvinfo->version));
+	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+		 "v%d.%d.%d",
+		 (qdev->fw_rev_id & 0x00ff0000) >> 16,
+		 (qdev->fw_rev_id & 0x0000ff00) >> 8,
+		 (qdev->fw_rev_id & 0x000000ff));
+	strscpy(drvinfo->bus_info, pci_name(qdev->pdev),
+		sizeof(drvinfo->bus_info));
+}
+
+static void qlge_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	unsigned short ssys_dev = qdev->pdev->subsystem_device;
+
+	/* WOL is only supported for mezz card. */
+	if (ssys_dev == QLGE_MEZZ_SSYS_ID_068 ||
+	    ssys_dev == QLGE_MEZZ_SSYS_ID_180) {
+		wol->supported = WAKE_MAGIC;
+		wol->wolopts = qdev->wol;
+	}
+}
+
+static int qlge_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	unsigned short ssys_dev = qdev->pdev->subsystem_device;
+
+	/* WOL is only supported for mezz card. */
+	if (ssys_dev != QLGE_MEZZ_SSYS_ID_068 &&
+	    ssys_dev != QLGE_MEZZ_SSYS_ID_180) {
+		netif_info(qdev, drv, qdev->ndev,
+			   "WOL is only supported for mezz card\n");
+		return -EOPNOTSUPP;
+	}
+	if (wol->wolopts & ~WAKE_MAGIC)
+		return -EINVAL;
+	qdev->wol = wol->wolopts;
+
+	netif_info(qdev, drv, qdev->ndev, "Set wol option 0x%x\n", qdev->wol);
+	return 0;
+}
+
+static int qlge_set_phys_id(struct net_device *ndev,
+			    enum ethtool_phys_id_state state)
+
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		/* Save the current LED settings */
+		if (qlge_mb_get_led_cfg(qdev))
+			return -EIO;
+
+		/* Start blinking */
+		qlge_mb_set_led_cfg(qdev, QL_LED_BLINK);
+		return 0;
+
+	case ETHTOOL_ID_INACTIVE:
+		/* Restore LED settings */
+		if (qlge_mb_set_led_cfg(qdev, qdev->led_config))
+			return -EIO;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int qlge_start_loopback(struct qlge_adapter *qdev)
+{
+	if (netif_carrier_ok(qdev->ndev)) {
+		set_bit(QL_LB_LINK_UP, &qdev->flags);
+		netif_carrier_off(qdev->ndev);
+	} else {
+		clear_bit(QL_LB_LINK_UP, &qdev->flags);
+	}
+	qdev->link_config |= CFG_LOOPBACK_PCS;
+	return qlge_mb_set_port_cfg(qdev);
+}
+
+static void qlge_stop_loopback(struct qlge_adapter *qdev)
+{
+	qdev->link_config &= ~CFG_LOOPBACK_PCS;
+	qlge_mb_set_port_cfg(qdev);
+	if (test_bit(QL_LB_LINK_UP, &qdev->flags)) {
+		netif_carrier_on(qdev->ndev);
+		clear_bit(QL_LB_LINK_UP, &qdev->flags);
+	}
+}
+
+static void qlge_create_lb_frame(struct sk_buff *skb,
+				 unsigned int frame_size)
+{
+	memset(skb->data, 0xFF, frame_size);
+	frame_size &= ~1;
+	memset(&skb->data[frame_size / 2], 0xAA, frame_size / 2 - 1);
+	skb->data[frame_size / 2 + 10] = (unsigned char)0xBE;
+	skb->data[frame_size / 2 + 12] = (unsigned char)0xAF;
+}
+
+void qlge_check_lb_frame(struct qlge_adapter *qdev,
+			 struct sk_buff *skb)
+{
+	unsigned int frame_size = skb->len;
+
+	if ((*(skb->data + 3) == 0xFF) &&
+	    (*(skb->data + frame_size / 2 + 10) == 0xBE) &&
+	    (*(skb->data + frame_size / 2 + 12) == 0xAF)) {
+		atomic_dec(&qdev->lb_count);
+		return;
+	}
+}
+
+static int qlge_run_loopback_test(struct qlge_adapter *qdev)
+{
+	int i;
+	netdev_tx_t rc;
+	struct sk_buff *skb;
+	unsigned int size = SMALL_BUF_MAP_SIZE;
+
+	for (i = 0; i < 64; i++) {
+		skb = netdev_alloc_skb(qdev->ndev, size);
+		if (!skb)
+			return -ENOMEM;
+
+		skb->queue_mapping = 0;
+		skb_put(skb, size);
+		qlge_create_lb_frame(skb, size);
+		rc = qlge_lb_send(skb, qdev->ndev);
+		if (rc != NETDEV_TX_OK)
+			return -EPIPE;
+		atomic_inc(&qdev->lb_count);
+	}
+	/* Give queue time to settle before testing results. */
+	usleep_range(2000, 2100);
+	qlge_clean_lb_rx_ring(&qdev->rx_ring[0], 128);
+	return atomic_read(&qdev->lb_count) ? -EIO : 0;
+}
+
+static int qlge_loopback_test(struct qlge_adapter *qdev, u64 *data)
+{
+	*data = qlge_start_loopback(qdev);
+	if (*data)
+		goto out;
+	*data = qlge_run_loopback_test(qdev);
+out:
+	qlge_stop_loopback(qdev);
+	return *data;
+}
+
+static void qlge_self_test(struct net_device *ndev,
+			   struct ethtool_test *eth_test, u64 *data)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	memset(data, 0, sizeof(u64) * QLGE_TEST_LEN);
+
+	if (netif_running(ndev)) {
+		set_bit(QL_SELFTEST, &qdev->flags);
+		if (eth_test->flags == ETH_TEST_FL_OFFLINE) {
+			/* Offline tests */
+			if (qlge_loopback_test(qdev, &data[0]))
+				eth_test->flags |= ETH_TEST_FL_FAILED;
+
+		} else {
+			/* Online tests */
+			data[0] = 0;
+		}
+		clear_bit(QL_SELFTEST, &qdev->flags);
+		/* Give link time to come up after
+		 * port configuration changes.
+		 */
+		msleep_interruptible(4 * 1000);
+	} else {
+		netif_err(qdev, drv, qdev->ndev,
+			  "is down, Loopback test will fail.\n");
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+	}
+}
+
+static int qlge_get_regs_len(struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	if (!test_bit(QL_FRC_COREDUMP, &qdev->flags))
+		return sizeof(struct qlge_mpi_coredump);
+	else
+		return sizeof(struct qlge_reg_dump);
+}
+
+static void qlge_get_regs(struct net_device *ndev,
+			  struct ethtool_regs *regs, void *p)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	qlge_get_dump(qdev, p);
+	if (!test_bit(QL_FRC_COREDUMP, &qdev->flags))
+		regs->len = sizeof(struct qlge_mpi_coredump);
+	else
+		regs->len = sizeof(struct qlge_reg_dump);
+}
+
+static int qlge_get_coalesce(struct net_device *ndev,
+			     struct ethtool_coalesce *c,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	c->rx_coalesce_usecs = qdev->rx_coalesce_usecs;
+	c->tx_coalesce_usecs = qdev->tx_coalesce_usecs;
+
+	/* This chip coalesces as follows:
+	 * If a packet arrives, hold off interrupts until
+	 * cqicb->int_delay expires, but if no other packets arrive don't
+	 * wait longer than cqicb->pkt_int_delay. But ethtool doesn't use a
+	 * timer to coalesce on a frame basis.  So, we have to take ethtool's
+	 * max_coalesced_frames value and convert it to a delay in microseconds.
+	 * We do this by using a basic thoughput of 1,000,000 frames per
+	 * second @ (1024 bytes).  This means one frame per usec. So it's a
+	 * simple one to one ratio.
+	 */
+	c->rx_max_coalesced_frames = qdev->rx_max_coalesced_frames;
+	c->tx_max_coalesced_frames = qdev->tx_max_coalesced_frames;
+
+	return 0;
+}
+
+static int qlge_set_coalesce(struct net_device *ndev,
+			     struct ethtool_coalesce *c,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	/* Validate user parameters. */
+	if (c->rx_coalesce_usecs > qdev->rx_ring_size / 2)
+		return -EINVAL;
+	/* Don't wait more than 10 usec. */
+	if (c->rx_max_coalesced_frames > MAX_INTER_FRAME_WAIT)
+		return -EINVAL;
+	if (c->tx_coalesce_usecs > qdev->tx_ring_size / 2)
+		return -EINVAL;
+	if (c->tx_max_coalesced_frames > MAX_INTER_FRAME_WAIT)
+		return -EINVAL;
+
+	/* Verify a change took place before updating the hardware. */
+	if (qdev->rx_coalesce_usecs == c->rx_coalesce_usecs &&
+	    qdev->tx_coalesce_usecs == c->tx_coalesce_usecs &&
+	    qdev->rx_max_coalesced_frames == c->rx_max_coalesced_frames &&
+	    qdev->tx_max_coalesced_frames == c->tx_max_coalesced_frames)
+		return 0;
+
+	qdev->rx_coalesce_usecs = c->rx_coalesce_usecs;
+	qdev->tx_coalesce_usecs = c->tx_coalesce_usecs;
+	qdev->rx_max_coalesced_frames = c->rx_max_coalesced_frames;
+	qdev->tx_max_coalesced_frames = c->tx_max_coalesced_frames;
+
+	return qlge_update_ring_coalescing(qdev);
+}
+
+static void qlge_get_pauseparam(struct net_device *ndev,
+				struct ethtool_pauseparam *pause)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	qlge_mb_get_port_cfg(qdev);
+	if (qdev->link_config & CFG_PAUSE_STD) {
+		pause->rx_pause = 1;
+		pause->tx_pause = 1;
+	}
+}
+
+static int qlge_set_pauseparam(struct net_device *ndev,
+			       struct ethtool_pauseparam *pause)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	if ((pause->rx_pause) && (pause->tx_pause))
+		qdev->link_config |= CFG_PAUSE_STD;
+	else if (!pause->rx_pause && !pause->tx_pause)
+		qdev->link_config &= ~CFG_PAUSE_STD;
+	else
+		return -EINVAL;
+
+	return qlge_mb_set_port_cfg(qdev);
+}
+
+static u32 qlge_get_msglevel(struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	return qdev->msg_enable;
+}
+
+static void qlge_set_msglevel(struct net_device *ndev, u32 value)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	qdev->msg_enable = value;
+}
+
+const struct ethtool_ops qlge_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES,
+	.get_drvinfo = qlge_get_drvinfo,
+	.get_wol = qlge_get_wol,
+	.set_wol = qlge_set_wol,
+	.get_regs_len	= qlge_get_regs_len,
+	.get_regs = qlge_get_regs,
+	.get_msglevel = qlge_get_msglevel,
+	.set_msglevel = qlge_set_msglevel,
+	.get_link = ethtool_op_get_link,
+	.set_phys_id		 = qlge_set_phys_id,
+	.self_test		 = qlge_self_test,
+	.get_pauseparam		 = qlge_get_pauseparam,
+	.set_pauseparam		 = qlge_set_pauseparam,
+	.get_coalesce = qlge_get_coalesce,
+	.set_coalesce = qlge_set_coalesce,
+	.get_sset_count = qlge_get_sset_count,
+	.get_strings = qlge_get_strings,
+	.get_ethtool_stats = qlge_get_ethtool_stats,
+	.get_link_ksettings = qlge_get_link_ksettings,
+};
+
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
new file mode 100644
index 000000000000..1ead7793062a
--- /dev/null
+++ b/drivers/staging/qlge/qlge_main.c
@@ -0,0 +1,4845 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * QLogic qlge NIC HBA Driver
+ * Copyright (c)  2003-2008 QLogic Corporation
+ * Author:     Linux qlge network device driver by
+ *                      Ron Mercer <ron.mercer@qlogic.com>
+ */
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/pagemap.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/dmapool.h>
+#include <linux/mempool.h>
+#include <linux/spinlock.h>
+#include <linux/kthread.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/if_vlan.h>
+#include <linux/skbuff.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/prefetch.h>
+#include <net/ip6_checksum.h>
+
+#include "qlge.h"
+#include "qlge_devlink.h"
+
+char qlge_driver_name[] = DRV_NAME;
+const char qlge_driver_version[] = DRV_VERSION;
+
+MODULE_AUTHOR("Ron Mercer <ron.mercer@qlogic.com>");
+MODULE_DESCRIPTION(DRV_STRING " ");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+static const u32 default_msg =
+	NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK |
+	NETIF_MSG_IFDOWN |
+	NETIF_MSG_IFUP |
+	NETIF_MSG_RX_ERR |
+	NETIF_MSG_TX_ERR |
+	NETIF_MSG_HW | NETIF_MSG_WOL | 0;
+
+static int debug = -1;	/* defaults above */
+module_param(debug, int, 0664);
+MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
+
+#define MSIX_IRQ 0
+#define MSI_IRQ 1
+#define LEG_IRQ 2
+static int qlge_irq_type = MSIX_IRQ;
+module_param(qlge_irq_type, int, 0664);
+MODULE_PARM_DESC(qlge_irq_type, "0 = MSI-X, 1 = MSI, 2 = Legacy.");
+
+static int qlge_mpi_coredump;
+module_param(qlge_mpi_coredump, int, 0);
+MODULE_PARM_DESC(qlge_mpi_coredump,
+		 "Option to enable MPI firmware dump. Default is OFF - Do Not allocate memory. ");
+
+static int qlge_force_coredump;
+module_param(qlge_force_coredump, int, 0);
+MODULE_PARM_DESC(qlge_force_coredump,
+		 "Option to allow force of firmware core dump. Default is OFF - Do not allow.");
+
+static const struct pci_device_id qlge_pci_tbl[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_QLOGIC, QLGE_DEVICE_ID_8012)},
+	{PCI_DEVICE(PCI_VENDOR_ID_QLOGIC, QLGE_DEVICE_ID_8000)},
+	/* required last entry */
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, qlge_pci_tbl);
+
+static int qlge_wol(struct qlge_adapter *);
+static void qlge_set_multicast_list(struct net_device *);
+static int qlge_adapter_down(struct qlge_adapter *);
+static int qlge_adapter_up(struct qlge_adapter *);
+
+/* This hardware semaphore causes exclusive access to
+ * resources shared between the NIC driver, MPI firmware,
+ * FCOE firmware and the FC driver.
+ */
+static int qlge_sem_trylock(struct qlge_adapter *qdev, u32 sem_mask)
+{
+	u32 sem_bits = 0;
+
+	switch (sem_mask) {
+	case SEM_XGMAC0_MASK:
+		sem_bits = SEM_SET << SEM_XGMAC0_SHIFT;
+		break;
+	case SEM_XGMAC1_MASK:
+		sem_bits = SEM_SET << SEM_XGMAC1_SHIFT;
+		break;
+	case SEM_ICB_MASK:
+		sem_bits = SEM_SET << SEM_ICB_SHIFT;
+		break;
+	case SEM_MAC_ADDR_MASK:
+		sem_bits = SEM_SET << SEM_MAC_ADDR_SHIFT;
+		break;
+	case SEM_FLASH_MASK:
+		sem_bits = SEM_SET << SEM_FLASH_SHIFT;
+		break;
+	case SEM_PROBE_MASK:
+		sem_bits = SEM_SET << SEM_PROBE_SHIFT;
+		break;
+	case SEM_RT_IDX_MASK:
+		sem_bits = SEM_SET << SEM_RT_IDX_SHIFT;
+		break;
+	case SEM_PROC_REG_MASK:
+		sem_bits = SEM_SET << SEM_PROC_REG_SHIFT;
+		break;
+	default:
+		netif_alert(qdev, probe, qdev->ndev, "bad Semaphore mask!.\n");
+		return -EINVAL;
+	}
+
+	qlge_write32(qdev, SEM, sem_bits | sem_mask);
+	return !(qlge_read32(qdev, SEM) & sem_bits);
+}
+
+int qlge_sem_spinlock(struct qlge_adapter *qdev, u32 sem_mask)
+{
+	unsigned int wait_count = 30;
+
+	do {
+		if (!qlge_sem_trylock(qdev, sem_mask))
+			return 0;
+		udelay(100);
+	} while (--wait_count);
+	return -ETIMEDOUT;
+}
+
+void qlge_sem_unlock(struct qlge_adapter *qdev, u32 sem_mask)
+{
+	qlge_write32(qdev, SEM, sem_mask);
+	qlge_read32(qdev, SEM);	/* flush */
+}
+
+/* This function waits for a specific bit to come ready
+ * in a given register.  It is used mostly by the initialize
+ * process, but is also used in kernel thread API such as
+ * netdev->set_multi, netdev->set_mac_address, netdev->vlan_rx_add_vid.
+ */
+int qlge_wait_reg_rdy(struct qlge_adapter *qdev, u32 reg, u32 bit, u32 err_bit)
+{
+	u32 temp;
+	int count;
+
+	for (count = 0; count < UDELAY_COUNT; count++) {
+		temp = qlge_read32(qdev, reg);
+
+		/* check for errors */
+		if (temp & err_bit) {
+			netif_alert(qdev, probe, qdev->ndev,
+				    "register 0x%.08x access error, value = 0x%.08x!.\n",
+				    reg, temp);
+			return -EIO;
+		} else if (temp & bit) {
+			return 0;
+		}
+		udelay(UDELAY_DELAY);
+	}
+	netif_alert(qdev, probe, qdev->ndev,
+		    "Timed out waiting for reg %x to come ready.\n", reg);
+	return -ETIMEDOUT;
+}
+
+/* The CFG register is used to download TX and RX control blocks
+ * to the chip. This function waits for an operation to complete.
+ */
+static int qlge_wait_cfg(struct qlge_adapter *qdev, u32 bit)
+{
+	int count;
+	u32 temp;
+
+	for (count = 0; count < UDELAY_COUNT; count++) {
+		temp = qlge_read32(qdev, CFG);
+		if (temp & CFG_LE)
+			return -EIO;
+		if (!(temp & bit))
+			return 0;
+		udelay(UDELAY_DELAY);
+	}
+	return -ETIMEDOUT;
+}
+
+/* Used to issue init control blocks to hw. Maps control block,
+ * sets address, triggers download, waits for completion.
+ */
+int qlge_write_cfg(struct qlge_adapter *qdev, void *ptr, int size, u32 bit,
+		   u16 q_id)
+{
+	u64 map;
+	int status = 0;
+	int direction;
+	u32 mask;
+	u32 value;
+
+	if (bit & (CFG_LRQ | CFG_LR | CFG_LCQ))
+		direction = DMA_TO_DEVICE;
+	else
+		direction = DMA_FROM_DEVICE;
+
+	map = dma_map_single(&qdev->pdev->dev, ptr, size, direction);
+	if (dma_mapping_error(&qdev->pdev->dev, map)) {
+		netif_err(qdev, ifup, qdev->ndev, "Couldn't map DMA area.\n");
+		return -ENOMEM;
+	}
+
+	status = qlge_sem_spinlock(qdev, SEM_ICB_MASK);
+	if (status)
+		goto lock_failed;
+
+	status = qlge_wait_cfg(qdev, bit);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Timed out waiting for CFG to come ready.\n");
+		goto exit;
+	}
+
+	qlge_write32(qdev, ICB_L, (u32)map);
+	qlge_write32(qdev, ICB_H, (u32)(map >> 32));
+
+	mask = CFG_Q_MASK | (bit << 16);
+	value = bit | (q_id << CFG_Q_SHIFT);
+	qlge_write32(qdev, CFG, (mask | value));
+
+	/*
+	 * Wait for the bit to clear after signaling hw.
+	 */
+	status = qlge_wait_cfg(qdev, bit);
+exit:
+	qlge_sem_unlock(qdev, SEM_ICB_MASK);	/* does flush too */
+lock_failed:
+	dma_unmap_single(&qdev->pdev->dev, map, size, direction);
+	return status;
+}
+
+/* Get a specific MAC address from the CAM.  Used for debug and reg dump. */
+int qlge_get_mac_addr_reg(struct qlge_adapter *qdev, u32 type, u16 index,
+			  u32 *value)
+{
+	u32 offset = 0;
+	int status;
+
+	switch (type) {
+	case MAC_ADDR_TYPE_MULTI_MAC:
+	case MAC_ADDR_TYPE_CAM_MAC: {
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     (offset++) | /* offset */
+				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
+				   MAC_ADDR_ADR | MAC_ADDR_RS |
+				   type); /* type */
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MR, 0);
+		if (status)
+			break;
+		*value++ = qlge_read32(qdev, MAC_ADDR_DATA);
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     (offset++) | /* offset */
+				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
+				   MAC_ADDR_ADR | MAC_ADDR_RS |
+				   type); /* type */
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MR, 0);
+		if (status)
+			break;
+		*value++ = qlge_read32(qdev, MAC_ADDR_DATA);
+		if (type == MAC_ADDR_TYPE_CAM_MAC) {
+			status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX,
+						   MAC_ADDR_MW, 0);
+			if (status)
+				break;
+			qlge_write32(qdev, MAC_ADDR_IDX,
+				     (offset++) | /* offset */
+					   (index
+					    << MAC_ADDR_IDX_SHIFT) | /* index */
+					   MAC_ADDR_ADR |
+					   MAC_ADDR_RS | type); /* type */
+			status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX,
+						   MAC_ADDR_MR, 0);
+			if (status)
+				break;
+			*value++ = qlge_read32(qdev, MAC_ADDR_DATA);
+		}
+		break;
+	}
+	case MAC_ADDR_TYPE_VLAN:
+	case MAC_ADDR_TYPE_MULTI_FLTR:
+	default:
+		netif_crit(qdev, ifup, qdev->ndev,
+			   "Address type %d not yet supported.\n", type);
+		status = -EPERM;
+	}
+	return status;
+}
+
+/* Set up a MAC, multicast or VLAN address for the
+ * inbound frame matching.
+ */
+static int qlge_set_mac_addr_reg(struct qlge_adapter *qdev, const u8 *addr,
+				 u32 type, u16 index)
+{
+	u32 offset = 0;
+	int status = 0;
+
+	switch (type) {
+	case MAC_ADDR_TYPE_MULTI_MAC: {
+		u32 upper = (addr[0] << 8) | addr[1];
+		u32 lower = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) |
+			    (addr[5]);
+
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     (offset++) | (index << MAC_ADDR_IDX_SHIFT) | type |
+				   MAC_ADDR_E);
+		qlge_write32(qdev, MAC_ADDR_DATA, lower);
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     (offset++) | (index << MAC_ADDR_IDX_SHIFT) | type |
+				   MAC_ADDR_E);
+
+		qlge_write32(qdev, MAC_ADDR_DATA, upper);
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		break;
+	}
+	case MAC_ADDR_TYPE_CAM_MAC: {
+		u32 cam_output;
+		u32 upper = (addr[0] << 8) | addr[1];
+		u32 lower = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) |
+			    (addr[5]);
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     (offset++) | /* offset */
+				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
+				   type); /* type */
+		qlge_write32(qdev, MAC_ADDR_DATA, lower);
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     (offset++) | /* offset */
+				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
+				   type); /* type */
+		qlge_write32(qdev, MAC_ADDR_DATA, upper);
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     (offset) | /* offset */
+				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
+				   type); /* type */
+		/* This field should also include the queue id
+		 * and possibly the function id.  Right now we hardcode
+		 * the route field to NIC core.
+		 */
+		cam_output = (CAM_OUT_ROUTE_NIC |
+			      (qdev->func << CAM_OUT_FUNC_SHIFT) |
+			      (0 << CAM_OUT_CQ_ID_SHIFT));
+		if (qdev->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)
+			cam_output |= CAM_OUT_RV;
+		/* route to NIC core */
+		qlge_write32(qdev, MAC_ADDR_DATA, cam_output);
+		break;
+	}
+	case MAC_ADDR_TYPE_VLAN: {
+		u32 enable_bit = *((u32 *)&addr[0]);
+		/* For VLAN, the addr actually holds a bit that
+		 * either enables or disables the vlan id we are
+		 * addressing. It's either MAC_ADDR_E on or off.
+		 * That's bit-27 we're talking about.
+		 */
+		status = qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+		if (status)
+			break;
+		qlge_write32(qdev, MAC_ADDR_IDX,
+			     offset | /* offset */
+				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
+				   type | /* type */
+				   enable_bit); /* enable/disable */
+		break;
+	}
+	case MAC_ADDR_TYPE_MULTI_FLTR:
+	default:
+		netif_crit(qdev, ifup, qdev->ndev,
+			   "Address type %d not yet supported.\n", type);
+		status = -EPERM;
+	}
+	return status;
+}
+
+/* Set or clear MAC address in hardware. We sometimes
+ * have to clear it to prevent wrong frame routing
+ * especially in a bonding environment.
+ */
+static int qlge_set_mac_addr(struct qlge_adapter *qdev, int set)
+{
+	int status;
+	char zero_mac_addr[ETH_ALEN];
+	char *addr;
+
+	if (set) {
+		addr = &qdev->current_mac_addr[0];
+		netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
+			     "Set Mac addr %pM\n", addr);
+	} else {
+		eth_zero_addr(zero_mac_addr);
+		addr = &zero_mac_addr[0];
+		netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
+			     "Clearing MAC address\n");
+	}
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	if (status)
+		return status;
+	status = qlge_set_mac_addr_reg(qdev, (const u8 *)addr,
+				       MAC_ADDR_TYPE_CAM_MAC,
+				       qdev->func * MAX_CQ);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	if (status)
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to init mac address.\n");
+	return status;
+}
+
+void qlge_link_on(struct qlge_adapter *qdev)
+{
+	netif_err(qdev, link, qdev->ndev, "Link is up.\n");
+	netif_carrier_on(qdev->ndev);
+	qlge_set_mac_addr(qdev, 1);
+}
+
+void qlge_link_off(struct qlge_adapter *qdev)
+{
+	netif_err(qdev, link, qdev->ndev, "Link is down.\n");
+	netif_carrier_off(qdev->ndev);
+	qlge_set_mac_addr(qdev, 0);
+}
+
+/* Get a specific frame routing value from the CAM.
+ * Used for debug and reg dump.
+ */
+int qlge_get_routing_reg(struct qlge_adapter *qdev, u32 index, u32 *value)
+{
+	int status = 0;
+
+	status = qlge_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MW, 0);
+	if (status)
+		goto exit;
+
+	qlge_write32(qdev, RT_IDX,
+		     RT_IDX_TYPE_NICQ | RT_IDX_RS | (index << RT_IDX_IDX_SHIFT));
+	status = qlge_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MR, 0);
+	if (status)
+		goto exit;
+	*value = qlge_read32(qdev, RT_DATA);
+exit:
+	return status;
+}
+
+/* The NIC function for this chip has 16 routing indexes.  Each one can be used
+ * to route different frame types to various inbound queues.  We send broadcast/
+ * multicast/error frames to the default queue for slow handling,
+ * and CAM hit/RSS frames to the fast handling queues.
+ */
+static int qlge_set_routing_reg(struct qlge_adapter *qdev, u32 index, u32 mask,
+				int enable)
+{
+	int status = -EINVAL; /* Return error if no mask match. */
+	u32 value = 0;
+
+	switch (mask) {
+	case RT_IDX_CAM_HIT:
+		{
+			value = RT_IDX_DST_CAM_Q |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (RT_IDX_CAM_HIT_SLOT << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	case RT_IDX_VALID:	/* Promiscuous Mode frames. */
+		{
+			value = RT_IDX_DST_DFLT_Q |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (RT_IDX_PROMISCUOUS_SLOT << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	case RT_IDX_ERR:	/* Pass up MAC,IP,TCP/UDP error frames. */
+		{
+			value = RT_IDX_DST_DFLT_Q |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (RT_IDX_ALL_ERR_SLOT << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	case RT_IDX_IP_CSUM_ERR: /* Pass up IP CSUM error frames. */
+		{
+			value = RT_IDX_DST_DFLT_Q | /* dest */
+				RT_IDX_TYPE_NICQ | /* type */
+				(RT_IDX_IP_CSUM_ERR_SLOT <<
+				RT_IDX_IDX_SHIFT); /* index */
+			break;
+		}
+	case RT_IDX_TU_CSUM_ERR: /* Pass up TCP/UDP CSUM error frames. */
+		{
+			value = RT_IDX_DST_DFLT_Q | /* dest */
+				RT_IDX_TYPE_NICQ | /* type */
+				(RT_IDX_TCP_UDP_CSUM_ERR_SLOT <<
+				RT_IDX_IDX_SHIFT); /* index */
+			break;
+		}
+	case RT_IDX_BCAST:	/* Pass up Broadcast frames to default Q. */
+		{
+			value = RT_IDX_DST_DFLT_Q |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (RT_IDX_BCAST_SLOT << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	case RT_IDX_MCAST:	/* Pass up All Multicast frames. */
+		{
+			value = RT_IDX_DST_DFLT_Q |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (RT_IDX_ALLMULTI_SLOT << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	case RT_IDX_MCAST_MATCH:	/* Pass up matched Multicast frames. */
+		{
+			value = RT_IDX_DST_DFLT_Q |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (RT_IDX_MCAST_MATCH_SLOT << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	case RT_IDX_RSS_MATCH:	/* Pass up matched RSS frames. */
+		{
+			value = RT_IDX_DST_RSS |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (RT_IDX_RSS_MATCH_SLOT << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	case 0:		/* Clear the E-bit on an entry. */
+		{
+			value = RT_IDX_DST_DFLT_Q |	/* dest */
+			    RT_IDX_TYPE_NICQ |	/* type */
+			    (index << RT_IDX_IDX_SHIFT);/* index */
+			break;
+		}
+	default:
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Mask type %d not yet supported.\n", mask);
+		status = -EPERM;
+		goto exit;
+	}
+
+	if (value) {
+		status = qlge_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MW, 0);
+		if (status)
+			goto exit;
+		value |= (enable ? RT_IDX_E : 0);
+		qlge_write32(qdev, RT_IDX, value);
+		qlge_write32(qdev, RT_DATA, enable ? mask : 0);
+	}
+exit:
+	return status;
+}
+
+static void qlge_enable_interrupts(struct qlge_adapter *qdev)
+{
+	qlge_write32(qdev, INTR_EN, (INTR_EN_EI << 16) | INTR_EN_EI);
+}
+
+static void qlge_disable_interrupts(struct qlge_adapter *qdev)
+{
+	qlge_write32(qdev, INTR_EN, (INTR_EN_EI << 16));
+}
+
+static void qlge_enable_completion_interrupt(struct qlge_adapter *qdev, u32 intr)
+{
+	struct intr_context *ctx = &qdev->intr_context[intr];
+
+	qlge_write32(qdev, INTR_EN, ctx->intr_en_mask);
+}
+
+static void qlge_disable_completion_interrupt(struct qlge_adapter *qdev, u32 intr)
+{
+	struct intr_context *ctx = &qdev->intr_context[intr];
+
+	qlge_write32(qdev, INTR_EN, ctx->intr_dis_mask);
+}
+
+static void qlge_enable_all_completion_interrupts(struct qlge_adapter *qdev)
+{
+	int i;
+
+	for (i = 0; i < qdev->intr_count; i++)
+		qlge_enable_completion_interrupt(qdev, i);
+}
+
+static int qlge_validate_flash(struct qlge_adapter *qdev, u32 size, const char *str)
+{
+	int status, i;
+	u16 csum = 0;
+	__le16 *flash = (__le16 *)&qdev->flash;
+
+	status = strncmp((char *)&qdev->flash, str, 4);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev, "Invalid flash signature.\n");
+		return	status;
+	}
+
+	for (i = 0; i < size; i++)
+		csum += le16_to_cpu(*flash++);
+
+	if (csum)
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Invalid flash checksum, csum = 0x%.04x.\n", csum);
+
+	return csum;
+}
+
+static int qlge_read_flash_word(struct qlge_adapter *qdev, int offset, __le32 *data)
+{
+	int status = 0;
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev,
+				   FLASH_ADDR, FLASH_ADDR_RDY, FLASH_ADDR_ERR);
+	if (status)
+		goto exit;
+	/* set up for reg read */
+	qlge_write32(qdev, FLASH_ADDR, FLASH_ADDR_R | offset);
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev,
+				   FLASH_ADDR, FLASH_ADDR_RDY, FLASH_ADDR_ERR);
+	if (status)
+		goto exit;
+	/* This data is stored on flash as an array of
+	 * __le32.  Since qlge_read32() returns cpu endian
+	 * we need to swap it back.
+	 */
+	*data = cpu_to_le32(qlge_read32(qdev, FLASH_DATA));
+exit:
+	return status;
+}
+
+static int qlge_get_8000_flash_params(struct qlge_adapter *qdev)
+{
+	u32 i, size;
+	int status;
+	__le32 *p = (__le32 *)&qdev->flash;
+	u32 offset;
+	u8 mac_addr[6];
+
+	/* Get flash offset for function and adjust
+	 * for dword access.
+	 */
+	if (!qdev->port)
+		offset = FUNC0_FLASH_OFFSET / sizeof(u32);
+	else
+		offset = FUNC1_FLASH_OFFSET / sizeof(u32);
+
+	if (qlge_sem_spinlock(qdev, SEM_FLASH_MASK))
+		return -ETIMEDOUT;
+
+	size = sizeof(struct flash_params_8000) / sizeof(u32);
+	for (i = 0; i < size; i++, p++) {
+		status = qlge_read_flash_word(qdev, i + offset, p);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Error reading flash.\n");
+			goto exit;
+		}
+	}
+
+	status = qlge_validate_flash(qdev,
+				     sizeof(struct flash_params_8000) /
+				   sizeof(u16),
+				   "8000");
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev, "Invalid flash.\n");
+		status = -EINVAL;
+		goto exit;
+	}
+
+	/* Extract either manufacturer or BOFM modified
+	 * MAC address.
+	 */
+	if (qdev->flash.flash_params_8000.data_type1 == 2)
+		memcpy(mac_addr,
+		       qdev->flash.flash_params_8000.mac_addr1,
+		       qdev->ndev->addr_len);
+	else
+		memcpy(mac_addr,
+		       qdev->flash.flash_params_8000.mac_addr,
+		       qdev->ndev->addr_len);
+
+	if (!is_valid_ether_addr(mac_addr)) {
+		netif_err(qdev, ifup, qdev->ndev, "Invalid MAC address.\n");
+		status = -EINVAL;
+		goto exit;
+	}
+
+	eth_hw_addr_set(qdev->ndev, mac_addr);
+
+exit:
+	qlge_sem_unlock(qdev, SEM_FLASH_MASK);
+	return status;
+}
+
+static int qlge_get_8012_flash_params(struct qlge_adapter *qdev)
+{
+	int i;
+	int status;
+	__le32 *p = (__le32 *)&qdev->flash;
+	u32 offset = 0;
+	u32 size = sizeof(struct flash_params_8012) / sizeof(u32);
+
+	/* Second function's parameters follow the first
+	 * function's.
+	 */
+	if (qdev->port)
+		offset = size;
+
+	if (qlge_sem_spinlock(qdev, SEM_FLASH_MASK))
+		return -ETIMEDOUT;
+
+	for (i = 0; i < size; i++, p++) {
+		status = qlge_read_flash_word(qdev, i + offset, p);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Error reading flash.\n");
+			goto exit;
+		}
+	}
+
+	status = qlge_validate_flash(qdev,
+				     sizeof(struct flash_params_8012) /
+				       sizeof(u16),
+				     "8012");
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev, "Invalid flash.\n");
+		status = -EINVAL;
+		goto exit;
+	}
+
+	if (!is_valid_ether_addr(qdev->flash.flash_params_8012.mac_addr)) {
+		status = -EINVAL;
+		goto exit;
+	}
+
+	eth_hw_addr_set(qdev->ndev, qdev->flash.flash_params_8012.mac_addr);
+
+exit:
+	qlge_sem_unlock(qdev, SEM_FLASH_MASK);
+	return status;
+}
+
+/* xgmac register are located behind the xgmac_addr and xgmac_data
+ * register pair.  Each read/write requires us to wait for the ready
+ * bit before reading/writing the data.
+ */
+static int qlge_write_xgmac_reg(struct qlge_adapter *qdev, u32 reg, u32 data)
+{
+	int status;
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev,
+				   XGMAC_ADDR, XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
+	if (status)
+		return status;
+	/* write the data to the data reg */
+	qlge_write32(qdev, XGMAC_DATA, data);
+	/* trigger the write */
+	qlge_write32(qdev, XGMAC_ADDR, reg);
+	return status;
+}
+
+/* xgmac register are located behind the xgmac_addr and xgmac_data
+ * register pair.  Each read/write requires us to wait for the ready
+ * bit before reading/writing the data.
+ */
+int qlge_read_xgmac_reg(struct qlge_adapter *qdev, u32 reg, u32 *data)
+{
+	int status = 0;
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev,
+				   XGMAC_ADDR, XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
+	if (status)
+		goto exit;
+	/* set up for reg read */
+	qlge_write32(qdev, XGMAC_ADDR, reg | XGMAC_ADDR_R);
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev,
+				   XGMAC_ADDR, XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
+	if (status)
+		goto exit;
+	/* get the data */
+	*data = qlge_read32(qdev, XGMAC_DATA);
+exit:
+	return status;
+}
+
+/* This is used for reading the 64-bit statistics regs. */
+int qlge_read_xgmac_reg64(struct qlge_adapter *qdev, u32 reg, u64 *data)
+{
+	int status = 0;
+	u32 hi = 0;
+	u32 lo = 0;
+
+	status = qlge_read_xgmac_reg(qdev, reg, &lo);
+	if (status)
+		goto exit;
+
+	status = qlge_read_xgmac_reg(qdev, reg + 4, &hi);
+	if (status)
+		goto exit;
+
+	*data = (u64)lo | ((u64)hi << 32);
+
+exit:
+	return status;
+}
+
+static int qlge_8000_port_initialize(struct qlge_adapter *qdev)
+{
+	int status;
+	/*
+	 * Get MPI firmware version for driver banner
+	 * and ethool info.
+	 */
+	status = qlge_mb_about_fw(qdev);
+	if (status)
+		goto exit;
+	status = qlge_mb_get_fw_state(qdev);
+	if (status)
+		goto exit;
+	/* Wake up a worker to get/set the TX/RX frame sizes. */
+	queue_delayed_work(qdev->workqueue, &qdev->mpi_port_cfg_work, 0);
+exit:
+	return status;
+}
+
+/* Take the MAC Core out of reset.
+ * Enable statistics counting.
+ * Take the transmitter/receiver out of reset.
+ * This functionality may be done in the MPI firmware at a
+ * later date.
+ */
+static int qlge_8012_port_initialize(struct qlge_adapter *qdev)
+{
+	int status = 0;
+	u32 data;
+
+	if (qlge_sem_trylock(qdev, qdev->xg_sem_mask)) {
+		/* Another function has the semaphore, so
+		 * wait for the port init bit to come ready.
+		 */
+		netif_info(qdev, link, qdev->ndev,
+			   "Another function has the semaphore, so wait for the port init bit to come ready.\n");
+		status = qlge_wait_reg_rdy(qdev, STS, qdev->port_init, 0);
+		if (status) {
+			netif_crit(qdev, link, qdev->ndev,
+				   "Port initialize timed out.\n");
+		}
+		return status;
+	}
+
+	netif_info(qdev, link, qdev->ndev, "Got xgmac semaphore!.\n");
+	/* Set the core reset. */
+	status = qlge_read_xgmac_reg(qdev, GLOBAL_CFG, &data);
+	if (status)
+		goto end;
+	data |= GLOBAL_CFG_RESET;
+	status = qlge_write_xgmac_reg(qdev, GLOBAL_CFG, data);
+	if (status)
+		goto end;
+
+	/* Clear the core reset and turn on jumbo for receiver. */
+	data &= ~GLOBAL_CFG_RESET;	/* Clear core reset. */
+	data |= GLOBAL_CFG_JUMBO;	/* Turn on jumbo. */
+	data |= GLOBAL_CFG_TX_STAT_EN;
+	data |= GLOBAL_CFG_RX_STAT_EN;
+	status = qlge_write_xgmac_reg(qdev, GLOBAL_CFG, data);
+	if (status)
+		goto end;
+
+	/* Enable transmitter, and clear it's reset. */
+	status = qlge_read_xgmac_reg(qdev, TX_CFG, &data);
+	if (status)
+		goto end;
+	data &= ~TX_CFG_RESET;	/* Clear the TX MAC reset. */
+	data |= TX_CFG_EN;	/* Enable the transmitter. */
+	status = qlge_write_xgmac_reg(qdev, TX_CFG, data);
+	if (status)
+		goto end;
+
+	/* Enable receiver and clear it's reset. */
+	status = qlge_read_xgmac_reg(qdev, RX_CFG, &data);
+	if (status)
+		goto end;
+	data &= ~RX_CFG_RESET;	/* Clear the RX MAC reset. */
+	data |= RX_CFG_EN;	/* Enable the receiver. */
+	status = qlge_write_xgmac_reg(qdev, RX_CFG, data);
+	if (status)
+		goto end;
+
+	/* Turn on jumbo. */
+	status =
+	    qlge_write_xgmac_reg(qdev, MAC_TX_PARAMS, MAC_TX_PARAMS_JUMBO | (0x2580 << 16));
+	if (status)
+		goto end;
+	status =
+	    qlge_write_xgmac_reg(qdev, MAC_RX_PARAMS, 0x2580);
+	if (status)
+		goto end;
+
+	/* Signal to the world that the port is enabled.        */
+	qlge_write32(qdev, STS, ((qdev->port_init << 16) | qdev->port_init));
+end:
+	qlge_sem_unlock(qdev, qdev->xg_sem_mask);
+	return status;
+}
+
+static inline unsigned int qlge_lbq_block_size(struct qlge_adapter *qdev)
+{
+	return PAGE_SIZE << qdev->lbq_buf_order;
+}
+
+static struct qlge_bq_desc *qlge_get_curr_buf(struct qlge_bq *bq)
+{
+	struct qlge_bq_desc *bq_desc;
+
+	bq_desc = &bq->queue[bq->next_to_clean];
+	bq->next_to_clean = QLGE_BQ_WRAP(bq->next_to_clean + 1);
+
+	return bq_desc;
+}
+
+static struct qlge_bq_desc *qlge_get_curr_lchunk(struct qlge_adapter *qdev,
+						 struct rx_ring *rx_ring)
+{
+	struct qlge_bq_desc *lbq_desc = qlge_get_curr_buf(&rx_ring->lbq);
+
+	dma_sync_single_for_cpu(&qdev->pdev->dev, lbq_desc->dma_addr,
+				qdev->lbq_buf_size, DMA_FROM_DEVICE);
+
+	if ((lbq_desc->p.pg_chunk.offset + qdev->lbq_buf_size) ==
+	    qlge_lbq_block_size(qdev)) {
+		/* last chunk of the master page */
+		dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
+			       qlge_lbq_block_size(qdev), DMA_FROM_DEVICE);
+	}
+
+	return lbq_desc;
+}
+
+/* Update an rx ring index. */
+static void qlge_update_cq(struct rx_ring *rx_ring)
+{
+	rx_ring->cnsmr_idx++;
+	rx_ring->curr_entry++;
+	if (unlikely(rx_ring->cnsmr_idx == rx_ring->cq_len)) {
+		rx_ring->cnsmr_idx = 0;
+		rx_ring->curr_entry = rx_ring->cq_base;
+	}
+}
+
+static void qlge_write_cq_idx(struct rx_ring *rx_ring)
+{
+	qlge_write_db_reg(rx_ring->cnsmr_idx, rx_ring->cnsmr_idx_db_reg);
+}
+
+static const char * const bq_type_name[] = {
+	[QLGE_SB] = "sbq",
+	[QLGE_LB] = "lbq",
+};
+
+/* return 0 or negative error */
+static int qlge_refill_sb(struct rx_ring *rx_ring,
+			  struct qlge_bq_desc *sbq_desc, gfp_t gfp)
+{
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct sk_buff *skb;
+
+	if (sbq_desc->p.skb)
+		return 0;
+
+	netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+		     "ring %u sbq: getting new skb for index %d.\n",
+		     rx_ring->cq_id, sbq_desc->index);
+
+	skb = __netdev_alloc_skb(qdev->ndev, SMALL_BUFFER_SIZE, gfp);
+	if (!skb)
+		return -ENOMEM;
+	skb_reserve(skb, QLGE_SB_PAD);
+
+	sbq_desc->dma_addr = dma_map_single(&qdev->pdev->dev, skb->data,
+					    SMALL_BUF_MAP_SIZE,
+					    DMA_FROM_DEVICE);
+	if (dma_mapping_error(&qdev->pdev->dev, sbq_desc->dma_addr)) {
+		netif_err(qdev, ifup, qdev->ndev, "PCI mapping failed.\n");
+		dev_kfree_skb_any(skb);
+		return -EIO;
+	}
+	*sbq_desc->buf_ptr = cpu_to_le64(sbq_desc->dma_addr);
+
+	sbq_desc->p.skb = skb;
+	return 0;
+}
+
+/* return 0 or negative error */
+static int qlge_refill_lb(struct rx_ring *rx_ring,
+			  struct qlge_bq_desc *lbq_desc, gfp_t gfp)
+{
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct qlge_page_chunk *master_chunk = &rx_ring->master_chunk;
+
+	if (!master_chunk->page) {
+		struct page *page;
+		dma_addr_t dma_addr;
+
+		page = alloc_pages(gfp | __GFP_COMP, qdev->lbq_buf_order);
+		if (unlikely(!page))
+			return -ENOMEM;
+		dma_addr = dma_map_page(&qdev->pdev->dev, page, 0,
+					qlge_lbq_block_size(qdev),
+					DMA_FROM_DEVICE);
+		if (dma_mapping_error(&qdev->pdev->dev, dma_addr)) {
+			__free_pages(page, qdev->lbq_buf_order);
+			netif_err(qdev, drv, qdev->ndev,
+				  "PCI mapping failed.\n");
+			return -EIO;
+		}
+		master_chunk->page = page;
+		master_chunk->va = page_address(page);
+		master_chunk->offset = 0;
+		rx_ring->chunk_dma_addr = dma_addr;
+	}
+
+	lbq_desc->p.pg_chunk = *master_chunk;
+	lbq_desc->dma_addr = rx_ring->chunk_dma_addr;
+	*lbq_desc->buf_ptr = cpu_to_le64(lbq_desc->dma_addr +
+					 lbq_desc->p.pg_chunk.offset);
+
+	/* Adjust the master page chunk for next
+	 * buffer get.
+	 */
+	master_chunk->offset += qdev->lbq_buf_size;
+	if (master_chunk->offset == qlge_lbq_block_size(qdev)) {
+		master_chunk->page = NULL;
+	} else {
+		master_chunk->va += qdev->lbq_buf_size;
+		get_page(master_chunk->page);
+	}
+
+	return 0;
+}
+
+/* return 0 or negative error */
+static int qlge_refill_bq(struct qlge_bq *bq, gfp_t gfp)
+{
+	struct rx_ring *rx_ring = QLGE_BQ_CONTAINER(bq);
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct qlge_bq_desc *bq_desc;
+	int refill_count;
+	int retval;
+	int i;
+
+	refill_count = QLGE_BQ_WRAP(QLGE_BQ_ALIGN(bq->next_to_clean - 1) -
+				    bq->next_to_use);
+	if (!refill_count)
+		return 0;
+
+	i = bq->next_to_use;
+	bq_desc = &bq->queue[i];
+	i -= QLGE_BQ_LEN;
+	do {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "ring %u %s: try cleaning idx %d\n",
+			     rx_ring->cq_id, bq_type_name[bq->type], i);
+
+		if (bq->type == QLGE_SB)
+			retval = qlge_refill_sb(rx_ring, bq_desc, gfp);
+		else
+			retval = qlge_refill_lb(rx_ring, bq_desc, gfp);
+		if (retval < 0) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "ring %u %s: Could not get a page chunk, idx %d\n",
+				  rx_ring->cq_id, bq_type_name[bq->type], i);
+			break;
+		}
+
+		bq_desc++;
+		i++;
+		if (unlikely(!i)) {
+			bq_desc = &bq->queue[0];
+			i -= QLGE_BQ_LEN;
+		}
+		refill_count--;
+	} while (refill_count);
+	i += QLGE_BQ_LEN;
+
+	if (bq->next_to_use != i) {
+		if (QLGE_BQ_ALIGN(bq->next_to_use) != QLGE_BQ_ALIGN(i)) {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "ring %u %s: updating prod idx = %d.\n",
+				     rx_ring->cq_id, bq_type_name[bq->type],
+				     i);
+			qlge_write_db_reg(i, bq->prod_idx_db_reg);
+		}
+		bq->next_to_use = i;
+	}
+
+	return retval;
+}
+
+static void qlge_update_buffer_queues(struct rx_ring *rx_ring, gfp_t gfp,
+				      unsigned long delay)
+{
+	bool sbq_fail, lbq_fail;
+
+	sbq_fail = !!qlge_refill_bq(&rx_ring->sbq, gfp);
+	lbq_fail = !!qlge_refill_bq(&rx_ring->lbq, gfp);
+
+	/* Minimum number of buffers needed to be able to receive at least one
+	 * frame of any format:
+	 * sbq: 1 for header + 1 for data
+	 * lbq: mtu 9000 / lb size
+	 * Below this, the queue might stall.
+	 */
+	if ((sbq_fail && QLGE_BQ_HW_OWNED(&rx_ring->sbq) < 2) ||
+	    (lbq_fail && QLGE_BQ_HW_OWNED(&rx_ring->lbq) <
+	     DIV_ROUND_UP(9000, LARGE_BUFFER_MAX_SIZE)))
+		/* Allocations can take a long time in certain cases (ex.
+		 * reclaim). Therefore, use a workqueue for long-running
+		 * work items.
+		 */
+		queue_delayed_work_on(smp_processor_id(), system_long_wq,
+				      &rx_ring->refill_work, delay);
+}
+
+static void qlge_slow_refill(struct work_struct *work)
+{
+	struct rx_ring *rx_ring = container_of(work, struct rx_ring,
+					       refill_work.work);
+	struct napi_struct *napi = &rx_ring->napi;
+
+	napi_disable(napi);
+	qlge_update_buffer_queues(rx_ring, GFP_KERNEL, HZ / 2);
+	napi_enable(napi);
+
+	local_bh_disable();
+	/* napi_disable() might have prevented incomplete napi work from being
+	 * rescheduled.
+	 */
+	napi_schedule(napi);
+	/* trigger softirq processing */
+	local_bh_enable();
+}
+
+/* Unmaps tx buffers.  Can be called from send() if a pci mapping
+ * fails at some stage, or from the interrupt when a tx completes.
+ */
+static void qlge_unmap_send(struct qlge_adapter *qdev,
+			    struct tx_ring_desc *tx_ring_desc, int mapped)
+{
+	int i;
+
+	for (i = 0; i < mapped; i++) {
+		if (i == 0 || (i == 7 && mapped > 7)) {
+			/*
+			 * Unmap the skb->data area, or the
+			 * external sglist (AKA the Outbound
+			 * Address List (OAL)).
+			 * If its the zeroeth element, then it's
+			 * the skb->data area.  If it's the 7th
+			 * element and there is more than 6 frags,
+			 * then its an OAL.
+			 */
+			if (i == 7) {
+				netif_printk(qdev, tx_done, KERN_DEBUG,
+					     qdev->ndev,
+					     "unmapping OAL area.\n");
+			}
+			dma_unmap_single(&qdev->pdev->dev,
+					 dma_unmap_addr(&tx_ring_desc->map[i],
+							mapaddr),
+					 dma_unmap_len(&tx_ring_desc->map[i],
+						       maplen),
+					 DMA_TO_DEVICE);
+		} else {
+			netif_printk(qdev, tx_done, KERN_DEBUG, qdev->ndev,
+				     "unmapping frag %d.\n", i);
+			dma_unmap_page(&qdev->pdev->dev,
+				       dma_unmap_addr(&tx_ring_desc->map[i],
+						      mapaddr),
+				       dma_unmap_len(&tx_ring_desc->map[i],
+						     maplen), DMA_TO_DEVICE);
+		}
+	}
+}
+
+/* Map the buffers for this transmit.  This will return
+ * NETDEV_TX_BUSY or NETDEV_TX_OK based on success.
+ */
+static int qlge_map_send(struct qlge_adapter *qdev,
+			 struct qlge_ob_mac_iocb_req *mac_iocb_ptr,
+			 struct sk_buff *skb, struct tx_ring_desc *tx_ring_desc)
+{
+	int len = skb_headlen(skb);
+	dma_addr_t map;
+	int frag_idx, err, map_idx = 0;
+	struct tx_buf_desc *tbd = mac_iocb_ptr->tbd;
+	int frag_cnt = skb_shinfo(skb)->nr_frags;
+
+	if (frag_cnt) {
+		netif_printk(qdev, tx_queued, KERN_DEBUG, qdev->ndev,
+			     "frag_cnt = %d.\n", frag_cnt);
+	}
+	/*
+	 * Map the skb buffer first.
+	 */
+	map = dma_map_single(&qdev->pdev->dev, skb->data, len, DMA_TO_DEVICE);
+
+	err = dma_mapping_error(&qdev->pdev->dev, map);
+	if (err) {
+		netif_err(qdev, tx_queued, qdev->ndev,
+			  "PCI mapping failed with error: %d\n", err);
+
+		return NETDEV_TX_BUSY;
+	}
+
+	tbd->len = cpu_to_le32(len);
+	tbd->addr = cpu_to_le64(map);
+	dma_unmap_addr_set(&tx_ring_desc->map[map_idx], mapaddr, map);
+	dma_unmap_len_set(&tx_ring_desc->map[map_idx], maplen, len);
+	map_idx++;
+
+	/*
+	 * This loop fills the remainder of the 8 address descriptors
+	 * in the IOCB.  If there are more than 7 fragments, then the
+	 * eighth address desc will point to an external list (OAL).
+	 * When this happens, the remainder of the frags will be stored
+	 * in this list.
+	 */
+	for (frag_idx = 0; frag_idx < frag_cnt; frag_idx++, map_idx++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[frag_idx];
+
+		tbd++;
+		if (frag_idx == 6 && frag_cnt > 7) {
+			/* Let's tack on an sglist.
+			 * Our control block will now
+			 * look like this:
+			 * iocb->seg[0] = skb->data
+			 * iocb->seg[1] = frag[0]
+			 * iocb->seg[2] = frag[1]
+			 * iocb->seg[3] = frag[2]
+			 * iocb->seg[4] = frag[3]
+			 * iocb->seg[5] = frag[4]
+			 * iocb->seg[6] = frag[5]
+			 * iocb->seg[7] = ptr to OAL (external sglist)
+			 * oal->seg[0] = frag[6]
+			 * oal->seg[1] = frag[7]
+			 * oal->seg[2] = frag[8]
+			 * oal->seg[3] = frag[9]
+			 * oal->seg[4] = frag[10]
+			 *      etc...
+			 */
+			/* Tack on the OAL in the eighth segment of IOCB. */
+			map = dma_map_single(&qdev->pdev->dev, &tx_ring_desc->oal,
+					     sizeof(struct qlge_oal),
+					     DMA_TO_DEVICE);
+			err = dma_mapping_error(&qdev->pdev->dev, map);
+			if (err) {
+				netif_err(qdev, tx_queued, qdev->ndev,
+					  "PCI mapping outbound address list with error: %d\n",
+					  err);
+				goto map_error;
+			}
+
+			tbd->addr = cpu_to_le64(map);
+			/*
+			 * The length is the number of fragments
+			 * that remain to be mapped times the length
+			 * of our sglist (OAL).
+			 */
+			tbd->len =
+			    cpu_to_le32((sizeof(struct tx_buf_desc) *
+					 (frag_cnt - frag_idx)) | TX_DESC_C);
+			dma_unmap_addr_set(&tx_ring_desc->map[map_idx], mapaddr,
+					   map);
+			dma_unmap_len_set(&tx_ring_desc->map[map_idx], maplen,
+					  sizeof(struct qlge_oal));
+			tbd = (struct tx_buf_desc *)&tx_ring_desc->oal;
+			map_idx++;
+		}
+
+		map = skb_frag_dma_map(&qdev->pdev->dev, frag, 0, skb_frag_size(frag),
+				       DMA_TO_DEVICE);
+
+		err = dma_mapping_error(&qdev->pdev->dev, map);
+		if (err) {
+			netif_err(qdev, tx_queued, qdev->ndev,
+				  "PCI mapping frags failed with error: %d.\n",
+				  err);
+			goto map_error;
+		}
+
+		tbd->addr = cpu_to_le64(map);
+		tbd->len = cpu_to_le32(skb_frag_size(frag));
+		dma_unmap_addr_set(&tx_ring_desc->map[map_idx], mapaddr, map);
+		dma_unmap_len_set(&tx_ring_desc->map[map_idx], maplen,
+				  skb_frag_size(frag));
+	}
+	/* Save the number of segments we've mapped. */
+	tx_ring_desc->map_cnt = map_idx;
+	/* Terminate the last segment. */
+	tbd->len = cpu_to_le32(le32_to_cpu(tbd->len) | TX_DESC_E);
+	return NETDEV_TX_OK;
+
+map_error:
+	/*
+	 * If the first frag mapping failed, then i will be zero.
+	 * This causes the unmap of the skb->data area.  Otherwise
+	 * we pass in the number of frags that mapped successfully
+	 * so they can be umapped.
+	 */
+	qlge_unmap_send(qdev, tx_ring_desc, map_idx);
+	return NETDEV_TX_BUSY;
+}
+
+/* Categorizing receive firmware frame errors */
+static void qlge_categorize_rx_err(struct qlge_adapter *qdev, u8 rx_err,
+				   struct rx_ring *rx_ring)
+{
+	struct nic_stats *stats = &qdev->nic_stats;
+
+	stats->rx_err_count++;
+	rx_ring->rx_errors++;
+
+	switch (rx_err & IB_MAC_IOCB_RSP_ERR_MASK) {
+	case IB_MAC_IOCB_RSP_ERR_CODE_ERR:
+		stats->rx_code_err++;
+		break;
+	case IB_MAC_IOCB_RSP_ERR_OVERSIZE:
+		stats->rx_oversize_err++;
+		break;
+	case IB_MAC_IOCB_RSP_ERR_UNDERSIZE:
+		stats->rx_undersize_err++;
+		break;
+	case IB_MAC_IOCB_RSP_ERR_PREAMBLE:
+		stats->rx_preamble_err++;
+		break;
+	case IB_MAC_IOCB_RSP_ERR_FRAME_LEN:
+		stats->rx_frame_len_err++;
+		break;
+	case IB_MAC_IOCB_RSP_ERR_CRC:
+		stats->rx_crc_err++;
+		break;
+	default:
+		break;
+	}
+}
+
+/*
+ * qlge_update_mac_hdr_len - helper routine to update the mac header length
+ * based on vlan tags if present
+ */
+static void qlge_update_mac_hdr_len(struct qlge_adapter *qdev,
+				    struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
+				    void *page, size_t *len)
+{
+	u16 *tags;
+
+	if (qdev->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)
+		return;
+	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_V) {
+		tags = (u16 *)page;
+		/* Look for stacked vlan tags in ethertype field */
+		if (tags[6] == ETH_P_8021Q &&
+		    tags[8] == ETH_P_8021Q)
+			*len += 2 * VLAN_HLEN;
+		else
+			*len += VLAN_HLEN;
+	}
+}
+
+/* Process an inbound completion from an rx ring. */
+static void qlge_process_mac_rx_gro_page(struct qlge_adapter *qdev,
+					 struct rx_ring *rx_ring,
+					 struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
+					 u32 length, u16 vlan_id)
+{
+	struct sk_buff *skb;
+	struct qlge_bq_desc *lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
+	struct napi_struct *napi = &rx_ring->napi;
+
+	/* Frame error, so drop the packet. */
+	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		put_page(lbq_desc->p.pg_chunk.page);
+		return;
+	}
+	napi->dev = qdev->ndev;
+
+	skb = napi_get_frags(napi);
+	if (!skb) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Couldn't get an skb, exiting.\n");
+		rx_ring->rx_dropped++;
+		put_page(lbq_desc->p.pg_chunk.page);
+		return;
+	}
+	prefetch(lbq_desc->p.pg_chunk.va);
+	__skb_fill_page_desc(skb, skb_shinfo(skb)->nr_frags,
+			     lbq_desc->p.pg_chunk.page,
+			     lbq_desc->p.pg_chunk.offset,
+			     length);
+
+	skb->len += length;
+	skb->data_len += length;
+	skb->truesize += length;
+	skb_shinfo(skb)->nr_frags++;
+
+	rx_ring->rx_packets++;
+	rx_ring->rx_bytes += length;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb_record_rx_queue(skb, rx_ring->cq_id);
+	if (vlan_id != 0xffff)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_id);
+	napi_gro_frags(napi);
+}
+
+/* Process an inbound completion from an rx ring. */
+static void qlge_process_mac_rx_page(struct qlge_adapter *qdev,
+				     struct rx_ring *rx_ring,
+				     struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
+				     u32 length, u16 vlan_id)
+{
+	struct net_device *ndev = qdev->ndev;
+	struct sk_buff *skb = NULL;
+	void *addr;
+	struct qlge_bq_desc *lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
+	struct napi_struct *napi = &rx_ring->napi;
+	size_t hlen = ETH_HLEN;
+
+	skb = netdev_alloc_skb(ndev, length);
+	if (!skb) {
+		rx_ring->rx_dropped++;
+		put_page(lbq_desc->p.pg_chunk.page);
+		return;
+	}
+
+	addr = lbq_desc->p.pg_chunk.va;
+	prefetch(addr);
+
+	/* Frame error, so drop the packet. */
+	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		goto err_out;
+	}
+
+	/* Update the MAC header length*/
+	qlge_update_mac_hdr_len(qdev, ib_mac_rsp, addr, &hlen);
+
+	/* The max framesize filter on this chip is set higher than
+	 * MTU since FCoE uses 2k frames.
+	 */
+	if (skb->len > ndev->mtu + hlen) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Segment too small, dropping.\n");
+		rx_ring->rx_dropped++;
+		goto err_out;
+	}
+	skb_put_data(skb, addr, hlen);
+	netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+		     "%d bytes of headers and data in large. Chain page to new skb and pull tail.\n",
+		     length);
+	skb_fill_page_desc(skb, 0, lbq_desc->p.pg_chunk.page,
+			   lbq_desc->p.pg_chunk.offset + hlen, length - hlen);
+	skb->len += length - hlen;
+	skb->data_len += length - hlen;
+	skb->truesize += length - hlen;
+
+	rx_ring->rx_packets++;
+	rx_ring->rx_bytes += skb->len;
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_checksum_none_assert(skb);
+
+	if ((ndev->features & NETIF_F_RXCSUM) &&
+	    !(ib_mac_rsp->flags1 & IB_MAC_CSUM_ERR_MASK)) {
+		/* TCP frame. */
+		if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_T) {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "TCP checksum done!\n");
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else if ((ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_U) &&
+			   (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_V4)) {
+			/* Unfragmented ipv4 UDP frame. */
+			struct iphdr *iph =
+				(struct iphdr *)((u8 *)addr + hlen);
+			if (!(iph->frag_off &
+			      htons(IP_MF | IP_OFFSET))) {
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				netif_printk(qdev, rx_status, KERN_DEBUG,
+					     qdev->ndev,
+					     "UDP checksum done!\n");
+			}
+		}
+	}
+
+	skb_record_rx_queue(skb, rx_ring->cq_id);
+	if (vlan_id != 0xffff)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_id);
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY)
+		napi_gro_receive(napi, skb);
+	else
+		netif_receive_skb(skb);
+	return;
+err_out:
+	dev_kfree_skb_any(skb);
+	put_page(lbq_desc->p.pg_chunk.page);
+}
+
+/* Process an inbound completion from an rx ring. */
+static void qlge_process_mac_rx_skb(struct qlge_adapter *qdev,
+				    struct rx_ring *rx_ring,
+				    struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
+				    u32 length, u16 vlan_id)
+{
+	struct qlge_bq_desc *sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
+	struct net_device *ndev = qdev->ndev;
+	struct sk_buff *skb, *new_skb;
+
+	skb = sbq_desc->p.skb;
+	/* Allocate new_skb and copy */
+	new_skb = netdev_alloc_skb(qdev->ndev, length + NET_IP_ALIGN);
+	if (!new_skb) {
+		rx_ring->rx_dropped++;
+		return;
+	}
+	skb_reserve(new_skb, NET_IP_ALIGN);
+
+	dma_sync_single_for_cpu(&qdev->pdev->dev, sbq_desc->dma_addr,
+				SMALL_BUF_MAP_SIZE, DMA_FROM_DEVICE);
+
+	skb_put_data(new_skb, skb->data, length);
+
+	skb = new_skb;
+
+	/* Frame error, so drop the packet. */
+	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	/* loopback self test for ethtool */
+	if (test_bit(QL_SELFTEST, &qdev->flags)) {
+		qlge_check_lb_frame(qdev, skb);
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	/* The max framesize filter on this chip is set higher than
+	 * MTU since FCoE uses 2k frames.
+	 */
+	if (skb->len > ndev->mtu + ETH_HLEN) {
+		dev_kfree_skb_any(skb);
+		rx_ring->rx_dropped++;
+		return;
+	}
+
+	prefetch(skb->data);
+	if (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "%s Multicast.\n",
+			     (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) ==
+			     IB_MAC_IOCB_RSP_M_HASH ? "Hash" :
+			     (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) ==
+			     IB_MAC_IOCB_RSP_M_REG ? "Registered" :
+			     (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) ==
+			     IB_MAC_IOCB_RSP_M_PROM ? "Promiscuous" : "");
+	}
+	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_P)
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "Promiscuous Packet.\n");
+
+	rx_ring->rx_packets++;
+	rx_ring->rx_bytes += skb->len;
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_checksum_none_assert(skb);
+
+	/* If rx checksum is on, and there are no
+	 * csum or frame errors.
+	 */
+	if ((ndev->features & NETIF_F_RXCSUM) &&
+	    !(ib_mac_rsp->flags1 & IB_MAC_CSUM_ERR_MASK)) {
+		/* TCP frame. */
+		if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_T) {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "TCP checksum done!\n");
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else if ((ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_U) &&
+			   (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_V4)) {
+			/* Unfragmented ipv4 UDP frame. */
+			struct iphdr *iph = (struct iphdr *)skb->data;
+
+			if (!(iph->frag_off &
+			      htons(IP_MF | IP_OFFSET))) {
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				netif_printk(qdev, rx_status, KERN_DEBUG,
+					     qdev->ndev,
+					     "UDP checksum done!\n");
+			}
+		}
+	}
+
+	skb_record_rx_queue(skb, rx_ring->cq_id);
+	if (vlan_id != 0xffff)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_id);
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY)
+		napi_gro_receive(&rx_ring->napi, skb);
+	else
+		netif_receive_skb(skb);
+}
+
+static void qlge_realign_skb(struct sk_buff *skb, int len)
+{
+	void *temp_addr = skb->data;
+
+	/* Undo the skb_reserve(skb,32) we did before
+	 * giving to hardware, and realign data on
+	 * a 2-byte boundary.
+	 */
+	skb->data -= QLGE_SB_PAD - NET_IP_ALIGN;
+	skb->tail -= QLGE_SB_PAD - NET_IP_ALIGN;
+	memmove(skb->data, temp_addr, len);
+}
+
+/*
+ * This function builds an skb for the given inbound
+ * completion.  It will be rewritten for readability in the near
+ * future, but for not it works well.
+ */
+static struct sk_buff *qlge_build_rx_skb(struct qlge_adapter *qdev,
+					 struct rx_ring *rx_ring,
+					 struct qlge_ib_mac_iocb_rsp *ib_mac_rsp)
+{
+	u32 length = le32_to_cpu(ib_mac_rsp->data_len);
+	u32 hdr_len = le32_to_cpu(ib_mac_rsp->hdr_len);
+	struct qlge_bq_desc *lbq_desc, *sbq_desc;
+	struct sk_buff *skb = NULL;
+	size_t hlen = ETH_HLEN;
+
+	/*
+	 * Handle the header buffer if present.
+	 */
+	if (ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HV &&
+	    ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HS) {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "Header of %d bytes in small buffer.\n", hdr_len);
+		/*
+		 * Headers fit nicely into a small buffer.
+		 */
+		sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
+		dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
+				 SMALL_BUF_MAP_SIZE, DMA_FROM_DEVICE);
+		skb = sbq_desc->p.skb;
+		qlge_realign_skb(skb, hdr_len);
+		skb_put(skb, hdr_len);
+		sbq_desc->p.skb = NULL;
+	}
+
+	/*
+	 * Handle the data buffer(s).
+	 */
+	if (unlikely(!length)) {	/* Is there data too? */
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "No Data buffer in this packet.\n");
+		return skb;
+	}
+
+	if (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DS) {
+		if (ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HS) {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "Headers in small, data of %d bytes in small, combine them.\n",
+				     length);
+			/*
+			 * Data is less than small buffer size so it's
+			 * stuffed in a small buffer.
+			 * For this case we append the data
+			 * from the "data" small buffer to the "header" small
+			 * buffer.
+			 */
+			sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
+			dma_sync_single_for_cpu(&qdev->pdev->dev,
+						sbq_desc->dma_addr,
+						SMALL_BUF_MAP_SIZE,
+						DMA_FROM_DEVICE);
+			skb_put_data(skb, sbq_desc->p.skb->data, length);
+		} else {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "%d bytes in a single small buffer.\n",
+				     length);
+			sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
+			skb = sbq_desc->p.skb;
+			qlge_realign_skb(skb, length);
+			skb_put(skb, length);
+			dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
+					 SMALL_BUF_MAP_SIZE,
+					 DMA_FROM_DEVICE);
+			sbq_desc->p.skb = NULL;
+		}
+	} else if (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DL) {
+		if (ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HS) {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "Header in small, %d bytes in large. Chain large to small!\n",
+				     length);
+			/*
+			 * The data is in a single large buffer.  We
+			 * chain it to the header buffer's skb and let
+			 * it rip.
+			 */
+			lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "Chaining page at offset = %d, for %d bytes  to skb.\n",
+				     lbq_desc->p.pg_chunk.offset, length);
+			skb_fill_page_desc(skb, 0, lbq_desc->p.pg_chunk.page,
+					   lbq_desc->p.pg_chunk.offset, length);
+			skb->len += length;
+			skb->data_len += length;
+			skb->truesize += length;
+		} else {
+			/*
+			 * The headers and data are in a single large buffer. We
+			 * copy it to a new skb and let it go. This can happen with
+			 * jumbo mtu on a non-TCP/UDP frame.
+			 */
+			lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
+			skb = netdev_alloc_skb(qdev->ndev, length);
+			if (!skb) {
+				netif_printk(qdev, probe, KERN_DEBUG, qdev->ndev,
+					     "No skb available, drop the packet.\n");
+				return NULL;
+			}
+			dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
+				       qdev->lbq_buf_size,
+				       DMA_FROM_DEVICE);
+			skb_reserve(skb, NET_IP_ALIGN);
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "%d bytes of headers and data in large. Chain page to new skb and pull tail.\n",
+				     length);
+			skb_fill_page_desc(skb, 0, lbq_desc->p.pg_chunk.page,
+					   lbq_desc->p.pg_chunk.offset,
+					   length);
+			skb->len += length;
+			skb->data_len += length;
+			skb->truesize += length;
+			qlge_update_mac_hdr_len(qdev, ib_mac_rsp,
+						lbq_desc->p.pg_chunk.va,
+						&hlen);
+			__pskb_pull_tail(skb, hlen);
+		}
+	} else {
+		/*
+		 * The data is in a chain of large buffers
+		 * pointed to by a small buffer.  We loop
+		 * thru and chain them to the our small header
+		 * buffer's skb.
+		 * frags:  There are 18 max frags and our small
+		 *         buffer will hold 32 of them. The thing is,
+		 *         we'll use 3 max for our 9000 byte jumbo
+		 *         frames.  If the MTU goes up we could
+		 *          eventually be in trouble.
+		 */
+		int size, i = 0;
+
+		sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
+		dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
+				 SMALL_BUF_MAP_SIZE, DMA_FROM_DEVICE);
+		if (!(ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HS)) {
+			/*
+			 * This is an non TCP/UDP IP frame, so
+			 * the headers aren't split into a small
+			 * buffer.  We have to use the small buffer
+			 * that contains our sg list as our skb to
+			 * send upstairs. Copy the sg list here to
+			 * a local buffer and use it to find the
+			 * pages to chain.
+			 */
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "%d bytes of headers & data in chain of large.\n",
+				     length);
+			skb = sbq_desc->p.skb;
+			sbq_desc->p.skb = NULL;
+			skb_reserve(skb, NET_IP_ALIGN);
+		}
+		do {
+			lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
+			size = min(length, qdev->lbq_buf_size);
+
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "Adding page %d to skb for %d bytes.\n",
+				     i, size);
+			skb_fill_page_desc(skb, i,
+					   lbq_desc->p.pg_chunk.page,
+					   lbq_desc->p.pg_chunk.offset, size);
+			skb->len += size;
+			skb->data_len += size;
+			skb->truesize += size;
+			length -= size;
+			i++;
+		} while (length > 0);
+		qlge_update_mac_hdr_len(qdev, ib_mac_rsp, lbq_desc->p.pg_chunk.va,
+					&hlen);
+		__pskb_pull_tail(skb, hlen);
+	}
+	return skb;
+}
+
+/* Process an inbound completion from an rx ring. */
+static void qlge_process_mac_split_rx_intr(struct qlge_adapter *qdev,
+					   struct rx_ring *rx_ring,
+					   struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
+					   u16 vlan_id)
+{
+	struct net_device *ndev = qdev->ndev;
+	struct sk_buff *skb = NULL;
+
+	skb = qlge_build_rx_skb(qdev, rx_ring, ib_mac_rsp);
+	if (unlikely(!skb)) {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "No skb available, drop packet.\n");
+		rx_ring->rx_dropped++;
+		return;
+	}
+
+	/* Frame error, so drop the packet. */
+	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	/* The max framesize filter on this chip is set higher than
+	 * MTU since FCoE uses 2k frames.
+	 */
+	if (skb->len > ndev->mtu + ETH_HLEN) {
+		dev_kfree_skb_any(skb);
+		rx_ring->rx_dropped++;
+		return;
+	}
+
+	/* loopback self test for ethtool */
+	if (test_bit(QL_SELFTEST, &qdev->flags)) {
+		qlge_check_lb_frame(qdev, skb);
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	prefetch(skb->data);
+	if (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev, "%s Multicast.\n",
+			     (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) ==
+			     IB_MAC_IOCB_RSP_M_HASH ? "Hash" :
+			     (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) ==
+			     IB_MAC_IOCB_RSP_M_REG ? "Registered" :
+			     (ib_mac_rsp->flags1 & IB_MAC_IOCB_RSP_M_MASK) ==
+			     IB_MAC_IOCB_RSP_M_PROM ? "Promiscuous" : "");
+		rx_ring->rx_multicast++;
+	}
+	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_P) {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "Promiscuous Packet.\n");
+	}
+
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_checksum_none_assert(skb);
+
+	/* If rx checksum is on, and there are no
+	 * csum or frame errors.
+	 */
+	if ((ndev->features & NETIF_F_RXCSUM) &&
+	    !(ib_mac_rsp->flags1 & IB_MAC_CSUM_ERR_MASK)) {
+		/* TCP frame. */
+		if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_T) {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "TCP checksum done!\n");
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else if ((ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_U) &&
+			   (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_V4)) {
+			/* Unfragmented ipv4 UDP frame. */
+			struct iphdr *iph = (struct iphdr *)skb->data;
+
+			if (!(iph->frag_off &
+			      htons(IP_MF | IP_OFFSET))) {
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+					     "TCP checksum done!\n");
+			}
+		}
+	}
+
+	rx_ring->rx_packets++;
+	rx_ring->rx_bytes += skb->len;
+	skb_record_rx_queue(skb, rx_ring->cq_id);
+	if (vlan_id != 0xffff)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_id);
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY)
+		napi_gro_receive(&rx_ring->napi, skb);
+	else
+		netif_receive_skb(skb);
+}
+
+/* Process an inbound completion from an rx ring. */
+static unsigned long qlge_process_mac_rx_intr(struct qlge_adapter *qdev,
+					      struct rx_ring *rx_ring,
+					      struct qlge_ib_mac_iocb_rsp *ib_mac_rsp)
+{
+	u32 length = le32_to_cpu(ib_mac_rsp->data_len);
+	u16 vlan_id = ((ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_V) &&
+		       (qdev->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)) ?
+		((le16_to_cpu(ib_mac_rsp->vlan_id) &
+		  IB_MAC_IOCB_RSP_VLAN_MASK)) : 0xffff;
+
+	if (ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HV) {
+		/* The data and headers are split into
+		 * separate buffers.
+		 */
+		qlge_process_mac_split_rx_intr(qdev, rx_ring, ib_mac_rsp,
+					       vlan_id);
+	} else if (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DS) {
+		/* The data fit in a single small buffer.
+		 * Allocate a new skb, copy the data and
+		 * return the buffer to the free pool.
+		 */
+		qlge_process_mac_rx_skb(qdev, rx_ring, ib_mac_rsp, length,
+					vlan_id);
+	} else if ((ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DL) &&
+		   !(ib_mac_rsp->flags1 & IB_MAC_CSUM_ERR_MASK) &&
+		   (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_T)) {
+		/* TCP packet in a page chunk that's been checksummed.
+		 * Tack it on to our GRO skb and let it go.
+		 */
+		qlge_process_mac_rx_gro_page(qdev, rx_ring, ib_mac_rsp, length,
+					     vlan_id);
+	} else if (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DL) {
+		/* Non-TCP packet in a page chunk. Allocate an
+		 * skb, tack it on frags, and send it up.
+		 */
+		qlge_process_mac_rx_page(qdev, rx_ring, ib_mac_rsp, length,
+					 vlan_id);
+	} else {
+		/* Non-TCP/UDP large frames that span multiple buffers
+		 * can be processed correctly by the split frame logic.
+		 */
+		qlge_process_mac_split_rx_intr(qdev, rx_ring, ib_mac_rsp,
+					       vlan_id);
+	}
+
+	return (unsigned long)length;
+}
+
+/* Process an outbound completion from an rx ring. */
+static void qlge_process_mac_tx_intr(struct qlge_adapter *qdev,
+				     struct qlge_ob_mac_iocb_rsp *mac_rsp)
+{
+	struct tx_ring *tx_ring;
+	struct tx_ring_desc *tx_ring_desc;
+
+	tx_ring = &qdev->tx_ring[mac_rsp->txq_idx];
+	tx_ring_desc = &tx_ring->q[mac_rsp->tid];
+	qlge_unmap_send(qdev, tx_ring_desc, tx_ring_desc->map_cnt);
+	tx_ring->tx_bytes += (tx_ring_desc->skb)->len;
+	tx_ring->tx_packets++;
+	dev_kfree_skb(tx_ring_desc->skb);
+	tx_ring_desc->skb = NULL;
+
+	if (unlikely(mac_rsp->flags1 & (OB_MAC_IOCB_RSP_E |
+					OB_MAC_IOCB_RSP_S |
+					OB_MAC_IOCB_RSP_L |
+					OB_MAC_IOCB_RSP_P | OB_MAC_IOCB_RSP_B))) {
+		if (mac_rsp->flags1 & OB_MAC_IOCB_RSP_E) {
+			netif_warn(qdev, tx_done, qdev->ndev,
+				   "Total descriptor length did not match transfer length.\n");
+		}
+		if (mac_rsp->flags1 & OB_MAC_IOCB_RSP_S) {
+			netif_warn(qdev, tx_done, qdev->ndev,
+				   "Frame too short to be valid, not sent.\n");
+		}
+		if (mac_rsp->flags1 & OB_MAC_IOCB_RSP_L) {
+			netif_warn(qdev, tx_done, qdev->ndev,
+				   "Frame too long, but sent anyway.\n");
+		}
+		if (mac_rsp->flags1 & OB_MAC_IOCB_RSP_B) {
+			netif_warn(qdev, tx_done, qdev->ndev,
+				   "PCI backplane error. Frame not sent.\n");
+		}
+	}
+	atomic_inc(&tx_ring->tx_count);
+}
+
+/* Fire up a handler to reset the MPI processor. */
+void qlge_queue_fw_error(struct qlge_adapter *qdev)
+{
+	qlge_link_off(qdev);
+	queue_delayed_work(qdev->workqueue, &qdev->mpi_reset_work, 0);
+}
+
+void qlge_queue_asic_error(struct qlge_adapter *qdev)
+{
+	qlge_link_off(qdev);
+	qlge_disable_interrupts(qdev);
+	/* Clear adapter up bit to signal the recovery
+	 * process that it shouldn't kill the reset worker
+	 * thread
+	 */
+	clear_bit(QL_ADAPTER_UP, &qdev->flags);
+	/* Set asic recovery bit to indicate reset process that we are
+	 * in fatal error recovery process rather than normal close
+	 */
+	set_bit(QL_ASIC_RECOVERY, &qdev->flags);
+	queue_delayed_work(qdev->workqueue, &qdev->asic_reset_work, 0);
+}
+
+static void qlge_process_chip_ae_intr(struct qlge_adapter *qdev,
+				      struct qlge_ib_ae_iocb_rsp *ib_ae_rsp)
+{
+	switch (ib_ae_rsp->event) {
+	case MGMT_ERR_EVENT:
+		netif_err(qdev, rx_err, qdev->ndev,
+			  "Management Processor Fatal Error.\n");
+		qlge_queue_fw_error(qdev);
+		return;
+
+	case CAM_LOOKUP_ERR_EVENT:
+		netdev_err(qdev->ndev, "Multiple CAM hits lookup occurred.\n");
+		netdev_err(qdev->ndev, "This event shouldn't occur.\n");
+		qlge_queue_asic_error(qdev);
+		return;
+
+	case SOFT_ECC_ERROR_EVENT:
+		netdev_err(qdev->ndev, "Soft ECC error detected.\n");
+		qlge_queue_asic_error(qdev);
+		break;
+
+	case PCI_ERR_ANON_BUF_RD:
+		netdev_err(qdev->ndev,
+			   "PCI error occurred when reading anonymous buffers from rx_ring %d.\n",
+			   ib_ae_rsp->q_id);
+		qlge_queue_asic_error(qdev);
+		break;
+
+	default:
+		netif_err(qdev, drv, qdev->ndev, "Unexpected event %d.\n",
+			  ib_ae_rsp->event);
+		qlge_queue_asic_error(qdev);
+		break;
+	}
+}
+
+static int qlge_clean_outbound_rx_ring(struct rx_ring *rx_ring)
+{
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	u32 prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
+	struct qlge_ob_mac_iocb_rsp *net_rsp = NULL;
+	int count = 0;
+
+	struct tx_ring *tx_ring;
+	/* While there are entries in the completion queue. */
+	while (prod != rx_ring->cnsmr_idx) {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "cq_id = %d, prod = %d, cnsmr = %d\n",
+			     rx_ring->cq_id, prod, rx_ring->cnsmr_idx);
+
+		net_rsp = (struct qlge_ob_mac_iocb_rsp *)rx_ring->curr_entry;
+		rmb();
+		switch (net_rsp->opcode) {
+		case OPCODE_OB_MAC_TSO_IOCB:
+		case OPCODE_OB_MAC_IOCB:
+			qlge_process_mac_tx_intr(qdev, net_rsp);
+			break;
+		default:
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "Hit default case, not handled! dropping the packet, opcode = %x.\n",
+				     net_rsp->opcode);
+		}
+		count++;
+		qlge_update_cq(rx_ring);
+		prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
+	}
+	if (!net_rsp)
+		return 0;
+	qlge_write_cq_idx(rx_ring);
+	tx_ring = &qdev->tx_ring[net_rsp->txq_idx];
+	if (__netif_subqueue_stopped(qdev->ndev, tx_ring->wq_id)) {
+		if ((atomic_read(&tx_ring->tx_count) > (tx_ring->wq_len / 4)))
+			/*
+			 * The queue got stopped because the tx_ring was full.
+			 * Wake it up, because it's now at least 25% empty.
+			 */
+			netif_wake_subqueue(qdev->ndev, tx_ring->wq_id);
+	}
+
+	return count;
+}
+
+static int qlge_clean_inbound_rx_ring(struct rx_ring *rx_ring, int budget)
+{
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	u32 prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
+	struct qlge_net_rsp_iocb *net_rsp;
+	int count = 0;
+
+	/* While there are entries in the completion queue. */
+	while (prod != rx_ring->cnsmr_idx) {
+		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+			     "cq_id = %d, prod = %d, cnsmr = %d\n",
+			     rx_ring->cq_id, prod, rx_ring->cnsmr_idx);
+
+		net_rsp = rx_ring->curr_entry;
+		rmb();
+		switch (net_rsp->opcode) {
+		case OPCODE_IB_MAC_IOCB:
+			qlge_process_mac_rx_intr(qdev, rx_ring,
+						 (struct qlge_ib_mac_iocb_rsp *)
+						 net_rsp);
+			break;
+
+		case OPCODE_IB_AE_IOCB:
+			qlge_process_chip_ae_intr(qdev, (struct qlge_ib_ae_iocb_rsp *)
+						  net_rsp);
+			break;
+		default:
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "Hit default case, not handled! dropping the packet, opcode = %x.\n",
+				     net_rsp->opcode);
+			break;
+		}
+		count++;
+		qlge_update_cq(rx_ring);
+		prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
+		if (count == budget)
+			break;
+	}
+	qlge_update_buffer_queues(rx_ring, GFP_ATOMIC, 0);
+	qlge_write_cq_idx(rx_ring);
+	return count;
+}
+
+static int qlge_napi_poll_msix(struct napi_struct *napi, int budget)
+{
+	struct rx_ring *rx_ring = container_of(napi, struct rx_ring, napi);
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct rx_ring *trx_ring;
+	int i, work_done = 0;
+	struct intr_context *ctx = &qdev->intr_context[rx_ring->cq_id];
+
+	netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+		     "Enter, NAPI POLL cq_id = %d.\n", rx_ring->cq_id);
+
+	/* Service the TX rings first.  They start
+	 * right after the RSS rings.
+	 */
+	for (i = qdev->rss_ring_count; i < qdev->rx_ring_count; i++) {
+		trx_ring = &qdev->rx_ring[i];
+		/* If this TX completion ring belongs to this vector and
+		 * it's not empty then service it.
+		 */
+		if ((ctx->irq_mask & (1 << trx_ring->cq_id)) &&
+		    (qlge_read_sh_reg(trx_ring->prod_idx_sh_reg) !=
+		     trx_ring->cnsmr_idx)) {
+			netif_printk(qdev, intr, KERN_DEBUG, qdev->ndev,
+				     "%s: Servicing TX completion ring %d.\n",
+				     __func__, trx_ring->cq_id);
+			qlge_clean_outbound_rx_ring(trx_ring);
+		}
+	}
+
+	/*
+	 * Now service the RSS ring if it's active.
+	 */
+	if (qlge_read_sh_reg(rx_ring->prod_idx_sh_reg) !=
+	    rx_ring->cnsmr_idx) {
+		netif_printk(qdev, intr, KERN_DEBUG, qdev->ndev,
+			     "%s: Servicing RX completion ring %d.\n",
+			     __func__, rx_ring->cq_id);
+		work_done = qlge_clean_inbound_rx_ring(rx_ring, budget);
+	}
+
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		qlge_enable_completion_interrupt(qdev, rx_ring->irq);
+	}
+	return work_done;
+}
+
+static void qlge_vlan_mode(struct net_device *ndev, netdev_features_t features)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	if (features & NETIF_F_HW_VLAN_CTAG_RX) {
+		qlge_write32(qdev, NIC_RCV_CFG, NIC_RCV_CFG_VLAN_MASK |
+			     NIC_RCV_CFG_VLAN_MATCH_AND_NON);
+	} else {
+		qlge_write32(qdev, NIC_RCV_CFG, NIC_RCV_CFG_VLAN_MASK);
+	}
+}
+
+/*
+ * qlge_update_hw_vlan_features - helper routine to reinitialize the adapter
+ * based on the features to enable/disable hardware vlan accel
+ */
+static int qlge_update_hw_vlan_features(struct net_device *ndev,
+					netdev_features_t features)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	bool need_restart = netif_running(ndev);
+	int status = 0;
+
+	if (need_restart) {
+		status = qlge_adapter_down(qdev);
+		if (status) {
+			netif_err(qdev, link, qdev->ndev,
+				  "Failed to bring down the adapter\n");
+			return status;
+		}
+	}
+
+	/* update the features with resent change */
+	ndev->features = features;
+
+	if (need_restart) {
+		status = qlge_adapter_up(qdev);
+		if (status) {
+			netif_err(qdev, link, qdev->ndev,
+				  "Failed to bring up the adapter\n");
+			return status;
+		}
+	}
+
+	return status;
+}
+
+static int qlge_set_features(struct net_device *ndev,
+			     netdev_features_t features)
+{
+	netdev_features_t changed = ndev->features ^ features;
+	int err;
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
+		/* Update the behavior of vlan accel in the adapter */
+		err = qlge_update_hw_vlan_features(ndev, features);
+		if (err)
+			return err;
+
+		qlge_vlan_mode(ndev, features);
+	}
+
+	return 0;
+}
+
+static int __qlge_vlan_rx_add_vid(struct qlge_adapter *qdev, u16 vid)
+{
+	u32 enable_bit = MAC_ADDR_E;
+	int err;
+
+	err = qlge_set_mac_addr_reg(qdev, (u8 *)&enable_bit,
+				    MAC_ADDR_TYPE_VLAN, vid);
+	if (err)
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to init vlan address.\n");
+	return err;
+}
+
+static int qlge_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	int status;
+	int err;
+
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	if (status)
+		return status;
+
+	err = __qlge_vlan_rx_add_vid(qdev, vid);
+	set_bit(vid, qdev->active_vlans);
+
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+
+	return err;
+}
+
+static int __qlge_vlan_rx_kill_vid(struct qlge_adapter *qdev, u16 vid)
+{
+	u32 enable_bit = 0;
+	int err;
+
+	err = qlge_set_mac_addr_reg(qdev, (u8 *)&enable_bit,
+				    MAC_ADDR_TYPE_VLAN, vid);
+	if (err)
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to clear vlan address.\n");
+	return err;
+}
+
+static int qlge_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	int status;
+	int err;
+
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	if (status)
+		return status;
+
+	err = __qlge_vlan_rx_kill_vid(qdev, vid);
+	clear_bit(vid, qdev->active_vlans);
+
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+
+	return err;
+}
+
+static void qlge_restore_vlan(struct qlge_adapter *qdev)
+{
+	int status;
+	u16 vid;
+
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	if (status)
+		return;
+
+	for_each_set_bit(vid, qdev->active_vlans, VLAN_N_VID)
+		__qlge_vlan_rx_add_vid(qdev, vid);
+
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+}
+
+/* MSI-X Multiple Vector Interrupt Handler for inbound completions. */
+static irqreturn_t qlge_msix_rx_isr(int irq, void *dev_id)
+{
+	struct rx_ring *rx_ring = dev_id;
+
+	napi_schedule(&rx_ring->napi);
+	return IRQ_HANDLED;
+}
+
+/* This handles a fatal error, MPI activity, and the default
+ * rx_ring in an MSI-X multiple vector environment.
+ * In MSI/Legacy environment it also process the rest of
+ * the rx_rings.
+ */
+static irqreturn_t qlge_isr(int irq, void *dev_id)
+{
+	struct rx_ring *rx_ring = dev_id;
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct intr_context *intr_context = &qdev->intr_context[0];
+	u32 var;
+	int work_done = 0;
+
+	/* Experience shows that when using INTx interrupts, interrupts must
+	 * be masked manually.
+	 * When using MSI mode, INTR_EN_EN must be explicitly disabled
+	 * (even though it is auto-masked), otherwise a later command to
+	 * enable it is not effective.
+	 */
+	if (!test_bit(QL_MSIX_ENABLED, &qdev->flags))
+		qlge_disable_completion_interrupt(qdev, 0);
+
+	var = qlge_read32(qdev, STS);
+
+	/*
+	 * Check for fatal error.
+	 */
+	if (var & STS_FE) {
+		qlge_disable_completion_interrupt(qdev, 0);
+		qlge_queue_asic_error(qdev);
+		netdev_err(qdev->ndev, "Got fatal error, STS = %x.\n", var);
+		var = qlge_read32(qdev, ERR_STS);
+		netdev_err(qdev->ndev, "Resetting chip. Error Status Register = 0x%x\n", var);
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * Check MPI processor activity.
+	 */
+	if ((var & STS_PI) &&
+	    (qlge_read32(qdev, INTR_MASK) & INTR_MASK_PI)) {
+		/*
+		 * We've got an async event or mailbox completion.
+		 * Handle it and clear the source of the interrupt.
+		 */
+		netif_err(qdev, intr, qdev->ndev,
+			  "Got MPI processor interrupt.\n");
+		qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+		queue_delayed_work_on(smp_processor_id(),
+				      qdev->workqueue, &qdev->mpi_work, 0);
+		work_done++;
+	}
+
+	/*
+	 * Get the bit-mask that shows the active queues for this
+	 * pass.  Compare it to the queues that this irq services
+	 * and call napi if there's a match.
+	 */
+	var = qlge_read32(qdev, ISR1);
+	if (var & intr_context->irq_mask) {
+		netif_info(qdev, intr, qdev->ndev,
+			   "Waking handler for rx_ring[0].\n");
+		napi_schedule(&rx_ring->napi);
+		work_done++;
+	} else {
+		/* Experience shows that the device sometimes signals an
+		 * interrupt but no work is scheduled from this function.
+		 * Nevertheless, the interrupt is auto-masked. Therefore, we
+		 * systematically re-enable the interrupt if we didn't
+		 * schedule napi.
+		 */
+		qlge_enable_completion_interrupt(qdev, 0);
+	}
+
+	return work_done ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int qlge_tso(struct sk_buff *skb, struct qlge_ob_mac_tso_iocb_req *mac_iocb_ptr)
+{
+	if (skb_is_gso(skb)) {
+		int err;
+		__be16 l3_proto = vlan_get_protocol(skb);
+
+		err = skb_cow_head(skb, 0);
+		if (err < 0)
+			return err;
+
+		mac_iocb_ptr->opcode = OPCODE_OB_MAC_TSO_IOCB;
+		mac_iocb_ptr->flags3 |= OB_MAC_TSO_IOCB_IC;
+		mac_iocb_ptr->frame_len = cpu_to_le32((u32)skb->len);
+		mac_iocb_ptr->total_hdrs_len =
+			cpu_to_le16(skb_tcp_all_headers(skb));
+		mac_iocb_ptr->net_trans_offset =
+			cpu_to_le16(skb_network_offset(skb) |
+				    skb_transport_offset(skb)
+				    << OB_MAC_TRANSPORT_HDR_SHIFT);
+		mac_iocb_ptr->mss = cpu_to_le16(skb_shinfo(skb)->gso_size);
+		mac_iocb_ptr->flags2 |= OB_MAC_TSO_IOCB_LSO;
+		if (likely(l3_proto == htons(ETH_P_IP))) {
+			struct iphdr *iph = ip_hdr(skb);
+
+			iph->check = 0;
+			mac_iocb_ptr->flags1 |= OB_MAC_TSO_IOCB_IP4;
+			tcp_hdr(skb)->check = ~csum_tcpudp_magic(iph->saddr,
+								 iph->daddr, 0,
+								 IPPROTO_TCP,
+								 0);
+		} else if (l3_proto == htons(ETH_P_IPV6)) {
+			mac_iocb_ptr->flags1 |= OB_MAC_TSO_IOCB_IP6;
+			tcp_hdr(skb)->check =
+				~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
+						 &ipv6_hdr(skb)->daddr,
+						 0, IPPROTO_TCP, 0);
+		}
+		return 1;
+	}
+	return 0;
+}
+
+static void qlge_hw_csum_setup(struct sk_buff *skb,
+			       struct qlge_ob_mac_tso_iocb_req *mac_iocb_ptr)
+{
+	int len;
+	struct iphdr *iph = ip_hdr(skb);
+	__sum16 *check;
+
+	mac_iocb_ptr->opcode = OPCODE_OB_MAC_TSO_IOCB;
+	mac_iocb_ptr->frame_len = cpu_to_le32((u32)skb->len);
+	mac_iocb_ptr->net_trans_offset =
+		cpu_to_le16(skb_network_offset(skb) |
+			    skb_transport_offset(skb) << OB_MAC_TRANSPORT_HDR_SHIFT);
+
+	mac_iocb_ptr->flags1 |= OB_MAC_TSO_IOCB_IP4;
+	len = (ntohs(iph->tot_len) - (iph->ihl << 2));
+	if (likely(iph->protocol == IPPROTO_TCP)) {
+		check = &(tcp_hdr(skb)->check);
+		mac_iocb_ptr->flags2 |= OB_MAC_TSO_IOCB_TC;
+		mac_iocb_ptr->total_hdrs_len =
+			cpu_to_le16(skb_transport_offset(skb) +
+				    (tcp_hdr(skb)->doff << 2));
+	} else {
+		check = &(udp_hdr(skb)->check);
+		mac_iocb_ptr->flags2 |= OB_MAC_TSO_IOCB_UC;
+		mac_iocb_ptr->total_hdrs_len =
+			cpu_to_le16(skb_transport_offset(skb) +
+				    sizeof(struct udphdr));
+	}
+	*check = ~csum_tcpudp_magic(iph->saddr,
+				    iph->daddr, len, iph->protocol, 0);
+}
+
+static netdev_tx_t qlge_send(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	struct qlge_ob_mac_iocb_req *mac_iocb_ptr;
+	struct tx_ring_desc *tx_ring_desc;
+	int tso;
+	struct tx_ring *tx_ring;
+	u32 tx_ring_idx = (u32)skb->queue_mapping;
+
+	tx_ring = &qdev->tx_ring[tx_ring_idx];
+
+	if (skb_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
+
+	if (unlikely(atomic_read(&tx_ring->tx_count) < 2)) {
+		netif_info(qdev, tx_queued, qdev->ndev,
+			   "%s: BUG! shutting down tx queue %d due to lack of resources.\n",
+			   __func__, tx_ring_idx);
+		netif_stop_subqueue(ndev, tx_ring->wq_id);
+		tx_ring->tx_errors++;
+		return NETDEV_TX_BUSY;
+	}
+	tx_ring_desc = &tx_ring->q[tx_ring->prod_idx];
+	mac_iocb_ptr = tx_ring_desc->queue_entry;
+	memset((void *)mac_iocb_ptr, 0, sizeof(*mac_iocb_ptr));
+
+	mac_iocb_ptr->opcode = OPCODE_OB_MAC_IOCB;
+	mac_iocb_ptr->tid = tx_ring_desc->index;
+	/* We use the upper 32-bits to store the tx queue for this IO.
+	 * When we get the completion we can use it to establish the context.
+	 */
+	mac_iocb_ptr->txq_idx = tx_ring_idx;
+	tx_ring_desc->skb = skb;
+
+	mac_iocb_ptr->frame_len = cpu_to_le16((u16)skb->len);
+
+	if (skb_vlan_tag_present(skb)) {
+		netif_printk(qdev, tx_queued, KERN_DEBUG, qdev->ndev,
+			     "Adding a vlan tag %d.\n", skb_vlan_tag_get(skb));
+		mac_iocb_ptr->flags3 |= OB_MAC_IOCB_V;
+		mac_iocb_ptr->vlan_tci = cpu_to_le16(skb_vlan_tag_get(skb));
+	}
+	tso = qlge_tso(skb, (struct qlge_ob_mac_tso_iocb_req *)mac_iocb_ptr);
+	if (tso < 0) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	} else if (unlikely(!tso) && (skb->ip_summed == CHECKSUM_PARTIAL)) {
+		qlge_hw_csum_setup(skb,
+				   (struct qlge_ob_mac_tso_iocb_req *)mac_iocb_ptr);
+	}
+	if (qlge_map_send(qdev, mac_iocb_ptr, skb, tx_ring_desc) !=
+	    NETDEV_TX_OK) {
+		netif_err(qdev, tx_queued, qdev->ndev,
+			  "Could not map the segments.\n");
+		tx_ring->tx_errors++;
+		return NETDEV_TX_BUSY;
+	}
+
+	tx_ring->prod_idx++;
+	if (tx_ring->prod_idx == tx_ring->wq_len)
+		tx_ring->prod_idx = 0;
+	wmb();
+
+	qlge_write_db_reg_relaxed(tx_ring->prod_idx, tx_ring->prod_idx_db_reg);
+	netif_printk(qdev, tx_queued, KERN_DEBUG, qdev->ndev,
+		     "tx queued, slot %d, len %d\n",
+		     tx_ring->prod_idx, skb->len);
+
+	atomic_dec(&tx_ring->tx_count);
+
+	if (unlikely(atomic_read(&tx_ring->tx_count) < 2)) {
+		netif_stop_subqueue(ndev, tx_ring->wq_id);
+		if ((atomic_read(&tx_ring->tx_count) > (tx_ring->wq_len / 4)))
+			/*
+			 * The queue got stopped because the tx_ring was full.
+			 * Wake it up, because it's now at least 25% empty.
+			 */
+			netif_wake_subqueue(qdev->ndev, tx_ring->wq_id);
+	}
+	return NETDEV_TX_OK;
+}
+
+static void qlge_free_shadow_space(struct qlge_adapter *qdev)
+{
+	if (qdev->rx_ring_shadow_reg_area) {
+		dma_free_coherent(&qdev->pdev->dev,
+				  PAGE_SIZE,
+				  qdev->rx_ring_shadow_reg_area,
+				  qdev->rx_ring_shadow_reg_dma);
+		qdev->rx_ring_shadow_reg_area = NULL;
+	}
+	if (qdev->tx_ring_shadow_reg_area) {
+		dma_free_coherent(&qdev->pdev->dev,
+				  PAGE_SIZE,
+				  qdev->tx_ring_shadow_reg_area,
+				  qdev->tx_ring_shadow_reg_dma);
+		qdev->tx_ring_shadow_reg_area = NULL;
+	}
+}
+
+static int qlge_alloc_shadow_space(struct qlge_adapter *qdev)
+{
+	qdev->rx_ring_shadow_reg_area =
+		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				   &qdev->rx_ring_shadow_reg_dma, GFP_ATOMIC);
+	if (!qdev->rx_ring_shadow_reg_area) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Allocation of RX shadow space failed.\n");
+		return -ENOMEM;
+	}
+
+	qdev->tx_ring_shadow_reg_area =
+		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				   &qdev->tx_ring_shadow_reg_dma, GFP_ATOMIC);
+	if (!qdev->tx_ring_shadow_reg_area) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Allocation of TX shadow space failed.\n");
+		goto err_wqp_sh_area;
+	}
+	return 0;
+
+err_wqp_sh_area:
+	dma_free_coherent(&qdev->pdev->dev,
+			  PAGE_SIZE,
+			  qdev->rx_ring_shadow_reg_area,
+			  qdev->rx_ring_shadow_reg_dma);
+	return -ENOMEM;
+}
+
+static void qlge_init_tx_ring(struct qlge_adapter *qdev, struct tx_ring *tx_ring)
+{
+	struct tx_ring_desc *tx_ring_desc;
+	int i;
+	struct qlge_ob_mac_iocb_req *mac_iocb_ptr;
+
+	mac_iocb_ptr = tx_ring->wq_base;
+	tx_ring_desc = tx_ring->q;
+	for (i = 0; i < tx_ring->wq_len; i++) {
+		tx_ring_desc->index = i;
+		tx_ring_desc->skb = NULL;
+		tx_ring_desc->queue_entry = mac_iocb_ptr;
+		mac_iocb_ptr++;
+		tx_ring_desc++;
+	}
+	atomic_set(&tx_ring->tx_count, tx_ring->wq_len);
+}
+
+static void qlge_free_tx_resources(struct qlge_adapter *qdev,
+				   struct tx_ring *tx_ring)
+{
+	if (tx_ring->wq_base) {
+		dma_free_coherent(&qdev->pdev->dev, tx_ring->wq_size,
+				  tx_ring->wq_base, tx_ring->wq_base_dma);
+		tx_ring->wq_base = NULL;
+	}
+	kfree(tx_ring->q);
+	tx_ring->q = NULL;
+}
+
+static int qlge_alloc_tx_resources(struct qlge_adapter *qdev,
+				   struct tx_ring *tx_ring)
+{
+	tx_ring->wq_base =
+		dma_alloc_coherent(&qdev->pdev->dev, tx_ring->wq_size,
+				   &tx_ring->wq_base_dma, GFP_ATOMIC);
+
+	if (!tx_ring->wq_base ||
+	    tx_ring->wq_base_dma & WQ_ADDR_ALIGN)
+		goto pci_alloc_err;
+
+	tx_ring->q =
+		kmalloc_array(tx_ring->wq_len, sizeof(struct tx_ring_desc),
+			      GFP_KERNEL);
+	if (!tx_ring->q)
+		goto err;
+
+	return 0;
+err:
+	dma_free_coherent(&qdev->pdev->dev, tx_ring->wq_size,
+			  tx_ring->wq_base, tx_ring->wq_base_dma);
+	tx_ring->wq_base = NULL;
+pci_alloc_err:
+	netif_err(qdev, ifup, qdev->ndev, "tx_ring alloc failed.\n");
+	return -ENOMEM;
+}
+
+static void qlge_free_lbq_buffers(struct qlge_adapter *qdev, struct rx_ring *rx_ring)
+{
+	struct qlge_bq *lbq = &rx_ring->lbq;
+	unsigned int last_offset;
+
+	last_offset = qlge_lbq_block_size(qdev) - qdev->lbq_buf_size;
+	while (lbq->next_to_clean != lbq->next_to_use) {
+		struct qlge_bq_desc *lbq_desc =
+			&lbq->queue[lbq->next_to_clean];
+
+		if (lbq_desc->p.pg_chunk.offset == last_offset)
+			dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
+				       qlge_lbq_block_size(qdev),
+				       DMA_FROM_DEVICE);
+		put_page(lbq_desc->p.pg_chunk.page);
+
+		lbq->next_to_clean = QLGE_BQ_WRAP(lbq->next_to_clean + 1);
+	}
+
+	if (rx_ring->master_chunk.page) {
+		dma_unmap_page(&qdev->pdev->dev, rx_ring->chunk_dma_addr,
+			       qlge_lbq_block_size(qdev), DMA_FROM_DEVICE);
+		put_page(rx_ring->master_chunk.page);
+		rx_ring->master_chunk.page = NULL;
+	}
+}
+
+static void qlge_free_sbq_buffers(struct qlge_adapter *qdev, struct rx_ring *rx_ring)
+{
+	int i;
+
+	for (i = 0; i < QLGE_BQ_LEN; i++) {
+		struct qlge_bq_desc *sbq_desc = &rx_ring->sbq.queue[i];
+
+		if (!sbq_desc) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "sbq_desc %d is NULL.\n", i);
+			return;
+		}
+		if (sbq_desc->p.skb) {
+			dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
+					 SMALL_BUF_MAP_SIZE,
+					 DMA_FROM_DEVICE);
+			dev_kfree_skb(sbq_desc->p.skb);
+			sbq_desc->p.skb = NULL;
+		}
+	}
+}
+
+/* Free all large and small rx buffers associated
+ * with the completion queues for this device.
+ */
+static void qlge_free_rx_buffers(struct qlge_adapter *qdev)
+{
+	int i;
+
+	for (i = 0; i < qdev->rx_ring_count; i++) {
+		struct rx_ring *rx_ring = &qdev->rx_ring[i];
+
+		if (rx_ring->lbq.queue)
+			qlge_free_lbq_buffers(qdev, rx_ring);
+		if (rx_ring->sbq.queue)
+			qlge_free_sbq_buffers(qdev, rx_ring);
+	}
+}
+
+static void qlge_alloc_rx_buffers(struct qlge_adapter *qdev)
+{
+	int i;
+
+	for (i = 0; i < qdev->rss_ring_count; i++)
+		qlge_update_buffer_queues(&qdev->rx_ring[i], GFP_KERNEL,
+					  HZ / 2);
+}
+
+static int qlge_init_bq(struct qlge_bq *bq)
+{
+	struct rx_ring *rx_ring = QLGE_BQ_CONTAINER(bq);
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct qlge_bq_desc *bq_desc;
+	__le64 *buf_ptr;
+	int i;
+
+	bq->base = dma_alloc_coherent(&qdev->pdev->dev, QLGE_BQ_SIZE,
+				      &bq->base_dma, GFP_ATOMIC);
+	if (!bq->base)
+		return -ENOMEM;
+
+	bq->queue = kmalloc_array(QLGE_BQ_LEN, sizeof(struct qlge_bq_desc),
+				  GFP_KERNEL);
+	if (!bq->queue)
+		return -ENOMEM;
+
+	buf_ptr = bq->base;
+	bq_desc = &bq->queue[0];
+	for (i = 0; i < QLGE_BQ_LEN; i++, buf_ptr++, bq_desc++) {
+		bq_desc->p.skb = NULL;
+		bq_desc->index = i;
+		bq_desc->buf_ptr = buf_ptr;
+	}
+
+	return 0;
+}
+
+static void qlge_free_rx_resources(struct qlge_adapter *qdev,
+				   struct rx_ring *rx_ring)
+{
+	/* Free the small buffer queue. */
+	if (rx_ring->sbq.base) {
+		dma_free_coherent(&qdev->pdev->dev, QLGE_BQ_SIZE,
+				  rx_ring->sbq.base, rx_ring->sbq.base_dma);
+		rx_ring->sbq.base = NULL;
+	}
+
+	/* Free the small buffer queue control blocks. */
+	kfree(rx_ring->sbq.queue);
+	rx_ring->sbq.queue = NULL;
+
+	/* Free the large buffer queue. */
+	if (rx_ring->lbq.base) {
+		dma_free_coherent(&qdev->pdev->dev, QLGE_BQ_SIZE,
+				  rx_ring->lbq.base, rx_ring->lbq.base_dma);
+		rx_ring->lbq.base = NULL;
+	}
+
+	/* Free the large buffer queue control blocks. */
+	kfree(rx_ring->lbq.queue);
+	rx_ring->lbq.queue = NULL;
+
+	/* Free the rx queue. */
+	if (rx_ring->cq_base) {
+		dma_free_coherent(&qdev->pdev->dev,
+				  rx_ring->cq_size,
+				  rx_ring->cq_base, rx_ring->cq_base_dma);
+		rx_ring->cq_base = NULL;
+	}
+}
+
+/* Allocate queues and buffers for this completions queue based
+ * on the values in the parameter structure.
+ */
+static int qlge_alloc_rx_resources(struct qlge_adapter *qdev,
+				   struct rx_ring *rx_ring)
+{
+	/*
+	 * Allocate the completion queue for this rx_ring.
+	 */
+	rx_ring->cq_base =
+		dma_alloc_coherent(&qdev->pdev->dev, rx_ring->cq_size,
+				   &rx_ring->cq_base_dma, GFP_ATOMIC);
+
+	if (!rx_ring->cq_base) {
+		netif_err(qdev, ifup, qdev->ndev, "rx_ring alloc failed.\n");
+		return -ENOMEM;
+	}
+
+	if (rx_ring->cq_id < qdev->rss_ring_count &&
+	    (qlge_init_bq(&rx_ring->sbq) || qlge_init_bq(&rx_ring->lbq))) {
+		qlge_free_rx_resources(qdev, rx_ring);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void qlge_tx_ring_clean(struct qlge_adapter *qdev)
+{
+	struct tx_ring *tx_ring;
+	struct tx_ring_desc *tx_ring_desc;
+	int i, j;
+
+	/*
+	 * Loop through all queues and free
+	 * any resources.
+	 */
+	for (j = 0; j < qdev->tx_ring_count; j++) {
+		tx_ring = &qdev->tx_ring[j];
+		for (i = 0; i < tx_ring->wq_len; i++) {
+			tx_ring_desc = &tx_ring->q[i];
+			if (tx_ring_desc && tx_ring_desc->skb) {
+				netif_err(qdev, ifdown, qdev->ndev,
+					  "Freeing lost SKB %p, from queue %d, index %d.\n",
+					  tx_ring_desc->skb, j,
+					  tx_ring_desc->index);
+				qlge_unmap_send(qdev, tx_ring_desc,
+						tx_ring_desc->map_cnt);
+				dev_kfree_skb(tx_ring_desc->skb);
+				tx_ring_desc->skb = NULL;
+			}
+		}
+	}
+}
+
+static void qlge_free_mem_resources(struct qlge_adapter *qdev)
+{
+	int i;
+
+	for (i = 0; i < qdev->tx_ring_count; i++)
+		qlge_free_tx_resources(qdev, &qdev->tx_ring[i]);
+	for (i = 0; i < qdev->rx_ring_count; i++)
+		qlge_free_rx_resources(qdev, &qdev->rx_ring[i]);
+	qlge_free_shadow_space(qdev);
+}
+
+static int qlge_alloc_mem_resources(struct qlge_adapter *qdev)
+{
+	int i;
+
+	/* Allocate space for our shadow registers and such. */
+	if (qlge_alloc_shadow_space(qdev))
+		return -ENOMEM;
+
+	for (i = 0; i < qdev->rx_ring_count; i++) {
+		if (qlge_alloc_rx_resources(qdev, &qdev->rx_ring[i]) != 0) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "RX resource allocation failed.\n");
+			goto err_mem;
+		}
+	}
+	/* Allocate tx queue resources */
+	for (i = 0; i < qdev->tx_ring_count; i++) {
+		if (qlge_alloc_tx_resources(qdev, &qdev->tx_ring[i]) != 0) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "TX resource allocation failed.\n");
+			goto err_mem;
+		}
+	}
+	return 0;
+
+err_mem:
+	qlge_free_mem_resources(qdev);
+	return -ENOMEM;
+}
+
+/* Set up the rx ring control block and pass it to the chip.
+ * The control block is defined as
+ * "Completion Queue Initialization Control Block", or cqicb.
+ */
+static int qlge_start_rx_ring(struct qlge_adapter *qdev, struct rx_ring *rx_ring)
+{
+	struct cqicb *cqicb = &rx_ring->cqicb;
+	void *shadow_reg = qdev->rx_ring_shadow_reg_area +
+		(rx_ring->cq_id * RX_RING_SHADOW_SPACE);
+	u64 shadow_reg_dma = qdev->rx_ring_shadow_reg_dma +
+		(rx_ring->cq_id * RX_RING_SHADOW_SPACE);
+	void __iomem *doorbell_area =
+		qdev->doorbell_area + (DB_PAGE_SIZE * (128 + rx_ring->cq_id));
+	int err = 0;
+	u64 dma;
+	__le64 *base_indirect_ptr;
+	int page_entries;
+
+	/* Set up the shadow registers for this ring. */
+	rx_ring->prod_idx_sh_reg = shadow_reg;
+	rx_ring->prod_idx_sh_reg_dma = shadow_reg_dma;
+	*rx_ring->prod_idx_sh_reg = 0;
+	shadow_reg += sizeof(u64);
+	shadow_reg_dma += sizeof(u64);
+	rx_ring->lbq.base_indirect = shadow_reg;
+	rx_ring->lbq.base_indirect_dma = shadow_reg_dma;
+	shadow_reg += (sizeof(u64) * MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN));
+	shadow_reg_dma += (sizeof(u64) * MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN));
+	rx_ring->sbq.base_indirect = shadow_reg;
+	rx_ring->sbq.base_indirect_dma = shadow_reg_dma;
+
+	/* PCI doorbell mem area + 0x00 for consumer index register */
+	rx_ring->cnsmr_idx_db_reg = (u32 __iomem *)doorbell_area;
+	rx_ring->cnsmr_idx = 0;
+	rx_ring->curr_entry = rx_ring->cq_base;
+
+	/* PCI doorbell mem area + 0x04 for valid register */
+	rx_ring->valid_db_reg = doorbell_area + 0x04;
+
+	/* PCI doorbell mem area + 0x18 for large buffer consumer */
+	rx_ring->lbq.prod_idx_db_reg = (u32 __iomem *)(doorbell_area + 0x18);
+
+	/* PCI doorbell mem area + 0x1c */
+	rx_ring->sbq.prod_idx_db_reg = (u32 __iomem *)(doorbell_area + 0x1c);
+
+	memset((void *)cqicb, 0, sizeof(struct cqicb));
+	cqicb->msix_vect = rx_ring->irq;
+
+	cqicb->len = cpu_to_le16(QLGE_FIT16(rx_ring->cq_len) | LEN_V |
+				 LEN_CPP_CONT);
+
+	cqicb->addr = cpu_to_le64(rx_ring->cq_base_dma);
+
+	cqicb->prod_idx_addr = cpu_to_le64(rx_ring->prod_idx_sh_reg_dma);
+
+	/*
+	 * Set up the control block load flags.
+	 */
+	cqicb->flags = FLAGS_LC |	/* Load queue base address */
+		FLAGS_LV |		/* Load MSI-X vector */
+		FLAGS_LI;		/* Load irq delay values */
+	if (rx_ring->cq_id < qdev->rss_ring_count) {
+		cqicb->flags |= FLAGS_LL;	/* Load lbq values */
+		dma = (u64)rx_ring->lbq.base_dma;
+		base_indirect_ptr = rx_ring->lbq.base_indirect;
+
+		for (page_entries = 0;
+		     page_entries < MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN);
+		     page_entries++) {
+			base_indirect_ptr[page_entries] = cpu_to_le64(dma);
+			dma += DB_PAGE_SIZE;
+		}
+		cqicb->lbq_addr = cpu_to_le64(rx_ring->lbq.base_indirect_dma);
+		cqicb->lbq_buf_size =
+			cpu_to_le16(QLGE_FIT16(qdev->lbq_buf_size));
+		cqicb->lbq_len = cpu_to_le16(QLGE_FIT16(QLGE_BQ_LEN));
+		rx_ring->lbq.next_to_use = 0;
+		rx_ring->lbq.next_to_clean = 0;
+
+		cqicb->flags |= FLAGS_LS;	/* Load sbq values */
+		dma = (u64)rx_ring->sbq.base_dma;
+		base_indirect_ptr = rx_ring->sbq.base_indirect;
+
+		for (page_entries = 0;
+		     page_entries < MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN);
+		     page_entries++) {
+			base_indirect_ptr[page_entries] = cpu_to_le64(dma);
+			dma += DB_PAGE_SIZE;
+		}
+		cqicb->sbq_addr =
+			cpu_to_le64(rx_ring->sbq.base_indirect_dma);
+		cqicb->sbq_buf_size = cpu_to_le16(SMALL_BUFFER_SIZE);
+		cqicb->sbq_len = cpu_to_le16(QLGE_FIT16(QLGE_BQ_LEN));
+		rx_ring->sbq.next_to_use = 0;
+		rx_ring->sbq.next_to_clean = 0;
+	}
+	if (rx_ring->cq_id < qdev->rss_ring_count) {
+		/* Inbound completion handling rx_rings run in
+		 * separate NAPI contexts.
+		 */
+		netif_napi_add(qdev->ndev, &rx_ring->napi,
+			       qlge_napi_poll_msix);
+		cqicb->irq_delay = cpu_to_le16(qdev->rx_coalesce_usecs);
+		cqicb->pkt_delay = cpu_to_le16(qdev->rx_max_coalesced_frames);
+	} else {
+		cqicb->irq_delay = cpu_to_le16(qdev->tx_coalesce_usecs);
+		cqicb->pkt_delay = cpu_to_le16(qdev->tx_max_coalesced_frames);
+	}
+	err = qlge_write_cfg(qdev, cqicb, sizeof(struct cqicb),
+			     CFG_LCQ, rx_ring->cq_id);
+	if (err) {
+		netif_err(qdev, ifup, qdev->ndev, "Failed to load CQICB.\n");
+		return err;
+	}
+	return err;
+}
+
+static int qlge_start_tx_ring(struct qlge_adapter *qdev, struct tx_ring *tx_ring)
+{
+	struct wqicb *wqicb = (struct wqicb *)tx_ring;
+	void __iomem *doorbell_area =
+		qdev->doorbell_area + (DB_PAGE_SIZE * tx_ring->wq_id);
+	void *shadow_reg = qdev->tx_ring_shadow_reg_area +
+		(tx_ring->wq_id * sizeof(u64));
+	u64 shadow_reg_dma = qdev->tx_ring_shadow_reg_dma +
+		(tx_ring->wq_id * sizeof(u64));
+	int err = 0;
+
+	/*
+	 * Assign doorbell registers for this tx_ring.
+	 */
+	/* TX PCI doorbell mem area for tx producer index */
+	tx_ring->prod_idx_db_reg = (u32 __iomem *)doorbell_area;
+	tx_ring->prod_idx = 0;
+	/* TX PCI doorbell mem area + 0x04 */
+	tx_ring->valid_db_reg = doorbell_area + 0x04;
+
+	/*
+	 * Assign shadow registers for this tx_ring.
+	 */
+	tx_ring->cnsmr_idx_sh_reg = shadow_reg;
+	tx_ring->cnsmr_idx_sh_reg_dma = shadow_reg_dma;
+
+	wqicb->len = cpu_to_le16(tx_ring->wq_len | Q_LEN_V | Q_LEN_CPP_CONT);
+	wqicb->flags = cpu_to_le16(Q_FLAGS_LC |
+				   Q_FLAGS_LB | Q_FLAGS_LI | Q_FLAGS_LO);
+	wqicb->cq_id_rss = cpu_to_le16(tx_ring->cq_id);
+	wqicb->rid = 0;
+	wqicb->addr = cpu_to_le64(tx_ring->wq_base_dma);
+
+	wqicb->cnsmr_idx_addr = cpu_to_le64(tx_ring->cnsmr_idx_sh_reg_dma);
+
+	qlge_init_tx_ring(qdev, tx_ring);
+
+	err = qlge_write_cfg(qdev, wqicb, sizeof(*wqicb), CFG_LRQ,
+			     (u16)tx_ring->wq_id);
+	if (err) {
+		netif_err(qdev, ifup, qdev->ndev, "Failed to load tx_ring.\n");
+		return err;
+	}
+	return err;
+}
+
+static void qlge_disable_msix(struct qlge_adapter *qdev)
+{
+	if (test_bit(QL_MSIX_ENABLED, &qdev->flags)) {
+		pci_disable_msix(qdev->pdev);
+		clear_bit(QL_MSIX_ENABLED, &qdev->flags);
+		kfree(qdev->msi_x_entry);
+		qdev->msi_x_entry = NULL;
+	} else if (test_bit(QL_MSI_ENABLED, &qdev->flags)) {
+		pci_disable_msi(qdev->pdev);
+		clear_bit(QL_MSI_ENABLED, &qdev->flags);
+	}
+}
+
+/* We start by trying to get the number of vectors
+ * stored in qdev->intr_count. If we don't get that
+ * many then we reduce the count and try again.
+ */
+static void qlge_enable_msix(struct qlge_adapter *qdev)
+{
+	int i, err;
+
+	/* Get the MSIX vectors. */
+	if (qlge_irq_type == MSIX_IRQ) {
+		/* Try to alloc space for the msix struct,
+		 * if it fails then go to MSI/legacy.
+		 */
+		qdev->msi_x_entry = kcalloc(qdev->intr_count,
+					    sizeof(struct msix_entry),
+					    GFP_KERNEL);
+		if (!qdev->msi_x_entry) {
+			qlge_irq_type = MSI_IRQ;
+			goto msi;
+		}
+
+		for (i = 0; i < qdev->intr_count; i++)
+			qdev->msi_x_entry[i].entry = i;
+
+		err = pci_enable_msix_range(qdev->pdev, qdev->msi_x_entry,
+					    1, qdev->intr_count);
+		if (err < 0) {
+			kfree(qdev->msi_x_entry);
+			qdev->msi_x_entry = NULL;
+			netif_warn(qdev, ifup, qdev->ndev,
+				   "MSI-X Enable failed, trying MSI.\n");
+			qlge_irq_type = MSI_IRQ;
+		} else {
+			qdev->intr_count = err;
+			set_bit(QL_MSIX_ENABLED, &qdev->flags);
+			netif_info(qdev, ifup, qdev->ndev,
+				   "MSI-X Enabled, got %d vectors.\n",
+				   qdev->intr_count);
+			return;
+		}
+	}
+msi:
+	qdev->intr_count = 1;
+	if (qlge_irq_type == MSI_IRQ) {
+		if (pci_alloc_irq_vectors(qdev->pdev, 1, 1, PCI_IRQ_MSI) >= 0) {
+			set_bit(QL_MSI_ENABLED, &qdev->flags);
+			netif_info(qdev, ifup, qdev->ndev,
+				   "Running with MSI interrupts.\n");
+			return;
+		}
+	}
+	qlge_irq_type = LEG_IRQ;
+	set_bit(QL_LEGACY_ENABLED, &qdev->flags);
+	netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
+		     "Running with legacy interrupts.\n");
+}
+
+/* Each vector services 1 RSS ring and 1 or more
+ * TX completion rings.  This function loops through
+ * the TX completion rings and assigns the vector that
+ * will service it.  An example would be if there are
+ * 2 vectors (so 2 RSS rings) and 8 TX completion rings.
+ * This would mean that vector 0 would service RSS ring 0
+ * and TX completion rings 0,1,2 and 3.  Vector 1 would
+ * service RSS ring 1 and TX completion rings 4,5,6 and 7.
+ */
+static void qlge_set_tx_vect(struct qlge_adapter *qdev)
+{
+	int i, j, vect;
+	u32 tx_rings_per_vector = qdev->tx_ring_count / qdev->intr_count;
+
+	if (likely(test_bit(QL_MSIX_ENABLED, &qdev->flags))) {
+		/* Assign irq vectors to TX rx_rings.*/
+		for (vect = 0, j = 0, i = qdev->rss_ring_count;
+		     i < qdev->rx_ring_count; i++) {
+			if (j == tx_rings_per_vector) {
+				vect++;
+				j = 0;
+			}
+			qdev->rx_ring[i].irq = vect;
+			j++;
+		}
+	} else {
+		/* For single vector all rings have an irq
+		 * of zero.
+		 */
+		for (i = 0; i < qdev->rx_ring_count; i++)
+			qdev->rx_ring[i].irq = 0;
+	}
+}
+
+/* Set the interrupt mask for this vector.  Each vector
+ * will service 1 RSS ring and 1 or more TX completion
+ * rings.  This function sets up a bit mask per vector
+ * that indicates which rings it services.
+ */
+static void qlge_set_irq_mask(struct qlge_adapter *qdev, struct intr_context *ctx)
+{
+	int j, vect = ctx->intr;
+	u32 tx_rings_per_vector = qdev->tx_ring_count / qdev->intr_count;
+
+	if (likely(test_bit(QL_MSIX_ENABLED, &qdev->flags))) {
+		/* Add the RSS ring serviced by this vector
+		 * to the mask.
+		 */
+		ctx->irq_mask = (1 << qdev->rx_ring[vect].cq_id);
+		/* Add the TX ring(s) serviced by this vector
+		 * to the mask.
+		 */
+		for (j = 0; j < tx_rings_per_vector; j++) {
+			ctx->irq_mask |=
+				(1 << qdev->rx_ring[qdev->rss_ring_count +
+				 (vect * tx_rings_per_vector) + j].cq_id);
+		}
+	} else {
+		/* For single vector we just shift each queue's
+		 * ID into the mask.
+		 */
+		for (j = 0; j < qdev->rx_ring_count; j++)
+			ctx->irq_mask |= (1 << qdev->rx_ring[j].cq_id);
+	}
+}
+
+/*
+ * Here we build the intr_context structures based on
+ * our rx_ring count and intr vector count.
+ * The intr_context structure is used to hook each vector
+ * to possibly different handlers.
+ */
+static void qlge_resolve_queues_to_irqs(struct qlge_adapter *qdev)
+{
+	int i = 0;
+	struct intr_context *intr_context = &qdev->intr_context[0];
+
+	if (likely(test_bit(QL_MSIX_ENABLED, &qdev->flags))) {
+		/* Each rx_ring has it's
+		 * own intr_context since we have separate
+		 * vectors for each queue.
+		 */
+		for (i = 0; i < qdev->intr_count; i++, intr_context++) {
+			qdev->rx_ring[i].irq = i;
+			intr_context->intr = i;
+			intr_context->qdev = qdev;
+			/* Set up this vector's bit-mask that indicates
+			 * which queues it services.
+			 */
+			qlge_set_irq_mask(qdev, intr_context);
+			/*
+			 * We set up each vectors enable/disable/read bits so
+			 * there's no bit/mask calculations in the critical path.
+			 */
+			intr_context->intr_en_mask =
+				INTR_EN_TYPE_MASK | INTR_EN_INTR_MASK |
+				INTR_EN_TYPE_ENABLE | INTR_EN_IHD_MASK | INTR_EN_IHD
+				| i;
+			intr_context->intr_dis_mask =
+				INTR_EN_TYPE_MASK | INTR_EN_INTR_MASK |
+				INTR_EN_TYPE_DISABLE | INTR_EN_IHD_MASK |
+				INTR_EN_IHD | i;
+			intr_context->intr_read_mask =
+				INTR_EN_TYPE_MASK | INTR_EN_INTR_MASK |
+				INTR_EN_TYPE_READ | INTR_EN_IHD_MASK | INTR_EN_IHD |
+				i;
+			if (i == 0) {
+				/* The first vector/queue handles
+				 * broadcast/multicast, fatal errors,
+				 * and firmware events.  This in addition
+				 * to normal inbound NAPI processing.
+				 */
+				intr_context->handler = qlge_isr;
+				sprintf(intr_context->name, "%s-rx-%d",
+					qdev->ndev->name, i);
+			} else {
+				/*
+				 * Inbound queues handle unicast frames only.
+				 */
+				intr_context->handler = qlge_msix_rx_isr;
+				sprintf(intr_context->name, "%s-rx-%d",
+					qdev->ndev->name, i);
+			}
+		}
+	} else {
+		/*
+		 * All rx_rings use the same intr_context since
+		 * there is only one vector.
+		 */
+		intr_context->intr = 0;
+		intr_context->qdev = qdev;
+		/*
+		 * We set up each vectors enable/disable/read bits so
+		 * there's no bit/mask calculations in the critical path.
+		 */
+		intr_context->intr_en_mask =
+			INTR_EN_TYPE_MASK | INTR_EN_INTR_MASK | INTR_EN_TYPE_ENABLE;
+		intr_context->intr_dis_mask =
+			INTR_EN_TYPE_MASK | INTR_EN_INTR_MASK |
+			INTR_EN_TYPE_DISABLE;
+		if (test_bit(QL_LEGACY_ENABLED, &qdev->flags)) {
+			/* Experience shows that when using INTx interrupts,
+			 * the device does not always auto-mask INTR_EN_EN.
+			 * Moreover, masking INTR_EN_EN manually does not
+			 * immediately prevent interrupt generation.
+			 */
+			intr_context->intr_en_mask |= INTR_EN_EI << 16 |
+				INTR_EN_EI;
+			intr_context->intr_dis_mask |= INTR_EN_EI << 16;
+		}
+		intr_context->intr_read_mask =
+			INTR_EN_TYPE_MASK | INTR_EN_INTR_MASK | INTR_EN_TYPE_READ;
+		/*
+		 * Single interrupt means one handler for all rings.
+		 */
+		intr_context->handler = qlge_isr;
+		sprintf(intr_context->name, "%s-single_irq", qdev->ndev->name);
+		/* Set up this vector's bit-mask that indicates
+		 * which queues it services. In this case there is
+		 * a single vector so it will service all RSS and
+		 * TX completion rings.
+		 */
+		qlge_set_irq_mask(qdev, intr_context);
+	}
+	/* Tell the TX completion rings which MSIx vector
+	 * they will be using.
+	 */
+	qlge_set_tx_vect(qdev);
+}
+
+static void qlge_free_irq(struct qlge_adapter *qdev)
+{
+	int i;
+	struct intr_context *intr_context = &qdev->intr_context[0];
+
+	for (i = 0; i < qdev->intr_count; i++, intr_context++) {
+		if (intr_context->hooked) {
+			if (test_bit(QL_MSIX_ENABLED, &qdev->flags)) {
+				free_irq(qdev->msi_x_entry[i].vector,
+					 &qdev->rx_ring[i]);
+			} else {
+				free_irq(qdev->pdev->irq, &qdev->rx_ring[0]);
+			}
+		}
+	}
+	qlge_disable_msix(qdev);
+}
+
+static int qlge_request_irq(struct qlge_adapter *qdev)
+{
+	int i;
+	int status = 0;
+	struct pci_dev *pdev = qdev->pdev;
+	struct intr_context *intr_context = &qdev->intr_context[0];
+
+	qlge_resolve_queues_to_irqs(qdev);
+
+	for (i = 0; i < qdev->intr_count; i++, intr_context++) {
+		if (test_bit(QL_MSIX_ENABLED, &qdev->flags)) {
+			status = request_irq(qdev->msi_x_entry[i].vector,
+					     intr_context->handler,
+					     0,
+					     intr_context->name,
+					     &qdev->rx_ring[i]);
+			if (status) {
+				netif_err(qdev, ifup, qdev->ndev,
+					  "Failed request for MSIX interrupt %d.\n",
+					  i);
+				goto err_irq;
+			}
+		} else {
+			netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
+				     "trying msi or legacy interrupts.\n");
+			netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
+				     "%s: irq = %d.\n", __func__, pdev->irq);
+			netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
+				     "%s: context->name = %s.\n", __func__,
+				     intr_context->name);
+			netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
+				     "%s: dev_id = 0x%p.\n", __func__,
+				     &qdev->rx_ring[0]);
+			status =
+				request_irq(pdev->irq, qlge_isr,
+					    test_bit(QL_MSI_ENABLED, &qdev->flags)
+					    ? 0
+					    : IRQF_SHARED,
+					    intr_context->name, &qdev->rx_ring[0]);
+			if (status)
+				goto err_irq;
+
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Hooked intr 0, queue type RX_Q, with name %s.\n",
+				  intr_context->name);
+		}
+		intr_context->hooked = 1;
+	}
+	return status;
+err_irq:
+	netif_err(qdev, ifup, qdev->ndev, "Failed to get the interrupts!!!\n");
+	qlge_free_irq(qdev);
+	return status;
+}
+
+static int qlge_start_rss(struct qlge_adapter *qdev)
+{
+	static const u8 init_hash_seed[] = {
+		0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
+		0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
+		0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
+		0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
+		0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa
+	};
+	struct ricb *ricb = &qdev->ricb;
+	int status = 0;
+	int i;
+	u8 *hash_id = (u8 *)ricb->hash_cq_id;
+
+	memset((void *)ricb, 0, sizeof(*ricb));
+
+	ricb->base_cq = RSS_L4K;
+	ricb->flags =
+		(RSS_L6K | RSS_LI | RSS_LB | RSS_LM | RSS_RT4 | RSS_RT6);
+	ricb->mask = cpu_to_le16((u16)(0x3ff));
+
+	/*
+	 * Fill out the Indirection Table.
+	 */
+	for (i = 0; i < 1024; i++)
+		hash_id[i] = (i & (qdev->rss_ring_count - 1));
+
+	memcpy((void *)&ricb->ipv6_hash_key[0], init_hash_seed, 40);
+	memcpy((void *)&ricb->ipv4_hash_key[0], init_hash_seed, 16);
+
+	status = qlge_write_cfg(qdev, ricb, sizeof(*ricb), CFG_LR, 0);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev, "Failed to load RICB.\n");
+		return status;
+	}
+	return status;
+}
+
+static int qlge_clear_routing_entries(struct qlge_adapter *qdev)
+{
+	int i, status = 0;
+
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	if (status)
+		return status;
+	/* Clear all the entries in the routing table. */
+	for (i = 0; i < 16; i++) {
+		status = qlge_set_routing_reg(qdev, i, 0, 0);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Failed to init routing register for CAM packets.\n");
+			break;
+		}
+	}
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	return status;
+}
+
+/* Initialize the frame-to-queue routing. */
+static int qlge_route_initialize(struct qlge_adapter *qdev)
+{
+	int status = 0;
+
+	/* Clear all the entries in the routing table. */
+	status = qlge_clear_routing_entries(qdev);
+	if (status)
+		return status;
+
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	if (status)
+		return status;
+
+	status = qlge_set_routing_reg(qdev, RT_IDX_IP_CSUM_ERR_SLOT,
+				      RT_IDX_IP_CSUM_ERR, 1);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to init routing register for IP CSUM error packets.\n");
+		goto exit;
+	}
+	status = qlge_set_routing_reg(qdev, RT_IDX_TCP_UDP_CSUM_ERR_SLOT,
+				      RT_IDX_TU_CSUM_ERR, 1);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to init routing register for TCP/UDP CSUM error packets.\n");
+		goto exit;
+	}
+	status = qlge_set_routing_reg(qdev, RT_IDX_BCAST_SLOT, RT_IDX_BCAST, 1);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to init routing register for broadcast packets.\n");
+		goto exit;
+	}
+	/* If we have more than one inbound queue, then turn on RSS in the
+	 * routing block.
+	 */
+	if (qdev->rss_ring_count > 1) {
+		status = qlge_set_routing_reg(qdev, RT_IDX_RSS_MATCH_SLOT,
+					      RT_IDX_RSS_MATCH, 1);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Failed to init routing register for MATCH RSS packets.\n");
+			goto exit;
+		}
+	}
+
+	status = qlge_set_routing_reg(qdev, RT_IDX_CAM_HIT_SLOT,
+				      RT_IDX_CAM_HIT, 1);
+	if (status)
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to init routing register for CAM packets.\n");
+exit:
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	return status;
+}
+
+int qlge_cam_route_initialize(struct qlge_adapter *qdev)
+{
+	int status, set;
+
+	/* If check if the link is up and use to
+	 * determine if we are setting or clearing
+	 * the MAC address in the CAM.
+	 */
+	set = qlge_read32(qdev, STS);
+	set &= qdev->port_link_up;
+	status = qlge_set_mac_addr(qdev, set);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev, "Failed to init mac address.\n");
+		return status;
+	}
+
+	status = qlge_route_initialize(qdev);
+	if (status)
+		netif_err(qdev, ifup, qdev->ndev, "Failed to init routing table.\n");
+
+	return status;
+}
+
+static int qlge_adapter_initialize(struct qlge_adapter *qdev)
+{
+	u32 value, mask;
+	int i;
+	int status = 0;
+
+	/*
+	 * Set up the System register to halt on errors.
+	 */
+	value = SYS_EFE | SYS_FAE;
+	mask = value << 16;
+	qlge_write32(qdev, SYS, mask | value);
+
+	/* Set the default queue, and VLAN behavior. */
+	value = NIC_RCV_CFG_DFQ;
+	mask = NIC_RCV_CFG_DFQ_MASK;
+	if (qdev->ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
+		value |= NIC_RCV_CFG_RV;
+		mask |= (NIC_RCV_CFG_RV << 16);
+	}
+	qlge_write32(qdev, NIC_RCV_CFG, (mask | value));
+
+	/* Set the MPI interrupt to enabled. */
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
+
+	/* Enable the function, set pagesize, enable error checking. */
+	value = FSC_FE | FSC_EPC_INBOUND | FSC_EPC_OUTBOUND |
+		FSC_EC | FSC_VM_PAGE_4K;
+	value |= SPLT_SETTING;
+
+	/* Set/clear header splitting. */
+	mask = FSC_VM_PAGESIZE_MASK |
+		FSC_DBL_MASK | FSC_DBRST_MASK | (value << 16);
+	qlge_write32(qdev, FSC, mask | value);
+
+	qlge_write32(qdev, SPLT_HDR, SPLT_LEN);
+
+	/* Set RX packet routing to use port/pci function on which the
+	 * packet arrived on in addition to usual frame routing.
+	 * This is helpful on bonding where both interfaces can have
+	 * the same MAC address.
+	 */
+	qlge_write32(qdev, RST_FO, RST_FO_RR_MASK | RST_FO_RR_RCV_FUNC_CQ);
+	/* Reroute all packets to our Interface.
+	 * They may have been routed to MPI firmware
+	 * due to WOL.
+	 */
+	value = qlge_read32(qdev, MGMT_RCV_CFG);
+	value &= ~MGMT_RCV_CFG_RM;
+	mask = 0xffff0000;
+
+	/* Sticky reg needs clearing due to WOL. */
+	qlge_write32(qdev, MGMT_RCV_CFG, mask);
+	qlge_write32(qdev, MGMT_RCV_CFG, mask | value);
+
+	/* Default WOL is enable on Mezz cards */
+	if (qdev->pdev->subsystem_device == 0x0068 ||
+	    qdev->pdev->subsystem_device == 0x0180)
+		qdev->wol = WAKE_MAGIC;
+
+	/* Start up the rx queues. */
+	for (i = 0; i < qdev->rx_ring_count; i++) {
+		status = qlge_start_rx_ring(qdev, &qdev->rx_ring[i]);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Failed to start rx ring[%d].\n", i);
+			return status;
+		}
+	}
+
+	/* If there is more than one inbound completion queue
+	 * then download a RICB to configure RSS.
+	 */
+	if (qdev->rss_ring_count > 1) {
+		status = qlge_start_rss(qdev);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev, "Failed to start RSS.\n");
+			return status;
+		}
+	}
+
+	/* Start up the tx queues. */
+	for (i = 0; i < qdev->tx_ring_count; i++) {
+		status = qlge_start_tx_ring(qdev, &qdev->tx_ring[i]);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Failed to start tx ring[%d].\n", i);
+			return status;
+		}
+	}
+
+	/* Initialize the port and set the max framesize. */
+	status = qdev->nic_ops->port_initialize(qdev);
+	if (status)
+		netif_err(qdev, ifup, qdev->ndev, "Failed to start port.\n");
+
+	/* Set up the MAC address and frame routing filter. */
+	status = qlge_cam_route_initialize(qdev);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Failed to init CAM/Routing tables.\n");
+		return status;
+	}
+
+	/* Start NAPI for the RSS queues. */
+	for (i = 0; i < qdev->rss_ring_count; i++)
+		napi_enable(&qdev->rx_ring[i].napi);
+
+	return status;
+}
+
+/* Issue soft reset to chip. */
+static int qlge_adapter_reset(struct qlge_adapter *qdev)
+{
+	u32 value;
+	int status = 0;
+	unsigned long end_jiffies;
+
+	/* Clear all the entries in the routing table. */
+	status = qlge_clear_routing_entries(qdev);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev, "Failed to clear routing bits.\n");
+		return status;
+	}
+
+	/* Check if bit is set then skip the mailbox command and
+	 * clear the bit, else we are in normal reset process.
+	 */
+	if (!test_bit(QL_ASIC_RECOVERY, &qdev->flags)) {
+		/* Stop management traffic. */
+		qlge_mb_set_mgmnt_traffic_ctl(qdev, MB_SET_MPI_TFK_STOP);
+
+		/* Wait for the NIC and MGMNT FIFOs to empty. */
+		qlge_wait_fifo_empty(qdev);
+	} else {
+		clear_bit(QL_ASIC_RECOVERY, &qdev->flags);
+	}
+
+	qlge_write32(qdev, RST_FO, (RST_FO_FR << 16) | RST_FO_FR);
+
+	end_jiffies = jiffies + usecs_to_jiffies(30);
+	do {
+		value = qlge_read32(qdev, RST_FO);
+		if ((value & RST_FO_FR) == 0)
+			break;
+		cpu_relax();
+	} while (time_before(jiffies, end_jiffies));
+
+	if (value & RST_FO_FR) {
+		netif_err(qdev, ifdown, qdev->ndev,
+			  "ETIMEDOUT!!! errored out of resetting the chip!\n");
+		status = -ETIMEDOUT;
+	}
+
+	/* Resume management traffic. */
+	qlge_mb_set_mgmnt_traffic_ctl(qdev, MB_SET_MPI_TFK_RESUME);
+	return status;
+}
+
+static void qlge_display_dev_info(struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	netif_info(qdev, probe, qdev->ndev,
+		   "Function #%d, Port %d, NIC Roll %d, NIC Rev = %d, XG Roll = %d, XG Rev = %d.\n",
+		   qdev->func,
+		   qdev->port,
+		   qdev->chip_rev_id & 0x0000000f,
+		   qdev->chip_rev_id >> 4 & 0x0000000f,
+		   qdev->chip_rev_id >> 8 & 0x0000000f,
+		   qdev->chip_rev_id >> 12 & 0x0000000f);
+	netif_info(qdev, probe, qdev->ndev,
+		   "MAC address %pM\n", ndev->dev_addr);
+}
+
+static int qlge_wol(struct qlge_adapter *qdev)
+{
+	int status = 0;
+	u32 wol = MB_WOL_DISABLE;
+
+	/* The CAM is still intact after a reset, but if we
+	 * are doing WOL, then we may need to program the
+	 * routing regs. We would also need to issue the mailbox
+	 * commands to instruct the MPI what to do per the ethtool
+	 * settings.
+	 */
+
+	if (qdev->wol & (WAKE_ARP | WAKE_MAGICSECURE | WAKE_PHY | WAKE_UCAST |
+			 WAKE_MCAST | WAKE_BCAST)) {
+		netif_err(qdev, ifdown, qdev->ndev,
+			  "Unsupported WOL parameter. qdev->wol = 0x%x.\n",
+			  qdev->wol);
+		return -EINVAL;
+	}
+
+	if (qdev->wol & WAKE_MAGIC) {
+		status = qlge_mb_wol_set_magic(qdev, 1);
+		if (status) {
+			netif_err(qdev, ifdown, qdev->ndev,
+				  "Failed to set magic packet on %s.\n",
+				  qdev->ndev->name);
+			return status;
+		}
+		netif_info(qdev, drv, qdev->ndev,
+			   "Enabled magic packet successfully on %s.\n",
+			   qdev->ndev->name);
+
+		wol |= MB_WOL_MAGIC_PKT;
+	}
+
+	if (qdev->wol) {
+		wol |= MB_WOL_MODE_ON;
+		status = qlge_mb_wol_mode(qdev, wol);
+		netif_err(qdev, drv, qdev->ndev,
+			  "WOL %s (wol code 0x%x) on %s\n",
+			  (status == 0) ? "Successfully set" : "Failed",
+			  wol, qdev->ndev->name);
+	}
+
+	return status;
+}
+
+static void qlge_cancel_all_work_sync(struct qlge_adapter *qdev)
+{
+	/* Don't kill the reset worker thread if we
+	 * are in the process of recovery.
+	 */
+	if (test_bit(QL_ADAPTER_UP, &qdev->flags))
+		cancel_delayed_work_sync(&qdev->asic_reset_work);
+	cancel_delayed_work_sync(&qdev->mpi_reset_work);
+	cancel_delayed_work_sync(&qdev->mpi_work);
+	cancel_delayed_work_sync(&qdev->mpi_idc_work);
+	cancel_delayed_work_sync(&qdev->mpi_port_cfg_work);
+}
+
+static int qlge_adapter_down(struct qlge_adapter *qdev)
+{
+	int i, status = 0;
+
+	qlge_link_off(qdev);
+
+	qlge_cancel_all_work_sync(qdev);
+
+	for (i = 0; i < qdev->rss_ring_count; i++)
+		napi_disable(&qdev->rx_ring[i].napi);
+
+	clear_bit(QL_ADAPTER_UP, &qdev->flags);
+
+	qlge_disable_interrupts(qdev);
+
+	qlge_tx_ring_clean(qdev);
+
+	/* Call netif_napi_del() from common point. */
+	for (i = 0; i < qdev->rss_ring_count; i++)
+		netif_napi_del(&qdev->rx_ring[i].napi);
+
+	status = qlge_adapter_reset(qdev);
+	if (status)
+		netif_err(qdev, ifdown, qdev->ndev, "reset(func #%d) FAILED!\n",
+			  qdev->func);
+	qlge_free_rx_buffers(qdev);
+
+	return status;
+}
+
+static int qlge_adapter_up(struct qlge_adapter *qdev)
+{
+	int err = 0;
+
+	err = qlge_adapter_initialize(qdev);
+	if (err) {
+		netif_info(qdev, ifup, qdev->ndev, "Unable to initialize adapter.\n");
+		goto err_init;
+	}
+	set_bit(QL_ADAPTER_UP, &qdev->flags);
+	qlge_alloc_rx_buffers(qdev);
+	/* If the port is initialized and the
+	 * link is up the turn on the carrier.
+	 */
+	if ((qlge_read32(qdev, STS) & qdev->port_init) &&
+	    (qlge_read32(qdev, STS) & qdev->port_link_up))
+		qlge_link_on(qdev);
+	/* Restore rx mode. */
+	clear_bit(QL_ALLMULTI, &qdev->flags);
+	clear_bit(QL_PROMISCUOUS, &qdev->flags);
+	qlge_set_multicast_list(qdev->ndev);
+
+	/* Restore vlan setting. */
+	qlge_restore_vlan(qdev);
+
+	qlge_enable_interrupts(qdev);
+	qlge_enable_all_completion_interrupts(qdev);
+	netif_tx_start_all_queues(qdev->ndev);
+
+	return 0;
+err_init:
+	qlge_adapter_reset(qdev);
+	return err;
+}
+
+static void qlge_release_adapter_resources(struct qlge_adapter *qdev)
+{
+	qlge_free_mem_resources(qdev);
+	qlge_free_irq(qdev);
+}
+
+static int qlge_get_adapter_resources(struct qlge_adapter *qdev)
+{
+	if (qlge_alloc_mem_resources(qdev)) {
+		netif_err(qdev, ifup, qdev->ndev, "Unable to  allocate memory.\n");
+		return -ENOMEM;
+	}
+	return qlge_request_irq(qdev);
+}
+
+static int qlge_close(struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	int i;
+
+	/* If we hit pci_channel_io_perm_failure
+	 * failure condition, then we already
+	 * brought the adapter down.
+	 */
+	if (test_bit(QL_EEH_FATAL, &qdev->flags)) {
+		netif_err(qdev, drv, qdev->ndev, "EEH fatal did unload.\n");
+		clear_bit(QL_EEH_FATAL, &qdev->flags);
+		return 0;
+	}
+
+	/*
+	 * Wait for device to recover from a reset.
+	 * (Rarely happens, but possible.)
+	 */
+	while (!test_bit(QL_ADAPTER_UP, &qdev->flags))
+		msleep(1);
+
+	/* Make sure refill_work doesn't re-enable napi */
+	for (i = 0; i < qdev->rss_ring_count; i++)
+		cancel_delayed_work_sync(&qdev->rx_ring[i].refill_work);
+
+	qlge_adapter_down(qdev);
+	qlge_release_adapter_resources(qdev);
+	return 0;
+}
+
+static void qlge_set_lb_size(struct qlge_adapter *qdev)
+{
+	if (qdev->ndev->mtu <= 1500)
+		qdev->lbq_buf_size = LARGE_BUFFER_MIN_SIZE;
+	else
+		qdev->lbq_buf_size = LARGE_BUFFER_MAX_SIZE;
+	qdev->lbq_buf_order = get_order(qdev->lbq_buf_size);
+}
+
+static int qlge_configure_rings(struct qlge_adapter *qdev)
+{
+	int i;
+	struct rx_ring *rx_ring;
+	struct tx_ring *tx_ring;
+	int cpu_cnt = min_t(int, MAX_CPUS, num_online_cpus());
+
+	/* In a perfect world we have one RSS ring for each CPU
+	 * and each has it's own vector.  To do that we ask for
+	 * cpu_cnt vectors.  qlge_enable_msix() will adjust the
+	 * vector count to what we actually get.  We then
+	 * allocate an RSS ring for each.
+	 * Essentially, we are doing min(cpu_count, msix_vector_count).
+	 */
+	qdev->intr_count = cpu_cnt;
+	qlge_enable_msix(qdev);
+	/* Adjust the RSS ring count to the actual vector count. */
+	qdev->rss_ring_count = qdev->intr_count;
+	qdev->tx_ring_count = cpu_cnt;
+	qdev->rx_ring_count = qdev->tx_ring_count + qdev->rss_ring_count;
+
+	for (i = 0; i < qdev->tx_ring_count; i++) {
+		tx_ring = &qdev->tx_ring[i];
+		memset((void *)tx_ring, 0, sizeof(*tx_ring));
+		tx_ring->qdev = qdev;
+		tx_ring->wq_id = i;
+		tx_ring->wq_len = qdev->tx_ring_size;
+		tx_ring->wq_size =
+			tx_ring->wq_len * sizeof(struct qlge_ob_mac_iocb_req);
+
+		/*
+		 * The completion queue ID for the tx rings start
+		 * immediately after the rss rings.
+		 */
+		tx_ring->cq_id = qdev->rss_ring_count + i;
+	}
+
+	for (i = 0; i < qdev->rx_ring_count; i++) {
+		rx_ring = &qdev->rx_ring[i];
+		memset((void *)rx_ring, 0, sizeof(*rx_ring));
+		rx_ring->qdev = qdev;
+		rx_ring->cq_id = i;
+		rx_ring->cpu = i % cpu_cnt;	/* CPU to run handler on. */
+		if (i < qdev->rss_ring_count) {
+			/*
+			 * Inbound (RSS) queues.
+			 */
+			rx_ring->cq_len = qdev->rx_ring_size;
+			rx_ring->cq_size =
+				rx_ring->cq_len * sizeof(struct qlge_net_rsp_iocb);
+			rx_ring->lbq.type = QLGE_LB;
+			rx_ring->sbq.type = QLGE_SB;
+			INIT_DELAYED_WORK(&rx_ring->refill_work,
+					  &qlge_slow_refill);
+		} else {
+			/*
+			 * Outbound queue handles outbound completions only.
+			 */
+			/* outbound cq is same size as tx_ring it services. */
+			rx_ring->cq_len = qdev->tx_ring_size;
+			rx_ring->cq_size =
+				rx_ring->cq_len * sizeof(struct qlge_net_rsp_iocb);
+		}
+	}
+	return 0;
+}
+
+static int qlge_open(struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	int err = 0;
+
+	err = qlge_adapter_reset(qdev);
+	if (err)
+		return err;
+
+	qlge_set_lb_size(qdev);
+	err = qlge_configure_rings(qdev);
+	if (err)
+		return err;
+
+	err = qlge_get_adapter_resources(qdev);
+	if (err)
+		goto error_up;
+
+	err = qlge_adapter_up(qdev);
+	if (err)
+		goto error_up;
+
+	return err;
+
+error_up:
+	qlge_release_adapter_resources(qdev);
+	return err;
+}
+
+static int qlge_change_rx_buffers(struct qlge_adapter *qdev)
+{
+	int status;
+
+	/* Wait for an outstanding reset to complete. */
+	if (!test_bit(QL_ADAPTER_UP, &qdev->flags)) {
+		int i = 4;
+
+		while (--i && !test_bit(QL_ADAPTER_UP, &qdev->flags)) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Waiting for adapter UP...\n");
+			ssleep(1);
+		}
+
+		if (!i) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Timed out waiting for adapter UP\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	status = qlge_adapter_down(qdev);
+	if (status)
+		goto error;
+
+	qlge_set_lb_size(qdev);
+
+	status = qlge_adapter_up(qdev);
+	if (status)
+		goto error;
+
+	return status;
+error:
+	netif_alert(qdev, ifup, qdev->ndev,
+		    "Driver up/down cycle failed, closing device.\n");
+	set_bit(QL_ADAPTER_UP, &qdev->flags);
+	dev_close(qdev->ndev);
+	return status;
+}
+
+static int qlge_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	int status;
+
+	if (ndev->mtu == 1500 && new_mtu == 9000)
+		netif_err(qdev, ifup, qdev->ndev, "Changing to jumbo MTU.\n");
+	else if (ndev->mtu == 9000 && new_mtu == 1500)
+		netif_err(qdev, ifup, qdev->ndev, "Changing to normal MTU.\n");
+	else
+		return -EINVAL;
+
+	queue_delayed_work(qdev->workqueue,
+			   &qdev->mpi_port_cfg_work, 3 * HZ);
+
+	ndev->mtu = new_mtu;
+
+	if (!netif_running(qdev->ndev))
+		return 0;
+
+	status = qlge_change_rx_buffers(qdev);
+	if (status) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Changing MTU failed.\n");
+	}
+
+	return status;
+}
+
+static struct net_device_stats *qlge_get_stats(struct net_device
+					       *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	struct rx_ring *rx_ring = &qdev->rx_ring[0];
+	struct tx_ring *tx_ring = &qdev->tx_ring[0];
+	unsigned long pkts, mcast, dropped, errors, bytes;
+	int i;
+
+	/* Get RX stats. */
+	pkts = mcast = dropped = errors = bytes = 0;
+	for (i = 0; i < qdev->rss_ring_count; i++, rx_ring++) {
+		pkts += rx_ring->rx_packets;
+		bytes += rx_ring->rx_bytes;
+		dropped += rx_ring->rx_dropped;
+		errors += rx_ring->rx_errors;
+		mcast += rx_ring->rx_multicast;
+	}
+	ndev->stats.rx_packets = pkts;
+	ndev->stats.rx_bytes = bytes;
+	ndev->stats.rx_dropped = dropped;
+	ndev->stats.rx_errors = errors;
+	ndev->stats.multicast = mcast;
+
+	/* Get TX stats. */
+	pkts = errors = bytes = 0;
+	for (i = 0; i < qdev->tx_ring_count; i++, tx_ring++) {
+		pkts += tx_ring->tx_packets;
+		bytes += tx_ring->tx_bytes;
+		errors += tx_ring->tx_errors;
+	}
+	ndev->stats.tx_packets = pkts;
+	ndev->stats.tx_bytes = bytes;
+	ndev->stats.tx_errors = errors;
+	return &ndev->stats;
+}
+
+static void qlge_set_multicast_list(struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	struct netdev_hw_addr *ha;
+	int i, status;
+
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	if (status)
+		return;
+	/*
+	 * Set or clear promiscuous mode if a
+	 * transition is taking place.
+	 */
+	if (ndev->flags & IFF_PROMISC) {
+		if (!test_bit(QL_PROMISCUOUS, &qdev->flags)) {
+			if (qlge_set_routing_reg
+			    (qdev, RT_IDX_PROMISCUOUS_SLOT, RT_IDX_VALID, 1)) {
+				netif_err(qdev, hw, qdev->ndev,
+					  "Failed to set promiscuous mode.\n");
+			} else {
+				set_bit(QL_PROMISCUOUS, &qdev->flags);
+			}
+		}
+	} else {
+		if (test_bit(QL_PROMISCUOUS, &qdev->flags)) {
+			if (qlge_set_routing_reg
+			    (qdev, RT_IDX_PROMISCUOUS_SLOT, RT_IDX_VALID, 0)) {
+				netif_err(qdev, hw, qdev->ndev,
+					  "Failed to clear promiscuous mode.\n");
+			} else {
+				clear_bit(QL_PROMISCUOUS, &qdev->flags);
+			}
+		}
+	}
+
+	/*
+	 * Set or clear all multicast mode if a
+	 * transition is taking place.
+	 */
+	if ((ndev->flags & IFF_ALLMULTI) ||
+	    (netdev_mc_count(ndev) > MAX_MULTICAST_ENTRIES)) {
+		if (!test_bit(QL_ALLMULTI, &qdev->flags)) {
+			if (qlge_set_routing_reg
+			    (qdev, RT_IDX_ALLMULTI_SLOT, RT_IDX_MCAST, 1)) {
+				netif_err(qdev, hw, qdev->ndev,
+					  "Failed to set all-multi mode.\n");
+			} else {
+				set_bit(QL_ALLMULTI, &qdev->flags);
+			}
+		}
+	} else {
+		if (test_bit(QL_ALLMULTI, &qdev->flags)) {
+			if (qlge_set_routing_reg
+			    (qdev, RT_IDX_ALLMULTI_SLOT, RT_IDX_MCAST, 0)) {
+				netif_err(qdev, hw, qdev->ndev,
+					  "Failed to clear all-multi mode.\n");
+			} else {
+				clear_bit(QL_ALLMULTI, &qdev->flags);
+			}
+		}
+	}
+
+	if (!netdev_mc_empty(ndev)) {
+		status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+		if (status)
+			goto exit;
+		i = 0;
+		netdev_for_each_mc_addr(ha, ndev) {
+			if (qlge_set_mac_addr_reg(qdev, (u8 *)ha->addr,
+						  MAC_ADDR_TYPE_MULTI_MAC, i)) {
+				netif_err(qdev, hw, qdev->ndev,
+					  "Failed to loadmulticast address.\n");
+				qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+				goto exit;
+			}
+			i++;
+		}
+		qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+		if (qlge_set_routing_reg
+		    (qdev, RT_IDX_MCAST_MATCH_SLOT, RT_IDX_MCAST_MATCH, 1)) {
+			netif_err(qdev, hw, qdev->ndev,
+				  "Failed to set multicast match mode.\n");
+		} else {
+			set_bit(QL_ALLMULTI, &qdev->flags);
+		}
+	}
+exit:
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
+}
+
+static int qlge_set_mac_address(struct net_device *ndev, void *p)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	struct sockaddr *addr = p;
+	int status;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+	eth_hw_addr_set(ndev, addr->sa_data);
+	/* Update local copy of current mac address. */
+	memcpy(qdev->current_mac_addr, ndev->dev_addr, ndev->addr_len);
+
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	if (status)
+		return status;
+	status = qlge_set_mac_addr_reg(qdev, (const u8 *)ndev->dev_addr,
+				       MAC_ADDR_TYPE_CAM_MAC,
+				       qdev->func * MAX_CQ);
+	if (status)
+		netif_err(qdev, hw, qdev->ndev, "Failed to load MAC address.\n");
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	return status;
+}
+
+static void qlge_tx_timeout(struct net_device *ndev, unsigned int txqueue)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+
+	qlge_queue_asic_error(qdev);
+}
+
+static void qlge_asic_reset_work(struct work_struct *work)
+{
+	struct qlge_adapter *qdev =
+		container_of(work, struct qlge_adapter, asic_reset_work.work);
+	int status;
+
+	rtnl_lock();
+	status = qlge_adapter_down(qdev);
+	if (status)
+		goto error;
+
+	status = qlge_adapter_up(qdev);
+	if (status)
+		goto error;
+
+	/* Restore rx mode. */
+	clear_bit(QL_ALLMULTI, &qdev->flags);
+	clear_bit(QL_PROMISCUOUS, &qdev->flags);
+	qlge_set_multicast_list(qdev->ndev);
+
+	rtnl_unlock();
+	return;
+error:
+	netif_alert(qdev, ifup, qdev->ndev,
+		    "Driver up/down cycle failed, closing device\n");
+
+	set_bit(QL_ADAPTER_UP, &qdev->flags);
+	dev_close(qdev->ndev);
+	rtnl_unlock();
+}
+
+static const struct nic_operations qla8012_nic_ops = {
+	.get_flash		= qlge_get_8012_flash_params,
+	.port_initialize	= qlge_8012_port_initialize,
+};
+
+static const struct nic_operations qla8000_nic_ops = {
+	.get_flash		= qlge_get_8000_flash_params,
+	.port_initialize	= qlge_8000_port_initialize,
+};
+
+/* Find the pcie function number for the other NIC
+ * on this chip.  Since both NIC functions share a
+ * common firmware we have the lowest enabled function
+ * do any common work.  Examples would be resetting
+ * after a fatal firmware error, or doing a firmware
+ * coredump.
+ */
+static int qlge_get_alt_pcie_func(struct qlge_adapter *qdev)
+{
+	int status = 0;
+	u32 temp;
+	u32 nic_func1, nic_func2;
+
+	status = qlge_read_mpi_reg(qdev, MPI_TEST_FUNC_PORT_CFG,
+				   &temp);
+	if (status)
+		return status;
+
+	nic_func1 = ((temp >> MPI_TEST_NIC1_FUNC_SHIFT) &
+		     MPI_TEST_NIC_FUNC_MASK);
+	nic_func2 = ((temp >> MPI_TEST_NIC2_FUNC_SHIFT) &
+		     MPI_TEST_NIC_FUNC_MASK);
+
+	if (qdev->func == nic_func1)
+		qdev->alt_func = nic_func2;
+	else if (qdev->func == nic_func2)
+		qdev->alt_func = nic_func1;
+	else
+		status = -EIO;
+
+	return status;
+}
+
+static int qlge_get_board_info(struct qlge_adapter *qdev)
+{
+	int status;
+
+	qdev->func =
+		(qlge_read32(qdev, STS) & STS_FUNC_ID_MASK) >> STS_FUNC_ID_SHIFT;
+	if (qdev->func > 3)
+		return -EIO;
+
+	status = qlge_get_alt_pcie_func(qdev);
+	if (status)
+		return status;
+
+	qdev->port = (qdev->func < qdev->alt_func) ? 0 : 1;
+	if (qdev->port) {
+		qdev->xg_sem_mask = SEM_XGMAC1_MASK;
+		qdev->port_link_up = STS_PL1;
+		qdev->port_init = STS_PI1;
+		qdev->mailbox_in = PROC_ADDR_MPI_RISC | PROC_ADDR_FUNC2_MBI;
+		qdev->mailbox_out = PROC_ADDR_MPI_RISC | PROC_ADDR_FUNC2_MBO;
+	} else {
+		qdev->xg_sem_mask = SEM_XGMAC0_MASK;
+		qdev->port_link_up = STS_PL0;
+		qdev->port_init = STS_PI0;
+		qdev->mailbox_in = PROC_ADDR_MPI_RISC | PROC_ADDR_FUNC0_MBI;
+		qdev->mailbox_out = PROC_ADDR_MPI_RISC | PROC_ADDR_FUNC0_MBO;
+	}
+	qdev->chip_rev_id = qlge_read32(qdev, REV_ID);
+	qdev->device_id = qdev->pdev->device;
+	if (qdev->device_id == QLGE_DEVICE_ID_8012)
+		qdev->nic_ops = &qla8012_nic_ops;
+	else if (qdev->device_id == QLGE_DEVICE_ID_8000)
+		qdev->nic_ops = &qla8000_nic_ops;
+	return status;
+}
+
+static void qlge_release_all(struct pci_dev *pdev)
+{
+	struct qlge_adapter *qdev = pci_get_drvdata(pdev);
+
+	if (qdev->workqueue) {
+		destroy_workqueue(qdev->workqueue);
+		qdev->workqueue = NULL;
+	}
+
+	if (qdev->reg_base)
+		iounmap(qdev->reg_base);
+	if (qdev->doorbell_area)
+		iounmap(qdev->doorbell_area);
+	vfree(qdev->mpi_coredump);
+	pci_release_regions(pdev);
+}
+
+static int qlge_init_device(struct pci_dev *pdev, struct qlge_adapter *qdev,
+			    int cards_found)
+{
+	struct net_device *ndev = qdev->ndev;
+	int err = 0;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "PCI device enable failed.\n");
+		return err;
+	}
+
+	qdev->pdev = pdev;
+	pci_set_drvdata(pdev, qdev);
+
+	/* Set PCIe read request size */
+	err = pcie_set_readrq(pdev, 4096);
+	if (err) {
+		dev_err(&pdev->dev, "Set readrq failed.\n");
+		goto err_disable_pci;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "PCI region request failed.\n");
+		goto err_disable_pci;
+	}
+
+	pci_set_master(pdev);
+	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
+		set_bit(QL_DMA64, &qdev->flags);
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	} else {
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		if (!err)
+			err = dma_set_coherent_mask(&pdev->dev,
+						    DMA_BIT_MASK(32));
+	}
+
+	if (err) {
+		dev_err(&pdev->dev, "No usable DMA configuration.\n");
+		goto err_release_pci;
+	}
+
+	/* Set PCIe reset type for EEH to fundamental. */
+	pdev->needs_freset = 1;
+	pci_save_state(pdev);
+	qdev->reg_base =
+		ioremap(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
+	if (!qdev->reg_base) {
+		dev_err(&pdev->dev, "Register mapping failed.\n");
+		err = -ENOMEM;
+		goto err_release_pci;
+	}
+
+	qdev->doorbell_area_size = pci_resource_len(pdev, 3);
+	qdev->doorbell_area =
+		ioremap(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
+	if (!qdev->doorbell_area) {
+		dev_err(&pdev->dev, "Doorbell register mapping failed.\n");
+		err = -ENOMEM;
+		goto err_iounmap_base;
+	}
+
+	err = qlge_get_board_info(qdev);
+	if (err) {
+		dev_err(&pdev->dev, "Register access failed.\n");
+		err = -EIO;
+		goto err_iounmap_doorbell;
+	}
+	qdev->msg_enable = netif_msg_init(debug, default_msg);
+	spin_lock_init(&qdev->stats_lock);
+
+	if (qlge_mpi_coredump) {
+		qdev->mpi_coredump =
+			vmalloc(sizeof(struct qlge_mpi_coredump));
+		if (!qdev->mpi_coredump) {
+			err = -ENOMEM;
+			goto err_iounmap_doorbell;
+		}
+		if (qlge_force_coredump)
+			set_bit(QL_FRC_COREDUMP, &qdev->flags);
+	}
+	/* make sure the EEPROM is good */
+	err = qdev->nic_ops->get_flash(qdev);
+	if (err) {
+		dev_err(&pdev->dev, "Invalid FLASH.\n");
+		goto err_free_mpi_coredump;
+	}
+
+	/* Keep local copy of current mac address. */
+	memcpy(qdev->current_mac_addr, ndev->dev_addr, ndev->addr_len);
+
+	/* Set up the default ring sizes. */
+	qdev->tx_ring_size = NUM_TX_RING_ENTRIES;
+	qdev->rx_ring_size = NUM_RX_RING_ENTRIES;
+
+	/* Set up the coalescing parameters. */
+	qdev->rx_coalesce_usecs = DFLT_COALESCE_WAIT;
+	qdev->tx_coalesce_usecs = DFLT_COALESCE_WAIT;
+	qdev->rx_max_coalesced_frames = DFLT_INTER_FRAME_WAIT;
+	qdev->tx_max_coalesced_frames = DFLT_INTER_FRAME_WAIT;
+
+	/*
+	 * Set up the operating parameters.
+	 */
+	qdev->workqueue = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM,
+						  ndev->name);
+	if (!qdev->workqueue) {
+		err = -ENOMEM;
+		goto err_free_mpi_coredump;
+	}
+
+	INIT_DELAYED_WORK(&qdev->asic_reset_work, qlge_asic_reset_work);
+	INIT_DELAYED_WORK(&qdev->mpi_reset_work, qlge_mpi_reset_work);
+	INIT_DELAYED_WORK(&qdev->mpi_work, qlge_mpi_work);
+	INIT_DELAYED_WORK(&qdev->mpi_port_cfg_work, qlge_mpi_port_cfg_work);
+	INIT_DELAYED_WORK(&qdev->mpi_idc_work, qlge_mpi_idc_work);
+	init_completion(&qdev->ide_completion);
+	mutex_init(&qdev->mpi_mutex);
+
+	if (!cards_found) {
+		dev_info(&pdev->dev, "%s\n", DRV_STRING);
+		dev_info(&pdev->dev, "Driver name: %s, Version: %s.\n",
+			 DRV_NAME, DRV_VERSION);
+	}
+	return 0;
+
+err_free_mpi_coredump:
+	vfree(qdev->mpi_coredump);
+err_iounmap_doorbell:
+	iounmap(qdev->doorbell_area);
+err_iounmap_base:
+	iounmap(qdev->reg_base);
+err_release_pci:
+	pci_release_regions(pdev);
+err_disable_pci:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static const struct net_device_ops qlge_netdev_ops = {
+	.ndo_open		= qlge_open,
+	.ndo_stop		= qlge_close,
+	.ndo_start_xmit		= qlge_send,
+	.ndo_change_mtu		= qlge_change_mtu,
+	.ndo_get_stats		= qlge_get_stats,
+	.ndo_set_rx_mode	= qlge_set_multicast_list,
+	.ndo_set_mac_address	= qlge_set_mac_address,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_tx_timeout		= qlge_tx_timeout,
+	.ndo_set_features	= qlge_set_features,
+	.ndo_vlan_rx_add_vid	= qlge_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= qlge_vlan_rx_kill_vid,
+};
+
+static void qlge_timer(struct timer_list *t)
+{
+	struct qlge_adapter *qdev = from_timer(qdev, t, timer);
+	u32 var = 0;
+
+	var = qlge_read32(qdev, STS);
+	if (pci_channel_offline(qdev->pdev)) {
+		netif_err(qdev, ifup, qdev->ndev, "EEH STS = 0x%.08x.\n", var);
+		return;
+	}
+
+	mod_timer(&qdev->timer, jiffies + (5 * HZ));
+}
+
+static const struct devlink_ops qlge_devlink_ops;
+
+static int qlge_probe(struct pci_dev *pdev,
+		      const struct pci_device_id *pci_entry)
+{
+	struct qlge_netdev_priv *ndev_priv;
+	struct qlge_adapter *qdev = NULL;
+	struct net_device *ndev = NULL;
+	struct devlink *devlink;
+	static int cards_found;
+	int err;
+
+	devlink = devlink_alloc(&qlge_devlink_ops, sizeof(struct qlge_adapter),
+				&pdev->dev);
+	if (!devlink)
+		return -ENOMEM;
+
+	qdev = devlink_priv(devlink);
+
+	ndev = alloc_etherdev_mq(sizeof(struct qlge_netdev_priv),
+				 min(MAX_CPUS,
+				     netif_get_num_default_rss_queues()));
+	if (!ndev) {
+		err = -ENOMEM;
+		goto devlink_free;
+	}
+
+	ndev_priv = netdev_priv(ndev);
+	ndev_priv->qdev = qdev;
+	ndev_priv->ndev = ndev;
+	qdev->ndev = ndev;
+	err = qlge_init_device(pdev, qdev, cards_found);
+	if (err < 0)
+		goto netdev_free;
+
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+	ndev->hw_features = NETIF_F_SG |
+		NETIF_F_IP_CSUM |
+		NETIF_F_TSO |
+		NETIF_F_TSO_ECN |
+		NETIF_F_HW_VLAN_CTAG_TX |
+		NETIF_F_HW_VLAN_CTAG_RX |
+		NETIF_F_HW_VLAN_CTAG_FILTER |
+		NETIF_F_RXCSUM;
+	ndev->features = ndev->hw_features;
+	ndev->vlan_features = ndev->hw_features;
+	/* vlan gets same features (except vlan filter) */
+	ndev->vlan_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER |
+				 NETIF_F_HW_VLAN_CTAG_TX |
+				 NETIF_F_HW_VLAN_CTAG_RX);
+
+	if (test_bit(QL_DMA64, &qdev->flags))
+		ndev->features |= NETIF_F_HIGHDMA;
+
+	/*
+	 * Set up net_device structure.
+	 */
+	ndev->tx_queue_len = qdev->tx_ring_size;
+	ndev->irq = pdev->irq;
+
+	ndev->netdev_ops = &qlge_netdev_ops;
+	ndev->ethtool_ops = &qlge_ethtool_ops;
+	ndev->watchdog_timeo = 10 * HZ;
+
+	/* MTU range: this driver only supports 1500 or 9000, so this only
+	 * filters out values above or below, and we'll rely on
+	 * qlge_change_mtu to make sure only 1500 or 9000 are allowed
+	 */
+	ndev->min_mtu = ETH_DATA_LEN;
+	ndev->max_mtu = 9000;
+
+	err = register_netdev(ndev);
+	if (err) {
+		dev_err(&pdev->dev, "net device registration failed.\n");
+		goto cleanup_pdev;
+	}
+
+	err = qlge_health_create_reporters(qdev);
+	if (err)
+		goto unregister_netdev;
+
+	/* Start up the timer to trigger EEH if
+	 * the bus goes dead
+	 */
+	timer_setup(&qdev->timer, qlge_timer, TIMER_DEFERRABLE);
+	mod_timer(&qdev->timer, jiffies + (5 * HZ));
+	qlge_link_off(qdev);
+	qlge_display_dev_info(ndev);
+	atomic_set(&qdev->lb_count, 0);
+	cards_found++;
+	devlink_register(devlink);
+	return 0;
+
+unregister_netdev:
+	unregister_netdev(ndev);
+cleanup_pdev:
+	qlge_release_all(pdev);
+	pci_disable_device(pdev);
+netdev_free:
+	free_netdev(ndev);
+devlink_free:
+	devlink_free(devlink);
+
+	return err;
+}
+
+netdev_tx_t qlge_lb_send(struct sk_buff *skb, struct net_device *ndev)
+{
+	return qlge_send(skb, ndev);
+}
+
+int qlge_clean_lb_rx_ring(struct rx_ring *rx_ring, int budget)
+{
+	return qlge_clean_inbound_rx_ring(rx_ring, budget);
+}
+
+static void qlge_remove(struct pci_dev *pdev)
+{
+	struct qlge_adapter *qdev = pci_get_drvdata(pdev);
+	struct net_device *ndev = qdev->ndev;
+	struct devlink *devlink = priv_to_devlink(qdev);
+
+	devlink_unregister(devlink);
+	del_timer_sync(&qdev->timer);
+	qlge_cancel_all_work_sync(qdev);
+	unregister_netdev(ndev);
+	qlge_release_all(pdev);
+	pci_disable_device(pdev);
+	devlink_health_reporter_destroy(qdev->reporter);
+	devlink_free(devlink);
+	free_netdev(ndev);
+}
+
+/* Clean up resources without touching hardware. */
+static void qlge_eeh_close(struct net_device *ndev)
+{
+	struct qlge_adapter *qdev = netdev_to_qdev(ndev);
+	int i;
+
+	if (netif_carrier_ok(ndev)) {
+		netif_carrier_off(ndev);
+		netif_stop_queue(ndev);
+	}
+
+	/* Disabling the timer */
+	qlge_cancel_all_work_sync(qdev);
+
+	for (i = 0; i < qdev->rss_ring_count; i++)
+		netif_napi_del(&qdev->rx_ring[i].napi);
+
+	clear_bit(QL_ADAPTER_UP, &qdev->flags);
+	qlge_tx_ring_clean(qdev);
+	qlge_free_rx_buffers(qdev);
+	qlge_release_adapter_resources(qdev);
+}
+
+/*
+ * This callback is called by the PCI subsystem whenever
+ * a PCI bus error is detected.
+ */
+static pci_ers_result_t qlge_io_error_detected(struct pci_dev *pdev,
+					       pci_channel_state_t state)
+{
+	struct qlge_adapter *qdev = pci_get_drvdata(pdev);
+	struct net_device *ndev = qdev->ndev;
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		netif_device_detach(ndev);
+		del_timer_sync(&qdev->timer);
+		if (netif_running(ndev))
+			qlge_eeh_close(ndev);
+		pci_disable_device(pdev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		dev_err(&pdev->dev,
+			"%s: pci_channel_io_perm_failure.\n", __func__);
+		del_timer_sync(&qdev->timer);
+		qlge_eeh_close(ndev);
+		set_bit(QL_EEH_FATAL, &qdev->flags);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/*
+ * This callback is called after the PCI buss has been reset.
+ * Basically, this tries to restart the card from scratch.
+ * This is a shortened version of the device probe/discovery code,
+ * it resembles the first-half of the () routine.
+ */
+static pci_ers_result_t qlge_io_slot_reset(struct pci_dev *pdev)
+{
+	struct qlge_adapter *qdev = pci_get_drvdata(pdev);
+
+	pdev->error_state = pci_channel_io_normal;
+
+	pci_restore_state(pdev);
+	if (pci_enable_device(pdev)) {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	if (qlge_adapter_reset(qdev)) {
+		netif_err(qdev, drv, qdev->ndev, "reset FAILED!\n");
+		set_bit(QL_EEH_FATAL, &qdev->flags);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void qlge_io_resume(struct pci_dev *pdev)
+{
+	struct qlge_adapter *qdev = pci_get_drvdata(pdev);
+	struct net_device *ndev = qdev->ndev;
+	int err = 0;
+
+	if (netif_running(ndev)) {
+		err = qlge_open(ndev);
+		if (err) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Device initialization failed after reset.\n");
+			return;
+		}
+	} else {
+		netif_err(qdev, ifup, qdev->ndev,
+			  "Device was not running prior to EEH.\n");
+	}
+	mod_timer(&qdev->timer, jiffies + (5 * HZ));
+	netif_device_attach(ndev);
+}
+
+static const struct pci_error_handlers qlge_err_handler = {
+	.error_detected = qlge_io_error_detected,
+	.slot_reset = qlge_io_slot_reset,
+	.resume = qlge_io_resume,
+};
+
+static int __maybe_unused qlge_suspend(struct device *dev_d)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_d);
+	struct qlge_adapter *qdev;
+	struct net_device *ndev;
+	int err;
+
+	qdev = pci_get_drvdata(pdev);
+	ndev = qdev->ndev;
+	netif_device_detach(ndev);
+	del_timer_sync(&qdev->timer);
+
+	if (netif_running(ndev)) {
+		err = qlge_adapter_down(qdev);
+		if (!err)
+			return err;
+	}
+
+	qlge_wol(qdev);
+
+	return 0;
+}
+
+static int __maybe_unused qlge_resume(struct device *dev_d)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_d);
+	struct qlge_adapter *qdev;
+	struct net_device *ndev;
+	int err;
+
+	qdev = pci_get_drvdata(pdev);
+	ndev = qdev->ndev;
+
+	pci_set_master(pdev);
+
+	device_wakeup_disable(dev_d);
+
+	if (netif_running(ndev)) {
+		err = qlge_adapter_up(qdev);
+		if (err)
+			return err;
+	}
+
+	mod_timer(&qdev->timer, jiffies + (5 * HZ));
+	netif_device_attach(ndev);
+
+	return 0;
+}
+
+static void qlge_shutdown(struct pci_dev *pdev)
+{
+	qlge_suspend(&pdev->dev);
+}
+
+static SIMPLE_DEV_PM_OPS(qlge_pm_ops, qlge_suspend, qlge_resume);
+
+static struct pci_driver qlge_driver = {
+	.name = DRV_NAME,
+	.id_table = qlge_pci_tbl,
+	.probe = qlge_probe,
+	.remove = qlge_remove,
+	.driver.pm = &qlge_pm_ops,
+	.shutdown = qlge_shutdown,
+	.err_handler = &qlge_err_handler
+};
+
+module_pci_driver(qlge_driver);
diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
new file mode 100644
index 000000000000..96a4de6d2b34
--- /dev/null
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -0,0 +1,1273 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qlge.h"
+
+int qlge_unpause_mpi_risc(struct qlge_adapter *qdev)
+{
+	u32 tmp;
+
+	/* Un-pause the RISC */
+	tmp = qlge_read32(qdev, CSR);
+	if (!(tmp & CSR_RP))
+		return -EIO;
+
+	qlge_write32(qdev, CSR, CSR_CMD_CLR_PAUSE);
+	return 0;
+}
+
+int qlge_pause_mpi_risc(struct qlge_adapter *qdev)
+{
+	u32 tmp;
+	int count;
+
+	/* Pause the RISC */
+	qlge_write32(qdev, CSR, CSR_CMD_SET_PAUSE);
+	for (count = UDELAY_COUNT; count; count--) {
+		tmp = qlge_read32(qdev, CSR);
+		if (tmp & CSR_RP)
+			break;
+		mdelay(UDELAY_DELAY);
+	}
+	return (count == 0) ? -ETIMEDOUT : 0;
+}
+
+int qlge_hard_reset_mpi_risc(struct qlge_adapter *qdev)
+{
+	u32 tmp;
+	int count;
+
+	/* Reset the RISC */
+	qlge_write32(qdev, CSR, CSR_CMD_SET_RST);
+	for (count = UDELAY_COUNT; count; count--) {
+		tmp = qlge_read32(qdev, CSR);
+		if (tmp & CSR_RR) {
+			qlge_write32(qdev, CSR, CSR_CMD_CLR_RST);
+			break;
+		}
+		mdelay(UDELAY_DELAY);
+	}
+	return (count == 0) ? -ETIMEDOUT : 0;
+}
+
+int qlge_read_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 *data)
+{
+	int status;
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	if (status)
+		goto exit;
+	/* set up for reg read */
+	qlge_write32(qdev, PROC_ADDR, reg | PROC_ADDR_R);
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	if (status)
+		goto exit;
+	/* get the data */
+	*data = qlge_read32(qdev, PROC_DATA);
+exit:
+	return status;
+}
+
+int qlge_write_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 data)
+{
+	int status = 0;
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	if (status)
+		goto exit;
+	/* write the data to the data reg */
+	qlge_write32(qdev, PROC_DATA, data);
+	/* trigger the write */
+	qlge_write32(qdev, PROC_ADDR, reg);
+	/* wait for reg to come ready */
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	if (status)
+		goto exit;
+exit:
+	return status;
+}
+
+int qlge_soft_reset_mpi_risc(struct qlge_adapter *qdev)
+{
+	return qlge_write_mpi_reg(qdev, 0x00001010, 1);
+}
+
+/* Determine if we are in charge of the firmware. If
+ * we are the lower of the 2 NIC pcie functions, or if
+ * we are the higher function and the lower function
+ * is not enabled.
+ */
+int qlge_own_firmware(struct qlge_adapter *qdev)
+{
+	u32 temp;
+
+	/* If we are the lower of the 2 NIC functions
+	 * on the chip the we are responsible for
+	 * core dump and firmware reset after an error.
+	 */
+	if (qdev->func < qdev->alt_func)
+		return 1;
+
+	/* If we are the higher of the 2 NIC functions
+	 * on the chip and the lower function is not
+	 * enabled, then we are responsible for
+	 * core dump and firmware reset after an error.
+	 */
+	temp =  qlge_read32(qdev, STS);
+	if (!(temp & (1 << (8 + qdev->alt_func))))
+		return 1;
+
+	return 0;
+}
+
+static int qlge_get_mb_sts(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int i, status;
+
+	status = qlge_sem_spinlock(qdev, SEM_PROC_REG_MASK);
+	if (status)
+		return -EBUSY;
+	for (i = 0; i < mbcp->out_count; i++) {
+		status =
+		    qlge_read_mpi_reg(qdev, qdev->mailbox_out + i,
+				      &mbcp->mbox_out[i]);
+		if (status) {
+			netif_err(qdev, drv, qdev->ndev, "Failed mailbox read.\n");
+			break;
+		}
+	}
+	qlge_sem_unlock(qdev, SEM_PROC_REG_MASK);	/* does flush too */
+	return status;
+}
+
+/* Wait for a single mailbox command to complete.
+ * Returns zero on success.
+ */
+static int qlge_wait_mbx_cmd_cmplt(struct qlge_adapter *qdev)
+{
+	int count;
+	u32 value;
+
+	for (count = 100; count; count--) {
+		value = qlge_read32(qdev, STS);
+		if (value & STS_PI)
+			return 0;
+		mdelay(UDELAY_DELAY); /* 100ms */
+	}
+	return -ETIMEDOUT;
+}
+
+/* Execute a single mailbox command.
+ * Caller must hold PROC_ADDR semaphore.
+ */
+static int qlge_exec_mb_cmd(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int i, status;
+
+	/*
+	 * Make sure there's nothing pending.
+	 * This shouldn't happen.
+	 */
+	if (qlge_read32(qdev, CSR) & CSR_HRI)
+		return -EIO;
+
+	status = qlge_sem_spinlock(qdev, SEM_PROC_REG_MASK);
+	if (status)
+		return status;
+
+	/*
+	 * Fill the outbound mailboxes.
+	 */
+	for (i = 0; i < mbcp->in_count; i++) {
+		status = qlge_write_mpi_reg(qdev, qdev->mailbox_in + i,
+					    mbcp->mbox_in[i]);
+		if (status)
+			goto end;
+	}
+	/*
+	 * Wake up the MPI firmware.
+	 */
+	qlge_write32(qdev, CSR, CSR_CMD_SET_H2R_INT);
+end:
+	qlge_sem_unlock(qdev, SEM_PROC_REG_MASK);
+	return status;
+}
+
+/* We are being asked by firmware to accept
+ * a change to the port.  This is only
+ * a change to max frame sizes (Tx/Rx), pause
+ * parameters, or loopback mode. We wake up a worker
+ * to handler processing this since a mailbox command
+ * will need to be sent to ACK the request.
+ */
+static int qlge_idc_req_aen(struct qlge_adapter *qdev)
+{
+	int status;
+	struct mbox_params *mbcp = &qdev->idc_mbc;
+
+	netif_err(qdev, drv, qdev->ndev, "Enter!\n");
+	/* Get the status data and start up a thread to
+	 * handle the request.
+	 */
+	mbcp->out_count = 4;
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Could not read MPI, resetting ASIC!\n");
+		qlge_queue_asic_error(qdev);
+	} else	{
+		/* Begin polled mode early so
+		 * we don't get another interrupt
+		 * when we leave mpi_worker.
+		 */
+		qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+		queue_delayed_work(qdev->workqueue, &qdev->mpi_idc_work, 0);
+	}
+	return status;
+}
+
+/* Process an inter-device event completion.
+ * If good, signal the caller's completion.
+ */
+static int qlge_idc_cmplt_aen(struct qlge_adapter *qdev)
+{
+	int status;
+	struct mbox_params *mbcp = &qdev->idc_mbc;
+
+	mbcp->out_count = 4;
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Could not read MPI, resetting RISC!\n");
+		qlge_queue_fw_error(qdev);
+	} else {
+		/* Wake up the sleeping mpi_idc_work thread that is
+		 * waiting for this event.
+		 */
+		complete(&qdev->ide_completion);
+	}
+	return status;
+}
+
+static void qlge_link_up(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+
+	mbcp->out_count = 2;
+
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "%s: Could not get mailbox status.\n", __func__);
+		return;
+	}
+
+	qdev->link_status = mbcp->mbox_out[1];
+	netif_err(qdev, drv, qdev->ndev, "Link Up.\n");
+
+	/* If we're coming back from an IDC event
+	 * then set up the CAM and frame routing.
+	 */
+	if (test_bit(QL_CAM_RT_SET, &qdev->flags)) {
+		status = qlge_cam_route_initialize(qdev);
+		if (status) {
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Failed to init CAM/Routing tables.\n");
+			return;
+		}
+		clear_bit(QL_CAM_RT_SET, &qdev->flags);
+	}
+
+	/* Queue up a worker to check the frame
+	 * size information, and fix it if it's not
+	 * to our liking.
+	 */
+	if (!test_bit(QL_PORT_CFG, &qdev->flags)) {
+		netif_err(qdev, drv, qdev->ndev, "Queue Port Config Worker!\n");
+		set_bit(QL_PORT_CFG, &qdev->flags);
+		/* Begin polled mode early so
+		 * we don't get another interrupt
+		 * when we leave mpi_worker dpc.
+		 */
+		qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+		queue_delayed_work(qdev->workqueue,
+				   &qdev->mpi_port_cfg_work, 0);
+	}
+
+	qlge_link_on(qdev);
+}
+
+static void qlge_link_down(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+
+	mbcp->out_count = 3;
+
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status)
+		netif_err(qdev, drv, qdev->ndev, "Link down AEN broken!\n");
+
+	qlge_link_off(qdev);
+}
+
+static int qlge_sfp_in(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+
+	mbcp->out_count = 5;
+
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status)
+		netif_err(qdev, drv, qdev->ndev, "SFP in AEN broken!\n");
+	else
+		netif_err(qdev, drv, qdev->ndev, "SFP insertion detected.\n");
+
+	return status;
+}
+
+static int qlge_sfp_out(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+
+	mbcp->out_count = 1;
+
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status)
+		netif_err(qdev, drv, qdev->ndev, "SFP out AEN broken!\n");
+	else
+		netif_err(qdev, drv, qdev->ndev, "SFP removal detected.\n");
+
+	return status;
+}
+
+static int qlge_aen_lost(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+
+	mbcp->out_count = 6;
+
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev, "Lost AEN broken!\n");
+	} else {
+		int i;
+
+		netif_err(qdev, drv, qdev->ndev, "Lost AEN detected.\n");
+		for (i = 0; i < mbcp->out_count; i++)
+			netif_err(qdev, drv, qdev->ndev, "mbox_out[%d] = 0x%.08x.\n",
+				  i, mbcp->mbox_out[i]);
+	}
+
+	return status;
+}
+
+static void qlge_init_fw_done(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+
+	mbcp->out_count = 2;
+
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev, "Firmware did not initialize!\n");
+	} else {
+		netif_err(qdev, drv, qdev->ndev, "Firmware Revision  = 0x%.08x.\n",
+			  mbcp->mbox_out[1]);
+		qdev->fw_rev_id = mbcp->mbox_out[1];
+		status = qlge_cam_route_initialize(qdev);
+		if (status)
+			netif_err(qdev, ifup, qdev->ndev,
+				  "Failed to init CAM/Routing tables.\n");
+	}
+}
+
+/* Process an async event and clear it unless it's an
+ * error condition.
+ *  This can get called iteratively from the mpi_work thread
+ *  when events arrive via an interrupt.
+ *  It also gets called when a mailbox command is polling for
+ *  it's completion.
+ */
+static int qlge_mpi_handler(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+	int orig_count = mbcp->out_count;
+
+	/* Just get mailbox zero for now. */
+	mbcp->out_count = 1;
+	status = qlge_get_mb_sts(qdev, mbcp);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Could not read MPI, resetting ASIC!\n");
+		qlge_queue_asic_error(qdev);
+		goto end;
+	}
+
+	switch (mbcp->mbox_out[0]) {
+		/* This case is only active when we arrive here
+		 * as a result of issuing a mailbox command to
+		 * the firmware.
+		 */
+	case MB_CMD_STS_INTRMDT:
+	case MB_CMD_STS_GOOD:
+	case MB_CMD_STS_INVLD_CMD:
+	case MB_CMD_STS_XFC_ERR:
+	case MB_CMD_STS_CSUM_ERR:
+	case MB_CMD_STS_ERR:
+	case MB_CMD_STS_PARAM_ERR:
+		/* We can only get mailbox status if we're polling from an
+		 * unfinished command.  Get the rest of the status data and
+		 * return back to the caller.
+		 * We only end up here when we're polling for a mailbox
+		 * command completion.
+		 */
+		mbcp->out_count = orig_count;
+		status = qlge_get_mb_sts(qdev, mbcp);
+		return status;
+
+		/* We are being asked by firmware to accept
+		 * a change to the port.  This is only
+		 * a change to max frame sizes (Tx/Rx), pause
+		 * parameters, or loopback mode.
+		 */
+	case AEN_IDC_REQ:
+		status = qlge_idc_req_aen(qdev);
+		break;
+
+		/* Process and inbound IDC event.
+		 * This will happen when we're trying to
+		 * change tx/rx max frame size, change pause
+		 * parameters or loopback mode.
+		 */
+	case AEN_IDC_CMPLT:
+	case AEN_IDC_EXT:
+		status = qlge_idc_cmplt_aen(qdev);
+		break;
+
+	case AEN_LINK_UP:
+		qlge_link_up(qdev, mbcp);
+		break;
+
+	case AEN_LINK_DOWN:
+		qlge_link_down(qdev, mbcp);
+		break;
+
+	case AEN_FW_INIT_DONE:
+		/* If we're in process on executing the firmware,
+		 * then convert the status to normal mailbox status.
+		 */
+		if (mbcp->mbox_in[0] == MB_CMD_EX_FW) {
+			mbcp->out_count = orig_count;
+			status = qlge_get_mb_sts(qdev, mbcp);
+			mbcp->mbox_out[0] = MB_CMD_STS_GOOD;
+			return status;
+		}
+		qlge_init_fw_done(qdev, mbcp);
+		break;
+
+	case AEN_AEN_SFP_IN:
+		qlge_sfp_in(qdev, mbcp);
+		break;
+
+	case AEN_AEN_SFP_OUT:
+		qlge_sfp_out(qdev, mbcp);
+		break;
+
+		/* This event can arrive at boot time or after an
+		 * MPI reset if the firmware failed to initialize.
+		 */
+	case AEN_FW_INIT_FAIL:
+		/* If we're in process on executing the firmware,
+		 * then convert the status to normal mailbox status.
+		 */
+		if (mbcp->mbox_in[0] == MB_CMD_EX_FW) {
+			mbcp->out_count = orig_count;
+			status = qlge_get_mb_sts(qdev, mbcp);
+			mbcp->mbox_out[0] = MB_CMD_STS_ERR;
+			return status;
+		}
+		netif_err(qdev, drv, qdev->ndev,
+			  "Firmware initialization failed.\n");
+		status = -EIO;
+		qlge_queue_fw_error(qdev);
+		break;
+
+	case AEN_SYS_ERR:
+		netif_err(qdev, drv, qdev->ndev, "System Error.\n");
+		qlge_queue_fw_error(qdev);
+		status = -EIO;
+		break;
+
+	case AEN_AEN_LOST:
+		qlge_aen_lost(qdev, mbcp);
+		break;
+
+	case AEN_DCBX_CHG:
+		/* Need to support AEN 8110 */
+		break;
+	default:
+		netif_err(qdev, drv, qdev->ndev,
+			  "Unsupported AE %.08x.\n", mbcp->mbox_out[0]);
+		/* Clear the MPI firmware status. */
+	}
+end:
+	qlge_write32(qdev, CSR, CSR_CMD_CLR_R2PCI_INT);
+	/* Restore the original mailbox count to
+	 * what the caller asked for.  This can get
+	 * changed when a mailbox command is waiting
+	 * for a response and an AEN arrives and
+	 * is handled.
+	 */
+	mbcp->out_count = orig_count;
+	return status;
+}
+
+/* Execute a single mailbox command.
+ * mbcp is a pointer to an array of u32.  Each
+ * element in the array contains the value for it's
+ * respective mailbox register.
+ */
+static int qlge_mailbox_command(struct qlge_adapter *qdev, struct mbox_params *mbcp)
+{
+	int status;
+	unsigned long count;
+
+	mutex_lock(&qdev->mpi_mutex);
+
+	/* Begin polled mode for MPI */
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+
+	/* Load the mailbox registers and wake up MPI RISC. */
+	status = qlge_exec_mb_cmd(qdev, mbcp);
+	if (status)
+		goto end;
+
+	/* If we're generating a system error, then there's nothing
+	 * to wait for.
+	 */
+	if (mbcp->mbox_in[0] == MB_CMD_MAKE_SYS_ERR)
+		goto end;
+
+	/* Wait for the command to complete. We loop
+	 * here because some AEN might arrive while
+	 * we're waiting for the mailbox command to
+	 * complete. If more than 5 seconds expire we can
+	 * assume something is wrong.
+	 */
+	count = jiffies + HZ * MAILBOX_TIMEOUT;
+	do {
+		/* Wait for the interrupt to come in. */
+		status = qlge_wait_mbx_cmd_cmplt(qdev);
+		if (status)
+			continue;
+
+		/* Process the event.  If it's an AEN, it
+		 * will be handled in-line or a worker
+		 * will be spawned. If it's our completion
+		 * we will catch it below.
+		 */
+		status = qlge_mpi_handler(qdev, mbcp);
+		if (status)
+			goto end;
+
+		/* It's either the completion for our mailbox
+		 * command complete or an AEN.  If it's our
+		 * completion then get out.
+		 */
+		if (((mbcp->mbox_out[0] & 0x0000f000) ==
+		     MB_CMD_STS_GOOD) ||
+		    ((mbcp->mbox_out[0] & 0x0000f000) ==
+		     MB_CMD_STS_INTRMDT))
+			goto done;
+	} while (time_before(jiffies, count));
+
+	netif_err(qdev, drv, qdev->ndev,
+		  "Timed out waiting for mailbox complete.\n");
+	status = -ETIMEDOUT;
+	goto end;
+
+done:
+
+	/* Now we can clear the interrupt condition
+	 * and look at our status.
+	 */
+	qlge_write32(qdev, CSR, CSR_CMD_CLR_R2PCI_INT);
+
+	if (((mbcp->mbox_out[0] & 0x0000f000) !=
+	     MB_CMD_STS_GOOD) &&
+	    ((mbcp->mbox_out[0] & 0x0000f000) !=
+	     MB_CMD_STS_INTRMDT)) {
+		status = -EIO;
+	}
+end:
+	/* End polled mode for MPI */
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
+	mutex_unlock(&qdev->mpi_mutex);
+	return status;
+}
+
+/* Get MPI firmware version. This will be used for
+ * driver banner and for ethtool info.
+ * Returns zero on success.
+ */
+int qlge_mb_about_fw(struct qlge_adapter *qdev)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status = 0;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 1;
+	mbcp->out_count = 3;
+
+	mbcp->mbox_in[0] = MB_CMD_ABOUT_FW;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed about firmware command\n");
+		status = -EIO;
+	}
+
+	/* Store the firmware version */
+	qdev->fw_rev_id = mbcp->mbox_out[1];
+
+	return status;
+}
+
+/* Get functional state for MPI firmware.
+ * Returns zero on success.
+ */
+int qlge_mb_get_fw_state(struct qlge_adapter *qdev)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status = 0;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 1;
+	mbcp->out_count = 2;
+
+	mbcp->mbox_in[0] = MB_CMD_GET_FW_STATE;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed Get Firmware State.\n");
+		status = -EIO;
+	}
+
+	/* If bit zero is set in mbx 1 then the firmware is
+	 * running, but not initialized.  This should never
+	 * happen.
+	 */
+	if (mbcp->mbox_out[1] & 1) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Firmware waiting for initialization.\n");
+		status = -EIO;
+	}
+
+	return status;
+}
+
+/* Send and ACK mailbox command to the firmware to
+ * let it continue with the change.
+ */
+static int qlge_mb_idc_ack(struct qlge_adapter *qdev)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status = 0;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 5;
+	mbcp->out_count = 1;
+
+	mbcp->mbox_in[0] = MB_CMD_IDC_ACK;
+	mbcp->mbox_in[1] = qdev->idc_mbc.mbox_out[1];
+	mbcp->mbox_in[2] = qdev->idc_mbc.mbox_out[2];
+	mbcp->mbox_in[3] = qdev->idc_mbc.mbox_out[3];
+	mbcp->mbox_in[4] = qdev->idc_mbc.mbox_out[4];
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev, "Failed IDC ACK send.\n");
+		status = -EIO;
+	}
+	return status;
+}
+
+/* Get link settings and maximum frame size settings
+ * for the current port.
+ * Most likely will block.
+ */
+int qlge_mb_set_port_cfg(struct qlge_adapter *qdev)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status = 0;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 3;
+	mbcp->out_count = 1;
+
+	mbcp->mbox_in[0] = MB_CMD_SET_PORT_CFG;
+	mbcp->mbox_in[1] = qdev->link_config;
+	mbcp->mbox_in[2] = qdev->max_frame_size;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] == MB_CMD_STS_INTRMDT) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Port Config sent, wait for IDC.\n");
+	} else	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed Set Port Configuration.\n");
+		status = -EIO;
+	}
+	return status;
+}
+
+static int qlge_mb_dump_ram(struct qlge_adapter *qdev, u64 req_dma, u32 addr,
+			    u32 size)
+{
+	int status = 0;
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 9;
+	mbcp->out_count = 1;
+
+	mbcp->mbox_in[0] = MB_CMD_DUMP_RISC_RAM;
+	mbcp->mbox_in[1] = LSW(addr);
+	mbcp->mbox_in[2] = MSW(req_dma);
+	mbcp->mbox_in[3] = LSW(req_dma);
+	mbcp->mbox_in[4] = MSW(size);
+	mbcp->mbox_in[5] = LSW(size);
+	mbcp->mbox_in[6] = MSW(MSD(req_dma));
+	mbcp->mbox_in[7] = LSW(MSD(req_dma));
+	mbcp->mbox_in[8] = MSW(addr);
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev, "Failed to dump risc RAM.\n");
+		status = -EIO;
+	}
+	return status;
+}
+
+/* Issue a mailbox command to dump RISC RAM. */
+int qlge_dump_risc_ram_area(struct qlge_adapter *qdev, void *buf,
+			    u32 ram_addr, int word_count)
+{
+	int status;
+	char *my_buf;
+	dma_addr_t buf_dma;
+
+	my_buf = dma_alloc_coherent(&qdev->pdev->dev,
+				    word_count * sizeof(u32), &buf_dma,
+				    GFP_ATOMIC);
+	if (!my_buf)
+		return -EIO;
+
+	status = qlge_mb_dump_ram(qdev, buf_dma, ram_addr, word_count);
+	if (!status)
+		memcpy(buf, my_buf, word_count * sizeof(u32));
+
+	dma_free_coherent(&qdev->pdev->dev, word_count * sizeof(u32), my_buf,
+			  buf_dma);
+	return status;
+}
+
+/* Get link settings and maximum frame size settings
+ * for the current port.
+ * Most likely will block.
+ */
+int qlge_mb_get_port_cfg(struct qlge_adapter *qdev)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status = 0;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 1;
+	mbcp->out_count = 3;
+
+	mbcp->mbox_in[0] = MB_CMD_GET_PORT_CFG;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed Get Port Configuration.\n");
+		status = -EIO;
+	} else	{
+		netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
+			     "Passed Get Port Configuration.\n");
+		qdev->link_config = mbcp->mbox_out[1];
+		qdev->max_frame_size = mbcp->mbox_out[2];
+	}
+	return status;
+}
+
+int qlge_mb_wol_mode(struct qlge_adapter *qdev, u32 wol)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 2;
+	mbcp->out_count = 1;
+
+	mbcp->mbox_in[0] = MB_CMD_SET_WOL_MODE;
+	mbcp->mbox_in[1] = wol;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev, "Failed to set WOL mode.\n");
+		status = -EIO;
+	}
+	return status;
+}
+
+int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status;
+	const u8 *addr = qdev->ndev->dev_addr;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 8;
+	mbcp->out_count = 1;
+
+	mbcp->mbox_in[0] = MB_CMD_SET_WOL_MAGIC;
+	if (enable_wol) {
+		mbcp->mbox_in[1] = (u32)addr[0];
+		mbcp->mbox_in[2] = (u32)addr[1];
+		mbcp->mbox_in[3] = (u32)addr[2];
+		mbcp->mbox_in[4] = (u32)addr[3];
+		mbcp->mbox_in[5] = (u32)addr[4];
+		mbcp->mbox_in[6] = (u32)addr[5];
+		mbcp->mbox_in[7] = 0;
+	} else {
+		mbcp->mbox_in[1] = 0;
+		mbcp->mbox_in[2] = 1;
+		mbcp->mbox_in[3] = 1;
+		mbcp->mbox_in[4] = 1;
+		mbcp->mbox_in[5] = 1;
+		mbcp->mbox_in[6] = 1;
+		mbcp->mbox_in[7] = 0;
+	}
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev, "Failed to set WOL mode.\n");
+		status = -EIO;
+	}
+	return status;
+}
+
+/* IDC - Inter Device Communication...
+ * Some firmware commands require consent of adjacent FCOE
+ * function.  This function waits for the OK, or a
+ * counter-request for a little more time.i
+ * The firmware will complete the request if the other
+ * function doesn't respond.
+ */
+static int qlge_idc_wait(struct qlge_adapter *qdev)
+{
+	int status = -ETIMEDOUT;
+	struct mbox_params *mbcp = &qdev->idc_mbc;
+	long wait_time;
+
+	for (wait_time = 1 * HZ; wait_time;) {
+		/* Wait here for the command to complete
+		 * via the IDC process.
+		 */
+		wait_time =
+			wait_for_completion_timeout(&qdev->ide_completion,
+						    wait_time);
+		if (!wait_time) {
+			netif_err(qdev, drv, qdev->ndev, "IDC Timeout.\n");
+			break;
+		}
+		/* Now examine the response from the IDC process.
+		 * We might have a good completion or a request for
+		 * more wait time.
+		 */
+		if (mbcp->mbox_out[0] == AEN_IDC_EXT) {
+			netif_err(qdev, drv, qdev->ndev,
+				  "IDC Time Extension from function.\n");
+			wait_time += (mbcp->mbox_out[1] >> 8) & 0x0000000f;
+		} else if (mbcp->mbox_out[0] == AEN_IDC_CMPLT) {
+			netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
+			status = 0;
+			break;
+		} else {
+			netif_err(qdev, drv, qdev->ndev,
+				  "IDC: Invalid State 0x%.04x.\n",
+				  mbcp->mbox_out[0]);
+			status = -EIO;
+			break;
+		}
+	}
+
+	return status;
+}
+
+int qlge_mb_set_led_cfg(struct qlge_adapter *qdev, u32 led_config)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 2;
+	mbcp->out_count = 1;
+
+	mbcp->mbox_in[0] = MB_CMD_SET_LED_CFG;
+	mbcp->mbox_in[1] = led_config;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed to set LED Configuration.\n");
+		status = -EIO;
+	}
+
+	return status;
+}
+
+int qlge_mb_get_led_cfg(struct qlge_adapter *qdev)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 1;
+	mbcp->out_count = 2;
+
+	mbcp->mbox_in[0] = MB_CMD_GET_LED_CFG;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] != MB_CMD_STS_GOOD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed to get LED Configuration.\n");
+		status = -EIO;
+	} else {
+		qdev->led_config = mbcp->mbox_out[1];
+	}
+	return status;
+}
+
+int qlge_mb_set_mgmnt_traffic_ctl(struct qlge_adapter *qdev, u32 control)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+
+	mbcp->in_count = 1;
+	mbcp->out_count = 2;
+
+	mbcp->mbox_in[0] = MB_CMD_SET_MGMNT_TFK_CTL;
+	mbcp->mbox_in[1] = control;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] == MB_CMD_STS_GOOD)
+		return status;
+
+	if (mbcp->mbox_out[0] == MB_CMD_STS_INVLD_CMD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Command not supported by firmware.\n");
+		status = -EINVAL;
+	} else if (mbcp->mbox_out[0] == MB_CMD_STS_ERR) {
+		/* This indicates that the firmware is
+		 * already in the state we are trying to
+		 * change it to.
+		 */
+		netif_err(qdev, drv, qdev->ndev,
+			  "Command parameters make no change.\n");
+	}
+	return status;
+}
+
+/* Returns a negative error code or the mailbox command status. */
+static int qlge_mb_get_mgmnt_traffic_ctl(struct qlge_adapter *qdev, u32 *control)
+{
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int status;
+
+	memset(mbcp, 0, sizeof(struct mbox_params));
+	*control = 0;
+
+	mbcp->in_count = 1;
+	mbcp->out_count = 1;
+
+	mbcp->mbox_in[0] = MB_CMD_GET_MGMNT_TFK_CTL;
+
+	status = qlge_mailbox_command(qdev, mbcp);
+	if (status)
+		return status;
+
+	if (mbcp->mbox_out[0] == MB_CMD_STS_GOOD) {
+		*control = mbcp->mbox_in[1];
+		return status;
+	}
+
+	if (mbcp->mbox_out[0] == MB_CMD_STS_INVLD_CMD) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Command not supported by firmware.\n");
+		status = -EINVAL;
+	} else if (mbcp->mbox_out[0] == MB_CMD_STS_ERR) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Failed to get MPI traffic control.\n");
+		status = -EIO;
+	}
+	return status;
+}
+
+int qlge_wait_fifo_empty(struct qlge_adapter *qdev)
+{
+	int count;
+	u32 mgmnt_fifo_empty;
+	u32 nic_fifo_empty;
+
+	for (count = 6; count; count--) {
+		nic_fifo_empty = qlge_read32(qdev, STS) & STS_NFE;
+		qlge_mb_get_mgmnt_traffic_ctl(qdev, &mgmnt_fifo_empty);
+		mgmnt_fifo_empty &= MB_GET_MPI_TFK_FIFO_EMPTY;
+		if (nic_fifo_empty && mgmnt_fifo_empty)
+			return 0;
+		msleep(100);
+	}
+	return -ETIMEDOUT;
+}
+
+/* API called in work thread context to set new TX/RX
+ * maximum frame size values to match MTU.
+ */
+static int qlge_set_port_cfg(struct qlge_adapter *qdev)
+{
+	int status;
+
+	status = qlge_mb_set_port_cfg(qdev);
+	if (status)
+		return status;
+	status = qlge_idc_wait(qdev);
+	return status;
+}
+
+/* The following routines are worker threads that process
+ * events that may sleep waiting for completion.
+ */
+
+/* This thread gets the maximum TX and RX frame size values
+ * from the firmware and, if necessary, changes them to match
+ * the MTU setting.
+ */
+void qlge_mpi_port_cfg_work(struct work_struct *work)
+{
+	struct qlge_adapter *qdev =
+		container_of(work, struct qlge_adapter, mpi_port_cfg_work.work);
+	int status;
+
+	status = qlge_mb_get_port_cfg(qdev);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Bug: Failed to get port config data.\n");
+		goto err;
+	}
+
+	if (qdev->link_config & CFG_JUMBO_FRAME_SIZE &&
+	    qdev->max_frame_size == CFG_DEFAULT_MAX_FRAME_SIZE)
+		goto end;
+
+	qdev->link_config |=	CFG_JUMBO_FRAME_SIZE;
+	qdev->max_frame_size = CFG_DEFAULT_MAX_FRAME_SIZE;
+	status = qlge_set_port_cfg(qdev);
+	if (status) {
+		netif_err(qdev, drv, qdev->ndev,
+			  "Bug: Failed to set port config data.\n");
+		goto err;
+	}
+end:
+	clear_bit(QL_PORT_CFG, &qdev->flags);
+	return;
+err:
+	qlge_queue_fw_error(qdev);
+	goto end;
+}
+
+/* Process an inter-device request.  This is issues by
+ * the firmware in response to another function requesting
+ * a change to the port. We set a flag to indicate a change
+ * has been made and then send a mailbox command ACKing
+ * the change request.
+ */
+void qlge_mpi_idc_work(struct work_struct *work)
+{
+	struct qlge_adapter *qdev =
+		container_of(work, struct qlge_adapter, mpi_idc_work.work);
+	int status;
+	struct mbox_params *mbcp = &qdev->idc_mbc;
+	u32 aen;
+	int timeout;
+
+	aen = mbcp->mbox_out[1] >> 16;
+	timeout = (mbcp->mbox_out[1] >> 8) & 0xf;
+
+	switch (aen) {
+	default:
+		netif_err(qdev, drv, qdev->ndev,
+			  "Bug: Unhandled IDC action.\n");
+		break;
+	case MB_CMD_PORT_RESET:
+	case MB_CMD_STOP_FW:
+		qlge_link_off(qdev);
+		fallthrough;
+	case MB_CMD_SET_PORT_CFG:
+		/* Signal the resulting link up AEN
+		 * that the frame routing and mac addr
+		 * needs to be set.
+		 */
+		set_bit(QL_CAM_RT_SET, &qdev->flags);
+		/* Do ACK if required */
+		if (timeout) {
+			status = qlge_mb_idc_ack(qdev);
+			if (status)
+				netif_err(qdev, drv, qdev->ndev,
+					  "Bug: No pending IDC!\n");
+		} else {
+			netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
+				     "IDC ACK not required\n");
+			status = 0; /* success */
+		}
+		break;
+
+		/* These sub-commands issued by another (FCoE)
+		 * function are requesting to do an operation
+		 * on the shared resource (MPI environment).
+		 * We currently don't issue these so we just
+		 * ACK the request.
+		 */
+	case MB_CMD_IOP_RESTART_MPI:
+	case MB_CMD_IOP_PREP_LINK_DOWN:
+		/* Drop the link, reload the routing
+		 * table when link comes up.
+		 */
+		qlge_link_off(qdev);
+		set_bit(QL_CAM_RT_SET, &qdev->flags);
+		fallthrough;
+	case MB_CMD_IOP_DVR_START:
+	case MB_CMD_IOP_FLASH_ACC:
+	case MB_CMD_IOP_CORE_DUMP_MPI:
+	case MB_CMD_IOP_PREP_UPDATE_MPI:
+	case MB_CMD_IOP_COMP_UPDATE_MPI:
+	case MB_CMD_IOP_NONE:	/*  an IDC without params */
+		/* Do ACK if required */
+		if (timeout) {
+			status = qlge_mb_idc_ack(qdev);
+			if (status)
+				netif_err(qdev, drv, qdev->ndev,
+					  "Bug: No pending IDC!\n");
+		} else {
+			netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
+				     "IDC ACK not required\n");
+			status = 0; /* success */
+		}
+		break;
+	}
+}
+
+void qlge_mpi_work(struct work_struct *work)
+{
+	struct qlge_adapter *qdev =
+		container_of(work, struct qlge_adapter, mpi_work.work);
+	struct mbox_params mbc;
+	struct mbox_params *mbcp = &mbc;
+	int err = 0;
+
+	mutex_lock(&qdev->mpi_mutex);
+	/* Begin polled mode for MPI */
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+
+	while (qlge_read32(qdev, STS) & STS_PI) {
+		memset(mbcp, 0, sizeof(struct mbox_params));
+		mbcp->out_count = 1;
+		/* Don't continue if an async event
+		 * did not complete properly.
+		 */
+		err = qlge_mpi_handler(qdev, mbcp);
+		if (err)
+			break;
+	}
+
+	/* End polled mode for MPI */
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
+	mutex_unlock(&qdev->mpi_mutex);
+}
+
+void qlge_mpi_reset_work(struct work_struct *work)
+{
+	struct qlge_adapter *qdev =
+		container_of(work, struct qlge_adapter, mpi_reset_work.work);
+	cancel_delayed_work_sync(&qdev->mpi_work);
+	cancel_delayed_work_sync(&qdev->mpi_port_cfg_work);
+	cancel_delayed_work_sync(&qdev->mpi_idc_work);
+	/* If we're not the dominant NIC function,
+	 * then there is nothing to do.
+	 */
+	if (!qlge_own_firmware(qdev)) {
+		netif_err(qdev, drv, qdev->ndev, "Don't own firmware!\n");
+		return;
+	}
+
+	qlge_soft_reset_mpi_risc(qdev);
+}
-- 
2.42.0

