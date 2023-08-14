Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70C77C1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjHNU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHNU6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:58:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E98C3;
        Mon, 14 Aug 2023 13:58:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso43001065e9.3;
        Mon, 14 Aug 2023 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692046717; x=1692651517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0A4A3WqLpjSmFP0W9YhFtOsFDHMwWhpbQHtyJDhofZQ=;
        b=K7CgABcOCoN88bhx5ZegXuyGVTnOsQ1l5DXIE7cqOJqaG9OebMw7Lpxm0gkJ0Dq40s
         nw7ioDMvmDXQQ8PibW5T1kQdxUPLVWyB+ktRH63FMzGeTGcDOXSbna6X0vH6554KEC+5
         KjARNDOFL9XVP30jMeqVMOGwa19UhWkZA8Jij8npyqG+1eL3Pj2vb67hmzJUHmEQj+MP
         Pnm8xLJDu8EHhspGsVjeyj+yTW6+pZwNPQ99nKyOTc4cZiIY/fuu0g0hDwtKVbyir7TX
         Py4/aQxOceJ0nUxq8bVGkO+nlV/RYZQMbq1NGEw0B0Kjq9QCQCJrzszs23z5iSVzhDPE
         d1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046717; x=1692651517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0A4A3WqLpjSmFP0W9YhFtOsFDHMwWhpbQHtyJDhofZQ=;
        b=MuVR5sv68Zn1bggq+t53Wq7OL1lBOZFCA667Jd1ArZiqflQyz7xJjdpJJtAJuTzYt9
         bUzb2+1ETIYmpD4+t8TE/BinUCidaEVZjwnevKNvM/Cf/P0p+XocgyN/5ibJ3gjCf5uy
         lij8yw0NyNL6gpanuLH3IgCTarsEEUHYto26csrdZ0ACQuBF2iIF9K9sbPfyApIkXgJy
         m3H9WR2Dmn28EdnItVeYS5Ff0uacMSCsX8PPnftAukBBuU87v9JbRdQtLI4Lmn+ZCPPy
         3g9F2TVeqRcCfQTs7PaoYhJOLMxDQ1suu6OLfSGQx9TqF52q9m2T448GKmWssCEhcPo3
         P7iw==
X-Gm-Message-State: AOJu0YwC4t3iGT0YpAdmQWNP3IZi9nivpC3uUkZEfE2cUDebzfyRGeMz
        nOdaImowNCsUnu24f3ACTRo=
X-Google-Smtp-Source: AGHT+IE5mW1TReGZDvV5xY+VNTlXFWfRsj3NGnJl/RV4Rww2zHvRyKicT3U3leN6QxQAzTyATGEOfg==
X-Received: by 2002:a05:6000:511:b0:317:648c:3895 with SMTP id a17-20020a056000051100b00317648c3895mr7387352wrf.33.1692046717355;
        Mon, 14 Aug 2023 13:58:37 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id h5-20020adffa85000000b003197efd1e7bsm2161806wrr.114.2023.08.14.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:58:36 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v11 0/6] Add non-coherent DMA support for AX45MP
Date:   Mon, 14 Aug 2023 21:57:13 +0100
Message-Id: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

non-coherent DMA support for AX45MP
====================================

On the Andes AX45MP core, cache coherency is a specification option so it
may not be supported. In this case DMA will fail. To get around with this
issue this patch series does the below:

1] Andes alternative ports is implemented as errata which checks if the
IOCP is missing and only then applies to CMO errata. One vendor specific
SBI EXT (ANDES_SBI_EXT_IOCP_SW_WORKAROUND) is implemented as part of
errata.

Below are the configs which Andes port provides (and are selected by
RZ/Five):
      - ERRATA_ANDES
      - ERRATA_ANDES_CMO

OpenSBI patch supporting ANDES_SBI_EXT_IOCP_SW_WORKAROUND SBI is now
part v1.3 release.

2] Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
block that allows dynamic adjustment of memory attributes in the runtime.
It contains a configurable amount of PMA entries implemented as CSR
registers to control the attributes of memory locations in interest.
OpenSBI configures the PMA regions as required and creates a reserve memory
node and propagates it to the higher boot stack.

Currently OpenSBI (upstream) configures the required PMA region and passes
this a shared DMA pool to Linux.

    reserved-memory {
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;

        pma_resv0@58000000 {
            compatible = "shared-dma-pool";
            reg = <0x0 0x58000000 0x0 0x08000000>;
            no-map;
            linux,dma-default;
        };
    };

The above shared DMA pool gets appended to Linux DTB so the DMA memory
requests go through this region.

3] We provide callbacks to synchronize specific content between memory and
cache.

4] RZ/Five SoC selects the below configs
        - AX45MP_L2_CACHE
        - DMA_GLOBAL_POOL
        - ERRATA_ANDES
        - ERRATA_ANDES_CMO

----------x---------------------x--------------------x---------------x----

