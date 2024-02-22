Return-Path: <linux-kernel+bounces-76448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E185F779
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C0E1F26493
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247646B83;
	Thu, 22 Feb 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ybw4Z8bt"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E411405D4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602667; cv=none; b=f9EwuMB4k2eL2tyhLoutEawjt5afhSIby2Q++/pxEjtWH93F0cHBacw1gy4dJQhVQNVZBbK6C/Sfji1K2Q40aMxOqinfykPHmGDRbBVDIRlarb8ItY67jAiAobna6VEPHSu3USWBO5Eqkjg0jyMZf3RfF3l/wBpdVoJT3YS2R2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602667; c=relaxed/simple;
	bh=3IL2ZkYOqUafbNGw3RQkjvZe+8BWUuMVfyjeMypwKzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QqbzRDvOFZYRNS+wIYlakHt+8E/uRscIeeF9h3zIY02CsLL4/7QGuvfab2wqhk35+LLzCUBCUgRAWVKekSfHo1wUCPna48pFwKpscO8W9BprCTg+A8qH4jC4uu04uAdx07MtkIMnmeDk8G8a8NUsI5UrbYlTERgYcwwyGLebscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ybw4Z8bt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d2b354c72so3767544f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602662; x=1709207462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9uOmaPJWXMSPVMWYlCkc7A6Acu0xg6yxtT4dMRJGg8=;
        b=Ybw4Z8btc08e8Hfh88MBSRJMYkICJntOJDiV/xrJvUqxFP/RxdfXEHcgWjucqceskT
         7qvsC/OK918wK1wTc9tpkCISXLqLNOnCXHmqFY7ChNKWS/5eK2Iy0nyxtjXF96i/Wpcf
         +AjDv8fWz/Z118lmS6ox1j5ps+pEZ7HH+fMXwvoMLVeWybJYPTIedlYOhwnJkIcka/H+
         JRBT6n+q/lyK0NAyx8lTpVPAz0TpFLjHbVSJaQs2pe/Tn+r0w+8CQR6LW6Zkv49JbIlm
         oQfzKHPP3bBaRfK0vagCjCBtNL27QM3dOn8l0F9jJ/XiBmRajfNxw5uiGNj34eHnTsLk
         UgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602662; x=1709207462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9uOmaPJWXMSPVMWYlCkc7A6Acu0xg6yxtT4dMRJGg8=;
        b=aUlAy8zeH6P8PAUgXToAtEj0+c/m4IUm0/ZTdwrEUyVFRVfCHhVKvJyJ4qcxP/9ZRq
         RtMRec7labbVHtGOCI2b7KacxqMp2i4a1DHBcg+Lt06J7UjEjheUwtXI7J8jym2z+CQd
         BPjp+MxXG9CT/7eQ7OH8Em75Ydu0Px50G481nmBQt91V5aIoLGv7xpcFBolKrNWFLPyl
         AJAe29eA86Bveky1jkbkUSfk0yGPimYt3AUgpys8avPxueQILCJVKC5VTIrTRY1oQ4xx
         BjQmZxFYk7uTvWxUtNres6E8WJ4oi6pBWalzxtw3jdjnXGDTfiIg2SIu+rCfRsd6mXqL
         yrIw==
X-Forwarded-Encrypted: i=1; AJvYcCUDGWRMVewk3YRnxrdVrm84IIuEUFEY+2Pdx4kVomtyXSDrErKQN2talEpovCAVWkUKqmPl1bGOvlrNcrbEi8U4Mf1KmPllOuP3nU0P
X-Gm-Message-State: AOJu0YxIi9yy38oS2dv18QEATMBUwefxaHlNp8uMMF1Um/DV7iCXrgQh
	rn9mkljqV2+dBw2lpvMqdy+LobognU8aO66XVF4fUIuHff+znu2U/JSvm/0Bhc0=
X-Google-Smtp-Source: AGHT+IEvgIk/Nhw4gHfWzlO4k4QZfJ6Qjd2Y1lzMwtCvAEareQW2/qL8s/GuxCbB/x+Rr0gr6jsmVQ==
X-Received: by 2002:adf:eeca:0:b0:33a:ff66:fecc with SMTP id a10-20020adfeeca000000b0033aff66feccmr14741847wrp.26.1708602661906;
        Thu, 22 Feb 2024 03:51:01 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:01 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 00/14] Fast kernel headers: split linux/mm.h
Date: Thu, 22 Feb 2024 12:50:41 +0100
Message-Id: <20240222115055.1172877-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set aims to clean up the linux/mm.h header and reduce
dependencies on it by moving parts out.

The goal was to eliminate dependencies on linux/mm.h from other
popular headers such as highmem.h and dma-mapping.h, and I started by
checking which symbols were really used and moved those declarations
to separate slim headers.

---
v1 -> v2: added more explanations to commit messages; renamed several
  new headers from page_*.h to folio_*.h as suggested by Matthew
  Wilcox; rebase on linux-next; fix build failures on architectures
  um,nios2,hexagon by adding more missing includes

