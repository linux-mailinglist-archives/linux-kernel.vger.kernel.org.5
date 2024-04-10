Return-Path: <linux-kernel+bounces-137998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C05E89EAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E469B219B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E336B00;
	Wed, 10 Apr 2024 06:36:11 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD01427B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730971; cv=none; b=UUeDOtSmPBJ0Pgj3o0HEQj/R3GWONMOvSD3yFZAn6Zvkj9f/Dgia13yFVJHnrUW2hXmDiZjxpWX44/9Jzl3PHLiL69J310SFFgZHGk+e7NkG1757vhNlVpVn3DVw7yErEZB8aDhoUn747bjaupjgBrY3q2upQk65uBePLwb9cSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730971; c=relaxed/simple;
	bh=Bswf8GGz9nhrCHVYWM9I5EX2nibhIgOoLY2Rrl6ouss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kVNbCuixeuTfKmGoADG++OUif4UbrJWNYAUHb1qeG1lOi9Qx9gOxuuFgu470qyZ00s1EQkfs/SkepVDS1NRSBEl53wmuh1NXkwVoaxz7QxyuCpDt5qk/XBCBnbFa40e8BvgpaPqk0U1Qkr8IaA5r8HTvsOmmZznBeFAUHMHKbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1712730896tvu5ywkv
X-QQ-Originating-IP: r0h3XHYT18sT2yt8k08GzNHSk4HTIBc66vnGcRK0aQI=
Received: from HX01040082.powercore.com.cn ( [14.19.197.107])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Apr 2024 14:34:49 +0800 (CST)
X-QQ-SSF: 01400000000000B09000000A0000000
X-QQ-FEAT: 3M0okmaRx3i4lw8jCv5pRZ7eo/gTlSNfqfJCPj1K7jvvSLIS40Dayz+ynQ2CK
	68XPUeRpihraguLeHHDc5Ady/t6uyuXAWz9D0gg08WMVpbdPkCpxYKWJ46mJRHekC77N4gq
	7eHNphwxlOOSmvR2iEiuWYHe1bWWaBuubSPXEHA6DPiBfdt3120CrKvB/FuppwIth/AlOjS
	oFwQiLyd9wlMT9+VRqYsS3NnEVUFosFvo0XnHfuqQgp0Zb4hqrYhdgWwiRTMtD7xAbfEE5m
	bGVsfo39affMyu2danRjhIP67B8TMJhHRq6ayu2OELnse0uQUCL+Lwhn7xyMu/iCKGMk6Wn
	3QQEsF2X2a7p3pGnrxGxJnV+PYquzqxiGgxiyrleUUh0ZOEu3nBrpuo4Hqz5nmix/+o/0ex
	zlZ6ECdTLx9zkkKO+eIghg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10304416365381800906
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: palmer@dabbelt.com
Cc: paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	atishp@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>
Subject: [PATCH 2/3] riscv: SBI as the interface for the early console
Date: Wed, 10 Apr 2024 14:34:31 +0800
Message-Id: <20240410063432.23058-3-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
References: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

Use the SBI interface as the early console output interface
for the RISC-V platform.

Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>
---
 drivers/tty/hvc/Kconfig         | 12 ++++++++++++
 drivers/tty/hvc/hvc_riscv_sbi.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index c2a4e88b328f..48658d2b700c 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -118,6 +118,18 @@ config HVC_RISCV_SBI
 
 	  If you don't know what do to here, say N.
 
+config RISCV_EARLY_CONSOLE_SBI
+	bool "Use SBI as the interface for RISC-V early console"
+	depends on RISCV
+	help
+	  Choose 'Y' to use the SBI interface as the early console
+	  output interface for the RISC-V platform.
+
+	  This configuration is a temporary setup for debugging
+	  purposes during the boot process to address issues as
+	  early as possible. It should not be enabled in production
+	  kernel.
+
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES && HVC_CONSOLE
diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index cede8a572594..6686dcf62853 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 
 #include <asm/sbi.h>
+#include <asm/early_console.h>
 
 #include "hvc_console.h"
 
@@ -81,3 +82,31 @@ static int __init hvc_sbi_init(void)
 	return 0;
 }
 device_initcall(hvc_sbi_init);
+
+#ifdef CONFIG_RISCV_EARLY_CONSOLE_SBI
+static ssize_t (*sbi_early_putc_common)(uint32_t vtermno, const u8 *buf, size_t count);
+
+static void sbi_early_putc(char c)
+{
+	unsigned int termno = 0;
+	int count = -1;
+
+	if (c == '\n')
+		sbi_early_putc('\r');
+
+	do {
+		count = sbi_early_putc_common(termno, &c, 1);
+	} while (count == 0 || count == -EAGAIN);
+}
+
+void __init hvc_sbi_early_init(void (**putc)(char c))
+{
+	if (sbi_debug_console_available)
+		sbi_early_putc_common = hvc_sbi_dbcn_tty_put;
+	else if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
+		sbi_early_putc_common = hvc_sbi_tty_put;
+
+	if (sbi_early_putc_common)
+		*putc = sbi_early_putc;
+}
+#endif
-- 
2.25.1


