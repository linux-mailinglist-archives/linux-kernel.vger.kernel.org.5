Return-Path: <linux-kernel+bounces-4834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA88182B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1BDB23F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD612B69;
	Tue, 19 Dec 2023 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTl2MQc1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9B12B60
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702972570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRvgvssN6KVSq9rYZ03PlMu3BaOgDfLGQsqd5RQuPrM=;
	b=KTl2MQc1qjJSDnZ+ZNXtzsi8B2d2fzd/vgol6a3tXXDBnugvGpmgFArhd90xNSXoIIpDla
	Xa7615j8a7XEUY+WVcK8hFx9KnVjgVhoLAV9AISiMw75yBjQZ3yDzIbuZHh2TnJMwR4vVe
	biMb1DGFi9jor0dpqrp6Aj+Gs+/xi0g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-dipUc7OWPBCmQTMSma-p8A-1; Tue,
 19 Dec 2023 02:56:06 -0500
X-MC-Unique: dipUc7OWPBCmQTMSma-p8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E23A729AA38D;
	Tue, 19 Dec 2023 07:56:04 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4B6D2026D66;
	Tue, 19 Dec 2023 07:55:52 +0000 (UTC)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Rik van Riel <riel@surriel.com>,
	linux-riscv@lists.infradead.org,
	Yang Shi <shy828301@gmail.com>,
	James Houghton <jthoughton@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	peterx@redhat.com,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH 01/13] mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES
Date: Tue, 19 Dec 2023 15:55:26 +0800
Message-ID: <20231219075538.414708-2-peterx@redhat.com>
In-Reply-To: <20231219075538.414708-1-peterx@redhat.com>
References: <20231219075538.414708-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Peter Xu <peterx@redhat.com>

Introduce a config option that will be selected as long as huge leaves are
involved in pgtable (thp or hugetlbfs).  It would be useful to mark any
code with this new config that can process either hugetlb or thp pages in
any level that is higher than pte level.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 8f8b02e9c136..4ca97d959323 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -904,6 +904,9 @@ config READ_ONLY_THP_FOR_FS
 
 endif # TRANSPARENT_HUGEPAGE
 
+config PGTABLE_HAS_HUGE_LEAVES
+	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.41.0


