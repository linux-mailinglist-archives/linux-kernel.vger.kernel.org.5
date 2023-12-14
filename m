Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1C812E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443892AbjLNLGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443910AbjLNLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:06:42 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154012C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:06:48 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-333501e22caso6205288f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702552006; x=1703156806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxQzspHe7zUTJxgwsmv/wupQFTZZ1fYtpU5Xj8U0vX4=;
        b=283IYO+SDQ/UJr4bzIB7PFY0ZhJEEmIM1qUaMC85WmvdKgyjRQQoTSu2hDHeIr7BRd
         wONgkIlzIDNLhyuVXu8R6JMSILlMANbvA2tgRxFAtQYZhQR8TmnQFh3AVp7Mn7Ranczk
         qNv9EL6n73IsFdXLOWDIaRKrCl73IgvtLYGadZ6FDPb9eb53fzC7cxfaysb9WpinS55I
         0vYXt8QUFqc9TT5fX99z5C97PI9l9/DMdDI5cfiMos53rzqLyjOCQzImPZfhDrbOKVKT
         xRDARDDbUa9R3rBjrmqVztKxMBK9dlElj+yL5D2+lnV+unjvdXtE90cxF9fvA9ayCOha
         G0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552006; x=1703156806;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxQzspHe7zUTJxgwsmv/wupQFTZZ1fYtpU5Xj8U0vX4=;
        b=rJxabCIX8sXkK/ixfubZBdjsIC77bCeCmHFJ03A/2+3z8vRoyZkjNPq4AQxHL94I2A
         OPSGrxtc51klRbAq1yxFMQzKBVPU1kkROA0cNnkzM8eO1IM7MjHKakRqfR9IfluzFFnL
         tay0CIssXlmmHIcnNDj7iwdmXdxNgMOk/nntLL1UXDLI5ccI1KUueAPiGz1rge5lT5D5
         jWlvnk/I6+JdNw34SmkiCyR6BDk/P/PRA2Usv+fULfT6vk2VsALlJ4xMASH+ohIJcqJM
         /QMOaiDf6GIfoUIcuKQ3bebJWRG0XyUoWr1o2KHaBDYGksHMD3td+czxBvzLRTIkJscv
         3qhQ==
X-Gm-Message-State: AOJu0YxkNts+2WLg9WgMGKwED5Nh0SXFZokfde9NvGDUARhiftMnVn/2
        IZowgBa6LoQyjPGT43FuNqXbTcHqRJk=
X-Google-Smtp-Source: AGHT+IGMKnQPwwwiWWoX0llBK0P2iontezG4gLDcsQN7qdh3Rh6ZSgqvPXK9BoS6aWvD7C6GcGIHC4Tvkss=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8447:3e89:1f77:ff8a])
 (user=glider job=sendgmr) by 2002:a5d:64e3:0:b0:334:b38b:6deb with SMTP id
 g3-20020a5d64e3000000b00334b38b6debmr54429wri.14.1702552006212; Thu, 14 Dec
 2023 03:06:46 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:06:32 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214110639.2294687-1-glider@google.com>
Subject: [PATCH v10-mte 0/7] Implement MTE tag compression for swapped pages
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
resulting in practical compression ratio of 2x. In many cases it is
possible to store the compressed data in 63-bit Xarray values, resulting
in no extra memory allocations.

To implement compression/decompression, we also extend <linux/bitmap.h>
with methods to read/write bit values at arbitrary places in the map.

This patch series depends on "lib/bitmap: add bitmap_{read,write}()"
(https://lore.kernel.org/linux-arm-kernel/20231030153210.139512-1-glider@google.com/T/)
that is mailed separately.

v10-mte:
 - add the bitmap_read()/bitmap_write() patches
   (https://lore.kernel.org/lkml/20231109151106.2385155-1-glider@google.com/)
   back to this series
 - add Acked-by: tags to MTE patches

v9:
 - split off the stats collection code into a separate patch in the
   series (as suggested by Yury Norov)

v8:
 - split off the bitmap_read()/bitmap_write() series
 - simplified the compression logic (only compress data if it fits into
   a pointer)

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


Alexander Potapenko (6):
  lib/test_bitmap: add tests for bitmap_{read,write}()
  lib/test_bitmap: use pr_info() for non-error messages
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c
  arm64: mte: implement CONFIG_ARM64_MTE_SWAP_STATS

Syed Nayyar Waris (1):
  lib/bitmap: add bitmap_{read,write}()

 Documentation/arch/arm64/index.rst            |   1 +
 .../arch/arm64/mte-tag-compression.rst        | 166 ++++++++
 arch/arm64/Kconfig                            |  37 ++
 arch/arm64/include/asm/mtecomp.h              |  39 ++
 arch/arm64/mm/Makefile                        |   2 +
 arch/arm64/mm/mtecomp.c                       | 257 +++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 arch/arm64/mm/mteswap.c                       | 110 +++++-
 arch/arm64/mm/test_mtecomp.c                  | 364 ++++++++++++++++++
 include/linux/bitmap.h                        |  77 ++++
 lib/test_bitmap.c                             | 185 ++++++++-
 11 files changed, 1237 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mtecomp.h
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.43.0.472.g3155946c3a-goog

