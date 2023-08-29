Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FE78BFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjH2IMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjH2ILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80F9E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50087d47d4dso6569673e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296704; x=1693901504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypiT9aaPKimQJTb8EA0BWrlL9wmne7HVxtb4pVgUIM8=;
        b=HvynVJlaIEJi8g772BM+SVLOetf4v/1itlq8nITpEQsMEsdeZKYVZUkuOCVFvJEYkv
         d77YpVpNYDArASqogFv/Thj9BXD4BHU5THBcwpnManZk2J7kOLp3SfOS0hx4fsyDTGMn
         OgZ2YlI8h12i6zYu9qwRG138/f59eJwoVburMpCZEYMwSmch8MXmWH0sG1M5l1/66zNj
         st+YOmpmT0YObALwu1Tl0gD4NQtvkbu+YqRlg+COCUcE+ww8DRYfPnEYr71v/LJZwVu7
         cT83/J2X5RN4g1tW6RiR35zJ2Z5QrHOjKB5pSbHaxbVXBP1QHfjRxQa39sKwAV9abLPH
         LjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296704; x=1693901504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypiT9aaPKimQJTb8EA0BWrlL9wmne7HVxtb4pVgUIM8=;
        b=KX5lHXEGtzr0B7YD9+FF96gVtPvr8OgHy+MGQOTUzuo1yyoImSQ2JIwBYQflk/lgV1
         o8z8NY/mNXi7GjzDucJ8W0cmsVGhHKgGAtIJfHcFON/B1hloEUkJ4VNKFjKjHYVDQKZz
         pFDRCZKA1pfpsfIzOgf7raNx2HGokwSgyQHdT/upX80dbMNCpZoj+SYGKruHOZgKJUJq
         fQtSJ7og4fMu7M64yvmTDdtVcZG22qR7o1NyhtSN8UsmEvhvkFtmaMTNN23/fHkrQVXW
         WbX7mdv7MMiYE232peToDj7gzZEyOm0naT2buxITKhR/cap+odOfrzlgc3y1KfsQmR8Y
         xvHQ==
X-Gm-Message-State: AOJu0YxeuzFODg1OXemzY6g4HtVXY41Fi5h0dHEYG0/RsTHwQggJydeE
        ehs38zK1OF1sMSXU/57f+8k=
X-Google-Smtp-Source: AGHT+IHqzbyj6s/BxrQ5oaFFpJBDX6ZRBgP+tCh/LHuBIb/Nh93Z2Cj0Jn1Swx19I1gj4HbSrdGRXQ==
X-Received: by 2002:a05:6512:2524:b0:4f8:766f:8dc3 with SMTP id be36-20020a056512252400b004f8766f8dc3mr20893792lfb.32.1693296703823;
        Tue, 29 Aug 2023 01:11:43 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:43 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Date:   Tue, 29 Aug 2023 10:11:33 +0200
Message-Id: <20230829081142.3619-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, folk!

This is the v2, the series which tends to minimize the vmap
lock contention. It is based on the tag: v6.5-rc6. Here you
can find a documentation about it:

wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf

even though it is a bit outdated(it follows v1), it still gives a
good overview on the problem and how it can be solved. On demand
and by request i can update it.

The v1 is here: https://lore.kernel.org/linux-mm/ZIAqojPKjChJTssg@pc636/T/

Delta v1 -> v2:
  - open coded locking;
  - switch to array of nodes instead of per-cpu definition;
  - density is 2 cores per one node(not equal to number of CPUs);
  - VAs first go back(free path) to an owner node and later to
    a global heap if a block is fully freed, nid is saved in va->flags;
  - add helpers to drain lazily-freed areas faster, if high pressure;
  - picked al Reviewed-by.

Test on AMD Ryzen Threadripper 3970X 32-Core Processor:
sudo ./test_vmalloc.sh run_test_mask=127 nr_threads=64

<v6.5-rc6 perf>
  94.17%     0.90%  [kernel]    [k] _raw_spin_lock
  93.27%    93.05%  [kernel]    [k] native_queued_spin_lock_slowpath
  74.69%     0.25%  [kernel]    [k] __vmalloc_node_range
  72.64%     0.01%  [kernel]    [k] __get_vm_area_node
  72.04%     0.89%  [kernel]    [k] alloc_vmap_area
  42.17%     0.00%  [kernel]    [k] vmalloc
  32.53%     0.00%  [kernel]    [k] __vmalloc_node
  24.91%     0.25%  [kernel]    [k] vfree
  24.32%     0.01%  [kernel]    [k] remove_vm_area
  22.63%     0.21%  [kernel]    [k] find_unlink_vmap_area
  15.51%     0.00%  [unknown]   [k] 0xffffffffc09a74ac
  14.35%     0.00%  [kernel]    [k] ret_from_fork_asm
  14.35%     0.00%  [kernel]    [k] ret_from_fork
  14.35%     0.00%  [kernel]    [k] kthread
<v6.5-rc6 perf>
   vs
<v6.5-rc6+v2 perf>
  74.32%     2.42%  [kernel]    [k] __vmalloc_node_range
  69.58%     0.01%  [kernel]    [k] vmalloc
  54.21%     1.17%  [kernel]    [k] __alloc_pages_bulk
  48.13%    47.91%  [kernel]    [k] clear_page_orig
  43.60%     0.01%  [unknown]   [k] 0xffffffffc082f16f
  32.06%     0.00%  [kernel]    [k] ret_from_fork_asm
  32.06%     0.00%  [kernel]    [k] ret_from_fork
  32.06%     0.00%  [kernel]    [k] kthread
  31.30%     0.00%  [unknown]   [k] 0xffffffffc082f889
  22.98%     4.16%  [kernel]    [k] vfree
  14.36%     0.28%  [kernel]    [k] __get_vm_area_node
  13.43%     3.35%  [kernel]    [k] alloc_vmap_area
  10.86%     0.04%  [kernel]    [k] remove_vm_area
   8.89%     2.75%  [kernel]    [k] _raw_spin_lock
   7.19%     0.00%  [unknown]   [k] 0xffffffffc082fba3
   6.65%     1.37%  [kernel]    [k] free_unref_page
   6.13%     6.11%  [kernel]    [k] native_queued_spin_lock_slowpath
<v6.5-rc6+v2 perf>

On smaller systems, for example, 8xCPU Hikey960 board the
contention is not that high and is approximately ~16 percent.

Uladzislau Rezki (Sony) (9):
  mm: vmalloc: Add va_alloc() helper
  mm: vmalloc: Rename adjust_va_to_fit_type() function
  mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
  mm: vmalloc: Remove global vmap_area_root rb-tree
  mm: vmalloc: Remove global purge_vmap_area_root rb-tree
  mm: vmalloc: Offload free_vmap_area_lock lock
  mm: vmalloc: Support multiple nodes in vread_iter
  mm: vmalloc: Support multiple nodes in vmallocinfo
  mm: vmalloc: Set nr_nodes/node_size based on CPU-cores

 mm/vmalloc.c | 929 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 683 insertions(+), 246 deletions(-)

-- 
2.30.2

