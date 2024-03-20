Return-Path: <linux-kernel+bounces-109277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5D881719
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D78281758
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556C96CDC7;
	Wed, 20 Mar 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pq/eelzv"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896226A8DD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957898; cv=none; b=qK3ERD1ElIp23zRRw1ssSWO0LDn6WSDRpjdBqnRWC4bTHX9AiINjU0Im5p1DmbEaMnr5V1FRO8t7o+rHM9GKfebLi/OLMWOkeWemal3Pp0ZSxyGMh9elUn0l6rgfe/sG6JRIaeSm5d5+RWM+MUWykhG1bZYujHUFOPZT3uhAw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957898; c=relaxed/simple;
	bh=bDLy9d7U903B92nDMy/OaOfaoSVQM75tRwno6iRYYME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grq4vafgRs1q6cNh/cfRcR3Yhxn3ZLm1YrLSxhoAnRpK0tjhXeZTkdCXzwz6obBgZhyYDYTznuGwCtxBsoad33Yt0cjtwQcZAcwrm4oXZ4TIm8gI3+GOMytGvaJFrEG+uGmcqk8FneYfFpun7J7ijM3ha6dHWMrOWsUsL0ok0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pq/eelzv; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbc649c275so119102b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957895; x=1711562695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7r0X9mNHsEvKFNd3QjZ02+rYxlZ2ijHgMC19/7k7mQ=;
        b=pq/eelzvJZi1mGXcbvg1/6OXf2KA6x9X9t4Fu8lNkZGJBzzQ+Rz7zaHE0OQyWLxjTs
         NXByTyutYEhIVMgIAgEJXza+fxC/yOgAzCCyC0XzUKxqd8E72ow4w3UdJRi7jxftBHQL
         bOM0Uy7brnRNO3UjV7upzoUfVtX/ONchy1Z86nhtHDVqfpZygaRrHfm7pZ15QRKNLf/X
         fM0Sglw5wiDe4M8xok6mCGrPqpwOT8PkXendP/W+kGArt0bIcRJOYUxwkC7Nmwt0mN7r
         6VH/NT4F7gsCrFltEx4FaLd4xLXun3lCPF+ZTExU/TqSpYkwTWXnFYMR6Gaz8xWkgCCl
         7gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957895; x=1711562695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7r0X9mNHsEvKFNd3QjZ02+rYxlZ2ijHgMC19/7k7mQ=;
        b=T50klSvA3NjDvGbCJ7ebn6gG8Au1rsabGwZssXTA/oDAgv+FylR4sZnRHhnWhFqsy5
         WZ6m/DTTIN+xdckjPymoR7K7SCppOfbh5nxIkDTl4Gs5Gw5Aezcy3zpwfH/AwvyFEOIx
         SIvaiCLpAGvFqGEj6fpfLFrLtQN86bbIS4wSH9x3VSVWjGCV73epTaKEle3RMXU1f41a
         Ie5V1ipI4INidsGIUAjsafdaNwrh7BWtNkpGNuAL3I2Of7M14dZKz/OMdZOfx/gmH98f
         glNVYvD40UbcCPQ05HuwqW7rs/ss1dF+RCDEB4HIA510O6c6nVXShr3C/wT7+XeSrhJs
         Z9YA==
X-Forwarded-Encrypted: i=1; AJvYcCXP5+ONy05w7lNiq5XXF6lulepQsGgsqCF6LAYUBGRMVh5c6Xxgnc05iELTnHY/rcQKGEhtsvGHl78xMalvSas6gGaEMorS1CCKUBem
X-Gm-Message-State: AOJu0YylhIWs5lSX064waHt84Qa0mwUZB8B6oBe4fYKcu8yhaL4rB9rH
	TF/GiMJvI2K2auL1DMM9nDzDGHnXknBLJj7zalQtbodxvL4gfGBLC3Ckre7UxOk=
X-Google-Smtp-Source: AGHT+IEjrZQWghTRcTpqpNffkDCKSOVahuvg3qnwvR8ayQXYPdrYk9RXL0q0Eb9YG2QM0kUquwP9xQ==
X-Received: by 2002:a05:6808:130d:b0:3c3:8339:6ef6 with SMTP id y13-20020a056808130d00b003c383396ef6mr3008346oiv.45.1710957895377;
        Wed, 20 Mar 2024 11:04:55 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id fg14-20020a05622a580e00b00430bddc75a5sm5411969qtb.23.2024.03.20.11.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:04:55 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] mm: page_alloc: fix up block types when merging compatible blocks
Date: Wed, 20 Mar 2024 14:02:08 -0400
Message-ID: <20240320180429.678181-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buddy allocator coalesces compatible blocks during freeing, but it
doesn't update the types of the subblocks to match. When an allocation
later breaks the chunk down again, its pieces will be put on freelists
of the wrong type. This encourages incompatible page mixing (ask for
one type, get another), and thus long-term fragmentation.

Update the subblocks when merging a larger chunk, such that a later
expand() will maintain freelist type hygiene.

v2:
- remove spurious change_pageblock_range() move (Zi Yan)

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 994e4f790e92..4529893d9f04 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -785,10 +785,17 @@ static inline void __free_one_page(struct page *page,
 			 */
 			int buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
 
-			if (migratetype != buddy_mt
-					&& (!migratetype_is_mergeable(migratetype) ||
-						!migratetype_is_mergeable(buddy_mt)))
-				goto done_merging;
+			if (migratetype != buddy_mt) {
+				if (!migratetype_is_mergeable(migratetype) ||
+				    !migratetype_is_mergeable(buddy_mt))
+					goto done_merging;
+				/*
+				 * Match buddy type. This ensures that
+				 * an expand() down the line puts the
+				 * sub-blocks on the right freelists.
+				 */
+				set_pageblock_migratetype(buddy, migratetype);
+			}
 		}
 
 		/*
-- 
2.44.0


