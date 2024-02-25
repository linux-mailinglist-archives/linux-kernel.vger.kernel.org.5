Return-Path: <linux-kernel+bounces-79978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4086291B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C82281CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A19454;
	Sun, 25 Feb 2024 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X12hB1tt"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2B9445
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708837042; cv=none; b=nCNLsF5Fn1RTLNT6YdhJ5lAWkrmobxbvZWMcptEtL0GtvELivwq855ADYpsML1rMwwzwT9ysd7KfdQewAuqqED84X750gpCbCJFQ7PYRZYa+7opc2R8/KgbDyw09nwt4MYthyxHNokmmoSsDtRZiJbpy11sk6HebVBlsvvJeuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708837042; c=relaxed/simple;
	bh=lh8wIdWDLhbdeIx1kIiqoQGhmSU8f0uE7eLpPZ+2Vy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcT7aQ9XjLEwaV3RadGafhE7KJ8NwK/mzYZTVAPbb4JmxypfbptHLpKMnvcHnLtaZpb7KHvcH0MSJXktQauzzQoQRrVJrXnZr2W+AaptyaPxEOfjq7j+zKPtcWKNA9h8UiFaGqrrgNR4o+QSFNbhfmt3mzjtgNcYyJlm7HAF1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X12hB1tt; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so1659692a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708837040; x=1709441840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBAbEO8N8UoJFU0GI3O78KlTzRGmo0GxF/Kd2SEwLGE=;
        b=X12hB1ttKA1bSyim2funw87r2H5xLfHFClSVZpmY7YEQeE4aKueWk8iVOEEGC9l0di
         6gqlUbL6lOU3+p44VheBQQvLcsc3sPdkkOmknaldjE+jT7ZvhfaYcauWnLVx3tlkWYhh
         IVmxo5zHwMRxxB9aJVXP9bFXwMFzjGg3kRpbW6Bs3R6IGQIdX1SOFjrkLhTai2XklpqG
         CCZAZxO2lLCCF4I5PFtop1zgaAt9+3KHFOpHf0N1J7puh5eYghRfHEB265yrFtuZ828Z
         OGtWo9b4/Iv8+6tOoeEN012ME1U/yIZ1ZaVpZ96MimucrQbcaDbmbj6LWBmEf+NL09cI
         C+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708837040; x=1709441840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBAbEO8N8UoJFU0GI3O78KlTzRGmo0GxF/Kd2SEwLGE=;
        b=CRKl4ut433rfcQdsR9SgkrmYbBMYxX85uWClKcAC7o3ykmdAjhRbTdRhIvshpr0/Lt
         aQrWBZ4vRptnSzAn8EgeQQ7B9jQmi9Nb9ZarvpIZ6YOU5Rl1UcPVqLw0r1dpRJP7WhaD
         wamG+cxxnfDAdvDvPWYoH6fq5Za4NtXwqcCeDG7qgDTMnjxuYGffWuAQPx0ZZ9BH4JhD
         /aPMYvPKvT1CFsjo7CPpiYlSk0VX+H9AIXwU+yl778qkbhXNR3AJWuxOybTRa8KzJTRj
         8EMw+PF0NZq9ivKO/Ba+Tc5jvuvpkKadWOKQiIEczxRKy5lN1uhSaPKb4gpLNnIWvrWs
         mMLg==
X-Forwarded-Encrypted: i=1; AJvYcCXCKygHAo/LMqqF/YY68SDPwyFayZ3HHW32p7Do+CGmdX3V9QJPu438aLEPKWer5EFo9QUz0F2gchNmt3C6W1hXItooc5hflpxhLzF2
X-Gm-Message-State: AOJu0YyCOQNYuDGlYhQS+QBgb8DEm5yXi/ux6nJEvunxIhSsfescWHMb
	W1fTGYaNpclaqrIkCxOCvyLrG/yQSy4/W9AjGAf8QpjMxkM5RnAO
X-Google-Smtp-Source: AGHT+IFgN4daKjGulDEbP34bF8Wqdjxb7tb2e2NhZ8VHoy6T4niJZv2NOzn72x6PMJwrD4FG6pZnbQ==
X-Received: by 2002:a17:90a:cb16:b0:299:cafa:5e8b with SMTP id z22-20020a17090acb1600b00299cafa5e8bmr4986126pjt.6.1708837040211;
        Sat, 24 Feb 2024 20:57:20 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.225.117])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a2e0600b0029681231ae1sm1978635pjd.28.2024.02.24.20.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 20:57:19 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org,
	shy828301@gmail.com
Cc: ioworker0@gmail.com,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	songmuchun@bytedance.com,
	zokeefe@google.com
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with MMF_DISABLE_THP check
Date: Sun, 25 Feb 2024 12:56:01 +0800
Message-Id: <20240225045601.79244-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CAK1f24=2z9tk4cCCSobVpExZ+uV6N8gbGx+xiJ7p_UjrZvSv3g@mail.gmail.com>
References: <CAK1f24=2z9tk4cCCSobVpExZ+uV6N8gbGx+xiJ7p_UjrZvSv3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a diff against mm-stable.

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2771fc043b3b..1c0073daad82 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -920,7 +920,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 {
 	struct vm_area_struct *vma;
 
-	if (unlikely(hpage_collapse_test_exit(mm)))
+	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
 		return SCAN_ANY_PROCESS;
 
 	*vmap = vma = find_vma(mm, address);
@@ -1428,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 
-	if (hpage_collapse_test_exit_or_disable(mm)) {
+	if (hpage_collapse_test_exit(mm)) {
 		/* free mm_slot */
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
@@ -2456,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	 * Release the current mm_slot if this mm is about to die, or
 	 * if we scanned all vmas of this mm.
 	 */
-	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
+	if (hpage_collapse_test_exit(mm) || !vma) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * khugepaged runs here, khugepaged_exit will find

