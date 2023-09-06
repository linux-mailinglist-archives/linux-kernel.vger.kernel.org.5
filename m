Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EC793B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbjIFL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjIFL2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:28:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80D1998
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:26:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401b393df02so35254575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693999573; x=1694604373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSQpDONv/OZHUkjn9Ge1fW9m2KPxZyl+hgiPVQzyIw4=;
        b=LaHKFTyON4tJvprNa4CX8CHgxCYMuNGGaatNjlqk2Y69pBAa9QK9DPFm1oDUkA5cOY
         St2kR745SU14T+a/wV9Ey2+gfY1NbhVV/6E8wzdMzCHEiJ9I6AWwB0i3pSYcHiFYEL6P
         Rw7nZgDcANZjUZPbbIITNtmDhpY0bFRscYXWXgjuvYKXp0YnydxmxOAUee/lhumD23kd
         rMBVGtlMdLiaqvfbznQq0FFW0YiSoZ+Z2jzs6lVXeT14REKv70OsxHIshsTbstqeKZEC
         1+LLkzgm6p2cVA7WAqjB9iTF+KpMms3QJvK/3VHPn9GvoPxtnc1Kw32VPADEkM4uMq45
         ftWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999573; x=1694604373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSQpDONv/OZHUkjn9Ge1fW9m2KPxZyl+hgiPVQzyIw4=;
        b=kroAEY3apvgJtIdq0hFSzP4vgRa89Ye5J4Ho/0fWKUZGgfUMaSTpCeIfjtv8FNJ+ob
         v+irVLlC8Zm+4vh2KCBqtPcqgugbL1R+gfVOX1lwmY2DUgDB6QWTicwENueXapcPlYGa
         ssfDM9YjJb00cCq0E2y+zqJjvRzeZBxqVmpDCvbKRZCD7x7bU9y0sWaAFzkXKO74xurC
         n8w0AME2BCInMVmiyQeVnvXWoJ7WUgOVkEstMEOm05EKQyQjcRY1Q3CCJrf4BgXCr+lF
         PU9g/PQi66qf23EOz7ALN9b7Xb1q9BgCC+AiQTU9r3F/11DRRZO/RDzQsI0fozRRK0/B
         +hoQ==
X-Gm-Message-State: AOJu0Yw3kU6SN+VoejL+t8rCpvrAtSEwXpmfEBliFzbTWO+c3+hWsU/R
        L2k4pmowpiJ2+Ngpd4o3Gi6nWj9o0szl8A3h6dI=
X-Google-Smtp-Source: AGHT+IHmK/c6SqzH+hydtTNXTTg8Wlugag5Vv0VewURFx+im28phCmq40JCuwfBwAphdZILfVzaHIg==
X-Received: by 2002:a1c:6a16:0:b0:401:c8b9:4b8a with SMTP id f22-20020a1c6a16000000b00401c8b94b8amr2092803wmc.29.1693999573276;
        Wed, 06 Sep 2023 04:26:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:6dce:31d8:efb1:5d81])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003feff926fc5sm19517038wmd.17.2023.09.06.04.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:26:12 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v4 0/4] mm: hugetlb: Skip initialization of gigantic tail struct pages if freed by HVO
Date:   Wed,  6 Sep 2023 12:26:01 +0100
Message-Id: <20230906112605.2286994-1-usama.arif@bytedance.com>
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
gigantic page to later on in the boot. Only the
HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
are initialized at the start. If HVO is successful, then no more tail struct
pages need to be initialized. For a 1G hugepage, this series avoid
initialization of 262144 - 63 = 262081 struct pages per hugepage.

When tested on a 512G system (which can allocate max 500 1G hugepages), the
kexec-boot time with HVO and DEFERRED_STRUCT_PAGE_INIT enabled without this
patchseries to running init is 3.9 seconds. With this patch it is 1.2 seconds.
This represents an approximately 70% reduction in boot time and will
significantly reduce server downtime when using a large number of
gigantic pages.

Thanks,
Usama

[v3->v4]:
- rebase ontop of patch "hugetlb: set hugetlb page flag before optimizing vmemmap".
- freeze head struct page ref count.
- Change order of operations to initialize head struct page -> initialize
the necessary tail struct pages -> attempt HVO -> initialize the rest of the
tail struct pages if HVO fails.
- (Mike Rapoport and Muchun Song) remove "_vmemmap" suffix from memblock reserve
noinit flags anf functions.

[v2->v3]:
- (Muchun Song) skip prep of struct pages backing gigantic hugepages
at boot time only.
- (Muchun Song) move initialization of tail struct pages to after
HVO is attempted.

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
  memblock: introduce MEMBLOCK_RSRV_NOINIT flag
  mm: hugetlb: Skip initialization of gigantic tail struct pages if
    freed by HVO

 include/linux/memblock.h |  9 ++++++
 mm/hugetlb.c             | 61 ++++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.c     |  4 +--
 mm/hugetlb_vmemmap.h     |  9 +++---
 mm/internal.h            |  3 ++
 mm/memblock.c            | 48 ++++++++++++++++++++++---------
 mm/mm_init.c             |  2 +-
 7 files changed, 107 insertions(+), 29 deletions(-)

-- 
2.25.1

