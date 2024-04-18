Return-Path: <linux-kernel+bounces-149930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF28A9800
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30B228264A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9015E5AB;
	Thu, 18 Apr 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfYr9CY7"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5FA15E1FC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437895; cv=none; b=cPeMegZ9MkMlvV9aN0oQwaNF1Fp8rTzRFm5ekRN8Nd4jGdMKPx2FRm+cN0i1Gq3raVeJ12vI4HNg92g7Lc5ar2KAIHwwArnppwOKPombXvYJ42NEe/Ut56ZClvEfuRT8Cut8EQTghUv8nVNZp0W4Jnzfzkhk113IuzGVQGkwMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437895; c=relaxed/simple;
	bh=BMKeamrUs5QYDmAt++7NWOeIYtOf6sOdQoLVn34m6EI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PuhKMBjVqX+HDXqn6mbwdJFMQo+Uv8rO8aEuj2UHKIgJM9QJXtiTcq76/a4lxYzJgIuiVui49XtCJS4diab8MmZLQMo11j5CspgVhPHWVmCthRkxmaulTCyTKenVsKEShqgc3m3mdEk//2Y0d2XIS7JhlYy4t/ruegLJIyznSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfYr9CY7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecff9df447so725251b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713437893; x=1714042693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDh/BDmc4GxVIIPX4vpyqLS6cxtfqtFde9O8+cyucD8=;
        b=MfYr9CY77z6cvvE36M8vntvitHSMKL6CWhmdCQOJjQDcaKAK057qGI7k84sfe4Bqih
         3FnVYjrq4GK/6yS2oJynLbwTDpyH3vMflnbuNYYeryXNy9L0r2iqC3yRWB7yDzbnP19K
         Wy40J5P7OjL5EWZERy1JtouuH54qIslt0qWPg+5K6NcO9G6qLr3989h1hxy8qp9AStfe
         11VxKmZbe9yjKSMQAOPQ1frm0w+1csYUj81b4FXZPIPuRZ4bavzMB04H74Hx9GclxkI4
         tyW+PE8r+Vdgvaf1Okfny4imRubgS3hMSeZE5GGzpCP0jA+fLSOP7RqZhg6mCMEWfR6l
         Iu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437893; x=1714042693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDh/BDmc4GxVIIPX4vpyqLS6cxtfqtFde9O8+cyucD8=;
        b=Vl/6d3a/2iR1C9tHi37w7xPS7Myzg13p4UCr4sbs1IEsH4RMg3yK3KzDOcP/bXTLP9
         xV3c9xzGzepBh+Zc11OvlIENUFdamvkiDfkCaubWaliChFX8clKH5hqkB5LVUw06Sq8D
         U45NDluUwHGLVUUj/Inm2muyoRj6lRr4WedOYYaE6p6E6t1BHWlS/INabMxL9ivI+oRS
         je/uXqQO1A9UeWkmaWkRNDup6nx3a7o3wtBvtrY3JbUTjtMchAPY95y+MExsxXCfy2Qc
         WxoZR03W3dU/bWanvgwwnqhjpR1m8PxANoMedpaH9o+CppPLxII4flyQ6R1xu9ALs3K2
         LUBA==
X-Forwarded-Encrypted: i=1; AJvYcCWVLGZoSYOQfHox1Y7wocbTt3LY2N5+6W/rMN+MynTkgLA2f2qLU/RzBqXFMpwfwQ440APgeBPMpieNAWfAxdM8ZHwd1CYEZHUUGhSE
X-Gm-Message-State: AOJu0Yw3g2lQWCLcdGYZd3Fq7JAbJvZGyNrhFy6L0caLZMG9M0kdXMbi
	p7AlQ8ICXmzctOMkx4Zg54mLopbKof/WjZKaUlZIQ6adU0xDkgaM
X-Google-Smtp-Source: AGHT+IFMtKbWnXmmZkOC1fnGlD0vshJ2wQkVFHJuz/Uhj+dQ7fHI58t2TX/J4UwzBWJylBQj0rjcVg==
X-Received: by 2002:a05:6a00:1906:b0:6ea:b9ef:f482 with SMTP id y6-20020a056a00190600b006eab9eff482mr2986258pfi.24.1713437892925;
        Thu, 18 Apr 2024 03:58:12 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id gd26-20020a056a00831a00b006ea923678a6sm1200487pfb.137.2024.04.18.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:58:12 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v9 0/4] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Thu, 18 Apr 2024 18:57:46 +0800
Message-Id: <20240418105750.98866-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This patchset adds support for lazyfreeing multi-size THP (mTHP) without
needing to first split the large folio via split_folio(). However, we
still need to split a large folio that is not fully mapped within the
target range.

If a large folio is locked or shared, or if we fail to split it, we just
leave it in place and advance to the next PTE in the range. But note that
the behavior is changed; previously, any failure of this sort would cause
the entire operation to give up. As large folios become more common,
sticking to the old way could result in wasted opportunities.

Performance Testing
===================

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
the same size results in the following runtimes for madvise(MADV_FREE)
in seconds (shorter is better):

