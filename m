Return-Path: <linux-kernel+bounces-90175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E7886FB6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0851F22B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206DE171AF;
	Mon,  4 Mar 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARZPDRI7"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519F134B7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540059; cv=none; b=BkLCy5bJ5609YgcTX1QuTkjFyyv7mJu06iRGGh/hqcmEGOFdpgTKGRQmlYUTAzDvZBMifUIqhoiLtAeRdsRkyvtAndoZniXKBn9APuokPMMLcSfP6FMe1UAqgqdsYRTp4LWW6vNH9e92UIsRV1Tu8M+y38f1iiHOATNRWeUu/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540059; c=relaxed/simple;
	bh=VntXjBDqjV2j8Y4q9f2AmUGXHE8nUbMrz87TVOIKuxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpbRMKl+GFA0yCpKk77OdSE2HOiCQcvrlfWQQjjCXaFw0XyCbcG5tOLbjX3P88aMlFh66a0RpR/2knkZJWwKbuOLAjBAwJlLLPqMO2xmVlXSS6dhIc6vA+x0mJ25JBIdjhAlAZsN3ORwIZmfvsI/iQs4D/1/wQLOl+eQ/tt8XUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARZPDRI7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so2429807b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709540057; x=1710144857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkZynPjlnCna4NEvK+MO2EuanxrrVGp4epakxir9YQY=;
        b=ARZPDRI7Xr0OJKvq8iiRHixRmwxmNaQbluLcQTqaXx1+DYgyxjSeQt5BUnHYom5jWQ
         EasdfUmVfzpvwQGnokfVv//gvfploIFOBK2k6OdaEgPugijKPwPT+S2rwwsomju0egGt
         M0BPpL/GJ48H2VpeFF4srA4UXNpBccFrpLfokCGnomp+o1SdXwbUXe9hKJPrYuWd6JGO
         L2EPFb9ObpjNNl/iND/Gpzvczl3XN1XeYe553MoENbdm6vkoedpoSJgif6UbWGhL/R+X
         E7gMflDJ6GAQSRDbFKy/asNNdoGFON0z1sUHZ+lhFeOeyf+7OQa0x0l+y9Xa5DbJH/H6
         Czfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540057; x=1710144857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkZynPjlnCna4NEvK+MO2EuanxrrVGp4epakxir9YQY=;
        b=tFcknLbC3UgE9sIIxKHl5P9dNjfwx9v8nopIB+v1P2vcS9ZOXvM7nhfKKe/GhaNlnZ
         3/fhNBwIj92tLczFa9Pzn0Afz8Sp6UM0ZEYqhUEycJI1NDXEL0sncwViAsuXl6CsVGxN
         Wc+Rk468bvDu7gRF6W9vJFSwQ8GrV3EirKyK4wKvuaZZIrYO4wCF8yCUyu4oPfVRlTFc
         qDm3Csz7nH5dQFbVa9Z+jsBFbqojQVBovnms/swLsZxT7AKEuT3ecbrRyWNHR4fnsuFX
         4BRyPbraqhH3u+vPTIiGnd6bP/qONF+Kn4nZkZdz6WkkH8eHMqAtfQYVOY9K9eB51ehE
         sp7A==
X-Forwarded-Encrypted: i=1; AJvYcCV2eo4w1gIOoJzxJBWV7e4ui6BDALLEHzcRPULTB+tHM4NDgpNrvAJ+Zs6IszXncveuLMj97ND1scf4nzs3Q524D5ndcleiW7yWjC+v
X-Gm-Message-State: AOJu0Yxr16Rdw+3oae4o+FB8MOoNS+0APhepuQxRWGc11QTSq8trAzJA
	9p13cD7JEL6HPe4ZZtUX01C/Tk4zHx/bkwnXU7g5o/P0yUqz0noP
