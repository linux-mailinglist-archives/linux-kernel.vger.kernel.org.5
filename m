Return-Path: <linux-kernel+bounces-7553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF081A999
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74BF2864B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375024FF62;
	Wed, 20 Dec 2023 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVnQMLjg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178664B12D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVk0EEeLHw3+o76tswuza0N9QDfjbUBpt28VqO6EQjM=;
	b=PVnQMLjgR0K2aR9IRiLHuITcihax27LX/imexNqtO1KofshwaJmjevWoybPvfaNdkVRsVT
	ZdRPLa3xGbmtP2uqoH53WELjMib2/lzv1wZL2VBqbsvCM+5eyoEoSoSGzHD6Bn5SOxw1mV
	/cXF38ebCU4c2oVfiuFp70+F6qXmUeU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-W2MzE-l6OeqzSGd0SCRvqQ-1; Wed, 20 Dec 2023 17:46:10 -0500
X-MC-Unique: W2MzE-l6OeqzSGd0SCRvqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 437B786EB20;
	Wed, 20 Dec 2023 22:46:10 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F294F40C6EB9;
	Wed, 20 Dec 2023 22:46:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 24/40] kernel/events/uprobes: page_remove_rmap() -> folio_remove_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:48 +0100
Message-ID: <20231220224504.646757-25-david@redhat.com>
In-Reply-To: <20231220224504.646757-1-david@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's convert __replace_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8b115fc43f041..485bb0389b488 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -198,7 +198,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		set_pte_at_notify(mm, addr, pvmw.pte,
 				  mk_pte(new_page, vma->vm_page_prot));
 
-	page_remove_rmap(old_page, vma, false);
+	folio_remove_rmap_pte(old_folio, old_page, vma);
 	if (!folio_mapped(old_folio))
 		folio_free_swap(old_folio);
 	page_vma_mapped_walk_done(&pvmw);
-- 
2.43.0


