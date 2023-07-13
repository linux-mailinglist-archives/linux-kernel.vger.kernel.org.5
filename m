Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64A7521FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjGMM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGMM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F9173B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5cea5773e8so617775276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689253033; x=1691845033;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZVmzvDv/wEkBzFvNB2jvCzxG6CGiDCDClwpWrFVZEg=;
        b=kHOs3OGWZRHY462sr8GlRAigBTUHckxrZT7XE5e/UoXWp7cDnu9efMT0TzUL/VotGY
         ZF0GWh8CHu2/IPXoacr1ELwvnzvC9MV1hj4U8a5z+FmJbN5mquh6n1mJQ/DBZaQgXbcn
         xohjUkIWb1JWqX5Ughb7iMDtvlAoCO258U4VZ5+2CV0aBk/XPEXpnvnBJAPsrImJbyjL
         mMFB7Vyb6UJH3OrkhtLXFgQbzWAzh4hz9VTmASffooNg5ujWFws10w6rjpOrrTU9x88P
         myl+PwL2m9+mStlnWqlX5cAMfakhfshQRZY1lEfZCp9r7GTUbUjlQq5TlTn83Nk9J5DE
         kGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253033; x=1691845033;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZVmzvDv/wEkBzFvNB2jvCzxG6CGiDCDClwpWrFVZEg=;
        b=OQ+pFaLLxW5p7DVl42HTnltkAhGzM3RUarCxksHF5kWkEoQb/dnQKDuDpCAve18MMd
         oti9m7i9kDa+StNJMbCP2JHMpf7Qhghdipw3+6Nr25YytxbOhBDhRU+PO4XZmSI/G7Qs
         gh0h0+Rcxhv7jJ9QrjvAbezpfAOKn6gZ6+MeI0Eq81jiNfouf4AW15ryWrb7u+4pYwKp
         03CeV+xBhpjO1GW9DoiR5enVE7gxJcEsq9mAz5Rx64QhqOv9jJA5R3ZwiDAQ0gkYgAVH
         ZTWE1JIWR9NdQCJm/J9JUxltpBnwHrW3n0FgLtizJYAaeS1RIa2MsEEre83b1WmSD858
         BHOA==
X-Gm-Message-State: ABy/qLYynSslNOeUqde34PfD5tTw9ZJLsR6tKmOHqEtdNhBQyHQmwFpM
        lypEZA/ysxWC2iG71lZbgwSXwyk/shk=
X-Google-Smtp-Source: APBJJlGE9Zj3+QlLEq9LQgNjQ5luQsqHW9scwXLl6f++pWPyI1Gv/NRvW0Mstq+Kix2p3qhM7BDofpUZpB4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7a88:66b7:31e5:7d85])
 (user=glider job=sendgmr) by 2002:a25:cacf:0:b0:c72:2386:7d26 with SMTP id
 a198-20020a25cacf000000b00c7223867d26mr7702ybg.0.1689253032952; Thu, 13 Jul
 2023 05:57:12 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:57:00 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713125706.2884502-1-glider@google.com>
Subject: [v2 0/5] Implement MTE tag compression for swapped pages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
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

v2:
 - as suggested by Yuri Norov, replace the poorly implemented struct
   bitq with <linux/bitmap.h>

Alexander Potapenko (5):
  lib/bitmap: add bitmap_{set,get}_value_unaligned()
  lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c

 arch/arm64/Kconfig               |  20 ++
 arch/arm64/include/asm/mtecomp.h |  60 +++++
 arch/arm64/mm/Makefile           |   7 +
 arch/arm64/mm/mtecomp.c          | 412 +++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap.c          |  19 +-
 arch/arm64/mm/mteswap.h          |  12 +
 arch/arm64/mm/mteswap_comp.c     |  50 ++++
 arch/arm64/mm/mteswap_nocomp.c   |  37 +++
 arch/arm64/mm/test_mtecomp.c     | 175 +++++++++++++
 include/linux/bitmap.h           |  63 +++++
 lib/test_bitmap.c                |  34 +++
 11 files changed, 878 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.41.0.255.g8b1d071c50-goog

