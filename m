Return-Path: <linux-kernel+bounces-74328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD185D2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AB41C2285E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205403CF47;
	Wed, 21 Feb 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8G7u+B6"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32A3CF41
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505459; cv=none; b=tc0HPh5HutmxUyk70SVWr0+E+k6mAzfakoYbcV9Vnr1o9RDUPXGhc4Ugq9tKBljanVAZvQX25hGE/C/rCbdQlHydIVIlzanKVJdQf1lZcLw5n3lnzHaM4XshuZWvXBng3JAEBFHz8j+RpefC/O26L52BsrXSSQyNq1kzOLMGwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505459; c=relaxed/simple;
	bh=0n1ZvzUGNabidXwZWh8WQEAvS/G2YOd0iyyXcwE/sVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMTxoWnbnODywg2f+RG/Z/lxKSTBo2Z4VWqZW7ro4aYFstb7nO/Pn4MG8Qys5xGwoXn9XxBRn24BZhOOid34Uw92SzPr959pVAhC4xYC5O8UWAeYg5RIxQqammap+6MU11Bq0m4/R/fQ5M7kmNYqe6TBUHewN2AvNyIkYYHsEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8G7u+B6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e152c757a5so237572a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708505457; x=1709110257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDWnFuWwtAaGkWdbKqeZ52kl0lx5mRMgSrEjZRcEHMc=;
        b=K8G7u+B6gazx/yTFThEwiHXSkLUPv0Cx0ZXcudokfejIywU940kpzEyS7359+Fz4cy
         UthycS+gD7gEbcG41Zxw5NSCjzx9UYaL3Nc10/KXeXVf/BzWWHDLWrEF+x2+aUIZH2ju
         Shu/W+yWIaD6TCnnhNXJdjKPJ9fzmBVgjQkBEUev15Xyvpg4Bfo9ltPBVVMN70TAb0av
         YM5J95Q/l18D4/41u0Gi4OEKDlcWCEFoac24WM6pANPRjAreG4Id8KADnR0xcprwm/Cd
         QzzRRHc8KgItSXLFaA/nnuBQ6Z3HQ9o94X+pAtF/7EJvH+e/82/hh215pYb80pMK5htE
         1feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505457; x=1709110257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDWnFuWwtAaGkWdbKqeZ52kl0lx5mRMgSrEjZRcEHMc=;
        b=KE7NDI9Ul4gk+WwsXmc8uLZsEPx0i9+RgYyBsDog3vtnumx1FSMA3UCnHdtch3utDs
         YQj5ervM/4PXjEY4ro/XwO2+2Vwn9k5kElZfA6MrJybQm6ZNpiVhM+LNY4BkgyNXsvEo
         /EfXcZeXwVpUDcxscbDnHs11mIOojT4eWPOntv62oDsIzmCmRc72dJvfVaa8H5+DmSpB
         ws0oRr/+F3BfM35RQbf8z1Z2gX2E+Z78FpA6AsbisH64pkNrkYCPXCO5rkR/Vx9qjwbO
         I8SnPoeh3G7Ir0K3bgWQ6khlvF6rCLC7a+YPWubYK5vqEFVoII1kXfYLoC4EPHRqLQvU
         FyOA==
X-Gm-Message-State: AOJu0YyK1bgHgU+DFjJoBAXIo/8vqMlkikp0ezx81hrrEI1kuN3HDfdY
	dSGMrbUrxjkyW6EbGrLjd9qgig9X/j3KiJD8TYfvUzo+EMgpiKk1
X-Google-Smtp-Source: AGHT+IEtfwHJ2P/VzyLpHiPxWMWwHmaEnoEaIxoJZF/ZzNUugWmiHmu8f5bXFT18km945yC9oh+zaQ==
X-Received: by 2002:a05:6a21:8cc4:b0:1a0:5fb6:fc52 with SMTP id ta4-20020a056a218cc400b001a05fb6fc52mr21506181pzb.15.1708505457217;
        Wed, 21 Feb 2024 00:50:57 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e5f3:9cc7:f0fb:8762])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090aea9700b00298c633bd5fsm1121192pjz.30.2024.02.21.00.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:50:56 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Matthew Wilcox <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Vishal Moola <vishal.moola@gmail.com>,
	Yang Shi <shy828301@gmail.com>
Subject: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split while folio_estimated_sharers = 0
Date: Wed, 21 Feb 2024 21:50:36 +1300
Message-Id: <20240221085036.105621-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The purpose is stopping splitting large folios whose mapcount are 2 or
above. Folios whose estimated_shares = 0 should be still perfect and
even better candidates than estimated_shares = 1.

Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
the current code will split folios and reclaim them while madvise goes
on this folio; but if we unmap subpage 0, we will keep this folio and
break. This is weird.

For pmd-mapped large folios, we can still use "= 1" as the condition
as anyway we have the entire map for it. So this patch doesn't change
the condition for pmd-mapped large folios.
This also explains why we had been using "= 1" for both pmd-mapped and
pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
madvise_cold_or_pageout_pte_range() to use folios"), because in the
past, we used the mapcount of the specific subpage, since the subpage
had pte present, its mapcount wouldn't be 0.

The problem can be quite easily reproduced by writing a small program,
unmapping the first subpage of a pte-mapped large folio vs. unmapping
anyone other than the first subpage.

Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index cfa5e7288261..abde3edb04f0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_estimated_sharers(folio) != 1)
+			if (folio_estimated_sharers(folio) > 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
-- 
2.34.1


