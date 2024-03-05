Return-Path: <linux-kernel+bounces-91932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768F8718C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B26D1C2161F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC574F894;
	Tue,  5 Mar 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Judfmg48"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEFA38DD1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629178; cv=none; b=p1BYaSXF8AcIZ9+hQiKb6s9ZXtdMOu6UhdFPl0rLqFvz7GbHGM6wPdyALIg/9Z0FPxdQkjgRWaGPdJJgy6PWllMMeBpaoNgo9gm34JDBBn8wYxe7PQfenfqp23dfNPCXKCYnJCYqhxik31CtvKKryr8ox0tjpsItQLb0McPyKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629178; c=relaxed/simple;
	bh=lu6SC+k07tAHlJfTt2dX9rhf8AqwN3jW2sUFbWLwSCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gUCjupxGqh6EN8Eo6W5EBpgbtw7kciwD9MTfd2M2gW93NJpXn4mf+iwR1KHLzJaQQI3+tJqkMSI1l+FrQ+66LHI+1HDRpyv4XAdyeanYViw1eUt8FHmoc12Vw3p/2vTpPx1qgcQ7nliCX+W6gXD2qTrFi/P5eKhb+mcBSMRsKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Judfmg48; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso7612917a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629174; x=1710233974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6C3Skxl3JZ6I3Bn9M0Rkt7P+AkMJ9BXocPtViO8HyA=;
        b=Judfmg484Fzv/n8WKJ7UiUZgOqJ4NP6TqtSMngqjLTuJGWQRkCcOpxfGXsP9J2kSzu
         kgybaO39VgeBqOg+DG8rDn13qDE9DQMYBCYPr0P/4UDVGHsP7UI7l3Qguds8IALo2FEn
         /163HnkeQsrikbmuaq19nVjgdTopRkZF/ZMpCCS3fbtqFycBde8aRlOAdoUcP28e8bcN
         wOa8mI9GqxD7kjeJEN0jvzKmODxx4dkpryCgJpgXb8/SWQ8kQHbhzpJ4nBeebNECUzYu
         cjx6nwUpLpqiUfOl7nN7+ZRPdNf3fTvYiFzGpAD3TgHkJM77NDPDrwdl6ljV53ENyIyJ
         YpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629174; x=1710233974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6C3Skxl3JZ6I3Bn9M0Rkt7P+AkMJ9BXocPtViO8HyA=;
        b=cW5EOgkPChMC7X90Bv6B/DNCqsOM4G5Jbo7QKd/sA0TSdZSjDoEme34YrGxrrK8Kgd
         Yqez9s/N0waJoS/m89xziN2Q4XLj4K8mGcZ52jyjsSDkZaplERUFK8Mv43XR8Z0Yezzr
         v6bsZSp79ayua3NKln/IitSQH8kcMiBQSEppa5WoYVKXQkdI5i2lB5IUu4wA0sQrchUq
         49cAzfF8VKaWbSdlnHE35hMvOWPRn9/CjoGDbIZwAcYU+jd3Kb+aGhyZG91sbq/CIzDA
         tBkWTpU2wYUH0D/fjLbQ0VVqlgji0dIXyGJ8yHOz0d0vRSM+fffJeZrNtKKSvMwcgKvJ
         YS6A==
X-Forwarded-Encrypted: i=1; AJvYcCX1b8UuBZixYwRzbtLMNdIg7RHl9DUwH4zGPRGirdc9uw/vYGcjkQI131IAB/WEeKHdJQ+aG8yLwTk46bGtHgrFT/WJFukdkvztJphC
X-Gm-Message-State: AOJu0YxpULwLeuwHrNnkos/7u4M+k1b+uejC4fwpwTbmzL7LBg2ncV0k
	uDtqG2IRF7bKmMAknMK74sSoN3I7VRaIwmCbywFlrvTklF4exN9wfIeA1ajDjhTMgQ/DTWenBXv
	m
X-Google-Smtp-Source: AGHT+IFMPVTm56Kq7yCVlQCGm8leuaxurrmwoBlFPKo/035wjfo25tHyRCTnVjULXBx8bQ19QGpKYw==
X-Received: by 2002:a17:906:eb16:b0:a45:3ad3:1f93 with SMTP id mb22-20020a170906eb1600b00a453ad31f93mr3324672ejb.44.1709629173710;
        Tue, 05 Mar 2024 00:59:33 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:33 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 00/14] Fast kernel headers: split linux/mm.h
Date: Tue,  5 Mar 2024 09:59:05 +0100
Message-Id: <20240305085919.1601395-1-max.kellermann@ionos.com>
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
v2 -> v3: rebase on linux-next

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
 include/linux/mm.h                            | 583 +-----------------
 include/linux/mm/devmap_managed.h             |  37 ++
 include/linux/mm/folio_next.h                 |  27 +
 include/linux/mm/folio_size.h                 | 150 +++++
 include/linux/mm/folio_usage.h                | 182 ++++++
 include/linux/mm/folio_zone.h                 |  36 ++
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
 66 files changed, 780 insertions(+), 576 deletions(-)
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


