Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C204A7C00E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjJJP5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJJP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:57:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E293;
        Tue, 10 Oct 2023 08:57:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DA7C433C7;
        Tue, 10 Oct 2023 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953454;
        bh=zfY6msBP5aRdpz2j74zGaeZjraK9nc1YJksJpF44//M=;
        h=From:To:Cc:Subject:Date:From;
        b=ul1qN8FckCpogFnrLfaRUJsYRE1jj8uswkXTnfWBgBeIAMBr4Qduf0EaSLQEbJEb1
         uDTXXog/iVBY2ymSuqk+PVVzTB9WOgoY/pvk2Fx6l77Hvl4XIV5lL6GRf/r9VEnVHV
         TjVGx7Ood720K95NGtHTMgGmkoZXKQZnZerFy+dQAaV0i/zVH4tcqdJ+G1tj0oMCy4
         E5XJGCgd/uPxwzVBmwu6ooPBCQi1j7su6/UdF5j+iWLJjNeXm2qMuHYE72gtgylo6y
         gtgOOENjf+ZSHq3+uMnaJ6BNKv+/TPksXVkP7gTDxm2g7omzh7XRXBUhCzyeSlBpPN
         tkjGptJiMhRlA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: [PATCH] [RFC] wireless: move obsolete drivers to staging
Date:   Tue, 10 Oct 2023 17:27:29 +0200
Message-Id: <20231010155444.858483-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While looking at the old drivers using the obsolete .ndo_do_ioctl()
callback, I found a number of network drivers that are especially
obsolete, in particular for 802.11b (11Mbit/s) or even older wireless
networks, using non-busmaster ISA/PCMCIA style bus interfaces, and using
the legacy wireless extension ioctls rather than the netlink interfaces
that were meant to replace them in 2007. All of these drivers are
obsolete or orphaned.

