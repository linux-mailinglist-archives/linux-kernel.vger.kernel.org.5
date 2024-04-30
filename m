Return-Path: <linux-kernel+bounces-164268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C86D8B7B94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2361F23845
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D11173321;
	Tue, 30 Apr 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CZ7oP5m6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D1BE49
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490992; cv=none; b=X+N/i3pN0MPbM0iPwPnablvciTGn7ZGFXFa3+PDa4x/LQgwlcOnh35VXcsYr6IFGLV6J7dNUjdnecR/IL5G09nyKD/it7/2+lMjX4eKzM3Gbn0X8fLJuaYVBB6B1HjmxvWWZDp6lwjl8V664RRupyG47aBVyS6D7IoamoG9W5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490992; c=relaxed/simple;
	bh=MzBSWBmF9FZNiibJu8W5sVdWX8m51Jd7d3qV/xtobVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIw6477FoK+XqNkvoKgFLXB/HeJVJGjeUV5QGfazTEufcpUQ3PQrZStajHWu1oHCQh6OEd+dcV0gjM7vQqimch3TbMSNpVC7sVhsuOZD3LPUE+1rp1pQzDLtkCUW6BPuKRzwNRsh4zG0gysgHKTJAe4pw8XEqSa6l52b8EAs5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CZ7oP5m6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5200afe39eso654681866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490987; x=1715095787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7AAE6U0hIueYZo00DVr4FEF5+iAzLopZ2BZK5Ba1WU=;
        b=CZ7oP5m6l+bbCLUcv+nAIhDOjORSSrFB7/CEiBRGXCX0bOwfBVKFbmHY8Aao9libj8
         RJNqCiCDRSo4oEpuedJa7UkJh0vYenH7BDGHlOFNsdCVPpT6N8q3V5zcH9mosFUI5Trl
         TarIfxpSA4AKX019ShOy0cREZPW9QLaGNqPa7JCoEyeSq+dog8BIZWclltcPUBUrvNK2
         mMfsFQnViDUOsiDHu3LxDCzTr9Ch/gyeKDeON5mom0RxKhWQwtR8P4+9FuX4TMLwCBlM
         omWCgqj2afi3pqn1iH6cZRCF2ijmCJiNzAJ/878iwTejjfB+rXiyYXAHwRxLfK/bll1Q
         X8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490987; x=1715095787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7AAE6U0hIueYZo00DVr4FEF5+iAzLopZ2BZK5Ba1WU=;
        b=Rhu2qzgUjP2bpbDgW1OVkb2gM6evGlhp8+9CtdVys8gn9dfjxpiXYTJ6ehLLe2SGfP
         9zo6RUAoTxD0BxyHq59egQ45hB1xmDZRm9cz3tVOCSBe/+ofrvi3k+TdG+1o1tAaih17
         mJYnWf/2/xMTTd8B5KzKAk8PPxWJ8QGARtIXZpW0dm9sPj1yQzOFhdQYNGtsLRpQyy5O
         0FGZkdNHRqKq2AioMTuSAny5wjxhZ1gGTInEepAa8XGRST/WTihTm8jCZz5LS9rSSPDK
         DIwtV5O8k8en4UZOWgCTyqVp30tvd8u64BKQZwgn6AFiZ4BG/W3EdWKbyZQbGb6zGUJR
         Qnsw==
X-Forwarded-Encrypted: i=1; AJvYcCXMQu5Z5tnfZXroN3O0O5RH03UNRS77/Yq+UjkOLo4+1VXuMzesCEzcrzcaE8V9nkGFAn0MMNYbhKidxc16l154MeNHxEPMlJ3dwVHL
X-Gm-Message-State: AOJu0YyBIJoBFHxj90PBGHd/tIkVcFKs6/bIa8LG5mnMLIFIfoh2Ev/N
	Wr0kv7n+yex/AqB0kMD4BOSp28R4Qsq2N9CoeR3rUCAhGbi23KHZUNexfrUEYXw=
