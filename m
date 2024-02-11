Return-Path: <linux-kernel+bounces-61015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEE8850C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2FA1C217EE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9E17560;
	Sun, 11 Feb 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Q154jwhq"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA77383AE
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693369; cv=none; b=D2yriGpubup7BeHEczimqH0Vy+DCY2mr5R+8QEr7kC4D0w8c3KXRpoa28CGcx2l23cTlPtg6ri4Be9wBo3IFn65pZpkRorex+NI490dMOCgwqVpxswP8W5PCV09Xb5A8uwH+aQR+VQWGui5UxpV0TFD+jDNwAayWCVi6ffVd570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693369; c=relaxed/simple;
	bh=iW4ba7UHKk0KDThAeTMx8C2vBPEV860cssjhylXWogA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NaYc9RTdI5inB6P62m9l4IO2JDlDco32ub5alFaa5QCwqaLB62Af3YC+4LmzwXhocYnVQg8NiyEF2TsVE+2p5LDRz9EjDtCUIIYDYieV4YiNoXInUL8ZEkc/iTr4FKIHNKvS73eCg23YAOeBYXq7pgj8sXKkXWj8nmzRvbgKvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Q154jwhq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3363551a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693364; x=1708298164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2wHzIJ+1gKKynMpcxVEtR1yMxxOWj0+XBOjO/6pnQI=;
        b=Q154jwhq42+KuhWwV3GIrcOX3btcp3kWzCIQ7T7NVLS9yNNbso2pUlHE+SgqXO1nUA
         mIv2rInZDldG9JOIsr976zUAN3HOQO1i20WmYvBQgfdHyHxRllYlsQN2v35EMUqtFmNR
         HYQPlL3aQiQxhQfC/4UUVfD8H+aGPxHXA6aZBET+L3TpAVJdakcZNB1BrjpnMGzrpBCC
         Eao5FFqRAo6ggf8dpWRHJjpCFILPNncJg1EQAzb5E2VZ/MjVSHnx6yxTy9mc0FhoJN8H
         4V85TPOMk/zxIu3gm0JVuSun/eg3SMDBkIIXZmVt6Cun2K/Ssc/3xjlU37iT63vjjGU0
         0rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693364; x=1708298164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2wHzIJ+1gKKynMpcxVEtR1yMxxOWj0+XBOjO/6pnQI=;
        b=T3eVNOmlG92iksCIecpmqAAE8GEkIE+l6bHGzD3siEyCP1HSb4NwE51m2IAu17yw3I
         wkwlHfm5W3qd3z74sqxprNGp2TS5xuzGqpa5iCN7CCo9j7DuDSiKeTOWPnCu05CqhQwr
         m82bgcebTNZjJjTUMreibZ7blYx1CZCZOctNum1zn5wdWQuMXzczrPSF/b3FEri97mbj
         bnBHh9RL8enAYRokwyJLdhlig524Qt681YTV/0g+6I+kQVn4Nebu9wnrZDbFAnmuI7qP
         594Lgu64ld7+xj1RNytVX3zi4aTfddN4qLLcyW7YyOHuRbIMN5iR3J1Tz0g4LGgjWbRO
         6gPw==
X-Gm-Message-State: AOJu0Ywk0aXKw4wzB0L2Uwwfmgp1TDR0tXUvPzMlzuYUosP5+Kjq5BpZ
	dhCALUpmBHnehT2v7KNxvtJNgkkYgwWY9jFC+Is+d2PlK5C6oht+cgmadolSXNFfpcIc5WPpAic
	m
X-Google-Smtp-Source: AGHT+IEdAsT8B7MqH0+bfjaLuq8WfheGTPFq9pVKgfkyUaPWRH/oKJQh3ITEJKt85/SGYGeCxmZXlA==
X-Received: by 2002:a05:6402:33c8:b0:55e:fe6b:f4dc with SMTP id a8-20020a05640233c800b0055efe6bf4dcmr2754011edc.40.1707693363892;
        Sun, 11 Feb 2024 15:16:03 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:16:03 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 33/35] linux/kernel.h: move upper/lower_*_bits macros to wordpart.h
Date: Mon, 12 Feb 2024 00:15:16 +0100
Message-Id: <20240211231518.349442-34-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reducing dependencies on the header linux/kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm64/include/asm/syscall.h  |  2 +-
 arch/arm64/kvm/handle_exit.c      |  2 +-
 drivers/bus/uniphier-system-bus.c |  2 +-
 drivers/irqchip/irq-gic-v3-its.c  |  1 +
 drivers/spi/spi-pci1xxxx.c        |  1 +
 fs/hfs/hfs_fs.h                   |  2 +-
 fs/hfsplus/hfsplus_fs.h           |  2 +-
 include/drm/drm_fixed.h           |  2 +-
 include/linux/dma-fence.h         |  2 +-
 include/linux/goldfish.h          |  2 +-
 include/linux/kernel.h            | 29 +----------------------------
 include/linux/qed/common_hsi.h    |  1 +
 include/linux/wordpart.h          | 28 ++++++++++++++++++++++++++++
 include/rdma/uverbs_ioctl.h       |  2 +-
 include/soc/fsl/bman.h            |  2 ++
 include/soc/fsl/qman.h            |  1 +
 16 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 107ada608694..e5f462cc1a54 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -8,7 +8,7 @@
 #include <uapi/linux/audit.h>
 #include <linux/compat.h>
 #include <linux/err.h>
