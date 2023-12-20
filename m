Return-Path: <linux-kernel+bounces-7542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651A81A963
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AE61F243D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912C4E62C;
	Wed, 20 Dec 2023 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbFsevIG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270714E611
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4j1gZ8J9Me1FxgaIKP15u5MZyCwMx8COQ6zxxJs5nQ=;
	b=fbFsevIGT2jAYMyEMwg1HdKhI4EnB82MuSnf0ZTxAh89w9OqUP1R9MW1pVNozUPRYK4FDz
	6nKzkT3vcnFgBbmFHkq2AiV1/l/0rkfTW8++5uffCQKGLj6V3SHndXSdqw9YU9HRreI3GW
	u8jCfMaM3bKZhzisNIxstFOaZjWL5So=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-rwHNZvE3PyqDqMksZaYNkA-1; Wed, 20 Dec 2023 17:45:52 -0500
X-MC-Unique: rwHNZvE3PyqDqMksZaYNkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A84F848C03;
	Wed, 20 Dec 2023 22:45:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 783D440C6EB9;
	Wed, 20 Dec 2023 22:45:50 +0000 (UTC)
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
Subject: [PATCH v2 17/40] mm/migrate: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:41 +0100
Message-ID: <20231220224504.646757-18-david@redhat.com>
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

Let's convert remove_migration_pte().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 65d64a119cabb..b37dd087da265 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -259,8 +259,8 @@ static bool remove_migration_pte(struct folio *folio,
 #endif
 		{
 			if (folio_test_anon(folio))
-				page_add_anon_rmap(new, vma, pvmw.address,
-						   rmap_flags);
+				folio_add_anon_rmap_pte(folio, new, vma,
+							pvmw.address, rmap_flags);
 			else
 				folio_add_file_rmap_pte(folio, new, vma);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
-- 
2.43.0