We had previously discussed this topic, but nobody ever moved the
files, so I now went through the list to my best knowledge. These
are the drivers that I would classify as "probably unused" by now:

 - Atmel at76c502/at76c504/at76c506 is a PIO-only (PCMCIA, mini-PCI
   and Cardbus) 802.11b driver with incomplete CFG80211 support.
   The related at76c50x USB driver uses MAC80211 and remains.

 - Cisco Aironet is an 802.11b PCMCIA and mini-PCI with limited support
   for Cardbus DMA and for CFG80211.

 - HostAP is an ISA/PCMCIA style 802.11b driver supporting only
   wireless extensions, and some custom ioctls (already removed).
   Some devices include a legacy PCI bridge but no DMA.

 - Aviator/Raytheon is an early PCMCIA driver, apparently predating
   802.11b and only supporting wireless extensions.

 - Planet WL3501 is another PCMCIA driver for pre-802.11b interfaces
   (2Mbit/s) with incomplete CFG80211 support

 - Zydas zd1201 is a USB 802.11b driver with limited support for
   CFG80211.

 - Orinoco is a PIO-only ISA/PCMCIA 802.11b device with extra bus
   interface connections for PCI/Cardbus/mini-PCI and a few
   pre-2002 Apple PowerMac variants. It supports both
   wireless extensions and CFG80211, but I could not tell if
   it requires using both.

 - Wireless RNDIS USB is a new-style CFG80211 driver for 802.11b
   and 802.11g USB hardware from around 2004 to 2006. This makes it
   more modern than any of the others, but Kalle already classified
   it as "legacy" in commit 298e50ad8eb8f ("wifi: move raycs, wl3501
   and rndis_wlan to legacy directory"), so it stays with ray_cs and
   wl3501_cs.

There are a few other drivers that are similar to these but that are
more likely to still be needed, and are not moved here:

 - Intel ipw2x00 is a PCI bus-master device for 802.11a/b/g that was
   popular in "Centrino" branded laptops from 2003 to 2005, but it
   still requires wireless extensions.

 - Marvell Libertas is an 802.11a/b/g device with a number of bus
   interfaces (USB, SDIO, SPI, PCMCIA) and incomplete CFG80211
   support. This one was used in the OLPC XO laptop and some other
   embedded devices that are still supported.

 - Some broadcom b43xx devices use the SSB bus that can be abstracted
   through PCMCIA. All of them use CFG80211.

 - The Sony Playstation 3 "gelic" ethernet driver contains a bridge
   and an 802.11b/g client chip that is controlled through a hypervisor
   interface from the OS, and it uses wireless extensions in the kernel
   driver.

Link: https://lore.kernel.org/all/87imaeg4ar.fsf@codeaurora.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm mainly taking educated guesses about which drivers are actually
obsolete. Let me know if I got any of them wrong, or if any others
should be included here.

I did not move the staging drivers for ks7010, rtl8192e, rtl8192u,
rtl8712, rtl8723bs, vt6656 or wlan-ng into driver/staging/wireless,
as they are already directly under drivers/staging, but that could
be another patch if we want to keep them all in one place.
---
 MAINTAINERS                                   | 16 ++++-----
 drivers/net/wireless/Kconfig                  |  4 ---
 drivers/net/wireless/Makefile                 |  2 --
 drivers/net/wireless/atmel/Kconfig            | 35 -------------------
 drivers/net/wireless/atmel/Makefile           |  4 ---
 drivers/net/wireless/intersil/Kconfig         |  2 --
 drivers/net/wireless/intersil/Makefile        |  2 --
 drivers/net/wireless/zydas/Kconfig            | 19 ----------
 drivers/net/wireless/zydas/Makefile           |  2 --
 drivers/staging/Kconfig                       |  2 ++
 drivers/staging/Makefile                      |  1 +
 drivers/staging/wireless/Kconfig              | 11 ++++++
 drivers/staging/wireless/Makefile             |  8 +++++
 drivers/staging/wireless/TODO                 | 11 ++++++
 drivers/staging/wireless/atmel/Kconfig        | 35 +++++++++++++++++++
 drivers/staging/wireless/atmel/Makefile       |  6 ++++
 .../{net => staging}/wireless/atmel/atmel.c   |  0
 .../{net => staging}/wireless/atmel/atmel.h   |  0
 .../wireless/atmel/atmel_cs.c                 |  0
 .../wireless/atmel/atmel_pci.c                |  0
 .../{net => staging}/wireless/cisco/Kconfig   |  0
 .../{net => staging}/wireless/cisco/Makefile  |  0
 .../{net => staging}/wireless/cisco/airo.c    |  0
 .../{net => staging}/wireless/cisco/airo.h    |  0
 .../{net => staging}/wireless/cisco/airo_cs.c |  0
 .../wireless}/hostap/Kconfig                  |  1 +
 .../wireless}/hostap/Makefile                 |  0
 .../wireless}/hostap/hostap.h                 |  0
 .../wireless}/hostap/hostap_80211.h           |  0
 .../wireless}/hostap/hostap_80211_rx.c        |  0
 .../wireless}/hostap/hostap_80211_tx.c        |  0
 .../wireless}/hostap/hostap_ap.c              |  0
 .../wireless}/hostap/hostap_ap.h              |  0
 .../wireless}/hostap/hostap_common.h          |  0
 .../wireless}/hostap/hostap_config.h          |  0
 .../wireless}/hostap/hostap_cs.c              |  0
 .../wireless}/hostap/hostap_download.c        |  0
 .../wireless}/hostap/hostap_hw.c              |  0
 .../wireless}/hostap/hostap_info.c            |  0
 .../wireless}/hostap/hostap_ioctl.c           |  0
 .../wireless}/hostap/hostap_main.c            |  0
 .../wireless}/hostap/hostap_pci.c             |  0
 .../wireless}/hostap/hostap_plx.c             |  0
 .../wireless}/hostap/hostap_proc.c            |  0
 .../wireless}/hostap/hostap_wlan.h            |  0
 .../{net => staging}/wireless/legacy/Kconfig  |  0
 .../{net => staging}/wireless/legacy/Makefile |  0
 .../{net => staging}/wireless/legacy/ray_cs.c |  0
 .../{net => staging}/wireless/legacy/ray_cs.h |  0
 .../{net => staging}/wireless/legacy/rayctl.h |  0
 .../wireless/legacy/rndis_wlan.c              |  0
 .../{net => staging}/wireless/legacy/wl3501.h |  0
 .../wireless/legacy/wl3501_cs.c               |  0
 .../wireless}/orinoco/Kconfig                 |  0
 .../wireless}/orinoco/Makefile                |  0
 .../wireless}/orinoco/airport.c               |  0
 .../wireless}/orinoco/cfg.c                   |  0
 .../wireless}/orinoco/cfg.h                   |  0
 .../wireless}/orinoco/fw.c                    |  0
 .../wireless}/orinoco/fw.h                    |  0
 .../wireless}/orinoco/hermes.c                |  0
 .../wireless}/orinoco/hermes.h                |  0
 .../wireless}/orinoco/hermes_dld.c            |  0
 .../wireless}/orinoco/hermes_dld.h            |  0
 .../wireless}/orinoco/hermes_rid.h            |  0
 .../wireless}/orinoco/hw.c                    |  0
 .../wireless}/orinoco/hw.h                    |  0
 .../wireless}/orinoco/main.c                  |  0
 .../wireless}/orinoco/main.h                  |  0
 .../wireless}/orinoco/mic.c                   |  0
 .../wireless}/orinoco/mic.h                   |  0
 .../wireless}/orinoco/orinoco.h               |  0
 .../wireless}/orinoco/orinoco_cs.c            |  0
 .../wireless}/orinoco/orinoco_nortel.c        |  0
 .../wireless}/orinoco/orinoco_pci.c           |  0
 .../wireless}/orinoco/orinoco_pci.h           |  0
 .../wireless}/orinoco/orinoco_plx.c           |  0
 .../wireless}/orinoco/orinoco_tmd.c           |  0
 .../wireless}/orinoco/orinoco_usb.c           |  0
 .../wireless}/orinoco/scan.c                  |  0
 .../wireless}/orinoco/scan.h                  |  0
 .../wireless}/orinoco/spectrum_cs.c           |  0
 .../wireless}/orinoco/wext.c                  |  0
 .../wireless}/orinoco/wext.h                  |  0
 drivers/staging/wireless/zydas/Kconfig        | 20 +++++++++++
 drivers/staging/wireless/zydas/Makefile       |  3 ++
 .../{net => staging}/wireless/zydas/zd1201.c  |  0
 .../{net => staging}/wireless/zydas/zd1201.h  |  0
 88 files changed, 106 insertions(+), 78 deletions(-)
 create mode 100644 drivers/staging/wireless/Kconfig
 create mode 100644 drivers/staging/wireless/Makefile
 create mode 100644 drivers/staging/wireless/TODO
 create mode 100644 drivers/staging/wireless/atmel/Kconfig
 create mode 100644 drivers/staging/wireless/atmel/Makefile
 rename drivers/{net => staging}/wireless/atmel/atmel.c (100%)
 rename drivers/{net => staging}/wireless/atmel/atmel.h (100%)
 rename drivers/{net => staging}/wireless/atmel/atmel_cs.c (100%)
 rename drivers/{net => staging}/wireless/atmel/atmel_pci.c (100%)
 rename drivers/{net => staging}/wireless/cisco/Kconfig (100%)
 rename drivers/{net => staging}/wireless/cisco/Makefile (100%)
 rename drivers/{net => staging}/wireless/cisco/airo.c (100%)
 rename drivers/{net => staging}/wireless/cisco/airo.h (100%)
 rename drivers/{net => staging}/wireless/cisco/airo_cs.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/Kconfig (98%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/Makefile (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_80211.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_80211_rx.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_80211_tx.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_ap.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_ap.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_common.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_config.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_cs.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_download.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_hw.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_info.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_ioctl.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_main.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_pci.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_plx.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_proc.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/hostap/hostap_wlan.h (100%)
 rename drivers/{net => staging}/wireless/legacy/Kconfig (100%)
 rename drivers/{net => staging}/wireless/legacy/Makefile (100%)
 rename drivers/{net => staging}/wireless/legacy/ray_cs.c (100%)
 rename drivers/{net => staging}/wireless/legacy/ray_cs.h (100%)
 rename drivers/{net => staging}/wireless/legacy/rayctl.h (100%)
 rename drivers/{net => staging}/wireless/legacy/rndis_wlan.c (100%)
 rename drivers/{net => staging}/wireless/legacy/wl3501.h (100%)
 rename drivers/{net => staging}/wireless/legacy/wl3501_cs.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/Kconfig (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/Makefile (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/airport.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/cfg.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/cfg.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/fw.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/fw.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/hermes.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/hermes.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/hermes_dld.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/hermes_dld.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/hermes_rid.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/hw.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/hw.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/main.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/main.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/mic.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/mic.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco_cs.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco_nortel.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco_pci.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco_pci.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco_plx.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco_tmd.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/orinoco_usb.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/scan.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/scan.h (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/spectrum_cs.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/wext.c (100%)
 rename drivers/{net/wireless/intersil => staging/wireless}/orinoco/wext.h (100%)
 create mode 100644 drivers/staging/wireless/zydas/Kconfig
 create mode 100644 drivers/staging/wireless/zydas/Makefile
 rename drivers/{net => staging}/wireless/zydas/zd1201.c (100%)
 rename drivers/{net => staging}/wireless/zydas/zd1201.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9e30ec6748ec..826c36d421dd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2389,7 +2389,7 @@ F:	drivers/memory/atmel*
 F:	drivers/watchdog/sama5d4_wdt.c
 F:	include/soc/at91/
 X:	drivers/input/touchscreen/atmel_mxt_ts.c
-X:	drivers/net/wireless/atmel/
+X:	drivers/staging/wireless/atmel/
 N:	at91
 N:	atmel
 
@@ -3298,7 +3298,7 @@ L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	http://www.thekelleys.org.uk/atmel
 W:	http://atmelwlandriver.sourceforge.net/
-F:	drivers/net/wireless/atmel/atmel*
+F:	drivers/staging/wireless/atmel/atmel*
 
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
@@ -9630,7 +9630,7 @@ F:	drivers/iio/pressure/mprls0025pa.c
 HOST AP DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Obsolete
-F:	drivers/net/wireless/intersil/hostap/
+F:	drivers/staging/wireless/hostap/
 
 HP BIOSCFG DRIVER
 M:	Jorge Lopez <jorge.lopez2@hp.com>
@@ -16208,7 +16208,7 @@ L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/orinoco
 W:	http://www.nongnu.org/orinoco/
-F:	drivers/net/wireless/intersil/orinoco/
+F:	drivers/staging/wireless/orinoco/
 
 OV2659 OMNIVISION SENSOR DRIVER
 M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
@@ -18120,7 +18120,7 @@ F:	include/ras/ras_event.h
 RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-F:	drivers/net/wireless/legacy/ray*
+F:	drivers/staging/wireless/legacy/ray*
 
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
@@ -22594,7 +22594,7 @@ F:	include/uapi/linux/usb/g_uvc.h
 USB WIRELESS RNDIS DRIVER (rndis_wlan)
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-F:	drivers/net/wireless/legacy/rndis_wlan.c
+F:	drivers/staging/wireless/legacy/rndis_wlan.c
 
 USB XHCI DRIVER
 M:	Mathias Nyman <mathias.nyman@intel.com>
@@ -22607,7 +22607,7 @@ USB ZD1201 DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	http://linux-lc100020.sourceforge.net
-F:	drivers/net/wireless/zydas/zd1201.*
+F:	drivers/staging/wireless/zydas/zd1201.*
 
 USER DATAGRAM PROTOCOL (UDP)
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
@@ -23419,7 +23419,7 @@ F:	drivers/input/misc/wistron_btns.c
 WL3501 WIRELESS PCMCIA CARD DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-F:	drivers/net/wireless/legacy/wl3501*
+F:	drivers/staging/wireless/legacy/wl3501*
 
 WMI BINARY MOF DRIVER
 M:	Armin Wolf <W_Armin@gmx.de>
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 7555af5195ec3..35a805e10991e 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -20,9 +20,7 @@ if WLAN
 
 source "drivers/net/wireless/admtek/Kconfig"
 source "drivers/net/wireless/ath/Kconfig"
-source "drivers/net/wireless/atmel/Kconfig"
 source "drivers/net/wireless/broadcom/Kconfig"
-source "drivers/net/wireless/cisco/Kconfig"
 source "drivers/net/wireless/intel/Kconfig"
 source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
@@ -38,8 +36,6 @@ source "drivers/net/wireless/ti/Kconfig"
 source "drivers/net/wireless/zydas/Kconfig"
 source "drivers/net/wireless/quantenna/Kconfig"
 
-source "drivers/net/wireless/legacy/Kconfig"
-
 source "drivers/net/wireless/virtual/Kconfig"
 
 endif # WLAN
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index 4d7374d567d18..e1c4141c60044 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_WLAN_VENDOR_ADMTEK) += admtek/
 obj-$(CONFIG_WLAN_VENDOR_ATH) += ath/
 obj-$(CONFIG_WLAN_VENDOR_ATMEL) += atmel/
 obj-$(CONFIG_WLAN_VENDOR_BROADCOM) += broadcom/
-obj-$(CONFIG_WLAN_VENDOR_CISCO) += cisco/
 obj-$(CONFIG_WLAN_VENDOR_INTEL) += intel/
 obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
@@ -23,5 +22,4 @@ obj-$(CONFIG_WLAN_VENDOR_ST) += st/
 obj-$(CONFIG_WLAN_VENDOR_TI) += ti/
 obj-$(CONFIG_WLAN_VENDOR_ZYDAS) += zydas/
 
-obj-$(CONFIG_WLAN) += legacy/
 obj-$(CONFIG_WLAN) += virtual/
diff --git a/drivers/net/wireless/atmel/Kconfig b/drivers/net/wireless/atmel/Kconfig
index bafdd57b049a1..7a2bb7a58ab7e 100644
--- a/drivers/net/wireless/atmel/Kconfig
+++ b/drivers/net/wireless/atmel/Kconfig
@@ -12,41 +12,6 @@ config WLAN_VENDOR_ATMEL
 
 if WLAN_VENDOR_ATMEL
 
-config ATMEL
-	tristate "Atmel at76c50x chipset  802.11b support"
-	depends on CFG80211 && (PCI || PCMCIA) && HAS_IOPORT
-	select WIRELESS_EXT
-	select WEXT_PRIV
-	select FW_LOADER
-	select CRC32
-	help
-	  A driver 802.11b wireless cards based on the Atmel fast-vnet
-	  chips. This driver supports standard Linux wireless extensions.
-
-	  Many  cards based on this chipset do not have flash memory
-	  and need their firmware loaded at start-up. If yours is
-	  one of these, you will need to provide a firmware image
-	  to be loaded into the card by the driver. The Atmel
-	  firmware package can be downloaded from
-	  <http://www.thekelleys.org.uk/atmel>
-
-config PCI_ATMEL
-	tristate "Atmel at76c506 PCI cards"
-	depends on ATMEL && PCI
-	help
-	  Enable support for PCI and mini-PCI cards containing the
-	  Atmel at76c506 chip.
-
-config PCMCIA_ATMEL
-	tristate "Atmel at76c502/at76c504 PCMCIA cards"
-	depends on ATMEL && PCMCIA
-	select WIRELESS_EXT
-	select FW_LOADER
-	select CRC32
-	help
-	  Enable support for PCMCIA cards containing the
-	  Atmel at76c502 and at76c504 chips.
-
 config AT76C50X_USB
 	tristate "Atmel at76c503/at76c505/at76c505a USB cards"
 	depends on MAC80211 && USB
diff --git a/drivers/net/wireless/atmel/Makefile b/drivers/net/wireless/atmel/Makefile
index 17e62805677d4..8338d7098ba60 100644
--- a/drivers/net/wireless/atmel/Makefile
+++ b/drivers/net/wireless/atmel/Makefile
@@ -1,6 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ATMEL)             += atmel.o
-obj-$(CONFIG_PCI_ATMEL)         += atmel_pci.o 
-obj-$(CONFIG_PCMCIA_ATMEL)      += atmel_cs.o
-
 obj-$(CONFIG_AT76C50X_USB)      += at76c50x-usb.o
diff --git a/drivers/net/wireless/intersil/Kconfig b/drivers/net/wireless/intersil/Kconfig
index bd6bf70ece03d..201b1534a9ca2 100644
--- a/drivers/net/wireless/intersil/Kconfig
+++ b/drivers/net/wireless/intersil/Kconfig
@@ -12,8 +12,6 @@ config WLAN_VENDOR_INTERSIL
 
 if WLAN_VENDOR_INTERSIL
 
-source "drivers/net/wireless/intersil/hostap/Kconfig"
-source "drivers/net/wireless/intersil/orinoco/Kconfig"
 source "drivers/net/wireless/intersil/p54/Kconfig"
 
 endif # WLAN_VENDOR_INTERSIL
diff --git a/drivers/net/wireless/intersil/Makefile b/drivers/net/wireless/intersil/Makefile
index 65281d1b3d852..27e9b2869da1a 100644
--- a/drivers/net/wireless/intersil/Makefile
+++ b/drivers/net/wireless/intersil/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_HOSTAP)		+= hostap/
-obj-$(CONFIG_HERMES)		+= orinoco/
 obj-$(CONFIG_P54_COMMON)	+= p54/
diff --git a/drivers/net/wireless/zydas/Kconfig b/drivers/net/wireless/zydas/Kconfig
index 08574433df66f..839e1217e855c 100644
--- a/drivers/net/wireless/zydas/Kconfig
+++ b/drivers/net/wireless/zydas/Kconfig
@@ -12,25 +12,6 @@ config WLAN_VENDOR_ZYDAS
 
 if WLAN_VENDOR_ZYDAS
 
-config USB_ZD1201
-	tristate "USB ZD1201 based Wireless device support"
-	depends on CFG80211 && USB
-	select WIRELESS_EXT
-	select WEXT_PRIV
-	select FW_LOADER
-	help
-	  Say Y if you want to use wireless LAN adapters based on the ZyDAS
-	  ZD1201 chip.
-
-	  This driver makes the adapter appear as a normal Ethernet interface,
-	  typically on wlan0.
-
-	  The zd1201 device requires external firmware to be loaded.
-	  This can be found at http://linux-lc100020.sourceforge.net/
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called zd1201.
-
 source "drivers/net/wireless/zydas/zd1211rw/Kconfig"
 
 endif # WLAN_VENDOR_ZYDAS
diff --git a/drivers/net/wireless/zydas/Makefile b/drivers/net/wireless/zydas/Makefile
index c70003d30a8fb..3e0a51db98742 100644
--- a/drivers/net/wireless/zydas/Makefile
+++ b/drivers/net/wireless/zydas/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ZD1211RW)		+= zd1211rw/
-
-obj-$(CONFIG_USB_ZD1201)	+= zd1201.o
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index f9aef39cac2e9..8206d994f144d 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -36,6 +36,8 @@ source "drivers/staging/rtl8723bs/Kconfig"
 
 source "drivers/staging/rtl8712/Kconfig"
 
+source "drivers/staging/wireless/Kconfig"
+
 source "drivers/staging/rts5208/Kconfig"
 
 source "drivers/staging/octeon/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index ffa70dda481d3..43c7e7a23b296 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
 obj-$(CONFIG_VT6655)		+= vt6655/
 obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme_user/
+obj-$(CONFIG_WLAN)		+= wireless/
 obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_FB_SM750)		+= sm750fb/
 obj-$(CONFIG_USB_EMXX)		+= emxx_udc/
