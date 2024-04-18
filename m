Return-Path: <linux-kernel+bounces-150306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD238A9D16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438A3286FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412316D9A1;
	Thu, 18 Apr 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vxzTKzzB"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD516C694
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450439; cv=none; b=Uc5ktBsP81q4j1w/59VxFvb8Pupipi2pLJ9EnJ/YNWVB5rpYvJ8dAQdRsqY3QB780Nw3zrzlwOpXillPL93GA8D3En1Bol44Zb4+GfYwprxvLXh6XkduOpBrEg+fADwvPDMpJwYXHMO9XirOpFjx7OmMflBNqVApc2YVdwbK0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450439; c=relaxed/simple;
	bh=kcoG6jiY9kWv2/uOQlFh79xxb7l93htaZIA0+tqUeuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh5CCoK4gskCC/nzc2fqAfZ4WiqeA4P2/z0pHQC5XV9szPISpfsP7s0zw/CdY4pqQf0aR8H4TLRRR4v5C4uHGoVWYb1r9oFI39HBcR+DioilifwPlDlksiiG4lTqtuxT3fkx9jseI9nmThZ+/HFB5++Ch6IDHrcj1pHj4n1wKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vxzTKzzB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346407b8c9aso257201f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713450435; x=1714055235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AvdB3u3xfYtOVc85K9gr+w0O/Mfoyuz+qydkV22p5c=;
        b=vxzTKzzBJLSR4s1E3LLAE8ZNhOmy1jAWuFlqUwCD541Y06sB3wr6KamOju+8O05pH9
         pfVTGYFnzsBispbgw5umkEXCj6GMGv/jDIDb2EWrNwrQ8jSgo154zuE1/14d9QTdTYnp
         tRXlOaxRBcpTQp67Z88JwBlitbv7C28Y0U4H0CjJDYY/YM5paHDXiO7BiYYdNox+a4sO
         1Hyhz6T2C/0ghxHlMwISmlazGM3WQnGEe7U5W5wkeEq3HASHoAoBeq2OIOiqPxNVmjRU
         lf/AcSVRuCNIOzn0d6//0D9Jj9G6ij7lha0EvXiffBnDNDT9wlHw+18bgnl2xIMMFOzG
         X1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450435; x=1714055235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AvdB3u3xfYtOVc85K9gr+w0O/Mfoyuz+qydkV22p5c=;
        b=DwABFr+o2YmGLxRkFL8zn5QqaWFJc8D+OntPEY4ZedLILcBTFuBXl9c77uLKOSA3uR
         9hqBEFVJBAJGWps9zQLHT2WzbdTRXkYTYSL0cl9eHKzldvZ9D5eUdnqeERWuL8akPrx3
         qGaqt6GObV5rToB0TSEjv7kmr9trJq2v/EIar1wdhiVwyxY/4sGWD1+r98Aj/OoJps3C
         juc+lNYKYVreLjSGxJmLk/dh3TRISRyRTnMOoezepJwFn0qX3OVa4sjRZyzObNN6vkwU
         RMs3C0vM8qSoQx91WEJ7rWPhOi349POXAsV2GpyYu2DyLzlXFfYVGo3RGHaRflDflx9s
         Oanw==
X-Forwarded-Encrypted: i=1; AJvYcCWxH5MH78xRgN5VQ3XiyNTgJXXNOzVmO/Hn2ZrkaQBpwKop460JlY4BjN5kWwmjYaPU+ZTJCBUA4apriY61Evs0mqB8+MdaW48B/8BT
X-Gm-Message-State: AOJu0YwTjrmN9F3c+FdBv92vEaK5NtLvznmSxqWxLQJ4lstL25maw2Fu
	ByedaMxYyo2ixJFmvKPcG3OKpAfGD78p9G4PzSMK/ZFP7iLN+KcfoAimquya13s=
X-Google-Smtp-Source: AGHT+IEwlQ04KaJP3EVY+XCohGbQqha8fE09E68ZNltKaQxFJ4YDXOPGuVd4fVf/pEkQ78VT8bcTuA==
X-Received: by 2002:a05:600c:35ca:b0:418:9941:ca28 with SMTP id r10-20020a05600c35ca00b004189941ca28mr2125666wmq.2.1713450435180;
        Thu, 18 Apr 2024 07:27:15 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm2873645wmo.42.2024.04.18.07.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:27:14 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	Ved Shanbhogue <ved@rivosinc.com>
