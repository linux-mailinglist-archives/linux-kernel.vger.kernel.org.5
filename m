Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1DE7AD325
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjIYISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjIYISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:18:15 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE122CC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:18:08 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59f7cc71e2eso14934157b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695629888; x=1696234688; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NBmOlGTl5TRsP+Q0MLYqRc364ZkZEmNojcMBhSc9Luo=;
        b=QFEIUnzat192jRh6l59PXjdvzxEXJ+aHHsmItlIwRQcJbcq5UCgpPAGhmHem6nAw3j
         cgIP6DgyMDCPnfj5/L5lSq3oUfAMCJNWWfqP2cF4zIjV1/8t5uS5oh8y8MBZSJu/FWdc
         3Ny4LPMcP2QexmYStjkAwZu7pcy8SzFS7eRKTepY5aEdZc6pXQEuuhMAw7+KW/OcA4x1
         2obuvpSYlR2f10yl6T6w/Sk0/ureI62NSaYna/v4hIget70+28xdEX9wGsbaoiVY4Igt
         ieo3e1Jpm81VEghoetHXzjYDGAwhwUAYjY2GNCZbP1YDAxfsKr2SpKIrjvxvKjQdfQrZ
         LQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695629888; x=1696234688;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBmOlGTl5TRsP+Q0MLYqRc364ZkZEmNojcMBhSc9Luo=;
        b=roZEnP8Lw8JOHFm25hgKxOEmAMjC+DAajoL5Clg6qLoYmsQ3ty6Upz8DrBPcguYMx/
         8TzJbUJuBY/titysKgUMkZe6C1EJ0vQaR/ZW0FcziMEPktOX0xtAKeWr21jxmgadkUh2
         tDPVrdOltCNCXsxkUMAK2yrlcfKDGH1xVSgtzs/FGm3Vioekb1Zr47JHBh8/n2AIcvB0
         +PtjPWv3Nal9vhko8o5opxr4TzcMIcMZrxJCUkiZf/oBrm4qRFZ9Kbe1QlAITYsixk2T
         gxl+tIcFZJ1OvW3RLfj7y5fsvmVPnLhQVbyBz1clOT2PXiEhaI6BlY6J7Hap486rfBrg
         tX2Q==
X-Gm-Message-State: AOJu0Yz38QLenlI0HFLR4z2oAet0LbuEfCN1+93YBa+1zSHSigvtglKI
        qTy+R9+X4WDyQT5SjUpnj9BL+w==
X-Google-Smtp-Source: AGHT+IHk64F5xQuSLEF9sz4jxS2L97eNKDzUKnZl1CJ4U3doCZv5KJbiwxw4GXizbkI9eoylPyi6+A==
X-Received: by 2002:a81:4e42:0:b0:59b:14ca:4316 with SMTP id c63-20020a814e42000000b0059b14ca4316mr5843751ywb.43.1695629887900;
        Mon, 25 Sep 2023 01:18:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x187-20020a81a0c4000000b0058c55d40765sm2267762ywg.106.2023.09.25.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:18:06 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:17:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 00/12] mempolicy: cleanups leading to NUMA mpol without vma
Message-ID: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches based on v6.6-rc3: mostly cleanups in
mm/mempolicy.c, but finally removing the pseudo-vma from shmem folio
allocation, and removing the mmap_lock around folio migration for
mbind and migrate_pages syscalls.

Applies cleanly to any v6.6-rc so far, but not quite to mm-unstable or
linux-next: a couple of rejects in mm/mempolicy.c (clashing with the
vma_start_write() in do_mbind() and the foliation in mpol_misplaced())
and in mm/swap_state.c (clashing with zswap mods).  Adjustments will
also be needed if hugetlb page->index changes to PAGE_SIZE: interleave
has to co-operate with that.  After some review, a v2 will probably be
issued, based then on mm-unstable.

01/12 hugetlbfs: drop shared NUMA mempolicy pretence
02/12 kernfs: drop shared NUMA mempolicy hooks
03/12 mempolicy: fix migrate_pages(2) syscall return
04/12 mempolicy trivia: delete those ancient pr_debug()s
05/12 mempolicy trivia: slightly more consistent naming
06/12 mempolicy trivia: use pgoff_t in shared mempolicy tree
07/12 mempolicy: mpol_shared_policy_init() without pseudo-vma
08/12 mempolicy: remove confusing MPOL_MF_LAZY dead code
09/12 mm: add page_rmappable_folio() wrapper
10/12 mempolicy: alloc_pages_mpol() for NUMA policy without vma
11/12 mempolicy: mmap_lock is not needed while migrating folios
12/12 mempolicy: migration attempt to match interleave nodes

 fs/hugetlbfs/inode.c           |  41 +-
 fs/kernfs/file.c               |  49 --
 fs/proc/task_mmu.c             |   5 +-
 include/linux/gfp.h            |  10 +-
 include/linux/huge_mm.h        |  13 +
 include/linux/hugetlb.h        |  11 -
 include/linux/mempolicy.h      |  36 +-
 include/linux/mm.h             |   2 +-
 include/uapi/linux/mempolicy.h |   2 +-
 ipc/shm.c                      |  21 +-
 mm/hugetlb.c                   |  38 +-
 mm/mempolicy.c                 | 952 ++++++++++++++++-------------------
 mm/page_alloc.c                |   8 +-
 mm/shmem.c                     | 102 ++--
 mm/swap.h                      |   9 +-
 mm/swap_state.c                |  86 ++--
 16 files changed, 617 insertions(+), 768 deletions(-)

Hugh
