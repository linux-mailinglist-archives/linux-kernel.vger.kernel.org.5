Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD68479E559
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbjIMKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbjIMKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:54:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A11726
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401b0d97850so73372385e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694602446; x=1695207246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/jwYmO43zAy8dw1dylGWTby1uHmPD0/fuY9NXytdPo=;
        b=EZj4eZpyt32CoVVx3aqQv6P51sXMWUhB/A0PyPBHPjihAob8A8wJJQPigSYGWHSHyJ
         604uHzflF1OtVDLZoRPzqHKCqmNtlMB3jKoOOK40ITBkQupgUGiY9mG9QSqCnOI5760p
         nRJVmPqyNoTmZK+vWbPOK0Z41W+NUwxqtMgfX5RyqQ1F7s1M4NMgUIGqEI4yVZDTmI51
         Cpv6cIvoy9pPx9OAW1hPsxOztxbvtTXXfMm9LUjY4Z9hFgvoyR/Pj0HT+Go+zj3aT/aG
         q02VIsWbCh5e1+Il1dMk0uDOQolPUQMhlmMBmIIPBKwH2/U5BRGf19FMf6d+GAZt6u3V
         Pafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602446; x=1695207246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/jwYmO43zAy8dw1dylGWTby1uHmPD0/fuY9NXytdPo=;
        b=t1tInF/4bfEGNi2JSAxW9EdTho9d5Y5ovr60bPyA2svPodd5Tiz8wYVAx1lEc07hxI
         KUaO2hvkU/p8oKFMf7rbRpWgjwpPB+O8qlhPLLfC4KinQUToAH6/O5O96OrykT+BA0e4
         nas6CjRyAb1zqIyZyO5WC6PXWtNVzLfAd4IoP0eW9tAMYJqUtXDzMCiAeWfV4dghOwLb
         NZVYRX/WRf3PkLLpxjNM4McpXZvcfTEWFxCuZMyyGlH78TbF5AGyWg/8AGQbhfCFe/s+
         oQrTfW/uQdpJ3/bUJn70uQlC3X9Ma1lETu8SVYY5nES8r/fh8QBWAnvH7DjHXBwrR1xu
         z4Uw==
X-Gm-Message-State: AOJu0YxJGHhtw5sIosPhvV/eQt3ArROyCEiZsphASGTEaHNa4cwn6q0B
        ERuCt/7xZXdUWvwwRl9XdmehDQ==
X-Google-Smtp-Source: AGHT+IG3TgIhnp1ot645v42otah+o1cULY/OJnOLImpb0/Lvb/J5aq/M+qX9WvdUTwm15PjcuRioHA==
X-Received: by 2002:a05:600c:2144:b0:3fe:5501:d284 with SMTP id v4-20020a05600c214400b003fe5501d284mr1760853wml.11.1694602445408;
        Wed, 13 Sep 2023 03:54:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:59d5:28b9:7f13:cd1b])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b003ff013a4fd9sm1757055wms.7.2023.09.13.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:54:04 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v5 0/4] mm: hugetlb: Skip initialization of gigantic tail struct pages if freed by HVO
Date:   Wed, 13 Sep 2023 11:53:57 +0100
Message-Id: <20230913105401.519709-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the boot time initialization of tail struct pages of a
gigantic page to later on in the boot. Only the
HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
are initialized at the start. If HVO is successful, then no more tail struct
pages need to be initialized. For a 1G hugepage, this series avoid
initialization of 262144 - 63 = 262081 struct pages per hugepage.

When tested on a 512G system (allocating 500 1G hugepages), the
kexec-boot times with DEFERRED_STRUCT_PAGE_INIT enabled are:

- with patches, HVO enabled: 1.32 seconds
- with patches, HVO disabled: 2.15 seconds
- without patches, HVO enabled: 3.90  seconds
- without patches, HVO disabled: 3.58 seconds

This represents an approximately 70% reduction in boot time and will
significantly reduce server downtime when using a large number of
gigantic pages.

This series is based on top of the patch
"hugetlb: set hugetlb page flag before optimizing vmemmap"

Thanks,
Usama

[v4->v5]:
- (Mike Kravetz) For tail struct pages, change from using set_page_count to
page_ref_freeze + VM_BUG_ON if ref_count != 1.

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
 mm/hugetlb.c             | 63 ++++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.c     |  4 +--
 mm/hugetlb_vmemmap.h     |  9 +++---
 mm/internal.h            |  3 ++
 mm/memblock.c            | 48 +++++++++++++++++++++---------
 mm/mm_init.c             |  2 +-
 7 files changed, 109 insertions(+), 29 deletions(-)

-- 
2.25.1

