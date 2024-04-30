Return-Path: <linux-kernel+bounces-164267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8208B7B91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BC11F23876
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5A4143759;
	Tue, 30 Apr 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VOH8qAW8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF5143722
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490991; cv=none; b=XuBayS0/RGTd63wCTorTdLFuSHpOLFQprkUKHy/gakF7am//4gz7bI8/D/0sNOJvw9H4Gb9UA143ExZp0speE/kFUI6aDdKp2wycZUzyFzmZTEt+o+2ZziGvoRsYbrmn/yzkBhmIQ7S/sOZYvFHAtEUS56jwRSJ3uSvmaqQ3snI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490991; c=relaxed/simple;
	bh=Eo9CZEavvlZvfslFyXQ8eLhNSj0EUVeUROZzlrz6dDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l5E1fjSui8C1MtqD8GxVhrtKplZeKTIABNRKfjmmgzK7b1i/Airfr7NAsgetgVejO/di+XyPb3/xfEMmzzUHdUJ6Oxc0NyfIUiM4SlPwqHVQjXwpoBq+iBsaZjwwBdIqzl2h+IJkvKCLj1v+rUxBgZmW4usZZbGOI3eQ6oBGMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VOH8qAW8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so11320637a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490986; x=1715095786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9DoQMK9q9pSbyMynIt4ms7bIdooJ2qc4sLnkNXJptA=;
        b=VOH8qAW8+hBzBEvjlRWurwQRxPKN2gS+4fbynzagWw+a0yK4W47HVV1c9RUKu0lt8P
         w1rU2CPxGpSduNAevmRQCxRYGIS7J0r/Ku3AcyFGyr2uoGpgWN0ONzJqoB27bcYuaXN5
         cK09O3myVFZoTPQHNJ639RBatPzyY3tg1IYidBE6pI0HKHKQyTXW5pVYo+0Wlwr5K2SK
         DjnFNhlr3g0t+1Q5dxacDIkh+veAomHmKQ3te7wFOH1oB2gBnEv3yJBX07oALwnzZDC6
         auFLiXki69GWXs+d+HZ83YJTKVS87UDmC/SFZFQniDwrvVnXzskMF0htiBWYiP2uQmav
         soOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490986; x=1715095786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9DoQMK9q9pSbyMynIt4ms7bIdooJ2qc4sLnkNXJptA=;
        b=keKbPg2BBpqkVOVD4e3rNT3BSDN20eA3WiT28leUOM+Wqe9s8lhWE58fhwdzKk0+bW
         7p1/78DOCEJ0BAL93Zt8wejSz7UjFXtakyuw0zMltoVuvFxoCuzbAaU/9TAwqM2+fi1G
         KeLGNqgRR4WLiVR4NpMZCGWyuVygEn3Ja/DZV2QSE3pLtiyFEe+7ZM40bIDBnpZO1fv/
         BU9D6IwluPmLCbuQuGrBudJzfYQjBuOeuBmTQ5swbL8Pir3K4GQDE3HkbLcS0EqSXmbq
         1DTAcUL2ieubXr5qTUDAJpdFB8te6ucTLfYMRY4yApvhX3G+liHrOCXGqElyVNo1/oJC
         dVsA==
X-Forwarded-Encrypted: i=1; AJvYcCUpv/gk81l0UNuLm/9uImtQkb+gsUCqo+2fKAilT15IiEKDNFStGCIPbvlAAXxgujHW5t3xhyzjLbfhk8UH7i/ERu5DwQ2OtlU9KDtJ
X-Gm-Message-State: AOJu0Yya0ZzcVBts/eeTtilt79K2wJJS9+lobhzw0heHZ/KUIDFkSCeR
	YtMYHo21GZLgOnk/NrmSFPuXVAWE28dxN9+VHbF1ApaIrDoHrJ2vGq8ATOg5Suo=
X-Google-Smtp-Source: AGHT+IEfVsU4G6WPSdAEqHAEtBXu3BdO32Tb63+YZg+Op6JnqM528UxRdG8qYgDnfHJUc3CSaFON6A==
X-Received: by 2002:a17:906:f6d9:b0:a55:5958:cb00 with SMTP id jo25-20020a170906f6d900b00a555958cb00mr2524314ejb.38.1714490986392;
        Tue, 30 Apr 2024 08:29:46 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:45 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 00/15] Fast kernel headers: split linux/mm.h
