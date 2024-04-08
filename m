Return-Path: <linux-kernel+bounces-134781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBFD89B6D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9121F216CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8724524A;
	Mon,  8 Apr 2024 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRZ/KGmo"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3E257D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550291; cv=none; b=ndAc7Sxs7L0qikmJh72LdjoNVBstUQPdUOpmd2cPxkiVd1RNWyAM5gcjxGlYy0BkomFDWKzRqTy8dzEiCUUvV+yei61nP+C7P27kc9Dl/NYjllvyZcR6x3f0MDCO8viy9Shdm58cfnSMlNG+brgPn+DH/cvQgT8gt1XrMD4EuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550291; c=relaxed/simple;
	bh=sYf7fEy0b49zinAFUGcG/cvBVtOgjIr0sx9o3xNL4GY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dv9PLIauROaKC5MGMJp//ykglnqpK0W9rOE0MP2Exdmf06oyNQfgRYrMsS9DqICgwhiZ3OeZigtISq9P8Ps67WV8EUqJeK7VOvrf/asvjZyKJmXCVMf9sWY7OG2RqVQ7US5mKlmUwKndaKumFmkyou7ckYJ5pLwJ4Fi8D7hUdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRZ/KGmo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso3313125b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712550289; x=1713155089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lvZDaxqmUkHGSXUI9YaQuvWtKQrnJIvEACQeGbEAIqM=;
        b=KRZ/KGmoie9IQJ8dnZgQIlOA6Jh+9EpCMdV7fygCBZemcV8Kh1IEpkPWJVyQE306MA
         /ydjbk8IVcAKjCc9HWuJLMU9hXwNyF1rpwTjXGZpLH0VRDHcabUrfD4dPpBHJUyk0Hcz
         mdhq5+PPo53jqAhkQKbLDOI2SIcRIsg+mg5mQsQL7+N85uOieB2bO4U1HBBaLwKzGB2b
         CuGtYVkURRbL++T/8DcL0ohlBB8aV3qJxr/w4w7FSqNykUXNj8IKvFVPHZRyTiHnU7z6
         GoyPh/NJgl7WYuunp8eUoGZOUFDfBzMzITQs8YMsVSP77ySBafsYoyTdUH2YzH100uPE
         PICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712550289; x=1713155089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvZDaxqmUkHGSXUI9YaQuvWtKQrnJIvEACQeGbEAIqM=;
        b=ujPaTaobbvYn0r+qMneX/8R8Z7i8ZfrU2tqC+EVbfutOZKnDnxlqQIYl8BVZqIp+mR
         OiT6NEUC0GGdFz7ZWSTr0hvFCeEhY9zNV5Ji+bh6hVR6CshRkntdcjdXGQMl4nT7n0kR
         Iy/SY/Id1AHB6Aqz1+84C6Yq6UzskHR8z7y1C0oeVYewGTYV5BYtn26l9RI/6Xx0ZqBK
         Qt7jQ5j64VErFFF7yjt1Xx1EsV6uHUPpLxSuXcYUrIfNCZygQuZQAGptfNmGjhONXj6g
         ZONxr5pw1N4y6ydAmUgXQFmixU0aedFEvvBVIQWx5vlKF1uOOCsloLERnYsS8dPddjIh
         /gqw==
X-Forwarded-Encrypted: i=1; AJvYcCU+FJxq4GnUmZLbGhkHShgMxAzEQePCFGNvYR+xLaC6gyXhirqTCqZ1t0zSdiiML3pgKbWFBRHluPpSd6cITNcbhd8KBfKyL4CuMmdh
X-Gm-Message-State: AOJu0YzMpjJmULe0jY5pC70D6rKxRYdROcvj+kR/XTGF9BlKBzpMcosG
	BviDvrLmSAtiAYbkq7lXXuAI/8aGvFNxGdKf+VSAQQWyE7PLa30h
X-Google-Smtp-Source: AGHT+IGbZOrCLrZJaHQy67i/FShVBjxhbnrmp61AK8agpPOVcn4KW5h0zlVJ9D+vneksS+P65au0Og==
X-Received: by 2002:a05:6a00:810:b0:6ed:5655:a094 with SMTP id m16-20020a056a00081000b006ed5655a094mr37371pfk.32.1712550288579;
        Sun, 07 Apr 2024 21:24:48 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id p20-20020a056a000b5400b006eab6ac1f83sm5465628pfo.0.2024.04.07.21.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 21:24:48 -0700 (PDT)
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
Subject: [PATCH v5 0/2] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Mon,  8 Apr 2024 12:24:35 +0800
Message-Id: <20240408042437.10951-1-ioworker0@gmail.com>
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
This patchset applies against mm-unstable (f43b3aae9451). 

The performance numbers are from v2. I did a quick benchmark run of v5 and
nothing significantly changed.

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

Thanks,
Lance

Lance Yang (2):
 mm/madvise: optimize lazyfreeing with mTHP in madvise_free
 mm/arm64: override mkold_clean_ptes() batch helper

 arch/arm64/include/asm/pgtable.h |  57 +++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          |  15 +++++++++
 include/linux/pgtable.h          |  35 ++++++++++++++++++++
 mm/internal.h                    |  12 +++++--
 mm/madvise.c                     | 149 +++++++++++++++++++++++++++++++++++----
 mm/memory.c                      |   4 +--
 6 files changed, 202 insertions(+), 70 deletions(-)

-- 
2.33.1


