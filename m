Return-Path: <linux-kernel+bounces-117558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A011688AC95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F3032414C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E54913D887;
	Mon, 25 Mar 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBCS0I9R"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380113D605
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386857; cv=none; b=HqhJNQDxJzNI5hVHoDuHkS1sor1oKS6qD+S36djQjBKAjh8F1a0qmIz+BYYHrLpwrSgKCQ9fe9iCYGUDNgLKZaYoD0XRjiVtMFI5bkgdRezVd4P+uOaR37d1vNpzMwMtWrDoEs1ArFcss0Ce2eDfxvWuq/kuUDABMU2tKhHcgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386857; c=relaxed/simple;
	bh=LWlwlamGO0rfQ1EM8aLmO1k7D9FshXdChnWs/pBPSrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUgiJLmpOaSgX9lnXpU5OdMFQ9c6kIa01unmjDuFnforvWTtjWK15HB8f9guI0a5SirDW9at8bktMyFNvB89MAg5iG3cE8ZSLDy4xeh2uwv586bmdeXxnXOXAmL5nfFg31U51UgdS9yrYgDaJtXJiKnXa4rc26TTe82mZJaNAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBCS0I9R; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3688d20b28dso5512445ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386855; x=1711991655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bN9a48YnOEXH7sPm0Ke4Oa5WKVmRd1RkDjnQJHDaF+o=;
        b=VBCS0I9RaAf56C8UqRa/PYanL+cxS52kVuGhIBQSlEb7aZh3l/xQoBJMsyhgcA7rwl
         h7rGkp2+L4x2/Wbt1FoRe3gtqJ7IC6Tm5CKko10CpCZzElnRGPC70tCQ3gAqh2JwvpR8
         f1MwPzlC9/C44ffV7JHkvl24pd20V5vfMcf5Auk+zlEbKwCRfzoQWmaf/5TJwassnEu3
         yihejF6TfMKUMsHEQil4u7u9HdFhkb5hlcVoocRcDkbkWeDRFRI+3ysjUEcCHjubWKDQ
         a9hFBkTwWm4WI/aypQLgiQbHpdUWPLq76yFPWPRpa2oBeNHxwhEDuGaL6j+oiIcg/Ozr
         SeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386855; x=1711991655;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bN9a48YnOEXH7sPm0Ke4Oa5WKVmRd1RkDjnQJHDaF+o=;
        b=X1UP9SDeMZIHyA1pZW6HO5IDEFbZuMkO20W7jp2A3AxwEEewLQZArD1FWjXhPkqbNb
         5cNb1GOBkRcTzqREbHbtHrQOazq8qvkozibSfdYUaZ5ESRGHpZ5+jJ4pXqv1olNWK4JI
         i5Qc5DHwDnGTwEjqfKZxprQIbocm/0eCHIps72iEidzW1E/6bSVadSMwbjIrn8eIGz5i
         JHAH7rWiNSslrv1PMNnIgvjZ+iMc/cYJsKkKj8hhnB0aGEmahnUacqONyZ3ZeGBjUIZq
         w07TSVl0NPkLEtGiDLx3yxuku7tR3yTYvdNoF6BxQQLNappiHp9WOrTeGXLzvZtkhw9O
         L17g==
X-Forwarded-Encrypted: i=1; AJvYcCUUrZVUV36eWN+SeJtXWy3mPQLd9uuCM9RDsjctdU7A5+TKgPjK5osC8zhRU7txKp0scZ4KFfX8vIhmMqUGpJOq8Lrd8R0jfvGKTmOD
X-Gm-Message-State: AOJu0Yx2Y20Q/Isne93dxqQ4Fk5CTX9l+utzD3Rr+7o18cbQ+CvUoJRQ
	j9COdhink0gqQT1Kxs4xrlrZySl6LeruIsJjMrBqJw3fBAgmHdEZ
X-Google-Smtp-Source: AGHT+IEV6m/IQGGduQkAd1EXsYeOBd+/asYh5Dr5GFoEqy3C5fYnTIRwAYULWlk6rk/10OQ+ts/pmA==
X-Received: by 2002:a92:c883:0:b0:368:4a8f:85f5 with SMTP id w3-20020a92c883000000b003684a8f85f5mr7282293ilo.19.1711386855551;
        Mon, 25 Mar 2024 10:14:15 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id r16-20020a63d910000000b005dc5129ba9dsm6001812pgg.72.2024.03.25.10.14.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Mar 2024 10:14:15 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 2/4] mm/filemap: clean up hugetlb exclusion code
Date: Tue, 26 Mar 2024 01:14:03 +0800
Message-ID: <20240325171405.99971-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325171405.99971-1-ryncsn@gmail.com>
References: <20240325171405.99971-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

__filemap_add_folio only has two callers, one never passes hugetlb
folio and one always passes in hugetlb folio. So move the hugetlb
related cgroup charging out of it to make the code cleaner.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f07ea0b97698..6bbec8783793 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -853,20 +853,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	bool huge = folio_test_hugetlb(folio);
-	bool charged = false;
-	long nr = 1;
+	long nr;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
 	mapping_set_update(&xas, mapping);
 
-	if (!huge) {
-		int error = mem_cgroup_charge(folio, NULL, gfp);
-		if (error)
-			return error;
-		charged = true;
-	}
-
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 	xas_set_order(&xas, index, folio_order(folio));
 	nr = folio_nr_pages(folio);
@@ -931,8 +923,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	trace_mm_filemap_add_to_page_cache(folio);
 	return 0;
 error:
-	if (charged)
-		mem_cgroup_uncharge(folio);
 	folio->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
 	folio_put_refs(folio, nr);
@@ -946,11 +936,16 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	void *shadow = NULL;
 	int ret;
 
+	ret = mem_cgroup_charge(folio, NULL, gfp);
+	if (ret)
+		return ret;
+
 	__folio_set_locked(folio);
 	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		mem_cgroup_uncharge(folio);
 		__folio_clear_locked(folio);
-	else {
+	} else {
 		/*
 		 * The folio might have been evicted from cache only
 		 * recently, in which case it should be activated like
-- 
2.43.0


