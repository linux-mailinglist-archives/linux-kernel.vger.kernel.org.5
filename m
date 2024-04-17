Return-Path: <linux-kernel+bounces-148659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FBD8A85A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B246228186C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BC1411D2;
	Wed, 17 Apr 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRx1tEM6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916B13F444
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363292; cv=none; b=kZ9zeJ39RNa2pquAVTlbYMwoOdKZmdgxVSFXxIDxAqtBtGe4+ARn9y4Km3i6VeIXpoJ72jAvUPkEP++k7lcqHNAtH9RgsdtzwaMUTIntJqDDeJhwQuPJgVicCVT9FXrNLx3WjrNSNMWcrns4yh60TaQ+gvR662oHLu3gPLsyXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363292; c=relaxed/simple;
	bh=5iuVoAg37Wstx+P94YuBN+3/MPUUNp+myq9j3bbaW7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzsMtMCb6yooKMJF3V91s8fREwUhrkcWheKZcCPy/CMDnd85aONgcOUouuvXQmX5VEyn7d6t3dmYFRug3kxaau5pRMCgkP/SNnbKupOP+dknwoHd5KF3ZhWnE1Cmdkq4GA7k5XkgVaWjHE6RKFoIQs6tPLczAQwA8N38Tv5bL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRx1tEM6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e65b29f703so30157625ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713363291; x=1713968091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOdqNlpobw5BkPj0KVJli6oAlknzNEgphraB7EENvoU=;
        b=WRx1tEM63dGywQJCIydThsTwvH+ZJFBS/ydRseiGyyUzG6YqPj5aPAoDYEMsaiDf8o
         x4LxIcfl7hSloMdoNO/BFyzbCmqgac64nyXylxyZi0hst7/khgM8rJ/sU+KZNgXVoz4z
         F8P9FANgb6yW8DEylYEVWUEkmKrgv4T28shUtiR05ZcQxuikFOVBjUrHKULyXOsToG5+
         e7ITebtEKT4XGTPjo3uQjVCYkXwdmyv4l336WoezrhwM0N84TgyiOlKJ72snV4ZreoxV
         gO7YnLoSqbaJOMUjj2Oc1dT9UNwWRz3yDahiTh4sTt2j3PJmr9dE4p2P69LAa9vu4Gsg
         1bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363291; x=1713968091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOdqNlpobw5BkPj0KVJli6oAlknzNEgphraB7EENvoU=;
        b=nOdlk7UbiTz+cpt+7265luRjW+3zvIYZH9e8GahiOXlLB04eax/yQrRgOMrQSqapmF
         gEi4QFwtMe6ezYbgMJAvfRDhMyykbfIErjW1qhGzVmb6WVYAmZmGZW5UikSHGEmUmJdz
         xeldeph/7xyyw93KqbTZPpX6S3T9+0mQ0PcKGRcsNvD+RGSitwjbqjE/U7DaTvhQJZjp
         7LtkJR4OWbjfj0PgNLflWgWK2vZxAuX3b6cmcxlv2F9t4QqEfVshIA2vYvoWnwcVA8Ms
         xCsxwLS2XM0MwZY2cjMveI+XI9ZtlDf4CXf/Gh45PHlxAVMKAn1lT/iqN9vciOJBZdIa
         qNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtpOZFXicXVKX+T8K/SD6gs27MN8c+gq4B+LqpCD4wyLg38sXTls4gLxKd76TPVTbAnmXKc2ZvlM+Z4AIaC+E54XoIQfMHryIRCmwa
X-Gm-Message-State: AOJu0YzIyIaQ3vYO/ZrMVzLhRpDRu8WS31gIdXyzypoX9ZEBucLZcgwu
	ebfC81rUX1FiO9i0H/fbiOiQzH1bTJrdfrkeha9BNP3FooglWXoj
X-Google-Smtp-Source: AGHT+IF65xXZWE/D8lMwGBdhlH4F1sGFx4vMdAiKWMYZXKnzO5Ri5TkXgMwrOdlF4Zlr/S9Ifg+5FQ==
X-Received: by 2002:a17:903:2452:b0:1e8:26e4:d089 with SMTP id l18-20020a170903245200b001e826e4d089mr2296668pls.54.1713363290409;
        Wed, 17 Apr 2024 07:14:50 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902a50e00b001ddc83fda95sm11613562plq.186.2024.04.17.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:14:50 -0700 (PDT)
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
Subject: [PATCH v8 0/3] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Wed, 17 Apr 2024 22:14:33 +0800
Message-Id: <20240417141436.77963-1-ioworker0@gmail.com>
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
This patchset applies against mm-unstable (96abec3c15c2). 

The performance numbers are from v2. I did a quick benchmark run of v8 and
nothing significantly changed.

Changes since v7 [7]
====================
 - mm/madvise: optimize lazyfreeing with mTHP in madvise_free
    - Remove the duplicated check for the mapcount (per Ryan Roberts,
      David Hildenbrand)
 - Pick up AB's
 - Pick up RB's

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

Thanks,
Lance

Lance Yang (3):
 mm/madvise: introduce clear_young_dirty_ptes() batch helper
 mm/arm64: override clear_young_dirty_ptes() batch helper
 mm/madvise: optimize lazyfreeing with mTHP in madvise_free

 arch/arm64/include/asm/pgtable.h |  55 +++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          |  29 +++++++++++++++++
 include/linux/mm_types.h         |   9 ++++++
 include/linux/pgtable.h          |  74 ++++++++++++++++++++++++--------------
 mm/internal.h                    |  12 ++++++--
 mm/madvise.c                     | 144 ++++++++++++++++++++++++++++++++------
 mm/memory.c                      |   4 +--
 7 files changed, 230 insertions(+), 97 deletions(-)

-- 
2.33.1


