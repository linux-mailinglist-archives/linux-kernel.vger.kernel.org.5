Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8F7561AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGQLhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:37:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144DBF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c926075a50cso8591235276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689593833; x=1692185833;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xYv4V4b0xoYvwQpX2K4ZRcvLQvhVYz6YxW8k/QuP+50=;
        b=JswCLXIyw4aNMNLj4Os5G6MDwT36EIoBrxHx0J5DU1NgUCBeXfgLJxmSB13+rw6YwG
         +xueK+VeS7KyZAxDokA/xpDESoMC9moujQtUitazxJaMMw3SG0P4bGjMfBSk/1Yx2Pvy
         E0LDj+pR1Yx8SpWbmJIbU8obQayy0crOe0nwPDFaL8/dROh8Y0Za8tn6q0MW8LSM78fN
         /FtUJCJPzbZarIYNqQTRLSVknHi+k/WEGOm16T4r1HlYR3K/tV+gL2Y/mza5ViqxXRd+
         XtycMHmxEBxqEZUJEWhrv5HybxGNp+qTBtYZKWpJ65XPaK7pUqwp+n9WA2hTm7K+L+jd
         3cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689593833; x=1692185833;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYv4V4b0xoYvwQpX2K4ZRcvLQvhVYz6YxW8k/QuP+50=;
        b=Br5Da33Ks65UPgDHR1QQy/2xS1U2un4lStqV23E7bFzYcjXDlnrnEh3CTQoY5UgAX0
         xsxjUQBl02fb8q7H6sLgdcwX26C8pgKLVrXvKtXr2+m8H0QFs4tfTHOGmhVgKROQIM+O
         6yg6kRIFkU/hkObW50kZ+RR/0YQifO0zl+5wgK70wxlgpjQzW3DZy3ZjTRauJvprZ99C
         wHaINS9n+BAvC49sGzyT1Vumj6kKrptJyfuK0xxGBbypdDsCF9mfhjGNvu6vLWX3cDce
         /ba/VYmC8mvtFvnFQ78Ef+8wkc3eQJb93nl43hCAQGhIKGe+p1/iwbLsPiPV0x1A/UU5
         XGUA==
X-Gm-Message-State: ABy/qLb8Ku8L+2fb8ttWFd/wMe4l8gl3hsg/cjecJaW2/XmwFXEzE/c0
        91GuF+dRAfq33fiyUlKBReya6cxr3xU=
X-Google-Smtp-Source: APBJJlGN6WeR/6dVICAL1IH0cT2a/nV53PRF1S3YA6v1DdZZbTbvPkvG5vQtA5MPhla93RUvJCtIYDuQNcU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3b6e:8102:6db8:d83f])
 (user=glider job=sendgmr) by 2002:a05:6902:11c9:b0:c2c:1b68:99b0 with SMTP id
 n9-20020a05690211c900b00c2c1b6899b0mr186434ybu.5.1689593833274; Mon, 17 Jul
 2023 04:37:13 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:37:03 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717113709.328671-1-glider@google.com>
Subject: [PATCH v3 0/5] Implement MTE tag compression for swapped pages
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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

v3:
 - as suggested by Andy Shevchenko, use
   bitmap_get_value()/bitmap_set_value() written by Syed Nayyar Waris
 - switched to unsigned long to reduce typecasts
 - simplified the compression code

v2:
 - as suggested by Yuri Norov, replace the poorly implemented struct
   bitq with <linux/bitmap.h>

Alexander Potapenko (5):
  lib/bitmap: add bitmap_{set,get}_value()
  lib/test_bitmap: add tests for bitmap_{set,get}_value()
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c

 arch/arm64/Kconfig               |  20 ++
 arch/arm64/include/asm/mtecomp.h |  60 +++++
 arch/arm64/mm/Makefile           |   7 +
 arch/arm64/mm/mtecomp.c          | 406 +++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap.c          |  20 +-
 arch/arm64/mm/mteswap.h          |  12 +
 arch/arm64/mm/mteswap_comp.c     |  52 ++++
 arch/arm64/mm/mteswap_nocomp.c   |  38 +++
 arch/arm64/mm/test_mtecomp.c     | 177 ++++++++++++++
 include/linux/bitmap.h           |  57 +++++
 lib/test_bitmap.c                |  33 +++
 11 files changed, 871 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.41.0.255.g8b1d071c50-goog

