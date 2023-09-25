Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7603B7AE1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjIYWfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIYWfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:35:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8E1192;
        Mon, 25 Sep 2023 15:35:24 -0700 (PDT)
X-QQ-mid: bizesmtp69t1695681314trhnno76
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:35:13 +0800 (CST)
X-QQ-SSF: 01200000002000E0Y000B00A0000000
X-QQ-FEAT: 5q30pvLz2ifym5SLIzsh144Znm6wRlu+bPV0w9peTQtfsIPVYY0hXdp41PdCD
        qNzUX3VU0ZbZvFxqzdl781ox5Wff3pzWuKKNI6Te1Y8Odq1dErSA2qLbFA/SMI2cKUrzOVs
        JqSkwphfZ1OdgeG+SXhsqzaC3EdPtZ01WiX3xWijTjjHsIaAgg69GAJkp+9VvBK+LXtqy1j
        nrLN7pG00O3beVVn6nNJXOacEGL+QVJsdzrevmusz0g8QdKt9Gmkrc6JmfWCThmyuCXGiVh
        gjxq5yWAioV+s2WgKuEpfsGOozhlcqRN+oC8EBu5Z9jN5LH+6xf8e1VBtfxSu4YLC8kyaQi
        XdE5S4RGw+7MohBQiYCuUk9wCwPZJByKg1RLiR97lDnE03vxkhVdJMeJFQ4NQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1656431424344420643
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 1/7] DCE: add debug support
Date:   Tue, 26 Sep 2023 06:35:11 +0800
Message-Id: <36d7ee5122e3a9c2b307cf6ab1a9508860fd7710.1695679700.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
MIME-Version: 1.0
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

Enable --print-gc-sections for --gc-sections to monitor which sections
are really eliminated.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 Makefile     | 3 +++
 init/Kconfig | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 57698d048e2c..a4e522b747cb 100644
--- a/Makefile
+++ b/Makefile
@@ -938,6 +938,9 @@ ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 KBUILD_RUSTFLAGS_KERNEL += -Zfunction-sections=y
 LDFLAGS_vmlinux += --gc-sections
+ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION_DEBUG
+LDFLAGS_vmlinux += --print-gc-sections
+endif
 endif
 
 ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..4350d8ba7db4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1404,6 +1404,13 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	  present. This option is not well tested yet, so use at your
 	  own risk.
 
+config LD_DEAD_CODE_DATA_ELIMINATION_DEBUG
+	bool "Debug dead code and data elimination (EXPERIMENTAL)"
+	depends on LD_DEAD_CODE_DATA_ELIMINATION
+	default n
+	help
+	  Enable --print-gc-sections for --gc-sections
+
 config LD_ORPHAN_WARN
 	def_bool y
 	depends on ARCH_WANT_LD_ORPHAN_WARN
-- 
2.25.1

