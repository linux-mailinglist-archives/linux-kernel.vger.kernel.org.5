Return-Path: <linux-kernel+bounces-167878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F08F8BB09F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EE2283594
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3749D155343;
	Fri,  3 May 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IbZhBw7V"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507226AF5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752771; cv=none; b=qAnfXSZTKPNvzFFBQbuE4ktbBDzvfMw+yUfnbL0KIFaapc2NaFeECnpM+whYlisym6+oxtXwMBobY2gjzAhvNmsguVPUGT6L/MbhuDe8eJhkOGCyU3y0VJgxo5kCJJYIH+RvHCCtol6PO6tFd+/crI0hqeucwbh5/FbqHWOkR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752771; c=relaxed/simple;
	bh=Muf+5crQf7UO0Ztgnrn20cNGhDFiaFXdMImvGaP1lk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MxnXIH0m9kzTymgCIoPv/D7ghhxnmUqizOYUN0F0MLQqLsb+EvI3X7tlDR+0jlditZ5jYq2atqHW8Ja6DjN9nmLkNf8MtVZqGQ2QvdK6slA/aMLvVeoZMrQVGsb2+SkD4K3XsGKx1MidkxhcS1fDrxStyJTCqtN+OBbBePmZrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IbZhBw7V; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecff927a45so16843755ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714752769; x=1715357569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SsYPCHFIzDKMqt+c2VcTik9i4CFhHISqpzih2Y5YwM=;
        b=IbZhBw7Vhb8bM/cuQkB5gmG5+npvX7IIO7qXfLgT5jDaVRoH8fUorRaUH0GZK+Bi2x
         ak6qE4RG9hNCMX8kG+sn9Uti3pHWOSF1ISEqre/HjV2115ktd3J2yh2MmftlIJ6lenhy
         Dw/bZ4l4n4oDzsSKAFmpCpG69M+a6QMIewQSNHyR9gpKpzNcbm06/lIWV6BrrtXhVORP
         g60kBR1K9q7A8m17wplJrQVS7esLIWnnrl+s84XrvIjbvjjWdkhDD1aBYidnGUDvfQzg
         jRfwo1YDVlUTXEPMVv2RFTuekGC9z8V8cawgxvtBt3bYjwniSk4CcZuYWTNfLU6Buwpb
         bSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752769; x=1715357569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SsYPCHFIzDKMqt+c2VcTik9i4CFhHISqpzih2Y5YwM=;
        b=Acz82G7jtoWobvpXpWXrFiS2Js0BuVXZCi2FM4SOgOGGv4Wa/9UQdpbEvb3fwNc9MO
         dRUja8xelqzgJPK8SIEr1Tyy5AlkPrAktyk9sz2uWfYiHkDo9ZB9jg8Kiff0rBewGP90
         eCISG7+uj4KTzOqBz3lDw8d6xXn00wEJrZwzZFU1ooHOePof3vgtOqwx6GseNFTlE3gd
         ukM1J3bUJXSGjW7fIjg0NGp9M9CSMMsn3rnOWPG+WRBTtKLnjY1zl7Qoio4Box21PFQY
         oqszfK3enKSEeBHPUA417MWP6uvo6M53yQVKy3y6IL2YqMnKXZHHRrbnXFAa1v0ONKM/
         Smag==
X-Forwarded-Encrypted: i=1; AJvYcCWanxuBVWA7FHUMd+jR3u++KeVLGXtqPdeyDvaIgLEUXFdEOf9qUP+A/vwh1CYfhopd1Yc1I9O/iVkeY4VCZXL4mb7I0TFmcxu53NC8
X-Gm-Message-State: AOJu0YzNUTsOZhE4AwDRhaKJp0mZ3IyObwGeF6FeSbEFpv7LmB4sZZcK
	5rRSXy4efrNvtXLZuulJamLL/rtaqhWXrFcmzC8yquJ+MAYjZq2OZqdk+p1newg=
X-Google-Smtp-Source: AGHT+IHI9LbCKHBkbWwHrBelW4UzMSUbdbIWW4nvucUsVTKhhMXlCsPu0hGFWBuw389Bh7kh55CCEw==
X-Received: by 2002:a17:902:e80c:b0:1e8:813f:4009 with SMTP id u12-20020a170902e80c00b001e8813f4009mr3673385plg.14.1714752768891;
        Fri, 03 May 2024 09:12:48 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ec8300b001e2086fddecsm3424746plg.139.2024.05.03.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:12:47 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v4 0/7] Linux RISC-V IOMMU Support
