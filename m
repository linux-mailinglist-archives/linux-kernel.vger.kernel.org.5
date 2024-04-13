Return-Path: <linux-kernel+bounces-143439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E78A3913
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C32283C31
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF41391;
	Sat, 13 Apr 2024 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EicIsxjU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DCD7F6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967764; cv=none; b=NDbeNQYPmV8LFLqy/+kMS0ljfZ33mvWj5oa8Zlvv23JKy4/+EH7cQuCXu/c2qxsbm3ucAG/zQZ3fiO8n0WNr6ER1pwQjo7JaQSs5udLBKcIr+mJkq8Cx4bSg9jaG/1FBUCdA1WMyhES6sTWMUV/2ngQZ4YDuYUalOcqCTlk8+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967764; c=relaxed/simple;
	bh=bIWfVfX+XOX6SU9FH16IhWdBXzDZV2p4tRkNNOUAXBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5N33/CZsUIFC3I57fbnSKMsFXyp+F5wUg8F2r0YDAol1d8jWCzwBjMcurIJ6fQ+V/PASZogWj05auTbab1YZkbTnrDx7q+1l0OhH08QpyWsGUYoIiudXAN5tf6dHNIcO1AHbykFMPudRUaOnlU71sri7JszXEjNp2X/8CdcBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EicIsxjU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ff14f249so11125165ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712967762; x=1713572562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H56jlVSkImjG5Con1Y1IwJCEpB0vQXFHrk5E2u8OB/Q=;
        b=EicIsxjUE9mA6Fs6Ed/J3g//DMES4Q5YuL/5Ph9lLfZtq6v3wmOcV6jptULTDA1dIn
         XsTrZUxvgm6peYeQlwMql+Dl9M5TzT0NM7rlhFlGDM0rkgzo3RvR6EDSleW7LXikPnvZ
         bNQBvCWwXrk/nP0Gc8HX+IOiGoh8l1D4K3X84j7A5srXvXa96XtubmHizytFEvIeSwC5
         t4N4+DQ5TpyapoTuizQqx9qxLvqEy4wEq4B6aeWMeJ5NbidX9nxqS2yiFvtj7GFo0I1c
         PPxMscvD2aSiGPNYnzPAnNlFyetITAq5gwWW5ht7mAXCkQ3idmhYf0bsFvPds/T7o5uK
         zvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967762; x=1713572562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H56jlVSkImjG5Con1Y1IwJCEpB0vQXFHrk5E2u8OB/Q=;
        b=K0YQ2B7h+A/kH7R5mGXXeyWh5Nj298C9oQgeK3Gaf2/QWYs4WLM3OC9dSSXHqE7UEA
         5Zw3oiBEZGnIIVNyYn+KbyaSP/ozFg2hx60oamtI2EYCn/vfhuJVvWs60WFb/UUS2A9n
         DyKF69ipzZF59iiA38/IZ1qPgHIBarzrIcdNWbsMO8XbO2/ovL69tiYUKyu7VRiRgVwM
         DwRxRfhggPiQk8HyNUOGbJd5MUu8Rwj9QJ2hjdXRwFSuVx3Cy2mgO7U5uYOVEp0QI24v
         KWZbUFaTJKs/cWYfuxqcDvO+E6moFgfj4/dQn+Nf9YS9bsF1rQhVRu12dEpcpOkFV/Za
         Gzyw==
X-Forwarded-Encrypted: i=1; AJvYcCXWkwSzLrdGJ0s7VvEemfIrTG2h4s9Qk+/pWnHqiOnVFWW3eswpRyUF87Ds6+dBwa+Fy6R6tJJzPRQlsO9HWVeLTiDOywIVGOAazg6Y
X-Gm-Message-State: AOJu0Yw1uyl4kViDaPrNIJbFeDHXkZANbfh/hRV6lwP8DEh/2ENeAM7f
	aIN0QplFVggQPvkqvaQJ4auweNg20Fw+oHtKh4sft1e2kz6HyqVf
X-Google-Smtp-Source: AGHT+IHDPb7KYH6+g22qQLutSNBT3fGe7ZKFU6yWCJMO/AHYf1F2UvmYB+FQBtiQwybK2ATAoW47bA==
X-Received: by 2002:a17:902:cec4:b0:1e4:55d8:e15f with SMTP id d4-20020a170902cec400b001e455d8e15fmr9761137plg.32.1712967762227;
        Fri, 12 Apr 2024 17:22:42 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001e2a4ac7bf9sm3569618pld.111.2024.04.12.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:22:41 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	shy828301@gmail.com,
	david@redhat.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v6 0/2] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Sat, 13 Apr 2024 08:22:17 +0800
Message-Id: <20240413002219.71246-1-ioworker0@gmail.com>
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
This patchset applies against mm-unstable (37a4ecbf36cb). 

The performance numbers are from v2. I did a quick benchmark run of v6 and
nothing significantly changed.

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

Thanks,
Lance

Lance Yang (2):
 mm/arm64: override clear_young_dirty_ptes() batch helper
 mm/madvise: optimize lazyfreeing with mTHP in madvise_free

 arch/arm64/include/asm/pgtable.h |  37 ++++++++++++++++++++++
 arch/arm64/mm/contpte.c          |  28 +++++++++++++++++
 include/linux/mm_types.h         |   9 ++++++
 include/linux/pgtable.h          |  42 +++++++++++++++++++++++++
 mm/internal.h                    |  12 +++++--
 mm/madvise.c                     | 147 +++++++++++++++++++++++++++++----------
 mm/memory.c                      |   4 +--
 7 files changed, 212 insertions(+), 67 deletions(-)

-- 
2.33.1


