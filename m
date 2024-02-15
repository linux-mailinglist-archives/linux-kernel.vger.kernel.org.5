Return-Path: <linux-kernel+bounces-67112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F1D8566A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7320287FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351A132C21;
	Thu, 15 Feb 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JqhowqsN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA2132486
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008975; cv=none; b=nt2zFAWypr35Y+gW5rlEid9q/KdBEyZC5DkgkMEwAyDUGvHLH3np8qpoEGuv9bwr1wmcwLS0uaJ/uHlijwrP/MKUtLDPzNYsOvjhWWYNAd2mDG7Ra7kNWrxj0zB18HK99ng/EWD7kQEpxKmO8GufLvCo6Z+t3JmQyWMMsvbkRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008975; c=relaxed/simple;
	bh=yo48K+OLdgpecXlpyx+V7fKNTco+Sad5NRmIDZmghJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gB4LOoNzzA9IuXkRJALL3ZUl5lvCfDC2i8+dR5FBgN8v2abagzRfS6HSArae726UZ83pnyw6+IaQ6O+4MwRuYg63kBPJEhyqy1kAlLJA3EqDe2vy8FMBQPPJNxzUmqZPB61yWQ1y0hhdpWWS0u2epxOtmNT7wPPC0zT4Q3mKRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JqhowqsN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d002bc6f7so92089966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008971; x=1708613771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oDI3MVOC+gdByL2sDhjkqrwTXc1Ta5YNXoQZrfiEOU=;
        b=JqhowqsNVOMPhWp2Jab46RkI09nRxeHmIjKgges18CYFmU+GP7ilAkMWSC/5c+YhmC
         Dia20wsiaMyBX5u7x6E/PmP2W70JiDLxdpHzaGk+hpvvO8AF6BAG3Cgk+fsYfJRj3iVa
         RewcZedx5u21T4yUkehGo94nI8y1hM3JtdSinQdSCnRxhUQcpFFixlCCPZyzOw3z56Hg
         GWNxBTvruhcngIhY6IcWkx9z16TLSPS4CKBzlk4QBRE8lLIimce6ysbtvhS9dSL3b1VU
         HyG5EnChqX15Kkg88Joe6HgKbw4PIFf8F9q57VK7152bsGICDF44VntmUPLeCYfWgOK9
         i7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008971; x=1708613771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oDI3MVOC+gdByL2sDhjkqrwTXc1Ta5YNXoQZrfiEOU=;
        b=cqamQw8alHyEu+UqKiRYc6aJNYO4VwTUJQezoQE1gJLiNiJQ+ALHfPZLe9kWqECqPF
         nCBsu+ZrO71/B8led++qmlefdEYLKAWaempHYQF53jvscu3mTrwhsIfTNRsaDcaYLYBT
         jmelQur4u4025tpTfhWmD9rR0GgYamcTn148f+fs2+YKlUkhTK9CmREE+FOa3LIvkcSu
         D72cc8TgmOboXyjgo9PYrZdFYEpjwqBFZnifVQ2O3GqeeOTgFjUJ3KyanA1i8Xe6xIt1
         6aCA6sbIlCg4pkJv7S2Yy+2kHxc9pV5VxnWU4hMdbilhPbrZ9OkHIvebX6fGrkT1Pe+D
         Tyvg==
X-Forwarded-Encrypted: i=1; AJvYcCUzJR8uxi0BCok3yqf37linFO8PbixbuW92Pglgd/8gbfpsKxrn5Trk7P667KGHZVWXVucp//gETbaAPdzqq5YOJMsAB+QMQwGnYqB7
X-Gm-Message-State: AOJu0YzY1pMePPXYP0A3men2ZnC+mh3Q/4M3k6vTE0Ey0WdFKo62jk6e
	6xzWrq9U2SdAoYO2ZuZdaP6AbH3FZct9LxjCmZghGoLTEyuj6RfYag9PfjXxtkFCa8ntEvlkRu4
	t
X-Google-Smtp-Source: AGHT+IEitTAWYbveUJr+PF64RWYCpKlCDLm/0Qp98VmYAYYJ+ah4ani7ivdRMaHpceHgriKsshu2vg==
X-Received: by 2002:a17:906:f343:b0:a3d:643f:1cd4 with SMTP id hg3-20020a170906f34300b00a3d643f1cd4mr1443557ejb.48.1708008970666;
        Thu, 15 Feb 2024 06:56:10 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:10 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 01/14] drivers: add missing includes on linux/mm.h (and others)
Date: Thu, 15 Feb 2024 15:55:49 +0100
Message-Id: <20240215145602.1371274-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215145602.1371274-1-max.kellermann@ionos.com>
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
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
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c | 1 +
 drivers/dma/dma-axi-dmac.c                                | 1 +
 drivers/dma/sh/rcar-dmac.c                                | 1 +
 drivers/firmware/qcom/qcom_scm-legacy.c                   | 1 +
 drivers/firmware/qcom/qcom_scm-smc.c                      | 1 +
 drivers/firmware/raspberrypi.c                            | 1 +
 drivers/iio/buffer/industrialio-buffer-dma.c              | 1 +
 drivers/iommu/iommufd/selftest.c                          | 1 +
 drivers/media/platform/mediatek/vpu/mtk_vpu.c             | 1 +
 drivers/media/platform/ti/omap/omap_voutlib.c             | 1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c                          | 1 +
 drivers/misc/fastrpc.c                                    | 1 +
 drivers/misc/genwqe/card_dev.c                            | 1 +
 drivers/misc/uacce/uacce.c                                | 1 +
 drivers/pci/p2pdma.c                                      | 1 +
 drivers/pci/pci.c                                         | 1 +
 drivers/remoteproc/remoteproc_core.c                      | 1 +
 drivers/soc/qcom/rmtfs_mem.c                              | 1 +
 drivers/spi/spi-bcm2835.c                                 | 2 ++
 drivers/spi/spi-intel.c                                   | 1 +
 drivers/virtio/virtio_ring.c                              | 1 +
 include/linux/iommu.h                                     | 1 +
 include/linux/nvme-keyring.h                              | 2 ++
 kernel/dma/ops_helpers.c                                  | 1 +
 kernel/dma/remap.c                                        | 1 +
 mm/dmapool.c                                              | 1 +
 27 files changed, 31 insertions(+)

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
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 4e339c04fc1e..0c98bf0e4b5d 100644
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
index 322aada20f74..beef5c4afef2 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kref.h>
 #include <linux/mailbox_client.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 5610ba67925e..b3ce8c4b101a 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8abf9747773e..710789a2add9 100644
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
index 7243604a82a5..885b873982e4 100644
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
index 03319a1fa97f..43448a97e502 100644
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
index cfc5b84dc9c9..e2afd992caa7 100644
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
index 49299b1f9ec7..5c3ca44aef42 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -12,6 +12,7 @@
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
 #include <linux/kmsan.h>
+#include <linux/mm.h> // for PAGE_ALIGN()
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8141a37556d5..25a3613a1f66 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/uaccess.h> // for copy_struct_from_user()
 #include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
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


