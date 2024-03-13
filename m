Return-Path: <linux-kernel+bounces-102552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C455587B3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8000E2883A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCC59168;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqNvRhhE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951855E6E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366448; cv=none; b=GW8CGwPT0ufzbOghzGCSrLACH485QFTe8xvYI4z7LXkz/vaQzy5h4/oQN91Ix2LvghtBFjTUg6yUoa8B1dzIFO6OuvKIxcRLJZePlKC3mxIhvmtXVIW3VBJCRZq00BbFDHkDJF2smim8rwRVUzHTqGEVxZRjEKHgg9lNcjWJ714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366448; c=relaxed/simple;
	bh=0Lswo5GE77ATHQ8L+dlMWa1yM2evkibSoyq3AnC70nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQCjabtMzsRtSMqXaLwXjAaRb+9lBNcI1XeM9AmaHsLudE82lzV8BpFFcR2s09VZawPTyK/oph4gGICO1UBupKClAJKcUoLEqt92eGriew3RXItbt/osSMConl000qTL9YtDafrELAI7wjzWgsYGWUjDllCm18hU758JgxoqHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqNvRhhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8evz9V3UX8qsNtRrNT6H/1m1GM34KP8FDwkI2vjQ2A=;
	b=fqNvRhhErD7r4aqpHDkLwaMtGa2Y+PGhRbj7cxmqWyP5AaL0cnZ3v6xyAVUxZec+OOCRbS
	tEG7pM1v6TStprIv5bcwOLL4jbqilmmWPXhQ1MZbbJ/TU1D9IXmyf7eEwqlYrX3ZWo+Jeb
	VT6FtXhUNgalPxnZt8aYCCZkvS1dNXE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-7VI_ZlahNv-QGl5EFM21og-1; Wed, 13 Mar 2024 17:47:24 -0400
X-MC-Unique: 7VI_ZlahNv-QGl5EFM21og-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69120b349c9so1131486d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366443; x=1710971243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8evz9V3UX8qsNtRrNT6H/1m1GM34KP8FDwkI2vjQ2A=;
        b=PhbG0MDSBPO2PxJNfoRtM2cOUA1I0/YNVOFNl99njLs3SyQL8zbZ3JWJjAZDLFPocq
         7YImctAwekmIa7aM4jvoxv5KsREpuadEKQ2J8BTwd6RjheX9aI+LL7D5Z21JnI4bQ/ZV
         fEns28wYYzFOtPjTv9vhQ/Owsfl75jnFU7WLrsiKRpy9iJiiRXq60XEiNNDuRpkG1TkB
         2cu/NyPhMgP0M1fOEO4a31/WFPXzM8Bu17yf3WW+lISKw8PzRWKmcWNrZIked8VlGFAc
         OzZEWXe4IkH6ae7M2o308U/F8wFRlsM/f/kDkEI2WMxLWLGIjNyzahM6c2DhqHW6y+jW
         QYAw==
X-Gm-Message-State: AOJu0Yzf9ukEa+YvRJbKOP62SckGFQ9C7fDhNXYRWalOxDDeVmZNcAOm
	fbCTTDA+0UYSfycl2aFg7W+GV+AOo3xtDdh1BHebBQ1frDUR0R2FUuHiT2+Vccb8zATPbz9irUs
	vzGWdsO7c0YleMylBjLM4aWRTEsbLCW1Pro9jeo75vdmQhs8rpN8gRje31OL3oj+YP7jhfg5uaW
	1x3GQkzF+RdCSv1Uzarv0AupAaQC+tvsf8s2seodjCmZg=
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id dc3-20020a056214174300b00690027a00e6mr5703643qvb.5.1710366443520;
        Wed, 13 Mar 2024 14:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB+0sslZT/w15j/K+m+SJUdgZVImDODUje9EjvSi+lJj4JWIjdAUo0kKWd9JJ6p81zVpsztA==
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id dc3-20020a056214174300b00690027a00e6mr5703604qvb.5.1710366442877;
        Wed, 13 Mar 2024 14:47:22 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:22 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 01/13] mm/hmm: Process pud swap entry without pud_huge()
Date: Wed, 13 Mar 2024 17:47:07 -0400
Message-ID: <20240313214719.253873-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Swap pud entries do not always return true for pud_huge() for all archs.
x86 and sparc (so far) allow it, but all the rest do not accept a swap
entry to be reported as pud_huge().  So it's not safe to check swap entries
within pud_huge().  Check swap entries before pud_huge(), so it should be
always safe.

This is the only place in the kernel that (IMHO, wrongly) relies on
pud_huge() to return true on pud swap entries.  The plan is to cleanup
pXd_huge() to only report non-swap mappings for all archs.

Cc: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hmm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 277ddcab4947..c95b9ec5d95f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -424,7 +424,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	walk->action = ACTION_CONTINUE;
 
 	pud = READ_ONCE(*pudp);
-	if (pud_none(pud)) {
+	if (!pud_present(pud)) {
 		spin_unlock(ptl);
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
@@ -435,11 +435,6 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		unsigned long *hmm_pfns;
 		unsigned long cpu_flags;
 
-		if (!pud_present(pud)) {
-			spin_unlock(ptl);
-			return hmm_vma_walk_hole(start, end, -1, walk);
-		}
-
 		i = (addr - range->start) >> PAGE_SHIFT;
 		npages = (end - addr) >> PAGE_SHIFT;
 		hmm_pfns = &range->hmm_pfns[i];
-- 
2.44.0


