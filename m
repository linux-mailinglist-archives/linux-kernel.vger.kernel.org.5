Return-Path: <linux-kernel+bounces-100039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1D87912A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC209283E32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4279DA2;
	Tue, 12 Mar 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V7FDEUEt"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901679B90
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236512; cv=none; b=hJMEWTCkyTWTKbUCI96NZdLf0FvkDkItEX6d+LKgge6SxkkQtmJtC7xV6xtWtzecpnSIIt6ApQ7tuTtyRBjKqUcmr3eo4G30lI5XsxshWvfl+UnUkKYGM7GqKE91muHVwWv2JnjZSmfz0IueFAPml7KzNjipEDvUsVeESpxK7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236512; c=relaxed/simple;
	bh=hpTbYT683gxbhh5L0kZ2cdvkRtYcLTlco4Tc+Ldrm08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XWLLf5415Cf0yklqkehIces20ftX4GQUBwsUlJehWr6DFuifsN4NXkNwUaXGk2qCl56I0TyRoLy+0v6akZHZFXXrTeTO+J53nW1/Wpu3eZleBIOtXsJOyX1YmQvKPOHwre5yWcpu4Z951UNAS0RpoI5ex2v3H9T7KysUM1sfsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V7FDEUEt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so574556666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236507; x=1710841307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WdTMuNhLdde4/npesOLEbN40iQG/MGbfim/kxJH6up0=;
        b=V7FDEUEtKRGxeXSrYB5TdRlp5qLoWWpeuvwUenipfx35W8vjMjc9TR9/MgmwrTtFSa
         /Mo5JZK8OS7QGPJprIdujoCxUIe6oDgf3P/opXoX3gMRcXMo3JuKy4yiJdmDsR45OZyQ
         bJ707PX6yA2y4cndKgVHiFFdCZmbIl2EofO+eSWJ1EA5fH161j3N2fxJk3uWtrzT8nck
         Hn+fW7ThFj0L1mdZF5zteMBoEVqnw4z43iCtwDgq80zoVq0yedDOkZ0DjzDGOjr9yDA0
         VYFvbipwQIaFsasxlEkti6odyl6UFu8UnFSS1hcipiHKYpPm9SXBev8+o30zfbTCpYsG
         mqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236507; x=1710841307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdTMuNhLdde4/npesOLEbN40iQG/MGbfim/kxJH6up0=;
        b=xNq7NfdN8Teea8bo2B2XaNc2+C0uTl6MuImYPy6i0i49XSsX4DSUG30Vlc8jXXfb5t
         /dAhuMfAYdjl8pnS8UHrxB1BYNarvOTqH91rgpRlOevb3yNVUU0NbXl/IoDpdxpUEjv+
         ruBn3SGC7PJjFiTcDQvz1K20irUNJV/Ms8wvsekHbqTsN4QRAubKXD3sS9j0NLG+ryHr
         vUGMkQVx8u/e8DbU9YA2Z1ezl8PVeSkjnRQpw2hnexfGMwgsPC57g39+zhdzBW3Rw0v/
         a8eQtoR3vV6TbUER6dgvyzJy+MVRLAz5iPQvcpmomvA/npq/cUGdWUR082107F5An/u4
         16qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrsfDGmX+F2vlmsqzKzFfwza0DzUA3G206rhH33FiBbzR5wESxrRYQJtCUD/x3Ve0BS1trIzLHOChc4kPp8z3tlRhhuyKWoC58pfWf
X-Gm-Message-State: AOJu0Yw+Rwf0TsV6jwPyalaPVuzHoRnkp/AitDVgUrd4Pklpw4WuLnbB
	ubxLGHvyFI5g3sMRwpHjhY8Qze9T4hUozmu/GfW7DlS9ttrbrd3NRiw6okb6jMY=
X-Google-Smtp-Source: AGHT+IGOAEcWgZfewOMBEQgq8gRG+1oEzNtwe7LDKMEfIaGe06nxshuW2ViBYXTYiAwkd4CGrT+ceQ==
X-Received: by 2002:a17:906:a298:b0:a44:763:4dd3 with SMTP id i24-20020a170906a29800b00a4407634dd3mr5764667ejz.27.1710236507685;
        Tue, 12 Mar 2024 02:41:47 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:41:47 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 00/15] Fast kernel headers: split linux/mm.h
Date: Tue, 12 Mar 2024 10:41:18 +0100
Message-Id: <20240312094133.2084996-1-max.kellermann@ionos.com>
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
v3 -> v4: rebase on linux-next; fix build failure on loongarch64
  (reported by kernel test robot); add missing includes to
  drivers/dma/bcm2835-dma.c and include/scsi/scsicam.h

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
 include/linux/page-flags.h                    |   3 +
 include/linux/scatterlist.h                   |   8 +-
 include/linux/skbuff.h                        |   4 +
 include/scsi/scsicam.h                        |   5 +
 kernel/dma/ops_helpers.c                      |   1 +
 kernel/dma/remap.c                            |   1 +
 lib/scatterlist.c                             |   1 +
 mm/dmapool.c                                  |   1 +
 69 files changed, 789 insertions(+), 576 deletions(-)
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