diff --git a/drivers/staging/wireless/Kconfig b/drivers/staging/wireless/Kconfig
new file mode 100644
index 0000000000000..a8ce42aa3e944
--- /dev/null
+++ b/drivers/staging/wireless/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+if WIRELESS
+
+source "drivers/staging/wireless/atmel/Kconfig"
+source "drivers/staging/wireless/cisco/Kconfig"
+source "drivers/staging/wireless/hostap/Kconfig"
+source "drivers/staging/wireless/legacy/Kconfig"
+source "drivers/staging/wireless/orinoco/Kconfig"
+source "drivers/staging/wireless/zydas/Kconfig"
+
+endif
diff --git a/drivers/staging/wireless/Makefile b/drivers/staging/wireless/Makefile
new file mode 100644
index 0000000000000..33179fca40953
--- /dev/null
+++ b/drivers/staging/wireless/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += atmel/
+obj-y += cisco/
+obj-y += hostap/
+obj-y += legacy/
+obj-y += orinoco/
+obj-y += zydas/
diff --git a/drivers/staging/wireless/TODO b/drivers/staging/wireless/TODO
new file mode 100644
index 0000000000000..7a3c1b6e7db41
--- /dev/null
+++ b/drivers/staging/wireless/TODO
@@ -0,0 +1,11 @@
+TODO (Oct. 2023)
+
+These 802.11(b) wireless drivers are likely all unused and can be removed
+in the near future, unless we find a reason to keep them.
+
+All except the rndis_wlan driver still rely on the deprecated wireless
+extension ioctl interface, which in modern drivers is only provided
+as an emulation layer on top of the cfg80211 interface.
+
+Ideally, any drivers we want to keep around should be converted to no
+longer require iw_handler_def.
diff --git a/drivers/staging/wireless/atmel/Kconfig b/drivers/staging/wireless/atmel/Kconfig
new file mode 100644
index 0000000000000..5771c82966347
--- /dev/null
+++ b/drivers/staging/wireless/atmel/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config ATMEL
+	tristate "Atmel at76c50x chipset  802.11b support"
+	depends on CFG80211 && (PCI || PCMCIA) && HAS_IOPORT
+	select WIRELESS_EXT
+	select WEXT_PRIV
+	select FW_LOADER
+	select CRC32
+	help
+	  A driver 802.11b wireless cards based on the Atmel fast-vnet
+	  chips. This driver supports standard Linux wireless extensions.
+
+	  Many  cards based on this chipset do not have flash memory
+	  and need their firmware loaded at start-up. If yours is
+	  one of these, you will need to provide a firmware image
+	  to be loaded into the card by the driver. The Atmel
+	  firmware package can be downloaded from
+	  <http://www.thekelleys.org.uk/atmel>
+
+config PCI_ATMEL
+	tristate "Atmel at76c506 PCI cards"
+	depends on ATMEL && PCI
+	help
+	  Enable support for PCI and mini-PCI cards containing the
+	  Atmel at76c506 chip.
+
+config PCMCIA_ATMEL
+	tristate "Atmel at76c502/at76c504 PCMCIA cards"
+	depends on ATMEL && PCMCIA
+	select WIRELESS_EXT
+	select FW_LOADER
+	select CRC32
+	help
+	  Enable support for PCMCIA cards containing the
+	  Atmel at76c502 and at76c504 chips.
diff --git a/drivers/staging/wireless/atmel/Makefile b/drivers/staging/wireless/atmel/Makefile
new file mode 100644
index 0000000000000..31d81bcd7ff7f
--- /dev/null
+++ b/drivers/staging/wireless/atmel/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ATMEL)             += atmel.o
+obj-$(CONFIG_PCI_ATMEL)         += atmel_pci.o
+obj-$(CONFIG_PCMCIA_ATMEL)      += atmel_cs.o
+
+
diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/staging/wireless/atmel/atmel.c
similarity index 100%
rename from drivers/net/wireless/atmel/atmel.c
rename to drivers/staging/wireless/atmel/atmel.c
diff --git a/drivers/net/wireless/atmel/atmel.h b/drivers/staging/wireless/atmel/atmel.h
similarity index 100%
rename from drivers/net/wireless/atmel/atmel.h
rename to drivers/staging/wireless/atmel/atmel.h
diff --git a/drivers/net/wireless/atmel/atmel_cs.c b/drivers/staging/wireless/atmel/atmel_cs.c
similarity index 100%
rename from drivers/net/wireless/atmel/atmel_cs.c
rename to drivers/staging/wireless/atmel/atmel_cs.c
diff --git a/drivers/net/wireless/atmel/atmel_pci.c b/drivers/staging/wireless/atmel/atmel_pci.c
similarity index 100%
rename from drivers/net/wireless/atmel/atmel_pci.c
rename to drivers/staging/wireless/atmel/atmel_pci.c
diff --git a/drivers/net/wireless/cisco/Kconfig b/drivers/staging/wireless/cisco/Kconfig
similarity index 100%
rename from drivers/net/wireless/cisco/Kconfig
rename to drivers/staging/wireless/cisco/Kconfig
diff --git a/drivers/net/wireless/cisco/Makefile b/drivers/staging/wireless/cisco/Makefile
similarity index 100%
rename from drivers/net/wireless/cisco/Makefile
rename to drivers/staging/wireless/cisco/Makefile
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/staging/wireless/cisco/airo.c
similarity index 100%
rename from drivers/net/wireless/cisco/airo.c
rename to drivers/staging/wireless/cisco/airo.c
diff --git a/drivers/net/wireless/cisco/airo.h b/drivers/staging/wireless/cisco/airo.h
similarity index 100%
rename from drivers/net/wireless/cisco/airo.h
rename to drivers/staging/wireless/cisco/airo.h
diff --git a/drivers/net/wireless/cisco/airo_cs.c b/drivers/staging/wireless/cisco/airo_cs.c
similarity index 100%
rename from drivers/net/wireless/cisco/airo_cs.c
rename to drivers/staging/wireless/cisco/airo_cs.c
diff --git a/drivers/net/wireless/intersil/hostap/Kconfig b/drivers/staging/wireless/hostap/Kconfig
similarity index 98%
rename from drivers/net/wireless/intersil/hostap/Kconfig
rename to drivers/staging/wireless/hostap/Kconfig
index 2edff8efbcbb1..2a7072d1e7dd6 100644
--- a/drivers/net/wireless/intersil/hostap/Kconfig
+++ b/drivers/staging/wireless/hostap/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config HOSTAP
 	tristate "IEEE 802.11 for Host AP (Prism2/2.5/3 and WEP/TKIP/CCMP)"
