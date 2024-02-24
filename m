Return-Path: <linux-kernel+bounces-79405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C003B8621A8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3A91F266E0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ABC8F7A;
	Sat, 24 Feb 2024 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YycqST1M"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9776FA9
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737278; cv=none; b=Y45h/2fcI5NAjzPWPCeDKVwfletFqXz9fTbcbbqYwlipKwx4mLvltqz0DlN+OG3bu4sE4k7LVn+xlxK0bBz1ZAJAgv6MiHR6HuWR8nnIomA7xlr5zfAJHDoZdDpHANyj23Rzl0XcakgouCQ0EH+hW4KKOzPFXX83ifUlejRrtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737278; c=relaxed/simple;
	bh=XueJjsnWsBuj0mZHI8nibC04MzRPfGYeRVMOYJGX0is=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qdBSJftUnjwt5qAbG/g+rIozKTTNYk48VpFd/DUB10iGVI6RnTAcEMnkgZsUO1D2TcM/ZR9pvnH78B5sGsOXc9FBf04WCZ3gvJlIhARpniQMfHw2/lZonvSJ6vsoZguZ1iPVPV6edPfQiPP/zkIiqHmX8e7/bDgKcLO1ZBx5G/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YycqST1M; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e613a1baso18543017b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708737276; x=1709342076; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+YELOrJctqfBDK565STy+1m3qLbN+ispRcJAtvKeFk=;
        b=YycqST1M0NOy4vYKBn+f6sL5ZgrF3JZLPe2fNamoC9GK7lg3wgLLXYrGUKIkRP3sH3
         o0wM4ctafyhhrhF/JA2w7T1fU7fCSLe/8geh7eACdCnu4Gof4k3kCn2EyRt0cRcIdTEv
         9OcvlWG93UBPg0UWVjx3eaWPP/dDAdop/Jy9ZeJqr4GrYt/Rrv6KnKZPa2c2CPu/cTSd
         XcuRJi/laHTyGcfW7R7HBKnE4EyoiVqbf5oJwG+WLQQO5o0warBiq1tVPdFjgIfON+0a
         fg/XN6g8MDsAVNuZX4iUPf1Z6HjBU8m85cMOx+bkpY28yfqT5Tj4Mez19EJjVgwsv9mL
         1xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708737276; x=1709342076;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+YELOrJctqfBDK565STy+1m3qLbN+ispRcJAtvKeFk=;
        b=qnpOjzXskzb7+0AOrbJ6VvsVtWJvHv+v9lEZBi7PY8oHFybdOuvaKhAC5yjaDATZ42
         Dy99Syb57cS2tGIWgdgflhjHxAjN+aRolzAr/5IcJQhPL1sd9PxzwN15fbcZ8Ur0M15x
         u04KOdVN3vRvLR4tVLhS4uZ8SlAu3+siXbvf3nTh0Suogra7YxWI2X9v7d1jFKtfnA+d
         fbp5yzDOCnvuuQrwR39VleqfTZ9rwS3XhX3ham2JLB9y7cb9Moz9XEa7jU8jSCYB8Rkq
         wqxw2WMOkcIjJu9fU9wujtpF+U6WxxqVRy9tGy0UngXiRxERvccCrvy2ipkQoCirwuo/
         4f7g==
X-Forwarded-Encrypted: i=1; AJvYcCVQuBSFIFWQdvVlacZoYSr5j5cxPVm6Te2t868Pfdi+owem9Ue+HUZzj0yaoZwKE1QmKxCjZFT9mt7Io1PF2RuzjiirXLD3wZNiF17h
X-Gm-Message-State: AOJu0YxCUgnMmsO/LUrB9GwgFfcN77lBZFR+4epz0FTPs/U0+t6ikKxb
	CpEKyBUbOLhrY3QZhipc/nsqeesJv/D8ehMdECCipzSLL6PuGJuWCvYBB2tGieagGget03x1E9f
	T33ZkJg==
X-Google-Smtp-Source: AGHT+IGOFSwDF96U+oZnXcs8GXW7FnIY7FN7qbMOXBfE1wQ0lPzupUOj5R5YIbQ6mjxgr/b8Xcpb5LJ9oa/r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3cf6:588d:1bf:3fa8])
 (user=irogers job=sendgmr) by 2002:a81:4f0b:0:b0:607:f6f0:bdca with SMTP id
 d11-20020a814f0b000000b00607f6f0bdcamr353865ywb.7.1708737275907; Fri, 23 Feb
 2024 17:14:35 -0800 (PST)
Date: Fri, 23 Feb 2024 17:14:20 -0800
In-Reply-To: <20240224011420.3066322-1-irogers@google.com>
Message-Id: <20240224011420.3066322-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240224011420.3066322-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v1 2/2] perf metrics: Fix segv for metrics with no events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A metric may have no events, for example, the transaction metrics on
x86 are dependent on there being TSX events. Fix a segv where an evsel
of NULL is dereferenced for a metric leader value.

Fixes: a59fb796a36b ("perf metrics: Compute unmerged uncore metrics individually")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2d6865c392ef..79ef6095ab28 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -44,7 +44,7 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 	if (!metric_events)
 		return NULL;
 
-	if (evsel->metric_leader)
+	if (evsel && evsel->metric_leader)
 		me.evsel = evsel->metric_leader;
 	nd = rblist__find(metric_events, &me);
 	if (nd)
-- 
2.44.0.rc0.258.g7320e95886-goog


