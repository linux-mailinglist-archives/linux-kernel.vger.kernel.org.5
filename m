Return-Path: <linux-kernel+bounces-75996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7485F1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC11C21137
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7650175A4;
	Thu, 22 Feb 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6012gkX"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96739A47
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585573; cv=none; b=FA7L53hyJ0B3H//7L7PdIqBULDcC0MrCXNa1wwVwc+YqXTYInpod4zcREhrljvl3tDvGcu3Qa23OpHHgjyMGJcvUT6lfo167Us6qu0hEtNT9F6fwfmj1mkg+zBPqRgjGAAyPPtR7yl2Ttldgp3Q0O9Y5J6W8/Hz8pDquBpiIDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585573; c=relaxed/simple;
	bh=Z+ioG0dAMOZqqxiXb5T6jqRujavhY9OroCg9orrCmvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjEBYudtS/lqMhXJJC7BCOoDu0RFIjjK1gdnvfwLQHToYtwq/EzuF9e9St5f87NbVQISZzZspwxq11GtZY6jjb4KwTS/aiVbiAJZ5yveeY4LobqOO5gpDVAi4+xGq/Gi1IU4Z5bqnenEIOKfpjK0ypq8/VxPO3zXK+e/hQYapy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6012gkX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4841ce028so1671417b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708585571; x=1709190371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fMxEDgPT+z3oBkdlnlH/S4iCM52MKDAW+qyjbAs634=;
        b=a6012gkXIW8GsQwpH1qQf5MKynSHIxyhA6eCF/vFtST7h9WX5RG+oguqgNcsUJp+CW
         5PWkAtOGWOhn6uEyFSx4VcXyjUTN3W97yL5np99D1yaCZr6fGlmhhiUBy0V6caCV1PPc
         DD+9QUwyVaUHgCLloxgfMt9sSUfIk4YSPxCipTzUFXAkgiu2SA8pGd9AL+M1cDbaD5VN
         3ww5URCAWRwvHD/ZgMgmHiC4niaQNC3T0FclJ/5Oav9G3xetZDwhezVBgA1guL6lnIt7
         tFwg9DNz3okastDeA3jpA3n4mXYNAYyP5IJ+IFBwprDWieZiJeYkv4AtuloYrRSvNm63
         5t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708585571; x=1709190371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fMxEDgPT+z3oBkdlnlH/S4iCM52MKDAW+qyjbAs634=;
        b=Nxtbl02nx+EBvaB80XCJR/VGbOh6h604jS4+PSpl8pSTQmIem9v+rJA0tjaNSSZnh4
         uBVLyTHfDpf5Xu5NNskW7pq9uGV5KaPuARLsKtepPbvM5uz0y+S4fu4iB7ghGVpcaGgd
         /tN+U9EKOZEKDp9epvUd3lf6y1eaNB6PaEz2BMPGLNZ5by5V8Zxv9psT60QfEcicriQ+
         LybDI/Iwt2jIoUvItkMp4Qm0SbmLdYiqhrysTiCIfcIKPVlSidMfGT97fuh7Xjp9J8Ny
         WDrue8SQkgqtERnwyj+OgA1bOvDeda9EUzVwwAABdJiWJKQCteNSHxaB06YeblAYmvzt
         clMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAiApqPgxYtgJhwGTWeOwe+pctjx2HVauFO8Pr3P2nIIb6nZbeLehQji6skoEaHWCCVswZVth38a2BLjSVobHHzFzyzXnLBwGHrFXk
X-Gm-Message-State: AOJu0Ywyp32qoys//g9cA/tJ4q4ShrRUaIy8195jJYdmhEUke3b5O7Lp
	HQWR9HMVp316qO/GwDKtME0HbqZIvTijk9hwBUVJOOZlezQ9T8RDIoKEsPBrDB4=
