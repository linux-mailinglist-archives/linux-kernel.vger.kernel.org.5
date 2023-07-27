Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529FF765D93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjG0UrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjG0Uqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:46:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05360F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso15078435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690490791; x=1691095591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbnBGeBUXtAMeUnmfrzncXKhjFpmdZ1Ibsl5jI52YQY=;
        b=TZTSLg2srssGLFinivNe8tD/8JmAqGYtYWeVDxr09UOH0jkDx0FAa7HglO3MPM88Lu
         ucO7fyfS/+s1OWwyFraRBy4ir+dGEArgEyHbUBGYo392JKFfbFxcRbiMR2apBj+BVkbb
         hq01LmWnAotWgkoMuhLatMW4vRztuEFaRMRJmvp3TxatrOIPIOCHdywLUYqANhcgFKy4
         n/q7E+1sDDqsxXzWz604h5ypYXxP0Z+ewkSP4BuiYsfBpJCorV1Rwl0lKtOg8upaWle2
         v6AjFshQp5whq2T3fMYoePfy/j7abM3CQnCAlbwyNGI5HvgO6kK0R3UGvVL2MxaeQ8qa
         BwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490791; x=1691095591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbnBGeBUXtAMeUnmfrzncXKhjFpmdZ1Ibsl5jI52YQY=;
        b=WwMHlBF3iUbE+wwcxBD1MxzyYDNRM5knP+56STFOTUljRe/MmpTS1QUS8I1gvtAhBQ
         ax5kGU39dZtsqfi8UXdSob5Csc8ZX221fOx7Xgfew6r0257/vKJZ8JSZw8KPs2vE7fG5
         8h49KB8jWPFDRmzUGX60Nlm2jGBJDzcpYyLMyJXssFkrfdmq61opO5PaiR7g7PDH6SPE
         +FScK/2p8cMrIm3o6RPdfotvZn/zeIzIYfLBCHzxGNb4/LCxN41DM4y5zFS9VvW/LO6d
         1tw3uffgmHxNKEsAB9vfkIh2iPdm0enOqOWy1DoIKXlM5V/pYhiGqTIK+AzeGXd9jlU2
         3WlA==
X-Gm-Message-State: ABy/qLasfOH/GMrYwXte8n3tOwWF3iVoDmXUoiRwqDCDnJ0sBEbR5YMQ
        S3oL+7dQmnW4YHa5XIsBVG6wByUaoHsLt5T0qVk=
X-Google-Smtp-Source: APBJJlGPxKyzuKwKs5yC1mRbohixE0NIULYu5NjvVcdpxTFrVGqV4CkuVZHZVgSvO66XUC5FJZLgNg==
X-Received: by 2002:adf:facc:0:b0:317:63a9:d11c with SMTP id a12-20020adffacc000000b0031763a9d11cmr152870wrs.48.1690490791133;
        Thu, 27 Jul 2023 13:46:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc401000000b003fc06169abdsm2701400wmi.2.2023.07.27.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:46:30 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v1 0/6] mm/memblock: Skip prep and initialization of struct pages freed later by HVO
Date:   Thu, 27 Jul 2023 21:46:18 +0100
Message-Id: <20230727204624.1942372-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the region is for gigantic hugepages and if HVO is enabled, then those
struct pages which will be freed later by HVO don't need to be prepared and
initialized. This can save significant time when a large number of hugepages
are allocated at boot time.

For a 1G hugepage, this series avoid initialization and preparation of
262144 - 64 = 262080 struct pages per hugepage.

When tested on a 512G system (which can allocate max 500 1G hugepages), the
kexec-boot time with HVO and DEFERRED_STRUCT_PAGE_INIT enabled without this
patchseries to running init is 3.9 seconds. With this patch it is 1.2 seconds.
This represents an approximately 70% reduction in boot time and will
significantly reduce server downtime when using a large number of
gigantic pages.

Thanks,
Usama

[RFC->v1]:
- (Mike Rapoport) Change from passing hugepage_size in
memblock_alloc_try_nid_raw for skipping struct page initialization to
using MEMBLOCK_RSRV_NOINIT flag

Usama Arif (6):
  mm: hugetlb: Skip prep of tail pages when HVO is enabled
  mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
  memblock: add parameter to memblock_setclr_flag for selecting
    memblock_type
  memblock: introduce MEMBLOCK_RSRV_NOINIT flag
  mm: move allocation of gigantic hstates to the start of mm_core_init
  mm: hugetlb: Skip initialization of struct pages freed later by HVO

 include/linux/hugetlb.h  |  1 +
 include/linux/memblock.h |  7 ++++
 mm/hugetlb.c             | 71 ++++++++++++++++++++++++++++++----------
 mm/hugetlb_vmemmap.c     |  6 ++--
 mm/hugetlb_vmemmap.h     | 10 ++++++
 mm/memblock.c            | 51 +++++++++++++++++++++--------
 mm/mm_init.c             |  4 +++
 7 files changed, 117 insertions(+), 33 deletions(-)

-- 
2.25.1

