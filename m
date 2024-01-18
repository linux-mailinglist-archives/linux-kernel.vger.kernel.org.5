Return-Path: <linux-kernel+bounces-30482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E9831F34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C192EB23614
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6E2E3F2;
	Thu, 18 Jan 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMdtktRq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C72E3E8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603360; cv=none; b=UuvP7Zw527XQrO3dd7/5ZE8c7V4GoCM/1UeLBW4IpItTu8SmvcUb/Pm6ZcZKGudewMbdyQ/MGIrnCMgAdLOVG5vLc8mEFkNFZbIpxMjt1rroUrp1eeXVsaplSfM2dfSeUT2zoh7Ef4krhSYpqqsuQC5vul1dJcPswDuYITAfkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603360; c=relaxed/simple;
	bh=W6yWw85H3wm9jzeUaOrfwrwakFw21eVoOvO+YQYOBos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VzykaaTo0uMJxK8WsB+ZVVxlMSgDfIF2JrR2iTxGa0ujKipRExeFYnOwyLnPZCnmBoXq3d8xlANJy4ClXoRzyRLvVGOPSjLarBHx9BcxSV5e+R+2XXgiTOrxfBLLQXCwRkkRP7OGlTN3ApcAM3LbsMtic3rsAHRC+tNlxKrmEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMdtktRq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff481be48cso71088147b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705603358; x=1706208158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8yx3MHixu6Yr8K4Tg1W1xt8jDb7qQNzMKngP58qnPGU=;
        b=PMdtktRqJ1Gnc8lPV2zXVo/ZhS+ldr3zp03yaAjH95umJCjbXJP8xiiWsDSXhKy0ZP
         moC4TnRUmtPnPz3nGJs32FW2Yx0Un/pP4HEYTHx24Ci2cC6irlQGCt94Ax9QGW/Ac+4x
         fiti05UZMmvwMEiSt4qv6OCggexdS2l1x98+wUxrR0g233ettGE6uI2uPXBQWBrwHiQx
         qsslHc2B9Q4uNtiivXI8RbMzsmZ8NGeChW9LdrPzEn7j6bpLLDoqWIXggweyv54383wb
         PmkHshRd7RkbU4xMrJY7tpZsd04fJ9H1NmIsYI+QSMJu498MA+sKBy3p2/ZU+E5rW7Ai
         z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603358; x=1706208158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yx3MHixu6Yr8K4Tg1W1xt8jDb7qQNzMKngP58qnPGU=;
        b=YbtxzZIyXVYz0LQ60X9WXlymB0iFD8rFJyQpBvsLJyPYvhzmTUqIgWM0nXHJzjhl/I
         WfsPZdBKIqnvBedr0IHiFVi0JBZGl/20GoNm0oItIirSXTL17mMF/ArJKU4uUP7hHF7O
         DoOLTzHL+IqPWL0Dy+XG0ttzUbY1Bq+i8THMXgBGuH3n/w8xlOLJuOgmzb+reN5vTvBQ
         ePOdEuliztMecMiy+Ux16+hx9NwvmCmTv8aVOyFOUj85CtbjHu97X6Jk/4lR/CiPU4g2
         lK8vaSS4w9HGpOOXcPAUmmGZVhpAnqgVyN+hWTIzRUMjwcicQwve+/CYBKQe8cyiXE8n
         bg1w==
X-Gm-Message-State: AOJu0YxmM+TDzWTQ2ak6vIc9ZTdoBgmO3xFtb9vbGh5fPNdC/ZV4rEeq
	gBNHxZDeuuE+aWjUESb01K/bVLoXjDZyI7pf9kQf45+IZ7hHOcyWJTn+slw7ge6GwudZcSnPpJ1
	T5zHBybfkOA==
X-Google-Smtp-Source: AGHT+IEiDX57atHRS7CWMR0FbSJ0cy4u58/JtLsH5ArVXLFG4dxXZERL658Remh0yZ2IAtpTFDXOqk/HVtek6w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:98d4:0:b0:5e3:fb36:ccb3 with SMTP id
 p203-20020a8198d4000000b005e3fb36ccb3mr584697ywg.3.1705603358687; Thu, 18 Jan
 2024 10:42:38 -0800 (PST)
Date: Thu, 18 Jan 2024 18:42:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118184235.618164-1-shakeelb@google.com>
Subject: [PATCH] mm: writeback: ratelimit stat flush from mem_cgroup_wb_stats
From: Shakeel Butt <shakeelb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

One of our workloads (Postgres 14) has regressed when migrated from 5.10
to 6.1 upstream kernel. The regression can be reproduced by sysbench's
oltp_write_only benchmark. It seems like the always on rstat flush in
mem_cgroup_wb_stats() is causing the regression. So, rate limit that
specific rstat flush. One potential consequence would be the dirty
throttling might be decided on stale memcg stats. However from our
benchmarks and production traffic we have not observed any change in the
dirty throttling behavior of the application.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 935f48c4d399..2474c8382e6f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4776,7 +4776,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats(memcg);
+	mem_cgroup_flush_stats_ratelimited(memcg);
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-- 
2.43.0.429.g432eaa2c6b-goog