Date: Fri,  3 May 2024 09:12:33 -0700
Message-Id: <cover.1714752293.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces support for RISC-V IOMMU architected
hardware into the Linux kernel.

The RISC-V IOMMU specification, which this series is based on, is
ratified and available at GitHub/riscv-non-isa [1].

At a high level, the RISC-V IOMMU specification defines:

1) Data structures:
  - Device-context: Associates devices with address spaces and holds
    per-device parameters for address translations.
  - Process-contexts: Associates different virtual address spaces based
    on device-provided process identification numbers.
  - MSI page table configuration used to direct an MSI to a guest
    interrupt file in an IMSIC.
2) In-memory queue interface:
  - Command-queue for issuing commands to the IOMMU.
  - Fault/event queue for reporting faults and events.
  - Page-request queue for reporting "Page Request" messages received
    from PCIe devices.
  - Message-signaled and wire-signaled interrupt mechanisms.
3) Memory-mapped programming interface:
  - Mandatory and optional register layout and description.
  - Software guidelines for device initialization and capabilities discovery.


This series introduces RISC-V IOMMU hardware initialization and complete
single-stage translation with paging domain support.

The patches are organized as follows:

Patch 1: Introduces minimal required device tree bindings for the driver.
Patch 2: Defines RISC-V IOMMU data structures, hardware programming interface
         registers layout, and minimal initialization code for enabling global
         pass-through for all connected masters.
Patch 3: Implements the device driver for PCIe implementation of RISC-V IOMMU
         architected hardware.
Patch 4: Introduces IOMMU interfaces to the kernel subsystem.
Patch 5: Implements device directory management with discovery sequences for
         I/O mapped or in-memory device directory table location, hardware
         capabilities discovery, and device to domain attach implementation.
Patch 6: Implements command and fault queue, and introduces directory cache
         invalidation sequences.
Patch 7: Implements paging domain, using highest page-table mode advertised
         by the hardware. This series enables only 4K mappings; complete support
         for large page mappings will be introduced in follow-up patch series.

Follow-up patch series, providing large page support and updated walk cache
management based on the revised specification, and complete ATS/PRI/SVA support,
will be posted to GitHub [2].

Changes from v3:
- dt-bindings: s/qemu,iommu/qemu,riscv-iommu/, fix iommu-map sample
- device probe will fail if IOMMU if running in restricted BARE mode
- synchronize_rcu moved to release_device, fixes for bonds locking, iotlb_inval fix
- page table radix tree selection based on IOMMU capabilities, failover to use SATP
- private iommu per device data structure added
- Editorial changes: rename goto labels, blocking_domain/blocking_domain, reformat
  to fit mostly under 80 characters per line

Patch series depends on (applied to iommu-next):
  IOMMU memory observability, v6 [3]
  iommu, dma-mapping: Simplify arch_setup_dma_ops(), v4 [4]

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux
[3] link: https://lore.kernel.org/linux-iommu/20240413002522.1101315-1-pasha.tatashin@soleen.com/
[4] link: https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com/
v3 link:  https://lore.kernel.org/linux-iommu/cover.1714494653.git.tjeznach@rivosinc.com/ 
v2 link:  https://lore.kernel.org/linux-iommu/cover.1713456597.git.tjeznach@rivosinc.com/
v1 link:  https://lore.kernel.org/linux-iommu/cover.1689792825.git.tjeznach@rivosinc.com/


Tomasz Jeznach (7):
  dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
  iommu/riscv: Add RISC-V IOMMU platform device driver
  iommu/riscv: Add RISC-V IOMMU PCIe device driver
  iommu/riscv: Enable IOMMU registration and device probe.
  iommu/riscv: Device directory management.
  iommu/riscv: Command and fault queue support
  iommu/riscv: Paging domain support

 .../bindings/iommu/riscv,iommu.yaml           |  147 ++
 MAINTAINERS                                   |    8 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/riscv/Kconfig                   |   20 +
 drivers/iommu/riscv/Makefile                  |    3 +
 drivers/iommu/riscv/iommu-bits.h              |  782 ++++++++
 drivers/iommu/riscv/iommu-pci.c               |  119 ++
 drivers/iommu/riscv/iommu-platform.c          |   92 +
 drivers/iommu/riscv/iommu.c                   | 1616 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2877 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: e67572cd2204894179d89bd7b984072f19313b03
message-id: 20240413002522.1101315-1-pasha.tatashin@soleen.com
message-id: cover.1713523152.git.robin.murphy@arm.com
-- 
2.34.1


