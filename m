Return-Path: <linux-kernel+bounces-138803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBAD89FA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A15F1C23459
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED517334D;
	Wed, 10 Apr 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TJWmsgoq"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293B16C85A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760378; cv=none; b=k9cjvygGqAsObrUoc7eBm7DmdslLDqqllYwDa6BdnN1wmxF86d4MMNcwKNAWocijkSfenhDXB9AgyXLEqiw8soFLexLX7IGOYkMpXF3s5NJ/eL97tisgJ29UwfHTJ7VBU77Vd7q+ffr7oLCZvgNoJrdvkP95MAHQXMJo9Kt7GBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760378; c=relaxed/simple;
	bh=WgkrZgZQAl6ugPvfnsOWKCXijBgJrcY9jgRDbI6X6mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pAFgnz3HRyzLduo+IVnggJiKMhaBhe9Q12GNK04vnMeTUDHpstN/qrJzk1Lw2GhOWUBTQz2FhAMljm6ENdhJiAqS5EsOxlcOD6gS/OL7Fj682U3JQaq8l/fKWTMJLwq15rVqC+Vwe6VsQBWHtUX11kV/qN499FqiSUF6D2Xzn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TJWmsgoq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346407b8c9aso660086f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712760373; x=1713365173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckqATcdgxJCfEplA12RhN0CYzD0p8U1UjWm+/+bzbPs=;
        b=TJWmsgoqHnI914w0dvG2pPHOr2C7PbsovQzT8vzlsBhS5n58mJZ0lSx0FBStYA72VQ
         qtCtUK/S6Z2WvkPAUZjSitjnza0jljsiA4gk++BxhRQKvwEuEs40vUUkVN+lhZjm6zrz
         eLkM9z4/ftg2D4y2Sy2XrmquG7PD2HKn67ABWvng5SN0x/JRlp2I73349Qb3DDkHnvwR
         1lB36eVdsb7cYS2Gp/OIRP5mlnLMQJdOjvLOOe2tACaAbbOMKnRYW55PSsWVVW5rAwyJ
         beMc17SyAgny0RsMT7RX6/UmBY63H+HtKSMA1ZMLL7NfbBTaIDUZujnu9ukld4y6Pis/
         VBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760373; x=1713365173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckqATcdgxJCfEplA12RhN0CYzD0p8U1UjWm+/+bzbPs=;
        b=oYEUV4hHnAxjc2iB1QsKIiBFJTce/f+plKMpjUFA5ysRgAIjO2QaO7J7FjYku70l1Y
         0dr9JAJ+6ugnZt2exu98pCs2YyPzcFm3MF3N1yNa/vGFhYhfv5187FcozdZ0lqW2TEgH
         zSwNBbrOzcRt2vrTzfTmGhd91Ga1uIGsC+pZDHAXO4rZsZOqYZjcsbgIfdy2u9qRlSy1
         e0BGOKZ3ityGeuTwe+Ax7BRjR3Jo2/1xUf84UJhtd1bAL46sbwx/6U1S1zKXLwMcTmK6
         rA1gleDyaFbecEQeJ9UrMDNygkeizxXR6D8TnK0TN4UOtZBhMhmY366TBsMG0B5Lgfxs
         5qJA==
X-Forwarded-Encrypted: i=1; AJvYcCVMmi6RQWae57eqo0zO4oc85kNZcsAPxdyjCQpxrjalhTgDFtnZUGYeZhWbbqItr+LhX3g/uBcYAMiW4dyDG0Hr1hRM34HeHnFhar2b
X-Gm-Message-State: AOJu0Yx1AQ2nykDlnsgZbkPZR2gH4UCb9iIWr1NH4eIBfT1+5z6kSata
	qI2Q9pCg2viIER0FZ87vphTbYklSshtAFsA0svGw3icmVoKIIoNr5BSrFBsK3ng=
