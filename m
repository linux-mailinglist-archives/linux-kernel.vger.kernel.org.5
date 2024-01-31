Return-Path: <linux-kernel+bounces-46533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC1844102
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7C51F222A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCA880BF1;
	Wed, 31 Jan 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZKdtYYw"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E780C02
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708993; cv=none; b=fIudsITMwy2y6KOrmHCqs9rIV/xpp+OuWrskR6CGfnvuJAO/M/eKs7zwCBjEq+CQsgkAN8feZsz72SpSL0JUkImnKlolJmbkebSash++yxGzXKPyJDlJhAVQ+to4UfN4UskZ/7hzOTuiCzedTi/nHZU+kxRq5X6L6eN7jGU3O+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708993; c=relaxed/simple;
	bh=ukGaeKDWoBnc0AIrKBff3Y2VDwj+LfqCpXcFKMzADh0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SHvbYQew1UixxJbnhw8rRUgsvbjHuSCroQejMvSeKMgm4QlFiHzcgxCH1c/9ij2b73jFSLI049xmhvknIKTPAc7HpOs+clbUsuGtyGmuCyNKjNRMFYigd3NKJ9ICTPris75FAwrlBiTOiEINs0TNdihiQ/v+PJtWausL1VccAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZKdtYYw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2685ebeso157042276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706708991; x=1707313791; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1xH5pJjJI+heTB8iMmEvxa0X+0fNgErrr9gRIyth2g=;
        b=pZKdtYYwGGRsPiP08F15caI+c6LBZLallcC/2/vXbA9E854ELOwGizx/BqGJpW/z9H
         jjzDA3Rj2SnRORqR1kjejjt1e98pcbdFPlX4BpehqUhyUpl7DjaEmG74ZXY5Xxkb1mR/
         k2gy9dxQEFZ/mUrxbiyjb8B/jEiKqCaic1ec5IqxXbnDUvREWF3TwYJcvzUQZExzRaD3
         jXZMnxqRjas3XTUE2LqBrtRAFcztbN4y+GPZMcrscpOyp0s9+xrn7CM6077+fKMHzttG
         3Zc5WduNLC9TMcgvsYmwKfcnSTswtcLXrHScHGkJHA7+eKvLwFr7Hw5KbKWkuaMixfp6
         3z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708991; x=1707313791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1xH5pJjJI+heTB8iMmEvxa0X+0fNgErrr9gRIyth2g=;
        b=CDhM0hLyAnG0PbfeSk6ZuOjMV/4SK4Zb8vNW897VMzQ44P/nbd36tvMV/f8rizGcjZ
         fbWCW0F+3jyfzoFNWiLvbkHY6RE8+eZkowzO2p8c8M7xAtxp2AXHxpnBClbsQvQehbf9
         LficYNPXup0FJkvNb5O+z7aezlxCEk2ABYHsrJW5D90ubHoPrHS1CGjUWkdC7X1tIGnX
         VNFAM6Gt22/KvezXJ7iaADMav6JXTgEIJDIm9MNB4+lIDjUcsgJopKr4d2XqcuJejCWz
         x2whJnI9HxA9Ju9AFpK3t990u9dJI9g2+ODHAxed7GwwMsiXOzZxk7+/9LVNoptLPKXI
         ImnA==
X-Gm-Message-State: AOJu0Yz2c9FOnzVwxWFnA4XPJTMZcrAulivO+OlQM0xLKJPLJE33Uli7
	x/upU8+1t/89La/MszobD/c7Flpxlh+u3u7BGmYCPNOZh+Ms9rTRi4a8B1e4b0vRa2vlecNdOTK
	UABbfNQ==
X-Google-Smtp-Source: AGHT+IHR5aWjJcPzg/siUBKUE3xk7nW+7LrhEkyMp2WgpHhmdN58mrCawphKGWtu584LcMbdtl4BNhPqdugW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d0ab:43c6:7969:62ab])
 (user=irogers job=sendgmr) by 2002:a25:820d:0:b0:dc6:cafd:dce5 with SMTP id
 q13-20020a25820d000000b00dc6cafddce5mr165356ybk.12.1706708991052; Wed, 31 Jan
 2024 05:49:51 -0800 (PST)
Date: Wed, 31 Jan 2024 05:49:39 -0800
In-Reply-To: <20240131134940.593788-1-irogers@google.com>
Message-Id: <20240131134940.593788-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240131134940.593788-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 2/3] perf parse-events: Improve error location of terms
 cloned from an event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

A PMU event/alias will have a set of format terms that replace it when
an event is parsed. The location of the terms is their position when
parsed for the event/alias either from sysfs or json. This location is
of little use when an event fails to parse as the error will be given
in terms of the location in the string of events parsed not the json
or sysfs string. Fix this by making the cloned terms location that of
the event/alias.

If a cloned term from an event/alias is invalid the bad format is hard
to determine from the error string. Add the name of the bad format
into the error string.

Signed-off-by: Ian Rogers <irogers@google.com>
---
These fixes were inspired by the poor error output in:
https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
---
 tools/perf/util/pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 355f813f960d..437386dedd5c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -657,7 +657,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 	return 0;
 }
 
-static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
+static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
 {
 	struct parse_events_term *term, *cloned;
 	struct parse_events_terms clone_terms;
@@ -675,6 +675,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 		 * which we don't want for implicit terms in aliases.
 		 */
 		cloned->weak = true;
+		cloned->err_term = cloned->err_val = err_loc;
 		list_add_tail(&cloned->list, &clone_terms.terms);
 	}
 	list_splice_init(&clone_terms.terms, terms);
@@ -1363,8 +1364,8 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 
 			parse_events_error__handle(err, term->err_val,
 				asprintf(&err_str,
-				    "value too big for format, maximum is %llu",
-				    (unsigned long long)max_val) < 0
+				    "value too big for format (%s), maximum is %llu",
+				    format->name, (unsigned long long)max_val) < 0
 				    ? strdup("value too big for format")
 				    : err_str,
 				    NULL);
@@ -1518,7 +1519,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		alias = pmu_find_alias(pmu, term);
 		if (!alias)
 			continue;
-		ret = pmu_alias_terms(alias, &term->list);
+		ret = pmu_alias_terms(alias, term->err_term, &term->list);
 		if (ret) {
 			parse_events_error__handle(err, term->err_term,
 						strdup("Failure to duplicate terms"),
-- 
2.43.0.429.g432eaa2c6b-goog


