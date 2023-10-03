Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132E97B651B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbjJCJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbjJCJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:12:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E748A10D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:12:25 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d81afd5273eso699219276.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324345; x=1696929145; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vwdKPsSZX5lF9BZ1cbD7q6c/KB8Lk1EC3PAauvodoEY=;
        b=LOufoRZcPrXDsGdwQo1HsndzLcdo7VhBUWm2XT3uvQiomIVfYe3dkfZZMw0ridFNOx
         0Utb1GSeHBwzt2FqFsJgn8mSGNaHn8sgLGGNgKaXa880xly+y67kSbzGDR6r0NHy3gqg
         yrWdl87ldtZHyHhYcHgFV3LrUvxhDxrMnlHI3/LY1/bY6bVPy+KZiAmPlldmG3zKQwJS
         0cZElmkVr7tplsXs6Sg4k3gJDAD2ZHbBhU+WgUDoJbY1INqjY6tIedtiYZ+M+ZNGKeKG
         lix1MAv/7qhmOHwy7foryyTxAloI7UrY+KNEEX2E3scszI8Ou0GxjsRQhe/gcV3Qs2s5
         9a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324345; x=1696929145;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwdKPsSZX5lF9BZ1cbD7q6c/KB8Lk1EC3PAauvodoEY=;
        b=S8Iok2X8VroNfFO9AL3t14TtR25NjzjsMs0AYYgPH1/VdeaMPpFVKZSJ9ZuOzUPUgm
         G29wi080jz6foctw8p2Pf4RZEzZKol69K5zWaG2+XEyTBqBUr5xyW4DPbn5hPRpv1Vtl
         PVJBhGGLZGRMIC1ImkvW5oqPRwhU+4YkHfcNa1nOfdXp8FgIIctYBiioI63tOkDSTKvL
         Spjf6fVDI8yu5aKesDR76zMKT58wPyHSw0Izs/OnpNUkRgzYr7kuZmpRK0CUotx5Jp72
         dAHCf4kIXEKeNVUl+DvYIRiL5oGyO5ABQVF+COXwlgrEHxQarNfmDEgYVOiuvVrRomVr
         aE7A==
X-Gm-Message-State: AOJu0YxNegVJt3CljbCFrHHdG+oyOryrFDNvDXT6ZnrncrNomvFWEkAI
        T3U74Z11tgFqL0V7BLwxHPIidw==
X-Google-Smtp-Source: AGHT+IHeox1fltLEhdIRRcLFlBpcEWhixSw6n5wz+13doXbu/4zqff/jwBbGoie468vAGNRgTE+iFA==
X-Received: by 2002:a5b:251:0:b0:d81:a0c5:f274 with SMTP id g17-20020a5b0251000000b00d81a0c5f274mr12294841ybp.48.1696324344885;
        Tue, 03 Oct 2023 02:12:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w7-20020a05690202c700b00d7ba4c5e31fsm274592ybh.39.2023.10.03.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:12:24 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:12:14 -0700 (PDT)
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
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 00/12] mempolicy: cleanups leading to NUMA mpol without
 vma
Message-ID: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
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

Here is v2 of a series of mempolicy patches, this version based on
mm-everything-2023-10-02-21-43, applicable also to next-20231003:
mostly cleanups in mm/mempolicy.c, but finally removing the pseudo-vma
from shmem folio allocation, and removing the mmap_lock around folio
migration for mbind and migrate_pages syscalls.

This replaces the "mempolicy: cleanups leading to NUMA mpol without vma"
https://lore.kernel.org/linux-mm/2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com/
series of 12 based on 6.6-rc3 and posted on 2023-09-25.

01/12 hugetlbfs: drop shared NUMA mempolicy pretence
      v2: add reviewed-by Matthew
          hugetlb.h include pagemap.h for filemap_lock_folio()
02/12 kernfs: drop shared NUMA mempolicy hooks
      v2: add reviewed-by Matthew
03/12 mempolicy: fix migrate_pages(2) syscall return
      v2: add reviewed-by Matthew
          replace Yang Shi's qp->has_unmovable by qp->nr_failed
          remove ptl,addr,end to queue_folios_pmd() per Huang,Ying
          reword comments above queue_folios_pte_range()
          fix incorrect migrate_folio_add()ing per Huang,Ying
          which also fixes qp->nr_failed as count of folios
04/12 mempolicy trivia: delete those ancient pr_debug()s
      v2: add reviewed-by Matthew
05/12 mempolicy trivia: slightly more consistent naming
      v2: add reviewed-by Matthew
06/12 mempolicy trivia: use pgoff_t in shared mempolicy tree
      v2: declare struct shared_policy (the root) before struct sp_node
          reformat sp_lookup, mpol_shared_policy_lookup decls per Matthew
07/12 mempolicy: mpol_shared_policy_init() without pseudo-vma
      v2: sn,npol instead of n,new (but no optimization) per Matthew
08/12 mempolicy: remove confusing MPOL_MF_LAZY dead code
      v2: add reviewed-by Matthew
09/12 mm: add page_rmappable_folio() wrapper
      v2: move page_rmappable_folio() to mm/internal.h per Matthew
10/12 mempolicy: alloc_pages_mpol() for NUMA policy without vma
      v2: adjust to fit on top of earlier mm-unstable mods
11/12 mempolicy: mmap_lock is not needed while migrating folios
      v2: remove HugeTLBfs special casing of src->index
12/12 mempolicy: migration attempt to match interleave nodes
      v2: remove HugeTLBfs special casing of page->index

 fs/hugetlbfs/inode.c           |  41 +-
 fs/kernfs/file.c               |  49 --
 fs/proc/task_mmu.c             |   5 +-
 include/linux/gfp.h            |  10 +-
 include/linux/hugetlb.h        |  12 +-
 include/linux/mempolicy.h      |  44 +-
 include/linux/mm.h             |   2 +-
 include/uapi/linux/mempolicy.h |   2 +-
 ipc/shm.c                      |  21 +-
 mm/hugetlb.c                   |  38 +-
 mm/internal.h                  |   9 +
 mm/mempolicy.c                 | 988 ++++++++++++++++-------------------
 mm/page_alloc.c                |   8 +-
 mm/shmem.c                     |  92 ++--
 mm/swap.h                      |   9 +-
 mm/swap_state.c                |  83 +--
 16 files changed, 630 insertions(+), 783 deletions(-)

Hugh
