Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3E7AABE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjIVIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjIVII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:08:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC812197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:08:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e758d6236so26959007b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695370132; x=1695974932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R4vswqebvpspbaowrRGzYOJlYeKRdv743foMaraS4cU=;
        b=HWFEGK1dWuF3ovte4SwuuaomIvyhgIyv83FNLdlXLzPz89rOcGKvc7mujLW2vekAon
         BgtmpmnOUJkOntvzzN/dKUKmIhw68PWwv1TW07Gx/bZIRk8gmzryXtOa+S+V7/7HRZRL
         iRFTKYob260qJWlz23fbvcyiMgVh0CCG9HS2P7NqTFy12+nI9hjbSYUyJdJAlQMXPy1D
         YA7hu2RT0yM8CGqjXGdFhvDcM6TASUqSZXg/jfT/UTKt8uN3v7DwvPVvKDp3vTcqM3jZ
         7mu9E7tJzeufyeeb7qGxDl+bQHjhk4b12vXEmiFzJBKweMtFIaS7cJOLIvxmY6Kbd/Hh
         eAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695370132; x=1695974932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R4vswqebvpspbaowrRGzYOJlYeKRdv743foMaraS4cU=;
        b=YYBCQAtZ6zAT1XZVdVnorFFWuiq2uKKlpVKN9r+CSgOFxtNIYfVCdkAiaOZ/LHhvNY
         8stWAxgC8Q206dFIQsGEDzv86vBQ3qpqAihgl28z5WhB9GDsFj7C0gqU4eTJgDq7CC9i
         5ZsZK4tr5ysOlKC2N1CDlxQPfTHwDWRHtPg9USEqZdGTn6TKoGJdSasuyMsMYl4CCroO
         KgefIilUGGd00DuHKe/xCI9KJms8OwHY13tEcU7dQHZi6U821zMbZ01iEkvJLuXDjlBK
         wGCHyrkvCpNI3XlmVy3wKhNfbXBT7BmnsQ5wFKNXstcKiWY03tUA9reQHDW3pu2wDkvP
         A5xA==
X-Gm-Message-State: AOJu0Yxs5sm7BIvbQF4TotRAFNkPtP47BlH/cgQQH9E3hgYqkXK6CyE3
        pD4yKHxJuItObsc7XqcziJbbi+HNjX8=
X-Google-Smtp-Source: AGHT+IGiDnMlo8gIzd5NqRZ/HkqDSPWlC0atM2jbQjQWc3jmvV9CTqTdBrKz6RhUPrTffre1wurvCgcosPs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4da0:80d4:9480:7d5c])
 (user=glider job=sendgmr) by 2002:a81:ae68:0:b0:59b:e663:23b9 with SMTP id
 g40-20020a81ae68000000b0059be66323b9mr113127ywk.1.1695370132027; Fri, 22 Sep
 2023 01:08:52 -0700 (PDT)
Date:   Fri, 22 Sep 2023 10:08:42 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922080848.1261487-1-glider@google.com>
Subject: [PATCH v5 0/5] Implement MTE tag compression for swapped pages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../arch/arm64/mte-tag-compression.rst        | 245 +++++++++
 arch/arm64/Kconfig                            |  21 +
 arch/arm64/include/asm/mtecomp.h              |  13 +
 arch/arm64/mm/Makefile                        |   7 +
 arch/arm64/mm/mtecomp.c                       | 467 ++++++++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 arch/arm64/mm/mteswap.c                       |  20 +-
 arch/arm64/mm/mteswap.h                       |  12 +
 arch/arm64/mm/mteswap_comp.c                  |  60 +++
 arch/arm64/mm/mteswap_nocomp.c                |  38 ++
 arch/arm64/mm/test_mtecomp.c                  | 287 +++++++++++
 include/linux/bitmap.h                        |  68 +++
 lib/test_bitmap.c                             | 115 +++++
 14 files changed, 1355 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mtecomp.h
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.42.0.515.g380fc7ccd1-goog