Max Kellermann (14):
  drivers: add missing includes on linux/mm.h (and others)
  include/drm/drm_gem.h: add poll_table_struct forward declaration
  linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
  linux/mm.h: move section functions to mm/page_section.h
  linux/mm.h: move page_address() and others to mm/page_address.h
  linux/mm.h: move folio_size(), ... to mm/folio_size.h
  linux/mm.h: move folio_next() to mm/folio_next.h
  linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
  linux/mm.h: move usage count functions to mm/folio_usage.h
  linux/mm.h: move page_zone_id() and more to mm/folio_zone.h
  linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
  linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
  linux/mm.h: move high_memory to mm/high_memory.h
  include: reduce dependencies on linux/mm.h

 MAINTAINERS                                   |   1 +
 arch/arm/include/asm/memory.h                 |   4 +
 arch/arm/include/asm/pgtable.h                |   2 +
 arch/arm/mm/iomap.c                           |   3 +
 arch/csky/include/asm/page.h                  |   1 +
 arch/hexagon/include/asm/mem-layout.h         |   4 +
 arch/m68k/include/asm/page_mm.h               |   1 +
 arch/m68k/include/asm/pgtable_mm.h            |   1 +
 arch/parisc/include/asm/floppy.h              |   1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h  |   4 +
 arch/powerpc/include/asm/nohash/32/pgtable.h  |   1 +
 arch/powerpc/include/asm/page.h               |   1 +
 arch/x86/include/asm/floppy.h                 |   1 +
 arch/x86/include/asm/pgtable_32_areas.h       |   4 +
 drivers/comedi/comedi_buf.c                   |   1 +
 .../qat/qat_common/adf_gen4_pm_debugfs.c      |   1 +
 drivers/dma/dma-axi-dmac.c                    |   1 +
 drivers/dma/sh/rcar-dmac.c                    |   1 +
 drivers/firmware/qcom/qcom_scm-legacy.c       |   1 +
 drivers/firmware/qcom/qcom_scm-smc.c          |   1 +
 drivers/firmware/raspberrypi.c                |   1 +
 drivers/iio/buffer/industrialio-buffer-dma.c  |   1 +
 drivers/iommu/iommufd/ioas.c                  |   2 +
 drivers/iommu/iommufd/selftest.c              |   1 +
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |   1 +
 drivers/media/platform/ti/omap/omap_voutlib.c |   1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   1 +
 drivers/misc/fastrpc.c                        |   1 +
 drivers/misc/genwqe/card_dev.c                |   1 +
 drivers/misc/uacce/uacce.c                    |   1 +
 drivers/mtd/nand/onenand/onenand_samsung.c    |   1 +
 drivers/mtd/spi-nor/core.h                    |   2 +
 drivers/pci/p2pdma.c                          |   1 +
 drivers/pci/pci.c                             |   1 +
 drivers/remoteproc/remoteproc_core.c          |   1 +
 drivers/soc/qcom/rmtfs_mem.c                  |   1 +
 drivers/spi/spi-aspeed-smc.c                  |   1 +
 drivers/spi/spi-bcm2835.c                     |   2 +
 drivers/spi/spi-intel.c                       |   1 +
 drivers/virtio/virtio_ring.c                  |   1 +
 include/drm/drm_file.h                        |   1 +
 include/linux/bio.h                           |   2 +
 include/linux/dma-mapping.h                   |   1 +
 include/linux/highmem-internal.h              |   2 +
 include/linux/highmem.h                       |   4 +-
 include/linux/huge_mm.h                       |   2 +
 include/linux/iommu.h                         |   1 +
 include/linux/mm.h                            | 582 +-----------------
 include/linux/mm/devmap_managed.h             |  37 ++
 include/linux/mm/folio_next.h                 |  27 +
 include/linux/mm/folio_size.h                 | 150 +++++
 include/linux/mm/folio_usage.h                | 177 ++++++
 include/linux/mm/folio_zone.h                 |  38 ++
 include/linux/mm/high_memory.h                |   7 +
 include/linux/mm/page_address.h               |  71 +++
 include/linux/mm/page_kasan_tag.h             |  66 ++
 include/linux/mm/page_section.h               |  23 +
 include/linux/mm/pfmemalloc.h                 |  52 ++
 include/linux/mm/vmalloc_addr.h               |  33 +
 include/linux/nvme-keyring.h                  |   2 +
 include/linux/scatterlist.h                   |   8 +-
 include/linux/skbuff.h                        |   4 +
 kernel/dma/ops_helpers.c                      |   1 +
 kernel/dma/remap.c                            |   1 +
 lib/scatterlist.c                             |   1 +
 mm/dmapool.c                                  |   1 +
 66 files changed, 777 insertions(+), 575 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h
 create mode 100644 include/linux/mm/folio_next.h
 create mode 100644 include/linux/mm/folio_size.h
 create mode 100644 include/linux/mm/folio_usage.h
 create mode 100644 include/linux/mm/folio_zone.h
 create mode 100644 include/linux/mm/high_memory.h
 create mode 100644 include/linux/mm/page_address.h
 create mode 100644 include/linux/mm/page_kasan_tag.h
 create mode 100644 include/linux/mm/page_section.h
 create mode 100644 include/linux/mm/pfmemalloc.h
 create mode 100644 include/linux/mm/vmalloc_addr.h

-- 
2.39.2