-#include <linux/kernel.h> // for lower_32_bits()
+#include <linux/wordpart.h> // for lower_32_bits()
 
 typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index a82b4b31bb36..91bd5b701acf 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -10,7 +10,7 @@
 
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
-#include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 
 #include <asm/esr.h>
 #include <asm/exception.h>
diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index 8cffdb089a6b..8949a7a5c170 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -6,7 +6,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
 #include <linux/log2.h>
-#include <linux/kernel.h> // for upper_32_bits()
+#include <linux/wordpart.h> // for upper_32_bits()
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1be09abac7cc..2b33edb78c26 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index ab99aac85eb9..1ff89d726927 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
+#include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/pci_regs.h>
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 71ebbed52f5f..99e54ff4df83 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -17,7 +17,7 @@
 
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/kernel.h> // for lower_32_bits()
+#include <linux/wordpart.h> // for lower_32_bits()
 #include <linux/mutex.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 157dad01495f..79cac82d050e 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -21,7 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
-#include <linux/kernel.h> // for lower_32_bits()
+#include <linux/wordpart.h> // for lower_32_bits()
 #include "hfsplus_raw.h"
 
 #define DBG_BNODE_REFS	0x00000001
diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 0c9f917a4d4b..ff9a91fa40b6 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -25,7 +25,7 @@
 #ifndef DRM_FIXED_H
 #define DRM_FIXED_H
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h> // for lower_32_bits()
 #include <linux/math64.h>
 
 typedef union dfixed {
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 3081ff146d41..308d77098e21 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/bitops.h>
-#include <linux/kernel.h> // for lower_32_bits()
+#include <linux/wordpart.h> // for lower_32_bits()
 #include <linux/kref.h>
 #include <linux/sched.h>
 #include <linux/printk.h>
diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index bcc17f95b906..8b2b3046f779 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_GOLDFISH_H
 #define __LINUX_GOLDFISH_H
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 #include <linux/types.h>
 #include <linux/io.h>
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ac332f4deed9..6f436367dd16 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -32,6 +32,7 @@
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
+#include <linux/wordpart.h>
 #include <asm/byteorder.h>
 
 #include <uapi/linux/kernel.h>
@@ -47,34 +48,6 @@
 }					\
 )
 
-/**
- * upper_32_bits - return bits 32-63 of a number
- * @n: the number we're accessing
- *
- * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
- * the "right shift count >= width of type" warning when that quantity is
- * 32-bits.
- */
-#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
-
-/**
- * lower_32_bits - return bits 0-31 of a number
- * @n: the number we're accessing
- */
-#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
-
-/**
- * upper_16_bits - return bits 16-31 of a number
- * @n: the number we're accessing
- */
-#define upper_16_bits(n) ((u16)((n) >> 16))
-
-/**
- * lower_16_bits - return bits 0-15 of a number
- * @n: the number we're accessing
- */
-#define lower_16_bits(n) ((u16)((n) & 0xffff))
-
 void do_exit(long error_code) __noreturn;
 
 extern int get_option(char **str, int *pint);
diff --git a/include/linux/qed/common_hsi.h b/include/linux/qed/common_hsi.h
index 827624840ee2..11482394d7f3 100644
--- a/include/linux/qed/common_hsi.h
+++ b/include/linux/qed/common_hsi.h
@@ -11,6 +11,7 @@
 #include <asm/byteorder.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
+#include <linux/wordpart.h> // for upper_32_bits()
 
 /* dma_addr_t manip */
 #define PTR_LO(x)		((u32)(((uintptr_t)(x)) & 0xffffffff))
diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
index c9e6bd773ebd..a73f0c84a03a 100644
--- a/include/linux/wordpart.h
+++ b/include/linux/wordpart.h
@@ -10,4 +10,32 @@
  */
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
+
+/**
+ * upper_16_bits - return bits 16-31 of a number
+ * @n: the number we're accessing
+ */
+#define upper_16_bits(n) ((u16)((n) >> 16))
+
+/**
+ * lower_16_bits - return bits 0-15 of a number
+ * @n: the number we're accessing
+ */
+#define lower_16_bits(n) ((u16)((n) & 0xffff))
+
 #endif // _LINUX_WORDPART_H
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 47a6be467004..05002792b078 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -7,7 +7,7 @@
 #define _UVERBS_IOCTL_
 
 #include <rdma/uverbs_types.h>
-#include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
+#include <linux/wordpart.h>
 #include <linux/uaccess.h>
 #include <rdma/rdma_user_ioctl.h>
 #include <rdma/ib_user_ioctl_verbs.h>
diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
index 173e4049d963..b01d8c0ac204 100644
--- a/include/soc/fsl/bman.h
+++ b/include/soc/fsl/bman.h
@@ -31,6 +31,8 @@
 #ifndef __FSL_BMAN_H
 #define __FSL_BMAN_H
 
+#include <linux/wordpart.h> // for upper_32_bits()
+
 /* wrapper for 48-bit buffers */
 struct bm_buffer {
 	union {
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 0d3d6beb7fdb..c5230a844114 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -33,6 +33,7 @@
 
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/wordpart.h> // for upper_32_bits()
 
 /* Hardware constants */
 #define QM_CHANNEL_SWPORTAL0 0
-- 
2.39.2


