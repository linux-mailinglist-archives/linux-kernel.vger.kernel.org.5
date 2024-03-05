Return-Path: <linux-kernel+bounces-91672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D092C8714DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E91C2039C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403162178;
	Tue,  5 Mar 2024 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOte3BSv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA65B1F4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613534; cv=none; b=kGOLGA7+2wQdg2dSpeAeHMsbLJdc+LXoSUqZJ5//HEM6S9l9p4ZBPuynqWBOox+700393QT/1fpY4lbOLa1muGkHd2iGxjv8FLPvQNK98lh6J4zOS2+izwxpq+vXvcFF7Qa9rlHMVJn1OAKtMYnrySoBYftj4+dHe9YIq3dJzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613534; c=relaxed/simple;
	bh=8EhJxQKrgTN0aih+ibAZt9D0Kjy5ldDVriI7No+O+Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZyD9V5n9aXp2y+5HkePXT6gK2bsFBZR4t7JERgxkVdaN5Mk/i8BZ0+OsMpRFoZLrH2HPy5iL4PEY9kRWO4tcj9+HPPKO2msjuIZsAmTU/4sLZUgSK6fyRgVJ70uHwLEsja+eiSXdhRGLCebsfgY0AyoIdC5eQStlkA+lWMpuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOte3BSv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OBCTz9lvlJv+Cv6bxuJooI+JmxCAuhU7weo02f7lPE=;
	b=DOte3BSvd62PeVlJX1qGGkyYBZNruF+nF6ATVi2+UNYABAyJxgZCxWQ2ot1+y8BDjy1cTt
	bRfkJH4Xo/WhnA+VD1uRBYlcQQPBJwZKcK5WPJy9reWFnI1pKKTUtclzJ9QkU8eC6+cnE2
	mpAcxohtXg2YTyjyHXKy+Ms/saZPzm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-mm-VBS-RM56uWvAAq4EvGA-1; Mon, 04 Mar 2024 23:38:48 -0500
X-MC-Unique: mm-VBS-RM56uWvAAq4EvGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31F86101A5BB;
	Tue,  5 Mar 2024 04:38:47 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 52DABC1F086;
	Tue,  5 Mar 2024 04:38:39 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Subject: [PATCH v3 06/10] mm/kasan: Use pXd_leaf() in shadow_mapped()
Date: Tue,  5 Mar 2024 12:37:46 +0800
Message-ID: <20240305043750.93762-7-peterx@redhat.com>
In-Reply-To: <20240305043750.93762-1-peterx@redhat.com>
References: <20240305043750.93762-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Peter Xu <peterx@redhat.com>

There is an old trick in shadow_mapped() to use pXd_bad() to detect huge
pages.  After commit 93fab1b22ef7 ("mm: add generic p?d_leaf() macros") we
have a global API for huge mappings.  Use that to replace the trick.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/kasan/shadow.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 9ef84f31833f..d6210ca48dda 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -199,19 +199,12 @@ static bool shadow_mapped(unsigned long addr)
 	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud))
 		return false;
-
-	/*
-	 * We can't use pud_large() or pud_huge(), the first one is
-	 * arch-specific, the last one depends on HUGETLB_PAGE.  So let's abuse
-	 * pud_bad(), if pud is bad then it's bad because it's huge.
-	 */
-	if (pud_bad(*pud))
+	if (pud_leaf(*pud))
 		return true;
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd))
 		return false;
-
-	if (pmd_bad(*pmd))
+	if (pmd_leaf(*pmd))
 		return true;
 	pte = pte_offset_kernel(pmd, addr);
 	return !pte_none(ptep_get(pte));
-- 
2.44.0


