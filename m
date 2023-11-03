Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD167E0623
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjKCQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjKCQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:03:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C2CA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:03:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da040c021aeso2526962276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027419; x=1699632219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTzXxPv+gObuuXQua2/KBmP4Hxk1HM7FnDHk5jUfbw4=;
        b=bTQRZquv+FPn1uDggpHuh+TsylPV1ByoIx70jjWT7FW0rcw970VgvYNzA3cvEz051I
         XmBDNFYBQN9EHjK7V7ByNMyMbvyAfyWVTdYdGcjZx6eGbgvmgoYSsOnrG+/ST3OJphOT
         DVRxHP/aEiKgjQ9CuRoYKRrubommkYUIUD1gMKPhsFp9GQYqNP/aTnG+L72agxhK6imD
         P/NE7F28v9Q3jXkQMzFkSDF5J6UtD+LzeTGnKfBxg8NY37sNSPXA2a+uACut0iB7PteK
         XcAY1I/bD5YI0tgzY+OF9mNQlEOnmpE//0eKmrD7JlpK0BeptMgcFUCYB6tIBqWbQGd8
         6F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027419; x=1699632219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTzXxPv+gObuuXQua2/KBmP4Hxk1HM7FnDHk5jUfbw4=;
        b=qkq7RcMvnOk8+R7R0KLrR5EtDjg9Op836j820yl7ZAn/fpGKx6jzaWhLr1xYCXoDn8
         Y1lptn7YxMkrIJtm2eb2rmURzPxkQ5MXvzRN7B2tUGt7edQf/PlP7T+uL/O8rQjz53j4
         UxOlzT75smGrHoSkCvbNr7MLQRLzwNCnnomKuDD/VTgBSZuPaLhtU9xTeyL05RAad5Jy
         ll0dL2vJ3NClNHJgElU0CoJbMl5N/+glawUBMyYFa55HrCxKSQPiAyq/15kneWtf1DAY
         LjDhTgd1+c3gtotVBcH4MsbsdPiwhYmhpvUCjSqmh4nGYSRmNkw7TupiZqSUTEoGwMQo
         Zg/A==
X-Gm-Message-State: AOJu0YxV6XgL/oWBjR8h/MRXsLQ0BbMvCLZQeMBW2+TM70Iyz+t1mfdN
        kCFbHIo0+d+YvryZmMvcV5+ALyMHL+M=
X-Google-Smtp-Source: AGHT+IHMdfpUDNksgB/Anwg08XNWUFG0UAqwDQelIsUFZSICwXGPRzrG+IYrnbhm1ObmCNhZXQ0QXsqhIJY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:74c:1f8e:4661:7aaa])
 (user=glider job=sendgmr) by 2002:a25:488:0:b0:da0:5452:29f7 with SMTP id
 130-20020a250488000000b00da0545229f7mr425792ybe.4.1699027419431; Fri, 03 Nov
 2023 09:03:39 -0700 (PDT)
Date:   Fri,  3 Nov 2023 17:03:32 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103160335.2464561-1-glider@google.com>
Subject: [PATCH v8 0/3] Implement MTE tag compression for swapped pages
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

This patch series depends on "lib/bitmap: add bitmap_{read,write}()"
(https://lore.kernel.org/linux-arm-kernel/20231030153210.139512-1-glider@google.com/T/)
that is mailed separately.

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



Alexander Potapenko (3):
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c

 Documentation/arch/arm64/index.rst            |   1 +
 .../arch/arm64/mte-tag-compression.rst        | 154 ++++++++
 arch/arm64/Kconfig                            |  21 +
 arch/arm64/include/asm/mtecomp.h              |  39 ++
 arch/arm64/mm/Makefile                        |   2 +
 arch/arm64/mm/mtecomp.c                       | 257 +++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 arch/arm64/mm/mteswap.c                       |  88 ++++-
 arch/arm64/mm/test_mtecomp.c                  | 364 ++++++++++++++++++
 9 files changed, 934 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mtecomp.h
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.42.0.869.gea05f2083d-goog

