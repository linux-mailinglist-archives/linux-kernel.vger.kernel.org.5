Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F280A84D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573832AbjLHQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjLHQMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:12:49 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD91985;
        Fri,  8 Dec 2023 08:12:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70EC820016;
        Fri,  8 Dec 2023 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702051973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=teHJUSCBCGpkoHDcgROECyXoWTtx2qAUTOMUinH7J78=;
        b=HAGejE4uH9xUq9HnSzerpzLeS6bVkuWG2bjpdTIFrAUsr58vFE7CRuXnM2auuqAN4yzb4C
        WXYMF3DPbSJYqiqC+rwHPF/gICuAzGqMVUw/D000YUw9oeYVIrDfXuhZL5HZAMk9sjCaq9
        0R21Lfbb/24ZJtCzthB8509HjzgtQUGcSdToEZ81LwgZ3zaGdD0pNHFLGzFj1rZ1MWm/Ku
        OB0mowveJfmvW+w8ROfWVw6Spt18sEOsQ5kzN0b8p/kDU+kTWa231G7qvwjiWIa7VFQ0H9
        YhrfT/2mhsyJvy9nixjBM5ISbGJnfaMGpkCr5LK1RLHZ+S2HOE5eoRl3krPFUQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v4 00/22] Add support for the Mobileye EyeQ5 SoC
Date:   Fri,  8 Dec 2023 17:12:16 +0100
Message-ID: <20231208161249.1827174-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
and features multiple controllers such as the classic UART, I2C, SPI,
as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
Security Module, Functional Safety Hardware, and MJPEG encoder.

One peculiarity of this SoC is that the physical address of the DDDR
exceeds 32 bits. Given that the architecture is 64 bits, this is not
an issue, but it requires some changes in how the mips64 is currently
managed during boot.

In this forth version there are now minor changes, mainly fixes for
warning during build reported by build bot or find by myself when
testing the mips32 build. I also made some modification in the
/board-eyeq5.config and thanks to the setting of SPARSMEM I don't have
any more the error message during boot when using low memory at
0x40000000.

To build and test the kernel, we need to run the following commands:

make 64r6el_defconfig BOARDS=eyeq5
make vmlinuz.itb

Changelog:

 v3 -> v4:

 - Fix build warning in "MIPS: Get rid of CONFIG_NO_EXCEPT_FILL":
   check that we are in 64bit mode before using KSEG0 that exist only
   in this mode.

 - Modify "MIPS: spaces: Define a couple of handy macros" to be
   buildable in 32bit mode.

 - Use correct format specifier to print address in "MIPS: traps: Give
   more explanations if ebase doesn't belong to KSEG0"

 - In "MIPS: generic: Add support for Mobileye EyeQ5",remove
   CONFIG_ZBOOT_LOAD_ADDRESS from board-eyeq5.config, (as well as
   CONFIG_USE_XKPHYS that does not exist anymore) and add
   CONFIG_SPARSEMEM_MANUAL to enable SPRASMEM.

v2 -> v3

 - Added more reviewed-by and acked-by tags

 - Fix sorting for cpus entries in

 - Fix indentation issue in Documentation/devicetree/bindings/mips/mobileye.yaml

 v1 -> v2

 - Added reviewed-by and acked-by tags

 - Fix typos reported

 - In patch 15 use 'img' vendor string instead of mti

 - In patch 16 modify licence

 - In patch 17 give more explanations about the block usage.

 - In patch 18, remove _ in node names, don't use anymore
   CONFIG_BUILTIN_DTB in Makefile, remove macro, modify licence.

 - In patch 19 remove most of the bootargs and only keeps earlycon. I
   also split the memory in 2 part in the device tree.

 - Integrate the series from Jiaxun Yang
   https://lore.kernel.org/linux-mips/20231027221106.405666-1-jiaxun.yang@flygoat.com/

  They are patches 2 to 6 and 8 to 12

  Then I added patch 7 to fix the cache issue visible on the Mobileye
  platform, I also add patch 13 to improve warning message when ebase
  doesn't belong to KSEG0

Regards,

Gregory

Gregory CLEMENT (13):
  MIPS: compressed: Use correct instruction for 64 bit code
  MIPS: spaces: Define a couple of handy macros
  MIPS: Fix cache issue with mips_cps_core_entry
  MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
  dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
  dt-bindings: mips: cpus: Sort the entries
  dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
  dt-bindings: mips: Add bindings for Mobileye SoCs
  dt-bindings: mfd: syscon: Document EyeQ5 OLB
  MIPS: mobileye: Add EyeQ5 dtsi
  MIPS: mobileye: Add EPM5 device tree
  MIPS: generic: Add support for Mobileye EyeQ5
  MAINTAINERS: Add entry for Mobileye MIPS SoCs

Jiaxun Yang (9):
  MIPS: Export higher/highest relocation functions in uasm
  MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
  MIPS: Fix set_uncached_handler for ebase in XKPHYS
  MIPS: Refactor mips_cps_core_entry implementation
  MIPS: Allow kernel base to be set from Kconfig for all platforms
  MIPS: traps: Handle CPU with non standard vint offset
  MIPS: Avoid unnecessary reservation of exception space
  MIPS: traps: Enhance memblock ebase allocation process
  MIPS: Get rid of CONFIG_NO_EXCEPT_FILL

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../devicetree/bindings/mips/cpus.yaml        |  13 +-
 .../devicetree/bindings/mips/mobileye.yaml    |  32 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  12 +
 arch/mips/Kconfig                             |  26 +-
 arch/mips/boot/compressed/head.S              |   4 +-
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/mobileye/Makefile          |   4 +
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts    |  24 ++
 .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 292 ++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 134 ++++++++
 arch/mips/configs/generic/board-eyeq5.config  |  41 +++
 arch/mips/generic/Kconfig                     |  15 +
 arch/mips/generic/Platform                    |   2 +
 arch/mips/generic/board-epm5.its.S            |  24 ++
 arch/mips/include/asm/addrspace.h             |   5 +
 arch/mips/include/asm/mach-generic/spaces.h   |   2 +
 arch/mips/include/asm/mips-cm.h               |   1 +
 arch/mips/include/asm/smp-cps.h               |   4 +-
 arch/mips/include/asm/traps.h                 |   1 -
 arch/mips/include/asm/uasm.h                  |   2 +
 arch/mips/kernel/cps-vec.S                    | 110 +++----
 arch/mips/kernel/cpu-probe.c                  |   5 -
 arch/mips/kernel/cpu-r3k-probe.c              |   2 -
 arch/mips/kernel/genex.S                      |  19 +-
 arch/mips/kernel/head.S                       |   7 +-
 arch/mips/kernel/smp-cps.c                    | 171 ++++++++--
 arch/mips/kernel/traps.c                      |  90 ++++--
 arch/mips/mm/uasm.c                           |   6 +-
 30 files changed, 893 insertions(+), 159 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
 create mode 100644 arch/mips/boot/dts/mobileye/Makefile
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
 create mode 100644 arch/mips/configs/generic/board-eyeq5.config
 create mode 100644 arch/mips/generic/board-epm5.its.S

-- 
2.42.0

