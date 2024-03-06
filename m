Return-Path: <linux-kernel+bounces-93315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3292872DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CD5B2654F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643E1B809;
	Wed,  6 Mar 2024 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OUpbRatj"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131F18B1B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698586; cv=none; b=HPrB/6D1pdYtoIAsdlz/Ls6aFMCE94w865zYCX8mtHaz2wGXeUfW7BiROa6aMZ1UBsERL5H4LGmjDX57wgnwwvWGYK/4PB82ylLRumMc9lMhElcFjq81WGI03wAwqg7ts43Lnd9yETdMp7Ozf8pHTj3PAjaFRTfQuKkvzdruYTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698586; c=relaxed/simple;
	bh=zBUFSW2ukpPwCDWvU1V6atcSGQrwf113QJQX8bg/rvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Niua0cdCv6j26xIg18bd8SeAsiBVmAF2DIplrnX1OZ1dgHHK9mOqSTgljYrfH54kGOEQwz1ewr517/4sOZ0F6ca1l09ciZwvA9opUHEeRHk7j52fbT3DciLWMMv+nSk0/xKdYPQ6Fv3BO++nJt8bfbfVbl0fa0AQVso/mLkTNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OUpbRatj; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-788254c16ceso29427385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698584; x=1710303384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m+XHRukptduyyFcyZXFpaIgdTql7GFreCc0MXKSlXc=;
        b=OUpbRatjD3Tv+0IiT/9aXWHlvWfUk5w69dDq73EIgNVXdPxzLBu/YgST1vjT/qRoDj
         70Iv5r5/qDA9v00xALBgElWE3vM1cxjyzdRhRot/DgAXpUQKVKZSRSW9l2ehKpF8ttt3
         N/h8V4lWNrVxICrUO7yN3qVDkVQQw4rch+XDeQd99pEZsUll7EmBxuL6F+Uo6z3TMkzm
         HB6cXrTWO2IjmgMwM3tqRXIevzXRejJF6bi+61N0SBOXenKPQf3niuEQVK8BdukyGy9z
         KS4itD/M7r9sWs8BTo3VcDbZdh0r5T2d3MRvthSkSi5jVJWr4+WIta8jH1kxFrehDEfo
         7O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698584; x=1710303384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m+XHRukptduyyFcyZXFpaIgdTql7GFreCc0MXKSlXc=;
        b=rMV68JZaltu6/FKG9vtwn8joyDa4LR7oXJTTi7TWuGNDkESxiRhrCbms+qLsHyCqdn
         fOoAgqMyXZw/gO4O5QJ/NDRaOWIrjom0RIcTPvz+AggbNBZI6oIQwADrrNtGlISbVezm
         +4P6RnsjQv9aeHZvwUjj30SzPNfw5R46Z6JM7d6QtpCtkm3B4YQnfZ8UCd17BHvjSHXS
         aRegJ84jePor5H578t/LV0QD9DALFvRP7R7emSar3ck47baMVeC6aHP+bXjEYc+IdxAs
         arptXsH8cy7RX6Z4GmIjTgysTJ6ukOZ01pdqID4Ds2+rVjpcIkS9Qe5FMUCk1Xjo74aa
         0Y4g==
X-Forwarded-Encrypted: i=1; AJvYcCVjmhr5+ai8hnT4I23Rr/ZJD/LIC6WUy3ZJ9y30841Zi7YBZnr6le2BpMPi/b88mJRkUCNxThvvZecyxMgqVFNhtgGOAeJ7I+id4t+i
X-Gm-Message-State: AOJu0YzFj0IqSoBGIMktUjAgl6Bozm2ylP9DYyAmzxkkx9GdL4SAf0kV
	Dn9QFzOmppClOF1GAYs4SKTIqJqOuhUOK3DSKgjJxEuWe/puRWvUbwLOV7VD+NI=
X-Google-Smtp-Source: AGHT+IEXUAmf9zcOiQ21viaXa9n/2vz9wsETICwKDGogRNNcrHNmI77n49+NVvK4GXUrVLm+lFphsA==
X-Received: by 2002:a05:620a:1272:b0:787:ed4f:a091 with SMTP id b18-20020a05620a127200b00787ed4fa091mr3769084qkl.72.1709698583788;
        Tue, 05 Mar 2024 20:16:23 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id e14-20020a05620a208e00b00788323a0c14sm1716137qka.39.2024.03.05.20.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:22 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] mm: page_alloc: fix up block types when merging compatible blocks
Date: Tue,  5 Mar 2024 23:08:34 -0500
Message-ID: <20240306041526.892167-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306041526.892167-1-hannes@cmpxchg.org>
References: <20240306041526.892167-1-hannes@cmpxchg.org>
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
index 88f4e08726ee..3f9ea4c392d5 100644
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