Folio Size |   Old    |   New    | Change
------------------------------------------
      4KiB | 0.590251 | 0.590259 |    0%
     16KiB | 2.990447 | 0.185655 |  -94%
     32KiB | 2.547831 | 0.104870 |  -95%
     64KiB | 2.457796 | 0.052812 |  -97%
    128KiB | 2.281034 | 0.032777 |  -99%
    256KiB | 2.230387 | 0.017496 |  -99%
    512KiB | 2.189106 | 0.010781 |  -99%
   1024KiB | 2.183949 | 0.007753 |  -99%
   2048KiB | 0.002799 | 0.002804 |    0%

---
This patchset applies against mm-unstable (6723e3b1a668). 

The performance numbers are from v2. I did a quick benchmark run of v9 and
nothing significantly changed.

Changes since v8 [8]
====================
 - mm/madvise: optimize lazyfreeing with mTHP in madvise_free
    - Leave the split folio code as is in the caller (per David Hildenbrand)
    - Use cydp_flags here that will make this easier to read (per
      David Hildenbrand)
 - Pick up RB's, Thanks to Ryan!

Changes since v7 [7]
====================
 - mm/madvise: optimize lazyfreeing with mTHP in madvise_free
    - Remove the duplicated check for the mapcount (per Ryan Roberts,
      David Hildenbrand)
 - Pick up AB's and RB's. Thanks to Ryan and David!

Changes since v6 [6]
====================
 - Fix a bug with incorrect bitwise operations (Thanks to Ryan Roberts)
 - Use a cmpxchg loop to only clear one of the flags to prevent race with
   the HW (per Ryan Roberts)

Changes since v5 [5]
====================
 - Convert mkold_ptes() to clear_young_dirty_ptes() (per Ryan Roberts)
 - Use the __bitwise flags as the input for clear_young_dirty_ptes()
   (per David Hildenbrand)
 - Follow the pattern already established by the original code
   (per Ryan Roberts)

Changes since v4 [4]
====================
 - The first patch implements the MADV_FREE change and introduces
   mkold_clean_ptes() with a generic implementation. The second patch
   specializes mkold_clean_ptes() for arm64, providing a performance boost
   specific to arm64 (per Ryan Roberts)
 - Drop the full parameter and call ptep_get_and_clear() in mkold_clean_ptes()
   (per Ryan Roberts)
 - Keep the previous behavior that avoids locking the folio if it wasn't in the
   swapcache or if it wasn't dirty (per Ryan Roberts)

Changes since v3 [3]
====================
 - Rename refresh_full_ptes -> mkold_clean_ptes (per Ryan Roberts)
 - Override mkold_clean_ptes() for arm64 to make it faster (per Ryan Roberts)
 - Update the changelog

Changes since v2 [2]
====================
 - Only skip all the PTEs for nr_pages when the number of batched PTEs matches
   nr_pages (per Barry Song)
 - Change folio_pte_batch() to consume an optional *any_dirty and *any_young
   function (per David Hildenbrand)
 - Move the ptep_get_and_clear_full() loop into refresh_full_ptes() (per
   David Hildenbrand)
 - Follow a similar pattern for madvise_free_pte_range() (per Ryan Roberts)

Changes since v1 [1]
====================
 - Update the performance numbers
 - Update the changelog (per Ryan Roberts)
 - Check the COW folio (per Yin Fengwei)
 - Check if we are mapping all subpages (per Barry Song, David Hildenbrand,
   Ryan Roberts)

[1] https://lore.kernel.org/linux-mm/20240225123215.86503-1-ioworker0@gmail.com
[2] https://lore.kernel.org/linux-mm/20240307061425.21013-1-ioworker0@gmail.com
[3] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0@gmail.com
[4] https://lore.kernel.org/linux-mm/20240402124029.47846-1-ioworker0@gmail.com
[5] https://lore.kernel.org/linux-mm/20240408042437.10951-1-ioworker0@gmail.com
[6] https://lore.kernel.org/linux-mm/20240413002219.71246-1-ioworker0@gmail.com
[7] https://lore.kernel.org/linux-mm/20240416033457.32154-1-ioworker0@gmail.com 
[8] https://lore.kernel.org/linux-mm/20240417141436.77963-1-ioworker0@gmail.com

Thanks,
Lance

Lance Yang (4):
 mm/madvise: introduce clear_young_dirty_ptes() batch helper
 mm/arm64: override clear_young_dirty_ptes() batch helper
 mm/memory: add any_dirty optional pointer to folio_pte_batch()
 mm/madvise: optimize lazyfreeing with mTHP in madvise_free

 arch/arm64/include/asm/pgtable.h |  55 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          |  29 +++++++++++++++++++++++
 include/linux/mm_types.h         |   9 ++++++++
 include/linux/pgtable.h          |  74 +++++++++++++++++++++------------------
 mm/internal.h                    |  12 ++++++++--
 mm/madvise.c                     | 107 +++++++++++++++++++--------------------
 mm/memory.c                      |   4 ++--
 7 files changed, 209 insertions(+), 81 deletions(-)

-- 
2.33.1


