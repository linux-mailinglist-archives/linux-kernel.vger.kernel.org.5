Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B820D800990
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378512AbjLALPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378475AbjLALPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:15:19 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7C1B2;
        Fri,  1 Dec 2023 03:15:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 420B71C0004;
        Fri,  1 Dec 2023 11:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701429322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4imsoNotdCY9kpBwQ1K6ybkxBX5vA3o4lFD6+R+1ft4=;
        b=N8HfEVAf50Nq7BZnY9kfsTYlgt4koQNK4FTPx+aaqu0yEt9V94CP51O/Xjn9jRYS12H6ix
        +Mbcjzox9UdKl3AzQ7I9rjshWPK9cZ7EWuiUVOpghkqa/MMhDYG9p7v+wAkryb6zokEk7B
        HkEmv6MptCwILz7flJbOHQWvjI0p+qtLsamokxexGHGkHy+q3ej0CNHNSHy8jqDB1nReHm
        6/hQjLpBq1a0VP0R8ZrXMQWcGVcppMVDfpSowvGWPnMDdTonxZrofs17XmkzfUAfFhWfLv
        BJuRCh8qsGmrRVhCG9Mxi4jl7KPxkQyVRQ4Fsm4v25RySjE7brdB73yYpUi0CQ==
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
Subject: [PATCH v3 00/22] Add support for the Mobileye EyeQ5 SoC
Date:   Fri,  1 Dec 2023 12:14:43 +0100
Message-ID: <20231201111512.803120-1-gregory.clement@bootlin.com>
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

In this third version there are only few changes done in the device
tree related part. I however managed to test this series on top of the
Jiaxun patches enabling SPARSMEM[1], and it fixed my issue about memory
consumption for memmap.

To build and test the kernel, we need to run the following commands:

make 64r6el_defconfig BOARDS=eyeq5
make vmlinuz.itb

I noticed that if the kernel can't be in kseg0 at all by using
low memory at 0x40000000, then I got the following message during
boot:

 Run /init as init process
 Unhandled kernel unaligned access[#1]:
 CPU: 0 PID: 22 Comm: kcompactd0 Not tainted 6.7.0-rc1-00024-g7d48f10cb2bb-dirty #409
 $ 0   : 0000000000000000 0000000000000001 0000000000000010 a80000080800e100
 $ 4   : a8000008088fe758 00000000088fe758 0000000000000004 0000000000000002
 $ 8   : 0000000000000089 0000000008fa0000 0000000000000000 0000000008ad0000
 $12   : 00000000140000e1 000000001000001e 0000000000000000 0000000000000141
 $16   : a80000080321fa30 0000000000000000 b88f553ba6dfc404 a8000008081bfe9c
 $20   : a800000808ad0000 a8000008081c03e4 0000000000012488 a80000080907afb4
 $24   : 0000000000000000 0000000008ad0000                                  
 $28   : a80000080321c000 a80000080321f950 0000000000000000 a80000080800dcd0
 epc   : a80000080800e104 emulate_load_store_insn+0x544/0xba0
 ra    : a80000080800dcd0 emulate_load_store_insn+0x110/0xba0
 Status: 140000e3 KX SX UX KERNEL EXL IE 
 Cause : 80800410 (ExcCode 04)
 BadVA : b88f553ba6dfc40b
 PrId  : 0001b028 (MIPS I6500)
 Modules linked in:
 Process kcompactd0 (pid: 22, threadinfo=(____ptrval____), task=(____ptrval____), tls=0000000000000000)
 Stack : 0000000000000000 0000000000000000 00000000dc420010 a8afa5b0e1346800
         0000000000012488 a80000080907af80 a80000080321fd28 a800000808acfb80
         a800000808ad0000 0000000000000000 a80000080321fa30 a80000080800e90c
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 a8afa5b0e1346800 0000000000000000 a80000080907afb4
         0000000000012488 a80000080907af80 a80000080321fd28 a800000809078d80
         0000000000000000 0000000000000000 0000000000000000 a800000808003174
         0000000000000000 0000000000000001 b88f553ba6dfc3f4 f91f7fb9d6d87a3d
         0000000000000002 fffffffffffffffc 0000000000000080 0000000008b90000
         0000000000000089 0000000008fc0000 0000000000000000 0000000000000000
         ...
 Call Trace:
 [<a80000080800e104>] emulate_load_store_insn+0x544/0xba0
 [<a80000080800e90c>] do_ade+0x1ac/0x1520
 [<a800000808003174>] handle_adel_int+0x30/0x3c
 
 Code: 3c03a800  cbffff4d  24020010 <205100f0> 82510007  92410006  00118a38  02218825  92410005 
 
 ---[ end trace 0000000000000000 ]---

But then I don't see other error when running the system.
So I don't know if this is a "real" error and how to fix it.

Changelog:
 v2 -> v3

 - Add more reviewed-by and acked-by tags

 - Fix sorting for cpus entries in Documentation/devicetree/bindings/mips/cpus.yaml

 - Fix indentation issue in Documentation/devicetree/bindings/mips/mobileye.yaml

 - Move gic node under soc node in arch/mips/boot/dts/mobileye/eyeq5.dtsi

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

[1]: https://lore.kernel.org/linux-mips/20231028-mm-v1-0-45377cd158cf@flygoat.com/

Gregory CLEMENT (12):
  MIPS: compressed: Use correct instruction for 64 bit code
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

Jiaxun Yang (10):
  MIPS: Export higher/highest relocation functions in uasm
  MIPS: spaces: Define a couple of handy macros
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
 arch/mips/configs/generic/board-eyeq5.config  |  43 +++
 arch/mips/generic/Kconfig                     |  15 +
 arch/mips/generic/Platform                    |   2 +
 arch/mips/generic/board-epm5.its.S            |  24 ++
 arch/mips/include/asm/addrspace.h             |   5 +
 arch/mips/include/asm/mach-generic/spaces.h   |   5 +-
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
 30 files changed, 896 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
 create mode 100644 arch/mips/boot/dts/mobileye/Makefile
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
 create mode 100644 arch/mips/configs/generic/board-eyeq5.config
 create mode 100644 arch/mips/generic/board-epm5.its.S

-- 
2.42.0

