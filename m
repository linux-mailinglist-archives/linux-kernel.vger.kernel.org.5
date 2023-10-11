Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2517C5A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjJKR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJKR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:28:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5258698
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:28:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7be940fe1so1099547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697045321; x=1697650121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LwuwjmnVQtXjn+X5MfT/OJgDNhPxUAgxvbWJ6WO5//o=;
        b=IXT8uKclxUzwcWT+thJ/UvkoT1GFIWMNl7FNEJIHHUH7bOrDotgNyOcEg9/dt5duHN
         JVh4l18b32Su5y71VGUwP2lN1G1949xhHN7FxCqSiC6Kh4h1FqTQP1vx063qdv/uc16k
         XUIJmDYmBPXEkwRH0F90h8Pi96Nc5UYPYMpcNR/4eVSKRm/w2SrBh0kkb9keNcW8L4Zh
         DI5NnH8MQZxa95v9c3G+pBKbZA8AYUR8p8/KY/yEmor9uz71NkZ+nJo7W1uAzhLQypNH
         3dHRIM0ZNzGEVGAYBChpV9QIVrhWeSOcnRl5PcpYpZ0rXaHPFJU+4AdI22P+OFqVBHsT
         ooag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045321; x=1697650121;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwuwjmnVQtXjn+X5MfT/OJgDNhPxUAgxvbWJ6WO5//o=;
        b=vczjecMVi5GxjSnQQIX4xlw1XS2wenvesquxGadh/I8CsfJ9nv774FijXkpqTMk5lb
         JtPMT7/oWIJBwr/bFBaz3GgDqPrPnVsKLoZcC2TSXyIZHpsmcwEWBKlOPtFtvRcEJukh
         ZxCKLDkKIgkYQEdbmLDgGo/IUYEjvB8s0slpfEMNjJbNYmJ1qyQnPb+gM0ZKxr1wNEmY
         FdUCxpKULvlaIbtgCfdlf9Kbhax4820DgjfVnTbNxT7S5Y/8MmA0BPbpj1I9xMB+0caj
         bvVkKMONmPVR8LY7CWVbY7hMsc0ALyFS/J90LRe5BOUNUlGGnq0zAbGBJsSEWAO4kyg5
         sjpg==
X-Gm-Message-State: AOJu0Yztf8G+NEIMlGycjKi/tLj23wGnd9yQHqgI5uczhvEzu/uozcpA
        0fjCKSVnrr73jUj0v+sMvFfZ/VaN2l8=
X-Google-Smtp-Source: AGHT+IFvIDL4pU0iR3JbDQTfyYNeAbR+jnr/Y9Dj6FlrLQu03dzX/AaLuKzGaLQWxlfGgKbV7k2zpTomtb0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:fe58:8292:66f9:d221])
 (user=glider job=sendgmr) by 2002:a25:d4d2:0:b0:d9a:38e4:78b5 with SMTP id
 m201-20020a25d4d2000000b00d9a38e478b5mr140459ybf.5.1697045321463; Wed, 11 Oct
 2023 10:28:41 -0700 (PDT)
Date:   Wed, 11 Oct 2023 19:28:30 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011172836.2579017-1-glider@google.com>
Subject: [PATCH v7 0/5] Implement MTE tag compression for swapped pages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when MTE pages are swapped out, the tags are kept in the
memory, occupying PAGE_SIZE/32 bytes per page. This is especially
problematic for devices that use zram-backed in-memory swap, because
tags stored uncompressed in the heap effectively reduce the available
amount of swap memory.

The RLE-based algorithm suggested by Evgenii Stepanov and implemented in
this patch series is able to efficiently compress fixed-size tag buffers,
resulting in practical compression ratio between 2.5x and 4x. In most
cases it is possible to store the compressed data in 63-bit Xarray values,
resulting in no extra memory allocations.

Our measurements show that the proposed algorithm provides better
compression than existing kernel compression algorithms (LZ4, LZO,
LZ4HC, ZSTD) can offer.

To implement compression/decompression, we also extend <linux/bitmap.h>
with methods to read/write bit values at arbitrary places in the map.

We refactor arch/arm64/mm/mteswap.c to support both the compressed
(CONFIG_ARM64_MTE_COMP) and non-compressed case. For the former, in
addition to tag compression, we move tag allocation from kmalloc() to
separate kmem caches, providing greater locality and relaxing the
alignment requirements.

v7:
 - fixed comments by Yury Norov, Andy Shevchenko, Rasmus Villemoes
 - added perf tests for bitmap_read()/bitmap_write()
 - more efficient bitmap_write() implementation (meant to be sent in v5)

v6:
 - fixed comments by Yury Norov
 - fixed handling of sizes divisible by MTE_GRANULES_PER_PAGE / 2
   (caught while testing on a real device)

v5:
 - fixed comments by Andy Shevchenko, Catalin Marinas, and Yury Norov
 - added support for 16K- and 64K pages
 - more efficient bitmap_write() implementation

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
  lib/test_bitmap: add tests for bitmap_{read,write}()
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c

Syed Nayyar Waris (1):
  lib/bitmap: add bitmap_{read,write}()

 Documentation/arch/arm64/index.rst            |   1 +
 .../arch/arm64/mte-tag-compression.rst        | 266 +++++++++
 arch/arm64/Kconfig                            |  21 +
 arch/arm64/include/asm/mtecomp.h              |  13 +
 arch/arm64/mm/Makefile                        |   7 +
 arch/arm64/mm/mtecomp.c                       | 524 ++++++++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 arch/arm64/mm/mteswap.c                       |  20 +-
 arch/arm64/mm/mteswap.h                       |  12 +
 arch/arm64/mm/mteswap_comp.c                  |  60 ++
 arch/arm64/mm/mteswap_nocomp.c                |  38 ++
 arch/arm64/mm/test_mtecomp.c                  | 377 +++++++++++++
 include/linux/bitmap.h                        |  75 +++
 lib/test_bitmap.c                             | 166 ++++++
 14 files changed, 1581 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mtecomp.h
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.42.0.609.gbb76f46606-goog

