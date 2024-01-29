Return-Path: <linux-kernel+bounces-43241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6994841157
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E22628AB14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A53F9D7;
	Mon, 29 Jan 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggESCby+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913C76C99
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550904; cv=none; b=MrAZMFteo5MDUOvaS3VBDWhVKjlFJGRgYWWbBOPuEaKcZG14W+HHcoU0cJrvRxzxCjfguB5U8vR5poWny4EdviLa+2OMSY+3qhU0FVzAVza7SG7b7dnFHFVOJJEKJ/T72vomVH44JvxYOHiQ6mvvP16tg9qrjIQIj5vKidRnBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550904; c=relaxed/simple;
	bh=V20LmJlc5qrvwDWZ8GaEPl1kFqw7QrxsmKmJ1nUjAY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jidSPrYuJj9jo5IgeI7McRDdDbr+0TSvotino6hgGgfnW44Apj91vFGEu2g9gxYgjylQ+rc+Sd2MvStWPDvtsqEthXGXWWv22HEbUb6WkvMSXseIbLxNyEYsf9Td86Vyx/5iskuUqz8DbI0CYO6lgngwFbKS8wlzEWWY+HaoDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggESCby+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddb807e23bso1304515b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550902; x=1707155702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+EU8gGa/jy7tRNv4sNkXeHUxxI9bh/bLE9dwfXYMaM=;
        b=ggESCby+9VB89/c62gVy1QO8ups+hcvFTm2wAUSwezZYN7xJVKUZ9+HW5YIL7a5IXN
         GpgKJEeUYMX75FNzjDw09NDm67RZriVoF+7q7Z2hKETuKpmgghYYD0BXIdwx3x2V/9cV
         XSYlnTsxL5Qj7K0sllWPLqzNlOGBkSrT1k4YtWX1ihPmNaQdnAiRjsfq3XHnZcKRzlDc
         ljrAVb38BIkz4dhE9oTiAF9C0ZkT5fOYih1Al8BpemMYvUYEdUVhYDOlQMEQ1npTm5Lk
         pmQxD+Of7ziaw7sYXC6Bz8yrnYkJxmhjyI8D0YRmW7lquhV3DjNOj2y4cdE30VewYln2
         Wdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550902; x=1707155702;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+EU8gGa/jy7tRNv4sNkXeHUxxI9bh/bLE9dwfXYMaM=;
        b=HH/xYyPZ+IK9qOA7YqvHkIRghRJS+p1ifpm/Ci5O+FNjO4cV8wPYb6lV1Iz1bYUIFv
         v8iOcnFPBK69b9nsQ80clfRuCcaa8QWGM2b8zBfLRHTkSGz2yFK9Q0qK/pDd5jpKcN/I
         MKX1qMmX158cE/MDbzgbjVPNc4kDAGhCD5AEAigwT3xGAIK/JumyC/N/7jnILbQPPnJA
         F5n+l80DAk1ZuXrOPkDsLwEfoE49zp9nlc5JEBhyVS9zgXOXHLm02N/lUUsXLbODuxyK
         QK8buTTctkpBOdKTtXxgAJSH0f75+UKmtprZG3H4LdXVnf1bR2n2V9MWVtFC2VBawqhs
         f6Yw==
X-Gm-Message-State: AOJu0YyGl8tH7eT7IbBD/8VGnjDKMCJYwvohskrRpFU62nryMwhpulFR
	nQppDs6+AZDQYXfWiEP4CKd4xc4bLltMLlqSWHBm/JsnGlG5bcj7
X-Google-Smtp-Source: AGHT+IHC6I3zeWIP+jFk+wHaltKLnBGg4kEGCsueXo1qt4bwGqe5GrwjhCmfcbPnj1+FhkoULuWlDw==
X-Received: by 2002:a05:6a20:6ca9:b0:19b:1d39:a567 with SMTP id em41-20020a056a206ca900b0019b1d39a567mr2722552pzb.47.1706550902318;
        Mon, 29 Jan 2024 09:55:02 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.54.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:01 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 0/7] swapin refactor for optimization and unified readahead
Date: Tue, 30 Jan 2024 01:54:15 +0800
Message-ID: <20240129175423.1987-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series tries to unify and clean up the swapin path, introduce minor
optimization, and make both shmem swapoff make use of SWP_SYNCHRONOUS_IO
flag to skip readahead and swapcache for better performance.

Test results:
- swap out 10G zero-filled data to ZRAM then read them in:
  Before: 11143285 us
  After:  10692644 us (+4.1%)

