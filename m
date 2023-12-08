Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEAB809C06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573200AbjLHFzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjLHFzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:55:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA51720
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:55:03 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d075392ff6so14023435ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014903; x=1702619703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIC4glHzB+IOAGM7YCu4gQFdGXeLpWj/I7OZVSGOh7k=;
        b=P08wfLhZLVp03l/oDHQYVEsEgGHxNL73uQkfOF2REHD8CU/xGIjVdn6TTfwt7Z9Acq
         yc5mEZY6+zMF9WUpEkK2U3S1uISA2BG89ANRwcL4lHxC8Rh4VHKLZ3ajdOYMgS5ABoht
         UiFsalaJpQLxpgJROK1FFOjdCKzyxqIqj+Lqmk5HmOytUWQGFIwNv2BPFL+JSuhOvm5D
         Gao/0wdYqjQsQm5cY7zKoOKpv/TZ1raGHI8hieOaLnNUnvI+CHfmj9SRa3ijwjmhw7QD
         lo3SeRnwnr/5YPMJfY75InwAzTKn5kuuqEtzcz+qVTdzwsPw/TvhNGb9TU/DdOxBGXIf
         VYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014903; x=1702619703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIC4glHzB+IOAGM7YCu4gQFdGXeLpWj/I7OZVSGOh7k=;
        b=oXpE+7w8p7ZmA04IvXwNeYV1SVe9nNqtpOIE720rzB3Qf43Q1VWA4Byw7DBSXK5FMc
         9zY4WgYc5sddEbZ9nq3yFAgJVlyGNdBIBLFmPwqkooBKs5TnwggWg9I7/M7nCRHQKpCe
         b9MdB0p7Zsxfj9X5v5Oy1+J4L1T7PDYdeO5hPmitYLvNmZgw0lDOAjBQCinEL8hWpveI
         dcp0r+wQxFpYwW05Jg2UjJNxKwppcZqAtAK8+E1vP7sh9sgyq5gY5iMyQJWwBCNDAHf4
         dit9wjN1Rm8g4D5c6QKIvXO1S7NsMhUkO8IFe5TpuFZpYQ3OLpT2pfHx2qZbRoVjz6LU
         FpKQ==
X-Gm-Message-State: AOJu0Yxj52ZnV4YCG4VEZzFGIrhYWTB/cQ4aFwPghdYyv1Iqzpo2HJOZ
        BPAGPzBgDMgN4SrKmyLThle1TQ==
X-Google-Smtp-Source: AGHT+IHobgnIbAqUwh0qy5g87XS9Ops6tA3mZ0Tbbi2vny+WXvVENlMrplaMBh4oGzh2rC3HGh0NRQ==
X-Received: by 2002:a17:902:c20c:b0:1d0:6ffd:610c with SMTP id 12-20020a170902c20c00b001d06ffd610cmr481032pll.46.1702014902890;
        Thu, 07 Dec 2023 21:55:02 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:02 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 00/12] Unified cross-architecture kernel-mode FPU API
Date:   Thu,  7 Dec 2023 21:54:30 -0800
Message-ID: <20231208055501.2916202-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series supersedes my earier RISC-V specific series[1].

This series unifies the kernel-mode FPU API across several architectures
by wrapping the existing functions (where needed) in consistently-named
functions placed in a consistent header location, with mostly the same
semantics: they can be called from preemptible or non-preemptible task
context, and are not assumed to be reentrant. Architectures are also
expected to provide CFLAGS adjustments for compiling FPU-dependent code.
For the moment, SIMD/vector units are out of scope for this common API.

This allows us to remove the ifdeffery and duplicated Makefile logic at
each FPU user. It then implements the common API on RISC-V, and converts
a couple of users to the new API: the AMDGPU DRM driver, and the FPU
self test.

The underlying goal of this series is to allow using newer AMD GPUs
(e.g. Navi) on RISC-V boards such as SiFive's HiFive Unmatched. Those
GPUs need CONFIG_DRM_AMD_DC_FP to initialize, which requires kernel-mode
FPU support.

[1]: https://lore.kernel.org/linux-riscv/20231122030621.3759313-1-samuel.holland@sifive.com/


Samuel Holland (12):
  arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
  arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
  LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  riscv: Add support for kernel-mode FPU
  drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
  selftests/fpu: Move FP code to a separate translation unit
  selftests/fpu: Allow building on other architectures

 Makefile                                      |  4 ++
 arch/Kconfig                                  |  9 +++++
 arch/arm/Kconfig                              |  1 +
 arch/arm/Makefile                             |  7 ++++
 arch/arm/include/asm/fpu.h                    | 17 +++++++++
 arch/arm/lib/Makefile                         |  3 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/Makefile                           |  9 ++++-
 arch/arm64/include/asm/fpu.h                  | 17 +++++++++
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/Makefile                       |  5 ++-
 arch/loongarch/include/asm/fpu.h              |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/Makefile                         |  5 ++-
 arch/powerpc/include/asm/fpu.h                | 28 ++++++++++++++
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/Makefile                           |  3 ++
 arch/riscv/include/asm/fpu.h                  | 26 +++++++++++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c           | 28 ++++++++++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/Makefile                             | 20 ++++++++++
 arch/x86/include/asm/fpu.h                    | 13 +++++++
 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 33 +----------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 +-----------------
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 +-----------------
 lib/Kconfig.debug                             |  2 +-
 lib/Makefile                                  | 26 ++-----------
 lib/raid6/Makefile                            | 31 ++++------------
 lib/{test_fpu.c => test_fpu_glue.c}           | 37 +++----------------
 lib/test_fpu_impl.c                           | 35 ++++++++++++++++++
 32 files changed, 255 insertions(+), 185 deletions(-)
 create mode 100644 arch/arm/include/asm/fpu.h
 create mode 100644 arch/arm64/include/asm/fpu.h
 create mode 100644 arch/powerpc/include/asm/fpu.h
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c
 create mode 100644 arch/x86/include/asm/fpu.h
 rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
 create mode 100644 lib/test_fpu_impl.c

-- 
2.42.0

