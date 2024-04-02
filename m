Return-Path: <linux-kernel+bounces-127957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE58953AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2169F1F22FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3DB83CD7;
	Tue,  2 Apr 2024 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGrRLnoe"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7A7A151
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061640; cv=none; b=ireG5yApPP/9tcwQQHk0iD5g+OcwFkEsacKuzGaBoNJ4h1mLx/PPMqzn4aSwf+RheSsdsFaDeyH2SENJ1PZnkvW3FBRlUxywG6z+SvY/wQ1yJomHKhZ/O4NOnxuMy5o7rs1HnRqOnM6adtOygEnQIwDpnf+luX5npsvqss9bhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061640; c=relaxed/simple;
	bh=0sNWHurwOJVBB17CbVkKuAQNe0MujrT3G7k4D7DMbc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFCIQdZ09/vcZ7u4G6SZ82+qxwJwHsoT3jMPKHjsja8klJQ+O8lsTrrjacONS4qfC2KLUQE5ivRs3uPQ8rLaI7sJNp7hsAJGAYfVqQqXA/obuzf6k5PPkN/FNHfvVVxdSHhepT6zil60CGW8LP/qh7APh6MOCX4fkriWQ0X/neE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGrRLnoe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4748762b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061638; x=1712666438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5G6GpIHkbgDMvuomt94iyreeKkPmpGXaASUVbfOhgI=;
        b=DGrRLnoedesg/fj/mgoJezjEbgGnj/i0G5yiOkzbmVUaRxyygnSr7IEkQMBD5fFU15
         pfSoMwkSre/hnKGyiEkzw6n39apNdohNBWEDo6UUSxH8HJegY5+sa37QlAF2J41nVqLg
         SpmQJwWpJUKPtVRH2VpAYVc4AQVLOVEIpLGbl6gFBtBDNOP7a5Ofp9jM5AJ2cYRmOX8i
         UHL2OxQrPOBNBTxLSVVDLrBbJ27ei+r7qbvIbTjw5RFXHVv3RBkXHCtJu3SnsI/bmoMB
         L71hsKBDzsj+zRrjHoD7ustonlEhwv6Fl7NFDGThr1yZ2YfwRAIEkM3KwrU+Pwa8A4CD
         XvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061638; x=1712666438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5G6GpIHkbgDMvuomt94iyreeKkPmpGXaASUVbfOhgI=;
        b=ZE8gmzGGji/S1bPsvfKR+sQ/aLFu0gEx/0X4ATUE4TUmYfxXzvrHj8flVCYjALVcfa
         7ig3PEXB771f3CB6gRwKQngNQU6mEnLWyE9OppE8q/od1nbEItz9UY8FsRwcHZQtpNYb
         +ivVJXvNdd7637dobevY71/Ip96Q83Rs3NvHzCWgSkVnDvN1sFOgFrw5HmyjGLwJc5vL
         LKUzXnBNOZl8wmWlrnbfi/ImaG/SCxnpLMNvUK4wQTtnNfCoZ+HPI4PCGKxy9Jzt2kzz
         mpEzS5RK6bq+S6jBqwovmK7qLGqP1yfg2k/d543njvHKD+4Jq7V5+hbfFc9HDauuQv/N
         XFNA==
X-Forwarded-Encrypted: i=1; AJvYcCW5rKcwzhBMRQM2NFzBfZaZ2tWpEGeXCQpLpWl0G2+7tO9f1lndOB7vu4yidN2OwVgOyxper7vdF1xlmkeSeaxebbbNcI5P1KtNRati
X-Gm-Message-State: AOJu0Yyx+j9X4epBv9U4XrsbaIk67k4fdF4/IaoQwixKB+Tb+HIbq9VD
	aYI3gxBQjERKygTUKv2qFz2ZdRJN6P46fLjg7R3zw561KlGBB0P1
X-Google-Smtp-Source: AGHT+IFU6JVlTIGq308kE/gMP4m+lWmDGW6KTg9wTf197WtftPYl4LndEzB7/UfG2/2McnwmBsYTvQ==
X-Received: by 2002:a05:6a20:3947:b0:1a5:698e:505c with SMTP id r7-20020a056a20394700b001a5698e505cmr11809339pzg.10.1712061638605;
        Tue, 02 Apr 2024 05:40:38 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.9])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b006e664031f10sm9708232pfn.51.2024.04.02.05.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:40:38 -0700 (PDT)
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
Subject: [PATCH v4 0/2] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Tue,  2 Apr 2024 20:40:27 +0800
Message-Id: <20240402124029.47846-1-ioworker0@gmail.com>
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
This patchset applies against mm-unstable (d4cd6840d1dc). 

The performance numbers are from v2. I did a quick benchmark run of v4 and
nothing significantly changed.

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

Thanks,
Lance

Lance Yang (2):
 mm/madvise: introduce mkold_clean_ptes() batch helper
 mm/madvise: optimize lazyfreeing with mTHP in madvise_free

 arch/arm64/include/asm/pgtable.h |  36 +++++++++++++++++
 arch/arm64/mm/contpte.c          |  10 +++++
 include/linux/pgtable.h          |  30 ++++++++++++++
 mm/internal.h                    |  12 +++++-
 mm/madvise.c                     | 147 ++++++++++++++++++++++++++++++++++++--
 mm/memory.c                      |   4 +-
 6 files changed, 164 insertions(+), 75 deletions(-)

-- 
2.33.1


