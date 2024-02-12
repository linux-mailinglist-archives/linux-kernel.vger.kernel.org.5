Return-Path: <linux-kernel+bounces-61494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458CC8512DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4A4B211B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0401E3F9D3;
	Mon, 12 Feb 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="d0QhNL/m"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461B3D3BA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738951; cv=none; b=G8TIRxWoQUWGpvvqWSm3TkNtlEXB5+WA+zjgc+U9k/11bNXTfyGkbX7I7vgHQh4cSiRvgmt7g4llOoNvWiJ/LFrsUlCjbRYZobLmOERS4PuRtllnY2rbT9Ih50YmEU91Jn8WXsL4f2CDZ3gSB2Y3fPayVxeDjV8p3yp2YYjoXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738951; c=relaxed/simple;
	bh=oqTjgZO+W1UzsOe79uc/PF43jC2mJyk1Zod+Zl8WRFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BvK5FRWjuEjMf9A/OLCKcLOyagCF7w+vCrEeUlSnGz13/2wNd7ibDO54A2a2j1pvF51tyyP+N6PzGJvsGReJnYiZKCgiVHqyk8pRjG9s//99R2IFghq+s8b8JIv2jN2H3Y3BI2l5t3eGGf9yA300pIz9UWa9FioNwyhKXp/xris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=d0QhNL/m; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so389521966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738946; x=1708343746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqBKyioLpQMwRvtX600aSZdz3rsEJrSU++0tqKocH9w=;
        b=d0QhNL/mBW/YvGuuSYFBdqx83fMDvQ74MY0YKFgcdDSgGBNfWico0s2dWd9jPU7xvz
         KBQDkX3MEOppxO1KF5SxueiYx/tFlBBnQA8RcUdubaHKKsMOXrWOw9/rILhcxxWaVdxu
         RD5uSKF9oz0d16mo3Af3aX9DknhaJS6n2OMBmoDAyfsaWNo6E/bWjPCpxx9+GGB/S8YW
         fiobHmZCK/8D4VnQfOZ/9L+PEK3Ufb1fSUgx4yZzxfehOtsFBQMsW0t4q+bv1kV6BY5I
         TKRS4re8Z3I0dLaZvkdM/qIQJM8ZuobGIDBpGIcxPRZicSpue1fV9BtQ03MDOU8HyrKd
         Sy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738946; x=1708343746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqBKyioLpQMwRvtX600aSZdz3rsEJrSU++0tqKocH9w=;
        b=AOtN507W+1LchAPSZ+56M6MDU2a5VeOCDR2Hwwrlws9DmHiJXeCCkMIZnnpcFUqvnd
         FHGYnIyPpcQ3wT8GlzF5Zjx234xf1/4luE1WP/HIh4z1QdAew2W+xw5gYv2ahXo5pqJ/
         mZIegfgcVV46sysLQEIWe6CehuJvODV+FL5uoVByM+UhQYbat6xsNBsJ5DhWTdHJQrUb
         JTtqKMoSPUf1XjapGFnzg/soZFz1lBZ0eTKrf5PUOXVcTYZs8DM9OURCbzwlymgeP7Vi
         1k6kzZpGRnUcPBJ6SUH0UqSDxvaAbjxVNysHH3S0Ra/khASJtGv3b0lh1qgMK1fWgLD3
         ZuFg==
X-Gm-Message-State: AOJu0Ywl8wDQfHRbEsSWKjkrCK/3NgufblyAVpT1AQW378K6n85i0Hiq
	6qRtU/EexaAVUj7IUcrPXktSoEJ2k8YbjvKBG5Emf3Khd9E1v3a9PpxkyrwXfQxPq1O8jgOTKdb
	x
X-Google-Smtp-Source: AGHT+IGmr0uAMaHAq6yMGm25npRpNpl1S9HpS8WnCaObRnt+gaeusxlSMbezO7hez/IlK2JHZ2Ba8A==
X-Received: by 2002:a17:906:3489:b0:a3c:e69:a62b with SMTP id g9-20020a170906348900b00a3c0e69a62bmr4723747ejb.26.1707738945874;
        Mon, 12 Feb 2024 03:55:45 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:45 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 33/35] linux/kernel.h: move upper/lower_*_bits macros to wordpart.h
Date: Mon, 12 Feb 2024 12:54:58 +0100
Message-Id: <20240212115500.2078463-34-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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
 include/rdma/uverbs_ioctl.h       |  3 ++-
 include/soc/fsl/bman.h            |  2 ++
 include/soc/fsl/qman.h            |  1 +
 16 files changed, 45 insertions(+), 37 deletions(-)

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
index 049f381b16c0..6d7776438ef6 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -7,8 +7,9 @@
 #define _UVERBS_IOCTL_
 
 #include <rdma/uverbs_types.h>
-#include <linux/kernel.h> // for u64_to_user_ptr(), upper_32_bits(), lower_32_bits()
+#include <linux/kernel.h> // for u64_to_user_ptr()
 #include <linux/uaccess.h>
+#include <linux/wordpart.h>
 #include <rdma/rdma_user_ioctl.h>
 #include <rdma/ib_user_ioctl_verbs.h>
 #include <rdma/ib_user_ioctl_cmds.h>
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


