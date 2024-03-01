Return-Path: <linux-kernel+bounces-88755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483386E624
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AD41C22F79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497BE3C6B3;
	Fri,  1 Mar 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SkGQcwHQ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059F33C47C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311495; cv=none; b=VPo52RP2bbBkI5KSbCRKGfaPy8v6IsNpcWO396Z1+9t9GwKl3YPF+Q2JVU+vjz3zS3tgPxO+SzvTUpRA/UO/MqTQMi/63vcv7dQggopmEjbtuGUPSdVoj+jF4nss7EHkTGbzCxAON//pBQqfl2AZ7w7wQFa98uvLdchUo5r70aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311495; c=relaxed/simple;
	bh=eW/jBE9xiI7mzT0S7JbXnNi/2VZkkXPS3pieWKtDhWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fERnI5QANPCIQnSungH6j/CM6tv6AjowVxTJ+0A+VZNuZAOAUiUiDJPjsEhyc/vykgkdi6F9wi3pbx3N7mNb+L8lwDTY1tdeGRa1A19eT18No/eQWJAem4CzcGih7kF1L3UhPZgiQxug6K9fstNRQtWYT1xe5cHRqyyLQrmPXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SkGQcwHQ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5132bd70e7dso576777e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709311490; x=1709916290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0fSMW0qhtBaxw1Ne7+Ji9afXRUSlXWtRAYNnO9M03wA=;
        b=SkGQcwHQSQw2jvhMg1rtMW0GIpv5/fDSioHSxRxKHmEONt9ynYhKeVKBmc371UcJzf
         3GIb/2VaJP2k9RMeL3qW794AB2QoLsRW7OjOvkTogEzx2Boz+8KDLq58QlmcTBvUZT41
         M7W/ZMVIKvSEAZpsZncsJu7bcT3L/KtgJOxwVgTbKWKL420AJTU+9IG2k/nRDc2fF1BX
         RCMa64JFTQn/URDR2NpGeru0Q76fWHZuc3Sy31a9K8wXZdMmN8RnB4TNDGwVAfUsh0IE
         ZW6RFvUri4mlYP4ZCi0SfRNVNAemLXspnU1kIJAgeTK6mO5M0Kp2Goq4kKpDEfw1lAy/
         137w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311490; x=1709916290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fSMW0qhtBaxw1Ne7+Ji9afXRUSlXWtRAYNnO9M03wA=;
        b=b+EYTPtS9JBWTh5OufpV5rc0LQwnG2DHZod+695FtGMvxeWs+kDWVSMpPUVN26VtVy
         WLXWPR5szqjRQDWBwViwq4i+XV3Pv9YbrPt8UOe88dhEluIWhPI5KqtLFW4/L4lx+ViT
         rW1ijr4piaf430p4ivCZlEzMRl3Xlsv6iRqxL84dVXjb5+DtbA3V9HcAYhYC38na+Nhp
         XAhHpjIXjbjl+YqIX5HrrnLBbJFTt3XDIYSMV9vXG/m3jt7/+qSN8kNK5sZ7mqqZ9ZdQ
         LVp2Ps5Ncvgik8MSi5cHuFfQnKTNED/82Tj4LBTgxN2lz0G+0H5kn/019duzVxWQu0Ox
         zLoA==
X-Forwarded-Encrypted: i=1; AJvYcCUXOBtS4jiQJngzXAscMvaaHA90uj2huG6cJzUJRSq/TJgGhIWsyFnBgDiC+6ylVqF1wdwM1idivlbo8betU0vHEEgj4tUw6eiylVm6
X-Gm-Message-State: AOJu0YzMc5VQiQ+jOQX/6E1geebobPnEE7j2jdieIgEOzi8qSyqF/+ay
	E5tQOB/wJ2nlh/KxUe3FKf5ggza0Kl4yiWMSywXI/S3alsRlAmPA2S4lXzmWecg=
X-Google-Smtp-Source: AGHT+IH+VZ/Ok1lQGCinD/i871+cRsq/HKRFrVNNHntki84EwJcMBwhp9FeP1K8gbRR0fmgRMfL0cA==
X-Received: by 2002:a05:6512:39c5:b0:513:258f:5ef3 with SMTP id k5-20020a05651239c500b00513258f5ef3mr2453949lfu.1.1709311489974;
        Fri, 01 Mar 2024 08:44:49 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:1cac:c075:fa3d:e5e9])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d5341000000b0033e11acf84asm4456462wrv.15.2024.03.01.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:44:49 -0800 (PST)
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
Subject: [PATCH] riscv: hwprobe: export highest virtual userspace address
Date: Fri,  1 Mar 2024 17:44:06 +0100
Message-ID: <20240301164407.475957-1-cleger@rivosinc.com>
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

---

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
 arch/riscv/include/asm/processor.h    | 8 +++++++-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 4 ++++
 5 files changed, 16 insertions(+), 2 deletions(-)

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
index a8509cc31ab2..341863d4d989 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,7 +14,7 @@
 
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE
 
@@ -58,6 +58,12 @@
 
 #define STACK_TOP		DEFAULT_MAP_WINDOW
 
+#ifdef CONFIG_MMU
+#define user_max_virt_addr() arch_get_mmap_end(ULONG_MAX, 0, 0)
+#else
+#define	user_max_virt_addr() 0
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
index a7c56b41efd2..560ea41a716d 100644
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
@@ -202,6 +203,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
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


