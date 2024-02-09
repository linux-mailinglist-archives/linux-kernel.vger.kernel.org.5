Return-Path: <linux-kernel+bounces-59965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4984FDF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9EB1C23048
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A91E88A;
	Fri,  9 Feb 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iyt/ez/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E411AAC9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511821; cv=none; b=oafDeDKtYxILWfnAUtpqeimL9s5W/Z2pETKV+jMMpedm6fitj2zr/8+CljbzzOn7KB3OSJZJgycAItdsUSVlLQDdUkChvDW5EMcyQhOTUKSfDvVKj4tdLy71TvE2SMRnrZs9y5o0MlqR2ZOEoGHxIEknDTFqcj1C0b8Cqv/GnfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511821; c=relaxed/simple;
	bh=v4L2Yvy+TPTB2iQqHtTEg47KRn3FjqMxg156ChWAFME=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dxUJLFhdKn7e5DKVovvUECQ4lRR8X8eRNJv6H5L/ePNFQ3OTw7LfJGZJi7op4YfMlryJQjh2zLrgXTZzXJCv1D3M9RPiWucHnKOmJtczkkbktWBpiuQ6l1+PJDsETka1ty5O8WWaVOmfw4NaVp4GLzEPd3yjoQqQOqkVLppd+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iyt/ez/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffee6fcdc1so25337397b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511819; x=1708116619; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gknoLaUB2sz5KFXkBLXORn9pUeJlqgUBUUSyFz57kQs=;
        b=0iyt/ez/4MjLd32489GYk3uUVOgqHjeKF5X618nVPzfmlb+NkyBI0PkQmB+g4+GupH
         +XIOM6NebXMjQZRRD7y/tEyWAp/WzB+lYzqdNJiN9k7S6UJIPck/zqBSNPgBdYOJrUVl
         35vgmLWgKjnE5Fx/NzXsS7PuopUgDYEwZdtrHrLDTMozkWXUpVPb03k0dKeW2dLtVfgH
         iHqH4Y1mAEA/UvflvjQoCWxI5/vDg93hPtQS/+krEBOZVoNNgUhj3RVsXxwsjVBWoSJx
         4G6EmQGl3cY6RIYvGwITZBL+RLUfNAzXdTHDcwZnOf4b4a9CjlxGpCZZOAvPc4AaXh9l
         rMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511819; x=1708116619;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gknoLaUB2sz5KFXkBLXORn9pUeJlqgUBUUSyFz57kQs=;
        b=f8INl2b6fyA9yllgdQ80Yh8rWLQIz8U+aYPZGNR+Egkqh8h9vLZCCOYBAMC//TB7Hx
         QzoJWvwKbm2yurwg8YKY49GP8K64lMDszgzp6Hjt2R5EvrgPYHYvZY6C4endzmkO0Ib6
         2fb+2zHRruWg1dWwzN1y9Gt6zinzX67cHwDmxihwtmtYrscuc9hQBnw2QxQEN9jkPRRa
         MVQQnX3uSgrrQ819pMSTBqp759s3WtfYorLA9CezYgK4AxMQ7IAoKr2RGrAnKrXv4kFs
         A+s09hUKRKJ5Oa6vbAIUSLVM5XC0kDp20jqWBAG2JnH/AGHTyEmQ8YlM8mcaZ57imTN3
         sWlw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7AL+68apXInm4npFhcwu9g+lZNQOsEXeYLo0VGhtbxLeTbwLfAqNclQl/mIJIi2Pa/f7nYjM/Ks8bd9VX6oLjga9x6bryVr+Mlwi
X-Gm-Message-State: AOJu0YwzpaFww9DLqWL4NZoCyNJQfiMlMzF9Q03c8iDbAv63aQtq79Nx
	Y9Rx2uDN8ufnROmjTcQ3pIErWycVNkbVUtXMrazFhjT/NLdvhuVLiDA/nFcSusaXXJQyLD8Vwwt
	avVcZWQ==
X-Google-Smtp-Source: AGHT+IGEWg8J1iOGAYwp5/i/iMbjcwAa2gGukyNU06noyL1m3zapgRwM6609RJcQllvTA2fSM0tl40LH6ykJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:2201:b0:dc6:d890:1a97 with SMTP
 id dm1-20020a056902220100b00dc6d8901a97mr5150ybb.9.1707511818829; Fri, 09 Feb
 2024 12:50:18 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:47 -0800
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Message-Id: <20240209204947.3873294-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 4/4] perf metric: Don't remove scale from counts
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

Counts were switched from the scaled saved value form to the
aggregated count to avoid double accounting. When this happened the
removing of scaling for a count should have been removed, however, it
wasn't and this wasn't observed as it normally doesn't matter because
a counter's scale is 1. A problem was observed with RAPL events that
are scaled.

Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e31426167852..cf573ff3fa84 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -414,12 +414,7 @@ static int prepare_metric(struct evsel **metric_events,
 				val = NAN;
 				source_count = 0;
 			} else {
-				/*
-				 * If an event was scaled during stat gathering,
-				 * reverse the scale before computing the
-				 * metric.
-				 */
-				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
+				val = aggr->counts.val;
 				source_count = evsel__source_count(metric_events[i]);
 			}
 		}
-- 
2.43.0.687.g38aa6559b0-goog


