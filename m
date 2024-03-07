Return-Path: <linux-kernel+bounces-95960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB2A87555B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE09C1F22E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0112131E54;
	Thu,  7 Mar 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jXH4eky1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540B13175D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833230; cv=none; b=NcWWja3CHXtB4s7dz0LTdlHXdE9nyJfB7X1pMLVVEu4W0Pt359+N6OMkkUNc4jnTOI42CD9NifigYw37DIvqSHQzOUzd+TBTNGZVTQ6EO6Hl5iCh/1+ZSl0FdA5o8Um8b2Veq42iH+uGjkHE8dAd7ciao7ojR757aji7O0BkvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833230; c=relaxed/simple;
	bh=kbFBHdCad/TTKVPzgQtSH7M2inFZrQ/NSaJSVlW2wnY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=d1KEW3+qTlifUrc5iLZpDZg2Ybj7cpfM4u67uC/3qzFqkfOIz2IY4xYk5eryrOjUtWQjNdye+W0qzCSzWOLtAYXhszNbEnt17VbsWCPlx2VnpURNpb0KEnHssBkqRlZni+GCcC/wCKyFGhrlDhh/Y4ub0iubxBx9UIeSTEmLXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXH4eky1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so18474817b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833227; x=1710438027; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=jXH4eky1aX3eDDpp3cgQ3WLemFoD3qlpwXlLRIpDJzTOP1EIFzdXI5+8OwPcwkDJxw
         HPBPruX81/yjO5CebGAwU5RyXgbHkrURG5mOHpAzcvINgeoCYdTXVny0Qr4EhG2oQkr0
         bSMxdkcNbty2RQrgtS8NkPh0C53JudynA7xz3Ribcd8mluQflxqWQ5ozw8kduo0lbJol
         nCmPGOSj3sA4BJMHtoD3cPod3p1UwFBIP9Y1QEJBFU0kIXQ/1mnQ5xefDF9/kwPvsYiH
         lkqIeo4IC2f1cBOBIdSD95i7rKWfHwtRelrfBlA1iVHLym4OKkXDb0aotpcgQsq63y+E
         kOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833227; x=1710438027;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=xCQF30iQJgM78Gz+yUpad0YeWmAjXdNOfEUh6dpKFUcOxbsWnkBeoUUidL0gpEPeH1
         hHpFdY8IEBt7Ag08WNj3GKtJQFc2EIo0ijC3N6aMD7Tlb3TdcJzsUJ3j4VvqH6XmoRat
         gXnuHbu1abCAJXslnqjWJgsY0xWHoObAW42zWv4quSQ+jW7xXNILOoRSHliG3FV2qPM4
         vQ3UXiwZmlzGxsJIr23S5WznblpKzYmfHpXm/5MNdoDpFvqx+8kD4QU5mLHzhcrp5Pac
         1LzhQvnQVj81ak8WA6uPDkT76gcO8ug86kFpQuRFK771NUGbbnf2UJ/WmcS8dee37FXj
         V/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVgwvanttB0XkumdKrSjcZMhAB5tCiR9FHFWfRTlYlzHYHfas8Zd98MAwK2XutOVXxoL67Pbylt+INsRNwauJFSk8bTBxmnXoFx1+eZ
X-Gm-Message-State: AOJu0Yz3xyFVko47FbdPMd1DvDBow3U+3UxMzdUBnWo3KKQUxx1Wu0aA
	EGpavLA6XETMYjO2IzOvEOd41uxmyk/rpadgGcVSr2D8ktXzv29DFs7pXSoBAqgR+ZvRdnSrQz8
	48LfCZg==
X-Google-Smtp-Source: AGHT+IH8sZdc0d9tNRzSN2uG5lhybBegGoq6WEWX2vIww74GkR3N/VxeT9aT7l441OV/23HQC5uuq7AsGoj5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:690c:3386:b0:609:3844:ecdb with SMTP
 id fl6-20020a05690c338600b006093844ecdbmr4023284ywb.6.1709833227619; Thu, 07
 Mar 2024 09:40:27 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:51 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 2/6] perf pmu: Drop "default_core" from alias names
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"default_core" is used by jevents.py for json events' PMU name when
none is specified. On x86 the "default_core" is typically the PMU
"cpu". When creating an alias see if the event's PMU name is
"default_core" in which case don't record it. This means in places
like "perf list" the PMU's name will be used in its place.

Before:
```
$ perf list --details
..
cache:
  l1d.replacement
       [Counts the number of cache lines replaced in L1 data cache]
        default_core/event=0x51,period=0x186a3,umask=0x1/
..
```

After:
```
$ perf list --details
..
cache:
  l1d.replacement
       [Counts the number of cache lines replaced in L1 data cache. Unit: cpu]
        cpu/event=0x51,period=0x186a3,umask=0x1/
..
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f39cbbc1a7ec..24be587e3537 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -518,7 +518,8 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		unit = pe->unit;
 		perpkg = pe->perpkg;
 		deprecated = pe->deprecated;
-		pmu_name = pe->pmu;
+		if (pe->pmu && strcmp(pe->pmu, "default_core"))
+			pmu_name = pe->pmu;
 	}
 
 	alias = zalloc(sizeof(*alias));
-- 
2.44.0.278.ge034bb2e1d-goog


