Return-Path: <linux-kernel+bounces-89283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208886EDBA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EFCB251C8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB217573;
	Sat,  2 Mar 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xhr/ucg1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCE1C16
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341221; cv=none; b=cwHjq8EH/HST8jvajOq+vgEbqV/IjkxnCb7y/vyynqCpE0PZoIqt7rtP2P5IB7WIxuU5czakHu2tloTJzdDgE3a08hdl4DGWApt4b936tKMQDbKrZMjepf04bepDCHEbcuMrFz19JIvhK+N+d0lSzNoTV8qe+1iNOeJ1FSN2rGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341221; c=relaxed/simple;
	bh=r7EPMWXB50WRmPs6Ybs2X/h0mr+Q2k6sSSuIvq/Jh3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=p1S6SGKIR32+vIdkBqyJRps4wwVGAhSgb9nIM0A1fTgvbj88rhE4mrvqZGklwhCgaWePB3js/URwVMUCN6TueokGb9fSAivVKqOGwcGgut4KTYfvQNELFJZvpgn8bmcHwthzm8jYfKoQbN/Ww/skohU1XKIHiVb/1ah/LMGjOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xhr/ucg1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so3629929276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341219; x=1709946019; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=Xhr/ucg1WzqHMRl4tmdOibBGQNwk518oDN4TEROUxHVsglY/zSmmMxbvN5Eu13nsax
         JUOJCZy7YSPIAb4hw6emVeJd/LJKx6Gwg93F4CCaTm3BmIWYbxSXTPavLJqutZ4BhkzR
         s9Fnliw+3uLd0tOZRQuJaYWuApofzAO5+fAVGMBS8MzHbb/eWEtY8VjFG76ocPc+ufoy
         taEJtRT4I/4UBA5d+Mf2Qsr0aptw9T7vxHzqCvEztVjOlhKkBfaeRHqNX7JwI4wvHTIa
         mPacVLdJXCwzw/gI9ZVbLy25OZgJzbRZXYciYCMt6FaXFpx0JSfkKB2aeO9MjI2r5bwX
         vWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341219; x=1709946019;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=ah0FVJNtoh50XKZ1wriuDyfu4k9w0y9htUSgBN986nRN9u0ybPZErEhqSZVlRCYiQt
         qDcjrKT9Y5C+z+PHQam/jglDXm31pnJKPngCZYOojozUOhYPnyKo6FcX6iaOS+aMi+OU
         7HJfRwWv7ss1TRg3IR8mlyl5yOp+Bnh+SMz6SZMNGhJZv4HWoDHYk9qnksS8i45x5j8L
         4gL5Wu35vZ4tRbUS7OOh/1BOTG6tmqawVxCh+XvsoesEIfRAT4U50YZJDpnk6Gztuk3h
         i090UeHKMotrCaDwylmxJfeQ/cSIaWfQDe22NKpgpECVnmwXrhZJ4jGLtzcGbHfxyEwl
         IKUA==
X-Forwarded-Encrypted: i=1; AJvYcCVHVUPwnXCvVdIw6A3hjfMqajrwOeJPKs1pMmqBjv3i3eSJFbh91+VryYQMwl/QVMu4qlUm2GpfZxVLpdZoriOn/mSR8B/jkVjN/Ksu
X-Gm-Message-State: AOJu0Yy6nr6mErTCT1+Zi8bCjk8pO3O2S7aZ8HWE4SCDdrJsdwHEhp62
	h4J/8RBy0Il4qwP5kpJfH1TkIlCW6fPfCsd54sJ/AAvCez6WrBi8uYybrfzet6Vq60a1gfztSy7
	xCG0kDA==
X-Google-Smtp-Source: AGHT+IG4guLzt+eNWZAQFrcV514Mi43PlUwCoRXQSTCsH1uIyiTwKHP3ri7f8gA9K5LsfJKbD2saZIuBlXnl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d3:b0:dc7:865b:22c6 with SMTP
 id ck19-20020a05690218d300b00dc7865b22c6mr117870ybb.8.1709341219679; Fri, 01
 Mar 2024 17:00:19 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:47 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 65ab03ce5064..55205a260a16 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -468,7 +468,7 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.44.0.278.ge034bb2e1d-goog


