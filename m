Return-Path: <linux-kernel+bounces-66557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF4855E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4951F23D24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172231B952;
	Thu, 15 Feb 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RG4slG63"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C917741
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989823; cv=none; b=mVW8D1D1Std04weHUPI3dZCfmEwd9tOJC+ENNzfJcP1i920gsuk21kN+RcntiIoXsAWQp9vw8428qL5duh9NQKmM+qFNn1azCQsjw/kTjwQgTENazMm1Ajzklmpq6L8rWnmeYjcF9SMokxHY06pWbsaJXGHn0D9H206utYLZOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989823; c=relaxed/simple;
	bh=aHKYH9vQ7JcKnIwHUJk+K0PHkYd1aK39zza+S+q5sZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjaCNOOuH3X55naYBpChwUx84//A8ZrrHrWbGa6DZmLj0OPuHmQzTobjiWRA8YB0YU96+tv3BeAqwRvt6SpgGXsJ8lURv52JxTRKO/dxOVrKO/ZoGNkIPR0YMpEq3olzmZ2dYJF8XhWEgvkbrX7wl+RSZ4rKyczHvkhTK4wsICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RG4slG63; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3da5bf7f9cso26000166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989818; x=1708594618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7dUZOBLu7d+3R+DKHO2TzD/GDIM7CR+ZFQySZN2YdQ=;
        b=RG4slG634Nd/V5uD81rPAdcXUVt/QNjQV8C1lWfF2KjNp1tbz7pppnO5EKBvpYzBF0
         nK0cbP3PTk1KOZFRCKkhvMsPJ+F/LoBNMVjs16XWI1SkF8xiKf1f4kzzkLLA7n7wvg6O
         YbgKdlbaabWtUCxofsIlCjNy2mJBxCqgel4W9l6n44FMUyCzHl0HBbTfKDAPt7gp+5oz
         FGgZghhljJtlLzy/7J5NzQG98aIRV3Dr7nXjoWSJmZ9TNYKNCTD83TTRpyiuqRNgeiHV
         H9xtXa3HGK3aBOi61jz9qSBGaqP1p7/B3gGhumJPozxgiNl8V4HQO3aBI55Jgy7BWkP2
         g9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989818; x=1708594618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7dUZOBLu7d+3R+DKHO2TzD/GDIM7CR+ZFQySZN2YdQ=;
        b=dM13CgCUEevSHn2uKOfOHqKrpDlynEya83Yjq2zQ1YHT6NKQNxAEbbZuMKAVXHQaJ9
         RwTdbSbzsZ7VOPo5lAJGI1EwUQ8kydc/Or3l3MDHRumlIthQ48iL0wA5dCdtTlegT5CP
         thDjOWADXxeKq2Vv9Uuk8pACAjpsvUQPwum3M8CGXQHV5/oivmjqjD4+M+gf6O+qH09i
         py/l6EwjdZpotEcAtGicmjPnLj8Ckly5TzQCFHXsgTrexXg75ZT8Z1j1fko/h7HrXpUy
         iPi5yvCmCSfJkC2WX6cl2NC4PF+6Q/TMYH61qPJMon/cwOrGo2/vfoiIHRE8K+ZFbuH4
         wjsQ==
X-Gm-Message-State: AOJu0YxYg1OVXy5JB2J5zpN1gjdFbMTBwLbIXe8NhpXtVVlDCpxqmw23
	KBmNLKteq48LfS4qOvbCH2X93Ov6Xe/hxakMKe0x1wtoUk2kLVxG+0sKjpnFyPRKfWnOmIV9RmY
	Z
X-Google-Smtp-Source: AGHT+IFUXii2K0AUUpMDVe1jokORv8xAqgKb9r+fePYUohnjQor5QUILIeJjCrEzoMJ9tSh3SHsKWw==
X-Received: by 2002:a17:906:7196:b0:a3d:1899:ec3 with SMTP id h22-20020a170906719600b00a3d18990ec3mr884874ejk.35.1707989818387;
        Thu, 15 Feb 2024 01:36:58 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:36:57 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 3/8] include linux/wordpart.h in various sources that need it