- swapping off a 10G ZRAM (lzo-rle) after same workload:
  Before:
  time swapoff /dev/zram0
  real    0m12.337s
  user    0m0.001s
  sys     0m12.329s

  After:
  time swapoff /dev/zram0
  real    0m9.728s
  user    0m0.001s
  sys     0m9.719s

- shmem FIO test 1 on a Ryzen 5900HX:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs --size=960m \
    --ioengine=mmap --rw=randread --random_distribution=zipf:0.5 \
    --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

  Before:
    bw (  MiB/s): min= 1167, max= 1732, per=100.00%, avg=1460.82, stdev= 4.38, samples=9536
    iops        : min=298938, max=443557, avg=373964.41, stdev=1121.27, samples=9536
  After (+3.5%):
    bw (  MiB/s): min= 1285, max= 1738, per=100.00%, avg=1512.88, stdev= 4.34, samples=9456
    iops        : min=328957, max=445105, avg=387294.21, stdev=1111.15, samples=9456

- shmem FIO test 2 on a Ryzen 5900HX:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs --size=960m \
    --ioengine=mmap --rw=randread --random_distribution=zipf:1.2 \
    --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

  Before:
    bw (  MiB/s): min= 5296, max= 7112, per=100.00%, avg=6131.93, stdev=17.09, samples=9536
    iops        : min=1355934, max=1820833, avg=1569769.11, stdev=4375.93, samples=9536
  After (+3.1%):
    bw (  MiB/s): min= 5466, max= 7173, per=100.00%, avg=6324.51, stdev=16.66, samples=9521
    iops        : min=1399355, max=1836435, avg=1619068.90, stdev=4263.94, samples=9521

- Some built objects are very slightly smaller (gcc 13.2.1):
/scripts/bloat-o-meter ./vmlinux ./vmlinux.new
add/remove: 4/2 grow/shrink: 1/10 up/down: 818/-983 (-165)
Function                                     old     new   delta
swapin_entry                                   -     482    +482
mm_counter                                     -     248    +248
shmem_swapin_folio                          1412    1468     +56
__pfx_swapin_entry                             -      16     +16
__pfx_mm_counter                               -      16     +16
__read_swap_cache_async                      738     736      -2
copy_present_pte                            1258    1249      -9
mem_cgroup_swapin_charge_folio               297     285     -12
__pfx_swapin_readahead                        16       -     -16
swap_cache_get_folio                         364     345     -19
do_anonymous_page                           1488    1458     -30
unuse_pte_range                              889     833     -56
free_p4d_range                               524     446     -78
restore_exclusive_pte                        937     822    -115
do_swap_page                                2969    2817    -152
swapin_readahead                             239       -    -239
copy_nonpresent_pte                         1478    1223    -255
Total: Before=26056243, After=26056078, chg -0.00%

V2: https://lore.kernel.org/linux-mm/20240102175338.62012-1-ryncsn@gmail.com/
Update from V2:
  - Many code path clean up (merge swapin_entry with swapin_entry_mpol,
    drop second param of mem_cgroup_swapin_charge_folio, swapin_entry
    takes a pointer to folio as return value instaed of pointer to
    boolean to reduce LOC and logic), thanks for Huang, Ying.
  - Don't use cluster readhead for swapoff, the performance is worse
    than VMA readahead for NVME.
  - Add a refactor patch for swap_cache_get_folio.

V1: https://lore.kernel.org/linux-mm/20231119194740.94101-1-ryncsn@gmail.com/T/
Update from V1:
  - Rebased based on mm-unstable.
  - Remove behaviour changing patches, will submit in seperate series
    later.
  - Code style, naming and comments updates.
  - Thanks to Chris Li for very detailed and helpful review of V1. Thanks
    to Matthew Wilcox and Huang Ying for helpful suggestions.

Kairui Song (7):
  mm/swapfile.c: add back some comment
  mm/swap: move no readahead swapin code to a stand-alone helper
  mm/swap: always account swapped in page into current memcg
  mm/swap: introduce swapin_entry for unified readahead policy
  mm/swap: avoid a duplicated swap cache lookup for SWP_SYNCHRONOUS_IO
  mm/swap, shmem: use unified swapin helper for shmem
  mm/swap: refactor swap_cache_get_folio

 include/linux/memcontrol.h |   4 +-
 mm/memcontrol.c            |   5 +-
 mm/memory.c                |  45 ++--------
 mm/shmem.c                 |  50 +++++++----
 mm/swap.h                  |  23 ++---
 mm/swap_state.c            | 176 ++++++++++++++++++++++++++-----------
 mm/swapfile.c              |  20 +++--
 7 files changed, 190 insertions(+), 133 deletions(-)

-- 
2.43.0


