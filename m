Return-Path: <linux-kernel+bounces-107316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E62B87FAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8FE1F22363
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA007E10C;
	Tue, 19 Mar 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgYzo7LQ"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E47CF32
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841306; cv=none; b=V3wIWxAzC9P3lNcAhArYG3Szw9d/ijiu3P8bCQCG4EgsP1QMxhZScjQNw2z74tb7/rkehog0rx+Q515oFhc+3NYYbQa4Lem/dPBv3vP3yliGZ6Cqj1PKrh98jOt5q7PhCl8bvjICnJX51XEdFtWjqI5xM+4xx6/8nb02JwqUIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841306; c=relaxed/simple;
	bh=DDs2rnx+E/mR/v1bFliS217+2gvtxPWAyB1Ek+cfMRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eC1qB4dX/SiGY1HMT8ibBK8Diw+rfUg+JpjyvUKMi7h/KzrO9nEBsGOV4OUHuU7WntBOk5pHeXwFsGpkFEn/KpAStM9VhaMqgEF63GOB+cG8Yuw16kIkqtXzTbZjS2M3XG94/8IqwujbhQsj+xEtVBFHWsGe+n0L+2q1gOFr6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgYzo7LQ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c38d76384cso780487b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841304; x=1711446104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J34Qf2qKoII5Mgpe9QZtGvKa+BRn934GAZXO0p+CcPY=;
        b=bgYzo7LQDkBglL1zMQ3waOvR2ZJSL+EklGdid28ZDwkW5Ols6EusT2XIOYG9oznMAO
         RVrHVGg0jYyvsiGJdP6tJho1p3P6qlbQmjrrLvWCdy7Es6zMrwdbVTP/CP1CH8KBvTRF
         bZZrseAWf3BetFo1KCVmswMs0XXqqLgPw833sZy4hdyU91w3Dld6kkY/rvKQWMUjDd3c
         Jr6mM+J+6f37Mei9mw8tguJsITq7YYPMJIuuRW4ilNkXAX/+o+Zgyhy7GXwHRH3Q9u4h
         NqGqwJt4lbg+C3fgYV8clLDlbnXan6GTAWks3XUG0laU7t4+Is0KK4rNSvIUR4M5AGQl
         70xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841304; x=1711446104;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J34Qf2qKoII5Mgpe9QZtGvKa+BRn934GAZXO0p+CcPY=;
        b=MbxE87wphr2dMDT2FaSLsohdvSwKYrSJTAn0aTbQMnV3RFgat7eF6yIgNW6TMx+qx3
         YhYARsTsHD4/oFw+QXdgigzPtlzh9JSnW6uVbDAJ8BcigpisN3aFulaIJwNBJsQnX97s
         Mu970n9zo7F+LDNwA3L2MnonW866GjM2r591a8/vq984bDTWzfmKaAWK3Qa4gxvIVwP5
         NqcZUa1rtMF2BxqeZ0HJVMuvwW8Xk60tzNDhzRKOD34Tco8HzQOpB9FHSkBXAl8T5Puw
         iuK5Lp5lYFem0TaKvpkxPzLEPmZMOx2UZqaa3Z3Yd1hYzPT+aSMbKpl+Ty5jvriVVJad
         4lEw==
X-Forwarded-Encrypted: i=1; AJvYcCXVj6sDCplRcC6/9Xeg4UwD/dbzupx0WDhnbje6VsdefMJfD7D7lc8f7md5KppL/Q2qvE0V8HrAhaEXPHU6RE914qfS2G4Ewno42sw2
X-Gm-Message-State: AOJu0YzjZ4Mkj9k/rrVXzH/F5vn+isnbnfuMyWYd7VmUwIUiGfttFpTL
	Vvle9yM+C3yYPpGNvQHpRqIrJd96aK3MFPv6y75FUyJzPEbz5+5s
X-Google-Smtp-Source: AGHT+IEJHFnNbXQdn3Vy4EOryeIqwhnOxZinPVrn7nSGg3zBBB2/OolNOe72ReevQN6mJSPYvWaGpA==
X-Received: by 2002:a05:6808:81:b0:3c2:616a:22 with SMTP id s1-20020a056808008100b003c2616a0022mr12406922oic.55.1710841304361;
        Tue, 19 Mar 2024 02:41:44 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id i185-20020a62c1c2000000b006e583a649b4sm9708761pfg.210.2024.03.19.02.41.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Mar 2024 02:41:43 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/4] mm/filemap: clean up hugetlb exclusion code
Date: Tue, 19 Mar 2024 17:27:31 +0800
Message-ID: <20240319092733.4501-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319092733.4501-1-ryncsn@gmail.com>
References: <20240319092733.4501-1-ryncsn@gmail.com>
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