X-Google-Smtp-Source: AGHT+IG7cMnkkwJP2OiNWJzW62ieySJWgdBup5i1dm2d6VMw4AtK13Ku5h9JCBXdgBkpNlIRG71qVQ==
X-Received: by 2002:a05:6a20:9143:b0:1a1:48df:d55c with SMTP id x3-20020a056a20914300b001a148dfd55cmr6499631pzc.0.1709540057031;
        Mon, 04 Mar 2024 00:14:17 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006e558a67374sm6686387pfb.0.2024.03.04.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:14:16 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: chengming.zhou@linux.dev,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [RFC PATCH v3 0/5] mm: support large folios swap-in
Date: Mon,  4 Mar 2024 21:13:43 +1300
Message-Id: <20240304081348.197341-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v3:
 * avoid over-writing err in __swap_duplicate_nr, pointed out by Yosry,
   thanks!
 * fix the issue folio is charged twice for do_swap_page, separating
   alloc_anon_folio and alloc_swap_folio as they have many differences
   now on
   * memcg charing
   * clearing allocated folio or not

-v2:
 https://lore.kernel.org/linux-mm/20240229003753.134193-1-21cnbao@gmail.com/
 * lots of code cleanup according to Chris's comments, thanks!
 * collect Chris's ack tags, thanks!
 * address David's comment on moving to use folio_add_new_anon_rmap
   for !folio_test_anon in do_swap_page, thanks!
 * remove the MADV_PAGEOUT patch from this series as Ryan will
   intergrate it into swap-out series
 * Apply Kairui's work of "mm/swap: fix race when skipping swapcache"
   on large folios swap-in as well
 * fixed corrupted data(zero-filled data) in two races: zswap and
   a part of entries are in swapcache while some others are not
   in by checking SWAP_HAS_CACHE while swapping in a large folio

-v1:
 https://lore.kernel.org/all/20240118111036.72641-1-21cnbao@gmail.com/#t

On an embedded system like Android, more than half of anon memory is actually
in swap devices such as zRAM. For example, while an app is switched to back-
ground, its most memory might be swapped-out.

Now we have mTHP features, unfortunately, if we don't support large folios
swap-in, once those large folios are swapped-out, we immediately lose the 
performance gain we can get through large folios and hardware optimization
such as CONT-PTE.

In theory, we don't need to rely on Ryan's swap out patchset[1]. That is to say,
before swap-out, if some memory were normal pages, but when swapping in, we
can also swap-in them as large folios. But this might require I/O happen at
some random places in swap devices. So we limit the large folios swap-in to
those areas which were large folios before swapping-out, aka, swaps are also
contiguous in swapdevice. On the other hand, in OPPO's product, we've deployed
anon large folios on millions of phones[2]. we enhanced zsmalloc and zRAM to
compress and decompress large folios as a whole, which help improve compression
ratio and decrease CPU consumption significantly. In zsmalloc and zRAM we can
save large objects whose original size are 64KiB for example (related patches
are coming). So it is also a good choice for us to support swap-in large
folios for those compressed large objects as a large folio can be decompressed
all together.

Note I am moving my previous "arm64: mm: swap: support THP_SWAP on hardware
with MTE" to this series as it might help review.

[1] [PATCH v3 0/4] Swap-out small-sized THP without splitting
https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/
[2] OnePlusOSS / android_kernel_oneplus_sm8550 
https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11

Barry Song (2):
  arm64: mm: swap: support THP_SWAP on hardware with MTE
  mm: swap: introduce swapcache_prepare_nr and swapcache_clear_nr for
    large folios swap-in

Chuanhua Han (3):
  mm: swap: introduce swap_nr_free() for batched swap_free()
  mm: swap: make should_try_to_free_swap() support large-folio
  mm: support large folios swapin as a whole

 arch/arm64/include/asm/pgtable.h |  19 +--
 arch/arm64/mm/mteswap.c          |  43 ++++++
 include/linux/huge_mm.h          |  12 --
 include/linux/pgtable.h          |   2 +-
 include/linux/swap.h             |   7 +
 mm/memory.c                      | 252 ++++++++++++++++++++++++++-----
 mm/page_io.c                     |   2 +-
 mm/swap.h                        |   1 +
 mm/swap_slots.c                  |   2 +-
 mm/swapfile.c                    | 153 +++++++++++++------
 10 files changed, 376 insertions(+), 117 deletions(-)

-- 
2.34.1


