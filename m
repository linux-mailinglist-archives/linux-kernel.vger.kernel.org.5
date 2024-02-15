Return-Path: <linux-kernel+bounces-67111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70185669F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5C71C229A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43A13248C;
	Thu, 15 Feb 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cXibe3GH"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63420B3D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008974; cv=none; b=lJnK5iqz6HaWzsnxm+Uq4ydAiv/ZqPbP9Dvld/Lgv+7nRjyAC0TIawL42qgK/xc95FftIoc+a0FB+l24dvf1yef4vUe2068Bh8HQTHT+CJ+aYdl+E6wiWzOpN77RYggnYuhxQnjZVuQcNXEjWbKrVDcXT1FURqwTDrotOhuC3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008974; c=relaxed/simple;
	bh=/ZXRO0BbPBK8pZ1dPsjt7GxXkirJvYdjQ4fT55CFUFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G5CF0es264Cunym+8bT7+oReulyRJu0ezzmjHrEqj+qbwo0mdqoBdKUmudYTwR4j8WwJ0TwtYsihz6hTsxladbRkpDluok75YFi7VJwTH2DpuaN8E5qt+nPHF7ZVrI0Qas20I8HnFmNXCyQjkFcVpKf6HD37B+JdaHRwaWXRyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cXibe3GH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563d017696eso247482a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008970; x=1708613770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5nXvWMW5tF9mUZIu3IKH+/C2q6hHrxXabf0w0v9TF+Q=;
        b=cXibe3GHjLONsKbxi/wwEh+8xD0WFwwnUFLBvHCX2K+haXMRtR6Xzj0mLRvl9qdKoo
         oyDYXIWS6bOpV/NjHKJCzB53zplcb8HbVH36GPXs9JwEHzLCjxMupDkyWgj45OAJYWaH
         4Yvn4dtjhZqeAwL3kuZwppujytfroMpz/mBkeM18CwPI7l36lXCzzINbqyadqxLn9vSa
         p21ex+LTrIFF74sXhnaR5m6MdlNTlfy7U24YiqSOQqb7YEQRbmrv5p0mRDNJrpLgcvpb
         9SU/UQUpu2SE1DMqAI73iWu+jZBjoEz0/GIjc/8hD4j+7QbU+KjZy0JoWuOxjO+tM+z8
         dimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008970; x=1708613770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nXvWMW5tF9mUZIu3IKH+/C2q6hHrxXabf0w0v9TF+Q=;
        b=ObSG8pgA+xI68VRCB8dOPx0YgqRbwZ6SEmBPwV4fwONJhWsUIEv/4+yl/95Mauilg6
         NwL6Zm+u/65Ps8CbqHmb0RK3CLDLLCcz4AELg1/nt3j+O+0lTImbkFZY4zJ1LNgMAR/u
         Go6F+3AShH1o331wCbduqYphIEQ1Fyl87fekpUZwaVes5Bcbem3EHAktV1bzWHiXlDEf
         EIA1oGIQDtg9B0b53ZBbbBdbFHA0v036hFWca6oehaWiZryoUUvgT21aUMYW1B0AtecG
         p634iHHYohv5R57776ik/zQBejOic0fYM8YmGBORmcLgYiLk6LM9oxtqeMC6eExw8ucG
         UOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH+mQ0DkSUGX3uXk337qxZEEHFx0EUi4F+IGjTbi1xsMijiER6zvByAeGPFpkhD/Y/LTM14Pxe6vJrGOkFu51RCgUglksDfUlEaBV+
X-Gm-Message-State: AOJu0Ywmuu+h+Ip5hCz3xeDaYtPSxKHwm4V5AcwA8A+TAMIkAfXWtm7g
	vbEiqcVv36lu3yXn06lPn94j/jTPrrlou3BuojlFrODWLJTDKr5xmfNa+MOYuJ1w1vuUbLXD1SC
	C
X-Google-Smtp-Source: AGHT+IEu+B4g679JrYfg2BNoCeEgkGfJ4dlSOqLdTnCeI8cmWtAq4dQB2KEUXYXMaUUhYGU5pBoE7w==
X-Received: by 2002:a17:906:759:b0:a3d:632e:7ab4 with SMTP id z25-20020a170906075900b00a3d632e7ab4mr1552932ejb.42.1708008970173;
        Thu, 15 Feb 2024 06:56:10 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:09 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 00/14] Fast kernel headers: split linux/mm.h
