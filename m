Return-Path: <linux-kernel+bounces-49245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40F8467D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0942E28219F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926418027;
	Fri,  2 Feb 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmQziLbY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C81755A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854562; cv=none; b=kRyxsgiaxfXyPkKrHBLzHj+y6WieYDA2lROi4vTcUToVH/rqBCWOn54G0tZPTmxBzTbfT+EoQbkcrbm+4JB4lIsnADCbT36JbakFe9cTHiIPgcDNnQG8+cQPZwGe7kfjkqvWEbEr0JOmAdWIB1DOpWVciHUfiN3nul7Y9DJwEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854562; c=relaxed/simple;
	bh=8s9pvXR/dJ4oS1alnHLZ3B/RdRusn7pUE+bkSp22vOk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YwNtFzcR5EJgmUcIyEV6thWf4iz4ku7yiLHZ9o5t/cxAXBk4YW33cfWDtoytrwV1Dxi5zQk1VVu8PsiK57iXX3hjdrxLO+mimKuVxktNQODVvMVz+todphWRNHzy5krHuIisjO3jxz9+ze/yw06lCuoViOO52+2/M9sHxed15xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmQziLbY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so1005120276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854560; x=1707459360; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtgvpFVCeAxfBLC1ay05GLymu1fr0pRRLiLlSBt0YmA=;
        b=SmQziLbYIXp3B16LvdMb/KufFnTDnU6wkgdxeaYTnlSpdH1hXEVaHzerxvqGhYspyV
         oo4stUf8s+SqXnRBKacAzX11GwcHYNHdO76K6Je+MjHEyJNFjs5c7fPn8a1mcmCsWSwK
         bobU5hnJuERN8LNTVMR0wwbZrUVQBeHSSh7ZR7qcwqB/9PBjNwwYGg8HRXYQmQBH1YT1
         gSDxU8AxtkQF7mqzu18HyDfspkMsXrpCy2FiMzCmpozpqrC1gkOHgnyOuUp69jjLoqab
         2QugJrXocAPCdctGM1RPcDPBz9C24N8R1AEnPGQVVjgvGu9J7hw4pvUMKQWo/jdw6B7G
         o/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854560; x=1707459360;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtgvpFVCeAxfBLC1ay05GLymu1fr0pRRLiLlSBt0YmA=;
        b=aqer77izX3NdPQ/+iedy26nBhCxkbIzftNoPkN5rcUDUHHV/xr7CQFfbnE7h3ASF5A
         KqAVuI16bkPhJTFIXviajNM+vKowet7zwfLQgFvwMEJlbX6f9kqfVlIFf81KInW2xqK/
         Z3u9NhtQASxOJZhIhZ23OreOz9ofPeN7kK0aOu4CRRGIxLlxJrg94Pz0wYPMl9SncsP0
         H3WNFEid7p61Ep6jF1U5LUMcwBy3Zafs13yg/5n/rNhEEfW3s3nBaI/qNs5Fx6yFwdkq
         32gwv5dZAvyFO5AYNOwh6mWbsz7Yqwj5/n5zRM0XRoOcgR26P2B34d3/Qh4154fdZIW7
         P0Dg==
X-Gm-Message-State: AOJu0Ywn83lFTkvz19hfTvSN5fUxukiTzXheKx/sjOaDCefbjLBKRiAW
	KZ/+CCyURldaOkFl4NrVjmBTrmt33o9vebZfZpecFYEQpi4+UKEI5QTBbuwUlpvB0b+2GHoiHpN
	M/9+0bQ==
X-Google-Smtp-Source: AGHT+IFVty0KcH0Mujt8X3fZO7GReBkJDiSZxq0RCAAO0yzK/ql0lYBqMJ3+4PB/2SrOhRZvSHmtSdivYdhO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a25:b28c:0:b0:dc6:ddb9:14ad with SMTP id
 k12-20020a25b28c000000b00dc6ddb914admr242339ybj.0.1706854560075; Thu, 01 Feb
 2024 22:16:00 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:13 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 06/25] perf maps: Locking tidy up of nr_maps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

After this change maps__nr_maps is only used by tests, existing users
are migrated to maps__empty. Compute maps__empty under the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c |  2 +-
 tools/perf/util/maps.c    | 10 ++++++++--
 tools/perf/util/maps.h    |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4911734411b5..3da92f18814a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -440,7 +440,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 		return NULL;
 
 	/* Assume maps are set up if there are any */
-	if (maps__nr_maps(thread__maps(thread)))
+	if (!maps__empty(thread__maps(thread)))
 		return thread;
 
 	host_thread = machine__find_thread(host_machine, -1, pid);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index c3d91e5e9cae..d5db1f284dad 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -541,7 +541,13 @@ void maps__remove(struct maps *maps, struct map *map)
 
 bool maps__empty(struct maps *maps)
 {
-	return maps__nr_maps(maps) == 0;
+	bool res;
+
+	down_read(maps__lock(maps));
+	res = maps__nr_maps(maps) == 0;
+	up_read(maps__lock(maps));
+
+	return res;
 }
 
 bool maps__equal(struct maps *a, struct maps *b)
@@ -865,7 +871,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 
 	parent_maps_by_address = maps__maps_by_address(parent);
 	n = maps__nr_maps(parent);
-	if (maps__empty(dest)) {
+	if (maps__nr_maps(dest) == 0) {
 		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
 		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
 		struct map **dest_maps_by_address =
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4bcba136ffe5..d9aa62ed968a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -43,8 +43,8 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 struct machine *maps__machine(const struct maps *maps);
-unsigned int maps__nr_maps(const struct maps *maps);
-refcount_t *maps__refcnt(struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
+refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
 void *maps__addr_space(const struct maps *maps);
-- 
2.43.0.594.gd9cf4e227d-goog


