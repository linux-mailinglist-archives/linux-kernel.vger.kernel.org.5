Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037927F0888
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjKSTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:07 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F011A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:03 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so2306332fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423282; x=1701028082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7g3Lfo6dN87EwnrcmQzmZgcn/H6DphiWq+VSi6rH/E=;
        b=aZqPot4NWnprM/f12lVZEeBzOKKOb6xu0FkGlFHri9hh/87XNaPHtt2x1wlLuoiAGj
         2OKcHrHLauN3QgZAawrXEZinJTTyYDsFVkZJ/KvaN8eRyoyXGJIRPOoNXoSN/v7sZhvT
         iwqZHZgIHh68UgavnRZKi8mTlSSXtzObJEl18CCUGDO8CNSaL5d8lGzp6MDFetDbqdwz
         sQg1XD0gh9CbSMtuy/ArbfJo8+dvPzEeSvxgN74LevFN4Cj/x1oR9Rv42cvzJH22T+Yl
         F4q77EQX+5iJgj3dR6FY4bPELzXJ1A/N/0NMrzPn8CvnY4gzgv4tL8ipONQkFEJ9ylvN
         g2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423282; x=1701028082;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7g3Lfo6dN87EwnrcmQzmZgcn/H6DphiWq+VSi6rH/E=;
        b=pekrreD2YdHJZ2u8bVLdTXE2CZS9UxRDm4/FAZmKp4UdfsiZKiJGRR2TU2yubfmOx5
         ULDKsY69zQhbn9s3VouhAa+yMGhLey7ApmPMqhHlCrOuMD/G0AebTbA0EwcvSTxd0YiT
         Yqsx70PlDdAbPAXKyKiBgcc7yIM+R1CPJG1C0eQTC4XKsKjTmXW3gHV2r+CpQ1qcURrH
         /KulPslX/OlvJO6iGQCAc7F472ikwp7CswPiwHIw9TYuj651ehNY/cg0sXP9guoJCkLe
         efacJuINIL08DVBmgzVnKaoj7eGotnbhSwX82ScFeusDzpJNdIGeX8dUwQDHj4fzPvdx
         JgoA==
X-Gm-Message-State: AOJu0YwQNRztIRyhzI5dh3i12AWngLLEiqPDnr702eHJr+LbIufw6VOX
        917dubMVRFyAKEbXrNhNdQo=
X-Google-Smtp-Source: AGHT+IHbOMmoRegyUVpK5atjtU0rtMh2MzeuyRg060GiHOZ0rDGKHx49WpCR2J4WmJAN0CmCPqc3zg==
X-Received: by 2002:a05:6870:aa97:b0:1e9:e975:4418 with SMTP id gr23-20020a056870aa9700b001e9e9754418mr7240498oab.53.1700423281997;
        Sun, 19 Nov 2023 11:48:01 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.47.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:01 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 00/24] Swapin path refactor for optimization and bugfix
Date:   Mon, 20 Nov 2023 03:47:16 +0800
Message-ID: <20231119194740.94101-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

This series tries to unify and clean up the swapin path, fixing a few
issues with optimizations:

1. Memcg leak issue: when a process that previously swapped out some
   migrated to another cgroup, and the origianl cgroup is dead. If we
   do a swapoff, swapped in pages will be accounted into the process
   doing swapoff instead of the new cgroup. This will allow the process
   to use more memory than expect easily.

   This can be easily reproduced by:
   - Setup a swap.
   - Create memory cgroup A, B and C.
   - Spawn process P1 in cgroup A and make it swap out some pages.
   - Move process P1 to memory cgroup B.
   - Destroy cgroup A.
   - Do a swapoff in cgroup C
   - Swapped in pages is accounted into cgroup C.

   This patch will fix it make the swapped in pages accounted in cgroup B.

2. When there are multiple swap deviced configured, if one of these
   devices is not SSD, VMA readahead will be globally disabled.

   This series will make the readahead policy check per swap entry.

3. This series also include many refactor and optimzations:
   - Swap readahead policy check is unified for page-fault/swapoff/shmem,
     so swapin from ramdisk (eg. ZRAM) will always bypass swapcache.
     Previously shmem and swapoff have different behavior on this.
   - Some mircro optimization (eg. skip duplicated xarray lookup)
     for swapin path while doing the refactor.

Some benchmark:

