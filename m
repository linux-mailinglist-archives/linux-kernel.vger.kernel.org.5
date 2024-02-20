Return-Path: <linux-kernel+bounces-72874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B639B85B9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FC41C21960
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D865BDE;
	Tue, 20 Feb 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yEV0jvSC"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49A60EFB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427404; cv=none; b=mRREoNF62YrE/7lS72lDL8/HOP4gd9hUn4epuOVvAb/ikE6KjSeM3l6zZ8VvjE5AKoAJnoW7NIH8ikjdboWYpZllvsLmxZD579QzXOTbK2kYAvB+mMmWr+/bmTDQRXh5Pcy/GQmp4ZesmtFZVb+Ll5NGbdTUP7vmHqGszfRpDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427404; c=relaxed/simple;
	bh=P8Aqy8ESp9/yuG+L+Ud949luCNrj2GyoAhcLJH3MYAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5COq9bLVXqIHFcrSd44bRutFftW4L0SesPyaBcfjOpOGDS+D6e7dccSmq6dYy+MbSF/NukU7wpxrptXBmsRefechkpAI++NKbWJrIlqMACfPU/yknPjQ9+obzjE3qM6usFwrWEdDe0lG8e+BrjhSfzPLWJAIOQvQarToMpoyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yEV0jvSC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d2746894dso910367f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708427399; x=1709032199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+NE38xHg+iFcMOIUoO6dahKVI267XimNpzeYRqug0o=;
        b=yEV0jvSClIWlDwPsjtIQUnwVTkrr0HDk6FRz260a0BEvYvN/8Z0GmdxG5FaCElycf8
         zesz/bdnaQG8uIKIKaIkFVawETxNyfZwF0/IjbTgUyqlYwh5Db4FK0nwI7UifRH0Pld6
         926KTfrNny0+LjM/lICF8mcq1dVfvCZn0eZp1jAj4JSHxhmQLlzYv0KXGEPNr6VQv9ES
         LwlLL4eLA1t6I1Z53HaFuC7QzUeBkh/UdFV4DHZhZ1pyscYNMYX3DCLi74ctb+0cwHHG
         W/E432ywrmYUsu92v+3daWTVCgwDObP5WdBWvhOaz4huWUvypkRXZlG6Nq9YMb8Yjzu4
         8Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708427399; x=1709032199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+NE38xHg+iFcMOIUoO6dahKVI267XimNpzeYRqug0o=;
        b=CslZ/oFOI4+jSsSq9HSbIrkwtmc4VmDe36dqmbvyvBkkQzqBfXxO1FuuJWg4GE0k0D
         PLic6UZXXNmV8yYMaf0pd9cw4eRUOggT6yS21+OwcZNOJNOFjgchHlR+8rkO4wON9O6o
         SoK8dbQs2+e9ady6Yitij3liQe6A3hmEraRn1kr3brX/w++tOLD1mu1h+nqRhfqQk/yX
         qOCrbZHeyQu2k1lKafgoba/2a+bXwNUq7LN4sBGMXH9VRnnJs0DqTNMZFsV/vrLw7zud
         4e6v0R5qHzyEq/1VSPj1ftBj0rUCqJXDW6R83/rrsSsNADrIdy1eLAm1RbYuvvUlOsT1
         tMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOzJV+X1xHA7Zo23ub/9/YZxEa1+7SE8Yk3dj77p7I8b/0IuGbu1oVEmM0eUx4U8zBU4kTi0QGtDaA732bLv+XfgOoNRSdyXb8tpwq
X-Gm-Message-State: AOJu0YwHliNeGks2wznYNkRtGAhA5q3SGjKLu+vwI6Dqln5tVZwAg68b
	cof0/mdQMn0gN/83e4ab/REAjQzMSw4Znc/PXSun/0BcvY2kujOITlmM8CCDVHw=
X-Google-Smtp-Source: AGHT+IFEeB57DA/UVYTFHFvFefw4+utIN4uHed+oWc9cOPONdvuPDUZUvkrfpHzHpS85/bYqCuA05g==
X-Received: by 2002:a05:6000:79d:b0:33d:7221:97cf with SMTP id bu29-20020a056000079d00b0033d722197cfmr55643wrb.6.1708427399487;
        Tue, 20 Feb 2024 03:09:59 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:6202:c7ea:a0cd:ad4a])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b0033d6ff7f9edsm1092523wrb.95.2024.02.20.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:09:59 -0800 (PST)
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
Subject: [PATCH v2] riscv: hwprobe: export largest userspace address
Date: Tue, 20 Feb 2024 12:09:46 +0100
Message-ID: <20240220110950.871307-1-cleger@rivosinc.com>
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
virtual address used bits [1]. Since this reflect the raw MMU mode
supported, it might differ from the logical one used internally.
Exporting the maximum mmappable address through hwprobe will allow a
more stable interface to be used. For that purpose, add a new hwprobe
key named RISCV_HWPROBE_MAX_KEY which will export the maximum mmappable
userspace address.

Link: https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_riscv/vm_version_linux_riscv.cpp#L171 [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
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
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 4 ++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..a626aa21ac74 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -210,3 +210,6 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_MAX_USER_ADDRESS`: An unsigned long which
+  represent the maximum userspace mmappable address.
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
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..a6da434be9da 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -67,6 +67,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_MAX_USER_ADDRESS	7
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..19a47540b4a2 100644
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
+	case RISCV_HWPROBE_KEY_MAX_USER_ADDRESS:
+		pair->value = arch_get_mmap_end(ULONG_MAX, 0, 0);
+		break;
 
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
-- 
2.43.0


