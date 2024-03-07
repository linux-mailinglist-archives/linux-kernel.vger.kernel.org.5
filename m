Return-Path: <linux-kernel+bounces-95964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457EA87555F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AF2284048
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5E13540C;
	Thu,  7 Mar 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SUiNu2zr"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3A13343F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833238; cv=none; b=TqISAD0EYFquEWyquSYUzeFBoaGjAjPKl2gd3dSObMoXBjc0rqkQP8NvtnaZUDOI8sChE3ej/gJjU/ohl5mVuRmwB6OdGAyiBFUM54eELKkM34gcjXts5OeELfmH8sNr/9Cj6eB+X5B4ZniKLTldYR6qJvNsRE1qbBjxUUXDiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833238; c=relaxed/simple;
	bh=ZLOOMl0qXMLQWjkuSZIkSXV501SW+ckp2OkDp4kJWAM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lJvhzgK1D7U0W7UwDLh548lks2/vneVmfLsVGxAAK1EgvRcOrLzlA0jL9dEu4G7pgv1l2OcsXuRDsmpyp7w4z86y2hZCIdhw9Qq5Py3vFsNNV43xG2RHFdz3z3T6y4M0YT2lTOpyO/Swf2H8FxS2jMFh1kTE5zrHtC4dG4cSyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SUiNu2zr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fb151752so11511877b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833236; x=1710438036; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZigOsMfeCTwvEg61o3PR7nQedI0UAALUJDC7Nz2NQVM=;
        b=SUiNu2zryv+/Q1qNfFr60aOKJDr3/q5KuR1/w4Qp6z/ccIU5ce+6QRS4ugJFrQfqu5
         CaK0CNyCkxvknWcYjlwQ+H8PUjyqGxqVwIsGRzQde0sCopbJSjvtT0yLLTOGmQ7q4f2l
         +0/L6mGwsHcxTjshxUgSRTusZaEhnGlsY6l+qCNf7qabgTpo2l6Ft49cbWwA5RlSl/bO
         Ms1CLVVugCxq7SgnASkXAicyX3bIX/k01LGyzTWX59kEmSg8Zqi2fzMGiKFHGKYT0D2s
         C1xq/Hn56HZVAXj7f2UoJbVU7Qs2QJXE1brNR6ibkBZH54DqY5MFkYq8WyEK3m38Wv4o
         1TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833236; x=1710438036;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZigOsMfeCTwvEg61o3PR7nQedI0UAALUJDC7Nz2NQVM=;
        b=ohT359LFvZ418x5dtupQ/qfrDAGO24uWND9ZK5LlOmFT4gMqM6mNp1HPtHXsto7sv9
         3tfntbKYgMwcd+TMNReQcnmxnYbkFMrK1Ymul2gU8nuoS+1yCBbAV1J0AZ4fmOgn5r6c
         1UFzfmuEiBteY9bAPE820tfXrMVtgL7KSlVA6wdsDpM5YwXZWDLVCXZsbR/CU8rwCiAS
         6K2x4Fvb+8EBYmn1ZjyFd5CnBiMhA2TZWFu7LkNuljQz/Ewp1N17Zlbizsf9PdAB6IJ4
         12+UqdV9Eqce9s7VbRZJO1vnwSasGCECNLQ7lDwezHFxQOKAsWvIODkeRlr+fNl/cI0z
         3/IA==
X-Forwarded-Encrypted: i=1; AJvYcCUb7+Mow/mo+BUqQvsGaW1IgfrnR7JR6+0aZp/HvN4zPbX2BqXxQDs5g01OYP7/pGUhItADiEpCTVlU4FkF+p1eHrbQ0zdjSYdt4f51
X-Gm-Message-State: AOJu0Yw9YAvjYus+FNZIIAx+gVurZyQPtuaSDnyL8f+G279tdsKiieTZ
	HIQlTfE0reyCwmY+sJZ/B33dkZA8ASpTPXUlpKQ8JDh3s8kEMfCaa2vIZ4HvcDVavQER2v1qG3+
	jFG0aNw==
X-Google-Smtp-Source: AGHT+IHgFKHoeLPEZSWiE0sw5Xu1/ZmH0sT3JOtCAUVonWb1XUC0Xo2AztyVVhS3uVUWpI48UnREqgf71zhv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:690c:c08:b0:608:b796:3d01 with SMTP id
 cl8-20020a05690c0c0800b00608b7963d01mr4993222ywb.10.1709833236538; Thu, 07
 Mar 2024 09:40:36 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:55 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 6/6] perf tools: Add/use PMU reverse lookup from config to name
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

Add perf_pmu__name_from_config that does a reverse lookup from a
config number to an alias name. The lookup is expensive as the config
is computed for every alias by filling in a perf_event_attr, but this
is only done when verbose output is enabled. The lookup also only
considers config, and not config1, config2 or config3.

An example of the output:
```
$ perf stat -vv -e data_read true
..
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff (data_read)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
..
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 10 ++++++++--
 tools/perf/util/pmu.c                     | 19 +++++++++++++++++++
 tools/perf/util/pmu.h                     |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 29e66835da3a..59fbbba79697 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -222,8 +222,14 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 }
 #endif
 
-static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
+static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
+	const char *name = perf_pmu__name_from_config(pmu, value);
+
+	if (name) {
+		print_id_hex(name);
+		return;
+	}
 	switch (type) {
 	case PERF_TYPE_HARDWARE:
 		return __p_config_hw_id(buf, size, value);
@@ -252,7 +258,7 @@ static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
 #define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
-#define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
+#define p_config_id(val)	__p_config_id(pmu, buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e24bc3b8f696..c7e0cb65a283 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2145,3 +2145,22 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->id);
 	free(pmu);
 }
+
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
+{
+	struct perf_pmu_alias *event;
+
+	if (!pmu)
+		return NULL;
+
+	list_for_each_entry(event, &pmu->aliases, list) {
+		struct perf_event_attr attr = {.config = 0,};
+		int ret = perf_pmu__config(pmu, &attr, &event->terms, NULL);
+
+		if (ret)
+			return NULL;
+		if (config == attr.config)
+			return event->name;
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 9f5284b29ecf..152700f78455 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -276,5 +276,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 
 #endif /* __PMU_H */
-- 
2.44.0.278.ge034bb2e1d-goog


