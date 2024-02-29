Return-Path: <linux-kernel+bounces-86162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC986C09B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135FA1F24C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869403C482;
	Thu, 29 Feb 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q93PgiMu"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C136AE1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187664; cv=none; b=JxEmqH0Wr0reLBzqN7DmqiWkHBxR7ut9xvu6H4n5ww8euwYnwO3h43ZCldtonHfcSKU6dC+aqUb0wAgqMSY5iwK7oWoxZmRq8ewCCTbwbEYx0+IJaIso1j78XdCwss6ZnTOKUwgjJE52AVfJkZim8J3kZcLU0P6B4SX+kS0ERpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187664; c=relaxed/simple;
	bh=rWfMlMwr/8u2RrDewjX8624dpgZQiC94SLvycpO6+Tk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=odCwG8ayQc5zqiKwm/zUsZWaFPzLbDchJNsEhtYqvA1wurq25VpEpWw/mDnbAgenT+GRIfFLmb0sSPdlHiwrf8i91HFI57f2/9ahGJGiwatO7Q7uqLgpDZzyuv8wRzWtIzCs3sZUaG8rxfv8lkH8xQL4ek7f7T7QK5MT4KilN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q93PgiMu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso1060677276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709187662; x=1709792462; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HP7FHTSIsiaJThzWBkYLUGihLpdmeLYVXFRi2ap+AOo=;
        b=Q93PgiMuTNFHaFBMTT7q9IYkbqBn6uQBFPZFiRtHrLrnA3s4/gYDUZBLgjduFT37rP
         NPWumPy5yNM+/K56ZIBF9ll3YYvsmm9zsX5q3+Fj67Z78eyewYvmWlA4gjNebUhOdRbz
         BxwfYAxh/GocDQXt+oIsFPP5Eu1TbzBSFkKlIb7XAh0E2XZvPR+PgbAPXqn4uxpXVyAB
         tVcEORGj0cEEtexjZTsWJnMmhG4GL2PGlq+bSSUEZ9MgRJwR3tkMnFliXSAMMu5jRhBu
         b6rLBUQuZowiUqqik9g3H8nrYBSU6WBX/47YDnrFmrkEOQ3oin1abYzOJ9Ezp6UyTO9p
         LLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709187662; x=1709792462;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HP7FHTSIsiaJThzWBkYLUGihLpdmeLYVXFRi2ap+AOo=;
        b=n/vQPj76WOQW7aJU5obSS2w54WGnPH/PFlJj+MCeDFRrDV5PjIA1MaWsH75E97gUwR
         GOUjlr6IFf8+RD25KZ3aUoQQyfxNajj1xBYWjz+2uzQbuFO72bNA0KIzhL7yPTxqlLSL
         3y5PcGC+q9vklJTHQxXIKpVZjqntWPrUaeninZFEOfK5qeRNSHE9KyoIIJHv7Sje9rwL
         BkJ0Y6g4ZDFMIY0JDvbjbZeDpACi7NT3KwMPkrLzUpngKgY++4hyC26lUjtbYHGqWXgB
         TNLKSZHa8zsH5644ivtALcBI6KJPxSitpBY4NNxIU+eae0B6B5RoSN52Cnu/WYlQWkGC
         ReUw==
X-Forwarded-Encrypted: i=1; AJvYcCWItcyCMxBUmHLjnSd72kDrZQzN7KR+ye5GAQsThPrqLmNU5T5sHmzZRhP3w+l0ufLJnm2CF24LVb1B8yIoccNSzAw7OzxcvfjbOiVn
X-Gm-Message-State: AOJu0Yy7ZckTAa8WlyPgNQ+ufWbi3M9Kp1fVUfPxdfXy8eNJl/5uHDPg
	kbgLtD2Wj+3YDgAuKgFgk9ejIED8k1o5LMNX3PCTp4DjhROfuUZ+V+QKMEoqZXtQv5p0jdQsSn9
	Axws1Xg==
X-Google-Smtp-Source: AGHT+IHL4gLgrbuz5ENk/kFB22N+h9+KtteAwYmZer1Y12jokb3z8fSjA99h4Up660cDOw/41Kg4Qa2NBBBX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:188d:b0:dcc:54d0:85e0 with SMTP
 id cj13-20020a056902188d00b00dcc54d085e0mr369155ybb.11.1709187662515; Wed, 28
 Feb 2024 22:21:02 -0800 (PST)
Date: Wed, 28 Feb 2024 22:20:48 -0800
Message-Id: <20240229062048.558799-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1] perf map: Fix map reference count issues
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The find will get the map, ensure puts are done on all paths.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c        | 14 +++++++-------
 tools/perf/util/probe-event.c |  4 +---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 53aea6d2ef93..ce13145a9f8e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -611,14 +611,14 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 	struct symbol *result = NULL;
 
 	/* Ensure map is loaded before using map->map_ip */
-	if (map != NULL && map__load(map) >= 0) {
-		if (mapp)
-			*mapp = map;
-
+	if (map != NULL && map__load(map) >= 0)
 		result = map__find_symbol(map, map__map_ip(map, addr));
-		if (!mapp)
-			map__put(map);
-	}
+
+	if (mapp)
+		*mapp = map;
+	else
+		map__put(map);
+
 	return result;
 }
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index be71abe8b9b0..2a0ad9ecf0a2 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2274,9 +2274,7 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
 	ret = pp->function ? 0 : -ENOMEM;
 
 out:
-	if (map && !is_kprobe) {
-		map__put(map);
-	}
+	map__put(map);
 
 	return ret;
 }
-- 
2.44.0.278.ge034bb2e1d-goog