1. fio test for shmem (whin 2G memcg limit and using lzo-rle ZRAM swap):
fio -name=tmpfs --numjobs=16 --directory=/tmpfs --size=256m --ioengine=mmap \
  --iodepth=128 --rw=randrw --random_distribution=<RANDOM> --time_based\
  --ramp_time=1m --runtime=1m --group_reporting

RANDOM=zipf:1.2 ZRAM
Before (R/W, bw): 7339MiB/s / 7341MiB/s
After  (R/W, bw): 7305MiB/s / 7308MiB/s (-0.5%)

RANDOM=zipf:0.5 ZRAM
Before (R/W, bw): 770MiB/s / 770MiB/s
After  (R/W, bw): 775MiB/s / 774MiB/s (+0.6%)

RANDOM=random ZRAM
Before (R/W, bw): 537MiB/s / 537MiB/s
After  (R/W, bw): 552MiB/s / 552MiB/s (+2.7%)

We can see readahead barely helps, and for random RW there is a observable performance gain.

2. Micro benchmark which use madvise to swap out 10G zero-filled data to
   ZRAM then read them in, shows a performance gain for swapin path:

Before: 12480532 us
After:  12013318 us (+3.8%)

4. The final vmlinux is also a little bit smaller (gcc 8.5.0):
./scripts/bloat-o-meter vmlinux.old vmlinux
add/remove: 8/7 grow/shrink: 5/6 up/down: 5737/-5789 (-52)
Function                                     old     new   delta
unuse_vma                                      -    3204   +3204
swapin_page_fault                              -    1804   +1804
swapin_page_non_fault                          -     437    +437
swapin_no_readahead                            -     165    +165
swap_cache_get_folio                         291     326     +35
__pfx_unuse_vma                                -      16     +16
__pfx_swapin_page_non_fault                    -      16     +16
__pfx_swapin_page_fault                        -      16     +16
__pfx_swapin_no_readahead                      -      16     +16
read_swap_cache_async                        179     191     +12
swap_cluster_readahead                       912     921      +9
__read_swap_cache_async                      669     673      +4
zswap_writeback_entry                       1463    1466      +3
__do_sys_swapon                             4923    4920      -3
nr_rotate_swap                                 4       -      -4
__pfx_unuse_pte_range                         16       -     -16
__pfx_swapin_readahead                        16       -     -16
__pfx___swap_count                            16       -     -16
__x64_sys_swapoff                           1347    1312     -35
__ia32_sys_swapoff                          1346    1311     -35
__swap_count                                  72       -     -72
shmem_swapin_folio                          1697    1535    -162
do_swap_page                                2404    1942    -462
try_to_unuse                                1867     880    -987
swapin_readahead                            1377       -   -1377
unuse_pte_range                             2604       -   -2604
Total: Before=30085393, After=30085341, chg -0.00%

Kairui Song (24):
  mm/swap: fix a potential undefined behavior issue
  mm/swapfile.c: add back some comment
  mm/swap: move no readahead swapin code to a stand alone helper
  mm/swap: avoid setting page lock bit and doing extra unlock check
  mm/swap: move readahead policy checking into swapin_readahead
  swap: rework swapin_no_readahead arguments
  mm/swap: move swap_count to header to be shared
  mm/swap: check readahead policy per entry
  mm/swap: inline __swap_count
  mm/swap: remove nr_rotate_swap and related code
  mm/swap: also handle swapcache lookup in swapin_readahead
  mm/swap: simplify arguments for swap_cache_get_folio
  swap: simplify swap_cache_get_folio
  mm/swap: do shadow lookup as well when doing swap cache lookup
  mm/swap: avoid an duplicated swap cache lookup for SYNCHRONOUS_IO
    device
  mm/swap: reduce scope of get_swap_device in swapin path
  mm/swap: fix false error when swapoff race with swapin
  mm/swap: introduce a helper non fault swapin
  shmem, swap: refactor error check on OOM or race
  swap: simplify and make swap_find_cache static
  swap: make swapin_readahead result checking argument mandatory
  swap: make swap_cluster_readahead static
  swap: fix multiple swap leak when after cgroup migrate
  mm/swap: change swapin_readahead to swapin_page_fault

 include/linux/swap.h |   7 --
 mm/memory.c          | 109 +++++++--------------
 mm/shmem.c           |  55 ++++-------
 mm/swap.h            |  34 ++++---
 mm/swap_state.c      | 222 ++++++++++++++++++++++++++++++++-----------
 mm/swapfile.c        |  70 ++++++--------
 mm/zswap.c           |   2 +-
 7 files changed, 269 insertions(+), 230 deletions(-)

-- 
2.42.0

