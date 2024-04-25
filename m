Return-Path: <linux-kernel+bounces-158217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95AC8B1D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A18286D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A282860;
	Thu, 25 Apr 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNYLgnAE"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E18005B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035080; cv=none; b=jCCdzqX2Ol8T+Rq0VwpnUQhCXk5rFOyzoftp9W16XuDmawngpY/wU5A6tDGO2Tc6CmccwBIkUulpcGM6OreOh8bv2Vfgd3nl6BqtVRwKKYnJzsa5nYq/h09kBka/OllcMq1xqo4U5BU5GMHN6NJrVqFHYvVj+udc0NkIx9G1ySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035080; c=relaxed/simple;
	bh=Xdket+Zp5Bk9sCxRhK7vg441aA/Gtyn3e8E68FzlA6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkmZwlpFihGPe8gSQUzkJdda3YNzCyAqalF1SyqGk1TBYhU6uyH8JiNS8dlS46x6kXiXI9G5zfTZOSRqVhYQScxUO4709H6hCEiB/RahUNXVuArfXcqSysZImErLDM4HeUiDppG2H7wSBHxTSc8512Hi4aJHPHr1T8KUvQQuiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNYLgnAE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so776180b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714035078; x=1714639878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl8rW2P7HEl/Ypq+RoNZ5toKYl3n27Whut7rMt4auOQ=;
        b=PNYLgnAEpXuWxFkQkEj9dDVC7cxFLbOhWlRlkAfE4kkb10daTQIDi5wtRFkr1wrP0W
         BtJcuQj9WjP0+lMZDCny+gHQGSQNl8McTzF9NukzNtoFohSG1wx7w5lk7yCf0VUbCICg
         UpFBKNCvE6ZW1G9TiLOEqM4/jFPtxqRYoLBrdX+KBTvNWz97ww3x6XOd1zdxLC7ID+X2
         OHU8oporxn+aZg1ZYjX5F5BDGkhVgEP8QCGiHvtv/IWmK9hg+MGGnQ+OQR7AZv3xtcDE
         MvhzdfjLsFvsztA0tkzEIHI78IyVJcPoNFU8xLTx9vuwphud+ISOa26ZVla8dk/+M81o
         6PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035078; x=1714639878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vl8rW2P7HEl/Ypq+RoNZ5toKYl3n27Whut7rMt4auOQ=;
        b=suAhglZSZPlrI/YTY3LbM4GMe3MtJBUiFADd4zm6UllM4DU6B4cZmV2tCMpK18gqtg
         zHvdabjbAxbtfw+oFtumLJARcXISaB/wGTnm9WIjy7Oepcd/CYYCJOtRz4Nm3Bfd9fBx
         5S55Jv4g4XIjAV+GWk0PxF9jDa+UsfY0fswUWpS/GeD6eoHz9tNy5rg/v7kVlS/vGLK5
         9EOde1vNGPEzpOpBvUltYLV4aSfO9gx8H3ZewOXcNXCkGCmGI+JjGlPdCatU4lHK/nH2
         N/zrtFrKn74zhRJuw4xSraHULSBaaIKwdCPftP+j3COMtmurC7GBS4djFpSQHrEdnnd3
         XbKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZVLj6aeKbNG2W86I0tPowwT0WhIS7Nei3OrgXZjcwyNrAluzxvZroa8vwrk7K71HUHVqHkoBee7uK/iTelp35hcNbhF9f39Yk47d
X-Gm-Message-State: AOJu0YysA5hl+c6v8Km/GQlCJL2KjRbQVrx2tWFim9NgkFnifWTcd6mu
	Nxq0kFNUQjGpDK1xjz/9u3NNaClURGDS2vKLOHHemB8I/K2CTB//
X-Google-Smtp-Source: AGHT+IHDX6sdZrvZkxaCoo0VmJnhVORLaihIWpzeuSV1kWLK87UQ5GYEwi9sToqIQkLdlYAJLx62xg==
X-Received: by 2002:a05:6a20:12c6:b0:1ac:3b5d:94b3 with SMTP id v6-20020a056a2012c600b001ac3b5d94b3mr5794669pzg.2.1714035077796;
        Thu, 25 Apr 2024 01:51:17 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.240.252])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b006ed045e3a70sm12676544pfh.25.2024.04.25.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 01:51:17 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: david@redhat.com,
	ziy@nvidia.com
Cc: ioworker0@gmail.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	fengwei.yin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maskray@google.com,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiehuan09@gmail.com,
	zokeefe@google.com
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
Date: Thu, 25 Apr 2024 16:50:51 +0800
Message-Id: <20240425085051.74889-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CAK1f24nb6FkipH3OZa0uwbBWkefS3f2BrJ_GTxkS2j6+6bgODQ@mail.gmail.com>
References: <CAK1f24nb6FkipH3OZa0uwbBWkefS3f2BrJ_GTxkS2j6+6bgODQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey Zi, David,

How about this change(diff against mm-unstable) as follows?

I'd like to add __try_to_unmap_huge_pmd() as a new internal function
specifically for unmapping PMD-mapped folios. If, for any reason, we cannot
unmap the folio, then we'll still split it as previously done.

Currently, __try_to_unmap_huge_pmd() only handles lazyfree THPs, but it
can be extended to support other large folios that are PMD-mapped in the
future if needed.

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 670218f762c8..0f906dc6d280 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -100,8 +100,6 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
-	TTU_LAZYFREE_THP	= 0x100, /* avoid splitting PMD-mapped THPs
-					  * that are marked as lazyfree. */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/rmap.c b/mm/rmap.c
index a7913a454028..879c8923abfc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1606,6 +1606,19 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+static bool __try_to_unmap_huge_pmd(struct vm_area_struct *vma,
+				    unsigned long addr, struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
+		return discard_trans_pmd(vma, addr, folio);
+#endif
+
+	return false;
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
@@ -1631,14 +1644,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	if (flags & TTU_SYNC)
 		pvmw.flags = PVMW_SYNC;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (flags & TTU_LAZYFREE_THP)
-		if (discard_trans_pmd(vma, address, folio))
+	if (flags & TTU_SPLIT_HUGE_PMD) {
+		if (__try_to_unmap_huge_pmd(vma, address, folio))
 			return true;
-#endif
-
-	if (flags & TTU_SPLIT_HUGE_PMD)
 		split_huge_pmd_address(vma, address, false, folio);
+	}
 
 	/*
 	 * For THP, we have to assume the worse case ie pmd for invalidation.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e2686cc0c037..49bd94423961 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1277,13 +1277,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			if (folio_test_anon(folio) && !was_swapbacked &&
-			    (flags & TTU_SPLIT_HUGE_PMD))
-				flags |= TTU_LAZYFREE_THP;
-#endif
-
 			/*
 			 * Without TTU_SYNC, try_to_unmap will only begin to
 			 * hold PTL from the first present PTE within a large
-- 

Thanks,
Lance

