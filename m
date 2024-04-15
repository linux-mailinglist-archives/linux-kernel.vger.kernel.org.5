Return-Path: <linux-kernel+bounces-145652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E28A5902
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B3281F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED4A84A5F;
	Mon, 15 Apr 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RULvmBfJ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECD83CBD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201558; cv=none; b=rtyLLWXngYwBK6HY8ngOYz4+fd7UFg2ggiB5+oql8pQf53uMgS0BjZrjGCgKTP0E32g8Ir8yH76NXr6drUqPR0jEGL0cgfRvwdJkaEseKLqda0UyHwY89kgckNWLoh1FILtua1yBWoqLPuoG5lcdF/G6rxRRC5SYlYIu/3cBCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201558; c=relaxed/simple;
	bh=bZhwZeYrlzAcy5RHy9jWTP4UjDiBbNQ8TWxMoaetbvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzikxVQVvz5m1imYBNlUMS3XQAIhXTcadzSCHYN3/qru18sjDm+DEaJtZK1QV0QScAQkGX0QdgCgR8SYx8Vgv9Ty/mQp59/XOpz8MiHac9LaSXNDEsexdKraEBT5GaCJ+FGZw6F1jtwAeS1zKKO3vUQ5pUE4TkBWrayHqNcOc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RULvmBfJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so2281870a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713201556; x=1713806356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x5lu4xKhCQ/0haQPCj7eyNWwUk1BrbeMvC9dF21zPVk=;
        b=RULvmBfJ2xIeU7e3CPYXj3Awmy9vgLBTmnvE+od6mQwIa3NhetuhzaabRMK0LiNYXp
         Urdpx7McvjcbH4+LEfpGUd08bq9RAdFvFJJHANL0uWQdG7EsH/SENaAPXhsoxD9wwoa2
         Cuk5bx2rBkcglnzIrt6i2ooFDQU1kl8mbipjBdPwpA9GYOoyLzp20g96ojvyWPNsv+7t
         7PDIfCVZoqTxCLXsixo0jB4ee9UWtHBD2u+x/4XDdVwlctbyDjxzPa2erRyPM6z4Qm9v
         PWmpwnCQ3wjuBfHaI8kURVvCyBkzs91xK4aLZtVj7ZiB3FpsivYLcYoVe917ZIOMKrpz
         Lzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201556; x=1713806356;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5lu4xKhCQ/0haQPCj7eyNWwUk1BrbeMvC9dF21zPVk=;
        b=EXjIUU7nyKZC9nmqBIu8rBNBFDgTG4+qBLuOaJTnv2dLsJFxdXagXxVjJPrJwYEbsb
         G9rpv8nRlC1uCsqckYAegYxWM3Rh74UxG2VoqUDF2L1XXh7U1JGsusW79mG3f44EER7e
         VjvFHmdOYfDoqufFB+JbHNtxO7sp+JZ/jKvV9B6tnoBl89ttJPNmXXCiAtUzDHGFx3/e
         qcR+IwaC0Vl2CIJQmNpJ/MXxp7GyP4+vnq8hrRPmdU5xeJsfWILGzWX+AwymvzNwLA2M
         Zffriz7oNyP0q6qjVwB8VPKBzClMK+7YRwG11ObKR5F8pFBY3xX4xy/uBrurj/VPlEg9
         4nRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmkHUcQRO2HpOZSiFP+lO+a8yU+CNjP2DxQITpTTCgq6YHK/pvvS9DHb/GNN0eeBUxFmodERHLLosSIw4qLx65yC91H/kot3yVewcS
X-Gm-Message-State: AOJu0YztTxDgaD5QZWm6pkU9AaHsTFUSatBrR6OKBUeZUOBfSGbec58q
	i0SqSmh0/etLtHJM83Jdb7VhODRuvo+926gYv/mf035GyYmTMCb/
X-Google-Smtp-Source: AGHT+IHCSW+MgtEmdHVUti9+WxD2hWCD0NmfCyU2sjka1LkmR7bv5TKrJwBuID2fpVaAEzlYPQwGNg==
X-Received: by 2002:a17:90a:e50c:b0:2a2:7817:f591 with SMTP id t12-20020a17090ae50c00b002a27817f591mr7838981pjy.48.1713201555986;
        Mon, 15 Apr 2024 10:19:15 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a537abb536sm8751648pjq.57.2024.04.15.10.19.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 10:19:15 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 2/4] mm/filemap: clean up hugetlb exclusion code
Date: Tue, 16 Apr 2024 01:18:54 +0800
Message-ID: <20240415171857.19244-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415171857.19244-1-ryncsn@gmail.com>
References: <20240415171857.19244-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

__filemap_add_folio only has two callers, one never passes hugetlb folio
and one always passes in hugetlb folio. So move the hugetlb related
cgroup charging out of it to make the code cleaner.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 12089c24abfb..17a66ea544e7 100644
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
2.44.0


