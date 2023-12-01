Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F08B8013CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379563AbjLAT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379538AbjLAT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:57:30 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED52D54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:57:36 -0800 (PST)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 66A11221C6;
        Fri,  1 Dec 2023 20:57:34 +0100 (CET)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id 194BF7F9C0;
        Fri,  1 Dec 2023 20:57:34 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1r99dl-0001Hk-35;
        Fri, 01 Dec 2023 20:57:33 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v3] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Date:   Fri,  1 Dec 2023 20:57:32 +0100
Message-Id: <20231201195732.4931-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
is not adequate for embedded systems that use SoCs where it's common to
have a large number of serial ports.

No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").

The need to increase this value was noticed while working with Toradex
Verdin AM62, this board has 4 serial UART instances available to the user
plus an internal one that is connected to a Bluetooth module. Without this
change the fifth UART connected to the BT module is not instantiated and BT
is not working.

Instead of increasing the number to the bare minimum (5) that would be
required to solve this specific issue, we increase this to 8 which seems a
more reasonable number to have in the defconfig and should cover more valid
use cases.

With this change the kernel image size increases by ~3.2kB. bloat-o-meter
summary: add/remove: 1/1 grow/shrink: 7/0 up/down: 3220/-8 (3212)

Cc: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Francesco Dolcini <francesco@dolcini.it>
---
v2: added details in the commit message on the verdin am62 uart config and
    requirement
v3: added details on the kernel size increase because of this change
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..ecd365cd1d87 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -448,6 +448,7 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=8
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
-- 
2.39.2