Note,
- Ive used GCC 12.2.0 for compilation
- Tested all the IP blocks on RZ/Five which use DMA
- Patch series is dependent on the series from Arnd,
  https://patchwork.kernel.org/project/linux-riscv/cover/20230814202821.78120-1-prabhakar.mahadev-lad.rj@bp.renesas.com/.
  (Ive rebased Arnd's series on v6.5-rc-5)
- Patches applies on top of palmer/master (25aa0bebba72) +
  palmer/for-next (174e8ac0272d5) + palmer/fixes (7e3811521dc39)
- Ive pushed the complete tree here https://github.com/prabhakarlad/linux/tree/rzfive-cmo-v11

v10 -> v11
* Included RB/TB tags from Conor
* Fixed review comments pointed by Geert to rename cache callbacks
* Dropped preserving the cache lines in ax45mp_dma_cache_inv() callback

v9 -> v10
* Included RB/TB tags from Conor
* Fixed review comments pointed by Geert to rename cache callbacks
* Dropped preserving the cache lines in ax45mp_dma_cache_inv() callback

v8 -> v9
* Dropped adding ALTERNATIVE_3
* Implemented function pointer support for nonstandard noncoherent systems
* Added a new config option CONFIG_RISCV_NONSTANDARD_CACHE_OPS
* Updated Andes errata code to drop patching the calls as we no more use
  ALTERNATIVE_X() macro.
* Updated Andes CMO code to use function pointer for doing cache management.

v7 -> v8
* Dropped using function pointers and switched to ALTERNATIVE_X()
* Added new patches (#1, #2)

v6 -> v7
* Reworked the code based on Arnd's work
* Fixed review comments pointed by Arnd
* Fixed review comments pointed by Conor

v5.1 -> v6
* Dropped use of ALTERNATIVE_x() macro
* Now switched to used function pointers for CMO
* Moved driver to drivers/cache folder

v5 -> v5.1
* https://patchwork.kernel.org/project/linux-riscv/list/?series=708610&state=%2A&archive=both

v4 -> v5
* Rebased ALTERNATIVE_3() macro on top of Andrew's patches
* Rebased the changes on top of Heiko's alternative call patches
* Dropped configuring the PMA from Linux
* Dropped configuring the L2 cache from Linux and dropped the binding for same
* Now using runtime patching mechanism instead of compile time config

RFC v3 -> v4
* Implemented ALTERNATIVE_3() macro
* Now using runtime patching mechanism instead of compile time config
* Added Andes CMO as and errata
* Fixed comments pointed by Geert

RFC v2-> RFC v3
* Fixed review comments pointed by Conor
* Move DT binding into cache folder
* Fixed DT binding check issue
* Added andestech,ax45mp-cache.h header file
* Now passing the flags for the PMA setup as part of andestech,pma-regions
  property.
* Added andestech,inst/data-prefetch and andestech,tag/data-ram-ctl
  properties to configure the L2 cache.
* Registered the cache driver as platform driver

RFC v1-> RFC v2
* Moved out the code from arc/riscv to drivers/soc/renesas
* Now handling the PMA setup as part of the L2 cache
* Now making use of dma-noncoherent.c instead SoC specific implementation.
* Dropped arch_dma_alloc() and arch_dma_free()
* Switched to RISCV_DMA_NONCOHERENT
* Included DT binding doc

RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (6):
  riscv: asm: vendorid_list: Add Andes Technology to the vendors list
  riscv: errata: Add Andes alternative ports
  riscv: mm: dma-noncoherent: nonstandard cache operations support
  dt-bindings: cache: andestech,ax45mp-cache: Add DT binding
    documentation for L2 cache controller
  cache: Add L2 cache management for Andes AX45MP RISC-V core
  soc: renesas: Kconfig: Select the required configs for RZ/Five SoC

 .../cache/andestech,ax45mp-cache.yaml         |  81 +++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/Kconfig                            |   7 +
 arch/riscv/Kconfig.errata                     |  21 ++
 arch/riscv/errata/Makefile                    |   1 +
 arch/riscv/errata/andes/Makefile              |   1 +
 arch/riscv/errata/andes/errata.c              |  66 ++++++
 arch/riscv/include/asm/alternative.h          |   3 +
 arch/riscv/include/asm/dma-noncoherent.h      |  28 +++
 arch/riscv/include/asm/errata_list.h          |   5 +
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 arch/riscv/kernel/alternative.c               |   5 +
 arch/riscv/mm/dma-noncoherent.c               |  43 ++++
 arch/riscv/mm/pmem.c                          |  13 ++
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/cache/Kconfig                         |  11 +
 drivers/cache/Makefile                        |   3 +
 drivers/cache/ax45mp_cache.c                  | 213 ++++++++++++++++++
 drivers/soc/renesas/Kconfig                   |   4 +
 20 files changed, 516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

-- 
2.34.1