Date: Tue, 30 Apr 2024 17:29:16 +0200
Message-Id: <20240430152931.1137975-1-max.kellermann@ionos.com>
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

This patch set borrows the name "fast kernel headers" from Ingo
Molnar's effort a few years ago.  While this kind of refactoring does
indeed improve build times because the amount of code that has to be
processed in each compilation unit is reduced, build speed is the
least important advantage.

Much more important is that this gives us greater confidence that the
code is correct: if we forget to include a header, it might (or might
not) already be included indirectly by some other header somewhere
down the large impenetrable include tree.  Chances are almost 100%
that linux/kernel.h or linux/mm.h gets included somewhere, which then
in turn includes everything else.  Now if this indirect include just
happens to be changed eventually, the build may suddenly fail at
remote places.  Worse, an #ifdef may silently produce different code.
Therefore, at each source file, all the includes that are needed
should be included directly (but not more).  This is only possible if
headers are small, and linux/mm.h and linux/kernel.h are large
offenders resisting the cleanup.

Therefore, splitting those is the first step towards leaner header
dependencies.  This patch set starts with linux/mm.h, and I am already
preparing another patch set addressing linux/kernel.h.

Some of these changes were part of a previous, bigger patch set
(https://lore.kernel.org/lkml/20240131145008.1345531-1-max.kellermann@ionos.com/)
but this patch set grew so large, it could not be reviewed.  This is
an attempt to break the patch set into smaller pieces.

---
v1 -> v2: added more explanations to commit messages; renamed several
  new headers from page_*.h to folio_*.h as suggested by Matthew
  Wilcox; rebase on linux-next; fix build failures on architectures
  um,nios2,hexagon by adding more missing includes
v2 -> v3: rebase on linux-next
v3 -> v4: rebase on linux-next; fix build failure on loongarch64
  (reported by kernel test robot); add missing includes to
  drivers/dma/bcm2835-dma.c and include/scsi/scsicam.h
v4 -> v5: rebase on linux-next; more text in cover letter as suggested
  by David Hildrenbrand

Max Kellermann (15):
  drivers: add missing includes on linux/mm.h (and others)
  include/drm/drm_gem.h: add poll_table_struct forward declaration
  include/scsi/scsicam.h: forward-declare struct block_device
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
 drivers/dma/bcm2835-dma.c                     |   1 +
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
 include/linux/bpfptr.h                        |   1 -
 include/linux/dma-mapping.h                   |   1 +
 include/linux/highmem-internal.h              |   2 +
 include/linux/highmem.h                       |   4 +-
 include/linux/huge_mm.h                       |   2 +
 include/linux/iommu.h                         |   1 +
 include/linux/mm.h                            | 598 +-----------------
 include/linux/mm/devmap_managed.h             |  32 +
 include/linux/mm/folio_next.h                 |  27 +
 include/linux/mm/folio_size.h                 | 150 +++++
 include/linux/mm/folio_usage.h                | 182 ++++++
 include/linux/mm/folio_zone.h                 |  56 ++
 include/linux/mm/high_memory.h                |   7 +
 include/linux/mm/page_address.h               |  71 +++
 include/linux/mm/page_kasan_tag.h             |  66 ++
 include/linux/mm/page_section.h               |  23 +
 include/linux/mm/pfmemalloc.h                 |  52 ++
 include/linux/mm/vmalloc_addr.h               |  33 +
 include/linux/net.h                           |   2 +-
 include/linux/nvme-keyring.h                  |   2 +
 include/linux/oom.h                           |   2 +-
 include/linux/page-flags.h                    |   3 +
 include/linux/pagemap.h                       |   2 +-
 include/linux/scatterlist.h                   |   8 +-
 include/linux/skbuff.h                        |   4 +
 include/linux/vmstat.h                        |   2 +
 include/scsi/scsicam.h                        |   5 +
 kernel/dma/ops_helpers.c                      |   1 +
 kernel/dma/remap.c                            |   1 +
 kernel/rcu/rcutorture.c                       |   1 +
 lib/scatterlist.c                             |   1 +
 mm/dmapool.c                                  |   1 +
 75 files changed, 810 insertions(+), 595 deletions(-)
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


