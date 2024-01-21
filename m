Return-Path: <linux-kernel+bounces-32193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AD08357F7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258651C20A77
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DE838DE2;
	Sun, 21 Jan 2024 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFC7YGFg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29EE1E49E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705873472; cv=none; b=r0bJlxX8efIItJ74eWMSXX4NeWQ37IyUt93oZrkmrL/VOtkFL3cQGZ50v5wA9lFVKNVv6cPVi31LFw5tWtcvo3h4hCNA+Cjf1e7i0eL/RInvjp6i2pLDWQRLGSf4YuhuPfn9sQLrnjtEtqIQCXCqD+kDhDATtqJIfGLvnQXBxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705873472; c=relaxed/simple;
	bh=6sK28xbIZX8Pa42yZVUnnO4tegkf3aHV2JBuABAaq9s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SCCQEOgNjW6dJniWbC8qHQdxR3RI9/vbZ7+l3GiFmMh1u6j/T55QJZPhk3jpkptVlOrSYZGgLLmScucHMiHxUxL69tmA2s2pQInxUM7uxCuf2Nk8eItFkD8CC406bB9fxDgz+54rSye860Rllg8wc/+yIyl1soSYOoSgGBmbwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFC7YGFg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc21df30950so4272577276.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 13:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705873470; x=1706478270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=42CVSiV7dgut5spnJTiZryp5KS2ThmG9GG1m+AnlGQk=;
        b=zFC7YGFgTUSe4o8g7OvYXif2sQvVT8ZClTIuaKc5LJbfZPUwj/ia+tc4XAQRJquY9q
         205RcDZZul8Q3IZUaPVh04dj9IBR1iFBTWrtaEFWMILFl7/lx4IU4/xtIaWaen4XDdse
         hxUsvjE9OTGhh4C1N07zqJvrJiCsHkaSMgzDMExE0WUJgLroFYBLCxM2xGS7Lm7ZMC5m
         8GirrynXqk6AwZ1s2Lar2rkbHW7hwKJPV3MnHYS1rikEbf+skHmvx6YZlsxcNUEa966N
         uTMx3w/7taxXjailSNpL7eakJ9JolsxbmXxZwYTLRADC/OcJS+GH/dQh2pbzZUt02U9a
         iyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705873470; x=1706478270;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42CVSiV7dgut5spnJTiZryp5KS2ThmG9GG1m+AnlGQk=;
        b=AzHk7EsSDG1iejy3h/y74Fu9t9foFuUmuT+ES3bFGCwZRfcNJFq9qgJuoaasDFm3G5
         Q6/pC9IDuIoAx7Lf//Loio4zTau4QGScjStGfXBcts8JUkgG9ku8UX5TtBt/arrhqga9
         5ddAyjyDCbGgJOZVjW9ToelT882RuYRf1eqEA0bF13ODB1/umJL0Awf2Y2T64zBWj/J2
         OUnLp/ON+6s1FiHj5U+YMAhLMo0cvVrNr8x5DGv6xqoQ2BrIvmqFAqZ/xxX8pzELj5tB
         ZK4i1KgYIT+YE14veSaDTavJ6VkXaA0wEHquVeF4RgqvdKBPmVAkAQTibICmzto1lh3d
         C0kw==
X-Gm-Message-State: AOJu0Yw8l0ffziHERrb42gt6iy9pOJnZZWTmBkuoGEFV72n+vi2dzi1h
	b0VrepS2+wW15CDqZJGRgYeKRJt+pYwz05GRnXdFB1oVuaGYV9d5bTONltVTJ5N/NlpCw2bxPMd
	MSziomlzhAKAiuw==
X-Google-Smtp-Source: AGHT+IEMyWh2JilAlDoiXR/SNFCsaW7XcaXIO9/SLICkIU9rA3hmvI/12jiPGRRnzJ4MSPZQr0BFbytoIkLdrTs=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a25:8204:0:b0:dc2:2179:5f30 with SMTP id
 q4-20020a258204000000b00dc221795f30mr1531560ybk.1.1705873469887; Sun, 21 Jan
 2024 13:44:29 -0800 (PST)
Date: Sun, 21 Jan 2024 21:44:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240121214413.833776-1-tjmercier@google.com>
Subject: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during proactive reclaim"
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: android-mm@google.com, yuzhao@google.com, yangyifei03@kuaishou.com, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 0388536ac29104a478c79b3869541524caec28eb.

Proactive reclaim on the root cgroup is 10x slower after this patch when
MGLRU is enabled, and completion times for proactive reclaim on much
smaller non-root cgroups take ~30% longer (with or without MGLRU). With
root reclaim before the patch, I observe average reclaim rates of
~70k pages/sec before try_to_free_mem_cgroup_pages starts to fail and
the nr_retries counter starts to decrement, eventually ending the
proactive reclaim attempt. After the patch the reclaim rate is
consistently ~6.6k pages/sec due to the reduced nr_pages value causing
scan aborts as soon as SWAP_CLUSTER_MAX pages are reclaimed. The
proactive reclaim doesn't complete after several minutes because
try_to_free_mem_cgroup_pages is still capable of reclaiming pages in
tiny SWAP_CLUSTER_MAX page chunks and nr_retries is never decremented.

The docs for memory.reclaim say, "the kernel can over or under reclaim
from the target cgroup" which this patch was trying to fix. Revert it
until a less costly solution is found.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4c8735e7c85..cee536c97151 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6956,8 +6956,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			lru_add_drain_all();
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
-					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-					GFP_KERNEL, reclaim_options);
+						nr_to_reclaim - nr_reclaimed,
+						GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
-- 
2.43.0.429.g432eaa2c6b-goog


