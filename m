Return-Path: <linux-kernel+bounces-121502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37488E904
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3971C304E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF78136E3C;
	Wed, 27 Mar 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Be9JyX9J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9931386A1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553034; cv=none; b=qErBmDMM+ZYD6wJ2ezZYS4BK3FpiDtmbgkF9r/vFj4OvprLdAV2I5jmW5S80T+ih+rnCfqLPLl7S8XzYCVXV8QEIkKMPHBFUrcoiqppKGuUTB5aBrJ2a1BBER6pJ8rhJ1+ReHErBmhLqOvs2lL5A7jYJAwsvQEQQi07KWvquH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553034; c=relaxed/simple;
	bh=JdU2xvMnMNAGrluWGr3Tb65X2k9KhflWIWuKDDNpCS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8mfF9iZSgMnUTw4ADC/UtTxlj6d5OcIlKbMdz63S4tcKIvi06vrLTiXqnSKZzGyhZ8kj0TuVW4bI/0xq/aEr0JTd7vEBgMa3Mw+WqW1ukcNV6KZwvcLqEOewyhgj7gtfyaifEkYhG6YvRXZheQ1Pd311Tk3HvmAKpFZT/oQgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Be9JyX9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD68z8/n0HSMW69QF19tjjGBtDgz4n3uypdcneHmRPc=;
	b=Be9JyX9JvA65ONDxFsD9SKnjxqa6Zwk20P+cUWd2U6TGD5mRH+lWveIwWV7QuM4d4mQx7O
	ubwFvp0CxiUshNNkCD7DyK+4JUOIxG1L/JQ2B2stc/N/+QZRj4dEAJc991uQXw6SQhkY/0
	r9k6xZPdGJ9k3PRrVMCVHcgd3e7Ps4U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-fCQKtxl8MHWgcrpVhXXKgg-1; Wed, 27 Mar 2024 11:23:50 -0400
X-MC-Unique: fCQKtxl8MHWgcrpVhXXKgg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69627b26a51so3093566d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553029; x=1712157829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD68z8/n0HSMW69QF19tjjGBtDgz4n3uypdcneHmRPc=;
        b=WhGZ743jylBPjiUxIaucyh6lFqqffJjnAIQ9Ovfo6eBegCZs+BwG9yvYEZwIcmzy5H
         +u4vJY3ttBlGA4l1sQBdmcJgCA4zzSA0hxRIymWGSnCjNWb258cZw4hjYGb00KX2dQ5f
         4tFS8vHKBFxPWlNBgXNoGQDAiV2p7KrlPSUzm4aEK0kZaI3xC29nHSWX9rH/KLMafPqn
         9mt9E5n6BtVshionnZuXOy74W2+uFwpuTipIQPUgBmK2nCR4Db3sXJ5hdvHnr1SZKwkN
         1rIJKUqEGA9t4ONMkHPKC39nUWH45/kjTuPdHQaqVm/66VIPTulSzCW5x5oxgKGNEBoy
         FwdA==
X-Forwarded-Encrypted: i=1; AJvYcCWjF4FSZPwJq7H85m0UlX3BYCdf1+6aMPRVBQsUNOAqEoTQZWHB3b74ljmEj6hbAnms9zUWaeb02pqKp6o7wHvtiHr+SbJouxa6Jsel
X-Gm-Message-State: AOJu0YxF5LGptyogd/B++PtTsBM/KHttTMUfb95/KMuLI8PWn2fQM6lt
	MXMDYDxF2Y09jS5HZ4nlc7UAvwKwzZLVTgRO41Cu60RFRbGA04UFYD1Qv0k2Hb4eqR8c22evghh
	q4FclafemUytLoaRmRhk8Bv6bIfeAklvjWGUSX9kjiWdo/zH1PUz5Aq0rBoxkOA==
X-Received: by 2002:a05:6214:3a01:b0:696:81b8:a462 with SMTP id nw1-20020a0562143a0100b0069681b8a462mr13234462qvb.0.1711553028773;
        Wed, 27 Mar 2024 08:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaIIFSwEPr6utJECaPIJXCgmHTkHVcLUQEzRJpciko/79sjH/yOlRx7KIof08fJkHOKzrhqQ==
X-Received: by 2002:a05:6214:3a01:b0:696:81b8:a462 with SMTP id nw1-20020a0562143a0100b0069681b8a462mr13234423qvb.0.1711553028305;
        Wed, 27 Mar 2024 08:23:48 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:47 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	peterx@redhat.com,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 06/13] mm/gup: Drop folio_fast_pin_allowed() in hugepd processing
Date: Wed, 27 Mar 2024 11:23:25 -0400
Message-ID: <20240327152332.950956-7-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152332.950956-1-peterx@redhat.com>
References: <20240327152332.950956-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Hugepd format for GUP is only used in PowerPC with hugetlbfs.  There are
some kernel usage of hugepd (can refer to hugepd_populate_kernel() for
PPC_8XX), however those pages are not candidates for GUP.

Commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
file-backed mappings") added a check to fail gup-fast if there's potential
risk of violating GUP over writeback file systems.  That should never apply
to hugepd.  Considering that hugepd is an old format (and even
software-only), there's no plan to extend hugepd into other file typed
memories that is prone to the same issue.

Drop that check, not only because it'll never be true for hugepd per any
known plan, but also it paves way for reusing the function outside
fast-gup.

To make sure we'll still remember this issue just in case hugepd will be
extended to support non-hugetlbfs memories, add a rich comment above
gup_huge_pd(), explaining the issue with proper references.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e7510b6ce765..db35b056fc9a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2832,11 +2832,6 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
-	if (!folio_fast_pin_allowed(folio, flags)) {
-		gup_put_folio(folio, refs, flags);
-		return 0;
-	}
-
 	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
@@ -2847,6 +2842,14 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	return 1;
 }
 
+/*
+ * NOTE: currently GUP for a hugepd is only possible on hugetlbfs file
+ * systems on Power, which does not have issue with folio writeback against
+ * GUP updates.  When hugepd will be extended to support non-hugetlbfs or
+ * even anonymous memory, we need to do extra check as what we do with most
+ * of the other folios. See writable_file_mapping_allowed() and
+ * folio_fast_pin_allowed() for more information.
+ */
 static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 		unsigned int pdshift, unsigned long end, unsigned int flags,
 		struct page **pages, int *nr)
-- 
2.44.0


