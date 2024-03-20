Return-Path: <linux-kernel+bounces-108367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9C8809B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C23E28437B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A120134C9;
	Wed, 20 Mar 2024 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="NyWllr7l"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB06FC17
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902547; cv=none; b=MpxwWBLiyCxngnIMkwL3vaVgnUva9mWxmFBptjf+xHA4yxtkrHGIqlAZ3xy1su3jFFi96nI6Xfk1bgxjtzGBL1xvnd1J5TeYvX+UkCBb4/c1NAxEQtTXJshrc772MaeSs+Xray+xZ+od96MgW59EBBsIubfJ14Tp0Y5Jd9iD1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902547; c=relaxed/simple;
	bh=YzPNp/bNBe/NK++T3MgP34oObjeH/a7wt40c91gratA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWtZfDmeD0f706R709d+91J0e1Mrhw1lNmepbEJ8chSH25oM6pRHkWWbxkti1fcsKOYXCp2DyaR/PrNyWbw1G51HzFroJkbBwvU33I0jYavsBc9dCMaWGkIzFKLOmNtAI0e21QXvUPdAVRrss4rW2UonvwmXCZyCngV9YMF1Xjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=NyWllr7l; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a13117a3dso41383385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902543; x=1711507343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gwth4DHc3n7Jk8RbQant6q4qmoLsduwQhc9A8tF9LNs=;
        b=NyWllr7lZI070fBxf7aqVYRREUG4OKRS/DVLH10s2ofC4Tz1HOulNy+cfe/LNG5QS5
         IQktS84gTIf2sIDOM/+QgSURQPit27g9OAp+WzqnxCXpLtvkfj2L5md9/nw6ujGVavNf
         BG+0HpffJq+Xp01WIBgcFxnFfAcuQpYeW2vjl9/G9zErl2If6d+NCMtWyzxzfedTgtz0
         Nh+TkzE5VSJkYo6sX3F8DMcdjJZbQZbftUHjmLAL4qCl3iFiL+18mL293wyoT9iNIWcD
         ZBtI0XVepGgzq4hf6bYNsjDXqfA+OMiayTKX9ibAmvnicFtSLYzqk3d1hUikAkW+DM/Q
         E0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902543; x=1711507343;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gwth4DHc3n7Jk8RbQant6q4qmoLsduwQhc9A8tF9LNs=;
        b=g9Ri5or2ONo4j8BWVGl/qnoUR+YmU0Gy2xZ+gEHmmosJLdZU3BJGbQLm/yx5L8zfPX
         mjL1TLxSEXPVlbb77QPnBKX2HDrfB/SG1IFWkdXnnxCNMjZ6Ic5mQDtQehqm7MY5DO91
         pWxoHihp57pnYW9G1lud7Rud6xQJuFUmMcWc7qePwqh9pUueT3NUfJu1LnrKqKQpMHEZ
         Zd7f6qLern921LykvdNySBzGkvkY2F4X+MAAMDuikno8eFIa8c9KlebkNykurO8z6k6Q
         q6peLvok8iwuzq9XOpHu8nuWkPKm+RJ+Ou6b8Ks+Jqo6pXSgQ4B6KKbc+IhXsjvl/mxh
         mTUA==
X-Forwarded-Encrypted: i=1; AJvYcCU8PTjHR8hKNh/CMSVshKJBBF6bQn0e2lSkWdYfyBGUp/I8k+sH9THqA7QS4R5hGDW+INq7kwI+1GLBiw0OI3i3MMaY0ndB4w4JRw9c
X-Gm-Message-State: AOJu0YzVzxTa107xQId012HjM47YplwKuInxXFuzpqbGquCQh4v0+7DQ
	/zOM+CwI8Lrz8vIUCz2CTBssWC2jSX+7uJ1ZTLeW+62ypTCNj62JQBZocaGy+JsDcPNxL4M24+4
	woQ==
X-Google-Smtp-Source: AGHT+IGHswrTM4FTiBPD0YXAQUMLyxW4PRx4gQjvpjDC8ST6/12GayLSbc0ihrs1ql7V1uIy1W3KoA==
X-Received: by 2002:a05:620a:4691:b0:78a:120f:ee44 with SMTP id bq17-20020a05620a469100b0078a120fee44mr2253073qkb.28.1710902543396;
        Tue, 19 Mar 2024 19:42:23 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id d7-20020a05620a136700b0078863e0f829sm5213075qkl.12.2024.03.19.19.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:23 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 4/7] vmstat counter for pages migrated across zones
Date: Wed, 20 Mar 2024 02:42:15 +0000
Message-Id: <20240320024218.203491-5-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Reply-To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Add a counter for the number of pages migrated across zones in vmstat

Signed-off-by: Kaiyang Zhao <zh_kaiyang@hotmail.com>
---
 include/linux/vm_event_item.h | 1 +
 mm/compaction.c               | 2 ++
 mm/vmstat.c                   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..be88819085b6 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -79,6 +79,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		COMPACTSTALL, COMPACTFAIL, COMPACTSUCCESS,
 		KCOMPACTD_WAKE,
 		KCOMPACTD_MIGRATE_SCANNED, KCOMPACTD_FREE_SCANNED,
+		COMPACT_CROSS_ZONE_MIGRATED,
 #endif
 #ifdef CONFIG_HUGETLB_PAGE
 		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
diff --git a/mm/compaction.c b/mm/compaction.c
index 03b5c4debc17..dea10ad8ec64 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2552,6 +2552,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	count_compact_events(COMPACTMIGRATE_SCANNED, cc->total_migrate_scanned);
 	count_compact_events(COMPACTFREE_SCANNED, cc->total_free_scanned);
+	if (dst_zone != cc->zone)
+		count_compact_events(COMPACT_CROSS_ZONE_MIGRATED, nr_succeeded);
 
 	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c28046371b45..98af82e65ad9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1324,6 +1324,7 @@ const char * const vmstat_text[] = {
 	"compact_daemon_wake",
 	"compact_daemon_migrate_scanned",
 	"compact_daemon_free_scanned",
+	"compact_cross_zone_migrated",
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.40.1


