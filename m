Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6261A78857F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbjHYLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjHYLSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:18:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE349CD1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31aeef88a55so618251f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692962328; x=1693567128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udAIvwx6neT1efGb/oM3DTSLzJIa/JJt0wDiTHZ/T+g=;
        b=Xjcfvt+pNpSD5aqiZlmN3nzUFcFvOxgryKI4rPyfk4iPzOPmROvK2JzTCa+4qq9thA
         iEqhHND7JXyd/QPB7n6Bf321bxRlgapCiJ/s/A68K6t6Ig+G5BYOgBTPEk/Hh783eUrF
         fHJgcdstjelwiZ55EM22t2pK7QiX9OsI01X6lyHHpgj3mN1qGBnZ84UsPAMeL7xSOod1
         B6nI39otAs49zFtnRPBKTUtLArezZD2Q4YYiMAzcgkAWO6rnEi40gLXN/P00lpts6XhA
         D2QmjzN3pniBCtOt23pHbzxhsWOz5eesOKx/nMzgI9u0wYuss8iZxpOBkasS0p3mMKmP
         qfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962328; x=1693567128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udAIvwx6neT1efGb/oM3DTSLzJIa/JJt0wDiTHZ/T+g=;
        b=A7GZmtuJ5914C3rxclOH5wfxIWnEMDAcNsdT0CB0+yaX73ng2Xd/B8zzHnPwX6ykPq
         7EdD5C26zPxUE+e2dyhzqhO0q/AZe+lEbw6rRhu6AE3thxASvQme96hSIdm0XOOapcwj
         fGRPcNxGOi4FmQopvF77fID+wOtFRGUhTRaIL5BQGB99Zd5ikKEVyYs9vinBd3getsKg
         Ikgp5721DknFkV0vvY5+SE/qO4VjXMuAZKv7+xCboQ9NE6AjReuDEf9oj2VAyYbyqhrs
         MZbvGWgLWOyfFKXsMcFz7/UcoZLhGqqtEocrC9ZOmdfo6NTxJRia4O4CqjV2mBubDwZL
         Z+WQ==
X-Gm-Message-State: AOJu0YwLWLWIoUmILSZxPt6ByBdYbGjGrl6E39EZ5xroCTfOP9jt47Wu
        64Vy00kNDBD4n8qmtgjplQ8HdQ==
X-Google-Smtp-Source: AGHT+IFbzBQK2y0ZFfjnyaMV0QpwjJwtZGusGMD0WFsVP9UJ1VpMAySZOL7UT6fA9D9lUh9r1W6yTA==
X-Received: by 2002:adf:de03:0:b0:313:f1c8:a968 with SMTP id b3-20020adfde03000000b00313f1c8a968mr15529115wrm.2.1692962328191;
        Fri, 25 Aug 2023 04:18:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:9000:8d13:d0bb:ba7d])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm1939502wrx.58.2023.08.25.04.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:18:47 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v3 0/4] mm: hugetlb: Skip initialization of gigantic tail struct pages if freed by HVO
Date:   Fri, 25 Aug 2023 12:18:32 +0100
Message-Id: <20230825111836.1715308-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the boot time initialization of tail struct pages of a
gigantic page to after HVO is attempted. If HVO is successful, only
HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) struct pages need to
be initialized. For a 1G hugepage, this series avoid initialization of
262144 - 63 = 262081 struct pages per hugepage.

When tested on a 512G system (which can allocate max 500 1G hugepages), the
kexec-boot time with HVO and DEFERRED_STRUCT_PAGE_INIT enabled without this
patchseries to running init is 3.9 seconds. With this patch it is 1.2 seconds.
This represents an approximately 70% reduction in boot time and will
significantly reduce server downtime when using a large number of
gigantic pages.

Thanks,
Usama

[v2->v3]:
- (Muchun Song) skip prep of struct pages backing gigantic hugepages
at boot time only.
- (Muchun Song) move initialization of tail struct pages to after
HVO is attempted. This also means that the hugetlb command line parsing
does not need to be changed.

[v1->v2]:
- (Mike Rapoport) Code quality improvements (function names, arguments,
comments).

[RFC->v1]:
- (Mike Rapoport) Change from passing hugepage_size in
memblock_alloc_try_nid_raw for skipping struct page initialization to
using MEMBLOCK_RSRV_NOINIT flag

Usama Arif (4):
  mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
  memblock: pass memblock_type to memblock_setclr_flag
  memblock: introduce MEMBLOCK_RSRV_NOINIT_VMEMMAP flag
  mm: hugetlb: Skip initialization of gigantic tail struct pages if
    freed by HVO

 include/linux/memblock.h | 10 ++++++++
 mm/hugetlb.c             | 52 ++++++++++++++++++++++++++++++++--------
 mm/hugetlb_vmemmap.c     |  2 +-
 mm/hugetlb_vmemmap.h     |  8 +++----
 mm/internal.h            |  3 +++
 mm/memblock.c            | 47 ++++++++++++++++++++++++++----------
 mm/mm_init.c             |  2 +-
 7 files changed, 95 insertions(+), 29 deletions(-)

-- 
2.25.1

