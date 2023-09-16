Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C5A7A2FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbjIPMIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbjIPMII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:08:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE6CED;
        Sat, 16 Sep 2023 05:08:02 -0700 (PDT)
X-QQ-mid: bizesmtp91t1694866064t8l0a72a
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Sep 2023 20:07:41 +0800 (CST)
X-QQ-SSF: 00200000000000907000000A0000000
X-QQ-FEAT: znfcQSa1hKbOWPpeocnk9p3hBnV5lSgG39wRYFvZp0ZJo2u0QcBtKK5FxZqXs
        CLQ8iul5Q9g8SR3Wml2ccUAdeART+ZB6BgDiABmmbknJBW9jgGQvf1u1llhBm1sk28dH5h4
        OyqWYbVqmE6AVz8vNsyKjU6+4LWQ/6ab6V6fhvIzfpKglzNnxxGbNDxEp8s16rdGTPKljvT
        eh8TdwkkN97uLINi0GmdeSD6mY6QP/RUPid/jGolVosHsxBnee4s5SpI5aFZz4awZnhMwUr
        MQB9cSoDmAIO7mbIdvg1HBW/Kp2snNj5ZOdNr7hgNXRmQVRAjs9q6/v1XqV6NzMRZk2o2q1
        gIW+mola5Ket6yGL/PuDcjhqJQ/K1nxsk/RXKYNV4Prdoo9nL8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14865914680998969880
From:   Yuan Tan <tanyuan@tinylab.org>
To:     philmd@linaro.org
Cc:     tsbogend@alpha.franken.de, 42.hyeyoo@gmail.com,
        linux-mips@vger.kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org, w@1wt.eu,
        linux@weissschuh.net, tanyuan@tinylab.org
Subject: [PATCH v4 2/2] Kconfig: add dependencies of POWER_RESET for mips malta
Date:   Sat, 16 Sep 2023 20:07:40 +0800
Message-Id: <413b332868bac086c32b7486a7cb9c6fc81c15c0.1694865711.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694865711.git.tanyuan@tinylab.org>
References: <cover.1694865711.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS Malta's power off depends on PCI, PCI_QUIRKS, and
POWER_RESET_PIIX4_POWEROFF to work. Enable them when POWER_RESET is set
for convenience.
Then regenerate malta_defconfig with 'make savedefconfig'.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/mips/Kconfig                 | 3 +++
 arch/mips/configs/malta_defconfig | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fc6fba925aea..b63a93e39f23 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -547,6 +547,9 @@ config MIPS_MALTA
 	select MIPS_L1_CACHE_SHIFT_6
 	select MIPS_MSC
 	select PCI_GT64XXX_PCI0
+	select PCI if POWER_RESET
+	select PCI_QUIRKS if POWER_RESET
+	select POWER_RESET_PIIX4_POWEROFF if POWER_RESET
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 7ae07d57b79a..99049e993192 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -192,7 +192,6 @@ CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
-CONFIG_PCI=y
 CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
@@ -284,7 +283,6 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-- 
2.34.1

