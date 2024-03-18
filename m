Return-Path: <linux-kernel+bounces-106597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7487F0C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A895F1C21D21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934BA57885;
	Mon, 18 Mar 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8fWg9m1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363E57336
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792252; cv=none; b=Ma58qxJ0Z1eOHSBJ5wY58ksZYh9DU+Pjn8b8kKKypxn65jIigHaHefzbvjxlctMLXJllPCIpInBUFSa0msmQ91G5zbk9p2vjxz2e0aBQPsfeBX6+lj7SWCo9RriHx7zkTovBJUottX/HSNpF4AbAQTNPQISuusyMxAPmUbJyu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792252; c=relaxed/simple;
	bh=0Lswo5GE77ATHQ8L+dlMWa1yM2evkibSoyq3AnC70nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTuIHvUim5tE1TmtRes6+Uf2zupZTbqH8SqWw8xodflzHvEB6C7JmESUSRvztwlfNST/YsfOtrTVDuTDPG1J1V5STa8j+R/dmaGF3J7LKfr6rrKcgzO3/8ijKRNH0LWplbg7eLJ2tUXx6vovfvsQgZb5mRSxADFuZdRER821xRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8fWg9m1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8evz9V3UX8qsNtRrNT6H/1m1GM34KP8FDwkI2vjQ2A=;
	b=S8fWg9m1YgkoczxzTj3AkBFqhB90e1s76QbODbE3ZeLW+Xt620sHj4h9CGALvr5saSt16Y
	kMABOOI9hIBvt0IIqzjH0YAf9xwZCkkUiAZ6ywaL1mSnHLFdF07oYzt6LJ53CKaj94WWk1
	ylnH5p9do/rS4tjK/HgwnTJbbyUv44s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-nnhJzsJePJSJcYS4mFbIHg-1; Mon, 18 Mar 2024 16:04:09 -0400
X-MC-Unique: nnhJzsJePJSJcYS4mFbIHg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430d73c0492so3449621cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792248; x=1711397048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8evz9V3UX8qsNtRrNT6H/1m1GM34KP8FDwkI2vjQ2A=;
        b=Q4jypZcsuucD2I/fmtHeVudP7fnLY75BgqO7ShatlB0XZr0Jh6Zg+ZXHBnKzwF1mM1
         dxxx9mvXmct848zQJPzMgfLMByaLHTJb5kRJGSglvx71zRglhsrzSk3vgTZSvbxnshb/
         cb+dISd/rFQXnBsS+sH+Tnr3EWpdmnL540jxF/aZAa9RitaM5sbyrou9g4EWELwhwUZf
         giiWiQYiw2VDJDCcP0qdYr35tQxd6xG85rtffOyf1qrEZYOfoREvAx3IVyCTzgfO/n38
         K7iciCw5uelmshsVebCu9KbE+FkQxmcpWcHfzet+q5CSs6j7+BPsi5WUVaRpZHeOvxgR
         4mwg==
X-Gm-Message-State: AOJu0YymNFEiTwYBYZme4/f5HGZ+3AeqN6i9XksPggaho2lMYgnufi6G
	OIZxebeSucdVn9Q6R01gm6xfkGP2Pmr4Dvt8ho5f5h4tar/GKSkSdkhkAYB9qbIGSTaivPvVRtn
	zFtmfK0gjCkfig/8jKohFdsz5aTujcWj+Q3riVfzAwX6CysIr4BEFaORNNHDhzyYAfNM4wNjLoq
	KrUGD5+eANKcm6qLdkfFc7atnSacqDFmSFJTfxgKBlMQQ=
X-Received: by 2002:ac8:4e2c:0:b0:430:d071:2b0 with SMTP id d12-20020ac84e2c000000b00430d07102b0mr368403qtw.0.1710792248153;
        Mon, 18 Mar 2024 13:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6cgX9VgTY+xZMMhFw6lqDmni31WpaCJ4ySK//jo7z1XpjzLPLjahfNZgReizXXgubZZVEzA==
X-Received: by 2002:ac8:4e2c:0:b0:430:d071:2b0 with SMTP id d12-20020ac84e2c000000b00430d07102b0mr368368qtw.0.1710792247694;
        Mon, 18 Mar 2024 13:04:07 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:07 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	peterx@redhat.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 01/14] mm/hmm: Process pud swap entry without pud_huge()
Date: Mon, 18 Mar 2024 16:03:51 -0400
Message-ID: <20240318200404.448346-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318200404.448346-1-peterx@redhat.com>
References: <20240318200404.448346-1-peterx@redhat.com>
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