Date: Thu, 15 Feb 2024 10:36:41 +0100
Message-Id: <20240215093646.3265823-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215093646.3265823-1-max.kellermann@ionos.com>
References: <20240215093646.3265823-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit edf2f6fb51bc ("kernel.h: Move upper_*_bits() and
lower_*_bits() to wordpart.h"), the lower/upper_*_bits functions can
be found in that header, and all sources that use those functions
should include the header that provides it.

This is just the beginning, many more sources are still missing, but a
large patch adding the "#include" everywhere (700+ sources) would be
hard to review.

(Found with "git grep -E '\b(upper|lower)_(16|32)_bits\('")

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm64/include/asm/syscall.h   | 1 +
 arch/arm64/kvm/handle_exit.c       | 1 +
 drivers/bus/uniphier-system-bus.c  | 1 +
 drivers/irqchip/irq-gic-v3-its.c   | 1 +
 drivers/spi/spi-pci1xxxx.c         | 1 +
 fs/ext4/super.c                    | 1 +
 fs/hfs/hfs_fs.h                    | 1 +
 fs/hfsplus/hfsplus_fs.h            | 1 +
 fs/notify/fanotify/fanotify_user.c | 1 +
 fs/open.c                          | 1 +
 fs/ufs/util.h                      | 1 +
 include/linux/dma-fence.h          | 1 +
 include/linux/qed/common_hsi.h     | 1 +
 include/rdma/uverbs_ioctl.h        | 2 +-
 include/soc/fsl/bman.h             | 2 ++
 include/soc/fsl/qman.h             | 1 +
 16 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index ab8e14b96f68..e5f462cc1a54 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -8,6 +8,7 @@
 #include <uapi/linux/audit.h>
 #include <linux/compat.h>
 #include <linux/err.h>
+#include <linux/wordpart.h> // for lower_32_bits()
 
 typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 617ae6dea5d5..91bd5b701acf 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -10,6 +10,7 @@
 
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 
 #include <asm/esr.h>
 #include <asm/exception.h>
diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index cb5c89ce7b86..964f31287d3c 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -10,6 +10,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/wordpart.h> // for upper_32_bits()
 
 /* System Bus Controller registers */
 #define UNIPHIER_SBC_BASE	0x100	/* base address of bank0 space */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 201055382bd1..94f917352ac6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -29,6 +29,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 969965d7bc98..775673861c79 100644
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
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e487623f9456..6a7686343bd0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -48,6 +48,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index b5a6ad5df357..514d3856aa27 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/wordpart.h> // for lower_32_bits()
 #include <linux/workqueue.h>
 
 #include <asm/byteorder.h>
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 7ededcb720c1..79cac82d050e 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
+#include <linux/wordpart.h> // for lower_32_bits()
 #include "hfsplus_raw.h"
 
 #define DBG_BNODE_REFS	0x00000001
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fbdc63cc10d9..9ca5adbf39ae 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -20,6 +20,7 @@
 #include <linux/memcontrol.h>
 #include <linux/statfs.h>
 #include <linux/exportfs.h>
+#include <linux/wordpart.h> // for upper_32_bits()
 
 #include <asm/ioctls.h>
 
diff --git a/fs/open.c b/fs/open.c
index a7d4bb2c725f..b006de16a15a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -34,6 +34,7 @@
 #include <linux/compat.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/filelock.h>
+#include <linux/wordpart.h> // for upper_32_bits()
 
 #include "internal.h"
 
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 0ecd2ed792f5..0d4b89794cc5 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -9,6 +9,7 @@
 
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/wordpart.h> // for lower_32_bits()
 #include "swab.h"
 
 /*
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index e06bad467f55..02ad83247ea8 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -22,6 +22,7 @@
 #include <linux/printk.h>
 #include <linux/rcupdate.h>
 #include <linux/timekeeping.h>
+#include <linux/wordpart.h> // for lower_32_bits()
 
 struct dma_fence;
 struct dma_fence_ops;
diff --git a/include/linux/qed/common_hsi.h b/include/linux/qed/common_hsi.h
index 827624840ee2..fa9cc2be077f 100644
--- a/include/linux/qed/common_hsi.h
+++ b/include/linux/qed/common_hsi.h
@@ -11,6 +11,7 @@
 #include <asm/byteorder.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 
 /* dma_addr_t manip */
 #define PTR_LO(x)		((u32)(((uintptr_t)(x)) & 0xffffffff))
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 06287de69cd2..5ed57a660ead 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
-/*
+ /*
  * Copyright (c) 2017, Mellanox Technologies inc.  All rights reserved.
  */
 
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


