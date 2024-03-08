Return-Path: <linux-kernel+bounces-96383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A17875B78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59CEB224A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1382C539C;
	Fri,  8 Mar 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QQ4ZptBi"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE33C36
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857182; cv=none; b=ixifzcvPPQR/fsD6/qI0GN5Rp6TzWUwc3BVNNItzjOxNNlBOXqF9BmxSN9iW37mMEqtQEInKcVHPoKoBrhN+xJrYqA8AK1xs8jGSEoNNUHGZBUiXNKIZt5VVzZjrlM/HsLVvNvcVTUNNS+1siCaWC4LXDQTNn3t/u51FNduLcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857182; c=relaxed/simple;
	bh=kbFBHdCad/TTKVPzgQtSH7M2inFZrQ/NSaJSVlW2wnY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lIikpHnIdC822sfX4Y/5TM5i1P6Unsd4JZT1SYZkP50s9ytgFhoosJ61xPaOakVSqUBaO/ZQ3IzWufEehR2QPQLRLqukyFPtn0kw0kya6tnRTKqRCx+q+r1871lc59z6XY60dmB/GywjTCMrL4a8UHQsKdx9FF9fY4HC/nYMDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQ4ZptBi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so2361878276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857180; x=1710461980; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=QQ4ZptBitK5TTDAKSdCOdFGhIpb55UUs/3U5tVvnVepfGVdHa06+0GZPrX0LlJA5JK
         DThxZ+bWZ0IPOkhKkZrcHJSGFLGkqoStRlWrwsDA0MOZ3MA3W07sT1CJm9gse97kV6Dl
         3XuZgf6fyFw2wViovu5srkfbuxNEJM7Jidwk1YBvNOE24HWmtSwzvks1pebQmtHWf9eB
         Omhw53U1CLQ2IXE5+6CbWkpP2fO1fDJRD93r/wVg2BS3EMiDZ5xG1AvRZuUvHpu1a79q
         Ds6VyVAP8DVpKqc6YFE8JmL/H8Nc9e8nw0w1vhFdTl6CC81kKfF7RO2bgYTyYtoZNn+e
         ohpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857180; x=1710461980;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=PdWbFkISh7RehLHoI6SL0yIvEW1+xsaYfzqUlebiziyoXA/DGsewL6LXO16wlxGGIZ
         pKkMWb8ugdMBmC50iBiItHk/xl36h/YnvL6SrMjl3XqsH7Gnc+XdajD7NJD6vH2Xh5Mq
         Czx9LO5mcPdNEiJNgfa9ldXPQ8oeT39N5wNrxNidMrve8Vg5esSKUaJVXFqTgZF+0lr8
         SNzuXEeM2SeK8/UhXjWOe9N8Bsbkqbe1sm8n5neRacUzkh4lYGsYsRq4ap8nU7qeknRz
         ohKfKb787CqD24S1ozNffqTdcpPEAzXJ/7Jqta3T6Dx1Vc67p4FNMqDs9Pv+eZyXFGau
         gL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOBt6w1XOPLxY0Lpyw72eeFxTlIHhLEvNpLGxvbjkWmaDgZL1CIsdMYPpIDGqvHKyXAP5Qu/FB6eyzOK8CcULWi8QL8Kt36X+ohjbT
X-Gm-Message-State: AOJu0Ywg+yb0QFpktqcGRh8zFgiCt9Ji13jSVLAaeKveuwnkYSy6OwFp
	DRG40VHQOyTGZYQLQcfQygXGTgFOXjpfVqwliRN+mcxVqtSj+lSqwLGWgeCjtd61a7FWtsH0ie1
	RVYHZGQ==
X-Google-Smtp-Source: AGHT+IHztcMIkTIC8gB0elvRFJcsKwcUzsPx2wj83xiF8gMH2QEYPBba6BBXD9kRH4bglX9Pa8g2PDxs21M3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP
 id cf33-20020a056902182100b00dc79218df3bmr879191ybb.10.1709857179792; Thu, 07
 Mar 2024 16:19:39 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:11 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 2/6] perf pmu: Drop "default_core" from alias names
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


