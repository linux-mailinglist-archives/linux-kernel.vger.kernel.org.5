Return-Path: <linux-kernel+bounces-136454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBAE89D432
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BED28366F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E27E591;
	Tue,  9 Apr 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrMq5z5y"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F57FBA4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651212; cv=none; b=DVXOLHF6J+6XyYwcaKRteTPw62+LKCZfYJ0DTc7tKVWWmbgBE9IoDZ386Cd7CEMgWBxnLxzLZnQydVjfwNMaNC7NODH7nSpuQn4d5gU1Kwqxt2TyZwrBU/bKfOYNGt0WjbyPvsX+0Vg0l4pYj20czQKTet7TOQ0+iDezh9dtkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651212; c=relaxed/simple;
	bh=VsYOF1JMpARh8icPaZLBbg5X8krdsxVBecPo/v9ECYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLdU4cePgQALsQREthI9cVpzbXnP/ekyz9k1GS5H4ELzFMyGMjnWuuMvq642Z+XAwKkIxYb2PEbaAu6k2GT57YgUVrbiGDMCsBQeGa7WeQzU4CXJgREp9uapyc/BQT4FfczA1/fTAM/4qNRQkOYwTlgnn6ulUeIudDXF3SpaMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrMq5z5y; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so3217670b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651210; x=1713256010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEV6OQjVxTSY2zvJnEJkUcnGhBmxeH58je50dLMPk7M=;
        b=YrMq5z5yiwA4f3BzWx0Ds89WithId0C58UWqG2UnCfOZKda+sbztTioRzoHF1/Tmgs
         Umo8EokbeP0W2uoQdTErs+Umw20kM5M/ihuPAIhe3xMFeLrvPnmUJKTrXKOvvANE0ozm
         uNRaA2xGQLPV3meOUGWUzB3VH5D7nwZiE9hF2nW4gHyhJJkLPoh+wNOP5GNIblPZV7pE
         US9dzVJRmnQd7GC3EW73Z3EsNo+5xLXKUDmjddMPx+BNUmUcmYC2HTfaNZadVZhv6OEc
         8vc3QSXrLWS5kReF6ufefuCad3tKh7L8+mvy5J0ZSyPGGEPIhnOeNbG/t6jYU2W5iIjB
         w3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651210; x=1713256010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEV6OQjVxTSY2zvJnEJkUcnGhBmxeH58je50dLMPk7M=;
        b=cgEC6xUjk8Z+yM/4MnfJTr0vIhwzy7IM7K6n6/ra8ehbj3J68OWe4OqvqaFYdBTYGd
         ig+tBlu3Co0dhL+M49ZL0OM0tHMl5/eOmBo/Xd4hd+Sdb7OC71h/tv3CPP0PcoO+aPHy
         mWF2VfKOrUPwsILQ/H4AFsprVWuIZ6/zczgiDXCQ9naQSjlhthFL4/nhG52hJHw3i0+e
         b4Xy/3/rocQwpbjk/l2drXLlofmGU41IcqrDiYXc3deWO5mkEQ6A4t0EKuoy1u1DAW/Z
         NDplwX2e7Sn67RcXS7NxmmrEbFNhH65cpJMt4sazVwNUaPhMSdtvz2/Wgn0pmRiIyL2Q
         4igA==
X-Forwarded-Encrypted: i=1; AJvYcCWOjBSFJj896Z03g67RY/wypIp0pmag5sLmfV0K4xHkY7ULmDl82B8bWxNE6rfbmVLKe2uPaCnulwEVpqXs/c1v5sBbJz2XpucOqGZU
X-Gm-Message-State: AOJu0YwJGhO+70mklZF7ASsew6AWSWrU1J9b1et7NKiQjtMBtBOti79N
	///4wIosYktlYSjZG8WVG1vqMVWVhYvgvPPUAZ1okm7/crR4pmt0
X-Google-Smtp-Source: AGHT+IHnSXKOHVSAMgfJF8XXWiIQpW7P/2klv+o3448Nul1gsbWu8MZY9Ik8wT9wAGSzIPftDqJIuA==
X-Received: by 2002:a05:6a20:9784:b0:1a7:48de:b2a4 with SMTP id hx4-20020a056a20978400b001a748deb2a4mr2552682pzc.6.1712651209608;
        Tue, 09 Apr 2024 01:26:49 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id r16-20020a632050000000b005f05c88c149sm7594238pgm.71.2024.04.09.01.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:26:49 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] large folios swap-in: handle refault cases first
