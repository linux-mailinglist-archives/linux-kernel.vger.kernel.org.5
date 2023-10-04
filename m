Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF07B848D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbjJDQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJDQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:10:52 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C54ED9;
        Wed,  4 Oct 2023 09:10:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A1421C0002;
        Wed,  4 Oct 2023 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U5+AU/guihP12spMQvepguwSEV/btZcH3Vlyui9M9yU=;
        b=TZVxAZrgS4Rc+Z7A4TfV0crPfqSJWJjtLQXSQ32w+yAwshW3S7nTzoyVaZ/JJw+90tVFSX
        gEANXAAPvq06ngxNodPEf+aX1CoiOt8JovRKZh7kNGMlbNxD11YT4Hu12Bhhw7tntyR9hz
        QHHRTxdLrXT7tWUHwnrdyZvGZqCDA1eObdE4Aj6Fjc4M5pcApL9krUelG4iBix1LB7xhoQ
        FZVsJK5wOw/bE08U1gSAY3DyVE8+1Z0mw/MyPsIUM2KawwoQhsDfyLQsCK4l2tSjhaenTQ
        ADoHb7FMNW1pHFJ2/a8a3l6P/hLyo91hV1sSwGegAX/UZtFsF2Vscf0b/GJotw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 00/11] Add support for the Mobileye EyeQ5 SoC
Date:   Wed,  4 Oct 2023 18:10:27 +0200
Message-Id: <20231004161038.2818327-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

With the second patch, we enable the use of xphys instead of the
legacy kesg0 and kseg1. However, the vector reset remains 32 bits. So
the third patch allows the use of aliasing to map the vector address
using a 32-bit pointer.

While working on it, we found that there was an issue in the way the
assembly code managed kernel uncompression. While most of the head.S
file uses macros to employ the correct instruction depending on
whether it's in 32 or 64 bits, one was missing. Fixing it is the
purpose of the first patch.

Then the following 4 patches document the bindings that will be used
for the device tree of the SoC submitted by patch 7.

In addition to the SoC support, patch 8 adds support for the
evaluation board.

Finally, patch 10 adds support to build the kernel image for the EyeQ5
SoC and board, not only the Kconfig and Makefile infrastructure but
also an ITS file and a default configuration. To build and test the
kernel, we need to run the following commands:

make 64r6el_defconfig BOARDS=eyeq5
make vmlinuz.itb

And then from U-Boot
bootm ${vmlinuz.itb_addr}#conf-1

Gregory

Gregory CLEMENT (9):
  MIPS: compressed: Use correct instruction for 64 bit code
  dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
  dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
  dt-bindings: mips: Add bindings for Mobileye SoCs
  dt-bindings: mfd: syscon: Document EyeQ5 OLB
  MIPS: mobileye: Add EyeQ5 dtsi
  MIPS: mobileye: Add EPM5 device tree
  MIPS: generic: Add support for Mobileye EyeQ5
  MAINTAINERS: Add entry for Mobileye MIPS SoCs

Vladimir Kondratiev (2):
  MIPS: use virtual addresses from xkphys for MIPS64
  MIPS: support RAM beyond 32-bit

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../devicetree/bindings/mips/cpus.yaml        |   1 +
 .../devicetree/bindings/mips/mobileye.yaml    |  36 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  12 +
 arch/mips/Kconfig                             |  15 +
 arch/mips/Makefile                            |   4 +
 arch/mips/boot/compressed/head.S              |   4 +-
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/mobileye/Makefile          |   6 +
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts    |  24 ++
 .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 315 ++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 138 ++++++++
 arch/mips/configs/generic/board-eyeq5.config  |  42 +++
 arch/mips/generic/Kconfig                     |  14 +
 arch/mips/generic/Platform                    |   7 +
 arch/mips/generic/board-epm5.its.S            |  24 ++
 arch/mips/include/asm/addrspace.h             |  12 +-
 arch/mips/include/asm/mips-cm.h               |   1 +
 arch/mips/include/asm/page.h                  |  10 +
 arch/mips/include/asm/vga.h                   |   4 +
 arch/mips/kernel/cps-vec.S                    |   8 +
 arch/mips/kernel/genex.S                      |  14 +
 arch/mips/kernel/smp-cps.c                    |  47 ++-
 arch/mips/kernel/traps.c                      |  32 +-
 arch/mips/lib/uncached.c                      |  10 +
 arch/mips/mm/init.c                           |   4 +-
 include/dt-bindings/soc/mobileye,eyeq5.h      |  77 +++++
 28 files changed, 847 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
 create mode 100644 arch/mips/boot/dts/mobileye/Makefile
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
 create mode 100644 arch/mips/configs/generic/board-eyeq5.config
 create mode 100644 arch/mips/generic/board-epm5.its.S
 create mode 100644 include/dt-bindings/soc/mobileye,eyeq5.h

-- 
2.40.1

