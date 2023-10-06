Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EF7BB99E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjJFNp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjJFNps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:45:48 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F397181
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:45:35 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-3217fdf913dso1583510f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696599933; x=1697204733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OtrAKvkMflYTL+omQBnC5NvMsnVi6sQ3TFEd0qd0ZG0=;
        b=O4T9lU/mURNyyyqIs88yj3Vtxog5kQ6+cPcru/PnqPMoyolZ6wtZtc8rQo4JLpRKc9
         +mMS9cDF3VNgS3AAXQAtgZgwPDaGKRIKg3+xBZWlck3tHQzYGT7xeKY12NBzfIzyqV0e
         HkkJ0PKYvKlHsJLyBnyojVrtm6jIx+0gx8OkvZcuIh3e7dQ/ORcN3HeVh57MFyzzi7zO
         DlFakDhbZqzgZqJP/P0eMOT6ZCD8g/Ep7VcWgBRlGLsrm9mXFpqX4s7YDTF7K1OR3ZpL
         i+Vl4XdO6bT0VdZE5MwTTMZ6hVoYYAKqWs0aHXiAVhQCVAwA0KA7XpOhKQoJxPZofw8e
         B9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599933; x=1697204733;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtrAKvkMflYTL+omQBnC5NvMsnVi6sQ3TFEd0qd0ZG0=;
        b=QK6OchyUsxw4k9jLEhnPHcA3/ChKJaxy45O22R7Gk8WiE4I3jKrWpNnD6PzjbJInH+
         XI0tVLAQDSiIyyq5xNlsmhkX2QDJxoKNiKRRk9l+vCn05MLLMlozWhHwFv8NLV9aSBvl
         eaqQj5E9GpBU8Z7wpz600Tg2PkXZWbXh625n7ZHLT0p/RPvhXcYVFCixPJn9RUJFC4CF
         ps6s89bndMmHAGYi3SuG5UI+pdljhedbVBZ4YD2okpFhM+OSjFuDrOHxM75sVFn6mtzw
         RconZ6gTkkUIeLmUHAztzKyfrNhv1K2G77weT20vKhEvEvbstG/Rx4NkVNpNCB5BOAi+
         FVDg==
X-Gm-Message-State: AOJu0Yy7duGhlwpI3Pm6/7Gpq2hLTJyDmk8h1AOiwUFZ0xMx/YaOj5Y8
        aq7pgOiKSeDRRYYrDSW+OzbDeyRwUCk=
X-Google-Smtp-Source: AGHT+IGb2cjEpqpBiIxzfPcD7K+9H+vfdX5CJqGEai4UM1Lm/lfEASgpnVc0FwnbuY0gHX3Q3GYs/ydoebc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2691:23e9:f01f:964])
 (user=glider job=sendgmr) by 2002:a5d:6549:0:b0:319:8430:f801 with SMTP id
 z9-20020a5d6549000000b003198430f801mr52714wrv.2.1696599933422; Fri, 06 Oct
 2023 06:45:33 -0700 (PDT)
Date:   Fri,  6 Oct 2023 15:45:24 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006134529.2816540-1-glider@google.com>
Subject: [PATCH v6 0/5] Implement MTE tag compression for swapped pages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com
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
 include/linux/bitmap.h                        |  68 +++
 lib/test_bitmap.c                             | 118 ++++
 14 files changed, 1526 insertions(+), 11 deletions(-)
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

