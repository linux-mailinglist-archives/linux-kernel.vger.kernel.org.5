Return-Path: <linux-kernel+bounces-59964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F284FDF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C969D28CD3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453618E07;
	Fri,  9 Feb 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LewBizmV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9C15485
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511818; cv=none; b=R2vAdsqLj05iMTmHGh2O9RBucQuswittJKDaiMxm9ztxlKKVA7lbbxGbVtGvt2+ZE0BSIHPHK6aCbM3X5P0D+Zu88HtW+rZBWngIv3RgOGZFZcrh80AGnCNka4Xeb8cHx+QfQKFu3pGmKQgs8qXgRlfuzIBYgUUL2H+0azJ09hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511818; c=relaxed/simple;
	bh=FN1xH7txpWYfGe8oXzu7wp0Df0lMgRHZJT67LPNIglU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZMfOa6UcHNfYV87tymwYchQmZZ5KMWqE+QqVy4YLRwgk7LH4JLkBoLxytg9xW0GdOgG+BYVsOdEE1eDR5wO0sJdTzuzAekCw3pC5F8HwjhZ3ri1Em22clTa/TISLJwQnRLrm6vdkk3/e8+XSb0r5nZ5UlknNG4zfAu9VmSRMsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LewBizmV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269b172so3194833276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511816; x=1708116616; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBdjorgQB0gt1zgRALPto7TpPrhqP+5PDX20bu5pfxU=;
        b=LewBizmV3f85bnm5XnNTMrsb6wd4bKnUbo2UeCWJCHCqbmnGvOxlAZ15l0DIYFxFl/
         CPBIGBzRno0n6DJz+9eFK6I02sBVwueMzR0I3qH59KT54tFalKPz31ylLZm4jqVcFW8S
         6VOB+oEHsP30+eJAFq0L3QePhh2nn1MngvbtHS6ddGzK3NXW3i3E9fUiHq3iPsmokuwk
         uLLM+TF7F03qEPMWNrY6S+JWezAOGxj6Qf+T6wyVBQQzPtUg4mu4soULBTGUPNax41qx
         eRhl+g86T24DbNfaqKv6E1uv4YIByunJdfzT5BuZ1GjlZP9xqsWopZyCvGidgixHVCZw
         Bauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511816; x=1708116616;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBdjorgQB0gt1zgRALPto7TpPrhqP+5PDX20bu5pfxU=;
        b=dgigybi3ipi1tlbCrcsKsSJbuYseyxNNn8ybUdBo68Gg4eFRVa2Wp3lo86EhKTC8TC
         wybWuK61ymgaRVjL+SPwa6/lNyh259R92b5n6SSSk5TIdjTwDT59Aa+z2fc5wlMPFN12
         Km21FQ6rNpjHYOIIPHejSmnZRz6gl8Ztj5GfZjBym6LykcAskS6Elb73b5XaGsbTgUcY
         qbFXIoL4mWNpwI+E4VHMYJPa1m23wPbm2Ce28sB/RDWMExOH9e9bTjKdThqO8Wl7TSNN
         hilq0ZMy0FsuuYUGQ9cnlytpLY74Ipc9qyhm5hvqIS46D8MyTckCwo8iEWoH38Yx5HUI
         ou1Q==
X-Gm-Message-State: AOJu0YxrZ8BHgatirE/Gh3mNEgRO8aBYTVViHNmC6N4SkXvp3w/qc5Tk
	ZM+d6Ts5EfJu1GPx5CPbkvRutSBcqDz1wVGeRyUKCmIZz1ZASsQzbmpeFLFVLb591h8pQKxVhhg
	670VPFQ==
X-Google-Smtp-Source: AGHT+IGCVCKuACIOU1FX0kOaK8wcfhbRrM75EuyLpzkhf7rKyVv1U4leJ8uARRH2YSaI56YeXEYjmx0YsVza
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a25:ae03:0:b0:dc7:463a:46d2 with SMTP id
 a3-20020a25ae03000000b00dc7463a46d2mr421048ybj.0.1707511816316; Fri, 09 Feb
 2024 12:50:16 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:46 -0800
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Message-Id: <20240209204947.3873294-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 3/4] perf stat: Avoid metric-only segv
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cycles is recognized as part of a hard coded metric in stat-shadow.c,
it may call print_metric_only with a NULL fmt string leading to a
segfault. Handle the NULL fmt explicitly.

Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")
Signed-off-by: Ian Rogers <irogers@google.com>
---
Note, the fixes tag is to a refactor that moved the function. The bug
existed before this.
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8c61f8627ebc..b7d00a538d70 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -560,7 +560,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 	os->first = false;
 }
-- 
2.43.0.687.g38aa6559b0-goog


