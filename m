Return-Path: <linux-kernel+bounces-88937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C386E8AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7709B1F25DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE139AE7;
	Fri,  1 Mar 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWNuBcRr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550B1E88A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318868; cv=none; b=b1CPql3Gobhvm0zXfJ/g17GNm1PsLdF+vniZR/Vs2bP3s2olfCQJbpqOA8EnWTwbjXqG5YyhDQL9DYds88zpXsrhCtrd35XKdY3FlNrI1/Y7mmFZ6qfqx8VcaQwRnyiFlMjYXIMsC8zSTChqlETF3buuJ9J1OCS4GunCFru3iKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318868; c=relaxed/simple;
	bh=DQQ+QjV7agVFDhvoUe21j3cUPs2rdBxdv3FtjoIPynE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZhsvCKo/8fkAQdqoxQvGknaALG483Nv2LnkSWJ+slvfncVu4g4AFVfROpBcWzFZIKWiuvOelZrGZ39GOjxDYWwVeF/L9DNZVa8esBLDq5HxqzVC8c1FJwwyiHJ+/EzwClZAuvWFwFlLaXObqlu+jxD/SvpTzBpui/lVSCPT4GVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWNuBcRr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60971264c48so30977717b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318866; x=1709923666; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cDfLfmopcTxAX7srrqB38twG7xayEXswr7ukOhJpmH0=;
        b=lWNuBcRrHTPK7SMiqmaxGXMIQdlgjdx6CJymJDHHjW6P2+rXt8c+lCMZSor2RTG7bU
         Soq93GMh0GL13WCqQZXogZD5wj0ajaz5lY+lD225XG7MKPEFFT03nER6rg+jXwBNH93p
         o370U97gYuiMJHURVlPtjlfm7qrzt6E1LAkKgPuOAUJT4+Wd/QeZdmeCT2I6qtKch1Gg
         K93EHi+6Iae7jW7fT6lTubHQcTIOvaNk+ai4STfZ+km+DGZnAAJm8lwC0EVqNB6vRgpy
         YzaS8W34LXBucbdbJfBNyfYr0buAbYp/A2ehbv9CaeWzDk94ECJ0oyVG8+DrrKOrTERP
         3r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318866; x=1709923666;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDfLfmopcTxAX7srrqB38twG7xayEXswr7ukOhJpmH0=;
        b=cKNe61USKr241bkhBsrH1j4RXxuiZ4TFc1SdwLT/vvFlJ73tTovA+FmBb6tmm7Jwcu
         NHRU0mMoU4Tu/Dcmr7FudfeAI48apE1RDZ1I6pT8SWQqSpBNZmas++Asy37j2pDsN3Nx
         KpXE4wQKlW1lCPbN6XFhcAg793IzY9d9dyv6MkNygZxATZwJNwlCaXITS5/cB2C6KOzg
         aEm/+dkhLlEDAfpKDA7kPLj+pSbJub+DrnoinmQoPXyJraj402fHmmpgWl5CRZpP8F10
         MMldN96efLuZufDj3VXJk3b6YdikdsodLvDXpQXLfX1bnlEzXvzxD1HT4ETfpF1gWK5t
         MFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn7+cybz3P37IXh8A+uam+cXwsscTt1YDqDyjOiGhPsXoO2MOvAlhvhet3V/P0snyrBcdmnFW9LZIVJoRsrSm0tfXmq3ZXedC/Od0N
X-Gm-Message-State: AOJu0Yw0PqrBh+8slpIlHWHpp+RzGSjvCAv5VEGIptQVLRT1uztVGoRu
	FPyI7uS0YatS3nBH2CyULilA+OBm4bJ/q6FMy4v6ten6igmBeboRDTjSE8VPpJ8Dq12gJr9FHF0
	+cTAuRg==
X-Google-Smtp-Source: AGHT+IG8ZKTGL94OdCtP5Ow9hj146uZBztJ4hvxB8c+YkXjVohYXP/DP30P2kjBPluznO+1WKZcbE9KP82Qd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:3386:b0:609:3844:ecdb with SMTP
 id fl6-20020a05690c338600b006093844ecdbmr445009ywb.6.1709318866243; Fri, 01
 Mar 2024 10:47:46 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:25 -0800
Message-Id: <20240301184737.2660108-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 00/12] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.

Ian Rogers (12):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD

 tools/perf/pmu-events/amd_metrics.py | 623 ++++++++++++++++++++++++++-
 1 file changed, 620 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