Date: Thu, 15 Feb 2024 15:55:48 +0100
Message-Id: <20240215145602.1371274-1-max.kellermann@ionos.com>
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

Max Kellermann (14):
  drivers: add missing includes on linux/mm.h (and others)
  include/drm/drm_gem.h: add poll_table_struct forward declaration
  linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
  linux/mm.h: move section functions to mm/page_section.h
  linux/mm.h: move page_address() and others to mm/page_address.h
  linux/mm.h: move page_size() to mm/page_size.h
  linux/mm.h: move folio_next() to mm/folio_next.h
  linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
  linux/mm.h: move usage count functions to mm/page_usage.h
  linux/mm.h: move page_zone_id() and more to mm/page_zone.h
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
 .../qat/qat_common/adf_gen4_pm_debugfs.c      |   1 +
 drivers/dma/dma-axi-dmac.c                    |   1 +
 drivers/dma/sh/rcar-dmac.c                    |   1 +
 drivers/firmware/qcom/qcom_scm-legacy.c       |   1 +
 drivers/firmware/qcom/qcom_scm-smc.c          |   1 +
 drivers/firmware/raspberrypi.c                |   1 +
 drivers/iio/buffer/industrialio-buffer-dma.c  |   1 +
 drivers/iommu/iommufd/selftest.c              |   1 +
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |   1 +
 drivers/media/platform/ti/omap/omap_voutlib.c |   1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   1 +
 drivers/misc/fastrpc.c                        |   1 +
 drivers/misc/genwqe/card_dev.c                |   1 +
 drivers/misc/uacce/uacce.c                    |   1 +
 drivers/pci/p2pdma.c                          |   1 +
 drivers/pci/pci.c                             |   1 +
 drivers/remoteproc/remoteproc_core.c          |   1 +
 drivers/soc/qcom/rmtfs_mem.c                  |   1 +
 drivers/spi/spi-bcm2835.c                     |   2 +
 drivers/spi/spi-intel.c                       |   1 +
 drivers/virtio/virtio_ring.c                  |   1 +
 include/drm/drm_file.h                        |   1 +
 include/linux/bio.h                           |   2 +
 include/linux/dma-mapping.h                   |   1 +
 include/linux/highmem-internal.h              |   2 +
 include/linux/highmem.h                       |   4 +-
 include/linux/iommu.h                         |   1 +
 include/linux/mm.h                            | 582 +-----------------
 include/linux/mm/devmap_managed.h             |  37 ++
 include/linux/mm/folio_next.h                 |  27 +
 include/linux/mm/high_memory.h                |   7 +
 include/linux/mm/page_address.h               |  71 +++
 include/linux/mm/page_kasan_tag.h             |  66 ++
 include/linux/mm/page_section.h               |  23 +
 include/linux/mm/page_size.h                  | 150 +++++
 include/linux/mm/page_usage.h                 | 177 ++++++
 include/linux/mm/page_zone.h                  |  38 ++
 include/linux/mm/pfmemalloc.h                 |  52 ++
 include/linux/mm/vmalloc_addr.h               |  33 +
 include/linux/nvme-keyring.h                  |   2 +
 include/linux/scatterlist.h                   |   2 +-
 include/linux/skbuff.h                        |   4 +
 kernel/dma/ops_helpers.c                      |   1 +
 kernel/dma/remap.c                            |   1 +
 mm/dmapool.c                                  |   1 +
 59 files changed, 761 insertions(+), 575 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h
 create mode 100644 include/linux/mm/folio_next.h
 create mode 100644 include/linux/mm/high_memory.h
 create mode 100644 include/linux/mm/page_address.h
 create mode 100644 include/linux/mm/page_kasan_tag.h
 create mode 100644 include/linux/mm/page_section.h
 create mode 100644 include/linux/mm/page_size.h
 create mode 100644 include/linux/mm/page_usage.h
 create mode 100644 include/linux/mm/page_zone.h
 create mode 100644 include/linux/mm/pfmemalloc.h
 create mode 100644 include/linux/mm/vmalloc_addr.h

-- 
2.39.2


