Return-Path: <linux-kernel+bounces-37803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681683B5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1426B2393D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FA136668;
	Wed, 24 Jan 2024 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9gzdftA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E661350E0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139731; cv=none; b=lnEiCW4OgylesLqTsxPCE3hWnbo5hVsfcmJwZDxHiDOQCzcAxc27ehoMcfmOy8jjGpMY3Bf+fl7ZKEzZyTHsdm7ry3KXa/681iRg9OsbJIjAlW/6U0pGolU/SytQxbW5ryBy8i8Fizgnjgj2e+3AaM7CtIQD1gdrsg5xaLcvByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139731; c=relaxed/simple;
	bh=IKmIcga6k5Dg0BlXa1TCH4mzfOReTRLYuv6E/ZEXKag=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=LZoG7p6Rzua+U9f4giVz+ZiMTTN8CqkzfFRd90AbnDdale64yGny1oWpl5jTztYqADnfkw4wk5YEIEkNcUoivNNLz54arNxNgHwzgak/UdK+OQ+MlIAvt63AvxmtWzOFSRnhdQ/TD8HrK10kRvif36gQbgDlHsG1mmYx7u6dGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9gzdftA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffee6fcdc1so59414887b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706139728; x=1706744528; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfW74auTs+0F7HhMDAnZCc535TjNzx9jhVgMO/Hoggc=;
        b=a9gzdftAWUoGzIOczaW8J8FZ3/SM/8jxR4RKGiust+1szKi4gjEZYg0RW0HQYJ3dZu
         rH4Ha7vePH5Zo3TFltsQn6G6Vlr5/5X6gGfsGJJnLcQZuGC0vY5Dw1lSskIFUuCivYX0
         5p9ECpRocpU7PDTSxJzUzzbPNI7e2g1IkqbTnVPGCNUY469XzdkqYeoiHtCSmJZh2ONQ
         hn4NPPxW/lYyTTNQ6JxCuYlBm7m5Xu8XpnqWWahZLc5Om+k8Cbfrac2F9oahBpPYamjB
         3Vtaz0UD7Wx7b4/Z/QY0sMKduvPn7zjxCO1H239uKwMzC+fCYBGv6mEl/pNYBbiiW0VQ
         RT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706139728; x=1706744528;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfW74auTs+0F7HhMDAnZCc535TjNzx9jhVgMO/Hoggc=;
        b=j2iHmp2pBshSl9258hqXkmx0wKzVuGOpRMc7KfS2uvvEcGzUIoP3wevL2fnobh7jQs
         30eYN84tUuv05t39DC+mYL6XJPOVPNkgql2T/HKNbh2tUvNEc1EL99WOaI3767k/ITDu
         IAv7x1zxZonXjEqTu2PEvLe06dUCgZQZXFVm9CfrMFgZl76Koty38Xl3cTk1KLEjfSiQ
         QckTghI6gqE9FqNdB5qvMMUZZqRp0p9+Uw/o9W8HG0/ESjpaYd94UFVf6sOvZA7s7/Bi
         G79lN/UGcRxjTOa0pm4nUoZTO/BuUXFKP6eFwis4FDwJhpfNjb6cl/UvPeUad1uIGZFq
         7EpQ==
X-Gm-Message-State: AOJu0Yzc519diBM/Af1U331N2/bU8nP0zszKjM9iGyZqK71LoHd5JTKb
	XRehkGGln34m8ga/y5jmn7fe8nKj+lAAWR7SII8Tkp0NzNB31sPoEYgmjhJMcblIObvgrrdmxG1
	kYEbrrg==
X-Google-Smtp-Source: AGHT+IE557Wa0s97f9sVCD0XX8RUVF49ObClcOfweWvyxtSeP1M6VsyAtIF2K58FzML/bjhFjlX1mr8SeV+Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4e5:2ab4:c78c:bc24])
 (user=irogers job=sendgmr) by 2002:a05:690c:a90:b0:5f3:f658:ba2a with SMTP id
 ci16-20020a05690c0a9000b005f3f658ba2amr569226ywb.7.1706139728536; Wed, 24 Jan
 2024 15:42:08 -0800 (PST)
Date: Wed, 24 Jan 2024 15:42:00 -0800
Message-Id: <20240124234200.1510417-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1] perf pmu: Treat the msr pmu as software
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

The msr PMU is a software one, meaning msr events may be grouped
with events in a hardware context. As the msr PMU isn't marked as a
software PMU by perf_pmu__is_software, groups with the msr PMU in
are broken and the msr events placed in a different group. This
may lead to multiplexing errors where a hardware event isn't
counted while the msr event, such as tsc, is. Fix all of this by
marking the msr PMU as software, which agrees with the driver.

Before:
```
$ perf stat -e '{slots,tsc}' -a true
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'system wide':

         1,750,335      slots
         4,243,557      tsc

       0.001456717 seconds time elapsed
```

After:
```
$ perf stat -e '{slots,tsc}' -a true
 Performance counter stats for 'system wide':

        12,526,380      slots
         3,415,163      tsc

       0.001488360 seconds time elapsed
```

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
The fixes tag is close enough rather than being fully accurate. The
regression was introduced earlier by the automatic event regrouping.
---
 tools/perf/util/pmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3c9609944a2f..88b9aa7d3a27 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1760,6 +1760,12 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
 
 bool perf_pmu__is_software(const struct perf_pmu *pmu)
 {
+	const char *known_sw_pmus[] = {
+		"kprobe",
+		"msr",
+		"uprobe",
+	};
+
 	if (pmu->is_core || pmu->is_uncore || pmu->auxtrace)
 		return false;
 	switch (pmu->type) {
@@ -1771,7 +1777,11 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	case PERF_TYPE_BREAKPOINT:	return true;
 	default: break;
 	}
-	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
+	for (size_t i = 0; i < ARRAY_SIZE(known_sw_pmus); i++) {
+		if (!strcmp(pmu->name, known_sw_pmus[i]))
+			return true;
+	}
+	return false;
 }
 
 FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
-- 
2.43.0.429.g432eaa2c6b-goog


