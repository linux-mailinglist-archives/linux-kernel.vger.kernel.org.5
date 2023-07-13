Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940BC751751
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjGMEU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjGMEUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:20:55 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D519BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:20:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a412653335so266082b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222053; x=1691814053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPThBi3gLHbiMnxNJA8Pqg7+B1TGtxLdGO8OQZP+rPE=;
        b=kZPDfTp8BiBR6nr8WXBNq/Q0pG0Jj/xtqusNHh+GQB/o1+8mYiboEeIDaKy4oTDCaX
         m0KbGb1TzIiljMKK5ecWb0kViWUeZV2R797gxnFo6+8imC+dLU+UECElCCtJL7vnR6y4
         jUJyurBGHJcWQ38PoVhHxoBS4hXToDnZ9xubwSOPm2NGnZqzb+9kIMJN/xNj0PaB1K5R
         HXgmxuwxbcPjmzN5eIT43t+HluklQTar/sMWaOE4MEBtNk84zA5Y14aVVhuAsmlfKwfK
         3IFEnmFQeSTP1E/7nxPsTWWv0/c0/ZA7IZJQMapCu/YPDw2sN98paPG0h2DJ2XhCLKNL
         KGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222053; x=1691814053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPThBi3gLHbiMnxNJA8Pqg7+B1TGtxLdGO8OQZP+rPE=;
        b=HoHJkxYR4B+3oWyzVrLbd1g5rb7AvKtEVZk3dXilxoA1RZB/BU5wgadrpxpmW75Idw
         6MRciiQijT2Di8bGt9ptItFuz6GNEQxeMC6sMHYSbpzOR/IlMSilczxDeQduGiEP/4bd
         fQU2TQDkn4AVY/8jM1Tk7+xQoz80Uofr7QpAbbMH5fe/5d0aiI0w3M65m0BrgwoRgXp4
         N/BM2GPjd5kHIsjGU0BsUxU9yoGW0M5WXxiZd7ilRQfxPAoha8L8zOcvpT/YDS0LqUwu
         jkUofOjgi5GbiwXyM2LWaXDpE+36ZH+6r6H/OIeMri7IrK8HxvtLf9VLjyTyyw6NYV96
         M5tA==
X-Gm-Message-State: ABy/qLZqqCQC45MLhVY+QM1mWxSRH1qE/TbkZADNe7ijaoiOhPai7EbG
        gZpS8HYJyhTxkIgDRYoSQL0=
X-Google-Smtp-Source: APBJJlEVeO6bzD9JRQ8lZ4+gjyfbYmqIa4dFDm7lRrzAYkMXt3pCuCK4fqd2c6VMnQYLZNQX3GlUCQ==
X-Received: by 2002:a05:6808:148d:b0:398:34da:daad with SMTP id e13-20020a056808148d00b0039834dadaadmr648193oiw.51.1689222053542;
        Wed, 12 Jul 2023 21:20:53 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:20:52 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
Date:   Thu, 13 Jul 2023 13:20:15 +0900
Message-ID: <20230713042037.980211-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/linux-mm/20230220132218.546369-1-42.hyeyoo@gmail.com

v1 -> v2:
 - rebased to the latest mm-unstable, resulting in some patches dropped
 - adjusted comments from Mike Rapoport, defining helpers when
   converting its users

The purpose of this series is to define own memory descriptor for zsmalloc,
instead of re-using various fields of struct page. This is a part of the
effort to reduce the size of struct page to unsigned long and enable
dynamic allocation of memory descriptors.

While [1] outlines this ultimate objective, the current use of struct page
is highly dependent on its definition, making it challenging to separately
allocate memory descriptors.

Therefore, this series introduces new descriptor for zsmalloc, called
zsdesc. It overlays struct page for now, but will eventually be allocated
independently in the future. And apart from dynamic allocation of descriptors,
this is a nice cleanup.

This work is also available at:
	https://gitlab.com/hyeyoo/linux/-/tree/separate_zsdesc_rfc-v2

[1] State Of The Page, August 2022
https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org

Hyeonggon Yoo (21):
  mm/zsmalloc: create new struct zsdesc
  mm/zsmalloc: add utility functions for zsdesc
  mm/zsmalloc: replace first_page to first_zsdesc in struct zspage
  mm/zsmalloc: add alternatives of frequently used helper functions
  mm/zsmalloc: convert {try,}lock_zspage() to use zsdesc
  mm/zsmalloc: convert __zs_{map,unmap}_object() to use zsdesc
  mm/zsmalloc: convert obj_to_location() and its users to use zsdesc
  mm/zsmalloc: convert obj_malloc() to use zsdesc
  mm/zsmalloc: convert create_page_chain() and its user to use zsdesc
  mm/zsmalloc: convert obj_allocated() and related helpers to use zsdesc
  mm/zsmalloc: convert init_zspage() to use zsdesc
  mm/zsmalloc: convert obj_to_page() and zs_free() to use zsdesc
  mm/zsmalloc: convert reset_page() to reset_zsdesc()
  mm/zsmalloc: convert zs_page_{isolate,migrate,putback} to use zsdesc
  mm/zsmalloc: convert __free_zspage() to use zsdesc
  mm/zsmalloc: convert location_to_obj() to use zsdesc
  mm/zsmalloc: convert migrate_zspage() to use zsdesc
  mm/zsmalloc: convert get_zspage() to take zsdesc
  mm/zsmalloc: convert SetZsPageMovable() to use zsdesc
  mm/zsmalloc: remove now unused helper functions
  mm/zsmalloc: convert {get,set}_first_obj_offset() to use zsdesc

 mm/zsmalloc.c | 574 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 360 insertions(+), 214 deletions(-)

-- 
2.41.0