X-Google-Smtp-Source: AGHT+IHspjbKantHWWwZNJBqzLRXvPR+2MRMZ20TrdwY8/JbHDnXeP8XcmVLQ1yJ2+OlsOqgDRCxeA==
X-Received: by 2002:a5d:64e3:0:b0:343:ba58:1297 with SMTP id g3-20020a5d64e3000000b00343ba581297mr2344809wri.3.1712760373469;
        Wed, 10 Apr 2024 07:46:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb09000000b00345c2f84d5asm7068715wrr.10.2024.04.10.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:46:13 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Robin Ehn <rehn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Stefan O'Rear" <sorear@fastmail.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v5] riscv: hwprobe: export highest virtual userspace address
Date: Wed, 10 Apr 2024 16:45:57 +0200
Message-ID: <20240410144558.1104006-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some userspace applications (OpenJDK for instance) uses the free MSBs
in pointers to insert additional information for their own logic and
need to get this information from somewhere. Currently they rely on
parsing /proc/cpuinfo "mmu=svxx" string to obtain the current value of
virtual address usable bits [1]. Since this reflect the raw supported
MMU mode, it might differ from the logical one used internally which is
why arch_get_mmap_end() is used. Exporting the highest mmapable address
through hwprobe will allow a more stable interface to be used. For that
purpose, add a new hwprobe key named
RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS which will export the highest
userspace virtual address.

Link: https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_riscv/vm_version_linux_riscv.cpp#L171 [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

---
Testing:

This new hwprobe key can be tested using qemu and a simple hwprobe dump tool:
https://github.com/clementleger/hwprobe_dump/tree/dev/cleger/highest_virt

v5:
 - Rebased on master to fix merge conflicts
 - Link to v4: https://lore.kernel.org/lkml/20240313084554.31925-1-cleger@rivosinc.com/

v4:
 - Added Charlie Reviewed-by
 - Replace a tab instead of a space
 - Resend with actual V4 tag in front of message which was missing
 - Link to v3: https://lore.kernel.org/lkml/20240301164407.475957-1-cleger@rivosinc.com/

v3:
 - Note: I did not added Stefan Reviewed-by since I did more
   modifications than just a simple respin.
 - Handle CONFIG_MMU=n as well and rename the key to
   RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS
 - Add a user_max_virt_addr() macro to handle !MMU config
 - Link to v2: https://lore.kernel.org/lkml/20240220110950.871307-1-cleger@rivosinc.com/

v2:
 - Note: tried sysconf to export it but this is not backed by syscall
   and thus does not allow exporting such information easily.
 - Use arch_get_mmap_end() instead of VA_BITS since it reflects the
   maximum logical address used by the riscv port
 - Change hwprobe key name from RISCV_HWPROBE_KEY_VA_BITS to
   RISCV_HWPROBE_KEY_MAX_ADDRESS
 - Link to v1: https://lore.kernel.org/lkml/20240201140319.360088-1-cleger@rivosinc.com/
---
 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/asm/processor.h    | 6 ++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 4 ++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..875d3122bd66 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -210,3 +210,6 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS`: An unsigned long which
+  represent the highest userspace virtual address usable.
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 630507dff5ea..150a9877b0af 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 6
+#define RISCV_HWPROBE_MAX_KEY 7
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0faf5f161f1e..345d9a3e4b25 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -57,6 +57,12 @@
 
 #define STACK_TOP		DEFAULT_MAP_WINDOW
 
+#ifdef CONFIG_MMU
+#define user_max_virt_addr() arch_get_mmap_end(ULONG_MAX, 0, 0)
+#else
+#define user_max_virt_addr() 0
+#endif /* CONFIG_MMU */
+
 /*
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..3630e3f30354 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -67,6 +67,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS	7
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8cae41a502dd..eddc0ffc47b4 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -8,6 +8,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
+#include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/switch_to.h>
 #include <asm/uaccess.h>
@@ -215,6 +216,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
 			pair->value = riscv_cboz_block_size;
 		break;
+	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
+		pair->value = user_max_virt_addr();
+		break;
 
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
-- 
2.43.0