Date: Tue,  9 Apr 2024 20:26:26 +1200
Message-Id: <20240409082631.187483-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch is extracted from the large folio swapin series[1], primarily addressing
the handling of scenarios involving large folios in the swap cache. Currently, it is
particularly focused on addressing the refaulting of mTHP, which is still undergoing
reclamation. This approach aims to streamline code review and expedite the integration
of this segment into the MM tree.

It relies on Ryan's swap-out series v7[2], leveraging the helper function
swap_pte_batch() introduced by that series.

Presently, do_swap_page only encounters a large folio in the swap
cache before the large folio is released by vmscan. However, the code
should remain equally useful once we support large folio swap-in via
swapin_readahead(). This approach can effectively reduce page faults
and eliminate most redundant checks and early exits for MTE restoration
in recent MTE patchset[3].

The large folio swap-in for SWP_SYNCHRONOUS_IO and swapin_readahead()
will be split into separate patch sets and sent at a later time.

-v2:
 - rebase on top of mm-unstable in which Ryan's swap_pte_batch() has changed
   a lot.
 - remove folio_add_new_anon_rmap() for !folio_test_anon()
   as currently large folios are always anon(refault).
 - add mTHP swpin refault counters

-v1:
  Link: https://lore.kernel.org/linux-mm/20240402073237.240995-1-21cnbao@gmail.com/

Differences with the original large folios swap-in series
 - collect r-o-b, acked;
 - rename swap_nr_free to swap_free_nr, according to Ryan;
 - limit the maximum kernel stack usage for swap_free_nr, Ryan;
 - add output argument in swap_pte_batch to expose if all entries are
   exclusive
 - many clean refinements, handle the corner case folio's virtual addr
   might not be naturally aligned

[1] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/
[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20240322114136.61386-1-21cnbao@gmail.com/

Barry Song (1):
  mm: swap_pte_batch: add an output argument to reture if all swap
    entries are exclusive
  mm: add per-order mTHP swpin_refault counter

Chuanhua Han (3):
  mm: swap: introduce swap_free_nr() for batched swap_free()
  mm: swap: make should_try_to_free_swap() support large-folio
  mm: swap: entirely map large folios found in swapcache

 include/linux/huge_mm.h |  1 +
 include/linux/swap.h    |  5 +++
 mm/huge_memory.c        |  2 ++
 mm/internal.h           |  9 +++++-
 mm/madvise.c            |  2 +-
 mm/memory.c             | 69 ++++++++++++++++++++++++++++++++---------
 mm/swapfile.c           | 51 ++++++++++++++++++++++++++++++
 7 files changed, 123 insertions(+), 16 deletions(-)

Appendix:

The following program can generate numerous instances where large folios
are hit in the swap cache if we enable 64KiB mTHP,

#echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled

#define DATA_SIZE (128UL * 1024)
#define PAGE_SIZE (4UL * 1024)
#define LARGE_FOLIO_SIZE (64UL * 1024)

static void *write_data(void *addr)
{
	unsigned long i;

	for (i = 0; i < DATA_SIZE; i += PAGE_SIZE)
		memset(addr + i, (char)i, PAGE_SIZE);
}

static void *read_data(void *addr)
{
	unsigned long i;

	for (i = 0; i < DATA_SIZE; i += PAGE_SIZE) {
		if (*((char *)addr + i) != (char)i) {
			perror("mismatched data");
			_exit(-1);
		}
	}
}

static void *pgout_data(void *addr)
{
	madvise(addr, DATA_SIZE, MADV_PAGEOUT);
}

int main(int argc, char **argv)
{
	for (int i = 0; i < 10000; i++) {
		pthread_t tid1, tid2;
		void *addr = mmap(NULL, DATA_SIZE * 2, PROT_READ | PROT_WRITE,
				MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
		unsigned long aligned_addr = ((unsigned long)addr + LARGE_FOLIO_SIZE) &
				~(LARGE_FOLIO_SIZE - 1);

		if (addr == MAP_FAILED) {
			perror("fail to malloc");
			return -1;
		}

		write_data(aligned_addr);

		if (pthread_create(&tid1, NULL, pgout_data, (void *)aligned_addr)) {
			perror("fail to pthread_create");
			return -1;
		}

		if (pthread_create(&tid2, NULL, read_data, (void *)aligned_addr)) {
			perror("fail to pthread_create");
			return -1;
		}

		pthread_join(tid1, NULL);
		pthread_join(tid2, NULL);
		munmap(addr, DATA_SIZE * 2);
	}

	return 0;
}

# cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/anon_swpout
932
# cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/anon_swpin_refault 
1488

-- 
2.34.1


