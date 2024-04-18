Return-Path: <linux-kernel+bounces-150191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2454E8A9B85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913E71F22FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD7F15FD16;
	Thu, 18 Apr 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njZd6oAy"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A984D02
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447885; cv=none; b=pe/TwlwYKGrj9ikxllGyFKWlsxSMas3dtgyPdhzWB+QO2JaGo7JLIl7TvUxC8FnTnhSz5geLFPOhlOTYZC6dNHSt6O8Gsqfb9HDI3LdirpPpVPGGXymeIAS/ZUy2Tvj8hDufvZ1ahrbpyd+v/UudhFcCJxCgFitSEuWc6h62aoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447885; c=relaxed/simple;
	bh=Gqc0YLypQ5BgZkJz7D4FTqGPucD4Qht1NBHsvnBpLvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewptHdSB15H0BfjrSN/fJhOf170QbiJ548wmLNabyFn7jqLBgsbiRBMtNSKNGQEnnIoNonqv2jpysjUNy3FdYcHFsGmLY5Au4qwBz0ejJt6QlkIQ+Zn2zKywRki0GMNC9lXPRX7e7q7Wg799vYDx2AzDhbqCOJOOIh11NOXHSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njZd6oAy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so902582b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447883; x=1714052683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fqqbw3IjyKnn1m1Xe9QqS4J7Q9A7Cu8Dc3YLSqhOLnE=;
        b=njZd6oAy9t2RxkP+lEOALg766IIuw9e45j5nhiKxLkmF4mMtLAf7ULNRX+2qWxyZhJ
         2yk9fdlNUVXcWttbo7SXXdckZ2SVQB1JTGv7WdihHmldcmkNvYMPiN+LDHR/dqRHAgZe
         HTRbxjz8j9bguw1Jpea6rID+Z5kGWYyFE+RdtDNWmT7gW4RGsO0kSl5QIf2y9qap9jjv
         HMz4tlq7MRJznUR0j8MeiJz7I8csHmi9DwS6ln0NaMQ+QBkR4S0yJ7gqgGqbb+g/wNr7
         RQzCQPZOPnYpxdQqZn1MYL/tqErn/+1EldLtUbu3Zt52FbOYDNuVFHrcwUAxmk8xN3nh
         k2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447883; x=1714052683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fqqbw3IjyKnn1m1Xe9QqS4J7Q9A7Cu8Dc3YLSqhOLnE=;
        b=YT9tsU4uwA2234V1Gqj4l8WpN/7Hrjg48Isv+fuYP6ae63V3o2FjLdIGchdKmy8aMv
         2MMzTbQT1q9E0+lUVmBbGbWc65jYWYEEJhJ14bX3u1wGg2zKo0U1kTD8lmw4mfiZg5cA
         pC3Yl9sstqiB3iMohiGcb6Pt2uWU98DuLbCMdPcsD5fmZTaK59mkY92rA4npQH18IO0S
         LfoIauQw4QeHUM8fb+m4mhB0yJ3EzMzk7g1VOsvOY9y42fv2kLJExmhhla0sGbI2wdWi
         QjD2e1fZ3k6Or2dN2/ulpPhe4JsPu0HImNkkgm+p43JLdJeM9nMKp6dUAC5rL2b4Rd18
         m14g==
X-Forwarded-Encrypted: i=1; AJvYcCXcT1O5cJdSRjTPz0eR3b2HCy5PvoQ/S5kTtj0GerLux5FF5XsF5T/FPHnz2RwIL7W6IV1InroudW0phowvu2U423tNI6uC23Rlrfom
X-Gm-Message-State: AOJu0YxqiW3v46hHtbyQNn1lV7hqqKrxJEZ8W8SvMxRuSv1khRX4578F
	HBsNhpTbHKTmVumjpbe4jSvEk0rNJwFaLf3wgcgzCNYBV114ZTo5
X-Google-Smtp-Source: AGHT+IG6+LasurbPxhaqNQ0AYUMX60c9471MkKIjRI6pRxYPA5DllfNCaYBL9yaDm8iPUDeFg62vQQ==
X-Received: by 2002:a05:6a21:3e0d:b0:1a9:c4ca:dc74 with SMTP id bk13-20020a056a213e0d00b001a9c4cadc74mr3589823pzc.5.1713447882856;
        Thu, 18 Apr 2024 06:44:42 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b001e4fdcf67desm1504837pls.299.2024.04.18.06.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:44:42 -0700 (PDT)
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
Subject: [PATCH v10 0/4] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Thu, 18 Apr 2024 21:44:31 +0800
Message-Id: <20240418134435.6092-1-ioworker0@gmail.com>
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
This patchset applies against mm-unstable (f52bcd4a9f60). 

The performance numbers are from v2. I did a quick benchmark run of v10 and
nothing significantly changed.

Changes since v9 [9]
====================
 - mm/madvise: optimize lazyfreeing with mTHP in madvise_free
    - Pass any_dirty to madvise_folio_pte_batch() (Thanks to David Hildenbrand)
 - Pick up AB's, Thanks to David!

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
[9] https://lore.kernel.org/linux-mm/20240418105750.98866-1-ioworker0@gmail.com

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


