Return-Path: <linux-kernel+bounces-49243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E38467D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB428D587
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911717BAC;
	Fri,  2 Feb 2024 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoIRlQsK"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE6A1774A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854558; cv=none; b=FPKN5D51Iu5gX7qoe3R9Rs9dYJfw/k+vvElyU3VS+jfhJyyil9/wu8k860r12AKxLN03aDsFqcDXQ54awgBxPrCjGm6mZuj3jC1tFpsVGxYHcjPYK6a8pm3RMypHEt37z8/qgutQba+9p31J6uKYC+neVvlYVQz9Ncl5dHXccRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854558; c=relaxed/simple;
	bh=DaB8vTdXvQNZKpQ3zmCJbz1kO9aEvxkRfoyVK91CF/8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Nb+LC4y33YBd8F+s7IuydGIGmbIwi5Iqv7JP+q1IzIZMED6j4YRHQec5Ayp94mrRKDVQ4kjIms4Nqw0H4GvUzKM5pFI9zauOmZOeL8+s7VHdTrMlW6wcUDvcRdFXPhBGfPIxV+mn83699xReVx2nhY/6h8kJ9mT6DELeA4B7DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoIRlQsK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so3113978276.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854555; x=1707459355; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1NDzPJDQoypR+FtlykBmPEdE/4vIPaLTqPNnIbkP3o=;
        b=KoIRlQsKE20SUL48lWyZvfQmqDsCbSlEExODvgMfICbWuHk4PjCORHQecoj3iv8baa
         l0PxQihrApQi8ZY4jJ8glRfBnTwE1oRdBp4JshMO+mqxvUij2RdFnY5wNOh0mcg95Fje
         Eza60cebkrHbcIDkOnleMalvGl1aUTsYi0/FNb/s7fV7C2baAP1wFZy+VZJeuL9t+Sbo
         JCacnOfh3CQIN8AaL9Jr1dERw+sE4g+xWR23qb+e1pHZvqNt5Y1Djz07mF3EQFUkkVl+
         sFH025fVuUcVtCdVhIyknPFz+CKJXAbOH25aRSFoKcHTqBt/Jj41h5GEzBhKMAebUige
         JNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854555; x=1707459355;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1NDzPJDQoypR+FtlykBmPEdE/4vIPaLTqPNnIbkP3o=;
        b=RBOCv1WL7L9uZCdQYN4VfvV1vnVb0Fga5UwQLhE3WWPtaoQDDEIe7wyjBBhEV4V6KB
         uwAk5asJGNKVGf99weLTREgV30Lg+XDX3qLrEPsZ3H7kJwxcjJHgYeVblEPoKlNejhmK
         VaNhdn2eBHd4PxJbVWoN6OHkukWv+ENoFOm5clIYIFAii6lAFLw3CtkdTIXNJZdq9A/P
         t3dVLKzzXwSQR7LCgqo+lFOEpoVLls9PArpJrifgjjoV0OudDKhE6ktMkfuSUNZKThw5
         zgUqia/eFI5u1mC4uwCBfjH8MmBz8PkGCPZJBaR7Xc/nrnfZcBHt/Uu+NjPss1fjBd9q
         c05g==
X-Gm-Message-State: AOJu0YwKQrCnXKeDBFqS3ND0W3aKN0bKNYMMf728c8/1kpGdLli3jMur
	hm4G5TQZhZNNTorqOntq/1g6AY6PEaq2ABidjDh21JS/Q9JbUf5LJApu5QQzkF6Z2qPAzCC9FUv
	lmxuMHg==
X-Google-Smtp-Source: AGHT+IEdn3eFJFcsAx9byY8lyiQ9DFXzQLhh9fr4pbXsLWEMjpduRuO2BPnqszGLbRoNgT9IBwBT4qv0ABMp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:f0a:b0:dc6:d3c0:ebe0 with SMTP id
 et10-20020a0569020f0a00b00dc6d3c0ebe0mr1158215ybb.0.1706854555663; Thu, 01
 Feb 2024 22:15:55 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:11 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 04/25] perf maps: Get map before returning in maps__find_next_entry
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

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7031f6fddcae..4911734411b5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1761,8 +1761,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 489072bebb5b..75e85c0e04bc 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -956,7 +956,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.594.gd9cf4e227d-goog


