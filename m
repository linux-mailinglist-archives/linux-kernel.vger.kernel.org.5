Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956975B5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGTRkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGTRkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:40:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55BE52
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cfdebfe9c14so789628276.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874800; x=1690479600;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXAvwU8PCBDNP3WmfE01iwMkKtvsYZg4exTztqekXrg=;
        b=44CqHRSEm6INB+DXI2owqq2rdfKaoCskgqstxzTUuCE3JQY7euGu3GtKuqfhJ4Azsa
         daoKakRV1zO3kP1yLp8rhhvktP8/6Hv9+cXkqRxEjOMDGns33sVtj+bn96QPQ4/e+Xa8
         LLkDt01HZgrhuHnATUXoazGZv/vBu06YVwmivVz2KpzjLq+2Hy0X092bwj9aEziA328w
         B2vsDnuPmvSw8B9bNIDB/O3U67ihWHNXgLyMOHIc8h22K2VqOXHoF+84nMTNzQyxblaP
         McMT8Jb633yicJf4ovZGX5/YnY7DVMjOa5SEOSlp2M6R0+DDGk8kPtjghuqbM2OmGQsS
         FLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874800; x=1690479600;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXAvwU8PCBDNP3WmfE01iwMkKtvsYZg4exTztqekXrg=;
        b=cx5vgM76BGoBH5DGe4BbkfVqCuEsx7+HI8as1KziW+Y7hH1cIiq+nMzxwOF/xwdfDC
         Yz57Bl6U8TfMup59rrxSXfJbJqK8Xw2/hRXRfElq9knv+sZ6pduRwp/NRseOeCGzgTJZ
         atLIBII5Ah9HfoXp7VmXGLs8lp4Nixg+uMYXnsS6NlwJ4fT+gRJgpyUZtdZXr2XfQ2kO
         qhlJFMt5wQjRhYzsPdB+KUgxwF+KWLXZlaLL2OdJoN84SVOCzWyan/lpY3mti+b422qP
         mLfEWzcAUvvV8LpUHB3F6cJm/v/Y+hh/xNhIHkb+EK1J/58yq+5URebG9MguUkP/ecQ0
         TGcg==
X-Gm-Message-State: ABy/qLaMaBreu+hiDDi8E2QOy8hGS6slNcDNDvfetGxxBvZxsEdKRdlE
        Y1UjzURzbXv/iByKMYauOHXQW/KmGDA=
X-Google-Smtp-Source: APBJJlHcrSfGWICYrKCTQHwEKkGwtJESJFM4ZLN4JtQZ6u5LVrtT+xoC2j69M0nDoBDlMsg511qhRE/wdPs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c495:c29a:e275:1dfb])
 (user=glider job=sendgmr) by 2002:a05:6902:10c5:b0:ca1:abd7:47d3 with SMTP id
 w5-20020a05690210c500b00ca1abd747d3mr50018ybu.9.1689874800280; Thu, 20 Jul
 2023 10:40:00 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:39:51 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720173956.3674987-1-glider@google.com>
Subject: [PATCH v4 0/5] Implement MTE tag compression for swapped pages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when MTE pages are swapped out, the tags are kept in the
memory, occupying 128 bytes per page. This is especially problematic
for devices that use zram-backed in-memory swap, because tags stored
uncompressed in the heap effectively reduce the available amount of
swap memory.

The RLE-based EA0 algorithm suggested by Evgenii Stepanov and
implemented in this patch series is able to efficiently compress
128-byte tag buffers, resulting in practical compression ratio between
2.5x and 20x. In most cases it is possible to store the compressed data
in 63-bit Xarray values, resulting in no extra memory allocations.

Our measurements show that EA0 provides better compression than existing
kernel compression algorithms (LZ4, LZO, LZ4HC, ZSTD) can offer, because
EA0 specifically targets 128-byte buffers.

To implement compression/decompression, we also extend <linux/bitmap.h>
with methods to set/get bit values at arbitrary places in the map.

We refactor arch/arm64/mm/mteswap.c to support both the compressed
(CONFIG_ARM64_MTE_COMP) and non-compressed case. For the former, in
addition to tag compression, we move tag allocation from kmalloc() to
separate kmem caches, providing greater locality and relaxing the
alignment requirements.

v4:
 - fixed a bunch of comments by Andy Shevchenko and Yury Norov
 - added Documentation/arch/arm64/mte-tag-compression.rst

v3:
 - as suggested by Andy Shevchenko, use
   bitmap_get_value()/bitmap_set_value() written by Syed Nayyar Waris
 - switched to unsigned long to reduce typecasts
 - simplified the compression code

v2:
 - as suggested by Yuri Norov, replace the poorly implemented struct
   bitq with <linux/bitmap.h>



Alexander Potapenko (4):
  lib/test_bitmap: add tests for bitmap_{set,get}_value()
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c

Syed Nayyar Waris (1):
  lib/bitmap: add bitmap_{set,get}_value()

 Documentation/arch/arm64/index.rst            |   1 +
 .../arch/arm64/mte-tag-compression.rst        | 212 ++++++++++
 arch/arm64/Kconfig                            |  19 +
 arch/arm64/include/asm/mtecomp.h              |  13 +
 arch/arm64/mm/Makefile                        |   7 +
 arch/arm64/mm/mtecomp.c                       | 382 ++++++++++++++++++
 arch/arm64/mm/mteswap.c                       |  20 +-
 arch/arm64/mm/mteswap.h                       |  12 +
 arch/arm64/mm/mteswap_comp.c                  |  54 +++
 arch/arm64/mm/mteswap_nocomp.c                |  38 ++
 arch/arm64/mm/test_mtecomp.c                  | 217 ++++++++++
 include/linux/bitmap.h                        |  60 +++
 lib/test_bitmap.c                             |  81 ++++
 13 files changed, 1105 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.41.0.487.g6d72f3e995-goog

