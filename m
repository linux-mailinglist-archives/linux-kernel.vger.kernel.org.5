Return-Path: <linux-kernel+bounces-85925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A547C86BCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368BAB25351
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E8168AB;
	Thu, 29 Feb 2024 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTo4w3fv"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22C107B3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167104; cv=none; b=Cy9M4Un8BLM502htmchVmbep77Olxq57Tz/ZVm37CZ/uWfZRMxAIr4OwDy++WILTBIwICIODjYagtKjSpLdn7Vw7VjEP/U3wfewAUBmferbLlCKa4qhdctY9EbeqresFBH8q8w42r/0aKlEdR1SgivDTmoz0swi4QDPtjMNtHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167104; c=relaxed/simple;
	bh=XkZeZaotjRY9f/JW79nEwtvQRPftr9TtSxowRUjsPuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a5TA3MQ9aWDJuIv/B2WPVAGESZqRmnxjtRTLS1DGCyHt9nUKgBXzaphihksgteX0FBs6VGqCbAatZBSn3HV2/ISdkOFRT8Hl84c3ox8SbP6FmZ0vglt3FqrnhHoX4u5oiZ2vYFwkbRNhXNQozVydpBU8h7j0jovrwSHh+Dzoa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTo4w3fv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e558a67f70so317321b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167102; x=1709771902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLlvZgGlSRzongjxq0MK8434n2l98HY21vL9Cchmy+s=;
        b=iTo4w3fvxhc0897OPLWF+CraLaVgXtUWNXNTpsvpmr1DyNr9MmXYX51nlVIbxayIxh
         EuuHwUCZ/RbmTSjSM9YKmusLgeRLK67vRCtghh1Vwp72y4EpKIxRZbA9mxr1v35dXjs/
         7PX+CKttck+ogVFtzv+POETH4mLfVZw1U+x7tJlkjzKZHH5S9rcMzM69+fd9ZHmLp6yK
         f7F/uJv6uMchAc0fT2o3daFD8s4BYIidrMb3oLYo7xkn+OTu62ou32/uS1zp54o9hAMz
         hG7nUJKGp/JNcQ9jXTYzc8AMlqczeDCFXeKZAYQsUC0PzGI9TB5I6MbEGLQbzsq70mDu
         MEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167102; x=1709771902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLlvZgGlSRzongjxq0MK8434n2l98HY21vL9Cchmy+s=;
        b=hjG7wQgKA6qEWHachlAFCwW8QLrbBkqM5tlDtGWZxB3vaXVTtVsB/OqaMQ+IWF3iyj
         uCqbYryxMuU7ROQSYyh1y5X1GengzZdoveOgtjBMrmV5rT7efRPvUP8Q38tEaxZBGNH4
         b9J6/Zc5sbO/1DUGBgc1auREpQfrfNbmyO5ut5a6hPD6zD/HyAEevAEBQSMJn8EThMhr
         EWPJALugKWyfful6CyvUIcfrzRvpQHaytjsIYrTIEoRICsjUXwQdmIXA4VsaMHc/AjSB
         1qc7d7gH22I3Rr17Ar6zcpJBo5sXYUeAnLZoYye3BlW1+3g16i9z0qGwhAEXx8Fj1k2J
         j4uA==
X-Forwarded-Encrypted: i=1; AJvYcCWF6NHge2Bww9OU7T7jDCUPPYzrAcbwAsocO4VTwvKi6WuYBInWL4t3oSkd6QVjq/hFxfRMTnle8C2jYZoPwbTzAC0sc0Oh96b2ex6y
X-Gm-Message-State: AOJu0YzFhQr+foTn1rxyF5htb7Mu1trxXUnENWJko9PphhM3fpzcwM79
	XMaM1Mo9l2loUYC+B0Zb2bd2RM9JvQj5JkLMY/dNb7rTqqcZkELS
X-Google-Smtp-Source: AGHT+IEd9ZL6V0bBtXZY0UKUADZ6hFH+KIkxlAwsFnjMdxe4pljodJu/eu75SFY+Vu1uM5BOFc05gQ==
X-Received: by 2002:a05:6a21:394b:b0:19e:9da6:c73b with SMTP id ac11-20020a056a21394b00b0019e9da6c73bmr1382377pzc.8.1709167101626;
        Wed, 28 Feb 2024 16:38:21 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001d9641003cfsm62647pll.142.2024.02.28.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:38:21 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	chrisl@kernel.org
Cc: 21cnbao@gmail.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	kasong@tencent.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-arm-kernel@lists.infradead.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC v2 0/5] mm: support large folios swap-in
Date: Thu, 29 Feb 2024 13:37:48 +1300
Message-Id: <20240229003753.134193-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v2:
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
 arch/arm64/mm/mteswap.c          |  43 +++++++
 include/linux/huge_mm.h          |  12 --
 include/linux/pgtable.h          |   2 +-
 include/linux/swap.h             |   7 ++
 mm/memory.c                      | 193 +++++++++++++++++++++++++------
 mm/page_io.c                     |   2 +-
 mm/swap.h                        |   1 +
 mm/swap_slots.c                  |   2 +-
 mm/swapfile.c                    | 152 ++++++++++++++++--------
 10 files changed, 319 insertions(+), 114 deletions(-)

-- 
2.34.1


