Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD075F8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjGXNuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGXNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:49:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50C81BD4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so33483545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690206407; x=1690811207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7WubRds7jbJgkABDaAVUdckubvdEH0her0SUPsLcCQ=;
        b=dkYXlVu6q4UXC1OOZTn+s9EHl4DQIRFghcEm3PtTNXR7R7GxhNE5qRwO2R6JV+9aHU
         Rg+4kpM9w7Nc0l3IHmIWyyw9lVON9WE2tDfO9rM9vZOzXsJvEF9uJ8+EKW/JLqtMa3s/
         moYx0FJ63BA2p52KAv5X67j04zVoOQ+RHrPbulnRNUIa/ettBTa8ixpqwliJqpCJHxLU
         4BeRa5neK3F4JMafNap4hsVRhP6bQRPBhngyWwsbUQXTdf8ox0YY5NtemI2bKbXFvW1v
         AGKZxuchTpfjKxZA02S5JPPhCVjfaEPrQrl+SURDMpYKPPd1Pt8za0jSq7Vvh6ggeO5D
         WL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206407; x=1690811207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7WubRds7jbJgkABDaAVUdckubvdEH0her0SUPsLcCQ=;
        b=XnPzdMB/2zj33irS+ZG8Y0/Etp7wz6LsrjpR3TLqMuQXrwQemVOAEIOswLefwpcj2C
         e6YFe3fFoosNRIipiIeUGtYmHSULVSTTLCI6f8u/wpqnU2IV0dTuqAatqpPj1h2X2M3R
         AxMyTVEoUnAyQoHZe3zjlqNSwwsN+N6bjW2mYBmOihWloVLPbFlMF1TjTacMLxq0ujPi
         uucNByVBLaxN+p04XENkSaETwZfJO78X16QqPgoXXNtLxW7vyDKI1ICpfnylz5Gmf31y
         jv6zQUUPvM6hNGZ6eloWLZJ4/4OjSEo6Uu9iuDDuPCv3Ha8QXJrG79CeDcyjO7mIArMT
         01lg==
X-Gm-Message-State: ABy/qLbfpNmVCleSZSxHEqltq2mjW8e/A6l0jX6d7MOfzH9Z+kk88on8
        3E9exOwz9QCHMdNOdhC9UbKUqQ==
X-Google-Smtp-Source: APBJJlE5M4jqNLdKVr+3iEYsqXcArR84aVgz3V+mrWWyTgSXnQO7ZHsYYjyxSBvWiT7bVaWRb3Lyxw==
X-Received: by 2002:a05:600c:11c9:b0:3fc:4e0:be97 with SMTP id b9-20020a05600c11c900b003fc04e0be97mr5772449wmi.6.1690206407724;
        Mon, 24 Jul 2023 06:46:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:d7c4:7f46:8fed:f874])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbe791a0e8sm10209354wme.0.2023.07.24.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:46:47 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [RFC 0/4] mm/memblock: Skip prep and initialization of struct pages freed later by HVO
Date:   Mon, 24 Jul 2023 14:46:40 +0100
Message-Id: <20230724134644.1299963-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Usama Arif (4):
  mm/hugetlb: Skip prep of tail pages when HVO is enabled
  mm/memblock: Add hugepage_size member to struct memblock_region
  mm/hugetlb_vmemmap: Use nid of the head page to reallocate it
  mm/memblock: Skip initialization of struct pages freed later by HVO

 arch/arm64/mm/kasan_init.c                   |  2 +-
 arch/powerpc/platforms/pasemi/iommu.c        |  2 +-
 arch/powerpc/platforms/pseries/setup.c       |  4 +-
 arch/powerpc/sysdev/dart_iommu.c             |  2 +-
 include/linux/memblock.h                     |  8 +-
 mm/cma.c                                     |  4 +-
 mm/hugetlb.c                                 | 36 +++++---
 mm/hugetlb_vmemmap.c                         |  6 +-
 mm/hugetlb_vmemmap.h                         |  4 +
 mm/memblock.c                                | 87 +++++++++++++-------
 mm/mm_init.c                                 |  2 +-
 mm/sparse-vmemmap.c                          |  2 +-
 tools/testing/memblock/tests/alloc_nid_api.c |  2 +-
 13 files changed, 106 insertions(+), 55 deletions(-)

-- 
2.25.1

