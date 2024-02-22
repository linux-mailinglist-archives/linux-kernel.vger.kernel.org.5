Return-Path: <linux-kernel+bounces-76449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A80885F77B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011CF282912
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467547A6C;
	Thu, 22 Feb 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LRK/ub8n"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD938FB2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602667; cv=none; b=GkbTdpAVz/JG5cJ77EnEeXHGy5P+ruiAITIjGijMymXRjD0irHXhTF5v2dD5d0G7AmxsWH8pIYUTTIdbhjYMx/wJp/LTK0B4/nRTT2VajEqbvXlSrfR6naZA3w3pxFuMjTCbe4zb21+VpgGDvOJ7DJpswt3LY60GIlqgTmNcleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602667; c=relaxed/simple;
	bh=Ap8Xe20ngfUIVvUMGOsadC9GpgU9Wf4no7RRx7xF/vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pt8SXU/ET6yPSsOheQph2m/7GEgczTU1QSgJPEHCKMyiecDs9zkx9xFj45CWzlLXpYii3bYGlv5ld/+B5dr/A3kgG+nCLUXzO3Yi+lpJeQXERKYww2tV3K2CHKGe/tmXBgy+GkdG31MXnTVpwNnARlRyoUf9bTVCiPIZnWyL5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LRK/ub8n; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d18931a94so1383092f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602663; x=1709207463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDtDdAHhdomsee3Ex/DKrZGnvTgKe9aa55S2NGfs23I=;
        b=LRK/ub8ngZ8g/37EQpdkfz1Wv8fQ87zls5DWsN1vTcaYdzdFbPfcvxRbdyIn63XiEi
         lYXZEgX0E26YgYKI0fn2hKJPjkvZYMCzLyAKrSHwmRJm4Z8rakCHlAK73WgP8RByoq9R
         Jch3xX8CbyunAfmMFDzZDAPWKZa422Rqotms7gKYLElLLcXTlgA0/M9K11kqgX1eRR1t
         kJY4xPVcDhM1EsUn7hACYvo9ft9pueDruTTC8QUZ92HUr3tx1zQzLQaNYOqgAENyeRqR
         ClzEa11qfcZgIUfvB26vHs6DM0p6ep1QsGJw6UWPegYi9WRK2+ZXoyKszKyJ/iaK/fad
         md4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602663; x=1709207463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDtDdAHhdomsee3Ex/DKrZGnvTgKe9aa55S2NGfs23I=;
        b=XFiBxzIbLLDFyKbVP7eTf9/gJ5WDvfJZuYKjOMnE18BsxDveGpXjq6pYuJPmYqpRKq
         0ycHUg9EScgc9ko7GK8WQfaTQeQuzfQ89LDPAnssyXdCtzUSvIaK09V84llwh2P9b8Wb
         rs/Q5mEmdsCnQ4bh2aSdVpg3hMOkseDxbefEPzb5PY9jx81uymYCohx1pSbK5go+Jlkv
         I47SmPXh7cCnTQwKRtst3AYC5fsfFDbiMjFIwdFko70vnUedMmt9nb4XMOL6cB0rIRnF
         r8d0HE1wFi33Cp5bcUZHtk0NtfmzppRVFGJMMm0a8TN1vX9tv0l8fVBblc8kyE8qDSXk
         JOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ui978v53rbdHzMlz9sLrxe6msmy5JYqh+F8MKDho+0ub730MgcL4GYkQLjolOR0mTAeW5ooB4XLpgl+5U3bp0fEnZcBgcR1+a4m1
X-Gm-Message-State: AOJu0YyldmZ2rdB5t4YpMk7QvXhoqQzZYPVgMDeD7ovAyT9LhbvJnBRh
	fURktQVJbq3aObEj0Oa4zCM9zBzIiew6EGX/f9Yqxjfl+gxftj09sc16sf68e6RAVcmyDnVp/m0
	f
X-Google-Smtp-Source: AGHT+IHpK0leZ4EwBsfTlfXs6Mp/6tOFCXoxjGX+x0XlqG94LlztrxXkuNNitFI3p/6e/W+fpRz9wA==
X-Received: by 2002:a05:6000:38d:b0:33d:8cb5:1429 with SMTP id u13-20020a056000038d00b0033d8cb51429mr2153581wrf.27.1708602663111;
        Thu, 22 Feb 2024 03:51:03 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:02 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 01/14] drivers: add missing includes on linux/mm.h (and others)
Date: Thu, 22 Feb 2024 12:50:42 +0100
Message-Id: <20240222115055.1172877-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222115055.1172877-1-max.kellermann@ionos.com>
References: <20240222115055.1172877-1-max.kellermann@ionos.com>
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
 include/linux/scatterlist.h                               | 6 ++++++
 kernel/dma/ops_helpers.c                                  | 1 +
 kernel/dma/remap.c                                        | 1 +
 mm/dmapool.c                                              | 1 +
 33 files changed, 45 insertions(+)

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
index dbd26c3b245b..35701e9ec28e 100644
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
index d36c0e072954..0d11ff848a7f 100644
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
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..e3395a9bea81 100644
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
index de839fd01bb8..c49cd93b9c85 100644
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


