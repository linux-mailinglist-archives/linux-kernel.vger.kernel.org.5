Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E987764869
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjG0HVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjG0HUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016A49CF;
        Thu, 27 Jul 2023 00:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DE661D6D;
        Thu, 27 Jul 2023 07:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51F6C433C7;
        Thu, 27 Jul 2023 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442029;
        bh=cafoR/ziko+WtTvOrSeEIqLiUaQ3gpgHzPdYvDSnKFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atJpXg23BRRqaIZ7bjG6HdEYDtHQT9dX6/U++WdO9XrP+Z3xe72sZA7xZye3nvm2I
         yDuWKgKp9f6Tgwz3dlsJNlzZ4IKHrcudtMziw2FgZyWNogqPaJOHUGvpkA5NWqYC+/
         d1XIRo+JcG3Io9evmMrlOa8VZFyyk8cPZoEdNXJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.188
Date:   Thu, 27 Jul 2023 09:13:26 +0200
Message-ID: <2023072726-alone-rare-96dc@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072726-capsize-reprise-ffda@gregkh>
References: <2023072726-capsize-reprise-ffda@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/filesystems/autofs-mount-control.rst b/Documentation/filesystems/autofs-mount-control.rst
index bf4b511cdbe8..b5a379d25c40 100644
--- a/Documentation/filesystems/autofs-mount-control.rst
+++ b/Documentation/filesystems/autofs-mount-control.rst
@@ -196,7 +196,7 @@ information and return operation results::
 		    struct args_ismountpoint	ismountpoint;
 	    };
 
-	    char path[0];
+	    char path[];
     };
 
 The ioctlfd field is a mount point file descriptor of an autofs mount
diff --git a/Documentation/filesystems/autofs.rst b/Documentation/filesystems/autofs.rst
index 681c6a492bc0..1b495768e7aa 100644
--- a/Documentation/filesystems/autofs.rst
+++ b/Documentation/filesystems/autofs.rst
@@ -467,7 +467,7 @@ Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure::
 			struct args_ismountpoint	ismountpoint;
 		};
 
-                char path[0];
+                char path[];
         };
 
 For the **OPEN_MOUNT** and **IS_MOUNTPOINT** commands, the target
diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index 504ba940c36c..dccd61c7c5c3 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -22,12 +22,11 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks
-the parent and finds source and target.  In case of exchange (with
-RENAME_EXCHANGE in flags argument) lock both.  In any case,
-if the target already exists, lock it.  If the source is a non-directory,
-lock it.  If we need to lock both, lock them in inode pointer order.
-Then call the method.  All locks are exclusive.
+4) rename() that is _not_ cross-directory.  Locking rules: caller locks the
+parent and finds source and target.  We lock both (provided they exist).  If we
+need to lock two inodes of different type (dir vs non-dir), we lock directory
+first.  If we need to lock two inodes of the same type, lock them in inode
+pointer order.  Then call the method.  All locks are exclusive.
 NB: we might get away with locking the source (and target in exchange
 case) shared.
 
@@ -44,15 +43,17 @@ All locks are exclusive.
 rules:
 
 	* lock the filesystem
-	* lock parents in "ancestors first" order.
+	* lock parents in "ancestors first" order. If one is not ancestor of
+	  the other, lock them in inode pointer order.
 	* find source and target.
 	* if old parent is equal to or is a descendent of target
 	  fail with -ENOTEMPTY
 	* if new parent is equal to or is a descendent of source
 	  fail with -ELOOP
-	* If it's an exchange, lock both the source and the target.
-	* If the target exists, lock it.  If the source is a non-directory,
-	  lock it.  If we need to lock both, do so in inode pointer order.
+	* Lock both the source and the target provided they exist. If we
+	  need to lock two inodes of different type (dir vs non-dir), we lock
+	  the directory first. If we need to lock two inodes of the same type,
+	  lock them in inode pointer order.
 	* call the method.
 
 All ->i_rwsem are taken exclusive.  Again, we might get away with locking
@@ -66,8 +67,9 @@ If no directory is its own ancestor, the scheme above is deadlock-free.
 
 Proof:
 
-	First of all, at any moment we have a partial ordering of the
-	objects - A < B iff A is an ancestor of B.
+	First of all, at any moment we have a linear ordering of the
+	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
+        of A and ptr(A) < ptr(B)).
 
 	That ordering can change.  However, the following is true:
 
diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 2ccc5644cc98..70623cb135d3 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -433,6 +433,15 @@ start N bytes into the buffer leaving the first N bytes for the
 application to use. The final option is the flags field, but it will
 be dealt with in separate sections for each UMEM flag.
 
+SO_BINDTODEVICE setsockopt
+--------------------------
+
+This is a generic SOL_SOCKET option that can be used to tie AF_XDP
+socket to a particular network interface.  It is useful when a socket
+is created by a privileged process and passed to a non-privileged one.
+Once the option is set, kernel will refuse attempts to bind that socket
+to a different interface.  Updating the value requires CAP_NET_RAW.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index df26cf4110ef..252212998378 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -713,6 +713,31 @@ tcp_syncookies - INTEGER
 	network connections you can set this knob to 2 to enable
 	unconditionally generation of syncookies.
 
+tcp_migrate_req - BOOLEAN
+	The incoming connection is tied to a specific listening socket when
+	the initial SYN packet is received during the three-way handshake.
+	When a listener is closed, in-flight request sockets during the
+	handshake and established sockets in the accept queue are aborted.
+
+	If the listener has SO_REUSEPORT enabled, other listeners on the
+	same port should have been able to accept such connections. This
+	option makes it possible to migrate such child sockets to another
+	listener after close() or shutdown().
+
+	The BPF_SK_REUSEPORT_SELECT_OR_MIGRATE type of eBPF program should
+	usually be used to define the policy to pick an alive listener.
+	Otherwise, the kernel will randomly pick an alive listener only if
+	this option is enabled.
+
+	Note that migration between listeners with different settings may
+	crash applications. Let's say migration happens from listener A to
+	B, and only B has TCP_SAVE_SYN enabled. B cannot read SYN data from
+	the requests migrated from A. To avoid such a situation, cancel
+	migration by returning SK_DROP in the type of eBPF program, or
+	disable this option.
+
+	Default: 0
+
 tcp_fastopen - INTEGER
 	Enable TCP Fast Open (RFC7413) to send and accept data in the opening
 	SYN packet.
diff --git a/Makefile b/Makefile
index 2aaf3b0b9250..7f9e1667d87d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 187
+SUBLEVEL = 188
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 660b14ce1317..12c120e436a2 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -241,8 +241,10 @@ pmd_page_vaddr(pmd_t pmd)
 #define pud_page(pud)	(mem_map + ((pud_val(pud) & _PFN_MASK) >> 32))
 #endif
 
-extern inline unsigned long pud_page_vaddr(pud_t pgd)
-{ return PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
+extern inline pmd_t *pud_pgtable(pud_t pgd)
+{
+	return (pmd_t *)(PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)));
+}
 
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
@@ -292,7 +294,7 @@ extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; retu
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pud_t * dir, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *) pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	pmd_t *ret = pud_pgtable(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 	smp_rmb(); /* see above */
 	return ret;
 }
diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index c9434ff3aa4c..8a3fb71e9cfa 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -8,6 +8,10 @@
 
 #include <asm/dwarf.h>
 
+#define ASM_NL		 `	/* use '`' to mark new line in macro */
+#define __ALIGN		.align 4
+#define __ALIGN_STR	__stringify(__ALIGN)
+
 #ifdef __ASSEMBLY__
 
 .macro ST2 e, o, off
@@ -28,10 +32,6 @@
 #endif
 .endm
 
-#define ASM_NL		 `	/* use '`' to mark new line in macro */
-#define __ALIGN		.align 4
-#define __ALIGN_STR	__stringify(__ALIGN)
-
 /* annotation for data we want in DCCM - if enabled in .config */
 .macro ARCFP_DATA nm
 #ifdef CONFIG_ARC_HAS_DCCM
diff --git a/arch/arm/boot/dts/bcm53015-meraki-mr26.dts b/arch/arm/boot/dts/bcm53015-meraki-mr26.dts
index 14f58033efeb..ca2266b936ee 100644
--- a/arch/arm/boot/dts/bcm53015-meraki-mr26.dts
+++ b/arch/arm/boot/dts/bcm53015-meraki-mr26.dts
@@ -128,7 +128,7 @@ port@5 {
 
 			fixed-link {
 				speed = <1000>;
-				duplex-full;
+				full-duplex;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
index 577a4dc604d9..edf9910100b0 100644
--- a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
@@ -212,7 +212,7 @@ port@5 {
 
 			fixed-link {
 				speed = <1000>;
-				duplex-full;
+				full-duplex;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9fdad20c40d1..4e9bb10f37d0 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -532,7 +532,6 @@ spi@18029200 {
 				  "spi_lr_session_done",
 				  "spi_lr_overread";
 		clocks = <&iprocmed>;
-		clock-names = "iprocmed";
 		num-cs = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 63cafd220dba..358f5477deef 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -49,7 +49,7 @@ audio_clock: audio_clock {
 	lcd_backlight: backlight {
 		compatible = "pwm-backlight";
 
-		pwms = <&pwm3 0 5000000 0>;
+		pwms = <&pwm3 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio5 14 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 08533116a39c..0d045add8165 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -611,13 +611,13 @@ &uart_A {
 
 &uart_B {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index f6eb7c803174..af2454c9f77a 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -599,13 +599,13 @@ &uart_A {
 
 &uart_B {
 	compatible = "amlogic,meson8b-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8b-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
diff --git a/arch/arm/boot/dts/omap3-gta04a5one.dts b/arch/arm/boot/dts/omap3-gta04a5one.dts
index 9db9fe67cd63..95df45cc70c0 100644
--- a/arch/arm/boot/dts/omap3-gta04a5one.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5one.dts
@@ -5,9 +5,11 @@
 
 #include "omap3-gta04a5.dts"
 
-&omap3_pmx_core {
+/ {
 	model = "Goldelico GTA04A5/Letux 2804 with OneNAND";
+};
 
+&omap3_pmx_core {
 	gpmc_pins: pinmux_gpmc_pins {
 		pinctrl-single,pins = <
 
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
index fd0cd10cb093..2c391065135e 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
@@ -120,10 +120,13 @@ lcd_panel_in: endpoint {
 
 	sound {
 		compatible = "audio-graph-card";
-		routing =
-			"MIC_IN", "Capture",
-			"Capture", "Mic Bias",
-			"Playback", "HP_OUT";
+		widgets = "Headphone", "Headphone Jack",
+			  "Line", "Line In Jack",
+			  "Microphone", "Microphone Jack";
+		routing = "Headphone Jack", "HP_OUT",
+			  "LINE_IN", "Line In Jack",
+			  "MIC_IN", "Microphone Jack",
+			  "Microphone Jack", "Mic Bias";
 		dais = <&sai2a_port &sai2b_port>;
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
index 723b39bb2129..d8547307a950 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
@@ -88,7 +88,7 @@ sd_switch: regulator-sd_switch {
 
 	sound {
 		compatible = "audio-graph-card";
-		label = "STM32MP1-AV96-HDMI";
+		label = "STM32-AV96-HDMI";
 		dais = <&sai2a_port>;
 		status = "okay";
 	};
@@ -232,6 +232,12 @@ adv7513_i2s0: endpoint {
 			};
 		};
 	};
+
+	dh_mac_eeprom: eeprom@53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <16>;
+	};
 };
 
 &ltdc {
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
index 5af32140e128..7dba02e9ba6d 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
@@ -167,12 +167,6 @@ watchdog {
 			status = "disabled";
 		};
 	};
-
-	eeprom@53 {
-		compatible = "atmel,24c02";
-		reg = <0x53>;
-		pagesize = <16>;
-	};
 };
 
 &iwdg2 {
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 47df8ac67cf1..75869d6a1ab2 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -406,7 +406,7 @@ &i2s2 {
 	i2s2_port: port {
 		i2s2_endpoint: endpoint {
 			remote-endpoint = <&sii9022_tx_endpoint>;
-			format = "i2s";
+			dai-format = "i2s";
 			mclk-fs = <256>;
 		};
 	};
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 2b85d175e999..4487aea88477 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -130,7 +130,7 @@
 		flush_pmd_entry(pudp);	\
 	} while (0)
 
-static inline pmd_t *pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index dd4b164d1831..a9efa7bc2fa1 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <asm/mach/time.h>
 #include "soc.h"
+#include "platform.h"
 
 /*************************************************************************
  * Timer handling for EP93xx
@@ -60,7 +61,7 @@ static u64 notrace ep93xx_read_sched_clock(void)
 	return ret;
 }
 
-u64 ep93xx_clocksource_read(struct clocksource *c)
+static u64 ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 1610c567a6a3..10d2f078e4a8 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -13,6 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/setup.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 3d36f1d95196..3f651df3a71c 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -63,6 +63,9 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
+	if (of_machine_is_compatible("lacie,d2-network"))
+		d2net_init();
+
 	of_platform_default_populate(NULL, orion5x_auxdata_lookup, NULL);
 }
 
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index eb96009e21c4..b9cfdb456456 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -75,6 +75,12 @@ extern void mss2_init(void);
 static inline void mss2_init(void) {}
 #endif
 
+#ifdef CONFIG_MACH_D2NET_DT
+void d2net_init(void);
+#else
+static inline void d2net_init(void) {}
+#endif
+
 /*****************************************************************************
  * Helpers to access Orion registers
  ****************************************************************************/
diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
index 4d720990cf2a..eba7ac4725c0 100644
--- a/arch/arm/probes/kprobes/checkers-common.c
+++ b/arch/arm/probes/kprobes/checkers-common.c
@@ -40,7 +40,7 @@ enum probes_insn checker_stack_use_imm_0xx(probes_opcode_t insn,
  * Different from other insn uses imm8, the real addressing offset of
  * STRD in T32 encoding should be imm8 * 4. See ARMARM description.
  */
-enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
+static enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
 		struct arch_probes_insn *asi,
 		const struct decode_header *h)
 {
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index e513d8a46776..c0ed17289378 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -231,7 +231,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
  * kprobe, and that level is reserved for user kprobe handlers, so we can't
  * risk encountering a new kprobe in an interrupt handler.
  */
-void __kprobes kprobe_handler(struct pt_regs *regs)
+static void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur;
 	struct kprobe_ctlblk *kcb;
diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index c78180172120..e20304f1d8bc 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -145,8 +145,6 @@ __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
 	}
 }
 
-extern void kprobe_handler(struct pt_regs *regs);
-
 static void
 optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 {
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index c562832b8627..171c7076b89f 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -720,7 +720,7 @@ static const char coverage_register_lookup[16] = {
 	[REG_TYPE_NOSPPCX]	= COVERAGE_ANY_REG | COVERAGE_SP,
 };
 
-unsigned coverage_start_registers(const struct decode_header *h)
+static unsigned coverage_start_registers(const struct decode_header *h)
 {
 	unsigned regs = 0;
 	int i;
diff --git a/arch/arm/probes/kprobes/test-core.h b/arch/arm/probes/kprobes/test-core.h
index 19a5b2add41e..805116c2ec27 100644
--- a/arch/arm/probes/kprobes/test-core.h
+++ b/arch/arm/probes/kprobes/test-core.h
@@ -453,3 +453,7 @@ void kprobe_thumb32_test_cases(void);
 #else
 void kprobe_arm_test_cases(void);
 #endif
+
+void __kprobes_test_case_start(void);
+void __kprobes_test_case_end_16(void);
+void __kprobes_test_case_end_32(void);
diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 3cb01c39c3c8..8dd679fbeed1 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -61,7 +61,7 @@ arm-pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
 	};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
index 9d1a082de3e2..32bb76b3202a 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
@@ -6,6 +6,18 @@
 /dts-v1/;
 #include "sparx5.dtsi"
 
+&psci {
+	status = "disabled";
+};
+
+&cpu0 {
+	enable-method = "spin-table";
+};
+
+&cpu1 {
+	enable-method = "spin-table";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index f6ddf17ada81..861b356a982b 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -26,7 +26,7 @@ chosen {
 
 	v1p05: v1p05-regulator {
 		compatible = "regulator-fixed";
-		reglator-name = "v1p05";
+		regulator-name = "v1p05";
 		regulator-always-on;
 		regulator-boot-on;
 
@@ -38,7 +38,7 @@ v1p05: v1p05-regulator {
 
 	v12_poe: v12-poe-regulator {
 		compatible = "regulator-fixed";
-		reglator-name = "v12_poe";
+		regulator-name = "v12_poe";
 		regulator-always-on;
 		regulator-boot-on;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c32e4a3833f2..5b79e4a37331 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1006,7 +1006,7 @@ dsi_phy0: dsi-phy@1a98300 {
 			};
 		};
 
-		camss: camss@1b00000 {
+		camss: camss@1b0ac00 {
 			compatible = "qcom,msm8916-camss";
 			reg = <0x01b0ac00 0x200>,
 				<0x01b00030 0x4>,
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index aeb5762566e9..caaf7102f579 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -489,7 +489,7 @@ restart@fc4ab000 {
 			reg = <0xfc4ab000 0x4>;
 		};
 
-		spmi_bus: spmi@fc4c0000 {
+		spmi_bus: spmi@fc4cf000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xfc4cf000 0x1000>,
 			      <0xfc4cb000 0x1000>,
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 159cdd03e7c0..73f7490911c9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -956,7 +956,7 @@ ufsphy_lane: lanes@627400 {
 			};
 		};
 
-		camss: camss@a00000 {
+		camss: camss@a34000 {
 			compatible = "qcom,msm8996-camss";
 			reg = <0x00a34000 0x1000>,
 			      <0x00a00030 0x4>,
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 05e64bfad023..24d0a1337ae1 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -270,7 +270,7 @@ hscif0_pins: hscif0 {
 	};
 
 	scif1_pins: scif1 {
-		groups = "scif1_data_b", "scif1_ctrl";
+		groups = "scif1_data_b";
 		function = "scif1";
 	};
 
@@ -330,7 +330,6 @@ rsnd_for_pcm3168a_capture: endpoint {
 &scif1 {
 	pinctrl-0 = <&scif1_pins>;
 	pinctrl-names = "default";
-	uart-has-rtscts;
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 909ab6661aef..4ec5e955c33c 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -19,25 +19,25 @@ chosen {
 &wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
-			J721E_WKUP_IOPAD(0x006c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
-			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
-			J721E_WKUP_IOPAD(0x0074, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
-			J721E_WKUP_IOPAD(0x0078, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
-			J721E_WKUP_IOPAD(0x007c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
-			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
-			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
-			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
-			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
-			J721E_WKUP_IOPAD(0x0080, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
-			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
+			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
+			J721E_WKUP_IOPAD(0x0004, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
+			J721E_WKUP_IOPAD(0x0008, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
+			J721E_WKUP_IOPAD(0x000c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
+			J721E_WKUP_IOPAD(0x0010, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
+			J721E_WKUP_IOPAD(0x0014, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
+			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
+			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
+			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
+			J721E_WKUP_IOPAD(0x002c, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
+			J721E_WKUP_IOPAD(0x0018, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
+			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
 		>;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio1-pins-default {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
-			J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
+			J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
+			J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 		>;
 	};
 };
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 0756191f44f6..59c3facb8a56 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -8,16 +8,11 @@
 #define __ASM_EXCEPTION_H
 
 #include <asm/esr.h>
-#include <asm/kprobes.h>
 #include <asm/ptrace.h>
 
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #define __exception_irq_entry	__irq_entry
-#else
-#define __exception_irq_entry	__kprobes
-#endif
 
 static inline u32 disr_to_esr(u64 disr)
 {
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3f74db7b0a31..4eedfd784cf6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -633,9 +633,9 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 	return __pud_to_phys(pud);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_page_paddr(pud));
+	return (pmd_t *)__va(pud_page_paddr(pud));
 }
 
 /* Find an entry in the second-level page table. */
@@ -694,9 +694,9 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
 	return __p4d_to_phys(p4d);
 }
 
-static inline unsigned long p4d_page_vaddr(p4d_t p4d)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
-	return (unsigned long)__va(p4d_page_paddr(p4d));
+	return (pud_t *)__va(p4d_page_paddr(p4d));
 }
 
 /* Find an entry in the frst-level page table. */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3284709ef567..78f9fb638c9c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -421,7 +421,7 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 				  phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
@@ -448,7 +448,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 				phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not updating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 9f64fdfbf275..6e5c38756657 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -279,7 +279,7 @@ extern unsigned long VMALLOC_END;
 #define pud_bad(pud)			(!ia64_phys_addr_valid(pud_val(pud)))
 #define pud_present(pud)		(pud_val(pud) != 0UL)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define pud_page_vaddr(pud)		((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_pgtable(pud)		((pmd_t *) __va(pud_val(pud) & _PFN_MASK))
 #define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #if CONFIG_PGTABLE_LEVELS == 4
@@ -287,7 +287,7 @@ extern unsigned long VMALLOC_END;
 #define p4d_bad(p4d)			(!ia64_phys_addr_valid(p4d_val(p4d)))
 #define p4d_present(p4d)		(p4d_val(p4d) != 0UL)
 #define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
-#define p4d_page_vaddr(p4d)		((unsigned long) __va(p4d_val(p4d) & _PFN_MASK))
+#define p4d_pgtable(p4d)		((pud_t *) __va(p4d_val(p4d) & _PFN_MASK))
 #define p4d_page(p4d)			virt_to_page((p4d_val(p4d) + PAGE_OFFSET))
 #endif
 
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 8076467eff4b..956c80874f98 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -129,7 +129,7 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 
 #define __pte_page(pte) ((unsigned long)__va(pte_val(pte) & PAGE_MASK))
 #define pmd_page_vaddr(pmd) ((unsigned long)__va(pmd_val(pmd) & _TABLE_MASK))
-#define pud_page_vaddr(pud) ((unsigned long)__va(pud_val(pud) & _TABLE_MASK))
+#define pud_pgtable(pud) ((pmd_t *)__va(pud_val(pud) & _TABLE_MASK))
 
 
 #define pte_none(pte)		(!pte_val(pte))
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 1e7d6ce9d8d6..b865edff2670 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -210,9 +210,9 @@ static inline void p4d_clear(p4d_t *p4dp)
 	p4d_val(*p4dp) = (unsigned long)invalid_pud_table;
 }
 
-static inline unsigned long p4d_page_vaddr(p4d_t p4d)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
-	return p4d_val(p4d);
+	return (pud_t *)p4d_val(p4d);
 }
 
 #define p4d_phys(p4d)		virt_to_phys((void *)p4d_val(p4d))
@@ -314,9 +314,9 @@ static inline void pud_clear(pud_t *pudp)
 #endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)pud_val(pud);
 }
 #define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d120201910ac..f8d1933bfe82 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1721,7 +1721,10 @@ static inline void decode_cpucfg(struct cpuinfo_mips *c)
 
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 {
+	c->cputype = CPU_LOONGSON64;
+
 	/* All Loongson processors covered here define ExcCode 16 as GSExc. */
+	decode_configs(c);
 	c->options |= MIPS_CPU_GSEXCEX;
 
 	switch (c->processor_id & PRID_IMP_MASK) {
@@ -1731,7 +1734,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		case PRID_REV_LOONGSON2K_R1_1:
 		case PRID_REV_LOONGSON2K_R1_2:
 		case PRID_REV_LOONGSON2K_R1_3:
-			c->cputype = CPU_LOONGSON64;
 			__cpu_name[cpu] = "Loongson-2K";
 			set_elf_platform(cpu, "gs264e");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1744,14 +1746,12 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON3A_R2_0:
 		case PRID_REV_LOONGSON3A_R2_1:
-			c->cputype = CPU_LOONGSON64;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
 			break;
 		case PRID_REV_LOONGSON3A_R3_0:
 		case PRID_REV_LOONGSON3A_R3_1:
-			c->cputype = CPU_LOONGSON64;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1771,7 +1771,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
 		break;
 	case PRID_IMP_LOONGSON_64G:
-		c->cputype = CPU_LOONGSON64;
 		__cpu_name[cpu] = "ICT Loongson-3";
 		set_elf_platform(cpu, "loongson3a");
 		set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1781,8 +1780,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		panic("Unknown Loongson Processor ID!");
 		break;
 	}
-
-	decode_configs(c);
 }
 #else
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu) { }
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 8964798b8274..ade591927cbf 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -330,8 +330,8 @@ static inline void pmd_clear(pmd_t *pmd) {
 
 
 #if CONFIG_PGTABLE_LEVELS == 3
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_address(pud)))
-#define pud_page(pud)	virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_address(pud)))
+#define pud_page(pud)	virt_to_page((void *)pud_pgtable(pud))
 
 /* For 64 bit we have three level tables */
 
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 52abca88b5b2..e03fb9154420 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -234,7 +234,7 @@ config PPC_EARLY_DEBUG_40x
 
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
-	depends on SERIAL_CPM
+	depends on SERIAL_CPM=y
 	help
 	  Select this to enable early debugging for Freescale chips
 	  using a CPM-based serial port.  This assumes that the bootwrapper
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a3f66ade09b3..912e64ab5f24 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -429,3 +429,11 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
+	@if test "x${CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT}" = "xy" -a \
+		"x${CONFIG_LD_IS_BFD}" = "xy" -a \
+		"${CONFIG_LD_VERSION}" = "23700" ; then \
+		echo -n '*** binutils 2.37 drops unused section symbols, which recordmcount ' ; \
+		echo 'is unable to handle.' ; \
+		echo '*** Please use a different binutils version.' ; \
+		false ; \
+	fi
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 71e2c524f1ee..2b4af824bdc5 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1030,8 +1030,15 @@ extern struct page *p4d_page(p4d_t p4d);
 /* Pointers in the page table tree are physical addresses */
 #define __pgtable_ptr_val(ptr)	__pa(ptr)
 
-#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
-#define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
+{
+	return (pud_t *)__va(p4d_val(p4d) & ~P4D_MASKED_BITS);
+}
+
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)__va(pud_val(pud) & ~PUD_MASKED_BITS);
+}
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index fe2f4c9acd9e..10f5cf444d72 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -56,10 +56,14 @@
 #define p4d_none(p4d)		(!p4d_val(p4d))
 #define p4d_bad(p4d)		(p4d_val(p4d) == 0)
 #define p4d_present(p4d)	(p4d_val(p4d) != 0)
-#define p4d_page_vaddr(p4d)	(p4d_val(p4d) & ~P4D_MASKED_BITS)
 
 #ifndef __ASSEMBLY__
 
+static inline pud_t *p4d_pgtable(p4d_t p4d)
+{
+	return (pud_t *) (p4d_val(p4d) & ~P4D_MASKED_BITS);
+}
+
 static inline void p4d_clear(p4d_t *p4dp)
 {
 	*p4dp = __p4d(0);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 1eacff0fff02..a4d475c0fc2c 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -164,7 +164,11 @@ static inline void pud_clear(pud_t *pudp)
 #define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
-#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)(pud_val(pud) & ~PUD_MASKED_BITS);
+}
 
 extern struct page *pud_page(pud_t pud);
 
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 5f0a2fa611fa..3728c17de87e 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -783,9 +783,9 @@ static void free_pud_table(pud_t *pud_start, p4d_t *p4d)
 }
 
 static void remove_pte_table(pte_t *pte_start, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
-	unsigned long next;
+	unsigned long next, pages = 0;
 	pte_t *pte;
 
 	pte = pte_start + pte_index(addr);
@@ -807,13 +807,16 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 		}
 
 		pte_clear(&init_mm, addr, pte);
+		pages++;
 	}
+	if (direct)
+		update_page_count(mmu_virtual_psize, -pages);
 }
 
 static void __meminit remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
-			     unsigned long end)
+				       unsigned long end, bool direct)
 {
-	unsigned long next;
+	unsigned long next, pages = 0;
 	pte_t *pte_base;
 	pmd_t *pmd;
 
@@ -831,19 +834,22 @@ static void __meminit remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 				continue;
 			}
 			pte_clear(&init_mm, addr, (pte_t *)pmd);
+			pages++;
 			continue;
 		}
 
 		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
-		remove_pte_table(pte_base, addr, next);
+		remove_pte_table(pte_base, addr, next, direct);
 		free_pte_table(pte_base, pmd);
 	}
+	if (direct)
+		update_page_count(MMU_PAGE_2M, -pages);
 }
 
 static void __meminit remove_pud_table(pud_t *pud_start, unsigned long addr,
-			     unsigned long end)
+				       unsigned long end, bool direct)
 {
-	unsigned long next;
+	unsigned long next, pages = 0;
 	pmd_t *pmd_base;
 	pud_t *pud;
 
@@ -861,16 +867,20 @@ static void __meminit remove_pud_table(pud_t *pud_start, unsigned long addr,
 				continue;
 			}
 			pte_clear(&init_mm, addr, (pte_t *)pud);
+			pages++;
 			continue;
 		}
 
-		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
-		remove_pmd_table(pmd_base, addr, next);
+		pmd_base = pud_pgtable(*pud);
+		remove_pmd_table(pmd_base, addr, next, direct);
 		free_pmd_table(pmd_base, pud);
 	}
+	if (direct)
+		update_page_count(MMU_PAGE_1G, -pages);
 }
 
-static void __meminit remove_pagetable(unsigned long start, unsigned long end)
+static void __meminit remove_pagetable(unsigned long start, unsigned long end,
+				       bool direct)
 {
 	unsigned long addr, next;
 	pud_t *pud_base;
@@ -898,8 +908,8 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 			continue;
 		}
 
-		pud_base = (pud_t *)p4d_page_vaddr(*p4d);
-		remove_pud_table(pud_base, addr, next);
+		pud_base = p4d_pgtable(*p4d);
+		remove_pud_table(pud_base, addr, next, direct);
 		free_pud_table(pud_base, p4d);
 	}
 
@@ -922,7 +932,7 @@ int __meminit radix__create_section_mapping(unsigned long start,
 
 int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
 {
-	remove_pagetable(start, end);
+	remove_pagetable(start, end, true);
 	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
@@ -958,7 +968,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 #ifdef CONFIG_MEMORY_HOTPLUG
 void __meminit radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
 {
-	remove_pagetable(start, start + page_size);
+	remove_pagetable(start, start + page_size, false);
 }
 #endif
 #endif
@@ -1156,7 +1166,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pmd_t *pmd;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pud_clear(pud);
 
 	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 386be136026e..b76cd49d521b 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -188,7 +188,7 @@ static bool altmap_cross_boundary(struct vmem_altmap *altmap, unsigned long star
 	unsigned long nr_pfn = page_size / sizeof(struct page);
 	unsigned long start_pfn = page_to_pfn((struct page *)start);
 
-	if ((start_pfn + nr_pfn) > altmap->end_pfn)
+	if ((start_pfn + nr_pfn - 1) > altmap->end_pfn)
 		return true;
 
 	if (start_pfn < altmap->base_pfn)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index aefc2bfdf104..175aabf101e8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -106,7 +106,7 @@ struct page *p4d_page(p4d_t p4d)
 			VM_WARN_ON(!p4d_huge(p4d));
 		return pte_page(p4d_pte(p4d));
 	}
-	return virt_to_page(p4d_page_vaddr(p4d));
+	return virt_to_page(p4d_pgtable(p4d));
 }
 #endif
 
@@ -117,7 +117,7 @@ struct page *pud_page(pud_t pud)
 			VM_WARN_ON(!pud_huge(pud));
 		return pte_page(pud_pte(pud));
 	}
-	return virt_to_page(pud_page_vaddr(pud));
+	return virt_to_page(pud_pgtable(pud));
 }
 
 /*
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 28aac933a439..e3e52ff2cbf5 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -600,12 +600,12 @@ static void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	struct pnv_iov_data   *iov;
 
 	iov = pnv_iov_get(pdev);
-	num_vfs = iov->num_vfs;
-	base_pe = iov->vf_pe_arr[0].pe_number;
-
 	if (WARN_ON(!iov))
 		return;
 
+	num_vfs = iov->num_vfs;
+	base_pe = iov->vf_pe_arr[0].pe_number;
+
 	/* Release VF PEs */
 	pnv_ioda_release_vf_PE(pdev);
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index f3b0da64c6c8..0e863f3f7187 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -60,9 +60,9 @@ static inline void pud_clear(pud_t *pudp)
 	set_pud(pudp, __pud(0));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
 }
 
 static inline struct page *pud_page(pud_t pud)
diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 75c1e9996867..ef336fe16004 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -69,6 +69,7 @@ struct rv_jit_context {
 	struct bpf_prog *prog;
 	u16 *insns;		/* RV insns */
 	int ninsns;
+	int prologue_len;
 	int epilogue_offset;
 	int *offset;		/* BPF to RV */
 	unsigned long flags;
@@ -214,8 +215,8 @@ static inline int rv_offset(int insn, int off, struct rv_jit_context *ctx)
 	int from, to;
 
 	off++; /* BPF branch is from PC+1, RV is from PC */
-	from = (insn > 0) ? ctx->offset[insn - 1] : 0;
-	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : 0;
+	from = (insn > 0) ? ctx->offset[insn - 1] : ctx->prologue_len;
+	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : ctx->prologue_len;
 	return ninsns_rvoff(to - from);
 }
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c113ae818b14..053dc83e323b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1144,16 +1144,3 @@ void bpf_jit_build_epilogue(struct rv_jit_context *ctx)
 {
 	__build_epilogue(false, ctx);
 }
-
-void *bpf_jit_alloc_exec(unsigned long size)
-{
-	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
-				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
-}
-
-void bpf_jit_free_exec(void *addr)
-{
-	return vfree(addr);
-}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index cbf7d2414886..ef17bc8055d4 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -83,6 +83,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = orig_prog;
 		goto out_offset;
 	}
+
+	if (build_body(ctx, extra_pass, NULL)) {
+		prog = orig_prog;
+		goto out_offset;
+	}
+
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 32;
 		ctx->offset[i] = prev_ninsns;
@@ -91,11 +97,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
 		pass++;
 		ctx->ninsns = 0;
+
+		bpf_jit_build_prologue(ctx);
+		ctx->prologue_len = ctx->ninsns;
+
 		if (build_body(ctx, extra_pass, ctx->offset)) {
 			prog = orig_prog;
 			goto out_offset;
 		}
-		bpf_jit_build_prologue(ctx);
+
 		ctx->epilogue_offset = ctx->ninsns;
 		bpf_jit_build_epilogue(ctx);
 
@@ -153,6 +163,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
 
 	if (!prog->is_func || extra_pass) {
+		bpf_jit_binary_lock_ro(jit_data->header);
+		for (i = 0; i < prog->len; i++)
+			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
+		bpf_prog_fill_jited_linfo(prog, ctx->offset);
 out_offset:
 		kfree(ctx->offset);
 		kfree(jit_data);
@@ -165,3 +179,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
+				    BPF_JIT_REGION_END, GFP_KERNEL,
+				    PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void bpf_jit_free_exec(void *addr)
+{
+	return vfree(addr);
+}
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index a8cb00f30a7c..39ffcd4389f1 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -29,6 +29,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
+KBUILD_CFLAGS_DECOMPRESSOR += -fPIE
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7ffc73ba220f..7a326d03087a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2005,6 +2005,10 @@ static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
 		ms = slots->memslots + slotidx;
 		ofs = 0;
 	}
+
+	if (cur_gfn < ms->base_gfn)
+		ofs = 0;
+
 	ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, ofs);
 	while ((slotidx > 0) && (ofs >= ms->npages)) {
 		slotidx--;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index ff58decfef5e..192eacc8fbb7 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -168,7 +168,8 @@ static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
 			    sizeof(struct kvm_s390_apcb0)))
 		return -EFAULT;
 
-	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb0));
+	bitmap_and(apcb_s, apcb_s, apcb_h,
+		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb0));
 
 	return 0;
 }
@@ -190,7 +191,8 @@ static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
 			    sizeof(struct kvm_s390_apcb1)))
 		return -EFAULT;
 
-	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb1));
+	bitmap_and(apcb_s, apcb_s, apcb_h,
+		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb1));
 
 	return 0;
 }
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 96c626c2cd0a..306fba1564e5 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -18,6 +18,18 @@
 #include <cpu/dma-register.h>
 #include <cpu/dma.h>
 
+/*
+ * Some of the SoCs feature two DMAC modules. In such a case, the channels are
+ * distributed equally among them.
+ */
+#ifdef	SH_DMAC_BASE1
+#define	SH_DMAC_NR_MD_CH	(CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
+#else
+#define	SH_DMAC_NR_MD_CH	CONFIG_NR_ONCHIP_DMA_CHANNELS
+#endif
+
+#define	SH_DMAC_CH_SZ		0x10
+
 /*
  * Define the default configuration for dual address memory-memory transfer.
  * The 0x400 value represents auto-request, external->external.
@@ -29,7 +41,7 @@ static unsigned long dma_find_base(unsigned int chan)
 	unsigned long base = SH_DMAC_BASE0;
 
 #ifdef SH_DMAC_BASE1
-	if (chan >= 6)
+	if (chan >= SH_DMAC_NR_MD_CH)
 		base = SH_DMAC_BASE1;
 #endif
 
@@ -40,13 +52,13 @@ static unsigned long dma_base_addr(unsigned int chan)
 {
 	unsigned long base = dma_find_base(chan);
 
-	/* Normalize offset calculation */
-	if (chan >= 9)
-		chan -= 6;
-	if (chan >= 4)
-		base += 0x10;
+	chan = (chan % SH_DMAC_NR_MD_CH) * SH_DMAC_CH_SZ;
+
+	/* DMAOR is placed inside the channel register space. Step over it. */
+	if (chan >= DMAOR)
+		base += SH_DMAC_CH_SZ;
 
-	return base + (chan * 0x10);
+	return base + chan;
 }
 
 #ifdef CONFIG_SH_DMA_IRQ_MULTI
@@ -250,12 +262,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
 #define NR_DMAOR	1
 #endif
 
-/*
- * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
- * channels 0 - 5, DMAOR1 6 - 11 (optional).
- */
-#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
-#define dmaor_write_reg(n, data)	__raw_writew(data, dma_find_base(n)*6)
+#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * \
+						    SH_DMAC_NR_MD_CH) + DMAOR)
+#define dmaor_write_reg(n, data)	__raw_writew(data, \
+						     dma_find_base((n) * \
+						     SH_DMAC_NR_MD_CH) + DMAOR)
 
 static inline int dmaor_reset(int no)
 {
diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 82d74472dfcd..cdced80a7ffa 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -32,9 +32,9 @@ typedef struct { unsigned long long pmd; } pmd_t;
 #define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) } )
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)(unsigned long)pud_val(pud);
 }
 
 /* only used by the stubbed out hugetlb gup code, should never be called */
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index d342ea08843f..70a07f4f2142 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -21,7 +21,7 @@ static int __init scan_cache(unsigned long node, const char *uname,
 	if (!of_flat_dt_is_compatible(node, "jcore,cache"))
 		return 0;
 
-	j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
+	j2_ccr_base = ioremap(of_flat_dt_translate_address(node), 4);
 
 	return 1;
 }
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 632cdb959542..7d1d10a8fd93 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -152,13 +152,13 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)__nocache_va(v << 4);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	if (srmmu_device_memory(pud_val(pud))) {
-		return ~0;
+		return (pmd_t *)~0;
 	} else {
 		unsigned long v = pud_val(pud) & SRMMU_PTD_PMASK;
-		return (unsigned long)__nocache_va(v << 4);
+		return (pmd_t *)__nocache_va(v << 4);
 	}
 }
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 7ef6affa105e..5a1efd600f77 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -845,23 +845,23 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return ((unsigned long) __va(pfn << PAGE_SHIFT));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
 	unsigned long pfn;
 
 	pfn = pte_pfn(pte);
 
-	return ((unsigned long) __va(pfn << PAGE_SHIFT));
+	return ((pmd_t *) __va(pfn << PAGE_SHIFT));
 }
 
 #define pmd_page(pmd) 			virt_to_page((void *)pmd_page_vaddr(pmd))
-#define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_page(pud)			virt_to_page((void *)pud_pgtable(pud))
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)		(pud_val(pud) != 0U)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define p4d_page_vaddr(p4d)		\
-	((unsigned long) __va(p4d_val(p4d)))
+#define p4d_pgtable(p4d)		\
+	((pud_t *) __va(p4d_val(p4d)))
 #define p4d_present(p4d)		(p4d_val(p4d) != 0U)
 #define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
 
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 775615141339..56e5320da762 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -147,7 +147,7 @@ export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 7e6a4180db9d..091bff319ccd 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -84,7 +84,7 @@ static inline void pud_clear (pud_t *pud)
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_val(pud) & PAGE_MASK))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_val(pud) & PAGE_MASK))
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 52eba415928a..afc955340f81 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -364,7 +364,7 @@ static int amd_pmu_hw_config(struct perf_event *event)
 
 	/* pass precise event sampling to ibs: */
 	if (event->attr.precise_ip && get_ibs_caps())
-		return -ENOENT;
+		return forward_event_to_ibs(event);
 
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 8a85658a24cc..354d52e17ef5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -202,7 +202,7 @@ static struct perf_ibs *get_ibs_pmu(int type)
 }
 
 /*
- * Use IBS for precise event sampling:
+ * core pmu config -> IBS config
  *
  *  perf record -a -e cpu-cycles:p ...    # use ibs op counting cycle count
  *  perf record -a -e r076:p ...          # same as -e cpu-cycles:p
@@ -211,25 +211,9 @@ static struct perf_ibs *get_ibs_pmu(int type)
  * IbsOpCntCtl (bit 19) of IBS Execution Control Register (IbsOpCtl,
  * MSRC001_1033) is used to select either cycle or micro-ops counting
  * mode.
- *
- * The rip of IBS samples has skid 0. Thus, IBS supports precise
- * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
- * rip is invalid when IBS was not able to record the rip correctly.
- * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
- *
  */
-static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
+static int core_pmu_ibs_config(struct perf_event *event, u64 *config)
 {
-	switch (event->attr.precise_ip) {
-	case 0:
-		return -ENOENT;
-	case 1:
-	case 2:
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		switch (event->attr.config) {
@@ -255,22 +239,37 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 	return -EOPNOTSUPP;
 }
 
+/*
+ * The rip of IBS samples has skid 0. Thus, IBS supports precise
+ * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
+ * rip is invalid when IBS was not able to record the rip correctly.
+ * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
+ */
+int forward_event_to_ibs(struct perf_event *event)
+{
+	u64 config = 0;
+
+	if (!event->attr.precise_ip || event->attr.precise_ip > 2)
+		return -EOPNOTSUPP;
+
+	if (!core_pmu_ibs_config(event, &config)) {
+		event->attr.type = perf_ibs_op.pmu.type;
+		event->attr.config = config;
+	}
+	return -ENOENT;
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
 	u64 max_cnt, config;
-	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
-	if (perf_ibs) {
-		config = event->attr.config;
-	} else {
-		perf_ibs = &perf_ibs_op;
-		ret = perf_ibs_precise_event(event, &config);
-		if (ret)
-			return ret;
-	}
+	if (!perf_ibs)
+		return -ENOENT;
+
+	config = event->attr.config;
 
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index b9a7fd0a27e2..a4e4bbb7795d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -412,8 +412,10 @@ struct pebs_xmm {
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
+extern int forward_event_to_ibs(struct perf_event *event);
 #else
 static inline u32 get_ibs_caps(void) { return 0; }
+static inline int forward_event_to_ibs(struct perf_event *event) { return -ENOENT; }
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 87de9f2d71cf..9bacde3ff514 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -865,9 +865,9 @@ static inline int pud_present(pud_t pud)
 	return pud_flags(pud) & _PAGE_PRESENT;
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_val(pud) & pud_pfn_mask(pud));
+	return (pmd_t *)__va(pud_val(pud) & pud_pfn_mask(pud));
 }
 
 /*
@@ -906,9 +906,9 @@ static inline int p4d_present(p4d_t p4d)
 	return p4d_flags(p4d) & _PAGE_PRESENT;
 }
 
-static inline unsigned long p4d_page_vaddr(p4d_t p4d)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
-	return (unsigned long)__va(p4d_val(p4d) & p4d_pfn_mask(p4d));
+	return (pud_t *)__va(p4d_val(p4d) & p4d_pfn_mask(p4d));
 }
 
 /*
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 56d0399a0cd1..dd520b44e89c 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -235,8 +235,8 @@ static inline void native_pgd_clear(pgd_t *pgd)
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
 #define __pmd_to_swp_entry(pmd)		((swp_entry_t) { pmd_val((pmd)) })
-#define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
-#define __swp_entry_to_pmd(x)		((pmd_t) { .pmd = (x).val })
+#define __swp_entry_to_pte(x)		(__pte((x).val))
+#define __swp_entry_to_pmd(x)		(__pmd((x).val))
 
 extern int kern_addr_valid(unsigned long addr);
 extern void cleanup_highmap(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1a943743cfe4..1e73b6fae3b4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -715,11 +715,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 {
 	struct task_struct *p, *t;
+	pid_t pid;
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r))
-			seq_printf(s, "%d\n", t->pid);
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
+			pid = task_pid_vnr(t);
+			if (pid)
+				seq_printf(s, "%d\n", pid);
+		}
 	}
 	rcu_read_unlock();
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index bda89ecc7799..d2403da17842 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -100,6 +100,17 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+struct mwait_cpu_dead {
+	unsigned int	control;
+	unsigned int	status;
+};
+
+/*
+ * Cache line aligned data for mwait_play_dead(). Separate on purpose so
+ * that it's unlikely to be touched by other CPUs.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -1674,10 +1685,10 @@ EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
  */
 static inline void mwait_play_dead(void)
 {
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
-	void *mwait_ptr;
 	int i;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
@@ -1712,13 +1723,6 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
-	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
-	 */
-	mwait_ptr = &current_thread_info()->flags;
-
 	wbinvd();
 
 	while (1) {
@@ -1730,9 +1734,9 @@ static inline void mwait_play_dead(void)
 		 * case where we return around the loop.
 		 */
 		mb();
-		clflush(mwait_ptr);
+		clflush(md);
 		mb();
-		__monitor(mwait_ptr, 0, 0);
+		__monitor(md, 0, 0);
 		mb();
 		__mwait(eax, 0);
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 20951ab522a1..acf4e50c5988 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -193,8 +193,8 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
 			spin_lock(pgt_lock);
 
 			if (!p4d_none(*p4d_ref) && !p4d_none(*p4d))
-				BUG_ON(p4d_page_vaddr(*p4d)
-				       != p4d_page_vaddr(*p4d_ref));
+				BUG_ON(p4d_pgtable(*p4d)
+				       != p4d_pgtable(*p4d_ref));
 
 			if (p4d_none(*p4d))
 				set_p4d(p4d, *p4d_ref);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 40baa90e74f4..217dda690ed8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1126,7 +1126,7 @@ static void __unmap_pmd_range(pud_t *pud, pmd_t *pmd,
 			      unsigned long start, unsigned long end)
 {
 	if (unmap_pte_range(pmd, start, end))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
@@ -1170,7 +1170,7 @@ static void unmap_pmd_range(pud_t *pud, unsigned long start, unsigned long end)
 	 * Try again to free the PMD page if haven't succeeded above.
 	 */
 	if (!pud_none(*pud))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f6a9e2e36642..204b25ee26f0 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -805,7 +805,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pte_t *pte;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (!pmd_sv)
 		return 0;
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 08d70c868c13..1270de83435e 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -231,7 +231,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 
 	init += sizeof(TRANSPORT_TUNTAP_NAME) - 1;
 	if (*init == ',') {
-		rem = split_if_spec(init + 1, &mac_str, &dev_name);
+		rem = split_if_spec(init + 1, &mac_str, &dev_name, NULL);
 		if (rem != NULL) {
 			pr_err("%s: extra garbage on specification : '%s'\n",
 			       dev->name, rem);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 105ad23dff06..7ba7c4e4e4c9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2426,6 +2426,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	u32 hwi, adj_step;
 	s64 margin;
 	u64 cost, new_inuse;
+	unsigned long flags;
 
 	current_hweight(iocg, NULL, &hwi);
 	old_hwi = hwi;
@@ -2444,11 +2445,11 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	    iocg->inuse == iocg->active)
 		return cost;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock_irqsave(&ioc->lock, flags);
 
 	/* we own inuse only when @iocg is in the normal active state */
 	if (iocg->abs_vdebt || list_empty(&iocg->active_list)) {
-		spin_unlock_irq(&ioc->lock);
+		spin_unlock_irqrestore(&ioc->lock, flags);
 		return cost;
 	}
 
@@ -2469,7 +2470,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	} while (time_after64(vtime + cost, now->vnow) &&
 		 iocg->inuse != iocg->active);
 
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock_irqrestore(&ioc->lock, flags);
 
 	TRACE_IOCG_PATH(inuse_adjust, iocg, now,
 			old_inuse, iocg->inuse, old_hwi, hwi);
diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 9526491d9aed..a99ec7f1a174 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -11,10 +11,18 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/types.h>
+#include <linux/mm_types.h>
+#include <linux/overflow.h>
 #include <linux/affs_hardblocks.h>
 
 #include "check.h"
 
+/* magic offsets in partition DosEnvVec */
+#define NR_HD	3
+#define NR_SECT	5
+#define LO_CYL	9
+#define HI_CYL	10
+
 static __inline__ u32
 checksum_block(__be32 *m, int size)
 {
@@ -31,8 +39,12 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	int start_sect, nr_sects, blk, part, res = 0;
-	int blksize = 1;	/* Multiplier for disk block size */
+	u64 start_sect, nr_sects;
+	sector_t blk, end_sect;
+	u32 cylblk;		/* rdb_CylBlocks = nr_heads*sect_per_track */
+	u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
+	int part, res = 0;
+	unsigned int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 	char b[BDEVNAME_SIZE];
 
@@ -41,7 +53,7 @@ int amiga_partition(struct parsed_partitions *state)
 			goto rdb_done;
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read RDB block %d\n",
+			pr_err("Dev %s: unable to read RDB block %llu\n",
 			       bdevname(state->bdev, b), blk);
 			res = -1;
 			goto rdb_done;
@@ -58,12 +70,12 @@ int amiga_partition(struct parsed_partitions *state)
 		*(__be32 *)(data+0xdc) = 0;
 		if (checksum_block((__be32 *)data,
 				be32_to_cpu(rdb->rdb_SummedLongs) & 0x7F)==0) {
-			pr_err("Trashed word at 0xd0 in block %d ignored in checksum calculation\n",
+			pr_err("Trashed word at 0xd0 in block %llu ignored in checksum calculation\n",
 			       blk);
 			break;
 		}
 
-		pr_err("Dev %s: RDB in block %d has bad checksum\n",
+		pr_err("Dev %s: RDB in block %llu has bad checksum\n",
 		       bdevname(state->bdev, b), blk);
 	}
 
@@ -79,11 +91,16 @@ int amiga_partition(struct parsed_partitions *state)
 	}
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
-	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
-		blk *= blksize;	/* Read in terms partition table understands */
+	for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {
+		/* Read in terms partition table understands */
+		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
+			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
+				bdevname(state->bdev, b), blk, part);
+			break;
+		}
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read partition block %d\n",
+			pr_err("Dev %s: unable to read partition block %llu\n",
 			       bdevname(state->bdev, b), blk);
 			res = -1;
 			goto rdb_done;
@@ -95,19 +112,70 @@ int amiga_partition(struct parsed_partitions *state)
 		if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
 			continue;
 
-		/* Tell Kernel about it */
+		/* RDB gives us more than enough rope to hang ourselves with,
+		 * many times over (2^128 bytes if all fields max out).
+		 * Some careful checks are in order, so check for potential
+		 * overflows.
+		 * We are multiplying four 32 bit numbers to one sector_t!
+		 */
+
+		nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
+		nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
+
+		/* CylBlocks is total number of blocks per cylinder */
+		if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
+			pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
+				bdevname(state->bdev, b), cylblk);
+			continue;
+		}
+
+		/* check for consistency with RDB defined CylBlocks */
+		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
+			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
+				bdevname(state->bdev, b), cylblk,
+				be32_to_cpu(rdb->rdb_CylBlocks));
+		}
+
+		/* RDB allows for variable logical block size -
+		 * normalize to 512 byte blocks and check result.
+		 */
+
+		if (check_mul_overflow(cylblk, blksize, &cylblk)) {
+			pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
+				bdevname(state->bdev, b), part);
+			continue;
+		}
+
+		/* Calculate partition start and end. Limit of 32 bit on cylblk
+		 * guarantees no overflow occurs if LBD support is enabled.
+		 */
+
+		lo_cyl = be32_to_cpu(pb->pb_Environment[LO_CYL]);
+		start_sect = ((u64) lo_cyl * cylblk);
+
+		hi_cyl = be32_to_cpu(pb->pb_Environment[HI_CYL]);
+		nr_sects = (((u64) hi_cyl - lo_cyl + 1) * cylblk);
 
-		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
-			    be32_to_cpu(pb->pb_Environment[9])) *
-			   be32_to_cpu(pb->pb_Environment[3]) *
-			   be32_to_cpu(pb->pb_Environment[5]) *
-			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
-			     be32_to_cpu(pb->pb_Environment[3]) *
-			     be32_to_cpu(pb->pb_Environment[5]) *
-			     blksize;
+
+		/* Warn user if partition end overflows u32 (AmigaDOS limit) */
+
+		if ((start_sect + nr_sects) > UINT_MAX) {
+			pr_warn("Dev %s: partition %u (%llu-%llu) needs 64 bit device support!\n",
+				bdevname(state->bdev, b), part,
+				start_sect, start_sect + nr_sects);
+		}
+
+		if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
+			pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
+				bdevname(state->bdev, b), part,
+				start_sect, end_sect);
+			continue;
+		}
+
+		/* Tell Kernel about it */
+
 		put_partition(state,slot++,start_sect,nr_sects);
 		{
 			/* Be even more informative to aid mounting */
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0d93a5ef4d07..4861aad1a9e9 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -82,6 +82,15 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 	},
+	{
+		/* Nextbook Ares 8A tablet, _LID device always reports lid closed */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
+	},
 	{
 		/*
 		 * Medion Akoya E2215T, notification of the LID device only
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 038542b3a80a..b02d381e7848 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -332,6 +332,22 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo ThinkPad X131e (3371 AMD version) */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "3371"),
+		},
+	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple iMac11,3 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d0ba5459ce0b..8a90f08c9682 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2763,10 +2763,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
 	err = of_property_read_u32(state_node, "min-residency-us", &residency);
 	if (!err)
-		genpd_state->residency_ns = 1000 * residency;
+		genpd_state->residency_ns = 1000LL * residency;
 
-	genpd_state->power_on_latency_ns = 1000 * exit_latency;
-	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+	genpd_state->power_on_latency_ns = 1000LL * exit_latency;
+	genpd_state->power_off_latency_ns = 1000LL * entry_latency;
 	genpd_state->fwnode = &state_node->fwnode;
 
 	return 0;
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 62b95a9212ae..051c10e730f9 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -242,8 +242,8 @@ static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
 static const struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.write = regmap_i2c_smbus_i2c_write,
 	.read = regmap_i2c_smbus_i2c_read,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 1,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 1,
 };
 
 static int regmap_i2c_smbus_i2c_write_reg16(void *context, const void *data,
@@ -299,8 +299,8 @@ static int regmap_i2c_smbus_i2c_read_reg16(void *context, const void *reg,
 static const struct regmap_bus regmap_i2c_smbus_i2c_block_reg16 = {
 	.write = regmap_i2c_smbus_i2c_write_reg16,
 	.read = regmap_i2c_smbus_i2c_read_reg16,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 2,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 2,
 };
 
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index 67f89937219c..ad1da83e849f 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -666,7 +666,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2a3c3dfefdce..55a30afc14a0 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1998,8 +1998,6 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
-	size_t max_data = map->max_raw_write - map->format.reg_bytes -
-			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2007,8 +2005,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > max_data)
-		chunk_regs = max_data / val_bytes;
+	else if (map->max_raw_write && val_len > map->max_raw_write)
+		chunk_regs = map->max_raw_write / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b6940f0a9c90..e0f805ca0e72 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1723,7 +1723,8 @@ static int nbd_dev_add(int index)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 4ee20be76508..4b1641fe30db 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1748,7 +1748,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 	if (!ddata->module_va)
 		return -EIO;
 
-	/* DISP_CONTROL */
+	/* DISP_CONTROL, shut down lcd and digit on disable if enabled */
 	val = sysc_read(ddata, dispc_offset + 0x40);
 	lcd_en = val & lcd_en_mask;
 	digit_en = val & digit_en_mask;
@@ -1760,7 +1760,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 		else
 			irq_mask |= BIT(2) | BIT(3);	/* EVSYNC bits */
 	}
-	if (disable & (lcd_en | digit_en))
+	if (disable && (lcd_en || digit_en))
 		sysc_write(ddata, dispc_offset + 0x40,
 			   val & ~(lcd_en_mask | digit_en_mask));
 
diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 9b182e5bfa87..dbb2da630611 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -110,7 +110,7 @@ static int imx_rngc_self_test(struct imx_rngc *rngc)
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, RNGC_TIMEOUT);
+	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 	imx_rngc_irq_mask_clear(rngc);
 	if (!ret)
 		return -ETIMEDOUT;
@@ -187,9 +187,7 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done,
-				RNGC_TIMEOUT);
-
+		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 		if (!ret) {
 			ret = -ETIMEDOUT;
 			goto err;
diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
index 15ba1e6fae4d..6e9dfac9fc9f 100644
--- a/drivers/char/hw_random/st-rng.c
+++ b/drivers/char/hw_random/st-rng.c
@@ -42,7 +42,6 @@
 
 struct st_rng_data {
 	void __iomem	*base;
-	struct clk	*clk;
 	struct hwrng	ops;
 };
 
@@ -85,26 +84,18 @@ static int st_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	ddata->ops.priv	= (unsigned long)ddata;
 	ddata->ops.read	= st_rng_read;
 	ddata->ops.name	= pdev->name;
 	ddata->base	= base;
-	ddata->clk	= clk;
-
-	dev_set_drvdata(&pdev->dev, ddata);
 
 	ret = devm_hwrng_register(&pdev->dev, &ddata->ops);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register HW RNG\n");
-		clk_disable_unprepare(clk);
 		return ret;
 	}
 
@@ -113,15 +104,6 @@ static int st_rng_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_rng_remove(struct platform_device *pdev)
-{
-	struct st_rng_data *ddata = dev_get_drvdata(&pdev->dev);
-
-	clk_disable_unprepare(ddata->clk);
-
-	return 0;
-}
-
 static const struct of_device_id st_rng_match[] __maybe_unused = {
 	{ .compatible = "st,rng" },
 	{},
@@ -134,7 +116,6 @@ static struct platform_driver st_rng_driver = {
 		.of_match_table = of_match_ptr(st_rng_match),
 	},
 	.probe = st_rng_probe,
-	.remove = st_rng_remove
 };
 
 module_platform_driver(st_rng_driver);
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a90001e02bf7..3a194eb3ce8a 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2007, 2008 Rusty Russell IBM Corporation
  */
 
+#include <asm/barrier.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
@@ -18,71 +19,111 @@ static DEFINE_IDA(rng_index_ida);
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
-	struct completion have_data;
 	char name[25];
-	unsigned int data_avail;
 	int index;
-	bool busy;
 	bool hwrng_register_done;
 	bool hwrng_removed;
+	/* data transfer */
+	struct completion have_data;
+	unsigned int data_avail;
+	unsigned int data_idx;
+	/* minimal size returned by rng_buffer_size() */
+#if SMP_CACHE_BYTES < 32
+	u8 data[32];
+#else
+	u8 data[SMP_CACHE_BYTES];
+#endif
 };
 
 static void random_recv_done(struct virtqueue *vq)
 {
 	struct virtrng_info *vi = vq->vdev->priv;
+	unsigned int len;
 
 	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
-	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
+	if (!virtqueue_get_buf(vi->vq, &len))
 		return;
 
+	smp_store_release(&vi->data_avail, len);
 	complete(&vi->have_data);
 }
 
-/* The host will fill any buffer we give it with sweet, sweet randomness. */
-static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
+static void request_entropy(struct virtrng_info *vi)
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, buf, size);
+	reinit_completion(&vi->have_data);
+	vi->data_idx = 0;
+
+	sg_init_one(&sg, vi->data, sizeof(vi->data));
 
 	/* There should always be room for one buffer. */
-	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
+	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
 
 	virtqueue_kick(vi->vq);
 }
 
+static unsigned int copy_data(struct virtrng_info *vi, void *buf,
+			      unsigned int size)
+{
+	size = min_t(unsigned int, size, vi->data_avail);
+	memcpy(buf, vi->data + vi->data_idx, size);
+	vi->data_idx += size;
+	vi->data_avail -= size;
+	if (vi->data_avail == 0)
+		request_entropy(vi);
+	return size;
+}
+
 static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 {
 	int ret;
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
+	unsigned int chunk;
+	size_t read;
 
 	if (vi->hwrng_removed)
 		return -ENODEV;
 
-	if (!vi->busy) {
-		vi->busy = true;
-		reinit_completion(&vi->have_data);
-		register_buffer(vi, buf, size);
+	read = 0;
+
+	/* copy available data */
+	if (smp_load_acquire(&vi->data_avail)) {
+		chunk = copy_data(vi, buf, size);
+		size -= chunk;
+		read += chunk;
 	}
 
 	if (!wait)
-		return 0;
-
-	ret = wait_for_completion_killable(&vi->have_data);
-	if (ret < 0)
-		return ret;
+		return read;
+
+	/* We have already copied available entropy,
+	 * so either size is 0 or data_avail is 0
+	 */
+	while (size != 0) {
+		/* data_avail is 0 but a request is pending */
+		ret = wait_for_completion_killable(&vi->have_data);
+		if (ret < 0)
+			return ret;
+		/* if vi->data_avail is 0, we have been interrupted
+		 * by a cleanup, but buffer stays in the queue
+		 */
+		if (vi->data_avail == 0)
+			return read;
 
-	vi->busy = false;
+		chunk = copy_data(vi, buf + read, size);
+		size -= chunk;
+		read += chunk;
+	}
 
-	return vi->data_avail;
+	return read;
 }
 
 static void virtio_cleanup(struct hwrng *rng)
 {
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
-	if (vi->busy)
-		wait_for_completion(&vi->have_data);
+	complete(&vi->have_data);
 }
 
 static int probe_common(struct virtio_device *vdev)
@@ -118,6 +159,9 @@ static int probe_common(struct virtio_device *vdev)
 		goto err_find;
 	}
 
+	/* we always have a pending entropy request */
+	request_entropy(vi);
+
 	return 0;
 
 err_find:
@@ -133,9 +177,9 @@ static void remove_common(struct virtio_device *vdev)
 
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
+	vi->data_idx = 0;
 	complete(&vi->have_data);
 	vdev->config->reset(vdev);
-	vi->busy = false;
 	if (vi->hwrng_register_done)
 		hwrng_unregister(&vi->hwrng);
 	vdev->config->del_vqs(vdev);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 512c867495ea..365761055df3 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -731,7 +731,9 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 		wake_up_interruptible(&priv->int_queue);
 
 	/* Clear interrupts handled with TPM_EOI */
+	tpm_tis_request_locality(chip, 0);
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
+	tpm_tis_relinquish_locality(chip, 0);
 	if (rc < 0)
 		return IRQ_NONE;
 
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 91c772e38bb5..ff2ec71d592e 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -683,37 +683,21 @@ static struct miscdevice vtpmx_miscdev = {
 	.fops = &vtpmx_fops,
 };
 
-static int vtpmx_init(void)
-{
-	return misc_register(&vtpmx_miscdev);
-}
-
-static void vtpmx_cleanup(void)
-{
-	misc_deregister(&vtpmx_miscdev);
-}
-
 static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
-		return rc;
-	}
-
 	workqueue = create_workqueue("tpm-vtpm");
 	if (!workqueue) {
 		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+		return -ENOMEM;
 	}
 
-	return 0;
-
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
+	rc = misc_register(&vtpmx_miscdev);
+	if (rc) {
+		pr_err("couldn't create vtpmx device\n");
+		destroy_workqueue(workqueue);
+	}
 
 	return rc;
 }
@@ -721,7 +705,7 @@ static int __init vtpm_module_init(void)
 static void __exit vtpm_module_exit(void)
 {
 	destroy_workqueue(workqueue);
-	vtpmx_cleanup();
+	misc_deregister(&vtpmx_miscdev);
 }
 
 module_init(vtpm_module_init);
diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 308b353815e1..470d91d7314d 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -705,6 +705,10 @@ static int cdce925_probe(struct i2c_client *client,
 	for (i = 0; i < data->chip_info->num_plls; ++i) {
 		pll_clk_name[i] = kasprintf(GFP_KERNEL, "%pOFn.pll%d",
 			client->dev.of_node, i);
+		if (!pll_clk_name[i]) {
+			err = -ENOMEM;
+			goto error;
+		}
 		init.name = pll_clk_name[i];
 		data->pll[i].chip = data;
 		data->pll[i].hw.init = &init;
@@ -746,6 +750,10 @@ static int cdce925_probe(struct i2c_client *client,
 	init.num_parents = 1;
 	init.parent_names = &parent_name; /* Mux Y1 to input */
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.Y1", client->dev.of_node);
+	if (!init.name) {
+		err = -ENOMEM;
+		goto error;
+	}
 	data->clk[0].chip = data;
 	data->clk[0].hw.init = &init;
 	data->clk[0].index = 0;
@@ -764,6 +772,10 @@ static int cdce925_probe(struct i2c_client *client,
 	for (i = 1; i < data->chip_info->num_outputs; ++i) {
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.Y%d",
 			client->dev.of_node, i+1);
+		if (!init.name) {
+			err = -ENOMEM;
+			goto error;
+		}
 		data->clk[i].chip = data;
 		data->clk[i].hw.init = &init;
 		data->clk[i].index = i;
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 382a0619a048..4dea29fa901d 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
@@ -59,6 +60,7 @@ struct clk_si5341_synth {
 struct clk_si5341_output {
 	struct clk_hw hw;
 	struct clk_si5341 *data;
+	struct regulator *vddo_reg;
 	u8 index;
 };
 #define to_clk_si5341_output(_hw) \
@@ -84,6 +86,7 @@ struct clk_si5341 {
 struct clk_si5341_output_config {
 	u8 out_format_drv_bits;
 	u8 out_cm_ampl_bits;
+	u8 vdd_sel_bits;
 	bool synth_master;
 	bool always_on;
 };
@@ -136,6 +139,8 @@ struct clk_si5341_output_config {
 #define SI5341_OUT_R_REG(output)	\
 			((output)->data->reg_rdiv_offset[(output)->index])
 
+#define SI5341_OUT_MUX_VDD_SEL_MASK 0x38
+
 /* Synthesize N divider */
 #define SI5341_SYNTH_N_NUM(x)	(0x0302 + ((x) * 11))
 #define SI5341_SYNTH_N_DEN(x)	(0x0308 + ((x) * 11))
@@ -1250,11 +1255,11 @@ static const struct regmap_config si5341_regmap_config = {
 	.volatile_table = &si5341_regmap_volatile,
 };
 
-static int si5341_dt_parse_dt(struct i2c_client *client,
-	struct clk_si5341_output_config *config)
+static int si5341_dt_parse_dt(struct clk_si5341 *data,
+			      struct clk_si5341_output_config *config)
 {
 	struct device_node *child;
-	struct device_node *np = client->dev.of_node;
+	struct device_node *np = data->i2c_client->dev.of_node;
 	u32 num;
 	u32 val;
 
@@ -1263,13 +1268,13 @@ static int si5341_dt_parse_dt(struct i2c_client *client,
 
 	for_each_child_of_node(np, child) {
 		if (of_property_read_u32(child, "reg", &num)) {
-			dev_err(&client->dev, "missing reg property of %s\n",
+			dev_err(&data->i2c_client->dev, "missing reg property of %s\n",
 				child->name);
 			goto put_child;
 		}
 
 		if (num >= SI5341_MAX_NUM_OUTPUTS) {
-			dev_err(&client->dev, "invalid clkout %d\n", num);
+			dev_err(&data->i2c_client->dev, "invalid clkout %d\n", num);
 			goto put_child;
 		}
 
@@ -1288,7 +1293,7 @@ static int si5341_dt_parse_dt(struct i2c_client *client,
 				config[num].out_format_drv_bits |= 0xc0;
 				break;
 			default:
-				dev_err(&client->dev,
+				dev_err(&data->i2c_client->dev,
 					"invalid silabs,format %u for %u\n",
 					val, num);
 				goto put_child;
@@ -1301,7 +1306,7 @@ static int si5341_dt_parse_dt(struct i2c_client *client,
 
 		if (!of_property_read_u32(child, "silabs,common-mode", &val)) {
 			if (val > 0xf) {
-				dev_err(&client->dev,
+				dev_err(&data->i2c_client->dev,
 					"invalid silabs,common-mode %u\n",
 					val);
 				goto put_child;
@@ -1312,7 +1317,7 @@ static int si5341_dt_parse_dt(struct i2c_client *client,
 
 		if (!of_property_read_u32(child, "silabs,amplitude", &val)) {
 			if (val > 0xf) {
-				dev_err(&client->dev,
+				dev_err(&data->i2c_client->dev,
 					"invalid silabs,amplitude %u\n",
 					val);
 				goto put_child;
@@ -1329,6 +1334,34 @@ static int si5341_dt_parse_dt(struct i2c_client *client,
 
 		config[num].always_on =
 			of_property_read_bool(child, "always-on");
+
+		config[num].vdd_sel_bits = 0x08;
+		if (data->clk[num].vddo_reg) {
+			int vdd = regulator_get_voltage(data->clk[num].vddo_reg);
+
+			switch (vdd) {
+			case 3300000:
+				config[num].vdd_sel_bits |= 0 << 4;
+				break;
+			case 1800000:
+				config[num].vdd_sel_bits |= 1 << 4;
+				break;
+			case 2500000:
+				config[num].vdd_sel_bits |= 2 << 4;
+				break;
+			default:
+				dev_err(&data->i2c_client->dev,
+					"unsupported vddo voltage %d for %s\n",
+					vdd, child->name);
+				goto put_child;
+			}
+		} else {
+			/* chip seems to default to 2.5V when not set */
+			dev_warn(&data->i2c_client->dev,
+				"no regulator set, defaulting vdd_sel to 2.5V for %s\n",
+				child->name);
+			config[num].vdd_sel_bits |= 2 << 4;
+		}
 	}
 
 	return 0;
@@ -1417,6 +1450,94 @@ static int si5341_clk_select_active_input(struct clk_si5341 *data)
 	return res;
 }
 
+static ssize_t input_present_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOSREF);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(input_present);
+
+static ssize_t input_present_sticky_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS_STICKY, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOSREF);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(input_present_sticky);
+
+static ssize_t pll_locked_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOL);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(pll_locked);
+
+static ssize_t pll_locked_sticky_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS_STICKY, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOL);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(pll_locked_sticky);
+
+static ssize_t clear_sticky_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	long val;
+
+	if (kstrtol(buf, 10, &val))
+		return -EINVAL;
+	if (val) {
+		int res = regmap_write(data->regmap, SI5341_STATUS_STICKY, 0);
+
+		if (res < 0)
+			return res;
+	}
+	return count;
+}
+static DEVICE_ATTR_WO(clear_sticky);
+
+static const struct attribute *si5341_attributes[] = {
+	&dev_attr_input_present.attr,
+	&dev_attr_input_present_sticky.attr,
+	&dev_attr_pll_locked.attr,
+	&dev_attr_pll_locked_sticky.attr,
+	&dev_attr_clear_sticky.attr,
+	NULL
+};
+
 static int si5341_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -1424,7 +1545,7 @@ static int si5341_probe(struct i2c_client *client,
 	struct clk_init_data init;
 	struct clk *input;
 	const char *root_clock_name;
-	const char *synth_clock_names[SI5341_NUM_SYNTH];
+	const char *synth_clock_names[SI5341_NUM_SYNTH] = { NULL };
 	int err;
 	unsigned int i;
 	struct clk_si5341_output_config config[SI5341_MAX_NUM_OUTPUTS];
@@ -1454,9 +1575,33 @@ static int si5341_probe(struct i2c_client *client,
 		}
 	}
 
-	err = si5341_dt_parse_dt(client, config);
+	for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
+		char reg_name[10];
+
+		snprintf(reg_name, sizeof(reg_name), "vddo%d", i);
+		data->clk[i].vddo_reg = devm_regulator_get_optional(
+			&client->dev, reg_name);
+		if (IS_ERR(data->clk[i].vddo_reg)) {
+			err = PTR_ERR(data->clk[i].vddo_reg);
+			data->clk[i].vddo_reg = NULL;
+			if (err == -ENODEV)
+				continue;
+			goto cleanup;
+		} else {
+			err = regulator_enable(data->clk[i].vddo_reg);
+			if (err) {
+				dev_err(&client->dev,
+					"failed to enable %s regulator: %d\n",
+					reg_name, err);
+				data->clk[i].vddo_reg = NULL;
+				goto cleanup;
+			}
+		}
+	}
+
+	err = si5341_dt_parse_dt(data, config);
 	if (err)
-		return err;
+		goto cleanup;
 
 	if (of_property_read_string(client->dev.of_node, "clock-output-names",
 			&init.name))
@@ -1464,21 +1609,23 @@ static int si5341_probe(struct i2c_client *client,
 	root_clock_name = init.name;
 
 	data->regmap = devm_regmap_init_i2c(client, &si5341_regmap_config);
-	if (IS_ERR(data->regmap))
-		return PTR_ERR(data->regmap);
+	if (IS_ERR(data->regmap)) {
+		err = PTR_ERR(data->regmap);
+		goto cleanup;
+	}
 
 	i2c_set_clientdata(client, data);
 
 	err = si5341_probe_chip_id(data);
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	if (of_property_read_bool(client->dev.of_node, "silabs,reprogram")) {
 		initialization_required = true;
 	} else {
 		err = si5341_is_programmed_already(data);
 		if (err < 0)
-			return err;
+			goto cleanup;
 
 		initialization_required = !err;
 	}
@@ -1487,11 +1634,11 @@ static int si5341_probe(struct i2c_client *client,
 		/* Populate the regmap cache in preparation for "cache only" */
 		err = si5341_read_settings(data);
 		if (err < 0)
-			return err;
+			goto cleanup;
 
 		err = si5341_send_preamble(data);
 		if (err < 0)
-			return err;
+			goto cleanup;
 
 		/*
 		 * We intend to send all 'final' register values in a single
@@ -1504,19 +1651,19 @@ static int si5341_probe(struct i2c_client *client,
 		err = si5341_write_multiple(data, si5341_reg_defaults,
 					ARRAY_SIZE(si5341_reg_defaults));
 		if (err < 0)
-			return err;
+			goto cleanup;
 	}
 
 	/* Input must be up and running at this point */
 	err = si5341_clk_select_active_input(data);
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	if (initialization_required) {
 		/* PLL configuration is required */
 		err = si5341_initialize_pll(data);
 		if (err < 0)
-			return err;
+			goto cleanup;
 	}
 
 	/* Register the PLL */
@@ -1529,7 +1676,7 @@ static int si5341_probe(struct i2c_client *client,
 	err = devm_clk_hw_register(&client->dev, &data->hw);
 	if (err) {
 		dev_err(&client->dev, "clock registration failed\n");
-		return err;
+		goto cleanup;
 	}
 
 	init.num_parents = 1;
@@ -1538,6 +1685,10 @@ static int si5341_probe(struct i2c_client *client,
 	for (i = 0; i < data->num_synth; ++i) {
 		synth_clock_names[i] = devm_kasprintf(&client->dev, GFP_KERNEL,
 				"%s.N%u", client->dev.of_node->name, i);
+		if (!synth_clock_names[i]) {
+			err = -ENOMEM;
+			goto free_clk_names;
+		}
 		init.name = synth_clock_names[i];
 		data->synth[i].index = i;
 		data->synth[i].data = data;
@@ -1546,6 +1697,7 @@ static int si5341_probe(struct i2c_client *client,
 		if (err) {
 			dev_err(&client->dev,
 				"synth N%u registration failed\n", i);
+			goto free_clk_names;
 		}
 	}
 
@@ -1555,6 +1707,10 @@ static int si5341_probe(struct i2c_client *client,
 	for (i = 0; i < data->num_outputs; ++i) {
 		init.name = kasprintf(GFP_KERNEL, "%s.%d",
 			client->dev.of_node->name, i);
+		if (!init.name) {
+			err = -ENOMEM;
+			goto free_clk_names;
+		}
 		init.flags = config[i].synth_master ? CLK_SET_RATE_PARENT : 0;
 		data->clk[i].index = i;
 		data->clk[i].data = data;
@@ -1566,13 +1722,17 @@ static int si5341_probe(struct i2c_client *client,
 			regmap_write(data->regmap,
 				SI5341_OUT_CM(&data->clk[i]),
 				config[i].out_cm_ampl_bits);
+			regmap_update_bits(data->regmap,
+				SI5341_OUT_MUX_SEL(&data->clk[i]),
+				SI5341_OUT_MUX_VDD_SEL_MASK,
+				config[i].vdd_sel_bits);
 		}
 		err = devm_clk_hw_register(&client->dev, &data->clk[i].hw);
 		kfree(init.name); /* clock framework made a copy of the name */
 		if (err) {
 			dev_err(&client->dev,
 				"output %u registration failed\n", i);
-			return err;
+			goto free_clk_names;
 		}
 		if (config[i].always_on)
 			clk_prepare(data->clk[i].hw.clk);
@@ -1582,7 +1742,7 @@ static int si5341_probe(struct i2c_client *client,
 			data);
 	if (err) {
 		dev_err(&client->dev, "unable to add clk provider\n");
-		return err;
+		goto free_clk_names;
 	}
 
 	if (initialization_required) {
@@ -1590,11 +1750,11 @@ static int si5341_probe(struct i2c_client *client,
 		regcache_cache_only(data->regmap, false);
 		err = regcache_sync(data->regmap);
 		if (err < 0)
-			return err;
+			goto free_clk_names;
 
 		err = si5341_finalize_defaults(data);
 		if (err < 0)
-			return err;
+			goto free_clk_names;
 	}
 
 	/* wait for device to report input clock present and PLL lock */
@@ -1603,20 +1763,47 @@ static int si5341_probe(struct i2c_client *client,
 	       10000, 250000);
 	if (err) {
 		dev_err(&client->dev, "Error waiting for input clock or PLL lock\n");
-		return err;
+		goto free_clk_names;
 	}
 
 	/* clear sticky alarm bits from initialization */
 	err = regmap_write(data->regmap, SI5341_STATUS_STICKY, 0);
 	if (err) {
 		dev_err(&client->dev, "unable to clear sticky status\n");
-		return err;
+		goto free_clk_names;
 	}
 
+	err = sysfs_create_files(&client->dev.kobj, si5341_attributes);
+	if (err)
+		dev_err(&client->dev, "unable to create sysfs files\n");
+
+free_clk_names:
 	/* Free the names, clk framework makes copies */
 	for (i = 0; i < data->num_synth; ++i)
 		 devm_kfree(&client->dev, (void *)synth_clock_names[i]);
 
+cleanup:
+	if (err) {
+		for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
+			if (data->clk[i].vddo_reg)
+				regulator_disable(data->clk[i].vddo_reg);
+		}
+	}
+	return err;
+}
+
+static int si5341_remove(struct i2c_client *client)
+{
+	struct clk_si5341 *data = i2c_get_clientdata(client);
+	int i;
+
+	sysfs_remove_files(&client->dev.kobj, si5341_attributes);
+
+	for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
+		if (data->clk[i].vddo_reg)
+			regulator_disable(data->clk[i].vddo_reg);
+	}
+
 	return 0;
 }
 
@@ -1646,6 +1833,7 @@ static struct i2c_driver si5341_driver = {
 		.of_match_table = clk_si5341_of_match,
 	},
 	.probe		= si5341_probe,
+	.remove		= si5341_remove,
 	.id_table	= si5341_id,
 };
 module_i2c_driver(si5341_driver);
diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index eb597ea7bb87..3ddb974da039 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -906,6 +906,11 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
+
 	init.ops = &vc5_mux_ops;
 	init.flags = 0;
 	init.parent_names = parent_names;
@@ -920,6 +925,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		memset(&init, 0, sizeof(init));
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.dbl",
 				      client->dev.of_node);
+		if (!init.name) {
+			ret = -ENOMEM;
+			goto err_clk;
+		}
 		init.ops = &vc5_dbl_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
@@ -935,6 +944,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Register PFD */
 	memset(&init, 0, sizeof(init));
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.pfd", client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
 	init.ops = &vc5_pfd_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_names;
@@ -952,6 +965,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Register PLL */
 	memset(&init, 0, sizeof(init));
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.pll", client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
 	init.ops = &vc5_pll_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_names;
@@ -971,6 +988,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		memset(&init, 0, sizeof(init));
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.fod%d",
 				      client->dev.of_node, idx);
+		if (!init.name) {
+			ret = -ENOMEM;
+			goto err_clk;
+		}
 		init.ops = &vc5_fod_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
@@ -989,6 +1010,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	memset(&init, 0, sizeof(init));
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.out0_sel_i2cb",
 			      client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
 	init.ops = &vc5_clk_out_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_names;
@@ -1015,6 +1040,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		memset(&init, 0, sizeof(init));
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.out%d",
 				      client->dev.of_node, idx + 1);
+		if (!init.name) {
+			ret = -ENOMEM;
+			goto err_clk;
+		}
 		init.ops = &vc5_clk_out_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 8a49e072d6e8..23f37a2cdf3a 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -291,7 +291,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX8MN_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
@@ -308,10 +308,10 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_EXT4] = imx_obtain_fixed_clk_hw(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
-	base = of_iomap(np, 0);
+	base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!base)) {
-		ret = -ENOMEM;
+	if (WARN_ON(IS_ERR(base))) {
+		ret = PTR_ERR(base);
 		goto unregister_hws;
 	}
 
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 72592e35836b..98a4711ef38d 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -425,25 +425,22 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *anatop_base, *ccm_base;
+	int err;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
-	anatop_base = of_iomap(np, 0);
+	anatop_base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!anatop_base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(anatop_base)))
+		return PTR_ERR(anatop_base);
 
 	np = dev->of_node;
 	ccm_base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(ccm_base))) {
-		iounmap(anatop_base);
+	if (WARN_ON(IS_ERR(ccm_base)))
 		return PTR_ERR(ccm_base);
-	}
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
-	if (WARN_ON(!clk_hw_data)) {
-		iounmap(anatop_base);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
-	}
 
 	clk_hw_data->num = IMX8MP_CLK_END;
 	hws = clk_hw_data->hws;
@@ -743,7 +740,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (err < 0) {
+		dev_err(dev, "failed to register hws for i.MX8MP\n");
+		imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
+		return err;
+	}
 
 	imx_register_uart_clocks(4);
 
diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 7e1b136e71ae..8af2a9faa805 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -302,6 +302,8 @@ static int _sci_clk_build(struct sci_clk_provider *provider,
 
 	name = kasprintf(GFP_KERNEL, "clk:%d:%d", sci_clk->dev_id,
 			 sci_clk->clk_id);
+	if (!name)
+		return -ENOMEM;
 
 	init.name = name;
 
diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 3f9c2f61a5d9..cde62a11f573 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -1654,7 +1654,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -4517,24 +4517,24 @@ static const struct qcom_reset_map gcc_ipq6018_resets[] = {
 	[GCC_PCIE0_AHB_ARES] = { 0x75040, 5 },
 	[GCC_PCIE0_AXI_MASTER_STICKY_ARES] = { 0x75040, 6 },
 	[GCC_PCIE0_AXI_SLAVE_STICKY_ARES] = { 0x75040, 7 },
-	[GCC_PPE_FULL_RESET] = { 0x68014, 0 },
-	[GCC_UNIPHY0_SOFT_RESET] = { 0x56004, 0 },
+	[GCC_PPE_FULL_RESET] = { .reg = 0x68014, .bitmask = 0xf0000 },
+	[GCC_UNIPHY0_SOFT_RESET] = { .reg = 0x56004, .bitmask = 0x3ff2 },
 	[GCC_UNIPHY0_XPCS_RESET] = { 0x56004, 2 },
-	[GCC_UNIPHY1_SOFT_RESET] = { 0x56104, 0 },
+	[GCC_UNIPHY1_SOFT_RESET] = { .reg = 0x56104, .bitmask = 0x32 },
 	[GCC_UNIPHY1_XPCS_RESET] = { 0x56104, 2 },
-	[GCC_EDMA_HW_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT1_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT2_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT3_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT4_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT5_RESET] = { 0x68014, 0 },
-	[GCC_UNIPHY0_PORT1_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT2_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT3_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT4_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT5_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT_4_5_RESET] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT_4_RESET] = { 0x56004, 0 },
+	[GCC_EDMA_HW_RESET] = { .reg = 0x68014, .bitmask = 0x300000 },
+	[GCC_NSSPORT1_RESET] = { .reg = 0x68014, .bitmask = 0x1000003 },
+	[GCC_NSSPORT2_RESET] = { .reg = 0x68014, .bitmask = 0x200000c },
+	[GCC_NSSPORT3_RESET] = { .reg = 0x68014, .bitmask = 0x4000030 },
+	[GCC_NSSPORT4_RESET] = { .reg = 0x68014, .bitmask = 0x8000300 },
+	[GCC_NSSPORT5_RESET] = { .reg = 0x68014, .bitmask = 0x10000c00 },
+	[GCC_UNIPHY0_PORT1_ARES] = { .reg = 0x56004, .bitmask = 0x30 },
+	[GCC_UNIPHY0_PORT2_ARES] = { .reg = 0x56004, .bitmask = 0xc0 },
+	[GCC_UNIPHY0_PORT3_ARES] = { .reg = 0x56004, .bitmask = 0x300 },
+	[GCC_UNIPHY0_PORT4_ARES] = { .reg = 0x56004, .bitmask = 0xc00 },
+	[GCC_UNIPHY0_PORT5_ARES] = { .reg = 0x56004, .bitmask = 0x3000 },
+	[GCC_UNIPHY0_PORT_4_5_RESET] = { .reg = 0x56004, .bitmask = 0x3c02 },
+	[GCC_UNIPHY0_PORT_4_RESET] = { .reg = 0x56004, .bitmask = 0xc02 },
 	[GCC_LPASS_BCR] = {0x1F000, 0},
 	[GCC_UBI32_TBU_BCR] = {0x65000, 0},
 	[GCC_LPASS_TBU_BCR] = {0x6C000, 0},
diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 819d194be8f7..0e914ec7aeae 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -13,8 +13,10 @@
 
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+
 	rcdev->ops->assert(rcdev, id);
-	udelay(1);
+	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }
@@ -28,7 +30,7 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
 }
@@ -42,7 +44,7 @@ qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index 2a08b5e282c7..9a47c838d9b1 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -11,6 +11,8 @@
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
+	u8 udelay;
+	u32 bitmask;
 };
 
 struct regmap;
diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 733a962ff521..15f728edc54b 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -455,6 +455,7 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 		err = load_one_timing_from_dt(tegra, timing, child);
 		if (err) {
 			of_node_put(child);
+			kfree(tegra->timings);
 			return err;
 		}
 
@@ -506,6 +507,7 @@ struct clk *tegra_clk_register_emc(void __iomem *base, struct device_node *np,
 		err = load_timings_from_dt(tegra, node, node_ram_code);
 		if (err) {
 			of_node_put(node);
+			kfree(tegra);
 			return ERR_PTR(err);
 		}
 	}
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 864c484bde1b..157abc46dcf4 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -267,6 +267,9 @@ static const char * __init clkctrl_get_clock_name(struct device_node *np,
 	if (clkctrl_name && !legacy_naming) {
 		clock_name = kasprintf(GFP_KERNEL, "%s-clkctrl:%04x:%d",
 				       clkctrl_name, offset, index);
+		if (!clock_name)
+			return NULL;
+
 		strreplace(clock_name, '_', '-');
 
 		return clock_name;
@@ -598,6 +601,10 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	if (clkctrl_name) {
 		provider->clkdm_name = kasprintf(GFP_KERNEL,
 						 "%s_clkdm", clkctrl_name);
+		if (!provider->clkdm_name) {
+			kfree(provider);
+			return;
+		}
 		goto clkdm_found;
 	}
 
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 4efd0cf3b602..0d52e28fea4d 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -486,10 +486,10 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	 * and use it. Note that the event timer uses the interrupt and it's the
 	 * 2nd TTC hence the irq_of_parse_and_map(,1)
 	 */
-	timer_baseaddr = of_iomap(timer, 0);
-	if (!timer_baseaddr) {
+	timer_baseaddr = devm_of_iomap(&pdev->dev, timer, 0, NULL);
+	if (IS_ERR(timer_baseaddr)) {
 		pr_err("ERROR: invalid timer base address\n");
-		return -ENXIO;
+		return PTR_ERR(timer_baseaddr);
 	}
 
 	irq = irq_of_parse_and_map(timer, 1);
@@ -513,20 +513,27 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	clk_ce = of_clk_get(timer, clksel);
 	if (IS_ERR(clk_ce)) {
 		pr_err("ERROR: timer input clock not found\n");
-		return PTR_ERR(clk_ce);
+		ret = PTR_ERR(clk_ce);
+		goto put_clk_cs;
 	}
 
 	ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
 	if (ret)
-		return ret;
+		goto put_clk_ce;
 
 	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
 	if (ret)
-		return ret;
+		goto put_clk_ce;
 
 	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
 
 	return 0;
+
+put_clk_ce:
+	clk_put(clk_ce);
+put_clk_cs:
+	clk_put(clk_cs);
+	return ret;
 }
 
 static const struct of_device_id ttc_timer_of_match[] = {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1686705bee7b..4b06b81d8bb0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -777,6 +777,8 @@ static ssize_t store_energy_performance_preference(
 			err = cpufreq_start_governor(policy);
 			if (!ret)
 				ret = err;
+		} else {
+			ret = 0;
 		}
 	}
 
diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index 596a8c74e40a..8dc10f998894 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -287,7 +287,7 @@ static int mv_cesa_des_setkey(struct crypto_skcipher *cipher, const u8 *key,
 static int mv_cesa_des3_ede_setkey(struct crypto_skcipher *cipher,
 				   const u8 *key, unsigned int len)
 {
-	struct mv_cesa_des_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct mv_cesa_des3_ctx *ctx = crypto_skcipher_ctx(cipher);
 	int err;
 
 	err = verify_skcipher_des3_key(cipher, key);
diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
index bc89a20e5d9d..351822a598f9 100644
--- a/drivers/crypto/nx/Makefile
+++ b/drivers/crypto/nx/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_NX_ENCRYPT) += nx-crypto.o
 nx-crypto-objs := nx.o \
-		  nx_debugfs.o \
 		  nx-aes-cbc.o \
 		  nx-aes-ecb.o \
 		  nx-aes-gcm.o \
@@ -11,6 +10,7 @@ nx-crypto-objs := nx.o \
 		  nx-sha256.o \
 		  nx-sha512.o
 
+nx-crypto-$(CONFIG_DEBUG_FS) += nx_debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES) += nx-compress-pseries.o nx-compress.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV) += nx-compress-powernv.o nx-compress.o
 nx-compress-objs := nx-842.o
diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
index c6233173c612..2697baebb6a3 100644
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -170,8 +170,8 @@ struct nx_sg *nx_walk_and_build(struct nx_sg *, unsigned int,
 void nx_debugfs_init(struct nx_crypto_driver *);
 void nx_debugfs_fini(struct nx_crypto_driver *);
 #else
-#define NX_DEBUGFS_INIT(drv)	(0)
-#define NX_DEBUGFS_FINI(drv)	(0)
+#define NX_DEBUGFS_INIT(drv)	do {} while (0)
+#define NX_DEBUGFS_FINI(drv)	do {} while (0)
 #endif
 
 #define NX_PAGE_NUM(x)		((u64)(x) & 0xfffffffffffff000ULL)
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index a02777c93c07..0541b7e4d5c6 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -403,18 +403,34 @@ static void unregister_dev_dax(void *dev)
 	put_device(dev);
 }
 
+static void dax_region_free(struct kref *kref)
+{
+	struct dax_region *dax_region;
+
+	dax_region = container_of(kref, struct dax_region, kref);
+	kfree(dax_region);
+}
+
+void dax_region_put(struct dax_region *dax_region)
+{
+	kref_put(&dax_region->kref, dax_region_free);
+}
+EXPORT_SYMBOL_GPL(dax_region_put);
+
 /* a return value >= 0 indicates this invocation invalidated the id */
 static int __free_dev_dax_id(struct dev_dax *dev_dax)
 {
-	struct dax_region *dax_region = dev_dax->region;
 	struct device *dev = &dev_dax->dev;
+	struct dax_region *dax_region;
 	int rc = dev_dax->id;
 
 	device_lock_assert(dev);
 
-	if (is_static(dax_region) || dev_dax->id < 0)
+	if (!dev_dax->dyn_id || dev_dax->id < 0)
 		return -1;
+	dax_region = dev_dax->region;
 	ida_free(&dax_region->ida, dev_dax->id);
+	dax_region_put(dax_region);
 	dev_dax->id = -1;
 	return rc;
 }
@@ -430,6 +446,20 @@ static int free_dev_dax_id(struct dev_dax *dev_dax)
 	return rc;
 }
 
+static int alloc_dev_dax_id(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	int id;
+
+	id = ida_alloc(&dax_region->ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	kref_get(&dax_region->kref);
+	dev_dax->dyn_id = true;
+	dev_dax->id = id;
+	return id;
+}
+
 static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t len)
 {
@@ -517,20 +547,6 @@ static const struct attribute_group *dax_region_attribute_groups[] = {
 	NULL,
 };
 
-static void dax_region_free(struct kref *kref)
-{
-	struct dax_region *dax_region;
-
-	dax_region = container_of(kref, struct dax_region, kref);
-	kfree(dax_region);
-}
-
-void dax_region_put(struct dax_region *dax_region)
-{
-	kref_put(&dax_region->kref, dax_region_free);
-}
-EXPORT_SYMBOL_GPL(dax_region_put);
-
 static void dax_region_unregister(void *region)
 {
 	struct dax_region *dax_region = region;
@@ -592,10 +608,12 @@ EXPORT_SYMBOL_GPL(alloc_dax_region);
 static void dax_mapping_release(struct device *dev)
 {
 	struct dax_mapping *mapping = to_dax_mapping(dev);
-	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+	struct device *parent = dev->parent;
+	struct dev_dax *dev_dax = to_dev_dax(parent);
 
 	ida_free(&dev_dax->ida, mapping->id);
 	kfree(mapping);
+	put_device(parent);
 }
 
 static void unregister_dax_mapping(void *data)
@@ -735,6 +753,7 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	dev = &mapping->dev;
 	device_initialize(dev);
 	dev->parent = &dev_dax->dev;
+	get_device(dev->parent);
 	dev->type = &dax_mapping_type;
 	dev_set_name(dev, "mapping%d", mapping->id);
 	rc = device_add(dev);
@@ -1267,12 +1286,10 @@ static const struct attribute_group *dax_attribute_groups[] = {
 static void dev_dax_release(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct dax_region *dax_region = dev_dax->region;
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 
 	put_dax(dax_dev);
 	free_dev_dax_id(dev_dax);
-	dax_region_put(dax_region);
 	kfree(dev_dax->pgmap);
 	kfree(dev_dax);
 }
@@ -1296,6 +1313,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
+	dev_dax->region = dax_region;
 	if (is_static(dax_region)) {
 		if (dev_WARN_ONCE(parent, data->id < 0,
 				"dynamic id specified to static region\n")) {
@@ -1311,13 +1329,11 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 			goto err_id;
 		}
 
-		rc = ida_alloc(&dax_region->ida, GFP_KERNEL);
+		rc = alloc_dev_dax_id(dev_dax);
 		if (rc < 0)
 			goto err_id;
-		dev_dax->id = rc;
 	}
 
-	dev_dax->region = dax_region;
 	dev = &dev_dax->dev;
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
@@ -1355,7 +1371,6 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	dev_dax->target_node = dax_region->target_node;
 	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
-	kref_get(&dax_region->kref);
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 1c974b7caae6..afcada6fd2ed 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -52,7 +52,8 @@ struct dax_mapping {
  * @region - parent region
  * @dax_dev - core dax functionality
  * @target_node: effective numa node if dev_dax memory range is onlined
- * @id: ida allocated id
+ * @dyn_id: is this a dynamic or statically created instance
+ * @id: ida allocated id when the dax_region is not static
  * @ida: mapping id allocator
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
@@ -64,6 +65,7 @@ struct dev_dax {
 	struct dax_device *dax_dev;
 	unsigned int align;
 	int target_node;
+	bool dyn_id;
 	int id;
 	struct ida ida;
 	struct device dev;
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 356610404bb4..fa08dec389dc 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -196,6 +196,14 @@ static const struct __extcon_info {
  * @attr_name:		"name" sysfs entry
  * @attr_state:		"state" sysfs entry
  * @attrs:		the array pointing to attr_name and attr_state for attr_g
+ * @usb_propval:	the array of USB connector properties
+ * @chg_propval:	the array of charger connector properties
+ * @jack_propval:	the array of jack connector properties
+ * @disp_propval:	the array of display connector properties
+ * @usb_bits:		the bit array of the USB connector property capabilities
+ * @chg_bits:		the bit array of the charger connector property capabilities
+ * @jack_bits:		the bit array of the jack connector property capabilities
+ * @disp_bits:		the bit array of the display connector property capabilities
  */
 struct extcon_cable {
 	struct extcon_dev *edev;
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 78a446cb4348..f432fe7cb60d 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -622,7 +622,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	end = rounddown(sh_memory->addr + sh_memory->size, PAGE_SIZE);
 	paddr = begin;
 	size = end - begin;
-	va = memremap(paddr, size, MEMREMAP_WC);
+	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
 	if (!va) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 45b1f00c5968..8445bb7ae06a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2229,14 +2229,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 
 	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
+	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
+		return -EINVAL;
+	if (saddr + size <= saddr || offset + size <= offset)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
-	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
+	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
 	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
 		return -EINVAL;
 
@@ -2295,14 +2295,14 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	int r;
 
 	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
+	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
+		return -EINVAL;
+	if (saddr + size <= saddr || offset + size <= offset)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
-	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
+	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
 	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
 		return -EINVAL;
 
@@ -3252,6 +3252,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	long timeout = msecs_to_jiffies(2000);
 	int r;
 
+	/* No valid flags defined yet */
+	if (args->in.flags)
+		return -EINVAL;
+
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 3b6f5963180d..dadeb2013fd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -113,18 +113,19 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
+
+		if (retval) {
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
 	} else {
 		retval = kfd_gtt_sa_allocate(kfd, sizeof(struct v9_mqd),
 				&mqd_mem_obj);
-	}
-
-	if (retval) {
-		kfree(mqd_mem_obj);
-		return NULL;
+		if (retval)
+			return NULL;
 	}
 
 	return mqd_mem_obj;
-
 }
 
 static void init_mqd(struct mqd_manager *mm, void **mqd,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7e0a55aa2b18..099542dd3154 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1855,9 +1855,6 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 
-	if (u->flip_addr)
-		update_flags->bits.addr_update = 1;
-
 	if (!is_surface_in_context(context, u->surface) || u->surface->force_full_update) {
 		update_flags->raw = 0xFFFFFFFF;
 		return UPDATE_TYPE_FULL;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index c6a8d6c54621..882b4e2816b5 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -347,7 +347,7 @@ struct dmub_srv {
  * of a firmware to know if feature or functionality is supported or present.
  */
 #define DMUB_FW_VERSION(major, minor, revision) \
-	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
+	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | (((revision) & 0xFF) << 8))
 
 /**
  * dmub_srv_create() - creates the DMUB service.
diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 8ed8302d6bbb..b4a69b210451 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -9,6 +9,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/media-bus-format.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -147,6 +149,7 @@ struct tc358768_priv {
 
 	u32 pd_lines; /* number of Parallel Port Input Data Lines */
 	u32 dsi_lanes; /* number of DSI Lanes */
+	u32 dsi_bpp; /* number of Bits Per Pixel over DSI */
 
 	/* Parameters for PLL programming */
 	u32 fbd;	/* PLL feedback divider */
@@ -279,12 +282,12 @@ static void tc358768_hw_disable(struct tc358768_priv *priv)
 
 static u32 tc358768_pll_to_pclk(struct tc358768_priv *priv, u32 pll_clk)
 {
-	return (u32)div_u64((u64)pll_clk * priv->dsi_lanes, priv->pd_lines);
+	return (u32)div_u64((u64)pll_clk * priv->dsi_lanes, priv->dsi_bpp);
 }
 
 static u32 tc358768_pclk_to_pll(struct tc358768_priv *priv, u32 pclk)
 {
-	return (u32)div_u64((u64)pclk * priv->pd_lines, priv->dsi_lanes);
+	return (u32)div_u64((u64)pclk * priv->dsi_bpp, priv->dsi_lanes);
 }
 
 static int tc358768_calc_pll(struct tc358768_priv *priv,
@@ -329,13 +332,17 @@ static int tc358768_calc_pll(struct tc358768_priv *priv,
 		u32 fbd;
 
 		for (fbd = 0; fbd < 512; ++fbd) {
-			u32 pll, diff;
+			u32 pll, diff, pll_in;
 
 			pll = (u32)div_u64((u64)refclk * (fbd + 1), divisor);
 
 			if (pll >= max_pll || pll < min_pll)
 				continue;
 
+			pll_in = (u32)div_u64((u64)refclk, prd + 1);
+			if (pll_in < 4000000)
+				continue;
+
 			diff = max(pll, target_pll) - min(pll, target_pll);
 
 			if (diff < best_diff) {
@@ -417,6 +424,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
 	priv->output.panel = panel;
 
 	priv->dsi_lanes = dev->lanes;
+	priv->dsi_bpp = mipi_dsi_pixel_format_to_bpp(dev->format);
 
 	/* get input ep (port0/endpoint0) */
 	ret = -EINVAL;
@@ -428,7 +436,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
 	}
 
 	if (ret)
-		priv->pd_lines = mipi_dsi_pixel_format_to_bpp(dev->format);
+		priv->pd_lines = priv->dsi_bpp;
 
 	drm_bridge_add(&priv->bridge);
 
@@ -626,6 +634,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
 	u32 val, val2, lptxcnt, hact, data_type;
+	s32 raw_val;
 	const struct drm_display_mode *mode;
 	u32 dsibclk_nsk, dsiclk_nsk, ui_nsk, phy_delay_nsk;
 	u32 dsiclk, dsibclk;
@@ -719,25 +728,26 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	/* 38ns < TCLK_PREPARE < 95ns */
 	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
-	/* TCLK_PREPARE > 300ns */
-	val2 = tc358768_ns_to_cnt(300 + tc358768_to_ns(3 * ui_nsk),
-				  dsibclk_nsk);
-	val |= (val2 - tc358768_to_ns(phy_delay_nsk - dsibclk_nsk)) << 8;
+	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
+	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
+				  dsibclk_nsk) - 2;
+	val |= val2 << 8;
 	dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
-	/* TCLK_TRAIL > 60ns + 3*UI */
-	val = 60 + tc358768_to_ns(3 * ui_nsk);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 5;
+	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
+	val = clamp(raw_val, 0, 127);
 	dev_dbg(priv->dev, "TCLK_TRAILCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
-	/* THS_ZERO > 145ns + 10*UI */
-	val2 = tc358768_ns_to_cnt(145 - tc358768_to_ns(ui_nsk), dsibclk_nsk);
-	val |= (val2 - tc358768_to_ns(phy_delay_nsk)) << 8;
+	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
+	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
+	val2 = clamp(raw_val, 0, 127);
+	val |= val2 << 8;
 	dev_dbg(priv->dev, "THS_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
@@ -753,9 +763,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	dev_dbg(priv->dev, "TCLK_POSTCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
-	/* 60ns + 4*UI < THS_PREPARE < 105ns + 12*UI */
-	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(15 * ui_nsk),
-				 dsibclk_nsk) - 5;
+	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
+				     dsibclk_nsk) - 4;
+	val = clamp(raw_val, 0, 15);
 	dev_dbg(priv->dev, "THS_TRAILCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
 
@@ -769,7 +780,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
 	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
 				  dsibclk_nsk) - 2;
 	val |= val2 << 16;
@@ -819,8 +830,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	val = TC358768_DSI_CONFW_MODE_SET | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
 	val |= (dsi_dev->lanes - 1) << 1;
 
-	if (!(dsi_dev->mode_flags & MIPI_DSI_MODE_LPM))
-		val |= TC358768_DSI_CONTROL_TXMD;
+	val |= TC358768_DSI_CONTROL_TXMD;
 
 	if (!(dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
 		val |= TC358768_DSI_CONTROL_HSCKMD;
@@ -866,6 +876,44 @@ static void tc358768_bridge_enable(struct drm_bridge *bridge)
 	}
 }
 
+#define MAX_INPUT_SEL_FORMATS	1
+
+static u32 *
+tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+				   struct drm_bridge_state *bridge_state,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state,
+				   u32 output_fmt,
+				   unsigned int *num_input_fmts)
+{
+	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	switch (priv->pd_lines) {
+	case 16:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
+		break;
+	case 18:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
+		break;
+	default:
+	case 24:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	};
+
+	*num_input_fmts = MAX_INPUT_SEL_FORMATS;
+
+	return input_fmts;
+}
+
 static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.attach = tc358768_bridge_attach,
 	.mode_valid = tc358768_bridge_mode_valid,
@@ -873,6 +921,11 @@ static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.enable = tc358768_bridge_enable,
 	.disable = tc358768_bridge_disable,
 	.post_disable = tc358768_bridge_post_disable,
+
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_get_input_bus_fmts = tc358768_atomic_get_input_bus_fmts,
 };
 
 static const struct drm_bridge_timings default_tc358768_timings = {
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 98b659981f1a..b10ba5057735 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -98,6 +98,12 @@ drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
 	if (!state->planes)
 		goto fail;
 
+	/*
+	 * Because drm_atomic_state can be committed asynchronously we need our
+	 * own reference and cannot rely on the on implied by drm_file in the
+	 * ioctl call.
+	 */
+	drm_dev_get(dev);
 	state->dev = dev;
 
 	DRM_DEBUG_ATOMIC("Allocated atomic state %p\n", state);
@@ -257,7 +263,8 @@ EXPORT_SYMBOL(drm_atomic_state_clear);
 void __drm_atomic_state_free(struct kref *ref)
 {
 	struct drm_atomic_state *state = container_of(ref, typeof(*state), ref);
-	struct drm_mode_config *config = &state->dev->mode_config;
+	struct drm_device *dev = state->dev;
+	struct drm_mode_config *config = &dev->mode_config;
 
 	drm_atomic_state_clear(state);
 
@@ -269,6 +276,8 @@ void __drm_atomic_state_free(struct kref *ref)
 		drm_atomic_state_default_release(state);
 		kfree(state);
 	}
+
+	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(__drm_atomic_state_free);
 
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 7fc8e7000046..0fde260b7edd 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1113,7 +1113,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 			continue;
 
 		ret = drm_crtc_vblank_get(crtc);
-		WARN_ONCE(ret != -EINVAL, "driver forgot to call drm_crtc_vblank_off()\n");
+		/*
+		 * Self-refresh is not a true "disable"; ensure vblank remains
+		 * enabled.
+		 */
+		if (new_crtc_state->self_refresh_active)
+			WARN_ONCE(ret != 0,
+				  "driver disabled vblank in self-refresh\n");
+		else
+			WARN_ONCE(ret != -EINVAL,
+				  "driver forgot to call drm_crtc_vblank_off()\n");
 		if (ret == 0)
 			drm_crtc_vblank_put(crtc);
 	}
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index b7e9e1c2564c..d5fd41823624 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -308,6 +308,9 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	for (i = 0; i < connector_count; i++) {
 		if (!enabled[i])
 			continue;
@@ -323,11 +326,13 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 		if (!modes[i])
 			can_clone = false;
 	}
+	kfree(dmt_mode);
 
 	if (can_clone) {
 		DRM_DEBUG_KMS("can clone using 1024x768\n");
 		return true;
 	}
+fail:
 	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
 	return false;
 }
@@ -859,6 +864,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 				break;
 			}
 
+			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 375c79e23ca5..eb104de16fa7 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -41,7 +41,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  * the frame's scanout buffer or the cursor image. If there's no more space
  * left in VRAM, inactive GEM objects can be moved to system memory.
  *
- * To initialize the VRAM helper library call drmm_vram_helper_alloc_mm().
+ * To initialize the VRAM helper library call drmm_vram_helper_init().
  * The function allocates and initializes an instance of &struct drm_vram_mm
  * in &struct drm_device.vram_mm . Use &DRM_GEM_VRAM_DRIVER to initialize
  * &struct drm_driver and  &DRM_VRAM_MM_FILE_OPERATIONS to initialize
@@ -69,7 +69,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  *		// setup device, vram base and size
  *		// ...
  *
- *		ret = drmm_vram_helper_alloc_mm(dev, vram_base, vram_size);
+ *		ret = drmm_vram_helper_init(dev, vram_base, vram_size);
  *		if (ret)
  *			return ret;
  *		return 0;
@@ -82,7 +82,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  * to userspace.
  *
  * You don't have to clean up the instance of VRAM MM.
- * drmm_vram_helper_alloc_mm() is a managed interface that installs a
+ * drmm_vram_helper_init() is a managed interface that installs a
  * clean-up handler to run during the DRM device's release.
  *
  * For drawing or scanout operations, rsp. buffer objects have to be pinned
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 5afb3c544653..4c64e2d4f650 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1262,6 +1262,8 @@ static const struct drm_crtc_helper_funcs dpu_crtc_helper_funcs = {
 struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 				struct drm_plane *cursor)
 {
+	struct msm_drm_private *priv = dev->dev_private;
+	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 	struct drm_crtc *crtc = NULL;
 	struct dpu_crtc *dpu_crtc = NULL;
 	int i;
@@ -1293,7 +1295,8 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 
 	drm_crtc_helper_add(crtc, &dpu_crtc_helper_funcs);
 
-	drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
+	if (dpu_kms->catalog->dspp_count)
+		drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
 
 	/* save user friendly CRTC name for later */
 	snprintf(dpu_crtc->name, DPU_CRTC_NAME_SIZE, "crtc%u", crtc->base.id);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 0bcccf422192..4da8cea76a11 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1267,9 +1267,9 @@ static int dp_display_remove(struct platform_device *pdev)
 	dp = container_of(g_dp_display,
 			struct dp_display_private, dp_display);
 
+	component_del(&pdev->dev, &dp_display_comp_ops);
 	dp_display_deinit_sub_modules(dp);
 
-	component_del(&pdev->dev, &dp_display_comp_ops);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 16dbf0f353ed..1f5fb1547730 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -192,15 +192,15 @@ static int sharp_nt_panel_enable(struct drm_panel *panel)
 }
 
 static const struct drm_display_mode default_mode = {
-	.clock = 41118,
+	.clock = (540 + 48 + 32 + 80) * (960 + 3 + 10 + 15) * 60 / 1000,
 	.hdisplay = 540,
 	.hsync_start = 540 + 48,
-	.hsync_end = 540 + 48 + 80,
-	.htotal = 540 + 48 + 80 + 32,
+	.hsync_end = 540 + 48 + 32,
+	.htotal = 540 + 48 + 32 + 80,
 	.vdisplay = 960,
 	.vsync_start = 960 + 3,
-	.vsync_end = 960 + 3 + 15,
-	.vtotal = 960 + 3 + 15 + 1,
+	.vsync_end = 960 + 3 + 10,
+	.vtotal = 960 + 3 + 10 + 15,
 };
 
 static int sharp_nt_panel_get_modes(struct drm_panel *panel,
@@ -280,6 +280,7 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 2;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
+			MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 			MIPI_DSI_MODE_VIDEO_HSE |
 			MIPI_DSI_CLOCK_NON_CONTINUOUS |
 			MIPI_DSI_MODE_EOT_PACKET;
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 1a87cc445b5e..7b69f81444eb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -704,8 +704,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
 	.num_modes = 1,
 	.bpc = 8,
 	.size = {
-		.width = 105,
-		.height = 67,
+		.width = 99,
+		.height = 58,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
@@ -2091,6 +2091,7 @@ static const struct panel_desc innolux_at043tn24 = {
 		.height = 54,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 };
 
@@ -3152,6 +3153,7 @@ static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
 	.vsync_start = 480 + 49,
 	.vsync_end = 480 + 49 + 2,
 	.vtotal = 480 + 49 + 2 + 22,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
 };
 
 static const struct panel_desc powertip_ph800480t013_idf02  = {
diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 886e9959496f..f98df826972c 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5541,6 +5541,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	u8 frev, crev;
 	u8 *power_state_offset;
 	struct ci_ps *ps;
+	int ret;
 
 	if (!atom_parse_data_header(mode_info->atom_context, index, NULL,
 				   &frev, &crev, &data_offset))
@@ -5570,11 +5571,15 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
-		if (!rdev->pm.power_state[i].clock_info)
-			return -EINVAL;
+		if (!rdev->pm.power_state[i].clock_info) {
+			ret = -EINVAL;
+			goto err_free_ps;
+		}
 		ps = kzalloc(sizeof(struct ci_ps), GFP_KERNEL);
-		if (ps == NULL)
-			return -ENOMEM;
+		if (ps == NULL) {
+			ret = -ENOMEM;
+			goto err_free_ps;
+		}
 		rdev->pm.dpm.ps[i].ps_priv = ps;
 		ci_parse_pplib_non_clock_info(rdev, &rdev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -5614,6 +5619,12 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	}
 
 	return 0;
+
+err_free_ps:
+	for (i = 0; i < rdev->pm.dpm.num_ps; i++)
+		kfree(rdev->pm.dpm.ps[i].ps_priv);
+	kfree(rdev->pm.dpm.ps);
+	return ret;
 }
 
 static int ci_get_vbios_boot_values(struct radeon_device *rdev,
@@ -5702,25 +5713,26 @@ int ci_dpm_init(struct radeon_device *rdev)
 
 	ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_get_platform_caps(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_parse_extended_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = ci_parse_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
+		r600_free_extended_power_table(rdev);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeon/cypress_dpm.c
index 35b177d77791..7120710d188f 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -559,8 +559,12 @@ static int cypress_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index a5218747742b..f79b348d36ad 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2240,8 +2240,12 @@ static int ni_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/rv740_dpm.c b/drivers/gpu/drm/radeon/rv740_dpm.c
index 327d65a76e1f..79b2de65e905 100644
--- a/drivers/gpu/drm/radeon/rv740_dpm.c
+++ b/drivers/gpu/drm/radeon/rv740_dpm.c
@@ -250,8 +250,12 @@ int rv740_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = 0x40000 * ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = 0x40000 * ss.percentage *
 				(dividers.whole_fb_div + (dividers.frac_fb_div / 8)) / (clk_s * 10000);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index af98bfcde518..65dde9df9793 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -702,13 +702,13 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (crtc->state->self_refresh_active)
 		rockchip_drm_set_win_enabled(crtc, false);
 
+	if (crtc->state->self_refresh_active)
+		goto out;
+
 	mutex_lock(&vop->vop_lock);
 
 	drm_crtc_vblank_off(crtc);
 
-	if (crtc->state->self_refresh_active)
-		goto out;
-
 	/*
 	 * Vop standby will take effect at end of current frame,
 	 * if dsp hold valid irq happen, it means standby complete.
@@ -740,9 +740,9 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	vop_core_clks_disable(vop);
 	pm_runtime_put(vop->dev);
 
-out:
 	mutex_unlock(&vop->vop_lock);
 
+out:
 	if (crtc->state->event && !crtc->state->active) {
 		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9f06dec0fc61..bb43196d5d83 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -777,21 +777,19 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 static int sun4i_tcon_init_clocks(struct device *dev,
 				  struct sun4i_tcon *tcon)
 {
-	tcon->clk = devm_clk_get(dev, "ahb");
+	tcon->clk = devm_clk_get_enabled(dev, "ahb");
 	if (IS_ERR(tcon->clk)) {
 		dev_err(dev, "Couldn't get the TCON bus clock\n");
 		return PTR_ERR(tcon->clk);
 	}
-	clk_prepare_enable(tcon->clk);
 
 	if (tcon->quirks->has_channel_0) {
-		tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
+		tcon->sclk0 = devm_clk_get_enabled(dev, "tcon-ch0");
 		if (IS_ERR(tcon->sclk0)) {
 			dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
 			return PTR_ERR(tcon->sclk0);
 		}
 	}
-	clk_prepare_enable(tcon->sclk0);
 
 	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
@@ -804,12 +802,6 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 	return 0;
 }
 
-static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
-{
-	clk_disable_unprepare(tcon->sclk0);
-	clk_disable_unprepare(tcon->clk);
-}
-
 static int sun4i_tcon_init_irq(struct device *dev,
 			       struct sun4i_tcon *tcon)
 {
@@ -1224,14 +1216,14 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	ret = sun4i_tcon_init_regmap(dev, tcon);
 	if (ret) {
 		dev_err(dev, "Couldn't init our TCON regmap\n");
-		goto err_free_clocks;
+		goto err_assert_reset;
 	}
 
 	if (tcon->quirks->has_channel_0) {
 		ret = sun4i_dclk_create(dev, tcon);
 		if (ret) {
 			dev_err(dev, "Couldn't create our TCON dot clock\n");
-			goto err_free_clocks;
+			goto err_assert_reset;
 		}
 	}
 
@@ -1294,8 +1286,6 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 err_free_dotclock:
 	if (tcon->quirks->has_channel_0)
 		sun4i_dclk_free(tcon);
-err_free_clocks:
-	sun4i_tcon_free_clocks(tcon);
 err_assert_reset:
 	reset_control_assert(tcon->lcd_rst);
 	return ret;
@@ -1309,7 +1299,6 @@ static void sun4i_tcon_unbind(struct device *dev, struct device *master,
 	list_del(&tcon->list);
 	if (tcon->quirks->has_channel_0)
 		sun4i_dclk_free(tcon);
-	sun4i_tcon_free_clocks(tcon);
 }
 
 static const struct component_ops sun4i_tcon_ops = {
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2e32a21bbcbf..6ac0c2d9a147 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4009,7 +4009,7 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
-	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* Mouse Logitech Anywhere MX */
 	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Mouse Logitech Cube */
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1bfcc94c1d23..de6fe9866870 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1307,7 +1307,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
 	int number_of_valid_frames = 0;
-	int time_interval = 15000000;
+	ktime_t time_interval = 15000000;
 	ktime_t time_packet_received = ktime_get();
 	int i;
 
@@ -1341,7 +1341,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 	if (number_of_valid_frames) {
 		if (wacom->hid_data.time_delayed)
 			time_interval = ktime_get() - wacom->hid_data.time_delayed;
-		time_interval /= number_of_valid_frames;
+		time_interval = div_u64(time_interval, number_of_valid_frames);
 		wacom->hid_data.time_delayed = time_packet_received;
 	}
 
@@ -1352,7 +1352,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
 		int frames_number_reversed = number_of_valid_frames - i - 1;
-		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
+		ktime_t event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 88badfbae999..166731292c35 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -320,7 +320,7 @@ struct hid_data {
 	int bat_connected;
 	int ps_connected;
 	bool pad_input_event_flag;
-	int time_delayed;
+	ktime_t time_delayed;
 };
 
 struct wacom_remote_data {
diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index f29ce49294da..89d036bf88df 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -82,8 +82,8 @@ static ssize_t pwm_auto_point_temp_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 10000);
-	temp = DIV_ROUND_CLOSEST(temp, 10);
+	temp = clamp_val(temp, 0, 100000);
+	temp = DIV_ROUND_CLOSEST(temp, 100);
 
 	regs[0] = temp & 0xff;
 	regs[1] = (temp >> 8) & 0xff;
@@ -100,7 +100,7 @@ static ssize_t pwm_auto_point_pwm_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)) / 100);
+	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)));
 }
 
 static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm_auto_point_pwm, 0);
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index e7997f37b266..c0618205758e 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -37,10 +37,13 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
 
 #define ADM1272_IRANGE			BIT(0)
 
+#define ADM1278_TSFILT			BIT(15)
 #define ADM1278_TEMP1_EN		BIT(3)
 #define ADM1278_VIN_EN			BIT(2)
 #define ADM1278_VOUT_EN			BIT(1)
 
+#define ADM1278_PMON_DEFCONFIG		(ADM1278_VOUT_EN | ADM1278_TEMP1_EN | ADM1278_TSFILT)
+
 #define ADM1293_IRANGE_25		0
 #define ADM1293_IRANGE_50		BIT(6)
 #define ADM1293_IRANGE_100		BIT(7)
@@ -462,6 +465,22 @@ static const struct i2c_device_id adm1275_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adm1275_id);
 
+/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
+static int adm1275_enable_vout_temp(struct i2c_client *client, int config)
+{
+	int ret;
+
+	if ((config & ADM1278_PMON_DEFCONFIG) != ADM1278_PMON_DEFCONFIG) {
+		config |= ADM1278_PMON_DEFCONFIG;
+		ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, config);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to enable VOUT/TEMP1 monitoring\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
 static int adm1275_probe(struct i2c_client *client)
 {
 	s32 (*config_read_fn)(const struct i2c_client *client, u8 reg);
@@ -475,6 +494,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u32 avg;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -611,24 +631,13 @@ static int adm1275_probe(struct i2c_client *client)
 		tindex = 8;
 
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
-
-		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
-			config |= ADM1278_VOUT_EN;
-			ret = i2c_smbus_write_byte_data(client,
-							ADM1275_PMON_CONFIG,
-							config);
-			if (ret < 0) {
-				dev_err(&client->dev,
-					"Failed to enable VOUT monitoring\n");
-				return -ENODEV;
-			}
-		}
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
+
+		ret = adm1275_enable_vout_temp(client, config);
+		if (ret)
+			return ret;
 
-		if (config & ADM1278_TEMP1_EN)
-			info->func[0] |=
-				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		if (config & ADM1278_VIN_EN)
 			info->func[0] |= PMBUS_HAVE_VIN;
 		break;
@@ -685,19 +694,9 @@ static int adm1275_probe(struct i2c_client *client)
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
 			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
-		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
-		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
-		    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
-			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
-			ret = i2c_smbus_write_byte_data(client,
-							ADM1275_PMON_CONFIG,
-							config);
-			if (ret < 0) {
-				dev_err(&client->dev,
-					"Failed to enable VOUT monitoring\n");
-				return -ENODEV;
-			}
-		}
+		ret = adm1275_enable_vout_temp(client, config);
+		if (ret)
+			return ret;
 
 		if (config & ADM1278_VIN_EN)
 			info->func[0] |= PMBUS_HAVE_VIN;
@@ -758,6 +757,43 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
+	    of_property_read_u32(client->dev.of_node,
+				 "adi,power-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of power samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, true,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting power sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
+	if (of_property_read_u32(client->dev.of_node,
+				"adi,volt-curr-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of voltage/current samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, false,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting voltage and current sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
 	if (voindex < 0)
 		voindex = vindex;
 	if (vindex >= 0) {
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 5ddc8103503b..c4b805b04531 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1376,13 +1376,8 @@ static int coresight_remove_match(struct device *dev, void *data)
 		if (csdev->dev.fwnode == conn->child_fwnode) {
 			iterator->orphan = true;
 			coresight_remove_links(iterator, conn);
-			/*
-			 * Drop the reference to the handle for the remote
-			 * device acquired in parsing the connections from
-			 * platform data.
-			 */
-			fwnode_handle_put(conn->child_fwnode);
-			conn->child_fwnode = NULL;
+
+			conn->child_dev = NULL;
 			/* No need to continue */
 			break;
 		}
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 5a47915869ae..576c12670bd8 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1752,16 +1752,21 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	if (!clk_freq || clk_freq > I2C_MAX_FAST_MODE_PLUS_FREQ) {
 		dev_err(qup->dev, "clock frequency not supported %d\n",
 			clk_freq);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail_dma;
 	}
 
 	qup->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qup->base))
-		return PTR_ERR(qup->base);
+	if (IS_ERR(qup->base)) {
+		ret = PTR_ERR(qup->base);
+		goto fail_dma;
+	}
 
 	qup->irq = platform_get_irq(pdev, 0);
-	if (qup->irq < 0)
-		return qup->irq;
+	if (qup->irq < 0) {
+		ret = qup->irq;
+		goto fail_dma;
+	}
 
 	if (has_acpi_companion(qup->dev)) {
 		ret = device_property_read_u32(qup->dev,
@@ -1775,13 +1780,15 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup->clk = devm_clk_get(qup->dev, "core");
 		if (IS_ERR(qup->clk)) {
 			dev_err(qup->dev, "Could not get core clock\n");
-			return PTR_ERR(qup->clk);
+			ret = PTR_ERR(qup->clk);
+			goto fail_dma;
 		}
 
 		qup->pclk = devm_clk_get(qup->dev, "iface");
 		if (IS_ERR(qup->pclk)) {
 			dev_err(qup->dev, "Could not get iface clock\n");
-			return PTR_ERR(qup->pclk);
+			ret = PTR_ERR(qup->pclk);
+			goto fail_dma;
 		}
 		qup_i2c_enable_clocks(qup);
 		src_clk_freq = clk_get_rate(qup->clk);
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3b564e68130b..568e97c3896d 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -375,6 +375,9 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	struct xiic_i2c *i2c = dev_id;
 	u32 pend, isr, ier;
 	u32 clr = 0;
+	int xfer_more = 0;
+	int wakeup_req = 0;
+	int wakeup_code = 0;
 
 	/* Get the interrupt Status from the IPIF. There is no clearing of
 	 * interrupts in the IPIF. Interrupts must be cleared at the source.
@@ -411,10 +414,16 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 		 */
 		xiic_reinit(i2c);
 
-		if (i2c->rx_msg)
-			xiic_wakeup(i2c, STATE_ERROR);
-		if (i2c->tx_msg)
-			xiic_wakeup(i2c, STATE_ERROR);
+		if (i2c->rx_msg) {
+			wakeup_req = 1;
+			wakeup_code = STATE_ERROR;
+		}
+		if (i2c->tx_msg) {
+			wakeup_req = 1;
+			wakeup_code = STATE_ERROR;
+		}
+		/* don't try to handle other events */
+		goto out;
 	}
 	if (pend & XIIC_INTR_RX_FULL_MASK) {
 		/* Receive register/FIFO is full */
@@ -448,8 +457,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 				i2c->tx_msg++;
 				dev_dbg(i2c->adap.dev.parent,
 					"%s will start next...\n", __func__);
-
-				__xiic_start_xfer(i2c);
+				xfer_more = 1;
 			}
 		}
 	}
@@ -463,11 +471,13 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 		if (!i2c->tx_msg)
 			goto out;
 
-		if ((i2c->nmsgs == 1) && !i2c->rx_msg &&
-			xiic_tx_space(i2c) == 0)
-			xiic_wakeup(i2c, STATE_DONE);
+		wakeup_req = 1;
+
+		if (i2c->nmsgs == 1 && !i2c->rx_msg &&
+		    xiic_tx_space(i2c) == 0)
+			wakeup_code = STATE_DONE;
 		else
-			xiic_wakeup(i2c, STATE_ERROR);
+			wakeup_code = STATE_ERROR;
 	}
 	if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK)) {
 		/* Transmit register/FIFO is empty or ½ empty */
@@ -491,7 +501,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 			if (i2c->nmsgs > 1) {
 				i2c->nmsgs--;
 				i2c->tx_msg++;
-				__xiic_start_xfer(i2c);
+				xfer_more = 1;
 			} else {
 				xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
 
@@ -509,6 +519,13 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
 
 	xiic_setreg32(i2c, XIIC_IISR_OFFSET, clr);
+	if (xfer_more)
+		__xiic_start_xfer(i2c);
+	if (wakeup_req)
+		xiic_wakeup(i2c, wakeup_code);
+
+	WARN_ON(xfer_more && wakeup_req);
+
 	mutex_unlock(&i2c->lock);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index e03988698755..e771299fac9d 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -71,7 +71,7 @@
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
 	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
-	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
+	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index db24f7dfa00f..805678f6fe57 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1792,6 +1792,14 @@ static void cma_cancel_operation(struct rdma_id_private *id_priv,
 {
 	switch (state) {
 	case RDMA_CM_ADDR_QUERY:
+		/*
+		 * We can avoid doing the rdma_addr_cancel() based on state,
+		 * only RDMA_CM_ADDR_QUERY has a work that could still execute.
+		 * Notice that the addr_handler work could still be exiting
+		 * outside this state, however due to the interaction with the
+		 * handler_mutex the work is guaranteed not to touch id_priv
+		 * during exit.
+		 */
 		rdma_addr_cancel(&id_priv->id.route.addr.dev_addr);
 		break;
 	case RDMA_CM_ROUTE_QUERY:
@@ -3401,6 +3409,21 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 		if (dst_addr->sa_family == AF_IB) {
 			ret = cma_resolve_ib_addr(id_priv);
 		} else {
+			/*
+			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
+			 * rdma_resolve_ip() is called, eg through the error
+			 * path in addr_handler(). If this happens the existing
+			 * request must be canceled before issuing a new one.
+			 * Since canceling a request is a bit slow and this
+			 * oddball path is rare, keep track once a request has
+			 * been issued. The track turns out to be a permanent
+			 * state since this is the only cancel as it is
+			 * immediately before rdma_resolve_ip().
+			 */
+			if (id_priv->used_resolve_ip)
+				rdma_addr_cancel(&id->route.addr.dev_addr);
+			else
+				id_priv->used_resolve_ip = 1;
 			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
 					      &id->route.addr.dev_addr,
 					      timeout_ms, addr_handler,
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index caece96ebcf5..b53f4fa5e3fb 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -89,6 +89,7 @@ struct rdma_id_private {
 	u8			reuseaddr;
 	u8			afonly;
 	u8			timeout;
+	u8 used_resolve_ip;
 	enum ib_gid_type	gid_type;
 
 	/*
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 5b7abcf102fe..3c29fd04b301 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -600,6 +600,17 @@ struct ib_device *_ib_alloc_device(size_t size)
 	init_completion(&device->unreg_completion);
 	INIT_WORK(&device->unregistration_work, ib_unregister_work);
 
+	device->uverbs_ex_cmd_mask =
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_FLOW) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
+
 	return device;
 }
 EXPORT_SYMBOL(_ib_alloc_device);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 09cf470c08d6..158f9eadc4e9 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3778,7 +3778,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 			IB_USER_VERBS_EX_CMD_MODIFY_CQ,
 			ib_uverbs_ex_modify_cq,
 			UAPI_DEF_WRITE_I(struct ib_uverbs_ex_modify_cq),
-			UAPI_DEF_METHOD_NEEDS_FN(create_cq))),
+			UAPI_DEF_METHOD_NEEDS_FN(modify_cq))),
 
 	DECLARE_UVERBS_OBJECT(
 		UVERBS_OBJECT_DEVICE,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9ef6aea29ff1..8a618769915d 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -294,15 +294,21 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	for (indx = 0; indx < rdev->num_msix; indx++)
 		rdev->msix_entries[indx].vector = ent[indx].vector;
 
-	bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
-				  false);
+	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
+				       false);
+	if (rc) {
+		ibdev_warn(&rdev->ibdev, "Failed to reinit CREQ\n");
+		return;
+	}
 	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->num_msix; indx++) {
 		nq = &rdev->nq[indx - 1];
 		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
 					     msix_ent[indx].vector, false);
-		if (rc)
+		if (rc) {
 			ibdev_warn(&rdev->ibdev, "Failed to reinit NQ index %d\n",
 				   indx - 1);
+			return;
+		}
 	}
 }
 
@@ -1185,12 +1191,6 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 	if (!ib_device_try_get(&rdev->ibdev))
 		return 0;
 
-	if (!sgid_tbl) {
-		ibdev_err(&rdev->ibdev, "QPLIB: SGID table not allocated");
-		rc = -EINVAL;
-		goto out;
-	}
-
 	for (index = 0; index < sgid_tbl->active; index++) {
 		gid_idx = sgid_tbl->hw_id[index];
 
@@ -1208,7 +1208,7 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 		rc = bnxt_qplib_update_sgid(sgid_tbl, &gid, gid_idx,
 					    rdev->qplib_res.netdev->dev_addr);
 	}
-out:
+
 	ib_device_put(&rdev->ibdev);
 	return rc;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index b26a89187a19..d44b6a5c90b5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -404,6 +404,9 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 
 void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 {
+	if (!nq->requested)
+		return;
+
 	tasklet_disable(&nq->nq_tasklet);
 	/* Mask h/w interrupt */
 	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, false);
@@ -411,11 +414,12 @@ void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 	synchronize_irq(nq->msix_vec);
 	if (kill)
 		tasklet_kill(&nq->nq_tasklet);
-	if (nq->requested) {
-		irq_set_affinity_hint(nq->msix_vec, NULL);
-		free_irq(nq->msix_vec, nq);
-		nq->requested = false;
-	}
+
+	irq_set_affinity_hint(nq->msix_vec, NULL);
+	free_irq(nq->msix_vec, nq);
+	kfree(nq->name);
+	nq->name = NULL;
+	nq->requested = false;
 }
 
 void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
@@ -441,6 +445,7 @@ void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
 int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 			    int msix_vector, bool need_init)
 {
+	struct bnxt_qplib_res *res = nq->res;
 	int rc;
 
 	if (nq->requested)
@@ -452,10 +457,17 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 	else
 		tasklet_enable(&nq->nq_tasklet);
 
-	snprintf(nq->name, sizeof(nq->name), "bnxt_qplib_nq-%d", nq_indx);
+	nq->name = kasprintf(GFP_KERNEL, "bnxt_re-nq-%d@pci:%s",
+			     nq_indx, pci_name(res->pdev));
+	if (!nq->name)
+		return -ENOMEM;
 	rc = request_irq(nq->msix_vec, bnxt_qplib_nq_irq, 0, nq->name, nq);
-	if (rc)
+	if (rc) {
+		kfree(nq->name);
+		nq->name = NULL;
+		tasklet_disable(&nq->nq_tasklet);
 		return rc;
+	}
 
 	cpumask_clear(&nq->mask);
 	cpumask_set_cpu(nq_indx, &nq->mask);
@@ -466,7 +478,7 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 			 nq->msix_vec, nq_indx);
 	}
 	nq->requested = true;
-	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
+	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, res->cctx, true);
 
 	return rc;
 }
@@ -1599,7 +1611,7 @@ static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
 		il_src = (void *)wqe->sg_list[indx].addr;
 		t_len += len;
 		if (t_len > qp->max_inline_data)
-			goto bad;
+			return -ENOMEM;
 		while (len) {
 			if (pull_dst) {
 				pull_dst = false;
@@ -1623,8 +1635,6 @@ static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
 	}
 
 	return t_len;
-bad:
-	return -ENOMEM;
 }
 
 static u32 bnxt_qplib_put_sges(struct bnxt_qplib_hwq *hwq,
@@ -2054,7 +2064,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	hwq_attr.sginfo = &cq->sg_info;
 	rc = bnxt_qplib_alloc_init_hwq(&cq->hwq, &hwq_attr);
 	if (rc)
-		goto exit;
+		return rc;
 
 	RCFW_CMD_PREP(req, CREATE_CQ, cmd_flags);
 
@@ -2095,7 +2105,6 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 
 fail:
 	bnxt_qplib_free_hwq(res, &cq->hwq);
-exit:
 	return rc;
 }
 
@@ -2723,11 +2732,8 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
 				      le64_to_cpu(hwcqe->qp_handle));
-	if (!qp) {
-		dev_err(&cq->hwq.pdev->dev,
-			"FP: CQ Process terminal qp is NULL\n");
+	if (!qp)
 		return -EINVAL;
-	}
 
 	/* Must block new posting of SQ and RQ */
 	qp->state = CMDQ_MODIFY_QP_NEW_STATE_ERR;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index f50784405e27..667f93d90045 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -469,7 +469,7 @@ typedef int (*srqn_handler_t)(struct bnxt_qplib_nq *nq,
 struct bnxt_qplib_nq {
 	struct pci_dev			*pdev;
 	struct bnxt_qplib_res		*res;
-	char				name[32];
+	char				*name;
 	struct bnxt_qplib_hwq		hwq;
 	struct bnxt_qplib_nq_db		nq_db;
 	u16				ring_id;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5759027914b0..2b0c3a86293c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -181,7 +181,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 	} while (size > 0);
 	cmdq->seq_num++;
 
-	cmdq_prod = hwq->prod;
+	cmdq_prod = hwq->prod & 0xFFFF;
 	if (test_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags)) {
 		/* The very first doorbell write
 		 * is required to set this flag
@@ -295,7 +295,8 @@ static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 }
 
 static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
-				       struct creq_qp_event *qp_event)
+				       struct creq_qp_event *qp_event,
+				       u32 *num_wait)
 {
 	struct creq_qp_error_notification *err_event;
 	struct bnxt_qplib_hwq *hwq = &rcfw->cmdq.hwq;
@@ -304,6 +305,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	u16 cbit, blocked = 0;
 	struct pci_dev *pdev;
 	unsigned long flags;
+	u32 wait_cmds = 0;
 	__le16  mcookie;
 	u16 cookie;
 	int rc = 0;
@@ -363,9 +365,10 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		crsqe->req_size = 0;
 
 		if (!blocked)
-			wake_up(&rcfw->cmdq.waitq);
+			wait_cmds++;
 		spin_unlock_irqrestore(&hwq->lock, flags);
 	}
+	*num_wait += wait_cmds;
 	return rc;
 }
 
@@ -379,6 +382,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	struct creq_base *creqe;
 	u32 sw_cons, raw_cons;
 	unsigned long flags;
+	u32 num_wakeup = 0;
 
 	/* Service the CREQ until budget is over */
 	spin_lock_irqsave(&hwq->lock, flags);
@@ -397,7 +401,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 		switch (type) {
 		case CREQ_BASE_TYPE_QP_EVENT:
 			bnxt_qplib_process_qp_event
-				(rcfw, (struct creq_qp_event *)creqe);
+				(rcfw, (struct creq_qp_event *)creqe,
+				 &num_wakeup);
 			creq->stats.creq_qp_event_processed++;
 			break;
 		case CREQ_BASE_TYPE_FUNC_EVENT:
@@ -425,6 +430,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 				      rcfw->res->cctx, true);
 	}
 	spin_unlock_irqrestore(&hwq->lock, flags);
+	if (num_wakeup)
+		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
 }
 
 static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
@@ -595,7 +602,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 		rcfw->cmdq_depth = BNXT_QPLIB_CMDQE_MAX_CNT_8192;
 
 	sginfo.pgsize = bnxt_qplib_cmdqe_page_size(rcfw->cmdq_depth);
-	hwq_attr.depth = rcfw->cmdq_depth;
+	hwq_attr.depth = rcfw->cmdq_depth & 0x7FFFFFFF;
 	hwq_attr.stride = BNXT_QPLIB_CMDQE_UNITS;
 	hwq_attr.type = HWQ_TYPE_CTX;
 	if (bnxt_qplib_alloc_init_hwq(&cmdq->hwq, &hwq_attr)) {
@@ -633,6 +640,10 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	struct bnxt_qplib_creq_ctx *creq;
 
 	creq = &rcfw->creq;
+
+	if (!creq->requested)
+		return;
+
 	tasklet_disable(&creq->creq_tasklet);
 	/* Mask h/w interrupts */
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, false);
@@ -641,10 +652,10 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	if (kill)
 		tasklet_kill(&creq->creq_tasklet);
 
-	if (creq->requested) {
-		free_irq(creq->msix_vec, rcfw);
-		creq->requested = false;
-	}
+	free_irq(creq->msix_vec, rcfw);
+	kfree(creq->irq_name);
+	creq->irq_name = NULL;
+	creq->requested = false;
 }
 
 void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
@@ -676,9 +687,11 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 			      bool need_init)
 {
 	struct bnxt_qplib_creq_ctx *creq;
+	struct bnxt_qplib_res *res;
 	int rc;
 
 	creq = &rcfw->creq;
+	res = rcfw->res;
 
 	if (creq->requested)
 		return -EFAULT;
@@ -688,13 +701,22 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 		tasklet_setup(&creq->creq_tasklet, bnxt_qplib_service_creq);
 	else
 		tasklet_enable(&creq->creq_tasklet);
+
+	creq->irq_name = kasprintf(GFP_KERNEL, "bnxt_re-creq@pci:%s",
+				   pci_name(res->pdev));
+	if (!creq->irq_name)
+		return -ENOMEM;
 	rc = request_irq(creq->msix_vec, bnxt_qplib_creq_irq, 0,
-			 "bnxt_qplib_creq", rcfw);
-	if (rc)
+			 creq->irq_name, rcfw);
+	if (rc) {
+		kfree(creq->irq_name);
+		creq->irq_name = NULL;
+		tasklet_disable(&creq->creq_tasklet);
 		return rc;
+	}
 	creq->requested = true;
 
-	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, true);
+	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, res->cctx, true);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 6953f4e53dd2..7df7170c80e0 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -172,6 +172,7 @@ struct bnxt_qplib_creq_ctx {
 	u16				ring_id;
 	int				msix_vec;
 	bool				requested; /*irq handler installed */
+	char				*irq_name;
 };
 
 /* RCFW Communication Channels */
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index ffdd18f4217f..cd41cd114ab6 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -326,9 +326,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH) |
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
 
-	dev->ibdev.uverbs_ex_cmd_mask =
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
-
 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
 
 	err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 956fc3fd88b9..188048468135 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -251,11 +251,11 @@ static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 		ret = sdma_txadd_page(dd,
-				      NULL,
 				      txreq,
 				      skb_frag_page(frag),
 				      frag->bv_offset,
-				      skb_frag_size(frag));
+				      skb_frag_size(frag),
+				      NULL, NULL, NULL);
 		if (unlikely(ret))
 			break;
 	}
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index d331184ded30..a501b7a682fc 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -60,8 +60,7 @@ static int mmu_notifier_range_start(struct mmu_notifier *,
 		const struct mmu_notifier_range *);
 static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *,
 					   unsigned long, unsigned long);
-static void do_remove(struct mmu_rb_handler *handler,
-		      struct list_head *del_list);
+static void release_immediate(struct kref *refcount);
 static void handle_remove(struct work_struct *work);
 
 static const struct mmu_notifier_ops mn_opts = {
@@ -144,7 +143,11 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	do_remove(handler, &del_list);
+	while (!list_empty(&del_list)) {
+		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&rbnode->list);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
 
 	/* Now the mm may be freed. */
 	mmdrop(handler->mn.mm);
@@ -172,12 +175,6 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
 	list_add_tail(&mnode->list, &handler->lru_list);
-
-	ret = handler->ops->insert(handler->ops_arg, mnode);
-	if (ret) {
-		__mmu_int_rb_remove(mnode, &handler->root);
-		list_del(&mnode->list); /* remove from LRU list */
-	}
 	mnode->handler = handler;
 unlock:
 	spin_unlock_irqrestore(&handler->lock, flags);
@@ -221,6 +218,48 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 	return node;
 }
 
+/*
+ * Must NOT call while holding mnode->handler->lock.
+ * mnode->handler->ops->remove() may sleep and mnode->handler->lock is a
+ * spinlock.
+ */
+static void release_immediate(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	mnode->handler->ops->remove(mnode->handler->ops_arg, mnode);
+}
+
+/* Caller must hold mnode->handler->lock */
+static void release_nolock(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	queue_work(mnode->handler->wq, &mnode->handler->del_work);
+}
+
+/*
+ * struct mmu_rb_node->refcount kref_put() callback.
+ * Adds mmu_rb_node to mmu_rb_node->handler->del_list and queues
+ * handler->del_work on handler->wq.
+ * Does not remove mmu_rb_node from handler->lru_list or handler->rb_root.
+ * Acquires mmu_rb_node->handler->lock; do not call while already holding
+ * handler->lock.
+ */
+void hfi1_mmu_rb_release(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	struct mmu_rb_handler *handler = mnode->handler;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+	queue_work(handler->wq, &handler->del_work);
+}
+
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 {
 	struct mmu_rb_node *rbnode, *ptr;
@@ -235,6 +274,10 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 
 	spin_lock_irqsave(&handler->lock, flags);
 	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
+		/* refcount == 1 implies mmu_rb_handler has only rbnode ref */
+		if (kref_read(&rbnode->refcount) > 1)
+			continue;
+
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -247,7 +290,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	spin_unlock_irqrestore(&handler->lock, flags);
 
 	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
-		handler->ops->remove(handler->ops_arg, rbnode);
+		kref_put(&rbnode->refcount, release_immediate);
 	}
 }
 
@@ -259,7 +302,6 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 	struct rb_root_cached *root = &handler->root;
 	struct mmu_rb_node *node, *ptr = NULL;
 	unsigned long flags;
-	bool added = false;
 
 	spin_lock_irqsave(&handler->lock, flags);
 	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
@@ -268,38 +310,16 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 		ptr = __mmu_int_rb_iter_next(node, range->start,
 					     range->end - 1);
 		trace_hfi1_mmu_mem_invalidate(node->addr, node->len);
-		if (handler->ops->invalidate(handler->ops_arg, node)) {
-			__mmu_int_rb_remove(node, root);
-			/* move from LRU list to delete list */
-			list_move(&node->list, &handler->del_list);
-			added = true;
-		}
+		/* Remove from rb tree and lru_list. */
+		__mmu_int_rb_remove(node, root);
+		list_del_init(&node->list);
+		kref_put(&node->refcount, release_nolock);
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	if (added)
-		queue_work(handler->wq, &handler->del_work);
-
 	return 0;
 }
 
-/*
- * Call the remove function for the given handler and the list.  This
- * is expected to be called with a delete list extracted from handler.
- * The caller should not be holding the handler lock.
- */
-static void do_remove(struct mmu_rb_handler *handler,
-		      struct list_head *del_list)
-{
-	struct mmu_rb_node *node;
-
-	while (!list_empty(del_list)) {
-		node = list_first_entry(del_list, struct mmu_rb_node, list);
-		list_del(&node->list);
-		handler->ops->remove(handler->ops_arg, node);
-	}
-}
-
 /*
  * Work queue function to remove all nodes that have been queued up to
  * be removed.  The key feature is that mm->mmap_lock is not being held
@@ -312,11 +332,16 @@ static void handle_remove(struct work_struct *work)
 						del_work);
 	struct list_head del_list;
 	unsigned long flags;
+	struct mmu_rb_node *node;
 
 	/* remove anything that is queued to get removed */
 	spin_lock_irqsave(&handler->lock, flags);
 	list_replace_init(&handler->del_list, &del_list);
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	do_remove(handler, &del_list);
+	while (!list_empty(&del_list)) {
+		node = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&node->list);
+		handler->ops->remove(handler->ops_arg, node);
+	}
 }
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 0265d81c6206..be85537d2326 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -57,6 +57,7 @@ struct mmu_rb_node {
 	struct rb_node node;
 	struct mmu_rb_handler *handler;
 	struct list_head list;
+	struct kref refcount;
 };
 
 /*
@@ -92,6 +93,8 @@ int hfi1_mmu_rb_register(void *ops_arg,
 void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
 int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		       struct mmu_rb_node *mnode);
+void hfi1_mmu_rb_release(struct kref *refcount);
+
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg);
 struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
 					  unsigned long addr,
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 061562627dae..2dc97de434a5 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1635,7 +1635,20 @@ static inline void sdma_unmap_desc(
 	struct hfi1_devdata *dd,
 	struct sdma_desc *descp)
 {
-	system_descriptor_complete(dd, descp);
+	switch (sdma_mapping_type(descp)) {
+	case SDMA_MAP_SINGLE:
+		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(descp),
+				 sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	case SDMA_MAP_PAGE:
+		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(descp),
+			       sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	}
+
+	if (descp->pinning_ctx && descp->ctx_put)
+		descp->ctx_put(descp->pinning_ctx);
+	descp->pinning_ctx = NULL;
 }
 
 /*
@@ -3155,8 +3168,8 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 
 		/* Add descriptor for coalesce buffer */
 		tx->desc_limit = MAX_DESC;
-		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx,
-					 addr, tx->tlen);
+		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx,
+					 addr, tx->tlen, NULL, NULL, NULL);
 	}
 
 	return 1;
@@ -3187,8 +3200,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	tx->num_desc++;
-	if ((unlikely(tx->num_desc == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
@@ -3200,9 +3212,10 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 	make_tx_sdma_desc(
 		tx,
 		SDMA_MAP_NONE,
-		NULL,
 		dd->sdma_pad_phys,
-		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
+		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)),
+		NULL, NULL, NULL);
+	tx->num_desc++;
 	_sdma_close_tx(dd, tx);
 	return rval;
 }
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 7d4f316ac6e4..7611f09d78dc 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -635,9 +635,11 @@ static inline dma_addr_t sdma_mapping_addr(struct sdma_desc *d)
 static inline void make_tx_sdma_desc(
 	struct sdma_txreq *tx,
 	int type,
-	void *pinning_ctx,
 	dma_addr_t addr,
-	size_t len)
+	size_t len,
+	void *pinning_ctx,
+	void (*ctx_get)(void *),
+	void (*ctx_put)(void *))
 {
 	struct sdma_desc *desc = &tx->descp[tx->num_desc];
 
@@ -654,7 +656,11 @@ static inline void make_tx_sdma_desc(
 				<< SDMA_DESC0_PHY_ADDR_SHIFT) |
 			(((u64)len & SDMA_DESC0_BYTE_COUNT_MASK)
 				<< SDMA_DESC0_BYTE_COUNT_SHIFT);
+
 	desc->pinning_ctx = pinning_ctx;
+	desc->ctx_put = ctx_put;
+	if (pinning_ctx && ctx_get)
+		ctx_get(pinning_ctx);
 }
 
 /* helper to extend txreq */
@@ -674,32 +680,34 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 				  struct sdma_txreq *tx)
 {
-	tx->descp[tx->num_desc].qw[0] |=
-		SDMA_DESC0_LAST_DESC_FLAG;
-	tx->descp[tx->num_desc].qw[1] |=
-		dd->default_desc1;
+	u16 last_desc = tx->num_desc - 1;
+
+	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
+	tx->descp[last_desc].qw[1] |= dd->default_desc1;
 	if (tx->flags & SDMA_TXREQ_F_URGENT)
-		tx->descp[tx->num_desc].qw[1] |=
-			(SDMA_DESC1_HEAD_TO_HOST_FLAG |
-			 SDMA_DESC1_INT_REQ_FLAG);
+		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
+					       SDMA_DESC1_INT_REQ_FLAG);
 }
 
 static inline int _sdma_txadd_daddr(
 	struct hfi1_devdata *dd,
 	int type,
-	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	dma_addr_t addr,
-	u16 len)
+	u16 len,
+	void *pinning_ctx,
+	void (*ctx_get)(void *),
+	void (*ctx_put)(void *))
 {
 	int rval = 0;
 
 	make_tx_sdma_desc(
 		tx,
 		type,
-		pinning_ctx,
-		addr, len);
+		addr, len,
+		pinning_ctx, ctx_get, ctx_put);
 	WARN_ON(len > tx->tlen);
+	tx->num_desc++;
 	tx->tlen -= len;
 	/* special cases for last */
 	if (!tx->tlen) {
@@ -711,18 +719,24 @@ static inline int _sdma_txadd_daddr(
 			_sdma_close_tx(dd, tx);
 		}
 	}
-	tx->num_desc++;
 	return rval;
 }
 
 /**
  * sdma_txadd_page() - add a page to the sdma_txreq
  * @dd: the device to use for mapping
- * @pinning_ctx: context to be released at descriptor retirement
  * @tx: tx request to which the page is added
  * @page: page to map
  * @offset: offset within the page
  * @len: length in bytes
+ * @pinning_ctx: context to be stored on struct sdma_desc .pinning_ctx. Not
+ *               added if coalesce buffer is used. E.g. pointer to pinned-page
+ *               cache entry for the sdma_desc.
+ * @ctx_get: optional function to take reference to @pinning_ctx. Not called if
+ *           @pinning_ctx is NULL.
+ * @ctx_put: optional function to release reference to @pinning_ctx after
+ *           sdma_desc completes. May be called in interrupt context so must
+ *           not sleep. Not called if @pinning_ctx is NULL.
  *
  * This is used to add a page/offset/length descriptor.
  *
@@ -734,11 +748,13 @@ static inline int _sdma_txadd_daddr(
  */
 static inline int sdma_txadd_page(
 	struct hfi1_devdata *dd,
-	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	struct page *page,
 	unsigned long offset,
-	u16 len)
+	u16 len,
+	void *pinning_ctx,
+	void (*ctx_get)(void *),
+	void (*ctx_put)(void *))
 {
 	dma_addr_t addr;
 	int rval;
@@ -762,7 +778,8 @@ static inline int sdma_txadd_page(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, pinning_ctx, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, tx, addr, len,
+				 pinning_ctx, ctx_get, ctx_put);
 }
 
 /**
@@ -796,8 +813,8 @@ static inline int sdma_txadd_daddr(
 			return rval;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, NULL, tx,
-				 addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len,
+				 NULL, NULL, NULL);
 }
 
 /**
@@ -843,7 +860,8 @@ static inline int sdma_txadd_kvaddr(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx, addr, len,
+				 NULL, NULL, NULL);
 }
 
 struct iowait_work;
@@ -1094,6 +1112,4 @@ u16 sdma_get_descq_cnt(void);
 extern uint mod_num_sdma;
 
 void sdma_update_lmc(struct hfi1_devdata *dd, u64 mask, u32 lid);
-
-void system_descriptor_complete(struct hfi1_devdata *dd, struct sdma_desc *descp);
 #endif
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index 4204650cebc2..fb091b5834b5 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -62,6 +62,8 @@ struct sdma_desc {
 	/* private:  don't use directly */
 	u64 qw[2];
 	void *pinning_ctx;
+	/* Release reference to @pinning_ctx. May be called in interrupt context. Must not sleep. */
+	void (*ctx_put)(void *ctx);
 };
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 1eb5a44a4ae6..a67791187d46 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -103,18 +103,14 @@ static int defer_packet_queue(
 static void activate_packet_queue(struct iowait *wait, int reason);
 static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
 			   unsigned long len);
-static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode);
 static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
 			 void *arg2, bool *stop);
 static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
-static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode);
 
 static struct mmu_rb_ops sdma_rb_ops = {
 	.filter = sdma_rb_filter,
-	.insert = sdma_rb_insert,
 	.evict = sdma_rb_evict,
 	.remove = sdma_rb_remove,
-	.invalidate = sdma_rb_invalidate
 };
 
 static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
@@ -202,9 +198,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	if (!pq->reqs)
 		goto pq_reqs_nomem;
 
-	pq->req_in_use = kcalloc(BITS_TO_LONGS(hfi1_sdma_comp_ring_size),
-				 sizeof(*pq->req_in_use),
-				 GFP_KERNEL);
+	pq->req_in_use = bitmap_zalloc(hfi1_sdma_comp_ring_size, GFP_KERNEL);
 	if (!pq->req_in_use)
 		goto pq_reqs_no_in_use;
 
@@ -251,7 +245,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 cq_nomem:
 	kmem_cache_destroy(pq->txreq_cache);
 pq_txreq_nomem:
-	kfree(pq->req_in_use);
+	bitmap_free(pq->req_in_use);
 pq_reqs_no_in_use:
 	kfree(pq->reqs);
 pq_reqs_nomem:
@@ -290,15 +284,15 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 		spin_unlock(&fd->pq_rcu_lock);
 		synchronize_srcu(&fd->pq_srcu);
 		/* at this point there can be no more new requests */
-		if (pq->handler)
-			hfi1_mmu_rb_unregister(pq->handler);
 		iowait_sdma_drain(&pq->busy);
 		/* Wait until all requests have been freed. */
 		wait_event_interruptible(
 			pq->wait,
 			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
-		kfree(pq->req_in_use);
+		if (pq->handler)
+			hfi1_mmu_rb_unregister(pq->handler);
+		bitmap_free(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		flush_pq_iowait(pq);
 		kfree(pq);
@@ -1318,25 +1312,17 @@ static void free_system_node(struct sdma_mmu_node *node)
 	kfree(node);
 }
 
-static inline void acquire_node(struct sdma_mmu_node *node)
-{
-	atomic_inc(&node->refcount);
-	WARN_ON(atomic_read(&node->refcount) < 0);
-}
-
-static inline void release_node(struct mmu_rb_handler *handler,
-				struct sdma_mmu_node *node)
-{
-	atomic_dec(&node->refcount);
-	WARN_ON(atomic_read(&node->refcount) < 0);
-}
-
+/*
+ * kref_get()'s an additional kref on the returned rb_node to prevent rb_node
+ * from being released until after rb_node is assigned to an SDMA descriptor
+ * (struct sdma_desc) under add_system_iovec_to_sdma_packet(), even if the
+ * virtual address range for rb_node is invalidated between now and then.
+ */
 static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
 					      unsigned long start,
 					      unsigned long end)
 {
 	struct mmu_rb_node *rb_node;
-	struct sdma_mmu_node *node;
 	unsigned long flags;
 
 	spin_lock_irqsave(&handler->lock, flags);
@@ -1345,11 +1331,12 @@ static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
 		spin_unlock_irqrestore(&handler->lock, flags);
 		return NULL;
 	}
-	node = container_of(rb_node, struct sdma_mmu_node, rb);
-	acquire_node(node);
+
+	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
+	kref_get(&rb_node->refcount);
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	return node;
+	return container_of(rb_node, struct sdma_mmu_node, rb);
 }
 
 static int pin_system_pages(struct user_sdma_request *req,
@@ -1398,6 +1385,13 @@ static int pin_system_pages(struct user_sdma_request *req,
 	return 0;
 }
 
+/*
+ * kref refcount on *node_p will be 2 on successful addition: one kref from
+ * kref_init() for mmu_rb_handler and one kref to prevent *node_p from being
+ * released until after *node_p is assigned to an SDMA descriptor (struct
+ * sdma_desc) under add_system_iovec_to_sdma_packet(), even if the virtual
+ * address range for *node_p is invalidated between now and then.
+ */
 static int add_system_pinning(struct user_sdma_request *req,
 			      struct sdma_mmu_node **node_p,
 			      unsigned long start, unsigned long len)
@@ -1411,6 +1405,12 @@ static int add_system_pinning(struct user_sdma_request *req,
 	if (!node)
 		return -ENOMEM;
 
+	/* First kref "moves" to mmu_rb_handler */
+	kref_init(&node->rb.refcount);
+
+	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
+	kref_get(&node->rb.refcount);
+
 	node->pq = pq;
 	ret = pin_system_pages(req, start, len, node, PFN_DOWN(len));
 	if (ret == 0) {
@@ -1474,15 +1474,15 @@ static int get_system_cache_entry(struct user_sdma_request *req,
 			return 0;
 		}
 
-		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->refcount %d",
-			 node->rb.addr, atomic_read(&node->refcount));
+		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->rb.refcount %d",
+			 node->rb.addr, kref_read(&node->rb.refcount));
 		prepend_len = node->rb.addr - start;
 
 		/*
 		 * This node will not be returned, instead a new node
 		 * will be. So release the reference.
 		 */
-		release_node(handler, node);
+		kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
 
 		/* Prepend a node to cover the beginning of the allocation */
 		ret = add_system_pinning(req, node_p, start, prepend_len);
@@ -1494,6 +1494,20 @@ static int get_system_cache_entry(struct user_sdma_request *req,
 	}
 }
 
+static void sdma_mmu_rb_node_get(void *ctx)
+{
+	struct mmu_rb_node *node = ctx;
+
+	kref_get(&node->refcount);
+}
+
+static void sdma_mmu_rb_node_put(void *ctx)
+{
+	struct sdma_mmu_node *node = ctx;
+
+	kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
+}
+
 static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
 				      struct user_sdma_txreq *tx,
 				      struct sdma_mmu_node *cache_entry,
@@ -1537,9 +1551,12 @@ static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
 			ctx = cache_entry;
 		}
 
-		ret = sdma_txadd_page(pq->dd, ctx, &tx->txreq,
+		ret = sdma_txadd_page(pq->dd, &tx->txreq,
 				      cache_entry->pages[page_index],
-				      page_offset, from_this_page);
+				      page_offset, from_this_page,
+				      ctx,
+				      sdma_mmu_rb_node_get,
+				      sdma_mmu_rb_node_put);
 		if (ret) {
 			/*
 			 * When there's a failure, the entire request is freed by
@@ -1561,8 +1578,6 @@ static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
 					   struct user_sdma_iovec *iovec,
 					   size_t from_this_iovec)
 {
-	struct mmu_rb_handler *handler = req->pq->handler;
-
 	while (from_this_iovec > 0) {
 		struct sdma_mmu_node *cache_entry;
 		size_t from_this_cache_entry;
@@ -1583,15 +1598,15 @@ static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
 
 		ret = add_mapping_to_sdma_packet(req, tx, cache_entry, start,
 						 from_this_cache_entry);
+
+		/*
+		 * Done adding cache_entry to zero or more sdma_desc. Can
+		 * kref_put() the "safety" kref taken under
+		 * get_system_cache_entry().
+		 */
+		kref_put(&cache_entry->rb.refcount, hfi1_mmu_rb_release);
+
 		if (ret) {
-			/*
-			 * We're guaranteed that there will be no descriptor
-			 * completion callback that releases this node
-			 * because only the last descriptor referencing it
-			 * has a context attached, and a failure means the
-			 * last descriptor was never added.
-			 */
-			release_node(handler, cache_entry);
 			SDMA_DBG(req, "add system segment failed %d", ret);
 			return ret;
 		}
@@ -1642,42 +1657,12 @@ static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
 	return 0;
 }
 
-void system_descriptor_complete(struct hfi1_devdata *dd,
-				struct sdma_desc *descp)
-{
-	switch (sdma_mapping_type(descp)) {
-	case SDMA_MAP_SINGLE:
-		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(descp),
-				 sdma_mapping_len(descp), DMA_TO_DEVICE);
-		break;
-	case SDMA_MAP_PAGE:
-		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(descp),
-			       sdma_mapping_len(descp), DMA_TO_DEVICE);
-		break;
-	}
-
-	if (descp->pinning_ctx) {
-		struct sdma_mmu_node *node = descp->pinning_ctx;
-
-		release_node(node->rb.handler, node);
-	}
-}
-
 static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
 			   unsigned long len)
 {
 	return (bool)(node->addr == addr);
 }
 
-static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-
-	atomic_inc(&node->refcount);
-	return 0;
-}
-
 /*
  * Return 1 to remove the node from the rb tree and call the remove op.
  *
@@ -1690,10 +1675,6 @@ static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
 		container_of(mnode, struct sdma_mmu_node, rb);
 	struct evict_data *evict_data = evict_arg;
 
-	/* is this node still being used? */
-	if (atomic_read(&node->refcount))
-		return 0; /* keep this node */
-
 	/* this node will be evicted, add its pages to our count */
 	evict_data->cleared += node->npages;
 
@@ -1711,13 +1692,3 @@ static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
 
 	free_system_node(node);
 }
-
-static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-
-	if (!atomic_read(&node->refcount))
-		return 1;
-	return 0;
-}
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 9d417aacfa8b..b2b26b71fcef 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -145,7 +145,6 @@ struct hfi1_user_sdma_comp_q {
 struct sdma_mmu_node {
 	struct mmu_rb_node rb;
 	struct hfi1_user_sdma_pkt_q *pq;
-	atomic_t refcount;
 	struct page **pages;
 	unsigned int npages;
 };
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index 7658c620a125..ab8bcdf10447 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -106,11 +106,11 @@ static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
 
 		/* combine physically continuous fragments later? */
 		ret = sdma_txadd_page(sde->dd,
-				      NULL,
 				      &tx->txreq,
 				      skb_frag_page(frag),
 				      skb_frag_off(frag),
-				      skb_frag_size(frag));
+				      skb_frag_size(frag),
+				      NULL, NULL, NULL);
 		if (unlikely(ret))
 			goto bail_txadd;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 455d533dd7c4..c493d7644b57 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -36,9 +36,9 @@
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 
-#define CMD_POLL_TOKEN		0xffff
-#define CMD_MAX_NUM		32
-#define CMD_TOKEN_MASK		0x1f
+#define CMD_POLL_TOKEN 0xffff
+#define CMD_MAX_NUM 32
+#define CMD_TOKEN_MASK 0x1f
 
 static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 				     u64 out_param, u32 in_modifier,
@@ -93,8 +93,8 @@ static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 			u64 out_param)
 {
-	struct hns_roce_cmd_context
-		*context = &hr_dev->cmd.context[token & hr_dev->cmd.token_mask];
+	struct hns_roce_cmd_context *context =
+		&hr_dev->cmd.context[token % hr_dev->cmd.max_cmds];
 
 	if (token != context->token)
 		return;
@@ -164,8 +164,8 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	int ret;
 
 	down(&hr_dev->cmd.event_sem);
-	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
-				       in_modifier, op_modifier, op, timeout);
+	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param, in_modifier,
+				       op_modifier, op, timeout);
 	up(&hr_dev->cmd.event_sem);
 
 	return ret;
@@ -231,9 +231,8 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
 	int i;
 
-	hr_cmd->context = kmalloc_array(hr_cmd->max_cmds,
-					sizeof(*hr_cmd->context),
-					GFP_KERNEL);
+	hr_cmd->context =
+		kcalloc(hr_cmd->max_cmds, sizeof(*hr_cmd->context), GFP_KERNEL);
 	if (!hr_cmd->context)
 		return -ENOMEM;
 
@@ -262,8 +261,8 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)
 	hr_cmd->use_events = 0;
 }
 
-struct hns_roce_cmd_mailbox
-	*hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
+struct hns_roce_cmd_mailbox *
+hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 
@@ -271,8 +270,8 @@ struct hns_roce_cmd_mailbox
 	if (!mailbox)
 		return ERR_PTR(-ENOMEM);
 
-	mailbox->buf = dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL,
-				      &mailbox->dma);
+	mailbox->buf =
+		dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL, &mailbox->dma);
 	if (!mailbox->buf) {
 		kfree(mailbox);
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 1915bacaded0..8e63b827f28c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -143,8 +143,8 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
 		      unsigned long timeout);
 
-struct hns_roce_cmd_mailbox
-	*hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
+struct hns_roce_cmd_mailbox *
+hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
 void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmd_mailbox *mailbox);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 8a6bded9c11c..9200e6477e1e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -41,9 +41,9 @@
 
 static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_cq_table *cq_table;
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle;
 	int ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d9aa7424d290..09b5e4935c2c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -46,8 +46,6 @@
 
 #define HNS_ROCE_IB_MIN_SQ_STRIDE		6
 
-#define HNS_ROCE_BA_SIZE			(32 * 4096)
-
 #define BA_BYTE_LEN				8
 
 /* Hardware specification only for v1 engine */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c880a8be7e3c..854b41c14774 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -36,9 +36,6 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_common.h"
 
-#define DMA_ADDR_T_SHIFT		12
-#define BT_BA_SHIFT			32
-
 #define HEM_INDEX_BUF			BIT(0)
 #define HEM_INDEX_L0			BIT(1)
 #define HEM_INDEX_L1			BIT(2)
@@ -198,9 +195,9 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 {
 	struct device *dev = hr_dev->dev;
 	u32 chunk_ba_num;
+	u32 chunk_size;
 	u32 table_idx;
 	u32 bt_num;
-	u32 chunk_size;
 
 	if (get_hem_table_config(hr_dev, mhop, table->type))
 		return -EINVAL;
@@ -260,7 +257,6 @@ static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
 	if (!hem)
 		return NULL;
 
-	hem->refcount = 0;
 	INIT_LIST_HEAD(&hem->chunk_list);
 
 	order = get_order(hem_alloc_size);
@@ -327,81 +323,6 @@ void hns_roce_free_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem *hem)
 	kfree(hem);
 }
 
-static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_hem_table *table, unsigned long obj)
-{
-	spinlock_t *lock = &hr_dev->bt_cmd_lock;
-	struct device *dev = hr_dev->dev;
-	long end;
-	unsigned long flags;
-	struct hns_roce_hem_iter iter;
-	void __iomem *bt_cmd;
-	__le32 bt_cmd_val[2];
-	__le32 bt_cmd_h = 0;
-	__le32 bt_cmd_l;
-	u64 bt_ba;
-	int ret = 0;
-
-	/* Find the HEM(Hardware Entry Memory) entry */
-	unsigned long i = (obj & (table->num_obj - 1)) /
-			  (table->table_chunk_size / table->obj_size);
-
-	switch (table->type) {
-	case HEM_TYPE_QPC:
-	case HEM_TYPE_MTPT:
-	case HEM_TYPE_CQC:
-	case HEM_TYPE_SRQC:
-		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
-		break;
-	default:
-		return ret;
-	}
-
-	roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
-		       ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
-	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
-	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
-
-	/* Currently iter only a chunk */
-	for (hns_roce_hem_first(table->hem[i], &iter);
-	     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
-		bt_ba = hns_roce_hem_addr(&iter) >> DMA_ADDR_T_SHIFT;
-
-		spin_lock_irqsave(lock, flags);
-
-		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
-
-		end = HW_SYNC_TIMEOUT_MSECS;
-		while (end > 0) {
-			if (!(readl(bt_cmd) >> BT_CMD_SYNC_SHIFT))
-				break;
-
-			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
-			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
-		}
-
-		if (end <= 0) {
-			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
-			spin_unlock_irqrestore(lock, flags);
-			return -EBUSY;
-		}
-
-		bt_cmd_l = cpu_to_le32(bt_ba);
-		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
-			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S,
-			       bt_ba >> BT_BA_SHIFT);
-
-		bt_cmd_val[0] = bt_cmd_l;
-		bt_cmd_val[1] = bt_cmd_h;
-		hns_roce_write64_k(bt_cmd_val,
-				   hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
-		spin_unlock_irqrestore(lock, flags);
-	}
-
-	return ret;
-}
-
 static int calc_hem_config(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_hem_table *table, unsigned long obj,
 			   struct hns_roce_hem_mhop *mhop,
@@ -607,7 +528,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 
 	mutex_lock(&table->mutex);
 	if (table->hem[index.buf]) {
-		++table->hem[index.buf]->refcount;
+		refcount_inc(&table->hem[index.buf]->refcount);
 		goto out;
 	}
 
@@ -626,7 +547,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	++table->hem[index.buf]->refcount;
+	refcount_set(&table->hem[index.buf]->refcount, 1);
 	goto out;
 
 err_alloc:
@@ -640,8 +561,8 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 		       struct hns_roce_hem_table *table, unsigned long obj)
 {
 	struct device *dev = hr_dev->dev;
-	int ret = 0;
 	unsigned long i;
+	int ret = 0;
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type))
 		return hns_roce_table_mhop_get(hr_dev, table, obj);
@@ -652,7 +573,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	mutex_lock(&table->mutex);
 
 	if (table->hem[i]) {
-		++table->hem[i]->refcount;
+		refcount_inc(&table->hem[i]->refcount);
 		goto out;
 	}
 
@@ -667,15 +588,16 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Set HEM base address(128K/page, pa) to Hardware */
-	if (hns_roce_set_hem(hr_dev, table, obj)) {
+	ret = hr_dev->hw->set_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT);
+	if (ret) {
 		hns_roce_free_hem(hr_dev, table->hem[i]);
 		table->hem[i] = NULL;
-		ret = -ENODEV;
-		dev_err(dev, "set HEM base address to HW failed.\n");
+		dev_err(dev, "set HEM base address to HW failed, ret = %d.\n",
+			ret);
 		goto out;
 	}
 
-	++table->hem[i]->refcount;
+	refcount_set(&table->hem[i]->refcount, 1);
 out:
 	mutex_unlock(&table->mutex);
 	return ret;
@@ -742,11 +664,11 @@ static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 		return;
 	}
 
-	mutex_lock(&table->mutex);
-	if (check_refcount && (--table->hem[index.buf]->refcount > 0)) {
-		mutex_unlock(&table->mutex);
+	if (!check_refcount)
+		mutex_lock(&table->mutex);
+	else if (!refcount_dec_and_mutex_lock(&table->hem[index.buf]->refcount,
+					      &table->mutex))
 		return;
-	}
 
 	clear_mhop_hem(hr_dev, table, obj, &mhop, &index);
 	free_mhop_hem(hr_dev, table, &mhop, &index);
@@ -768,16 +690,15 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 	i = (obj & (table->num_obj - 1)) /
 	    (table->table_chunk_size / table->obj_size);
 
-	mutex_lock(&table->mutex);
+	if (!refcount_dec_and_mutex_lock(&table->hem[i]->refcount,
+					 &table->mutex))
+		return;
 
-	if (--table->hem[i]->refcount == 0) {
-		/* Clear HEM base address */
-		if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
-			dev_warn(dev, "Clear HEM base address failed.\n");
+	if (hr_dev->hw->clear_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT))
+		dev_warn(dev, "failed to clear HEM base address.\n");
 
-		hns_roce_free_hem(hr_dev, table->hem[i]);
-		table->hem[i] = NULL;
-	}
+	hns_roce_free_hem(hr_dev, table->hem[i]);
+	table->hem[i] = NULL;
 
 	mutex_unlock(&table->mutex);
 }
@@ -789,14 +710,14 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	struct hns_roce_hem_chunk *chunk;
 	struct hns_roce_hem_mhop mhop;
 	struct hns_roce_hem *hem;
-	void *addr = NULL;
 	unsigned long mhop_obj = obj;
 	unsigned long obj_per_chunk;
 	unsigned long idx_offset;
 	int offset, dma_offset;
+	void *addr = NULL;
+	u32 hem_idx = 0;
 	int length;
 	int i, j;
-	u32 hem_idx = 0;
 
 	if (!table->lowmem)
 		return NULL;
@@ -966,8 +887,8 @@ static void hns_roce_cleanup_mhop_hem_table(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_hem_mhop mhop;
 	u32 buf_chunk_size;
-	int i;
 	u64 obj;
+	int i;
 
 	if (hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop))
 		return;
@@ -1298,8 +1219,8 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 				  const struct hns_roce_buf_region *regions,
 				  int region_cnt)
 {
-	struct roce_hem_item *hem, *temp_hem, *root_hem;
 	struct list_head temp_list[HNS_ROCE_MAX_BT_REGION];
+	struct roce_hem_item *hem, *temp_hem, *root_hem;
 	const struct hns_roce_buf_region *r;
 	struct list_head temp_root;
 	struct list_head temp_btm;
@@ -1404,8 +1325,8 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
-	int ret;
 	int unit;
+	int ret;
 	int i;
 
 	if (region_cnt > HNS_ROCE_MAX_BT_REGION) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index b34c940077bb..b7617786b100 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -34,9 +34,7 @@
 #ifndef _HNS_ROCE_HEM_H
 #define _HNS_ROCE_HEM_H
 
-#define HW_SYNC_SLEEP_TIME_INTERVAL	20
-#define HW_SYNC_TIMEOUT_MSECS           (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
-#define BT_CMD_SYNC_SHIFT		31
+#define HEM_HOP_STEP_DIRECT 0xff
 
 enum {
 	/* MAP HEM(Hardware Entry Memory) */
@@ -73,11 +71,6 @@ enum {
 	(type >= HEM_TYPE_MTT && hop_num == 1) || \
 	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
 
-enum {
-	 HNS_ROCE_HEM_PAGE_SHIFT = 12,
-	 HNS_ROCE_HEM_PAGE_SIZE  = 1 << HNS_ROCE_HEM_PAGE_SHIFT,
-};
-
 struct hns_roce_hem_chunk {
 	struct list_head	 list;
 	int			 npages;
@@ -87,8 +80,8 @@ struct hns_roce_hem_chunk {
 };
 
 struct hns_roce_hem {
-	struct list_head	 chunk_list;
-	int			 refcount;
+	struct list_head chunk_list;
+	refcount_t refcount;
 };
 
 struct hns_roce_hem_iter {
@@ -174,4 +167,4 @@ static inline dma_addr_t hns_roce_hem_addr(struct hns_roce_hem_iter *iter)
 	return sg_dma_address(&iter->chunk->mem[iter->page_idx]);
 }
 
-#endif /*_HNS_ROCE_HEM_H*/
+#endif /* _HNS_ROCE_HEM_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5f4d8a32ed6d..6f9b024d4ff7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -239,7 +239,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				break;
 			}
 
-			/*Ctrl field, ctrl set type: sig, solic, imm, fence */
+			/* Ctrl field, ctrl set type: sig, solic, imm, fence */
 			/* SO wait for conforming application scenarios */
 			ctrl->flag |= (wr->send_flags & IB_SEND_SIGNALED ?
 				      cpu_to_le32(HNS_ROCE_WQE_CQ_NOTIFY) : 0) |
@@ -300,7 +300,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				}
 				ctrl->flag |= cpu_to_le32(HNS_ROCE_WQE_INLINE);
 			} else {
-				/*sqe num is two */
+				/* sqe num is two */
 				for (i = 0; i < wr->num_sge; i++)
 					set_data_seg(dseg + i, wr->sg_list + i);
 
@@ -450,6 +450,82 @@ static void hns_roce_set_db_event_mode(struct hns_roce_dev *hr_dev,
 	roce_write(hr_dev, ROCEE_GLB_CFG_REG, val);
 }
 
+static int hns_roce_v1_set_hem(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_hem_table *table, int obj,
+			       int step_idx)
+{
+	spinlock_t *lock = &hr_dev->bt_cmd_lock;
+	struct device *dev = hr_dev->dev;
+	struct hns_roce_hem_iter iter;
+	void __iomem *bt_cmd;
+	__le32 bt_cmd_val[2];
+	__le32 bt_cmd_h = 0;
+	unsigned long flags;
+	__le32 bt_cmd_l;
+	int ret = 0;
+	u64 bt_ba;
+	long end;
+
+	/* Find the HEM(Hardware Entry Memory) entry */
+	unsigned long i = (obj & (table->num_obj - 1)) /
+			  (table->table_chunk_size / table->obj_size);
+
+	switch (table->type) {
+	case HEM_TYPE_QPC:
+	case HEM_TYPE_MTPT:
+	case HEM_TYPE_CQC:
+	case HEM_TYPE_SRQC:
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
+			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
+		break;
+	default:
+		return ret;
+	}
+
+	roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
+		       ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
+
+	/* Currently iter only a chunk */
+	for (hns_roce_hem_first(table->hem[i], &iter);
+	     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
+		bt_ba = hns_roce_hem_addr(&iter) >> HNS_HW_PAGE_SHIFT;
+
+		spin_lock_irqsave(lock, flags);
+
+		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
+
+		end = HW_SYNC_TIMEOUT_MSECS;
+		while (end > 0) {
+			if (!(readl(bt_cmd) >> BT_CMD_SYNC_SHIFT))
+				break;
+
+			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
+			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
+		}
+
+		if (end <= 0) {
+			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
+			spin_unlock_irqrestore(lock, flags);
+			return -EBUSY;
+		}
+
+		bt_cmd_l = cpu_to_le32(bt_ba);
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
+			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S,
+			       upper_32_bits(bt_ba));
+
+		bt_cmd_val[0] = bt_cmd_l;
+		bt_cmd_val[1] = bt_cmd_h;
+		hns_roce_write64_k(bt_cmd_val,
+				   hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
+		spin_unlock_irqrestore(lock, flags);
+	}
+
+	return ret;
+}
+
 static void hns_roce_set_db_ext_mode(struct hns_roce_dev *hr_dev, u32 sdb_mode,
 				     u32 odb_mode)
 {
@@ -1165,7 +1241,7 @@ static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 	}
 	raq->e_raq_buf->map = addr;
 
-	/* Configure raq extended address. 48bit 4K align*/
+	/* Configure raq extended address. 48bit 4K align */
 	roce_write(hr_dev, ROCEE_EXT_RAQ_REG, raq->e_raq_buf->map >> 12);
 
 	/* Configure raq_shift */
@@ -2062,11 +2138,6 @@ static void hns_roce_v1_write_cqc(struct hns_roce_dev *hr_dev,
 		       CQ_CONTEXT_CQC_BYTE_32_CQ_CONS_IDX_S, 0);
 }
 
-static int hns_roce_v1_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
-{
-	return -EOPNOTSUPP;
-}
-
 static int hns_roce_v1_req_notify_cq(struct ib_cq *ibcq,
 				     enum ib_cq_notify_flags flags)
 {
@@ -2765,7 +2836,6 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		roce_set_field(context->qpc_bytes_16,
 			       QP_CONTEXT_QPC_BYTES_16_QP_NUM_M,
 			       QP_CONTEXT_QPC_BYTES_16_QP_NUM_S, hr_qp->qpn);
-
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
 		roce_set_field(context->qpc_bytes_4,
 			       QP_CONTEXT_QPC_BYTES_4_TRANSPORT_SERVICE_TYPE_M,
@@ -3798,7 +3868,6 @@ static int hns_roce_v1_aeq_int(struct hns_roce_dev *hr_dev,
 	int event_type;
 
 	while ((aeqe = next_aeqe_sw_v1(eq))) {
-
 		/* Make sure we read the AEQ entry after we have checked the
 		 * ownership bit
 		 */
@@ -3903,7 +3972,6 @@ static int hns_roce_v1_ceq_int(struct hns_roce_dev *hr_dev,
 	u32 cqn;
 
 	while ((ceqe = next_ceqe_sw_v1(eq))) {
-
 		/* Make sure we read CEQ entry after we have checked the
 		 * ownership bit
 		 */
@@ -4347,7 +4415,6 @@ static void hns_roce_v1_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 
 static const struct ib_device_ops hns_roce_v1_dev_ops = {
 	.destroy_qp = hns_roce_v1_destroy_qp,
-	.modify_cq = hns_roce_v1_modify_cq,
 	.poll_cq = hns_roce_v1_poll_cq,
 	.post_recv = hns_roce_v1_post_recv,
 	.post_send = hns_roce_v1_post_send,
@@ -4367,7 +4434,7 @@ static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.set_mtu = hns_roce_v1_set_mtu,
 	.write_mtpt = hns_roce_v1_write_mtpt,
 	.write_cqc = hns_roce_v1_write_cqc,
-	.modify_cq = hns_roce_v1_modify_cq,
+	.set_hem = hns_roce_v1_set_hem,
 	.clear_hem = hns_roce_v1_clear_hem,
 	.modify_qp = hns_roce_v1_modify_qp,
 	.query_qp = hns_roce_v1_query_qp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
index ffd0156080f5..9ff1a41ddec3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
@@ -419,7 +419,7 @@ struct hns_roce_wqe_data_seg {
 
 struct hns_roce_wqe_raddr_seg {
 	__le32 rkey;
-	__le32 len;/* reserved */
+	__le32 len; /* reserved */
 	__le64 raddr;
 };
 
@@ -1042,6 +1042,11 @@ struct hns_roce_db_table {
 	struct hns_roce_ext_db *ext_db;
 };
 
+#define HW_SYNC_SLEEP_TIME_INTERVAL 20
+#define HW_SYNC_TIMEOUT_MSECS (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
+#define BT_CMD_SYNC_SHIFT 31
+#define HNS_ROCE_BA_SIZE (32 * 4096)
+
 struct hns_roce_bt_table {
 	struct hns_roce_buf_list qpc_buf;
 	struct hns_roce_buf_list mtpt_buf;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 76ed547b76ea..322f341f4145 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1028,8 +1028,8 @@ static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
-	unsigned long instance_stage;	/* the current instance stage */
-	unsigned long reset_stage;	/* the current reset stage */
+	unsigned long instance_stage; /* the current instance stage */
+	unsigned long reset_stage; /* the current reset stage */
 	unsigned long reset_cnt;
 	bool sw_resetting;
 	bool hw_resetting;
@@ -2434,7 +2434,6 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 		if (i < (pg_num - 1))
 			entry[i].blk_ba1_nxt_ptr |=
 				(i + 1) << HNS_ROCE_LINK_TABLE_NXT_PTR_S;
-
 	}
 	link_tbl->npages = pg_num;
 	link_tbl->pg_sz = buf_chk_sz;
@@ -5540,16 +5539,14 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
 			hns_roce_cq_event(hr_dev, cqn, event_type);
 			break;
-		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
-			break;
 		case HNS_ROCE_EVENT_TYPE_MB:
 			hns_roce_cmd_event(hr_dev,
 					le16_to_cpu(aeqe->event.cmd.token),
 					aeqe->event.cmd.status,
 					le64_to_cpu(aeqe->event.cmd.out_param));
 			break;
+		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
 		case HNS_ROCE_EVENT_TYPE_CEQ_OVERFLOW:
-			break;
 		case HNS_ROCE_EVENT_TYPE_FLR:
 			break;
 		default:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 8a92faeb3d23..8948d2b5577d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -440,7 +440,7 @@ struct hns_roce_srq_context {
 #define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_S 1
 #define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_M GENMASK(31, 1)
 
-enum{
+enum {
 	V2_MPT_ST_VALID = 0x1,
 	V2_MPT_ST_FREE	= 0x2,
 };
@@ -1076,9 +1076,9 @@ struct hns_roce_v2_ud_send_wqe {
 	__le32	dmac;
 	__le32	byte_48;
 	u8	dgid[GID_LEN_V2];
-
 };
-#define	V2_UD_SEND_WQE_BYTE_4_OPCODE_S 0
+
+#define V2_UD_SEND_WQE_BYTE_4_OPCODE_S 0
 #define V2_UD_SEND_WQE_BYTE_4_OPCODE_M GENMASK(4, 0)
 
 #define	V2_UD_SEND_WQE_BYTE_4_OWNER_S 7
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1e8b3e4ef1b1..90cbd15f6441 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -511,8 +511,6 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		(1ULL << IB_USER_VERBS_CMD_QUERY_QP) |
 		(1ULL << IB_USER_VERBS_CMD_DESTROY_QP);
 
-	ib_dev->uverbs_ex_cmd_mask |= (1ULL << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
-
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
 		ib_dev->uverbs_cmd_mask |= (1ULL << IB_USER_VERBS_CMD_REREG_MR);
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
@@ -584,8 +582,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table,
 				      HEM_TYPE_MTPT, hr_dev->caps.mtpt_entry_sz,
@@ -725,8 +723,8 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
  */
 static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	spin_lock_init(&hr_dev->sm_lock);
 	spin_lock_init(&hr_dev->bt_cmd_lock);
@@ -849,8 +847,8 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
 
 int hns_roce_init(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	if (hr_dev->hw->reset) {
 		ret = hr_dev->hw->reset(hr_dev, true);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 1c342a7bd7df..d5b3b10e0a80 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -167,10 +167,10 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_mr *mr)
 {
-	int ret;
 	unsigned long mtpt_idx = key_to_hw_index(mr->key);
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
+	struct device *dev = hr_dev->dev;
+	int ret;
 
 	/* Allocate mailbox memory */
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6fe98af7741b..c42c6761382d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -114,8 +114,8 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 				 enum hns_roce_event type)
 {
-	struct ib_event event;
 	struct ib_qp *ibqp = &hr_qp->ibqp;
+	struct ib_event event;
 
 	if (ibqp->event_handler) {
 		event.device = ibqp->device;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 08df97e0a665..02e2416b5fed 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -245,7 +245,6 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 			err = -ENOMEM;
 			goto err_idx_mtr;
 		}
-
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 05c7200751e5..c62cdd645696 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2682,8 +2682,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE) |
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ) |
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
 
@@ -2691,15 +2689,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	    ((mlx4_ib_port_link_layer(&ibdev->ib_dev, 1) ==
 	    IB_LINK_LAYER_ETHERNET) ||
 	    (mlx4_ib_port_link_layer(&ibdev->ib_dev, 2) ==
-	    IB_LINK_LAYER_ETHERNET))) {
-		ibdev->ib_dev.uverbs_ex_cmd_mask |=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
+	    IB_LINK_LAYER_ETHERNET)))
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_wq_ops);
-	}
 
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_MEM_WINDOW ||
 	    dev->caps.bmme_flags & MLX4_BMME_FLAG_TYPE_2_WIN) {
@@ -2718,9 +2709,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 	if (check_flow_steering_support(dev)) {
 		ibdev->steering_support = MLX4_STEERING_MODE_DEVICE_MANAGED;
-		ibdev->ib_dev.uverbs_ex_cmd_mask	|=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fs_ops);
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 39ba7005f2c4..215d6618839b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4180,14 +4180,10 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
 		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ)		|
 		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
-	dev->ib_dev.uverbs_ex_cmd_mask =
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE)	|
+	dev->ib_dev.uverbs_ex_cmd_mask |=
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ)	|
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW)	|
-		(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
+		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP);
 
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
 	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
@@ -4290,12 +4286,6 @@ static int mlx5_ib_roce_init(struct mlx5_ib_dev *dev)
 	ll = mlx5_port_type_cap_to_rdma_ll(port_type_cap);
 
 	if (ll == IB_LINK_LAYER_ETHERNET) {
-		dev->ib_dev.uverbs_ex_cmd_mask |=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_common_roce_ops);
 
 		port_num = mlx5_core_native_port_num(dev->mdev) - 1;
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 4cc4e8ff42b3..ad035c342cd3 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -811,8 +811,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	AC_WRITE(ac, POWER_CTL, 0);
 
 	err = request_threaded_irq(ac->irq, NULL, adxl34x_irq,
-				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-				   dev_name(dev), ac);
+				   IRQF_ONESHOT, dev_name(dev), ac);
 	if (err) {
 		dev_err(dev, "irq %d busy?\n", ac->irq);
 		goto err_free_mem;
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 79d7fa710a71..54002d1a446b 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -435,6 +435,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 	}
 
 	do {
+		usleep_range(15000, 15500);
 		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
 		if (error) {
 			dev_err(&haptics->client->dev,
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 033bccb41455..b9dcc8e78c75 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int ret;
 
 	pr_info("Initializing J-Core AIC\n");
 
@@ -100,11 +101,17 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";
 
-	domain = irq_domain_add_linear(node, dom_sz, &jcore_aic_irqdomain_ops,
+	ret = irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
+			      of_node_to_nid(node));
+
+	if (ret < 0)
+		return ret;
+
+	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
+				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
 	if (!domain)
 		return -ENOMEM;
-	irq_create_strict_mappings(domain, min_irq, min_irq, dom_sz - min_irq);
 
 	return 0;
 }
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index d5e774d83021..f4d670ec30bc 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -318,6 +318,9 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	clear_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
 	switch (evt) {
 	case NETDEV_CHANGENAME:
+		if (netif_carrier_ok(dev))
+			set_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
+		fallthrough;
 	case NETDEV_REGISTER:
 		if (trigger_data->net_dev)
 			dev_put(trigger_data->net_dev);
diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 0130628f4d9d..535fe73ce310 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -385,14 +385,20 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 		/* Ensure all unused data is 0 */
 		data_trail &= 0xFFFFFFFF >> (8 * (sizeof(u32) - trail_bytes));
 		writel(data_trail, data_reg);
-		data_reg++;
+		data_reg += sizeof(u32);
 	}
+
 	/*
 	 * 'data_reg' indicates next register to write. If we did not already
 	 * write on tx complete reg(last reg), we must do so for transmit
+	 * In addition, we also need to make sure all intermediate data
+	 * registers(if any required), are reset to 0 for TISCI backward
+	 * compatibility to be maintained.
 	 */
-	if (data_reg <= qinst->queue_buff_end)
-		writel(0, qinst->queue_buff_end);
+	while (data_reg <= qinst->queue_buff_end) {
+		writel(0, data_reg);
+		data_reg += sizeof(u32);
+	}
 
 	return 0;
 }
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index b47c00dea0f2..24c57bb85b35 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -885,7 +885,7 @@ static struct btree *mca_cannibalize(struct cache_set *c, struct btree_op *op,
  * cannibalize_bucket() will take. This means every time we unlock the root of
  * the btree, we need to release this lock if we have it held.
  */
-static void bch_cannibalize_unlock(struct cache_set *c)
+void bch_cannibalize_unlock(struct cache_set *c)
 {
 	spin_lock(&c->btree_cannibalize_lock);
 	if (c->btree_cache_alloc_lock == current) {
@@ -1090,10 +1090,12 @@ struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 				     struct btree *parent)
 {
 	BKEY_PADDED(key) k;
-	struct btree *b = ERR_PTR(-EAGAIN);
+	struct btree *b;
 
 	mutex_lock(&c->bucket_lock);
 retry:
+	/* return ERR_PTR(-EAGAIN) when it fails */
+	b = ERR_PTR(-EAGAIN);
 	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, wait))
 		goto err;
 
@@ -1138,7 +1140,7 @@ static struct btree *btree_node_alloc_replacement(struct btree *b,
 {
 	struct btree *n = bch_btree_node_alloc(b->c, op, b->level, b->parent);
 
-	if (!IS_ERR_OR_NULL(n)) {
+	if (!IS_ERR(n)) {
 		mutex_lock(&n->write_lock);
 		bch_btree_sort_into(&b->keys, &n->keys, &b->c->sort);
 		bkey_copy_key(&n->key, &b->key);
@@ -1340,7 +1342,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;
@@ -1352,7 +1354,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 
 	for (i = 0; i < nodes; i++) {
 		new_nodes[i] = btree_node_alloc_replacement(r[i].b, NULL);
-		if (IS_ERR_OR_NULL(new_nodes[i]))
+		if (IS_ERR(new_nodes[i]))
 			goto out_nocoalesce;
 	}
 
@@ -1487,7 +1489,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	bch_keylist_free(&keylist);
 
 	for (i = 0; i < nodes; i++)
-		if (!IS_ERR_OR_NULL(new_nodes[i])) {
+		if (!IS_ERR(new_nodes[i])) {
 			btree_node_free(new_nodes[i]);
 			rw_unlock(true, new_nodes[i]);
 		}
@@ -1669,7 +1671,7 @@ static int bch_btree_gc_root(struct btree *b, struct btree_op *op,
 	if (should_rewrite) {
 		n = btree_node_alloc_replacement(b, NULL);
 
-		if (!IS_ERR_OR_NULL(n)) {
+		if (!IS_ERR(n)) {
 			bch_btree_node_write_sync(n);
 
 			bch_btree_set_root(n);
@@ -1968,6 +1970,15 @@ static int bch_btree_check_thread(void *arg)
 			c->gc_stats.nodes++;
 			bch_btree_op_init(&op, 0);
 			ret = bcache_btree(check_recurse, p, c->root, &op);
+			/*
+			 * The op may be added to cache_set's btree_cache_wait
+			 * in mca_cannibalize(), must ensure it is removed from
+			 * the list and release btree_cache_alloc_lock before
+			 * free op memory.
+			 * Otherwise, the btree_cache_wait will be damaged.
+			 */
+			bch_cannibalize_unlock(c);
+			finish_wait(&c->btree_cache_wait, &(&op)->wait);
 			if (ret)
 				goto out;
 		}
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index 1b5fdbc0d83e..a2920bbfcad5 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -282,6 +282,7 @@ void bch_initial_gc_finish(struct cache_set *c);
 void bch_moving_gc(struct cache_set *c);
 int bch_btree_check(struct cache_set *c);
 void bch_initial_mark_key(struct cache_set *c, int level, struct bkey *k);
+void bch_cannibalize_unlock(struct cache_set *c);
 
 static inline void wake_up_gc(struct cache_set *c)
 {
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 7f5ea2509643..e8c8077667f9 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1748,7 +1748,7 @@ static void cache_set_flush(struct closure *cl)
 	if (!IS_ERR_OR_NULL(c->gc_thread))
 		kthread_stop(c->gc_thread);
 
-	if (!IS_ERR_OR_NULL(c->root))
+	if (!IS_ERR(c->root))
 		list_add(&c->root->list, &c->btree_cache);
 
 	/*
@@ -2112,7 +2112,7 @@ static int run_cache_set(struct cache_set *c)
 
 		err = "cannot allocate new btree root";
 		c->root = __bch_btree_node_alloc(c, NULL, 0, true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		mutex_lock(&c->root->write_lock);
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 3aa73da2c67b..6324c922f6ba 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -834,6 +834,16 @@ static int bch_root_node_dirty_init(struct cache_set *c,
 	if (ret < 0)
 		pr_warn("sectors dirty init failed, ret=%d!\n", ret);
 
+	/*
+	 * The op may be added to cache_set's btree_cache_wait
+	 * in mca_cannibalize(), must ensure it is removed from
+	 * the list and release btree_cache_alloc_lock before
+	 * free op memory.
+	 * Otherwise, the btree_cache_wait will be damaged.
+	 */
+	bch_cannibalize_unlock(c);
+	finish_wait(&c->btree_cache_wait, &(&op.op)->wait);
+
 	return ret;
 }
 
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 20afc0aec177..f843ade442de 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -54,14 +54,7 @@ __acquires(bitmap->lock)
 {
 	unsigned char *mappage;
 
-	if (page >= bitmap->pages) {
-		/* This can happen if bitmap_start_sync goes beyond
-		 * End-of-device while looking for a whole page.
-		 * It is harmless.
-		 */
-		return -EINVAL;
-	}
-
+	WARN_ON_ONCE(page >= bitmap->pages);
 	if (bitmap->bp[page].hijacked) /* it's hijacked, don't try to alloc */
 		return 0;
 
@@ -1365,6 +1358,14 @@ __acquires(bitmap->lock)
 	sector_t csize;
 	int err;
 
+	if (page >= bitmap->pages) {
+		/*
+		 * This can happen if bitmap_start_sync goes beyond
+		 * End-of-device while looking for a whole page or
+		 * user set a huge number to sysfs bitmap_set_bits.
+		 */
+		return NULL;
+	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
 
 	if (bitmap->bp[page].hijacked ||
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1553c2495841..ae0a857d6076 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3890,8 +3890,9 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
 static ssize_t
 safe_delay_show(struct mddev *mddev, char *page)
 {
-	int msec = (mddev->safemode_delay*1000)/HZ;
-	return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
+	unsigned int msec = ((unsigned long)mddev->safemode_delay*1000)/HZ;
+
+	return sprintf(page, "%u.%03u\n", msec/1000, msec%1000);
 }
 static ssize_t
 safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
@@ -3903,7 +3904,7 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0 || msec > UINT_MAX / HZ)
 		return -EINVAL;
 	if (msec == 0)
 		mddev->safemode_delay = 0;
@@ -4573,6 +4574,8 @@ max_corrected_read_errors_store(struct mddev *mddev, const char *buf, size_t len
 	rv = kstrtouint(buf, 10, &n);
 	if (rv < 0)
 		return rv;
+	if (n > INT_MAX)
+		return -EINVAL;
 	atomic_set(&mddev->max_corr_read_errors, n);
 	return len;
 }
@@ -4887,11 +4890,21 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			return -EINVAL;
 		err = mddev_lock(mddev);
 		if (!err) {
-			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 				err =  -EBUSY;
-			else {
+			} else if (mddev->reshape_position == MaxSector ||
+				   mddev->pers->check_reshape == NULL ||
+				   mddev->pers->check_reshape(mddev)) {
 				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 				err = mddev->pers->start_reshape(mddev);
+			} else {
+				/*
+				 * If reshape is still in progress, and
+				 * md_check_recovery() can continue to reshape,
+				 * don't restart reshape because data can be
+				 * corrupted for raid456.
+				 */
+				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			}
 			mddev_unlock(mddev);
 		}
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index a20332e755e8..ee2cfd6c2dfb 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -274,6 +274,18 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 		goto abort;
 	}
 
+	if (conf->layout == RAID0_ORIG_LAYOUT) {
+		for (i = 1; i < conf->nr_strip_zones; i++) {
+			sector_t first_sector = conf->strip_zone[i-1].zone_end;
+
+			sector_div(first_sector, mddev->chunk_sectors);
+			zone = conf->strip_zone + i;
+			/* disk_shift is first disk index used in the zone */
+			zone->disk_shift = sector_div(first_sector,
+						      zone->nb_dev);
+		}
+	}
+
 	pr_debug("md/raid0:%s: done.\n", mdname(mddev));
 	*private_conf = conf;
 
@@ -427,6 +439,20 @@ static void raid0_free(struct mddev *mddev, void *priv)
 	kfree(conf);
 }
 
+/*
+ * Convert disk_index to the disk order in which it is read/written.
+ *  For example, if we have 4 disks, they are numbered 0,1,2,3. If we
+ *  write the disks starting at disk 3, then the read/write order would
+ *  be disk 3, then 0, then 1, and then disk 2 and we want map_disk_shift()
+ *  to map the disks as follows 0,1,2,3 => 1,2,3,0. So disk 0 would map
+ *  to 1, 1 to 2, 2 to 3, and 3 to 0. That way we can compare disks in
+ *  that 'output' space to understand the read/write disk ordering.
+ */
+static int map_disk_shift(int disk_index, int num_disks, int disk_shift)
+{
+	return ((disk_index + num_disks - disk_shift) % num_disks);
+}
+
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
@@ -440,7 +466,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	sector_t orig_start, orig_end;
 
+	orig_start = start;
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
@@ -454,6 +482,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	} else
 		end = bio_end_sector(bio);
 
+	orig_end = end;
 	if (zone != conf->strip_zone)
 		end = end - zone[-1].zone_end;
 
@@ -465,13 +494,26 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	last_stripe_index = end;
 	sector_div(last_stripe_index, stripe_size);
 
-	start_disk_index = (int)(start - first_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
+	/* In the first zone the original and alternate layouts are the same */
+	if ((conf->layout == RAID0_ORIG_LAYOUT) && (zone != conf->strip_zone)) {
+		sector_div(orig_start, mddev->chunk_sectors);
+		start_disk_index = sector_div(orig_start, zone->nb_dev);
+		start_disk_index = map_disk_shift(start_disk_index,
+						  zone->nb_dev,
+						  zone->disk_shift);
+		sector_div(orig_end, mddev->chunk_sectors);
+		end_disk_index = sector_div(orig_end, zone->nb_dev);
+		end_disk_index = map_disk_shift(end_disk_index,
+						zone->nb_dev, zone->disk_shift);
+	} else {
+		start_disk_index = (int)(start - first_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+		end_disk_index = (int)(end - last_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+	}
 	start_disk_offset = ((int)(start - first_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		first_stripe_index * mddev->chunk_sectors;
-	end_disk_index = (int)(end - last_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
 	end_disk_offset = ((int)(end - last_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		last_stripe_index * mddev->chunk_sectors;
@@ -480,18 +522,22 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 		sector_t dev_start, dev_end;
 		struct bio *discard_bio = NULL;
 		struct md_rdev *rdev;
+		int compare_disk;
+
+		compare_disk = map_disk_shift(disk, zone->nb_dev,
+					      zone->disk_shift);
 
-		if (disk < start_disk_index)
+		if (compare_disk < start_disk_index)
 			dev_start = (first_stripe_index + 1) *
 				mddev->chunk_sectors;
-		else if (disk > start_disk_index)
+		else if (compare_disk > start_disk_index)
 			dev_start = first_stripe_index * mddev->chunk_sectors;
 		else
 			dev_start = start_disk_offset;
 
-		if (disk < end_disk_index)
+		if (compare_disk < end_disk_index)
 			dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
-		else if (disk > end_disk_index)
+		else if (compare_disk > end_disk_index)
 			dev_end = last_stripe_index * mddev->chunk_sectors;
 		else
 			dev_end = end_disk_offset;
diff --git a/drivers/md/raid0.h b/drivers/md/raid0.h
index 3816e5477db1..8cc761ca7423 100644
--- a/drivers/md/raid0.h
+++ b/drivers/md/raid0.h
@@ -6,6 +6,7 @@ struct strip_zone {
 	sector_t zone_end;	/* Start of the next zone (in sectors) */
 	sector_t dev_start;	/* Zone offset in real dev (in sectors) */
 	int	 nb_dev;	/* # of devices attached to the zone */
+	int	 disk_shift;	/* start disk for the original layout */
 };
 
 /* Linux 3.14 (20d0189b101) made an unintended change to
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6a0459f9fafb..55144f7d9303 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -751,8 +751,16 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		disk = r10_bio->devs[slot].devnum;
 		rdev = rcu_dereference(conf->mirrors[disk].replacement);
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags) ||
-		    r10_bio->devs[slot].addr + sectors > rdev->recovery_offset)
+		    r10_bio->devs[slot].addr + sectors >
+		    rdev->recovery_offset) {
+			/*
+			 * Read replacement first to prevent reading both rdev
+			 * and replacement as NULL during replacement replace
+			 * rdev.
+			 */
+			smp_mb();
 			rdev = rcu_dereference(conf->mirrors[disk].rdev);
+		}
 		if (rdev == NULL ||
 		    test_bit(Faulty, &rdev->flags))
 			continue;
@@ -894,6 +902,7 @@ static void flush_pending_writes(struct r10conf *conf)
 			else
 				submit_bio_noacct(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1087,6 +1096,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		else
 			submit_bio_noacct(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
@@ -1346,9 +1356,15 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
 	for (i = 0;  i < conf->copies; i++) {
 		int d = r10_bio->devs[i].devnum;
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[d].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[d].replacement);
+		struct md_rdev *rdev, *rrdev;
+
+		rrdev = rcu_dereference(conf->mirrors[d].replacement);
+		/*
+		 * Read replacement first to prevent reading both rdev and
+		 * replacement as NULL during replacement replace rdev.
+		 */
+		smp_mb();
+		rdev = rcu_dereference(conf->mirrors[d].rdev);
 		if (rdev == rrdev)
 			rrdev = NULL;
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
@@ -3037,7 +3053,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			int must_sync;
 			int any_working;
 			int need_recover = 0;
-			int need_replace = 0;
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
 
@@ -3049,11 +3064,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			    !test_bit(Faulty, &mrdev->flags) &&
 			    !test_bit(In_sync, &mrdev->flags))
 				need_recover = 1;
-			if (mreplace != NULL &&
-			    !test_bit(Faulty, &mreplace->flags))
-				need_replace = 1;
+			if (mreplace && test_bit(Faulty, &mreplace->flags))
+				mreplace = NULL;
 
-			if (!need_recover && !need_replace) {
+			if (!need_recover && !mreplace) {
 				rcu_read_unlock();
 				continue;
 			}
@@ -3069,8 +3083,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				rcu_read_unlock();
 				continue;
 			}
-			if (mreplace && test_bit(Faulty, &mreplace->flags))
-				mreplace = NULL;
 			/* Unless we are doing a full sync, or a replacement
 			 * we only need to recover the block if it is set in
 			 * the bitmap
@@ -3193,11 +3205,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio = r10_bio->devs[1].repl_bio;
 				if (bio)
 					bio->bi_end_io = NULL;
-				/* Note: if need_replace, then bio
+				/* Note: if replace is not NULL, then bio
 				 * cannot be NULL as r10buf_pool_alloc will
 				 * have allocated it.
 				 */
-				if (!need_replace)
+				if (!mreplace)
 					break;
 				bio->bi_next = biolist;
 				biolist = bio;
diff --git a/drivers/media/cec/i2c/Kconfig b/drivers/media/cec/i2c/Kconfig
index 70432a1d6918..d912d143fb31 100644
--- a/drivers/media/cec/i2c/Kconfig
+++ b/drivers/media/cec/i2c/Kconfig
@@ -5,6 +5,7 @@
 config CEC_CH7322
 	tristate "Chrontel CH7322 CEC controller"
 	depends on I2C
+	select REGMAP
 	select REGMAP_I2C
 	select CEC_CORE
 	help
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 5ca3920237c5..5fdce5f07364 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -917,8 +917,8 @@ static u32 get_framesize_raw_yuv420_tp10_ubwc(u32 width, u32 height)
 	u32 extradata = SZ_16K;
 	u32 size;
 
-	y_stride = ALIGN(ALIGN(width, 192) * 4 / 3, 256);
-	uv_stride = ALIGN(ALIGN(width, 192) * 4 / 3, 256);
+	y_stride = ALIGN(width * 4 / 3, 256);
+	uv_stride = ALIGN(width * 4 / 3, 256);
 	y_sclines = ALIGN(height, 16);
 	uv_sclines = ALIGN((height + 1) >> 1, 16);
 
diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 62ee09f28a0b..7524c90f5da6 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -202,7 +202,8 @@ static int az6007_rc_query(struct dvb_usb_device *d)
 	unsigned code;
 	enum rc_proto proto;
 
-	az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10);
+	if (az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10) < 0)
+		return -EIO;
 
 	if (st->data[1] == 0x44)
 		return 0;
diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 1babfe6e2c36..5c223b5498b4 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -179,7 +179,8 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 
 	for (i = 0; i < MAX_URBS; i++) {
 		usb_kill_urb(&dev->surbs[i].urb);
-		cancel_work_sync(&dev->surbs[i].wq);
+		if (dev->surbs[i].wq.func)
+			cancel_work_sync(&dev->surbs[i].wq);
 
 		if (dev->surbs[i].cb) {
 			smscore_putbuffer(dev->coredev, dev->surbs[i].cb);
diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index f43ba69fbb3e..2daae2e0cb19 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -434,15 +434,17 @@ static void __finalize_command(struct brcmstb_dpfe_priv *priv)
 static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
 			  u32 result[])
 {
-	const u32 *msg = priv->dpfe_api->command[cmd];
 	void __iomem *regs = priv->regs;
 	unsigned int i, chksum, chksum_idx;
+	const u32 *msg;
 	int ret = 0;
 	u32 resp;
 
 	if (cmd >= DPFE_CMD_MAX)
 		return -1;
 
+	msg = priv->dpfe_api->command[cmd];
+
 	mutex_lock(&priv->lock);
 
 	/* Wait for DCPU to become ready */
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index dd06c18495eb..0e37c6a5ee36 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -44,12 +44,10 @@ static const char *tpc_names[] = {
  * memstick_debug_get_tpc_name - debug helper that returns string for
  * a TPC number
  */
-const char *memstick_debug_get_tpc_name(int tpc)
+static __maybe_unused const char *memstick_debug_get_tpc_name(int tpc)
 {
 	return tpc_names[tpc-1];
 }
-EXPORT_SYMBOL(memstick_debug_get_tpc_name);
-
 
 /* Read a register*/
 static inline u32 r592_read_reg(struct r592_device *dev, int address)
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 045cbf0cbe53..993e305a232c 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -114,6 +114,9 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!info->mem)
+		return -ENODEV;
+
 	info->irq = platform_get_irq(pdev, 0);
 
 	ret = intel_lpss_probe(&pdev->dev, info);
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 48381d9bf740..302115dabff4 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -41,9 +41,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 988e2ba6dd0f..b45d7b0b842c 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -330,9 +330,8 @@ static int stmfx_chip_init(struct i2c_client *client)
 	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
 	if (ret) {
-		if (ret == -ENODEV)
-			stmfx->vdd = NULL;
-		else
+		stmfx->vdd = NULL;
+		if (ret != -ENODEV)
 			return dev_err_probe(&client->dev, ret, "Failed to get VDD regulator\n");
 	}
 
@@ -387,7 +386,7 @@ static int stmfx_chip_init(struct i2c_client *client)
 
 err:
 	if (stmfx->vdd)
-		return regulator_disable(stmfx->vdd);
+		regulator_disable(stmfx->vdd);
 
 	return ret;
 }
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 508349399f8a..7f758fb60c1f 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1494,9 +1494,9 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 int stmpe_remove(struct stmpe *stmpe)
 {
-	if (!IS_ERR(stmpe->vio))
+	if (!IS_ERR(stmpe->vio) && regulator_is_enabled(stmpe->vio))
 		regulator_disable(stmpe->vio);
-	if (!IS_ERR(stmpe->vcc))
+	if (!IS_ERR(stmpe->vcc) && regulator_is_enabled(stmpe->vcc))
 		regulator_disable(stmpe->vcc);
 
 	__stmpe_disable(stmpe, STMPE_BLOCK_ADC);
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 2488a9a67d18..eed047e971e7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1106,7 +1106,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
-		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 6, 0);
+		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
 
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				      sc, args);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 48eec5fe7397..6c4c85eb7147 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -727,6 +727,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq = -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
@@ -935,6 +939,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	if (id < 0)
 		return;
 
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
@@ -944,9 +951,6 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c8c0f50a2076..afe8d8c5fa8a 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -99,6 +99,20 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
+	/*
+	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
 	/*
 	 * Some SD cards reports discard support while they don't
 	 */
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9cfffcecc9eb..a72ca7416138 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2386,6 +2386,7 @@ static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
 		.pm	= &mmci_dev_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= mmci_probe,
 	.remove		= mmci_remove,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 133f0d376480..bad01cc6823f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1145,6 +1145,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 	}
 
+	sdhci_config_dma(host);
+
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 
@@ -1164,8 +1166,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 	}
 
-	sdhci_config_dma(host);
-
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
 
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 228612d82f31..ee3976b7e197 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -72,6 +72,7 @@
 #define GENCMDIADDRH(aih, addr)		((aih) | (((addr) >> 16) & 0xffff))
 
 #define DMA_DIR(dir)		((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
+#define DMA_ADDR_ALIGN		8
 
 #define ECC_CHECK_RETURN_FF	(-1)
 
@@ -838,6 +839,9 @@ static int meson_nfc_read_oob(struct nand_chip *nand, int page)
 
 static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
 {
+	if ((uintptr_t)buffer % DMA_ADDR_ALIGN)
+		return false;
+
 	if (virt_addr_valid(buffer) && (!object_is_on_stack(buffer)))
 		return true;
 	return false;
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 19ce4aa0973b..80eadf509c0a 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1025,17 +1025,17 @@ static int vsc73xx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	struct vsc73xx *vsc = ds->priv;
 
 	return vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port,
-			     VSC73XX_MAXLEN, new_mtu);
+			     VSC73XX_MAXLEN, new_mtu + ETH_HLEN + ETH_FCS_LEN);
 }
 
 /* According to application not "VSC7398 Jumbo Frames" setting
- * up the MTU to 9.6 KB does not affect the performance on standard
+ * up the frame size to 9.6 KB does not affect the performance on standard
  * frames. It is clear from the application note that
  * "9.6 kilobytes" == 9600 bytes.
  */
 static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
 {
-	return 9600;
+	return 9600 - ETH_HLEN - ETH_FCS_LEN;
 }
 
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 5f8769aa469d..d59ea5148c16 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -35,6 +35,8 @@
 
 #define ENA_REGS_ADMIN_INTR_MASK 1
 
+#define ENA_MAX_BACKOFF_DELAY_EXP 16U
+
 #define ENA_MIN_ADMIN_POLL_US 100
 
 #define ENA_MAX_ADMIN_POLL_US 5000
@@ -522,6 +524,7 @@ static int ena_com_comp_status_to_errno(u8 comp_status)
 
 static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
 {
+	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
 	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
 	delay_us = min_t(u32, delay_us * (1U << exp), ENA_MAX_ADMIN_POLL_US);
 	usleep_range(delay_us, 2 * delay_us);
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index bb999e67d773..ab8ee9331635 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1492,8 +1492,6 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 
 	bgmac->in_init = true;
 
-	bgmac_chip_intrs_off(bgmac);
-
 	net_dev->irq = bgmac->irq;
 	SET_NETDEV_DEV(net_dev, bgmac->dev);
 	dev_set_drvdata(bgmac->dev, bgmac);
@@ -1511,6 +1509,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	 */
 	bgmac_clk_enable(bgmac, 0);
 
+	bgmac_chip_intrs_off(bgmac);
+
 	/* This seems to be fixing IRQ by assigning OOB #6 to the core */
 	if (!(bgmac->feature_flags & BGMAC_FEAT_IDM_MASK)) {
 		if (bgmac->feature_flags & BGMAC_FEAT_IRQ_ID_OOB_6)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 4b875838a646..99aba64f03c2 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -624,5 +624,7 @@ void bcmgenet_mii_exit(struct net_device *dev)
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
+	clk_prepare_enable(priv->clk);
 	platform_device_unregister(priv->mii_pdev);
+	clk_disable_unprepare(priv->clk);
 }
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 613ca6124e3c..d14f37be1eb3 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -224,6 +224,7 @@ MODULE_AUTHOR("David S. Miller (davem@redhat.com) and Jeff Garzik (jgarzik@pobox
 MODULE_DESCRIPTION("Broadcom Tigon3 ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_TG3);
+MODULE_FIRMWARE(FIRMWARE_TG357766);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO5);
 
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index e0449cc24fbd..cbfd00744935 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -516,6 +516,9 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 		err = gve_adminq_report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
+
+	cmd->base.duplex = DUPLEX_FULL;
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 4680a2fe6d3c..05cd70579c16 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -968,7 +968,7 @@ static int iavf_set_channels(struct net_device *netdev,
 	}
 	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
 		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
-		adapter->num_active_queues = num_req;
+		adapter->num_req_queues = 0;
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index e45f3a1a11f3..b64801bc216b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1377,19 +1377,16 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 static void iavf_free_q_vectors(struct iavf_adapter *adapter)
 {
 	int q_idx, num_q_vectors;
-	int napi_vectors;
 
 	if (!adapter->q_vectors)
 		return;
 
 	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
-	napi_vectors = adapter->num_active_queues;
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
 		struct iavf_q_vector *q_vector = &adapter->q_vectors[q_idx];
 
-		if (q_idx < napi_vectors)
-			netif_napi_del(&q_vector->napi);
+		netif_napi_del(&q_vector->napi);
 	}
 	kfree(adapter->q_vectors);
 	adapter->q_vectors = NULL;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c5f465814dec..446598210012 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9453,6 +9453,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (state == pci_channel_io_normal) {
+		dev_warn(&pdev->dev, "Non-correctable non-fatal error reported.\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
+
 	netif_device_detach(netdev);
 
 	if (state == pci_channel_io_perm_failure)
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 970dd878d8a7..33f64c80335d 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -13,6 +13,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <linux/net_tstamp.h>
+#include <linux/bitfield.h>
 
 #include "igc_hw.h"
 
@@ -209,6 +210,10 @@ struct igc_adapter {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
 	struct work_struct ptp_tx_work;
+	/* Access to ptp_tx_skb and ptp_tx_start are protected by the
+	 * ptp_tx_lock.
+	 */
+	spinlock_t ptp_tx_lock;
 	struct sk_buff *ptp_tx_skb;
 	struct hwtstamp_config tstamp_config;
 	unsigned long ptp_tx_start;
@@ -272,6 +277,33 @@ extern char igc_driver_name[];
 #define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
 #define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
 
+/* RX-desc Write-Back format RSS Type's */
+enum igc_rss_type_num {
+	IGC_RSS_TYPE_NO_HASH		= 0,
+	IGC_RSS_TYPE_HASH_TCP_IPV4	= 1,
+	IGC_RSS_TYPE_HASH_IPV4		= 2,
+	IGC_RSS_TYPE_HASH_TCP_IPV6	= 3,
+	IGC_RSS_TYPE_HASH_IPV6_EX	= 4,
+	IGC_RSS_TYPE_HASH_IPV6		= 5,
+	IGC_RSS_TYPE_HASH_TCP_IPV6_EX	= 6,
+	IGC_RSS_TYPE_HASH_UDP_IPV4	= 7,
+	IGC_RSS_TYPE_HASH_UDP_IPV6	= 8,
+	IGC_RSS_TYPE_HASH_UDP_IPV6_EX	= 9,
+	IGC_RSS_TYPE_MAX		= 10,
+};
+#define IGC_RSS_TYPE_MAX_TABLE		16
+#define IGC_RSS_TYPE_MASK		GENMASK(3,0) /* 4-bits (3:0) = mask 0x0F */
+
+/* igc_rss_type - Rx descriptor RSS type field */
+static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
+{
+	/* RSS Type 4-bits (3:0) number: 0-9 (above 9 is reserved)
+	 * Accessing the same bits via u16 (wb.lower.lo_dword.hs_rss.pkt_info)
+	 * is slightly slower than via u32 (wb.lower.lo_dword.data)
+	 */
+	return le32_get_bits(rx_desc->wb.lower.lo_dword.data, IGC_RSS_TYPE_MASK);
+}
+
 /* Interrupt defines */
 #define IGC_START_ITR			648 /* ~6000 ints/sec */
 #define IGC_4K_ITR			980
@@ -361,7 +393,6 @@ enum igc_state_t {
 	__IGC_TESTING,
 	__IGC_RESETTING,
 	__IGC_DOWN,
-	__IGC_PTP_TX_IN_PROGRESS,
 };
 
 enum igc_tx_flags {
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index da259cd59add..d28ac3a025ab 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1673,6 +1673,8 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	/* twisted pair */
 	cmd->base.port = PORT_TP;
 	cmd->base.phy_address = hw->phy.addr;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
 
 	/* advertising link modes */
 	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 3aa0efb542aa..631ce793fb2e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -600,7 +600,6 @@ static void igc_configure_tx_ring(struct igc_adapter *adapter,
 	/* disable the queue */
 	wr32(IGC_TXDCTL(reg_idx), 0);
 	wrfl();
-	mdelay(10);
 
 	wr32(IGC_TDLEN(reg_idx),
 	     ring->count * sizeof(union igc_adv_tx_desc));
@@ -906,7 +905,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 	ktime_t base_time = adapter->base_time;
 	ktime_t now = ktime_get_clocktai();
 	ktime_t baset_est, end_of_cycle;
-	u32 launchtime;
+	s32 launchtime;
 	s64 n;
 
 	n = div64_s64(ktime_sub_ns(now, base_time), cycle_time);
@@ -919,7 +918,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 			*first_flag = true;
 			ring->last_ff_cycle = baset_est;
 
-			if (ktime_compare(txtime, ring->last_tx_cycle) > 0)
+			if (ktime_compare(end_of_cycle, ring->last_tx_cycle) > 0)
 				*insert_empty = true;
 		}
 	}
@@ -1467,9 +1466,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		 * the other timer registers before skipping the
 		 * timestamping request.
 		 */
-		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !test_and_set_bit_lock(__IGC_PTP_TX_IN_PROGRESS,
-					   &adapter->state)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON && !adapter->ptp_tx_skb) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGC_TX_FLAGS_TSTAMP;
 
@@ -1478,6 +1478,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
+
+		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
 
 	/* record initial flags and protocol */
@@ -1569,14 +1571,36 @@ static void igc_rx_checksum(struct igc_ring *ring,
 		   le32_to_cpu(rx_desc->wb.upper.status_error));
 }
 
+/* Mapping HW RSS Type to enum pkt_hash_types */
+static const enum pkt_hash_types igc_rss_type_table[IGC_RSS_TYPE_MAX_TABLE] = {
+	[IGC_RSS_TYPE_NO_HASH]		= PKT_HASH_TYPE_L2,
+	[IGC_RSS_TYPE_HASH_TCP_IPV4]	= PKT_HASH_TYPE_L4,
+	[IGC_RSS_TYPE_HASH_IPV4]	= PKT_HASH_TYPE_L3,
+	[IGC_RSS_TYPE_HASH_TCP_IPV6]	= PKT_HASH_TYPE_L4,
+	[IGC_RSS_TYPE_HASH_IPV6_EX]	= PKT_HASH_TYPE_L3,
+	[IGC_RSS_TYPE_HASH_IPV6]	= PKT_HASH_TYPE_L3,
+	[IGC_RSS_TYPE_HASH_TCP_IPV6_EX] = PKT_HASH_TYPE_L4,
+	[IGC_RSS_TYPE_HASH_UDP_IPV4]	= PKT_HASH_TYPE_L4,
+	[IGC_RSS_TYPE_HASH_UDP_IPV6]	= PKT_HASH_TYPE_L4,
+	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = PKT_HASH_TYPE_L4,
+	[10] = PKT_HASH_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
+	[11] = PKT_HASH_TYPE_NONE, /* keep array sized for SW bit-mask   */
+	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisons       */
+	[13] = PKT_HASH_TYPE_NONE,
+	[14] = PKT_HASH_TYPE_NONE,
+	[15] = PKT_HASH_TYPE_NONE,
+};
+
 static inline void igc_rx_hash(struct igc_ring *ring,
 			       union igc_adv_rx_desc *rx_desc,
 			       struct sk_buff *skb)
 {
-	if (ring->netdev->features & NETIF_F_RXHASH)
-		skb_set_hash(skb,
-			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
-			     PKT_HASH_TYPE_L3);
+	if (ring->netdev->features & NETIF_F_RXHASH) {
+		u32 rss_hash = le32_to_cpu(rx_desc->wb.lower.hi_dword.rss);
+		u32 rss_type = igc_rss_type(rx_desc);
+
+		skb_set_hash(skb, rss_hash, igc_rss_type_table[rss_type]);
+	}
 }
 
 /**
@@ -5257,6 +5281,7 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_TSO;
 	netdev->features |= NETIF_F_TSO6;
 	netdev->features |= NETIF_F_TSO_ECN;
+	netdev->features |= NETIF_F_RXHASH;
 	netdev->features |= NETIF_F_RXCSUM;
 	netdev->features |= NETIF_F_HW_CSUM;
 	netdev->features |= NETIF_F_SCTP_CRC;
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index ef53f7665b58..25b238c6a675 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -323,6 +323,7 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	return 0;
 }
 
+/* Requires adapter->ptp_tx_lock held by caller. */
 static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -330,7 +331,6 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
 	adapter->tx_hwtstamp_timeouts++;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
 	rd32(IGC_TXSTMPH);
 	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
@@ -338,20 +338,20 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 
 void igc_ptp_tx_hang(struct igc_adapter *adapter)
 {
-	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
-					      IGC_PTP_TX_TIMEOUT);
+	unsigned long flags;
 
-	if (!test_bit(__IGC_PTP_TX_IN_PROGRESS, &adapter->state))
-		return;
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
-	/* If we haven't received a timestamp within the timeout, it is
-	 * reasonable to assume that it will never occur, so we can unlock the
-	 * timestamp bit when this occurs.
-	 */
-	if (timeout) {
-		cancel_work_sync(&adapter->ptp_tx_work);
-		igc_ptp_tx_timeout(adapter);
-	}
+	if (!adapter->ptp_tx_skb)
+		goto unlock;
+
+	if (time_is_after_jiffies(adapter->ptp_tx_start + IGC_PTP_TX_TIMEOUT))
+		goto unlock;
+
+	igc_ptp_tx_timeout(adapter);
+
+unlock:
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
 /**
@@ -361,6 +361,8 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
  * If we were asked to do hardware stamping and such a time stamp is
  * available, then it must have been for this skb here because we only
  * allow only one such packet into the queue.
+ *
+ * Context: Expects adapter->ptp_tx_lock to be held by caller.
  */
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
@@ -396,13 +398,7 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 	shhwtstamps.hwtstamp =
 		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
 
-	/* Clear the lock early before calling skb_tstamp_tx so that
-	 * applications are not woken up before the lock bit is clear. We use
-	 * a copy of the skb pointer to ensure other threads can't change it
-	 * while we're notifying the stack.
-	 */
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 
 	/* Notify the stack and free the skb after we've unlocked */
 	skb_tstamp_tx(skb, &shhwtstamps);
@@ -413,24 +409,33 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
  * igc_ptp_tx_work
  * @work: pointer to work struct
  *
- * This work function polls the TSYNCTXCTL valid bit to determine when a
- * timestamp has been taken for the current stored skb.
+ * This work function checks the TSYNCTXCTL valid bit to determine when
+ * a timestamp has been taken for the current stored skb.
  */
 static void igc_ptp_tx_work(struct work_struct *work)
 {
 	struct igc_adapter *adapter = container_of(work, struct igc_adapter,
 						   ptp_tx_work);
 	struct igc_hw *hw = &adapter->hw;
+	unsigned long flags;
 	u32 tsynctxctl;
 
-	if (!test_bit(__IGC_PTP_TX_IN_PROGRESS, &adapter->state))
-		return;
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
+	if (!adapter->ptp_tx_skb)
+		goto unlock;
 
 	tsynctxctl = rd32(IGC_TSYNCTXCTL);
-	if (WARN_ON_ONCE(!(tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)))
-		return;
+	tsynctxctl &= IGC_TSYNCTXCTL_TXTT_0;
+	if (!tsynctxctl) {
+		WARN_ONCE(1, "Received a TSTAMP interrupt but no TSTAMP is ready.\n");
+		goto unlock;
+	}
 
 	igc_ptp_tx_hwtstamp(adapter);
+
+unlock:
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
 /**
@@ -506,6 +511,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 		return;
 	}
 
+	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->tmreg_lock);
 	INIT_WORK(&adapter->ptp_tx_work, igc_ptp_tx_work);
 
@@ -559,7 +565,6 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 	cancel_work_sync(&adapter->ptp_tx_work);
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 
 	if (pci_device_is_present(adapter->pdev))
 		igc_ptp_time_save(adapter);
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f5567d485e91..3656a3937eca 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1471,7 +1471,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -4165,7 +4165,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		 */
 		if (txq_number == 1)
 			txq_map = (cpu == elected_cpu) ?
-				MVNETA_CPU_TXQ_ACCESS(1) : 0;
+				MVNETA_CPU_TXQ_ACCESS(0) : 0;
 		else
 			txq_map = mvreg_read(pp, MVNETA_CPU_MAP(cpu)) &
 				MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index fc6d785b98dd..ec9a291e866c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -20,6 +20,7 @@
 #define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
 
 /* Subsystem Device ID */
+#define PCI_SUBSYS_DEVID_98XX                  0xB100
 #define PCI_SUBSYS_DEVID_96XX                  0xB200
 
 /* PCI BAR nos */
@@ -403,6 +404,16 @@ static inline bool is_rvu_96xx_B0(struct rvu *rvu)
 		(pdev->subsystem_device == PCI_SUBSYS_DEVID_96XX);
 }
 
+static inline bool is_rvu_supports_nix1(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_98XX)
+		return true;
+
+	return false;
+}
+
 /* Function Prototypes
  * RVU
  */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 6c6b411e78fd..83743e15326d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -84,7 +84,7 @@ static void rvu_map_cgx_nix_block(struct rvu *rvu, int pf,
 	p2x = cgx_lmac_get_p2x(cgx_id, lmac_id);
 	/* Firmware sets P2X_SELECT as either NIX0 or NIX1 */
 	pfvf->nix_blkaddr = BLKADDR_NIX0;
-	if (p2x == CMR_P2X_SEL_NIX1)
+	if (is_rvu_supports_nix1(rvu) && p2x == CMR_P2X_SEL_NIX1)
 		pfvf->nix_blkaddr = BLKADDR_NIX1;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 54aeb276b9a0..000dd89c4baf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1311,8 +1311,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	if (err)
 		goto err_free_npa_lf;
 
-	/* Enable backpressure */
-	otx2_nix_config_bp(pf, true);
+	/* Enable backpressure for CGX mapped PF/VFs */
+	if (!is_otx2_lbkvf(pf->pdev))
+		otx2_nix_config_bp(pf, true);
 
 	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
 	err = otx2_rq_aura_pool_init(pf);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index e51f60b55daa..2da90f6649d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -194,6 +194,7 @@ static int accel_fs_tcp_create_groups(struct mlx5e_flow_table *ft,
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 16846442717d..c6a81a51530d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1334,7 +1334,8 @@ static void remove_unready_flow(struct mlx5e_tc_flow *flow)
 	uplink_priv = &rpriv->uplink_priv;
 
 	mutex_lock(&uplink_priv->unready_flows_lock);
-	unready_flow_del(flow);
+	if (flow_flag_test(flow, NOT_READY))
+		unready_flow_del(flow);
 	mutex_unlock(&uplink_priv->unready_flows_lock);
 }
 
@@ -1475,8 +1476,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 
 	mlx5e_put_flow_tunnel_id(flow);
 
-	if (flow_flag_test(flow, NOT_READY))
-		remove_unready_flow(flow);
+	remove_unready_flow(flow);
 
 	if (mlx5e_is_offloaded_flow(flow)) {
 		if (flow_flag_test(flow, SLOW))
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 481f89d193f7..50cb1c5251f7 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -83,6 +83,18 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
 				  !(data & HW_CFG_LRST_), 100000, 10000000);
 }
 
+static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
+					   int offset, u32 bit_mask,
+					   int target_value, int udelay_min,
+					   int udelay_max, int count)
+{
+	u32 data;
+
+	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
+					 target_value == !!(data & bit_mask),
+					 udelay_max, udelay_min * count);
+}
+
 static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 				    int offset, u32 bit_mask,
 				    int target_value, int usleep_min,
@@ -678,8 +690,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -690,8 +702,9 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 		lan743x_csr_write(adapter, DP_ADDR, addr + i);
 		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
 		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
-		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-					     1, 40, 100, 100))
+		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL,
+						    DP_SEL_DPRDY_,
+						    1, 40, 100, 100))
 			return -EIO;
 	}
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index fcd4213c99b8..098772601df8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -433,11 +433,6 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
 static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 				      struct ionic_qcq *n_qcq)
 {
-	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
-		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
-		n_qcq->flags &= ~IONIC_QCQ_F_INTR;
-	}
-
 	n_qcq->intr.vector = src_qcq->intr.vector;
 	n_qcq->intr.index = src_qcq->intr.index;
 }
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 32654fe1f8b5..3f53b5ea7841 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1297,8 +1297,10 @@ static void efx_ef10_fini_nic(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 
+	spin_lock_bh(&efx->stats_lock);
 	kfree(nic_data->mc_stats);
 	nic_data->mc_stats = NULL;
+	spin_unlock_bh(&efx->stats_lock);
 }
 
 static int efx_ef10_init_nic(struct efx_nic *efx)
@@ -1836,9 +1838,14 @@ static size_t efx_ef10_update_stats_pf(struct efx_nic *efx, u64 *full_stats,
 
 	efx_ef10_get_stat_mask(efx, mask);
 
-	efx_nic_copy_stats(efx, nic_data->mc_stats);
-	efx_nic_update_stats(efx_ef10_stat_desc, EF10_STAT_COUNT,
-			     mask, stats, nic_data->mc_stats, false);
+	/* If NIC was fini'd (probably resetting), then we can't read
+	 * updated stats right now.
+	 */
+	if (nic_data->mc_stats) {
+		efx_nic_copy_stats(efx, nic_data->mc_stats);
+		efx_nic_update_stats(efx_ef10_stat_desc, EF10_STAT_COUNT,
+				     mask, stats, nic_data->mc_stats, false);
+	}
 
 	/* Update derived statistics */
 	efx_nic_fix_nodesc_drop_stat(efx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index de66406c5057..83e9a4d019c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5254,12 +5254,6 @@ int stmmac_dvr_remove(struct device *dev)
 	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
 
-	/* Serdes power down needs to happen after VLAN filter
-	 * is deleted that is triggered by unregister_netdev().
-	 */
-	if (priv->plat->serdes_powerdown)
-		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
-
 #ifdef CONFIG_DEBUG_FS
 	stmmac_exit_fs(ndev);
 #endif
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index a6a455c32628..73efc8b45364 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -104,23 +104,37 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx;
+	int idx, idx2;
+	u32 hi_val = 0;
 
 	idx    = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be fetched exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
-	return (ale_entry[idx] >> start) & BITMASK(bits);
+	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
 }
 
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx;
+	int idx, idx2;
 
 	value &= BITMASK(bits);
-	idx    = start / 32;
+	idx = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be set exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+	}
 	start -= idx * 32;
-	idx    = 2 - idx; /* flip */
+	idx = 2 - idx; /* flip */
 	ale_entry[idx] &= ~(BITMASK(bits) << start);
 	ale_entry[idx] |=  (value << start);
 }
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 3d91baf2e55a..9d362283196a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2009,6 +2009,11 @@ static int axienet_probe(struct platform_device *pdev)
 		goto cleanup_clk;
 	}
 
+	/* Reset core now that clocks are enabled, prior to accessing MDIO */
+	ret = __axienet_device_reset(lp);
+	if (ret)
+		goto cleanup_clk;
+
 	/* Autodetect the need for 64-bit DMA pointers.
 	 * When the IP is configured for a bus width bigger than 32 bits,
 	 * writing the MSB registers is mandatory, even if they are all 0.
@@ -2055,11 +2060,6 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 
-	/* Reset core now that clocks are enabled, prior to accessing MDIO */
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		goto cleanup_clk;
-
 	ret = axienet_mdio_setup(lp);
 	if (ret)
 		dev_warn(&pdev->dev,
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 1c46bc4d2705..05ea3a18552b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -291,7 +291,9 @@ static void __gtp_encap_destroy(struct sock *sk)
 			gtp->sk1u = NULL;
 		udp_sk(sk)->encap_type = 0;
 		rcu_assign_sk_user_data(sk, NULL);
+		release_sock(sk);
 		sock_put(sk);
+		return;
 	}
 	release_sock(sk);
 }
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 0a5b5ff597c6..ab09d110760e 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -586,7 +586,8 @@ static int ipvlan_xmit_mode_l3(struct sk_buff *skb, struct net_device *dev)
 				consume_skb(skb);
 				return NET_XMIT_DROP;
 			}
-			return ipvlan_rcv_frame(addr, &skb, true);
+			ipvlan_rcv_frame(addr, &skb, true);
+			return NET_XMIT_SUCCESS;
 		}
 	}
 out:
@@ -612,7 +613,8 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 					consume_skb(skb);
 					return NET_XMIT_DROP;
 				}
-				return ipvlan_rcv_frame(addr, &skb, true);
+				ipvlan_rcv_frame(addr, &skb, true);
+				return NET_XMIT_SUCCESS;
 			}
 		}
 		skb = skb_share_check(skb, GFP_ATOMIC);
@@ -624,7 +626,8 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 		 * the skb for the main-dev. At the RX side we just return
 		 * RX_PASS for it to be processed further on the stack.
 		 */
-		return dev_forward_skb(ipvlan->phy_dev, skb);
+		dev_forward_skb(ipvlan->phy_dev, skb);
+		return NET_XMIT_SUCCESS;
 
 	} else if (is_multicast_ether_addr(eth->h_dest)) {
 		skb_reset_mac_header(skb);
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 9bbecf4d159b..bcf354719745 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -149,13 +149,10 @@ static ssize_t nsim_dev_trap_fa_cookie_write(struct file *file,
 	cookie_len = (count - 1) / 2;
 	if ((count - 1) % 2)
 		return -EINVAL;
-	buf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
-	if (!buf)
-		return -ENOMEM;
 
-	ret = simple_write_to_buffer(buf, count, ppos, data, count);
-	if (ret < 0)
-		goto free_buf;
+	buf = memdup_user(data, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	fa_cookie = kmalloc(sizeof(*fa_cookie) + cookie_len,
 			    GFP_KERNEL | __GFP_NOWARN);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index e771e0e8a9bc..095d16ceafcf 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3024,23 +3024,30 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+
 	rc = mdio_bus_init();
 	if (rc)
-		return rc;
+		goto err_ethtool_phy_ops;
 
-	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
 	if (rc)
-		goto err_c45;
+		goto err_mdio_bus;
 
 	rc = phy_driver_register(&genphy_driver, THIS_MODULE);
-	if (rc) {
-		phy_driver_unregister(&genphy_c45_driver);
+	if (rc)
+		goto err_c45;
+
+	return 0;
+
 err_c45:
-		mdio_bus_exit();
-	}
+	phy_driver_unregister(&genphy_c45_driver);
+err_mdio_bus:
+	mdio_bus_exit();
+err_ethtool_phy_ops:
+	ethtool_set_ethtool_phy_ops(NULL);
 
 	return rc;
 }
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index ee5058445d06..05a75b5a8b68 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -24,6 +24,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/rcupdate.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 
 #include <net/sock.h>
@@ -128,6 +129,23 @@ static void del_chan(struct pppox_sock *sock)
 	spin_unlock(&chan_lock);
 }
 
+static struct rtable *pptp_route_output(struct pppox_sock *po,
+					struct flowi4 *fl4)
+{
+	struct sock *sk = &po->sk;
+	struct net *net;
+
+	net = sock_net(sk);
+	flowi4_init_output(fl4, sk->sk_bound_dev_if, sk->sk_mark, 0,
+			   RT_SCOPE_UNIVERSE, IPPROTO_GRE, 0,
+			   po->proto.pptp.dst_addr.sin_addr.s_addr,
+			   po->proto.pptp.src_addr.sin_addr.s_addr,
+			   0, 0, sock_net_uid(net, sk));
+	security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
+
+	return ip_route_output_flow(net, fl4, sk);
+}
+
 static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *) chan->private;
@@ -151,11 +169,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	if (sk_pppox(po)->sk_state & PPPOX_DEAD)
 		goto tx_error;
 
-	rt = ip_route_output_ports(net, &fl4, NULL,
-				   opt->dst_addr.sin_addr.s_addr,
-				   opt->src_addr.sin_addr.s_addr,
-				   0, 0, IPPROTO_GRE,
-				   RT_TOS(0), sk->sk_bound_dev_if);
+	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt))
 		goto tx_error;
 
@@ -440,12 +454,7 @@ static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
 	po->chan.private = sk;
 	po->chan.ops = &pptp_chan_ops;
 
-	rt = ip_route_output_ports(sock_net(sk), &fl4, sk,
-				   opt->dst_addr.sin_addr.s_addr,
-				   opt->src_addr.sin_addr.s_addr,
-				   0, 0,
-				   IPPROTO_GRE, RT_CONN_FLAGS(sk),
-				   sk->sk_bound_dev_if);
+	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt)) {
 		error = -EHOSTUNREACH;
 		goto end;
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 5c804bcabfe6..f5bc279c9a8c 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -546,6 +546,7 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 		u8 *private_key = nla_data(info->attrs[WGDEVICE_A_PRIVATE_KEY]);
 		u8 public_key[NOISE_PUBLIC_KEY_LEN];
 		struct wg_peer *peer, *temp;
+		bool send_staged_packets;
 
 		if (!crypto_memneq(wg->static_identity.static_private,
 				   private_key, NOISE_PUBLIC_KEY_LEN))
@@ -564,14 +565,17 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 		}
 
 		down_write(&wg->static_identity.lock);
-		wg_noise_set_static_identity_private_key(&wg->static_identity,
-							 private_key);
-		list_for_each_entry_safe(peer, temp, &wg->peer_list,
-					 peer_list) {
+		send_staged_packets = !wg->static_identity.has_identity && netif_running(wg->dev);
+		wg_noise_set_static_identity_private_key(&wg->static_identity, private_key);
+		send_staged_packets = send_staged_packets && wg->static_identity.has_identity;
+
+		wg_cookie_checker_precompute_device_keys(&wg->cookie_checker);
+		list_for_each_entry_safe(peer, temp, &wg->peer_list, peer_list) {
 			wg_noise_precompute_static_static(peer);
 			wg_noise_expire_current_peer_keypairs(peer);
+			if (send_staged_packets)
+				wg_packet_send_staged_packets(peer);
 		}
-		wg_cookie_checker_precompute_device_keys(&wg->cookie_checker);
 		up_write(&wg->static_identity.lock);
 	}
 skip_set_private_key:
diff --git a/drivers/net/wireguard/queueing.c b/drivers/net/wireguard/queueing.c
index 8084e7408c0a..26d235d15235 100644
--- a/drivers/net/wireguard/queueing.c
+++ b/drivers/net/wireguard/queueing.c
@@ -28,6 +28,7 @@ int wg_packet_queue_init(struct crypt_queue *queue, work_func_t function,
 	int ret;
 
 	memset(queue, 0, sizeof(*queue));
+	queue->last_cpu = -1;
 	ret = ptr_ring_init(&queue->ring, len, GFP_KERNEL);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index e2388107f7fd..a2e702f8c582 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -119,20 +119,17 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 	return cpu;
 }
 
-/* This function is racy, in the sense that next is unlocked, so it could return
- * the same CPU twice. A race-free version of this would be to instead store an
- * atomic sequence number, do an increment-and-return, and then iterate through
- * every possible CPU until we get to that index -- choose_cpu. However that's
- * a bit slower, and it doesn't seem like this potential race actually
- * introduces any performance loss, so we live with it.
+/* This function is racy, in the sense that it's called while last_cpu is
+ * unlocked, so it could return the same CPU twice. Adding locking or using
+ * atomic sequence numbers is slower though, and the consequences of racing are
+ * harmless, so live with it.
  */
-static inline int wg_cpumask_next_online(int *next)
+static inline int wg_cpumask_next_online(int *last_cpu)
 {
-	int cpu = *next;
-
-	while (unlikely(!cpumask_test_cpu(cpu, cpu_online_mask)))
-		cpu = cpumask_next(cpu, cpu_online_mask) % nr_cpumask_bits;
-	*next = cpumask_next(cpu, cpu_online_mask) % nr_cpumask_bits;
+	int cpu = cpumask_next(*last_cpu, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(cpu_online_mask);
+	*last_cpu = cpu;
 	return cpu;
 }
 
@@ -161,7 +158,7 @@ static inline void wg_prev_queue_drop_peeked(struct prev_queue *queue)
 
 static inline int wg_queue_enqueue_per_device_and_peer(
 	struct crypt_queue *device_queue, struct prev_queue *peer_queue,
-	struct sk_buff *skb, struct workqueue_struct *wq, int *next_cpu)
+	struct sk_buff *skb, struct workqueue_struct *wq)
 {
 	int cpu;
 
@@ -175,7 +172,7 @@ static inline int wg_queue_enqueue_per_device_and_peer(
 	/* Then we queue it up in the device queue, which consumes the
 	 * packet as soon as it can.
 	 */
-	cpu = wg_cpumask_next_online(next_cpu);
+	cpu = wg_cpumask_next_online(&device_queue->last_cpu);
 	if (unlikely(ptr_ring_produce_bh(&device_queue->ring, skb)))
 		return -EPIPE;
 	queue_work_on(cpu, wq, &per_cpu_ptr(device_queue->worker, cpu)->work);
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index 7b8df406c773..f500aaf67837 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -531,7 +531,7 @@ static void wg_packet_consume_data(struct wg_device *wg, struct sk_buff *skb)
 		goto err;
 
 	ret = wg_queue_enqueue_per_device_and_peer(&wg->decrypt_queue, &peer->rx_queue, skb,
-						   wg->packet_crypt_wq, &wg->decrypt_queue.last_cpu);
+						   wg->packet_crypt_wq);
 	if (unlikely(ret == -EPIPE))
 		wg_queue_enqueue_per_peer_rx(skb, PACKET_STATE_DEAD);
 	if (likely(!ret || ret == -EPIPE)) {
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 5368f7c35b4b..95c853b59e1d 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -318,7 +318,7 @@ static void wg_packet_create_data(struct wg_peer *peer, struct sk_buff *first)
 		goto err;
 
 	ret = wg_queue_enqueue_per_device_and_peer(&wg->encrypt_queue, &peer->tx_queue, first,
-						   wg->packet_crypt_wq, &wg->encrypt_queue.last_cpu);
+						   wg->packet_crypt_wq);
 	if (unlikely(ret == -EPIPE))
 		wg_queue_enqueue_per_peer_tx(first, PACKET_STATE_DEAD);
 err:
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 67faf62999de..3170c54c97b7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6044,7 +6044,7 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		if (reg_cap->high_5ghz_chan >= ATH11K_MAX_6G_FREQ) {
+		if (reg_cap->high_5ghz_chan >= ATH11K_MIN_6G_FREQ) {
 			channels = kmemdup(ath11k_6ghz_channels,
 					   sizeof(ath11k_6ghz_channels), GFP_KERNEL);
 			if (!channels) {
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
index 42f00a2a8c80..cf5648188459 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
@@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *ah, unsigned int queue)
 {
 	u32 dma_dbg_chain, dma_dbg_complete;
 	u8 dcu_chain_state, dcu_complete_state;
+	unsigned int dbg_reg, reg_offset;
 	int i;
 
-	for (i = 0; i < NUM_STATUS_READS; i++) {
-		if (queue < 6)
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_4);
-		else
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_5);
+	if (queue < 6) {
+		dbg_reg = AR_DMADBG_4;
+		reg_offset = queue * 5;
+	} else {
+		dbg_reg = AR_DMADBG_5;
+		reg_offset = (queue - 6) * 5;
+	}
 
+	for (i = 0; i < NUM_STATUS_READS; i++) {
+		dma_dbg_chain = REG_READ(ah, dbg_reg);
 		dma_dbg_complete = REG_READ(ah, AR_DMADBG_6);
 
-		dcu_chain_state = (dma_dbg_chain >> (5 * queue)) & 0x1f;
+		dcu_chain_state = (dma_dbg_chain >> reg_offset) & 0x1f;
 		dcu_complete_state = dma_dbg_complete & 0x3;
 
 		if ((dcu_chain_state != 0x6) || (dcu_complete_state != 0x1))
@@ -1128,6 +1133,7 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 	u8 dcu_chain_state, dcu_complete_state;
 	bool dcu_wait_frdone = false;
 	unsigned long chk_dcu = 0;
+	unsigned int reg_offset;
 	unsigned int i = 0;
 
 	dma_dbg_4 = REG_READ(ah, AR_DMADBG_4);
@@ -1139,12 +1145,15 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 		goto exit;
 
 	for (i = 0; i < ATH9K_NUM_TX_QUEUES; i++) {
-		if (i < 6)
+		if (i < 6) {
 			chk_dbg = dma_dbg_4;
-		else
+			reg_offset = i * 5;
+		} else {
 			chk_dbg = dma_dbg_5;
+			reg_offset = (i - 6) * 5;
+		}
 
-		dcu_chain_state = (chk_dbg >> (5 * i)) & 0x1f;
+		dcu_chain_state = (chk_dbg >> reg_offset) & 0x1f;
 		if (dcu_chain_state == 0x6) {
 			dcu_wait_frdone = true;
 			chk_dcu |= BIT(i);
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index fe62ff668f75..99667aba289d 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -114,7 +114,13 @@ static void htc_process_conn_rsp(struct htc_target *target,
 
 	if (svc_rspmsg->status == HTC_SERVICE_SUCCESS) {
 		epid = svc_rspmsg->endpoint_id;
-		if (epid < 0 || epid >= ENDPOINT_MAX)
+
+		/* Check that the received epid for the endpoint to attach
+		 * a new service is valid. ENDPOINT0 can't be used here as it
+		 * is already reserved for HTC_CTRL_RSVD_SVC service and thus
+		 * should not be modified.
+		 */
+		if (epid <= ENDPOINT0 || epid >= ENDPOINT_MAX)
 			return;
 
 		service_id = be16_to_cpu(svc_rspmsg->service_id);
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index ac354dfc5055..b2cfc483515c 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -203,7 +203,7 @@ void ath_cancel_work(struct ath_softc *sc)
 void ath_restart_work(struct ath_softc *sc)
 {
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 
 	if (AR_SREV_9340(sc->sc_ah) || AR_SREV_9330(sc->sc_ah))
 		ieee80211_queue_delayed_work(sc->hw, &sc->hw_pll_work,
@@ -850,7 +850,7 @@ static bool ath9k_txq_list_has_key(struct list_head *txq_list, u32 keyix)
 static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 {
 	struct ath_hw *ah = sc->sc_ah;
-	int i;
+	int i, j;
 	struct ath_txq *txq;
 	bool key_in_use = false;
 
@@ -868,8 +868,9 @@ static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 		if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA) {
 			int idx = txq->txq_tailidx;
 
-			while (!key_in_use &&
-			       !list_empty(&txq->txq_fifo[idx])) {
+			for (j = 0; !key_in_use &&
+			     !list_empty(&txq->txq_fifo[idx]) &&
+			     j < ATH_TXFIFO_DEPTH; j++) {
 				key_in_use = ath9k_txq_list_has_key(
 					&txq->txq_fifo[idx], keyix);
 				INCR(idx, ATH_TXFIFO_DEPTH);
@@ -2243,7 +2244,7 @@ void __ath9k_flush(struct ieee80211_hw *hw, u32 queues, bool drop,
 	}
 
 	ieee80211_queue_delayed_work(hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 }
 
 static bool ath9k_tx_frames_pending(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 19345b8f7bfd..d652c647d56b 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -221,6 +221,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	/* Validate the obtained SKB. */
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
diff --git a/drivers/net/wireless/atmel/atmel_cs.c b/drivers/net/wireless/atmel/atmel_cs.c
index 368eebefa741..e64f108d288b 100644
--- a/drivers/net/wireless/atmel/atmel_cs.c
+++ b/drivers/net/wireless/atmel/atmel_cs.c
@@ -73,6 +73,7 @@ struct local_info {
 static int atmel_probe(struct pcmcia_device *p_dev)
 {
 	struct local_info *local;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "atmel_attach()\n");
 
@@ -83,8 +84,16 @@ static int atmel_probe(struct pcmcia_device *p_dev)
 
 	p_dev->priv = local;
 
-	return atmel_config(p_dev);
-} /* atmel_attach */
+	ret = atmel_config(p_dev);
+	if (ret)
+		goto err_free_priv;
+
+	return 0;
+
+err_free_priv:
+	kfree(p_dev->priv);
+	return ret;
+}
 
 static void atmel_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 8c9c6bfbaeee..aa1d12f6f5c3 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6150,8 +6150,11 @@ static int airo_get_rate(struct net_device *dev,
 {
 	struct airo_info *local = dev->ml_priv;
 	StatusRid status_rid;		/* Card status info */
+	int ret;
 
-	readStatusRid(local, &status_rid, 1);
+	ret = readStatusRid(local, &status_rid, 1);
+	if (ret)
+		return -EBUSY;
 
 	vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
 	/* If more than one rate, set auto */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7c61d179895b..5b173f21e87b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1174,8 +1174,11 @@ static void iwl_mvm_queue_state_change(struct iwl_op_mode *op_mode,
 		mvmtxq = iwl_mvm_txq_from_mac80211(txq);
 		mvmtxq->stopped = !start;
 
-		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST)
+		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST) {
+			local_bh_disable();
 			iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
+			local_bh_enable();
+		}
 	}
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 09f870c48a4f..141581fa74c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2590,7 +2590,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (iwl_mvm_has_new_rx_api(mvm) && start) {
-		u16 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
+		u32 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
 
 		/* sparse doesn't like the __align() so don't check */
 #ifndef __CHECKER__
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
index a956f965a1e5..03bfd2482656 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
@@ -96,6 +96,7 @@ orinoco_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				orinoco_cs_hard_reset, NULL);
@@ -107,8 +108,16 @@ orinoco_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return orinoco_cs_config(link);
-}				/* orinoco_cs_attach */
+	ret = orinoco_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void orinoco_cs_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
index 291ef97ed45e..841d623c621a 100644
--- a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
@@ -157,6 +157,7 @@ spectrum_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				spectrum_cs_hard_reset,
@@ -169,8 +170,16 @@ spectrum_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return spectrum_cs_config(link);
-}				/* spectrum_cs_attach */
+	ret = spectrum_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void spectrum_cs_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index c2a685f63e95..78ef40e315b5 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2200,9 +2200,9 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 
 	if (nd_config) {
 		adapter->nd_info =
-			kzalloc(sizeof(struct cfg80211_wowlan_nd_match) +
-				sizeof(struct cfg80211_wowlan_nd_match *) *
-				scan_rsp->number_of_sets, GFP_ATOMIC);
+			kzalloc(struct_size(adapter->nd_info, matches,
+					    scan_rsp->number_of_sets),
+				GFP_ATOMIC);
 
 		if (adapter->nd_info)
 			adapter->nd_info->n_matches = scan_rsp->number_of_sets;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index b25847799138..884f45e627a7 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -470,6 +470,9 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 		int rsn_ie_len = sizeof(struct element) + rsn_ie[1];
 		int offset = 8;
 
+		param->mode_802_11i = 2;
+		param->rsn_found = true;
+
 		/* extract RSN capabilities */
 		if (offset < rsn_ie_len) {
 			/* skip over pairwise suites */
@@ -479,11 +482,8 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				/* skip over authentication suites */
 				offset += (rsn_ie[offset] * 4) + 2;
 
-				if (offset + 1 < rsn_ie_len) {
-					param->mode_802_11i = 2;
-					param->rsn_found = true;
+				if (offset + 1 < rsn_ie_len)
 					memcpy(param->rsn_cap, &rsn_ie[offset], 2);
-				}
 			}
 		}
 	}
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 091eea0d958d..bf1282702761 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -270,13 +270,14 @@ static int ray_probe(struct pcmcia_device *p_dev)
 {
 	ray_dev_t *local;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "ray_attach()\n");
 
 	/* Allocate space for private device-specific data */
 	dev = alloc_etherdev(sizeof(ray_dev_t));
 	if (!dev)
-		goto fail_alloc_dev;
+		return -ENOMEM;
 
 	local = netdev_priv(dev);
 	local->finder = p_dev;
@@ -313,11 +314,16 @@ static int ray_probe(struct pcmcia_device *p_dev)
 	timer_setup(&local->timer, NULL, 0);
 
 	this_device = p_dev;
-	return ray_config(p_dev);
+	ret = ray_config(p_dev);
+	if (ret)
+		goto err_free_dev;
+
+	return 0;
 
-fail_alloc_dev:
-	return -ENOMEM;
-} /* ray_attach */
+err_free_dev:
+	free_netdev(dev);
+	return ret;
+}
 
 static void ray_detach(struct pcmcia_device *link)
 {
@@ -1641,38 +1647,34 @@ static void authenticate_timeout(struct timer_list *t)
 /*===========================================================================*/
 static int parse_addr(char *in_str, UCHAR *out)
 {
+	int i, k;
 	int len;
-	int i, j, k;
-	int status;
 
 	if (in_str == NULL)
 		return 0;
-	if ((len = strlen(in_str)) < 2)
+	len = strnlen(in_str, ADDRLEN * 2 + 1) - 1;
+	if (len < 1)
 		return 0;
 	memset(out, 0, ADDRLEN);
 
-	status = 1;
-	j = len - 1;
-	if (j > 12)
-		j = 12;
 	i = 5;
 
-	while (j > 0) {
-		if ((k = hex_to_bin(in_str[j--])) != -1)
+	while (len > 0) {
+		if ((k = hex_to_bin(in_str[len--])) != -1)
 			out[i] = k;
 		else
 			return 0;
 
-		if (j == 0)
+		if (len == 0)
 			break;
-		if ((k = hex_to_bin(in_str[j--])) != -1)
+		if ((k = hex_to_bin(in_str[len--])) != -1)
 			out[i] += k << 4;
 		else
 			return 0;
 		if (!i--)
 			break;
 	}
-	return status;
+	return 1;
 }
 
 /*===========================================================================*/
diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 8108f941ccd3..b1d3aea10d7d 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1463,10 +1463,8 @@ static void rsi_shutdown(struct device *dev)
 
 	rsi_dbg(ERR_ZONE, "SDIO Bus shutdown =====>\n");
 
-	if (hw) {
-		struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
-
-		if (rsi_config_wowlan(adapter, wowlan))
+	if (hw && hw->wiphy && hw->wiphy->wowlan_config) {
+		if (rsi_config_wowlan(adapter, hw->wiphy->wowlan_config))
 			rsi_dbg(ERR_ZONE, "Failed to configure WoWLAN\n");
 	}
 
@@ -1481,9 +1479,6 @@ static void rsi_shutdown(struct device *dev)
 	if (sdev->write_fail)
 		rsi_dbg(INFO_ZONE, "###### Device is not ready #######\n");
 
-	if (rsi_set_sdio_pm_caps(adapter))
-		rsi_dbg(INFO_ZONE, "Setting power management caps failed\n");
-
 	rsi_dbg(INFO_ZONE, "***** RSI module shut down *****\n");
 }
 
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index ccf6344ed6fd..4c408fd7c159 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -134,7 +134,7 @@ static const struct {
 
 /**
  * iw_valid_channel - validate channel in regulatory domain
- * @reg_comain: regulatory domain
+ * @reg_domain: regulatory domain
  * @channel: channel to validate
  *
  * Returns 0 if invalid in the specified regulatory domain, non-zero if valid.
@@ -458,11 +458,9 @@ static int wl3501_pwr_mgmt(struct wl3501_card *this, int suspend)
 /**
  * wl3501_send_pkt - Send a packet.
  * @this: Card
- *
- * Send a packet.
- *
- * data = Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
+ * @data: Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
  *                                   data[6] - data[11] is Src MAC Addr)
+ * @len: Packet length
  * Ref: IEEE 802.11
  */
 static int wl3501_send_pkt(struct wl3501_card *this, u8 *data, u16 len)
@@ -1864,6 +1862,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 {
 	struct net_device *dev;
 	struct wl3501_card *this;
+	int ret;
 
 	/* The io structure describes IO port mapping */
 	p_dev->resource[0]->end	= 16;
@@ -1875,8 +1874,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 
 	dev = alloc_etherdev(sizeof(struct wl3501_card));
 	if (!dev)
-		goto out_link;
-
+		return -ENOMEM;
 
 	dev->netdev_ops		= &wl3501_netdev_ops;
 	dev->watchdog_timeo	= 5 * HZ;
@@ -1889,9 +1887,15 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 	netif_stop_queue(dev);
 	p_dev->priv = dev;
 
-	return wl3501_config(p_dev);
-out_link:
-	return -ENOMEM;
+	ret = wl3501_config(p_dev);
+	if (ret)
+		goto out_free_etherdev;
+
+	return 0;
+
+out_free_etherdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static int wl3501_config(struct pcmcia_device *link)
@@ -1947,8 +1951,7 @@ static int wl3501_config(struct pcmcia_device *link)
 		goto failed;
 	}
 
-	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = ((char *)&this->mac_addr)[i];
+	eth_hw_addr_set(dev, this->mac_addr);
 
 	/* print probe information */
 	printk(KERN_INFO "%s: wl3501 @ 0x%3.3x, IRQ %d, "
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 71428d8cbcfc..ac401ad7884a 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1344,12 +1344,17 @@ static struct pci_driver amd_ntb_pci_driver = {
 
 static int __init amd_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&amd_ntb_pci_driver);
+	ret = pci_register_driver(&amd_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(amd_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index d54261f50851..99711dd0b6e8 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2902,6 +2902,7 @@ static struct pci_driver idt_pci_driver = {
 
 static int __init idt_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	/* Create the top DebugFS directory if the FS is initialized */
@@ -2909,7 +2910,11 @@ static int __init idt_pci_driver_init(void)
 		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* Register the NTB hardware driver to handle the PCI device */
-	return pci_register_driver(&idt_pci_driver);
+	ret = pci_register_driver(&idt_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(dbgfs_topdir);
+
+	return ret;
 }
 module_init(idt_pci_driver_init);
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 093dd20057b9..4f1add57d81d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -2068,12 +2068,17 @@ static struct pci_driver intel_ntb_pci_driver = {
 
 static int __init intel_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&intel_ntb_pci_driver);
+	ret = pci_register_driver(&intel_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(intel_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4a02561cfb96..d18cb4476560 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -412,7 +412,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
 		rc = device_register(dev);
 		if (rc) {
-			kfree(client_dev);
+			put_device(dev);
 			goto err;
 		}
 
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 5ee0afa621a9..eeeb4b1c97d2 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
 		tc->peers[pidx].outmws =
 			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
 				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
+		if (tc->peers[pidx].outmws == NULL)
+			return -ENOMEM;
 
 		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
 			tc->peers[pidx].outmws[widx].pidx = pidx;
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 88e1f9a0faaf..78cf0e7b53d5 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -137,6 +137,18 @@ static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int nubus_rsrc_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nubus_proc_rsrc_show, inode);
+}
+
+static const struct proc_ops nubus_rsrc_proc_ops = {
+	.proc_open	= nubus_rsrc_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
 void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 			     const struct nubus_dirent *ent,
 			     unsigned int size)
@@ -152,8 +164,8 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 		pde_data = nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
 	else
 		pde_data = NULL;
-	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show, pde_data);
+	proc_create_data(name, S_IFREG | 0444, procdir,
+			 &nubus_rsrc_proc_ops, pde_data);
 }
 
 void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
@@ -166,9 +178,9 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
-	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show,
-			nubus_proc_alloc_pde_data(data, 0));
+	proc_create_data(name, S_IFREG | 0444, procdir,
+			 &nubus_rsrc_proc_ops,
+			 nubus_proc_alloc_pde_data(data, 0));
 }
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c47512da9872..3aaead9b3a57 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -968,7 +968,8 @@ static void nvme_pci_complete_rq(struct request *req)
 
 	if (blk_integrity_rq(req))
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
+			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
 	nvme_complete_rq(req);
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fb96d37a135c..4d8d15ac51ef 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -12,6 +12,8 @@
 
 #include "pcie-cadence.h"
 
+#define LINK_RETRAIN_TIMEOUT HZ
+
 static u64 bar_max_size[] = {
 	[RP_BAR0] = _ULL(128 * SZ_2G),
 	[RP_BAR1] = SZ_2G,
@@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
+{
+	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	unsigned long end_jiffies;
+	u16 lnk_stat;
+
+	/* Wait for link training to complete. Exit after timeout. */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+			break;
+		usleep_range(0, 1000);
+	} while (time_before(jiffies, end_jiffies));
+
+	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
 static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
 		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
 				    lnk_ctl);
 
+		ret = cdns_pcie_host_training_complete(pcie);
+		if (ret)
+			return ret;
+
 		ret = cdns_pcie_host_wait_for_link(pcie);
 	}
 	return ret;
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c68e14271c02..737cc9d6fa6a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -771,6 +771,8 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 			return PTR_ERR(res->phy_ahb_reset);
 	}
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index aefef1986201..80cfea5d9f12 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -442,22 +442,12 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	p->dev = dev;
 
 	/* Retrieve and enable optional clocks */
-	clk = devm_clk_get(dev, "PCLK");
+	clk = devm_clk_get_enabled(dev, "PCLK");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "could not prepare PCLK\n");
-		return ret;
-	}
-	p->bus_clk = devm_clk_get(dev, "PCICLK");
+	p->bus_clk = devm_clk_get_enabled(dev, "PCICLK");
 	if (IS_ERR(p->bus_clk))
 		return PTR_ERR(p->bus_clk);
-	ret = clk_prepare_enable(p->bus_clk);
-	if (ret) {
-		dev_err(dev, "could not prepare PCICLK\n");
-		return ret;
-	}
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 379cde59988c..dba8bdc3fc94 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -125,6 +125,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 					 struct pci_epf_header *hdr)
 {
+	u32 reg;
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
@@ -137,8 +138,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
-	rockchip_pcie_write(rockchip, hdr->deviceid << 16,
-			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) + PCI_VENDOR_ID);
+	reg = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_DID_VID);
+	reg = (reg & 0xFFFF) | (hdr->deviceid << 16);
+	rockchip_pcie_write(rockchip, reg, PCIE_EP_CONFIG_DID_VID);
 
 	rockchip_pcie_write(rockchip,
 			    hdr->revid |
@@ -312,15 +314,15 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags;
+	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
 				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK;
 	flags |=
-	   ((multi_msg_cap << 1) <<  ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
-	   PCI_MSI_FLAGS_64BIT;
+	   (multi_msg_cap << ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
+	   (PCI_MSI_FLAGS_64BIT << ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP;
 	rockchip_pcie_write(rockchip, flags,
 			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
@@ -332,7 +334,7 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags;
+	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
@@ -345,48 +347,25 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 }
 
 static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
-					 u8 intx, bool is_asserted)
+					 u8 intx, bool do_assert)
 {
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u32 r = ep->max_regions - 1;
-	u32 offset;
-	u32 status;
-	u8 msg_code;
-
-	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
-		     ep->irq_pci_fn != fn)) {
-		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
-					     AXI_WRAPPER_NOR_MSG,
-					     ep->irq_phys_addr, 0, 0);
-		ep->irq_pci_addr = ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR;
-		ep->irq_pci_fn = fn;
-	}
 
 	intx &= 3;
-	if (is_asserted) {
+
+	if (do_assert) {
 		ep->irq_pending |= BIT(intx);
-		msg_code = ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA + intx;
+		rockchip_pcie_write(rockchip,
+				    PCIE_CLIENT_INT_IN_ASSERT |
+				    PCIE_CLIENT_INT_PEND_ST_PEND,
+				    PCIE_CLIENT_LEGACY_INT_CTRL);
 	} else {
 		ep->irq_pending &= ~BIT(intx);
-		msg_code = ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA + intx;
+		rockchip_pcie_write(rockchip,
+				    PCIE_CLIENT_INT_IN_DEASSERT |
+				    PCIE_CLIENT_INT_PEND_ST_NORMAL,
+				    PCIE_CLIENT_LEGACY_INT_CTRL);
 	}
-
-	status = rockchip_pcie_read(rockchip,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
-	status &= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-
-	if ((status != 0) ^ (ep->irq_pending != 0)) {
-		status ^= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-		rockchip_pcie_write(rockchip, status,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
-	}
-
-	offset =
-	   ROCKCHIP_PCIE_MSG_ROUTING(ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX) |
-	   ROCKCHIP_PCIE_MSG_CODE(msg_code) | ROCKCHIP_PCIE_MSG_NO_DATA;
-	writel(0, ep->irq_cpu_addr + offset);
 }
 
 static int rockchip_pcie_ep_send_legacy_irq(struct rockchip_pcie_ep *ep, u8 fn,
@@ -416,7 +395,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 					 u8 interrupt_num)
 {
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags, mme, data, data_mask;
+	u32 flags, mme, data, data_mask;
 	u8 msi_count;
 	u64 pci_addr, pci_addr_mask = 0xff;
 
@@ -506,6 +485,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = 256,
 };
 
 static const struct pci_epc_features*
@@ -631,6 +611,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
+			    PCIE_CLIENT_CONFIG);
+
 	return 0;
 err_epc_mem_exit:
 	pci_epc_mem_exit(epc);
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 990a00e08bc5..1aa84035a8bc 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -153,6 +154,12 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
 
+#define rockchip_pcie_read_addr(addr) rockchip_pcie_read(rockchip, addr)
+/* 100 ms max wait time for PHY PLLs to lock */
+#define RK_PHY_PLL_LOCK_TIMEOUT_US 100000
+/* Sleep should be less than 20ms */
+#define RK_PHY_PLL_LOCK_SLEEP_US 1000
+
 int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
@@ -254,6 +261,16 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
+	err = readx_poll_timeout(rockchip_pcie_read_addr,
+				 PCIE_CLIENT_SIDE_BAND_STATUS,
+				 regs, !(regs & PCIE_CLIENT_PHY_ST),
+				 RK_PHY_PLL_LOCK_SLEEP_US,
+				 RK_PHY_PLL_LOCK_TIMEOUT_US);
+	if (err) {
+		dev_err(dev, "PHY PLLs could not lock, %d\n", err);
+		goto err_power_off_phy;
+	}
+
 	/*
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index c7d0178fc8c2..76a5f96bfd0a 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -37,6 +37,13 @@
 #define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
 #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
+#define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
+#define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
+#define   PCIE_CLIENT_INT_IN_DEASSERT		HIWORD_UPDATE(0x0002, 0)
+#define   PCIE_CLIENT_INT_PEND_ST_PEND		HIWORD_UPDATE_BIT(0x0001)
+#define   PCIE_CLIENT_INT_PEND_ST_NORMAL	HIWORD_UPDATE(0x0001, 0)
+#define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
+#define   PCIE_CLIENT_PHY_ST			BIT(12)
 #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
 #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
@@ -132,6 +139,8 @@
 #define PCIE_RC_RP_ATS_BASE		0x400000
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define   PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
@@ -223,6 +232,7 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET		20
@@ -230,7 +240,6 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
-#define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..32baba1b7f13 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -256,6 +256,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (present <= 0 && link_active <= 0) {
+		if (ctrl->state == BLINKINGON_STATE) {
+			ctrl->state = OFF_STATE;
+			cancel_delayed_work(&ctrl->button_work);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      INDICATOR_NOOP);
+			ctrl_info(ctrl, "Slot(%s): Card not present\n",
+				  slot_name(ctrl));
+		}
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d37013d007b6..1f8106ec7094 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2830,13 +2830,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 	{
 		/*
 		 * Downstream device is not accessible after putting a root port
-		 * into D3cold and back into D0 on Elo i2.
+		 * into D3cold and back into D0 on Elo Continental Z2 board
 		 */
-		.ident = "Elo i2",
+		.ident = "Elo Continental Z2",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Elo Touch Solutions"),
+			DMI_MATCH(DMI_BOARD_NAME, "Geminilake"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
 #endif
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..51da8ba67d21 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -993,21 +993,24 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	/*
-	 * All PCIe functions are in one slot, remove one function will remove
-	 * the whole slot, so just wait until we are the last function left.
-	 */
-	if (!list_empty(&parent->subordinate->devices))
-		goto out;
 
 	link = parent->link_state;
 	root = link->root;
 	parent_link = link->parent;
 
-	/* All functions are removed, so just disable ASPM for the link */
+	/*
+	 * link->downstream is a pointer to the pci_dev of function 0.  If
+	 * we remove that function, the pci_dev is about to be deallocated,
+	 * so we can't use link->downstream again.  Free the link state to
+	 * avoid this.
+	 *
+	 * If we're removing a non-0 function, it's possible we could
+	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
+	 * programming the same ASPM Control value for all functions of
+	 * multi-function devices, so disable ASPM for all of them.
+	 */
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
-	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
 	/* Recheck latencies and configure upstream links */
@@ -1015,7 +1018,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_update_aspm_capable(root);
 		pcie_config_aspm_path(parent_link);
 	}
-out:
+
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c1ebd5e12b06..c0d113481191 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4123,6 +4123,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index bb019e383988..36061aaf026c 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1254,9 +1254,10 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
 	if (dtc->irq < 0)
 		return dtc->irq;
 
-	writel_relaxed(0, dtc->base + CMN_DT_PMCR);
+	writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
+	writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN, dtc->base + CMN_DT_PMCR);
+	writeq_relaxed(0, dtc->base + CMN_DT_PMCCNTR);
 	writel_relaxed(0x1ff, dtc->base + CMN_DT_PMOVSR_CLR);
-	writel_relaxed(CMN_DT_PMCR_OVFL_INTR_EN, dtc->base + CMN_DT_PMCR);
 
 	/* We do at least know that a DTC's XP must be in that DTC's domain */
 	xp = arm_cmn_node_to_xp(dn);
@@ -1303,7 +1304,7 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 			dn->type = CMN_TYPE_RNI;
 	}
 
-	writel_relaxed(CMN_DT_DTC_CTL_DT_EN, cmn->dtc[0].base + CMN_DT_DTC_CTL);
+	arm_cmn_set_state(cmn, CMN_STATE_DISABLED);
 
 	return 0;
 }
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index d07f33ec7939..8f11b293c48d 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -556,6 +556,7 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 		usb_role_switch_unregister(port->usb_role_sw);
 		cancel_work_sync(&port->usb_phy_work);
 		usb_remove_phy(&port->usb_phy);
+		port->usb_phy.dev->driver = NULL;
 	}
 
 	if (port->ops->remove)
@@ -662,6 +663,9 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	port->dev.driver = devm_kzalloc(&port->dev,
 					sizeof(struct device_driver),
 					GFP_KERNEL);
+	if (!port->dev.driver)
+		return -ENOMEM;
+
 	port->dev.driver->owner	 = THIS_MODULE;
 
 	port->usb_role_sw = usb_role_switch_register(&port->dev,
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index c7ae9f900b53..e3f49d0ed029 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -359,10 +359,8 @@ static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
 	if (!pctldev)
 		return 0;
 
-	gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
-			       gc->ngpio);
-
-	return 0;
+	return gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
+				      gc->ngpio);
 }
 
 static const struct gpio_chip bcm2835_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 2ed17cdf946d..44caada37b71 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -945,11 +945,6 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		break;
 
-	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
-			return -EINVAL;
-		break;
-
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE: {
 		u32 cfg;
 
@@ -959,6 +954,16 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 			return -EINVAL;
 
 		break;
+
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (ctrl1 & CHV_PADCTRL1_ODEN)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
+			return -EINVAL;
+		break;
 	}
 
 	default:
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 82b658a3c220..3a05ebb9aa25 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -126,6 +126,14 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+
+	/* Use special handling for Pin0 debounce */
+	if (offset == 0) {
+		pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+		if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+			debounce = 0;
+	}
+
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
 	if (debounce) {
@@ -181,18 +189,6 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -215,6 +211,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *output_value;
 	char *output_enable;
 
+	seq_printf(s, "WAKE_INT_MASTER_REG: 0x%08x\n", readl(gpio_dev->base + WAKE_INT_MASTER_REG));
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
 		seq_printf(s, "GPIO bank%d\t", bank);
 
@@ -667,7 +664,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -757,6 +754,20 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		u32 debounce = pinconf_to_config_argument(config);
+
+		return amd_gpio_set_debounce(gc, pin, debounce);
+	}
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,
@@ -784,9 +795,9 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
-		pin_reg = readl(gpio_dev->base + i * 4);
+		pin_reg = readl(gpio_dev->base + pin * 4);
 		pin_reg &= ~mask;
-		writel(pin_reg, gpio_dev->base + i * 4);
+		writel(pin_reg, gpio_dev->base + pin * 4);
 
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 95e763424042..9f95ec9e2201 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -17,6 +17,7 @@
 #define AMD_GPIO_PINS_BANK3     32
 
 #define WAKE_INT_MASTER_REG 0xfc
+#define INTERNAL_GPIO0_DEBOUNCE (1 << 15)
 #define EOI_MASK (1 << 29)
 
 #define WAKE_INT_STATUS_REG0 0x2f8
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 315a6c4d9ade..bf8aa0ea35d1 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1083,6 +1083,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		/* Pin naming convention: P(bank_name)(bank_pin_number). */
 		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%d",
 						  bank + 'A', line);
+		if (!pin_desc[i].name)
+			return -ENOMEM;
 
 		group->name = group_names[i] = pin_desc[i].name;
 		group->pin = pin_desc[i].number;
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1f80b2628162..567c28705cb1 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -40,7 +40,7 @@ MODULE_LICENSE("GPL");
 static LIST_HEAD(wmi_block_list);
 
 struct guid_block {
-	char guid[16];
+	guid_t guid;
 	union {
 		char object_id[2];
 		struct {
@@ -121,7 +121,7 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	list_for_each_entry(wblock, &wmi_block_list, list) {
 		block = &wblock->gblock;
 
-		if (memcmp(block->guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->guid, &guid_input)) {
 			if (out)
 				*out = wblock;
 			return true;
@@ -130,11 +130,20 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	return false;
 }
 
+static bool guid_parse_and_compare(const char *string, const guid_t *guid)
+{
+	guid_t guid_input;
+
+	if (guid_parse(string, &guid_input))
+		return false;
+
+	return guid_equal(&guid_input, guid);
+}
+
 static const void *find_guid_context(struct wmi_block *wblock,
 				      struct wmi_driver *wdriver)
 {
 	const struct wmi_device_id *id;
-	guid_t guid_input;
 
 	if (wblock == NULL || wdriver == NULL)
 		return NULL;
@@ -143,9 +152,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 
 	id = wdriver->id_table;
 	while (*id->guid_string) {
-		if (guid_parse(id->guid_string, &guid_input))
-			continue;
-		if (!memcmp(wblock->gblock.guid, &guid_input, 16))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return id->context;
 		id++;
 	}
@@ -457,7 +464,7 @@ EXPORT_SYMBOL_GPL(wmi_set_block);
 
 static void wmi_dump_wdg(const struct guid_block *g)
 {
-	pr_info("%pUL:\n", g->guid);
+	pr_info("%pUL:\n", &g->guid);
 	if (g->flags & ACPI_WMI_EVENT)
 		pr_info("\tnotify_id: 0x%02X\n", g->notify_id);
 	else
@@ -539,7 +546,7 @@ wmi_notify_handler handler, void *data)
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->gblock.guid, &guid_input)) {
 			if (block->handler &&
 			    block->handler != wmi_notify_debug)
 				return AE_ALREADY_ACQUIRED;
@@ -579,7 +586,7 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->gblock.guid, &guid_input)) {
 			if (!block->handler ||
 			    block->handler == wmi_notify_debug)
 				return AE_NULL_ENTRY;
@@ -615,7 +622,6 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 {
 	struct acpi_object_list input;
 	union acpi_object params[1];
-	struct guid_block *gblock;
 	struct wmi_block *wblock;
 
 	input.count = 1;
@@ -624,7 +630,7 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 	params[0].integer.value = event;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		gblock = &wblock->gblock;
+		struct guid_block *gblock = &wblock->gblock;
 
 		if ((gblock->flags & ACPI_WMI_EVENT) &&
 			(gblock->notify_id == event))
@@ -685,7 +691,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "wmi:%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "wmi:%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -694,7 +700,7 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(guid);
 
@@ -777,10 +783,10 @@ static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, "WMI_GUID=%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "WMI_GUID=%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
 	return 0;
@@ -804,11 +810,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 		return 0;
 
 	while (*id->guid_string) {
-		guid_t driver_guid;
-
-		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
-			continue;
-		if (!memcmp(&driver_guid, wblock->gblock.guid, 16))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return 1;
 
 		id++;
@@ -1042,7 +1044,6 @@ static const struct device_type wmi_type_data = {
 };
 
 static int wmi_create_device(struct device *wmi_bus_dev,
-			     const struct guid_block *gblock,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
 {
@@ -1050,12 +1051,12 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	char method[5];
 	int result;
 
-	if (gblock->flags & ACPI_WMI_EVENT) {
+	if (wblock->gblock.flags & ACPI_WMI_EVENT) {
 		wblock->dev.dev.type = &wmi_type_event;
 		goto out_init;
 	}
 
-	if (gblock->flags & ACPI_WMI_METHOD) {
+	if (wblock->gblock.flags & ACPI_WMI_METHOD) {
 		wblock->dev.dev.type = &wmi_type_method;
 		mutex_init(&wblock->char_mutex);
 		goto out_init;
@@ -1105,7 +1106,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	wblock->dev.dev.bus = &wmi_bus_type;
 	wblock->dev.dev.parent = wmi_bus_dev;
 
-	dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
+	dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
 
 	device_initialize(&wblock->dev.dev);
 
@@ -1125,12 +1126,12 @@ static void wmi_free_devices(struct acpi_device *device)
 	}
 }
 
-static bool guid_already_parsed(struct acpi_device *device, const u8 *guid)
+static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
 {
 	struct wmi_block *wblock;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		if (memcmp(wblock->gblock.guid, guid, 16) == 0) {
+		if (guid_equal(&wblock->gblock.guid, guid)) {
 			/*
 			 * Because we historically didn't track the relationship
 			 * between GUIDs and ACPI nodes, we don't know whether
@@ -1185,7 +1186,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		 * case yet, so for now, we'll just ignore the duplicate
 		 * for device creation.
 		 */
-		if (guid_already_parsed(device, gblock[i].guid))
+		if (guid_already_parsed(device, &gblock[i].guid))
 			continue;
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
@@ -1197,7 +1198,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		retval = wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
+		retval = wmi_create_device(wmi_bus_dev, wblock, device);
 		if (retval) {
 			kfree(wblock);
 			continue;
@@ -1222,7 +1223,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		retval = device_add(&wblock->dev.dev);
 		if (retval) {
 			dev_err(wmi_bus_dev, "failed to register %pUL\n",
-				wblock->gblock.guid);
+				&wblock->gblock.guid);
 			if (debug_event)
 				wmi_method_enable(wblock, 0);
 			list_del(&wblock->list);
@@ -1282,12 +1283,11 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 				    void *context)
 {
-	struct guid_block *block;
 	struct wmi_block *wblock;
 	bool found_it = false;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		block = &wblock->gblock;
+		struct guid_block *block = &wblock->gblock;
 
 		if (wblock->acpi_device->handle == handle &&
 		    (block->flags & ACPI_WMI_EVENT) &&
@@ -1336,7 +1336,7 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 	}
 
 	if (debug_event)
-		pr_info("DEBUG Event GUID: %pUL\n", wblock->gblock.guid);
+		pr_info("DEBUG Event GUID: %pUL\n", &wblock->gblock.guid);
 
 	acpi_bus_generate_netlink_event(
 		wblock->acpi_device->pnp.device_class,
diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index bc228725346b..0e4b2c214a70 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -18,10 +18,12 @@ if POWERCAP
 # Client driver configurations go here.
 config INTEL_RAPL_CORE
 	tristate
+	depends on PCI
+	select IOSF_MBI
 
 config INTEL_RAPL
 	tristate "Intel RAPL Support via MSR Interface"
-	depends on X86 && IOSF_MBI
+	depends on X86 && PCI
 	select INTEL_RAPL_CORE
 	help
 	  This enables support for the Intel Running Average Power Limit (RAPL)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 1646808d354c..6b68e5ed2081 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -22,7 +22,6 @@
 #include <linux/processor.h>
 #include <linux/platform_device.h>
 
-#include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index fcdf6befb838..871527b78aa4 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -403,6 +403,13 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
 	if (tpm->enable_count > 0)
 		return -EBUSY;
 
+	/*
+	 * Force 'real_period' to be zero to force period update code
+	 * can be executed after system resume back, since suspend causes
+	 * the period related registers to become their reset values.
+	 */
+	tpm->real_period = 0;
+
 	clk_disable_unprepare(tpm->clk);
 
 	return 0;
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9903c3a7eced..b8417a8d2ef9 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -424,6 +424,13 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 		if (!export)
 			continue;
 
+		/* If pwmchip was not enabled before suspend, do nothing. */
+		if (!export->suspend.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
 		state.enabled = export->suspend.enabled;
 		ret = pwm_class_apply_state(export, pwm, &state);
 		if (ret < 0)
@@ -448,7 +455,17 @@ static int __maybe_unused pwm_class_suspend(struct device *parent)
 		if (!export)
 			continue;
 
+		/*
+		 * If pwmchip was not enabled before suspend, save
+		 * state for resume time and do nothing else.
+		 */
 		export->suspend = state;
+		if (!state.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
 		state.enabled = false;
 		ret = pwm_class_apply_state(export, pwm, &state);
 		if (ret < 0) {
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f5ab74683b58..52b75779dbb7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1751,19 +1751,17 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
 	if (err != -EEXIST)
 		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
-	if (!regulator->debugfs) {
+	if (IS_ERR(regulator->debugfs))
 		rdev_dbg(rdev, "Failed to create debugfs directory\n");
-	} else {
-		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
-				   &regulator->uA_load);
-		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
-				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
-		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
-				   &regulator->voltage[PM_SUSPEND_ON].max_uV);
-		debugfs_create_file("constraint_flags", 0444,
-				    regulator->debugfs, regulator,
-				    &constraint_flags_fops);
-	}
+
+	debugfs_create_u32("uA_load", 0444, regulator->debugfs,
+			   &regulator->uA_load);
+	debugfs_create_u32("min_uV", 0444, regulator->debugfs,
+			   &regulator->voltage[PM_SUSPEND_ON].min_uV);
+	debugfs_create_u32("max_uV", 0444, regulator->debugfs,
+			   &regulator->voltage[PM_SUSPEND_ON].max_uV);
+	debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
+			    regulator, &constraint_flags_fops);
 
 	/*
 	 * Check now if the regulator is an always on regulator - if
@@ -5032,10 +5030,8 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (IS_ERR(rdev->debugfs)) {
-		rdev_warn(rdev, "Failed to create debugfs directory\n");
-		return;
-	}
+	if (IS_ERR(rdev->debugfs))
+		rdev_dbg(rdev, "Failed to create debugfs directory\n");
 
 	debugfs_create_u32("use_count", 0444, rdev->debugfs,
 			   &rdev->use_count);
@@ -5938,7 +5934,7 @@ static int __init regulator_init(void)
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
 	if (IS_ERR(debugfs_root))
-		pr_warn("regulator: Failed to create debugfs directory\n");
+		pr_debug("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 7d53f7e2febc..c4ea3f3f0884 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -228,7 +228,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 	enable_irq_wake(rtc->irq);
 	disable_irq(rtc->irq);
 
-	rtc->clk = clk_get(&pdev->dev, NULL);
+	rtc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rtc->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		return PTR_ERR(rtc->clk);
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 997fbb7006a7..316f8622f3cc 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -652,7 +652,7 @@ static QETH_DEVICE_ATTR(vipa_add4, add4, 0644,
 static ssize_t qeth_l3_dev_vipa_del4_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	return qeth_l3_vipa_store(dev, buf, true, count, QETH_PROT_IPV4);
+	return qeth_l3_vipa_store(dev, buf, false, count, QETH_PROT_IPV4);
 }
 
 static QETH_DEVICE_ATTR(vipa_del4, del4, 0200, NULL,
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index fb6444d0409c..211a25351e7d 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2308,8 +2308,10 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	TW_DISABLE_INTERRUPTS(tw_dev);
 
 	/* Initialize the card */
-	if (tw_reset_sequence(tw_dev))
+	if (tw_reset_sequence(tw_dev)) {
+		retval = -EINVAL;
 		goto out_release_mem_region;
+	}
 
 	/* Set host specific parameters */
 	host->max_id = TW_MAX_UNITS;
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index f48ef47546f4..b33cb1172f31 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3042,9 +3042,8 @@ static int qedf_alloc_global_queues(struct qedf_ctx *qedf)
 	 * addresses of our queues
 	 */
 	if (!qedf->p_cpuq) {
-		status = -EINVAL;
 		QEDF_ERR(&qedf->dbg_ctx, "p_cpuq is NULL.\n");
-		goto mem_alloc_failure;
+		return -EINVAL;
 	}
 
 	qedf->global_queues = kzalloc((sizeof(struct global_queue *)
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 61b9dc511d90..12e27ee8c5c7 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2698,6 +2698,7 @@ static void
 qla2x00_terminate_rport_io(struct fc_rport *rport)
 {
 	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+	scsi_qla_host_t *vha;
 
 	if (!fcport)
 		return;
@@ -2707,9 +2708,12 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 
 	if (test_bit(ABORT_ISP_ACTIVE, &fcport->vha->dpc_flags))
 		return;
+	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
 		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+			0, WAIT_TARGET);
 		return;
 	}
 	/*
@@ -2724,6 +2728,15 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 		else
 			qla2x00_port_logout(fcport->vha, fcport);
 	}
+
+	/* check for any straggling io left behind */
+	if (qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x300b,
+		       "IO not return.  Resetting. \n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
 }
 
 static int
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 1fd292a6ac88..804cac4c3476 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -268,6 +268,10 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport) {
+			rval = -ENOMEM;
+			goto done;
+		}
 		fcport = *(fc_port_t **) rport->dd_data;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
@@ -2541,6 +2545,8 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport)
+			return ret;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
 	} else {
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 6afce455b9d8..06b0ad2b51bb 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -639,7 +639,6 @@ typedef struct srb {
 	struct iocb_resource iores;
 	struct kref cmd_kref;	/* need to migrate ref_count over to this */
 	void *priv;
-	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
 	unsigned int start_timer:1;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 422ff67038d1..3d1a53ba86ac 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5107,7 +5107,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index e80e41b6c9e1..7e8b59a0954b 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -109,11 +109,13 @@ qla2x00_set_fcport_disc_state(fc_port_t *fcport, int state)
 {
 	int old_val;
 	uint8_t shiftbits, mask;
+	uint8_t port_dstate_str_sz;
 
 	/* This will have to change when the max no. of states > 16 */
 	shiftbits = 4;
 	mask = (1 << shiftbits) - 1;
 
+	port_dstate_str_sz = sizeof(port_dstate_str) / sizeof(char *);
 	fcport->disc_state = state;
 	while (1) {
 		old_val = atomic_read(&fcport->shadow_disc_state);
@@ -121,7 +123,8 @@ qla2x00_set_fcport_disc_state(fc_port_t *fcport, int state)
 		    old_val, (old_val << shiftbits) | state)) {
 			ql_dbg(ql_dbg_disc, fcport->vha, 0x2134,
 			    "FCPort %8phC disc_state transition: %s to %s - portid=%06x.\n",
-			    fcport->port_name, port_dstate_str[old_val & mask],
+			    fcport->port_name, (old_val & mask) < port_dstate_str_sz ?
+				    port_dstate_str[old_val & mask] : "Unknown",
 			    port_dstate_str[state], fcport->d_id.b24);
 			return;
 		}
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index e54cc2a761dd..54fc0afbc02a 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -601,7 +601,8 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
 	put_unaligned_le32(COMMAND_TYPE_6, &cmd_pkt->entry_type);
 
 	/* No data transfer */
-	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE) {
+	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE ||
+	    tot_dsds == 0) {
 		cmd_pkt->byte_count = cpu_to_le32(0);
 		return 0;
 	}
@@ -3713,7 +3714,7 @@ qla2x00_start_sp(srb_t *sp)
 	spin_lock_irqsave(qp->qp_lock_ptr, flags);
 	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
 	if (!pkt) {
-		rval = EAGAIN;
+		rval = -EAGAIN;
 		ql_log(ql_log_warn, vha, 0x700c,
 		    "qla2x00_alloc_iocbs failed.\n");
 		goto done;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 695dd89be330..8b0c8f9bdef0 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -331,7 +331,6 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x700e,
 		    "qla2x00_start_sp failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2x00_rel_sp(sp);
@@ -590,7 +589,6 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (!sp)
 		return -EBUSY;
 
-	init_waitqueue_head(&sp->nvme_ls_waitq);
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
 	sp->priv = priv;
@@ -608,7 +606,6 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2xxx_rel_qpair_sp(sp->qpair, sp);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 38b8ff87ec0a..cbc5af26303a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4877,7 +4877,8 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, vha->host_no);
+	snprintf(vha->host_str, sizeof(vha->host_str), "%s_%lu",
+		 QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,
diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index fff92e2f3974..090a32666475 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -103,7 +103,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(ACODEC,	0),
 	SEC_PD(AUDIO,	0),
 	SEC_PD(OTP,	0),
-	SEC_PD(DMA,	0),
+	SEC_PD(DMA,	GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAFE),
 	SEC_PD(SD_EMMC,	0),
 	SEC_PD(RAMA,	0),
 	/* SRAMB is used as ATF runtime memory, and should be always on */
diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index 357c5800b112..7afa796dbbb8 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -39,6 +39,7 @@ config QE_TDM
 
 config QE_USB
 	bool
+	depends on QUICC_ENGINE
 	default y if USB_FSL_QE
 	help
 	  QE USB Controller support
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 766b00350e39..2c734ea0784b 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1369,13 +1369,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "mspi");
 
-	if (res) {
-		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qspi->base[MSPI]))
-			return PTR_ERR(qspi->base[MSPI]);
-	} else {
-		return 0;
-	}
+	qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qspi->base[MSPI]))
+		return PTR_ERR(qspi->base[MSPI]);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
 	if (res) {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 96d075e633f4..d36384fef0d7 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -126,7 +126,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 01ef79f15b02..be259c685cc8 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -32,7 +32,7 @@
 #define CS_DEMUX_OUTPUT_SEL	GENMASK(3, 0)
 
 #define SE_SPI_TRANS_CFG	0x25c
-#define CS_TOGGLE		BIT(0)
+#define CS_TOGGLE		BIT(1)
 
 #define SE_SPI_WORD_LEN		0x268
 #define WORD_LEN_MSK		GENMASK(9, 0)
diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 20c19e08968e..613bd9620224 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -5243,7 +5243,7 @@ static int atomisp_set_fmt_to_isp(struct video_device *vdev,
 	int (*configure_pp_input)(struct atomisp_sub_device *asd,
 				  unsigned int width, unsigned int height) =
 				      configure_pp_input_nop;
-	u16 stream_index = atomisp_source_pad_to_stream_id(asd, source_pad);
+	u16 stream_index;
 	const struct atomisp_in_fmt_conv *fc;
 	int ret, i;
 
@@ -5252,6 +5252,7 @@ static int atomisp_set_fmt_to_isp(struct video_device *vdev,
 			__func__, vdev->name);
 		return -EINVAL;
 	}
+	stream_index = atomisp_source_pad_to_stream_id(asd, source_pad);
 
 	v4l2_fh_init(&fh.vfh, vdev);
 
diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index c9ee85037644..f0387486eb17 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1198,7 +1198,7 @@ static int gmin_get_config_dsm_var(struct device *dev,
 	dev_info(dev, "found _DSM entry for '%s': %s\n", var,
 		 cur->string.pointer);
 	strscpy(out, cur->string.pointer, *out_len);
-	*out_len = strlen(cur->string.pointer);
+	*out_len = strlen(out);
 
 	ACPI_FREE(obj);
 	return 0;
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 8a0648fd7c81..4615e4cae718 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1123,7 +1123,7 @@ int __atomisp_reqbufs(struct file *file, void *fh,
 	struct ia_css_frame *frame;
 	struct videobuf_vmalloc_memory *vm_mem;
 	u16 source_pad = atomisp_subdev_source_pad(vdev);
-	u16 stream_id = atomisp_source_pad_to_stream_id(asd, source_pad);
+	u16 stream_id;
 	int ret = 0, i = 0;
 
 	if (!asd) {
@@ -1131,6 +1131,7 @@ int __atomisp_reqbufs(struct file *file, void *fh,
 			__func__, vdev->name);
 		return -EINVAL;
 	}
+	stream_id = atomisp_source_pad_to_stream_id(asd, source_pad);
 
 	if (req->count == 0) {
 		mutex_lock(&pipe->capq.vb_lock);
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 9fe169dbed88..0bd7aa564bc2 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1026,12 +1026,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
-	if (IS_ERR(auxadc_base)) {
-		of_node_put(auxadc);
-		return PTR_ERR(auxadc_base);
-	}
-
+	auxadc_base = of_iomap(auxadc, 0);
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1047,12 +1042,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
-	if (IS_ERR(apmixed_base)) {
-		of_node_put(apmixedsys);
-		return PTR_ERR(apmixed_base);
-	}
-
+	apmixed_base = of_iomap(apmixedsys, 0);
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f8b13071a6f4..e053b0628017 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -318,6 +318,11 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	return ret;
 }
 
+static void sun8i_ths_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int sun8i_ths_resource_init(struct ths_device *tmdev)
 {
 	struct device *dev = tmdev->dev;
@@ -338,47 +343,35 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-		tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		ret = reset_control_deassert(tmdev->reset);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
+					       tmdev->reset);
+		if (ret)
+			return ret;
+
+		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
 		if (IS_ERR(tmdev->bus_clk))
 			return PTR_ERR(tmdev->bus_clk);
 	}
 
 	if (tmdev->chip->has_mod_clk) {
-		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");
 		if (IS_ERR(tmdev->mod_clk))
 			return PTR_ERR(tmdev->mod_clk);
 	}
 
-	ret = reset_control_deassert(tmdev->reset);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(tmdev->bus_clk);
-	if (ret)
-		goto assert_reset;
-
 	ret = clk_set_rate(tmdev->mod_clk, 24000000);
 	if (ret)
-		goto bus_disable;
-
-	ret = clk_prepare_enable(tmdev->mod_clk);
-	if (ret)
-		goto bus_disable;
+		return ret;
 
 	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
-		goto mod_disable;
+		return ret;
 
 	return 0;
-
-mod_disable:
-	clk_disable_unprepare(tmdev->mod_clk);
-bus_disable:
-	clk_disable_unprepare(tmdev->bus_clk);
-assert_reset:
-	reset_control_assert(tmdev->reset);
-
-	return ret;
 }
 
 static int sun8i_h3_thermal_init(struct ths_device *tmdev)
@@ -529,17 +522,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun8i_ths_remove(struct platform_device *pdev)
-{
-	struct ths_device *tmdev = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(tmdev->mod_clk);
-	clk_disable_unprepare(tmdev->bus_clk);
-	reset_control_assert(tmdev->reset);
-
-	return 0;
-}
-
 static const struct ths_thermal_chip sun8i_a83t_ths = {
 	.sensor_num = 3,
 	.scale = 705,
@@ -641,7 +623,6 @@ MODULE_DEVICE_TABLE(of, of_ths_match);
 
 static struct platform_driver ths_driver = {
 	.probe = sun8i_ths_probe,
-	.remove = sun8i_ths_remove,
 	.driver = {
 		.name = "sun8i-thermal",
 		.of_match_table = of_ths_match,
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 0771cd226581..61b11490ae5b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -87,7 +87,6 @@ struct serial8250_config {
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
 #define UART_BUG_TXRACE	(1 << 5)	/* UART Tx fails to set remote DR */
 
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 483fff3a95c9..e26ac3f42e05 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -653,6 +653,8 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	if ((lsr & UART_LSR_OE) && up->overrun_backoff_time_ms > 0) {
 		unsigned long delay;
 
+		/* Synchronize UART_IER access against the console. */
+		spin_lock(&port->lock);
 		up->ier = port->serial_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
@@ -662,6 +664,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 			 */
 			cancel_delayed_work(&up->overrun_backoff);
 		}
+		spin_unlock(&port->lock);
 
 		delay = msecs_to_jiffies(up->overrun_backoff_time_ms);
 		schedule_delayed_work(&up->overrun_backoff, delay);
@@ -1469,7 +1472,9 @@ static int omap8250_probe(struct platform_device *pdev)
 err:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
+	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
+	cpu_latency_qos_remove_request(&priv->pm_qos_request);
 	return ret;
 }
 
@@ -1516,25 +1521,35 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	int err;
 
 	serial8250_suspend_port(priv->line);
 
-	pm_runtime_get_sync(dev);
+	err = pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-
+	err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
-	return 0;
+
+	return err;
 }
 
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	int err;
 
+	err = pm_runtime_force_resume(dev);
+	if (err)
+		return err;
 	serial8250_resume_port(priv->line);
+	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 }
 #else
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 9617f7ad332d..fd857d434326 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1044,14 +1044,6 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 	return number_uarts;
 }
 
-static int pci_asix_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	port->bugs |= UART_BUG_PARITY;
-	return pci_default_setup(priv, board, port, idx);
-}
-
 /* Quatech devices have their own extra interface features */
 
 struct quatech_feature {
@@ -1874,7 +1866,6 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2684,16 +2675,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.exit		= pci_wch_ch38x_exit,
 		.setup          = pci_wch_ch38x_setup,
 	},
-	/*
-	 * ASIX devices with FIFO bug
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_ASIX,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_asix_setup,
-	},
 	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b19908779e3b..432a438929e6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2577,11 +2577,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 
 	if (c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-	if (c_cflag & PARENB) {
+	if (c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-		if (up->bugs & UART_BUG_PARITY)
-			up->fifo_bug = true;
-	}
 	if (!(c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
 #ifdef CMSPAR
@@ -2744,8 +2741,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3081,8 +3077,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	struct uart_8250_port *up = up_to_u8250p(uport);
 	int rxtrig;
 
-	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1 ||
-	    up->fifo_bug)
+	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1)
 		return -EINVAL;
 
 	rxtrig = bytes_to_fcr_rxtrig(up, bytes);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 02fd0e79c8f7..a1249bed6636 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -873,11 +873,11 @@ static void atmel_complete_tx_dma(void *arg)
 
 	port->icount.tx += atmel_port->tx_len;
 
-	spin_lock_irq(&atmel_port->lock_tx);
+	spin_lock(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
 	atmel_port->cookie_tx = -EINVAL;
 	atmel_port->desc_tx = NULL;
-	spin_unlock_irq(&atmel_port->lock_tx);
+	spin_unlock(&atmel_port->lock_tx);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ca22a1125821..a4cf00756681 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2589,6 +2589,7 @@ OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8ulp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 263c33260d8a..fa5b1321d9b1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1313,8 +1313,12 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			continue;
 
 		rate = clk_get_rate(clk);
-		if (!rate)
+		if (!rate) {
+			dev_err(ourport->port.dev,
+				"Failed to get clock rate for %s.\n", clkname);
+			clk_put(clk);
 			continue;
+		}
 
 		if (ourport->info->has_divslot) {
 			unsigned long div = rate / req_baud;
@@ -1340,10 +1344,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			calc_deviation = -calc_deviation;
 
 		if (calc_deviation < deviation) {
+			/*
+			 * If we find a better clk, release the previous one, if
+			 * any.
+			 */
+			if (!IS_ERR(*best_clk))
+				clk_put(*best_clk);
 			*best_clk = clk;
 			best_quot = quot;
 			*clk_num = cnt;
 			deviation = calc_deviation;
+		} else {
+			clk_put(clk);
 		}
 	}
 
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 2fe29319de44..1b95035d179f 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -734,6 +734,7 @@ static int driver_resume(struct usb_interface *intf)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /* The following routines apply to the entire device, not interfaces */
 void usbfs_notify_suspend(struct usb_device *udev)
 {
@@ -752,6 +753,7 @@ void usbfs_notify_resume(struct usb_device *udev)
 	}
 	mutex_unlock(&usbfs_mutex);
 }
+#endif
 
 struct usb_driver usbfs_driver = {
 	.name =		"usbfs",
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index d0f9b7c296b0..69ec06efd7f2 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -805,7 +805,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = dwc3_meson_g12a_otg_init(pdev, priv);
 	if (ret)
-		goto err_phys_power;
+		goto err_plat_depopulate;
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -813,6 +813,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_plat_depopulate:
+	of_platform_depopulate(dev);
+
 err_phys_power:
 	for (i = 0 ; i < PHY_COUNT ; ++i)
 		phy_power_off(priv->phys[i]);
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index dac13fe97811..ec8c43231746 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -722,6 +722,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	struct dwc3_qcom	*qcom;
 	struct resource		*res, *parent_res = NULL;
+	struct resource		local_res;
 	int			ret, i;
 	bool			ignore_pipe_clk;
 
@@ -772,9 +773,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (np) {
 		parent_res = res;
 	} else {
-		parent_res = kmemdup(res, sizeof(struct resource), GFP_KERNEL);
-		if (!parent_res)
-			return -ENOMEM;
+		memcpy(&local_res, res, sizeof(struct resource));
+		parent_res = &local_res;
 
 		parent_res->start = res->start +
 			qcom->acpi_pdata->qscratch_base_offset;
@@ -786,9 +786,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
 				dev_err(dev, "failed to create URS USB platdev\n");
 				if (!qcom->urs_usb)
-					return -ENODEV;
+					ret = -ENODEV;
 				else
-					return PTR_ERR(qcom->urs_usb);
+					ret = PTR_ERR(qcom->urs_usb);
+				goto clk_disable;
 			}
 		}
 	}
@@ -869,10 +870,14 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 static int dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int i;
 
-	of_platform_depopulate(dev);
+	if (np)
+		of_platform_depopulate(&pdev->dev);
+	else
+		platform_device_put(pdev);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 164910237669..221738b64426 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2215,7 +2215,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	ret = pm_runtime_get_sync(dwc->dev);
 	if (!ret || ret < 0) {
 		pm_runtime_put(dwc->dev);
-		return 0;
+		if (ret < 0)
+			pm_runtime_set_suspended(dwc->dev);
+		return ret;
 	}
 
 	if (dwc->pullups_connected == is_on) {
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 7b54e814aefb..3b5a6430e241 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1421,10 +1421,19 @@ EXPORT_SYMBOL_GPL(gserial_disconnect);
 
 void gserial_suspend(struct gserial *gser)
 {
-	struct gs_port	*port = gser->ioport;
+	struct gs_port	*port;
 	unsigned long	flags;
 
-	spin_lock_irqsave(&port->port_lock, flags);
+	spin_lock_irqsave(&serial_port_lock, flags);
+	port = gser->ioport;
+
+	if (!port) {
+		spin_unlock_irqrestore(&serial_port_lock, flags);
+		return;
+	}
+
+	spin_lock(&port->port_lock);
+	spin_unlock(&serial_port_lock);
 	port->suspended = true;
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index a8a9addb4d25..390bdf823e08 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2146,7 +2146,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
@@ -2166,6 +2166,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		 */
 		if (minor_revision > 0x00 && minor_revision < 0x10)
 			minor_revision <<= 4;
+		/*
+		 * Some zhaoxin's xHCI controller that follow usb3.1 spec
+		 * but only support Gen1.
+		 */
+		if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
+			tmp_minor_revision = minor_revision;
+			minor_revision = 0;
+		}
+
 	} else if (major_revision <= 0x02) {
 		rhub = &xhci->usb2_rhub;
 	} else {
@@ -2175,10 +2184,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
 	}
-	rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
-
-	if (rhub->min_rev < minor_revision)
-		rhub->min_rev = minor_revision;
 
 	/* Port offset and count in the third dword, see section 7.2 */
 	temp = readl(addr + 2);
@@ -2197,8 +2202,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	if (xhci->num_port_caps > max_caps)
 		return;
 
-	port_cap->maj_rev = major_revision;
-	port_cap->min_rev = minor_revision;
 	port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
 
 	if (port_cap->psi_count) {
@@ -2219,6 +2222,11 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i - 1])))
 				port_cap->psi_uid_count++;
 
+			if (xhci->quirks & XHCI_ZHAOXIN_HOST &&
+			    major_revision == 0x03 &&
+			    XHCI_EXT_PORT_PSIV(port_cap->psi[i]) >= 5)
+				minor_revision = tmp_minor_revision;
+
 			xhci_dbg(xhci, "PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i]),
 				  XHCI_EXT_PORT_PSIE(port_cap->psi[i]),
@@ -2228,6 +2236,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIM(port_cap->psi[i]));
 		}
 	}
+
+	rhub->maj_rev = major_revision;
+
+	if (rhub->min_rev < minor_revision)
+		rhub->min_rev = minor_revision;
+
+	port_cap->maj_rev = major_revision;
+	port_cap->min_rev = minor_revision;
+
 	/* cache usb2 port capabilities */
 	if (major_revision < 0x03 && xhci->num_ext_caps < max_caps)
 		xhci->ext_caps[xhci->num_ext_caps++] = temp;
@@ -2472,8 +2489,12 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
-			TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE, xhci->page_size);
+	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
+				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
+	else
+		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
+				TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE, xhci->page_size);
 
 	/* See Table 46 and Note on Figure 55 */
 	xhci->device_pool = dma_pool_create("xHCI input/output contexts", dev,
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index aff65cefead2..8034e643a4af 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -330,6 +330,18 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
+		xhci->quirks |= XHCI_ZHAOXIN_HOST;
+
+		if (pdev->device == 0x9202) {
+			xhci->quirks |= XHCI_RESET_ON_RESUME;
+			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+		}
+
+		if (pdev->device == 0x9203)
+			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+	}
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index c7749f6e3474..6a7c05940e66 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1895,6 +1895,8 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
+#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index a3e043e3e4aa..d0672b671298 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -395,7 +395,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 	tu->irq = ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		return ret;
+		goto err_remove_phy;
 	ret = request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt,
 				   IRQF_ONESHOT,
 				   "tahvo-vbus", tu);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 243f97a30779..625d9dc776be 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1151,6 +1151,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x90fa),
 	  .driver_info = RSVD(3) },
 	/* u-blox products */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1311) },	/* u-blox LARA-R6 01B */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1312),		/* u-blox LARA-R6 01B (RMNET) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(UBLOX_VENDOR_ID, 0x1313, 0xff) },	/* u-blox LARA-R6 01B (ECM) */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1341) },	/* u-blox LARA-L6 */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1342),		/* u-blox LARA-L6 (RMNET) */
 	  .driver_info = RSVD(4) },
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index a8a0a448cdb5..80f54111baec 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1732,6 +1732,9 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);
 	if (ret) {
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index e04411701ec8..1b2fb8ed7623 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1346,7 +1346,7 @@ static const struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1419,7 +1419,7 @@ static void init_imstt(struct fb_info *info)
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac == IBM ? "IBM" : "TVP");
@@ -1455,12 +1455,13 @@ static void init_imstt(struct fb_info *info)
 
 	if (register_framebuffer(info) < 0) {
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	tmp = (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
+	return 0;
 }
 
 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1469,6 +1470,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct imstt_par *par;
 	struct fb_info *info;
 	struct device_node *dp;
+	int ret = -ENOMEM;
 	
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
@@ -1504,23 +1506,37 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		default:
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
-			release_mem_region(addr, size);
-			framebuffer_release(info);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto error;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
+	if (!info->screen_base)
+		goto error;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
+	if (!par->dc_regs)
+		goto error;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
+	if (!par->cmap_regs)
+		goto error;
 	info->pseudo_palette = par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret = init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
+
+error:
+	if (par->dc_regs)
+		iounmap(par->dc_regs);
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(addr, size);
+	framebuffer_release(info);
+	return ret;
 }
 
 static void imsttfb_remove(struct pci_dev *pdev)
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 564bd0407ed8..d663e080b157 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -602,10 +602,10 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin > 255)
+	if (var->left_margin < 3  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
-	if (var->right_margin > 255)
+	if (var->right_margin < 1 || var->right_margin > 255)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index a75ae0c9b14c..d1cd8785d011 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -563,11 +563,15 @@ static int mipid_spi_probe(struct spi_device *spi)
 
 	r = mipid_detect(md);
 	if (r < 0)
-		return r;
+		goto free_md;
 
 	omapfb_register_panel(&md->panel);
 
 	return 0;
+
+free_md:
+	kfree(md);
+	return r;
 }
 
 static int mipid_spi_remove(struct spi_device *spi)
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 6546d029c7fd..3888643a22f6 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1094,29 +1094,26 @@ static int convert_t(struct w1_slave *sl, struct therm_info *info)
 
 			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
-			if (strong_pullup) { /*some device need pullup */
+			if (SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
+				ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
+				if (ret) {
+					dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
+					goto mt_unlock;
+				}
+				mutex_unlock(&dev_master->bus_mutex);
+			} else if (!strong_pullup) { /*no device need pullup */
 				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
 					goto mt_unlock;
 				}
 				mutex_unlock(&dev_master->bus_mutex);
-			} else { /*no device need pullup */
-				if (SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
-					ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
-					if (ret) {
-						dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
-						goto mt_unlock;
-					}
-					mutex_unlock(&dev_master->bus_mutex);
-				} else {
-					/* Fixed delay */
-					mutex_unlock(&dev_master->bus_mutex);
-					sleep_rem = msleep_interruptible(t_conv);
-					if (sleep_rem != 0) {
-						ret = -EINTR;
-						goto dec_refcnt;
-					}
+			} else { /*some device need pullup */
+				mutex_unlock(&dev_master->bus_mutex);
+				sleep_rem = msleep_interruptible(t_conv);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto dec_refcnt;
 				}
 			}
 			ret = read_scratchpad(sl, info);
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 15842377c8d2..1c1a9438f4b6 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1228,10 +1228,10 @@ static int __init w1_init(void)
 
 static void __exit w1_fini(void)
 {
-	struct w1_master *dev;
+	struct w1_master *dev, *n;
 
 	/* Set netlink removal messages and some cleanup */
-	list_for_each_entry(dev, &w1_masters, w1_master_entry)
+	list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry)
 		__w1_remove_master_device(dev);
 
 	w1_fini_netlink();
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d0fecbd28232..c4e3c1a5de05 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -77,14 +77,21 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	}
 	allowed &= flags;
 
-	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
+	/* Select the highest-redundancy RAID level. */
+	if (allowed & BTRFS_BLOCK_GROUP_RAID1C4)
+		allowed = BTRFS_BLOCK_GROUP_RAID1C4;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
 		allowed = BTRFS_BLOCK_GROUP_RAID6;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID1C3)
+		allowed = BTRFS_BLOCK_GROUP_RAID1C3;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
 		allowed = BTRFS_BLOCK_GROUP_RAID5;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
 		allowed = BTRFS_BLOCK_GROUP_RAID10;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
 		allowed = BTRFS_BLOCK_GROUP_RAID1;
+	else if (allowed & BTRFS_BLOCK_GROUP_DUP)
+		allowed = BTRFS_BLOCK_GROUP_DUP;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
 		allowed = BTRFS_BLOCK_GROUP_RAID0;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5a114cad988a..608b939a4d28 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2256,6 +2256,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		if (!strstr(crypto_shash_driver_name(csum_shash), "generic"))
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3fc689154bb5..828a7ff4aebe 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1270,7 +1270,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	spin_lock(&fs_info->trans_lock);
 	list_del(&quota_root->dirty_list);
+	spin_unlock(&fs_info->trans_lock);
 
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clean_tree_block(quota_root->node);
@@ -4374,4 +4376,5 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 		ulist_free(entry->old_roots);
 		kfree(entry);
 	}
+	*root = RB_ROOT;
 }
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e1fda3923944..432dc2a16e28 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3574,6 +3574,15 @@ static void handle_cap_grant(struct inode *inode,
 	}
 	BUG_ON(cap->issued & ~cap->implemented);
 
+	/* don't let check_caps skip sending a response to MDS for revoke msgs */
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
+		cap->mds_wanted = 0;
+		if (cap == ci->i_auth_cap)
+			check_caps = 1; /* check auth cap only */
+		else
+			check_caps = 2; /* check all caps */
+	}
+
 	if (extra_info->inline_version > 0 &&
 	    extra_info->inline_version >= ci->i_inline_version) {
 		ci->i_inline_version = extra_info->inline_version;
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index a10d2bcfe75a..edce0b25cd90 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -363,7 +363,9 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		locks_init_lock(fl);
 		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
 		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = -op->info.pid;
+		fl->fl_pid = op->info.pid;
+		if (op->info.nodeid != dlm_our_nodeid())
+			fl->fl_pid = -fl->fl_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8cb2cf612e49..9cff92738259 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -629,7 +629,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED &&
 		  clt->mode != COLLECT_PRIMARY_FOLLOWED_NOINPLACE);
 
-	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
+	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
 		goto next_part;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index f18194fd8d77..a5537a9f8f36 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -215,7 +215,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	int i;
 	u8 *in, type;
 
-	if (1 << amortizedshift == 4)
+	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits == 12)
 		vcnt = 16;
@@ -273,7 +273,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
 					vi->inode_isize + vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
@@ -283,9 +282,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	erofs_off_t pos;
 	int err;
 
-	if (lclusterbits != 12)
-		return -EOPNOTSUPP;
-
 	if (lcn >= totalidx)
 		return -EINVAL;
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 237983cd8cdc..c2bb2ff3fbb6 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -649,6 +649,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
+
+	/*
+	 * Update reserved blocks/metadata blocks after successful block
+	 * allocation which had been deferred till now.
+	 */
+	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
+		ext4_da_update_reserve_space(inode, count, 1);
+
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d3143746bcdb..365c4d3a434a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -654,16 +654,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
 		}
-
-		/*
-		 * Update reserved blocks/metadata blocks after successful
-		 * block allocation which had been deferred till now. We don't
-		 * support fallocate for non extent files. So we can update
-		 * reserve space here.
-		 */
-		if ((retval > 0) &&
-			(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
-			ext4_da_update_reserve_space(inode, retval, 1);
 	}
 
 	if (retval > 0) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8a51448b7670..3a7192884671 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5549,8 +5549,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		 * them with group lock_held
 		 */
 		if (test_opt(sb, DISCARD)) {
-			err = ext4_issue_discard(sb, block_group, bit, count,
-						 NULL);
+			err = ext4_issue_discard(sb, block_group, bit,
+						 count_clusters, NULL);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%u block:%d count:%lu failed"
@@ -5634,12 +5634,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 
 	sbi = EXT4_SB(sb);
 
-	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
-		ext4_free_blocks_simple(inode, block, count);
-		return;
-	}
-
-	might_sleep();
 	if (bh) {
 		if (block)
 			BUG_ON(block != bh->b_blocknr);
@@ -5647,6 +5641,13 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 			block = bh->b_blocknr;
 	}
 
+	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+		ext4_free_blocks_simple(inode, block, EXT4_NUM_B2C(sbi, count));
+		return;
+	}
+
+	might_sleep();
+
 	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
 	    !ext4_inode_block_valid(inode, block, count)) {
 		ext4_error(sb, "Freeing blocks not in datazone - "
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 45f719c1e002..ca3d2a33a08c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3863,19 +3863,10 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			return retval;
 	}
 
-	/*
-	 * We need to protect against old.inode directory getting converted
-	 * from inline directory format into a normal one.
-	 */
-	if (S_ISDIR(old.inode->i_mode))
-		inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
-
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
 				 &old.inlined);
-	if (IS_ERR(old.bh)) {
-		retval = PTR_ERR(old.bh);
-		goto unlock_moved_dir;
-	}
+	if (IS_ERR(old.bh))
+		return PTR_ERR(old.bh);
 
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
@@ -4065,10 +4056,6 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 	brelse(old.bh);
 	brelse(new.bh);
 
-unlock_moved_dir:
-	if (S_ISDIR(old.inode->i_mode))
-		inode_unlock(old.inode);
-
 	return retval;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 84b4fc9833e3..e386d67cff9d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1091,6 +1091,12 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 	struct block_device *bdev;
 	bdev = sbi->s_journal_bdev;
 	if (bdev) {
+		/*
+		 * Invalidate the journal device's buffers.  We don't want them
+		 * floating about in memory - the physical journal device may
+		 * hotswapped, and it breaks the `ro-after' testing code.
+		 */
+		invalidate_bdev(bdev);
 		ext4_blkdev_put(bdev);
 		sbi->s_journal_bdev = NULL;
 	}
@@ -1230,13 +1236,7 @@ static void ext4_put_super(struct super_block *sb)
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
 	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
-		/*
-		 * Invalidate the journal device's buffers.  We don't want them
-		 * floating about in memory - the physical journal device may
-		 * hotswapped, and it breaks the `ro-after' testing code.
-		 */
 		sync_blockdev(sbi->s_journal_bdev);
-		invalidate_bdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
 
@@ -5206,6 +5206,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	brelse(bh);
 	ext4_blkdev_remove(sbi);
 out_fail:
+	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
 out_free_base:
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ed39101dc7b6..5bf858fc271f 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1725,6 +1725,20 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		memmove(here, (void *)here + size,
 			(void *)last - (void *)here + sizeof(__u32));
 		memset(last, 0, size);
+
+		/*
+		 * Update i_inline_off - moved ibody region might contain
+		 * system.data attribute.  Handling a failure here won't
+		 * cause other complications for setting an xattr.
+		 */
+		if (!is_block && ext4_has_inline_data(inode)) {
+			ret = ext4_find_inline_data_nolock(inode);
+			if (ret) {
+				ext4_warning_inode(inode,
+					"unable to update i_inline_off");
+				goto out;
+			}
+		}
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62b7848f1f71..83ebc860508b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3483,7 +3483,7 @@ block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background, bool force,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a0d8aa52b696..6e91be5b8c30 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3356,7 +3356,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 66ac048cc899..8e4daee0171f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -7,6 +7,7 @@
  */
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
 #include <linux/f2fs_fs.h>
@@ -1976,8 +1977,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2015,12 +2017,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		return -EINVAL;
 	}
 
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
 
 	/* stop other GC */
-	if (!down_write_trylock(&sbi->gc_lock))
-		return -EAGAIN;
+	if (!down_write_trylock(&sbi->gc_lock)) {
+		err = -EAGAIN;
+		goto out_drop_write;
+	}
 
 	/* stop CP to protect MAIN_SEC in free_segment_range */
 	f2fs_lock_op(sbi);
@@ -2040,10 +2048,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_unlock:
 	f2fs_unlock_op(sbi);
 	up_write(&sbi->gc_lock);
+out_drop_write:
+	mnt_drop_write_file(filp);
 	if (err)
 		return err;
 
 	freeze_super(sbi->sb);
+
+	if (f2fs_readonly(sbi->sb)) {
+		thaw_super(sbi->sb);
+		return -EROFS;
+	}
+
 	down_write(&sbi->gc_lock);
 	mutex_lock(&sbi->cp_mutex);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 98263180c0ea..72b109685db4 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -969,20 +969,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out;
 	}
 
-	/*
-	 * Copied from ext4_rename: we need to protect against old.inode
-	 * directory getting converted from inline directory format into
-	 * a normal one.
-	 */
-	if (S_ISDIR(old_inode->i_mode))
-		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
-
 	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
 			err = PTR_ERR(old_page);
-		goto out_unlock_old;
+		goto out;
 	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
@@ -1090,9 +1082,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_unlock_op(sbi);
 
-	if (S_ISDIR(old_inode->i_mode))
-		inode_unlock(old_inode);
-
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1107,9 +1096,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
-out_unlock_old:
-	if (S_ISDIR(old_inode->i_mode))
-		inode_unlock(old_inode);
 out:
 	if (whiteout)
 		iput(whiteout);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c63274d4b74b..02cb1c806c3e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -884,8 +884,10 @@ static int truncate_dnode(struct dnode_of_data *dn)
 	dn->ofs_in_node = 0;
 	f2fs_truncate_data_blocks(dn);
 	err = truncate_node(dn);
-	if (err)
+	if (err) {
+		f2fs_put_page(page, 1);
 		return err;
+	}
 
 	return 1;
 }
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 740322dff4a3..e6ef7e040743 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -543,7 +543,8 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -ENOMEM;
 	}
 
-	ctx->legacy_data[size++] = ',';
+	if (size)
+		ctx->legacy_data[size++] = ',';
 	len = strlen(param->key);
 	memcpy(ctx->legacy_data + size, param->key, len);
 	size += len;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e3b9b7d188e6..b0c701c007c6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -249,7 +249,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
 		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
diff --git a/fs/inode.c b/fs/inode.c
index 7ec90788d8be..311237e8d359 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1015,6 +1015,48 @@ void discard_new_inode(struct inode *inode)
 }
 EXPORT_SYMBOL(discard_new_inode);
 
+/**
+ * lock_two_inodes - lock two inodes (may be regular files but also dirs)
+ *
+ * Lock any non-NULL argument. The caller must make sure that if he is passing
+ * in two directories, one is not ancestor of the other.  Zero, one or two
+ * objects may be locked by this function.
+ *
+ * @inode1: first inode to lock
+ * @inode2: second inode to lock
+ * @subclass1: inode lock subclass for the first lock obtained
+ * @subclass2: inode lock subclass for the second lock obtained
+ */
+void lock_two_inodes(struct inode *inode1, struct inode *inode2,
+		     unsigned subclass1, unsigned subclass2)
+{
+	if (!inode1 || !inode2) {
+		/*
+		 * Make sure @subclass1 will be used for the acquired lock.
+		 * This is not strictly necessary (no current caller cares) but
+		 * let's keep things consistent.
+		 */
+		if (!inode1)
+			swap(inode1, inode2);
+		goto lock;
+	}
+
+	/*
+	 * If one object is directory and the other is not, we must make sure
+	 * to lock directory first as the other object may be its child.
+	 */
+	if (S_ISDIR(inode2->i_mode) == S_ISDIR(inode1->i_mode)) {
+		if (inode1 > inode2)
+			swap(inode1, inode2);
+	} else if (!S_ISDIR(inode1->i_mode))
+		swap(inode1, inode2);
+lock:
+	if (inode1)
+		inode_lock_nested(inode1, subclass1);
+	if (inode2 && inode2 != inode1)
+		inode_lock_nested(inode2, subclass2);
+}
+
 /**
  * lock_two_nondirectories - take two i_mutexes on non-directory objects
  *
diff --git a/fs/internal.h b/fs/internal.h
index d5d9fcdae10c..39193250a4ed 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -150,6 +150,8 @@ extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
 extern void inode_add_lru(struct inode *inode);
 extern int dentry_needs_remove_privs(struct dentry *dentry);
 bool in_group_or_capable(const struct inode *inode, kgid_t gid);
+void lock_two_inodes(struct inode *inode1, struct inode *inode2,
+		     unsigned subclass1, unsigned subclass2);
 
 /*
  * fs-writeback.c
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index 837cd55fd4c5..6ae9d6fefb86 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -211,7 +211,10 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
 		ic->scan_dents = NULL;
 		cond_resched();
 	}
-	jffs2_build_xattr_subsystem(c);
+	ret = jffs2_build_xattr_subsystem(c);
+	if (ret)
+		goto exit;
+
 	c->flags &= ~JFFS2_SB_FLAG_BUILDING;
 
 	dbg_fsbuild("FS build complete\n");
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..acb4492f5970 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -772,10 +772,10 @@ void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c)
 }
 
 #define XREF_TMPHASH_SIZE	(128)
-void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
+int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 {
 	struct jffs2_xattr_ref *ref, *_ref;
-	struct jffs2_xattr_ref *xref_tmphash[XREF_TMPHASH_SIZE];
+	struct jffs2_xattr_ref **xref_tmphash;
 	struct jffs2_xattr_datum *xd, *_xd;
 	struct jffs2_inode_cache *ic;
 	struct jffs2_raw_node_ref *raw;
@@ -784,9 +784,12 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 
 	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
 
+	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
+			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
+	if (!xref_tmphash)
+		return -ENOMEM;
+
 	/* Phase.1 : Merge same xref */
-	for (i=0; i < XREF_TMPHASH_SIZE; i++)
-		xref_tmphash[i] = NULL;
 	for (ref=c->xref_temp; ref; ref=_ref) {
 		struct jffs2_xattr_ref *tmp;
 
@@ -884,6 +887,8 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 		     "%u of xref (%u dead, %u orphan) found.\n",
 		     xdatum_count, xdatum_unchecked_count, xdatum_orphan_count,
 		     xref_count, xref_dead_count, xref_orphan_count);
+	kfree(xref_tmphash);
+	return 0;
 }
 
 struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
index 720007b2fd65..1b5030a3349d 100644
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -71,7 +71,7 @@ static inline int is_xattr_ref_dead(struct jffs2_xattr_ref *ref)
 #ifdef CONFIG_JFFS2_FS_XATTR
 
 extern void jffs2_init_xattr_subsystem(struct jffs2_sb_info *c);
-extern void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
+extern int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
 extern void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c);
 
 extern struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
@@ -103,7 +103,7 @@ extern ssize_t jffs2_listxattr(struct dentry *, char *, size_t);
 #else
 
 #define jffs2_init_xattr_subsystem(c)
-#define jffs2_build_xattr_subsystem(c)
+#define jffs2_build_xattr_subsystem(c)		(0)
 #define jffs2_clear_xattr_subsystem(c)
 
 #define jffs2_xattr_do_crccheck_inode(c, ic)
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 501263355ef4..bd9af2be352f 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -178,7 +178,13 @@ int dbMount(struct inode *ipbmap)
 	dbmp_le = (struct dbmap_disk *) mp->data;
 	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
+
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
 	if (!bmp->db_numag) {
 		err = -EINVAL;
diff --git a/fs/jfs/jfs_filsys.h b/fs/jfs/jfs_filsys.h
index b5d702df7111..33ef13a0b110 100644
--- a/fs/jfs/jfs_filsys.h
+++ b/fs/jfs/jfs_filsys.h
@@ -122,7 +122,9 @@
 #define NUM_INODE_PER_IAG	INOSPERIAG
 
 #define MINBLOCKSIZE		512
+#define L2MINBLOCKSIZE		9
 #define MAXBLOCKSIZE		4096
+#define L2MAXBLOCKSIZE		12
 #define	MAXFILESIZE		((s64)1 << 52)
 
 #define JFS_LINK_MAX		0xffffffff
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b3c86a502da..c91ee05cce74 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -679,7 +679,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
+	spin_unlock(&kernfs_idr_lock);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
diff --git a/fs/namei.c b/fs/namei.c
index 3d98db9802a7..bc5e633a5954 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2782,8 +2782,8 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 		return p;
 	}
 
-	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	lock_two_inodes(p1->d_inode, p2->d_inode,
+			I_MUTEX_PARENT, I_MUTEX_PARENT2);
 	return NULL;
 }
 EXPORT_SYMBOL(lock_rename);
@@ -4264,7 +4264,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
  *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source (if it is not a directory).
+ *	   and source.
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4341,10 +4341,16 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
-	if (!is_dir || (flags & RENAME_EXCHANGE))
-		lock_two_nondirectories(source, target);
-	else if (target)
-		inode_lock(target);
+	/*
+	 * Lock all moved children. Moved directories may need to change parent
+	 * pointer so they need the lock to prevent against concurrent
+	 * directory changes moving parent pointer. For regular files we've
+	 * historically always done this. The lockdep locking subclasses are
+	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
+	 * regular files and directories so it's difficult to tell which
+	 * subclasses to use.
+	 */
+	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
 
 	error = -EBUSY;
 	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
@@ -4388,9 +4394,8 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	if (!is_dir || (flags & RENAME_EXCHANGE))
-		unlock_two_nondirectories(source, target);
-	else if (target)
+	inode_unlock(source);
+	if (target)
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bca5d1bdd79b..b9567cc8698e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -926,6 +926,7 @@ static int nfs41_sequence_process(struct rpc_task *task,
 out_noaction:
 	return ret;
 session_recover:
+	set_bit(NFS4_SLOT_TBL_DRAINING, &session->fc_slot_table.slot_tbl_state);
 	nfs4_schedule_session_recovery(session, status);
 	dprintk("%s ERROR: %d Reset session\n", __func__, status);
 	nfs41_sequence_free_slot(res);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e3410a9b03e..c7e8e641d3e5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3705,7 +3705,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 		p = xdr_reserve_space(xdr, 32);
 		if (!p)
 			return nfserr_resource;
-		*p++ = cpu_to_be32(0);
+		*p++ = cpu_to_be32(open->op_recall);
 
 		/*
 		 * TODO: space_limit's in delegations
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 18e014fa0648..84de9f97bbc0 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1090,8 +1090,11 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 	return 0;
 }
 
-static int fanotify_events_supported(struct path *path, __u64 mask)
+static int fanotify_events_supported(struct path *path, __u64 mask,
+				     unsigned int flags)
 {
+	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1103,6 +1106,21 @@ static int fanotify_events_supported(struct path *path, __u64 mask)
 	if (mask & FANOTIFY_PERM_EVENTS &&
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
+
+	/*
+	 * mount and sb marks are not allowed on kernel internal pseudo fs,
+	 * like pipe_mnt, because that would subscribe to events on all the
+	 * anonynous pipes in the system.
+	 *
+	 * SB_NOUSER covers all of the internal pseudo fs whose objects are not
+	 * exposed to user's mount namespace, but there are other SB_KERNMOUNT
+	 * fs, like nsfs, debugfs, for which the value of allowing sb and mount
+	 * mark is questionable. For now we leave them alone.
+	 */
+	if (mark_type != FAN_MARK_INODE &&
+	    path->mnt->mnt_sb->s_flags & SB_NOUSER)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1218,7 +1236,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	if (flags & FAN_MARK_ADD) {
-		ret = fanotify_events_supported(&path, mask);
+		ret = fanotify_events_supported(&path, mask, flags);
 		if (ret)
 			goto path_put_and_out;
 	}
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e466c58f9ec4..7ef3c87f8a23 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -475,6 +475,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			/* Restore timestamps on parent (best effort) */
 			ovl_set_timestamps(upperdir, &c->pstat);
 			ovl_dentry_set_upper_alias(c->dentry);
+			ovl_dentry_update_reval(c->dentry, upper);
 		}
 	}
 	inode_unlock(udir);
@@ -762,6 +763,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		inode_unlock(udir);
 
 		ovl_dentry_set_upper_alias(c->dentry);
+		ovl_dentry_update_reval(c->dentry, ovl_dentry_upper(c->dentry));
 	}
 
 out:
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 8ebd9f2b1c95..a7021c87bfcb 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -266,8 +266,7 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 
 	ovl_dir_modified(dentry->d_parent, false);
 	ovl_dentry_set_upper_alias(dentry);
-	ovl_dentry_update_reval(dentry, newdentry,
-			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_reval(dentry, newdentry);
 
 	if (!hardlink) {
 		/*
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 44118f0ab0b3..f981283177ec 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -324,8 +324,7 @@ static struct dentry *ovl_obtain_alias(struct super_block *sb,
 	if (upper_alias)
 		ovl_dentry_set_upper_alias(dentry);
 
-	ovl_dentry_update_reval(dentry, upper,
-			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_reval(dentry, upper);
 
 	return d_instantiate_anon(dentry, inode);
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 092812c2f118..ff5284b86bd5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1095,8 +1095,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			ovl_set_flag(OVL_UPPERDATA, inode);
 	}
 
-	ovl_dentry_update_reval(dentry, upperdentry,
-			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_reval(dentry, upperdentry);
 
 	revert_creds(old_cred);
 	if (origin_path) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 898de3bf884e..26f91868fbda 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -257,8 +257,10 @@ bool ovl_index_all(struct super_block *sb);
 bool ovl_verify_lower(struct super_block *sb);
 struct ovl_entry *ovl_alloc_entry(unsigned int numlower);
 bool ovl_dentry_remote(struct dentry *dentry);
-void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *upperdentry,
-			     unsigned int mask);
+void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *realdentry);
+void ovl_dentry_init_reval(struct dentry *dentry, struct dentry *upperdentry);
+void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
+			   unsigned int mask);
 bool ovl_dentry_weird(struct dentry *dentry);
 enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e3cd5a00f880..5d7df839902d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1868,7 +1868,7 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
-	ovl_dentry_update_reval(root, upperdentry, DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_flags(root, upperdentry, DCACHE_OP_WEAK_REVALIDATE);
 
 	return root;
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index e8b14d2c180c..060f9c99d9b3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -90,14 +90,30 @@ struct ovl_entry *ovl_alloc_entry(unsigned int numlower)
 	return oe;
 }
 
+#define OVL_D_REVALIDATE (DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE)
+
 bool ovl_dentry_remote(struct dentry *dentry)
 {
-	return dentry->d_flags &
-		(DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+	return dentry->d_flags & OVL_D_REVALIDATE;
+}
+
+void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *realdentry)
+{
+	if (!ovl_dentry_remote(realdentry))
+		return;
+
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= realdentry->d_flags & OVL_D_REVALIDATE;
+	spin_unlock(&dentry->d_lock);
+}
+
+void ovl_dentry_init_reval(struct dentry *dentry, struct dentry *upperdentry)
+{
+	return ovl_dentry_init_flags(dentry, upperdentry, OVL_D_REVALIDATE);
 }
 
-void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *upperdentry,
-			     unsigned int mask)
+void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
+			   unsigned int mask)
 {
 	struct ovl_entry *oe = OVL_E(dentry);
 	unsigned int i, flags = 0;
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 184cb97c83bd..b6183f1f4ebc 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -577,6 +577,8 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	raw_spin_lock_init(&prz->buffer_lock);
 	prz->flags = flags;
 	prz->label = kstrdup(label, GFP_KERNEL);
+	if (!prz->label)
+		goto err;
 
 	ret = persistent_ram_buffer_map(start, size, prz, memtype);
 	if (ret)
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index ee179a81b3da..23d2c333066f 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -264,7 +264,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void ramfs_kill_sb(struct super_block *sb)
+void ramfs_kill_sb(struct super_block *sb)
 {
 	kfree(sb->s_fs_info);
 	kill_litter_super(sb);
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index ce2cbb3c380f..2f1d0aad645c 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -42,7 +42,7 @@ static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 #define __p4d(x)				((p4d_t) { __pgd(x) })
 
 #define pgd_page(pgd)				(p4d_page((p4d_t){ pgd }))
-#define pgd_page_vaddr(pgd)			(p4d_page_vaddr((p4d_t){ pgd }))
+#define pgd_page_vaddr(pgd)			((unsigned long)(p4d_pgtable((p4d_t){ pgd })))
 
 /*
  * allocating and freeing a p4d is trivial: the 1-entry p4d is
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 3e13acd019ae..10789cf51d16 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -51,7 +51,7 @@ static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
 #define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_page_vaddr(pud)			(pmd_page_vaddr((pmd_t){ pud }))
+#define pud_pgtable(pud)			((pmd_t *)(pmd_page_vaddr((pmd_t){ pud })))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index a9d751fbda9e..eb70c6d7ceff 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -49,7 +49,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #define __pud(x)				((pud_t) { __p4d(x) })
 
 #define p4d_page(p4d)				(pud_page((pud_t){ p4d }))
-#define p4d_page_vaddr(p4d)			(pud_page_vaddr((pud_t){ p4d }))
+#define p4d_pgtable(p4d)			((pud_t *)(pud_pgtable((pud_t){ p4d })))
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 91b966978541..53702b83ce5f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -158,6 +158,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 				       int __user *optlen, int max_optlen,
 				       int retval);
 
+int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
+					    int optname, void *optval,
+					    int *optlen, int retval);
+
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
@@ -404,10 +408,23 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 ({									       \
 	int __ret = retval;						       \
 	if (cgroup_bpf_enabled)						       \
-		__ret = __cgroup_bpf_run_filter_getsockopt(sock, level,	       \
-							   optname, optval,    \
-							   optlen, max_optlen, \
-							   retval);	       \
+		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
+		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
+					tcp_bpf_bypass_getsockopt,	       \
+					level, optname))		       \
+			__ret = __cgroup_bpf_run_filter_getsockopt(	       \
+				sock, level, optname, optval, optlen,	       \
+				max_optlen, retval);			       \
+	__ret;								       \
+})
+
+#define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval,      \
+					    optlen, retval)		       \
+({									       \
+	int __ret = retval;						       \
+	if (cgroup_bpf_enabled)						       \
+		__ret = __cgroup_bpf_run_filter_getsockopt_kern(	       \
+			sock, level, optname, optval, optlen, retval);	       \
 	__ret;								       \
 })
 
@@ -493,6 +510,8 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
 				       optlen, max_optlen, retval) ({ retval; })
+#define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, \
+					    optlen, retval) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
 				       kernel_optval) ({ 0; })
 
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 99209f50915f..b060514bf25d 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -299,6 +299,18 @@ static inline void ether_addr_copy(u8 *dst, const u8 *src)
 #endif
 }
 
+/**
+ * eth_hw_addr_set - Assign Ethernet address to a net_device
+ * @dev: pointer to net_device structure
+ * @addr: address to assign
+ *
+ * Assign given address to the net_device, addr_assign_type is not changed.
+ */
+static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
+{
+	ether_addr_copy(dev->dev_addr, addr);
+}
+
 /**
  * eth_hw_addr_inherit - Copy dev_addr from another net_device
  * @dst: pointer to net_device to copy dev_addr to
diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index 54c02c84906a..cfcfef37b2f1 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -60,4 +60,10 @@
 #define INDIRECT_CALL_INET(f, f2, f1, ...) f(__VA_ARGS__)
 #endif
 
+#if IS_ENABLED(CONFIG_INET)
+#define INDIRECT_CALL_INET_1(f, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
+#else
+#define INDIRECT_CALL_INET_1(f, f1, ...) f(__VA_ARGS__)
+#endif
+
 #endif
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8f03cc42bd43..302abfc2a1f6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4474,6 +4474,24 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 void __hw_addr_init(struct netdev_hw_addr_list *list);
 
 /* Functions used for device addresses handling */
+static inline void
+__dev_addr_set(struct net_device *dev, const u8 *addr, size_t len)
+{
+	memcpy(dev->dev_addr, addr, len);
+}
+
+static inline void dev_addr_set(struct net_device *dev, const u8 *addr)
+{
+	__dev_addr_set(dev, addr, dev->addr_len);
+}
+
+static inline void
+dev_addr_mod(struct net_device *dev, unsigned int offset,
+	     const u8 *addr, size_t len)
+{
+	memcpy(&dev->dev_addr[offset], addr, len);
+}
+
 int dev_addr_add(struct net_device *dev, const unsigned char *addr,
 		 unsigned char addr_type);
 int dev_addr_del(struct net_device *dev, const unsigned char *addr,
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index f700ff2df074..0db377ff8f60 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -197,7 +197,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
-    defined(CONFIG_HARDLOCKUP_DETECTOR)
+    defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 void watchdog_update_hrtimer_threshold(u64 period);
 #else
 static inline void watchdog_update_hrtimer_threshold(u64 period) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cc42ad2f6c5..550e1cdb473f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1719,6 +1719,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
+static inline void pci_clear_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9def1ac19546..f924468d84ec 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -89,7 +89,7 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #ifndef pmd_offset
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 {
-	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
+	return pud_pgtable(*pud) + pmd_index(address);
 }
 #define pmd_offset pmd_offset
 #endif
@@ -97,7 +97,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 #ifndef pud_offset
 static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 {
-	return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
+	return p4d_pgtable(*p4d) + pud_index(address);
 }
 #define pud_offset pud_offset
 #endif
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index c0b6ec6bf65b..ef236dbaa294 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -256,18 +256,14 @@ void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
 
-#ifdef CONFIG_WATCH_QUEUE
 unsigned long account_pipe_buffers(struct user_struct *user,
 				   unsigned long old, unsigned long new);
 bool too_many_pipe_buffers_soft(unsigned long user_bufs);
 bool too_many_pipe_buffers_hard(unsigned long user_bufs);
 bool pipe_is_unprivileged_user(void);
-#endif
 
 /* for F_SETPIPE_SZ and F_GETPIPE_SZ */
-#ifdef CONFIG_WATCH_QUEUE
 int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots);
-#endif
 long pipe_fcntl(struct file *, unsigned int, unsigned long arg);
 struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 
diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
index 917528d102c4..d506dc63dd47 100644
--- a/include/linux/ramfs.h
+++ b/include/linux/ramfs.h
@@ -7,6 +7,7 @@
 struct inode *ramfs_get_inode(struct super_block *sb, const struct inode *dir,
 	 umode_t mode, dev_t dev);
 extern int ramfs_init_fs_context(struct fs_context *fc);
+extern void ramfs_kill_sb(struct super_block *sb);
 
 #ifdef CONFIG_MMU
 static inline int
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index ae60f838ebb9..2c634010cc7b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -125,7 +125,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 92f3b778d8c2..abb928361270 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -98,7 +98,6 @@ struct uart_8250_port {
 	struct list_head	list;		/* ports on this IRQ */
 	u32			capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
-	bool			fifo_bug;	/* min RX trigger if enabled */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned char		acr;
 	unsigned char		fcr;
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6e3340379d85..11a98144bda0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -473,7 +473,7 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	int somaxconn = READ_ONCE(sock_net(sk)->core.sysctl_somaxconn);
 
-	queue->fastopenq.max_qlen = min_t(unsigned int, backlog, somaxconn);
+	WRITE_ONCE(queue->fastopenq.max_qlen, min_t(unsigned int, backlog, somaxconn));
 }
 
 static inline void tcp_move_syn(struct tcp_sock *tp,
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2fa9b311e566..460c58fa011a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -73,7 +73,6 @@ enum {
 	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
 
 	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
-	WORK_OFFQ_CANCELING	= (1 << __WORK_OFFQ_CANCELING),
 
 	/*
 	 * When a work item is off queue, its high bits point to the last
@@ -84,12 +83,6 @@ enum {
 	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-	WORK_OFFQ_POOL_NONE	= (1LU << WORK_OFFQ_POOL_BITS) - 1,
-
-	/* convenience constants */
-	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
-	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
-	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
 
 	/* bit mask for work_busy() return values */
 	WORK_BUSY_PENDING	= 1 << 0,
@@ -99,6 +92,14 @@ enum {
 	WORKER_DESC_LEN		= 24,
 };
 
+/* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
+#define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
+#define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
+
+#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
+#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+
 struct work_struct {
 	atomic_long_t data;
 	struct list_head entry;
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 030237f3d82a..fb3c5f690750 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -382,7 +382,8 @@ struct nft_set_ops {
 	int				(*init)(const struct nft_set *set,
 						const struct nft_set_desc *desc,
 						const struct nlattr * const nla[]);
-	void				(*destroy)(const struct nft_set *set);
+	void				(*destroy)(const struct nft_ctx *ctx,
+						   const struct nft_set *set);
 	void				(*gc_init)(const struct nft_set *set);
 
 	unsigned int			elemsize;
@@ -686,6 +687,8 @@ void *nft_set_elem_init(const struct nft_set *set,
 			u64 timeout, u64 expiration, gfp_t gfp);
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr);
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem);
 
 /**
  *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
@@ -777,6 +780,7 @@ struct nft_expr_type {
 
 enum nft_trans_phase {
 	NFT_TRANS_PREPARE,
+	NFT_TRANS_PREPARE_ERROR,
 	NFT_TRANS_ABORT,
 	NFT_TRANS_COMMIT,
 	NFT_TRANS_RELEASE
@@ -907,7 +911,10 @@ static inline struct nft_userdata *nft_userdata(const struct nft_rule *rule)
 	return (void *)&rule->data[rule->dlen];
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase);
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule);
 
 static inline void nft_set_elem_update_expr(const struct nft_set_ext *ext,
 					    struct nft_regs *regs,
@@ -966,6 +973,8 @@ struct nft_chain {
 };
 
 int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain);
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
+void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
 
 enum nft_chain_types {
 	NFT_CHAIN_T_DEFAULT = 0,
@@ -1002,11 +1011,17 @@ int nft_chain_validate_dependency(const struct nft_chain *chain,
 int nft_chain_validate_hooks(const struct nft_chain *chain,
                              unsigned int hook_flags);
 
+static inline bool nft_chain_binding(const struct nft_chain *chain)
+{
+	return chain->flags & NFT_CHAIN_BINDING;
+}
+
 static inline bool nft_chain_is_bound(struct nft_chain *chain)
 {
 	return (chain->flags & NFT_CHAIN_BINDING) && chain->bound;
 }
 
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain);
 void nft_chain_del(struct nft_chain *chain);
 void nf_tables_chain_destroy(struct nft_ctx *ctx);
 
@@ -1414,6 +1429,7 @@ static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
  *	struct nft_trans - nf_tables object update in transaction
  *
  *	@list: used internally
+ *	@binding_list: list of objects with possible bindings
  *	@msg_type: message type
  *	@put_net: ctx->net needs to be put
  *	@ctx: transaction context
@@ -1421,6 +1437,7 @@ static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
  */
 struct nft_trans {
 	struct list_head		list;
+	struct list_head		binding_list;
 	int				msg_type;
 	bool				put_net;
 	struct nft_ctx			ctx;
@@ -1431,6 +1448,7 @@ struct nft_trans_rule {
 	struct nft_rule			*rule;
 	struct nft_flow_rule		*flow;
 	u32				rule_id;
+	bool				bound;
 };
 
 #define nft_trans_rule(trans)	\
@@ -1439,6 +1457,8 @@ struct nft_trans_rule {
 	(((struct nft_trans_rule *)trans->data)->flow)
 #define nft_trans_rule_id(trans)	\
 	(((struct nft_trans_rule *)trans->data)->rule_id)
+#define nft_trans_rule_bound(trans)	\
+	(((struct nft_trans_rule *)trans->data)->bound)
 
 struct nft_trans_set {
 	struct nft_set			*set;
@@ -1454,13 +1474,17 @@ struct nft_trans_set {
 	(((struct nft_trans_set *)trans->data)->bound)
 
 struct nft_trans_chain {
+	struct nft_chain		*chain;
 	bool				update;
 	char				*name;
 	struct nft_stats __percpu	*stats;
 	u8				policy;
+	bool				bound;
 	u32				chain_id;
 };
 
+#define nft_trans_chain(trans)	\
+	(((struct nft_trans_chain *)trans->data)->chain)
 #define nft_trans_chain_update(trans)	\
 	(((struct nft_trans_chain *)trans->data)->update)
 #define nft_trans_chain_name(trans)	\
@@ -1469,6 +1493,8 @@ struct nft_trans_chain {
 	(((struct nft_trans_chain *)trans->data)->stats)
 #define nft_trans_chain_policy(trans)	\
 	(((struct nft_trans_chain *)trans->data)->policy)
+#define nft_trans_chain_bound(trans)	\
+	(((struct nft_trans_chain *)trans->data)->bound)
 #define nft_trans_chain_id(trans)	\
 	(((struct nft_trans_chain *)trans->data)->chain_id)
 
@@ -1535,4 +1561,15 @@ void nf_tables_trans_destroy_flush_work(void);
 int nf_msecs_to_jiffies64(const struct nlattr *nla, u64 *result);
 __be64 nf_jiffies64_to_msecs(u64 input);
 
+struct nftables_pernet {
+	struct list_head	tables;
+	struct list_head	commit_list;
+	struct list_head	binding_list;
+	struct list_head	module_list;
+	struct list_head	notify_list;
+	struct mutex		commit_mutex;
+	unsigned int		base_seq;
+	u8			validate_state;
+};
+
 #endif /* _NET_NF_TABLES_H */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4a4a5270ff6f..9b0d8649ae5b 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -131,6 +131,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_syn_retries;
 	u8 sysctl_tcp_synack_retries;
 	u8 sysctl_tcp_syncookies;
+	u8 sysctl_tcp_migrate_req;
 	int sysctl_tcp_reordering;
 	u8 sysctl_tcp_retries1;
 	u8 sysctl_tcp_retries2;
diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index 6c0806bd8d1e..8c77832d0240 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -5,14 +5,7 @@
 #include <linux/list.h>
 
 struct netns_nftables {
-	struct list_head	tables;
-	struct list_head	commit_list;
-	struct list_head	module_list;
-	struct list_head	notify_list;
-	struct mutex		commit_mutex;
-	unsigned int		base_seq;
 	u8			gencursor;
-	u8			validate_state;
 };
 
 #endif
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 2cd3a261bcbc..32890e43f06c 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -266,7 +266,7 @@ struct sk_buff *nfc_alloc_send_skb(struct nfc_dev *dev, struct sock *sk,
 struct sk_buff *nfc_alloc_recv_skb(unsigned int size, gfp_t gfp);
 
 int nfc_set_remote_general_bytes(struct nfc_dev *dev,
-				 u8 *gt, u8 gt_len);
+				 const u8 *gt, u8 gt_len);
 u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len);
 
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
@@ -280,7 +280,7 @@ int nfc_dep_link_is_up(struct nfc_dev *dev, u32 target_idx,
 		       u8 comm_mode, u8 rf_mode);
 
 int nfc_tm_activated(struct nfc_dev *dev, u32 protocol, u8 comm_mode,
-		     u8 *gb, size_t gb_len);
+		     const u8 *gb, size_t gb_len);
 int nfc_tm_deactivated(struct nfc_dev *dev);
 int nfc_tm_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index ba781e0aaf56..e186b2bd8c86 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -136,7 +136,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-	return dev->mtu + dev->hard_header_len;
+	return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }
 
 static inline struct net *qdisc_net(struct Qdisc *q)
diff --git a/include/net/sock.h b/include/net/sock.h
index 51b499d74549..1fb5c535537c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1207,6 +1207,8 @@ struct proto {
 
 	int			(*backlog_rcv) (struct sock *sk,
 						struct sk_buff *skb);
+	bool			(*bpf_bypass_getsockopt)(int level,
+							 int optname);
 
 	void		(*release_cb)(struct sock *sk);
 
@@ -1932,6 +1934,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 }
 
 kuid_t sock_i_uid(struct sock *sk);
+unsigned long __sock_i_ino(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index d213b86a4822..dcca41f3a224 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -389,6 +389,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock,
 		      struct poll_table_struct *wait);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
+bool tcp_bpf_bypass_getsockopt(int level, int optname);
 int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		   unsigned int optlen);
 void tcp_set_keepalive(struct sock *sk, int val);
@@ -1450,25 +1451,38 @@ void tcp_leave_memory_pressure(struct sock *sk);
 static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_intvl ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepintvl()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_intvl);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
 }
 
 static inline int keepalive_time_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_time ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepidle_locked() */
+	val = READ_ONCE(tp->keepalive_time);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
 }
 
 static inline int keepalive_probes(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_probes ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepcnt()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_probes);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
 }
 
 static inline u32 keepalive_time_elapsed(const struct tcp_sock *tp)
@@ -1977,7 +1991,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+	u32 val;
+
+	val = READ_ONCE(tp->notsent_lowat);
+
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 /* @wake is one when sk_stream_write_space() calls us.
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 40e9b5a12732..5c540ccabcac 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -156,7 +156,11 @@ DEFINE_EVENT(timer_class, timer_cancel,
 		{ HRTIMER_MODE_ABS_SOFT,	"ABS|SOFT"	},	\
 		{ HRTIMER_MODE_REL_SOFT,	"REL|SOFT"	},	\
 		{ HRTIMER_MODE_ABS_PINNED_SOFT,	"ABS|PINNED|SOFT" },	\
-		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" })
+		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" },	\
+		{ HRTIMER_MODE_ABS_HARD,	"ABS|HARD" },		\
+		{ HRTIMER_MODE_REL_HARD,	"REL|HARD" },		\
+		{ HRTIMER_MODE_ABS_PINNED_HARD, "ABS|PINNED|HARD" },	\
+		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
 
 /**
  * hrtimer_init - called when the hrtimer is initialized
diff --git a/include/uapi/linux/affs_hardblocks.h b/include/uapi/linux/affs_hardblocks.h
index 5e2fb8481252..a5aff2eb5f70 100644
--- a/include/uapi/linux/affs_hardblocks.h
+++ b/include/uapi/linux/affs_hardblocks.h
@@ -7,42 +7,42 @@
 /* Just the needed definitions for the RDB of an Amiga HD. */
 
 struct RigidDiskBlock {
-	__u32	rdb_ID;
+	__be32	rdb_ID;
 	__be32	rdb_SummedLongs;
-	__s32	rdb_ChkSum;
-	__u32	rdb_HostID;
+	__be32	rdb_ChkSum;
+	__be32	rdb_HostID;
 	__be32	rdb_BlockBytes;
-	__u32	rdb_Flags;
-	__u32	rdb_BadBlockList;
+	__be32	rdb_Flags;
+	__be32	rdb_BadBlockList;
 	__be32	rdb_PartitionList;
-	__u32	rdb_FileSysHeaderList;
-	__u32	rdb_DriveInit;
-	__u32	rdb_Reserved1[6];
-	__u32	rdb_Cylinders;
-	__u32	rdb_Sectors;
-	__u32	rdb_Heads;
-	__u32	rdb_Interleave;
-	__u32	rdb_Park;
-	__u32	rdb_Reserved2[3];
-	__u32	rdb_WritePreComp;
-	__u32	rdb_ReducedWrite;
-	__u32	rdb_StepRate;
-	__u32	rdb_Reserved3[5];
-	__u32	rdb_RDBBlocksLo;
-	__u32	rdb_RDBBlocksHi;
-	__u32	rdb_LoCylinder;
-	__u32	rdb_HiCylinder;
-	__u32	rdb_CylBlocks;
-	__u32	rdb_AutoParkSeconds;
-	__u32	rdb_HighRDSKBlock;
-	__u32	rdb_Reserved4;
+	__be32	rdb_FileSysHeaderList;
+	__be32	rdb_DriveInit;
+	__be32	rdb_Reserved1[6];
+	__be32	rdb_Cylinders;
+	__be32	rdb_Sectors;
+	__be32	rdb_Heads;
+	__be32	rdb_Interleave;
+	__be32	rdb_Park;
+	__be32	rdb_Reserved2[3];
+	__be32	rdb_WritePreComp;
+	__be32	rdb_ReducedWrite;
+	__be32	rdb_StepRate;
+	__be32	rdb_Reserved3[5];
+	__be32	rdb_RDBBlocksLo;
+	__be32	rdb_RDBBlocksHi;
+	__be32	rdb_LoCylinder;
+	__be32	rdb_HiCylinder;
+	__be32	rdb_CylBlocks;
+	__be32	rdb_AutoParkSeconds;
+	__be32	rdb_HighRDSKBlock;
+	__be32	rdb_Reserved4;
 	char	rdb_DiskVendor[8];
 	char	rdb_DiskProduct[16];
 	char	rdb_DiskRevision[4];
 	char	rdb_ControllerVendor[8];
 	char	rdb_ControllerProduct[16];
 	char	rdb_ControllerRevision[4];
-	__u32	rdb_Reserved5[10];
+	__be32	rdb_Reserved5[10];
 };
 
 #define	IDNAME_RIGIDDISK	0x5244534B	/* "RDSK" */
@@ -50,16 +50,16 @@ struct RigidDiskBlock {
 struct PartitionBlock {
 	__be32	pb_ID;
 	__be32	pb_SummedLongs;
-	__s32	pb_ChkSum;
-	__u32	pb_HostID;
+	__be32	pb_ChkSum;
+	__be32	pb_HostID;
 	__be32	pb_Next;
-	__u32	pb_Flags;
-	__u32	pb_Reserved1[2];
-	__u32	pb_DevFlags;
+	__be32	pb_Flags;
+	__be32	pb_Reserved1[2];
+	__be32	pb_DevFlags;
 	__u8	pb_DriveName[32];
-	__u32	pb_Reserved2[15];
+	__be32	pb_Reserved2[15];
 	__be32	pb_Environment[17];
-	__u32	pb_EReserved[15];
+	__be32	pb_EReserved[15];
 };
 
 #define	IDNAME_PARTITION	0x50415254	/* "PART" */
diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index 62e625356dc8..08be539605fc 100644
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -109,7 +109,7 @@ struct autofs_dev_ioctl {
 		struct args_ismountpoint	ismountpoint;
 	};
 
-	char path[0];
+	char path[];
 };
 
 static inline void init_autofs_dev_ioctl(struct autofs_dev_ioctl *in)
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index b28817c59fdf..55b8c4b82479 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1644,7 +1644,7 @@ struct v4l2_input {
 	__u8	     name[32];		/*  Label */
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
-	__u32        tuner;             /*  enum v4l2_tuner_type */
+	__u32        tuner;             /*  Tuner index */
 	v4l2_std_id  std;
 	__u32	     status;
 	__u32	     capabilities;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index f169b4645769..51e6ebe72caf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1521,6 +1521,8 @@ static void io_kill_timeout(struct io_kiocb *req, int status)
 
 static void io_queue_deferred(struct io_ring_ctx *ctx)
 {
+	lockdep_assert_held(&ctx->completion_lock);
+
 	while (!list_empty(&ctx->defer_list)) {
 		struct io_defer_entry *de = list_first_entry(&ctx->defer_list,
 						struct io_defer_entry, list);
@@ -1572,14 +1574,24 @@ static void __io_commit_cqring_flush(struct io_ring_ctx *ctx)
 		io_queue_deferred(ctx);
 }
 
-static inline void io_commit_cqring(struct io_ring_ctx *ctx)
+static inline bool io_commit_needs_flush(struct io_ring_ctx *ctx)
+{
+	return ctx->off_timeout_used || ctx->drain_active;
+}
+
+static inline void __io_commit_cqring(struct io_ring_ctx *ctx)
 {
-	if (unlikely(ctx->off_timeout_used || ctx->drain_active))
-		__io_commit_cqring_flush(ctx);
 	/* order cqe stores with ring update */
 	smp_store_release(&ctx->rings->cq.tail, ctx->cached_cq_tail);
 }
 
+static inline void io_commit_cqring(struct io_ring_ctx *ctx)
+{
+	if (unlikely(io_commit_needs_flush(ctx)))
+		__io_commit_cqring_flush(ctx);
+	__io_commit_cqring(ctx);
+}
+
 static inline bool io_sqring_full(struct io_ring_ctx *ctx)
 {
 	struct io_rings *r = ctx->rings;
@@ -2202,9 +2214,12 @@ static void tctx_task_work(struct callback_head *cb)
 			}
 			req->io_task_work.func(req, &locked);
 			node = next;
+			if (unlikely(need_resched())) {
+				ctx_flush_and_put(ctx, &locked);
+				ctx = NULL;
+				cond_resched();
+			}
 		} while (node);
-
-		cond_resched();
 	}
 
 	ctx_flush_and_put(ctx, &locked);
@@ -2518,7 +2533,12 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			io_req_free_batch(&rb, req, &ctx->submit_state);
 	}
 
-	io_commit_cqring(ctx);
+	if (io_commit_needs_flush(ctx)) {
+		spin_lock(&ctx->completion_lock);
+		__io_commit_cqring_flush(ctx);
+		spin_unlock(&ctx->completion_lock);
+	}
+	__io_commit_cqring(ctx);
 	io_cqring_ev_posted_iopoll(ctx);
 	io_req_free_batch_finish(ctx, &rb);
 }
@@ -7608,7 +7628,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
 					  ktime_t *timeout)
 {
-	int ret;
+	int token, ret;
 
 	/* make sure we run task_work before checking for signals */
 	ret = io_run_task_work_sig();
@@ -7618,9 +7638,17 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	if (test_bit(0, &ctx->check_cq_overflow))
 		return 1;
 
+	/*
+	 * Use io_schedule_prepare/finish, so cpufreq can take into account
+	 * that the task is waiting for IO - turns out to be important for low
+	 * QD IO.
+	 */
+	token = io_schedule_prepare();
+	ret = 1;
 	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
-		return -ETIME;
-	return 1;
+		ret = -ETIME;
+	io_schedule_finish(token);
+	return ret;
 }
 
 /*
@@ -9526,7 +9554,18 @@ static void io_ring_exit_work(struct work_struct *work)
 			/* there is little hope left, don't run it too often */
 			interval = HZ * 60;
 		}
-	} while (!wait_for_completion_timeout(&ctx->ref_comp, interval));
+		/*
+		 * This is really an uninterruptible wait, as it has to be
+		 * complete. But it's also run from a kworker, which doesn't
+		 * take signals, so it's fine to make it interruptible. This
+		 * avoids scenarios where we knowingly can wait much longer
+		 * on completions, for example if someone does a SIGSTOP on
+		 * a task that needs to finish task_work to make this loop
+		 * complete. That's a synthetic situation that should not
+		 * cause a stuck task backtrace, and hence a potential panic
+		 * on stuck tasks if that is enabled.
+		 */
+	} while (!wait_for_completion_interruptible_timeout(&ctx->ref_comp, interval));
 
 	init_completion(&exit.completion);
 	init_task_work(&exit.task_work, io_tctx_exit_cb);
@@ -9551,7 +9590,12 @@ static void io_ring_exit_work(struct work_struct *work)
 		wake_up_process(node->task);
 
 		mutex_unlock(&ctx->uring_lock);
-		wait_for_completion(&exit.completion);
+		/*
+		 * See comment above for
+		 * wait_for_completion_interruptible_timeout() on why this
+		 * wait is marked as interruptible.
+		 */
+		wait_for_completion_interruptible(&exit.completion);
 		mutex_lock(&ctx->uring_lock);
 	}
 	mutex_unlock(&ctx->uring_lock);
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index d99e89f113c4..3dabdd137d10 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -41,7 +41,12 @@ static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
 /* bpf_lru_node helpers */
 static bool bpf_lru_node_is_ref(const struct bpf_lru_node *node)
 {
-	return node->ref;
+	return READ_ONCE(node->ref);
+}
+
+static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
+{
+	WRITE_ONCE(node->ref, 0);
 }
 
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
@@ -89,7 +94,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -110,7 +115,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 		bpf_lru_list_count_inc(l, tgt_type);
 		node->type = tgt_type;
 	}
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 
 	/* If the moving node is the next_inactive_rotation candidate,
 	 * move the next_inactive_rotation pointer also.
@@ -353,7 +358,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -419,7 +424,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
 		*(u32 *)((void *)node + lru->hash_offset) = hash;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
@@ -522,7 +527,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -568,7 +573,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -594,7 +599,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 6b12f06ee18c..9c12ee453c61 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -63,11 +63,8 @@ struct bpf_lru {
 
 static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 {
-	/* ref is an approximation on access frequency.  It does not
-	 * have to be very accurate.  Hence, no protection is used.
-	 */
-	if (!node->ref)
-		node->ref = 1;
+	if (!READ_ONCE(node->ref))
+		WRITE_ONCE(node->ref, 1);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index d3593a520bb7..85927c2aa343 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1546,6 +1546,52 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	sockopt_free_buf(&ctx);
 	return ret;
 }
+
+int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
+					    int optname, void *optval,
+					    int *optlen, int retval)
+{
+	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
+	struct bpf_sockopt_kern ctx = {
+		.sk = sk,
+		.level = level,
+		.optname = optname,
+		.retval = retval,
+		.optlen = *optlen,
+		.optval = optval,
+		.optval_end = optval + *optlen,
+	};
+	int ret;
+
+	/* Note that __cgroup_bpf_run_filter_getsockopt doesn't copy
+	 * user data back into BPF buffer when reval != 0. This is
+	 * done as an optimization to avoid extra copy, assuming
+	 * kernel won't populate the data in case of an error.
+	 * Here we always pass the data and memset() should
+	 * be called if that data shouldn't be "exported".
+	 */
+
+	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
+				 &ctx, BPF_PROG_RUN);
+	if (!ret)
+		return -EPERM;
+
+	if (ctx.optlen > *optlen)
+		return -EFAULT;
+
+	/* BPF programs only allowed to set retval to 0, not some
+	 * arbitrary value.
+	 */
+	if (ctx.retval != 0 && ctx.retval != retval)
+		return -EFAULT;
+
+	/* BPF programs can shrink the buffer, export the modifications.
+	 */
+	if (ctx.optlen != 0)
+		*optlen = ctx.optlen;
+
+	return ctx.retval;
+}
 #endif
 
 static ssize_t sysctl_cpy_dir(const struct ctl_dir *dir, char **bufp,
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 762df6108c58..473dc04591b8 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1035,7 +1035,9 @@ EXPORT_SYMBOL(__tsan_init);
 DEFINE_TSAN_ATOMIC_OPS(8);
 DEFINE_TSAN_ATOMIC_OPS(16);
 DEFINE_TSAN_ATOMIC_OPS(32);
+#ifdef CONFIG_64BIT
 DEFINE_TSAN_ATOMIC_OPS(64);
+#endif
 
 void __tsan_atomic_thread_fence(int memorder);
 void __tsan_atomic_thread_fence(int memorder)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7a8104d48997..3a37fc62dc95 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1029,6 +1029,7 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
@@ -1040,9 +1041,7 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
-	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
-
+	end = start + new_size;
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2819b95479af..6c05365ed80f 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -49,8 +49,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 	pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s)
 #define VERBOSE_SCALEOUT_STRING(s) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s); } while (0)
-#define VERBOSE_SCALEOUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s); } while (0)
+#define SCALEOUT_ERRSTRING(s) \
+	pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s)
 
 /*
  * The intended use cases for the nreaders and nwriters module parameters
@@ -457,7 +457,7 @@ rcu_scale_writer(void *arg)
 	if (gp_async) {
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max;
+	writer_n_durations[me] = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -470,89 +470,6 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
 }
 
-static void
-rcu_scale_cleanup(void)
-{
-	int i;
-	int j;
-	int ngps = 0;
-	u64 *wdp;
-	u64 *wdpp;
-
-	/*
-	 * Would like warning at start, but everything is expedited
-	 * during the mid-boot phase, so have to wait till the end.
-	 */
-	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
-		VERBOSE_SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
-	if (rcu_gp_is_normal() && gp_exp)
-		VERBOSE_SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
-	if (gp_exp && gp_async)
-		VERBOSE_SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
-
-	if (torture_cleanup_begin())
-		return;
-	if (!cur_ops) {
-		torture_cleanup_end();
-		return;
-	}
-
-	if (reader_tasks) {
-		for (i = 0; i < nrealreaders; i++)
-			torture_stop_kthread(rcu_scale_reader,
-					     reader_tasks[i]);
-		kfree(reader_tasks);
-	}
-
-	if (writer_tasks) {
-		for (i = 0; i < nrealwriters; i++) {
-			torture_stop_kthread(rcu_scale_writer,
-					     writer_tasks[i]);
-			if (!writer_n_durations)
-				continue;
-			j = writer_n_durations[i];
-			pr_alert("%s%s writer %d gps: %d\n",
-				 scale_type, SCALE_FLAG, i, j);
-			ngps += j;
-		}
-		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
-			 scale_type, SCALE_FLAG,
-			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
-			 t_rcu_scale_writer_finished -
-			 t_rcu_scale_writer_started,
-			 ngps,
-			 rcuscale_seq_diff(b_rcu_gp_test_finished,
-					   b_rcu_gp_test_started));
-		for (i = 0; i < nrealwriters; i++) {
-			if (!writer_durations)
-				break;
-			if (!writer_n_durations)
-				continue;
-			wdpp = writer_durations[i];
-			if (!wdpp)
-				continue;
-			for (j = 0; j <= writer_n_durations[i]; j++) {
-				wdp = &wdpp[j];
-				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
-					scale_type, SCALE_FLAG,
-					i, j, *wdp);
-				if (j % 100 == 0)
-					schedule_timeout_uninterruptible(1);
-			}
-			kfree(writer_durations[i]);
-		}
-		kfree(writer_tasks);
-		kfree(writer_durations);
-		kfree(writer_n_durations);
-	}
-
-	/* Do torture-type-specific cleanup operations.  */
-	if (cur_ops->cleanup != NULL)
-		cur_ops->cleanup();
-
-	torture_cleanup_end();
-}
-
 /*
  * Return the number if non-negative.  If -1, the number of CPUs.
  * If less than -1, that much less than the number of CPUs, but
@@ -572,21 +489,6 @@ static int compute_real(int n)
 	return nr;
 }
 
-/*
- * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
- * down system.
- */
-static int
-rcu_scale_shutdown(void *arg)
-{
-	wait_event(shutdown_wq,
-		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
-	smp_mb(); /* Wake before output. */
-	rcu_scale_cleanup();
-	kernel_power_off();
-	return -EINVAL;
-}
-
 /*
  * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs for number
  * of iterations and measure total time and number of GP for all iterations to complete.
@@ -693,8 +595,8 @@ kfree_scale_cleanup(void)
 static int
 kfree_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
+	wait_event_idle(shutdown_wq,
+			atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
@@ -748,6 +650,108 @@ kfree_scale_init(void)
 	return firsterr;
 }
 
+static void
+rcu_scale_cleanup(void)
+{
+	int i;
+	int j;
+	int ngps = 0;
+	u64 *wdp;
+	u64 *wdpp;
+
+	/*
+	 * Would like warning at start, but everything is expedited
+	 * during the mid-boot phase, so have to wait till the end.
+	 */
+	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
+		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
+	if (rcu_gp_is_normal() && gp_exp)
+		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
+	if (gp_exp && gp_async)
+		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
+
+	if (kfree_rcu_test) {
+		kfree_scale_cleanup();
+		return;
+	}
+
+	if (torture_cleanup_begin())
+		return;
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
+
+	if (reader_tasks) {
+		for (i = 0; i < nrealreaders; i++)
+			torture_stop_kthread(rcu_scale_reader,
+					     reader_tasks[i]);
+		kfree(reader_tasks);
+	}
+
+	if (writer_tasks) {
+		for (i = 0; i < nrealwriters; i++) {
+			torture_stop_kthread(rcu_scale_writer,
+					     writer_tasks[i]);
+			if (!writer_n_durations)
+				continue;
+			j = writer_n_durations[i];
+			pr_alert("%s%s writer %d gps: %d\n",
+				 scale_type, SCALE_FLAG, i, j);
+			ngps += j;
+		}
+		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
+			 scale_type, SCALE_FLAG,
+			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
+			 t_rcu_scale_writer_finished -
+			 t_rcu_scale_writer_started,
+			 ngps,
+			 rcuscale_seq_diff(b_rcu_gp_test_finished,
+					   b_rcu_gp_test_started));
+		for (i = 0; i < nrealwriters; i++) {
+			if (!writer_durations)
+				break;
+			if (!writer_n_durations)
+				continue;
+			wdpp = writer_durations[i];
+			if (!wdpp)
+				continue;
+			for (j = 0; j < writer_n_durations[i]; j++) {
+				wdp = &wdpp[j];
+				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
+					scale_type, SCALE_FLAG,
+					i, j, *wdp);
+				if (j % 100 == 0)
+					schedule_timeout_uninterruptible(1);
+			}
+			kfree(writer_durations[i]);
+		}
+		kfree(writer_tasks);
+		kfree(writer_durations);
+		kfree(writer_n_durations);
+	}
+
+	/* Do torture-type-specific cleanup operations.  */
+	if (cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
+
+	torture_cleanup_end();
+}
+
+/*
+ * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
+ * down system.
+ */
+static int
+rcu_scale_shutdown(void *arg)
+{
+	wait_event_idle(shutdown_wq, atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
+	smp_mb(); /* Wake before output. */
+	rcu_scale_cleanup();
+	kernel_power_off();
+	return -EINVAL;
+}
+
 static int __init
 rcu_scale_init(void)
 {
@@ -803,7 +807,7 @@ rcu_scale_init(void)
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -823,7 +827,7 @@ rcu_scale_init(void)
 		kcalloc(nrealwriters, sizeof(*writer_n_durations),
 			GFP_KERNEL);
 	if (!writer_tasks || !writer_durations || !writer_n_durations) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c66d47685b28..23101ebbbe1e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -801,7 +801,7 @@ static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
-	int nq = t->trc_reader_special.b.need_qs;
+	int nq = READ_ONCE(t->trc_reader_special.b.need_qs);
 
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
 	    t->trc_reader_special.b.need_mb)
@@ -841,33 +841,25 @@ static void trc_read_check_handler(void *t_in)
 
 	// If the task is no longer running on this CPU, leave.
 	if (unlikely(texp != t)) {
-		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
-			wake_up(&trc_wait);
 		goto reset_ipi; // Already on holdout list, so will check later.
 	}
 
 	// If the task is not in a read-side critical section, and
 	// if this is the last reader, awaken the grace-period kthread.
-	if (likely(!t->trc_reader_nesting)) {
-		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
-			wake_up(&trc_wait);
-		// Mark as checked after decrement to avoid false
-		// positives on the above WARN_ON_ONCE().
+	if (likely(!READ_ONCE(t->trc_reader_nesting))) {
 		WRITE_ONCE(t->trc_reader_checked, true);
 		goto reset_ipi;
 	}
 	// If we are racing with an rcu_read_unlock_trace(), try again later.
-	if (unlikely(t->trc_reader_nesting < 0)) {
-		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
-			wake_up(&trc_wait);
+	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0))
 		goto reset_ipi;
-	}
 	WRITE_ONCE(t->trc_reader_checked, true);
 
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 
 reset_ipi:
@@ -904,6 +896,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 			n_heavy_reader_ofl_updates++;
 		in_qs = true;
 	} else {
+		// The task is not running, so C-language access is safe.
 		in_qs = likely(!t->trc_reader_nesting);
 	}
 
@@ -918,7 +911,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	// state so that it will awaken the grace-period kthread upon exit
 	// from that critical section.
 	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	return true;
 }
@@ -936,7 +929,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	// The current task had better be in a quiescent state.
 	if (t == current) {
 		t->trc_reader_checked = true;
-		WARN_ON_ONCE(t->trc_reader_nesting);
+		WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 		return;
 	}
 
@@ -959,21 +952,15 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 		if (per_cpu(trc_ipi_to_cpu, cpu) || t->trc_ipi_to_cpu >= 0)
 			return;
 
-		atomic_inc(&trc_n_readers_need_end);
 		per_cpu(trc_ipi_to_cpu, cpu) = true;
 		t->trc_ipi_to_cpu = cpu;
 		rcu_tasks_trace.n_ipis++;
-		if (smp_call_function_single(cpu,
-					     trc_read_check_handler, t, 0)) {
+		if (smp_call_function_single(cpu, trc_read_check_handler, t, 0)) {
 			// Just in case there is some other reason for
 			// failure than the target CPU being offline.
 			rcu_tasks_trace.n_ipis_fails++;
 			per_cpu(trc_ipi_to_cpu, cpu) = false;
 			t->trc_ipi_to_cpu = cpu;
-			if (atomic_dec_and_test(&trc_n_readers_need_end)) {
-				WARN_ON_ONCE(1);
-				wake_up(&trc_wait);
-			}
 		}
 	}
 }
@@ -1046,8 +1033,8 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
-		 t->trc_reader_nesting,
-		 " N"[!!t->trc_reader_special.b.need_qs],
+		 READ_ONCE(t->trc_reader_nesting),
+		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
 		 cpu);
 	sched_show_task(t);
 }
@@ -1141,7 +1128,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
 	WRITE_ONCE(t->trc_reader_checked, true);
-	WARN_ON_ONCE(t->trc_reader_nesting);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 	WRITE_ONCE(t->trc_reader_nesting, 0);
 	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
 		rcu_read_unlock_trace_special(t, 0);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 45c1d03aff73..d53f57ac7609 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9883,7 +9883,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
-		.dst_grpmask    = sched_group_span(sd->groups),
+		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
 		.loop_break	= sched_nr_migrate_break,
 		.cpus		= cpus,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d089627f2f2b..29569b1c3d8c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -140,25 +140,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	int first_free_id = sig->posix_timer_id;
 	struct hlist_head *head;
-	int ret = -ENOENT;
+	unsigned int cnt, id;
 
-	do {
+	/*
+	 * FIXME: Replace this by a per signal struct xarray once there is
+	 * a plan to handle the resulting CRIU regression gracefully.
+	 */
+	for (cnt = 0; cnt <= INT_MAX; cnt++) {
 		spin_lock(&hash_lock);
-		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
-		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
+		id = sig->next_posix_timer_id;
+
+		/* Write the next ID back. Clamp it to the positive space */
+		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+
+		head = &posix_timers_hashtable[hash(sig, id)];
+		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
-			ret = sig->posix_timer_id;
+			spin_unlock(&hash_lock);
+			return id;
 		}
-		if (++sig->posix_timer_id < 0)
-			sig->posix_timer_id = 0;
-		if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
-			/* Loop over all possible ids completed */
-			ret = -EAGAIN;
 		spin_unlock(&hash_lock);
-	} while (ret == -ENOENT);
-	return ret;
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -1037,27 +1042,52 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 }
 
 /*
- * return timer owned by the process, used by exit_itimers
+ * Delete a timer if it is armed, remove it from the hash and schedule it
+ * for RCU freeing.
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-retry_delete:
-	spin_lock_irq(&timer->it_lock);
+	unsigned long flags;
+
+	/*
+	 * irqsave is required to make timer_wait_running() work.
+	 */
+	spin_lock_irqsave(&timer->it_lock, flags);
 
+retry_delete:
+	/*
+	 * Even if the timer is not longer accessible from other tasks
+	 * it still might be armed and queued in the underlying timer
+	 * mechanism. Worse, that timer mechanism might run the expiry
+	 * function concurrently.
+	 */
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		spin_unlock_irq(&timer->it_lock);
+		/*
+		 * Timer is expired concurrently, prevent livelocks
+		 * and pointless spinning on RT.
+		 *
+		 * timer_wait_running() drops timer::it_lock, which opens
+		 * the possibility for another task to delete the timer.
+		 *
+		 * That's not possible here because this is invoked from
+		 * do_exit() only for the last thread of the thread group.
+		 * So no other task can access and delete that timer.
+		 */
+		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
+			return;
+
 		goto retry_delete;
 	}
 	list_del(&timer->list);
 
-	spin_unlock_irq(&timer->it_lock);
+	spin_unlock_irqrestore(&timer->it_lock, flags);
 	release_posix_timer(timer, IT_ID_SET);
 }
 
 /*
- * This is called by do_exit or de_thread, only when nobody else can
- * modify the signal->posix_timers list. Yet we need sighand->siglock
- * to prevent the race with /proc/pid/timers.
+ * Invoked from do_exit() when the last thread of a thread group exits.
+ * At that point no other task can access the timers of the dying
+ * task anymore.
  */
 void exit_itimers(struct task_struct *tsk)
 {
@@ -1067,10 +1097,12 @@ void exit_itimers(struct task_struct *tsk)
 	if (list_empty(&tsk->signal->posix_timers))
 		return;
 
+	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
 	list_replace_init(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
+	/* The timers are not longer accessible via tsk::signal */
 	while (!list_empty(&timers)) {
 		tmr = list_first_entry(&timers, struct k_itimer, list);
 		itimer_delete(tmr);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3dab978c156d..31fec924b7c4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1091,7 +1091,7 @@ struct ftrace_page {
 	struct ftrace_page	*next;
 	struct dyn_ftrace	*records;
 	int			index;
-	int			size;
+	int			order;
 };
 
 #define ENTRY_SIZE sizeof(struct dyn_ftrace)
@@ -3188,7 +3188,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	ftrace_number_of_groups++;
 
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
-	pg->size = cnt;
+	pg->order = order;
 
 	if (cnt > count)
 		cnt = count;
@@ -3196,12 +3196,27 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	return cnt;
 }
 
+static void ftrace_free_pages(struct ftrace_page *pages)
+{
+	struct ftrace_page *pg = pages;
+
+	while (pg) {
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
+		pages = pg->next;
+		kfree(pg);
+		pg = pages;
+		ftrace_number_of_groups--;
+	}
+}
+
 static struct ftrace_page *
 ftrace_allocate_pages(unsigned long num_to_init)
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
-	int order;
 	int cnt;
 
 	if (!num_to_init)
@@ -3235,17 +3250,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	return start_pg;
 
  free_pages:
-	pg = start_pg;
-	while (pg) {
-		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		if (order >= 0)
-			free_pages((unsigned long)pg->records, order);
-		start_pg = pg->next;
-		kfree(pg);
-		pg = start_pg;
-		ftrace_number_of_pages -= 1 << order;
-		ftrace_number_of_groups--;
-	}
+	ftrace_free_pages(start_pg);
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
 }
@@ -6191,9 +6196,11 @@ static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
 {
+	struct ftrace_page *pg_unuse = NULL;
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
+	unsigned long skipped = 0;
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
@@ -6239,6 +6246,7 @@ static int ftrace_process_locs(struct module *mod,
 	p = start;
 	pg = start_pg;
 	while (p < end) {
+		unsigned long end_offset;
 		addr = ftrace_call_adjust(*p++);
 		/*
 		 * Some architecture linkers will pad between
@@ -6246,10 +6254,13 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr)
+		if (!addr) {
+			skipped++;
 			continue;
+		}
 
-		if (pg->index == pg->size) {
+		end_offset = (pg->index+1) * sizeof(pg->records[0]);
+		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
 			if (WARN_ON(!pg->next))
 				break;
@@ -6260,8 +6271,10 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	/* We should have used all pages */
-	WARN_ON(pg->next);
+	if (pg->next) {
+		pg_unuse = pg->next;
+		pg->next = NULL;
+	}
 
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
@@ -6283,6 +6296,11 @@ static int ftrace_process_locs(struct module *mod,
  out:
 	mutex_unlock(&ftrace_lock);
 
+	/* We should have used all pages unless we skipped some */
+	if (pg_unuse) {
+		WARN_ON(!skipped);
+		ftrace_free_pages(pg_unuse);
+	}
 	return ret;
 }
 
@@ -6418,7 +6436,6 @@ void ftrace_release_mod(struct module *mod)
 	struct ftrace_page **last_pg;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
-	int order;
 
 	mutex_lock(&ftrace_lock);
 
@@ -6469,12 +6486,12 @@ void ftrace_release_mod(struct module *mod)
 		/* Needs to be called outside of ftrace_lock */
 		clear_mod_from_hashes(pg);
 
-		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		if (order >= 0)
-			free_pages((unsigned long)pg->records, order);
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
 		tmp_page = pg->next;
 		kfree(pg);
-		ftrace_number_of_pages -= 1 << order;
 		ftrace_number_of_groups--;
 	}
 }
@@ -6792,7 +6809,6 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct ftrace_mod_map *mod_map = NULL;
 	struct ftrace_init_func *func, *func_next;
 	struct list_head clear_hash;
-	int order;
 
 	INIT_LIST_HEAD(&clear_hash);
 
@@ -6830,10 +6846,10 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-			if (order >= 0)
-				free_pages((unsigned long)pg->records, order);
-			ftrace_number_of_pages -= 1 << order;
+			if (pg->records) {
+				free_pages((unsigned long)pg->records, pg->order);
+				ftrace_number_of_pages -= 1 << pg->order;
+			}
 			ftrace_number_of_groups--;
 			kfree(pg);
 			pg = container_of(last_pg, struct ftrace_page, next);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f08904914166..593e446f6c48 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4954,28 +4954,34 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
+static void rb_clear_buffer_page(struct buffer_page *page)
+{
+	local_set(&page->write, 0);
+	local_set(&page->entries, 0);
+	rb_init_page(page->page);
+	page->read = 0;
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
+	struct buffer_page *page;
+
 	rb_head_page_deactivate(cpu_buffer);
 
 	cpu_buffer->head_page
 		= list_entry(cpu_buffer->pages, struct buffer_page, list);
-	local_set(&cpu_buffer->head_page->write, 0);
-	local_set(&cpu_buffer->head_page->entries, 0);
-	local_set(&cpu_buffer->head_page->page->commit, 0);
-
-	cpu_buffer->head_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->head_page);
+	list_for_each_entry(page, cpu_buffer->pages, list) {
+		rb_clear_buffer_page(page);
+	}
 
 	cpu_buffer->tail_page = cpu_buffer->head_page;
 	cpu_buffer->commit_page = cpu_buffer->head_page;
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
-	local_set(&cpu_buffer->reader_page->write, 0);
-	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
-	cpu_buffer->reader_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->reader_page);
 
 	local_set(&cpu_buffer->entries_bytes, 0);
 	local_set(&cpu_buffer->overrun, 0);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 70526400e05c..7867fc39c4fc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6250,6 +6250,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 	mutex_unlock(&trace_types_lock);
 
 	free_cpumask_var(iter->started);
+	kfree(iter->temp);
 	mutex_destroy(&iter->mutex);
 	kfree(iter);
 
@@ -7529,7 +7530,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek         = tracing_lseek,
 	.release        = tracing_err_log_release,
 };
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9ed65191888e..059a106e62be 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5817,13 +5817,16 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	if (has_hist_vars(hist_data))
-		save_hist_vars(hist_data);
-
 	ret = create_actions(hist_data);
 	if (ret)
 		goto out_unreg;
 
+	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+		ret = save_hist_vars(hist_data);
+		if (ret)
+			goto out_unreg;
+	}
+
 	ret = tracing_map_init(hist_data->map);
 	if (ret)
 		goto out_unreg;
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index e5282828f4a6..29348874ebde 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -143,6 +143,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 array:
 	/* the last stage: Loop on array */
 	if (code->op == FETCH_OP_LP_ARRAY) {
+		if (ret < 0)
+			ret = 0;
 		total += ret;
 		if (++i < code->param) {
 			code = s3;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..1e8a49dc956e 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -114,14 +114,14 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	/* Ensure the watchdog never gets throttled */
 	event->hw.interrupts = 0;
 
+	if (!watchdog_check_timestamp())
+		return;
+
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
 	}
 
-	if (!watchdog_check_timestamp())
-		return;
-
 	/* check for a hardlockup
 	 * This is done by making sure our timer interrupt
 	 * is incrementing.  The timer interrupt should have
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b9041ab881bc..fa0a0e59b385 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -679,12 +679,17 @@ static void clear_work_data(struct work_struct *work)
 	set_work_data(work, WORK_STRUCT_NO_POOL, 0);
 }
 
+static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
+{
+	return (struct pool_workqueue *)(data & WORK_STRUCT_WQ_DATA_MASK);
+}
+
 static struct pool_workqueue *get_work_pwq(struct work_struct *work)
 {
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
+		return work_struct_pwq(data);
 	else
 		return NULL;
 }
@@ -712,8 +717,7 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 	assert_rcu_or_pool_mutex();
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+		return work_struct_pwq(data)->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -734,8 +738,7 @@ static int get_work_pool_id(struct work_struct *work)
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+		return work_struct_pwq(data)->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4c39678c03ee..4dd9283f6fea 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -501,6 +501,15 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
+	/*
+	 * Don't report if lookup_object_or_alloc() by the current thread
+	 * failed because lookup_object_or_alloc()/debug_objects_oom() by a
+	 * concurrent thread turned off debug_objects_enabled and cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index ed0455a9ded8..25dc9eb6c902 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -183,7 +183,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -606,7 +606,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -654,7 +654,7 @@ static ssize_t trigger_request_platform_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("inserting test platform fw '%s'\n", name);
 	efi_embedded_fw.name = name;
@@ -707,7 +707,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -752,7 +752,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
@@ -803,7 +803,7 @@ static int test_fw_run_batch_request(void *data)
 
 		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
 		if (!test_buf)
-			return -ENOSPC;
+			return -ENOMEM;
 
 		if (test_fw_config->partial)
 			req->rc = request_partial_firmware_into_buf
diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 4cf250031f0f..352ae837e031 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -60,10 +60,12 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 	struct ts_bm *bm = ts_config_priv(conf);
 	unsigned int i, text_len, consumed = state->offset;
 	const u8 *text;
-	int shift = bm->patlen - 1, bs;
+	int bs;
 	const u8 icase = conf->flags & TS_IGNORECASE;
 
 	for (;;) {
+		int shift = bm->patlen - 1;
+
 		text_len = conf->get_next_block(consumed, &text, conf, state);
 
 		if (unlikely(text_len == 0))
diff --git a/mm/shmem.c b/mm/shmem.c
index d3d8c5e7a296..cfa8f43cb3a6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4128,7 +4128,7 @@ static struct file_system_type shmem_fs_type = {
 	.name		= "tmpfs",
 	.init_fs_context = ramfs_init_fs_context,
 	.parameters	= ramfs_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= ramfs_kill_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 1d87bf51f384..e35488fde9c8 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -157,8 +157,9 @@ void br_manage_promisc(struct net_bridge *br)
 			 * This lets us disable promiscuous mode and write
 			 * this config to hw.
 			 */
-			if (br->auto_cnt == 0 ||
-			    (br->auto_cnt == 1 && br_auto_port(p)))
+			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
+			    (br->auto_cnt == 0 ||
+			     (br->auto_cnt == 1 && br_auto_port(p))))
 				br_port_clear_promisc(p);
 			else
 				br_port_set_promisc(p);
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index ba55851fe132..3326dfced68a 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,6 +201,9 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
+	if (!net_eq(dev_net(br->dev), &init_net))
+		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
+
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
diff --git a/net/can/bcm.c b/net/can/bcm.c
index ddba4e12da78..2388c619f29c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1521,6 +1521,12 @@ static int bcm_release(struct socket *sock)
 
 	lock_sock(sk);
 
+#if IS_ENABLED(CONFIG_PROC_FS)
+	/* remove procfs entry */
+	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif /* CONFIG_PROC_FS */
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
@@ -1556,12 +1562,6 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
-#if IS_ENABLED(CONFIG_PROC_FS)
-	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
-		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
-#endif /* CONFIG_PROC_FS */
-
 	/* remove device reference */
 	if (bo->bound) {
 		bo->bound   = 0;
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4fcd8162fad4..16ebc187af1c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -990,8 +990,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		/* wait for complete transmission of current pdu */
 		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 
-		if (sk->sk_err)
-			return -sk->sk_err;
+		err = sock_error(sk);
+		if (err)
+			return err;
 	}
 
 	return size;
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 72047750dcd9..00c6944ed634 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -8092,7 +8092,10 @@ EXPORT_SYMBOL_GPL(devlink_free);
 
 static void devlink_port_type_warn(struct work_struct *work)
 {
-	WARN(true, "Type was not set for devlink port.");
+	struct devlink_port *port = container_of(to_delayed_work(work),
+						 struct devlink_port,
+						 type_warn_dw);
+	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3c9c2d6e3b92..d3c03ebf06a5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -929,24 +929,27 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
 			 nla_total_size(sizeof(struct ifla_vf_rate)) +
 			 nla_total_size(sizeof(struct ifla_vf_link_state)) +
 			 nla_total_size(sizeof(struct ifla_vf_rss_query_en)) +
-			 nla_total_size(0) + /* nest IFLA_VF_STATS */
-			 /* IFLA_VF_STATS_RX_PACKETS */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_TX_PACKETS */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_RX_BYTES */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_TX_BYTES */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_BROADCAST */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_MULTICAST */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_RX_DROPPED */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_TX_DROPPED */
-			 nla_total_size_64bit(sizeof(__u64)) +
 			 nla_total_size(sizeof(struct ifla_vf_trust)));
+		if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS) {
+			size += num_vfs *
+				(nla_total_size(0) + /* nest IFLA_VF_STATS */
+				 /* IFLA_VF_STATS_RX_PACKETS */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_TX_PACKETS */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_RX_BYTES */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_TX_BYTES */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_BROADCAST */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_MULTICAST */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_RX_DROPPED */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_TX_DROPPED */
+				 nla_total_size_64bit(sizeof(__u64)));
+		}
 		return size;
 	} else
 		return 0;
@@ -1221,7 +1224,8 @@ static noinline_for_stack int rtnl_fill_stats(struct sk_buff *skb,
 static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 					       struct net_device *dev,
 					       int vfs_num,
-					       struct nlattr *vfinfo)
+					       struct nlattr *vfinfo,
+					       u32 ext_filter_mask)
 {
 	struct ifla_vf_rss_query_en vf_rss_query_en;
 	struct nlattr *vf, *vfstats, *vfvlanlist;
@@ -1327,33 +1331,35 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 		goto nla_put_vf_failure;
 	}
 	nla_nest_end(skb, vfvlanlist);
-	memset(&vf_stats, 0, sizeof(vf_stats));
-	if (dev->netdev_ops->ndo_get_vf_stats)
-		dev->netdev_ops->ndo_get_vf_stats(dev, vfs_num,
-						&vf_stats);
-	vfstats = nla_nest_start_noflag(skb, IFLA_VF_STATS);
-	if (!vfstats)
-		goto nla_put_vf_failure;
-	if (nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_PACKETS,
-			      vf_stats.rx_packets, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_PACKETS,
-			      vf_stats.tx_packets, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_BYTES,
-			      vf_stats.rx_bytes, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_BYTES,
-			      vf_stats.tx_bytes, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_BROADCAST,
-			      vf_stats.broadcast, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_MULTICAST,
-			      vf_stats.multicast, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_DROPPED,
-			      vf_stats.rx_dropped, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_DROPPED,
-			      vf_stats.tx_dropped, IFLA_VF_STATS_PAD)) {
-		nla_nest_cancel(skb, vfstats);
-		goto nla_put_vf_failure;
+	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS) {
+		memset(&vf_stats, 0, sizeof(vf_stats));
+		if (dev->netdev_ops->ndo_get_vf_stats)
+			dev->netdev_ops->ndo_get_vf_stats(dev, vfs_num,
+							  &vf_stats);
+		vfstats = nla_nest_start_noflag(skb, IFLA_VF_STATS);
+		if (!vfstats)
+			goto nla_put_vf_failure;
+		if (nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_PACKETS,
+				      vf_stats.rx_packets, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_PACKETS,
+				      vf_stats.tx_packets, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_BYTES,
+				      vf_stats.rx_bytes, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_BYTES,
+				      vf_stats.tx_bytes, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_BROADCAST,
+				      vf_stats.broadcast, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_MULTICAST,
+				      vf_stats.multicast, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_DROPPED,
+				      vf_stats.rx_dropped, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_DROPPED,
+				      vf_stats.tx_dropped, IFLA_VF_STATS_PAD)) {
+			nla_nest_cancel(skb, vfstats);
+			goto nla_put_vf_failure;
+		}
+		nla_nest_end(skb, vfstats);
 	}
-	nla_nest_end(skb, vfstats);
 	nla_nest_end(skb, vf);
 	return 0;
 
@@ -1386,7 +1392,7 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	for (i = 0; i < num_vfs; i++) {
-		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo))
+		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask))
 			return -EMSGSIZE;
 	}
 
@@ -3883,7 +3889,7 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	ndm->ndm_ifindex = dev->ifindex;
 	ndm->ndm_state   = ndm_state;
 
-	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, addr))
+	if (nla_put(skb, NDA_LLADDR, dev->addr_len, addr))
 		goto nla_put_failure;
 	if (vid)
 		if (nla_put(skb, NDA_VLAN, sizeof(u16), &vid))
@@ -3897,10 +3903,10 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static inline size_t rtnl_fdb_nlmsg_size(void)
+static inline size_t rtnl_fdb_nlmsg_size(const struct net_device *dev)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg)) +
-	       nla_total_size(ETH_ALEN) +	/* NDA_LLADDR */
+	       nla_total_size(dev->addr_len) +	/* NDA_LLADDR */
 	       nla_total_size(sizeof(u16)) +	/* NDA_VLAN */
 	       0;
 }
@@ -3912,7 +3918,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(rtnl_fdb_nlmsg_size(), GFP_ATOMIC);
+	skb = nlmsg_new(rtnl_fdb_nlmsg_size(dev), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e203172b9b9e..b10285d06a2c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3685,6 +3685,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 
 	skb_push(skb, -skb_network_offset(skb) + offset);
 
+	/* Ensure the head is writeable before touching the shared info */
+	err = skb_unclone(skb, GFP_ATOMIC);
+	if (err)
+		goto err_linearize;
+
 	skb_shinfo(skb)->frag_list = NULL;
 
 	while (list_skb) {
diff --git a/net/core/sock.c b/net/core/sock.c
index 9b013d052a72..4e00c6e2cb43 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2175,13 +2175,24 @@ kuid_t sock_i_uid(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_i_uid);
 
-unsigned long sock_i_ino(struct sock *sk)
+unsigned long __sock_i_ino(struct sock *sk)
 {
 	unsigned long ino;
 
-	read_lock_bh(&sk->sk_callback_lock);
+	read_lock(&sk->sk_callback_lock);
 	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock(&sk->sk_callback_lock);
+	return ino;
+}
+EXPORT_SYMBOL(__sock_i_ino);
+
+unsigned long sock_i_ino(struct sock *sk)
+{
+	unsigned long ino;
+
+	local_bh_disable();
+	ino = __sock_i_ino(sk);
+	local_bh_enable();
 	return ino;
 }
 EXPORT_SYMBOL(sock_i_ino);
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 50496013cdb7..07876160edd2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -48,8 +48,8 @@ static void sja1105_meta_unpack(const struct sk_buff *skb,
 	 * a unified unpacking command for both device series.
 	 */
 	packing(buf,     &meta->tstamp,     31, 0, 4, UNPACK, 0);
-	packing(buf + 4, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
-	packing(buf + 5, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 4, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 5, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
 	packing(buf + 6, &meta->source_port, 7, 0, 1, UNPACK, 0);
 	packing(buf + 7, &meta->switch_id,   7, 0, 1, UNPACK, 0);
 }
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 20d738137841..28252029bd79 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1134,7 +1134,7 @@ static int esp_init_authenc(struct xfrm_state *x)
 	err = crypto_aead_setkey(aead, key, keylen);
 
 free_key:
-	kfree(key);
+	kfree_sensitive(key);
 
 error:
 	return err;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 406305aaec90..5f71a1c74e7e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -740,7 +740,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	if (inet_sk_state_load(sk_listener) != TCP_LISTEN)
 		goto drop;
 
-	max_syn_ack_retries = icsk->icsk_syn_retries ? : net->ipv4.sysctl_tcp_synack_retries;
+	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
+		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
 	 * If synack was not acknowledged for 1 second, it means
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 79bf550c9dfc..ad050f8476b8 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -571,20 +571,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_hashed(osk);
-		if (ret) {
-			/* Before deleting the node, we insert a new one to make
-			 * sure that the look-up-sk process would not miss either
-			 * of them and that at least one node would exist in ehash
-			 * table all the time. Otherwise there's a tiny chance
-			 * that lookup process could find nothing in ehash table.
-			 */
-			__sk_nulls_add_node_tail_rcu(sk, list);
-			sk_nulls_del_node_init_rcu(osk);
-		}
-		goto unlock;
-	}
-	if (found_dup_sk) {
+		ret = sk_nulls_del_node_init_rcu(osk);
+	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -593,7 +581,6 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
-unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index a00102d7c7fd..c411c87ae865 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -81,10 +81,10 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_tail_rcu(struct inet_timewait_sock *tw,
-					struct hlist_nulls_head *list)
+static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
+				   struct hlist_nulls_head *list)
 {
-	hlist_nulls_add_tail_rcu(&tw->tw_node, list);
+	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
 static void inet_twsk_add_bind_node(struct inet_timewait_sock *tw,
@@ -120,7 +120,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
-	inet_twsk_add_node_tail_rcu(tw, &ehead->chain);
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 5aa8bde3e9c8..59ba518a85b9 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -878,6 +878,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dou8vec_minmax,
 	},
 #endif
+	{
+		.procname	= "tcp_migrate_req",
+		.data		= &init_net.ipv4.sysctl_tcp_migrate_req,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	{
 		.procname	= "tcp_reordering",
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82abbf192985..3dd9b76f4055 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3072,7 +3072,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	inet_csk(sk)->icsk_syn_retries = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_syn_retries, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3081,7 +3081,7 @@ EXPORT_SYMBOL(tcp_sock_set_syncnt);
 void tcp_sock_set_user_timeout(struct sock *sk, u32 val)
 {
 	lock_sock(sk);
-	inet_csk(sk)->icsk_user_timeout = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_user_timeout, val);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(tcp_sock_set_user_timeout);
@@ -3093,7 +3093,8 @@ int tcp_sock_set_keepidle_locked(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_KEEPIDLE)
 		return -EINVAL;
 
-	tp->keepalive_time = val * HZ;
+	/* Paired with WRITE_ONCE() in keepalive_time_when() */
+	WRITE_ONCE(tp->keepalive_time, val * HZ);
 	if (sock_flag(sk, SOCK_KEEPOPEN) &&
 	    !((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
 		u32 elapsed = keepalive_time_elapsed(tp);
@@ -3125,7 +3126,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_intvl = val * HZ;
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
 	release_sock(sk);
 	return 0;
 }
@@ -3137,7 +3138,8 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_probes = val;
+	/* Paired with READ_ONCE() in keepalive_probes() */
+	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3323,19 +3325,19 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_KEEPINTVL)
 			err = -EINVAL;
 		else
-			tp->keepalive_intvl = val * HZ;
+			WRITE_ONCE(tp->keepalive_intvl, val * HZ);
 		break;
 	case TCP_KEEPCNT:
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
 			err = -EINVAL;
 		else
-			tp->keepalive_probes = val;
+			WRITE_ONCE(tp->keepalive_probes, val);
 		break;
 	case TCP_SYNCNT:
 		if (val < 1 || val > MAX_TCP_SYNCNT)
 			err = -EINVAL;
 		else
-			icsk->icsk_syn_retries = val;
+			WRITE_ONCE(icsk->icsk_syn_retries, val);
 		break;
 
 	case TCP_SAVE_SYN:
@@ -3348,18 +3350,18 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_LINGER2:
 		if (val < 0)
-			tp->linger2 = -1;
+			WRITE_ONCE(tp->linger2, -1);
 		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
-			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
 		else
-			tp->linger2 = val * HZ;
+			WRITE_ONCE(tp->linger2, val * HZ);
 		break;
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -3391,7 +3393,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			err = -EINVAL;
 		else
-			icsk->icsk_user_timeout = val;
+			WRITE_ONCE(icsk->icsk_user_timeout, val);
 		break;
 
 	case TCP_FASTOPEN:
@@ -3435,7 +3437,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	case TCP_INQ:
@@ -3447,7 +3449,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	case TCP_TX_DELAY:
 		if (val)
 			tcp_enable_tx_delay();
-		tp->tcp_tx_delay = val;
+		WRITE_ONCE(tp->tcp_tx_delay, val);
 		break;
 	default:
 		err = -ENOPROTOOPT;
@@ -3741,16 +3743,18 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = keepalive_probes(tp);
 		break;
 	case TCP_SYNCNT:
-		val = icsk->icsk_syn_retries ? : net->ipv4.sysctl_tcp_syn_retries;
+		val = READ_ONCE(icsk->icsk_syn_retries) ? :
+			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		break;
 	case TCP_LINGER2:
-		val = tp->linger2;
+		val = READ_ONCE(tp->linger2);
 		if (val >= 0)
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
@@ -3886,11 +3890,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_USER_TIMEOUT:
-		val = icsk->icsk_user_timeout;
+		val = READ_ONCE(icsk->icsk_user_timeout);
 		break;
 
 	case TCP_FASTOPEN:
-		val = icsk->icsk_accept_queue.fastopenq.max_qlen;
+		val = READ_ONCE(icsk->icsk_accept_queue.fastopenq.max_qlen);
 		break;
 
 	case TCP_FASTOPEN_CONNECT:
@@ -3902,14 +3906,14 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TX_DELAY:
-		val = tp->tcp_tx_delay;
+		val = READ_ONCE(tp->tcp_tx_delay);
 		break;
 
 	case TCP_TIMESTAMP:
 		val = tcp_time_stamp_raw() + tp->tsoffset;
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_INQ:
 		val = tp->recvmsg_inq;
@@ -3970,6 +3974,8 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 			return -EFAULT;
 		lock_sock(sk);
 		err = tcp_zerocopy_receive(sk, &zc);
+		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sk, level, optname,
+							  &zc, &len, err);
 		release_sock(sk);
 		if (len >= offsetofend(struct tcp_zerocopy_receive, err))
 			goto zerocopy_rcv_sk_err;
@@ -4004,6 +4010,18 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	return 0;
 }
 
+bool tcp_bpf_bypass_getsockopt(int level, int optname)
+{
+	/* TCP do_tcp_getsockopt has optimized getsockopt implementation
+	 * to avoid extra socket lock for TCP_ZEROCOPY_RECEIVE.
+	 */
+	if (level == SOL_TCP && optname == TCP_ZEROCOPY_RECEIVE)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL(tcp_bpf_bypass_getsockopt);
+
 int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		   int __user *optlen)
 {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 39fb037ce5f3..92d63cf3e50b 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -312,6 +312,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 	struct fastopen_queue *fastopenq;
+	int max_qlen;
 
 	/* Make sure the listener has enabled fastopen, and we don't
 	 * exceed the max # of pending TFO requests allowed before trying
@@ -324,10 +325,11 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 	 * temporarily vs a server not supporting Fast Open at all.
 	 */
 	fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
-	if (fastopenq->max_qlen == 0)
+	max_qlen = READ_ONCE(fastopenq->max_qlen);
+	if (max_qlen == 0)
 		return false;
 
-	if (fastopenq->qlen >= fastopenq->max_qlen) {
+	if (fastopenq->qlen >= max_qlen) {
 		struct request_sock *req1;
 		spin_lock(&fastopenq->lock);
 		req1 = fastopenq->rskq_rst_head;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b98b7920c402..d6dfbb88dcf5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3560,8 +3560,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 				   u32 *last_oow_ack_time)
 {
-	if (*last_oow_ack_time) {
-		s32 elapsed = (s32)(tcp_jiffies32 - *last_oow_ack_time);
+	/* Paired with the WRITE_ONCE() in this function. */
+	u32 val = READ_ONCE(*last_oow_ack_time);
+
+	if (val) {
+		s32 elapsed = (s32)(tcp_jiffies32 - val);
 
 		if (0 <= elapsed &&
 		    elapsed < READ_ONCE(net->ipv4.sysctl_tcp_invalid_ratelimit)) {
@@ -3570,7 +3573,10 @@ static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 		}
 	}
 
-	*last_oow_ack_time = tcp_jiffies32;
+	/* Paired with the prior READ_ONCE() and with itself,
+	 * as we might be lockless.
+	 */
+	WRITE_ONCE(*last_oow_ack_time, tcp_jiffies32);
 
 	return false;	/* not rate-limited: go ahead, send dupack now! */
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 270b20e0907c..b40780fde791 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -960,7 +960,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent,
+			READ_ONCE(req->ts_recent),
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
@@ -2805,6 +2805,7 @@ struct proto tcp_prot = {
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
+	.bpf_bypass_getsockopt	= tcp_bpf_bypass_getsockopt,
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 8d854feebdb0..01e27620b7ee 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -523,7 +523,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->max_window = newtp->snd_wnd;
 
 	if (newtp->rx_opt.tstamp_ok) {
-		newtp->rx_opt.ts_recent = req->ts_recent;
+		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
 		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
@@ -586,7 +586,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
-			tmp_opt.ts_recent = req->ts_recent;
+			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
 			/* We do not store true stamp, but it is not required,
@@ -726,8 +726,11 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
+	/* TODO: We probably should defer ts_recent change once
+	 * we take ownership of @req.
+	 */
 	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		req->ts_recent = tmp_opt.rcv_tsval;
+		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
 
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e4ad274ec7a3..86e896351364 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -874,7 +874,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	if (likely(ireq->tstamp_ok)) {
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
-		opts->tsecr = req->ts_recent;
+		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
 	if (likely(ireq->sack_ok)) {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 888683f2ff3e..715fdfa3e2ae 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -239,7 +239,8 @@ static int tcp_write_timeout(struct sock *sk)
 	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
 		if (icsk->icsk_retransmits)
 			__dst_negative_advice(sk);
-		retry_until = icsk->icsk_syn_retries ? : net->ipv4.sysctl_tcp_syn_retries;
+		retry_until = icsk->icsk_syn_retries ? :
+			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		expired = icsk->icsk_retransmits >= retry_until;
 	} else {
 		if (retransmits_timed_out(sk, READ_ONCE(net->ipv4.sysctl_tcp_retries1), 0)) {
@@ -406,12 +407,15 @@ abort:		tcp_write_err(sk);
 static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	int max_retries = icsk->icsk_syn_retries ? :
-	    sock_net(sk)->ipv4.sysctl_tcp_synack_retries + 1; /* add one more retry for fastopen */
 	struct tcp_sock *tp = tcp_sk(sk);
+	int max_retries;
 
 	req->rsk_ops->syn_ack_timeout(req);
 
+	/* add one more retry for fastopen */
+	max_retries = icsk->icsk_syn_retries ? :
+		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
+
 	if (req->num_timeout >= max_retries) {
 		tcp_write_err(sk);
 		return;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ed1e5bfc97b3..d5d10496b4ae 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -314,9 +314,8 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
 static void addrconf_mod_rs_timer(struct inet6_dev *idev,
 				  unsigned long when)
 {
-	if (!timer_pending(&idev->rs_timer))
+	if (!mod_timer(&idev->rs_timer, jiffies + when))
 		in6_dev_hold(idev);
-	mod_timer(&idev->rs_timer, jiffies + when);
 }
 
 static void addrconf_mod_dad_work(struct inet6_ifaddr *ifp,
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index fd1f896115c1..d01165bb6a32 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -429,7 +429,10 @@ static struct net_device *icmp6_dev(const struct sk_buff *skb)
 	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
 		const struct rt6_info *rt6 = skb_rt6_info(skb);
 
-		if (rt6)
+		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
+		 * and ip6_null_entry could be set to skb if no route is found.
+		 */
+		if (rt6 && rt6->rt6i_idev)
 			dev = rt6->rt6i_idev->dev;
 	}
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 7b50e1811678..2df1036330f8 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -955,7 +955,8 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 		goto tx_err;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		pskb_trim(skb, dev->mtu + dev->hard_header_len);
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+			goto tx_err;
 		truncate = true;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index fe29bc66aeac..79d6f6ea3c54 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1151,7 +1151,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent, sk->sk_bound_dev_if,
+			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority);
 }
@@ -2135,6 +2135,7 @@ struct proto tcpv6_prot = {
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
+	.bpf_bypass_getsockopt	= tcp_bpf_bypass_getsockopt,
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 19c0721399d9..788bb19f32e9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -87,7 +87,7 @@ static u32 udp6_ehashfn(const struct net *net,
 	fhash = __ipv6_addr_jhash(faddr, udp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       udp_ipv6_hash_secret + net_hash_mix(net));
+			       udp6_ehash_secret + net_hash_mix(net));
 }
 
 int udp_v6_get_port(struct sock *sk, unsigned short snum)
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index c309b72a5877..7cac441862e2 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -163,9 +163,6 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	void (*sta_handler)(struct sk_buff *skb);
 	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		goto drop;
-
 	/*
 	 * When the interface is in promisc. mode, drop all the crap that it
 	 * receives, do not try to analyse it.
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 118f415928ae..32cc91f5ba99 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -404,6 +404,9 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
 
+	if (!nf_ct_helper_hash)
+		return -ENOENT;
+
 	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
 		return -EINVAL;
 
@@ -587,4 +590,5 @@ void nf_conntrack_helper_fini(void)
 {
 	nf_ct_extend_unregister(&helper_extend);
 	kvfree(nf_ct_helper_hash);
+	nf_ct_helper_hash = NULL;
 }
diff --git a/net/netfilter/nf_conntrack_proto_dccp.c b/net/netfilter/nf_conntrack_proto_dccp.c
index 94001eb51ffe..a9ae292e932a 100644
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -431,9 +431,19 @@ static bool dccp_error(const struct dccp_hdr *dh,
 		       struct sk_buff *skb, unsigned int dataoff,
 		       const struct nf_hook_state *state)
 {
+	static const unsigned long require_seq48 = 1 << DCCP_PKT_REQUEST |
+						   1 << DCCP_PKT_RESPONSE |
+						   1 << DCCP_PKT_CLOSEREQ |
+						   1 << DCCP_PKT_CLOSE |
+						   1 << DCCP_PKT_RESET |
+						   1 << DCCP_PKT_SYNC |
+						   1 << DCCP_PKT_SYNCACK;
 	unsigned int dccp_len = skb->len - dataoff;
 	unsigned int cscov;
 	const char *msg;
+	u8 type;
+
+	BUILD_BUG_ON(DCCP_PKT_INVALID >= BITS_PER_LONG);
 
 	if (dh->dccph_doff * 4 < sizeof(struct dccp_hdr) ||
 	    dh->dccph_doff * 4 > dccp_len) {
@@ -458,10 +468,17 @@ static bool dccp_error(const struct dccp_hdr *dh,
 		goto out_invalid;
 	}
 
-	if (dh->dccph_type >= DCCP_PKT_INVALID) {
+	type = dh->dccph_type;
+	if (type >= DCCP_PKT_INVALID) {
 		msg = "nf_ct_dccp: reserved packet type ";
 		goto out_invalid;
 	}
+
+	if (test_bit(type, &require_seq48) && !dh->dccph_x) {
+		msg = "nf_ct_dccp: type lacks 48bit sequence numbers";
+		goto out_invalid;
+	}
+
 	return false;
 out_invalid:
 	nf_l4proto_log_invalid(skb, state->net, state->pf,
@@ -469,24 +486,53 @@ static bool dccp_error(const struct dccp_hdr *dh,
 	return true;
 }
 
+struct nf_conntrack_dccp_buf {
+	struct dccp_hdr dh;	 /* generic header part */
+	struct dccp_hdr_ext ext; /* optional depending dh->dccph_x */
+	union {			 /* depends on header type */
+		struct dccp_hdr_ack_bits ack;
+		struct dccp_hdr_request req;
+		struct dccp_hdr_response response;
+		struct dccp_hdr_reset rst;
+	} u;
+};
+
+static struct dccp_hdr *
+dccp_header_pointer(const struct sk_buff *skb, int offset, const struct dccp_hdr *dh,
+		    struct nf_conntrack_dccp_buf *buf)
+{
+	unsigned int hdrlen = __dccp_hdr_len(dh);
+
+	if (hdrlen > sizeof(*buf))
+		return NULL;
+
+	return skb_header_pointer(skb, offset, hdrlen, buf);
+}
+
 int nf_conntrack_dccp_packet(struct nf_conn *ct, struct sk_buff *skb,
 			     unsigned int dataoff,
 			     enum ip_conntrack_info ctinfo,
 			     const struct nf_hook_state *state)
 {
 	enum ip_conntrack_dir dir = CTINFO2DIR(ctinfo);
-	struct dccp_hdr _dh, *dh;
+	struct nf_conntrack_dccp_buf _dh;
 	u_int8_t type, old_state, new_state;
 	enum ct_dccp_roles role;
 	unsigned int *timeouts;
+	struct dccp_hdr *dh;
 
-	dh = skb_header_pointer(skb, dataoff, sizeof(_dh), &_dh);
+	dh = skb_header_pointer(skb, dataoff, sizeof(*dh), &_dh.dh);
 	if (!dh)
 		return NF_DROP;
 
 	if (dccp_error(dh, skb, dataoff, state))
 		return -NF_ACCEPT;
 
+	/* pull again, including possible 48 bit sequences and subtype header */
+	dh = dccp_header_pointer(skb, dataoff, dh, &_dh);
+	if (!dh)
+		return NF_DROP;
+
 	type = dh->dccph_type;
 	if (!nf_ct_is_confirmed(ct) && !dccp_new(ct, skb, dh))
 		return -NF_ACCEPT;
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 78fd9122b70c..751df19fe0f8 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -611,7 +611,7 @@ int ct_sip_parse_numerical_param(const struct nf_conn *ct, const char *dptr,
 	start += strlen(name);
 	*val = simple_strtoul(start, &end, 0);
 	if (start == end)
-		return 0;
+		return -1;
 	if (matchoff && matchlen) {
 		*matchoff = start - dptr;
 		*matchlen = end - start;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e59cad1f7a36..356416564d9f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -21,10 +21,13 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/sock.h>
 
 #define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
 
+unsigned int nf_tables_net_id __read_mostly;
+
 static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
@@ -103,7 +106,9 @@ static const u8 nft2audit_op[NFT_MSG_MAX] = { // enum nf_tables_msg_types
 
 static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 {
-	switch (net->nft.validate_state) {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	switch (nft_net->validate_state) {
 	case NFT_VALIDATE_SKIP:
 		WARN_ON_ONCE(new_validate_state == NFT_VALIDATE_DO);
 		break;
@@ -114,7 +119,7 @@ static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 			return;
 	}
 
-	net->nft.validate_state = new_validate_state;
+	nft_net->validate_state = new_validate_state;
 }
 static void nf_tables_trans_destroy_work(struct work_struct *w);
 static DECLARE_WORK(trans_destroy_work, nf_tables_trans_destroy_work);
@@ -150,6 +155,7 @@ static struct nft_trans *nft_trans_alloc_gfp(const struct nft_ctx *ctx,
 		return NULL;
 
 	INIT_LIST_HEAD(&trans->list);
+	INIT_LIST_HEAD(&trans->binding_list);
 	trans->msg_type = msg_type;
 	trans->ctx	= *ctx;
 
@@ -162,34 +168,107 @@ static struct nft_trans *nft_trans_alloc(const struct nft_ctx *ctx,
 	return nft_trans_alloc_gfp(ctx, msg_type, size, GFP_KERNEL);
 }
 
-static void nft_trans_destroy(struct nft_trans *trans)
+static void nft_trans_list_del(struct nft_trans *trans)
 {
 	list_del(&trans->list);
+	list_del(&trans->binding_list);
+}
+
+static void nft_trans_destroy(struct nft_trans *trans)
+{
+	nft_trans_list_del(trans);
 	kfree(trans);
 }
 
-static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+static void __nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set,
+				 bool bind)
 {
+	struct nftables_pernet *nft_net;
 	struct net *net = ctx->net;
 	struct nft_trans *trans;
 
 	if (!nft_set_is_anonymous(set))
 		return;
 
-	list_for_each_entry_reverse(trans, &net->nft.commit_list, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_reverse(trans, &nft_net->commit_list, list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWSET:
 			if (nft_trans_set(trans) == set)
-				nft_trans_set_bound(trans) = true;
+				nft_trans_set_bound(trans) = bind;
 			break;
 		case NFT_MSG_NEWSETELEM:
 			if (nft_trans_elem_set(trans) == set)
-				nft_trans_elem_set_bound(trans) = true;
+				nft_trans_elem_set_bound(trans) = bind;
 			break;
 		}
 	}
 }
 
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, true);
+}
+
+static void nft_set_trans_unbind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, false);
+}
+
+static void __nft_chain_trans_bind(const struct nft_ctx *ctx,
+				   struct nft_chain *chain, bool bind)
+{
+	struct nftables_pernet *nft_net;
+	struct net *net = ctx->net;
+	struct nft_trans *trans;
+
+	if (!nft_chain_binding(chain))
+		return;
+
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_reverse(trans, &nft_net->commit_list, list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWCHAIN:
+			if (nft_trans_chain(trans) == chain)
+				nft_trans_chain_bound(trans) = bind;
+			break;
+		case NFT_MSG_NEWRULE:
+			if (trans->ctx.chain == chain)
+				nft_trans_rule_bound(trans) = bind;
+			break;
+		}
+	}
+}
+
+static void nft_chain_trans_bind(const struct nft_ctx *ctx,
+				 struct nft_chain *chain)
+{
+	__nft_chain_trans_bind(ctx, chain, true);
+}
+
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	if (!nft_chain_binding(chain))
+		return 0;
+
+	if (nft_chain_binding(ctx->chain))
+		return -EOPNOTSUPP;
+
+	if (chain->bound)
+		return -EBUSY;
+
+	chain->bound = true;
+	chain->use++;
+	nft_chain_trans_bind(ctx, chain);
+
+	return 0;
+}
+
+void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	__nft_chain_trans_bind(ctx, chain, false);
+}
+
 static int nft_netdev_register_hooks(struct net *net,
 				     struct list_head *hook_list)
 {
@@ -270,6 +349,27 @@ static void nf_tables_unregister_hook(struct net *net,
 		nf_unregister_net_hook(net, &basechain->ops);
 }
 
+static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *trans)
+{
+	struct nftables_pernet *nft_net;
+
+	nft_net = net_generic(net, nf_tables_net_id);
+
+	switch (trans->msg_type) {
+	case NFT_MSG_NEWSET:
+		if (nft_set_is_anonymous(nft_trans_set(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
+	case NFT_MSG_NEWCHAIN:
+		if (!nft_trans_chain_update(trans) &&
+		    nft_chain_binding(nft_trans_chain(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
+	}
+
+	list_add_tail(&trans->list, &nft_net->commit_list);
+}
+
 static int nft_trans_table_add(struct nft_ctx *ctx, int msg_type)
 {
 	struct nft_trans *trans;
@@ -281,7 +381,7 @@ static int nft_trans_table_add(struct nft_ctx *ctx, int msg_type)
 	if (msg_type == NFT_MSG_NEWTABLE)
 		nft_activate_next(ctx->net, ctx->table);
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 }
 
@@ -313,8 +413,9 @@ static struct nft_trans *nft_trans_chain_add(struct nft_ctx *ctx, int msg_type)
 				ntohl(nla_get_be32(ctx->nla[NFTA_CHAIN_ID]));
 		}
 	}
+	nft_trans_chain(trans) = ctx->chain;
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
 	return trans;
 }
 
@@ -332,8 +433,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	return 0;
 }
 
-static void nft_rule_expr_activate(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr;
 
@@ -346,9 +446,8 @@ static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 	}
 }
 
-static void nft_rule_expr_deactivate(const struct nft_ctx *ctx,
-				     struct nft_rule *rule,
-				     enum nft_trans_phase phase)
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase)
 {
 	struct nft_expr *expr;
 
@@ -387,7 +486,7 @@ static struct nft_trans *nft_trans_rule_add(struct nft_ctx *ctx, int msg_type,
 			ntohl(nla_get_be32(ctx->nla[NFTA_RULE_ID]));
 	}
 	nft_trans_rule(trans) = rule;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return trans;
 }
@@ -453,11 +552,36 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 		nft_activate_next(ctx->net, set);
 	}
 	nft_trans_set(trans) = set;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
 
+static void nft_setelem_data_deactivate(const struct net *net,
+					const struct nft_set *set,
+					struct nft_set_elem *elem);
+
+static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
+				  struct nft_set *set,
+				  const struct nft_set_iter *iter,
+				  struct nft_set_elem *elem)
+{
+	nft_setelem_data_deactivate(ctx->net, set, elem);
+
+	return 0;
+}
+
+static void nft_map_deactivate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_deactivate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+}
+
 static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	int err;
@@ -466,6 +590,9 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 	if (err < 0)
 		return err;
 
+	if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+		nft_map_deactivate(ctx, set);
+
 	nft_deactivate_next(ctx->net, set);
 	ctx->table->use--;
 
@@ -485,7 +612,7 @@ static int nft_trans_obj_add(struct nft_ctx *ctx, int msg_type,
 		nft_activate_next(ctx->net, obj);
 
 	nft_trans_obj(trans) = obj;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -519,7 +646,7 @@ static int nft_trans_flowtable_add(struct nft_ctx *ctx, int msg_type,
 
 	INIT_LIST_HEAD(&nft_trans_flowtable_hooks(trans));
 	nft_trans_flowtable(trans) = flowtable;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -547,13 +674,15 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 					  const struct nlattr *nla,
 					  u8 family, u8 genmask)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list,
-				lockdep_is_held(&net->nft.commit_mutex)) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_rcu(table, &nft_net->tables, list,
+				lockdep_is_held(&nft_net->commit_mutex)) {
 		if (!nla_strcmp(nla, table->name) &&
 		    table->family == family &&
 		    nft_active_genmask(table, genmask))
@@ -567,9 +696,11 @@ static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 						   const struct nlattr *nla,
 						   u8 genmask)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
 		    nft_active_genmask(table, genmask))
 			return table;
@@ -621,6 +752,7 @@ struct nft_module_request {
 static int nft_request_module(struct net *net, const char *fmt, ...)
 {
 	char module_name[MODULE_NAME_LEN];
+	struct nftables_pernet *nft_net;
 	struct nft_module_request *req;
 	va_list args;
 	int ret;
@@ -631,7 +763,8 @@ static int nft_request_module(struct net *net, const char *fmt, ...)
 	if (ret >= MODULE_NAME_LEN)
 		return 0;
 
-	list_for_each_entry(req, &net->nft.module_list, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry(req, &nft_net->module_list, list) {
 		if (!strcmp(req->module, module_name)) {
 			if (req->done)
 				return 0;
@@ -647,7 +780,7 @@ static int nft_request_module(struct net *net, const char *fmt, ...)
 
 	req->done = false;
 	strlcpy(req->module, module_name, MODULE_NAME_LEN);
-	list_add_tail(&req->list, &net->nft.module_list);
+	list_add_tail(&req->list, &nft_net->module_list);
 
 	return -EAGAIN;
 }
@@ -685,7 +818,9 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 
 static __be16 nft_base_seq(const struct net *net)
 {
-	return htons(net->nft.base_seq & 0xffff);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return htons(nft_net->base_seq & 0xffff);
 }
 
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
@@ -743,6 +878,7 @@ static void nft_notify_enqueue(struct sk_buff *skb, bool report,
 
 static void nf_tables_table_notify(const struct nft_ctx *ctx, int event)
 {
+	struct nftables_pernet *nft_net;
 	struct sk_buff *skb;
 	int err;
 
@@ -761,7 +897,8 @@ static void nf_tables_table_notify(const struct nft_ctx *ctx, int event)
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, ctx->report, &ctx->net->nft.notify_list);
+	nft_net = net_generic(ctx->net, nf_tables_net_id);
+	nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 	return;
 err:
 	nfnetlink_set_err(ctx->net, ctx->portid, NFNLGRP_NFTABLES, -ENOBUFS);
@@ -771,15 +908,17 @@ static int nf_tables_dump_tables(struct sk_buff *skb,
 				 struct netlink_callback *cb)
 {
 	const struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
+	struct nftables_pernet *nft_net;
 	const struct nft_table *table;
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -954,7 +1093,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 		goto err;
 
 	nft_trans_table_update(trans) = true;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 err:
 	nft_trans_destroy(trans);
@@ -1017,6 +1156,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 			      const struct nlattr * const nla[],
 			      struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	int family = nfmsg->nfgen_family;
@@ -1026,7 +1166,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	u32 flags = 0;
 	int err;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
 	if (IS_ERR(table)) {
@@ -1084,7 +1224,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	if (err < 0)
 		goto err_trans;
 
-	list_add_tail_rcu(&table->list, &net->nft.tables);
+	list_add_tail_rcu(&table->list, &nft_net->tables);
 	return 0;
 err_trans:
 	rhltable_destroy(&table->chains_ht);
@@ -1172,11 +1312,12 @@ static int nft_flush_table(struct nft_ctx *ctx)
 
 static int nft_flush(struct nft_ctx *ctx, int family)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct nft_table *table, *nt;
 	const struct nlattr * const *nla = ctx->nla;
 	int err = 0;
 
-	list_for_each_entry_safe(table, nt, &ctx->net->nft.tables, list) {
+	list_for_each_entry_safe(table, nt, &nft_net->tables, list) {
 		if (family != AF_UNSPEC && table->family != family)
 			continue;
 
@@ -1291,7 +1432,9 @@ nft_chain_lookup_byhandle(const struct nft_table *table, u64 handle, u8 genmask)
 static bool lockdep_commit_lock_is_held(const struct net *net)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	return lockdep_is_held(&net->nft.commit_mutex);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return lockdep_is_held(&nft_net->commit_mutex);
 #else
 	return true;
 #endif
@@ -1494,6 +1637,7 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 
 static void nf_tables_chain_notify(const struct nft_ctx *ctx, int event)
 {
+	struct nftables_pernet *nft_net;
 	struct sk_buff *skb;
 	int err;
 
@@ -1513,7 +1657,8 @@ static void nf_tables_chain_notify(const struct nft_ctx *ctx, int event)
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, ctx->report, &ctx->net->nft.notify_list);
+	nft_net = net_generic(ctx->net, nf_tables_net_id);
+	nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 	return;
 err:
 	nfnetlink_set_err(ctx->net, ctx->portid, NFNLGRP_NFTABLES, -ENOBUFS);
@@ -1528,11 +1673,13 @@ static int nf_tables_dump_chains(struct sk_buff *skb,
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -1847,11 +1994,12 @@ static int nft_chain_parse_hook(struct net *net,
 				struct nft_chain_hook *hook, u8 family,
 				bool autoload)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nlattr *ha[NFTA_HOOK_MAX + 1];
 	const struct nft_chain_type *type;
 	int err;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	lockdep_nfnl_nft_mutex_not_held();
 
 	err = nla_parse_nested_deprecated(ha, NFTA_HOOK_MAX,
@@ -1981,7 +2129,7 @@ static int nft_basechain_init(struct nft_base_chain *basechain, u8 family,
 	return 0;
 }
 
-static int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
 {
 	int err;
 
@@ -2244,6 +2392,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 	if (nla[NFTA_CHAIN_HANDLE] &&
 	    nla[NFTA_CHAIN_NAME]) {
+		struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 		struct nft_trans *tmp;
 		char *name;
 
@@ -2253,7 +2402,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 			goto err;
 
 		err = -EEXIST;
-		list_for_each_entry(tmp, &ctx->net->nft.commit_list, list) {
+		list_for_each_entry(tmp, &nft_net->commit_list, list) {
 			if (tmp->msg_type == NFT_MSG_NEWCHAIN &&
 			    tmp->ctx.table == table &&
 			    nft_trans_chain_update(tmp) &&
@@ -2267,7 +2416,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 		nft_trans_chain_name(trans) = name;
 	}
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 err:
@@ -2278,17 +2427,19 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 					       const struct nft_table *table,
-					       const struct nlattr *nla)
+					       const struct nlattr *nla, u8 genmask)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	u32 id = ntohl(nla_get_be32(nla));
 	struct nft_trans *trans;
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		struct nft_chain *chain = trans->ctx.chain;
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
 		    chain->table == table &&
-		    id == nft_trans_chain_id(trans))
+		    id == nft_trans_chain_id(trans) &&
+		    nft_active_genmask(chain, genmask))
 			return chain;
 	}
 	return ERR_PTR(-ENOENT);
@@ -2299,6 +2450,7 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 			      const struct nlattr * const nla[],
 			      struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	int family = nfmsg->nfgen_family;
@@ -2310,7 +2462,7 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 	u64 handle = 0;
 	u32 flags = 0;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	table = nft_table_lookup(net, nla[NFTA_CHAIN_TABLE], family, genmask);
 	if (IS_ERR(table)) {
@@ -2848,6 +3000,7 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 static void nf_tables_rule_notify(const struct nft_ctx *ctx,
 				  const struct nft_rule *rule, int event)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct sk_buff *skb;
 	int err;
 
@@ -2867,7 +3020,7 @@ static void nf_tables_rule_notify(const struct nft_ctx *ctx,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, ctx->report, &ctx->net->nft.notify_list);
+	nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 	return;
 err:
 	nfnetlink_set_err(ctx->net, ctx->portid, NFNLGRP_NFTABLES, -ENOBUFS);
@@ -2925,11 +3078,13 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 	unsigned int idx = 0;
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -3076,8 +3231,7 @@ static int nf_tables_getrule(struct net *net, struct sock *nlsk,
 	return err;
 }
 
-static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr, *next;
 
@@ -3094,7 +3248,7 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 	kfree(rule);
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
+static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
@@ -3145,6 +3299,8 @@ static int nft_table_validate(struct net *net, const struct nft_table *table)
 		err = nft_chain_validate(&ctx, chain);
 		if (err < 0)
 			return err;
+
+		cond_resched();
 	}
 
 	return 0;
@@ -3161,6 +3317,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 			     const struct nlattr * const nla[],
 			     struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	struct nft_expr_info *info = NULL;
@@ -3178,7 +3335,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	int err, rem;
 	u64 handle, pos_handle;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	table = nft_table_lookup(net, nla[NFTA_RULE_TABLE], family, genmask);
 	if (IS_ERR(table)) {
@@ -3197,7 +3354,8 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
+					      genmask);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -3351,7 +3509,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	kvfree(info);
 	chain->use++;
 
-	if (net->nft.validate_state == NFT_VALIDATE_DO)
+	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, table);
 
 	if (chain->flags & NFT_CHAIN_HW_OFFLOAD) {
@@ -3364,7 +3522,8 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 
 	return 0;
 err2:
-	nf_tables_rule_release(&ctx, rule);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
+	nf_tables_rule_destroy(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
 		if (info[i].ops) {
@@ -3381,10 +3540,11 @@ static struct nft_rule *nft_rule_lookup_byid(const struct net *net,
 					     const struct nft_chain *chain,
 					     const struct nlattr *nla)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	u32 id = ntohl(nla_get_be32(nla));
 	struct nft_trans *trans;
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		struct nft_rule *rule = nft_trans_rule(trans);
 
 		if (trans->msg_type == NFT_MSG_NEWRULE &&
@@ -3451,6 +3611,8 @@ static int nf_tables_delrule(struct net *net, struct sock *nlsk,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
+			if (nft_chain_is_bound(chain))
+				continue;
 
 			ctx.chain = chain;
 			err = nft_delrule_by_chain(&ctx);
@@ -3497,13 +3659,14 @@ nft_select_set_ops(const struct nft_ctx *ctx,
 		   const struct nft_set_desc *desc,
 		   enum nft_set_policies policy)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	const struct nft_set_ops *ops, *bops;
 	struct nft_set_estimate est, best;
 	const struct nft_set_type *type;
 	u32 flags = 0;
 	int i;
 
-	lockdep_assert_held(&ctx->net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	lockdep_nfnl_nft_mutex_not_held();
 
 	if (nla[NFTA_SET_FLAGS] != NULL)
@@ -3641,10 +3804,11 @@ static struct nft_set *nft_set_lookup_byid(const struct net *net,
 					   const struct nft_table *table,
 					   const struct nlattr *nla, u8 genmask)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans;
 	u32 id = ntohl(nla_get_be32(nla));
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		if (trans->msg_type == NFT_MSG_NEWSET) {
 			struct nft_set *set = nft_trans_set(trans);
 
@@ -3867,6 +4031,7 @@ static void nf_tables_set_notify(const struct nft_ctx *ctx,
 				 const struct nft_set *set, int event,
 			         gfp_t gfp_flags)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct sk_buff *skb;
 	u32 portid = ctx->portid;
 	int err;
@@ -3885,7 +4050,7 @@ static void nf_tables_set_notify(const struct nft_ctx *ctx,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, ctx->report, &ctx->net->nft.notify_list);
+	nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 	return;
 err:
 	nfnetlink_set_err(ctx->net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
@@ -3898,14 +4063,16 @@ static int nf_tables_dump_sets(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nft_table *table, *cur_table = (struct nft_table *)cb->args[2];
 	struct net *net = sock_net(skb->sk);
 	struct nft_ctx *ctx = cb->data, ctx_set;
+	struct nftables_pernet *nft_net;
 
 	if (cb->args[1])
 		return skb->len;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (ctx->family != NFPROTO_UNSPEC &&
 		    ctx->family != table->family)
 			continue;
@@ -4339,7 +4506,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (set->expr)
 		nft_expr_destroy(&ctx, set->expr);
 
-	ops->destroy(set);
+	ops->destroy(&ctx, set);
 err_set_init:
 	kfree(set->name);
 err_set_name:
@@ -4355,7 +4522,7 @@ static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 	if (set->expr)
 		nft_expr_destroy(ctx, set->expr);
 
-	set->ops->destroy(set);
+	set->ops->destroy(ctx, set);
 	kfree(set->name);
 	kvfree(set);
 }
@@ -4479,10 +4646,39 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	}
 }
 
+static void nft_setelem_data_activate(const struct net *net,
+				      const struct nft_set *set,
+				      struct nft_set_elem *elem);
+
+static int nft_mapelem_activate(const struct nft_ctx *ctx,
+				struct nft_set *set,
+				const struct nft_set_iter *iter,
+				struct nft_set_elem *elem)
+{
+	nft_setelem_data_activate(ctx->net, set, elem);
+
+	return 0;
+}
+
+static void nft_map_activate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_activate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+}
+
 void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	if (nft_set_is_anonymous(set))
+	if (nft_set_is_anonymous(set)) {
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_activate(ctx, set);
+
 		nft_clear(ctx->net, set);
+	}
 
 	set->use++;
 }
@@ -4493,14 +4689,30 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
-	case NFT_TRANS_PREPARE:
+	case NFT_TRANS_PREPARE_ERROR:
+		nft_set_trans_unbind(ctx, set);
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
+
+		set->use--;
+		break;
+	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set)) {
+			if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_deactivate(ctx, set);
 
+			nft_deactivate_next(ctx->net, set);
+		}
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
+		if (nft_set_is_anonymous(set) &&
+		    set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(ctx, set);
+
 		set->use--;
 		fallthrough;
 	default:
@@ -4706,6 +4918,7 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nft_set_dump_ctx *dump_ctx = cb->data;
 	struct net *net = sock_net(skb->sk);
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct nft_set *set;
 	struct nft_set_dump_args args;
@@ -4716,7 +4929,8 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	int event;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (dump_ctx->ctx.family != NFPROTO_UNSPEC &&
 		    dump_ctx->ctx.family != table->family)
 			continue;
@@ -4995,6 +5209,7 @@ static void nf_tables_setelem_notify(const struct nft_ctx *ctx,
 				     const struct nft_set_elem *elem,
 				     int event, u16 flags)
 {
+	struct nftables_pernet *nft_net;
 	struct net *net = ctx->net;
 	u32 portid = ctx->portid;
 	struct sk_buff *skb;
@@ -5014,7 +5229,8 @@ static void nf_tables_setelem_notify(const struct nft_ctx *ctx,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, ctx->report, &ctx->net->nft.notify_list);
+	nft_net = net_generic(net, nf_tables_net_id);
+	nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 	return;
 err:
 	nfnetlink_set_err(net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
@@ -5103,6 +5319,7 @@ static void nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
 	}
 }
 
+/* Drop references and destroy. Called from gc, dynset and abort path. */
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr)
 {
@@ -5124,11 +5341,11 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
 
-/* Only called from commit path, nft_set_elem_deactivate() already deals with
- * the refcounting from the preparation phase.
+/* Destroy element. References have been already dropped in the preparation
+ * path via nft_setelem_data_deactivate().
  */
-static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
-				       const struct nft_set *set, void *elem)
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem)
 {
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem);
 
@@ -5410,7 +5627,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	nft_trans_elem(trans) = elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 
 err_set_full:
@@ -5441,6 +5658,7 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 				const struct nlattr * const nla[],
 				struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	u8 genmask = nft_genmask_next(net);
 	const struct nlattr *attr;
 	struct nft_set *set;
@@ -5470,7 +5688,7 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 			return err;
 	}
 
-	if (net->nft.validate_state == NFT_VALIDATE_DO)
+	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, ctx.table);
 
 	return 0;
@@ -5490,7 +5708,6 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
@@ -5498,23 +5715,14 @@ void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 		case NFT_GOTO:
 			chain = data->verdict.chain;
 			chain->use++;
-
-			if (!nft_chain_is_bound(chain))
-				break;
-
-			chain->table->use++;
-			list_for_each_entry(rule, &chain->rules, list)
-				chain->use++;
-
-			nft_chain_add(chain->table, chain);
 			break;
 		}
 	}
 }
 
-static void nft_set_elem_activate(const struct net *net,
-				  const struct nft_set *set,
-				  struct nft_set_elem *elem)
+static void nft_setelem_data_activate(const struct net *net,
+				      const struct nft_set *set,
+				      struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
@@ -5524,9 +5732,9 @@ static void nft_set_elem_activate(const struct net *net,
 		(*nft_set_ext_obj(ext))->use++;
 }
 
-static void nft_set_elem_deactivate(const struct net *net,
-				    const struct nft_set *set,
-				    struct nft_set_elem *elem)
+static void nft_setelem_data_deactivate(const struct net *net,
+					const struct nft_set *set,
+					struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
@@ -5603,10 +5811,10 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	kfree(elem.priv);
 	elem.priv = priv;
 
-	nft_set_elem_deactivate(ctx->net, set, &elem);
+	nft_setelem_data_deactivate(ctx->net, set, &elem);
 
 	nft_trans_elem(trans) = elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 
 fail_ops:
@@ -5637,10 +5845,10 @@ static int nft_flush_set(const struct nft_ctx *ctx,
 	}
 	set->ndeact++;
 
-	nft_set_elem_deactivate(ctx->net, set, elem);
+	nft_setelem_data_deactivate(ctx->net, set, elem);
 	nft_trans_elem_set(trans) = set;
 	nft_trans_elem(trans) = *elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 err1:
@@ -5939,7 +6147,7 @@ static int nf_tables_updobj(const struct nft_ctx *ctx,
 	nft_trans_obj(trans) = obj;
 	nft_trans_obj_update(trans) = true;
 	nft_trans_obj_newobj(trans) = newobj;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 
@@ -6102,6 +6310,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nft_obj_filter *filter = cb->data;
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 	struct nft_object *obj;
 	bool reset = false;
 
@@ -6109,9 +6318,10 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 		reset = true;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -6134,7 +6344,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 				char *buf = kasprintf(GFP_ATOMIC,
 						      "%s:%u",
 						      table->name,
-						      net->nft.base_seq);
+						      nft_net->base_seq);
 
 				audit_log_nfcfg(buf,
 						family,
@@ -6255,8 +6465,11 @@ static int nf_tables_getobj(struct net *net, struct sock *nlsk,
 		reset = true;
 
 	if (reset) {
-		char *buf = kasprintf(GFP_ATOMIC, "%s:%u",
-				      table->name, net->nft.base_seq);
+		const struct nftables_pernet *nft_net;
+		char *buf;
+
+		nft_net = net_generic(net, nf_tables_net_id);
+		buf = kasprintf(GFP_ATOMIC, "%s:%u", table->name, nft_net->base_seq);
 
 		audit_log_nfcfg(buf,
 				family,
@@ -6341,10 +6554,11 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq, int event,
 		    int family, int report, gfp_t gfp)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct sk_buff *skb;
 	int err;
 	char *buf = kasprintf(gfp, "%s:%u",
-			      table->name, net->nft.base_seq);
+			      table->name, nft_net->base_seq);
 
 	audit_log_nfcfg(buf,
 			family,
@@ -6370,7 +6584,7 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, report, &net->nft.notify_list);
+	nft_notify_enqueue(skb, report, &nft_net->notify_list);
 	return;
 err:
 	nfnetlink_set_err(net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
@@ -6432,6 +6646,7 @@ void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
 				    enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
 	case NFT_TRANS_PREPARE:
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
@@ -6706,7 +6921,7 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 	INIT_LIST_HEAD(&nft_trans_flowtable_hooks(trans));
 	list_splice(&flowtable_hook.list, &nft_trans_flowtable_hooks(trans));
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 
@@ -6896,7 +7111,7 @@ static int nft_delflowtable_hook(struct nft_ctx *ctx,
 	list_splice(&flowtable_del_list, &nft_trans_flowtable_hooks(trans));
 	nft_flowtable_hook_release(&flowtable_hook);
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 
@@ -7022,12 +7237,14 @@ static int nf_tables_dump_flowtable(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 	struct nft_flowtable *flowtable;
+	struct nftables_pernet *nft_net;
 	const struct nft_table *table;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -7162,6 +7379,7 @@ static void nf_tables_flowtable_notify(struct nft_ctx *ctx,
 				       struct list_head *hook_list,
 				       int event)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct sk_buff *skb;
 	int err;
 
@@ -7181,7 +7399,7 @@ static void nf_tables_flowtable_notify(struct nft_ctx *ctx,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, ctx->report, &ctx->net->nft.notify_list);
+	nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 	return;
 err:
 	nfnetlink_set_err(ctx->net, ctx->portid, NFNLGRP_NFTABLES, -ENOBUFS);
@@ -7206,6 +7424,7 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nlmsghdr *nlh;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
@@ -7215,7 +7434,7 @@ static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(net->nft.base_seq)) ||
+	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
 		goto nla_put_failure;
@@ -7250,6 +7469,7 @@ static int nf_tables_flowtable_event(struct notifier_block *this,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct nft_flowtable *flowtable;
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct net *net;
 
@@ -7257,13 +7477,14 @@ static int nf_tables_flowtable_event(struct notifier_block *this,
 		return 0;
 
 	net = dev_net(dev);
-	mutex_lock(&net->nft.commit_mutex);
-	list_for_each_entry(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(flowtable, &table->flowtables, list) {
 			nft_flowtable_event(event, dev, flowtable);
 		}
 	}
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -7444,16 +7665,17 @@ static const struct nfnl_callback nf_tables_cb[NFT_MSG_MAX] = {
 
 static int nf_tables_validate(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_table *table;
 
-	switch (net->nft.validate_state) {
+	switch (nft_net->validate_state) {
 	case NFT_VALIDATE_SKIP:
 		break;
 	case NFT_VALIDATE_NEED:
 		nft_validate_state_update(net, NFT_VALIDATE_DO);
 		fallthrough;
 	case NFT_VALIDATE_DO:
-		list_for_each_entry(table, &net->nft.tables, list) {
+		list_for_each_entry(table, &nft_net->tables, list) {
 			if (nft_table_validate(net, table) < 0)
 				return -EAGAIN;
 		}
@@ -7586,7 +7808,7 @@ static void nf_tables_trans_destroy_work(struct work_struct *w)
 	synchronize_rcu();
 
 	list_for_each_entry_safe(trans, next, &head, list) {
-		list_del(&trans->list);
+		nft_trans_list_del(trans);
 		nft_commit_release(trans);
 	}
 }
@@ -7630,9 +7852,10 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 
 static void nf_tables_commit_chain_prepare_cancel(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		struct nft_chain *chain = trans->ctx.chain;
 
 		if (trans->msg_type == NFT_MSG_NEWRULE ||
@@ -7730,10 +7953,11 @@ void nft_chain_del(struct nft_chain *chain)
 
 static void nf_tables_module_autoload_cleanup(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_module_request *req, *next;
 
-	WARN_ON_ONCE(!list_empty(&net->nft.commit_list));
-	list_for_each_entry_safe(req, next, &net->nft.module_list, list) {
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+	list_for_each_entry_safe(req, next, &nft_net->module_list, list) {
 		WARN_ON_ONCE(!req->done);
 		list_del(&req->list);
 		kfree(req);
@@ -7742,6 +7966,7 @@ static void nf_tables_module_autoload_cleanup(struct net *net)
 
 static void nf_tables_commit_release(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans;
 
 	/* all side effects have to be made visible.
@@ -7751,35 +7976,36 @@ static void nf_tables_commit_release(struct net *net)
 	 * Memory reclaim happens asynchronously from work queue
 	 * to prevent expensive synchronize_rcu() in commit phase.
 	 */
-	if (list_empty(&net->nft.commit_list)) {
+	if (list_empty(&nft_net->commit_list)) {
 		nf_tables_module_autoload_cleanup(net);
-		mutex_unlock(&net->nft.commit_mutex);
+		mutex_unlock(&nft_net->commit_mutex);
 		return;
 	}
 
-	trans = list_last_entry(&net->nft.commit_list,
+	trans = list_last_entry(&nft_net->commit_list,
 				struct nft_trans, list);
 	get_net(trans->ctx.net);
 	WARN_ON_ONCE(trans->put_net);
 
 	trans->put_net = true;
 	spin_lock(&nf_tables_destroy_list_lock);
-	list_splice_tail_init(&net->nft.commit_list, &nf_tables_destroy_list);
+	list_splice_tail_init(&nft_net->commit_list, &nf_tables_destroy_list);
 	spin_unlock(&nf_tables_destroy_list_lock);
 
 	nf_tables_module_autoload_cleanup(net);
 	schedule_work(&trans_destroy_work);
 
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 }
 
 static void nft_commit_notify(struct net *net, u32 portid)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct sk_buff *batch_skb = NULL, *nskb, *skb;
 	unsigned char *data;
 	int len;
 
-	list_for_each_entry_safe(skb, nskb, &net->nft.notify_list, list) {
+	list_for_each_entry_safe(skb, nskb, &nft_net->notify_list, list) {
 		if (!batch_skb) {
 new_batch:
 			batch_skb = skb;
@@ -7805,7 +8031,7 @@ static void nft_commit_notify(struct net *net, u32 portid)
 			       NFT_CB(batch_skb).report, GFP_KERNEL);
 	}
 
-	WARN_ON_ONCE(!list_empty(&net->nft.notify_list));
+	WARN_ON_ONCE(!list_empty(&nft_net->notify_list));
 }
 
 static int nf_tables_commit_audit_alloc(struct list_head *adl,
@@ -7871,6 +8097,7 @@ static void nf_tables_commit_audit_log(struct list_head *adl, u32 generation)
 
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
@@ -7878,11 +8105,31 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	LIST_HEAD(adl);
 	int err;
 
-	if (list_empty(&net->nft.commit_list)) {
-		mutex_unlock(&net->nft.commit_mutex);
+	if (list_empty(&nft_net->commit_list)) {
+		mutex_unlock(&nft_net->commit_mutex);
 		return 0;
 	}
 
+	list_for_each_entry(trans, &nft_net->binding_list, binding_list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWSET:
+			if (nft_set_is_anonymous(nft_trans_set(trans)) &&
+			    !nft_trans_set_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound set\n");
+				return -EINVAL;
+			}
+			break;
+		case NFT_MSG_NEWCHAIN:
+			if (!nft_trans_chain_update(trans) &&
+			    nft_chain_binding(nft_trans_chain(trans)) &&
+			    !nft_trans_chain_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound chain\n");
+				return -EINVAL;
+			}
+			break;
+		}
+	}
+
 	/* 0. Validate ruleset, otherwise roll back for error reporting. */
 	if (nf_tables_validate(net) < 0)
 		return -EAGAIN;
@@ -7892,7 +8139,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		return err;
 
 	/* 1.  Allocate space for next generation rules_gen_X[] */
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		int ret;
 
 		ret = nf_tables_commit_audit_alloc(&adl, trans->ctx.table);
@@ -7915,7 +8162,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	}
 
 	/* step 2.  Make rules_gen_X visible to packet path */
-	list_for_each_entry(table, &net->nft.tables, list) {
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(chain, &table->chains, list)
 			nf_tables_commit_chain(net, chain);
 	}
@@ -7924,12 +8171,13 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	 * Bump generation counter, invalidate any dump in progress.
 	 * Cannot fail after this point.
 	 */
-	while (++net->nft.base_seq == 0);
+	while (++nft_net->base_seq == 0)
+		;
 
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
 
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		nf_tables_commit_audit_collect(&adl, trans->ctx.table,
 					       trans->msg_type);
 		switch (trans->msg_type) {
@@ -8089,7 +8337,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
-	nf_tables_commit_audit_log(&adl, net->nft.base_seq);
+	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
 	nf_tables_commit_release(net);
 
 	return 0;
@@ -8097,17 +8345,18 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 static void nf_tables_module_autoload(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_module_request *req, *next;
 	LIST_HEAD(module_list);
 
-	list_splice_init(&net->nft.module_list, &module_list);
-	mutex_unlock(&net->nft.commit_mutex);
+	list_splice_init(&nft_net->module_list, &module_list);
+	mutex_unlock(&nft_net->commit_mutex);
 	list_for_each_entry_safe(req, next, &module_list, list) {
 		request_module("%s", req->module);
 		req->done = true;
 	}
-	mutex_lock(&net->nft.commit_mutex);
-	list_splice(&module_list, &net->nft.module_list);
+	mutex_lock(&nft_net->commit_mutex);
+	list_splice(&module_list, &nft_net->module_list);
 }
 
 static void nf_tables_abort_release(struct nft_trans *trans)
@@ -8144,6 +8393,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 
 static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
 
@@ -8151,7 +8401,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	    nf_tables_validate(net) < 0)
 		return -EAGAIN;
 
-	list_for_each_entry_safe_reverse(trans, next, &net->nft.commit_list,
+	list_for_each_entry_safe_reverse(trans, next, &nft_net->commit_list,
 					 list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
@@ -8176,7 +8426,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				if (nft_chain_is_bound(trans->ctx.chain)) {
+				if (nft_trans_chain_bound(trans)) {
 					nft_trans_destroy(trans);
 					break;
 				}
@@ -8193,6 +8443,10 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWRULE:
+			if (nft_trans_rule_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			trans->ctx.chain->use--;
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
@@ -8216,6 +8470,9 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DELSET:
 			trans->ctx.table->use++;
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
+			if (nft_trans_set(trans)->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_activate(&trans->ctx, nft_trans_set(trans));
+
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
@@ -8230,7 +8487,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DELSETELEM:
 			te = (struct nft_trans_elem *)trans->data;
 
-			nft_set_elem_activate(net, te->set, &te->elem);
+			nft_setelem_data_activate(net, te->set, &te->elem);
 			te->set->ops->activate(net, te->set, &te->elem);
 			te->set->ndeact--;
 
@@ -8277,8 +8534,8 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	synchronize_rcu();
 
 	list_for_each_entry_safe_reverse(trans, next,
-					 &net->nft.commit_list, list) {
-		list_del(&trans->list);
+					 &nft_net->commit_list, list) {
+		nft_trans_list_del(trans);
 		nf_tables_abort_release(trans);
 	}
 
@@ -8293,22 +8550,24 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	int ret = __nf_tables_abort(net, action);
 
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
 }
 
 static bool nf_tables_valid_genid(struct net *net, u32 genid)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	bool genid_ok;
 
-	mutex_lock(&net->nft.commit_mutex);
+	mutex_lock(&nft_net->commit_mutex);
 
-	genid_ok = genid == 0 || net->nft.base_seq == genid;
+	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
-		mutex_unlock(&net->nft.commit_mutex);
+		mutex_unlock(&nft_net->commit_mutex);
 
 	/* else, commit mutex has to be released by commit or abort function */
 	return genid_ok;
@@ -8657,6 +8916,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 	if (!tb[NFTA_VERDICT_CODE])
 		return -EINVAL;
+
+	/* zero padding hole for memcmp */
+	memset(data, 0, sizeof(*data));
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
@@ -8682,7 +8944,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 						 genmask);
 		} else if (tb[NFTA_VERDICT_CHAIN_ID]) {
 			chain = nft_chain_lookup_byid(ctx->net, ctx->table,
-						      tb[NFTA_VERDICT_CHAIN_ID]);
+						      tb[NFTA_VERDICT_CHAIN_ID],
+						      genmask);
 			if (IS_ERR(chain))
 				return PTR_ERR(chain);
 		} else {
@@ -8712,22 +8975,12 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 static void nft_verdict_uninit(const struct nft_data *data)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 		chain->use--;
-
-		if (!nft_chain_is_bound(chain))
-			break;
-
-		chain->table->use--;
-		list_for_each_entry(rule, &chain->rules, list)
-			chain->use--;
-
-		nft_chain_del(chain);
 		break;
 	}
 }
@@ -8909,19 +9162,19 @@ EXPORT_SYMBOL_GPL(__nft_release_basechain);
 
 static void __nft_release_hooks(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_table *table;
 	struct nft_chain *chain;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(chain, &table->chains, list)
 			nf_tables_unregister_hook(net, table, chain);
 	}
 }
 
-static void __nft_release_tables(struct net *net)
+static void __nft_release_table(struct net *net, struct nft_table *table)
 {
 	struct nft_flowtable *flowtable, *nf;
-	struct nft_table *table, *nt;
 	struct nft_chain *chain, *nc;
 	struct nft_object *obj, *ne;
 	struct nft_rule *rule, *nr;
@@ -8931,79 +9184,101 @@ static void __nft_release_tables(struct net *net)
 		.family	= NFPROTO_NETDEV,
 	};
 
-	list_for_each_entry_safe(table, nt, &net->nft.tables, list) {
-		ctx.family = table->family;
-		ctx.table = table;
-		list_for_each_entry(chain, &table->chains, list) {
-			ctx.chain = chain;
-			list_for_each_entry_safe(rule, nr, &chain->rules, list) {
-				list_del(&rule->list);
-				chain->use--;
-				nf_tables_rule_release(&ctx, rule);
-			}
-		}
-		list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
-			list_del(&flowtable->list);
-			table->use--;
-			nf_tables_flowtable_destroy(flowtable);
-		}
-		list_for_each_entry_safe(set, ns, &table->sets, list) {
-			list_del(&set->list);
-			table->use--;
-			nft_set_destroy(&ctx, set);
-		}
-		list_for_each_entry_safe(obj, ne, &table->objects, list) {
-			nft_obj_del(obj);
-			table->use--;
-			nft_obj_destroy(&ctx, obj);
-		}
-		list_for_each_entry_safe(chain, nc, &table->chains, list) {
-			ctx.chain = chain;
-			nft_chain_del(chain);
-			table->use--;
-			nf_tables_chain_destroy(&ctx);
+	ctx.family = table->family;
+	ctx.table = table;
+	list_for_each_entry(chain, &table->chains, list) {
+		if (nft_chain_is_bound(chain))
+			continue;
+
+		ctx.chain = chain;
+		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
+			list_del(&rule->list);
+			chain->use--;
+			nf_tables_rule_release(&ctx, rule);
 		}
-		list_del(&table->list);
-		nf_tables_table_destroy(&ctx);
 	}
+	list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
+		list_del(&flowtable->list);
+		table->use--;
+		nf_tables_flowtable_destroy(flowtable);
+	}
+	list_for_each_entry_safe(set, ns, &table->sets, list) {
+		list_del(&set->list);
+		table->use--;
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(&ctx, set);
+
+		nft_set_destroy(&ctx, set);
+	}
+	list_for_each_entry_safe(obj, ne, &table->objects, list) {
+		nft_obj_del(obj);
+		table->use--;
+		nft_obj_destroy(&ctx, obj);
+	}
+	list_for_each_entry_safe(chain, nc, &table->chains, list) {
+		ctx.chain = chain;
+		nft_chain_del(chain);
+		table->use--;
+		nf_tables_chain_destroy(&ctx);
+	}
+	list_del(&table->list);
+	nf_tables_table_destroy(&ctx);
+}
+
+static void __nft_release_tables(struct net *net)
+{
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+	struct nft_table *table, *nt;
+
+	list_for_each_entry_safe(table, nt, &nft_net->tables, list)
+		__nft_release_table(net, table);
 }
 
 static int __net_init nf_tables_init_net(struct net *net)
 {
-	INIT_LIST_HEAD(&net->nft.tables);
-	INIT_LIST_HEAD(&net->nft.commit_list);
-	INIT_LIST_HEAD(&net->nft.module_list);
-	INIT_LIST_HEAD(&net->nft.notify_list);
-	mutex_init(&net->nft.commit_mutex);
-	net->nft.base_seq = 1;
-	net->nft.validate_state = NFT_VALIDATE_SKIP;
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	INIT_LIST_HEAD(&nft_net->tables);
+	INIT_LIST_HEAD(&nft_net->commit_list);
+	INIT_LIST_HEAD(&nft_net->binding_list);
+	INIT_LIST_HEAD(&nft_net->module_list);
+	INIT_LIST_HEAD(&nft_net->notify_list);
+	mutex_init(&nft_net->commit_mutex);
+	nft_net->base_seq = 1;
+	nft_net->validate_state = NFT_VALIDATE_SKIP;
 
 	return 0;
 }
 
 static void __net_exit nf_tables_pre_exit_net(struct net *net)
 {
-	mutex_lock(&net->nft.commit_mutex);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
 	__nft_release_hooks(net);
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 }
 
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
-	mutex_lock(&net->nft.commit_mutex);
-	if (!list_empty(&net->nft.commit_list))
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
+	if (!list_empty(&nft_net->commit_list))
 		__nf_tables_abort(net, NFNL_ABORT_NONE);
 	__nft_release_tables(net);
-	mutex_unlock(&net->nft.commit_mutex);
-	WARN_ON_ONCE(!list_empty(&net->nft.tables));
-	WARN_ON_ONCE(!list_empty(&net->nft.module_list));
-	WARN_ON_ONCE(!list_empty(&net->nft.notify_list));
+	mutex_unlock(&nft_net->commit_mutex);
+	WARN_ON_ONCE(!list_empty(&nft_net->tables));
+	WARN_ON_ONCE(!list_empty(&nft_net->module_list));
+	WARN_ON_ONCE(!list_empty(&nft_net->notify_list));
 }
 
 static struct pernet_operations nf_tables_net_ops = {
 	.init		= nf_tables_init_net,
 	.pre_exit	= nf_tables_pre_exit_net,
 	.exit		= nf_tables_exit_net,
+	.id		= &nf_tables_net_id,
+	.size		= sizeof(struct nftables_pernet),
 };
 
 static int __init nf_tables_module_init(void)
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 4e99b1731b3f..5cfbb29d8a34 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -7,6 +7,8 @@
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/pkt_cls.h>
 
+extern unsigned int nf_tables_net_id;
+
 static struct nft_flow_rule *nft_flow_rule_alloc(int num_actions)
 {
 	struct nft_flow_rule *flow;
@@ -371,16 +373,18 @@ static void nft_indr_block_cleanup(struct flow_block_cb *block_cb)
 	struct nft_base_chain *basechain = block_cb->indr.data;
 	struct net_device *dev = block_cb->indr.dev;
 	struct netlink_ext_ack extack = {};
+	struct nftables_pernet *nft_net;
 	struct net *net = dev_net(dev);
 	struct flow_block_offload bo;
 
 	nft_flow_block_offload_init(&bo, dev_net(dev), FLOW_BLOCK_UNBIND,
 				    basechain, &extack);
-	mutex_lock(&net->nft.commit_mutex);
+	nft_net = net_generic(net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
 	list_del(&block_cb->driver_list);
 	list_move(&block_cb->list, &bo.cb_list);
 	nft_flow_offload_unbind(&bo, basechain);
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 }
 
 static int nft_indr_block_offload_cmd(struct nft_base_chain *basechain,
@@ -476,9 +480,10 @@ static int nft_flow_offload_chain(struct nft_chain *chain, u8 *ppolicy,
 static void nft_flow_rule_offload_abort(struct net *net,
 					struct nft_trans *trans)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	int err = 0;
 
-	list_for_each_entry_continue_reverse(trans, &net->nft.commit_list, list) {
+	list_for_each_entry_continue_reverse(trans, &nft_net->commit_list, list) {
 		if (trans->ctx.family != NFPROTO_NETDEV)
 			continue;
 
@@ -524,11 +529,12 @@ static void nft_flow_rule_offload_abort(struct net *net,
 
 int nft_flow_rule_offload_commit(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans;
 	int err = 0;
 	u8 policy;
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		if (trans->ctx.family != NFPROTO_NETDEV)
 			continue;
 
@@ -580,7 +586,7 @@ int nft_flow_rule_offload_commit(struct net *net)
 		}
 	}
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		if (trans->ctx.family != NFPROTO_NETDEV)
 			continue;
 
@@ -600,15 +606,15 @@ int nft_flow_rule_offload_commit(struct net *net)
 	return err;
 }
 
-static struct nft_chain *__nft_offload_get_chain(struct net_device *dev)
+static struct nft_chain *__nft_offload_get_chain(const struct nftables_pernet *nft_net,
+						 struct net_device *dev)
 {
 	struct nft_base_chain *basechain;
-	struct net *net = dev_net(dev);
 	struct nft_hook *hook, *found;
 	const struct nft_table *table;
 	struct nft_chain *chain;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (table->family != NFPROTO_NETDEV)
 			continue;
 
@@ -640,19 +646,21 @@ static int nft_offload_netdev_event(struct notifier_block *this,
 				    unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct nftables_pernet *nft_net;
 	struct net *net = dev_net(dev);
 	struct nft_chain *chain;
 
 	if (event != NETDEV_UNREGISTER)
 		return NOTIFY_DONE;
 
-	mutex_lock(&net->nft.commit_mutex);
-	chain = __nft_offload_get_chain(dev);
+	nft_net = net_generic(net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	chain = __nft_offload_get_chain(nft_net, dev);
 	if (chain)
 		nft_flow_block_chain(nft_base_chain(chain), dev,
 				     FLOW_BLOCK_UNBIND);
 
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 9d5947ab8d4e..7b0b8fecb220 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -30,11 +30,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 	const struct nft_byteorder *priv = nft_expr_priv(expr);
 	u32 *src = &regs->data[priv->sreg];
 	u32 *dst = &regs->data[priv->dreg];
-	union { u32 u32; u16 u16; } *s, *d;
+	u16 *s16, *d16;
 	unsigned int i;
 
-	s = (void *)src;
-	d = (void *)dst;
+	s16 = (void *)src;
+	d16 = (void *)dst;
 
 	switch (priv->size) {
 	case 8: {
@@ -61,11 +61,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = ntohl((__force __be32)s[i].u32);
+				dst[i] = ntohl((__force __be32)src[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = (__force __u32)htonl(s[i].u32);
+				dst[i] = (__force __u32)htonl(src[i]);
 			break;
 		}
 		break;
@@ -73,11 +73,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = ntohs((__force __be16)s[i].u16);
+				d16[i] = ntohs((__force __be16)s16[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = (__force __u16)htons(s[i].u16);
+				d16[i] = (__force __u16)htons(s16[i]);
 			break;
 		}
 		break;
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index ff8528ad3dc6..7a9aa57b195b 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/netfilter/nf_tables.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
@@ -10,6 +11,8 @@
 #include <net/netfilter/nf_tables_ipv4.h>
 #include <net/netfilter/nf_tables_ipv6.h>
 
+extern unsigned int nf_tables_net_id;
+
 #ifdef CONFIG_NF_TABLES_IPV4
 static unsigned int nft_do_chain_ipv4(void *priv,
 				      struct sk_buff *skb,
@@ -355,6 +358,7 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 				  unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct nft_chain *chain, *nr;
 	struct nft_ctx ctx = {
@@ -365,8 +369,9 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 	    event != NETDEV_CHANGENAME)
 		return NOTIFY_DONE;
 
-	mutex_lock(&ctx.net->nft.commit_mutex);
-	list_for_each_entry(table, &ctx.net->nft.tables, list) {
+	nft_net = net_generic(ctx.net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (table->family != NFPROTO_NETDEV)
 			continue;
 
@@ -380,7 +385,7 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 			nft_netdev_event(event, dev, &ctx);
 		}
 	}
-	mutex_unlock(&ctx.net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 038588d4d80e..8d47782b778f 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -11,6 +11,9 @@
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 struct nft_dynset {
 	struct nft_set			*set;
@@ -106,13 +109,14 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 			   const struct nft_expr *expr,
 			   const struct nlattr * const tb[])
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct nft_dynset *priv = nft_expr_priv(expr);
 	u8 genmask = nft_genmask_next(ctx->net);
 	struct nft_set *set;
 	u64 timeout;
 	int err;
 
-	lockdep_assert_held(&ctx->net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	if (tb[NFTA_DYNSET_SET_NAME] == NULL ||
 	    tb[NFTA_DYNSET_OP] == NULL ||
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index fcdbc5ed3f36..6b0efab4fad0 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -76,11 +76,9 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 		switch (priv->data.verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			if (nft_chain_is_bound(chain)) {
-				err = -EBUSY;
-				goto err1;
-			}
-			chain->bound = true;
+			err = nf_tables_bind_chain(ctx, chain);
+			if (err < 0)
+				return err;
 			break;
 		default:
 			break;
@@ -98,6 +96,31 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 				   const struct nft_expr *expr)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_activate(&chain_ctx, rule);
+
+			nft_clear(ctx->net, chain);
+			break;
+		default:
+			break;
+		}
+	}
 
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
@@ -107,6 +130,43 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+
+			switch (phase) {
+			case NFT_TRANS_PREPARE_ERROR:
+				nf_tables_unbind_chain(ctx, chain);
+				fallthrough;
+			case NFT_TRANS_PREPARE:
+				nft_deactivate_next(ctx->net, chain);
+				break;
+			default:
+				nft_chain_del(chain);
+				chain->bound = false;
+				chain->table->use--;
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (phase == NFT_TRANS_COMMIT)
 		return;
@@ -131,15 +191,27 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 
-		if (!nft_chain_is_bound(chain))
+		if (!nft_chain_binding(chain))
+			break;
+
+		/* Rule construction failed, but chain is already bound:
+		 * let the transaction records release this chain and its rules.
+		 */
+		if (chain->bound) {
+			chain->use--;
 			break;
+		}
 
+		/* Rule has been deleted, release chain and its rules. */
 		chain_ctx = *ctx;
 		chain_ctx.chain = chain;
 
-		list_for_each_entry_safe(rule, n, &chain->rules, list)
-			nf_tables_rule_release(&chain_ctx, rule);
-
+		chain->use--;
+		list_for_each_entry_safe(rule, n, &chain->rules, list) {
+			chain->use--;
+			list_del(&rule->list);
+			nf_tables_rule_destroy(&chain_ctx, rule);
+		}
 		nf_tables_chain_destroy(&chain_ctx);
 		break;
 	default:
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 2a81ea421819..3c63f8acebd8 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -270,13 +270,14 @@ static int nft_bitmap_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_bitmap_destroy(const struct nft_set *set)
+static void nft_bitmap_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_bitmap *priv = nft_set_priv(set);
 	struct nft_bitmap_elem *be, *n;
 
 	list_for_each_entry_safe(be, n, &priv->list, head)
-		nft_set_elem_destroy(set, be, true);
+		nf_tables_set_elem_destroy(ctx, set, be);
 }
 
 static bool nft_bitmap_estimate(const struct nft_set_desc *desc, u32 features,
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index a5cfb321ae23..51d3e6f0934a 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -380,19 +380,31 @@ static int nft_rhash_init(const struct nft_set *set,
 	return 0;
 }
 
+struct nft_rhash_ctx {
+	const struct nft_ctx	ctx;
+	const struct nft_set	*set;
+};
+
 static void nft_rhash_elem_destroy(void *ptr, void *arg)
 {
-	nft_set_elem_destroy(arg, ptr, true);
+	struct nft_rhash_ctx *rhash_ctx = arg;
+
+	nf_tables_set_elem_destroy(&rhash_ctx->ctx, rhash_ctx->set, ptr);
 }
 
-static void nft_rhash_destroy(const struct nft_set *set)
+static void nft_rhash_destroy(const struct nft_ctx *ctx,
+			      const struct nft_set *set)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
+	struct nft_rhash_ctx rhash_ctx = {
+		.ctx	= *ctx,
+		.set	= set,
+	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
 	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
-				    (void *)set);
+				    (void *)&rhash_ctx);
 }
 
 /* Number of buckets is stored in u32, so cap our result to 1U<<31 */
@@ -621,7 +633,8 @@ static int nft_hash_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_hash_destroy(const struct nft_set *set)
+static void nft_hash_destroy(const struct nft_ctx *ctx,
+			     const struct nft_set *set)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	struct nft_hash_elem *he;
@@ -631,7 +644,7 @@ static void nft_hash_destroy(const struct nft_set *set)
 	for (i = 0; i < priv->buckets; i++) {
 		hlist_for_each_entry_safe(he, next, &priv->table[i], node) {
 			hlist_del_rcu(&he->node);
-			nft_set_elem_destroy(set, he, true);
+			nf_tables_set_elem_destroy(ctx, set, he);
 		}
 	}
 }
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index eb5934eb3adf..3be93175b3ff 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1904,7 +1904,11 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		int i, start, rules_fx;
 
 		match_start = data;
-		match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+
+		if (nft_set_ext_exists(&e->ext, NFT_SET_EXT_KEY_END))
+			match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+		else
+			match_end = data;
 
 		start = first_rule;
 		rules_fx = rules_f0;
@@ -2127,10 +2131,12 @@ static int nft_pipapo_init(const struct nft_set *set,
 
 /**
  * nft_set_pipapo_match_destroy() - Destroy elements from key mapping array
+ * @ctx:	context
  * @set:	nftables API set representation
  * @m:		matching data pointing to key mapping array
  */
-static void nft_set_pipapo_match_destroy(const struct nft_set *set,
+static void nft_set_pipapo_match_destroy(const struct nft_ctx *ctx,
+					 const struct nft_set *set,
 					 struct nft_pipapo_match *m)
 {
 	struct nft_pipapo_field *f;
@@ -2147,15 +2153,17 @@ static void nft_set_pipapo_match_destroy(const struct nft_set *set,
 
 		e = f->mt[r].e;
 
-		nft_set_elem_destroy(set, e, true);
+		nf_tables_set_elem_destroy(ctx, set, e);
 	}
 }
 
 /**
  * nft_pipapo_destroy() - Free private data for set and all committed elements
+ * @ctx:	context
  * @set:	nftables API set representation
  */
-static void nft_pipapo_destroy(const struct nft_set *set)
+static void nft_pipapo_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *m;
@@ -2165,7 +2173,7 @@ static void nft_pipapo_destroy(const struct nft_set *set)
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 #ifdef NFT_PIPAPO_ALIGN
 		free_percpu(m->scratch_aligned);
@@ -2182,7 +2190,7 @@ static void nft_pipapo_destroy(const struct nft_set *set)
 		m = priv->clone;
 
 		if (priv->dirty)
-			nft_set_pipapo_match_destroy(set, m);
+			nft_set_pipapo_match_destroy(ctx, set, m);
 
 #ifdef NFT_PIPAPO_ALIGN
 		free_percpu(priv->clone->scratch_aligned);
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 1ffb24f4c74c..172b994790a0 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -657,7 +657,8 @@ static int nft_rbtree_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_rbtree_destroy(const struct nft_set *set)
+static void nft_rbtree_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe;
@@ -668,7 +669,7 @@ static void nft_rbtree_destroy(const struct nft_set *set)
 	while ((node = priv->root.rb_node) != NULL) {
 		rb_erase(node, &priv->root);
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
-		nft_set_elem_destroy(set, rbe, true);
+		nf_tables_set_elem_destroy(ctx, set, rbe);
 	}
 }
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 99c869d8d304..9737c3229c12 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1602,6 +1602,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 {
 	struct netlink_set_err_data info;
+	unsigned long flags;
 	struct sock *sk;
 	int ret = 0;
 
@@ -1611,12 +1612,12 @@ int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 	/* sk->sk_err wants a positive error value */
 	info.code = -code;
 
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 
 	sk_for_each_bound(sk, &nl_table[ssk->sk_protocol].mc_list)
 		ret += do_one_set_err(sk, &info);
 
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(netlink_set_err);
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index c6255eac305c..e4f21b1067bc 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -94,6 +94,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	struct net *net = sock_net(skb->sk);
 	struct netlink_diag_req *req;
 	struct netlink_sock *nlsk;
+	unsigned long flags;
 	struct sock *sk;
 	int num = 2;
 	int ret = 0;
@@ -152,7 +153,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	num++;
 
 mc_list:
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 	sk_for_each_bound(sk, &tbl->mc_list) {
 		if (sk_hashed(sk))
 			continue;
@@ -167,13 +168,13 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq,
 				 NLM_F_MULTI,
-				 sock_i_ino(sk)) < 0) {
+				 __sock_i_ino(sk)) < 0) {
 			ret = 1;
 			break;
 		}
 		num++;
 	}
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 
 done:
 	cb->args[0] = num;
diff --git a/net/nfc/core.c b/net/nfc/core.c
index 2ef56366bd5f..10a3d740d155 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -634,7 +634,7 @@ int nfc_disable_se(struct nfc_dev *dev, u32 se_idx)
 	return rc;
 }
 
-int nfc_set_remote_general_bytes(struct nfc_dev *dev, u8 *gb, u8 gb_len)
+int nfc_set_remote_general_bytes(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 {
 	pr_debug("dev_name=%s gb_len=%d\n", dev_name(&dev->dev), gb_len);
 
@@ -663,7 +663,7 @@ int nfc_tm_data_received(struct nfc_dev *dev, struct sk_buff *skb)
 EXPORT_SYMBOL(nfc_tm_data_received);
 
 int nfc_tm_activated(struct nfc_dev *dev, u32 protocol, u8 comm_mode,
-		     u8 *gb, size_t gb_len)
+		     const u8 *gb, size_t gb_len)
 {
 	int rc;
 
diff --git a/net/nfc/hci/llc_shdlc.c b/net/nfc/hci/llc_shdlc.c
index 0eb4ddc056e7..02909e3e91ef 100644
--- a/net/nfc/hci/llc_shdlc.c
+++ b/net/nfc/hci/llc_shdlc.c
@@ -123,7 +123,7 @@ static bool llc_shdlc_x_lteq_y_lt_z(int x, int y, int z)
 		return ((y >= x) || (y < z)) ? true : false;
 }
 
-static struct sk_buff *llc_shdlc_alloc_skb(struct llc_shdlc *shdlc,
+static struct sk_buff *llc_shdlc_alloc_skb(const struct llc_shdlc *shdlc,
 					   int payload_len)
 {
 	struct sk_buff *skb;
@@ -137,7 +137,7 @@ static struct sk_buff *llc_shdlc_alloc_skb(struct llc_shdlc *shdlc,
 }
 
 /* immediately sends an S frame. */
-static int llc_shdlc_send_s_frame(struct llc_shdlc *shdlc,
+static int llc_shdlc_send_s_frame(const struct llc_shdlc *shdlc,
 				  enum sframe_type sframe_type, int nr)
 {
 	int r;
@@ -159,7 +159,7 @@ static int llc_shdlc_send_s_frame(struct llc_shdlc *shdlc,
 }
 
 /* immediately sends an U frame. skb may contain optional payload */
-static int llc_shdlc_send_u_frame(struct llc_shdlc *shdlc,
+static int llc_shdlc_send_u_frame(const struct llc_shdlc *shdlc,
 				  struct sk_buff *skb,
 				  enum uframe_modifier uframe_modifier)
 {
@@ -361,7 +361,7 @@ static void llc_shdlc_connect_complete(struct llc_shdlc *shdlc, int r)
 	wake_up(shdlc->connect_wq);
 }
 
-static int llc_shdlc_connect_initiate(struct llc_shdlc *shdlc)
+static int llc_shdlc_connect_initiate(const struct llc_shdlc *shdlc)
 {
 	struct sk_buff *skb;
 
@@ -377,7 +377,7 @@ static int llc_shdlc_connect_initiate(struct llc_shdlc *shdlc)
 	return llc_shdlc_send_u_frame(shdlc, skb, U_FRAME_RSET);
 }
 
-static int llc_shdlc_connect_send_ua(struct llc_shdlc *shdlc)
+static int llc_shdlc_connect_send_ua(const struct llc_shdlc *shdlc)
 {
 	struct sk_buff *skb;
 
diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index 97853c9cefc7..a81893bc06ce 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -202,7 +202,6 @@ void nfc_llcp_sock_link(struct llcp_sock_list *l, struct sock *s);
 void nfc_llcp_sock_unlink(struct llcp_sock_list *l, struct sock *s);
 void nfc_llcp_socket_remote_param_init(struct nfc_llcp_sock *sock);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
-struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local);
 int nfc_llcp_local_put(struct nfc_llcp_local *local);
 u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 			 struct nfc_llcp_sock *sock);
@@ -221,15 +220,15 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *sk, struct socket *newsock);
 
 /* TLV API */
 int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
-			  u8 *tlv_array, u16 tlv_array_len);
+			  const u8 *tlv_array, u16 tlv_array_len);
 int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
-				  u8 *tlv_array, u16 tlv_array_len);
+				  const u8 *tlv_array, u16 tlv_array_len);
 
 /* Commands API */
 void nfc_llcp_recv(void *data, struct sk_buff *skb, int err);
-u8 *nfc_llcp_build_tlv(u8 type, u8 *value, u8 value_length, u8 *tlv_length);
+u8 *nfc_llcp_build_tlv(u8 type, const u8 *value, u8 value_length, u8 *tlv_length);
 struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdres_tlv(u8 tid, u8 sap);
-struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, char *uri,
+struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 						  size_t uri_len);
 void nfc_llcp_free_sdp_tlv(struct nfc_llcp_sdp_tlv *sdp);
 void nfc_llcp_free_sdp_tlv_list(struct hlist_head *sdp_head);
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 475061c79c44..5b8754ae7d3a 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -15,7 +15,7 @@
 #include "nfc.h"
 #include "llcp.h"
 
-static u8 llcp_tlv_length[LLCP_TLV_MAX] = {
+static const u8 llcp_tlv_length[LLCP_TLV_MAX] = {
 	0,
 	1, /* VERSION */
 	2, /* MIUX */
@@ -29,7 +29,7 @@ static u8 llcp_tlv_length[LLCP_TLV_MAX] = {
 
 };
 
-static u8 llcp_tlv8(u8 *tlv, u8 type)
+static u8 llcp_tlv8(const u8 *tlv, u8 type)
 {
 	if (tlv[0] != type || tlv[1] != llcp_tlv_length[tlv[0]])
 		return 0;
@@ -37,7 +37,7 @@ static u8 llcp_tlv8(u8 *tlv, u8 type)
 	return tlv[2];
 }
 
-static u16 llcp_tlv16(u8 *tlv, u8 type)
+static u16 llcp_tlv16(const u8 *tlv, u8 type)
 {
 	if (tlv[0] != type || tlv[1] != llcp_tlv_length[tlv[0]])
 		return 0;
@@ -46,37 +46,37 @@ static u16 llcp_tlv16(u8 *tlv, u8 type)
 }
 
 
-static u8 llcp_tlv_version(u8 *tlv)
+static u8 llcp_tlv_version(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_VERSION);
 }
 
-static u16 llcp_tlv_miux(u8 *tlv)
+static u16 llcp_tlv_miux(const u8 *tlv)
 {
 	return llcp_tlv16(tlv, LLCP_TLV_MIUX) & 0x7ff;
 }
 
-static u16 llcp_tlv_wks(u8 *tlv)
+static u16 llcp_tlv_wks(const u8 *tlv)
 {
 	return llcp_tlv16(tlv, LLCP_TLV_WKS);
 }
 
-static u16 llcp_tlv_lto(u8 *tlv)
+static u16 llcp_tlv_lto(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_LTO);
 }
 
-static u8 llcp_tlv_opt(u8 *tlv)
+static u8 llcp_tlv_opt(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_OPT);
 }
 
-static u8 llcp_tlv_rw(u8 *tlv)
+static u8 llcp_tlv_rw(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_RW) & 0xf;
 }
 
-u8 *nfc_llcp_build_tlv(u8 type, u8 *value, u8 value_length, u8 *tlv_length)
+u8 *nfc_llcp_build_tlv(u8 type, const u8 *value, u8 value_length, u8 *tlv_length)
 {
 	u8 *tlv, length;
 
@@ -130,7 +130,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdres_tlv(u8 tid, u8 sap)
 	return sdres;
 }
 
-struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, char *uri,
+struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 						  size_t uri_len)
 {
 	struct nfc_llcp_sdp_tlv *sdreq;
@@ -190,9 +190,10 @@ void nfc_llcp_free_sdp_tlv_list(struct hlist_head *head)
 }
 
 int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
-			  u8 *tlv_array, u16 tlv_array_len)
+			  const u8 *tlv_array, u16 tlv_array_len)
 {
-	u8 *tlv = tlv_array, type, length, offset = 0;
+	const u8 *tlv = tlv_array;
+	u8 type, length, offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -239,9 +240,10 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 }
 
 int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
-				  u8 *tlv_array, u16 tlv_array_len)
+				  const u8 *tlv_array, u16 tlv_array_len)
 {
-	u8 *tlv = tlv_array, type, length, offset = 0;
+	const u8 *tlv = tlv_array;
+	u8 type, length, offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -295,7 +297,7 @@ static struct sk_buff *llcp_add_header(struct sk_buff *pdu,
 	return pdu;
 }
 
-static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, u8 *tlv,
+static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, const u8 *tlv,
 				    u8 tlv_length)
 {
 	/* XXX Add an skb length check */
@@ -359,6 +361,7 @@ int nfc_llcp_send_symm(struct nfc_dev *dev)
 	struct sk_buff *skb;
 	struct nfc_llcp_local *local;
 	u16 size = 0;
+	int err;
 
 	pr_debug("Sending SYMM\n");
 
@@ -370,8 +373,10 @@ int nfc_llcp_send_symm(struct nfc_dev *dev)
 	size += dev->tx_headroom + dev->tx_tailroom + NFC_HEADER_SIZE;
 
 	skb = alloc_skb(size, GFP_KERNEL);
-	if (skb == NULL)
-		return -ENOMEM;
+	if (skb == NULL) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	skb_reserve(skb, dev->tx_headroom + NFC_HEADER_SIZE);
 
@@ -381,17 +386,22 @@ int nfc_llcp_send_symm(struct nfc_dev *dev)
 
 	nfc_llcp_send_to_raw_sock(local, skb, NFC_DIRECTION_TX);
 
-	return nfc_data_exchange(dev, local->target_idx, skb,
+	err = nfc_data_exchange(dev, local->target_idx, skb,
 				 nfc_llcp_recv, local);
+out:
+	nfc_llcp_local_put(local);
+	return err;
 }
 
 int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local;
 	struct sk_buff *skb;
-	u8 *service_name_tlv = NULL, service_name_tlv_length;
-	u8 *miux_tlv = NULL, miux_tlv_length;
-	u8 *rw_tlv = NULL, rw_tlv_length, rw;
+	const u8 *service_name_tlv = NULL;
+	const u8 *miux_tlv = NULL;
+	const u8 *rw_tlv = NULL;
+	u8 service_name_tlv_length = 0;
+	u8 miux_tlv_length,  rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
@@ -465,8 +475,9 @@ int nfc_llcp_send_cc(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local;
 	struct sk_buff *skb;
-	u8 *miux_tlv = NULL, miux_tlv_length;
-	u8 *rw_tlv = NULL, rw_tlv_length, rw;
+	const u8 *miux_tlv = NULL;
+	const u8 *rw_tlv = NULL;
+	u8 miux_tlv_length, rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index edadebb3efd2..ddfd159f64e1 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -17,6 +17,8 @@
 static u8 llcp_magic[3] = {0x46, 0x66, 0x6d};
 
 static LIST_HEAD(llcp_devices);
+/* Protects llcp_devices list */
+static DEFINE_SPINLOCK(llcp_devices_lock);
 
 static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb);
 
@@ -143,7 +145,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 	write_unlock(&local->raw_sockets.lock);
 }
 
-struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
+static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
 	kref_get(&local->ref);
 
@@ -171,7 +173,6 @@ static void local_release(struct kref *ref)
 
 	local = container_of(ref, struct nfc_llcp_local, ref);
 
-	list_del(&local->list);
 	local_cleanup(local);
 	kfree(local);
 }
@@ -284,12 +285,33 @@ static void nfc_llcp_sdreq_timer(struct timer_list *t)
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev)
 {
 	struct nfc_llcp_local *local;
+	struct nfc_llcp_local *res = NULL;
 
+	spin_lock(&llcp_devices_lock);
 	list_for_each_entry(local, &llcp_devices, list)
-		if (local->dev == dev)
+		if (local->dev == dev) {
+			res = nfc_llcp_local_get(local);
+			break;
+		}
+	spin_unlock(&llcp_devices_lock);
+
+	return res;
+}
+
+static struct nfc_llcp_local *nfc_llcp_remove_local(struct nfc_dev *dev)
+{
+	struct nfc_llcp_local *local, *tmp;
+
+	spin_lock(&llcp_devices_lock);
+	list_for_each_entry_safe(local, tmp, &llcp_devices, list)
+		if (local->dev == dev) {
+			list_del(&local->list);
+			spin_unlock(&llcp_devices_lock);
 			return local;
+		}
+	spin_unlock(&llcp_devices_lock);
 
-	pr_debug("No device found\n");
+	pr_warn("Shutting down device not found\n");
 
 	return NULL;
 }
@@ -302,7 +324,7 @@ static char *wks[] = {
 	"urn:nfc:sn:snep",
 };
 
-static int nfc_llcp_wks_sap(char *service_name, size_t service_name_len)
+static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 {
 	int sap, num_wks;
 
@@ -326,7 +348,7 @@ static int nfc_llcp_wks_sap(char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -523,7 +545,7 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
 {
 	u8 *gb_cur, version, version_length;
 	u8 lto_length, wks_length, miux_length;
-	u8 *version_tlv = NULL, *lto_tlv = NULL,
+	const u8 *version_tlv = NULL, *lto_tlv = NULL,
 	   *wks_tlv = NULL, *miux_tlv = NULL;
 	__be16 wks = cpu_to_be16(local->local_wks);
 	u8 gb_len = 0;
@@ -610,12 +632,15 @@ u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
 
 	*general_bytes_len = local->gb_len;
 
+	nfc_llcp_local_put(local);
+
 	return local->gb;
 }
 
-int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len)
+int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 {
 	struct nfc_llcp_local *local;
+	int err;
 
 	if (gb_len < 3 || gb_len > NFC_MAX_GT_LEN)
 		return -EINVAL;
@@ -632,35 +657,39 @@ int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len)
 
 	if (memcmp(local->remote_gb, llcp_magic, 3)) {
 		pr_err("MAC does not support LLCP\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
-	return nfc_llcp_parse_gb_tlv(local,
+	err = nfc_llcp_parse_gb_tlv(local,
 				     &local->remote_gb[3],
 				     local->remote_gb_len - 3);
+out:
+	nfc_llcp_local_put(local);
+	return err;
 }
 
-static u8 nfc_llcp_dsap(struct sk_buff *pdu)
+static u8 nfc_llcp_dsap(const struct sk_buff *pdu)
 {
 	return (pdu->data[0] & 0xfc) >> 2;
 }
 
-static u8 nfc_llcp_ptype(struct sk_buff *pdu)
+static u8 nfc_llcp_ptype(const struct sk_buff *pdu)
 {
 	return ((pdu->data[0] & 0x03) << 2) | ((pdu->data[1] & 0xc0) >> 6);
 }
 
-static u8 nfc_llcp_ssap(struct sk_buff *pdu)
+static u8 nfc_llcp_ssap(const struct sk_buff *pdu)
 {
 	return pdu->data[1] & 0x3f;
 }
 
-static u8 nfc_llcp_ns(struct sk_buff *pdu)
+static u8 nfc_llcp_ns(const struct sk_buff *pdu)
 {
 	return pdu->data[2] >> 4;
 }
 
-static u8 nfc_llcp_nr(struct sk_buff *pdu)
+static u8 nfc_llcp_nr(const struct sk_buff *pdu)
 {
 	return pdu->data[2] & 0xf;
 }
@@ -802,7 +831,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
-						  u8 *sn, size_t sn_len)
+						  const u8 *sn, size_t sn_len)
 {
 	struct nfc_llcp_sock *llcp_sock;
 
@@ -816,9 +845,10 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 	return llcp_sock;
 }
 
-static u8 *nfc_llcp_connect_sn(struct sk_buff *skb, size_t *sn_len)
+static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
-	u8 *tlv = &skb->data[2], type, length;
+	u8 type, length;
+	const u8 *tlv = &skb->data[2];
 	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
 
 	while (offset < tlv_array_len) {
@@ -876,7 +906,7 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
 }
 
 static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
-				  struct sk_buff *skb)
+				  const struct sk_buff *skb)
 {
 	struct sock *new_sk, *parent;
 	struct nfc_llcp_sock *sock, *new_sock;
@@ -894,7 +924,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 			goto fail;
 		}
 	} else {
-		u8 *sn;
+		const u8 *sn;
 		size_t sn_len;
 
 		sn = nfc_llcp_connect_sn(skb, &sn_len);
@@ -1113,7 +1143,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 }
 
 static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
-			       struct sk_buff *skb)
+			       const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1156,7 +1186,8 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	nfc_llcp_sock_put(llcp_sock);
 }
 
-static void nfc_llcp_recv_cc(struct nfc_llcp_local *local, struct sk_buff *skb)
+static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
+			     const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1189,7 +1220,8 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local, struct sk_buff *skb)
 	nfc_llcp_sock_put(llcp_sock);
 }
 
-static void nfc_llcp_recv_dm(struct nfc_llcp_local *local, struct sk_buff *skb)
+static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
+			     const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1227,12 +1259,13 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local, struct sk_buff *skb)
 }
 
 static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
-			      struct sk_buff *skb)
+			      const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
-	u8 dsap, ssap, *tlv, type, length, tid, sap;
+	u8 dsap, ssap, type, length, tid, sap;
+	const u8 *tlv;
 	u16 tlv_len, offset;
-	char *service_name;
+	const char *service_name;
 	size_t service_name_len;
 	struct nfc_llcp_sdp_tlv *sdp;
 	HLIST_HEAD(llc_sdres_list);
@@ -1523,6 +1556,8 @@ int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb)
 
 	__nfc_llcp_recv(local, skb);
 
+	nfc_llcp_local_put(local);
+
 	return 0;
 }
 
@@ -1539,6 +1574,8 @@ void nfc_llcp_mac_is_down(struct nfc_dev *dev)
 
 	/* Close and purge all existing sockets */
 	nfc_llcp_socket_release(local, true, 0);
+
+	nfc_llcp_local_put(local);
 }
 
 void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
@@ -1564,6 +1601,8 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 		mod_timer(&local->link_timer,
 			  jiffies + msecs_to_jiffies(local->remote_lto));
 	}
+
+	nfc_llcp_local_put(local);
 }
 
 int nfc_llcp_register_device(struct nfc_dev *ndev)
@@ -1614,7 +1653,7 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 
 void nfc_llcp_unregister_device(struct nfc_dev *dev)
 {
-	struct nfc_llcp_local *local = nfc_llcp_find_local(dev);
+	struct nfc_llcp_local *local = nfc_llcp_remove_local(dev);
 
 	if (local == NULL) {
 		pr_debug("No such device\n");
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 0b93a17b9f11..6e1fba208493 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -99,7 +99,7 @@ static int llcp_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	}
 
 	llcp_sock->dev = dev;
-	llcp_sock->local = nfc_llcp_local_get(local);
+	llcp_sock->local = local;
 	llcp_sock->nfc_protocol = llcp_addr.nfc_protocol;
 	llcp_sock->service_name_len = min_t(unsigned int,
 					    llcp_addr.service_name_len,
@@ -181,7 +181,7 @@ static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr *addr,
 	}
 
 	llcp_sock->dev = dev;
-	llcp_sock->local = nfc_llcp_local_get(local);
+	llcp_sock->local = local;
 	llcp_sock->nfc_protocol = llcp_addr.nfc_protocol;
 
 	nfc_llcp_sock_link(&local->raw_sockets, sk);
@@ -698,24 +698,22 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 	if (dev->dep_link_up == false) {
 		ret = -ENOLINK;
 		device_unlock(&dev->dev);
-		goto put_dev;
+		goto sock_llcp_put_local;
 	}
 	device_unlock(&dev->dev);
 
 	if (local->rf_mode == NFC_RF_INITIATOR &&
 	    addr->target_idx != local->target_idx) {
 		ret = -ENOLINK;
-		goto put_dev;
+		goto sock_llcp_put_local;
 	}
 
 	llcp_sock->dev = dev;
-	llcp_sock->local = nfc_llcp_local_get(local);
+	llcp_sock->local = local;
 	llcp_sock->ssap = nfc_llcp_get_local_ssap(local);
 	if (llcp_sock->ssap == LLCP_SAP_MAX) {
-		nfc_llcp_local_put(llcp_sock->local);
-		llcp_sock->local = NULL;
 		ret = -ENOMEM;
-		goto put_dev;
+		goto sock_llcp_nullify;
 	}
 
 	llcp_sock->reserved_ssap = llcp_sock->ssap;
@@ -760,8 +758,13 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 
 sock_llcp_release:
 	nfc_llcp_put_ssap(local, llcp_sock->ssap);
-	nfc_llcp_local_put(llcp_sock->local);
+
+sock_llcp_nullify:
 	llcp_sock->local = NULL;
+	llcp_sock->dev = NULL;
+
+sock_llcp_put_local:
+	nfc_llcp_local_put(local);
 
 put_dev:
 	nfc_put_device(dev);
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index e0e116865511..1c5b3ce1e8b1 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1039,11 +1039,14 @@ static int nfc_genl_llc_get_params(struct sk_buff *skb, struct genl_info *info)
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		rc = -ENOMEM;
-		goto exit;
+		goto put_local;
 	}
 
 	rc = nfc_genl_send_params(msg, local, info->snd_portid, info->snd_seq);
 
+put_local:
+	nfc_llcp_local_put(local);
+
 exit:
 	device_unlock(&dev->dev);
 
@@ -1105,7 +1108,7 @@ static int nfc_genl_llc_set_params(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NFC_ATTR_LLC_PARAM_LTO]) {
 		if (dev->dep_link_up) {
 			rc = -EINPROGRESS;
-			goto exit;
+			goto put_local;
 		}
 
 		local->lto = nla_get_u8(info->attrs[NFC_ATTR_LLC_PARAM_LTO]);
@@ -1117,6 +1120,9 @@ static int nfc_genl_llc_set_params(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NFC_ATTR_LLC_PARAM_MIUX])
 		local->miux = cpu_to_be16(miux);
 
+put_local:
+	nfc_llcp_local_put(local);
+
 exit:
 	device_unlock(&dev->dev);
 
@@ -1172,7 +1178,7 @@ static int nfc_genl_llc_sdreq(struct sk_buff *skb, struct genl_info *info)
 
 		if (rc != 0) {
 			rc = -EINVAL;
-			goto exit;
+			goto put_local;
 		}
 
 		if (!sdp_attrs[NFC_SDP_ATTR_URI])
@@ -1191,7 +1197,7 @@ static int nfc_genl_llc_sdreq(struct sk_buff *skb, struct genl_info *info)
 		sdreq = nfc_llcp_build_sdreq_tlv(tid, uri, uri_len);
 		if (sdreq == NULL) {
 			rc = -ENOMEM;
-			goto exit;
+			goto put_local;
 		}
 
 		tlvs_len += sdreq->tlv_len;
@@ -1201,10 +1207,14 @@ static int nfc_genl_llc_sdreq(struct sk_buff *skb, struct genl_info *info)
 
 	if (hlist_empty(&sdreq_list)) {
 		rc = -EINVAL;
-		goto exit;
+		goto put_local;
 	}
 
 	rc = nfc_llcp_send_snl_sdreq(local, &sdreq_list, tlvs_len);
+
+put_local:
+	nfc_llcp_local_put(local);
+
 exit:
 	device_unlock(&dev->dev);
 
diff --git a/net/nfc/nfc.h b/net/nfc/nfc.h
index 889fefd64e56..0b1e6466f4fb 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -48,10 +48,11 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 			u8 comm_mode, u8 rf_mode);
 int nfc_llcp_register_device(struct nfc_dev *dev);
 void nfc_llcp_unregister_device(struct nfc_dev *dev);
-int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len);
+int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len);
 u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len);
 int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
+int nfc_llcp_local_put(struct nfc_llcp_local *local);
 int __init nfc_llcp_init(void);
 void nfc_llcp_exit(void);
 void nfc_llcp_free_sdp_tlv(struct nfc_llcp_sdp_tlv *sdp);
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index db0d3bff19eb..a44101b2f441 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -26,6 +26,7 @@ static struct tc_action_ops act_pedit_ops;
 
 static const struct nla_policy pedit_policy[TCA_PEDIT_MAX + 1] = {
 	[TCA_PEDIT_PARMS]	= { .len = sizeof(struct tc_pedit) },
+	[TCA_PEDIT_PARMS_EX]	= { .len = sizeof(struct tc_pedit) },
 	[TCA_PEDIT_KEYS_EX]   = { .type = NLA_NESTED },
 };
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index caf1a05bfbde..dcf21d99f132 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -778,6 +778,16 @@ static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
 		       TCA_FLOWER_KEY_PORT_SRC_MAX, &mask->tp_range.tp_max.src,
 		       TCA_FLOWER_UNSPEC, sizeof(key->tp_range.tp_max.src));
 
+	if (mask->tp_range.tp_min.dst != mask->tp_range.tp_max.dst) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max destination ports must be specified");
+		return -EINVAL;
+	}
+	if (mask->tp_range.tp_min.src != mask->tp_range.tp_max.src) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max source ports must be specified");
+		return -EINVAL;
+	}
 	if (mask->tp_range.tp_min.dst && mask->tp_range.tp_max.dst &&
 	    ntohs(key->tp_range.tp_max.dst) <=
 	    ntohs(key->tp_range.tp_min.dst)) {
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index ec945294626a..41f0898a5a56 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -210,11 +210,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_FW_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
-		tcf_bind_filter(tp, &f->res, base);
-	}
-
 	if (tb[TCA_FW_INDEV]) {
 		int ret;
 		ret = tcf_change_indev(net, tb[TCA_FW_INDEV], extack);
@@ -231,6 +226,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	} else if (head->mask != 0xFFFFFFFF)
 		return err;
 
+	if (tb[TCA_FW_CLASSID]) {
+		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
+		tcf_bind_filter(tp, &f->res, base);
+	}
+
 	return 0;
 }
 
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index cad7deacf60a..d5a1e4b237b1 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -113,6 +113,7 @@
 
 #define QFQ_MTU_SHIFT		16	/* to support TSO/GSO */
 #define QFQ_MIN_LMAX		512	/* see qfq_slot_insert */
+#define QFQ_MAX_LMAX		(1UL << QFQ_MTU_SHIFT)
 
 #define QFQ_MAX_AGG_CLASSES	8 /* max num classes per aggregate allowed */
 
@@ -214,9 +215,14 @@ static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 	return container_of(clc, struct qfq_class, common);
 }
 
+static struct netlink_range_validation lmax_range = {
+	.min = QFQ_MIN_LMAX,
+	.max = QFQ_MAX_LMAX,
+};
+
 static const struct nla_policy qfq_policy[TCA_QFQ_MAX + 1] = {
-	[TCA_QFQ_WEIGHT] = { .type = NLA_U32 },
-	[TCA_QFQ_LMAX] = { .type = NLA_U32 },
+	[TCA_QFQ_WEIGHT] = NLA_POLICY_RANGE(NLA_U32, 1, QFQ_MAX_WEIGHT),
+	[TCA_QFQ_LMAX] = NLA_POLICY_FULL_RANGE(NLA_U32, &lmax_range),
 };
 
 /*
@@ -375,8 +381,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 			   u32 lmax)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+	struct qfq_aggregate *new_agg;
+
+	/* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+	if (lmax > QFQ_MAX_LMAX)
+		return -EINVAL;
 
+	new_agg = qfq_find_agg(q, lmax, weight);
 	if (new_agg == NULL) { /* create new aggregate */
 		new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
 		if (new_agg == NULL)
@@ -408,27 +419,25 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_QFQ_MAX, tca[TCA_OPTIONS],
-					  qfq_policy, NULL);
+					  qfq_policy, extack);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_QFQ_WEIGHT]) {
+	if (tb[TCA_QFQ_WEIGHT])
 		weight = nla_get_u32(tb[TCA_QFQ_WEIGHT]);
-		if (!weight || weight > (1UL << QFQ_MAX_WSHIFT)) {
-			pr_notice("qfq: invalid weight %u\n", weight);
-			return -EINVAL;
-		}
-	} else
+	else
 		weight = 1;
 
-	if (tb[TCA_QFQ_LMAX])
+	if (tb[TCA_QFQ_LMAX]) {
 		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
-	else
+	} else {
+		/* MTU size is user controlled */
 		lmax = psched_mtu(qdisc_dev(sch));
-
-	if (lmax < QFQ_MIN_LMAX || lmax > (1UL << QFQ_MTU_SHIFT)) {
-		pr_notice("qfq: invalid max length %u\n", lmax);
-		return -EINVAL;
+		if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "MTU size out of bounds for qfq");
+			return -EINVAL;
+		}
 	}
 
 	inv_w = ONE_FP / weight;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 35d3eee26ea5..534364bb871a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -362,9 +362,9 @@ static void sctp_auto_asconf_init(struct sctp_sock *sp)
 	struct net *net = sock_net(&sp->inet.sk);
 
 	if (net->sctp.default_auto_asconf) {
-		spin_lock(&net->sctp.addr_wq_lock);
+		spin_lock_bh(&net->sctp.addr_wq_lock);
 		list_add_tail(&sp->auto_asconf_list, &net->sctp.auto_asconf_splist);
-		spin_unlock(&net->sctp.addr_wq_lock);
+		spin_unlock_bh(&net->sctp.addr_wq_lock);
 		sp->do_auto_asconf = 1;
 	}
 }
@@ -8039,6 +8039,22 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
 	return retval;
 }
 
+static bool sctp_bpf_bypass_getsockopt(int level, int optname)
+{
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		case SCTP_SOCKOPT_PEELOFF:
+		case SCTP_SOCKOPT_PEELOFF_FLAGS:
+		case SCTP_SOCKOPT_CONNECTX3:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+
 static int sctp_hash(struct sock *sk)
 {
 	/* STUB */
@@ -9407,6 +9423,7 @@ struct proto sctp_prot = {
 	.shutdown    =	sctp_shutdown,
 	.setsockopt  =	sctp_setsockopt,
 	.getsockopt  =	sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg     =	sctp_sendmsg,
 	.recvmsg     =	sctp_recvmsg,
 	.bind        =	sctp_bind,
@@ -9459,6 +9476,7 @@ struct proto sctpv6_prot = {
 	.shutdown	= sctp_shutdown,
 	.setsockopt	= sctp_setsockopt,
 	.getsockopt	= sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg	= sctp_sendmsg,
 	.recvmsg	= sctp_recvmsg,
 	.bind		= sctp_bind,
diff --git a/net/socket.c b/net/socket.c
index 84223419da86..f2172b756c0f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2137,6 +2137,9 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 	return __sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
+INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
+							 int optname));
+
 /*
  *	Get a socket option. Because we don't know the option lengths we have
  *	to pass a user mode parameter for the protocols to sort out.
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6d5bb8bfed38..3d5ee042c501 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -692,12 +692,6 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 {
 	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
 
-	if (svsk) {
-		/* Refer to svc_setup_socket() for details. */
-		rmb();
-		svsk->sk_odata(sk);
-	}
-
 	/*
 	 * This callback may called twice when a new connection
 	 * is established as a child socket inherits everything
@@ -706,13 +700,18 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 	 *    when one of child sockets become ESTABLISHED.
 	 * 2) data_ready method of the child socket may be called
 	 *    when it receives data before the socket is accepted.
-	 * In case of 2, we should ignore it silently.
+	 * In case of 2, we should ignore it silently and DO NOT
+	 * dereference svsk.
 	 */
-	if (sk->sk_state == TCP_LISTEN) {
-		if (svsk) {
-			set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
-			svc_xprt_enqueue(&svsk->sk_xprt);
-		}
+	if (sk->sk_state != TCP_LISTEN)
+		return;
+
+	if (svsk) {
+		/* Refer to svc_setup_socket() for details. */
+		rmb();
+		svsk->sk_odata(sk);
+		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
+		svc_xprt_enqueue(&svsk->sk_xprt);
 	}
 }
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d09dabae5627..671c7f83d5fc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -262,117 +262,152 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 }
 EXPORT_SYMBOL(cfg80211_is_element_inherited);
 
-static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
-				  const u8 *subelement, size_t subie_len,
-				  u8 *new_ie, gfp_t gfp)
+static size_t cfg80211_copy_elem_with_frags(const struct element *elem,
+					    const u8 *ie, size_t ie_len,
+					    u8 **pos, u8 *buf, size_t buf_len)
 {
-	u8 *pos, *tmp;
-	const u8 *tmp_old, *tmp_new;
-	const struct element *non_inherit_elem;
-	u8 *sub_copy;
+	if (WARN_ON((u8 *)elem < ie || elem->data > ie + ie_len ||
+		    elem->data + elem->datalen > ie + ie_len))
+		return 0;
 
-	/* copy subelement as we need to change its content to
-	 * mark an ie after it is processed.
-	 */
-	sub_copy = kmemdup(subelement, subie_len, gfp);
-	if (!sub_copy)
+	if (elem->datalen + 2 > buf + buf_len - *pos)
 		return 0;
 
-	pos = &new_ie[0];
+	memcpy(*pos, elem, elem->datalen + 2);
+	*pos += elem->datalen + 2;
 
-	/* set new ssid */
-	tmp_new = cfg80211_find_ie(WLAN_EID_SSID, sub_copy, subie_len);
-	if (tmp_new) {
-		memcpy(pos, tmp_new, tmp_new[1] + 2);
-		pos += (tmp_new[1] + 2);
+	/* Finish if it is not fragmented  */
+	if (elem->datalen != 255)
+		return *pos - buf;
+
+	ie_len = ie + ie_len - elem->data - elem->datalen;
+	ie = (const u8 *)elem->data + elem->datalen;
+
+	for_each_element(elem, ie, ie_len) {
+		if (elem->id != WLAN_EID_FRAGMENT)
+			break;
+
+		if (elem->datalen + 2 > buf + buf_len - *pos)
+			return 0;
+
+		memcpy(*pos, elem, elem->datalen + 2);
+		*pos += elem->datalen + 2;
+
+		if (elem->datalen != 255)
+			break;
 	}
 
-	/* get non inheritance list if exists */
-	non_inherit_elem =
-		cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-				       sub_copy, subie_len);
+	return *pos - buf;
+}
 
-	/* go through IEs in ie (skip SSID) and subelement,
-	 * merge them into new_ie
+static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
+				  const u8 *subie, size_t subie_len,
+				  u8 *new_ie, size_t new_ie_len)
+{
+	const struct element *non_inherit_elem, *parent, *sub;
+	u8 *pos = new_ie;
+	u8 id, ext_id;
+	unsigned int match_len;
+
+	non_inherit_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+						  subie, subie_len);
+
+	/* We copy the elements one by one from the parent to the generated
+	 * elements.
+	 * If they are not inherited (included in subie or in the non
+	 * inheritance element), then we copy all occurrences the first time
+	 * we see this element type.
 	 */
-	tmp_old = cfg80211_find_ie(WLAN_EID_SSID, ie, ielen);
-	tmp_old = (tmp_old) ? tmp_old + tmp_old[1] + 2 : ie;
-
-	while (tmp_old + 2 - ie <= ielen &&
-	       tmp_old + tmp_old[1] + 2 - ie <= ielen) {
-		if (tmp_old[0] == 0) {
-			tmp_old++;
+	for_each_element(parent, ie, ielen) {
+		if (parent->id == WLAN_EID_FRAGMENT)
 			continue;
+
+		if (parent->id == WLAN_EID_EXTENSION) {
+			if (parent->datalen < 1)
+				continue;
+
+			id = WLAN_EID_EXTENSION;
+			ext_id = parent->data[0];
+			match_len = 1;
+		} else {
+			id = parent->id;
+			match_len = 0;
 		}
 
-		if (tmp_old[0] == WLAN_EID_EXTENSION)
-			tmp = (u8 *)cfg80211_find_ext_ie(tmp_old[2], sub_copy,
-							 subie_len);
-		else
-			tmp = (u8 *)cfg80211_find_ie(tmp_old[0], sub_copy,
-						     subie_len);
+		/* Find first occurrence in subie */
+		sub = cfg80211_find_elem_match(id, subie, subie_len,
+					       &ext_id, match_len, 0);
 
-		if (!tmp) {
-			const struct element *old_elem = (void *)tmp_old;
+		/* Copy from parent if not in subie and inherited */
+		if (!sub &&
+		    cfg80211_is_element_inherited(parent, non_inherit_elem)) {
+			if (!cfg80211_copy_elem_with_frags(parent,
+							   ie, ielen,
+							   &pos, new_ie,
+							   new_ie_len))
+				return 0;
 
-			/* ie in old ie but not in subelement */
-			if (cfg80211_is_element_inherited(old_elem,
-							  non_inherit_elem)) {
-				memcpy(pos, tmp_old, tmp_old[1] + 2);
-				pos += tmp_old[1] + 2;
-			}
-		} else {
-			/* ie in transmitting ie also in subelement,
-			 * copy from subelement and flag the ie in subelement
-			 * as copied (by setting eid field to WLAN_EID_SSID,
-			 * which is skipped anyway).
-			 * For vendor ie, compare OUI + type + subType to
-			 * determine if they are the same ie.
-			 */
-			if (tmp_old[0] == WLAN_EID_VENDOR_SPECIFIC) {
-				if (tmp_old[1] >= 5 && tmp[1] >= 5 &&
-				    !memcmp(tmp_old + 2, tmp + 2, 5)) {
-					/* same vendor ie, copy from
-					 * subelement
-					 */
-					memcpy(pos, tmp, tmp[1] + 2);
-					pos += tmp[1] + 2;
-					tmp[0] = WLAN_EID_SSID;
-				} else {
-					memcpy(pos, tmp_old, tmp_old[1] + 2);
-					pos += tmp_old[1] + 2;
-				}
-			} else {
-				/* copy ie from subelement into new ie */
-				memcpy(pos, tmp, tmp[1] + 2);
-				pos += tmp[1] + 2;
-				tmp[0] = WLAN_EID_SSID;
-			}
+			continue;
 		}
 
-		if (tmp_old + tmp_old[1] + 2 - ie == ielen)
-			break;
+		/* Already copied if an earlier element had the same type */
+		if (cfg80211_find_elem_match(id, ie, (u8 *)parent - ie,
+					     &ext_id, match_len, 0))
+			continue;
 
-		tmp_old += tmp_old[1] + 2;
+		/* Not inheriting, copy all similar elements from subie */
+		while (sub) {
+			if (!cfg80211_copy_elem_with_frags(sub,
+							   subie, subie_len,
+							   &pos, new_ie,
+							   new_ie_len))
+				return 0;
+
+			sub = cfg80211_find_elem_match(id,
+						       sub->data + sub->datalen,
+						       subie_len + subie -
+						       (sub->data +
+							sub->datalen),
+						       &ext_id, match_len, 0);
+		}
 	}
 
-	/* go through subelement again to check if there is any ie not
-	 * copied to new ie, skip ssid, capability, bssid-index ie
+	/* The above misses elements that are included in subie but not in the
+	 * parent, so do a pass over subie and append those.
+	 * Skip the non-tx BSSID caps and non-inheritance element.
 	 */
-	tmp_new = sub_copy;
-	while (tmp_new + 2 - sub_copy <= subie_len &&
-	       tmp_new + tmp_new[1] + 2 - sub_copy <= subie_len) {
-		if (!(tmp_new[0] == WLAN_EID_NON_TX_BSSID_CAP ||
-		      tmp_new[0] == WLAN_EID_SSID)) {
-			memcpy(pos, tmp_new, tmp_new[1] + 2);
-			pos += tmp_new[1] + 2;
+	for_each_element(sub, subie, subie_len) {
+		if (sub->id == WLAN_EID_NON_TX_BSSID_CAP)
+			continue;
+
+		if (sub->id == WLAN_EID_FRAGMENT)
+			continue;
+
+		if (sub->id == WLAN_EID_EXTENSION) {
+			if (sub->datalen < 1)
+				continue;
+
+			id = WLAN_EID_EXTENSION;
+			ext_id = sub->data[0];
+			match_len = 1;
+
+			if (ext_id == WLAN_EID_EXT_NON_INHERITANCE)
+				continue;
+		} else {
+			id = sub->id;
+			match_len = 0;
 		}
-		if (tmp_new + tmp_new[1] + 2 - sub_copy == subie_len)
-			break;
-		tmp_new += tmp_new[1] + 2;
+
+		/* Processed if one was included in the parent */
+		if (cfg80211_find_elem_match(id, ie, ielen,
+					     &ext_id, match_len, 0))
+			continue;
+
+		if (!cfg80211_copy_elem_with_frags(sub, subie, subie_len,
+						   &pos, new_ie, new_ie_len))
+			return 0;
 	}
 
-	kfree(sub_copy);
 	return pos - new_ie;
 }
 
@@ -2170,7 +2205,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 			new_ie_len = cfg80211_gen_new_ie(ie, ielen,
 							 profile,
 							 profile_len, new_ie,
-							 gfp);
+							 IEEE80211_MAX_DATA_LEN);
 			if (!new_ie_len)
 				continue;
 
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 76a80a41615b..a57f54bc0e1a 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -796,6 +796,12 @@ static int ioctl_standard_iw_point(struct iw_point *iwp, unsigned int cmd,
 		}
 	}
 
+	/* Sanity-check to ensure we never end up _allocating_ zero
+	 * bytes of data for extra.
+	 */
+	if (extra_size <= 0)
+		return -EFAULT;
+
 	/* kzalloc() ensures NULL-termination for essid_compat. */
 	extra = kzalloc(extra_size, GFP_KERNEL);
 	if (!extra)
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 691841dc6d33..d04f91f4d09d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -667,6 +667,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct net_device *dev;
+	int bound_dev_if;
 	u32 flags, qid;
 	int err = 0;
 
@@ -680,6 +681,10 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		      XDP_USE_NEED_WAKEUP))
 		return -EINVAL;
 
+	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+	if (bound_dev_if && bound_dev_if != sxdp->sxdp_ifindex)
+		return -EINVAL;
+
 	rtnl_lock();
 	mutex_lock(&xs->mutex);
 	if (xs->state != XSK_READY) {
diff --git a/samples/bpf/tcp_basertt_kern.c b/samples/bpf/tcp_basertt_kern.c
index 8dfe09a92fec..822b0742b815 100644
--- a/samples/bpf/tcp_basertt_kern.c
+++ b/samples/bpf/tcp_basertt_kern.c
@@ -47,7 +47,7 @@ int bpf_basertt(struct bpf_sock_ops *skops)
 		case BPF_SOCK_OPS_BASE_RTT:
 			n = bpf_getsockopt(skops, SOL_TCP, TCP_CONGESTION,
 					   cong, sizeof(cong));
-			if (!n && !__builtin_memcmp(cong, nv, sizeof(nv)+1)) {
+			if (!n && !__builtin_memcmp(cong, nv, sizeof(nv))) {
 				/* Set base_rtt to 80us */
 				rv = 80;
 			} else if (n) {
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 3927cb880d1a..4bdd67916ce4 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -4,14 +4,14 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 
-extern void my_direct_func(struct vm_area_struct *vma,
-			   unsigned long address, unsigned int flags);
+extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+			   unsigned int flags, struct pt_regs *regs);
 
-void my_direct_func(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+		    unsigned int flags, struct pt_regs *regs)
 {
-	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
-		     vma, address, flags);
+	trace_printk("handle mm fault vma=%p address=%lx flags=%x regs=%p\n",
+		     vma, address, flags, regs);
 }
 
 extern void my_tramp(void *);
@@ -26,7 +26,9 @@ asm (
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
+"	pushq %rcx\n"
 "	call my_direct_func\n"
+"	popq %rcx\n"
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e48742760fec..78ac98cfa02d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1313,6 +1313,10 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 	if (relsym->st_name != 0)
 		return relsym;
 
+	/*
+	 * Strive to find a better symbol name, but the resulting name may not
+	 * match the symbol referenced in the original code.
+	 */
 	relsym_secindex = get_secindex(elf, relsym);
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != relsym_secindex)
@@ -1617,7 +1621,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 static int is_executable_section(struct elf_info* elf, unsigned int section_index)
 {
-	if (section_index > elf->num_sections)
+	if (section_index >= elf->num_sections)
 		fatal("section_index is outside elf->num_sections!\n");
 
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
@@ -1792,19 +1796,33 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define	R_ARM_THM_JUMP19	51
 #endif
 
+static int32_t sign_extend32(int32_t value, int index)
+{
+	uint8_t shift = 31 - index;
+
+	return (int32_t)(value << shift) >> shift;
+}
+
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
+	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
+	void *loc = reloc_location(elf, sechdr, r);
+	uint32_t inst;
+	int32_t offset;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
-		/* From ARM ABI: (S + A) | T */
-		r->r_addend = (int)(long)
-			      (elf->symtab_start + ELF_R_SYM(r->r_info));
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		r->r_addend = inst + sym->st_value;
 		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		offset = sign_extend32((inst & 0x00ffffff) << 2, 25);
+		r->r_addend = offset + sym->st_value + 8;
+		break;
 	case R_ARM_THM_CALL:
 	case R_ARM_THM_JUMP24:
 	case R_ARM_THM_JUMP19:
diff --git a/scripts/tags.sh b/scripts/tags.sh
index b82aebb0c995..d17801c9d85a 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -32,6 +32,13 @@ else
 	ignore="$ignore ( -path ${tree}tools ) -prune -o"
 fi
 
+# gtags(1) refuses to index any file outside of its current working dir.
+# If gtags indexing is requested and the build output directory is not
+# the kernel source tree, index all files in absolute-path form.
+if [[ "$1" == "gtags" && -n "${tree}" ]]; then
+	tree=$(realpath "$tree")/
+fi
+
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -131,7 +138,7 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	all_target_sources | gtags -i -C "${tree:-.}" -f - "$PWD"
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 519656e68582..10896d69c442 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -909,8 +909,13 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 				goto fail;
 			}
 
-			rhashtable_insert_fast(profile->data, &data->head,
-					       profile->data->p);
+			if (rhashtable_insert_fast(profile->data, &data->head,
+						   profile->data->p)) {
+				kfree_sensitive(data->key);
+				kfree_sensitive(data);
+				info = "failed to insert data to table";
+				goto fail;
+			}
 		}
 
 		if (!unpack_nameX(e, AA_STRUCTEND, NULL)) {
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0033364ac404..8cfc49fa4df5 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -472,7 +472,9 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
+ * @attr: iattr structure containing the new file attributes
  *
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 0ba01847e836..9ed2d5bfbed5 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -43,12 +43,10 @@ static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
 		else if (inode > iint->inode)
 			n = n->rb_right;
 		else
-			break;
+			return iint;
 	}
-	if (!n)
-		return NULL;
 
-	return iint;
+	return NULL;
 }
 
 /*
@@ -121,10 +119,15 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 		parent = *p;
 		test_iint = rb_entry(parent, struct integrity_iint_cache,
 				     rb_node);
-		if (inode < test_iint->inode)
+		if (inode < test_iint->inode) {
 			p = &(*p)->rb_left;
-		else
+		} else if (inode > test_iint->inode) {
 			p = &(*p)->rb_right;
+		} else {
+			write_unlock(&integrity_iint_lock);
+			kmem_cache_free(iint_cache, iint);
+			return test_iint;
+		}
 	}
 
 	iint->inode = inode;
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index fb25723c65bc..3e7bee30080f 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -89,6 +89,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 /**
  * ima_collect_modsig - Calculate the file hash without the appended signature.
+ * @modsig: parsed module signature
+ * @buf: data to verify the signature on
+ * @size: data size
  *
  * Since the modsig is part of the file contents, the hash used in its signature
  * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 96ecb7d25403..1c403e8a8044 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -628,6 +628,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @secid: LSM secid of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @keyring: the keyring name, if given, to be used to check in the policy.
@@ -1515,7 +1516,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
- * @rule - ima measurement policy rule
+ * @rule: ima measurement policy rule
  *
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 07a0ef2baacd..a7673ad86d18 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -401,17 +401,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
 
 	if (dest_keyring) {
-		ret = __key_link_lock(dest_keyring, &ctx->index_key);
+		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
-		ret = __key_link_begin(dest_keyring, &ctx->index_key, &edit);
-		if (ret < 0)
-			goto link_prealloc_failed;
 	}
 
-	/* attach the key to the destination keyring under lock, but we do need
+	/*
+	 * Attach the key to the destination keyring under lock, but we do need
 	 * to do another check just in case someone beat us to it whilst we
-	 * waited for locks */
+	 * waited for locks.
+	 *
+	 * The caller might specify a comparison function which looks for keys
+	 * that do not exactly match but are still equivalent from the caller's
+	 * perspective. The __key_link_begin() operation must be done only after
+	 * an actual key is determined.
+	 */
 	mutex_lock(&key_construction_mutex);
 
 	rcu_read_lock();
@@ -420,12 +424,16 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (!IS_ERR(key_ref))
 		goto key_already_present;
 
-	if (dest_keyring)
+	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed;
 		__key_link(dest_keyring, key, &edit);
+	}
 
 	mutex_unlock(&key_construction_mutex);
 	if (dest_keyring)
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
 	kleave(" = 0 [%d]", key_serial(key));
@@ -438,10 +446,13 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	mutex_unlock(&key_construction_mutex);
 	key = key_ref_to_ptr(key_ref);
 	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed_unlocked;
 		ret = __key_link_check_live_key(dest_keyring, key);
 		if (ret == 0)
 			__key_link(dest_keyring, key, &edit);
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto link_check_failed;
 	}
@@ -456,8 +467,10 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	kleave(" = %d [linkcheck]", ret);
 	return ret;
 
-link_prealloc_failed:
-	__key_link_end(dest_keyring, &ctx->index_key, edit);
+link_alloc_failed:
+	mutex_unlock(&key_construction_mutex);
+link_alloc_failed_unlocked:
+	__key_link_end(dest_keyring, &key->index_key, edit);
 link_lock_failed:
 	mutex_unlock(&user->cons_lock);
 	key_put(key);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 4c19d3abddbe..65f68856414a 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -21,7 +21,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 };
 
 /**
- * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
+ * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
  * @buf: an allocated tpm_buf instance
  * @session_handle: session handle
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 45e28db6ea38..8a9baa084191 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -364,6 +364,7 @@ void snd_jack_report(struct snd_jack *jack, int status)
 {
 	struct snd_jack_kctl *jack_kctl;
 #ifdef CONFIG_SND_JACK_INPUT_DEV
+	struct input_dev *idev;
 	int i;
 #endif
 
@@ -375,30 +376,28 @@ void snd_jack_report(struct snd_jack *jack, int status)
 					    status & jack_kctl->mask_bits);
 
 #ifdef CONFIG_SND_JACK_INPUT_DEV
-	mutex_lock(&jack->input_dev_lock);
-	if (!jack->input_dev) {
-		mutex_unlock(&jack->input_dev_lock);
+	idev = input_get_device(jack->input_dev);
+	if (!idev)
 		return;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(jack->key); i++) {
 		int testbit = SND_JACK_BTN_0 >> i;
 
 		if (jack->type & testbit)
-			input_report_key(jack->input_dev, jack->key[i],
+			input_report_key(idev, jack->key[i],
 					 status & testbit);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++) {
 		int testbit = 1 << i;
 		if (jack->type & testbit)
-			input_report_switch(jack->input_dev,
+			input_report_switch(idev,
 					    jack_switch_types[i],
 					    status & testbit);
 	}
 
-	input_sync(jack->input_dev);
-	mutex_unlock(&jack->input_dev_lock);
+	input_sync(idev);
+	input_put_device(idev);
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 }
 EXPORT_SYMBOL(snd_jack_report);
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index cd66632bf1c3..e18572eae5e0 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2007,8 +2007,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		.dev_disconnect =	snd_ac97_dev_disconnect,
 	};
 
-	if (rac97)
-		*rac97 = NULL;
+	if (!rac97)
+		return -EINVAL;
 	if (snd_BUG_ON(!bus || !template))
 		return -EINVAL;
 	if (snd_BUG_ON(template->num >= 4))
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7d6a36b647a7..6bfc7e28515a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -121,6 +121,7 @@ struct alc_spec {
 	unsigned int ultra_low_power:1;
 	unsigned int has_hs_key:1;
 	unsigned int no_internal_mic_pin:1;
+	unsigned int en_3kpull_low:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -3617,6 +3618,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	if (!hp_pin)
 		hp_pin = 0x21;
 
+	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x1); /* Low power */
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
 	if (hp_pin_sense)
@@ -3633,8 +3635,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
 	 * when booting with headset plugged. So skip setting it for the codec alc257
 	 */
-	if (codec->core.vendor_id != 0x10ec0236 &&
-	    codec->core.vendor_id != 0x10ec0257)
+	if (spec->en_3kpull_low)
 		alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
 	if (!spec->no_shutup_pins)
@@ -4558,6 +4559,21 @@ static void alc236_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
 	}
 }
 
+static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x07;
+		spec->mute_led_coef.mask = 1;
+		spec->mute_led_coef.on = 1;
+		spec->mute_led_coef.off = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -6877,6 +6893,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
+	ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
@@ -8249,6 +8266,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_mute_led,
 	},
+	[ALC236_FIXUP_HP_MUTE_LED_COEFBIT2] = {
+	    .type = HDA_FIXUP_FUNC,
+	    .v.func = alc236_fixup_hp_mute_led_coefbit2,
+	},
 	[ALC236_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_gpio_led,
@@ -9003,6 +9024,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
@@ -10065,6 +10087,8 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
+		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = true;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index bc3d46617a11..03ad34a275da 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -52,7 +52,12 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(dac_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_max_gain_tlv, -650, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_min_gain_tlv, -1200, 150, 0);
-static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_target_tlv, -1650, 150, 0);
+
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(alc_target_tlv,
+	0, 10, TLV_DB_SCALE_ITEM(-1650, 150, 0),
+	11, 11, TLV_DB_SCALE_ITEM(-150, 0, 0),
+);
+
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpmixer_gain_tlv,
 	0, 4, TLV_DB_SCALE_ITEM(-1200, 150, 0),
 	8, 11, TLV_DB_SCALE_ITEM(-450, 150, 0),
@@ -115,7 +120,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 		       alc_max_gain_tlv),
 	SOC_SINGLE_TLV("ALC Capture Min Volume", ES8316_ADC_ALC2, 0, 28, 0,
 		       alc_min_gain_tlv),
-	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 10, 0,
+	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 11, 0,
 		       alc_target_tlv),
 	SOC_SINGLE("ALC Capture Hold Time", ES8316_ADC_ALC3, 0, 10, 0),
 	SOC_SINGLE("ALC Capture Decay Time", ES8316_ADC_ALC4, 4, 10, 0),
@@ -364,13 +369,11 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	int count = 0;
 
 	es8316->sysclk = freq;
+	es8316->sysclk_constraints.list = NULL;
+	es8316->sysclk_constraints.count = 0;
 
-	if (freq == 0) {
-		es8316->sysclk_constraints.list = NULL;
-		es8316->sysclk_constraints.count = 0;
-
+	if (freq == 0)
 		return 0;
-	}
 
 	ret = clk_set_rate(es8316->mclk, freq);
 	if (ret)
@@ -386,8 +389,10 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 			es8316->allowed_rates[count++] = freq / ratio;
 	}
 
-	es8316->sysclk_constraints.list = es8316->allowed_rates;
-	es8316->sysclk_constraints.count = count;
+	if (count) {
+		es8316->sysclk_constraints.list = es8316->allowed_rates;
+		es8316->sysclk_constraints.count = count;
+	}
 
 	return 0;
 }
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 6a5d2b08e271..03731d14d475 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -552,7 +552,7 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	u32 xcsr, count = 100;
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
-			   FSL_SAI_CSR_TERE, 0);
+			   FSL_SAI_CSR_TERE | FSL_SAI_CSR_BCE, 0);
 
 	/* TERE will remain set till the end of current frame */
 	do {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 8923c680f0e0..691847d54b17 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -87,6 +87,7 @@
 /* SAI Transmit/Receive Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
 #define FSL_SAI_CSR_SE		BIT(30)
+#define FSL_SAI_CSR_BCE		BIT(28)
 #define FSL_SAI_CSR_FR		BIT(25)
 #define FSL_SAI_CSR_SR		BIT(24)
 #define FSL_SAI_CSR_xF_SHIFT	16
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index cbdc0a2c09c5..77d8234c7ac4 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -230,6 +230,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 
 		dai_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
 					  fe_name_pref, args.np->full_name + 1);
+		if (!dai_name)
+			return -ENOMEM;
 
 		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
 
@@ -238,6 +240,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 			capture_dai_name =
 				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
 					       dai_name, "CPU-Capture");
+			if (!capture_dai_name)
+				return -ENOMEM;
 		}
 
 		priv->dai[i].cpus = &dlc[0];
@@ -268,6 +272,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 				       "AUDMIX-Playback-%d", i);
 		be_cp = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 				       "AUDMIX-Capture-%d", i);
+		if (!be_name || !be_pb || !be_cp)
+			return -ENOMEM;
 
 		priv->dai[num_dai + i].cpus = &dlc[3];
 		priv->dai[num_dai + i].codecs = &dlc[4];
@@ -295,6 +301,9 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		priv->dapm_routes[i].source =
 			devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
 				       dai_name, "CPU-Playback");
+		if (!priv->dapm_routes[i].source)
+			return -ENOMEM;
+
 		priv->dapm_routes[i].sink = be_pb;
 		priv->dapm_routes[num_dai + i].source   = be_pb;
 		priv->dapm_routes[num_dai + i].sink     = be_cp;
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 619d6733091c..3f6d9659ee95 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1072,6 +1072,10 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	afe->dev = &pdev->dev;
 
+	irq_id = platform_get_irq(pdev, 0);
+	if (irq_id <= 0)
+		return irq_id < 0 ? irq_id : -ENXIO;
+
 	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(afe->base_addr))
 		return PTR_ERR(afe->base_addr);
@@ -1158,14 +1162,14 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	comp_hdmi = devm_kzalloc(&pdev->dev, sizeof(*comp_hdmi), GFP_KERNEL);
 	if (!comp_hdmi) {
 		ret = -ENOMEM;
-		goto err_pm_disable;
+		goto err_cleanup_components;
 	}
 
 	ret = snd_soc_component_initialize(comp_hdmi,
 					   &mt8173_afe_hdmi_dai_component,
 					   &pdev->dev);
 	if (ret)
-		goto err_pm_disable;
+		goto err_cleanup_components;
 
 #ifdef CONFIG_DEBUG_FS
 	comp_hdmi->debugfs_prefix = "hdmi";
@@ -1177,14 +1181,11 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_components;
 
-	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0)
-		return irq_id < 0 ? irq_id : -ENXIO;
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
 	if (ret) {
 		dev_err(afe->dev, "could not request_irq\n");
-		goto err_pm_disable;
+		goto err_cleanup_components;
 	}
 
 	dev_info(&pdev->dev, "MT8173 AFE driver initialized.\n");
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 359960a8f1de..5f0b1397798e 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -135,12 +135,12 @@ static void print_end_section(void)
 
 /* Probing functions */
 
-static int read_procfs(const char *path)
+static long read_procfs(const char *path)
 {
 	char *endptr, *line = NULL;
 	size_t len = 0;
 	FILE *fd;
-	int res;
+	long res;
 
 	fd = fopen(path, "r");
 	if (!fd)
@@ -162,7 +162,7 @@ static int read_procfs(const char *path)
 
 static void probe_unprivileged_disabled(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -181,14 +181,14 @@ static void probe_unprivileged_disabled(void)
 			printf("Unable to retrieve required privileges for bpf() syscall\n");
 			break;
 		default:
-			printf("bpf() syscall restriction has unknown value %d\n", res);
+			printf("bpf() syscall restriction has unknown value %ld\n", res);
 		}
 	}
 }
 
 static void probe_jit_enable(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -210,7 +210,7 @@ static void probe_jit_enable(void)
 			printf("Unable to retrieve JIT-compiler status\n");
 			break;
 		default:
-			printf("JIT-compiler status has unknown value %d\n",
+			printf("JIT-compiler status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -218,7 +218,7 @@ static void probe_jit_enable(void)
 
 static void probe_jit_harden(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -240,7 +240,7 @@ static void probe_jit_harden(void)
 			printf("Unable to retrieve JIT hardening status\n");
 			break;
 		default:
-			printf("JIT hardening status has unknown value %d\n",
+			printf("JIT hardening status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -248,7 +248,7 @@ static void probe_jit_harden(void)
 
 static void probe_jit_kallsyms(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -267,14 +267,14 @@ static void probe_jit_kallsyms(void)
 			printf("Unable to retrieve JIT kallsyms export status\n");
 			break;
 		default:
-			printf("JIT kallsyms exports status has unknown value %d\n", res);
+			printf("JIT kallsyms exports status has unknown value %ld\n", res);
 		}
 	}
 }
 
 static void probe_jit_limit(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -287,7 +287,7 @@ static void probe_jit_limit(void)
 			printf("Unable to retrieve global memory limit for JIT compiler for unprivileged users\n");
 			break;
 		default:
-			printf("Global memory limit for JIT compiler for unprivileged users is %d bytes\n", res);
+			printf("Global memory limit for JIT compiler for unprivileged users is %ld bytes\n", res);
 		}
 	}
 }
diff --git a/tools/include/uapi/linux/tcp.h b/tools/include/uapi/linux/tcp.h
new file mode 100644
index 000000000000..13ceeb395eb8
--- /dev/null
+++ b/tools/include/uapi/linux/tcp.h
@@ -0,0 +1,357 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		Definitions for the TCP protocol.
+ *
+ * Version:	@(#)tcp.h	1.0.2	04/28/93
+ *
+ * Author:	Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+#ifndef _UAPI_LINUX_TCP_H
+#define _UAPI_LINUX_TCP_H
+
+#include <linux/types.h>
+#include <asm/byteorder.h>
+#include <linux/socket.h>
+
+struct tcphdr {
+	__be16	source;
+	__be16	dest;
+	__be32	seq;
+	__be32	ack_seq;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u16	res1:4,
+		doff:4,
+		fin:1,
+		syn:1,
+		rst:1,
+		psh:1,
+		ack:1,
+		urg:1,
+		ece:1,
+		cwr:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u16	doff:4,
+		res1:4,
+		cwr:1,
+		ece:1,
+		urg:1,
+		ack:1,
+		psh:1,
+		rst:1,
+		syn:1,
+		fin:1;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif	
+	__be16	window;
+	__sum16	check;
+	__be16	urg_ptr;
+};
+
+/*
+ *	The union cast uses a gcc extension to avoid aliasing problems
+ *  (union is compatible to any of its members)
+ *  This means this part of the code is -fstrict-aliasing safe now.
+ */
+union tcp_word_hdr { 
+	struct tcphdr hdr;
+	__be32 		  words[5];
+}; 
+
+#define tcp_flag_word(tp) ( ((union tcp_word_hdr *)(tp))->words [3]) 
+
+enum { 
+	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
+	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
+	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
+	TCP_FLAG_ACK = __constant_cpu_to_be32(0x00100000),
+	TCP_FLAG_PSH = __constant_cpu_to_be32(0x00080000),
+	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
+	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
+	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
+	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
+	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
+}; 
+
+/*
+ * TCP general constants
+ */
+#define TCP_MSS_DEFAULT		 536U	/* IPv4 (RFC1122, RFC2581) */
+#define TCP_MSS_DESIRED		1220U	/* IPv6 (tunneled), EDNS0 (RFC3226) */
+
+/* TCP socket options */
+#define TCP_NODELAY		1	/* Turn off Nagle's algorithm. */
+#define TCP_MAXSEG		2	/* Limit MSS */
+#define TCP_CORK		3	/* Never send partially complete segments */
+#define TCP_KEEPIDLE		4	/* Start keeplives after this period */
+#define TCP_KEEPINTVL		5	/* Interval between keepalives */
+#define TCP_KEEPCNT		6	/* Number of keepalives before death */
+#define TCP_SYNCNT		7	/* Number of SYN retransmits */
+#define TCP_LINGER2		8	/* Life time of orphaned FIN-WAIT-2 state */
+#define TCP_DEFER_ACCEPT	9	/* Wake up listener only when data arrive */
+#define TCP_WINDOW_CLAMP	10	/* Bound advertised window */
+#define TCP_INFO		11	/* Information about this connection. */
+#define TCP_QUICKACK		12	/* Block/reenable quick acks */
+#define TCP_CONGESTION		13	/* Congestion control algorithm */
+#define TCP_MD5SIG		14	/* TCP MD5 Signature (RFC2385) */
+#define TCP_THIN_LINEAR_TIMEOUTS 16      /* Use linear timeouts for thin streams*/
+#define TCP_THIN_DUPACK         17      /* Fast retrans. after 1 dupack */
+#define TCP_USER_TIMEOUT	18	/* How long for loss retry before timeout */
+#define TCP_REPAIR		19	/* TCP sock is under repair right now */
+#define TCP_REPAIR_QUEUE	20
+#define TCP_QUEUE_SEQ		21
+#define TCP_REPAIR_OPTIONS	22
+#define TCP_FASTOPEN		23	/* Enable FastOpen on listeners */
+#define TCP_TIMESTAMP		24
+#define TCP_NOTSENT_LOWAT	25	/* limit number of unsent bytes in write queue */
+#define TCP_CC_INFO		26	/* Get Congestion Control (optional) info */
+#define TCP_SAVE_SYN		27	/* Record SYN headers for new connections */
+#define TCP_SAVED_SYN		28	/* Get SYN headers recorded for connection */
+#define TCP_REPAIR_WINDOW	29	/* Get/set window parameters */
+#define TCP_FASTOPEN_CONNECT	30	/* Attempt FastOpen with connect */
+#define TCP_ULP			31	/* Attach a ULP to a TCP connection */
+#define TCP_MD5SIG_EXT		32	/* TCP MD5 Signature with extensions */
+#define TCP_FASTOPEN_KEY	33	/* Set the key for Fast Open (cookie) */
+#define TCP_FASTOPEN_NO_COOKIE	34	/* Enable TFO without a TFO cookie */
+#define TCP_ZEROCOPY_RECEIVE	35
+#define TCP_INQ			36	/* Notify bytes available to read as a cmsg on read */
+
+#define TCP_CM_INQ		TCP_INQ
+
+#define TCP_TX_DELAY		37	/* delay outgoing packets by XX usec */
+
+
+#define TCP_REPAIR_ON		1
+#define TCP_REPAIR_OFF		0
+#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
+
+struct tcp_repair_opt {
+	__u32	opt_code;
+	__u32	opt_val;
+};
+
+struct tcp_repair_window {
+	__u32	snd_wl1;
+	__u32	snd_wnd;
+	__u32	max_window;
+
+	__u32	rcv_wnd;
+	__u32	rcv_wup;
+};
+
+enum {
+	TCP_NO_QUEUE,
+	TCP_RECV_QUEUE,
+	TCP_SEND_QUEUE,
+	TCP_QUEUES_NR,
+};
+
+/* why fastopen failed from client perspective */
+enum tcp_fastopen_client_fail {
+	TFO_STATUS_UNSPEC, /* catch-all */
+	TFO_COOKIE_UNAVAILABLE, /* if not in TFO_CLIENT_NO_COOKIE mode */
+	TFO_DATA_NOT_ACKED, /* SYN-ACK did not ack SYN data */
+	TFO_SYN_RETRANSMITTED, /* SYN-ACK did not ack SYN data after timeout */
+};
+
+/* for TCP_INFO socket option */
+#define TCPI_OPT_TIMESTAMPS	1
+#define TCPI_OPT_SACK		2
+#define TCPI_OPT_WSCALE		4
+#define TCPI_OPT_ECN		8 /* ECN was negociated at TCP session init */
+#define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
+#define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
+
+/*
+ * Sender's congestion state indicating normal or abnormal situations
+ * in the last round of packets sent. The state is driven by the ACK
+ * information and timer events.
+ */
+enum tcp_ca_state {
+	/*
+	 * Nothing bad has been observed recently.
+	 * No apparent reordering, packet loss, or ECN marks.
+	 */
+	TCP_CA_Open = 0,
+#define TCPF_CA_Open	(1<<TCP_CA_Open)
+	/*
+	 * The sender enters disordered state when it has received DUPACKs or
+	 * SACKs in the last round of packets sent. This could be due to packet
+	 * loss or reordering but needs further information to confirm packets
+	 * have been lost.
+	 */
+	TCP_CA_Disorder = 1,
+#define TCPF_CA_Disorder (1<<TCP_CA_Disorder)
+	/*
+	 * The sender enters Congestion Window Reduction (CWR) state when it
+	 * has received ACKs with ECN-ECE marks, or has experienced congestion
+	 * or packet discard on the sender host (e.g. qdisc).
+	 */
+	TCP_CA_CWR = 2,
+#define TCPF_CA_CWR	(1<<TCP_CA_CWR)
+	/*
+	 * The sender is in fast recovery and retransmitting lost packets,
+	 * typically triggered by ACK events.
+	 */
+	TCP_CA_Recovery = 3,
+#define TCPF_CA_Recovery (1<<TCP_CA_Recovery)
+	/*
+	 * The sender is in loss recovery triggered by retransmission timeout.
+	 */
+	TCP_CA_Loss = 4
+#define TCPF_CA_Loss	(1<<TCP_CA_Loss)
+};
+
+struct tcp_info {
+	__u8	tcpi_state;
+	__u8	tcpi_ca_state;
+	__u8	tcpi_retransmits;
+	__u8	tcpi_probes;
+	__u8	tcpi_backoff;
+	__u8	tcpi_options;
+	__u8	tcpi_snd_wscale : 4, tcpi_rcv_wscale : 4;
+	__u8	tcpi_delivery_rate_app_limited:1, tcpi_fastopen_client_fail:2;
+
+	__u32	tcpi_rto;
+	__u32	tcpi_ato;
+	__u32	tcpi_snd_mss;
+	__u32	tcpi_rcv_mss;
+
+	__u32	tcpi_unacked;
+	__u32	tcpi_sacked;
+	__u32	tcpi_lost;
+	__u32	tcpi_retrans;
+	__u32	tcpi_fackets;
+
+	/* Times. */
+	__u32	tcpi_last_data_sent;
+	__u32	tcpi_last_ack_sent;     /* Not remembered, sorry. */
+	__u32	tcpi_last_data_recv;
+	__u32	tcpi_last_ack_recv;
+
+	/* Metrics. */
+	__u32	tcpi_pmtu;
+	__u32	tcpi_rcv_ssthresh;
+	__u32	tcpi_rtt;
+	__u32	tcpi_rttvar;
+	__u32	tcpi_snd_ssthresh;
+	__u32	tcpi_snd_cwnd;
+	__u32	tcpi_advmss;
+	__u32	tcpi_reordering;
+
+	__u32	tcpi_rcv_rtt;
+	__u32	tcpi_rcv_space;
+
+	__u32	tcpi_total_retrans;
+
+	__u64	tcpi_pacing_rate;
+	__u64	tcpi_max_pacing_rate;
+	__u64	tcpi_bytes_acked;    /* RFC4898 tcpEStatsAppHCThruOctetsAcked */
+	__u64	tcpi_bytes_received; /* RFC4898 tcpEStatsAppHCThruOctetsReceived */
+	__u32	tcpi_segs_out;	     /* RFC4898 tcpEStatsPerfSegsOut */
+	__u32	tcpi_segs_in;	     /* RFC4898 tcpEStatsPerfSegsIn */
+
+	__u32	tcpi_notsent_bytes;
+	__u32	tcpi_min_rtt;
+	__u32	tcpi_data_segs_in;	/* RFC4898 tcpEStatsDataSegsIn */
+	__u32	tcpi_data_segs_out;	/* RFC4898 tcpEStatsDataSegsOut */
+
+	__u64   tcpi_delivery_rate;
+
+	__u64	tcpi_busy_time;      /* Time (usec) busy sending data */
+	__u64	tcpi_rwnd_limited;   /* Time (usec) limited by receive window */
+	__u64	tcpi_sndbuf_limited; /* Time (usec) limited by send buffer */
+
+	__u32	tcpi_delivered;
+	__u32	tcpi_delivered_ce;
+
+	__u64	tcpi_bytes_sent;     /* RFC4898 tcpEStatsPerfHCDataOctetsOut */
+	__u64	tcpi_bytes_retrans;  /* RFC4898 tcpEStatsPerfOctetsRetrans */
+	__u32	tcpi_dsack_dups;     /* RFC4898 tcpEStatsStackDSACKDups */
+	__u32	tcpi_reord_seen;     /* reordering events seen */
+
+	__u32	tcpi_rcv_ooopack;    /* Out-of-order packets received */
+
+	__u32	tcpi_snd_wnd;	     /* peer's advertised receive window after
+				      * scaling (bytes)
+				      */
+};
+
+/* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
+enum {
+	TCP_NLA_PAD,
+	TCP_NLA_BUSY,		/* Time (usec) busy sending data */
+	TCP_NLA_RWND_LIMITED,	/* Time (usec) limited by receive window */
+	TCP_NLA_SNDBUF_LIMITED,	/* Time (usec) limited by send buffer */
+	TCP_NLA_DATA_SEGS_OUT,	/* Data pkts sent including retransmission */
+	TCP_NLA_TOTAL_RETRANS,	/* Data pkts retransmitted */
+	TCP_NLA_PACING_RATE,    /* Pacing rate in bytes per second */
+	TCP_NLA_DELIVERY_RATE,  /* Delivery rate in bytes per second */
+	TCP_NLA_SND_CWND,       /* Sending congestion window */
+	TCP_NLA_REORDERING,     /* Reordering metric */
+	TCP_NLA_MIN_RTT,        /* minimum RTT */
+	TCP_NLA_RECUR_RETRANS,  /* Recurring retransmits for the current pkt */
+	TCP_NLA_DELIVERY_RATE_APP_LMT, /* delivery rate application limited ? */
+	TCP_NLA_SNDQ_SIZE,	/* Data (bytes) pending in send queue */
+	TCP_NLA_CA_STATE,	/* ca_state of socket */
+	TCP_NLA_SND_SSTHRESH,	/* Slow start size threshold */
+	TCP_NLA_DELIVERED,	/* Data pkts delivered incl. out-of-order */
+	TCP_NLA_DELIVERED_CE,	/* Like above but only ones w/ CE marks */
+	TCP_NLA_BYTES_SENT,	/* Data bytes sent including retransmission */
+	TCP_NLA_BYTES_RETRANS,	/* Data bytes retransmitted */
+	TCP_NLA_DSACK_DUPS,	/* DSACK blocks received */
+	TCP_NLA_REORD_SEEN,	/* reordering events seen */
+	TCP_NLA_SRTT,		/* smoothed RTT in usecs */
+	TCP_NLA_TIMEOUT_REHASH, /* Timeout-triggered rehash attempts */
+	TCP_NLA_BYTES_NOTSENT,	/* Bytes in write queue not yet sent */
+	TCP_NLA_EDT,		/* Earliest departure time (CLOCK_MONOTONIC) */
+};
+
+/* for TCP_MD5SIG socket option */
+#define TCP_MD5SIG_MAXKEYLEN	80
+
+/* tcp_md5sig extension flags for TCP_MD5SIG_EXT */
+#define TCP_MD5SIG_FLAG_PREFIX		0x1	/* address prefix length */
+#define TCP_MD5SIG_FLAG_IFINDEX		0x2	/* ifindex set */
+
+struct tcp_md5sig {
+	struct __kernel_sockaddr_storage tcpm_addr;	/* address associated */
+	__u8	tcpm_flags;				/* extension flags */
+	__u8	tcpm_prefixlen;				/* address prefix */
+	__u16	tcpm_keylen;				/* key length */
+	int	tcpm_ifindex;				/* device index for scope */
+	__u8	tcpm_key[TCP_MD5SIG_MAXKEYLEN];		/* key (binary) */
+};
+
+/* INET_DIAG_MD5SIG */
+struct tcp_diag_md5sig {
+	__u8	tcpm_family;
+	__u8	tcpm_prefixlen;
+	__u16	tcpm_keylen;
+	__be32	tcpm_addr[4];
+	__u8	tcpm_key[TCP_MD5SIG_MAXKEYLEN];
+};
+
+/* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
+
+#define TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT 0x1
+struct tcp_zerocopy_receive {
+	__u64 address;		/* in: address of mapping */
+	__u32 length;		/* in/out: number of bytes to map/mapped */
+	__u32 recv_skip_hint;	/* out: amount of bytes to skip */
+	__u32 inq; /* out: amount of bytes in read queue */
+	__s32 err; /* out: socket error */
+	__u64 copybuf_address;	/* in: copybuf address (small reads) */
+	__s32 copybuf_len; /* in/out: copybuf bytes avail/used or error */
+	__u32 flags; /* in: flags */
+};
+#endif /* _UAPI_LINUX_TCP_H */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 72b251110c4d..1c389b0f5499 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -42,16 +42,21 @@
 /*
  * Helper macro to manipulate data structures
  */
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)->MEMBER)
-#endif
-#ifndef container_of
+
+/* offsetof() definition that uses __builtin_offset() might not preserve field
+ * offset CO-RE relocation properly, so force-redefine offsetof() using
+ * old-school approach which works with CO-RE correctly
+ */
+#undef offsetof
+#define offsetof(type, member)	((unsigned long)&((type *)0)->member)
+
+/* redefined container_of() to ensure we use the above offsetof() macro */
+#undef container_of
 #define container_of(ptr, type, member)				\
 	({							\
 		void *__mptr = (void *)(ptr);			\
 		((type *)(__mptr - offsetof(type, member)));	\
 	})
-#endif
 
 /*
  * Helper macro to throw a compilation error if __bpf_unreachable() gets
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 62a7b7420a44..fb3029495c23 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -21,6 +21,7 @@
 #include "builtin.h"
 #include "bench/bench.h"
 
+#include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -225,7 +226,6 @@ static void run_collection(struct collection *coll)
 		if (!bench->fn)
 			break;
 		printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
-		fflush(stdout);
 
 		argv[1] = bench->name;
 		run_bench(coll->name, bench->name, bench->fn, 1, argv);
@@ -246,6 +246,10 @@ int cmd_bench(int argc, const char **argv)
 	struct collection *coll;
 	int ret = 0;
 
+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+	setlocale(LC_ALL, "");
+
 	if (argc < 2) {
 		/* No collection specified. */
 		print_usage();
@@ -299,7 +303,6 @@ int cmd_bench(int argc, const char **argv)
 
 			if (bench_format == BENCH_FORMAT_DEFAULT)
 				printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
-			fflush(stdout);
 			ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
 			goto end;
 		}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5109d01619ee..85befbacb2a4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -295,8 +295,7 @@ static inline struct evsel_script *evsel_script(struct evsel *evsel)
 	return (struct evsel_script *)evsel->priv;
 }
 
-static struct evsel_script *perf_evsel_script__new(struct evsel *evsel,
-							struct perf_data *data)
+static struct evsel_script *evsel_script__new(struct evsel *evsel, struct perf_data *data)
 {
 	struct evsel_script *es = zalloc(sizeof(*es));
 
@@ -316,7 +315,7 @@ static struct evsel_script *perf_evsel_script__new(struct evsel *evsel,
 	return NULL;
 }
 
-static void perf_evsel_script__delete(struct evsel_script *es)
+static void evsel_script__delete(struct evsel_script *es)
 {
 	zfree(&es->filename);
 	fclose(es->fp);
@@ -324,7 +323,7 @@ static void perf_evsel_script__delete(struct evsel_script *es)
 	free(es);
 }
 
-static int perf_evsel_script__fprintf(struct evsel_script *es, FILE *fp)
+static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
 {
 	struct stat st;
 
@@ -2147,6 +2146,9 @@ static int process_sample_event(struct perf_tool *tool,
 	return 0;
 }
 
+// Used when scr->per_event_dump is not set
+static struct evsel_script es_stdout;
+
 static int process_attr(struct perf_tool *tool, union perf_event *event,
 			struct evlist **pevlist)
 {
@@ -2155,7 +2157,6 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct evsel *evsel, *pos;
 	u64 sample_type;
 	int err;
-	static struct evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -2165,15 +2166,13 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evsel = evlist__last(*pevlist);
 
 	if (!evsel->priv) {
-		if (scr->per_event_dump) {
-			evsel->priv = perf_evsel_script__new(evsel,
-						scr->session->data);
-		} else {
-			es = zalloc(sizeof(*es));
-			if (!es)
+		if (scr->per_event_dump) { 
+			evsel->priv = evsel_script__new(evsel, scr->session->data);
+			if (!evsel->priv)
 				return -ENOMEM;
-			es->fp = stdout;
-			evsel->priv = es;
+		} else { // Replicate what is done in perf_script__setup_per_event_dump()
+			es_stdout.fp = stdout;
+			evsel->priv = &es_stdout;
 		}
 	}
 
@@ -2422,7 +2421,7 @@ static void perf_script__fclose_per_event_dump(struct perf_script *script)
 	evlist__for_each_entry(evlist, evsel) {
 		if (!evsel->priv)
 			break;
-		perf_evsel_script__delete(evsel->priv);
+		evsel_script__delete(evsel->priv);
 		evsel->priv = NULL;
 	}
 }
@@ -2442,7 +2441,7 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 		if (evsel->priv != NULL)
 			continue;
 
-		evsel->priv = perf_evsel_script__new(evsel, script->session->data);
+		evsel->priv = evsel_script__new(evsel, script->session->data);
 		if (evsel->priv == NULL)
 			goto out_err_fclose;
 	}
@@ -2457,7 +2456,6 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 static int perf_script__setup_per_event_dump(struct perf_script *script)
 {
 	struct evsel *evsel;
-	static struct evsel_script es_stdout;
 
 	if (script->per_event_dump)
 		return perf_script__fopen_per_event_dump(script);
@@ -2477,8 +2475,8 @@ static void perf_script__exit_per_event_dump_stats(struct perf_script *script)
 	evlist__for_each_entry(script->session->evlist, evsel) {
 		struct evsel_script *es = evsel->priv;
 
-		perf_evsel_script__fprintf(es, stdout);
-		perf_evsel_script__delete(es);
+		evsel_script__fprintf(es, stdout);
+		evsel_script__delete(es);
 		evsel->priv = NULL;
 	}
 }
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 132bdb3e6c31..73c911dd0c2c 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -793,6 +793,9 @@ int cmd_test(int argc, const char **argv)
         if (ret < 0)
                 return ret;
 
+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
new file mode 100644
index 000000000000..00d2e0e2e0c2
--- /dev/null
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# test perf probe of function from different CU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
+		echo "--- Cleaning up ---"
+		perf probe -x ${temp_dir}/testfile -d foo
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+        cleanup
+        exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+cat > ${temp_dir}/testfile-foo.h << EOF
+struct t
+{
+  int *p;
+  int c;
+};
+
+extern int foo (int i, struct t *t);
+EOF
+
+cat > ${temp_dir}/testfile-foo.c << EOF
+#include "testfile-foo.h"
+
+int
+foo (int i, struct t *t)
+{
+  int j, res = 0;
+  for (j = 0; j < i && j < t->c; j++)
+    res += t->p[j];
+
+  return res;
+}
+EOF
+
+cat > ${temp_dir}/testfile-main.c << EOF
+#include "testfile-foo.h"
+
+static struct t g;
+
+int
+main (int argc, char **argv)
+{
+  int i;
+  int j[argc];
+  g.c = argc;
+  g.p = j;
+  for (i = 0; i < argc; i++)
+    j[i] = (int) argv[i][0];
+  return foo (3, &g);
+}
+EOF
+
+gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
+gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
+gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
+
+perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile foo
+
+cleanup
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index f8a10d5148f6..443374a77c8d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1081,7 +1081,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	ret = die_get_typename(vr_die, buf);
 	if (ret < 0) {
 		pr_debug("Failed to get type, make it unknown.\n");
-		ret = strbuf_add(buf, " (unknown_type)", 14);
+		ret = strbuf_add(buf, "(unknown_type)", 14);
 	}
 
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 9a8f47fc0b91..37c5494a0381 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 Facebook */
 
 #include <linux/err.h>
+#include <netinet/tcp.h>
 #include <test_progs.h>
 #include "bpf_dctcp.skel.h"
 #include "bpf_cubic.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 9781d85cb223..e075d03ab630 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -7,6 +7,7 @@
 #include <string.h>
 
 #include <linux/pkt_cls.h>
+#include <netinet/tcp.h>
 
 #include <test_progs.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 85f73261fab0..b8b48cac2ac3 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Cloudflare
 #include <error.h>
+#include <netinet/tcp.h>
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index b25c9c45c148..d5b44b135c00 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -2,6 +2,12 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 
+#include <linux/tcp.h>
+
+#ifndef SOL_TCP
+#define SOL_TCP IPPROTO_TCP
+#endif
+
 #define SOL_CUSTOM			0xdeadbeef
 
 static int getsetsockopt(void)
@@ -11,6 +17,7 @@ static int getsetsockopt(void)
 		char u8[4];
 		__u32 u32;
 		char cc[16]; /* TCP_CA_NAME_MAX */
+		struct tcp_zerocopy_receive zc;
 	} buf = {};
 	socklen_t optlen;
 	char *big_buf = NULL;
@@ -154,6 +161,27 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
+	/* TCP_ZEROCOPY_RECEIVE triggers */
+	memset(&buf, 0, sizeof(buf));
+	optlen = sizeof(buf.zc);
+	err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(TCP_ZEROCOPY_RECEIVE) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+
+	memset(&buf, 0, sizeof(buf));
+	buf.zc.address = 12345; /* rejected by BPF */
+	optlen = sizeof(buf.zc);
+	errno = 0;
+	err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
+	if (errno != EPERM) {
+		log_err("Unexpected getsockopt(TCP_ZEROCOPY_RECEIVE) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+
 	free(big_buf);
 	close(fd);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index 712df7b49cb1..d3597f81e6e9 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
-#include <netinet/in.h>
-#include <netinet/tcp.h>
+#include <linux/tcp.h>
 #include <linux/bpf.h>
+#include <netinet/in.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
@@ -12,6 +12,10 @@ __u32 _version SEC("version") = 1;
 #define PAGE_SIZE 4096
 #endif
 
+#ifndef SOL_TCP
+#define SOL_TCP IPPROTO_TCP
+#endif
+
 #define SOL_CUSTOM			0xdeadbeef
 
 struct sockopt_sk {
@@ -57,6 +61,21 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		return 1;
 	}
 
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
+		/* Verify that TCP_ZEROCOPY_RECEIVE triggers.
+		 * It has a custom implementation for performance
+		 * reasons.
+		 */
+
+		if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
+			return 0; /* EPERM, bounds check */
+
+		if (((struct tcp_zerocopy_receive *)optval)->address != 0)
+			return 0; /* EPERM, unexpected data */
+
+		return 1;
+	}
+
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
 		if (optval + 1 > optval_end)
 			return 0; /* EPERM, bounds check */
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 238f5f61189e..1d429d67f8dd 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -16,7 +16,6 @@ typedef __u16 __sum16;
 #include <linux/if_packet.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <netinet/tcp.h>
 #include <linux/filter.h>
 #include <linux/perf_event.h>
 #include <linux/socket.h>
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 0fb92d9a319b..961c17b4681e 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	20
+#define MAX_NR_MAPS	21
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -87,6 +87,7 @@ struct bpf_test {
 	int fixup_sk_storage_map[MAX_FIXUPS];
 	int fixup_map_event_output[MAX_FIXUPS];
 	int fixup_map_reuseport_array[MAX_FIXUPS];
+	int fixup_map_ringbuf[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t insn_processed;
@@ -640,6 +641,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_sk_storage_map = test->fixup_sk_storage_map;
 	int *fixup_map_event_output = test->fixup_map_event_output;
 	int *fixup_map_reuseport_array = test->fixup_map_reuseport_array;
+	int *fixup_map_ringbuf = test->fixup_map_ringbuf;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -817,6 +819,14 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			fixup_map_reuseport_array++;
 		} while (*fixup_map_reuseport_array);
 	}
+	if (*fixup_map_ringbuf) {
+		map_fds[20] = create_map(BPF_MAP_TYPE_RINGBUF, 0,
+					   0, 4096);
+		do {
+			prog[*fixup_map_ringbuf].imm = map_fds[20];
+			fixup_map_ringbuf++;
+		} while (*fixup_map_ringbuf);
+	}
 }
 
 struct libcap {
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
index 45d43bf82f26..0b943897aaf6 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -28,6 +28,36 @@
 	.result = ACCEPT,
 	.result_unpriv = ACCEPT,
 },
+{
+	"check valid spill/fill, ptr to mem",
+	.insns = {
+	/* reserve 8 byte ringbuf memory */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_2, 8),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	/* store a pointer to the reserved memory in R6 */
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* check whether the reservation was successful */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	/* spill R6(mem) into the stack */
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
+	/* fill it back in R7 */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, -8),
+	/* should be able to access *(R7) = 0 */
+	BPF_ST_MEM(BPF_DW, BPF_REG_7, 0, 0),
+	/* submit the reserved ringbuf memory */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_ringbuf = { 1 },
+	.result = ACCEPT,
+	.result_unpriv = ACCEPT,
+},
 {
 	"check corrupted spill/fill",
 	.insns = {
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index c3a905923ef2..cbf166df57da 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -835,6 +835,7 @@ EOF
 	fi
 
 	# clean up any leftovers
+	echo 0 > /sys/bus/netdevsim/del_device
 	$probed && rmmod netdevsim
 
 	if [ $ret -ne 0 ]; then
diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index b71828df5a6d..5f581c3a1131 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 
 CONFIG_NET_SCHED=y
diff --git a/tools/testing/selftests/tc-testing/settings b/tools/testing/selftests/tc-testing/settings
new file mode 100644
index 000000000000..e2206265f67c
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/settings
@@ -0,0 +1 @@
+timeout=900
diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 8a9461aa0878..93e44410f170 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -502,10 +502,32 @@ n2 bash -c 'printf 0 > /proc/sys/net/ipv4/conf/all/rp_filter'
 n1 ping -W 1 -c 1 192.168.241.2
 [[ $(n2 wg show wg0 endpoints) == "$pub1	10.0.0.3:1" ]]
 
-ip1 link del veth1
-ip1 link del veth3
-ip1 link del wg0
-ip2 link del wg0
+ip1 link del dev veth3
+ip1 link del dev wg0
+ip2 link del dev wg0
+
+# Make sure persistent keep alives are sent when an adapter comes up
+ip1 link add dev wg0 type wireguard
+n1 wg set wg0 private-key <(echo "$key1") peer "$pub2" endpoint 10.0.0.1:1 persistent-keepalive 1
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -eq 0 ]]
+ip1 link set dev wg0 up
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -gt 0 ]]
+ip1 link del dev wg0
+# This should also happen even if the private key is set later
+ip1 link add dev wg0 type wireguard
+n1 wg set wg0 peer "$pub2" endpoint 10.0.0.1:1 persistent-keepalive 1
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -eq 0 ]]
+ip1 link set dev wg0 up
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -eq 0 ]]
+n1 wg set wg0 private-key <(echo "$key1")
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -gt 0 ]]
+ip1 link del dev veth1
+ip1 link del dev wg0
 
 # We test that Netlink/IPC is working properly by doing things that usually cause split responses
 ip0 link add dev wg0 type wireguard