X-Google-Smtp-Source: AGHT+IG01dDiXX1Dq81Ds0/UD7TrLTcLrtamL+EgoDkgHNBzW6Vc9DaxNlpkcys8wR1K21v/KWzUOw==
X-Received: by 2002:a05:6a20:d705:b0:1a0:d103:7030 with SMTP id iz5-20020a056a20d70500b001a0d1037030mr2210773pzb.32.1708585570690;
        Wed, 21 Feb 2024 23:06:10 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:3b18:a2e2:f00b:c965])
        by smtp.gmail.com with ESMTPSA id ga16-20020a17090b039000b00299101c1341sm11023857pjb.18.2024.02.21.23.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 23:06:10 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	chrisl@kernel.org,
	surenb@google.com,
	hanchuanhua@oppo.com
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
Date: Thu, 22 Feb 2024 20:05:44 +1300
Message-Id: <20240222070544.133673-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025144546.577640-5-ryan.roberts@arm.com>
References: <20231025144546.577640-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ryan,

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2cc0cb41fb32..ea19710aa4cd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  					if (!can_split_folio(folio, NULL))
>  						goto activate_locked;
>  					/*
> -					 * Split folios without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> +					 * Split PMD-mappable folios without a
> +					 * PMD map right away. Chances are some
> +					 * or all of the tail pages can be freed
> +					 * without IO.
>  					 */
> -					if (!folio_entire_mapcount(folio) &&
> +					if (folio_test_pmd_mappable(folio) &&
> +					    !folio_entire_mapcount(folio) &&
>  					    split_folio_to_list(folio,
>  								folio_list))
>  						goto activate_locked;

I ran a test to investigate what would happen while reclaiming a partially
unmapped large folio. for example, for 64KiB large folios, MADV_DONTNEED
4KB~64KB, and keep the first subpage 0~4KiB.
 
My test wants to address my three concerns,
a. whether we will have leak on swap slots
b. whether we will have redundant I/O
c. whether we will cause races on swapcache

what i have done is printing folio->_nr_pages_mapped and dumping 16 swap_map[]
at some specific stage
1. just after add_to_swap   (swap slots are allocated)
2. before and after try_to_unmap   (ptes are set to swap_entry)
3. before and after pageout (also add printk in zram driver to dump all I/O write)
4. before and after remove_mapping

The below is the dumped info for a particular large folio,

1. after add_to_swap
[   27.267357] vmscan: After add_to_swap shrink_folio_list 1947 mapnr:1
[   27.267650] vmscan: offset:101b0 swp_map 40-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40

as you can see,
_nr_pages_mapped is 1 and all 16 swap_map are SWAP_HAS_CACHE (0x40)


2. before and after try_to_unmap
[   27.268067] vmscan: before try to unmap shrink_folio_list 1991 mapnr:1
[   27.268372] try_to_unmap_one address:ffff731f0000 pte:e8000103cd0b43 pte_p:ffff0000c36a8f80
[   27.268854] vmscan: after try to unmap shrink_folio_list 1997 mapnr:0
[   27.269180] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40

as you can see, one pte is set to swp_entry, and _nr_pages_mapped becomes
0 from 1. The 1st swp_map becomes 0x41, SWAP_HAS_CACHE + 1

3. before and after pageout
[   27.269602] vmscan: before pageout shrink_folio_list 2065 mapnr:0
[   27.269880] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
[   27.270691] zram: zram_write_page page:fffffc00030f3400 index:101b0
[   27.271061] zram: zram_write_page page:fffffc00030f3440 index:101b1
[   27.271416] zram: zram_write_page page:fffffc00030f3480 index:101b2
[   27.271751] zram: zram_write_page page:fffffc00030f34c0 index:101b3
[   27.272046] zram: zram_write_page page:fffffc00030f3500 index:101b4
[   27.272384] zram: zram_write_page page:fffffc00030f3540 index:101b5
[   27.272746] zram: zram_write_page page:fffffc00030f3580 index:101b6
[   27.273042] zram: zram_write_page page:fffffc00030f35c0 index:101b7
[   27.273339] zram: zram_write_page page:fffffc00030f3600 index:101b8
[   27.273676] zram: zram_write_page page:fffffc00030f3640 index:101b9
[   27.274044] zram: zram_write_page page:fffffc00030f3680 index:101ba
[   27.274554] zram: zram_write_page page:fffffc00030f36c0 index:101bb
[   27.274870] zram: zram_write_page page:fffffc00030f3700 index:101bc
[   27.275166] zram: zram_write_page page:fffffc00030f3740 index:101bd
[   27.275463] zram: zram_write_page page:fffffc00030f3780 index:101be
[   27.275760] zram: zram_write_page page:fffffc00030f37c0 index:101bf
[   27.276102] vmscan: after pageout and before needs_release shrink_folio_list 2124 mapnr:0

as you can see, obviously, we have done redundant I/O - 16 zram_write_page though
4~64KiB has been zap_pte_range before, we still write them to zRAM.

4. before and after remove_mapping
[   27.276428] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
[   27.277485] vmscan: after remove_mapping shrink_folio_list 2169 mapnr:0 offset:0
[   27.277802] vmscan: offset:101b0 01-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00

as you can see, swp_map 1-15 becomes 0 and only the first swp_map is 1.
all SWAP_HAS_CACHE has been removed. This is perfect and there is no swap
slot leak at all!

Thus, only two concerns are left for me,
1. as we don't split anyway, we have done 15 unnecessary I/O if a large folio
is partially unmapped.
2. large folio is added as a whole as a swapcache covering the range whose
part has been zapped. I am not quite sure if this will cause some problems
while some concurrent do_anon_page, swapin and swapout occurs between 3 and
4 on zapped subpage1~subpage15. still struggling.. my brain is exploding... 

To me, it seems safer to split or do some other similar optimization if we find a
large folio has partial map and unmap.

Thanks
Barry

