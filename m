Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1377317E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjHGVqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHGVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:46:15 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2410CF;
        Mon,  7 Aug 2023 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=fuPTYKnBJKOXKnQ4H+uGsiph8wLAETrQseBXpkUnoJY=; b=hcSqiDTXaSkO3RD/mkjqcwBXf3
        aYQ5iGy/MQCxSUMuepXIQh3cVQ8gzuvA75p6Dv5sYULdfOPHrP5JCUEGTdYjF31u0+t+tbnVvJB3N
        t4XfBwB8zrSE7RosWi7eBXPNDN2KdmVGpSovzsm3Zv3ILEtIk+zkRJpf5TECMJrPe9U8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:47088 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qT839-0000hD-Jp; Mon, 07 Aug 2023 17:46:07 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Mon,  7 Aug 2023 17:45:50 -0400
Message-Id: <20230807214556.540627-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v10 0/6] serial: sc16is7xx: fix GPIO regression and rs485 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series mainly fixes a GPIO regression and improve RS485 flags and
properties detection from DT.

It now also includes various small fixes and improvements that were previously
sent as separate patches, but that made testing everything difficult.

Patch 1 fixes an issue with init of first port during probing.

Patch 2 fixes an incorrect label in sc16is7xx_probe() cleanup code.

Patches 3 and 4 fix a GPIO regression by (re)allowing to choose GPIO function
for GPIO pins shared with modem status lines.

Patch 5 fixes a bug with the output value when first setting the GPIO direction.

Patch 6 allows to add a missing fetature to read common rs485 device-tree flags
and properties.

Boards that need to have GPIOS configured as modem control lines
should add that property to their device tree. Here is a list of
boards using the sc16is7xx driver in their device tree and that may
need to be modified:

    arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
    mips/boot/dts/ingenic/cu1830-neo.dts
    mips/boot/dts/ingenic/cu1000-neo.dts

fsl-ls1012a-frdm board uses a sc16is740, which has no GPIOs or modem control
lines, so no DT changes are required.

For the two Ingenic boards cu1xxx, they use a SC16IS752, which has shared modem
control lines and GPIOs. No schematics or block diagrams could be found to
understand if they need GPIOs or modem control lines. But considering that these
platforms were in use before the patch to add the modem control lines was added,
then they probably use these shared lines as GPIOs or nothing, so no DT changes
would be required.

The author of the patch to add modem control lines tested it on a board that
was used only internally.

I have tested the changes on a custom board with two SC16IS752 DUART using a
Variscite IMX8MN NANO SOM.

Thank you.

Link: [v0] https://lkml.org/lkml/2023/5/15/923
      [v1] https://lkml.org/lkml/2023/5/17/967
      [v1] https://lkml.org/lkml/2023/5/17/777
      [v1] https://lkml.org/lkml/2023/5/17/780
      [v1] https://lkml.org/lkml/2023/5/17/785
      [v1] https://lkml.org/lkml/2023/5/17/1311
      [v2] https://lkml.org/lkml/2023/5/18/516
      [v3] https://lkml.org/lkml/2023/5/25/7
      [v4] https://lkml.org/lkml/2023/5/29/656
      [v5] https://lkml.org/lkml/2023/6/1/1046
      [v6] https://lkml.org/lkml/2023/6/1/1328
      [v7] https://lkml.org/lkml/2023/6/2/861
      [v8] https://lkml.org/lkml/2023/6/7/813
           https://lkml.org/lkml/2023/7/21/1055
      [v9] https://lkml.org/lkml/2023/7/25/914

Changes for V1:
- Abandonned the approach of trying to fix GPIO regression by reverting the
  original patches, because it created more problems than it solved (breaking
  existing users). Instead, add DT property to fix the GPIO behavior.

Changes for V2:
- Integrate multiple patches into this serie.

Changes for V3:
- Integrated all patches into single serie to facilitate debugging and tests.
- Reduce number of exported GPIOs depending on new property
  nxp,modem-control-line-ports
- Added additional example in DT bindings

Changes for V4:
- Increase reset post delay to relax scheduler.
- Put comments patches at the end.
- Remove Fixes tag for patch "mark IOCONTROL register as volatile".
- Improve commit messages after reviews.
- Fix coding style issues after reviews.
- Change GPIO registration to always register the maximum number of GPIOs
  supported by the chip, but maks-out GPIOs declared as modem control lines.
- Add patch to refactor GPIO registration.
- Remove patch "serial: sc16is7xx: fix syntax error in comments".
- Remove patch "add dump registers function"

Changes for V5:
- Change patch order to facilitate stable backport(s).
- Change duplicate device addresses in DT binding examples.
- Use GENMASK for bit masks.
- Replace of_property_for_each_u32() with device_property_read_u32_array
- Add "Cc: stable..." tags

Changes for V6:
- Fix compilation bug introduced by patch 3

Changes for V7:
- Minor changes and coding style fixes after review for
  patch 5 "fix regression with GPIO configuration".

Changes for V8:
- Move mctrl_mask to "struct sc16is7xx_port" to avoid compiler warning when
  CONFIG_GPIOLIB is undefined.
- Add "struct device" member to "struct sc16is7xx_port", in order to avoid
  passing a raw "struct device" to called functions from sc16is7xx_probe().
- Add new patch "serial: sc16is7xx: remove obsolete out_thread label"

Changes for V9:
- Change DT property name in commit message and move some comments to cover
  letter for patch "fix regression with GPIO configuration".
- Add proper link to pre-v1 (v0) RFC patch.
- Add changes log for V1 and V2 to this cover letter.

Changes for V10:
- Rebase on gregkh_tty/tty-next
- Remove patch "mark IOCONTROL register as volatile" because an equivalent patch
  is now present in gregkh_tty/tty-next tree:
    https://lore.kernel.org/all/20230724034727.17335-1-hui.wang@canonical.com/
- Remove kernel version prerequisites for "Cc: <stable@vger.kernel.org>" tags
- Add source code comments for patch "fix broken port 0 uart init":
- Remove confusing "Fixes" tag for patch "remove obsolete out_thread label"
- Remove patch "improve comments about variants", which will be sent as a
  separate patch
- Remove patch "add post reset delay" which will be sent as a separate patch
- Remove invalid "Cc: <stable@vger.kernel.org>" tags for patch
  "fix regression with GPIO configuration"
- Change commit log message for patch "add call to get rs485 DT flags and properties"
- Merge patch "refactor GPIO controller registration" with
  "fix regression with GPIO configuration"
- Remove raw "struct device *" pointer added to "struct sc16is7xx_port".

Hugo Villeneuve (6):
  serial: sc16is7xx: fix broken port 0 uart init
  serial: sc16is7xx: remove obsolete out_thread label
  dt-bindings: sc16is7xx: Add property to change GPIO function
  serial: sc16is7xx: fix regression with GPIO configuration
  serial: sc16is7xx: fix bug when first setting GPIO direction
  serial: sc16is7xx: add missing support for rs485 devicetree properties

 .../bindings/serial/nxp,sc16is7xx.txt         |  46 +++++
 drivers/tty/serial/sc16is7xx.c                | 166 ++++++++++++++----
 2 files changed, 174 insertions(+), 38 deletions(-)


base-commit: 593135f09368dbddc0244b859a7c3befb97214e0
-- 
2.30.2