+	depends on (PCMCIA || PCI) && HAS_IOPORT
 	select WIRELESS_EXT
 	select WEXT_SPY
 	select WEXT_PRIV
diff --git a/drivers/net/wireless/intersil/hostap/Makefile b/drivers/staging/wireless/hostap/Makefile
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/Makefile
rename to drivers/staging/wireless/hostap/Makefile
diff --git a/drivers/net/wireless/intersil/hostap/hostap.h b/drivers/staging/wireless/hostap/hostap.h
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap.h
rename to drivers/staging/wireless/hostap/hostap.h
diff --git a/drivers/net/wireless/intersil/hostap/hostap_80211.h b/drivers/staging/wireless/hostap/hostap_80211.h
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_80211.h
rename to drivers/staging/wireless/hostap/hostap_80211.h
diff --git a/drivers/net/wireless/intersil/hostap/hostap_80211_rx.c b/drivers/staging/wireless/hostap/hostap_80211_rx.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_80211_rx.c
rename to drivers/staging/wireless/hostap/hostap_80211_rx.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_80211_tx.c b/drivers/staging/wireless/hostap/hostap_80211_tx.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_80211_tx.c
rename to drivers/staging/wireless/hostap/hostap_80211_tx.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/staging/wireless/hostap/hostap_ap.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_ap.c
rename to drivers/staging/wireless/hostap/hostap_ap.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.h b/drivers/staging/wireless/hostap/hostap_ap.h
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_ap.h
rename to drivers/staging/wireless/hostap/hostap_ap.h
diff --git a/drivers/net/wireless/intersil/hostap/hostap_common.h b/drivers/staging/wireless/hostap/hostap_common.h
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_common.h
rename to drivers/staging/wireless/hostap/hostap_common.h
diff --git a/drivers/net/wireless/intersil/hostap/hostap_config.h b/drivers/staging/wireless/hostap/hostap_config.h
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_config.h
rename to drivers/staging/wireless/hostap/hostap_config.h
diff --git a/drivers/net/wireless/intersil/hostap/hostap_cs.c b/drivers/staging/wireless/hostap/hostap_cs.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_cs.c
rename to drivers/staging/wireless/hostap/hostap_cs.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/staging/wireless/hostap/hostap_download.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_download.c
rename to drivers/staging/wireless/hostap/hostap_download.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_hw.c b/drivers/staging/wireless/hostap/hostap_hw.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_hw.c
rename to drivers/staging/wireless/hostap/hostap_hw.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_info.c b/drivers/staging/wireless/hostap/hostap_info.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_info.c
rename to drivers/staging/wireless/hostap/hostap_info.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c b/drivers/staging/wireless/hostap/hostap_ioctl.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_ioctl.c
rename to drivers/staging/wireless/hostap/hostap_ioctl.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_main.c b/drivers/staging/wireless/hostap/hostap_main.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_main.c
rename to drivers/staging/wireless/hostap/hostap_main.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_pci.c b/drivers/staging/wireless/hostap/hostap_pci.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_pci.c
rename to drivers/staging/wireless/hostap/hostap_pci.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_plx.c b/drivers/staging/wireless/hostap/hostap_plx.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_plx.c
rename to drivers/staging/wireless/hostap/hostap_plx.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_proc.c b/drivers/staging/wireless/hostap/hostap_proc.c
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_proc.c
rename to drivers/staging/wireless/hostap/hostap_proc.c
diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/staging/wireless/hostap/hostap_wlan.h
similarity index 100%
rename from drivers/net/wireless/intersil/hostap/hostap_wlan.h
rename to drivers/staging/wireless/hostap/hostap_wlan.h
diff --git a/drivers/net/wireless/legacy/Kconfig b/drivers/staging/wireless/legacy/Kconfig
similarity index 100%
rename from drivers/net/wireless/legacy/Kconfig
rename to drivers/staging/wireless/legacy/Kconfig
diff --git a/drivers/net/wireless/legacy/Makefile b/drivers/staging/wireless/legacy/Makefile
similarity index 100%
rename from drivers/net/wireless/legacy/Makefile
rename to drivers/staging/wireless/legacy/Makefile
diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/staging/wireless/legacy/ray_cs.c
similarity index 100%
rename from drivers/net/wireless/legacy/ray_cs.c
rename to drivers/staging/wireless/legacy/ray_cs.c
diff --git a/drivers/net/wireless/legacy/ray_cs.h b/drivers/staging/wireless/legacy/ray_cs.h
similarity index 100%
rename from drivers/net/wireless/legacy/ray_cs.h
rename to drivers/staging/wireless/legacy/ray_cs.h
diff --git a/drivers/net/wireless/legacy/rayctl.h b/drivers/staging/wireless/legacy/rayctl.h
similarity index 100%
rename from drivers/net/wireless/legacy/rayctl.h
rename to drivers/staging/wireless/legacy/rayctl.h
diff --git a/drivers/net/wireless/legacy/rndis_wlan.c b/drivers/staging/wireless/legacy/rndis_wlan.c
similarity index 100%
rename from drivers/net/wireless/legacy/rndis_wlan.c
rename to drivers/staging/wireless/legacy/rndis_wlan.c
diff --git a/drivers/net/wireless/legacy/wl3501.h b/drivers/staging/wireless/legacy/wl3501.h
similarity index 100%
rename from drivers/net/wireless/legacy/wl3501.h
rename to drivers/staging/wireless/legacy/wl3501.h
diff --git a/drivers/net/wireless/legacy/wl3501_cs.c b/drivers/staging/wireless/legacy/wl3501_cs.c
similarity index 100%
rename from drivers/net/wireless/legacy/wl3501_cs.c
rename to drivers/staging/wireless/legacy/wl3501_cs.c
diff --git a/drivers/net/wireless/intersil/orinoco/Kconfig b/drivers/staging/wireless/orinoco/Kconfig
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/Kconfig
rename to drivers/staging/wireless/orinoco/Kconfig
diff --git a/drivers/net/wireless/intersil/orinoco/Makefile b/drivers/staging/wireless/orinoco/Makefile
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/Makefile
rename to drivers/staging/wireless/orinoco/Makefile
diff --git a/drivers/net/wireless/intersil/orinoco/airport.c b/drivers/staging/wireless/orinoco/airport.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/airport.c
rename to drivers/staging/wireless/orinoco/airport.c
diff --git a/drivers/net/wireless/intersil/orinoco/cfg.c b/drivers/staging/wireless/orinoco/cfg.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/cfg.c
rename to drivers/staging/wireless/orinoco/cfg.c
diff --git a/drivers/net/wireless/intersil/orinoco/cfg.h b/drivers/staging/wireless/orinoco/cfg.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/cfg.h
rename to drivers/staging/wireless/orinoco/cfg.h
diff --git a/drivers/net/wireless/intersil/orinoco/fw.c b/drivers/staging/wireless/orinoco/fw.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/fw.c
rename to drivers/staging/wireless/orinoco/fw.c
diff --git a/drivers/net/wireless/intersil/orinoco/fw.h b/drivers/staging/wireless/orinoco/fw.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/fw.h
rename to drivers/staging/wireless/orinoco/fw.h
diff --git a/drivers/net/wireless/intersil/orinoco/hermes.c b/drivers/staging/wireless/orinoco/hermes.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/hermes.c
rename to drivers/staging/wireless/orinoco/hermes.c
diff --git a/drivers/net/wireless/intersil/orinoco/hermes.h b/drivers/staging/wireless/orinoco/hermes.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/hermes.h
rename to drivers/staging/wireless/orinoco/hermes.h
diff --git a/drivers/net/wireless/intersil/orinoco/hermes_dld.c b/drivers/staging/wireless/orinoco/hermes_dld.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/hermes_dld.c
rename to drivers/staging/wireless/orinoco/hermes_dld.c
diff --git a/drivers/net/wireless/intersil/orinoco/hermes_dld.h b/drivers/staging/wireless/orinoco/hermes_dld.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/hermes_dld.h
rename to drivers/staging/wireless/orinoco/hermes_dld.h
diff --git a/drivers/net/wireless/intersil/orinoco/hermes_rid.h b/drivers/staging/wireless/orinoco/hermes_rid.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/hermes_rid.h
rename to drivers/staging/wireless/orinoco/hermes_rid.h
diff --git a/drivers/net/wireless/intersil/orinoco/hw.c b/drivers/staging/wireless/orinoco/hw.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/hw.c
rename to drivers/staging/wireless/orinoco/hw.c
diff --git a/drivers/net/wireless/intersil/orinoco/hw.h b/drivers/staging/wireless/orinoco/hw.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/hw.h
rename to drivers/staging/wireless/orinoco/hw.h
diff --git a/drivers/net/wireless/intersil/orinoco/main.c b/drivers/staging/wireless/orinoco/main.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/main.c
rename to drivers/staging/wireless/orinoco/main.c
diff --git a/drivers/net/wireless/intersil/orinoco/main.h b/drivers/staging/wireless/orinoco/main.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/main.h
rename to drivers/staging/wireless/orinoco/main.h
diff --git a/drivers/net/wireless/intersil/orinoco/mic.c b/drivers/staging/wireless/orinoco/mic.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/mic.c
rename to drivers/staging/wireless/orinoco/mic.c
diff --git a/drivers/net/wireless/intersil/orinoco/mic.h b/drivers/staging/wireless/orinoco/mic.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/mic.h
rename to drivers/staging/wireless/orinoco/mic.h
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco.h b/drivers/staging/wireless/orinoco/orinoco.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco.h
rename to drivers/staging/wireless/orinoco/orinoco.h
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c b/drivers/staging/wireless/orinoco/orinoco_cs.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco_cs.c
rename to drivers/staging/wireless/orinoco/orinoco_cs.c
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_nortel.c b/drivers/staging/wireless/orinoco/orinoco_nortel.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco_nortel.c
rename to drivers/staging/wireless/orinoco/orinoco_nortel.c
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_pci.c b/drivers/staging/wireless/orinoco/orinoco_pci.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco_pci.c
rename to drivers/staging/wireless/orinoco/orinoco_pci.c
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_pci.h b/drivers/staging/wireless/orinoco/orinoco_pci.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco_pci.h
rename to drivers/staging/wireless/orinoco/orinoco_pci.h
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_plx.c b/drivers/staging/wireless/orinoco/orinoco_plx.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco_plx.c
rename to drivers/staging/wireless/orinoco/orinoco_plx.c
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_tmd.c b/drivers/staging/wireless/orinoco/orinoco_tmd.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco_tmd.c
rename to drivers/staging/wireless/orinoco/orinoco_tmd.c
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/staging/wireless/orinoco/orinoco_usb.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/orinoco_usb.c
rename to drivers/staging/wireless/orinoco/orinoco_usb.c
diff --git a/drivers/net/wireless/intersil/orinoco/scan.c b/drivers/staging/wireless/orinoco/scan.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/scan.c
rename to drivers/staging/wireless/orinoco/scan.c
diff --git a/drivers/net/wireless/intersil/orinoco/scan.h b/drivers/staging/wireless/orinoco/scan.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/scan.h
rename to drivers/staging/wireless/orinoco/scan.h
diff --git a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c b/drivers/staging/wireless/orinoco/spectrum_cs.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/spectrum_cs.c
rename to drivers/staging/wireless/orinoco/spectrum_cs.c
diff --git a/drivers/net/wireless/intersil/orinoco/wext.c b/drivers/staging/wireless/orinoco/wext.c
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/wext.c
rename to drivers/staging/wireless/orinoco/wext.c
diff --git a/drivers/net/wireless/intersil/orinoco/wext.h b/drivers/staging/wireless/orinoco/wext.h
similarity index 100%
rename from drivers/net/wireless/intersil/orinoco/wext.h
rename to drivers/staging/wireless/orinoco/wext.h
diff --git a/drivers/staging/wireless/zydas/Kconfig b/drivers/staging/wireless/zydas/Kconfig
new file mode 100644
index 0000000000000..9ff2ce3e1695a
--- /dev/null
+++ b/drivers/staging/wireless/zydas/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config USB_ZD1201
+	tristate "USB ZD1201 based Wireless device support"
+	depends on CFG80211 && USB
+	select WIRELESS_EXT
+	select WEXT_PRIV
+	select FW_LOADER
+	help
+	  Say Y if you want to use wireless LAN adapters based on the ZyDAS
+	  ZD1201 chip.
+
+	  This driver makes the adapter appear as a normal Ethernet interface,
+	  typically on wlan0.
+
+	  The zd1201 device requires external firmware to be loaded.
+	  This can be found at http://linux-lc100020.sourceforge.net/
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called zd1201.
diff --git a/drivers/staging/wireless/zydas/Makefile b/drivers/staging/wireless/zydas/Makefile
new file mode 100644
index 0000000000000..5239cc17bd2ad
--- /dev/null
+++ b/drivers/staging/wireless/zydas/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_USB_ZD1201)	+= zd1201.o
diff --git a/drivers/net/wireless/zydas/zd1201.c b/drivers/staging/wireless/zydas/zd1201.c
similarity index 100%
rename from drivers/net/wireless/zydas/zd1201.c
rename to drivers/staging/wireless/zydas/zd1201.c
diff --git a/drivers/net/wireless/zydas/zd1201.h b/drivers/staging/wireless/zydas/zd1201.h
similarity index 100%
rename from drivers/net/wireless/zydas/zd1201.h
rename to drivers/staging/wireless/zydas/zd1201.h
-- 
2.39.2

