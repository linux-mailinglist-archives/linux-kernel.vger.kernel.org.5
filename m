Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6C75E1CF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGWM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGWM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA010E5;
        Sun, 23 Jul 2023 05:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65EDB60CE8;
        Sun, 23 Jul 2023 12:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1E2C433C7;
        Sun, 23 Jul 2023 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690115185;
        bh=TQxN1zUj8DA8A7TW7g4U30Qt8CtRogoYMUfkUC6iEhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfdC8+9SihhDjpDqtbMASATL0QNCIZg4dgRpW//tHzdj4zL4I43F3akLICGnCXB0K
         ZQO4KfnB5men4iG7KwBV8img22sV2qFTQq+jMlV68vrUe+hnUVrTAqe3s6ubMZRtDE
         YGWiYVV9wqyfWNh+jiY9D2YEv++gnLckmFs6bpEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.121
Date:   Sun, 23 Jul 2023 14:26:10 +0200
Message-ID: <2023072309-ludicrous-quotable-8da6@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072309-passport-unmovable-6f0f@gregkh>
References: <2023072309-passport-unmovable-6f0f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/device-mapper/dm-init.rst b/Documentation/admin-guide/device-mapper/dm-init.rst
index e5242ff17e9b..981d6a907699 100644
--- a/Documentation/admin-guide/device-mapper/dm-init.rst
+++ b/Documentation/admin-guide/device-mapper/dm-init.rst
@@ -123,3 +123,11 @@ Other examples (per target):
     0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
     fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
     51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
+
+For setups using device-mapper on top of asynchronously probed block
+devices (MMC, USB, ..), it may be necessary to tell dm-init to
+explicitly wait for them to become available before setting up the
+device-mapper tables. This can be done with the "dm-mod.waitfor="
+module parameter, which takes a list of devices to wait for::
+
+  dm-mod.waitfor=<device1>[,..,<deviceN>]
diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 1cee230338a2..076861b0f5ac 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -102,12 +102,16 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
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
index 60b217b436be..5b77b9e5ac7e 100644
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
 
diff --git a/Makefile b/Makefile
index 017e48385465..ed71adea751c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 120
+SUBLEVEL = 121
 EXTRAVERSION =
 NAME = Trick or Treat
 
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
index 30217948ef82..b4b73ab99626 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -542,7 +542,6 @@ spi@18029200 {
 				  "spi_lr_session_done",
 				  "spi_lr_overread";
 		clocks = <&iprocmed>;
-		clock-names = "iprocmed";
 		num-cs = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index bc857676d191..c13d2f6e1a38 100644
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
index 9997a5d0333a..72828b9d4281 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -749,13 +749,13 @@ &uart_A {
 
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
index 94f1c03decce..cfd4a909a7a7 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -737,13 +737,13 @@ &uart_A {
 
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
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
index b0f476ff017f..aadca9bf416c 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
@@ -11,9 +11,9 @@ soc {
 		dma@7984000 {
 			status = "okay";
 		};
-
-		qpic-nand@79b0000 {
-			status = "okay";
-		};
 	};
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
index 7a337dc08741..726aa30eeef5 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
@@ -102,10 +102,10 @@ pci@40000000 {
 			status = "okay";
 			perst-gpio = <&tlmm 38 0x1>;
 		};
-
-		qpic-nand@79b0000 {
-			pinctrl-0 = <&nand_pins>;
-			pinctrl-names = "default";
-		};
 	};
 };
+
+&nand {
+	pinctrl-0 = <&nand_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
index 94872518b5a2..9988b9eab803 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -65,11 +65,11 @@ i2c@78b7000 { /* BLSP1 QUP2 */
 		dma@7984000 {
 			status = "okay";
 		};
-
-		qpic-nand@79b0000 {
-			pinctrl-0 = <&nand_pins>;
-			pinctrl-names = "default";
-			status = "okay";
-		};
 	};
 };
+
+&nand {
+	pinctrl-0 = <&nand_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
index fbf3826933e4..7c0aa59accc5 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
@@ -137,10 +137,13 @@ reg_panel_supply: regulator-panel-supply {
 
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
index d3375ad8c91f..5f65d96435f6 100644
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
@@ -267,6 +267,12 @@ adv7513_i2s0: endpoint {
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
index 44ecc4708587..108d934a186b 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
@@ -171,12 +171,6 @@ watchdog {
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
index 48beed0f1f30..a76173e8a2a1 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -438,7 +438,7 @@ &i2s2 {
 	i2s2_port: port {
 		i2s2_endpoint: endpoint {
 			remote-endpoint = <&sii9022_tx_endpoint>;
-			format = "i2s";
+			dai-format = "i2s";
 			mclk-fs = <256>;
 		};
 	};
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 09c241280ed9..5d52da168ab3 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -326,6 +326,23 @@
 #endif
 	.endm
 
+/*
+ * Raw SMP data memory barrier
+ */
+	.macro	__smp_dmb mode
+#if __LINUX_ARM_ARCH__ >= 7
+	.ifeqs "\mode","arm"
+	dmb	ish
+	.else
+	W(dmb)	ish
+	.endif
+#elif __LINUX_ARM_ARCH__ == 6
+	mcr	p15, 0, r0, c7, c10, 5	@ dmb
+#else
+	.error "Incompatible SMP platform"
+#endif
+	.endm
+
 #if defined(CONFIG_CPU_V7M)
 	/*
 	 * setmode is used to assert to be in svc mode during boot. For v7-M
diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
index 6f5d627c44a3..f46b3c570f92 100644
--- a/arch/arm/include/asm/sync_bitops.h
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -14,14 +14,35 @@
  * ops which are SMP safe even on a UP kernel.
  */
 
+/*
+ * Unordered
+ */
+
 #define sync_set_bit(nr, p)		_set_bit(nr, p)
 #define sync_clear_bit(nr, p)		_clear_bit(nr, p)
 #define sync_change_bit(nr, p)		_change_bit(nr, p)
-#define sync_test_and_set_bit(nr, p)	_test_and_set_bit(nr, p)
-#define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
-#define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
 #define sync_test_bit(nr, addr)		test_bit(nr, addr)
-#define arch_sync_cmpxchg		arch_cmpxchg
 
+/*
+ * Fully ordered
+ */
+
+int _sync_test_and_set_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_set_bit(nr, p)	_sync_test_and_set_bit(nr, p)
+
+int _sync_test_and_clear_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_clear_bit(nr, p)	_sync_test_and_clear_bit(nr, p)
+
+int _sync_test_and_change_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_change_bit(nr, p)	_sync_test_and_change_bit(nr, p)
+
+#define arch_sync_cmpxchg(ptr, old, new)				\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__smp_mb__before_atomic();					\
+	__ret = arch_cmpxchg_relaxed((ptr), (old), (new));		\
+	__smp_mb__after_atomic();					\
+	__ret;								\
+})
 
 #endif
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 95bd35991288..f069d1b2318e 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -28,7 +28,7 @@ UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
 
-	.macro	testop, name, instr, store
+	.macro	__testop, name, instr, store, barrier
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
@@ -38,7 +38,7 @@ UNWIND(	.fnstart	)
 	mov	r0, r0, lsr #5
 	add	r1, r1, r0, lsl #2	@ Get word offset
 	mov	r3, r2, lsl r3		@ create mask
-	smp_dmb
+	\barrier
 #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 	.arch_extension	mp
 	ALT_SMP(W(pldw)	[r1])
@@ -50,13 +50,21 @@ UNWIND(	.fnstart	)
 	strex	ip, r2, [r1]
 	cmp	ip, #0
 	bne	1b
-	smp_dmb
+	\barrier
 	cmp	r0, #0
 	movne	r0, #1
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
+
+	.macro	testop, name, instr, store
+	__testop \name, \instr, \store, smp_dmb
+	.endm
+
+	.macro	sync_testop, name, instr, store
+	__testop \name, \instr, \store, __smp_dmb
+	.endm
 #else
 	.macro	bitop, name, instr
 ENTRY(	\name		)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4ebecc67e6e0..f13fe9bc2399 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_change_bit, eor, str
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_change_bit, eor, str
+#endif
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 009afa0f5b4a..4d2c5ca620eb 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_clear_bit, bicne, strne
+#endif
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index f3192e55acc8..649dbab65d8d 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_set_bit, orreq, streq
+#endif
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
index 9bcae72dda44..3bd017f6e256 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -233,7 +233,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
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
index f1d5583e7bbb..7054d9fae2ea 100644
--- a/arch/arm/probes/kprobes/test-core.h
+++ b/arch/arm/probes/kprobes/test-core.h
@@ -454,3 +454,7 @@ void kprobe_thumb32_test_cases(void);
 #else
 void kprobe_arm_test_cases(void);
 #endif
+
+void __kprobes_test_case_start(void);
+void __kprobes_test_case_end_16(void);
+void __kprobes_test_case_end_32(void);
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9d3cbe786f8d..e5e35470647b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -733,6 +733,47 @@ config ARM64_ERRATUM_2457168
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	bool
+
+config ARM64_ERRATUM_2119858
+	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
+
+	  Affected Cortex-A710 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2139208
+	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Neoverse-N2 erratum 2139208.
+
+	  Affected Neoverse-N2 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 8e9cf36a9a41..6529962edd4e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -281,6 +281,10 @@ dsi_out: endpoint {
 	};
 };
 
+&gic {
+	mediatek,broken-save-restore-fw;
+};
+
 &gpu {
 	mali-supply = <&mt6358_vgpu_reg>;
 	sram-supply = <&mt6358_vsram_gpu_reg>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 9ed1a7229574..72f444405ebf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -41,7 +41,8 @@ cpu0: cpu@0 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
-			capacity-dmips-mhz = <530>;
+			performance-domains = <&performance 0>;
+			capacity-dmips-mhz = <427>;
 		};
 
 		cpu1: cpu@100 {
@@ -52,7 +53,8 @@ cpu1: cpu@100 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
-			capacity-dmips-mhz = <530>;
+			performance-domains = <&performance 0>;
+			capacity-dmips-mhz = <427>;
 		};
 
 		cpu2: cpu@200 {
@@ -63,7 +65,8 @@ cpu2: cpu@200 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
-			capacity-dmips-mhz = <530>;
+			performance-domains = <&performance 0>;
+			capacity-dmips-mhz = <427>;
 		};
 
 		cpu3: cpu@300 {
@@ -74,7 +77,8 @@ cpu3: cpu@300 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
-			capacity-dmips-mhz = <530>;
+			performance-domains = <&performance 0>;
+			capacity-dmips-mhz = <427>;
 		};
 
 		cpu4: cpu@400 {
@@ -85,6 +89,7 @@ cpu4: cpu@400 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -96,6 +101,7 @@ cpu5: cpu@500 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -107,6 +113,7 @@ cpu6: cpu@600 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -118,6 +125,7 @@ cpu7: cpu@700 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -234,6 +242,12 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		performance: performance-controller@11bc10 {
+			compatible = "mediatek,cpufreq-hw";
+			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+			#performance-domain-cells = <1>;
+		};
+
 		gic: interrupt-controller@c000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <4>;
diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 787ebcec121d..a6405059636c 100644
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
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index f3c0dbfd0a23..c6e8bf18defc 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -5,9 +5,847 @@
 
 /dts-v1/;
 
-#include "apq8016-sbc.dtsi"
+#include "msm8916-pm8916.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. APQ 8016 SBC";
 	compatible = "qcom,apq8016-sbc", "qcom,apq8016";
+
+	aliases {
+		serial0 = &blsp1_uart2;
+		serial1 = &blsp1_uart1;
+		usid0 = &pm8916_0;
+		i2c0	= &blsp_i2c2;
+		i2c1	= &blsp_i2c6;
+		i2c3	= &blsp_i2c4;
+		spi0	= &blsp_spi5;
+		spi1	= &blsp_spi3;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	camera_vdddo_1v8: camera-vdddo-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdddo";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	camera_vdda_2v8: camera-vdda-2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdda";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	camera_vddd_1v5: camera-vddd-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
+	reserved-memory {
+		ramoops@bff00000 {
+			compatible = "ramoops";
+			reg = <0x0 0xbff00000 0x0 0x100000>;
+
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x20000>;
+		};
+	};
+
+	usb2513 {
+		compatible = "smsc,usb3503";
+		reset-gpios = <&pm8916_gpios 3 GPIO_ACTIVE_LOW>;
+		initial-mode = <1>;
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_id_default>;
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7533_out>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&msm_key_volp_n_default>;
+
+		button@0 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&msmgpio_leds>,
+			    <&pm8916_gpios_leds>,
+			    <&pm8916_mpps_leds>;
+
+		compatible = "gpio-leds";
+
+		led@1 {
+			label = "apq8016-sbc:green:user1";
+			gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led@2 {
+			label = "apq8016-sbc:green:user2";
+			gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led@3 {
+			label = "apq8016-sbc:green:user3";
+			gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
+		};
+
+		led@4 {
+			label = "apq8016-sbc:green:user4";
+			gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			panic-indicator;
+			default-state = "off";
+		};
+
+		led@5 {
+			label = "apq8016-sbc:yellow:wlan";
+			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		led@6 {
+			label = "apq8016-sbc:blue:bt";
+			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+	};
+};
+
+&blsp_dma {
+	status = "okay";
+};
+
+&blsp_i2c2 {
+	/* On Low speed expansion */
+	status = "okay";
+	label = "LS-I2C0";
+};
+
+&blsp_i2c4 {
+	/* On High speed expansion */
+	status = "okay";
+	label = "HS-I2C2";
+
+	adv_bridge: bridge@39 {
+		status = "okay";
+
+		compatible = "adi,adv7533";
+		reg = <0x39>;
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+
+		adi,dsi-lanes = <4>;
+		clocks = <&rpmcc RPM_SMD_BB_CLK2>;
+		clock-names = "cec";
+
+		pd-gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
+
+		avdd-supply = <&pm8916_l6>;
+		v1p2-supply = <&pm8916_l6>;
+		v3p3-supply = <&pm8916_l17>;
+
+		pinctrl-names = "default","sleep";
+		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
+		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
+		#sound-dai-cells = <1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7533_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7533_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&blsp_i2c6 {
+	/* On Low speed expansion */
+	status = "okay";
+	label = "LS-I2C1";
+};
+
+&blsp_spi3 {
+	/* On High speed expansion */
+	status = "okay";
+	label = "HS-SPI1";
+};
+
+&blsp_spi5 {
+	/* On Low speed expansion */
+	status = "okay";
+	label = "LS-SPI0";
+};
+
+&blsp1_uart1 {
+	status = "okay";
+	label = "LS-UART0";
+};
+
+&blsp1_uart2 {
+	status = "okay";
+	label = "LS-UART1";
+};
+
+&camss {
+	status = "okay";
+	ports {
+		port@0 {
+			reg = <0>;
+			csiphy0_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <0 2>;
+				remote-endpoint = <&ov5640_ep>;
+				status = "okay";
+			};
+		};
+	};
+};
+
+&cci {
+	status = "okay";
+};
+
+&cci_i2c0 {
+	camera_rear@3b {
+		compatible = "ovti,ov5640";
+		reg = <0x3b>;
+
+		enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&camera_rear_default>;
+
+		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		clock-names = "xclk";
+		clock-frequency = <23880000>;
+
+		vdddo-supply = <&camera_vdddo_1v8>;
+		vdda-supply = <&camera_vdda_2v8>;
+		vddd-supply = <&camera_vddd_1v5>;
+
+		/* No camera mezzanine by default */
+		status = "disabled";
+
+		port {
+			ov5640_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <0 2>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
+};
+
+&dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&adv7533_in>;
+};
+
+&lpass {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mpss {
+	status = "okay";
+
+	firmware-name = "qcom/apq8016/mba.mbn", "qcom/apq8016/modem.mbn";
+};
+
+&pm8916_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
+&pronto {
+	status = "okay";
+
+	firmware-name = "qcom/apq8016/wcnss.mbn";
+};
+
+&sdhc_1 {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
+	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+
+	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
+};
+
+&sound {
+	status = "okay";
+
+	pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act &ext_mclk_tlmm_lines_act>;
+	pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus &ext_mclk_tlmm_lines_sus>;
+	pinctrl-names = "default", "sleep";
+	qcom,model = "DB410c";
+	qcom,audio-routing =
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	external-dai-link@0 {
+		link-name = "ADV7533";
+		cpu {
+			sound-dai = <&lpass MI2S_QUATERNARY>;
+		};
+		codec {
+			sound-dai = <&adv_bridge 0>;
+		};
+	};
+
+	internal-codec-playback-dai-link@0 {
+		link-name = "WCD";
+		cpu {
+			sound-dai = <&lpass MI2S_PRIMARY>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+		};
+	};
+
+	internal-codec-capture-dai-link@0 {
+		link-name = "WCD-Capture";
+		cpu {
+			sound-dai = <&lpass MI2S_TERTIARY>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
+		};
+	};
+};
+
+&usb {
+	status = "okay";
+	extcon = <&usb_id>, <&usb_id>;
+
+	pinctrl-names = "default", "device";
+	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
+	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
+
+&wcd_codec {
+	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+	clock-names = "mclk";
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+};
+
+&wcnss_ctrl {
+	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
+};
+
+/* Enable CoreSight */
+&cti0 { status = "okay"; };
+&cti1 { status = "okay"; };
+&cti12 { status = "okay"; };
+&cti13 { status = "okay"; };
+&cti14 { status = "okay"; };
+&cti15 { status = "okay"; };
+&debug0 { status = "okay"; };
+&debug1 { status = "okay"; };
+&debug2 { status = "okay"; };
+&debug3 { status = "okay"; };
+&etf { status = "okay"; };
+&etm0 { status = "okay"; };
+&etm1 { status = "okay"; };
+&etm2 { status = "okay"; };
+&etm3 { status = "okay"; };
+&etr { status = "okay"; };
+&funnel0 { status = "okay"; };
+&funnel1 { status = "okay"; };
+&replicator { status = "okay"; };
+&stm { status = "okay"; };
+&tpiu { status = "okay"; };
+
+&smd_rpm_regulators {
+	vdd_l1_l2_l3-supply = <&pm8916_s3>;
+	vdd_l4_l5_l6-supply = <&pm8916_s4>;
+	vdd_l7-supply = <&pm8916_s4>;
+
+	s3 {
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
+	};
+
+	s4 {
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	l1 {
+		regulator-min-microvolt = <1225000>;
+		regulator-max-microvolt = <1225000>;
+	};
+
+	l2 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	l4 {
+		regulator-min-microvolt = <2050000>;
+		regulator-max-microvolt = <2050000>;
+	};
+
+	l5 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l6 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l7 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l8 {
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	l9 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l10 {
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	l11 {
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+		regulator-allow-set-load;
+		regulator-system-load = <200000>;
+	};
+
+	l12 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	l13 {
+		regulator-min-microvolt = <3075000>;
+		regulator-max-microvolt = <3075000>;
+	};
+
+	l14 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	/*
+	 * The 96Boards specification expects a 1.8V power rail on the low-speed
+	 * expansion connector that is able to provide at least 0.18W / 100 mA.
+	 * L15/L16 are connected in parallel to provide 55 mA each. A minimum load
+	 * must be specified to ensure the regulators are not put in LPM where they
+	 * would only provide 5 mA.
+	 */
+	l15 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-system-load = <50000>;
+		regulator-allow-set-load;
+		regulator-always-on;
+	};
+
+	l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-system-load = <50000>;
+		regulator-allow-set-load;
+		regulator-always-on;
+	};
+
+	l17 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l18 {
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+	};
+};
+
+/*
+ * 2mA drive strength is not enough when connecting multiple
+ * I2C devices with different pull up resistors.
+ */
+&i2c2_default {
+	drive-strength = <16>;
+};
+
+&i2c4_default {
+	drive-strength = <16>;
+};
+
+&i2c6_default {
+	drive-strength = <16>;
+};
+
+/*
+ * GPIO name legend: proper name = the GPIO line is used as GPIO
+ *         NC = not connected (pin out but not routed from the chip to
+ *              anything the board)
+ *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
+ *         LSEC = Low Speed External Connector
+ *         HSEC = High Speed External Connector
+ *
+ * Line names are taken from the schematic "DragonBoard410c"
+ * dated monday, august 31, 2015. Page 5 in particular.
+ *
+ * For the lines routed to the external connectors the
+ * lines are named after the 96Boards CE Specification 1.0,
+ * Appendix "Expansion Connector Signal Description".
+ *
+ * When the 96Board naming of a line and the schematic name of
+ * the same line are in conflict, the 96Board specification
+ * takes precedence, which means that the external UART on the
+ * LSEC is named UART0 while the schematic and SoC names this
+ * UART3. This is only for the informational lines i.e. "[FOO]",
+ * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
+ * ones actually used for GPIO.
+ */
+
+&msmgpio {
+	gpio-line-names =
+		"[UART0_TX]", /* GPIO_0, LSEC pin 5 */
+		"[UART0_RX]", /* GPIO_1, LSEC pin 7 */
+		"[UART0_CTS_N]", /* GPIO_2, LSEC pin 3 */
+		"[UART0_RTS_N]", /* GPIO_3, LSEC pin 9 */
+		"[UART1_TX]", /* GPIO_4, LSEC pin 11 */
+		"[UART1_RX]", /* GPIO_5, LSEC pin 13 */
+		"[I2C0_SDA]", /* GPIO_8, LSEC pin 17 */
+		"[I2C0_SCL]", /* GPIO_7, LSEC pin 15 */
+		"[SPI1_DOUT]", /* SPI1_MOSI, HSEC pin 1 */
+		"[SPI1_DIN]", /* SPI1_MISO, HSEC pin 11 */
+		"[SPI1_CS]", /* SPI1_CS_N, HSEC pin 7 */
+		"[SPI1_SCLK]", /* SPI1_CLK, HSEC pin 9 */
+		"GPIO-B", /* LS_EXP_GPIO_B, LSEC pin 24 */
+		"GPIO-C", /* LS_EXP_GPIO_C, LSEC pin 25 */
+		"[I2C3_SDA]", /* HSEC pin 38 */
+		"[I2C3_SCL]", /* HSEC pin 36 */
+		"[SPI0_MOSI]", /* LSEC pin 14 */
+		"[SPI0_MISO]", /* LSEC pin 10 */
+		"[SPI0_CS_N]", /* LSEC pin 12 */
+		"[SPI0_CLK]", /* LSEC pin 8 */
+		"HDMI_HPD_N", /* GPIO 20 */
+		"USR_LED_1_CTRL",
+		"[I2C1_SDA]", /* GPIO_22, LSEC pin 21 */
+		"[I2C1_SCL]", /* GPIO_23, LSEC pin 19 */
+		"GPIO-G", /* LS_EXP_GPIO_G, LSEC pin 29 */
+		"GPIO-H", /* LS_EXP_GPIO_H, LSEC pin 30 */
+		"[CSI0_MCLK]", /* HSEC pin 15 */
+		"[CSI1_MCLK]", /* HSEC pin 17 */
+		"GPIO-K", /* LS_EXP_GPIO_K, LSEC pin 33 */
+		"[I2C2_SDA]", /* HSEC pin 34 */
+		"[I2C2_SCL]", /* HSEC pin 32 */
+		"DSI2HDMI_INT_N",
+		"DSI_SW_SEL_APQ",
+		"GPIO-L", /* LS_EXP_GPIO_L, LSEC pin 34 */
+		"GPIO-J", /* LS_EXP_GPIO_J, LSEC pin 32 */
+		"GPIO-I", /* LS_EXP_GPIO_I, LSEC pin 31 */
+		"GPIO-A", /* LS_EXP_GPIO_A, LSEC pin 23 */
+		"FORCED_USB_BOOT",
+		"SD_CARD_DET_N",
+		"[WCSS_BT_SSBI]",
+		"[WCSS_WLAN_DATA_2]", /* GPIO 40 */
+		"[WCSS_WLAN_DATA_1]",
+		"[WCSS_WLAN_DATA_0]",
+		"[WCSS_WLAN_SET]",
+		"[WCSS_WLAN_CLK]",
+		"[WCSS_FM_SSBI]",
+		"[WCSS_FM_SDI]",
+		"[WCSS_BT_DAT_CTL]",
+		"[WCSS_BT_DAT_STB]",
+		"NC",
+		"NC", /* GPIO 50 */
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 60 */
+		"NC",
+		"NC",
+		"[CDC_PDM0_CLK]",
+		"[CDC_PDM0_SYNC]",
+		"[CDC_PDM0_TX0]",
+		"[CDC_PDM0_RX0]",
+		"[CDC_PDM0_RX1]",
+		"[CDC_PDM0_RX2]",
+		"GPIO-D", /* LS_EXP_GPIO_D, LSEC pin 26 */
+		"NC", /* GPIO 70 */
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 74 */
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"BOOT_CONFIG_0", /* GPIO 80 */
+		"BOOT_CONFIG_1",
+		"BOOT_CONFIG_2",
+		"BOOT_CONFIG_3",
+		"NC",
+		"NC",
+		"BOOT_CONFIG_5",
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 90 */
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 100 */
+		"NC",
+		"NC",
+		"NC",
+		"SSBI_GPS",
+		"NC",
+		"NC",
+		"KEY_VOLP_N",
+		"NC",
+		"NC",
+		"[LS_EXP_MI2S_WS]", /* GPIO 110 */
+		"NC",
+		"NC",
+		"[LS_EXP_MI2S_SCK]",
+		"[LS_EXP_MI2S_DATA0]",
+		"GPIO-E", /* LS_EXP_GPIO_E, LSEC pin 27 */
+		"NC",
+		"[DSI2HDMI_MI2S_WS]",
+		"[DSI2HDMI_MI2S_SCK]",
+		"[DSI2HDMI_MI2S_DATA0]",
+		"USR_LED_2_CTRL", /* GPIO 120 */
+		"SB_HS_ID";
+
+	msmgpio_leds: msmgpio-leds {
+		pins = "gpio21", "gpio120";
+		function = "gpio";
+
+		output-low;
+	};
+
+	usb_id_default: usb-id-default {
+		pins = "gpio121";
+		function = "gpio";
+
+		drive-strength = <8>;
+		input-enable;
+		bias-pull-up;
+	};
+
+	adv7533_int_active: adv533-int-active {
+		pins = "gpio31";
+		function = "gpio";
+
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	adv7533_int_suspend: adv7533-int-suspend {
+		pins = "gpio31";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	adv7533_switch_active: adv7533-switch-active {
+		pins = "gpio32";
+		function = "gpio";
+
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	adv7533_switch_suspend: adv7533-switch-suspend {
+		pins = "gpio32";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	msm_key_volp_n_default: msm-key-volp-n-default {
+		pins = "gpio107";
+		function = "gpio";
+
+		drive-strength = <8>;
+		input-enable;
+		bias-pull-up;
+	};
+};
+
+&pm8916_gpios {
+	gpio-line-names =
+		"USR_LED_3_CTRL",
+		"USR_LED_4_CTRL",
+		"USB_HUB_RESET_N_PM",
+		"USB_SW_SEL_PM";
+
+	usb_hub_reset_pm: usb-hub-reset-pm {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		input-disable;
+		output-high;
+	};
+
+	usb_hub_reset_pm_device: usb-hub-reset-pm-device {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		output-low;
+	};
+
+	usb_sw_sel_pm: usb-sw-sel-pm {
+		pins = "gpio4";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		power-source = <PM8916_GPIO_VPH>;
+		input-disable;
+		output-high;
+	};
+
+	usb_sw_sel_pm_device: usb-sw-sel-pm-device {
+		pins = "gpio4";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		power-source = <PM8916_GPIO_VPH>;
+		input-disable;
+		output-low;
+	};
+
+	pm8916_gpios_leds: pm8916-gpios-leds {
+		pins = "gpio1", "gpio2";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		output-low;
+	};
+};
+
+&pm8916_mpps {
+	gpio-line-names =
+		"VDD_PX_BIAS",
+		"WLAN_LED_CTRL",
+		"BT_LED_CTRL",
+		"GPIO-F"; /* LS_EXP_GPIO_F, LSEC pin 28 */
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ls_exp_gpio_f>;
+
+	ls_exp_gpio_f: pm8916-mpp4-state {
+		pins = "mpp4";
+		function = "digital";
+
+		output-low;
+		power-source = <PM8916_MPP_L5>;	// 1.8V
+	};
+
+	pm8916_mpps_leds: pm8916-mpps-state {
+		pins = "mpp2", "mpp3";
+		function = "digital";
+
+		output-low;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
deleted file mode 100644
index f8d8f3e3664e..000000000000
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ /dev/null
@@ -1,826 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- */
-
-#include "msm8916-pm8916.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
-#include <dt-bindings/sound/apq8016-lpass.h>
-
-/ {
-	aliases {
-		serial0 = &blsp1_uart2;
-		serial1 = &blsp1_uart1;
-		usid0 = &pm8916_0;
-		i2c0	= &blsp_i2c2;
-		i2c1	= &blsp_i2c6;
-		i2c3	= &blsp_i2c4;
-		spi0	= &blsp_spi5;
-		spi1	= &blsp_spi3;
-	};
-
-	chosen {
-		stdout-path = "serial0";
-	};
-
-	camera_vdddo_1v8: camera-vdddo-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "camera_vdddo";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
-	camera_vdda_2v8: camera-vdda-2v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "camera_vdda";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
-	};
-
-	camera_vddd_1v5: camera-vddd-1v5 {
-		compatible = "regulator-fixed";
-		regulator-name = "camera_vddd";
-		regulator-min-microvolt = <1500000>;
-		regulator-max-microvolt = <1500000>;
-		regulator-always-on;
-	};
-
-	reserved-memory {
-		ramoops@bff00000 {
-			compatible = "ramoops";
-			reg = <0x0 0xbff00000 0x0 0x100000>;
-
-			record-size = <0x20000>;
-			console-size = <0x20000>;
-			ftrace-size = <0x20000>;
-		};
-	};
-
-	usb2513 {
-		compatible = "smsc,usb3503";
-		reset-gpios = <&pm8916_gpios 3 GPIO_ACTIVE_LOW>;
-		initial-mode = <1>;
-	};
-
-	usb_id: usb-id {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb_id_default>;
-	};
-
-	hdmi-out {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con: endpoint {
-				remote-endpoint = <&adv7533_out>;
-			};
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		autorepeat;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&msm_key_volp_n_default>;
-
-		button@0 {
-			label = "Volume Up";
-			linux,code = <KEY_VOLUMEUP>;
-			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	leds {
-		pinctrl-names = "default";
-		pinctrl-0 = <&msmgpio_leds>,
-			    <&pm8916_gpios_leds>,
-			    <&pm8916_mpps_leds>;
-
-		compatible = "gpio-leds";
-
-		led@1 {
-			label = "apq8016-sbc:green:user1";
-			gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-			default-state = "off";
-		};
-
-		led@2 {
-			label = "apq8016-sbc:green:user2";
-			gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-			default-state = "off";
-		};
-
-		led@3 {
-			label = "apq8016-sbc:green:user3";
-			gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc1";
-			default-state = "off";
-		};
-
-		led@4 {
-			label = "apq8016-sbc:green:user4";
-			gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "none";
-			panic-indicator;
-			default-state = "off";
-		};
-
-		led@5 {
-			label = "apq8016-sbc:yellow:wlan";
-			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0tx";
-			default-state = "off";
-		};
-
-		led@6 {
-			label = "apq8016-sbc:blue:bt";
-			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "bluetooth-power";
-			default-state = "off";
-		};
-	};
-};
-
-&blsp_dma {
-	status = "okay";
-};
-
-&blsp_i2c2 {
-	/* On Low speed expansion */
-	status = "okay";
-	label = "LS-I2C0";
-};
-
-&blsp_i2c4 {
-	/* On High speed expansion */
-	status = "okay";
-	label = "HS-I2C2";
-
-	adv_bridge: bridge@39 {
-		status = "okay";
-
-		compatible = "adi,adv7533";
-		reg = <0x39>;
-
-		interrupt-parent = <&msmgpio>;
-		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
-
-		adi,dsi-lanes = <4>;
-		clocks = <&rpmcc RPM_SMD_BB_CLK2>;
-		clock-names = "cec";
-
-		pd-gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
-
-		avdd-supply = <&pm8916_l6>;
-		v1p2-supply = <&pm8916_l6>;
-		v3p3-supply = <&pm8916_l17>;
-
-		pinctrl-names = "default","sleep";
-		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
-		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
-		#sound-dai-cells = <1>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				adv7533_in: endpoint {
-					remote-endpoint = <&dsi0_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-				adv7533_out: endpoint {
-					remote-endpoint = <&hdmi_con>;
-				};
-			};
-		};
-	};
-};
-
-&blsp_i2c6 {
-	/* On Low speed expansion */
-	status = "okay";
-	label = "LS-I2C1";
-};
-
-&blsp_spi3 {
-	/* On High speed expansion */
-	status = "okay";
-	label = "HS-SPI1";
-};
-
-&blsp_spi5 {
-	/* On Low speed expansion */
-	status = "okay";
-	label = "LS-SPI0";
-};
-
-&blsp1_uart1 {
-	status = "okay";
-	label = "LS-UART0";
-};
-
-&blsp1_uart2 {
-	status = "okay";
-	label = "LS-UART1";
-};
-
-&camss {
-	status = "okay";
-	ports {
-		port@0 {
-			reg = <0>;
-			csiphy0_ep: endpoint {
-				clock-lanes = <1>;
-				data-lanes = <0 2>;
-				remote-endpoint = <&ov5640_ep>;
-				status = "okay";
-			};
-		};
-	};
-};
-
-&cci {
-	status = "okay";
-};
-
-&cci_i2c0 {
-	camera_rear@3b {
-		compatible = "ovti,ov5640";
-		reg = <0x3b>;
-
-		enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&camera_rear_default>;
-
-		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
-		clock-names = "xclk";
-		clock-frequency = <23880000>;
-
-		vdddo-supply = <&camera_vdddo_1v8>;
-		vdda-supply = <&camera_vdda_2v8>;
-		vddd-supply = <&camera_vddd_1v5>;
-
-		/* No camera mezzanine by default */
-		status = "disabled";
-
-		port {
-			ov5640_ep: endpoint {
-				clock-lanes = <1>;
-				data-lanes = <0 2>;
-				remote-endpoint = <&csiphy0_ep>;
-			};
-		};
-	};
-};
-
-&dsi0_out {
-	data-lanes = <0 1 2 3>;
-	remote-endpoint = <&adv7533_in>;
-};
-
-&lpass {
-	status = "okay";
-};
-
-&mdss {
-	status = "okay";
-};
-
-&pm8916_resin {
-	status = "okay";
-	linux,code = <KEY_VOLUMEDOWN>;
-};
-
-&pronto {
-	status = "okay";
-};
-
-&sdhc_1 {
-	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
-};
-
-&sdhc_2 {
-	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
-
-	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
-};
-
-&sound {
-	status = "okay";
-
-	pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act &ext_mclk_tlmm_lines_act>;
-	pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus &ext_mclk_tlmm_lines_sus>;
-	pinctrl-names = "default", "sleep";
-	qcom,model = "DB410c";
-	qcom,audio-routing =
-		"AMIC2", "MIC BIAS Internal2",
-		"AMIC3", "MIC BIAS External1";
-
-	external-dai-link@0 {
-		link-name = "ADV7533";
-		cpu {
-			sound-dai = <&lpass MI2S_QUATERNARY>;
-		};
-		codec {
-			sound-dai = <&adv_bridge 0>;
-		};
-	};
-
-	internal-codec-playback-dai-link@0 {
-		link-name = "WCD";
-		cpu {
-			sound-dai = <&lpass MI2S_PRIMARY>;
-		};
-		codec {
-			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
-		};
-	};
-
-	internal-codec-capture-dai-link@0 {
-		link-name = "WCD-Capture";
-		cpu {
-			sound-dai = <&lpass MI2S_TERTIARY>;
-		};
-		codec {
-			sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
-		};
-	};
-};
-
-&usb {
-	status = "okay";
-	extcon = <&usb_id>, <&usb_id>;
-
-	pinctrl-names = "default", "device";
-	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
-	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
-};
-
-&usb_hs_phy {
-	extcon = <&usb_id>;
-};
-
-&wcd_codec {
-	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-	clock-names = "mclk";
-	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-};
-
-/* Enable CoreSight */
-&cti0 { status = "okay"; };
-&cti1 { status = "okay"; };
-&cti12 { status = "okay"; };
-&cti13 { status = "okay"; };
-&cti14 { status = "okay"; };
-&cti15 { status = "okay"; };
-&debug0 { status = "okay"; };
-&debug1 { status = "okay"; };
-&debug2 { status = "okay"; };
-&debug3 { status = "okay"; };
-&etf { status = "okay"; };
-&etm0 { status = "okay"; };
-&etm1 { status = "okay"; };
-&etm2 { status = "okay"; };
-&etm3 { status = "okay"; };
-&etr { status = "okay"; };
-&funnel0 { status = "okay"; };
-&funnel1 { status = "okay"; };
-&replicator { status = "okay"; };
-&stm { status = "okay"; };
-&tpiu { status = "okay"; };
-
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <375000>;
-		regulator-max-microvolt = <1562000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	l1 {
-		regulator-min-microvolt = <375000>;
-		regulator-max-microvolt = <1525000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	/**
-	 * 1.8v required on LS expansion
-	 * for mezzanine boards
-	 */
-	l15 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-		regulator-always-on;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
-	};
-};
-
-/*
- * 2mA drive strength is not enough when connecting multiple
- * I2C devices with different pull up resistors.
- */
-&i2c2_default {
-	drive-strength = <16>;
-};
-
-&i2c4_default {
-	drive-strength = <16>;
-};
-
-&i2c6_default {
-	drive-strength = <16>;
-};
-
-/*
- * GPIO name legend: proper name = the GPIO line is used as GPIO
- *         NC = not connected (pin out but not routed from the chip to
- *              anything the board)
- *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
- *         LSEC = Low Speed External Connector
- *         HSEC = High Speed External Connector
- *
- * Line names are taken from the schematic "DragonBoard410c"
- * dated monday, august 31, 2015. Page 5 in particular.
- *
- * For the lines routed to the external connectors the
- * lines are named after the 96Boards CE Specification 1.0,
- * Appendix "Expansion Connector Signal Description".
- *
- * When the 96Board naming of a line and the schematic name of
- * the same line are in conflict, the 96Board specification
- * takes precedence, which means that the external UART on the
- * LSEC is named UART0 while the schematic and SoC names this
- * UART3. This is only for the informational lines i.e. "[FOO]",
- * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
- * ones actually used for GPIO.
- */
-
-&msmgpio {
-	gpio-line-names =
-		"[UART0_TX]", /* GPIO_0, LSEC pin 5 */
-		"[UART0_RX]", /* GPIO_1, LSEC pin 7 */
-		"[UART0_CTS_N]", /* GPIO_2, LSEC pin 3 */
-		"[UART0_RTS_N]", /* GPIO_3, LSEC pin 9 */
-		"[UART1_TX]", /* GPIO_4, LSEC pin 11 */
-		"[UART1_RX]", /* GPIO_5, LSEC pin 13 */
-		"[I2C0_SDA]", /* GPIO_8, LSEC pin 17 */
-		"[I2C0_SCL]", /* GPIO_7, LSEC pin 15 */
-		"[SPI1_DOUT]", /* SPI1_MOSI, HSEC pin 1 */
-		"[SPI1_DIN]", /* SPI1_MISO, HSEC pin 11 */
-		"[SPI1_CS]", /* SPI1_CS_N, HSEC pin 7 */
-		"[SPI1_SCLK]", /* SPI1_CLK, HSEC pin 9 */
-		"GPIO-B", /* LS_EXP_GPIO_B, LSEC pin 24 */
-		"GPIO-C", /* LS_EXP_GPIO_C, LSEC pin 25 */
-		"[I2C3_SDA]", /* HSEC pin 38 */
-		"[I2C3_SCL]", /* HSEC pin 36 */
-		"[SPI0_MOSI]", /* LSEC pin 14 */
-		"[SPI0_MISO]", /* LSEC pin 10 */
-		"[SPI0_CS_N]", /* LSEC pin 12 */
-		"[SPI0_CLK]", /* LSEC pin 8 */
-		"HDMI_HPD_N", /* GPIO 20 */
-		"USR_LED_1_CTRL",
-		"[I2C1_SDA]", /* GPIO_22, LSEC pin 21 */
-		"[I2C1_SCL]", /* GPIO_23, LSEC pin 19 */
-		"GPIO-G", /* LS_EXP_GPIO_G, LSEC pin 29 */
-		"GPIO-H", /* LS_EXP_GPIO_H, LSEC pin 30 */
-		"[CSI0_MCLK]", /* HSEC pin 15 */
-		"[CSI1_MCLK]", /* HSEC pin 17 */
-		"GPIO-K", /* LS_EXP_GPIO_K, LSEC pin 33 */
-		"[I2C2_SDA]", /* HSEC pin 34 */
-		"[I2C2_SCL]", /* HSEC pin 32 */
-		"DSI2HDMI_INT_N",
-		"DSI_SW_SEL_APQ",
-		"GPIO-L", /* LS_EXP_GPIO_L, LSEC pin 34 */
-		"GPIO-J", /* LS_EXP_GPIO_J, LSEC pin 32 */
-		"GPIO-I", /* LS_EXP_GPIO_I, LSEC pin 31 */
-		"GPIO-A", /* LS_EXP_GPIO_A, LSEC pin 23 */
-		"FORCED_USB_BOOT",
-		"SD_CARD_DET_N",
-		"[WCSS_BT_SSBI]",
-		"[WCSS_WLAN_DATA_2]", /* GPIO 40 */
-		"[WCSS_WLAN_DATA_1]",
-		"[WCSS_WLAN_DATA_0]",
-		"[WCSS_WLAN_SET]",
-		"[WCSS_WLAN_CLK]",
-		"[WCSS_FM_SSBI]",
-		"[WCSS_FM_SDI]",
-		"[WCSS_BT_DAT_CTL]",
-		"[WCSS_BT_DAT_STB]",
-		"NC",
-		"NC", /* GPIO 50 */
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC", /* GPIO 60 */
-		"NC",
-		"NC",
-		"[CDC_PDM0_CLK]",
-		"[CDC_PDM0_SYNC]",
-		"[CDC_PDM0_TX0]",
-		"[CDC_PDM0_RX0]",
-		"[CDC_PDM0_RX1]",
-		"[CDC_PDM0_RX2]",
-		"GPIO-D", /* LS_EXP_GPIO_D, LSEC pin 26 */
-		"NC", /* GPIO 70 */
-		"NC",
-		"NC",
-		"NC",
-		"NC", /* GPIO 74 */
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"BOOT_CONFIG_0", /* GPIO 80 */
-		"BOOT_CONFIG_1",
-		"BOOT_CONFIG_2",
-		"BOOT_CONFIG_3",
-		"NC",
-		"NC",
-		"BOOT_CONFIG_5",
-		"NC",
-		"NC",
-		"NC",
-		"NC", /* GPIO 90 */
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC", /* GPIO 100 */
-		"NC",
-		"NC",
-		"NC",
-		"SSBI_GPS",
-		"NC",
-		"NC",
-		"KEY_VOLP_N",
-		"NC",
-		"NC",
-		"[LS_EXP_MI2S_WS]", /* GPIO 110 */
-		"NC",
-		"NC",
-		"[LS_EXP_MI2S_SCK]",
-		"[LS_EXP_MI2S_DATA0]",
-		"GPIO-E", /* LS_EXP_GPIO_E, LSEC pin 27 */
-		"NC",
-		"[DSI2HDMI_MI2S_WS]",
-		"[DSI2HDMI_MI2S_SCK]",
-		"[DSI2HDMI_MI2S_DATA0]",
-		"USR_LED_2_CTRL", /* GPIO 120 */
-		"SB_HS_ID";
-
-	msmgpio_leds: msmgpio-leds {
-		pins = "gpio21", "gpio120";
-		function = "gpio";
-
-		output-low;
-	};
-
-	usb_id_default: usb-id-default {
-		pins = "gpio121";
-		function = "gpio";
-
-		drive-strength = <8>;
-		input-enable;
-		bias-pull-up;
-	};
-
-	adv7533_int_active: adv533-int-active {
-		pins = "gpio31";
-		function = "gpio";
-
-		drive-strength = <16>;
-		bias-disable;
-	};
-
-	adv7533_int_suspend: adv7533-int-suspend {
-		pins = "gpio31";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	adv7533_switch_active: adv7533-switch-active {
-		pins = "gpio32";
-		function = "gpio";
-
-		drive-strength = <16>;
-		bias-disable;
-	};
-
-	adv7533_switch_suspend: adv7533-switch-suspend {
-		pins = "gpio32";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	msm_key_volp_n_default: msm-key-volp-n-default {
-		pins = "gpio107";
-		function = "gpio";
-
-		drive-strength = <8>;
-		input-enable;
-		bias-pull-up;
-	};
-};
-
-&pm8916_gpios {
-	gpio-line-names =
-		"USR_LED_3_CTRL",
-		"USR_LED_4_CTRL",
-		"USB_HUB_RESET_N_PM",
-		"USB_SW_SEL_PM";
-
-	usb_hub_reset_pm: usb-hub-reset-pm {
-		pins = "gpio3";
-		function = PMIC_GPIO_FUNC_NORMAL;
-
-		input-disable;
-		output-high;
-	};
-
-	usb_hub_reset_pm_device: usb-hub-reset-pm-device {
-		pins = "gpio3";
-		function = PMIC_GPIO_FUNC_NORMAL;
-
-		output-low;
-	};
-
-	usb_sw_sel_pm: usb-sw-sel-pm {
-		pins = "gpio4";
-		function = PMIC_GPIO_FUNC_NORMAL;
-
-		power-source = <PM8916_GPIO_VPH>;
-		input-disable;
-		output-high;
-	};
-
-	usb_sw_sel_pm_device: usb-sw-sel-pm-device {
-		pins = "gpio4";
-		function = PMIC_GPIO_FUNC_NORMAL;
-
-		power-source = <PM8916_GPIO_VPH>;
-		input-disable;
-		output-low;
-	};
-
-	pm8916_gpios_leds: pm8916-gpios-leds {
-		pins = "gpio1", "gpio2";
-		function = PMIC_GPIO_FUNC_NORMAL;
-
-		output-low;
-	};
-};
-
-&pm8916_mpps {
-	gpio-line-names =
-		"VDD_PX_BIAS",
-		"WLAN_LED_CTRL",
-		"BT_LED_CTRL",
-		"GPIO-F"; /* LS_EXP_GPIO_F, LSEC pin 28 */
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&ls_exp_gpio_f>;
-
-	ls_exp_gpio_f: pm8916-mpp4 {
-		pins = "mpp4";
-		function = "digital";
-
-		output-low;
-		power-source = <PM8916_MPP_L5>;	// 1.8V
-	};
-
-	pm8916_mpps_leds: pm8916-mpps-leds {
-		pins = "mpp2", "mpp3";
-		function = "digital";
-
-		output-low;
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 757afa27424d..d01a512634cf 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -5,9 +5,1077 @@
 
 /dts-v1/;
 
-#include "apq8096-db820c.dtsi"
+#include "msm8996.dtsi"
+#include "pm8994.dtsi"
+#include "pmi8994.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+
+/*
+ * GPIO name legend: proper name = the GPIO line is used as GPIO
+ *         NC      = not connected (pin out but not routed from the chip to
+ *                   anything the board)
+ *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
+ *         LSEC    = Low Speed External Connector
+ *         P HSEC  = Primary High Speed External Connector
+ *         S HSEC  = Secondary High Speed External Connector
+ *         J14     = Camera Connector
+ *         TP      = Test Points
+ *
+ * Line names are taken from the schematic "DragonBoard 820c",
+ * drawing no: LM25-P2751-1
+ *
+ * For the lines routed to the external connectors the
+ * lines are named after the 96Boards CE Specification 1.0,
+ * Appendix "Expansion Connector Signal Description".
+ *
+ * When the 96Board naming of a line and the schematic name of
+ * the same line are in conflict, the 96Board specification
+ * takes precedence, which means that the external UART on the
+ * LSEC is named UART0 while the schematic and SoC names this
+ * UART3. This is only for the informational lines i.e. "[FOO]",
+ * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
+ * ones actually used for GPIO.
+ */
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
 	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
+
+	aliases {
+		serial0 = &blsp2_uart2;
+		serial1 = &blsp2_uart3;
+		serial2 = &blsp1_uart2;
+		i2c0	= &blsp1_i2c3;
+		i2c1	= &blsp2_i2c1;
+		i2c2	= &blsp2_i2c1;
+		spi0	= &blsp1_spi1;
+		spi1	= &blsp2_spi6;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		divclk4: divclk4 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "divclk4";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&divclk4_pin_a>;
+		};
+
+		div1_mclk: divclk1 {
+			compatible = "gpio-gate-clock";
+			pinctrl-0 = <&audio_mclk>;
+			pinctrl-names = "default";
+			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+			#clock-cells = <0>;
+			enable-gpios = <&pm8994_gpios 15 0>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&volume_up_gpio>;
+
+		button@0 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	usb2_id: usb2-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_vbus_det_gpio>;
+	};
+
+	usb3_id: usb3-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_vbus_det_gpio>;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	wlan_en: wlan-en-1-8v {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en_gpios>;
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&pm8994_gpios 8 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+};
+
+&blsp1_i2c3 {
+	/* On Low speed expansion */
+	label = "LS-I2C0";
+	status = "okay";
+};
+
+&blsp1_spi1 {
+	/* On Low speed expansion */
+	label = "LS-SPI0";
+	status = "okay";
+};
+
+&blsp1_uart2 {
+	label = "BT-UART";
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6174-bt";
+
+		/* bt_disable_n gpio */
+		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+
+		clocks = <&divclk4>;
+	};
+};
+
+&adsp_pil {
+	status = "okay";
+};
+
+&blsp2_i2c1 {
+	/* On High speed expansion */
+	label = "HS-I2C2";
+	status = "okay";
+};
+
+&blsp2_i2c1 {
+	/* On Low speed expansion */
+	label = "LS-I2C1";
+	status = "okay";
+};
+
+&blsp2_spi6 {
+	/* On High speed expansion */
+	label = "HS-SPI1";
+	status = "okay";
+};
+
+&blsp2_uart2 {
+	label = "LS-UART1";
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart2_2pins_default>;
+	pinctrl-1 = <&blsp2_uart2_2pins_sleep>;
+};
+
+&blsp2_uart3 {
+	label = "LS-UART0";
+	status = "disabled";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart3_4pins_default>;
+	pinctrl-1 = <&blsp2_uart3_4pins_sleep>;
+};
+
+&camss {
+	vdda-supply = <&vreg_l2a_1p25>;
+};
+
+&gpu {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
+	pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
+
+	core-vdda-supply = <&vreg_l12a_1p8>;
+	core-vcc-supply = <&vreg_s4a_1p8>;
+};
+
+&hdmi_phy {
+	status = "okay";
+
+	vddio-supply = <&vreg_l12a_1p8>;
+	vcca-supply = <&vreg_l28a_0p925>;
+	#phy-cells = <0>;
+};
+
+&hsusb_phy1 {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
+&hsusb_phy2 {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
+&mdp {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mmcc {
+	vdd-gfx-supply = <&vdd_gfx>;
+};
+
+&pm8994_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
+&tlmm {
+	gpio-line-names =
+		"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
+		"[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
+		"[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
+		"[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
+		"[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
+		"[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
+		"[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
+		"[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
+		"GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
+		"TP93", /* GPIO_9 */
+		"GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
+		"[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
+		"NC", /* GPIO_12 */
+		"[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
+		"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
+		"[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
+		"TP99", /* GPIO_16 */
+		"[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
+		"[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
+		"[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
+		"[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
+		"FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
+		"FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
+		"GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
+		"GPIO-D", /* GPIO_24, LSEC pin 26 */
+		"GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
+		"GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
+		"BLSP6_I2C_SDA", /* GPIO_27 */
+		"BLSP6_I2C_SCL", /* GPIO_28 */
+		"GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
+		"GPIO30", /* GPIO_30, S HSEC pin 4 */
+		"HDMI_CEC", /* GPIO_31 */
+		"HDMI_DDC_CLOCK", /* GPIO_32 */
+		"HDMI_DDC_DATA", /* GPIO_33 */
+		"HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
+		"PCIE0_RST_N", /* GPIO_35 */
+		"PCIE0_CLKREQ_N", /* GPIO_36 */
+		"PCIE0_WAKE", /* GPIO_37 */
+		"SD_CARD_DET_N", /* GPIO_38 */
+		"TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
+		"W_DISABLE_N", /* GPIO_40 */
+		"[BLSP9_UART_TX]", /* GPIO_41 */
+		"[BLSP9_UART_RX]", /* GPIO_42 */
+		"[BLSP2_UART_CTS_N]", /* GPIO_43 */
+		"[BLSP2_UART_RFR_N]", /* GPIO_44 */
+		"[BLSP3_UART_TX]", /* GPIO_45 */
+		"[BLSP3_UART_RX]", /* GPIO_46 */
+		"[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
+		"[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
+		"[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
+		"[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
+		"[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
+		"[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
+		"[CODEC_INT1_N]", /* GPIO_53 */
+		"[CODEC_INT2_N]", /* GPIO_54 */
+		"[BLSP7_I2C_SDA]", /* GPIO_55 */
+		"[BLSP7_I2C_SCL]", /* GPIO_56 */
+		"MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
+		"[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
+		"[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
+		"[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
+		"[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
+		"GPIO-E", /* GPIO_62, LSEC pin 27 */
+		"TP87", /* GPIO_63 */
+		"[CODEC_RST_N]", /* GPIO_64 */
+		"[PCM1_CLK]", /* GPIO_65 */
+		"[PCM1_SYNC]", /* GPIO_66 */
+		"[PCM1_DIN]", /* GPIO_67 */
+		"[PCM1_DOUT]", /* GPIO_68 */
+		"AUDIO_REF_CLK", /* GPIO_69 */
+		"SLIMBUS_CLK", /* GPIO_70 */
+		"SLIMBUS_DATA0", /* GPIO_71 */
+		"SLIMBUS_DATA1", /* GPIO_72 */
+		"NC", /* GPIO_73 */
+		"NC", /* GPIO_74 */
+		"NC", /* GPIO_75 */
+		"NC", /* GPIO_76 */
+		"TP94", /* GPIO_77 */
+		"NC", /* GPIO_78 */
+		"TP95", /* GPIO_79 */
+		"GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
+		"TP88", /* GPIO_81 */
+		"TP89", /* GPIO_82 */
+		"TP90", /* GPIO_83 */
+		"TP91", /* GPIO_84 */
+		"[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
+		"[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
+		"[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
+		"[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
+		"TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
+		"TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
+		"TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
+		"NC", /* GPIO_92 */
+		"TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
+		"TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
+		"TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
+		"TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
+		"NC", /* GPIO_97 */
+		"CAM1_STANDBY_N", /* GPIO_98 */
+		"NC", /* GPIO_99 */
+		"NC", /* GPIO_100 */
+		"[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
+		"BOOT_CONFIG1", /* GPIO_102 */
+		"USB_HUB_RESET", /* GPIO_103 */
+		"CAM1_RST_N", /* GPIO_104 */
+		"NC", /* GPIO_105 */
+		"NC", /* GPIO_106 */
+		"NC", /* GPIO_107 */
+		"NC", /* GPIO_108 */
+		"NC", /* GPIO_109 */
+		"NC", /* GPIO_110 */
+		"NC", /* GPIO_111 */
+		"NC", /* GPIO_112 */
+		"PMI8994_BUA", /* GPIO_113 */
+		"PCIE2_RST_N", /* GPIO_114 */
+		"PCIE2_CLKREQ_N", /* GPIO_115 */
+		"PCIE2_WAKE", /* GPIO_116 */
+		"SSC_IRQ_0", /* GPIO_117 */
+		"SSC_IRQ_1", /* GPIO_118 */
+		"SSC_IRQ_2", /* GPIO_119 */
+		"NC", /* GPIO_120 */
+		"GPIO121", /* GPIO_121, S HSEC pin 2 */
+		"NC", /* GPIO_122 */
+		"SSC_IRQ_6", /* GPIO_123 */
+		"SSC_IRQ_7", /* GPIO_124 */
+		"GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
+		"BOOT_CONFIG5", /* GPIO_126 */
+		"NC", /* GPIO_127 */
+		"NC", /* GPIO_128 */
+		"BOOT_CONFIG7", /* GPIO_129 */
+		"PCIE1_RST_N", /* GPIO_130 */
+		"PCIE1_CLKREQ_N", /* GPIO_131 */
+		"PCIE1_WAKE", /* GPIO_132 */
+		"GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
+		"NC", /* GPIO_134 */
+		"NC", /* GPIO_135 */
+		"BOOT_CONFIG8", /* GPIO_136 */
+		"NC", /* GPIO_137 */
+		"NC", /* GPIO_138 */
+		"GPS_SSBI2", /* GPIO_139 */
+		"GPS_SSBI1", /* GPIO_140 */
+		"NC", /* GPIO_141 */
+		"NC", /* GPIO_142 */
+		"NC", /* GPIO_143 */
+		"BOOT_CONFIG6", /* GPIO_144 */
+		"NC", /* GPIO_145 */
+		"NC", /* GPIO_146 */
+		"NC", /* GPIO_147 */
+		"NC", /* GPIO_148 */
+		"NC"; /* GPIO_149 */
+
+	sdc2_cd_on: sdc2_cd_on {
+		mux {
+			pins = "gpio38";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio38";
+			bias-pull-up;		/* pull up */
+			drive-strength = <16>;	/* 16 MA */
+		};
+	};
+
+	sdc2_cd_off: sdc2_cd_off {
+		mux {
+			pins = "gpio38";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio38";
+			bias-pull-up;		/* pull up */
+			drive-strength = <2>;	/* 2 MA */
+		};
+	};
+
+	hdmi_hpd_active: hdmi_hpd_active {
+		mux {
+			pins = "gpio34";
+			function = "hdmi_hot";
+		};
+
+		config {
+			pins = "gpio34";
+			bias-pull-down;
+			drive-strength = <16>;
+		};
+	};
+
+	hdmi_hpd_suspend: hdmi_hpd_suspend {
+		mux {
+			pins = "gpio34";
+			function = "hdmi_hot";
+		};
+
+		config {
+			pins = "gpio34";
+			bias-pull-down;
+			drive-strength = <2>;
+		};
+	};
+
+	hdmi_ddc_active: hdmi_ddc_active {
+		mux {
+			pins = "gpio32", "gpio33";
+			function = "hdmi_ddc";
+		};
+
+		config {
+			pins = "gpio32", "gpio33";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	hdmi_ddc_suspend: hdmi_ddc_suspend {
+		mux {
+			pins = "gpio32", "gpio33";
+			function = "hdmi_ddc";
+		};
+
+		config {
+			pins = "gpio32", "gpio33";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+};
+
+&pcie0 {
+	status = "okay";
+	perst-gpio = <&tlmm 35 GPIO_ACTIVE_LOW>;
+	vddpe-3v3-supply = <&wlan_en>;
+	vdda-supply = <&vreg_l28a_0p925>;
+};
+
+&pcie1 {
+	status = "okay";
+	perst-gpio = <&tlmm 130 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&vreg_l28a_0p925>;
+};
+
+&pcie2 {
+	status = "okay";
+	perst-gpio = <&tlmm 114 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&vreg_l28a_0p925>;
+};
+
+&pcie_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+};
+
+&pm8994_gpios {
+	gpio-line-names =
+		"NC",
+		"KEY_VOLP_N",
+		"NC",
+		"BL1_PWM",
+		"GPIO-F", /* BL0_PWM, LSEC pin 28 */
+		"BL1_EN",
+		"NC",
+		"WLAN_EN",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"DIVCLK1",
+		"DIVCLK2",
+		"DIVCLK3",
+		"DIVCLK4",
+		"BT_EN",
+		"PMIC_SLB",
+		"PMIC_BUA",
+		"USB_VBUS_DET";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ls_exp_gpio_f &bt_en_gpios>;
+
+	ls_exp_gpio_f: pm8994_gpio5 {
+		pinconf {
+			pins = "gpio5";
+			output-low;
+			power-source = <2>; // PM8994_GPIO_S4, 1.8V
+		};
+	};
+
+	bt_en_gpios: bt_en_gpios {
+		pinconf {
+			pins = "gpio19";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
+	wlan_en_gpios: wlan_en_gpios {
+		pinconf {
+			pins = "gpio8";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
+	audio_mclk: clk_div1 {
+		pinconf {
+			pins = "gpio15";
+			function = "func1";
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+
+	volume_up_gpio: pm8996_gpio2 {
+		pinconf {
+			pins = "gpio2";
+			function = "normal";
+			input-enable;
+			drive-push-pull;
+			bias-pull-up;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+
+	divclk4_pin_a: divclk4 {
+		pinconf {
+			pins = "gpio18";
+			function = PMIC_GPIO_FUNC_FUNC2;
+
+			bias-disable;
+			power-source = <PM8994_GPIO_S4>;
+		};
+	};
+
+	usb3_vbus_det_gpio: pm8996_gpio22 {
+		pinconf {
+			pins = "gpio22";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+};
+
+&pm8994_mpps {
+	gpio-line-names =
+		"VDDPX_BIAS",
+		"WIFI_LED",
+		"NC",
+		"BT_LED",
+		"PM_MPP05",
+		"PM_MPP06",
+		"PM_MPP07",
+		"NC";
+};
+
+&pm8994_spmi_regulators {
+	qcom,saw-reg = <&saw3>;
+	s9 {
+		qcom,saw-slave;
+	};
+	s10 {
+		qcom,saw-slave;
+	};
+	s11 {
+		qcom,saw-leader;
+		regulator-always-on;
+		regulator-min-microvolt = <980000>;
+		regulator-max-microvolt = <980000>;
+	};
+};
+
+&pmi8994_gpios {
+	gpio-line-names =
+		"NC",
+		"SPKR_AMP_EN1",
+		"SPKR_AMP_EN2",
+		"TP61",
+		"NC",
+		"USB2_VBUS_DET",
+		"NC",
+		"NC",
+		"NC",
+		"NC";
+
+	usb2_vbus_det_gpio: pmi8996_gpio6 {
+		pinconf {
+			pins = "gpio6";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+};
+
+&pmi8994_spmi_regulators {
+	vdd_gfx: s2@1700 {
+		reg = <0x1700 0x100>;
+		regulator-name = "VDD_GFX";
+		regulator-min-microvolt = <980000>;
+		regulator-max-microvolt = <980000>;
+	};
+};
+
+&rpm_requests {
+	pm8994-regulators {
+		compatible = "qcom,rpm-pm8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_s8-supply = <&vph_pwr>;
+		vdd_s9-supply = <&vph_pwr>;
+		vdd_s10-supply = <&vph_pwr>;
+		vdd_s11-supply = <&vph_pwr>;
+		vdd_s12-supply = <&vph_pwr>;
+		vdd_l1-supply = <&vreg_s1b_1p025>;
+		vdd_l2_l26_l28-supply = <&vreg_s3a_1p3>;
+		vdd_l3_l11-supply = <&vreg_s3a_1p3>;
+		vdd_l4_l27_l31-supply = <&vreg_s3a_1p3>;
+		vdd_l5_l7-supply = <&vreg_s5a_2p15>;
+		vdd_l6_l12_l32-supply = <&vreg_s5a_2p15>;
+		vdd_l8_l16_l30-supply = <&vph_pwr>;
+		vdd_l9_l10_l18_l22-supply = <&vph_pwr_bbyp>;
+		vdd_l13_l19_l23_l24-supply = <&vph_pwr_bbyp>;
+		vdd_l14_l15-supply = <&vreg_s5a_2p15>;
+		vdd_l17_l29-supply = <&vph_pwr_bbyp>;
+		vdd_l20_l21-supply = <&vph_pwr_bbyp>;
+		vdd_l25-supply = <&vreg_s3a_1p3>;
+		vdd_lvs1_lvs2-supply = <&vreg_s4a_1p8>;
+
+		vreg_s3a_1p3: s3 {
+			regulator-name = "vreg_s3a_1p3";
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		/**
+		 * 1.8v required on LS expansion
+		 * for mezzanine boards
+		 */
+		vreg_s4a_1p8: s4 {
+			regulator-name = "vreg_s4a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+		vreg_s5a_2p15: s5 {
+			regulator-name = "vreg_s5a_2p15";
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+		};
+		vreg_s7a_1p0: s7 {
+			regulator-name = "vreg_s7a_1p0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		vreg_l1a_1p0: l1 {
+			regulator-name = "vreg_l1a_1p0";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l2a_1p25: l2 {
+			regulator-name = "vreg_l2a_1p25";
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1250000>;
+		};
+		vreg_l3a_0p875: l3 {
+			regulator-name = "vreg_l3a_0p875";
+			regulator-min-microvolt = <850000>;
+			regulator-max-microvolt = <850000>;
+		};
+		vreg_l4a_1p225: l4 {
+			regulator-name = "vreg_l4a_1p225";
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+		vreg_l6a_1p2: l6 {
+			regulator-name = "vreg_l6a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vreg_l8a_1p8: l8 {
+			regulator-name = "vreg_l8a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l9a_1p8: l9 {
+			regulator-name = "vreg_l9a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l10a_1p8: l10 {
+			regulator-name = "vreg_l10a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l11a_1p15: l11 {
+			regulator-name = "vreg_l11a_1p15";
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+		vreg_l12a_1p8: l12 {
+			regulator-name = "vreg_l12a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l13a_2p95: l13 {
+			regulator-name = "vreg_l13a_2p95";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		vreg_l14a_1p8: l14 {
+			regulator-name = "vreg_l14a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l15a_1p8: l15 {
+			regulator-name = "vreg_l15a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l16a_2p7: l16 {
+			regulator-name = "vreg_l16a_2p7";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+		vreg_l17a_2p8: l17 {
+			regulator-name = "vreg_l17a_2p8";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+		};
+		vreg_l18a_2p85: l18 {
+			regulator-name = "vreg_l18a_2p85";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2900000>;
+		};
+		vreg_l19a_2p8: l19 {
+			regulator-name = "vreg_l19a_2p8";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		vreg_l20a_2p95: l20 {
+			regulator-name = "vreg_l20a_2p95";
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+		vreg_l21a_2p95: l21 {
+			regulator-name = "vreg_l21a_2p95";
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+		vreg_l22a_3p0: l22 {
+			regulator-name = "vreg_l22a_3p0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+		vreg_l23a_2p8: l23 {
+			regulator-name = "vreg_l23a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l24a_3p075: l24 {
+			regulator-name = "vreg_l24a_3p075";
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+		vreg_l25a_1p2: l25 {
+			regulator-name = "vreg_l25a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
+		};
+		vreg_l26a_0p8: l27 {
+			regulator-name = "vreg_l26a_0p8";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l28a_0p925: l28 {
+			regulator-name = "vreg_l28a_0p925";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <925000>;
+			regulator-allow-set-load;
+		};
+		vreg_l29a_2p8: l29 {
+			regulator-name = "vreg_l29a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l30a_1p8: l30 {
+			regulator-name = "vreg_l30a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l32a_1p8: l32 {
+			regulator-name = "vreg_l32a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_lvs1a_1p8: lvs1 {
+			regulator-name = "vreg_lvs1a_1p8";
+		};
+
+		vreg_lvs2a_1p8: lvs2 {
+			regulator-name = "vreg_lvs2a_1p8";
+		};
+	};
+
+	pmi8994-regulators {
+		compatible = "qcom,rpm-pmi8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_bst_byp-supply = <&vph_pwr>;
+
+		vph_pwr_bbyp: boost-bypass {
+			regulator-name = "vph_pwr_bbyp";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_s1b_1p025: s1 {
+			regulator-name = "vreg_s1b_1p025";
+			regulator-min-microvolt = <1025000>;
+			regulator-max-microvolt = <1025000>;
+		};
+	};
+};
+
+&sdhc2 {
+	/* External SD card */
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_state_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_state_off &sdc2_cd_off>;
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vreg_l13a_2p95>;
+	status = "okay";
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
+&sound {
+	compatible = "qcom,apq8096-sndcard";
+	model = "DB820c";
+	audio-routing =	"RX_BIAS", "MCLK",
+		"MM_DL1",  "MultiMedia1 Playback",
+		"MM_DL2",  "MultiMedia2 Playback",
+		"MultiMedia3 Capture", "MM_UL3";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI";
+		cpu {
+			sound-dai = <&q6afedai HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&hdmi 0>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_6_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+	};
+
+		codec {
+			sound-dai = <&wcd9335 6>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9335 1>;
+		};
+	};
+};
+
+&ufsphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vddp-ref-clk-supply = <&vreg_l25a_1p2>;
+};
+
+&ufshc {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l25a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+
+	vcc-max-microamp = <600000>;
+	vccq-max-microamp = <450000>;
+	vccq2-max-microamp = <450000>;
+};
+
+&usb2 {
+	status = "okay";
+	extcon = <&usb2_id>;
+
+	dwc3@7600000 {
+		extcon = <&usb2_id>;
+		dr_mode = "otg";
+		maximum-speed = "high-speed";
+	};
+};
+
+&usb3 {
+	status = "okay";
+	extcon = <&usb3_id>;
+
+	dwc3@6a00000 {
+		extcon = <&usb3_id>;
+		dr_mode = "otg";
+	};
+};
+
+&usb3phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+
+};
+
+&venus {
+	status = "okay";
+};
+
+&wcd9335 {
+	clock-names = "mclk", "slimbus";
+	clocks = <&div1_mclk>,
+		 <&rpmcc RPM_SMD_BB_CLK1>;
+
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
deleted file mode 100644
index 51e17094d7b1..000000000000
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ /dev/null
@@ -1,1105 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
- */
-
-#include "msm8996.dtsi"
-#include "pm8994.dtsi"
-#include "pmi8994.dtsi"
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-#include <dt-bindings/sound/qcom,q6afe.h>
-#include <dt-bindings/sound/qcom,q6asm.h>
-
-/*
- * GPIO name legend: proper name = the GPIO line is used as GPIO
- *         NC      = not connected (pin out but not routed from the chip to
- *                   anything the board)
- *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
- *         LSEC    = Low Speed External Connector
- *         P HSEC  = Primary High Speed External Connector
- *         S HSEC  = Secondary High Speed External Connector
- *         J14     = Camera Connector
- *         TP      = Test Points
- *
- * Line names are taken from the schematic "DragonBoard 820c",
- * drawing no: LM25-P2751-1
- *
- * For the lines routed to the external connectors the
- * lines are named after the 96Boards CE Specification 1.0,
- * Appendix "Expansion Connector Signal Description".
- *
- * When the 96Board naming of a line and the schematic name of
- * the same line are in conflict, the 96Board specification
- * takes precedence, which means that the external UART on the
- * LSEC is named UART0 while the schematic and SoC names this
- * UART3. This is only for the informational lines i.e. "[FOO]",
- * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
- * ones actually used for GPIO.
- */
-
-/ {
-	aliases {
-		serial0 = &blsp2_uart2;
-		serial1 = &blsp2_uart3;
-		serial2 = &blsp1_uart2;
-		i2c0	= &blsp1_i2c3;
-		i2c1	= &blsp2_i2c1;
-		i2c2	= &blsp2_i2c1;
-		spi0	= &blsp1_spi1;
-		spi1	= &blsp2_spi6;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	clocks {
-		compatible = "simple-bus";
-		divclk4: divclk4 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk4";
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk4_pin_a>;
-		};
-
-		div1_mclk: divclk1 {
-			compatible = "gpio-gate-clock";
-			pinctrl-0 = <&audio_mclk>;
-			pinctrl-names = "default";
-			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
-			#clock-cells = <0>;
-			enable-gpios = <&pm8994_gpios 15 0>;
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		autorepeat;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&volume_up_gpio>;
-
-		button@0 {
-			label = "Volume Up";
-			linux,code = <KEY_VOLUMEUP>;
-			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	usb2_id: usb2-id {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb2_vbus_det_gpio>;
-	};
-
-	usb3_id: usb3-id {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb3_vbus_det_gpio>;
-	};
-
-	vph_pwr: vph-pwr-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vph_pwr";
-		regulator-always-on;
-		regulator-boot-on;
-
-		regulator-min-microvolt = <3700000>;
-		regulator-max-microvolt = <3700000>;
-	};
-
-	wlan_en: wlan-en-1-8v {
-		pinctrl-names = "default";
-		pinctrl-0 = <&wlan_en_gpios>;
-		compatible = "regulator-fixed";
-		regulator-name = "wlan-en-regulator";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-
-		gpio = <&pm8994_gpios 8 0>;
-
-		/* WLAN card specific delay */
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-};
-
-&blsp1_i2c3 {
-	/* On Low speed expansion */
-	label = "LS-I2C0";
-	status = "okay";
-};
-
-&blsp1_spi1 {
-	/* On Low speed expansion */
-	label = "LS-SPI0";
-	status = "okay";
-};
-
-&blsp1_uart2 {
-	label = "BT-UART";
-	status = "okay";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&blsp1_uart2_default>;
-	pinctrl-1 = <&blsp1_uart2_sleep>;
-
-	bluetooth {
-		compatible = "qcom,qca6174-bt";
-
-		/* bt_disable_n gpio */
-		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
-
-		clocks = <&divclk4>;
-	};
-};
-
-&adsp_pil {
-	status = "okay";
-};
-
-&blsp2_i2c1 {
-	/* On High speed expansion */
-	label = "HS-I2C2";
-	status = "okay";
-};
-
-&blsp2_i2c1 {
-	/* On Low speed expansion */
-	label = "LS-I2C1";
-	status = "okay";
-};
-
-&blsp2_spi6 {
-	/* On High speed expansion */
-	label = "HS-SPI1";
-	status = "okay";
-};
-
-&blsp2_uart2 {
-	label = "LS-UART1";
-	status = "okay";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&blsp2_uart2_2pins_default>;
-	pinctrl-1 = <&blsp2_uart2_2pins_sleep>;
-};
-
-&blsp2_uart3 {
-	label = "LS-UART0";
-	status = "disabled";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&blsp2_uart3_4pins_default>;
-	pinctrl-1 = <&blsp2_uart3_4pins_sleep>;
-};
-
-&camss {
-	vdda-supply = <&vreg_l2a_1p25>;
-};
-
-&gpu {
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
-	pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
-
-	core-vdda-supply = <&vreg_l12a_1p8>;
-	core-vcc-supply = <&vreg_s4a_1p8>;
-};
-
-&hdmi_phy {
-	status = "okay";
-
-	vddio-supply = <&vreg_l12a_1p8>;
-	vcca-supply = <&vreg_l28a_0p925>;
-	#phy-cells = <0>;
-};
-
-&hsusb_phy1 {
-	status = "okay";
-
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
-};
-
-&hsusb_phy2 {
-	status = "okay";
-
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
-};
-
-&mdp {
-	status = "okay";
-};
-
-&mdss {
-	status = "okay";
-};
-
-&mmcc {
-	vdd-gfx-supply = <&vdd_gfx>;
-};
-
-&pm8994_resin {
-	status = "okay";
-	linux,code = <KEY_VOLUMEDOWN>;
-};
-
-&tlmm {
-	gpio-line-names =
-		"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
-		"[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
-		"[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
-		"[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
-		"[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
-		"[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
-		"[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
-		"[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
-		"GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
-		"TP93", /* GPIO_9 */
-		"GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
-		"[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
-		"NC", /* GPIO_12 */
-		"[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
-		"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
-		"[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
-		"TP99", /* GPIO_16 */
-		"[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
-		"[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
-		"[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
-		"[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
-		"FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
-		"FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
-		"GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
-		"GPIO-D", /* GPIO_24, LSEC pin 26 */
-		"GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
-		"GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
-		"BLSP6_I2C_SDA", /* GPIO_27 */
-		"BLSP6_I2C_SCL", /* GPIO_28 */
-		"GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
-		"GPIO30", /* GPIO_30, S HSEC pin 4 */
-		"HDMI_CEC", /* GPIO_31 */
-		"HDMI_DDC_CLOCK", /* GPIO_32 */
-		"HDMI_DDC_DATA", /* GPIO_33 */
-		"HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
-		"PCIE0_RST_N", /* GPIO_35 */
-		"PCIE0_CLKREQ_N", /* GPIO_36 */
-		"PCIE0_WAKE", /* GPIO_37 */
-		"SD_CARD_DET_N", /* GPIO_38 */
-		"TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
-		"W_DISABLE_N", /* GPIO_40 */
-		"[BLSP9_UART_TX]", /* GPIO_41 */
-		"[BLSP9_UART_RX]", /* GPIO_42 */
-		"[BLSP2_UART_CTS_N]", /* GPIO_43 */
-		"[BLSP2_UART_RFR_N]", /* GPIO_44 */
-		"[BLSP3_UART_TX]", /* GPIO_45 */
-		"[BLSP3_UART_RX]", /* GPIO_46 */
-		"[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
-		"[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
-		"[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
-		"[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
-		"[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
-		"[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
-		"[CODEC_INT1_N]", /* GPIO_53 */
-		"[CODEC_INT2_N]", /* GPIO_54 */
-		"[BLSP7_I2C_SDA]", /* GPIO_55 */
-		"[BLSP7_I2C_SCL]", /* GPIO_56 */
-		"MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
-		"[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
-		"[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
-		"[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
-		"[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
-		"GPIO-E", /* GPIO_62, LSEC pin 27 */
-		"TP87", /* GPIO_63 */
-		"[CODEC_RST_N]", /* GPIO_64 */
-		"[PCM1_CLK]", /* GPIO_65 */
-		"[PCM1_SYNC]", /* GPIO_66 */
-		"[PCM1_DIN]", /* GPIO_67 */
-		"[PCM1_DOUT]", /* GPIO_68 */
-		"AUDIO_REF_CLK", /* GPIO_69 */
-		"SLIMBUS_CLK", /* GPIO_70 */
-		"SLIMBUS_DATA0", /* GPIO_71 */
-		"SLIMBUS_DATA1", /* GPIO_72 */
-		"NC", /* GPIO_73 */
-		"NC", /* GPIO_74 */
-		"NC", /* GPIO_75 */
-		"NC", /* GPIO_76 */
-		"TP94", /* GPIO_77 */
-		"NC", /* GPIO_78 */
-		"TP95", /* GPIO_79 */
-		"GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
-		"TP88", /* GPIO_81 */
-		"TP89", /* GPIO_82 */
-		"TP90", /* GPIO_83 */
-		"TP91", /* GPIO_84 */
-		"[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
-		"[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
-		"[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
-		"[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
-		"TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
-		"TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
-		"TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
-		"NC", /* GPIO_92 */
-		"TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
-		"TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
-		"TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
-		"TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
-		"NC", /* GPIO_97 */
-		"CAM1_STANDBY_N", /* GPIO_98 */
-		"NC", /* GPIO_99 */
-		"NC", /* GPIO_100 */
-		"[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
-		"BOOT_CONFIG1", /* GPIO_102 */
-		"USB_HUB_RESET", /* GPIO_103 */
-		"CAM1_RST_N", /* GPIO_104 */
-		"NC", /* GPIO_105 */
-		"NC", /* GPIO_106 */
-		"NC", /* GPIO_107 */
-		"NC", /* GPIO_108 */
-		"NC", /* GPIO_109 */
-		"NC", /* GPIO_110 */
-		"NC", /* GPIO_111 */
-		"NC", /* GPIO_112 */
-		"PMI8994_BUA", /* GPIO_113 */
-		"PCIE2_RST_N", /* GPIO_114 */
-		"PCIE2_CLKREQ_N", /* GPIO_115 */
-		"PCIE2_WAKE", /* GPIO_116 */
-		"SSC_IRQ_0", /* GPIO_117 */
-		"SSC_IRQ_1", /* GPIO_118 */
-		"SSC_IRQ_2", /* GPIO_119 */
-		"NC", /* GPIO_120 */
-		"GPIO121", /* GPIO_121, S HSEC pin 2 */
-		"NC", /* GPIO_122 */
-		"SSC_IRQ_6", /* GPIO_123 */
-		"SSC_IRQ_7", /* GPIO_124 */
-		"GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
-		"BOOT_CONFIG5", /* GPIO_126 */
-		"NC", /* GPIO_127 */
-		"NC", /* GPIO_128 */
-		"BOOT_CONFIG7", /* GPIO_129 */
-		"PCIE1_RST_N", /* GPIO_130 */
-		"PCIE1_CLKREQ_N", /* GPIO_131 */
-		"PCIE1_WAKE", /* GPIO_132 */
-		"GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
-		"NC", /* GPIO_134 */
-		"NC", /* GPIO_135 */
-		"BOOT_CONFIG8", /* GPIO_136 */
-		"NC", /* GPIO_137 */
-		"NC", /* GPIO_138 */
-		"GPS_SSBI2", /* GPIO_139 */
-		"GPS_SSBI1", /* GPIO_140 */
-		"NC", /* GPIO_141 */
-		"NC", /* GPIO_142 */
-		"NC", /* GPIO_143 */
-		"BOOT_CONFIG6", /* GPIO_144 */
-		"NC", /* GPIO_145 */
-		"NC", /* GPIO_146 */
-		"NC", /* GPIO_147 */
-		"NC", /* GPIO_148 */
-		"NC"; /* GPIO_149 */
-
-	sdc2_cd_on: sdc2_cd_on {
-		mux {
-			pins = "gpio38";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio38";
-			bias-pull-up;		/* pull up */
-			drive-strength = <16>;	/* 16 MA */
-		};
-	};
-
-	sdc2_cd_off: sdc2_cd_off {
-		mux {
-			pins = "gpio38";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio38";
-			bias-pull-up;		/* pull up */
-			drive-strength = <2>;	/* 2 MA */
-		};
-	};
-
-	blsp1_uart2_default: blsp1_uart2_default {
-		mux {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			function = "blsp_uart2";
-		};
-
-		config {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			drive-strength = <16>;
-			bias-disable;
-		};
-	};
-
-	blsp1_uart2_sleep: blsp1_uart2_sleep {
-		mux {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	hdmi_hpd_active: hdmi_hpd_active {
-		mux {
-			pins = "gpio34";
-			function = "hdmi_hot";
-		};
-
-		config {
-			pins = "gpio34";
-			bias-pull-down;
-			drive-strength = <16>;
-		};
-	};
-
-	hdmi_hpd_suspend: hdmi_hpd_suspend {
-		mux {
-			pins = "gpio34";
-			function = "hdmi_hot";
-		};
-
-		config {
-			pins = "gpio34";
-			bias-pull-down;
-			drive-strength = <2>;
-		};
-	};
-
-	hdmi_ddc_active: hdmi_ddc_active {
-		mux {
-			pins = "gpio32", "gpio33";
-			function = "hdmi_ddc";
-		};
-
-		config {
-			pins = "gpio32", "gpio33";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-	};
-
-	hdmi_ddc_suspend: hdmi_ddc_suspend {
-		mux {
-			pins = "gpio32", "gpio33";
-			function = "hdmi_ddc";
-		};
-
-		config {
-			pins = "gpio32", "gpio33";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
-	};
-};
-
-&pcie0 {
-	status = "okay";
-	perst-gpio = <&tlmm 35 GPIO_ACTIVE_LOW>;
-	vddpe-3v3-supply = <&wlan_en>;
-	vdda-supply = <&vreg_l28a_0p925>;
-};
-
-&pcie1 {
-	status = "okay";
-	perst-gpio = <&tlmm 130 GPIO_ACTIVE_LOW>;
-	vdda-supply = <&vreg_l28a_0p925>;
-};
-
-&pcie2 {
-	status = "okay";
-	perst-gpio = <&tlmm 114 GPIO_ACTIVE_LOW>;
-	vdda-supply = <&vreg_l28a_0p925>;
-};
-
-&pcie_phy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l28a_0p925>;
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-};
-
-&pm8994_gpios {
-	gpio-line-names =
-		"NC",
-		"KEY_VOLP_N",
-		"NC",
-		"BL1_PWM",
-		"GPIO-F", /* BL0_PWM, LSEC pin 28 */
-		"BL1_EN",
-		"NC",
-		"WLAN_EN",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
-		"DIVCLK1",
-		"DIVCLK2",
-		"DIVCLK3",
-		"DIVCLK4",
-		"BT_EN",
-		"PMIC_SLB",
-		"PMIC_BUA",
-		"USB_VBUS_DET";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&ls_exp_gpio_f &bt_en_gpios>;
-
-	ls_exp_gpio_f: pm8994_gpio5 {
-		pinconf {
-			pins = "gpio5";
-			output-low;
-			power-source = <2>; // PM8994_GPIO_S4, 1.8V
-		};
-	};
-
-	bt_en_gpios: bt_en_gpios {
-		pinconf {
-			pins = "gpio19";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			output-low;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
-			bias-pull-down;
-		};
-	};
-
-	wlan_en_gpios: wlan_en_gpios {
-		pinconf {
-			pins = "gpio8";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			output-low;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
-			bias-pull-down;
-		};
-	};
-
-	audio_mclk: clk_div1 {
-		pinconf {
-			pins = "gpio15";
-			function = "func1";
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-
-	volume_up_gpio: pm8996_gpio2 {
-		pinconf {
-			pins = "gpio2";
-			function = "normal";
-			input-enable;
-			drive-push-pull;
-			bias-pull-up;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-
-	divclk4_pin_a: divclk4 {
-		pinconf {
-			pins = "gpio18";
-			function = PMIC_GPIO_FUNC_FUNC2;
-
-			bias-disable;
-			power-source = <PM8994_GPIO_S4>;
-		};
-	};
-
-	usb3_vbus_det_gpio: pm8996_gpio22 {
-		pinconf {
-			pins = "gpio22";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			input-enable;
-			bias-pull-down;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-};
-
-&pm8994_mpps {
-	gpio-line-names =
-		"VDDPX_BIAS",
-		"WIFI_LED",
-		"NC",
-		"BT_LED",
-		"PM_MPP05",
-		"PM_MPP06",
-		"PM_MPP07",
-		"NC";
-};
-
-&pm8994_spmi_regulators {
-	qcom,saw-reg = <&saw3>;
-	s9 {
-		qcom,saw-slave;
-	};
-	s10 {
-		qcom,saw-slave;
-	};
-	s11 {
-		qcom,saw-leader;
-		regulator-always-on;
-		regulator-min-microvolt = <980000>;
-		regulator-max-microvolt = <980000>;
-	};
-};
-
-&pmi8994_gpios {
-	gpio-line-names =
-		"NC",
-		"SPKR_AMP_EN1",
-		"SPKR_AMP_EN2",
-		"TP61",
-		"NC",
-		"USB2_VBUS_DET",
-		"NC",
-		"NC",
-		"NC",
-		"NC";
-
-	usb2_vbus_det_gpio: pmi8996_gpio6 {
-		pinconf {
-			pins = "gpio6";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			input-enable;
-			bias-pull-down;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-};
-
-&pmi8994_spmi_regulators {
-	vdd_gfx: s2@1700 {
-		reg = <0x1700 0x100>;
-		regulator-name = "VDD_GFX";
-		regulator-min-microvolt = <980000>;
-		regulator-max-microvolt = <980000>;
-	};
-};
-
-&rpm_requests {
-	pm8994-regulators {
-		compatible = "qcom,rpm-pm8994-regulators";
-
-		vdd_s1-supply = <&vph_pwr>;
-		vdd_s2-supply = <&vph_pwr>;
-		vdd_s3-supply = <&vph_pwr>;
-		vdd_s4-supply = <&vph_pwr>;
-		vdd_s5-supply = <&vph_pwr>;
-		vdd_s6-supply = <&vph_pwr>;
-		vdd_s7-supply = <&vph_pwr>;
-		vdd_s8-supply = <&vph_pwr>;
-		vdd_s9-supply = <&vph_pwr>;
-		vdd_s10-supply = <&vph_pwr>;
-		vdd_s11-supply = <&vph_pwr>;
-		vdd_s12-supply = <&vph_pwr>;
-		vdd_l1-supply = <&vreg_s1b_1p025>;
-		vdd_l2_l26_l28-supply = <&vreg_s3a_1p3>;
-		vdd_l3_l11-supply = <&vreg_s3a_1p3>;
-		vdd_l4_l27_l31-supply = <&vreg_s3a_1p3>;
-		vdd_l5_l7-supply = <&vreg_s5a_2p15>;
-		vdd_l6_l12_l32-supply = <&vreg_s5a_2p15>;
-		vdd_l8_l16_l30-supply = <&vph_pwr>;
-		vdd_l9_l10_l18_l22-supply = <&vph_pwr_bbyp>;
-		vdd_l13_l19_l23_l24-supply = <&vph_pwr_bbyp>;
-		vdd_l14_l15-supply = <&vreg_s5a_2p15>;
-		vdd_l17_l29-supply = <&vph_pwr_bbyp>;
-		vdd_l20_l21-supply = <&vph_pwr_bbyp>;
-		vdd_l25-supply = <&vreg_s3a_1p3>;
-		vdd_lvs1_lvs2-supply = <&vreg_s4a_1p8>;
-
-		vreg_s3a_1p3: s3 {
-			regulator-name = "vreg_s3a_1p3";
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		/**
-		 * 1.8v required on LS expansion
-		 * for mezzanine boards
-		 */
-		vreg_s4a_1p8: s4 {
-			regulator-name = "vreg_s4a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-		vreg_s5a_2p15: s5 {
-			regulator-name = "vreg_s5a_2p15";
-			regulator-min-microvolt = <2150000>;
-			regulator-max-microvolt = <2150000>;
-		};
-		vreg_s7a_1p0: s7 {
-			regulator-name = "vreg_s7a_1p0";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-		};
-
-		vreg_l1a_1p0: l1 {
-			regulator-name = "vreg_l1a_1p0";
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-		};
-		vreg_l2a_1p25: l2 {
-			regulator-name = "vreg_l2a_1p25";
-			regulator-min-microvolt = <1250000>;
-			regulator-max-microvolt = <1250000>;
-		};
-		vreg_l3a_0p875: l3 {
-			regulator-name = "vreg_l3a_0p875";
-			regulator-min-microvolt = <850000>;
-			regulator-max-microvolt = <850000>;
-		};
-		vreg_l4a_1p225: l4 {
-			regulator-name = "vreg_l4a_1p225";
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1225000>;
-		};
-		vreg_l6a_1p2: l6 {
-			regulator-name = "vreg_l6a_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-		vreg_l8a_1p8: l8 {
-			regulator-name = "vreg_l8a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-		vreg_l9a_1p8: l9 {
-			regulator-name = "vreg_l9a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-		vreg_l10a_1p8: l10 {
-			regulator-name = "vreg_l10a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-		vreg_l11a_1p15: l11 {
-			regulator-name = "vreg_l11a_1p15";
-			regulator-min-microvolt = <1150000>;
-			regulator-max-microvolt = <1150000>;
-		};
-		vreg_l12a_1p8: l12 {
-			regulator-name = "vreg_l12a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-		vreg_l13a_2p95: l13 {
-			regulator-name = "vreg_l13a_2p95";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-		vreg_l14a_1p8: l14 {
-			regulator-name = "vreg_l14a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-		vreg_l15a_1p8: l15 {
-			regulator-name = "vreg_l15a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-		vreg_l16a_2p7: l16 {
-			regulator-name = "vreg_l16a_2p7";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-		};
-		vreg_l17a_2p8: l17 {
-			regulator-name = "vreg_l17a_2p8";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-		};
-		vreg_l18a_2p85: l18 {
-			regulator-name = "vreg_l18a_2p85";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2900000>;
-		};
-		vreg_l19a_2p8: l19 {
-			regulator-name = "vreg_l19a_2p8";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-		};
-		vreg_l20a_2p95: l20 {
-			regulator-name = "vreg_l20a_2p95";
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-allow-set-load;
-		};
-		vreg_l21a_2p95: l21 {
-			regulator-name = "vreg_l21a_2p95";
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-allow-set-load;
-			regulator-system-load = <200000>;
-		};
-		vreg_l22a_3p0: l22 {
-			regulator-name = "vreg_l22a_3p0";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-		};
-		vreg_l23a_2p8: l23 {
-			regulator-name = "vreg_l23a_2p8";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-		};
-		vreg_l24a_3p075: l24 {
-			regulator-name = "vreg_l24a_3p075";
-			regulator-min-microvolt = <3075000>;
-			regulator-max-microvolt = <3075000>;
-		};
-		vreg_l25a_1p2: l25 {
-			regulator-name = "vreg_l25a_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-allow-set-load;
-		};
-		vreg_l26a_0p8: l27 {
-			regulator-name = "vreg_l26a_0p8";
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-		};
-		vreg_l28a_0p925: l28 {
-			regulator-name = "vreg_l28a_0p925";
-			regulator-min-microvolt = <925000>;
-			regulator-max-microvolt = <925000>;
-			regulator-allow-set-load;
-		};
-		vreg_l29a_2p8: l29 {
-			regulator-name = "vreg_l29a_2p8";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-		};
-		vreg_l30a_1p8: l30 {
-			regulator-name = "vreg_l30a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-		vreg_l32a_1p8: l32 {
-			regulator-name = "vreg_l32a_1p8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		vreg_lvs1a_1p8: lvs1 {
-			regulator-name = "vreg_lvs1a_1p8";
-		};
-
-		vreg_lvs2a_1p8: lvs2 {
-			regulator-name = "vreg_lvs2a_1p8";
-		};
-	};
-
-	pmi8994-regulators {
-		compatible = "qcom,rpm-pmi8994-regulators";
-
-		vdd_s1-supply = <&vph_pwr>;
-		vdd_s2-supply = <&vph_pwr>;
-		vdd_s3-supply = <&vph_pwr>;
-		vdd_bst_byp-supply = <&vph_pwr>;
-
-		vph_pwr_bbyp: boost-bypass {
-			regulator-name = "vph_pwr_bbyp";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		vreg_s1b_1p025: s1 {
-			regulator-name = "vreg_s1b_1p025";
-			regulator-min-microvolt = <1025000>;
-			regulator-max-microvolt = <1025000>;
-		};
-	};
-};
-
-&sdhc2 {
-	/* External SD card */
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_state_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_state_off &sdc2_cd_off>;
-	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&vreg_l21a_2p95>;
-	vqmmc-supply = <&vreg_l13a_2p95>;
-	status = "okay";
-};
-
-&q6asmdai {
-	dai@0 {
-		reg = <0>;
-	};
-
-	dai@1 {
-		reg = <1>;
-	};
-
-	dai@2 {
-		reg = <2>;
-	};
-};
-
-&sound {
-	compatible = "qcom,apq8096-sndcard";
-	model = "DB820c";
-	audio-routing =	"RX_BIAS", "MCLK",
-		"MM_DL1",  "MultiMedia1 Playback",
-		"MM_DL2",  "MultiMedia2 Playback",
-		"MultiMedia3 Capture", "MM_UL3";
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	mm2-dai-link {
-		link-name = "MultiMedia2";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
-		};
-	};
-
-	mm3-dai-link {
-		link-name = "MultiMedia3";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
-		};
-	};
-
-	hdmi-dai-link {
-		link-name = "HDMI";
-		cpu {
-			sound-dai = <&q6afedai HDMI_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&hdmi 0>;
-		};
-	};
-
-	slim-dai-link {
-		link-name = "SLIM Playback";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_6_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-	};
-
-		codec {
-			sound-dai = <&wcd9335 6>;
-		};
-	};
-
-	slimcap-dai-link {
-		link-name = "SLIM Capture";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_TX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9335 1>;
-		};
-	};
-};
-
-&ufsphy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l28a_0p925>;
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-	vddp-ref-clk-supply = <&vreg_l25a_1p2>;
-};
-
-&ufshc {
-	status = "okay";
-
-	vcc-supply = <&vreg_l20a_2p95>;
-	vccq-supply = <&vreg_l25a_1p2>;
-	vccq2-supply = <&vreg_s4a_1p8>;
-
-	vcc-max-microamp = <600000>;
-	vccq-max-microamp = <450000>;
-	vccq2-max-microamp = <450000>;
-};
-
-&usb2 {
-	status = "okay";
-	extcon = <&usb2_id>;
-
-	dwc3@7600000 {
-		extcon = <&usb2_id>;
-		dr_mode = "otg";
-		maximum-speed = "high-speed";
-	};
-};
-
-&usb3 {
-	status = "okay";
-	extcon = <&usb3_id>;
-
-	dwc3@6a00000 {
-		extcon = <&usb3_id>;
-		dr_mode = "otg";
-	};
-};
-
-&usb3phy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l28a_0p925>;
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-
-};
-
-&venus {
-	status = "okay";
-};
-
-&wcd9335 {
-	clock-names = "mclk", "slimbus";
-	clocks = <&div1_mclk>,
-		 <&rpmcc RPM_SMD_BB_CLK1>;
-
-	vdd-buck-supply = <&vreg_s4a_1p8>;
-	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-	vdd-tx-supply = <&vreg_s4a_1p8>;
-	vdd-rx-supply = <&vreg_s4a_1p8>;
-	vdd-io-supply = <&vreg_s4a_1p8>;
-};
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index a57c60070cdc..f0a98ab1616a 100644
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
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
index d66c15538785..7c0ceb3cff45 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
@@ -5,9 +5,22 @@
 
 /dts-v1/;
 
-#include "msm8916-mtp.dtsi"
+#include "msm8916-pm8916.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
 	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp/1", "qcom,msm8916";
+
+	aliases {
+		serial0 = &blsp1_uart2;
+		usid0 = &pm8916_0;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
deleted file mode 100644
index 1bd05046cdeb..000000000000
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
- */
-
-#include "msm8916-pm8916.dtsi"
-
-/ {
-	aliases {
-		serial0 = &blsp1_uart2;
-		usid0 = &pm8916_0;
-	};
-
-	chosen {
-		stdout-path = "serial0";
-	};
-};
-
-&blsp1_uart2 {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index b967dbfba3b8..fcc9f757c9e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1064,7 +1064,7 @@ dsi_phy0: dsi-phy@1a98300 {
 			};
 		};
 
-		camss: camss@1b00000 {
+		camss: camss@1b0ac00 {
 			compatible = "qcom,msm8916-camss";
 			reg = <0x01b0ac00 0x200>,
 				<0x01b00030 0x4>,
@@ -1771,7 +1771,7 @@ smd-edge {
 
 				label = "pronto";
 
-				wcnss {
+				wcnss_ctrl: wcnss {
 					compatible = "qcom,wcnss";
 					qcom,smd-channels = "WCNSS_CTRL";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index a8dc8163ee82..4447ed146b3a 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -725,7 +725,7 @@ restart@fc4ab000 {
 			reg = <0xfc4ab000 0x4>;
 		};
 
-		spmi_bus: spmi@fc4c0000 {
+		spmi_bus: spmi@fc4cf000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xfc4cf000 0x1000>,
 			      <0xfc4cb000 0x1000>,
diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
index 45ed594c1b9c..7d9fc35bc7a0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
@@ -5,9 +5,31 @@
 
 /dts-v1/;
 
-#include "msm8996-mtp.dtsi"
+#include "msm8996.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM 8996 MTP";
 	compatible = "qcom,msm8996-mtp";
+
+	aliases {
+		serial0 = &blsp2_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	soc {
+		serial@75b0000 {
+			status = "okay";
+		};
+	};
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_phy {
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
deleted file mode 100644
index ac43a91f1104..000000000000
--- a/arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
- */
-
-#include "msm8996.dtsi"
-
-/ {
-	aliases {
-		serial0 = &blsp2_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0";
-	};
-
-	soc {
-		serial@75b0000 {
-			status = "okay";
-		};
-	};
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_phy {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cd66bb16c739..ec3ef14048cc 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1228,6 +1228,20 @@ wake {
 				};
 			};
 
+			blsp1_uart2_default: blsp1-uart2-default {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "blsp_uart2";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_uart2_sleep: blsp1-uart2-sleep {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			blsp1_i2c3_default: blsp1-i2c2-default {
 				pins = "gpio47", "gpio48";
 				function = "blsp_i2c3";
@@ -1771,7 +1785,7 @@ ufsphy_lane: phy@627400 {
 			};
 		};
 
-		camss: camss@a00000 {
+		camss: camss@a34000 {
 			compatible = "qcom,msm8996-camss";
 			reg = <0x00a34000 0x1000>,
 			      <0x00a00030 0x4>,
@@ -2724,6 +2738,9 @@ blsp1_uart2: serial@7570000 {
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			pinctrl-1 = <&blsp1_uart2_sleep>;
 			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
 			dma-names = "tx", "rx";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index c2e1a0d9a272..e00c0577cef7 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1834,7 +1834,7 @@ pil-reloc@94c {
 			};
 		};
 
-		camss: camss@ca00000 {
+		camss: camss@ca00020 {
 			compatible = "qcom,sdm660-camss";
 			reg = <0x0c824000 0x1000>,
 			      <0x0ca00120 0x4>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d973aa39e410..a0489a45aafb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3921,7 +3921,7 @@ videocc: clock-controller@ab00000 {
 			#reset-cells = <1>;
 		};
 
-		camss: camss@a00000 {
+		camss: camss@acb3000 {
 			compatible = "qcom,sdm845-camss";
 
 			reg = <0 0xacb3000 0 0x1000>,
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index effbd6a9c989..b093f2a02a9c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -26,9 +26,10 @@ chosen {
 		framebuffer: framebuffer@9c000000 {
 			compatible = "simple-framebuffer";
 			reg = <0 0x9c000000 0 0x2300000>;
-			width = <1644>;
-			height = <3840>;
-			stride = <(1644 * 4)>;
+			/* pdx203 BL initializes in 2.5k mode, not 4k */
+			width = <1096>;
+			height = <2560>;
+			stride = <(1096 * 4)>;
 			format = "a8r8g8b8";
 			/*
 			 * That's a lot of clocks, but it's necessary due
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 61bd4df09df0..26cb5f14f9c7 100644
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
index 4417fe81afd7..ee244df75eae 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -80,25 +80,25 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
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
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ce59811616d8..d810d4b7b438 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -363,6 +363,18 @@ static struct midr_range broken_aarch32_aes[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2139208
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2119858
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -564,6 +576,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
 	},
 #endif
+
 #ifdef CONFIG_ARM64_ERRATUM_2457168
 	{
 		.desc = "ARM erratum 2457168",
@@ -580,6 +593,19 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		CAP_MIDR_RANGE_LIST(broken_aarch32_aes),
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	{
+		/*
+		 * The erratum work around is handled within the TRBE
+		 * driver and can be applied per-cpu. So, we can allow
+		 * a late CPU to come online with this erratum.
+		 */
+		.desc = "ARM erratum 2119858 or 2139208",
+		.capability = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 6b1e70aee8cf..32fe50a3a26c 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -56,6 +56,7 @@ WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_1742098
 WORKAROUND_2457168
+WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 696f6b009377..cfd9e1581777 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -318,7 +318,7 @@ struct kvm_vcpu_arch {
 	unsigned int aux_inuse;
 
 	/* COP0 State */
-	struct mips_coproc *cop0;
+	struct mips_coproc cop0;
 
 	/* Resume PC after MMIO completion */
 	unsigned long io_pc;
@@ -699,7 +699,7 @@ static inline bool kvm_mips_guest_can_have_fpu(struct kvm_vcpu_arch *vcpu)
 static inline bool kvm_mips_guest_has_fpu(struct kvm_vcpu_arch *vcpu)
 {
 	return kvm_mips_guest_can_have_fpu(vcpu) &&
-		kvm_read_c0_guest_config1(vcpu->cop0) & MIPS_CONF1_FP;
+		kvm_read_c0_guest_config1(&vcpu->cop0) & MIPS_CONF1_FP;
 }
 
 static inline bool kvm_mips_guest_can_have_msa(struct kvm_vcpu_arch *vcpu)
@@ -711,7 +711,7 @@ static inline bool kvm_mips_guest_can_have_msa(struct kvm_vcpu_arch *vcpu)
 static inline bool kvm_mips_guest_has_msa(struct kvm_vcpu_arch *vcpu)
 {
 	return kvm_mips_guest_can_have_msa(vcpu) &&
-		kvm_read_c0_guest_config3(vcpu->cop0) & MIPS_CONF3_MSA;
+		kvm_read_c0_guest_config3(&vcpu->cop0) & MIPS_CONF3_MSA;
 }
 
 struct kvm_mips_callbacks {
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 7c861e6a8952..8ebcc298bf75 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1734,7 +1734,10 @@ static inline void decode_cpucfg(struct cpuinfo_mips *c)
 
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 {
+	c->cputype = CPU_LOONGSON64;
+
 	/* All Loongson processors covered here define ExcCode 16 as GSExc. */
+	decode_configs(c);
 	c->options |= MIPS_CPU_GSEXCEX;
 
 	switch (c->processor_id & PRID_IMP_MASK) {
@@ -1744,7 +1747,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		case PRID_REV_LOONGSON2K_R1_1:
 		case PRID_REV_LOONGSON2K_R1_2:
 		case PRID_REV_LOONGSON2K_R1_3:
-			c->cputype = CPU_LOONGSON64;
 			__cpu_name[cpu] = "Loongson-2K";
 			set_elf_platform(cpu, "gs264e");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1757,14 +1759,12 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -1784,7 +1784,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
 		break;
 	case PRID_IMP_LOONGSON_64G:
-		c->cputype = CPU_LOONGSON64;
 		__cpu_name[cpu] = "ICT Loongson-3";
 		set_elf_platform(cpu, "loongson3a");
 		set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1794,8 +1793,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		panic("Unknown Loongson Processor ID!");
 		break;
 	}
-
-	decode_configs(c);
 }
 #else
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu) { }
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 22e745e49b0a..3e80b0b2deaa 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -312,7 +312,7 @@ int kvm_get_badinstrp(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
  */
 int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	return	(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC) ||
 		(kvm_read_c0_guest_cause(cop0) & CAUSEF_DC);
@@ -384,7 +384,7 @@ static inline ktime_t kvm_mips_count_time(struct kvm_vcpu *vcpu)
  */
 static u32 kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	ktime_t expires, threshold;
 	u32 count, compare;
 	int running;
@@ -444,7 +444,7 @@ static u32 kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
  */
 u32 kvm_mips_read_count(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	/* If count disabled just read static copy of count */
 	if (kvm_mips_count_disabled(vcpu))
@@ -502,7 +502,7 @@ ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu, u32 *count)
 static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
 				    ktime_t now, u32 count)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 compare;
 	u64 delta;
 	ktime_t expire;
@@ -603,7 +603,7 @@ int kvm_mips_restore_hrtimer(struct kvm_vcpu *vcpu, ktime_t before,
  */
 void kvm_mips_write_count(struct kvm_vcpu *vcpu, u32 count)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	ktime_t now;
 
 	/* Calculate bias */
@@ -649,7 +649,7 @@ void kvm_mips_init_count(struct kvm_vcpu *vcpu, unsigned long count_hz)
  */
 int kvm_mips_set_count_hz(struct kvm_vcpu *vcpu, s64 count_hz)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	int dc;
 	ktime_t now;
 	u32 count;
@@ -696,7 +696,7 @@ int kvm_mips_set_count_hz(struct kvm_vcpu *vcpu, s64 count_hz)
  */
 void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	int dc;
 	u32 old_compare = kvm_read_c0_guest_compare(cop0);
 	s32 delta = compare - old_compare;
@@ -779,7 +779,7 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
  */
 static ktime_t kvm_mips_count_disable(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 count;
 	ktime_t now;
 
@@ -806,7 +806,7 @@ static ktime_t kvm_mips_count_disable(struct kvm_vcpu *vcpu)
  */
 void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	kvm_set_c0_guest_cause(cop0, CAUSEF_DC);
 	if (!(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC))
@@ -826,7 +826,7 @@ void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
  */
 void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 count;
 
 	kvm_clear_c0_guest_cause(cop0, CAUSEF_DC);
@@ -852,7 +852,7 @@ void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu)
  */
 int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	s64 changed = count_ctl ^ vcpu->arch.count_ctl;
 	s64 delta;
 	ktime_t expire, now;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 75c6f264c626..6b15ac978658 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -652,7 +652,7 @@ static int kvm_mips_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	struct mips_fpu_struct *fpu = &vcpu->arch.fpu;
 	int ret;
 	s64 v;
@@ -764,7 +764,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	struct mips_fpu_struct *fpu = &vcpu->arch.fpu;
 	s64 v;
 	s64 vs[2];
@@ -1104,7 +1104,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
 	return kvm_mips_pending_timer(vcpu) ||
-		kvm_read_c0_guest_cause(vcpu->arch.cop0) & C_TI;
+		kvm_read_c0_guest_cause(&vcpu->arch.cop0) & C_TI;
 }
 
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
@@ -1128,7 +1128,7 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
 	kvm_debug("\thi: 0x%08lx\n", vcpu->arch.hi);
 	kvm_debug("\tlo: 0x%08lx\n", vcpu->arch.lo);
 
-	cop0 = vcpu->arch.cop0;
+	cop0 = &vcpu->arch.cop0;
 	kvm_debug("\tStatus: 0x%08x, Cause: 0x%08x\n",
 		  kvm_read_c0_guest_status(cop0),
 		  kvm_read_c0_guest_cause(cop0));
@@ -1250,7 +1250,7 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 
 	case EXCCODE_TLBS:
 		kvm_debug("TLB ST fault:  cause %#x, status %#x, PC: %p, BadVaddr: %#lx\n",
-			  cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc,
+			  cause, kvm_read_c0_guest_status(&vcpu->arch.cop0), opc,
 			  badvaddr);
 
 		++vcpu->stat.tlbmiss_st_exits;
@@ -1322,7 +1322,7 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 		kvm_get_badinstr(opc, vcpu, &inst);
 		kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#x\n",
 			exccode, opc, inst, badvaddr,
-			kvm_read_c0_guest_status(vcpu->arch.cop0));
+			kvm_read_c0_guest_status(&vcpu->arch.cop0));
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
@@ -1384,7 +1384,7 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 /* Enable FPU for guest and restore context */
 void kvm_own_fpu(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int sr, cfg5;
 
 	preempt_disable();
@@ -1428,7 +1428,7 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 /* Enable MSA for guest and restore context */
 void kvm_own_msa(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int sr, cfg5;
 
 	preempt_disable();
diff --git a/arch/mips/kvm/stats.c b/arch/mips/kvm/stats.c
index 53f851a61554..3e6682018fbe 100644
--- a/arch/mips/kvm/stats.c
+++ b/arch/mips/kvm/stats.c
@@ -54,9 +54,9 @@ void kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
 	kvm_info("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
 	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
 		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
-			if (vcpu->arch.cop0->stat[i][j])
+			if (vcpu->arch.cop0.stat[i][j])
 				kvm_info("%s[%d]: %lu\n", kvm_cop0_str[i], j,
-					 vcpu->arch.cop0->stat[i][j]);
+					 vcpu->arch.cop0.stat[i][j]);
 		}
 	}
 #endif
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index a8c7fd7bf6d2..136c3535a1cb 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -322,11 +322,11 @@ TRACE_EVENT_FN(kvm_guest_mode_change,
 	    ),
 
 	    TP_fast_assign(
-			__entry->epc = kvm_read_c0_guest_epc(vcpu->arch.cop0);
+			__entry->epc = kvm_read_c0_guest_epc(&vcpu->arch.cop0);
 			__entry->pc = vcpu->arch.pc;
-			__entry->badvaddr = kvm_read_c0_guest_badvaddr(vcpu->arch.cop0);
-			__entry->status = kvm_read_c0_guest_status(vcpu->arch.cop0);
-			__entry->cause = kvm_read_c0_guest_cause(vcpu->arch.cop0);
+			__entry->badvaddr = kvm_read_c0_guest_badvaddr(&vcpu->arch.cop0);
+			__entry->status = kvm_read_c0_guest_status(&vcpu->arch.cop0);
+			__entry->cause = kvm_read_c0_guest_cause(&vcpu->arch.cop0);
 	    ),
 
 	    TP_printk("EPC: 0x%08lx PC: 0x%08lx Status: 0x%08x Cause: 0x%08x BadVAddr: 0x%08lx",
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 4adca5abbc72..717f88333316 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -422,7 +422,7 @@ static void _kvm_vz_restore_htimer(struct kvm_vcpu *vcpu,
  */
 static void kvm_vz_restore_timer(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 cause, compare;
 
 	compare = kvm_read_sw_gc0_compare(cop0);
@@ -517,7 +517,7 @@ static void _kvm_vz_save_htimer(struct kvm_vcpu *vcpu,
  */
 static void kvm_vz_save_timer(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 gctl0, compare, cause;
 
 	gctl0 = read_c0_guestctl0();
@@ -863,7 +863,7 @@ static unsigned long mips_process_maar(unsigned int op, unsigned long val)
 
 static void kvm_write_maari(struct kvm_vcpu *vcpu, unsigned long val)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	val &= MIPS_MAARI_INDEX;
 	if (val == MIPS_MAARI_INDEX)
@@ -876,7 +876,7 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 					      u32 *opc, u32 cause,
 					      struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 	u32 rt, rd, sel;
 	unsigned long curr_pc;
@@ -1905,7 +1905,7 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 			      const struct kvm_one_reg *reg,
 			      s64 *v)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int idx;
 
 	switch (reg->id) {
@@ -2075,7 +2075,7 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_MAARI:
 		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
 			return -EINVAL;
-		*v = kvm_read_sw_gc0_maari(vcpu->arch.cop0);
+		*v = kvm_read_sw_gc0_maari(&vcpu->arch.cop0);
 		break;
 #ifdef CONFIG_64BIT
 	case KVM_REG_MIPS_CP0_XCONTEXT:
@@ -2129,7 +2129,7 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 			      const struct kvm_one_reg *reg,
 			      s64 v)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int idx;
 	int ret = 0;
 	unsigned int cur, change;
@@ -2556,7 +2556,7 @@ static void kvm_vz_vcpu_load_tlb(struct kvm_vcpu *vcpu, int cpu)
 
 static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	bool migrated, all;
 
 	/*
@@ -2698,7 +2698,7 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 static int kvm_vz_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	if (current->flags & PF_VCPU)
 		kvm_vz_vcpu_save_wired(vcpu);
@@ -3070,7 +3070,7 @@ static void kvm_vz_vcpu_uninit(struct kvm_vcpu *vcpu)
 
 static int kvm_vz_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned long count_hz = 100*1000*1000; /* default to 100 MHz */
 
 	/*
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 192f0ed0097f..80ce54f59fae 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -240,7 +240,7 @@ config PPC_EARLY_DEBUG_40x
 
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
-	depends on SERIAL_CPM
+	depends on SERIAL_CPM=y
 	help
 	  Select this to enable early debugging for Freescale chips
 	  using a CPM-based serial port.  This assumes that the bootwrapper
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a8e52e64c1a5..3dc75040a756 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -444,3 +444,11 @@ checkbin:
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
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 8703df709cce..e93f67c3af76 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -531,7 +531,6 @@ void preempt_schedule_irq(void);
 
 notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 {
-	unsigned long flags;
 	unsigned long ret = 0;
 	unsigned long kuap;
 	bool stack_store = current_thread_info()->flags &
@@ -548,7 +547,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 
 	kuap = kuap_get_and_assert_locked();
 
-	local_irq_save(flags);
+	local_irq_disable();
 
 	if (!arch_irq_disabled_regs(regs)) {
 		/* Returning to a kernel context with local irqs enabled. */
diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
index 2d4d21bb46a9..235ae2428451 100644
--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -21,60 +21,33 @@
  * different ABIs, though).
  */
 _GLOBAL(ppc_save_regs)
-	PPC_STL	r0,0*SZL(r3)
+	/* This allows stack frame accessor macros and offsets to be used */
+	subi	r3,r3,STACK_FRAME_OVERHEAD
+	PPC_STL	r0,GPR0(r3)
 #ifdef CONFIG_PPC32
-	stmw	r2, 2*SZL(r3)
+	stmw	r2,GPR2(r3)
 #else
-	PPC_STL	r2,2*SZL(r3)
-	PPC_STL	r3,3*SZL(r3)
-	PPC_STL	r4,4*SZL(r3)
-	PPC_STL	r5,5*SZL(r3)
-	PPC_STL	r6,6*SZL(r3)
-	PPC_STL	r7,7*SZL(r3)
-	PPC_STL	r8,8*SZL(r3)
-	PPC_STL	r9,9*SZL(r3)
-	PPC_STL	r10,10*SZL(r3)
-	PPC_STL	r11,11*SZL(r3)
-	PPC_STL	r12,12*SZL(r3)
-	PPC_STL	r13,13*SZL(r3)
-	PPC_STL	r14,14*SZL(r3)
-	PPC_STL	r15,15*SZL(r3)
-	PPC_STL	r16,16*SZL(r3)
-	PPC_STL	r17,17*SZL(r3)
-	PPC_STL	r18,18*SZL(r3)
-	PPC_STL	r19,19*SZL(r3)
-	PPC_STL	r20,20*SZL(r3)
-	PPC_STL	r21,21*SZL(r3)
-	PPC_STL	r22,22*SZL(r3)
-	PPC_STL	r23,23*SZL(r3)
-	PPC_STL	r24,24*SZL(r3)
-	PPC_STL	r25,25*SZL(r3)
-	PPC_STL	r26,26*SZL(r3)
-	PPC_STL	r27,27*SZL(r3)
-	PPC_STL	r28,28*SZL(r3)
-	PPC_STL	r29,29*SZL(r3)
-	PPC_STL	r30,30*SZL(r3)
-	PPC_STL	r31,31*SZL(r3)
+	SAVE_GPRS(2, 31, r3)
 	lbz	r0,PACAIRQSOFTMASK(r13)
-	PPC_STL	r0,SOFTE-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,SOFTE(r3)
 #endif
-	/* go up one stack frame for SP */
-	PPC_LL	r4,0(r1)
-	PPC_STL	r4,1*SZL(r3)
+	/* store current SP */
+	PPC_STL	r1,GPR1(r3)
 	/* get caller's LR */
+	PPC_LL	r4,0(r1)
 	PPC_LL	r0,LRSAVE(r4)
-	PPC_STL	r0,_LINK-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_LINK(r3)
 	mflr	r0
-	PPC_STL	r0,_NIP-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_NIP(r3)
 	mfmsr	r0
-	PPC_STL	r0,_MSR-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_MSR(r3)
 	mfctr	r0
-	PPC_STL	r0,_CTR-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_CTR(r3)
 	mfxer	r0
-	PPC_STL	r0,_XER-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_XER(r3)
 	mfcr	r0
-	PPC_STL	r0,_CCR-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_CCR(r3)
 	li	r0,0
-	PPC_STL	r0,_TRAP-STACK_FRAME_OVERHEAD(r3)
-	PPC_STL	r0,ORIG_GPR3-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_TRAP(r3)
+	PPC_STL	r0,ORIG_GPR3(r3)
 	blr
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 15fb5ea1b9ea..cd6fc64ad9ca 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -363,26 +363,27 @@ ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *
 
 static int ssb_prctl_get(struct task_struct *task)
 {
+	/*
+	 * The STF_BARRIER feature is on by default, so if it's off that means
+	 * firmware has explicitly said the CPU is not vulnerable via either
+	 * the hypercall or device tree.
+	 */
+	if (!security_ftr_enabled(SEC_FTR_STF_BARRIER))
+		return PR_SPEC_NOT_AFFECTED;
+
+	/*
+	 * If the system's CPU has no known barrier (see setup_stf_barrier())
+	 * then assume that the CPU is not vulnerable.
+	 */
 	if (stf_enabled_flush_types == STF_BARRIER_NONE)
-		/*
-		 * We don't have an explicit signal from firmware that we're
-		 * vulnerable or not, we only have certain CPU revisions that
-		 * are known to be vulnerable.
-		 *
-		 * We assume that if we're on another CPU, where the barrier is
-		 * NONE, then we are not vulnerable.
-		 */
 		return PR_SPEC_NOT_AFFECTED;
-	else
-		/*
-		 * If we do have a barrier type then we are vulnerable. The
-		 * barrier is not a global or per-process mitigation, so the
-		 * only value we can report here is PR_SPEC_ENABLE, which
-		 * appears as "vulnerable" in /proc.
-		 */
-		return PR_SPEC_ENABLE;
-
-	return -EINVAL;
+
+	/*
+	 * Otherwise the CPU is vulnerable. The barrier is not a global or
+	 * per-process mitigation, so the only value that can be reported here
+	 * is PR_SPEC_ENABLE, which appears as "vulnerable" in /proc.
+	 */
+	return PR_SPEC_ENABLE;
 }
 
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3e053e2fd6b6..68ed8ecf64fc 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -258,8 +258,9 @@ static void prepare_save_user_regs(int ctx_has_vsx_region)
 #endif
 }
 
-static int __unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
-				   struct mcontext __user *tm_frame, int ctx_has_vsx_region)
+static __always_inline int
+__unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
+			struct mcontext __user *tm_frame, int ctx_has_vsx_region)
 {
 	unsigned long msr = regs->msr;
 
@@ -358,8 +359,9 @@ static void prepare_save_tm_user_regs(void)
 		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
 }
 
-static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				    struct mcontext __user *tm_frame, unsigned long msr)
+static __always_inline int
+save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
+			 struct mcontext __user *tm_frame, unsigned long msr)
 {
 	/* Save both sets of general registers */
 	unsafe_save_general_regs(&current->thread.ckpt_regs, frame, failed);
@@ -438,8 +440,9 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 #else
 static void prepare_save_tm_user_regs(void) { }
 
-static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				    struct mcontext __user *tm_frame, unsigned long msr)
+static __always_inline int
+save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
+			 struct mcontext __user *tm_frame, unsigned long msr)
 {
 	return 0;
 }
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 1d9d7efacbc7..832dfc59fc6c 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -764,9 +764,9 @@ static void free_pud_table(pud_t *pud_start, p4d_t *p4d)
 }
 
 static void remove_pte_table(pte_t *pte_start, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
-	unsigned long next;
+	unsigned long next, pages = 0;
 	pte_t *pte;
 
 	pte = pte_start + pte_index(addr);
@@ -788,13 +788,16 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
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
 
@@ -812,19 +815,22 @@ static void __meminit remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
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
 
@@ -842,16 +848,20 @@ static void __meminit remove_pud_table(pud_t *pud_start, unsigned long addr,
 				continue;
 			}
 			pte_clear(&init_mm, addr, (pte_t *)pud);
+			pages++;
 			continue;
 		}
 
 		pmd_base = pud_pgtable(*pud);
-		remove_pmd_table(pmd_base, addr, next);
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
@@ -880,7 +890,7 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 		}
 
 		pud_base = p4d_pgtable(*p4d);
-		remove_pud_table(pud_base, addr, next);
+		remove_pud_table(pud_base, addr, next, direct);
 		free_pud_table(pud_base, p4d);
 	}
 
@@ -903,7 +913,7 @@ int __meminit radix__create_section_mapping(unsigned long start,
 
 int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
 {
-	remove_pagetable(start, end);
+	remove_pagetable(start, end, true);
 	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
@@ -939,7 +949,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 #ifdef CONFIG_MEMORY_HOTPLUG
 void __meminit radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
 {
-	remove_pagetable(start, start + page_size);
+	remove_pagetable(start, start + page_size, false);
 }
 #endif
 #endif
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
 
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 0072682531d8..b664838008c1 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1310,8 +1310,8 @@ int vas_win_close(struct vas_window *vwin)
 	/* if send window, drop reference to matching receive window */
 	if (window->tx_win) {
 		if (window->user_win) {
-			put_vas_user_win_ref(&vwin->task_ref);
 			mm_context_remove_vas_window(vwin->task_ref.mm);
+			put_vas_user_win_ref(&vwin->task_ref);
 		}
 		put_rx_win(window->rxwin);
 	}
diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 15046d80f042..b54f6fc27896 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -441,8 +441,8 @@ static int vas_deallocate_window(struct vas_window *vwin)
 	atomic_dec(&caps->used_lpar_creds);
 	mutex_unlock(&vas_pseries_mutex);
 
-	put_vas_user_win_ref(&vwin->task_ref);
 	mm_context_remove_vas_window(vwin->task_ref.mm);
+	put_vas_user_win_ref(&vwin->task_ref);
 
 	kfree(win);
 	return 0;
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index c976a21cd4bd..194f166b2cc4 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -67,6 +67,7 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	struct uprobe_task *utask = current->utask;
 
 	WARN_ON_ONCE(current->thread.bad_cause != UPROBE_TRAP_NR);
+	current->thread.bad_cause = utask->autask.saved_cause;
 
 	instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
 
@@ -102,6 +103,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
+	current->thread.bad_cause = utask->autask.saved_cause;
 	/*
 	 * Task has received a fatal signal, so reset back to probbed
 	 * address.
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0afcd4ae7eed..d7115acab350 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -235,7 +235,6 @@ static void __init setup_bootmem(void)
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-	memblock_allow_resize();
 }
 
 #ifdef CONFIG_MMU
@@ -844,7 +843,7 @@ static void __init reserve_crashkernel(void)
 	 */
 	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
 					       search_start,
-					       min(search_end, (unsigned long) SZ_4G));
+					       min(search_end, (unsigned long)(SZ_4G - 1)));
 	if (crash_base == 0) {
 		/* Try again without restricting region to 32bit addressible memory */
 		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
@@ -868,6 +867,9 @@ void __init paging_init(void)
 {
 	setup_bootmem();
 	setup_vm_final();
+
+	/* Depend on that Linear Mapping is ready */
+	memblock_allow_resize();
 }
 
 void __init misc_mem_init(void)
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
 
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 753d85bdfad0..b95c60f663d4 100644
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
 
@@ -154,6 +164,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (!prog->is_func || extra_pass) {
 		bpf_jit_binary_lock_ro(jit_data->header);
+		for (i = 0; i < prog->len; i++)
+			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
+		bpf_prog_fill_jited_linfo(prog, ctx->offset);
 out_offset:
 		kfree(ctx->offset);
 		kfree(jit_data);
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index c7b7a60f6405..dc840ba0b016 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -29,6 +29,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbac
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
+KBUILD_CFLAGS_DECOMPRESSOR += -fPIE
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 807fa9da1e72..3c65b8258ae6 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -166,6 +166,7 @@ static int diag9c_forwarding_overrun(void)
 static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *tcpu;
+	int tcpu_cpu;
 	int tid;
 
 	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
@@ -181,14 +182,15 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 		goto no_yield;
 
 	/* target guest VCPU already running */
-	if (READ_ONCE(tcpu->cpu) >= 0) {
+	tcpu_cpu = READ_ONCE(tcpu->cpu);
+	if (tcpu_cpu >= 0) {
 		if (!diag9c_forwarding_hz || diag9c_forwarding_overrun())
 			goto no_yield;
 
 		/* target host CPU already running */
-		if (!vcpu_is_preempted(tcpu->cpu))
+		if (!vcpu_is_preempted(tcpu_cpu))
 			goto no_yield;
-		smp_yield_cpu(tcpu->cpu);
+		smp_yield_cpu(tcpu_cpu);
 		VCPU_EVENT(vcpu, 5,
 			   "diag time slice end directed to %d: yield forwarded",
 			   tid);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d7aa442ceaf1..eb97db59b236 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2030,6 +2030,10 @@ static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
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
index 2c0704f5eb3c..e07bc0d3df6f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -169,7 +169,8 @@ static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
 			    sizeof(struct kvm_s390_apcb0)))
 		return -EFAULT;
 
-	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb0));
+	bitmap_and(apcb_s, apcb_s, apcb_h,
+		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb0));
 
 	return 0;
 }
@@ -191,7 +192,8 @@ static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
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
diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1d4d67157be..3dbd0e3b660e 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -148,7 +148,7 @@ export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d93d098dea99..4ebedc7e1188 100644
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
index 2704ec1e42a3..b605e08f9a8e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -194,7 +194,7 @@ static struct perf_ibs *get_ibs_pmu(int type)
 }
 
 /*
- * Use IBS for precise event sampling:
+ * core pmu config -> IBS config
  *
  *  perf record -a -e cpu-cycles:p ...    # use ibs op counting cycle count
  *  perf record -a -e r076:p ...          # same as -e cpu-cycles:p
@@ -203,25 +203,9 @@ static struct perf_ibs *get_ibs_pmu(int type)
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
@@ -247,22 +231,37 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
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
index a2b6626c681f..0e4efcde0783 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -427,8 +427,10 @@ struct pebs_xmm {
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
+extern int forward_event_to_ibs(struct perf_event *event);
 #else
 static inline u32 get_ibs_caps(void) { return 0; }
+static inline int forward_event_to_ibs(struct perf_event *event) { return -ENOENT; }
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
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
index 421d31718fbd..2ec16477eb3e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -731,11 +731,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
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
index 43cf04966c74..f95feabb3ca8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2448,6 +2448,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	u32 hwi, adj_step;
 	s64 margin;
 	u64 cost, new_inuse;
+	unsigned long flags;
 
 	current_hweight(iocg, NULL, &hwi);
 	old_hwi = hwi;
@@ -2466,11 +2467,11 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
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
 
@@ -2491,7 +2492,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	} while (time_after64(vtime + cost, now->vnow) &&
 		 iocg->inuse != iocg->active);
 
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock_irqrestore(&ioc->lock, flags);
 
 	TRACE_IOCG_PATH(inuse_adjust, iocg, now,
 			old_inuse, iocg->inuse, old_hwi, hwi);
diff --git a/block/disk-events.c b/block/disk-events.c
index 8d5496e7592a..c3488409dd32 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -307,6 +307,7 @@ bool disk_force_media_change(struct gendisk *disk, unsigned int events)
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return false;
 
+	inc_diskseq(disk);
 	if (__invalidate_device(disk->part0, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			disk->disk_name);
diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 5c8624e26a54..506921095412 100644
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
 
 	for (blk = 0; ; blk++, put_dev_sector(sect)) {
@@ -40,7 +52,7 @@ int amiga_partition(struct parsed_partitions *state)
 			goto rdb_done;
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read RDB block %d\n",
+			pr_err("Dev %s: unable to read RDB block %llu\n",
 			       state->disk->disk_name, blk);
 			res = -1;
 			goto rdb_done;
@@ -57,12 +69,12 @@ int amiga_partition(struct parsed_partitions *state)
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
 		       state->disk->disk_name, blk);
 	}
 
@@ -78,11 +90,16 @@ int amiga_partition(struct parsed_partitions *state)
 	}
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
-	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
-		blk *= blksize;	/* Read in terms partition table understands */
+	for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {
+		/* Read in terms partition table understands */
+		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
+			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
+				state->disk->disk_name, blk, part);
+			break;
+		}
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read partition block %d\n",
+			pr_err("Dev %s: unable to read partition block %llu\n",
 			       state->disk->disk_name, blk);
 			res = -1;
 			goto rdb_done;
@@ -94,19 +111,70 @@ int amiga_partition(struct parsed_partitions *state)
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
+				state->disk->disk_name, cylblk);
+			continue;
+		}
+
+		/* check for consistency with RDB defined CylBlocks */
+		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
+			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
+				state->disk->disk_name, cylblk,
+				be32_to_cpu(rdb->rdb_CylBlocks));
+		}
+
+		/* RDB allows for variable logical block size -
+		 * normalize to 512 byte blocks and check result.
+		 */
+
+		if (check_mul_overflow(cylblk, blksize, &cylblk)) {
+			pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
+				state->disk->disk_name, part);
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
+				state->disk->disk_name, part,
+				start_sect, start_sect + nr_sects);
+		}
+
+		if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
+			pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
+				state->disk->disk_name, part,
+				start_sect, end_sect);
+			continue;
+		}
+
+		/* Tell Kernel about it */
+
 		put_partition(state,slot++,start_sect,nr_sects);
 		{
 			/* Be even more informative to aid mounting */
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 24a82e252b7e..6ffee01e174d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2860,10 +2860,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
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
diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index 91db001eb69a..972603ed06a6 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -33,7 +33,7 @@
 #define IXP4XX_EXP_TIMING_STRIDE	0x04
 #define IXP4XX_EXP_CS_EN		BIT(31)
 #define IXP456_EXP_PAR_EN		BIT(30) /* Only on IXP45x and IXP46x */
-#define IXP4XX_EXP_T1_MASK		GENMASK(28, 27)
+#define IXP4XX_EXP_T1_MASK		GENMASK(29, 28)
 #define IXP4XX_EXP_T1_SHIFT		28
 #define IXP4XX_EXP_T2_MASK		GENMASK(27, 26)
 #define IXP4XX_EXP_T2_SHIFT		26
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e93912e56f28..7d508f905003 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1759,7 +1759,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 	if (!ddata->module_va)
 		return -EIO;
 
-	/* DISP_CONTROL */
+	/* DISP_CONTROL, shut down lcd and digit on disable if enabled */
 	val = sysc_read(ddata, dispc_offset + 0x40);
 	lcd_en = val & lcd_en_mask;
 	digit_en = val & digit_en_mask;
@@ -1771,7 +1771,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 		else
 			irq_mask |= BIT(2) | BIT(3);	/* EVSYNC bits */
 	}
-	if (disable & (lcd_en | digit_en))
+	if (disable && (lcd_en || digit_en))
 		sysc_write(ddata, dispc_offset + 0x40,
 			   val & ~(lcd_en_mask | digit_en_mask));
 
diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 2964efeb71c3..c4ae72b6743e 100644
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
index 4de098b6b0d4..91a6bc74ebd5 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1554,7 +1554,7 @@ static int si5341_probe(struct i2c_client *client,
 	struct clk_init_data init;
 	struct clk *input;
 	const char *root_clock_name;
-	const char *synth_clock_names[SI5341_NUM_SYNTH];
+	const char *synth_clock_names[SI5341_NUM_SYNTH] = { NULL };
 	int err;
 	unsigned int i;
 	struct clk_si5341_output_config config[SI5341_MAX_NUM_OUTPUTS];
@@ -1698,6 +1698,10 @@ static int si5341_probe(struct i2c_client *client,
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
@@ -1706,6 +1710,7 @@ static int si5341_probe(struct i2c_client *client,
 		if (err) {
 			dev_err(&client->dev,
 				"synth N%u registration failed\n", i);
+			goto free_clk_names;
 		}
 	}
 
@@ -1715,6 +1720,10 @@ static int si5341_probe(struct i2c_client *client,
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
@@ -1736,7 +1745,7 @@ static int si5341_probe(struct i2c_client *client,
 		if (err) {
 			dev_err(&client->dev,
 				"output %u registration failed\n", i);
-			goto cleanup;
+			goto free_clk_names;
 		}
 		if (config[i].always_on)
 			clk_prepare(data->clk[i].hw.clk);
@@ -1746,7 +1755,7 @@ static int si5341_probe(struct i2c_client *client,
 			data);
 	if (err) {
 		dev_err(&client->dev, "unable to add clk provider\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	if (initialization_required) {
@@ -1754,11 +1763,11 @@ static int si5341_probe(struct i2c_client *client,
 		regcache_cache_only(data->regmap, false);
 		err = regcache_sync(data->regmap);
 		if (err < 0)
-			goto cleanup;
+			goto free_clk_names;
 
 		err = si5341_finalize_defaults(data);
 		if (err < 0)
-			goto cleanup;
+			goto free_clk_names;
 	}
 
 	/* wait for device to report input clock present and PLL lock */
@@ -1767,32 +1776,31 @@ static int si5341_probe(struct i2c_client *client,
 	       10000, 250000);
 	if (err) {
 		dev_err(&client->dev, "Error waiting for input clock or PLL lock\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	/* clear sticky alarm bits from initialization */
 	err = regmap_write(data->regmap, SI5341_STATUS_STICKY, 0);
 	if (err) {
 		dev_err(&client->dev, "unable to clear sticky status\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	err = sysfs_create_files(&client->dev.kobj, si5341_attributes);
-	if (err) {
+	if (err)
 		dev_err(&client->dev, "unable to create sysfs files\n");
-		goto cleanup;
-	}
 
+free_clk_names:
 	/* Free the names, clk framework makes copies */
 	for (i = 0; i < data->num_synth; ++i)
 		 devm_kfree(&client->dev, (void *)synth_clock_names[i]);
 
-	return 0;
-
 cleanup:
-	for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
-		if (data->clk[i].vddo_reg)
-			regulator_disable(data->clk[i].vddo_reg);
+	if (err) {
+		for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
+			if (data->clk[i].vddo_reg)
+				regulator_disable(data->clk[i].vddo_reg);
+		}
 	}
 	return err;
 }
diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 5f8bd49b0810..c52f02471bb4 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -992,6 +992,11 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1006,6 +1011,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1021,6 +1030,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1038,6 +1051,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1057,6 +1074,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1075,6 +1096,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1101,6 +1126,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0674dbc62eb5..5eba83745d8d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4504,6 +4504,7 @@ int devm_clk_notifier_register(struct device *dev, struct clk *clk,
 	if (!ret) {
 		devres->clk = clk;
 		devres->nb = nb;
+		devres_add(dev, devres);
 	} else {
 		devres_free(devres);
 	}
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 52903146fdba..4499da4154f0 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -299,7 +299,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX8MN_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
@@ -316,10 +316,10 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
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
index b173c3009394..0191457fb3cf 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -407,25 +407,22 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
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
@@ -710,7 +707,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (err < 0) {
+		dev_err(dev, "failed to register hws for i.MX8MP\n");
+		imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
+		return err;
+	}
 
 	imx_register_uart_clocks(4);
 
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index dc933fd5d5a0..1cee88b073fa 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -702,11 +702,11 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 
 void imx_clk_scu_unregister(void)
 {
-	struct imx_scu_clk_node *clk;
+	struct imx_scu_clk_node *clk, *n;
 	int i;
 
 	for (i = 0; i < IMX_SC_R_LAST; i++) {
-		list_for_each_entry(clk, &imx_scu_clks[i], node) {
+		list_for_each_entry_safe(clk, n, &imx_scu_clks[i], node) {
 			clk_hw_unregister(clk->hw);
 			kfree(clk);
 		}
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
 
diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index ce73ee9037cb..4b3e3902b7ee 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1493,12 +1493,21 @@ static struct clk_branch cam_cc_sys_tmr_clk = {
 	},
 };
 
+static struct gdsc titan_top_gdsc = {
+	.gdscr = 0xb134,
+	.pd = {
+		.name = "titan_top_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct gdsc bps_gdsc = {
 	.gdscr = 0x6004,
 	.pd = {
 		.name = "bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 	.flags = HW_CTRL,
 };
 
@@ -1508,6 +1517,7 @@ static struct gdsc ife_0_gdsc = {
 		.name = "ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };
 
 static struct gdsc ife_1_gdsc = {
@@ -1516,6 +1526,7 @@ static struct gdsc ife_1_gdsc = {
 		.name = "ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };
 
 static struct gdsc ipe_0_gdsc = {
@@ -1525,15 +1536,9 @@ static struct gdsc ipe_0_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = HW_CTRL,
+	.parent = &titan_top_gdsc.pd,
 };
 
-static struct gdsc titan_top_gdsc = {
-	.gdscr = 0xb134,
-	.pd = {
-		.name = "titan_top_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-};
 
 static struct clk_hw *cam_cc_sc7180_hws[] = {
 	[CAM_CC_PLL2_OUT_EARLY] = &cam_cc_pll2_out_early.hw,
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
index 219c80653dbd..2a6db0434281 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -464,6 +464,7 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 		err = load_one_timing_from_dt(tegra, timing, child);
 		if (err) {
 			of_node_put(child);
+			kfree(tegra->timings);
 			return err;
 		}
 
@@ -515,6 +516,7 @@ struct clk *tegra124_clk_register_emc(void __iomem *base, struct device_node *np
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
index eee74a2fe317..2f5063db2f1f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -824,6 +824,8 @@ static ssize_t store_energy_performance_preference(
 			err = cpufreq_start_governor(policy);
 			if (!ret)
 				ret = err;
+		} else {
+			ret = 0;
 		}
 	}
 
diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index c6f2fa753b7c..0f37dfd42d85 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -297,7 +297,7 @@ static int mv_cesa_des_setkey(struct crypto_skcipher *cipher, const u8 *key,
 static int mv_cesa_des3_ede_setkey(struct crypto_skcipher *cipher,
 				   const u8 *key, unsigned int len)
 {
-	struct mv_cesa_des_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct mv_cesa_des3_ctx *ctx = crypto_skcipher_ctx(cipher);
 	int err;
 
 	err = verify_skcipher_des3_key(cipher, key);
diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
index d00181a26dd6..483cef62acee 100644
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
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 4261749fae8d..75693ca4afea 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -49,11 +49,6 @@ struct service_hndl {
 	struct list_head list;
 };
 
-static inline int get_current_node(void)
-{
-	return topology_physical_package_id(raw_smp_processor_id());
-}
-
 int adf_service_register(struct service_hndl *service);
 int adf_service_unregister(struct service_hndl *service);
 
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 906082fbdd67..f56ee4cc5ae8 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -605,7 +605,7 @@ static int qat_alg_aead_newkey(struct crypto_aead *tfm, const u8 *key,
 {
 	struct qat_alg_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qat_crypto_instance *inst = NULL;
-	int node = get_current_node();
+	int node = numa_node_id();
 	struct device *dev;
 	int ret;
 
@@ -706,7 +706,8 @@ static void qat_alg_free_bufl(struct qat_crypto_instance *inst,
 static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 			       struct scatterlist *sgl,
 			       struct scatterlist *sglout,
-			       struct qat_crypto_request *qat_req)
+			       struct qat_crypto_request *qat_req,
+			       gfp_t flags)
 {
 	struct device *dev = &GET_DEV(inst->accel_dev);
 	int i, sg_nctr = 0;
@@ -727,7 +728,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 	qat_req->buf.sgl_dst_valid = false;
 
 	if (n > QAT_MAX_BUFF_DESC) {
-		bufl = kzalloc_node(sz, GFP_ATOMIC, node);
+		bufl = kzalloc_node(sz, flags, node);
 		if (unlikely(!bufl))
 			return -ENOMEM;
 	} else {
@@ -771,7 +772,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		sg_nctr = 0;
 
 		if (n > QAT_MAX_BUFF_DESC) {
-			buflout = kzalloc_node(sz_out, GFP_ATOMIC, node);
+			buflout = kzalloc_node(sz_out, flags, node);
 			if (unlikely(!buflout))
 				goto err_in;
 		} else {
@@ -972,6 +973,7 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 	struct icp_qat_fw_la_auth_req_params *auth_param;
 	struct icp_qat_fw_la_bulk_req *msg;
 	int digst_size = crypto_aead_authsize(aead_tfm);
+	gfp_t f = qat_algs_alloc_flags(&areq->base);
 	int ret;
 	u32 cipher_len;
 
@@ -979,7 +981,7 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 	if (cipher_len % AES_BLOCK_SIZE != 0)
 		return -EINVAL;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1014,6 +1016,7 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 	struct qat_crypto_request *qat_req = aead_request_ctx(areq);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
 	struct icp_qat_fw_la_auth_req_params *auth_param;
+	gfp_t f = qat_algs_alloc_flags(&areq->base);
 	struct icp_qat_fw_la_bulk_req *msg;
 	u8 *iv = areq->iv;
 	int ret;
@@ -1021,7 +1024,7 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 	if (areq->cryptlen % AES_BLOCK_SIZE != 0)
 		return -EINVAL;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1068,7 +1071,7 @@ static int qat_alg_skcipher_newkey(struct qat_alg_skcipher_ctx *ctx,
 {
 	struct qat_crypto_instance *inst = NULL;
 	struct device *dev;
-	int node = get_current_node();
+	int node = numa_node_id();
 	int ret;
 
 	inst = qat_crypto_get_instance_node(node);
@@ -1199,13 +1202,14 @@ static int qat_alg_skcipher_encrypt(struct skcipher_request *req)
 	struct qat_alg_skcipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct qat_crypto_request *qat_req = skcipher_request_ctx(req);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
+	gfp_t f = qat_algs_alloc_flags(&req->base);
 	struct icp_qat_fw_la_bulk_req *msg;
 	int ret;
 
 	if (req->cryptlen == 0)
 		return 0;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1264,13 +1268,14 @@ static int qat_alg_skcipher_decrypt(struct skcipher_request *req)
 	struct qat_alg_skcipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct qat_crypto_request *qat_req = skcipher_request_ctx(req);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
+	gfp_t f = qat_algs_alloc_flags(&req->base);
 	struct icp_qat_fw_la_bulk_req *msg;
 	int ret;
 
 	if (req->cryptlen == 0)
 		return 0;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 5f11929cf9ba..4128200a9032 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -170,15 +170,14 @@ static void qat_dh_cb(struct icp_qat_fw_pke_resp *resp)
 	}
 
 	areq->dst_len = req->ctx.dh->p_size;
+	dma_unmap_single(dev, req->out.dh.r, req->ctx.dh->p_size,
+			 DMA_FROM_DEVICE);
 	if (req->dst_align) {
 		scatterwalk_map_and_copy(req->dst_align, areq->dst, 0,
 					 areq->dst_len, 1);
 		kfree_sensitive(req->dst_align);
 	}
 
-	dma_unmap_single(dev, req->out.dh.r, req->ctx.dh->p_size,
-			 DMA_FROM_DEVICE);
-
 	dma_unmap_single(dev, req->phy_in, sizeof(struct qat_dh_input_params),
 			 DMA_TO_DEVICE);
 	dma_unmap_single(dev, req->phy_out,
@@ -224,9 +223,10 @@ static int qat_dh_compute_value(struct kpp_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(kpp_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
-	int ret;
+	gfp_t flags = qat_algs_alloc_flags(&req->base);
 	int n_input_params = 0;
 	u8 *vaddr;
+	int ret;
 
 	if (unlikely(!ctx->xa))
 		return -EINVAL;
@@ -291,7 +291,7 @@ static int qat_dh_compute_value(struct kpp_request *req)
 		} else {
 			int shift = ctx->p_size - req->src_len;
 
-			qat_req->src_align = kzalloc(ctx->p_size, GFP_KERNEL);
+			qat_req->src_align = kzalloc(ctx->p_size, flags);
 			if (unlikely(!qat_req->src_align))
 				return ret;
 
@@ -317,7 +317,7 @@ static int qat_dh_compute_value(struct kpp_request *req)
 		qat_req->dst_align = NULL;
 		vaddr = sg_virt(req->dst);
 	} else {
-		qat_req->dst_align = kzalloc(ctx->p_size, GFP_KERNEL);
+		qat_req->dst_align = kzalloc(ctx->p_size, flags);
 		if (unlikely(!qat_req->dst_align))
 			goto unmap_src;
 
@@ -331,13 +331,13 @@ static int qat_dh_compute_value(struct kpp_request *req)
 	qat_req->in.dh.in_tab[n_input_params] = 0;
 	qat_req->out.dh.out_tab[1] = 0;
 	/* Mapping in.in.b or in.in_g2.xa is the same */
-	qat_req->phy_in = dma_map_single(dev, &qat_req->in.dh.in.b,
+	qat_req->phy_in = dma_map_single(dev, &qat_req->in.dh,
 					 sizeof(struct qat_dh_input_params),
 					 DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_in)))
 		goto unmap_dst;
 
-	qat_req->phy_out = dma_map_single(dev, &qat_req->out.dh.r,
+	qat_req->phy_out = dma_map_single(dev, &qat_req->out.dh,
 					  sizeof(struct qat_dh_output_params),
 					  DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_out)))
@@ -488,11 +488,13 @@ static int qat_dh_init_tfm(struct crypto_kpp *tfm)
 {
 	struct qat_dh_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct qat_crypto_instance *inst =
-			qat_crypto_get_instance_node(get_current_node());
+			qat_crypto_get_instance_node(numa_node_id());
 
 	if (!inst)
 		return -EINVAL;
 
+	kpp_set_reqsize(tfm, sizeof(struct qat_asym_request) + 64);
+
 	ctx->p_size = 0;
 	ctx->g2 = false;
 	ctx->inst = inst;
@@ -518,12 +520,14 @@ static void qat_rsa_cb(struct icp_qat_fw_pke_resp *resp)
 
 	err = (err == ICP_QAT_FW_COMN_STATUS_FLAG_OK) ? 0 : -EINVAL;
 
-	kfree_sensitive(req->src_align);
-
 	dma_unmap_single(dev, req->in.rsa.enc.m, req->ctx.rsa->key_sz,
 			 DMA_TO_DEVICE);
 
+	kfree_sensitive(req->src_align);
+
 	areq->dst_len = req->ctx.rsa->key_sz;
+	dma_unmap_single(dev, req->out.rsa.enc.c, req->ctx.rsa->key_sz,
+			 DMA_FROM_DEVICE);
 	if (req->dst_align) {
 		scatterwalk_map_and_copy(req->dst_align, areq->dst, 0,
 					 areq->dst_len, 1);
@@ -531,9 +535,6 @@ static void qat_rsa_cb(struct icp_qat_fw_pke_resp *resp)
 		kfree_sensitive(req->dst_align);
 	}
 
-	dma_unmap_single(dev, req->out.rsa.enc.c, req->ctx.rsa->key_sz,
-			 DMA_FROM_DEVICE);
-
 	dma_unmap_single(dev, req->phy_in, sizeof(struct qat_rsa_input_params),
 			 DMA_TO_DEVICE);
 	dma_unmap_single(dev, req->phy_out,
@@ -650,6 +651,7 @@ static int qat_rsa_enc(struct akcipher_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(akcipher_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
+	gfp_t flags = qat_algs_alloc_flags(&req->base);
 	u8 *vaddr;
 	int ret;
 
@@ -696,7 +698,7 @@ static int qat_rsa_enc(struct akcipher_request *req)
 	} else {
 		int shift = ctx->key_sz - req->src_len;
 
-		qat_req->src_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->src_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->src_align))
 			return ret;
 
@@ -714,7 +716,7 @@ static int qat_rsa_enc(struct akcipher_request *req)
 		qat_req->dst_align = NULL;
 		vaddr = sg_virt(req->dst);
 	} else {
-		qat_req->dst_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->dst_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->dst_align))
 			goto unmap_src;
 		vaddr = qat_req->dst_align;
@@ -727,13 +729,13 @@ static int qat_rsa_enc(struct akcipher_request *req)
 
 	qat_req->in.rsa.in_tab[3] = 0;
 	qat_req->out.rsa.out_tab[1] = 0;
-	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa.enc.m,
+	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa,
 					 sizeof(struct qat_rsa_input_params),
 					 DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_in)))
 		goto unmap_dst;
 
-	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa.enc.c,
+	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa,
 					  sizeof(struct qat_rsa_output_params),
 					  DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_out)))
@@ -783,6 +785,7 @@ static int qat_rsa_dec(struct akcipher_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(akcipher_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
+	gfp_t flags = qat_algs_alloc_flags(&req->base);
 	u8 *vaddr;
 	int ret;
 
@@ -839,7 +842,7 @@ static int qat_rsa_dec(struct akcipher_request *req)
 	} else {
 		int shift = ctx->key_sz - req->src_len;
 
-		qat_req->src_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->src_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->src_align))
 			return ret;
 
@@ -857,7 +860,7 @@ static int qat_rsa_dec(struct akcipher_request *req)
 		qat_req->dst_align = NULL;
 		vaddr = sg_virt(req->dst);
 	} else {
-		qat_req->dst_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->dst_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->dst_align))
 			goto unmap_src;
 		vaddr = qat_req->dst_align;
@@ -872,13 +875,13 @@ static int qat_rsa_dec(struct akcipher_request *req)
 	else
 		qat_req->in.rsa.in_tab[3] = 0;
 	qat_req->out.rsa.out_tab[1] = 0;
-	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa.dec.c,
+	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa,
 					 sizeof(struct qat_rsa_input_params),
 					 DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_in)))
 		goto unmap_dst;
 
-	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa.dec.m,
+	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa,
 					  sizeof(struct qat_rsa_output_params),
 					  DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_out)))
@@ -1222,11 +1225,13 @@ static int qat_rsa_init_tfm(struct crypto_akcipher *tfm)
 {
 	struct qat_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
 	struct qat_crypto_instance *inst =
-			qat_crypto_get_instance_node(get_current_node());
+			qat_crypto_get_instance_node(numa_node_id());
 
 	if (!inst)
 		return -EINVAL;
 
+	akcipher_set_reqsize(tfm, sizeof(struct qat_asym_request) + 64);
+
 	ctx->key_sz = 0;
 	ctx->inst = inst;
 	return 0;
@@ -1249,7 +1254,6 @@ static struct akcipher_alg rsa = {
 	.max_size = qat_rsa_max_size,
 	.init = qat_rsa_init_tfm,
 	.exit = qat_rsa_exit_tfm,
-	.reqsize = sizeof(struct qat_asym_request) + 64,
 	.base = {
 		.cra_name = "rsa",
 		.cra_driver_name = "qat-rsa",
@@ -1266,7 +1270,6 @@ static struct kpp_alg dh = {
 	.max_size = qat_dh_max_size,
 	.init = qat_dh_init_tfm,
 	.exit = qat_dh_exit_tfm,
-	.reqsize = sizeof(struct qat_asym_request) + 64,
 	.base = {
 		.cra_name = "dh",
 		.cra_driver_name = "qat-dh",
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.h b/drivers/crypto/qat/qat_common/qat_crypto.h
index 245b6d9a3650..df3c738ce323 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.h
+++ b/drivers/crypto/qat/qat_common/qat_crypto.h
@@ -109,4 +109,9 @@ static inline bool adf_hw_dev_has_crypto(struct adf_accel_dev *accel_dev)
 	return true;
 }
 
+static inline gfp_t qat_algs_alloc_flags(struct crypto_async_request *req)
+{
+	return req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
+}
+
 #endif
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index e75b9edc88a1..7ad61c707687 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -402,18 +402,34 @@ static void unregister_dev_dax(void *dev)
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
@@ -429,6 +445,20 @@ static int free_dev_dax_id(struct dev_dax *dev_dax)
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
@@ -516,20 +546,6 @@ static const struct attribute_group *dax_region_attribute_groups[] = {
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
@@ -591,10 +607,12 @@ EXPORT_SYMBOL_GPL(alloc_dax_region);
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
@@ -734,6 +752,7 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	dev = &mapping->dev;
 	device_initialize(dev);
 	dev->parent = &dev_dax->dev;
+	get_device(dev->parent);
 	dev->type = &dax_mapping_type;
 	dev_set_name(dev, "mapping%d", mapping->id);
 	rc = device_add(dev);
@@ -1251,12 +1270,10 @@ static const struct attribute_group *dax_attribute_groups[] = {
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
@@ -1280,6 +1297,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
+	dev_dax->region = dax_region;
 	if (is_static(dax_region)) {
 		if (dev_WARN_ONCE(parent, data->id < 0,
 				"dynamic id specified to static region\n")) {
@@ -1295,13 +1313,11 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
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
@@ -1339,7 +1355,6 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
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
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 04f85f16720c..97723ee15bc6 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -88,7 +88,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (!data->res_name)
 		goto err_res_name;
 
-	rc = memory_group_register_static(numa_node, total_len);
+	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
 	if (rc < 0)
 		goto err_reg_mgid;
 	data->mgid = rc;
diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 9dfa545427ca..b408ce989c22 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -428,8 +428,7 @@ static int tusb320_typec_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int tusb320_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int tusb320_probe(struct i2c_client *client)
 {
 	struct tusb320_priv *priv;
 	const void *match_data;
@@ -502,7 +501,7 @@ static const struct of_device_id tusb320_extcon_dt_match[] = {
 MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
 
 static struct i2c_driver tusb320_extcon_driver = {
-	.probe		= tusb320_probe,
+	.probe_new	= tusb320_probe,
 	.driver		= {
 		.name	= "extcon-tusb320",
 		.of_match_table = tusb320_extcon_dt_match,
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index f305503ec27e..6a0d55d627ad 100644
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
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index d489bdc645fe..2a00eb627c3c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -439,8 +439,10 @@ efi_status_t efi_exit_boot_services(void *handle,
 {
 	efi_status_t status;
 
-	status = efi_get_memory_map(map);
+	if (efi_disable_pci_dma)
+		efi_pci_disable_bridge_busmaster();
 
+	status = efi_get_memory_map(map);
 	if (status != EFI_SUCCESS)
 		goto fail;
 
@@ -448,9 +450,6 @@ efi_status_t efi_exit_boot_services(void *handle,
 	if (status != EFI_SUCCESS)
 		goto free_map;
 
-	if (efi_disable_pci_dma)
-		efi_pci_disable_bridge_busmaster();
-
 	status = efi_bs_call(exit_boot_services, handle, *map->key_ptr);
 
 	if (status == EFI_INVALID_PARAMETER) {
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2b50dc21fba1..1bd3979abde6 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 34303dd3ada9..00a8aef48a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2350,6 +2350,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 			if (!attachment->is_mapped)
 				continue;
 
+			if (attachment->bo_va->base.bo->tbo.pin_count)
+				continue;
+
 			kfd_mem_dmaunmap_attachment(mem, attachment);
 			ret = update_gpuvm_pte(mem, attachment, &sync_obj, NULL);
 			if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8da5cc8fcc6c..0e4554950e07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2334,14 +2334,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
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
 
@@ -2400,14 +2400,14 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
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
 
@@ -2575,18 +2575,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 
 	/* Insert partial mapping before the range */
 	if (!list_empty(&before->list)) {
+		struct amdgpu_bo *bo = before->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(before, &vm->va);
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !before->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
 
 	/* Insert partial mapping after the range */
 	if (!list_empty(&after->list)) {
+		struct amdgpu_bo *bo = after->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(after, &vm->va);
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !after->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7f4e102ff4bd..ddaafcd7b825 100644
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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index be863af956bb..79ac19948e7a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10209,6 +10209,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 		/* Now check if we should set freesync video mode */
 		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
+		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
+		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 8ecc708bcd9e..766759420eeb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -302,6 +302,9 @@ void dcn30_smu_set_display_refresh_from_mall(struct clk_mgr_internal *clk_mgr, b
 	/* bits 8:7 for cache timer scale, bits 6:1 for cache timer delay, bit 0 = 1 for enable, = 0 for disable */
 	uint32_t param = (cache_timer_scale << 7) | (cache_timer_delay << 1) | (enable ? 1 : 0);
 
+	smu_print("SMU Set display refresh from mall: enable = %d, cache_timer_delay = %d, cache_timer_scale = %d\n",
+		enable, cache_timer_delay, cache_timer_scale);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetDisplayRefreshFromMall, param, NULL);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 220a26e45a28..634640d5c0ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2111,9 +2111,6 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 
-	if (u->flip_addr)
-		update_flags->bits.addr_update = 1;
-
 	if (!is_surface_in_context(context, u->surface) || u->surface->force_full_update) {
 		update_flags->raw = 0xFFFFFFFF;
 		return UPDATE_TYPE_FULL;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index caf961bb633f..0fc4f90d9e3e 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -445,7 +445,7 @@ struct dmub_notification {
  * of a firmware to know if feature or functionality is supported or present.
  */
 #define DMUB_FW_VERSION(major, minor, revision) \
-	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
+	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | (((revision) & 0xFF) << 8))
 
 /**
  * dmub_srv_create() - creates the DMUB service.
diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index a3db532bbdd1..8b1bdffc5005 100644
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
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index bbedce0eedda..22c2ff5272c6 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -147,9 +147,9 @@
  *                each other's read-modify-write.
  */
 struct ti_sn65dsi86 {
-	struct auxiliary_device		bridge_aux;
-	struct auxiliary_device		gpio_aux;
-	struct auxiliary_device		aux_aux;
+	struct auxiliary_device		*bridge_aux;
+	struct auxiliary_device		*gpio_aux;
+	struct auxiliary_device		*aux_aux;
 
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -412,27 +412,34 @@ static void ti_sn65dsi86_delete_aux(void *data)
 	auxiliary_device_delete(data);
 }
 
-/*
- * AUX bus docs say that a non-NULL release is mandatory, but it makes no
- * sense for the model used here where all of the aux devices are allocated
- * in the single shared structure. We'll use this noop as a workaround.
- */
-static void ti_sn65dsi86_noop(struct device *dev) {}
+static void ti_sn65dsi86_aux_device_release(struct device *dev)
+{
+	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device, dev);
+
+	kfree(aux);
+}
 
 static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
-				       struct auxiliary_device *aux,
+				       struct auxiliary_device **aux_out,
 				       const char *name)
 {
 	struct device *dev = pdata->dev;
+	struct auxiliary_device *aux;
 	int ret;
 
+	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
+	if (!aux)
+		return -ENOMEM;
+
 	aux->name = name;
 	aux->dev.parent = dev;
-	aux->dev.release = ti_sn65dsi86_noop;
+	aux->dev.release = ti_sn65dsi86_aux_device_release;
 	device_set_of_node_from_dev(&aux->dev, dev);
 	ret = auxiliary_device_init(aux);
-	if (ret)
+	if (ret) {
+		kfree(aux);
 		return ret;
+	}
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_uninit_aux, aux);
 	if (ret)
 		return ret;
@@ -441,6 +448,8 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 	if (ret)
 		return ret;
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_delete_aux, aux);
+	if (!ret)
+		*aux_out = aux;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 1fcb5f8aea20..166d329de939 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -138,6 +138,12 @@ drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
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
@@ -297,7 +303,8 @@ EXPORT_SYMBOL(drm_atomic_state_clear);
 void __drm_atomic_state_free(struct kref *ref)
 {
 	struct drm_atomic_state *state = container_of(ref, typeof(*state), ref);
-	struct drm_mode_config *config = &state->dev->mode_config;
+	struct drm_device *dev = state->dev;
+	struct drm_mode_config *config = &dev->mode_config;
 
 	drm_atomic_state_clear(state);
 
@@ -309,6 +316,8 @@ void __drm_atomic_state_free(struct kref *ref)
 		drm_atomic_state_default_release(state);
 		kfree(state);
 	}
+
+	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(__drm_atomic_state_free);
 
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index aa09a19fae37..5ba316391381 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1115,7 +1115,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
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
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 43cf7e887d1a..aaf4f7dcc581 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -43,7 +43,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  * the frame's scanout buffer or the cursor image. If there's no more space
  * left in VRAM, inactive GEM objects can be moved to system memory.
  *
- * To initialize the VRAM helper library call drmm_vram_helper_alloc_mm().
+ * To initialize the VRAM helper library call drmm_vram_helper_init().
  * The function allocates and initializes an instance of &struct drm_vram_mm
  * in &struct drm_device.vram_mm . Use &DRM_GEM_VRAM_DRIVER to initialize
  * &struct drm_driver and  &DRM_VRAM_MM_FILE_OPERATIONS to initialize
@@ -71,7 +71,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  *		// setup device, vram base and size
  *		// ...
  *
- *		ret = drmm_vram_helper_alloc_mm(dev, vram_base, vram_size);
+ *		ret = drmm_vram_helper_init(dev, vram_base, vram_size);
  *		if (ret)
  *			return ret;
  *		return 0;
@@ -84,7 +84,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  * to userspace.
  *
  * You don't have to clean up the instance of VRAM MM.
- * drmm_vram_helper_alloc_mm() is a managed interface that installs a
+ * drmm_vram_helper_init() is a managed interface that installs a
  * clean-up handler to run during the DRM device's release.
  *
  * For drawing or scanout operations, rsp. buffer objects have to be pinned
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index cf1e92486cbc..93d2fd4cd16b 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -862,9 +862,9 @@ static bool _compute_psr2_wake_times(struct intel_dp *intel_dp,
 	}
 
 	io_wake_lines = intel_usecs_to_scanlines(
-		&crtc_state->uapi.adjusted_mode, io_wake_time);
+		&crtc_state->hw.adjusted_mode, io_wake_time);
 	fast_wake_lines = intel_usecs_to_scanlines(
-		&crtc_state->uapi.adjusted_mode, fast_wake_time);
+		&crtc_state->hw.adjusted_mode, fast_wake_time);
 
 	if (io_wake_lines > max_wake_lines ||
 	    fast_wake_lines > max_wake_lines)
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 2d3a979736cc..f9d4094916e3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -547,7 +547,7 @@ __vm_create_scratch_for_read(struct i915_address_space *vm, unsigned long size)
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 
-	i915_gem_object_set_cache_coherency(obj, I915_CACHING_CACHED);
+	i915_gem_object_set_cache_coherency(obj, I915_CACHE_LLC);
 
 	vma = i915_vma_instance(obj, vm, NULL);
 	if (IS_ERR(vma)) {
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index d92416d52628..ef62900b0612 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1746,6 +1746,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
+	struct adreno_platform_config *config = pdev->dev.platform_data;
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
@@ -1772,7 +1773,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	nr_rings = 4;
 
-	if (adreno_is_a510(adreno_gpu))
+	if (adreno_cmp_rev(ADRENO_REV(5, 1, 0, ANY_ID), config->rev))
 		nr_rings = 1;
 
 	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 4194689b6b35..8be941c9b6a9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1380,6 +1380,8 @@ static const struct drm_crtc_helper_funcs dpu_crtc_helper_funcs = {
 struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 				struct drm_plane *cursor)
 {
+	struct msm_drm_private *priv = dev->dev_private;
+	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 	struct drm_crtc *crtc = NULL;
 	struct dpu_crtc *dpu_crtc = NULL;
 	int i;
@@ -1411,7 +1413,8 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 
 	drm_crtc_helper_add(crtc, &dpu_crtc_helper_funcs);
 
-	drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
+	if (dpu_kms->catalog->dspp_count)
+		drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
 
 	/* save user friendly CRTC name for later */
 	snprintf(dpu_crtc->name, DPU_CRTC_NAME_SIZE, "crtc%u", crtc->base.id);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 4c65259eecb9..272a3d7e1aef 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -53,9 +53,13 @@
 
 #define INTF_SDM845_MASK (0)
 
-#define INTF_SC7180_MASK BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE)
+#define INTF_SC7180_MASK \
+	(BIT(DPU_INTF_INPUT_CTRL) | \
+	 BIT(DPU_INTF_TE) | \
+	 BIT(DPU_INTF_STATUS_SUPPORTED) | \
+	 BIT(DPU_DATA_HCTL_EN))
 
-#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
+#define INTF_SC7280_MASK (INTF_SC7180_MASK)
 
 #define IRQ_SDM845_MASK (BIT(MDP_SSPP_TOP0_INTR) | \
 			 BIT(MDP_SSPP_TOP0_INTR2) | \
@@ -804,7 +808,7 @@ static const struct dpu_pingpong_cfg sm8150_pp[] = {
 #define MERGE_3D_BLK(_name, _id, _base) \
 	{\
 	.name = _name, .id = _id, \
-	.base = _base, .len = 0x100, \
+	.base = _base, .len = 0x8, \
 	.features = MERGE_3D_SM8150_MASK, \
 	.sblk = NULL \
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index d2a945a27cfa..321b7599fe2d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -191,17 +191,19 @@ enum {
 
 /**
  * INTF sub-blocks
- * @DPU_INTF_INPUT_CTRL         Supports the setting of pp block from which
- *                              pixel data arrives to this INTF
- * @DPU_INTF_TE                 INTF block has TE configuration support
- * @DPU_DATA_HCTL_EN            Allows data to be transferred at different rate
-                                than video timing
+ * @DPU_INTF_INPUT_CTRL             Supports the setting of pp block from which
+ *                                  pixel data arrives to this INTF
+ * @DPU_INTF_TE                     INTF block has TE configuration support
+ * @DPU_DATA_HCTL_EN                Allows data to be transferred at different rate
+ *                                  than video timing
+ * @DPU_INTF_STATUS_SUPPORTED       INTF block has INTF_STATUS register
  * @DPU_INTF_MAX
  */
 enum {
 	DPU_INTF_INPUT_CTRL = 0x1,
 	DPU_INTF_TE,
 	DPU_DATA_HCTL_EN,
+	DPU_INTF_STATUS_SUPPORTED,
 	DPU_INTF_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 916e2a4756c0..7c09d30a62b8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -54,6 +54,7 @@
 #define   INTF_PROG_FETCH_START         0x170
 #define   INTF_PROG_ROT_START           0x174
 #define   INTF_MUX                      0x25C
+#define   INTF_STATUS                   0x26C
 
 static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
 		const struct dpu_mdss_cfg *m,
@@ -259,8 +260,13 @@ static void dpu_hw_intf_get_status(
 		struct intf_status *s)
 {
 	struct dpu_hw_blk_reg_map *c = &intf->hw;
+	unsigned long cap = intf->cap->features;
+
+	if (cap & BIT(DPU_INTF_STATUS_SUPPORTED))
+		s->is_en = DPU_REG_READ(c, INTF_STATUS) & BIT(0);
+	else
+		s->is_en = DPU_REG_READ(c, INTF_TIMING_ENGINE_EN);
 
-	s->is_en = DPU_REG_READ(c, INTF_TIMING_ENGINE_EN);
 	s->is_prog_fetch_en = !!(DPU_REG_READ(c, INTF_CONFIG) & BIT(31));
 	if (s->is_en) {
 		s->frame_count = DPU_REG_READ(c, INTF_FRAME_COUNT);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 38d37345c216..bbe350fab797 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1295,9 +1295,9 @@ static int dp_display_remove(struct platform_device *pdev)
 	dp = container_of(g_dp_display,
 			struct dp_display_private, dp_display);
 
+	component_del(&pdev->dev, &dp_display_comp_ops);
 	dp_display_deinit_sub_modules(dp);
 
-	component_del(&pdev->dev, &dp_display_comp_ops);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
index 6d3abcdc57bf..66507eb71304 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
@@ -541,6 +541,9 @@ static int dsi_pll_14nm_vco_prepare(struct clk_hw *hw)
 	if (unlikely(pll_14nm->phy->pll_on))
 		return 0;
 
+	if (dsi_pll_14nm_vco_recalc_rate(hw, VCO_REF_CLK_RATE) == 0)
+		dsi_pll_14nm_vco_set_rate(hw, pll_14nm->phy->cfg->min_pll_rate, VCO_REF_CLK_RATE);
+
 	dsi_phy_write(base + REG_DSI_14nm_PHY_PLL_VREF_CFG1, 0x10);
 	dsi_phy_write(cmn_base + REG_DSI_14nm_PHY_CMN_PLL_CNTRL, 1);
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 25829a0a8e80..e2f1e983ef7e 100644
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
 			MIPI_DSI_MODE_NO_EOT_PACKET;
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index fb785f5a106a..391d73d2638a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -890,8 +890,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
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
@@ -2469,6 +2469,7 @@ static const struct panel_desc innolux_at043tn24 = {
 		.height = 54,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 };
 
@@ -3650,6 +3651,7 @@ static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
 	.vsync_start = 480 + 49,
 	.vsync_end = 480 + 49 + 2,
 	.vtotal = 480 + 49 + 2 + 22,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
 };
 
 static const struct panel_desc powertip_ph800480t013_idf02  = {
diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index f0cfb58da467..4f93cc81ca7a 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5520,6 +5520,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	u8 frev, crev;
 	u8 *power_state_offset;
 	struct ci_ps *ps;
+	int ret;
 
 	if (!atom_parse_data_header(mode_info->atom_context, index, NULL,
 				   &frev, &crev, &data_offset))
@@ -5549,11 +5550,15 @@ static int ci_parse_power_table(struct radeon_device *rdev)
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
@@ -5593,6 +5598,12 @@ static int ci_parse_power_table(struct radeon_device *rdev)
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
@@ -5681,25 +5692,26 @@ int ci_dpm_init(struct radeon_device *rdev)
 
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
index fdddbbaecbb7..72a0768df00f 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -557,8 +557,12 @@ static int cypress_populate_mclk_value(struct radeon_device *rdev,
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
index 672d2239293e..3e1c1a392fb7 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2241,8 +2241,12 @@ static int ni_populate_mclk_value(struct radeon_device *rdev,
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
index d57a3e1df8d6..4464fd21a302 100644
--- a/drivers/gpu/drm/radeon/rv740_dpm.c
+++ b/drivers/gpu/drm/radeon/rv740_dpm.c
@@ -249,8 +249,12 @@ int rv740_populate_mclk_value(struct radeon_device *rdev,
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
index d5b74ea06a45..26a3ed142b6b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -703,13 +703,13 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
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
@@ -741,9 +741,9 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
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
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 33e78f56123e..d5a2b69489e7 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1187,6 +1187,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
 		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, &ctx, &hop);
 		if (unlikely(ret != 0)) {
 			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
+			ttm_resource_free(bo, &evict_mem);
 			goto out;
 		}
 	}
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
index d311e0557401..b8543c06d022 100644
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
@@ -614,19 +634,10 @@ static int adm1275_probe(struct i2c_client *client)
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
+
 		if (config & ADM1278_VIN_EN)
 			info->func[0] |= PMBUS_HAVE_VIN;
 		break;
@@ -683,19 +694,9 @@ static int adm1275_probe(struct i2c_client *client)
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
@@ -756,6 +757,43 @@ static int adm1275_probe(struct i2c_client *client)
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
index 6471f4232a2e..3ea690054222 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1421,13 +1421,8 @@ static int coresight_remove_match(struct device *dev, void *data)
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
index fcd35e8de83c..b89eca2398d9 100644
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
index 34b8da949462..9652e8bea2d0 100644
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
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index a2d29cabb389..548a8c4269e7 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -486,8 +486,7 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 		.sign = 's', \
 		.realbits = 12, \
 		.storagebits = 16, \
-		.shift = 4, \
-		.endianness = IIO_BE, \
+		.endianness = IIO_LE, \
 	}, \
 }
 
@@ -656,9 +655,10 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 	int total_length = samples * sample_length;
 	int ret;
 
-	if (i2c_verify_client(dev))
+	if (i2c_verify_client(dev) &&
+	    data->chip_info->chip_id == FXLS8962AF_DEVICE_ID)
 		/*
-		 * Due to errata bug:
+		 * Due to errata bug (only applicable on fxls8962af):
 		 * E3: FIFO burst read operation error using I2C interface
 		 * We have to avoid burst reads on I2C..
 		 */
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 4b6b7bc86100..6df435e3c421 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -327,7 +327,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
-	if (st->mclk) {
+	if (!st->mclk) {
 		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
@@ -340,9 +340,9 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
+	struct ad7192_state *st = iio_priv(indio_dev);
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
@@ -1015,7 +1015,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(st, spi->dev.of_node);
+	ret = ad7192_setup(indio_dev, spi->dev.of_node);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 705d5e11a54b..36ec07ad7017 100644
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
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 66268e41b470..7b85eef113fc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -331,15 +331,21 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
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
 
@@ -1173,12 +1179,6 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
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
 
@@ -1196,7 +1196,7 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
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
index 037501952543..f859710f9a7f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -471,7 +471,7 @@ typedef int (*srqn_handler_t)(struct bnxt_qplib_nq *nq,
 struct bnxt_qplib_nq {
 	struct pci_dev			*pdev;
 	struct bnxt_qplib_res		*res;
-	char				name[32];
+	char				*name;
 	struct bnxt_qplib_hwq		hwq;
 	struct bnxt_qplib_nq_db		nq_db;
 	u16				ring_id;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index d2d39126f185..3b8cb46551bf 100644
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
@@ -299,7 +299,8 @@ static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 }
 
 static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
-				       struct creq_qp_event *qp_event)
+				       struct creq_qp_event *qp_event,
+				       u32 *num_wait)
 {
 	struct creq_qp_error_notification *err_event;
 	struct bnxt_qplib_hwq *hwq = &rcfw->cmdq.hwq;
@@ -308,6 +309,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	u16 cbit, blocked = 0;
 	struct pci_dev *pdev;
 	unsigned long flags;
+	u32 wait_cmds = 0;
 	__le16  mcookie;
 	u16 cookie;
 	int rc = 0;
@@ -367,9 +369,10 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		crsqe->req_size = 0;
 
 		if (!blocked)
-			wake_up(&rcfw->cmdq.waitq);
+			wait_cmds++;
 		spin_unlock_irqrestore(&hwq->lock, flags);
 	}
+	*num_wait += wait_cmds;
 	return rc;
 }
 
@@ -383,6 +386,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	struct creq_base *creqe;
 	u32 sw_cons, raw_cons;
 	unsigned long flags;
+	u32 num_wakeup = 0;
 
 	/* Service the CREQ until budget is over */
 	spin_lock_irqsave(&hwq->lock, flags);
@@ -401,7 +405,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 		switch (type) {
 		case CREQ_BASE_TYPE_QP_EVENT:
 			bnxt_qplib_process_qp_event
-				(rcfw, (struct creq_qp_event *)creqe);
+				(rcfw, (struct creq_qp_event *)creqe,
+				 &num_wakeup);
 			creq->stats.creq_qp_event_processed++;
 			break;
 		case CREQ_BASE_TYPE_FUNC_EVENT:
@@ -429,6 +434,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 				      rcfw->res->cctx, true);
 	}
 	spin_unlock_irqrestore(&hwq->lock, flags);
+	if (num_wakeup)
+		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
 }
 
 static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
@@ -599,7 +606,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 		rcfw->cmdq_depth = BNXT_QPLIB_CMDQE_MAX_CNT_8192;
 
 	sginfo.pgsize = bnxt_qplib_cmdqe_page_size(rcfw->cmdq_depth);
-	hwq_attr.depth = rcfw->cmdq_depth;
+	hwq_attr.depth = rcfw->cmdq_depth & 0x7FFFFFFF;
 	hwq_attr.stride = BNXT_QPLIB_CMDQE_UNITS;
 	hwq_attr.type = HWQ_TYPE_CTX;
 	if (bnxt_qplib_alloc_init_hwq(&cmdq->hwq, &hwq_attr)) {
@@ -637,6 +644,10 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	struct bnxt_qplib_creq_ctx *creq;
 
 	creq = &rcfw->creq;
+
+	if (!creq->requested)
+		return;
+
 	tasklet_disable(&creq->creq_tasklet);
 	/* Mask h/w interrupts */
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, false);
@@ -645,10 +656,10 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
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
@@ -680,9 +691,11 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 			      bool need_init)
 {
 	struct bnxt_qplib_creq_ctx *creq;
+	struct bnxt_qplib_res *res;
 	int rc;
 
 	creq = &rcfw->creq;
+	res = rcfw->res;
 
 	if (creq->requested)
 		return -EFAULT;
@@ -692,13 +705,22 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
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
index 0c6d0b70ce89..2acdec55a667 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -174,6 +174,7 @@ struct bnxt_qplib_creq_ctx {
 	u16				ring_id;
 	int				msix_vec;
 	bool				requested; /*irq handler installed */
+	char				*irq_name;
 };
 
 /* RCFW Communication Channels */
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 33ffb00c6382..a89d1bd99a33 100644
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
index 71b9ac018887..94f170166730 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -19,8 +19,7 @@ static int mmu_notifier_range_start(struct mmu_notifier *,
 		const struct mmu_notifier_range *);
 static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *,
 					   unsigned long, unsigned long);
-static void do_remove(struct mmu_rb_handler *handler,
-		      struct list_head *del_list);
+static void release_immediate(struct kref *refcount);
 static void handle_remove(struct work_struct *work);
 
 static const struct mmu_notifier_ops mn_opts = {
@@ -103,7 +102,11 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler)
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
@@ -131,12 +134,6 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
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
@@ -180,6 +177,48 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
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
@@ -194,6 +233,10 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 
 	spin_lock_irqsave(&handler->lock, flags);
 	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
+		/* refcount == 1 implies mmu_rb_handler has only rbnode ref */
+		if (kref_read(&rbnode->refcount) > 1)
+			continue;
+
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -206,7 +249,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	spin_unlock_irqrestore(&handler->lock, flags);
 
 	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
-		handler->ops->remove(handler->ops_arg, rbnode);
+		kref_put(&rbnode->refcount, release_immediate);
 	}
 }
 
@@ -218,7 +261,6 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 	struct rb_root_cached *root = &handler->root;
 	struct mmu_rb_node *node, *ptr = NULL;
 	unsigned long flags;
-	bool added = false;
 
 	spin_lock_irqsave(&handler->lock, flags);
 	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
@@ -227,38 +269,16 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
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
@@ -271,11 +291,16 @@ static void handle_remove(struct work_struct *work)
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
index ed75acdb7b83..dd2c4a0ae95b 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -16,6 +16,7 @@ struct mmu_rb_node {
 	struct rb_node node;
 	struct mmu_rb_handler *handler;
 	struct list_head list;
+	struct kref refcount;
 };
 
 /*
@@ -51,6 +52,8 @@ int hfi1_mmu_rb_register(void *ops_arg,
 void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
 int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		       struct mmu_rb_node *mnode);
+void hfi1_mmu_rb_release(struct kref *refcount);
+
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg);
 struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
 					  unsigned long addr,
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index bb2552dd29c1..26c62162759b 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1593,7 +1593,20 @@ static inline void sdma_unmap_desc(
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
@@ -3113,8 +3126,8 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 
 		/* Add descriptor for coalesce buffer */
 		tx->desc_limit = MAX_DESC;
-		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx,
-					 addr, tx->tlen);
+		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx,
+					 addr, tx->tlen, NULL, NULL, NULL);
 	}
 
 	return 1;
@@ -3157,9 +3170,9 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 	make_tx_sdma_desc(
 		tx,
 		SDMA_MAP_NONE,
-		NULL,
 		dd->sdma_pad_phys,
-		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
+		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)),
+		NULL, NULL, NULL);
 	tx->num_desc++;
 	_sdma_close_tx(dd, tx);
 	return rval;
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 95aaec14c6c2..7fdebab202c4 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -594,9 +594,11 @@ static inline dma_addr_t sdma_mapping_addr(struct sdma_desc *d)
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
 
@@ -613,7 +615,11 @@ static inline void make_tx_sdma_desc(
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
@@ -645,18 +651,20 @@ static inline void _sdma_close_tx(struct hfi1_devdata *dd,
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
 	tx->num_desc++;
 	tx->tlen -= len;
@@ -676,11 +684,18 @@ static inline int _sdma_txadd_daddr(
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
@@ -692,11 +707,13 @@ static inline int _sdma_txadd_daddr(
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
@@ -720,7 +737,8 @@ static inline int sdma_txadd_page(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, pinning_ctx, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, tx, addr, len,
+				 pinning_ctx, ctx_get, ctx_put);
 }
 
 /**
@@ -754,8 +772,8 @@ static inline int sdma_txadd_daddr(
 			return rval;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, NULL, tx,
-				 addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len,
+				 NULL, NULL, NULL);
 }
 
 /**
@@ -801,7 +819,8 @@ static inline int sdma_txadd_kvaddr(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx, addr, len,
+				 NULL, NULL, NULL);
 }
 
 struct iowait_work;
@@ -1034,6 +1053,4 @@ u16 sdma_get_descq_cnt(void);
 extern uint mod_num_sdma;
 
 void sdma_update_lmc(struct hfi1_devdata *dd, u64 mask, u32 lid);
-
-void system_descriptor_complete(struct hfi1_devdata *dd, struct sdma_desc *descp);
 #endif
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index fad946cb5e0d..85ae7293c274 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -20,6 +20,8 @@ struct sdma_desc {
 	/* private:  don't use directly */
 	u64 qw[2];
 	void *pinning_ctx;
+	/* Release reference to @pinning_ctx. May be called in interrupt context. Must not sleep. */
+	void (*ctx_put)(void *ctx);
 };
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index a932ae1e03af..02bd62b857b7 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -62,18 +62,14 @@ static int defer_packet_queue(
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
@@ -161,9 +157,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	if (!pq->reqs)
 		goto pq_reqs_nomem;
 
-	pq->req_in_use = kcalloc(BITS_TO_LONGS(hfi1_sdma_comp_ring_size),
-				 sizeof(*pq->req_in_use),
-				 GFP_KERNEL);
+	pq->req_in_use = bitmap_zalloc(hfi1_sdma_comp_ring_size, GFP_KERNEL);
 	if (!pq->req_in_use)
 		goto pq_reqs_no_in_use;
 
@@ -210,7 +204,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 cq_nomem:
 	kmem_cache_destroy(pq->txreq_cache);
 pq_txreq_nomem:
-	kfree(pq->req_in_use);
+	bitmap_free(pq->req_in_use);
 pq_reqs_no_in_use:
 	kfree(pq->reqs);
 pq_reqs_nomem:
@@ -249,15 +243,15 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
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
@@ -1277,25 +1271,17 @@ static void free_system_node(struct sdma_mmu_node *node)
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
@@ -1304,11 +1290,12 @@ static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
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
@@ -1357,6 +1344,13 @@ static int pin_system_pages(struct user_sdma_request *req,
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
@@ -1370,6 +1364,12 @@ static int add_system_pinning(struct user_sdma_request *req,
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
@@ -1433,15 +1433,15 @@ static int get_system_cache_entry(struct user_sdma_request *req,
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
@@ -1453,6 +1453,20 @@ static int get_system_cache_entry(struct user_sdma_request *req,
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
@@ -1496,9 +1510,12 @@ static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
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
@@ -1520,8 +1537,6 @@ static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
 					   struct user_sdma_iovec *iovec,
 					   size_t from_this_iovec)
 {
-	struct mmu_rb_handler *handler = req->pq->handler;
-
 	while (from_this_iovec > 0) {
 		struct sdma_mmu_node *cache_entry;
 		size_t from_this_cache_entry;
@@ -1542,15 +1557,15 @@ static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
 
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
@@ -1601,42 +1616,12 @@ static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
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
@@ -1649,10 +1634,6 @@ static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
 		container_of(mnode, struct sdma_mmu_node, rb);
 	struct evict_data *evict_data = evict_arg;
 
-	/* is this node still being used? */
-	if (atomic_read(&node->refcount))
-		return 0; /* keep this node */
-
 	/* this node will be evicted, add its pages to our count */
 	evict_data->cleared += node->npages;
 
@@ -1670,13 +1651,3 @@ static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
 
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
index a241836371dc..548347d4c5bc 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -104,7 +104,6 @@ struct hfi1_user_sdma_comp_q {
 struct sdma_mmu_node {
 	struct mmu_rb_node rb;
 	struct hfi1_user_sdma_pkt_q *pq;
-	atomic_t refcount;
 	struct page **pages;
 	unsigned int npages;
 };
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index 727eedfba332..cc6324d2d1dd 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -64,11 +64,11 @@ static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
 
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
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index fa15d79eabb3..267474070f27 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -597,11 +597,12 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Set HEM base address(128K/page, pa) to Hardware */
-	if (hr_dev->hw->set_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT)) {
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
 
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index aecd64a7dbba..a348f0c010ab 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -94,16 +94,18 @@ static enum irdma_status_code irdma_nop_1(struct irdma_qp_uk *qp)
  */
 void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx)
 {
-	__le64 *wqe;
+	struct irdma_qp_quanta *sq;
 	u32 wqe_idx;
 
 	if (!(qp_wqe_idx & 0x7F)) {
 		wqe_idx = (qp_wqe_idx + 128) % qp->sq_ring.size;
-		wqe = qp->sq_base[wqe_idx].elem;
+		sq = qp->sq_base + wqe_idx;
 		if (wqe_idx)
-			memset(wqe, qp->swqe_polarity ? 0 : 0xFF, 0x1000);
+			memset(sq, qp->swqe_polarity ? 0 : 0xFF,
+			       128 * sizeof(*sq));
 		else
-			memset(wqe, qp->swqe_polarity ? 0xFF : 0, 0x1000);
+			memset(sq, qp->swqe_polarity ? 0xFF : 0,
+			       128 * sizeof(*sq));
 	}
 }
 
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
index 0efe56f49aa9..1923924fdd44 100644
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
index 5f47d8ee4ae3..b9dcc8e78c75 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int ret;
 
 	pr_info("Initializing J-Core AIC\n");
 
@@ -100,6 +101,12 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";
 
+	ret = irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
+			      of_node_to_nid(node));
+
+	if (ret < 0)
+		return ret;
+
 	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
 				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
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
index efb43b038596..fa71ae837d23 100644
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
index 98daa9d200f7..88097d1892ac 100644
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
index af4fa8071cbc..9e7a6c3faa42 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1729,7 +1729,7 @@ static void cache_set_flush(struct closure *cl)
 	if (!IS_ERR_OR_NULL(c->gc_thread))
 		kthread_stop(c->gc_thread);
 
-	if (!IS_ERR_OR_NULL(c->root))
+	if (!IS_ERR(c->root))
 		list_add(&c->root->list, &c->btree_cache);
 
 	/*
@@ -2093,7 +2093,7 @@ static int run_cache_set(struct cache_set *c)
 
 		err = "cannot allocate new btree root";
 		c->root = __bch_btree_node_alloc(c, NULL, 0, true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		mutex_lock(&c->root->write_lock);
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index ee7ad999e924..4dcbaf9a2149 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -880,6 +880,16 @@ static int bch_root_node_dirty_init(struct cache_set *c,
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
 
diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b0c45c6ebe0b..dc4381d68313 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/device-mapper.h>
 #include <linux/init.h>
@@ -18,12 +19,17 @@
 #define DM_MAX_DEVICES 256
 #define DM_MAX_TARGETS 256
 #define DM_MAX_STR_SIZE 4096
+#define DM_MAX_WAITFOR 256
 
 static char *create;
 
+static char *waitfor[DM_MAX_WAITFOR];
+
 /*
  * Format: dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
  * Table format: <start_sector> <num_sectors> <target_type> <target_args>
+ * Block devices to wait for to become available before setting up tables:
+ * dm-mod.waitfor=<device1>[,..,<deviceN>]
  *
  * See Documentation/admin-guide/device-mapper/dm-init.rst for dm-mod.create="..." format
  * details.
@@ -266,7 +272,7 @@ static int __init dm_init_init(void)
 	struct dm_device *dev;
 	LIST_HEAD(devices);
 	char *str;
-	int r;
+	int i, r;
 
 	if (!create)
 		return 0;
@@ -286,6 +292,17 @@ static int __init dm_init_init(void)
 	DMINFO("waiting for all devices to be available before creating mapped devices");
 	wait_for_device_probe();
 
+	for (i = 0; i < ARRAY_SIZE(waitfor); i++) {
+		if (waitfor[i]) {
+			DMINFO("waiting for device %s ...", waitfor[i]);
+			while (!dm_get_dev_t(waitfor[i]))
+				msleep(5);
+		}
+	}
+
+	if (waitfor[0])
+		DMINFO("all devices available");
+
 	list_for_each_entry(dev, &devices, list) {
 		if (dm_early_create(&dev->dmi, dev->table,
 				    dev->target_args_array))
@@ -301,3 +318,6 @@ late_initcall(dm_init_init);
 
 module_param(create, charp, 0);
 MODULE_PARM_DESC(create, "Create a mapped device in early boot");
+
+module_param_array(waitfor, charp, NULL, 0);
+MODULE_PARM_DESC(waitfor, "Devices to wait for before setting up tables");
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index c09693daabd8..455788b6e5a1 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -31,11 +31,11 @@
 #define DEFAULT_BUFFER_SECTORS		128
 #define DEFAULT_JOURNAL_WATERMARK	50
 #define DEFAULT_SYNC_MSEC		10000
-#define DEFAULT_MAX_JOURNAL_SECTORS	131072
+#define DEFAULT_MAX_JOURNAL_SECTORS	(IS_ENABLED(CONFIG_64BIT) ? 131072 : 8192)
 #define MIN_LOG2_INTERLEAVE_SECTORS	3
 #define MAX_LOG2_INTERLEAVE_SECTORS	31
 #define METADATA_WORKQUEUE_MAX_ACTIVE	16
-#define RECALC_SECTORS			32768
+#define RECALC_SECTORS			(IS_ENABLED(CONFIG_64BIT) ? 32768 : 2048)
 #define RECALC_WRITE_SUPER		16
 #define BITMAP_BLOCK_SIZE		4096	/* don't change it */
 #define BITMAP_FLUSH_INTERVAL		(10 * HZ)
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 062142559caa..adada558a1b0 100644
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
index bd0c9dfac981..5a21aeedc1ba 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3872,8 +3872,9 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
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
@@ -3885,7 +3886,7 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0 || msec > UINT_MAX / HZ)
 		return -EINVAL;
 	if (msec == 0)
 		mddev->safemode_delay = 0;
@@ -4555,6 +4556,8 @@ max_corrected_read_errors_store(struct mddev *mddev, const char *buf, size_t len
 	rv = kstrtouint(buf, 10, &n);
 	if (rv < 0)
 		return rv;
+	if (n > INT_MAX)
+		return -EINVAL;
 	atomic_set(&mddev->max_corr_read_errors, n);
 	return len;
 }
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index c16fa65a3ffd..dca912387ec1 100644
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
 
@@ -444,6 +456,20 @@ static int raid0_run(struct mddev *mddev)
 	return ret;
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
@@ -457,7 +483,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	sector_t orig_start, orig_end;
 
+	orig_start = start;
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
@@ -471,6 +499,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	} else
 		end = bio_end_sector(bio);
 
+	orig_end = end;
 	if (zone != conf->strip_zone)
 		end = end - zone[-1].zone_end;
 
@@ -482,13 +511,26 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
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
@@ -496,18 +538,22 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	for (disk = 0; disk < zone->nb_dev; disk++) {
 		sector_t dev_start, dev_end;
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
index 1f5589c5294d..edd3b65c447d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -297,7 +297,7 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
 	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
 		bio->bi_status = BLK_STS_IOERR;
 
-	if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
+	if (r10_bio->start_time)
 		bio_end_io_acct(bio, r10_bio->start_time);
 	bio_endio(bio);
 	/*
@@ -752,8 +752,16 @@ static struct md_rdev *read_balance(struct r10conf *conf,
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
@@ -1449,9 +1457,15 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
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
 		if (rdev && (test_bit(Faulty, &rdev->flags)))
@@ -3412,7 +3426,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			int must_sync;
 			int any_working;
 			int need_recover = 0;
-			int need_replace = 0;
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
 
@@ -3424,11 +3437,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
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
@@ -3444,8 +3456,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				rcu_read_unlock();
 				continue;
 			}
-			if (mreplace && test_bit(Faulty, &mreplace->flags))
-				mreplace = NULL;
 			/* Unless we are doing a full sync, or a replacement
 			 * we only need to recover the block if it is set in
 			 * the bitmap
@@ -3568,11 +3578,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
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
diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index f630b88cbfaa..cf55c57a7970 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -710,8 +710,13 @@ static void mipid02_set_fmt_source(struct v4l2_subdev *sd,
 {
 	struct mipid02_dev *bridge = to_mipid02_dev(sd);
 
-	/* source pad mirror active sink pad */
-	format->format = bridge->fmt;
+	/* source pad mirror sink pad */
+	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		format->format = bridge->fmt;
+	else
+		format->format = *v4l2_subdev_get_try_format(sd, sd_state,
+							     MIPID02_SINK_0);
+
 	/* but code may need to be converted */
 	format->format.code = serial_to_parallel_code(format->format.code);
 
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 8012f5c7bf34..ff705d513aae 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -981,8 +981,8 @@ static u32 get_framesize_raw_yuv420_tp10_ubwc(u32 width, u32 height)
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
index 42bfc46842b8..461f5ffd02bc 100644
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
index f2ea6540a01e..4c43d71cddbd 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -148,6 +148,9 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!info->mem)
+		return -ENODEV;
+
 	info->irq = platform_get_irq(pdev, 0);
 
 	ret = intel_lpss_probe(&pdev->dev, info);
diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 9f3c4a01b4c1..4af1d368c321 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -233,6 +233,7 @@ static const struct of_device_id pm8008_match[] = {
 	{ .compatible = "qcom,pm8008", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, pm8008_match);
 
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index f1236a9acf30..df095e91e266 100644
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
index e095a3930142..9852f49c3f88 100644
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
index 58d09c615e67..743afbe4e99b 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1498,9 +1498,9 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
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
index 0fdf5bbd76ac..24dfc069dbc6 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1108,7 +1108,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
-		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 6, 0);
+		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
 
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				      sc, args);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 4e4c0884d35e..2ad28f1b1461 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -728,6 +728,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq = -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
@@ -937,6 +941,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	if (id < 0)
 		return;
 
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
@@ -946,9 +953,6 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
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
index 090246aa6f03..1ffb9dbdf78e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2449,6 +2449,7 @@ static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
 		.pm	= &mmci_dev_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= mmci_probe,
 	.remove		= mmci_remove,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cda145c2ebb6..d897c981b079 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1144,6 +1144,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 	}
 
+	sdhci_config_dma(host);
+
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 
@@ -1163,8 +1165,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 	}
 
-	sdhci_config_dma(host);
-
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
 
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index c66edabec9f1..bb256a3bb9be 100644
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
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b4d613bdbc06..7b0b4049bd29 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3900,7 +3900,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
 		return skb->hash;
 
 	return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
-				skb_mac_offset(skb), skb_network_offset(skb),
+				0, skb_network_offset(skb),
 				skb_headlen(skb));
 }
 
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index a4b1447ff055..0c0bc78b1788 100644
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
index f0faad149a3b..7979b1019242 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -35,6 +35,8 @@
 
 #define ENA_REGS_ADMIN_INTR_MASK 1
 
+#define ENA_MAX_BACKOFF_DELAY_EXP 16U
+
 #define ENA_MIN_ADMIN_POLL_US 100
 
 #define ENA_MAX_ADMIN_POLL_US 5000
@@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
 
 static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
 {
+	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
 	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
 	delay_us = min_t(u32, delay_us * (1U << exp), ENA_MAX_ADMIN_POLL_US);
 	usleep_range(delay_us, 2 * delay_us);
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index f8fd65ab663e..54ff28c9b214 100644
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
index f61f832ea19c..8c800d9c11b7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -627,5 +627,7 @@ void bcmgenet_mii_exit(struct net_device *dev)
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
+	clk_prepare_enable(priv->clk);
 	platform_device_unregister(priv->mii_pdev);
+	clk_disable_unprepare(priv->clk);
 }
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 50f86bebbc19..70b1a855273e 100644
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
index 6a0663aadd1e..1f8cc722aae3 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -532,6 +532,9 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 		err = gve_adminq_report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
+
+	cmd->base.duplex = DUPLEX_FULL;
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 8a92c6a6e764..765dee2e4882 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1240,7 +1240,14 @@ static int __ibmvnic_open(struct net_device *netdev)
 		if (prev_state == VNIC_CLOSED)
 			enable_irq(adapter->tx_scrq[i]->irq);
 		enable_scrq_irq(adapter, adapter->tx_scrq[i]);
-		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
+		/* netdev_tx_reset_queue will reset dql stats. During NON_FATAL
+		 * resets, don't reset the stats because there could be batched
+		 * skb's waiting to be sent. If we reset dql stats, we risk
+		 * num_completed being greater than num_queued. This will cause
+		 * a BUG_ON in dql_completed().
+		 */
+		if (adapter->reset_reason != VNIC_RESET_NON_FATAL)
+			netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
 	}
 
 	rc = set_link_state(adapter, IBMVNIC_LOGICAL_LNK_UP);
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 66678cd72a6c..192fee9e72b0 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -13,6 +13,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <linux/net_tstamp.h>
+#include <linux/bitfield.h>
 
 #include "igc_hw.h"
 
@@ -227,6 +228,10 @@ struct igc_adapter {
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
@@ -312,6 +317,33 @@ extern char igc_driver_name[];
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
@@ -402,7 +434,6 @@ enum igc_state_t {
 	__IGC_TESTING,
 	__IGC_RESETTING,
 	__IGC_DOWN,
-	__IGC_PTP_TX_IN_PROGRESS,
 };
 
 enum igc_tx_flags {
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index e0a76ac1bbbc..859ddc07fbbf 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1701,6 +1701,8 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	/* twisted pair */
 	cmd->base.port = PORT_TP;
 	cmd->base.phy_address = hw->phy.addr;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
 
 	/* advertising link modes */
 	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index eb7aa8c13f7e..db48979cdecb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -708,7 +708,6 @@ static void igc_configure_tx_ring(struct igc_adapter *adapter,
 	/* disable the queue */
 	wr32(IGC_TXDCTL(reg_idx), 0);
 	wrfl();
-	mdelay(10);
 
 	wr32(IGC_TDLEN(reg_idx),
 	     ring->count * sizeof(union igc_adv_tx_desc));
@@ -1014,7 +1013,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 	ktime_t base_time = adapter->base_time;
 	ktime_t now = ktime_get_clocktai();
 	ktime_t baset_est, end_of_cycle;
-	u32 launchtime;
+	s32 launchtime;
 	s64 n;
 
 	n = div64_s64(ktime_sub_ns(now, base_time), cycle_time);
@@ -1027,7 +1026,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 			*first_flag = true;
 			ring->last_ff_cycle = baset_est;
 
-			if (ktime_compare(txtime, ring->last_tx_cycle) > 0)
+			if (ktime_compare(end_of_cycle, ring->last_tx_cycle) > 0)
 				*insert_empty = true;
 		}
 	}
@@ -1576,9 +1575,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
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
 
@@ -1587,6 +1587,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
+
+		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
 
 	if (skb_vlan_tag_present(skb)) {
@@ -1683,14 +1685,36 @@ static void igc_rx_checksum(struct igc_ring *ring,
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
 
 static void igc_rx_vlan(struct igc_ring *rx_ring,
@@ -6525,6 +6549,7 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_TSO;
 	netdev->features |= NETIF_F_TSO6;
 	netdev->features |= NETIF_F_TSO_ECN;
+	netdev->features |= NETIF_F_RXHASH;
 	netdev->features |= NETIF_F_RXCSUM;
 	netdev->features |= NETIF_F_HW_CSUM;
 	netdev->features |= NETIF_F_SCTP_CRC;
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 743c31659709..556750b61c98 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -357,16 +357,35 @@ static int igc_ptp_feature_enable_i225(struct ptp_clock_info *ptp,
 			tsim &= ~IGC_TSICR_TT0;
 		}
 		if (on) {
+			struct timespec64 safe_start;
 			int i = rq->perout.index;
 
 			igc_pin_perout(igc, i, pin, use_freq);
-			igc->perout[i].start.tv_sec = rq->perout.start.sec;
+			igc_ptp_read(igc, &safe_start);
+
+			/* PPS output start time is triggered by Target time(TT)
+			 * register. Programming any past time value into TT
+			 * register will cause PPS to never start. Need to make
+			 * sure we program the TT register a time ahead in
+			 * future. There isn't a stringent need to fire PPS out
+			 * right away. Adding +2 seconds should take care of
+			 * corner cases. Let's say if the SYSTIML is close to
+			 * wrap up and the timer keeps ticking as we program the
+			 * register, adding +2seconds is safe bet.
+			 */
+			safe_start.tv_sec += 2;
+
+			if (rq->perout.start.sec < safe_start.tv_sec)
+				igc->perout[i].start.tv_sec = safe_start.tv_sec;
+			else
+				igc->perout[i].start.tv_sec = rq->perout.start.sec;
 			igc->perout[i].start.tv_nsec = rq->perout.start.nsec;
 			igc->perout[i].period.tv_sec = ts.tv_sec;
 			igc->perout[i].period.tv_nsec = ts.tv_nsec;
-			wr32(trgttimh, rq->perout.start.sec);
+			wr32(trgttimh, (u32)igc->perout[i].start.tv_sec);
 			/* For now, always select timer 0 as source. */
-			wr32(trgttiml, rq->perout.start.nsec | IGC_TT_IO_TIMER_SEL_SYSTIM0);
+			wr32(trgttiml, (u32)(igc->perout[i].start.tv_nsec |
+					     IGC_TT_IO_TIMER_SEL_SYSTIM0));
 			if (use_freq)
 				wr32(freqout, ns);
 			tsauxc |= tsauxc_mask;
@@ -608,6 +627,7 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	return 0;
 }
 
+/* Requires adapter->ptp_tx_lock held by caller. */
 static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -615,7 +635,6 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
 	adapter->tx_hwtstamp_timeouts++;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
 	rd32(IGC_TXSTMPH);
 	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
@@ -623,20 +642,20 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 
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
@@ -646,6 +665,8 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
  * If we were asked to do hardware stamping and such a time stamp is
  * available, then it must have been for this skb here because we only
  * allow only one such packet into the queue.
+ *
+ * Context: Expects adapter->ptp_tx_lock to be held by caller.
  */
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
@@ -681,13 +702,7 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
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
@@ -698,24 +713,33 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
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
@@ -964,6 +988,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 		return;
 	}
 
+	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->tmreg_lock);
 	INIT_WORK(&adapter->ptp_tx_work, igc_ptp_tx_work);
 
@@ -1028,7 +1053,6 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 	cancel_work_sync(&adapter->ptp_tx_work);
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 
 	if (pci_device_is_present(adapter->pdev)) {
 		igc_ptp_time_save(adapter);
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5c431a369762..f5b5ae58c269 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1474,7 +1474,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -4185,7 +4185,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		 */
 		if (txq_number == 1)
 			txq_map = (cpu == elected_cpu) ?
-				MVNETA_CPU_TXQ_ACCESS(1) : 0;
+				MVNETA_CPU_TXQ_ACCESS(0) : 0;
 		else
 			txq_map = mvreg_read(pp, MVNETA_CPU_MAP(cpu)) &
 				MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index fd0a31bf94fe..8ac95cb7bbb7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -167,6 +167,9 @@ void cgx_lmac_write(int cgx_id, int lmac_id, u64 offset, u64 val)
 {
 	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
 
+	/* Software must not access disabled LMAC registers */
+	if (!is_lmac_valid(cgx_dev, lmac_id))
+		return;
 	cgx_write(cgx_dev, lmac_id, offset, val);
 }
 
@@ -174,6 +177,10 @@ u64 cgx_lmac_read(int cgx_id, int lmac_id, u64 offset)
 {
 	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
 
+	/* Software must not access disabled LMAC registers */
+	if (!is_lmac_valid(cgx_dev, lmac_id))
+		return 0;
+
 	return cgx_read(cgx_dev, lmac_id, offset);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index fed49d6a178d..9d517e6dac2f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -23,6 +23,7 @@
 #define	PCI_DEVID_OCTEONTX2_LBK			0xA061
 
 /* Subsystem Device ID */
+#define PCI_SUBSYS_DEVID_98XX                  0xB100
 #define PCI_SUBSYS_DEVID_96XX                  0xB200
 #define PCI_SUBSYS_DEVID_CN10K_A	       0xB900
 
@@ -614,6 +615,16 @@ static inline u16 rvu_nix_chan_cpt(struct rvu *rvu, u8 chan)
 	return rvu->hw->cpt_chan_base + chan;
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
index 28ff67819566..f4c7bb6bf053 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -111,7 +111,7 @@ static void rvu_map_cgx_nix_block(struct rvu *rvu, int pf,
 	p2x = cgx_lmac_get_p2x(cgx_id, lmac_id);
 	/* Firmware sets P2X_SELECT as either NIX0 or NIX1 */
 	pfvf->nix_blkaddr = BLKADDR_NIX0;
-	if (p2x == CMR_P2X_SEL_NIX1)
+	if (is_rvu_supports_nix1(rvu) && p2x == CMR_P2X_SEL_NIX1)
 		pfvf->nix_blkaddr = BLKADDR_NIX1;
 }
 
@@ -724,7 +724,7 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	cgxd = rvu_cgx_pdata(cgx_id, rvu);
 
 	mac_ops = get_mac_ops(cgxd);
-	mac_ops->mac_enadis_ptp_config(cgxd, lmac_id, true);
+	mac_ops->mac_enadis_ptp_config(cgxd, lmac_id, enable);
 	/* If PTP is enabled then inform NPC that packets to be
 	 * parsed by this PF will have their data shifted by 8 bytes
 	 * and if PTP is disabled then no shift is required
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 63889449b8f6..483f660cebc4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -827,6 +827,14 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 				return -EINVAL;
 
 			vlan_etype = be16_to_cpu(fsp->h_ext.vlan_etype);
+
+			/* Drop rule with vlan_etype == 802.1Q
+			 * and vlan_id == 0 is not supported
+			 */
+			if (vlan_etype == ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
+			    fsp->ring_cookie == RX_CLS_FLOW_DISC)
+				return -EINVAL;
+
 			/* Only ETH_P_8021Q and ETH_P_802AD types supported */
 			if (vlan_etype != ETH_P_8021Q &&
 			    vlan_etype != ETH_P_8021AD)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index a42373e6f259..26231c59b024 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -536,6 +536,21 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 			return -EOPNOTSUPP;
 		}
 
+		if (!match.mask->vlan_id) {
+			struct flow_action_entry *act;
+			int i;
+
+			flow_action_for_each(i, act, &rule->action) {
+				if (act->id == FLOW_ACTION_DROP) {
+					netdev_err(nic->netdev,
+						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
+						   ntohs(match.key->vlan_tpid),
+						   match.key->vlan_id);
+					return -EOPNOTSUPP;
+				}
+			}
+		}
+
 		if (match.mask->vlan_id ||
 		    match.mask->vlan_dei ||
 		    match.mask->vlan_priority) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index ee95cc3a0378..ce941e6091c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -676,8 +676,10 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 
 	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, dev_to_node(mlx5_core_dma_dev(mdev)));
 	cparams = kvzalloc(sizeof(*cparams), GFP_KERNEL);
-	if (!c || !cparams)
-		return -ENOMEM;
+	if (!c || !cparams) {
+		err = -ENOMEM;
+		goto err_free;
+	}
 
 	c->priv     = priv;
 	c->mdev     = priv->mdev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index 4c4ee524176c..153c16e3ff3b 100644
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
index 5cef556223e2..d123d9b4adf5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1282,7 +1282,8 @@ static void remove_unready_flow(struct mlx5e_tc_flow *flow)
 	uplink_priv = &rpriv->uplink_priv;
 
 	mutex_lock(&uplink_priv->unready_flows_lock);
-	unready_flow_del(flow);
+	if (flow_flag_test(flow, NOT_READY))
+		unready_flow_del(flow);
 	mutex_unlock(&uplink_priv->unready_flows_lock);
 }
 
@@ -1525,8 +1526,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 	esw_attr = attr->esw_attr;
 	mlx5e_put_flow_tunnel_id(flow);
 
-	if (flow_flag_test(flow, NOT_READY))
-		remove_unready_flow(flow);
+	remove_unready_flow(flow);
 
 	if (mlx5e_is_offloaded_flow(flow)) {
 		if (flow_flag_test(flow, SLOW))
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index d64ce65a3c17..d66ee9bf5558 100644
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
@@ -671,8 +683,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -683,8 +695,9 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
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
index 6fbd2a51d66c..2cc126d37835 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -451,11 +451,6 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
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
index 302b97c2e617..b20dbda37c7e 100644
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
@@ -1852,9 +1854,14 @@ static size_t efx_ef10_update_stats_pf(struct efx_nic *efx, u64 *full_stats,
 
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
index 179f8d196c89..a43628dd1f4c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7318,12 +7318,6 @@ int stmmac_dvr_remove(struct device *dev)
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
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fbbbcfe0e891..e7f6c29b8dd8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2075,6 +2075,11 @@ static int axienet_probe(struct platform_device *pdev)
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
@@ -2122,11 +2127,6 @@ static int axienet_probe(struct platform_device *pdev)
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
index 30e0a10595a1..a3878aef0ea4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -298,7 +298,9 @@ static void __gtp_encap_destroy(struct sock *sk)
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
index 1f5125698e83..e10cb98b0f4f 100644
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
index 94490dfae656..a7279356299a 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -168,13 +168,10 @@ static ssize_t nsim_dev_trap_fa_cookie_write(struct file *file,
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
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 0fe78826c8fa..32183f24e63f 100644
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
 
@@ -438,12 +452,7 @@ static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
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
index e2791d45f5f5..9e6d088bd281 100644
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
@@ -2238,7 +2239,7 @@ void __ath9k_flush(struct ieee80211_hw *hw, u32 queues, bool drop,
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
index 453bb84cb338..58bba9875d36 100644
--- a/drivers/net/wireless/atmel/atmel_cs.c
+++ b/drivers/net/wireless/atmel/atmel_cs.c
@@ -72,6 +72,7 @@ struct local_info {
 static int atmel_probe(struct pcmcia_device *p_dev)
 {
 	struct local_info *local;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "atmel_attach()\n");
 
@@ -82,8 +83,16 @@ static int atmel_probe(struct pcmcia_device *p_dev)
 
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
index fc19ecbc4c08..bcbf197fa937 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6147,8 +6147,11 @@ static int airo_get_rate(struct net_device *dev,
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
index 3ee4b3ecd0c8..01f65c9789e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1309,8 +1309,11 @@ static void iwl_mvm_queue_state_change(struct iwl_op_mode *op_mode,
 		else
 			set_bit(IWL_MVM_TXQ_STATE_STOP_FULL, &mvmtxq->state);
 
-		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST)
+		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST) {
+			local_bh_disable();
 			iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
+			local_bh_enable();
+		}
 	}
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 49c28c96fdf2..411254e9e603 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -302,7 +302,8 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 				struct ieee80211_hdr *hdr,
 				struct iwl_rx_mpdu_desc *desc,
-				u32 status)
+				u32 status,
+				struct ieee80211_rx_status *stats)
 {
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_vif *mvmvif;
@@ -331,8 +332,10 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 
 	/* good cases */
 	if (likely(status & IWL_RX_MPDU_STATUS_MIC_OK &&
-		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)))
+		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR))) {
+		stats->flag |= RX_FLAG_DECRYPTED;
 		return 0;
+	}
 
 	if (!sta)
 		return -1;
@@ -401,7 +404,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	if (unlikely(ieee80211_is_mgmt(hdr->frame_control) &&
 		     !ieee80211_has_protected(hdr->frame_control)))
-		return iwl_mvm_rx_mgmt_prot(sta, hdr, desc, status);
+		return iwl_mvm_rx_mgmt_prot(sta, hdr, desc, status, stats);
 
 	if (!ieee80211_has_protected(hdr->frame_control) ||
 	    (status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index fea89330f692..6c6512158813 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1601,18 +1601,22 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	struct msix_entry *entry = dev_id;
 	struct iwl_trans_pcie *trans_pcie = iwl_pcie_get_trans_pcie(entry);
 	struct iwl_trans *trans = trans_pcie->trans;
-	struct iwl_rxq *rxq = &trans_pcie->rxq[entry->entry];
+	struct iwl_rxq *rxq;
 
 	trace_iwlwifi_dev_irq_msix(trans->dev, entry, false, 0, 0);
 
 	if (WARN_ON(entry->entry >= trans->num_rx_queues))
 		return IRQ_NONE;
 
-	if (WARN_ONCE(!rxq,
-		      "[%d] Got MSI-X interrupt before we have Rx queues",
-		      entry->entry))
+	if (!trans_pcie->rxq) {
+		if (net_ratelimit())
+			IWL_ERR(trans,
+				"[%d] Got MSI-X interrupt before we have Rx queues\n",
+				entry->entry);
 		return IRQ_NONE;
+	}
 
+	rxq = &trans_pcie->rxq[entry->entry];
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
 
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
index 0b877f3f6b97..5ec8a42e7150 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2199,9 +2199,9 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 
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
index 3e5cc947b9b9..a7bca0475e1e 100644
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
index f8409e93fe33..96330a6c066b 100644
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
@@ -1643,38 +1649,34 @@ static void authenticate_timeout(struct timer_list *t)
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
index 9f16128e4ffa..670de56c69a2 100644
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
index cb71b73853f4..4c408fd7c159 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1862,6 +1862,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 {
 	struct net_device *dev;
 	struct wl3501_card *this;
+	int ret;
 
 	/* The io structure describes IO port mapping */
 	p_dev->resource[0]->end	= 16;
@@ -1873,8 +1874,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 
 	dev = alloc_etherdev(sizeof(struct wl3501_card));
 	if (!dev)
-		goto out_link;
-
+		return -ENOMEM;
 
 	dev->netdev_ops		= &wl3501_netdev_ops;
 	dev->watchdog_timeo	= 5 * HZ;
@@ -1887,9 +1887,15 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
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
@@ -1945,8 +1951,7 @@ static int wl3501_config(struct pcmcia_device *link)
 		goto failed;
 	}
 
-	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = ((char *)&this->mac_addr)[i];
+	eth_hw_addr_set(dev, this->mac_addr);
 
 	/* print probe information */
 	printk(KERN_INFO "%s: wl3501 @ 0x%3.3x, IRQ %d, "
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 87847c380051..1c03a78c125b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1336,12 +1336,17 @@ static struct pci_driver amd_ntb_pci_driver = {
 
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
index 733557231ed0..72060acb9caf 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2891,6 +2891,7 @@ static struct pci_driver idt_pci_driver = {
 
 static int __init idt_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	/* Create the top DebugFS directory if the FS is initialized */
@@ -2898,7 +2899,11 @@ static int __init idt_pci_driver_init(void)
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
index e5f14e20a9ff..41897167abc7 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -2060,12 +2060,17 @@ static struct pci_driver intel_ntb_pci_driver = {
 
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
index a9b97ebc71ac..2abd2235bbca 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -410,7 +410,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
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
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a646757f76b3..bb3813e8474f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -224,7 +224,6 @@ struct nvme_queue {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
-	struct nvme_queue *nvmeq;
 	bool use_sgl;
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
@@ -422,11 +421,6 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 {
 	struct nvme_dev *dev = set->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	int queue_idx = (set == &dev->tagset) ? hctx_idx + 1 : 0;
-	struct nvme_queue *nvmeq = &dev->queues[queue_idx];
-
-	BUG_ON(!nvmeq);
-	iod->nvmeq = nvmeq;
 
 	nvme_req(req)->ctrl = &dev->ctrl;
 	nvme_req(req)->cmd = &iod->cmd;
@@ -529,7 +523,7 @@ static void **nvme_pci_iod_list(struct request *req)
 
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	int nseg = blk_rq_nr_phys_segments(req);
 	unsigned int avg_seg_size;
 
@@ -537,7 +531,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 
 	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
-	if (!iod->nvmeq->qid)
+	if (!nvmeq->qid)
 		return false;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return false;
@@ -846,6 +840,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	int nr_mapped;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -853,7 +848,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-			if (iod->nvmeq->qid && sgl_threshold &&
+			if (nvmeq->qid && sgl_threshold &&
 			    nvme_ctrl_sgl_supported(&dev->ctrl))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
@@ -963,12 +958,16 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void nvme_pci_complete_rq(struct request *req)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_dev *dev = iod->nvmeq->dev;
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
+
+	if (blk_integrity_rq(req)) {
+	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	if (blk_integrity_rq(req))
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
+			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+	}
+
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
 	nvme_complete_rq(req);
@@ -1194,8 +1193,7 @@ static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 
 static void abort_endio(struct request *req, blk_status_t error)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = iod->nvmeq;
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
 	dev_warn(nvmeq->dev->ctrl.device,
 		 "Abort status: 0x%x", nvme_req(req)->status);
@@ -1249,7 +1247,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = iod->nvmeq;
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd = { };
diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 80cb187f1481..752d0bf4445e 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -71,6 +71,7 @@ static int rmem_probe(struct platform_device *pdev)
 	config.dev = dev;
 	config.priv = priv;
 	config.name = "rmem";
+	config.id = NVMEM_DEVID_AUTO;
 	config.size = mem->size;
 	config.reg_read = rmem_read;
 
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b2da497dd378..4960d5f8c8bc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1249,7 +1249,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	return opp_table;
 
 remove_opp_dev:
+	_of_clear_opp_table(opp_table);
 	_remove_opp_dev(opp_dev, opp_table);
+	mutex_destroy(&opp_table->genpd_virt_dev_lock);
+	mutex_destroy(&opp_table->lock);
 err:
 	kfree(opp_table);
 	return ERR_PTR(ret);
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
index 5960cbbea818..9402fe8dddab 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1134,6 +1134,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 		PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 88980a44461d..ca8de44045bb 100644
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
index d1a200b93b2b..827d91e73efa 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -125,6 +125,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 					 struct pci_epf_header *hdr)
 {
+	u32 reg;
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
@@ -137,8 +138,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
-	rockchip_pcie_write(rockchip, hdr->deviceid << 16,
-			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) + PCI_VENDOR_ID);
+	reg = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_DID_VID);
+	reg = (reg & 0xFFFF) | (hdr->deviceid << 16);
+	rockchip_pcie_write(rockchip, reg, PCIE_EP_CONFIG_DID_VID);
 
 	rockchip_pcie_write(rockchip,
 			    hdr->revid |
@@ -312,15 +314,15 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
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
@@ -332,7 +334,7 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags;
+	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
@@ -345,48 +347,25 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
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
index 1650a5087450..cbd2fd25ba76 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -38,6 +38,13 @@
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
@@ -133,6 +140,8 @@
 #define PCIE_RC_RP_ATS_BASE		0x400000
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define   PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
@@ -217,6 +226,7 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET		20
@@ -224,7 +234,6 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
-#define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8dce71142e10..f49001ba96c7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -881,6 +881,13 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_remove_irq_domain(vmd);
 }
 
+static void vmd_shutdown(struct pci_dev *dev)
+{
+        struct vmd_dev *vmd = pci_get_drvdata(dev);
+
+        vmd_remove_irq_domain(vmd);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int vmd_suspend(struct device *dev)
 {
@@ -946,6 +953,7 @@ static struct pci_driver vmd_drv = {
 	.id_table	= vmd_ids,
 	.probe		= vmd_probe,
 	.remove		= vmd_remove,
+	.shutdown	= vmd_shutdown,
 	.driver		= {
 		.pm	= &vmd_dev_pm_ops,
 	},
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
index 4aa2e655398c..244c1c2e0876 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2886,13 +2886,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
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
index b3ad316418f1..c58294f53fcd 100644
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
index 643a3b292f0b..ec17d42c2a15 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4149,6 +4149,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 400eb7f579dc..40945343c4cc 100644
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
index 71271af39ad6..119e2c039225 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -562,6 +562,7 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 		usb_role_switch_unregister(port->usb_role_sw);
 		cancel_work_sync(&port->usb_phy_work);
 		usb_remove_phy(&port->usb_phy);
+		port->usb_phy.dev->driver = NULL;
 	}
 
 	if (port->ops->remove)
@@ -668,6 +669,9 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	port->dev.driver = devm_kzalloc(&port->dev,
 					sizeof(struct device_driver),
 					GFP_KERNEL);
+	if (!port->dev.driver)
+		return -ENOMEM;
+
 	port->dev.driver->owner	 = THIS_MODULE;
 
 	port->usb_role_sw = usb_role_switch_register(&port->dev,
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 2c10086fd155..7904ae5406da 100644
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
index 980099028cf8..34f0ec784dbe 100644
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
index 52d1fe5ec3e7..9dff866614d4 100644
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
@@ -223,6 +231,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char debounce_value[40];
 	char *debounce_enable;
 
+	seq_printf(s, "WAKE_INT_MASTER_REG: 0x%08x\n", readl(gpio_dev->base + WAKE_INT_MASTER_REG));
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
 		seq_printf(s, "GPIO bank%d\t", bank);
 
@@ -646,21 +655,21 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 			 * We must read the pin register again, in case the
 			 * value was changed while executing
 			 * generic_handle_domain_irq() above.
-			 * If we didn't find a mapping for the interrupt,
-			 * disable it in order to avoid a system hang caused
-			 * by an interrupt storm.
+			 * If the line is not an irq, disable it in order to
+			 * avoid a system hang caused by an interrupt storm.
 			 */
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 			regval = readl(regs + i);
-			if (irq == 0) {
-				regval &= ~BIT(INTERRUPT_ENABLE_OFF);
+			if (!gpiochip_line_is_irq(gc, irqnr + i)) {
+				regval &= ~BIT(INTERRUPT_MASK_OFF);
 				dev_dbg(&gpio_dev->pdev->dev,
 					"Disabling spurious GPIO IRQ %d\n",
 					irqnr + i);
+			} else {
+				ret = true;
 			}
 			writel(regval, regs + i);
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-			ret = true;
 		}
 	}
 	/* did not cause wake on resume context for shared IRQ */
@@ -883,9 +892,9 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
-		pin_reg = readl(gpio_dev->base + i * 4);
+		pin_reg = readl(gpio_dev->base + pin * 4);
 		pin_reg &= ~mask;
-		writel(pin_reg, gpio_dev->base + i * 4);
+		writel(pin_reg, gpio_dev->base + pin * 4);
 
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 1d4317073654..04ae23c46152 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -17,6 +17,7 @@
 #define AMD_GPIO_PINS_BANK3     32
 
 #define WAKE_INT_MASTER_REG 0xfc
+#define INTERNAL_GPIO0_DEBOUNCE (1 << 15)
 #define EOI_MASK (1 << 29)
 
 #define WAKE_INT_STATUS_REG0 0x2f8
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index e31f5d9febe9..62b9a94c10ba 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1128,6 +1128,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		/* Pin naming convention: P(bank_name)(bank_pin_number). */
 		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%d",
 						  bank + 'A', line);
+		if (!pin_desc[i].name)
+			return -ENOMEM;
 
 		group->name = group_names[i] = pin_desc[i].name;
 		group->pin = pin_desc[i].number;
diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index dfa374195694..aceadc9ec024 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -729,6 +729,9 @@ static int microchip_sgpio_register_bank(struct device *dev,
 	pctl_desc->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%sput",
 					 dev_name(dev),
 					 bank->is_input ? "in" : "out");
+	if (!pctl_desc->name)
+		return -ENOMEM;
+
 	pctl_desc->pctlops = &sgpio_pctl_ops;
 	pctl_desc->pmxops = &sgpio_pmx_ops;
 	pctl_desc->confops = &sgpio_confops;
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c4f917d45b51..7ce0408d3bfd 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -39,7 +39,7 @@ MODULE_LICENSE("GPL");
 static LIST_HEAD(wmi_block_list);
 
 struct guid_block {
-	char guid[16];
+	guid_t guid;
 	union {
 		char object_id[2];
 		struct {
@@ -124,7 +124,7 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	list_for_each_entry(wblock, &wmi_block_list, list) {
 		block = &wblock->gblock;
 
-		if (memcmp(block->guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->guid, &guid_input)) {
 			if (out)
 				*out = wblock;
 			return true;
@@ -133,11 +133,20 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
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
@@ -146,9 +155,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 
 	id = wdriver->id_table;
 	while (*id->guid_string) {
-		if (guid_parse(id->guid_string, &guid_input))
-			continue;
-		if (!memcmp(wblock->gblock.guid, &guid_input, 16))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return id->context;
 		id++;
 	}
@@ -460,7 +467,7 @@ EXPORT_SYMBOL_GPL(wmi_set_block);
 
 static void wmi_dump_wdg(const struct guid_block *g)
 {
-	pr_info("%pUL:\n", g->guid);
+	pr_info("%pUL:\n", &g->guid);
 	if (g->flags & ACPI_WMI_EVENT)
 		pr_info("\tnotify_id: 0x%02X\n", g->notify_id);
 	else
@@ -542,7 +549,7 @@ wmi_notify_handler handler, void *data)
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->gblock.guid, &guid_input)) {
 			if (block->handler &&
 			    block->handler != wmi_notify_debug)
 				return AE_ALREADY_ACQUIRED;
@@ -582,7 +589,7 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->gblock.guid, &guid_input)) {
 			if (!block->handler ||
 			    block->handler == wmi_notify_debug)
 				return AE_NULL_ENTRY;
@@ -618,7 +625,6 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 {
 	struct acpi_object_list input;
 	union acpi_object params[1];
-	struct guid_block *gblock;
 	struct wmi_block *wblock;
 
 	input.count = 1;
@@ -627,7 +633,7 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 	params[0].integer.value = event;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		gblock = &wblock->gblock;
+		struct guid_block *gblock = &wblock->gblock;
 
 		if ((gblock->flags & ACPI_WMI_EVENT) &&
 			(gblock->notify_id == event))
@@ -693,7 +699,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "wmi:%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "wmi:%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -702,7 +708,7 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(guid);
 
@@ -785,10 +791,10 @@ static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, "WMI_GUID=%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "WMI_GUID=%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
 	return 0;
@@ -811,11 +817,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
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
@@ -1046,7 +1048,6 @@ static const struct device_type wmi_type_data = {
 };
 
 static int wmi_create_device(struct device *wmi_bus_dev,
-			     const struct guid_block *gblock,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
 {
@@ -1054,12 +1055,12 @@ static int wmi_create_device(struct device *wmi_bus_dev,
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
@@ -1109,7 +1110,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	wblock->dev.dev.bus = &wmi_bus_type;
 	wblock->dev.dev.parent = wmi_bus_dev;
 
-	dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
+	dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
 
 	device_initialize(&wblock->dev.dev);
 
@@ -1129,12 +1130,12 @@ static void wmi_free_devices(struct acpi_device *device)
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
@@ -1189,7 +1190,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		 * case yet, so for now, we'll just ignore the duplicate
 		 * for device creation.
 		 */
-		if (guid_already_parsed(device, gblock[i].guid))
+		if (guid_already_parsed(device, &gblock[i].guid))
 			continue;
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
@@ -1201,7 +1202,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		retval = wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
+		retval = wmi_create_device(wmi_bus_dev, wblock, device);
 		if (retval) {
 			kfree(wblock);
 			continue;
@@ -1226,7 +1227,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		retval = device_add(&wblock->dev.dev);
 		if (retval) {
 			dev_err(wmi_bus_dev, "failed to register %pUL\n",
-				wblock->gblock.guid);
+				&wblock->gblock.guid);
 			if (debug_event)
 				wmi_method_enable(wblock, 0);
 			list_del(&wblock->list);
@@ -1283,12 +1284,11 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
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
@@ -1334,7 +1334,7 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 	}
 
 	if (debug_event)
-		pr_info("DEBUG Event GUID: %pUL\n", wblock->gblock.guid);
+		pr_info("DEBUG Event GUID: %pUL\n", &wblock->gblock.guid);
 
 	acpi_bus_generate_netlink_event(
 		wblock->acpi_device->pnp.device_class,
diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 8242e8c5ed77..503797b2a1c6 100644
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
index 1be45f36ab6c..c19e69e77093 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -22,7 +22,6 @@
 #include <linux/processor.h>
 #include <linux/platform_device.h>
 
-#include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index ad37bc46f272..5fa91f4cda7a 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -96,7 +96,7 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	int err;
 
 	if (pdev->id < 1 || pdev->id > 31)
-		return dev_err_probe(&pdev->dev, EINVAL, "Invalid device id %d\n", pdev->id);
+		return dev_err_probe(&pdev->dev, -EINVAL, "Invalid device id %d\n", pdev->id);
 
 	/*
 	 * Nothing to be done in probe, this is required to get the
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index e5e7b7c339a8..7a53bf51964f 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -397,6 +397,13 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
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
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 92ba02cfec92..a581d8adab59 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -79,14 +79,11 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
-	if (!state->enabled) {
-		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
-					 0x0);
-
-		if (mdp->enabled) {
-			clk_disable_unprepare(mdp->clk_mm);
-			clk_disable_unprepare(mdp->clk_main);
-		}
+	if (!state->enabled && mdp->enabled) {
+		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
+					 mdp->data->enable_mask, 0x0);
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
 
 		mdp->enabled = false;
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
index 211ab227b000..ebde10e74434 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1874,19 +1874,17 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
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
@@ -5193,10 +5191,8 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
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
@@ -6104,7 +6100,7 @@ static int __init regulator_init(void)
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
 	if (IS_ERR(debugfs_root))
-		pr_warn("regulator: Failed to create debugfs directory\n");
+		pr_debug("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 0f8e4231098e..d04d46f9cc65 100644
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
index 1082380b21f8..dba9b307020c 100644
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
index 4ee485ab2714..678c8ca4f699 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2305,8 +2305,10 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
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
index fa49a3e52a9b..cf10c1a60399 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3046,9 +3046,8 @@ static int qedf_alloc_global_queues(struct qedf_ctx *qedf)
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
index b6a427f0570e..de57d45ffc5c 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2738,6 +2738,7 @@ static void
 qla2x00_terminate_rport_io(struct fc_rport *rport)
 {
 	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+	scsi_qla_host_t *vha;
 
 	if (!fcport)
 		return;
@@ -2747,9 +2748,12 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 
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
@@ -2774,6 +2778,15 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 			qla2x00_port_logout(fcport->vha, fcport);
 		}
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
index c7c5c013a074..5db43b6b76c5 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -283,6 +283,10 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport) {
+			rval = -ENOMEM;
+			goto done;
+		}
 		fcport = *(fc_port_t **) rport->dd_data;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
@@ -2899,6 +2903,8 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport)
+			return ret;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
 	} else {
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 5b499b0e2c86..e674d3fb5926 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -676,7 +676,6 @@ typedef struct srb {
 	struct iocb_resource iores;
 	struct kref cmd_kref;	/* need to migrate ref_count over to this */
 	void *priv;
-	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
 	unsigned int start_timer:1;
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index f81cf85dcdc7..40a03f9c2d21 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -2230,8 +2230,8 @@ qla24xx_issue_sa_replace_iocb(scsi_qla_host_t *vha, struct qla_work_evt *e)
 	if (!sa_ctl) {
 		ql_dbg(ql_dbg_edif, vha, 0x70e6,
 		    "sa_ctl allocation failed\n");
-		rval =  -ENOMEM;
-		goto done;
+		rval = -ENOMEM;
+		return rval;
 	}
 
 	fcport = sa_ctl->fcport;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index ded027fe2924..37cb469dc925 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5359,7 +5359,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index b0ee307b5d4b..a034699e58ae 100644
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
index 4f48f098ea5a..7a4298388ef1 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -603,7 +603,8 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
 	put_unaligned_le32(COMMAND_TYPE_6, &cmd_pkt->entry_type);
 
 	/* No data transfer */
-	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE) {
+	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE ||
+	    tot_dsds == 0) {
 		cmd_pkt->byte_count = cpu_to_le32(0);
 		return 0;
 	}
@@ -3898,7 +3899,7 @@ qla2x00_start_sp(srb_t *sp)
 
 	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
 	if (!pkt) {
-		rval = EAGAIN;
+		rval = -EAGAIN;
 		ql_log(ql_log_warn, vha, 0x700c,
 		    "qla2x00_alloc_iocbs failed.\n");
 		goto done;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 98edab687c13..53a54e8a4d97 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -355,7 +355,6 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x700e,
 		    "qla2x00_start_sp failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2x00_rel_sp(sp);
@@ -637,7 +636,6 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (!sp)
 		return -EBUSY;
 
-	init_waitqueue_head(&sp->nvme_ls_waitq);
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
 	sp->priv = priv;
@@ -656,7 +654,6 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2xxx_rel_qpair_sp(sp->qpair, sp);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2efe31327ed1..30325fd4c120 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5042,7 +5042,8 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, vha->host_no);
+	snprintf(vha->host_str, sizeof(vha->host_str), "%s_%lu",
+		 QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,
diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index 2eeea5e1b3b7..2f3ca5531fa9 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -104,7 +104,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
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
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 2ba0911f5d0c..2045bcdfce1a 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -146,7 +146,8 @@ struct qcom_swrm_ctrl {
 	u32 intr_mask;
 	u8 rcmd_id;
 	u8 wcmd_id;
-	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
+	/* Port numbers are 1 - 14 */
+	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS + 1];
 	struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index bd7c7fc73961..c79797c06cda 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1370,13 +1370,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
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
diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 59e22c6b4b20..8fc598f09a72 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -416,7 +416,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->n_bytes =
+		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
+						BITS_PER_BYTE));
+
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 2f51421e2a71..4b92f119955c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -32,7 +32,7 @@
 #define CS_DEMUX_OUTPUT_SEL	GENMASK(3, 0)
 
 #define SE_SPI_TRANS_CFG	0x25c
-#define CS_TOGGLE		BIT(0)
+#define CS_TOGGLE		BIT(1)
 
 #define SE_SPI_WORD_LEN		0x268
 #define WORD_LEN_MSK		GENMASK(9, 0)
diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
index 39367712ef54..8c1934df70de 100644
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
@@ -347,7 +347,7 @@ static struct clk *clk_wzrd_register_divider(struct device *dev,
 	hw = &div->hw;
 	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
-		hw = ERR_PTR(ret);
+		return ERR_PTR(ret);
 
 	return hw->clk;
 }
diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index cd0a771454da..2a8ef766b25a 100644
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
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d9cd23cbb671..cd464db06414 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -319,6 +319,11 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
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
@@ -339,47 +344,35 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
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
@@ -530,17 +523,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
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
@@ -642,7 +624,6 @@ MODULE_DEVICE_TABLE(of, of_ths_match);
 
 static struct platform_driver ths_driver = {
 	.probe = sun8i_ths_probe,
-	.remove = sun8i_ths_remove,
 	.driver = {
 		.name = "sun8i-thermal",
 		.of_match_table = of_ths_match,
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index bb1a98c97adf..d9500a25e03a 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -90,7 +90,6 @@ struct serial8250_config {
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	BIT(2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	BIT(3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	BIT(4)	/* UART mishandles parity if FIFO enabled */
 #define UART_BUG_TXRACE	BIT(5)	/* UART Tx fails to set remote DR */
 
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 078a7028ee5a..a6b374c026a8 100644
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
index 980ce0b5e5e6..5f0daa0d1dd0 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1252,14 +1252,6 @@ static int pci_oxsemi_tornado_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, up, idx);
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
@@ -2082,7 +2074,6 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2892,16 +2883,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
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
index bfdd9ecc2baf..ad5b742a68cd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2620,11 +2620,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 
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
@@ -2787,8 +2784,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3124,8 +3120,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	struct uart_8250_port *up = up_to_u8250p(uport);
 	int rxtrig;
 
-	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1 ||
-	    up->fifo_bug)
+	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1)
 		return -EINVAL;
 
 	rxtrig = bytes_to_fcr_rxtrig(up, bytes);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 714e6ff4a8fb..98a3f36b40b9 100644
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
index b1676cac9b63..b0b27808c7c3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2632,6 +2632,7 @@ OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8ulp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 77a4f4af3b8d..3b2beb98eb1e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -397,6 +397,16 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
        hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
+static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
+{
+	unsigned int uts;
+
+	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
+	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+	uts &= ~UTS_LOOP;
+	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -418,6 +428,7 @@ static void imx_uart_start_rx(struct uart_port *port)
 	/* Write UCR2 first as it includes RXEN */
 	imx_uart_writel(sport, ucr2, UCR2);
 	imx_uart_writel(sport, ucr1, UCR1);
+	imx_uart_disable_loopback_rs485(sport);
 }
 
 /* called with port.lock taken and irqs off */
@@ -1394,7 +1405,7 @@ static int imx_uart_startup(struct uart_port *port)
 	int retval, i;
 	unsigned long flags;
 	int dma_is_inited = 0;
-	u32 ucr1, ucr2, ucr3, ucr4, uts;
+	u32 ucr1, ucr2, ucr3, ucr4;
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
@@ -1499,10 +1510,7 @@ static int imx_uart_startup(struct uart_port *port)
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
-	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
-	uts &= ~UTS_LOOP;
-	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+	imx_uart_disable_loopback_rs485(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index f460b47ff6f2..09b2b40b63c4 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1478,8 +1478,12 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
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
@@ -1505,10 +1509,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
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
index 5e34986fac96..5cd0a724b425 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -735,6 +735,7 @@ static int driver_resume(struct usb_interface *intf)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /* The following routines apply to the entire device, not interfaces */
 void usbfs_notify_suspend(struct usb_device *udev)
 {
@@ -753,6 +754,7 @@ void usbfs_notify_resume(struct usb_device *udev)
 	}
 	mutex_unlock(&usbfs_mutex);
 }
+#endif
 
 struct usb_driver usbfs_driver = {
 	.name =		"usbfs",
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 7a09476e9f19..6496bfbd34ed 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -205,6 +205,11 @@ int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	return ret;
 }
 
+static void dwc2_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 {
 	int i, ret;
@@ -217,6 +222,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	}
 
 	reset_control_deassert(hsotg->reset);
+	ret = devm_add_action_or_reset(hsotg->dev, dwc2_reset_control_assert,
+				       hsotg->reset);
+	if (ret)
+		return ret;
 
 	hsotg->reset_ecc = devm_reset_control_get_optional(hsotg->dev, "dwc2-ecc");
 	if (IS_ERR(hsotg->reset_ecc)) {
@@ -226,6 +235,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	}
 
 	reset_control_deassert(hsotg->reset_ecc);
+	ret = devm_add_action_or_reset(hsotg->dev, dwc2_reset_control_assert,
+				       hsotg->reset_ecc);
+	if (ret)
+		return ret;
 
 	/*
 	 * Attempt to find a generic PHY, then look for an old style
@@ -352,10 +365,7 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 
-	reset_control_assert(hsotg->reset);
-	reset_control_assert(hsotg->reset_ecc);
-
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index bd814df3bf8b..8f94bc4a82cf 100644
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
index 28bc7480acf3..73c0c381e5d0 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -727,6 +727,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	struct dwc3_qcom	*qcom;
 	struct resource		*res, *parent_res = NULL;
+	struct resource		local_res;
 	int			ret, i;
 	bool			ignore_pipe_clk;
 
@@ -777,9 +778,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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
@@ -791,9 +791,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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
@@ -873,11 +874,15 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 static int dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int i;
 
 	device_remove_software_node(&qcom->dwc3->dev);
-	of_platform_depopulate(dev);
+	if (np)
+		of_platform_depopulate(&pdev->dev);
+	else
+		platform_device_put(pdev);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e4c503967cdf..845c6041b385 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2530,7 +2530,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
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
index 116d2e15e9b2..a8d1e8b192c5 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1419,10 +1419,19 @@ EXPORT_SYMBOL_GPL(gserial_disconnect);
 
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
index 9d9ab7e3560a..6444aef33cf0 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2128,7 +2128,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
@@ -2148,6 +2148,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
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
@@ -2157,10 +2166,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
 	}
-	rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
-
-	if (rhub->min_rev < minor_revision)
-		rhub->min_rev = minor_revision;
 
 	/* Port offset and count in the third dword, see section 7.2 */
 	temp = readl(addr + 2);
@@ -2179,8 +2184,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	if (xhci->num_port_caps > max_caps)
 		return;
 
-	port_cap->maj_rev = major_revision;
-	port_cap->min_rev = minor_revision;
 	port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
 
 	if (port_cap->psi_count) {
@@ -2201,6 +2204,11 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
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
@@ -2210,6 +2218,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
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
@@ -2454,8 +2471,12 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
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
index 131a6dc2ecff..6c23b5156448 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -336,6 +336,18 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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
index 0b22e8580863..64278cd77f98 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1906,6 +1906,8 @@ struct xhci_hcd {
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
index e12fec4c2e2f..6692440c1e0a 100644
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
index 9cbeeb4923ec..67d1cfbbb5f7 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1093,29 +1093,26 @@ static int convert_t(struct w1_slave *sl, struct therm_info *info)
 
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
index 4a2ddf730a3a..2eee26b7fc4a 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1263,10 +1263,10 @@ static int __init w1_init(void)
 
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
index a76796f153d5..d426a2a5823e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -78,14 +78,21 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
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
 
@@ -1534,8 +1541,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 		spin_unlock(&bg->lock);
 
-		/* Get out fast, in case we're unmounting the filesystem */
-		if (btrfs_fs_closing(fs_info)) {
+		/*
+		 * Get out fast, in case we're read-only or unmounting the
+		 * filesystem. It is OK to drop block groups from the list even
+		 * for the read-only case. As we did sb_start_write(),
+		 * "mount -o remount,ro" won't happen and read-only filesystem
+		 * means it is forced read-only due to a fatal error. So, it
+		 * never gets back to read-write to let us reclaim again.
+		 */
+		if (btrfs_need_cleaner_sleep(fs_info)) {
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
@@ -1566,11 +1580,27 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 
 next:
+		if (ret)
+			btrfs_mark_bg_to_reclaim(bg);
 		btrfs_put_block_group(bg);
+
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
+		/*
+		 * Reclaiming all the block groups in the list can take really
+		 * long.  Prioritize cleaning up unused block groups.
+		 */
+		btrfs_delete_unused_bgs(fs_info);
+		/*
+		 * If we are interrupted by a balance, we can just bail out. The
+		 * cleaner thread restart again if necessary.
+		 */
+		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
+			goto end;
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
+end:
 	btrfs_exclop_finish(fs_info);
 	sb_end_write(fs_info->sb);
 }
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1a19354382b2..a648dff2bece 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -457,9 +457,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
 			parent_start = buf->start;
 
-		atomic_inc(&cow->refs);
 		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		atomic_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
 		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
@@ -912,7 +917,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_tree_unlock(child);
+			free_extent_buffer(child);
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		rcu_assign_pointer(root->node, child);
 
 		add_root_to_dirty_list(root);
@@ -994,7 +1004,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_node_key(right, &right_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
 					BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto enospc;
+			}
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
 		}
@@ -1040,7 +1053,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_node_key(mid, &mid_key, 0);
 		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
 				BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
 	}
@@ -2626,6 +2642,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 26110d9587cd..42dd6316c62f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1269,7 +1269,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	spin_lock(&fs_info->trans_lock);
 	list_del(&quota_root->dirty_list);
+	spin_unlock(&fs_info->trans_lock);
 
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clean_tree_block(quota_root->node);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6ff3aaebaf93..ca92f2d2f3c7 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3517,6 +3517,15 @@ static void handle_cap_grant(struct inode *inode,
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
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index bda1ffe6e41f..4e4f73a90574 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4923,20 +4923,19 @@ void cifs_oplock_break(struct work_struct *work)
 
 	_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 	/*
-	 * releasing stale oplock after recent reconnect of smb session using
-	 * a now incorrect file handle is not a data integrity issue but do
-	 * not bother sending an oplock release if session to server still is
-	 * disconnected since oplock already released by the server
+	 * MS-SMB2 3.2.5.19.1 and 3.2.5.19.2 (and MS-CIFS 3.2.5.42) do not require
+	 * an acknowledgment to be sent when the file has already been closed.
+	 * check for server null, since can race with kill_sb calling tree disconnect.
 	 */
-	if (!oplock_break_cancelled) {
-		/* check for server null since can race with kill_sb calling tree disconnect */
-		if (tcon->ses && tcon->ses->server) {
-			rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
-				volatile_fid, net_fid, cinode);
-			cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
-		} else
-			pr_warn_once("lease break not sent for unmounted share\n");
-	}
+	spin_lock(&cinode->open_file_lock);
+	if (tcon->ses && tcon->ses->server && !oplock_break_cancelled &&
+					!list_empty(&cinode->openFileList)) {
+		spin_unlock(&cinode->open_file_lock);
+		rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
+						volatile_fid, net_fid, cinode);
+		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
+	} else
+		spin_unlock(&cinode->open_file_lock);
 
 	cifs_done_oplock_break(cinode);
 }
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
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 0c293ff6697b..638bb70d0d65 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -192,8 +192,9 @@ static struct page *erofs_read_inode(struct inode *inode,
 	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
 
 	inode->i_flags &= ~S_DAX;
-	if (test_opt(&sbi->ctx, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
+	    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
+	     vi->datalayout == EROFS_INODE_CHUNK_BASED))
 		inode->i_flags |= S_DAX;
 	if (!nblks)
 		/* measure inode.i_blocks as generic filesystems */
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index beadb06d8feb..323e46d800e9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,7 +47,7 @@ typedef u64 erofs_off_t;
 /* data type for filesystem-wide blocks number */
 typedef u32 erofs_blk_t;
 
-struct erofs_fs_context {
+struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
@@ -60,6 +60,10 @@ struct erofs_fs_context {
 	unsigned int mount_opt;
 };
 
+struct erofs_fs_context {
+	struct erofs_mount_opts opt;
+};
+
 /* all filesystem-wide lz4 configurations */
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
@@ -69,6 +73,8 @@ struct erofs_sb_lz4_info {
 };
 
 struct erofs_sb_info {
+	struct erofs_mount_opts opt;	/* options */
+
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
 	struct list_head list;
@@ -108,8 +114,6 @@ struct erofs_sb_info {
 	u8 volume_name[16];             /* volume name */
 	u32 feature_compat;
 	u32 feature_incompat;
-
-	struct erofs_fs_context ctx;	/* options */
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -121,9 +125,9 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
 
-#define clear_opt(ctx, option)	((ctx)->mount_opt &= ~EROFS_MOUNT_##option)
-#define set_opt(ctx, option)	((ctx)->mount_opt |= EROFS_MOUNT_##option)
-#define test_opt(ctx, option)	((ctx)->mount_opt & EROFS_MOUNT_##option)
+#define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
+#define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
+#define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
 
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 11b88559f8bf..25f6b8b37f28 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -340,15 +340,15 @@ static int erofs_read_superblock(struct super_block *sb)
 static void erofs_default_options(struct erofs_fs_context *ctx)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
-	ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	ctx->max_sync_decompress_pages = 3;
-	ctx->readahead_sync_decompress = false;
+	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	ctx->opt.max_sync_decompress_pages = 3;
+	ctx->opt.readahead_sync_decompress = false;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(ctx, XATTR_USER);
+	set_opt(&ctx->opt, XATTR_USER);
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(ctx, POSIX_ACL);
+	set_opt(&ctx->opt, POSIX_ACL);
 #endif
 }
 
@@ -392,12 +392,12 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		set_opt(ctx, DAX_ALWAYS);
-		clear_opt(ctx, DAX_NEVER);
+		set_opt(&ctx->opt, DAX_ALWAYS);
+		clear_opt(&ctx->opt, DAX_NEVER);
 		return true;
 	case EROFS_MOUNT_DAX_NEVER:
-		set_opt(ctx, DAX_NEVER);
-		clear_opt(ctx, DAX_ALWAYS);
+		set_opt(&ctx->opt, DAX_NEVER);
+		clear_opt(&ctx->opt, DAX_ALWAYS);
 		return true;
 	default:
 		DBG_BUGON(1);
@@ -424,9 +424,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
 		if (result.boolean)
-			set_opt(ctx, XATTR_USER);
+			set_opt(&ctx->opt, XATTR_USER);
 		else
-			clear_opt(ctx, XATTR_USER);
+			clear_opt(&ctx->opt, XATTR_USER);
 #else
 		errorfc(fc, "{,no}user_xattr options not supported");
 #endif
@@ -434,16 +434,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_acl:
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		if (result.boolean)
-			set_opt(ctx, POSIX_ACL);
+			set_opt(&ctx->opt, POSIX_ACL);
 		else
-			clear_opt(ctx, POSIX_ACL);
+			clear_opt(&ctx->opt, POSIX_ACL);
 #else
 		errorfc(fc, "{,no}acl options not supported");
 #endif
 		break;
 	case Opt_cache_strategy:
 #ifdef CONFIG_EROFS_FS_ZIP
-		ctx->cache_strategy = result.uint_32;
+		ctx->opt.cache_strategy = result.uint_32;
 #else
 		errorfc(fc, "compression not supported, cache_strategy ignored");
 #endif
@@ -540,15 +540,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
+	sbi->opt = ctx->opt;
 	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
-	if (test_opt(ctx, DAX_ALWAYS) &&
+	if (test_opt(&sbi->opt, DAX_ALWAYS) &&
 	    !dax_supported(sbi->dax_dev, sb->s_bdev, EROFS_BLKSIZ, 0, bdev_nr_sectors(sb->s_bdev))) {
 		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
-		clear_opt(ctx, DAX_ALWAYS);
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
 	sb->s_flags |= SB_RDONLY | SB_NOATIME;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
@@ -557,13 +558,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &erofs_sops;
 	sb->s_xattr = erofs_xattr_handlers;
 
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(&sbi->opt, POSIX_ACL))
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
-	sbi->ctx = *ctx;
-
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
 #endif
@@ -607,12 +606,12 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 	DBG_BUGON(!sb_rdonly(sb));
 
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(&ctx->opt, POSIX_ACL))
 		fc->sb_flags |= SB_POSIXACL;
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
-	sbi->ctx = *ctx;
+	sbi->opt = ctx->opt;
 
 	fc->sb_flags |= SB_RDONLY;
 	return 0;
@@ -640,7 +639,6 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	erofs_default_options(fc->fs_private);
 
 	fc->ops = &erofs_context_ops;
-
 	return 0;
 }
 
@@ -763,31 +761,31 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
-	struct erofs_fs_context *ctx = &sbi->ctx;
+	struct erofs_mount_opts *opt = &sbi->opt;
 
 #ifdef CONFIG_EROFS_FS_XATTR
-	if (test_opt(ctx, XATTR_USER))
+	if (test_opt(opt, XATTR_USER))
 		seq_puts(seq, ",user_xattr");
 	else
 		seq_puts(seq, ",nouser_xattr");
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(opt, POSIX_ACL))
 		seq_puts(seq, ",acl");
 	else
 		seq_puts(seq, ",noacl");
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP
-	if (ctx->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
+	if (opt->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
 		seq_puts(seq, ",cache_strategy=disabled");
-	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
+	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
 		seq_puts(seq, ",cache_strategy=readahead");
-	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
+	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
 		seq_puts(seq, ",cache_strategy=readaround");
 #endif
-	if (test_opt(ctx, DAX_ALWAYS))
+	if (test_opt(opt, DAX_ALWAYS))
 		seq_puts(seq, ",dax=always");
-	if (test_opt(ctx, DAX_NEVER))
+	if (test_opt(opt, DAX_NEVER))
 		seq_puts(seq, ",dax=never");
 	return 0;
 }
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 778f2c52295d..01c581e93c5f 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -429,7 +429,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
 {
-	return test_opt(&EROFS_SB(dentry->d_sb)->ctx, XATTR_USER);
+	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
 }
 
 static bool erofs_xattr_trusted_list(struct dentry *dentry)
@@ -476,7 +476,7 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 
 	switch (handler->flags) {
 	case EROFS_XATTR_INDEX_USER:
-		if (!test_opt(&sbi->ctx, XATTR_USER))
+		if (!test_opt(&sbi->opt, XATTR_USER))
 			return -EOPNOTSUPP;
 		break;
 	case EROFS_XATTR_INDEX_TRUSTED:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index eb51df4a9f77..c247b1bf57cc 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -695,7 +695,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto err_out;
 
 	/* preload all compressed pages (maybe downgrade role if necessary) */
-	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
+	if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy, map->m_la))
 		cache_strategy = TRYALLOC;
 	else
 		cache_strategy = DONTALLOC;
@@ -713,7 +713,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED &&
 		  clt->mode != COLLECT_PRIMARY_FOLLOWED_NOINPLACE);
 
-	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
+	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
 		goto next_part;
@@ -797,7 +797,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->ctx.readahead_sync_decompress = true;
+		sbi->opt.readahead_sync_decompress = true;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1412,8 +1412,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (sbi->ctx.readahead_sync_decompress &&
-			nr_pages <= sbi->ctx.max_sync_decompress_pages);
+	bool sync = (sbi->opt.readahead_sync_decompress &&
+			nr_pages <= sbi->opt.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 2c8575a8f6da..15cac6baf6d2 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -253,7 +253,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	u8 *in, type;
 	bool big_pcluster;
 
-	if (1 << amortizedshift == 4)
+	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits == 12)
 		vcnt = 16;
@@ -351,7 +351,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
 					vi->inode_isize + vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
@@ -361,9 +360,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	erofs_off_t pos;
 	int err;
 
-	if (lclusterbits != 12)
-		return -EOPNOTSUPP;
-
 	if (lcn >= totalidx)
 		return -EINVAL;
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 9813cc4b7b2a..d795ccef0417 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -651,6 +651,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 
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
index 7415f7f7ee9c..64a783f22105 100644
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
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 47ec00cfb445..18002b0a908c 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -559,6 +559,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u32 flags;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -577,7 +578,9 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		freeze_bdev(sb->s_bdev);
+		ret = freeze_bdev(sb->s_bdev);
+		if (ret)
+			return ret;
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		thaw_bdev(sb->s_bdev);
 		break;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e8f5f05bddb3..47c28e3582fd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6086,8 +6086,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
@@ -6171,12 +6171,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 
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
@@ -6184,6 +6178,13 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
index b87269bae4fb..2629e90f8dbb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3848,19 +3848,10 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
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
@@ -4050,10 +4041,6 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	brelse(old.bh);
 	brelse(new.bh);
 
-unlock_moved_dir:
-	if (S_ISDIR(old.inode->i_mode))
-		inode_unlock(old.inode);
-
 	return retval;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index acbecefae316..65716a17059d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1097,6 +1097,12 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
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
@@ -1239,13 +1245,7 @@ static void ext4_put_super(struct super_block *sb)
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
 
@@ -4977,7 +4977,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount9;
+			goto failed_mount10;
 	}
 	if (EXT4_SB(sb)->s_journal) {
 		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
@@ -5023,7 +5023,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
 	goto failed_mount;
 
-failed_mount9:
+failed_mount10:
+	ext4_quota_off_umount(sb);
+failed_mount9: __maybe_unused
 	ext4_release_orphan_info(sb);
 failed_mount8:
 	ext4_unregister_sysfs(sb);
@@ -5100,6 +5102,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	brelse(bh);
 	ext4_blkdev_remove(sbi);
 out_fail:
+	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
 out_free_base:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5c0920e11e4b..835ef98643bd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3660,7 +3660,7 @@ block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background, bool force,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c24162f72f0..e1131af0396b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3251,7 +3251,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 615b109570b0..7010440cb64c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1992,8 +1992,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2031,12 +2032,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
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
@@ -2056,10 +2063,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
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
 	down_write(&sbi->cp_global_sem);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index f3b7ed54f402..7a86a8dcf4f1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -991,20 +991,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
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
@@ -1112,9 +1104,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_unlock_op(sbi);
 
-	if (S_ISDIR(old_inode->i_mode))
-		inode_unlock(old_inode);
-
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1129,9 +1118,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
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
index 89a7f6021c36..195658263f0a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -942,8 +942,10 @@ static int truncate_dnode(struct dnode_of_data *dn)
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
index 24ce12f0db32..851214d1d013 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -561,7 +561,8 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -ENOMEM;
 	}
 
-	ctx->legacy_data[size++] = ',';
+	if (size)
+		ctx->legacy_data[size++] = ',';
 	len = strlen(param->key);
 	memcpy(ctx->legacy_data + size, param->key, len);
 	size += len;
diff --git a/fs/inode.c b/fs/inode.c
index 079b64f9b756..7cb048a3b3bd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1023,6 +1023,48 @@ void discard_new_inode(struct inode *inode)
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
index 46df4ce58e87..ceb154583a3c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -152,6 +152,8 @@ extern void inode_add_lru(struct inode *inode);
 int dentry_needs_remove_privs(struct user_namespace *, struct dentry *dentry);
 bool in_group_or_capable(struct user_namespace *mnt_userns,
 			 const struct inode *inode, kgid_t gid);
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
index 0034b0f39715..d6e02ce44b97 100644
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
index 90677cfbcf9c..6a1cb2a182b6 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -637,7 +637,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
+	spin_unlock(&kernfs_idr_lock);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 1c5e7e023058..eb45d56b3577 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -184,24 +184,31 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		goto send;
 	}
 
-	if (conn->ops->check_user_session) {
-		rc = conn->ops->check_user_session(work);
-		if (rc < 0) {
-			command = conn->ops->get_cmd_val(work);
-			conn->ops->set_rsp_status(work,
-					STATUS_USER_SESSION_DELETED);
-			goto send;
-		} else if (rc > 0) {
-			rc = conn->ops->get_ksmbd_tcon(work);
+	do {
+		if (conn->ops->check_user_session) {
+			rc = conn->ops->check_user_session(work);
 			if (rc < 0) {
-				conn->ops->set_rsp_status(work,
-					STATUS_NETWORK_NAME_DELETED);
+				if (rc == -EINVAL)
+					conn->ops->set_rsp_status(work,
+						STATUS_INVALID_PARAMETER);
+				else
+					conn->ops->set_rsp_status(work,
+						STATUS_USER_SESSION_DELETED);
 				goto send;
+			} else if (rc > 0) {
+				rc = conn->ops->get_ksmbd_tcon(work);
+				if (rc < 0) {
+					if (rc == -EINVAL)
+						conn->ops->set_rsp_status(work,
+							STATUS_INVALID_PARAMETER);
+					else
+						conn->ops->set_rsp_status(work,
+							STATUS_NETWORK_NAME_DELETED);
+					goto send;
+				}
 			}
 		}
-	}
 
-	do {
 		rc = __process_request(work, conn, &command);
 		if (rc == SERVER_HANDLER_ABORT)
 			break;
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 33a927df64f1..c24674fc1904 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -347,19 +347,21 @@ static int smb2_validate_credit_charge(struct ksmbd_conn *conn,
 
 int ksmbd_smb2_check_message(struct ksmbd_work *work)
 {
-	struct smb2_pdu *pdu = work->request_buf;
+	struct smb2_pdu *pdu = ksmbd_req_buf_next(work);
 	struct smb2_hdr *hdr = &pdu->hdr;
 	int command;
 	__u32 clc_len;  /* calculated length */
-	__u32 len = get_rfc1002_len(pdu);
+	__u32 len = get_rfc1002_len(work->request_buf);
+	__u32 req_struct_size, next_cmd = le32_to_cpu(hdr->NextCommand);
 
-	if (work->next_smb2_rcv_hdr_off) {
-		pdu = ksmbd_req_buf_next(work);
-		hdr = &pdu->hdr;
+	if ((u64)work->next_smb2_rcv_hdr_off + next_cmd > len) {
+		pr_err("next command(%u) offset exceeds smb msg size\n",
+				next_cmd);
+		return 1;
 	}
 
-	if (le32_to_cpu(hdr->NextCommand) > 0)
-		len = le32_to_cpu(hdr->NextCommand);
+	if (next_cmd > 0)
+		len = next_cmd;
 	else if (work->next_smb2_rcv_hdr_off)
 		len -= work->next_smb2_rcv_hdr_off;
 
@@ -379,17 +381,9 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	}
 
 	if (smb2_req_struct_sizes[command] != pdu->StructureSize2) {
-		if (command != SMB2_OPLOCK_BREAK_HE &&
-		    (hdr->Status == 0 || pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
-			/* error packets have 9 byte structure size */
-			ksmbd_debug(SMB,
-				    "Illegal request size %u for command %d\n",
-				    le16_to_cpu(pdu->StructureSize2), command);
-			return 1;
-		} else if (command == SMB2_OPLOCK_BREAK_HE &&
-			   hdr->Status == 0 &&
-			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
-			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
+		if (command == SMB2_OPLOCK_BREAK_HE &&
+		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
+		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
 			/* special case for SMB2.1 lease break message */
 			ksmbd_debug(SMB,
 				    "Illegal request size %d for oplock break\n",
@@ -398,6 +392,14 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 		}
 	}
 
+	req_struct_size = le16_to_cpu(pdu->StructureSize2) +
+		__SMB2_HEADER_STRUCTURE_SIZE;
+	if (command == SMB2_LOCK_HE)
+		req_struct_size -= sizeof(struct smb2_lock_element);
+
+	if (req_struct_size > len + 1)
+		return 1;
+
 	if (smb2_calc_size(hdr, &clc_len))
 		return 1;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 266430a2a0e0..9f9d07caa57e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -97,7 +97,6 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 	struct smb2_hdr *req_hdr = work->request_buf;
 	int tree_id;
 
-	work->tcon = NULL;
 	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
 	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
 	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
@@ -111,10 +110,28 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 	}
 
 	tree_id = le32_to_cpu(req_hdr->Id.SyncId.TreeId);
+
+	/*
+	 * If request is not the first in Compound request,
+	 * Just validate tree id in header with work->tcon->id.
+	 */
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!work->tcon) {
+			pr_err("The first operation in the compound does not have tcon\n");
+			return -EINVAL;
+		}
+		if (work->tcon->id != tree_id) {
+			pr_err("tree id(%u) is different with id(%u) in first operation\n",
+					tree_id, work->tcon->id);
+			return -EINVAL;
+		}
+		return 1;
+	}
+
 	work->tcon = ksmbd_tree_conn_lookup(work->sess, tree_id);
 	if (!work->tcon) {
 		pr_err("Invalid tid %d\n", tree_id);
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	return 1;
@@ -569,7 +586,6 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	unsigned int cmd = conn->ops->get_cmd_val(work);
 	unsigned long long sess_id;
 
-	work->sess = NULL;
 	/*
 	 * SMB2_ECHO, SMB2_NEGOTIATE, SMB2_SESSION_SETUP command do not
 	 * require a session id, so no need to validate user session's for
@@ -580,15 +596,33 @@ int smb2_check_user_session(struct ksmbd_work *work)
 		return 0;
 
 	if (!ksmbd_conn_good(work))
-		return -EINVAL;
+		return -EIO;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
+
+	/*
+	 * If request is not the first in Compound request,
+	 * Just validate session id in header with work->sess->id.
+	 */
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!work->sess) {
+			pr_err("The first operation in the compound does not have sess\n");
+			return -EINVAL;
+		}
+		if (work->sess->id != sess_id) {
+			pr_err("session id(%llu) is different with the first operation(%lld)\n",
+					sess_id, work->sess->id);
+			return -EINVAL;
+		}
+		return 1;
+	}
+
 	/* Check for validity of user session */
 	work->sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (work->sess)
 		return 1;
 	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
-	return -EINVAL;
+	return -ENOENT;
 }
 
 static void destroy_previous_session(struct ksmbd_conn *conn,
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index f034b75c6d7f..af583e426621 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -423,7 +423,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 	out[baselen + 3] = PERIOD;
 
 	if (dot_present)
-		memcpy(&out[baselen + 4], extension, 4);
+		memcpy(out + baselen + 4, extension, 4);
 	else
 		out[baselen + 4] = '\0';
 	smbConvertToUTF16((__le16 *)shortname, out, PATH_MAX,
diff --git a/fs/namei.c b/fs/namei.c
index 02e99606c65b..885b0e93ee96 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2984,8 +2984,8 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 		return p;
 	}
 
-	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	lock_two_inodes(p1->d_inode, p2->d_inode,
+			I_MUTEX_PARENT, I_MUTEX_PARENT2);
 	return NULL;
 }
 EXPORT_SYMBOL(lock_rename);
@@ -4618,7 +4618,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
  *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source (if it is not a directory).
+ *	   and source.
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4702,10 +4702,16 @@ int vfs_rename(struct renamedata *rd)
 
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
 
 	error = -EPERM;
 	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
@@ -4753,9 +4759,8 @@ int vfs_rename(struct renamedata *rd)
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
index 0546fa1ac98f..b1ec9b5d06e5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -923,6 +923,7 @@ static int nfs41_sequence_process(struct rpc_task *task,
 out_noaction:
 	return ret;
 session_recover:
+	set_bit(NFS4_SLOT_TBL_DRAINING, &session->fc_slot_table.slot_tbl_state);
 	nfs4_schedule_session_recovery(session, status);
 	dprintk("%s ERROR: %d Reset session\n", __func__, status);
 	nfs41_sequence_free_slot(res);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0394dd60a0b4..e8132a17eeb3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3816,7 +3816,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 		p = xdr_reserve_space(xdr, 32);
 		if (!p)
 			return nfserr_resource;
-		*p++ = cpu_to_be32(0);
+		*p++ = cpu_to_be32(open->op_recall);
 
 		/*
 		 * TODO: space_limit's in delegations
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 84ec851211d9..0e2a0eb7cb9e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1337,8 +1337,11 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
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
@@ -1350,6 +1353,21 @@ static int fanotify_events_supported(struct path *path, __u64 mask)
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
 
@@ -1476,7 +1494,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	if (flags & FAN_MARK_ADD) {
-		ret = fanotify_events_supported(&path, mask);
+		ret = fanotify_events_supported(&path, mask, flags);
 		if (ret)
 			goto path_put_and_out;
 	}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1ae3b310869d..124eba7238fd 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -605,11 +605,58 @@ static const struct NTFS_DE *hdr_insert_head(struct INDEX_HDR *hdr,
 	return e;
 }
 
+/*
+ * index_hdr_check
+ *
+ * return true if INDEX_HDR is valid
+ */
+static bool index_hdr_check(const struct INDEX_HDR *hdr, u32 bytes)
+{
+	u32 end = le32_to_cpu(hdr->used);
+	u32 tot = le32_to_cpu(hdr->total);
+	u32 off = le32_to_cpu(hdr->de_off);
+
+	if (!IS_ALIGNED(off, 8) || tot > bytes || end > tot ||
+	    off + sizeof(struct NTFS_DE) > end) {
+		/* incorrect index buffer. */
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * index_buf_check
+ *
+ * return true if INDEX_BUFFER seems is valid
+ */
+static bool index_buf_check(const struct INDEX_BUFFER *ib, u32 bytes,
+			    const CLST *vbn)
+{
+	const struct NTFS_RECORD_HEADER *rhdr = &ib->rhdr;
+	u16 fo = le16_to_cpu(rhdr->fix_off);
+	u16 fn = le16_to_cpu(rhdr->fix_num);
+
+	if (bytes <= offsetof(struct INDEX_BUFFER, ihdr) ||
+	    rhdr->sign != NTFS_INDX_SIGNATURE ||
+	    fo < sizeof(struct INDEX_BUFFER)
+	    /* Check index buffer vbn. */
+	    || (vbn && *vbn != le64_to_cpu(ib->vbn)) || (fo % sizeof(short)) ||
+	    fo + fn * sizeof(short) >= bytes ||
+	    fn != ((bytes >> SECTOR_SHIFT) + 1)) {
+		/* incorrect index buffer. */
+		return false;
+	}
+
+	return index_hdr_check(&ib->ihdr,
+			       bytes - offsetof(struct INDEX_BUFFER, ihdr));
+}
+
 void fnd_clear(struct ntfs_fnd *fnd)
 {
 	int i;
 
-	for (i = 0; i < fnd->level; i++) {
+	for (i = fnd->level - 1; i >= 0; i--) {
 		struct indx_node *n = fnd->nodes[i];
 
 		if (!n)
@@ -828,9 +875,16 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	u32 t32;
 	const struct INDEX_ROOT *root = resident_data(attr);
 
+	t32 = le32_to_cpu(attr->res.data_size);
+	if (t32 <= offsetof(struct INDEX_ROOT, ihdr) ||
+	    !index_hdr_check(&root->ihdr,
+			     t32 - offsetof(struct INDEX_ROOT, ihdr))) {
+		goto out;
+	}
+
 	/* Check root fields. */
 	if (!root->index_block_clst)
-		return -EINVAL;
+		goto out;
 
 	indx->type = type;
 	indx->idx2vbn_bits = __ffs(root->index_block_clst);
@@ -842,19 +896,19 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	if (t32 < sbi->cluster_size) {
 		/* Index record is smaller than a cluster, use 512 blocks. */
 		if (t32 != root->index_block_clst * SECTOR_SIZE)
-			return -EINVAL;
+			goto out;
 
 		/* Check alignment to a cluster. */
 		if ((sbi->cluster_size >> SECTOR_SHIFT) &
 		    (root->index_block_clst - 1)) {
-			return -EINVAL;
+			goto out;
 		}
 
 		indx->vbn2vbo_bits = SECTOR_SHIFT;
 	} else {
 		/* Index record must be a multiple of cluster size. */
 		if (t32 != root->index_block_clst << sbi->cluster_bits)
-			return -EINVAL;
+			goto out;
 
 		indx->vbn2vbo_bits = sbi->cluster_bits;
 	}
@@ -862,7 +916,14 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	init_rwsem(&indx->run_lock);
 
 	indx->cmp = get_cmp_func(root);
-	return indx->cmp ? 0 : -EINVAL;
+	if (!indx->cmp)
+		goto out;
+
+	return 0;
+
+out:
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
+	return -EINVAL;
 }
 
 static struct indx_node *indx_new(struct ntfs_index *indx,
@@ -1029,6 +1090,13 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 		goto out;
 
 ok:
+	if (!index_buf_check(ib, bytes, &vbn)) {
+		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
+		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (err == -E_NTFS_FIXUP) {
 		ntfs_write_bh(ni->mi.sbi, &ib->rhdr, &in->nb, 0);
 		err = 0;
@@ -1623,9 +1691,9 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	if (err) {
 		/* Restore root. */
-		if (mi_resize_attr(mi, attr, -ds_root))
+		if (mi_resize_attr(mi, attr, -ds_root)) {
 			memcpy(attr, a_root, asize);
-		else {
+		} else {
 			/* Bug? */
 			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 2034c0ae6549..176b04a5d1ad 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -81,7 +81,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			 le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
 		goto out;
 	} else if (!is_rec_inuse(rec)) {
-		err = -EINVAL;
+		err = -ESTALE;
 		ntfs_err(sb, "Inode r=%x is not in use!", (u32)ino);
 		goto out;
 	}
@@ -92,8 +92,10 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 	}
 
-	if (!is_rec_base(rec))
-		goto Ok;
+	if (!is_rec_base(rec)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	/* Record should contain $I30 root. */
 	is_dir = rec->flags & RECORD_FLAG_DIR;
@@ -472,7 +474,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		inode->i_flags |= S_NOSEC;
 	}
 
-Ok:
 	if (ino == MFT_REC_MFT && !sb->s_root)
 		sbi->mft.ni = NULL;
 
@@ -526,6 +527,9 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 		make_bad_inode(inode);
 	}
 
+	if (IS_ERR(inode) && name)
+		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
+
 	return inode;
 }
 
@@ -1647,10 +1651,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
 
 out5:
-	if (S_ISDIR(mode) || run_is_empty(&ni->file.run))
-		goto out4;
-
-	run_deallocate(sbi, &ni->file.run, false);
+	if (!S_ISDIR(mode))
+		run_deallocate(sbi, &ni->file.run, false);
 
 out4:
 	clear_rec_inuse(rec);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index e571e7643596..fc0eb93c76de 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -789,12 +789,12 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 	     u32 run_buf_size, CLST *packed_vcns);
 int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	       CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-	       u32 run_buf_size);
+	       int run_buf_size);
 
 #ifdef NTFS3_CHECK_FREE_CLST
 int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		  CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-		  u32 run_buf_size);
+		  int run_buf_size);
 #else
 #define run_unpack_ex run_unpack
 #endif
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index a8fec651f973..6940ee5432ba 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -872,12 +872,15 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
  */
 int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	       CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-	       u32 run_buf_size)
+	       int run_buf_size)
 {
 	u64 prev_lcn, vcn64, lcn, next_vcn;
 	const u8 *run_last, *run_0;
 	bool is_mft = ino == MFT_REC_MFT;
 
+	if (run_buf_size < 0)
+		return -EINVAL;
+
 	/* Check for empty. */
 	if (evcn + 1 == svcn)
 		return 0;
@@ -999,7 +1002,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
  */
 int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		  CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-		  u32 run_buf_size)
+		  int run_buf_size)
 {
 	int ret, err;
 	CLST next_vcn, lcn, len;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 8847db015908..aaf4bafa2c70 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -42,28 +42,26 @@ static inline size_t packed_ea_size(const struct EA_FULL *ea)
  * Assume there is at least one xattr in the list.
  */
 static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
-			   const char *name, u8 name_len, u32 *off)
+			   const char *name, u8 name_len, u32 *off, u32 *ea_sz)
 {
-	*off = 0;
+	u32 ea_size;
 
-	if (!ea_all || !bytes)
+	*off = 0;
+	if (!ea_all)
 		return false;
 
-	for (;;) {
+	for (; *off < bytes; *off += ea_size) {
 		const struct EA_FULL *ea = Add2Ptr(ea_all, *off);
-		u32 next_off = *off + unpacked_ea_size(ea);
-
-		if (next_off > bytes)
-			return false;
-
+		ea_size = unpacked_ea_size(ea);
 		if (ea->name_len == name_len &&
-		    !memcmp(ea->name, name, name_len))
+		    !memcmp(ea->name, name, name_len)) {
+			if (ea_sz)
+				*ea_sz = ea_size;
 			return true;
-
-		*off = next_off;
-		if (next_off >= bytes)
-			return false;
+		}
 	}
+
+	return false;
 }
 
 /*
@@ -74,12 +72,12 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
 static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 			size_t add_bytes, const struct EA_INFO **info)
 {
-	int err;
+	int err = -EINVAL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct ATTRIB *attr_info, *attr_ea;
 	void *ea_p;
-	u32 size;
+	u32 size, off, ea_size;
 
 	static_assert(le32_to_cpu(ATTR_EA_INFO) < le32_to_cpu(ATTR_EA));
 
@@ -96,24 +94,31 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 
 	*info = resident_data_ex(attr_info, sizeof(struct EA_INFO));
 	if (!*info)
-		return -EINVAL;
+		goto out;
 
 	/* Check Ea limit. */
 	size = le32_to_cpu((*info)->size);
-	if (size > sbi->ea_max_size)
-		return -EFBIG;
+	if (size > sbi->ea_max_size) {
+		err = -EFBIG;
+		goto out;
+	}
+
+	if (attr_size(attr_ea) > sbi->ea_max_size) {
+		err = -EFBIG;
+		goto out;
+	}
 
-	if (attr_size(attr_ea) > sbi->ea_max_size)
-		return -EFBIG;
+	if (!size) {
+		/* EA info persists, but xattr is empty. Looks like EA problem. */
+		goto out;
+	}
 
 	/* Allocate memory for packed Ea. */
 	ea_p = kmalloc(size_add(size, add_bytes), GFP_NOFS);
 	if (!ea_p)
 		return -ENOMEM;
 
-	if (!size) {
-		/* EA info persists, but xattr is empty. Looks like EA problem. */
-	} else if (attr_ea->non_res) {
+	if (attr_ea->non_res) {
 		struct runs_tree run;
 
 		run_init(&run);
@@ -124,24 +129,52 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 		run_close(&run);
 
 		if (err)
-			goto out;
+			goto out1;
 	} else {
 		void *p = resident_data_ex(attr_ea, size);
 
-		if (!p) {
-			err = -EINVAL;
-			goto out;
-		}
+		if (!p)
+			goto out1;
 		memcpy(ea_p, p, size);
 	}
 
 	memset(Add2Ptr(ea_p, size), 0, add_bytes);
+
+	/* Check all attributes for consistency. */
+	for (off = 0; off < size; off += ea_size) {
+		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
+		u32 bytes = size - off;
+
+		/* Check if we can use field ea->size. */
+		if (bytes < sizeof(ef->size))
+			goto out1;
+
+		if (ef->size) {
+			ea_size = le32_to_cpu(ef->size);
+			if (ea_size > bytes)
+				goto out1;
+			continue;
+		}
+
+		/* Check if we can use fields ef->name_len and ef->elength. */
+		if (bytes < offsetof(struct EA_FULL, name))
+			goto out1;
+
+		ea_size = ALIGN(struct_size(ef, name,
+					    1 + ef->name_len +
+						    le16_to_cpu(ef->elength)),
+				4);
+		if (ea_size > bytes)
+			goto out1;
+	}
+
 	*ea = ea_p;
 	return 0;
 
-out:
+out1:
 	kfree(ea_p);
-	*ea = NULL;
+out:
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
 	return err;
 }
 
@@ -163,6 +196,7 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 	const struct EA_FULL *ea;
 	u32 off, size;
 	int err;
+	int ea_size;
 	size_t ret;
 
 	err = ntfs_read_ea(ni, &ea_all, 0, &info);
@@ -175,8 +209,12 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 	size = le32_to_cpu(info->size);
 
 	/* Enumerate all xattrs. */
-	for (ret = 0, off = 0; off < size; off += unpacked_ea_size(ea)) {
+	for (ret = 0, off = 0; off < size; off += ea_size) {
 		ea = Add2Ptr(ea_all, off);
+		ea_size = unpacked_ea_size(ea);
+
+		if (!ea->name_len)
+			break;
 
 		if (buffer) {
 			if (ret + ea->name_len + 1 > bytes_per_buffer) {
@@ -227,7 +265,8 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
 		goto out;
 
 	/* Enumerate all xattrs. */
-	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off)) {
+	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off,
+		     NULL)) {
 		err = -ENODATA;
 		goto out;
 	}
@@ -269,7 +308,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	struct EA_FULL *new_ea;
 	struct EA_FULL *ea_all = NULL;
 	size_t add, new_pack;
-	u32 off, size;
+	u32 off, size, ea_sz;
 	__le16 size_pack;
 	struct ATTRIB *attr;
 	struct ATTR_LIST_ENTRY *le;
@@ -303,9 +342,8 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		size_pack = ea_info.size_pack;
 	}
 
-	if (info && find_ea(ea_all, size, name, name_len, &off)) {
+	if (info && find_ea(ea_all, size, name, name_len, &off, &ea_sz)) {
 		struct EA_FULL *ea;
-		size_t ea_sz;
 
 		if (flags & XATTR_CREATE) {
 			err = -EEXIST;
@@ -328,8 +366,6 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		if (ea->flags & FILE_NEED_EA)
 			le16_add_cpu(&ea_info.count, -1);
 
-		ea_sz = unpacked_ea_size(ea);
-
 		le16_add_cpu(&ea_info.size_pack, 0 - packed_ea_size(ea));
 
 		memmove(ea, Add2Ptr(ea, ea_sz), size - off - ea_sz);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index ef0bf98b620d..46cc429c44f7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -542,6 +542,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			/* Restore timestamps on parent (best effort) */
 			ovl_set_timestamps(upperdir, &c->pstat);
 			ovl_dentry_set_upper_alias(c->dentry);
+			ovl_dentry_update_reval(c->dentry, upper);
 		}
 	}
 	inode_unlock(udir);
@@ -840,6 +841,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		inode_unlock(udir);
 
 		ovl_dentry_set_upper_alias(c->dentry);
+		ovl_dentry_update_reval(c->dentry, ovl_dentry_upper(c->dentry));
 	}
 
 out:
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index eca984d6484d..519193ce7d57 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -267,8 +267,7 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 
 	ovl_dir_modified(dentry->d_parent, false);
 	ovl_dentry_set_upper_alias(dentry);
-	ovl_dentry_update_reval(dentry, newdentry,
-			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_reval(dentry, newdentry);
 
 	if (!hardlink) {
 		/*
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 0cc14ce8c7e8..baa50ece0bc5 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -326,8 +326,7 @@ static struct dentry *ovl_obtain_alias(struct super_block *sb,
 	if (upper_alias)
 		ovl_dentry_set_upper_alias(dentry);
 
-	ovl_dentry_update_reval(dentry, upper,
-			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_reval(dentry, upper);
 
 	return d_instantiate_anon(dentry, inode);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index d41f0c8e0e2a..65e5e6eb761a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -453,7 +453,15 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 	const struct cred *old_cred;
 	struct posix_acl *acl;
 
-	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
+	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
+		return NULL;
+
+	if (!realinode) {
+		WARN_ON(!rcu);
+		return ERR_PTR(-ECHILD);
+	}
+
+	if (!IS_POSIXACL(realinode))
 		return NULL;
 
 	if (rcu)
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 1a9b515fc45d..9c055d11a95d 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1103,8 +1103,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			ovl_set_flag(OVL_UPPERDATA, inode);
 	}
 
-	ovl_dentry_update_reval(dentry, upperdentry,
-			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_reval(dentry, upperdentry);
 
 	revert_creds(old_cred);
 	if (origin_path) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ae4876da2ced..a96b67586f81 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -286,8 +286,10 @@ bool ovl_index_all(struct super_block *sb);
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
index b3675d13c1ac..5310271cf2e3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1965,7 +1965,7 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
-	ovl_dentry_update_reval(root, upperdentry, DCACHE_OP_WEAK_REVALIDATE);
+	ovl_dentry_init_flags(root, upperdentry, DCACHE_OP_WEAK_REVALIDATE);
 
 	return root;
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 9d33ce385bef..d62d5ede60df 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -94,14 +94,30 @@ struct ovl_entry *ovl_alloc_entry(unsigned int numlower)
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
index 155c7010b1f8..fd9bab137685 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -591,6 +591,8 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	raw_spin_lock_init(&prz->buffer_lock);
 	prz->flags = flags;
 	prz->label = kstrdup(label, GFP_KERNEL);
+	if (!prz->label)
+		goto err;
 
 	ret = persistent_ram_buffer_map(start, size, prz, memtype);
 	if (ret)
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 65e7e56005b8..dc1f9e6d95a5 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -274,7 +274,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void ramfs_kill_sb(struct super_block *sb)
+void ramfs_kill_sb(struct super_block *sb)
 {
 	kfree(sb->s_fs_info);
 	kill_litter_super(sb);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e9c7d7b270e7..7a85ae6b7b00 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -52,7 +52,7 @@ bool acpi_dock_match(acpi_handle handle);
 bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
-
+#ifdef CONFIG_ACPI
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -68,6 +68,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 
 	return obj;
 }
+#endif
 
 #define	ACPI_INIT_DSM_ARGV4(cnt, eles)			\
 	{						\
diff --git a/include/crypto/internal/kpp.h b/include/crypto/internal/kpp.h
index 659b642efada..05b25a819d0d 100644
--- a/include/crypto/internal/kpp.h
+++ b/include/crypto/internal/kpp.h
@@ -18,6 +18,12 @@ static inline void *kpp_request_ctx(struct kpp_request *req)
 	return req->__ctx;
 }
 
+static inline void kpp_set_reqsize(struct crypto_kpp *kpp,
+				   unsigned int reqsize)
+{
+	crypto_kpp_alg(kpp)->reqsize = reqsize;
+}
+
 static inline void *kpp_tfm_ctx(struct crypto_kpp *tfm)
 {
 	return tfm->base.__crt_ctx;
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 2bc8b1f69c93..888eb660d3f6 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -59,6 +60,7 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
 
 static inline void free_bootmem_page(struct page *page)
 {
+	kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
 	free_reserved_page(page);
 }
 #endif
diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 6995092b774e..ef1fd32cef16 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -69,17 +69,18 @@
  * Error Status Indicator (ESI)		1
  * Data length code (DLC)		4
  * Data field				0...512
- * Stuff Bit Count (SBC)		0...16: 4 20...64:5
+ * Stuff Bit Count (SBC)		4
  * CRC					0...16: 17 20...64:21
  * CRC delimiter (CD)			1
+ * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
  * ACK slot (AS)			1
  * ACK delimiter (AD)			1
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21, rounded up and ignoring dynamic bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
+#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(67, 8)
 
 /*
  * Size of a CAN-FD Extended Frame
@@ -98,17 +99,18 @@
  * Error Status Indicator (ESI)		1
  * Data length code (DLC)		4
  * Data field				0...512
- * Stuff Bit Count (SBC)		0...16: 4 20...64:5
+ * Stuff Bit Count (SBC)		4
  * CRC					0...16: 17 20...64:21
  * CRC delimiter (CD)			1
+ * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
  * ACK slot (AS)			1
  * ACK delimiter (AD)			1
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21, rounded up and ignoring dynamic bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
+#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(86, 8)
 
 /*
  * Maximum size of a Classical CAN frame
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0a4589ab706..b5df2e59a51d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5196,6 +5196,15 @@ static inline bool netif_is_l3_slave(const struct net_device *dev)
 	return dev->priv_flags & IFF_L3MDEV_SLAVE;
 }
 
+static inline int dev_sdif(const struct net_device *dev)
+{
+#ifdef CONFIG_NET_L3_MASTER_DEV
+	if (netif_is_l3_slave(dev))
+		return dev->ifindex;
+#endif
+	return 0;
+}
+
 static inline bool netif_is_bridge_master(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_EBRIDGE;
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
index 7e471432a998..99dfb8c1993a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1787,6 +1787,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
+static inline void pci_clear_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 18dcca51829e..d15190b3e032 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -265,18 +265,14 @@ void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 
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
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 68abc6bdd891..979586e34da8 100644
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
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..20a47eb94b0f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -68,7 +68,6 @@ enum {
 	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
 
 	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
-	WORK_OFFQ_CANCELING	= (1 << __WORK_OFFQ_CANCELING),
 
 	/*
 	 * When a work item is off queue, its high bits point to the last
@@ -79,12 +78,6 @@ enum {
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
@@ -94,6 +87,14 @@ enum {
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
index 7da74b9428b9..d486bddda15d 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -437,7 +437,8 @@ struct nft_set_ops {
 	int				(*init)(const struct nft_set *set,
 						const struct nft_set_desc *desc,
 						const struct nlattr * const nla[]);
-	void				(*destroy)(const struct nft_set *set);
+	void				(*destroy)(const struct nft_ctx *ctx,
+						   const struct nft_set *set);
 	void				(*gc_init)(const struct nft_set *set);
 
 	unsigned int			elemsize;
@@ -772,6 +773,8 @@ int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_expr *expr_array[]);
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr);
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem);
 
 /**
  *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9cd2d4e84913..d0d9dd2483dd 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -141,7 +141,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-	return dev->mtu + dev->hard_header_len;
+	return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }
 
 static inline struct net *qdisc_net(struct Qdisc *q)
diff --git a/include/net/sock.h b/include/net/sock.h
index 0eb6a4d07a4d..93a6717213ae 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2004,6 +2004,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 }
 
 kuid_t sock_i_uid(struct sock *sk);
+unsigned long __sock_i_ino(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 1cf012de6442..d49e44fcc10f 100644
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
index 61c5011dfc13..f5c6758464f2 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1652,7 +1652,7 @@ struct v4l2_input {
 	__u8	     name[32];		/*  Label */
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
-	__u32        tuner;             /*  enum v4l2_tuner_type */
+	__u32        tuner;             /*  Tuner index */
 	v4l2_std_id  std;
 	__u32	     status;
 	__u32	     capabilities;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index cbfc9bbe87b0..d7f87157be9a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1524,6 +1524,8 @@ static void io_kill_timeout(struct io_kiocb *req, int status)
 
 static void io_queue_deferred(struct io_ring_ctx *ctx)
 {
+	lockdep_assert_held(&ctx->completion_lock);
+
 	while (!list_empty(&ctx->defer_list)) {
 		struct io_defer_entry *de = list_first_entry(&ctx->defer_list,
 						struct io_defer_entry, list);
@@ -1575,14 +1577,24 @@ static void __io_commit_cqring_flush(struct io_ring_ctx *ctx)
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
@@ -2205,9 +2217,12 @@ static void tctx_task_work(struct callback_head *cb)
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
@@ -2521,7 +2536,12 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
@@ -7779,7 +7799,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
 					  ktime_t *timeout)
 {
-	int ret;
+	int token, ret;
 
 	/* make sure we run task_work before checking for signals */
 	ret = io_run_task_work_sig();
@@ -7789,9 +7809,17 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
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
@@ -9697,7 +9725,18 @@ static void io_ring_exit_work(struct work_struct *work)
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
@@ -9722,7 +9761,12 @@ static void io_ring_exit_work(struct work_struct *work)
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
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 87174832aa86..297569e5c639 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1481,6 +1481,12 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		ret = 1;
 	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
 		/* optlen is out of bounds */
+		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = 0;
+			goto out;
+		}
 		ret = -EFAULT;
 	} else {
 		/* optlen within bounds, run kernel handler */
@@ -1536,6 +1542,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		.optname = optname,
 		.retval = retval,
 	};
+	int orig_optlen;
 	int ret;
 
 	/* Opportunistic check to see whether we have any BPF program
@@ -1545,6 +1552,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (__cgroup_bpf_prog_array_is_empty(cgrp, CGROUP_GETSOCKOPT))
 		return retval;
 
+	orig_optlen = max_optlen;
 	ctx.optlen = max_optlen;
 
 	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
@@ -1568,6 +1576,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 			ret = -EFAULT;
 			goto out;
 		}
+		orig_optlen = ctx.optlen;
 
 		if (copy_from_user(ctx.optval, optval,
 				   min(ctx.optlen, max_optlen)) != 0) {
@@ -1587,6 +1596,12 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
+		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = retval;
+			goto out;
+		}
 		ret = -EFAULT;
 		goto out;
 	}
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 585b2b77ccc4..db6221773e43 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -126,22 +126,6 @@ static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	atomic_inc(&rcpu->refcnt);
 }
 
-/* called from workqueue, to workaround syscall using preempt_disable */
-static void cpu_map_kthread_stop(struct work_struct *work)
-{
-	struct bpf_cpu_map_entry *rcpu;
-
-	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
-
-	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
-	 * as it waits until all in-flight call_rcu() callbacks complete.
-	 */
-	rcu_barrier();
-
-	/* kthread_stop will wake_up_process and wait for it to complete */
-	kthread_stop(rcpu->kthread);
-}
-
 static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 {
 	/* The tear-down procedure should have made sure that queue is
@@ -169,6 +153,30 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	}
 }
 
+/* called from workqueue, to workaround syscall using preempt_disable */
+static void cpu_map_kthread_stop(struct work_struct *work)
+{
+	struct bpf_cpu_map_entry *rcpu;
+	int err;
+
+	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
+
+	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
+	 * as it waits until all in-flight call_rcu() callbacks complete.
+	 */
+	rcu_barrier();
+
+	/* kthread_stop will wake_up_process and wait for it to complete */
+	err = kthread_stop(rcpu->kthread);
+	if (err) {
+		/* kthread_stop may be called before cpu_map_kthread_run
+		 * is executed, so we need to release the memory related
+		 * to rcpu.
+		 */
+		put_cpu_map_entry(rcpu);
+	}
+}
+
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 				     struct list_head *listp,
 				     struct xdp_cpumap_stats *stats)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a70595c3c15..bd31aa6407a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3765,8 +3765,9 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
-			 /* async callbacks don't increase bpf prog stack size */
-			continue;
+			/* async callbacks don't increase bpf prog stack size unless called directly */
+			if (!bpf_pseudo_call(insn + i))
+				continue;
 		}
 		i = next_insn;
 
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 526510b3791e..3f3b5e3ca9eb 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1050,7 +1050,9 @@ EXPORT_SYMBOL(__tsan_init);
 DEFINE_TSAN_ATOMIC_OPS(8);
 DEFINE_TSAN_ATOMIC_OPS(16);
 DEFINE_TSAN_ATOMIC_OPS(32);
+#ifdef CONFIG_64BIT
 DEFINE_TSAN_ATOMIC_OPS(64);
+#endif
 
 void __tsan_atomic_thread_fence(int memorder);
 void __tsan_atomic_thread_fence(int memorder)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index bdc2d952911c..7e735fd33858 100644
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
index 2cc34a22a506..57ec414710bb 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -50,8 +50,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 	pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s)
 #define VERBOSE_SCALEOUT_STRING(s) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s); } while (0)
-#define VERBOSE_SCALEOUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s); } while (0)
+#define SCALEOUT_ERRSTRING(s) \
+	pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s)
 
 /*
  * The intended use cases for the nreaders and nwriters module parameters
@@ -500,89 +500,6 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
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
-			for (j = 0; j < writer_n_durations[i]; j++) {
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
@@ -602,21 +519,6 @@ static int compute_real(int n)
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
@@ -736,8 +638,8 @@ kfree_scale_cleanup(void)
 static int
 kfree_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
+	wait_event_idle(shutdown_wq,
+			atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
@@ -791,6 +693,108 @@ kfree_scale_init(void)
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
@@ -845,7 +849,7 @@ rcu_scale_init(void)
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -865,7 +869,7 @@ rcu_scale_init(void)
 		kcalloc(nrealwriters, sizeof(*writer_n_durations),
 			GFP_KERNEL);
 	if (!writer_tasks || !writer_durations || !writer_n_durations) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 808a247205a9..ed3c4a954398 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1037,27 +1037,52 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
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
@@ -1067,10 +1092,12 @@ void exit_itimers(struct task_struct *tsk)
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
index 06927f772d50..157a1d2d9802 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3192,6 +3192,22 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
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
@@ -3230,17 +3246,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	return start_pg;
 
  free_pages:
-	pg = start_pg;
-	while (pg) {
-		if (pg->records) {
-			free_pages((unsigned long)pg->records, pg->order);
-			ftrace_number_of_pages -= 1 << pg->order;
-		}
-		start_pg = pg->next;
-		kfree(pg);
-		pg = start_pg;
-		ftrace_number_of_groups--;
-	}
+	ftrace_free_pages(start_pg);
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
 }
@@ -6184,9 +6190,11 @@ static int ftrace_process_locs(struct module *mod,
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
@@ -6240,8 +6248,10 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr)
+		if (!addr) {
+			skipped++;
 			continue;
+		}
 
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
@@ -6255,8 +6265,10 @@ static int ftrace_process_locs(struct module *mod,
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
@@ -6278,6 +6290,11 @@ static int ftrace_process_locs(struct module *mod,
  out:
 	mutex_unlock(&ftrace_lock);
 
+	/* We should have used all pages unless we skipped some */
+	if (pg_unuse) {
+		WARN_ON(!skipped);
+		ftrace_free_pages(pg_unuse);
+	}
 	return ret;
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 83046c6443f1..ceeba8bf1265 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5196,28 +5196,34 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
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
index 0202f23ae960..1dda36c7e5eb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6650,6 +6650,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	free_cpumask_var(iter->started);
 	kfree(iter->fmt);
+	kfree(iter->temp);
 	mutex_destroy(&iter->mutex);
 	kfree(iter);
 
@@ -8013,7 +8014,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek         = tracing_lseek,
 	.release        = tracing_err_log_release,
 };
 
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 9806316af127..085f056e66f1 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -725,6 +725,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
+	int cnt = 0;
 
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
@@ -748,12 +749,25 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 		if (ret)
 			break;
 		enabled = true;
+		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled)
-			disable_eprobe(ep, file->tr);
+		if (enabled) {
+			/*
+			 * It's a bug if one failed for something other than memory
+			 * not being available but another eprobe succeeded.
+			 */
+			WARN_ON_ONCE(ret != -ENOMEM);
+
+			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+				ep = container_of(pos, struct trace_eprobe, tp);
+				disable_eprobe(ep, file->tr);
+				if (!--cnt)
+					break;
+			}
+		}
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 80e65287294c..0bb34467e4f2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5944,13 +5944,15 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	if (has_hist_vars(hist_data))
-		save_hist_vars(hist_data);
-
 	ret = create_actions(hist_data);
 	if (ret)
 		goto out_unreg;
 
+	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+		if (save_hist_vars(hist_data))
+			goto out_unreg;
+	}
+
 	ret = tracing_map_init(hist_data->map);
 	if (ret)
 		goto out_unreg;
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index b3bdb8ddb862..c293a607d536 100644
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
@@ -204,11 +206,13 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic)) {
-			*dl = make_data_loc(0, dyndata - base);
-		} else {
-			dyndata += ret;
-			maxlen -= ret;
+		if (arg->dynamic) {
+			if (unlikely(ret < 0)) {
+				*dl = make_data_loc(0, dyndata - base);
+			} else {
+				dyndata += ret;
+				maxlen -= ret;
+			}
 		}
 	}
 }
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
index 2d27bed9881d..8e108c040cc3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -697,12 +697,17 @@ static void clear_work_data(struct work_struct *work)
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
@@ -730,8 +735,7 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 	assert_rcu_or_pool_mutex();
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+		return work_struct_pwq(data)->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -752,8 +756,7 @@ static int get_work_pool_id(struct work_struct *work)
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+		return work_struct_pwq(data)->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 2a4078946a3f..b64f87f4f228 100644
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
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1945196fd743..6ad96da15081 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -393,7 +393,7 @@ static struct page *damon_get_page(unsigned long pfn)
 	return page;
 }
 
-static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
+static void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma,
 			     unsigned long addr)
 {
 	bool referenced = false;
@@ -402,13 +402,11 @@ static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
 	if (!page)
 		return;
 
-	if (pte_young(*pte)) {
+	if (ptep_test_and_clear_young(vma, addr, pte))
 		referenced = true;
-		*pte = pte_mkold(*pte);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
+	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
@@ -419,7 +417,7 @@ static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
 	put_page(page);
 }
 
-static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
+static void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma,
 			     unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -429,13 +427,11 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
 	if (!page)
 		return;
 
-	if (pmd_young(*pmd)) {
+	if (pmdp_test_and_clear_young(vma, addr, pmd))
 		referenced = true;
-		*pmd = pmd_mkold(*pmd);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr,
+	if (mmu_notifier_clear_young(vma->vm_mm, addr,
 				addr + ((1UL) << HPAGE_PMD_SHIFT)))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
@@ -462,7 +458,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		}
 
 		if (pmd_huge(*pmd)) {
-			damon_pmdp_mkold(pmd, walk->mm, addr);
+			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
 		}
@@ -474,7 +470,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte_present(*pte))
 		goto out;
-	damon_ptep_mkold(pte, walk->mm, addr);
+	damon_ptep_mkold(pte, walk->vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
diff --git a/mm/shmem.c b/mm/shmem.c
index 0c37c5f0a903..41efb92c4e38 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4043,7 +4043,7 @@ static struct file_system_type shmem_fs_type = {
 	.name		= "tmpfs",
 	.init_fs_context = ramfs_init_fs_context,
 	.parameters	= ramfs_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= ramfs_kill_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 4a02f8bb278a..1f70441cbada 100644
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
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index cc40ce4e02fb..c3d105e59d25 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -391,6 +391,8 @@ static int head_onwire_len(int ctrl_len, bool secure)
 	int head_len;
 	int rem_len;
 
+	BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
+
 	if (secure) {
 		head_len = CEPH_PREAMBLE_SECURE_LEN;
 		if (ctrl_len > CEPH_PREAMBLE_INLINE_LEN) {
@@ -409,6 +411,10 @@ static int head_onwire_len(int ctrl_len, bool secure)
 static int __tail_onwire_len(int front_len, int middle_len, int data_len,
 			     bool secure)
 {
+	BUG_ON(front_len < 0 || front_len > CEPH_MSG_MAX_FRONT_LEN ||
+	       middle_len < 0 || middle_len > CEPH_MSG_MAX_MIDDLE_LEN ||
+	       data_len < 0 || data_len > CEPH_MSG_MAX_DATA_LEN);
+
 	if (!front_len && !middle_len && !data_len)
 		return 0;
 
@@ -521,29 +527,34 @@ static int decode_preamble(void *p, struct ceph_frame_desc *desc)
 		desc->fd_aligns[i] = ceph_decode_16(&p);
 	}
 
-	/*
-	 * This would fire for FRAME_TAG_WAIT (it has one empty
-	 * segment), but we should never get it as client.
-	 */
-	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
-		pr_err("last segment empty\n");
+	if (desc->fd_lens[0] < 0 ||
+	    desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
+		pr_err("bad control segment length %d\n", desc->fd_lens[0]);
 		return -EINVAL;
 	}
-
-	if (desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
-		pr_err("control segment too big %d\n", desc->fd_lens[0]);
+	if (desc->fd_lens[1] < 0 ||
+	    desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
+		pr_err("bad front segment length %d\n", desc->fd_lens[1]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
-		pr_err("front segment too big %d\n", desc->fd_lens[1]);
+	if (desc->fd_lens[2] < 0 ||
+	    desc->fd_lens[2] > CEPH_MSG_MAX_MIDDLE_LEN) {
+		pr_err("bad middle segment length %d\n", desc->fd_lens[2]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[2] > CEPH_MSG_MAX_MIDDLE_LEN) {
-		pr_err("middle segment too big %d\n", desc->fd_lens[2]);
+	if (desc->fd_lens[3] < 0 ||
+	    desc->fd_lens[3] > CEPH_MSG_MAX_DATA_LEN) {
+		pr_err("bad data segment length %d\n", desc->fd_lens[3]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[3] > CEPH_MSG_MAX_DATA_LEN) {
-		pr_err("data segment too big %d\n", desc->fd_lens[3]);
+
+	/*
+	 * This would fire for FRAME_TAG_WAIT (it has one empty
+	 * segment), but we should never get it as client.
+	 */
+	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
+		pr_err("last segment empty, segment count %d\n",
+		       desc->fd_seg_cnt);
 		return -EINVAL;
 	}
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 519315a1acf3..18eb8049c795 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6174,12 +6174,11 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 static struct sock *
 __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		 struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		 u64 flags)
+		 u64 flags, int sdif)
 {
 	struct sock *sk = NULL;
-	u8 family = AF_UNSPEC;
 	struct net *net;
-	int sdif;
+	u8 family;
 
 	if (len == sizeof(tuple->ipv4))
 		family = AF_INET;
@@ -6188,14 +6187,15 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	else
 		return NULL;
 
-	if (unlikely(family == AF_UNSPEC || flags ||
-		     !((s32)netns_id < 0 || netns_id <= S32_MAX)))
+	if (unlikely(flags || !((s32)netns_id < 0 || netns_id <= S32_MAX)))
 		goto out;
 
-	if (family == AF_INET)
-		sdif = inet_sdif(skb);
-	else
-		sdif = inet6_sdif(skb);
+	if (sdif < 0) {
+		if (family == AF_INET)
+			sdif = inet_sdif(skb);
+		else
+			sdif = inet6_sdif(skb);
+	}
 
 	if ((s32)netns_id < 0) {
 		net = caller_net;
@@ -6215,10 +6215,11 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 static struct sock *
 __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		u64 flags)
+		u64 flags, int sdif)
 {
 	struct sock *sk = __bpf_skc_lookup(skb, tuple, len, caller_net,
-					   ifindex, proto, netns_id, flags);
+					   ifindex, proto, netns_id, flags,
+					   sdif);
 
 	if (sk) {
 		struct sock *sk2 = sk_to_full_sk(sk);
@@ -6258,7 +6259,7 @@ bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	}
 
 	return __bpf_skc_lookup(skb, tuple, len, caller_net, ifindex, proto,
-				netns_id, flags);
+				netns_id, flags, -1);
 }
 
 static struct sock *
@@ -6347,6 +6348,78 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	struct net_device *dev = skb->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
+
+	return (unsigned long)__bpf_skc_lookup(skb, tuple, len, caller_net,
+					       ifindex, IPPROTO_TCP, netns_id,
+					       flags, sdif);
+}
+
+static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
+	.func		= bpf_tc_skc_lookup_tcp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	struct net_device *dev = skb->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
+
+	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
+					      ifindex, IPPROTO_TCP, netns_id,
+					      flags, sdif);
+}
+
+static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
+	.func		= bpf_tc_sk_lookup_tcp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	struct net_device *dev = skb->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
+
+	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
+					      ifindex, IPPROTO_UDP, netns_id,
+					      flags, sdif);
+}
+
+static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
+	.func		= bpf_tc_sk_lookup_udp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
 	if (sk && sk_is_refcounted(sk))
@@ -6364,12 +6437,13 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_UDP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
@@ -6387,12 +6461,13 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len, caller_net,
 					       ifindex, IPPROTO_TCP, netns_id,
-					       flags);
+					       flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
@@ -6410,12 +6485,13 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 BPF_CALL_5(bpf_xdp_sk_lookup_tcp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_TCP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
@@ -6435,7 +6511,8 @@ BPF_CALL_5(bpf_sock_addr_skc_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len,
 					       sock_net(ctx->sk), 0,
-					       IPPROTO_TCP, netns_id, flags);
+					       IPPROTO_TCP, netns_id, flags,
+					       -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
@@ -6454,7 +6531,7 @@ BPF_CALL_5(bpf_sock_addr_sk_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
 					      sock_net(ctx->sk), 0, IPPROTO_TCP,
-					      netns_id, flags);
+					      netns_id, flags, -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
@@ -6473,7 +6550,7 @@ BPF_CALL_5(bpf_sock_addr_sk_lookup_udp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
 					      sock_net(ctx->sk), 0, IPPROTO_UDP,
-					      netns_id, flags);
+					      netns_id, flags, -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
@@ -7476,9 +7553,9 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
-		return &bpf_sk_lookup_tcp_proto;
+		return &bpf_tc_sk_lookup_tcp_proto;
 	case BPF_FUNC_sk_lookup_udp:
-		return &bpf_sk_lookup_udp_proto;
+		return &bpf_tc_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
 	case BPF_FUNC_tcp_sock:
@@ -7486,7 +7563,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_listener_sock:
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skc_lookup_tcp:
-		return &bpf_skc_lookup_tcp_proto;
+		return &bpf_tc_skc_lookup_tcp_proto;
 	case BPF_FUNC_tcp_check_syncookie:
 		return &bpf_tcp_check_syncookie_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index bc187289bf64..49766446797c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -922,24 +922,27 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
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
@@ -1214,7 +1217,8 @@ static noinline_for_stack int rtnl_fill_stats(struct sk_buff *skb,
 static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 					       struct net_device *dev,
 					       int vfs_num,
-					       struct nlattr *vfinfo)
+					       struct nlattr *vfinfo,
+					       u32 ext_filter_mask)
 {
 	struct ifla_vf_rss_query_en vf_rss_query_en;
 	struct nlattr *vf, *vfstats, *vfvlanlist;
@@ -1320,33 +1324,35 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
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
 
@@ -1379,7 +1385,7 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	for (i = 0; i < num_vfs; i++) {
-		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo))
+		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask))
 			return -EMSGSIZE;
 	}
 
@@ -3905,7 +3911,7 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	ndm->ndm_ifindex = dev->ifindex;
 	ndm->ndm_state   = ndm_state;
 
-	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, addr))
+	if (nla_put(skb, NDA_LLADDR, dev->addr_len, addr))
 		goto nla_put_failure;
 	if (vid)
 		if (nla_put(skb, NDA_VLAN, sizeof(u16), &vid))
@@ -3919,10 +3925,10 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
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
@@ -3934,7 +3940,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(rtnl_fdb_nlmsg_size(), GFP_ATOMIC);
+	skb = nlmsg_new(rtnl_fdb_nlmsg_size(dev), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f3850c88cdda..e01dd4cad0fc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3882,6 +3882,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 
 	skb_push(skb, -skb_network_offset(skb) + offset);
 
+	/* Ensure the head is writeable before touching the shared info */
+	err = skb_unclone(skb, GFP_ATOMIC);
+	if (err)
+		goto err_linearize;
+
 	skb_shinfo(skb)->frag_list = NULL;
 
 	while (list_skb) {
diff --git a/net/core/sock.c b/net/core/sock.c
index 93fb3d64f48e..cf1e437ae487 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2324,13 +2324,24 @@ kuid_t sock_i_uid(struct sock *sk)
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
index d43feadd5fa6..a163f535697e 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -100,8 +100,8 @@ static void sja1105_meta_unpack(const struct sk_buff *skb,
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
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 65f5d07cd83d..6849094e5e5e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3584,8 +3584,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
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
@@ -3594,7 +3597,10 @@ static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 		}
 	}
 
-	*last_oow_ack_time = tcp_jiffies32;
+	/* Paired with the prior READ_ONCE() and with itself,
+	 * as we might be lockless.
+	 */
+	WRITE_ONCE(*last_oow_ack_time, tcp_jiffies32);
 
 	return false;	/* not rate-limited: go ahead, send dupack now! */
 }
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 6ba34f51c411..e0d3909172a8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -323,9 +323,8 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
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
index 716e7717fe8f..71a69166a6bd 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -430,7 +430,10 @@ static struct net_device *icmp6_dev(const struct sk_buff *skb)
 	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
 		const struct rt6_info *rt6 = skb_rt6_info(skb);
 
-		if (rt6)
+		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
+		 * and ip6_null_entry could be set to skb if no route is found.
+		 */
+		if (rt6 && rt6->rt6i_idev)
 			dev = rt6->rt6i_idev->dev;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5161e98f6fcf..a746abbe81b5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -88,7 +88,7 @@ static u32 udp6_ehashfn(const struct net *net,
 	fhash = __ipv6_addr_jhash(faddr, udp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       udp_ipv6_hash_secret + net_hash_mix(net));
+			       udp6_ehash_secret + net_hash_mix(net));
 }
 
 int udp_v6_get_port(struct sock *sk, unsigned short snum)
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 271da8447b29..2a3017b9c001 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -44,7 +44,8 @@ config	IP_VS_DEBUG
 
 config	IP_VS_TAB_BITS
 	int "IPVS connection table size (the Nth power of 2)"
-	range 8 20
+	range 8 20 if !64BIT
+	range 8 27 if 64BIT
 	default 12
 	help
 	  The IPVS connection hash table uses the chaining scheme to handle
@@ -54,24 +55,24 @@ config	IP_VS_TAB_BITS
 
 	  Note the table size must be power of 2. The table size will be the
 	  value of 2 to the your input number power. The number to choose is
-	  from 8 to 20, the default number is 12, which means the table size
-	  is 4096. Don't input the number too small, otherwise you will lose
-	  performance on it. You can adapt the table size yourself, according
-	  to your virtual server application. It is good to set the table size
-	  not far less than the number of connections per second multiplying
-	  average lasting time of connection in the table.  For example, your
-	  virtual server gets 200 connections per second, the connection lasts
-	  for 200 seconds in average in the connection table, the table size
-	  should be not far less than 200x200, it is good to set the table
-	  size 32768 (2**15).
+	  from 8 to 27 for 64BIT(20 otherwise), the default number is 12,
+	  which means the table size is 4096. Don't input the number too
+	  small, otherwise you will lose performance on it. You can adapt the
+	  table size yourself, according to your virtual server application.
+	  It is good to set the table size not far less than the number of
+	  connections per second multiplying average lasting time of
+	  connection in the table.  For example, your virtual server gets 200
+	  connections per second, the connection lasts for 200 seconds in
+	  average in the connection table, the table size should be not far
+	  less than 200x200, it is good to set the table size 32768 (2**15).
 
 	  Another note that each connection occupies 128 bytes effectively and
 	  each hash entry uses 8 bytes, so you can estimate how much memory is
 	  needed for your box.
 
 	  You can overwrite this number setting conn_tab_bits module parameter
-	  or by appending ip_vs.conn_tab_bits=? to the kernel command line
-	  if IP VS was compiled built-in.
+	  or by appending ip_vs.conn_tab_bits=? to the kernel command line if
+	  IP VS was compiled built-in.
 
 comment "IPVS transport protocol load balancing support"
 
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index cb6d68220c26..3252d67b6df0 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1484,8 +1484,8 @@ int __init ip_vs_conn_init(void)
 	int idx;
 
 	/* Compute size and mask */
-	if (ip_vs_conn_tab_bits < 8 || ip_vs_conn_tab_bits > 20) {
-		pr_info("conn_tab_bits not in [8, 20]. Using default value\n");
+	if (ip_vs_conn_tab_bits < 8 || ip_vs_conn_tab_bits > 27) {
+		pr_info("conn_tab_bits not in [8, 27]. Using default value\n");
 		ip_vs_conn_tab_bits = CONFIG_IP_VS_TAB_BITS;
 	}
 	ip_vs_conn_tab_size = 1 << ip_vs_conn_tab_bits;
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index ceb38a7b37cb..41c9708b5057 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -405,6 +405,9 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
 
+	if (!nf_ct_helper_hash)
+		return -ENOENT;
+
 	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
 		return -EINVAL;
 
@@ -595,4 +598,5 @@ void nf_conntrack_helper_fini(void)
 {
 	nf_ct_extend_unregister(&helper_extend);
 	kvfree(nf_ct_helper_hash);
+	nf_ct_helper_hash = NULL;
 }
diff --git a/net/netfilter/nf_conntrack_proto_dccp.c b/net/netfilter/nf_conntrack_proto_dccp.c
index c1557d47ccd1..d4fd626d2b8c 100644
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -432,9 +432,19 @@ static bool dccp_error(const struct dccp_hdr *dh,
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
@@ -459,34 +469,70 @@ static bool dccp_error(const struct dccp_hdr *dh,
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
 	nf_l4proto_log_invalid(skb, state, IPPROTO_DCCP, "%s", msg);
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
 	if (!nf_ct_is_confirmed(ct) && !dccp_new(ct, skb, dh, state))
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
index 826bd961d90c..04b7c4e59520 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -581,6 +581,58 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 	return __nft_trans_set_add(ctx, msg_type, set, NULL);
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
+struct nft_set_elem_catchall {
+	struct list_head	list;
+	struct rcu_head		rcu;
+	void			*elem;
+};
+
+static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
+					struct nft_set *set)
+{
+	u8 genmask = nft_genmask_next(ctx->net);
+	struct nft_set_elem_catchall *catchall;
+	struct nft_set_elem elem;
+	struct nft_set_ext *ext;
+
+	list_for_each_entry(catchall, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+		if (!nft_set_elem_active(ext, genmask))
+			continue;
+
+		elem.priv = catchall->elem;
+		nft_setelem_data_deactivate(ctx->net, set, &elem);
+		break;
+	}
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
+
+	nft_map_catchall_deactivate(ctx, set);
+}
+
 static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	int err;
@@ -589,6 +641,9 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 	if (err < 0)
 		return err;
 
+	if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+		nft_map_deactivate(ctx, set);
+
 	nft_deactivate_next(ctx->net, set);
 	ctx->table->use--;
 
@@ -2478,7 +2533,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 					       const struct nft_table *table,
-					       const struct nlattr *nla)
+					       const struct nlattr *nla, u8 genmask)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	u32 id = ntohl(nla_get_be32(nla));
@@ -2489,7 +2544,8 @@ static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
 		    chain->table == table &&
-		    id == nft_trans_chain_id(trans))
+		    id == nft_trans_chain_id(trans) &&
+		    nft_active_genmask(chain, genmask))
 			return chain;
 	}
 	return ERR_PTR(-ENOENT);
@@ -3407,12 +3463,6 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 	return 0;
 }
 
-struct nft_set_elem_catchall {
-	struct list_head	list;
-	struct rcu_head		rcu;
-	void			*elem;
-};
-
 int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	u8 genmask = nft_genmask_next(ctx->net);
@@ -3483,7 +3533,8 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
+					      genmask);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -4734,7 +4785,7 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	for (i = 0; i < set->num_exprs; i++)
 		nft_expr_destroy(&ctx, set->exprs[i]);
 err_set_destroy:
-	ops->destroy(set);
+	ops->destroy(&ctx, set);
 err_set_init:
 	kfree(set->name);
 err_set_name:
@@ -4749,7 +4800,7 @@ static void nft_set_catchall_destroy(const struct nft_ctx *ctx,
 
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		list_del_rcu(&catchall->list);
-		nft_set_elem_destroy(set, catchall->elem, true);
+		nf_tables_set_elem_destroy(ctx, set, catchall->elem);
 		kfree_rcu(catchall, rcu);
 	}
 }
@@ -4764,7 +4815,7 @@ static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 	for (i = 0; i < set->num_exprs; i++)
 		nft_expr_destroy(ctx, set->exprs[i]);
 
-	set->ops->destroy(set);
+	set->ops->destroy(ctx, set);
 	nft_set_catchall_destroy(ctx, set);
 	kfree(set->name);
 	kvfree(set);
@@ -4925,10 +4976,60 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
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
+static void nft_map_catchall_activate(const struct nft_ctx *ctx,
+				      struct nft_set *set)
+{
+	u8 genmask = nft_genmask_next(ctx->net);
+	struct nft_set_elem_catchall *catchall;
+	struct nft_set_elem elem;
+	struct nft_set_ext *ext;
+
+	list_for_each_entry(catchall, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+		if (!nft_set_elem_active(ext, genmask))
+			continue;
+
+		elem.priv = catchall->elem;
+		nft_setelem_data_activate(ctx->net, set, &elem);
+		break;
+	}
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
+
+	nft_map_catchall_activate(ctx, set);
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
@@ -4943,17 +5044,26 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		nft_set_trans_unbind(ctx, set);
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
 
 		set->use--;
 		break;
 	case NFT_TRANS_PREPARE:
-		if (nft_set_is_anonymous(set))
-			nft_deactivate_next(ctx->net, set);
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
@@ -5669,6 +5779,7 @@ static void nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
 		__nft_set_elem_expr_destroy(ctx, expr);
 }
 
+/* Drop references and destroy. Called from gc, dynset and abort path. */
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr)
 {
@@ -5690,11 +5801,11 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
 
-/* Only called from commit path, nft_setelem_data_deactivate() already deals
- * with the refcounting from the preparation phase.
+/* Destroy element. References have been already dropped in the preparation
+ * path via nft_setelem_data_deactivate().
  */
-static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
-				       const struct nft_set *set, void *elem)
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem)
 {
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem);
 
@@ -9323,6 +9434,9 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DELSET:
 			trans->ctx.table->use++;
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
+			if (nft_trans_set(trans)->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_activate(&trans->ctx, nft_trans_set(trans));
+
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
@@ -9819,7 +9933,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 						 genmask);
 		} else if (tb[NFTA_VERDICT_CHAIN_ID]) {
 			chain = nft_chain_lookup_byid(ctx->net, ctx->table,
-						      tb[NFTA_VERDICT_CHAIN_ID]);
+						      tb[NFTA_VERDICT_CHAIN_ID],
+						      genmask);
 			if (IS_ERR(chain))
 				return PTR_ERR(chain);
 		} else {
@@ -10089,6 +10204,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	list_for_each_entry_safe(set, ns, &table->sets, list) {
 		list_del(&set->list);
 		table->use--;
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(&ctx, set);
+
 		nft_set_destroy(&ctx, set);
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
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
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index e7ae5914971e..60122539fee6 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -271,13 +271,14 @@ static int nft_bitmap_init(const struct nft_set *set,
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
index 76de6c8d9865..0b73cb0e752f 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -400,19 +400,31 @@ static int nft_rhash_init(const struct nft_set *set,
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
@@ -643,7 +655,8 @@ static int nft_hash_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_hash_destroy(const struct nft_set *set)
+static void nft_hash_destroy(const struct nft_ctx *ctx,
+			     const struct nft_set *set)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	struct nft_hash_elem *he;
@@ -653,7 +666,7 @@ static void nft_hash_destroy(const struct nft_set *set)
 	for (i = 0; i < priv->buckets; i++) {
 		hlist_for_each_entry_safe(he, next, &priv->table[i], node) {
 			hlist_del_rcu(&he->node);
-			nft_set_elem_destroy(set, he, true);
+			nf_tables_set_elem_destroy(ctx, set, he);
 		}
 	}
 }
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 78e1ec8badde..0452ee586c1c 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2152,10 +2152,12 @@ static int nft_pipapo_init(const struct nft_set *set,
 
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
@@ -2172,15 +2174,17 @@ static void nft_set_pipapo_match_destroy(const struct nft_set *set,
 
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
@@ -2190,7 +2194,7 @@ static void nft_pipapo_destroy(const struct nft_set *set)
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 #ifdef NFT_PIPAPO_ALIGN
 		free_percpu(m->scratch_aligned);
@@ -2207,7 +2211,7 @@ static void nft_pipapo_destroy(const struct nft_set *set)
 		m = priv->clone;
 
 		if (priv->dirty)
-			nft_set_pipapo_match_destroy(set, m);
+			nft_set_pipapo_match_destroy(ctx, set, m);
 
 #ifdef NFT_PIPAPO_ALIGN
 		free_percpu(priv->clone->scratch_aligned);
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 2f114aa10f1a..5c05c9b990fb 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -664,7 +664,8 @@ static int nft_rbtree_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_rbtree_destroy(const struct nft_set *set)
+static void nft_rbtree_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe;
@@ -675,7 +676,7 @@ static void nft_rbtree_destroy(const struct nft_set *set)
 	while ((node = priv->root.rb_node) != NULL) {
 		rb_erase(node, &priv->root);
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
-		nft_set_elem_destroy(set, rbe, true);
+		nf_tables_set_elem_destroy(ctx, set, rbe);
 	}
 }
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 46c4306ddee7..f41e130a812f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1610,6 +1610,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 {
 	struct netlink_set_err_data info;
+	unsigned long flags;
 	struct sock *sk;
 	int ret = 0;
 
@@ -1619,12 +1620,12 @@ int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
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
diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index d49d4bf2e37c..a81893bc06ce 100644
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
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 3c4172a5aeb5..5b8754ae7d3a 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -361,6 +361,7 @@ int nfc_llcp_send_symm(struct nfc_dev *dev)
 	struct sk_buff *skb;
 	struct nfc_llcp_local *local;
 	u16 size = 0;
+	int err;
 
 	pr_debug("Sending SYMM\n");
 
@@ -372,8 +373,10 @@ int nfc_llcp_send_symm(struct nfc_dev *dev)
 	size += dev->tx_headroom + dev->tx_tailroom + NFC_HEADER_SIZE;
 
 	skb = alloc_skb(size, GFP_KERNEL);
-	if (skb == NULL)
-		return -ENOMEM;
+	if (skb == NULL) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	skb_reserve(skb, dev->tx_headroom + NFC_HEADER_SIZE);
 
@@ -383,8 +386,11 @@ int nfc_llcp_send_symm(struct nfc_dev *dev)
 
 	nfc_llcp_send_to_raw_sock(local, skb, NFC_DIRECTION_TX);
 
-	return nfc_data_exchange(dev, local->target_idx, skb,
+	err = nfc_data_exchange(dev, local->target_idx, skb,
 				 nfc_llcp_recv, local);
+out:
+	nfc_llcp_local_put(local);
+	return err;
 }
 
 int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
@@ -394,7 +400,8 @@ int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
 	const u8 *service_name_tlv = NULL;
 	const u8 *miux_tlv = NULL;
 	const u8 *rw_tlv = NULL;
-	u8 service_name_tlv_length, miux_tlv_length,  rw_tlv_length, rw;
+	u8 service_name_tlv_length = 0;
+	u8 miux_tlv_length,  rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index fd43e75abd94..ddfd159f64e1 100644
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
@@ -610,12 +632,15 @@ u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
 
 	*general_bytes_len = local->gb_len;
 
+	nfc_llcp_local_put(local);
+
 	return local->gb;
 }
 
 int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 {
 	struct nfc_llcp_local *local;
+	int err;
 
 	if (gb_len < 3 || gb_len > NFC_MAX_GT_LEN)
 		return -EINVAL;
@@ -632,12 +657,16 @@ int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 
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
 
 static u8 nfc_llcp_dsap(const struct sk_buff *pdu)
@@ -1527,6 +1556,8 @@ int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb)
 
 	__nfc_llcp_recv(local, skb);
 
+	nfc_llcp_local_put(local);
+
 	return 0;
 }
 
@@ -1543,6 +1574,8 @@ void nfc_llcp_mac_is_down(struct nfc_dev *dev)
 
 	/* Close and purge all existing sockets */
 	nfc_llcp_socket_release(local, true, 0);
+
+	nfc_llcp_local_put(local);
 }
 
 void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
@@ -1568,6 +1601,8 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 		mod_timer(&local->link_timer,
 			  jiffies + msecs_to_jiffies(local->remote_lto));
 	}
+
+	nfc_llcp_local_put(local);
 }
 
 int nfc_llcp_register_device(struct nfc_dev *ndev)
@@ -1618,7 +1653,7 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 
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
index 9bc0ab759ea4..eb4f70a827e4 100644
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
index de2ec66d7e83..0b1e6466f4fb 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -52,6 +52,7 @@ int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len);
 u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len);
 int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
+int nfc_llcp_local_put(struct nfc_llcp_local *local);
 int __init nfc_llcp_init(void);
 void nfc_llcp_exit(void);
 void nfc_llcp_free_sdp_tlv(struct nfc_llcp_sdp_tlv *sdp);
diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index 2f3d507c24a1..ebd403f571ea 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -50,7 +50,7 @@ static int ipt_init_target(struct net *net, struct xt_entry_target *t,
 	par.entryinfo = &e;
 	par.target    = target;
 	par.targinfo  = t->data;
-	par.hook_mask = hook;
+	par.hook_mask = 1 << hook;
 	par.family    = NFPROTO_IPV4;
 
 	ret = xt_check_target(&par, t->u.target_size - sizeof(*t), 0, false);
@@ -87,7 +87,8 @@ static void tcf_ipt_release(struct tc_action *a)
 
 static const struct nla_policy ipt_policy[TCA_IPT_MAX + 1] = {
 	[TCA_IPT_TABLE]	= { .type = NLA_STRING, .len = IFNAMSIZ },
-	[TCA_IPT_HOOK]	= { .type = NLA_U32 },
+	[TCA_IPT_HOOK]	= NLA_POLICY_RANGE(NLA_U32, NF_INET_PRE_ROUTING,
+					   NF_INET_NUMHOOKS),
 	[TCA_IPT_INDEX]	= { .type = NLA_U32 },
 	[TCA_IPT_TARG]	= { .len = sizeof(struct xt_entry_target) },
 };
@@ -160,15 +161,27 @@ static int __tcf_ipt_init(struct net *net, unsigned int id, struct nlattr *nla,
 			return -EEXIST;
 		}
 	}
+
+	err = -EINVAL;
 	hook = nla_get_u32(tb[TCA_IPT_HOOK]);
+	switch (hook) {
+	case NF_INET_PRE_ROUTING:
+		break;
+	case NF_INET_POST_ROUTING:
+		break;
+	default:
+		goto err1;
+	}
+
+	if (tb[TCA_IPT_TABLE]) {
+		/* mangle only for now */
+		if (nla_strcmp(tb[TCA_IPT_TABLE], "mangle"))
+			goto err1;
+	}
 
-	err = -ENOMEM;
-	tname = kmalloc(IFNAMSIZ, GFP_KERNEL);
+	tname = kstrdup("mangle", GFP_KERNEL);
 	if (unlikely(!tname))
 		goto err1;
-	if (tb[TCA_IPT_TABLE] == NULL ||
-	    nla_strscpy(tname, tb[TCA_IPT_TABLE], IFNAMSIZ) >= IFNAMSIZ)
-		strcpy(tname, "mangle");
 
 	t = kmemdup(td, td->u.target_size, GFP_KERNEL);
 	if (unlikely(!t))
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index e77da0545b55..df9ff123a7ee 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -29,6 +29,7 @@ static struct tc_action_ops act_pedit_ops;
 
 static const struct nla_policy pedit_policy[TCA_PEDIT_MAX + 1] = {
 	[TCA_PEDIT_PARMS]	= { .len = sizeof(struct tc_pedit) },
+	[TCA_PEDIT_PARMS_EX]	= { .len = sizeof(struct tc_pedit) },
 	[TCA_PEDIT_KEYS_EX]   = { .type = NLA_NESTED },
 };
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index ee137d5c20a4..bff0a5f24aca 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -784,6 +784,16 @@ static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
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
index 8654b0ce997c..ea52c320f67c 100644
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
index 4c51aeb78f14..905c86b50215 100644
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
index 2bbc81ddb9e0..f10ad80fd694 100644
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
@@ -8287,6 +8287,22 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
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
@@ -9655,6 +9671,7 @@ struct proto sctp_prot = {
 	.shutdown    =	sctp_shutdown,
 	.setsockopt  =	sctp_setsockopt,
 	.getsockopt  =	sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg     =	sctp_sendmsg,
 	.recvmsg     =	sctp_recvmsg,
 	.bind        =	sctp_bind,
@@ -9707,6 +9724,7 @@ struct proto sctpv6_prot = {
 	.shutdown	= sctp_shutdown,
 	.setsockopt	= sctp_setsockopt,
 	.getsockopt	= sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg	= sctp_sendmsg,
 	.recvmsg	= sctp_recvmsg,
 	.bind		= sctp_bind,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6fc7a8c52369..be7081284a09 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -685,12 +685,6 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
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
@@ -699,13 +693,18 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
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
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 3ad4291148a6..0377679678f9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -791,6 +791,12 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	struct svc_rdma_recv_ctxt *ctxt;
 	int ret;
 
+	/* Prevent svc_xprt_release() from releasing pages in rq_pages
+	 * when returning 0 or an error.
+	 */
+	rqstp->rq_respages = rqstp->rq_pages;
+	rqstp->rq_next_page = rqstp->rq_respages;
+
 	rqstp->rq_xprt_ctxt = NULL;
 
 	ctxt = NULL;
@@ -814,12 +820,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 				   DMA_FROM_DEVICE);
 	svc_rdma_build_arg_xdr(rqstp, ctxt);
 
-	/* Prevent svc_xprt_release from releasing pages in rq_pages
-	 * if we return 0 or an error.
-	 */
-	rqstp->rq_respages = rqstp->rq_pages;
-	rqstp->rq_next_page = rqstp->rq_respages;
-
 	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
 	if (ret < 0)
 		goto out_err;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index ef31e401d791..a565476809f0 100644
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
 
@@ -2180,7 +2215,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 			new_ie_len = cfg80211_gen_new_ie(ie, ielen,
 							 profile,
 							 profile_len, new_ie,
-							 gfp);
+							 IEEE80211_MAX_DATA_LEN);
 			if (!new_ie_len)
 				continue;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 330dd498fc61..e80e3fcbb8e8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -893,6 +893,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct net_device *dev;
+	int bound_dev_if;
 	u32 flags, qid;
 	int err = 0;
 
@@ -906,6 +907,10 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
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
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index ce9661d968a3..47f047458264 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -23,7 +23,7 @@ modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 
 quiet_cmd_cc_o_c = CC [M]  $@
-      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI), $(c_flags)) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), $(c_flags)) -c -o $@ $<
 
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b284ee01fdeb..c6e655e0ed98 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1302,6 +1302,10 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 	if (relsym->st_name != 0)
 		return relsym;
 
+	/*
+	 * Strive to find a better symbol name, but the resulting name may not
+	 * match the symbol referenced in the original code.
+	 */
 	relsym_secindex = get_secindex(elf, relsym);
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != relsym_secindex)
@@ -1606,49 +1610,12 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 static int is_executable_section(struct elf_info* elf, unsigned int section_index)
 {
-	if (section_index > elf->num_sections)
+	if (section_index >= elf->num_sections)
 		fatal("section_index is outside elf->num_sections!\n");
 
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
 }
 
-/*
- * We rely on a gross hack in section_rel[a]() calling find_extable_entry_size()
- * to know the sizeof(struct exception_table_entry) for the target architecture.
- */
-static unsigned int extable_entry_size = 0;
-static void find_extable_entry_size(const char* const sec, const Elf_Rela* r)
-{
-	/*
-	 * If we're currently checking the second relocation within __ex_table,
-	 * that relocation offset tells us the offsetof(struct
-	 * exception_table_entry, fixup) which is equal to sizeof(struct
-	 * exception_table_entry) divided by two.  We use that to our advantage
-	 * since there's no portable way to get that size as every architecture
-	 * seems to go with different sized types.  Not pretty but better than
-	 * hard-coding the size for every architecture..
-	 */
-	if (!extable_entry_size)
-		extable_entry_size = r->r_offset * 2;
-}
-
-static inline bool is_extable_fault_address(Elf_Rela *r)
-{
-	/*
-	 * extable_entry_size is only discovered after we've handled the
-	 * _second_ relocation in __ex_table, so only abort when we're not
-	 * handling the first reloc and extable_entry_size is zero.
-	 */
-	if (r->r_offset && extable_entry_size == 0)
-		fatal("extable_entry size hasn't been discovered!\n");
-
-	return ((r->r_offset == 0) ||
-		(r->r_offset % extable_entry_size == 0));
-}
-
-#define is_second_extable_reloc(Start, Cur, Sec)			\
-	(((Cur) == (Start) + 1) && (strcmp("__ex_table", (Sec)) == 0))
-
 static void report_extable_warnings(const char* modname, struct elf_info* elf,
 				    const struct sectioncheck* const mismatch,
 				    Elf_Rela* r, Elf_Sym* sym,
@@ -1705,22 +1672,9 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 		      "You might get more information about where this is\n"
 		      "coming from by using scripts/check_extable.sh %s\n",
 		      fromsec, (long)r->r_offset, tosec, modname);
-	else if (!is_executable_section(elf, get_secindex(elf, sym))) {
-		if (is_extable_fault_address(r))
-			fatal("The relocation at %s+0x%lx references\n"
-			      "section \"%s\" which is not executable, IOW\n"
-			      "it is not possible for the kernel to fault\n"
-			      "at that address.  Something is seriously wrong\n"
-			      "and should be fixed.\n",
-			      fromsec, (long)r->r_offset, tosec);
-		else
-			fatal("The relocation at %s+0x%lx references\n"
-			      "section \"%s\" which is not executable, IOW\n"
-			      "the kernel will fault if it ever tries to\n"
-			      "jump to it.  Something is seriously wrong\n"
-			      "and should be fixed.\n",
-			      fromsec, (long)r->r_offset, tosec);
-	}
+	else if (!is_executable_section(elf, get_secindex(elf, sym)))
+		error("%s+0x%lx references non-executable section '%s'\n",
+		      fromsec, (long)r->r_offset, tosec);
 }
 
 static void check_section_mismatch(const char *modname, struct elf_info *elf,
@@ -1781,19 +1735,33 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
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
@@ -1871,8 +1839,6 @@ static void section_rela(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		if (is_second_extable_reloc(start, rela, fromsec))
-			find_extable_entry_size(fromsec, &r);
 		check_section_mismatch(modname, elf, &r, sym, fromsec);
 	}
 }
@@ -1931,8 +1897,6 @@ static void section_rel(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		if (is_second_extable_reloc(start, rel, fromsec))
-			find_extable_entry_size(fromsec, &r);
 		check_section_mismatch(modname, elf, &r, sym, fromsec);
 	}
 }
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index d5b3a062d1d1..5f758b289ace 100644
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
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b862f0f919bf..99c7452555c3 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -40,7 +40,7 @@ static const char evm_hmac[] = "hmac(sha1)";
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
  * @key: pointer to a buffer with the key data
- * @size: length of the key data
+ * @keylen: length of the key data
  *
  * This function allows setting the EVM HMAC key from the kernel
  * without using the "encrypted" key subsystem keys. It can be used
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 7d87772f0ce6..b0e791e18432 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -324,7 +324,6 @@ int evm_protected_xattr_if_enabled(const char *req_xattr_name)
 /**
  * evm_read_protected_xattrs - read EVM protected xattr names, lengths, values
  * @dentry: dentry of the read xattrs
- * @inode: inode of the read xattrs
  * @buffer: buffer xattr names, lengths or values are copied to
  * @buffer_size: size of buffer
  * @type: n: names, l: lengths, v: values
@@ -396,6 +395,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
  * @xattr_value_len: requested xattr value length
+ * @iint: inode integrity metadata
  *
  * Calculate the HMAC for the given dentry and verify it against the stored
  * security.evm xattr. For performance, use the xattr value and length
@@ -770,7 +770,9 @@ static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
 
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
+ * @attr: iattr structure containing the new file attributes
  *
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..65418e0906c1 100644
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
index ed43d30682ff..7e41917e1f76 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -674,6 +674,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @secid: LSM secid of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
@@ -1709,7 +1710,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
- * @rule - ima measurement policy rule
+ * @rule: ima measurement policy rule
  *
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 88493cc31914..03d155ed362b 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -654,6 +654,7 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	struct snd_jack_kctl *jack_kctl;
 	unsigned int mask_bits = 0;
 #ifdef CONFIG_SND_JACK_INPUT_DEV
+	struct input_dev *idev;
 	int i;
 #endif
 
@@ -670,17 +671,15 @@ void snd_jack_report(struct snd_jack *jack, int status)
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
 		int testbit = ((SND_JACK_BTN_0 >> i) & ~mask_bits);
 
 		if (jack->type & testbit)
-			input_report_key(jack->input_dev, jack->key[i],
+			input_report_key(idev, jack->key[i],
 					 status & testbit);
 	}
 
@@ -688,13 +687,13 @@ void snd_jack_report(struct snd_jack *jack, int status)
 		int testbit = ((1 << i) & ~mask_bits);
 
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
index ceead55f13ab..58ae0c3ce1e4 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2070,8 +2070,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
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
index 22f0d1b359f0..f22c6387adbd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9242,6 +9242,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x971d, "Clevo N970T[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL5[03]RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index afd6d401e3d0..b36ccfc54cd6 100644
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
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index a364e2415de0..d991e457060c 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -228,6 +228,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 
 		dai_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
 					  fe_name_pref, args.np->full_name + 1);
+		if (!dai_name)
+			return -ENOMEM;
 
 		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
 
@@ -236,6 +238,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 			capture_dai_name =
 				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
 					       dai_name, "CPU-Capture");
+			if (!capture_dai_name)
+				return -ENOMEM;
 		}
 
 		priv->dai[i].cpus = &dlc[0];
@@ -266,6 +270,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 				       "AUDMIX-Playback-%d", i);
 		be_cp = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 				       "AUDMIX-Capture-%d", i);
+		if (!be_name || !be_pb || !be_cp)
+			return -ENOMEM;
 
 		priv->dai[num_dai + i].cpus = &dlc[3];
 		priv->dai[num_dai + i].codecs = &dlc[4];
@@ -293,6 +299,9 @@ static int imx_audmix_probe(struct platform_device *pdev)
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
index 8092506facbd..b8b5038d1be1 100644
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
index 7f36385aa9e2..0c9544c6d302 100644
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
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index b9987c3efa3c..956b57d02eb9 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -72,16 +72,21 @@
 /*
  * Helper macros to manipulate data structures
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
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 98cb3831aa18..b91dd7cd4ffb 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2126,9 +2126,25 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
 					     const struct btf_type *t,
 					     __u32 id,
 					     const void *data,
-					     __u8 bits_offset)
+					     __u8 bits_offset,
+					     __u8 bit_sz)
 {
-	__s64 size = btf__resolve_size(d->btf, id);
+	__s64 size;
+
+	if (bit_sz) {
+		/* bits_offset is at most 7. bit_sz is at most 128. */
+		__u8 nr_bytes = (bits_offset + bit_sz + 7) / 8;
+
+		/* When bit_sz is non zero, it is called from
+		 * btf_dump_struct_data() where it only cares about
+		 * negative error value.
+		 * Return nr_bytes in success case to make it
+		 * consistent as the regular integer case below.
+		 */
+		return data + nr_bytes > d->typed_dump->data_end ? -E2BIG : nr_bytes;
+	}
+
+	size = btf__resolve_size(d->btf, id);
 
 	if (size < 0 || size >= INT_MAX) {
 		pr_warn("unexpected size [%zu] for id [%u]\n",
@@ -2281,7 +2297,7 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 {
 	int size, err = 0;
 
-	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset);
+	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bit_sz);
 	if (size < 0)
 		return size;
 	err = btf_dump_type_data_check_zero(d, t, id, data, bits_offset, bit_sz);
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index d0895162c2ba..ac72bcccc353 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -21,6 +21,7 @@
 #include "builtin.h"
 #include "bench/bench.h"
 
+#include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -226,7 +227,6 @@ static void run_collection(struct collection *coll)
 		if (!bench->fn)
 			break;
 		printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
-		fflush(stdout);
 
 		argv[1] = bench->name;
 		run_bench(coll->name, bench->name, bench->fn, 1, argv);
@@ -247,6 +247,10 @@ int cmd_bench(int argc, const char **argv)
 	struct collection *coll;
 	int ret = 0;
 
+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+	setlocale(LC_ALL, "");
+
 	if (argc < 2) {
 		/* No collection specified. */
 		print_usage();
@@ -300,7 +304,6 @@ int cmd_bench(int argc, const char **argv)
 
 			if (bench_format == BENCH_FORMAT_DEFAULT)
 				printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
-			fflush(stdout);
 			ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
 			goto end;
 		}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c6c40191933d..34e809c934d7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2260,6 +2260,9 @@ static int process_sample_event(struct perf_tool *tool,
 	return ret;
 }
 
+// Used when scr->per_event_dump is not set
+static struct evsel_script es_stdout;
+
 static int process_attr(struct perf_tool *tool, union perf_event *event,
 			struct evlist **pevlist)
 {
@@ -2268,7 +2271,6 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct evsel *evsel, *pos;
 	u64 sample_type;
 	int err;
-	static struct evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -2278,14 +2280,13 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evsel = evlist__last(*pevlist);
 
 	if (!evsel->priv) {
-		if (scr->per_event_dump) {
+		if (scr->per_event_dump) { 
 			evsel->priv = evsel_script__new(evsel, scr->session->data);
-		} else {
-			es = zalloc(sizeof(*es));
-			if (!es)
+			if (!evsel->priv)
 				return -ENOMEM;
-			es->fp = stdout;
-			evsel->priv = es;
+		} else { // Replicate what is done in perf_script__setup_per_event_dump()
+			es_stdout.fp = stdout;
+			evsel->priv = &es_stdout;
 		}
 	}
 
@@ -2591,7 +2592,6 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 static int perf_script__setup_per_event_dump(struct perf_script *script)
 {
 	struct evsel *evsel;
-	static struct evsel_script es_stdout;
 
 	if (script->per_event_dump)
 		return perf_script__fopen_per_event_dump(script);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index da7dc5e45d0c..4d6d3e314200 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -828,6 +828,9 @@ int cmd_test(int argc, const char **argv)
         if (ret < 0)
                 return ret;
 
+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 623527edeac1..b125eaadcec4 100644
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
diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
index 012068f33a0a..871971cdd7b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -197,7 +197,7 @@ static void test_check_mtu_tc(__u32 mtu, __u32 ifindex)
 
 void test_check_mtu(void)
 {
-	__u32 mtu_lo;
+	int mtu_lo;
 
 	if (test__start_subtest("bpf_check_mtu XDP-attach"))
 		test_check_mtu_xdp_attach();
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index f7d33a16051c..3f9e540fee57 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -6,6 +6,7 @@ CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_VETH=y
 CONFIG_NET_SCH_NETEM=m
+CONFIG_SYN_COOKIES=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 89a53aa0ab9d..d5c79e4a8f1e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -119,6 +119,7 @@ check_mark()
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			ret=1
 			return 1
 		fi
 	done
@@ -213,11 +214,11 @@ do_transfer()
 	fi
 
 	if [ $local_addr = "::" ];then
-		check_mark $listener_ns 6
-		check_mark $connector_ns 6
+		check_mark $listener_ns 6 || retc=1
+		check_mark $connector_ns 6 || retc=1
 	else
-		check_mark $listener_ns 4
-		check_mark $connector_ns 4
+		check_mark $listener_ns 4 || retc=1
+		check_mark $connector_ns 4 || retc=1
 	fi
 
 	check_transfer $cin $sout "file received by server"
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
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
index f57720c52c0f..84f6bb98ce99 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -5,4 +5,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
-tree.use_softirq=0
+rcutree.use_softirq=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index 64f864f1f361..8e50bfd4b710 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -4,4 +4,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
-tree.use_softirq=0
+rcutree.use_softirq=0
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 15dcee16ff72..38d46a8bf7cb 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -84,12 +84,12 @@ static inline int vdso_test_clock(unsigned int clock_id)
 
 int main(int argc, char **argv)
 {
-	int ret;
+	int ret = 0;
 
 #if _POSIX_TIMERS > 0
 
 #ifdef CLOCK_REALTIME
-	ret = vdso_test_clock(CLOCK_REALTIME);
+	ret += vdso_test_clock(CLOCK_REALTIME);
 #endif
 
 #ifdef CLOCK_BOOTTIME
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