X-Google-Smtp-Source: AGHT+IEL02VqOtLdEk+EVBHDA9MIr+u+/Djgcp6+FagOcorAt14WPaNWE6uwh2bbxQJznLeU9lSh5w==
X-Received: by 2002:a17:906:2451:b0:a58:ebe0:49a6 with SMTP id a17-20020a170906245100b00a58ebe049a6mr29249ejb.63.1714490987521;
        Tue, 30 Apr 2024 08:29:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:46 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 01/15] drivers: add missing includes on linux/mm.h (and others)
Date: Tue, 30 Apr 2024 17:29:17 +0200
Message-Id: <20240430152931.1137975-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430152931.1137975-1-max.kellermann@ionos.com>
References: <20240430152931.1137975-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After developing the other patches in this series, I had lots of build
failures because "#include <linux/mm.h>" was missing.  This patch
fixes those build failures by adding the missing "#include" lines.  To
allow bisects, it is ordered before the others.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm/mm/iomap.c                                       | 3 +++
 drivers/comedi/comedi_buf.c                               | 1 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c | 1 +
 drivers/dma/bcm2835-dma.c                                 | 1 +
 drivers/dma/dma-axi-dmac.c                                | 1 +
 drivers/dma/sh/rcar-dmac.c                                | 1 +
 drivers/firmware/qcom/qcom_scm-legacy.c                   | 1 +
 drivers/firmware/qcom/qcom_scm-smc.c                      | 1 +
 drivers/firmware/raspberrypi.c                            | 1 +
 drivers/iio/buffer/industrialio-buffer-dma.c              | 1 +
 drivers/iommu/iommufd/ioas.c                              | 2 ++
 drivers/iommu/iommufd/selftest.c                          | 1 +
 drivers/media/platform/mediatek/vpu/mtk_vpu.c             | 1 +
 drivers/media/platform/ti/omap/omap_voutlib.c             | 1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c                          | 1 +
 drivers/misc/fastrpc.c                                    | 1 +
 drivers/misc/genwqe/card_dev.c                            | 1 +
 drivers/misc/uacce/uacce.c                                | 1 +
 drivers/mtd/spi-nor/core.h                                | 2 ++
 drivers/pci/p2pdma.c                                      | 1 +
 drivers/pci/pci.c                                         | 1 +
 drivers/remoteproc/remoteproc_core.c                      | 1 +
 drivers/soc/qcom/rmtfs_mem.c                              | 1 +
 drivers/spi/spi-aspeed-smc.c                              | 1 +
 drivers/spi/spi-bcm2835.c                                 | 2 ++
 drivers/spi/spi-intel.c                                   | 1 +
 drivers/virtio/virtio_ring.c                              | 1 +
 include/linux/huge_mm.h                                   | 2 ++
 include/linux/iommu.h                                     | 1 +
 include/linux/nvme-keyring.h                              | 2 ++
 include/linux/page-flags.h                                | 3 +++
 include/linux/scatterlist.h                               | 6 ++++++
 include/linux/vmstat.h                                    | 1 +
 include/scsi/scsicam.h                                    | 3 +++
 kernel/dma/ops_helpers.c                                  | 1 +
 kernel/dma/remap.c                                        | 1 +
 kernel/rcu/rcutorture.c                                   | 1 +
 mm/dmapool.c                                              | 1 +
 38 files changed, 54 insertions(+)

diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index 415d0a454237..9873d8156908 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -29,6 +29,9 @@ EXPORT_SYMBOL(ioport_unmap);
 #endif
 
 #ifdef CONFIG_PCI
+
+#include <asm/pgtable.h> // for VMALLOC_*
+
 unsigned long pcibios_min_io = 0x1000;
 EXPORT_SYMBOL(pcibios_min_io);
 
diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 393966c09740..23b07ebc97ca 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/comedi/comedidev.h>
+#include <asm/pgtable.h> // for PAGE_KERNEL*
 #include "comedi_internal.h"
 
 #ifdef PAGE_KERNEL_NOCACHE
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
index ee0b5079de3e..c9b2787baac7 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation */
 #include <linux/dma-mapping.h>
+#include <linux/fs.h> // for simple_read_from_buffer()
 #include <linux/kernel.h>
 #include <linux/string_helpers.h>
 #include <linux/stringify.h>
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..1d971999fd39 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <asm/pgtable.h> // for ZERO_PAGE()
 
 #include "virt-dma.h"
 
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index bdb752f11869..7538459f1d8a 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 40482cb73d79..784da367665c 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
diff --git a/drivers/firmware/qcom/qcom_scm-legacy.c b/drivers/firmware/qcom/qcom_scm-legacy.c
index 029e6d117cb8..01e082c7163c 100644
--- a/drivers/firmware/qcom/qcom_scm-legacy.c
+++ b/drivers/firmware/qcom/qcom_scm-legacy.c
@@ -5,6 +5,7 @@
 
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/errno.h>
diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 16cf88acfa8e..a5c74d8996fe 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -5,6 +5,7 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index ac34876a97f8..b7858014a59c 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -10,6 +10,7 @@
 #include <linux/kref.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 13b1a858969e..d3e82d25df70 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 742248276548..40c4942406cd 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -5,6 +5,8 @@
 #include <linux/interval_tree.h>
 #include <linux/iommufd.h>
 #include <linux/iommu.h>
+#include <linux/capability.h>
+#include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
 
 #include "io_pagetable.h"
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7a2199470f31..bcecf44681fe 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -5,6 +5,7 @@
  */
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/mm.h> // for GUP_PIN_COUNTING_BIAS
 #include <linux/xarray.h>
 #include <linux/file.h>
 #include <linux/anon_inodes.h>
diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 724ae7c2ab3b..f248e4194b49 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -8,6 +8,7 @@
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/mm.h> // for totalram_pages()
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
diff --git a/drivers/media/platform/ti/omap/omap_voutlib.c b/drivers/media/platform/ti/omap/omap_voutlib.c
index 0ac46458e41c..3b653b49cc48 100644
--- a/drivers/media/platform/ti/omap/omap_voutlib.c
+++ b/drivers/media/platform/ti/omap/omap_voutlib.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index d4a96137728d..c5a39a8189bf 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/panic_notifier.h>
 #include <linux/kref.h>
+#include <linux/mm.h> // for io_remap_pfn_range()
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4c67e2c5a82e..e0549b4b1c33 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -10,6 +10,7 @@
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
+#include <linux/mm.h> // for find_vma()
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 4441aca2280a..ce3acb938ca6 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -17,6 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/mm.h> // for struct vm_operations_struct
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/string.h>
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index bdc2e6fda782..af815b8a718e 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -2,6 +2,7 @@
 #include <linux/compat.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/mm.h> // for struct vm_operations_struct
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 442786685515..c113ed8e8751 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -9,6 +9,8 @@
 
 #include "sfdp.h"
 
+#include <linux/sizes.h> // for SZ_*
+
 #define SPI_NOR_MAX_ID_LEN	6
 /*
  * 256 bytes is a sane default for most older flashes. Newer flashes will
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500..ef37ea6c09fc 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/genalloc.h>
 #include <linux/memremap.h>
+#include <linux/mm.h> // for VM_MAYSHARE
 #include <linux/percpu-refcount.h>
 #include <linux/random.h>
 #include <linux/seq_buf.h>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59aaebb67c0b..cec668988ac6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -25,6 +25,7 @@
 #include <linux/logic_pio.h>
 #include <linux/pm_wakeup.h>
 #include <linux/device.h>
+#include <linux/pgtable.h> // for pgprot_device()
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f276956f2c5c..938220fe29f5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -18,6 +18,7 @@
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/panic_notifier.h>
diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index df850d073102..15c2f6e5eaff 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/cdev.h>
 #include <linux/err.h>
+#include <linux/mm.h> // for remap_pfn_range()
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index bbd417c55e7f..e45f64761e5e 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h> // for SZ_*
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1b9b1235787..d8ed5575a9c6 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -33,6 +33,8 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
+#include <asm/pgtable.h> // for ZERO_PAGE()
+
 /* SPI register offsets */
 #define BCM2835_SPI_CS			0x00
 #define BCM2835_SPI_FIFO		0x04
diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 3e5dcf2b3c8a..cf8e4f1c4d93 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -8,6 +8,7 @@
 
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/sizes.h> // for SZ_*
 
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 947098b6a65e..b83e3a7293f6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -12,6 +12,7 @@
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
 #include <linux/kmsan.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c8d3ec116e29..10366254617f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -7,6 +7,8 @@
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 
+#include <asm/page.h> // for pmd_t
+
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..d56e17a0fdf6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/uaccess.h> // for copy_struct_from_user()
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index e10333d78dbb..9e033850b967 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -6,6 +6,8 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
+#include <linux/key.h>
+
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
 key_serial_t nvme_tls_psk_default(struct key *keyring,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 104078afe0b1..f05a3925caf7 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -12,6 +12,9 @@
 #ifndef __GENERATING_BOUNDS_H
 #include <linux/mm_types.h>
 #include <generated/bounds.h>
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#include <linux/jump_label.h> // for DECLARE_STATIC_KEY_FALSE
+#endif
 #endif /* !__GENERATING_BOUNDS_H */
 
 /*
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 77df3d7b18a6..0516e64dc03e 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -8,6 +8,12 @@
 #include <linux/mm.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_UML
+#include <asm/pgtable.h> // for virt_to_page(), page_to_phys()
+#else
+#include <asm/page.h> // for virt_to_page(), page_to_phys()
+#endif
+
 struct scatterlist {
 	unsigned long	page_link;
 	unsigned int	offset;
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 735eae6e272c..86bdcfe319ae 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
+#include <linux/mm.h> // for folio_zone(), folio_nr_pages()
 #include <linux/mmzone.h>
 #include <linux/vm_event_item.h>
 #include <linux/atomic.h>
diff --git a/include/scsi/scsicam.h b/include/scsi/scsicam.h
index 08edd603e521..6eb9fb7a57d0 100644
--- a/include/scsi/scsicam.h
+++ b/include/scsi/scsicam.h
@@ -13,6 +13,9 @@
 
 #ifndef SCSICAM_H
 #define SCSICAM_H
+
+#include <linux/types.h> // for sector_t
+
 int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip);
 bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3]);
 unsigned char *scsi_bios_ptable(struct block_device *bdev);
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index af4a6ef48ce0..641363b13bb9 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -4,6 +4,7 @@
  * the allocated memory contains normal pages in the direct kernel mapping.
  */
 #include <linux/dma-map-ops.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 
 static struct page *dma_common_vaddr_to_page(void *cpu_addr)
 {
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 27596f3b4aef..87b3c874d370 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014 The Linux Foundation
  */
 #include <linux/dma-map-ops.h>
+#include <linux/mm.h> // for vmap(), PAGE_ALIGN()
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index cafe047d046e..aa65850ac40b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -47,6 +47,7 @@
 #include <linux/oom.h>
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/mm.h> // for mem_dump_obj()
 #include <linux/nmi.h>
 
 #include "rcu.h"
diff --git a/mm/dmapool.c b/mm/dmapool.c
index f0bfc6c490f4..b8e23fdc81d7 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/export.h>
+#include <linux/mm.h> // for want_init_on_alloc()
 #include <linux/mutex.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
-- 
2.39.2


