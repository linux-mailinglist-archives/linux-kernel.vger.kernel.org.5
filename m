Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71FE7E9A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjKMKwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKMKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:52:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B210CC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:52:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afe220cadeso64797437b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699872757; x=1700477557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZBgUsc1a+sMxZldszdOQr8LgJQCZkrcquIQgM/3+8M=;
        b=PLigGecIwx3SJjZmxuhEQ+bslIsr7bkmKspF1iIpHF8onVlmstn3JC+2BhS4XO28ZR
         ld/qth1Rfh674ILvMBlsLPB7uQgQqPSC5g8oo2hJ3qQMAN/zS1zhlZT0jzz3CcyVIIIN
         mXjNnt9DFxTiB48zsmhiMV2zRLF20LUnHtaiw2xmr47/17wLa5pCPYvsF3FCK0IksuH7
         7XOBsGufa7+heORlHfqsQyzd9+wwwUx26Jy9wjsoG5U7jEaw+CelezsPQQJjq0bgsh2x
         6d6QlqzbQhtpCRj0/G/okDTOdpsKMcOnCdyWRajxFDZs2I/BbbUik1d7pHiFf/oHNNpc
         eiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699872757; x=1700477557;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZBgUsc1a+sMxZldszdOQr8LgJQCZkrcquIQgM/3+8M=;
        b=dnioSrE4vG4ppDLureNXtattoOCpBzMEn2Khm1xbFA5YdQCGF2UENvbAuOJeVSsclV
         B1pC5T1kth4kRwG599ViVyjIyeJNFhfQdZRThcMiGQNvPiZUF/c7DYC9y9sE7dRuJPwm
         pip4wIYLiIvSArbdU+hnSWKy5b+jFRxexSt4z7rncHnR5l3pLuhqRpoNYacXfr7pish1
         iKh5517sGGTyBDQ6DItgez6DBDdTqiIGMhQNgKnXInOaYQks/laSpVsVB1w3TwMeude0
         sGJgAjyW2OZ31LkczpUuYACAK1s2wilnlmcF0pschqG18ZDDBcfvWx9MAb+LkrBE7Z+t
         LtTg==
X-Gm-Message-State: AOJu0YwGjd0bDfDDlRAmRqKjWgoVDNKTYZPqq2+AmhGvcHT9mjd2LtAa
        75c/J7zDeppUJ3Plg7COx70vbnvKYcM=
X-Google-Smtp-Source: AGHT+IE20znD6l8HryjriPKI7AolFBe57xU87rIu+7TmlBv/4QWBhnVcZNpqXBgU2sbOeqiMqFJn44NnC4Y=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:be07:845d:4221:b15e])
 (user=glider job=sendgmr) by 2002:a81:430b:0:b0:5a7:be10:461d with SMTP id
 q11-20020a81430b000000b005a7be10461dmr132113ywa.2.1699872757205; Mon, 13 Nov
 2023 02:52:37 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:52:29 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113105234.32058-1-glider@google.com>
Subject: [PATCH v9 0/4] Implement MTE tag compression for swapped pages
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
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
resulting in practical compression ratio of 2x. In many cases it is
possible to store the compressed data in 63-bit Xarray values, resulting
in no extra memory allocations.

This patch series depends on "lib/bitmap: add bitmap_{read,write}()"
(https://lore.kernel.org/linux-arm-kernel/20231030153210.139512-1-glider@google.com/T/)
that is mailed separately.

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


Alexander Potapenko (4):
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c
  arm64: mte: implement CONFIG_ARM64_MTE_SWAP_STATS

 Documentation/arch/arm64/index.rst            |   1 +
 .../arch/arm64/mte-tag-compression.rst        | 166 ++++++++
 arch/arm64/Kconfig                            |  37 ++
 arch/arm64/include/asm/mtecomp.h              |  39 ++
 arch/arm64/mm/Makefile                        |   2 +
 arch/arm64/mm/mtecomp.c                       | 257 +++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 arch/arm64/mm/mteswap.c                       | 110 +++++-
 arch/arm64/mm/test_mtecomp.c                  | 364 ++++++++++++++++++
 9 files changed, 985 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mtecomp.h
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.42.0.869.gea05f2083d-goog

