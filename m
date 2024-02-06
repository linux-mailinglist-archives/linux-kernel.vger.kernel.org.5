Return-Path: <linux-kernel+bounces-54262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92F84ACED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC07B23247
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8676977F0A;
	Tue,  6 Feb 2024 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZ7AdCqI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D2762F3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190417; cv=none; b=KGGClSMl2nW140ckJcJHoMu5gJxewitLOZNbry8czV8BwKtth9Lf/QmVSReBaVDoD/0yXE/2L0oHGhxgLlGb7NFQUAHmMr5Bdh4j9Y4gyv5v2ejP+ZTBaJGI66XOXHDRGpira3H6JAwUURGMhfVjGvv+GBSOzescNKTLk51dHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190417; c=relaxed/simple;
	bh=5X1qsUi3skYX0+XJLWX/k8pq64P7f+cfj6l98r2VoJ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BlBh4MWTKM0eLOQHbnNDEJK20tdY90NPDYxUjoSF1DB7KbZ0bg3tjfjB0KyvQ2KeTes7KliNqXFjMUSJ6JcGmdLjcHLbzcuCvnr1Umm7Daq+Fcq6EyGedX9kVonuF5sa4XKSHbug/HI6ztdolmkQgERWzly4TCey/LpwCEduq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZ7AdCqI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso8644669276.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190413; x=1707795213; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=DZ7AdCqIW4SN2p0fFMDtzJZsQtPSR2SW8mD/U+JILSftqL8rvTaRyvTFmtXRpk77+0
         usH3CaZILv3zi/4R5iZVfOOhJxmPYOKS/vbTefJmT1DdLWWLfXGUHHoB1CuUUjgqM61D
         SqywKLyd2ja6OT/OzJHMBpUJBWGAmniBKa+5Na0NvS9OwH2jnDHH2pnR5GasxDGYA3EX
         uJZ/HkhrRS5HhPQ4xQbY3xzjSYbds2vSuM2b5+3S06KwcCTjh2iK0uKKquTq5yme3OA2
         Iw9Mm5nnfyj2nQ+4PXEmMhcnAZuDuABnUeURZj+EaZYfO7sf33krKCNFTxPrEg+RrVV6
         Wj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190413; x=1707795213;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=Aurhn2Zrc4pNdzDqo97I1vpk7UnyFRwzp823ECSvQpBud7Pp1SglEaz3NOTbn2Pzgv
         B8H2cWR9UZVI/agXud2noPQcDPxLECQ5f0WNfXuU57xjj96Rgu7Nb7h6l2Y8diZBLy9p
         bWwknQsZfYu/rGV5y4+D0DoKCzS1Bk3zksGEHf2FbCBHlk5M3LGTwAT/wFUETXI7atOC
         kvTnATKVBaFO35oxuL6q8J593rKGQVKpcquLTSUzHAn+Am4Yrz4PunKRxQl7JKob3Vur
         hAxu2TafAVqDLJTubE1Y/TFCmjBzXm9CpiGz24RDX7X2UIJx7maIIASFlnqLOwxD5tLL
         eCdA==
X-Gm-Message-State: AOJu0YyzsnU/d14e+yjO5RALLjrZkHiHOEC3kk+ZJOcu6hBmzvNiK7d4
	pkL7UY01FUSv1QqJYsP+S0KsZBw2w85hpV27RA9dfrjqD2qZHznN6/FIl9dqta43xk1/fqf26HJ
	fbpUMYw==
X-Google-Smtp-Source: AGHT+IEVrQzvef2PB8ocQh4oMNlAgaBdn57OMhZd6HACfNXpfG2wAAU0mWAbGbzOYfUhhHLOFL/kwhqvK7Iv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:6902:2785:b0:dc6:dfc6:4207 with SMTP
 id eb5-20020a056902278500b00dc6dfc64207mr113515ybb.10.1707190413407; Mon, 05
 Feb 2024 19:33:33 -0800 (PST)
Date: Mon,  5 Feb 2024 19:33:18 -0800
In-Reply-To: <20240206033320.2657716-1-irogers@google.com>
Message-Id: <20240206033320.2657716-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206033320.2657716-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 4/6] perf maps: Get map before returning in maps__find_next_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, liuwenyu <liuwenyu7@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index f4855e2bfd6e..e577909456be 100644
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


