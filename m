Return-Path: <linux-kernel+bounces-50920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0B8483C7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAEF285D16
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5610795;
	Sat,  3 Feb 2024 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1P+lO191"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB6101C5
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706935577; cv=none; b=pWc7oL4SE1jj6+JfFPN70dWeaAqSoaBjJJGuwTWEnNhjfkR/+k+0memfD2SFSdkybUS/qDrnVNiBGtZkMSpLbtwqmNi4KCJbYT6NLyqWlTbXftFckKoNXHN+jdzqtm0BUgBM4DrP531i0R/H+goziDdL3BTFcwolg/zAC3xyWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706935577; c=relaxed/simple;
	bh=1uujFxMT7rMTPcIYZAAP5fuRR4EOncinGJBVCVidoCc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GebPRcLN3u15pWwHzQ3Kmkr5rPrFGuORhcn9cDrPEgQjHoZExCaFIcTWJ0nh3HOaDBuJgLdCqWTS83Kwo1ts1xEgxFE2O7nnqW9Kq1KHbwBaKaumOdpzyBuZlZRmoHCyMlWKjOt/A7Aqf6XtD8P63kRJzAQZniutRNZA4eT9EEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1P+lO191; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4612165276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 20:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706935575; x=1707540375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIjjFEohc7BizHW5snB3BX6UTrsWYnDTvUNfCUqP8fo=;
        b=1P+lO191PBjRv5LBilrKJMTxBvBjeZ2H6ayg9mNcif0SPYxW9wrTwlLPZI3NxKRRcH
         Tw5dKKUI/9s9oNsszIUgVIOCtZ6xyE9/rCgQHVRp2N+h3S229z7Hd5kH+AIcxh9FOwUd
         Rc84pmdbBC1wQCHWMi2SWBKlSL9d9rZq7filKe/uLVlgFdyc4gx3FnHhGgd35dTsiSfA
         B3k4Su9K94HJsWzrusgEzfmnlK2MJs6dU6Rn1FtsA5OdopYmr3wT4RIgsPVPgqfkgxs0
         FuiQVxKYkue+BvPx/q7hkd0lI8JuHbYuAUvl90kGIpSiQuUDvRRO5wYdPNEOhU311ntC
         ZDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706935575; x=1707540375;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIjjFEohc7BizHW5snB3BX6UTrsWYnDTvUNfCUqP8fo=;
        b=GzksOohD69LpTGjKuhHl6H7dfsw4ltlcAttzv61PnC5KmddzlveDnQkXtz86jFKYhj
         EK8oeTZKM5SUaWJkxFN9pGtVmksH0AeBvSoT30TdEUj02R1Q7Q+t2JHGO0+4iUq+i5g6
         s7Uq41v06gIvp0ZdJLnYHtywkGtc6LXIUpwX4FitaFQFJtaQByiI10NekdQm+U2qBeLB
         w0G3Uu1KhBjIket0kJ4FAoq64OkNBHO+QJkrWSP0Igs/NScqzp9bJ3J0O+xc4brzMxFS
         WD6r6rMc5dhAAhiHfyePcYCzoAgC/sHug9GrYZWeSDjwWFhdh35mlV/14+b6469Utw7M
         p+FA==
X-Gm-Message-State: AOJu0YymRs7kgdWgPieM8kTbDL/7fjVoD+7YdxvZnsUeUS1r3rv291gV
	Cprl6QsrDTITZMt76J9Td3125ee3vA/FlTxXfqR/QClO727hiZZDiIcEusG2E4fuawrdwdwCD3c
	2L0S0/P4O/cBVVjUevg==
X-Google-Smtp-Source: AGHT+IGAenCSeE/ByPCnMPf0P8sNA6h6ocBEKdDYaJFQ9TcJgAm0rONYTdeZI9tq91q/gs/t0jXDXM0Zkaj7OSD5
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1748:b0:dc6:f21f:64ac with
 SMTP id bz8-20020a056902174800b00dc6f21f64acmr761350ybb.12.1706935575018;
 Fri, 02 Feb 2024 20:46:15 -0800 (PST)
Date: Sat,  3 Feb 2024 04:46:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240203044612.1234216-1-yosryahmed@google.com>
Subject: [PATCH mm-hotfixes-unstable v2] mm: memcg: fix struct
 memcg_vmstats_percpu size and alignment
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit da10d7e140196 ("mm: memcg: optimize parent iteration in
memcg_rstat_updated()") added two additional pointers to the end of
struct memcg_vmstats_percpu with CACHELINE_PADDING to put them in a
separate cacheline. This caused the struct size to increase from 1200 to
1280 on my config (80 extra bytes instead of 16).

Upon revisiting, the relevant struct members do not need to be on a
separate cacheline, they just need to fit in a single one. This is a
percpu struct, so there shouldn't be any contention on that cacheline
anyway. Move the members to the beginning of the struct and make sure
the struct itself is cacheline aligned. Add a comment about the members
that need to fit together in a cacheline.

The struct size is now 1216 on my config with this change.

Fixes: da10d7e14019 ("mm: memcg: optimize parent iteration in memcg_rstat_updated()")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1 -> v2:
- Moved ____cacheline_aligned to the end of the struct definition as
  recommended by Shakeel.
v1: https://lore.kernel.org/lkml/20240203003414.1067730-1-yosryahmed@google.com/

---
 mm/memcontrol.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d9ca0fdbe4ab0..1ed40f9d3a277 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -621,6 +621,15 @@ static inline int memcg_events_index(enum vm_event_item idx)
 }
 
 struct memcg_vmstats_percpu {
+	/* Stats updates since the last flush */
+	unsigned int			stats_updates;
+
+	/* Cached pointers for fast iteration in memcg_rstat_updated() */
+	struct memcg_vmstats_percpu	*parent;
+	struct memcg_vmstats		*vmstats;
+
+	/* The above should fit a single cacheline for memcg_rstat_updated() */
+
 	/* Local (CPU and cgroup) page state & events */
 	long			state[MEMCG_NR_STAT];
 	unsigned long		events[NR_MEMCG_EVENTS];
@@ -632,17 +641,7 @@ struct memcg_vmstats_percpu {
 	/* Cgroup1: threshold notifications & softlimit tree updates */
 	unsigned long		nr_page_events;
 	unsigned long		targets[MEM_CGROUP_NTARGETS];
-
-	/* Fit members below in a single cacheline for memcg_rstat_updated() */
-	CACHELINE_PADDING(_pad1_);
-
-	/* Stats updates since the last flush */
-	unsigned int		stats_updates;
-
-	/* Cached pointers for fast iteration in memcg_rstat_updated() */
-	struct memcg_vmstats_percpu	*parent;
-	struct memcg_vmstats		*vmstats;
-};
+} ____cacheline_aligned;
 
 struct memcg_vmstats {
 	/* Aggregated (CPU and subtree) page state & events */
-- 
2.43.0.594.gd9cf4e227d-goog


