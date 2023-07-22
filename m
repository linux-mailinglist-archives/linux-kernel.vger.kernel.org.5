Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2175DBEB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGVLgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGVLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:36:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FFE171A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:36:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3174aac120aso91020f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690025765; x=1690630565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tClH+/vlnZHyJoQAaBUK6IjRTXTlSAczbSsv8EGYQts=;
        b=g2gAh8SyazgicwzrNsr57Mi1mwkjLq6hAoDYMFxpUNZmxM3K8CasoSNR98FlScKzaB
         p0CXB4h9Vx6cZuiR+3+UVdbcnmRjyYRZefrWZ5ikBxDskDlXEYaZdF4UO/i9ZGdDoX0z
         CjBmEz+Uul1es37d0m08xM/qTncsZLssANCNcUCZm48m59zYjGDknzsl3LpYSqnvPuSV
         WLbC850w25fps35oxdW1AcaBHw18LILAA5Z0drDWGjw6vLcifnHKb6SWjwfWyC+eC6xV
         2khDmEWsHMJ3eOZb4XIwfgE6B85+uQAaVU8isMWQoWiIRJQg88rXNQ25rLN6u5LLJzDd
         fjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690025765; x=1690630565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tClH+/vlnZHyJoQAaBUK6IjRTXTlSAczbSsv8EGYQts=;
        b=QhOkl1sNWaZIrgTC1hus1cjRfIIhRHxjzgi9FO6pl1WJaGbvAHM1QtGTBMWKsoOjPm
         IT6O16QmXMqLIxB7vi0lpTu9jpqirIoo5tbvV+egkorzUNGB08FoOoIR87cuUgybj7op
         URDQyUl5UcxWrcPgro6bgQgOH5caYLsk76gC282HsWhhsnIDgM/Y5Uvo+L8CBjQBhYYm
         BkwxAT/PS+BH7qtaMk0iMPfc9vDGu1lrZWO0eOkMd/r5Y0tszkuduZNLlExgYl3BjWDA
         A6t5+lUBHO64lzqXjfeX+jJjT92yjVJTop3j3vuke8E5+a1dS8NJTDqAsag5deSlbdYk
         ZvPw==
X-Gm-Message-State: ABy/qLZuYrKIuU0lQyQtBFN9Ukrpy6W5Npw6vGBtn40JMKQJxxdHHSdq
        fpOPBLrPVv8UByH+GzChQG/2hA==
X-Google-Smtp-Source: APBJJlHpsfpaDb6CYnyNK/GdPQkCAKHI8GADZHB4hGNq0D2HyyZUr01FCks98kPS4nvkagw+J65/kg==
X-Received: by 2002:adf:fac1:0:b0:313:ebf3:f817 with SMTP id a1-20020adffac1000000b00313ebf3f817mr3573507wrs.22.1690025764989;
        Sat, 22 Jul 2023 04:36:04 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e22-20020a5d5956000000b003063db8f45bsm6715616wri.23.2023.07.22.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:36:04 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v5 2/3] Documentation: riscv: Add early boot document
Date:   Sat, 22 Jul 2023 13:34:44 +0200
Message-Id: <20230722113445.630714-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722113445.630714-1-alexghiti@rivosinc.com>
References: <20230722113445.630714-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document describes the constraints and requirements of the early
boot process in a RISC-V kernel.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
- Changes in v5:
  * Rebase on top of docs-next

 Documentation/riscv/boot-image-header.rst |   3 -
 Documentation/riscv/boot.rst              | 169 ++++++++++++++++++++++
 Documentation/riscv/index.rst             |   1 +
 3 files changed, 170 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/riscv/boot.rst

diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
index d7752533865f..a4a45310c4c4 100644
--- a/Documentation/riscv/boot-image-header.rst
+++ b/Documentation/riscv/boot-image-header.rst
@@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
 
 This document only describes the boot image header details for RISC-V Linux.
 
-TODO:
-  Write a complete booting guide.
-
 The following 64-byte header is present in decompressed Linux kernel image::
 
 	u32 code0;		  /* Executable code */
diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
new file mode 100644
index 000000000000..f890ac442c91
--- /dev/null
+++ b/Documentation/riscv/boot.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================
+RISC-V Kernel Boot Requirements and Constraints
+===============================================
+
+:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
+:Date: 23 May 2023
+
+This document describes what the RISC-V kernel expects from bootloaders and
+firmware, but also the constraints that any developer must have in mind when
+touching the early boot process. For the purposes of this document, the
+``early boot process`` refers to any code that runs before the final virtual
+mapping is set up.
+
+Pre-kernel Requirements and Constraints
+=======================================
+
+The RISC-V kernel expects the following of bootloaders and platform firmware:
+
+Register state
+--------------
+
+The RISC-V kernel expects:
+
+  * ``$a0`` to contain the hartid of the current core.
+  * ``$a1`` to contain the address of the devicetree in memory.
+
+CSR state
+---------
+
+The RISC-V kernel expects:
+
+  * ``$satp = 0``: the MMU, if present, must be disabled.
+
+Reserved memory for resident firmware
+-------------------------------------
+
+The RISC-V kernel must not map any resident memory, or memory protected with
+PMPs, in the direct mapping, so the firmware must correctly mark those regions
+as per the devicetree specification and/or the UEFI specification.
+
+Kernel location
+---------------
+
+The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for rv64
+and 4MB aligned for rv32). Note that the EFI stub will physically relocate the
+kernel if that's not the case.
+
+Hardware description
+--------------------
+
+The firmware can pass either a devicetree or ACPI tables to the RISC-V kernel.
+
+The devicetree is either passed directly to the kernel from the previous stage
+using the ``$a1`` register, or when booting with UEFI, it can be passed using the
+EFI configuration table.
+
+The ACPI tables are passed to the kernel using the EFI configuration table. In
+this case, a tiny devicetree is still created by the EFI stub. Please refer to
+"EFI stub and devicetree" section below for details about this devicetree.
+
+Kernel entrance
+---------------
+
+On SMP systems, there are 2 methods to enter the kernel:
+
+- ``RISCV_BOOT_SPINWAIT``: the firmware releases all harts in the kernel, one hart
+  wins a lottery and executes the early boot code while the other harts are
+  parked waiting for the initialization to finish. This method is mostly used to
+  support older firmwares without SBI HSM extension and M-mode RISC-V kernel.
+- ``Ordered booting``: the firmware releases only one hart that will execute the
+  initialization phase and then will start all other harts using the SBI HSM
+  extension. The ordered booting method is the preferred booting method for
+  booting the RISC-V kernel because it can support cpu hotplug and kexec.
+
+UEFI
+----
+
+UEFI memory map
+~~~~~~~~~~~~~~~
+
+When booting with UEFI, the RISC-V kernel will use only the EFI memory map to
+populate the system memory.
+
+The UEFI firmware must parse the subnodes of the ``/reserved-memory`` devicetree
+node and abide by the devicetree specification to convert the attributes of
+those subnodes (``no-map`` and ``reusable``) into their correct EFI equivalent
+(refer to section "3.5.4 /reserved-memory and UEFI" of the devicetree
+specification v0.4-rc1).
+
+RISCV_EFI_BOOT_PROTOCOL
+~~~~~~~~~~~~~~~~~~~~~~~
+
+When booting with UEFI, the EFI stub requires the boot hartid in order to pass
+it to the RISC-V kernel in ``$a1``. The EFI stub retrieves the boot hartid using
+one of the following methods:
+
+- ``RISCV_EFI_BOOT_PROTOCOL`` (**preferred**).
+- ``boot-hartid`` devicetree subnode (**deprecated**).
+
+Any new firmware must implement ``RISCV_EFI_BOOT_PROTOCOL`` as the devicetree
+based approach is deprecated now.
+
+Early Boot Requirements and Constraints
+=======================================
+
+The RISC-V kernel's early boot process operates under the following constraints:
+
+EFI stub and devicetree
+-----------------------
+
+When booting with UEFI, the devicetree is supplemented (or created) by the EFI
+stub with the same parameters as arm64 which are described at the paragraph
+"UEFI kernel support on ARM" in Documentation/arm/uefi.rst.
+
+Virtual mapping installation
+----------------------------
+
+The installation of the virtual mapping is done in 2 steps in the RISC-V kernel:
+
+1. ``setup_vm()`` installs a temporary kernel mapping in ``early_pg_dir`` which
+   allows discovery of the system memory. Only the kernel text/data are mapped
+   at this point. When establishing this mapping, no allocation can be done
+   (since the system memory is not known yet), so ``early_pg_dir`` page table is
+   statically allocated (using only one table for each level).
+
+2. ``setup_vm_final()`` creates the final kernel mapping in ``swapper_pg_dir``
+   and takes advantage of the discovered system memory to create the linear
+   mapping. When establishing this mapping, the kernel can allocate memory but
+   cannot access it directly (since the direct mapping is not present yet), so
+   it uses temporary mappings in the fixmap region to be able to access the
+   newly allocated page table levels.
+
+For ``virt_to_phys()`` and ``phys_to_virt()`` to be able to correctly convert
+direct mapping addresses to physical addresses, they need to know the start of
+the DRAM. This happens after step 1, right before step 2 installs the direct
+mapping (see ``setup_bootmem()`` function in arch/riscv/mm/init.c). Any usage of
+those macros before the final virtual mapping is installed must be carefully
+examined.
+
+Devicetree mapping via fixmap
+-----------------------------
+
+As the ``reserved_mem`` array is initialized with virtual addresses established
+by ``setup_vm()``, and used with the mapping established by
+``setup_vm_final()``, the RISC-V kernel uses the fixmap region to map the
+devicetree. This ensures that the devicetree remains accessible by both virtual
+mappings.
+
+Pre-MMU execution
+-----------------
+
+A few pieces of code need to run before even the first virtual mapping is
+established. These are the installation of the first virtual mapping itself,
+patching of early alternatives and the early parsing of the kernel command line.
+That code must be very carefully compiled as:
+
+- ``-fno-pie``: This is needed for relocatable kernels which use ``-fPIE``,
+  since otherwise, any access to a global symbol would go through the GOT which
+  is only relocated virtually.
+- ``-mcmodel=medany``: Any access to a global symbol must be PC-relative to
+  avoid any relocations to happen before the MMU is setup.
+- *all* instrumentation must also be disabled (that includes KASAN, ftrace and
+  others).
+
+As using a symbol from a different compilation unit requires this unit to be
+compiled with those flags, we advise, as much as possible, not to use external
+symbols.
diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index 81cf6e616476..4dab0cb4b900 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -6,6 +6,7 @@ RISC-V architecture
     :maxdepth: 1
 
     acpi
+    boot
     boot-image-header
     vm-layout
     hwprobe
-- 
2.39.2