Subject: [RFC PATCH 5/7] riscv: add double trap driver
Date: Thu, 18 Apr 2024 16:26:44 +0200
Message-ID: <20240418142701.1493091-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418142701.1493091-1-cleger@rivosinc.com>
References: <20240418142701.1493091-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a small driver to request double trap enabling as well as
registering a SSE handler for double trap. This will also be used by KVM
SBI FWFT extension support to detect if it is possible to enable double
trap in VS-mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h    |  1 +
 drivers/firmware/Kconfig        |  7 +++
 drivers/firmware/Makefile       |  1 +
 drivers/firmware/riscv_dbltrp.c | 95 +++++++++++++++++++++++++++++++++
 include/linux/riscv_dbltrp.h    | 19 +++++++
 5 files changed, 123 insertions(+)
 create mode 100644 drivers/firmware/riscv_dbltrp.c
 create mode 100644 include/linux/riscv_dbltrp.h

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 744aa1796c92..9cd4ca66487c 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -314,6 +314,7 @@ enum sbi_sse_attr_id {
 #define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SPIE	(1 << 2)
 
 #define SBI_SSE_EVENT_LOCAL_RAS		0x00000000
+#define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP	0x00000001
 #define SBI_SSE_EVENT_GLOBAL_RAS	0x00008000
 #define SBI_SSE_EVENT_LOCAL_PMU		0x00010000
 #define SBI_SSE_EVENT_LOCAL_SOFTWARE	0xffff0000
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 59f611288807..a037f6e89942 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -197,6 +197,13 @@ config RISCV_SSE_TEST
 	  Select if you want to enable SSE extension testing at boot time.
 	  This will run a series of test which verifies SSE sanity.
 
+config RISCV_DBLTRP
+	bool "Enable Double trap handling"
+	depends on RISCV_SSE && RISCV_SBI
+	default n
+	help
+	  Select if you want to enable SSE double trap handler.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index fb7b0c08c56d..ad67a1738c0f 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_RISCV_SSE)		+= riscv_sse.o
 obj-$(CONFIG_RISCV_SSE_TEST)	+= riscv_sse_test.o
+obj-$(CONFIG_RISCV_DBLTRP)	+= riscv_dbltrp.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/riscv_dbltrp.c b/drivers/firmware/riscv_dbltrp.c
new file mode 100644
index 000000000000..72f9a067e87a
--- /dev/null
+++ b/drivers/firmware/riscv_dbltrp.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-dbltrp: " fmt
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/riscv_dbltrp.h>
+#include <linux/riscv_sse.h>
+
+#include <asm/sbi.h>
+
+static bool double_trap_enabled;
+
+static int riscv_sse_dbltrp_handle(uint32_t evt, void *arg,
+				   struct pt_regs *regs)
+{
+	__show_regs(regs);
+	panic("Double trap !\n");
+
+	return 0;
+}
+
+struct cpu_dbltrp_data {
+	int error;
+};
+
+static void
+sbi_cpu_enable_double_trap(void *data)
+{
+	struct sbiret ret;
+	struct cpu_dbltrp_data *cdd = data;
+
+	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
+			SBI_FWFT_DOUBLE_TRAP_ENABLE, 1, 0, 0, 0, 0);
+
+	if (ret.error) {
+		cdd->error = 1;
+		pr_err("Failed to enable double trap on cpu %d\n", smp_processor_id());
+	}
+}
+
+static int sbi_enable_double_trap(void)
+{
+	struct cpu_dbltrp_data cdd = {0};
+
+	on_each_cpu(sbi_cpu_enable_double_trap, &cdd, 1);
+	if (cdd.error)
+		return -1;
+
+	double_trap_enabled = true;
+
+	return 0;
+}
+
+bool riscv_double_trap_enabled(void)
+{
+	return double_trap_enabled;
+}
+EXPORT_SYMBOL(riscv_double_trap_enabled);
+
+static int __init riscv_dbltrp(void)
+{
+	struct sse_event *evt;
+
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SSDBLTRP)) {
+		pr_err("Ssdbltrp extension not available\n");
+		return 1;
+	}
+
+	if (!sbi_probe_extension(SBI_EXT_FWFT)) {
+		pr_err("Can not enable double trap, SBI_EXT_FWFT is not available\n");
+		return 1;
+	}
+
+	if (sbi_enable_double_trap()) {
+		pr_err("Failed to enable double trap on all cpus\n");
+		return 1;
+	}
+
+	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP, 0,
+				 riscv_sse_dbltrp_handle, NULL);
+	if (IS_ERR(evt)) {
+		pr_err("SSE double trap register failed\n");
+		return PTR_ERR(evt);
+	}
+
+	sse_event_enable(evt);
+	pr_info("Double trap handling registered\n");
+
+	return 0;
+}
+device_initcall(riscv_dbltrp);
diff --git a/include/linux/riscv_dbltrp.h b/include/linux/riscv_dbltrp.h
new file mode 100644
index 000000000000..6de4f43fae6b
--- /dev/null
+++ b/include/linux/riscv_dbltrp.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+#ifndef __LINUX_RISCV_DBLTRP_H
+#define __LINUX_RISCV_DBLTRP_H
+
+#if defined(CONFIG_RISCV_DBLTRP)
+bool riscv_double_trap_enabled(void);
+#else
+
+static inline bool riscv_double_trap_enabled(void)
+{
+	return false;
+}
+#endif
+
+#endif /* __LINUX_RISCV_DBLTRP_H */
-- 
2.43.0


