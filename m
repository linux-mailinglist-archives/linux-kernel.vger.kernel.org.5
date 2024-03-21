Return-Path: <linux-kernel+bounces-110727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055358862F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961A21F231DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54113667B;
	Thu, 21 Mar 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFBqd3Pr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447B134CC8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058892; cv=none; b=UvikXCm+90+qIMvu/WaAs7wzNq6P05pTEaaneiS4xSPVYIfzAfaVrbycd7uSGOK2k/ZQYTb5hbXL5HJw/tfwJcZgqygJKjPIjqGkAdIfB6HHgHtFaWBct74H3c/YhNOb5uFwD+aIhjpvfhudyppF03c+U5O/7n2kXQUIOn2BsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058892; c=relaxed/simple;
	bh=aHfZvZI3hblnvK7sGliw4vracY8c0yNtRNBxsmY5Mag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nunDnHjzrEthnco7hrAxIMUAbIB7KuUEa0LmolveAa2B76gclrcVezNAFREq7m7vP5+Xd9qVpzTqCHCSWU+m5010LQ0d08iEbwqNPqUsXT/rvsv60TIaTstBks0s2WEtSu0SqllHzBF+lSDUKYuxKFfHGxh3IQGMtoCYWaTCapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFBqd3Pr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzTkuuEUZ2f7C9YouF2ORWZwnTLSeJ8Y5AJhy7kkISQ=;
	b=WFBqd3PrcfzDUqwzRERf+ocDwAn35oYVR+h6HNReRIoJUgEGWqiUxFqmCsBsC371vvCL9t
	WaygFvC/wWgOjBq1hrrCqAy9gaXi3YKZtRVPwWSwAnmdzXcY6jo6MYP/wI6Rs5FH0iiDau
	KSWZNkg3FEY6fYef5lOtIsoXGHW9EB4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-3gX3Z4ycMTaI6_yU27yKoA-1; Thu, 21 Mar 2024 18:08:08 -0400
X-MC-Unique: 3gX3Z4ycMTaI6_yU27yKoA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-430c9bbe925so2914751cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058887; x=1711663687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzTkuuEUZ2f7C9YouF2ORWZwnTLSeJ8Y5AJhy7kkISQ=;
        b=R32hgGHf7C/2I2LJNP0PDQpYlXNpMUqiAlclog+r8QUHPyN0KFzv5GJmP4lRvsHaZM
         mC8Fb3azu9dpTGQFXxAZTp2We7ONyz18tHkOy81mlgJMQ7GlGFZmm6EVwskodUvnF31m
         6fqBXFttJYeuPSGfKYh0xaBqnOt2FiFhi5rVRCKudRfagxdSZTPoCBrmdyR2OfM1JFzz
         OsFVul3+6aQX2IpcyPleStpbl/jnjNMl3Gal/qHlo73VnF+pl4XbzqH70PLLnu/Y2MhH
         WWrXFf5m6htJpppTQqdJ34/NdxChQfTsCGUSZn4l1JDF2pb/S8q158+Ukwm+wCtv7d8b
         Xw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlEfwa4sQAtODWKJ7oZQPY6hFrZQ2LRXMdYYjho8fSrl8B9eiNto/yTP8+N+rOaAHFBd8t/i8ISn0cpeyIQYGfgbpcVUbxSznugMaB
X-Gm-Message-State: AOJu0YzcAU9LT+A3ujYFyEF2gZYUlJM67NreMd1NYLnpV7AS3lLdEoPb
	9VFE3kw/M2UowC9F8kdXAs50dAufFdyuA92oFUJWa2m0w5/bkV10tDD6hTcQCFx9LlspWluM/lD
	3QHJ1T1OCn3BRvXZIBeyzTyTyO+iFaJoLqAQlU2Y/mv3YRjI6ViOQ1odrGBlYbA==
X-Received: by 2002:a0c:e58b:0:b0:691:87dd:f836 with SMTP id t11-20020a0ce58b000000b0069187ddf836mr428477qvm.5.1711058887529;
        Thu, 21 Mar 2024 15:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbvsPPVNStAWHyU+pKNLEFDZ4j8yXA8+9tn+eCe8z7LjIA9ieYt5evzB7ZRQzGTHD3gHSYEw==
X-Received: by 2002:a0c:e58b:0:b0:691:87dd:f836 with SMTP id t11-20020a0ce58b000000b0069187ddf836mr428451qvm.5.1711058887085;
        Thu, 21 Mar 2024 15:08:07 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:06 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	Yang Shi <shy828301@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 01/12] mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES
Date: Thu, 21 Mar 2024 18:07:51 -0400
Message-ID: <20240321220802.679544-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321220802.679544-1-peterx@redhat.com>
References: <20240321220802.679544-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Introduce a config option that will be selected as long as huge leaves are
involved in pgtable (thp or hugetlbfs).  It would be useful to mark any
code with this new config that can process either hugetlb or thp pages in
any level that is higher than pte level.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index b924f4a5a3ef..497cdf4d8ebf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -850,6 +850,12 @@ config READ_ONLY_THP_FOR_FS
 
 endif # TRANSPARENT_HUGEPAGE
 
+#
+# The architecture supports pgtable leaves that is larger than PAGE_SIZE
+#
+config PGTABLE_HAS_HUGE_LEAVES
+	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.44.0


