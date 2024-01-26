Return-Path: <linux-kernel+bounces-40632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2EF83E36B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2CAB21E10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C5249F7;
	Fri, 26 Jan 2024 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPuQV1Lt"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7B2420C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301250; cv=none; b=pcWBeM/anhXIRnme8EcHOu/U5RkXGaHo2Xxv9/JarFKcWwizH4ah6GOCEMY9SGk4s80LYPyW+NkKBw7vGreJu97ELJhM8bteqPmiMlZmLI2p/xv5qM3lF39HHgeyxJGjuu7mt3djOZ4IHnoREZ3QpqJTKidRuVWmDhBer8+qDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301250; c=relaxed/simple;
	bh=cFh1Le3i1dCMQawi1ZeXZVMvlDVa69/HNaaxp1jLcdU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t4NsHkUmRL3zP/1HGvYQk9xijwpm2lfu5Mkingg993xaPJ1MwnDWQyopY9tq4um92zFu4L7JLu23z2uGsDzZDN87rSrlOQrIN43mHoH/QKGdARZgzKLBsgFvAWUU/tOzCRaBvPdfPpveaM0zVfoGgWI2rnc9rjkAB775nDBjwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPuQV1Lt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6de0aabeef3so399934b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706301248; x=1706906048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBt418QgT8toCepZHQBStqxbTN+QCMoMJNdQnaVMPAc=;
        b=lPuQV1LtJzxhn3dsxrCAQFre0wVRTAoEnraqiR+nepOYK0XW4w9eDIexvj46xHerQ3
         WAXlnGyZm9jERG4lVdJcRK48pz4eSquAqxXrmeWsS4k6ZoW2Q2hS+ZIVlAr5atiD6Fam
         XvbpAb2OVJ1F8YVkT2EV8HdU2NNKMoLs3TaQkBaycnmR2QgWwSEt2OcX79EZxPyBPk+L
         wSwV5CgsPL4vkTOEHVxZjyUfp/FdJoWnhipZX0hWmHPz6tknakgyRHIsrQhiBFwpUKup
         8F+t+zobtGcKBxSJzqLP3qaLSV0k4DZRcBLUK0KiPsBy7lqUEpicD/7RviGGG+SiimuB
         2zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706301248; x=1706906048;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBt418QgT8toCepZHQBStqxbTN+QCMoMJNdQnaVMPAc=;
        b=WAAz2KhWxo2FU3tLd2BfgzCJvizRHsbBargr4iA0cDxHLsrvEC1jiBzEFA7rwcfdQh
         MhGEIT2I4zRgwCIC6SKxg0ESwsF6E+jJfbk5SrXj8xSbtf0HKVRxJJ+TNwT9xRN+PXT1
         G8024bXw99eXcNCJcmJLQZwdZq6KltS6giTbMitgH8BJj8hRovmb2KtYZS1m+YokCpwu
         42+z4OpX2JodsYw1vmQR5eWE57Kv5LwC1IC2OuuSVZm2FLsS2WFVX9qnIO1yWFe0u/Yz
         it/n5ui65GXF1QcQ8VMrQUrTEKv0pU1GWdcJMBKysB9cf+nE/DiXXBmDTSjhZo0CzEYW
         ylLQ==
X-Gm-Message-State: AOJu0YyOaEWhjP6QJeTfYRAJnuGmzt9PyhGgVSyL/C5NnPlfx9I0jx8E
	ywR/u9xvQ0DOTUF43NaRQJQ6Sz6Yq0/W7caz4OwzZB09XVeq6T2G3HahoXjD9tL9zDj9gQ6oSYu
	mFm9lHl0WErH96A==
X-Google-Smtp-Source: AGHT+IHHP1kWMGZ9Bn+eeuZ85+wyFk88AXN/ijazKS5W01BlOVXP7g+JlvkKSyax8yyiQ2csnKCubTzf9fCCle8=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6a00:1d15:b0:6db:d1de:6e9c with SMTP
 id a21-20020a056a001d1500b006dbd1de6e9cmr40934pfx.3.1706301248701; Fri, 26
 Jan 2024 12:34:08 -0800 (PST)
Date: Fri, 26 Jan 2024 20:33:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126203353.1163059-1-tjmercier@google.com>
Subject: [PATCH] mm: memcg: Don't periodically flush stats when memcg is disabled
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: android-mm@google.com, Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The root memcg is onlined even when memcg is disabled. When it's onlined
a 2 second periodic stat flush is started, but no stat flushing is
required when memcg is disabled because there can be no child memcgs.
Most calls to flush memcg stats are avoided when memcg is disabled as a
result of the mem_cgroup_disabled check [1] added in [2], but the
periodic flushing started in mem_cgroup_css_online is not. Skip it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memcontrol.c?h=v6.8-rc1#n753
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d7ef0a4686abe43cd76a141b340a348f45ecdf2

Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
Reported-by: Minchan Kim <minchan@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4c8735e7c85..bad8f9dfc9ab 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5586,7 +5586,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
 
-	if (unlikely(mem_cgroup_is_root(memcg)))
+	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   FLUSH_TIME);
 	lru_gen_online_memcg(memcg);
-- 
2.43.0.429.g432eaa2c6b-goog


