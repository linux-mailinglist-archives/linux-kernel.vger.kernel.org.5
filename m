Return-Path: <linux-kernel+bounces-34437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D8837912
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C9728B3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636E146915;
	Tue, 23 Jan 2024 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4ubij68"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C951468F0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968379; cv=none; b=cX/1ocKZhVyTo3AetWoQKl2pnG8WJ5Fwex2e5uUFmbZ/INh+N5UVGDRLIssP5qqVRoNmjU1TATJ9PeNqmXks1WhdwatiDl798ydi/Oo6l0yt6gDNO526dqqAwCTFl1/2VK0BZyPzaIq1j3mVSV/2IW4GMy1Za5HpmAG80QseA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968379; c=relaxed/simple;
	bh=0g/j+czwZZZV0jyeUsBRsvNrDyJWksVMiiivTFDmwII=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=o4lYhbRH93OvtQWC+BnLVHZoeIGV3+DSLhDVT2AHVk1I1RRb5zyUlTHDH+48Lt3TKRci4AJ4yJmTwcYqH2z8KhuHO1F8Uqs2BwbcZunxbdNplXAjcTGUZp5cb/CN+CtomImccdOfGCfA/Nq1e3vdP+/IN2ouagnnAnUeo/tpKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4ubij68; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc21b7f41a1so4778377276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968376; x=1706573176; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwOTolb94//HSm3DPw2galb3SBW/iq3bnifLRUsxAiA=;
        b=b4ubij68NPzkF6MY3Za9q5X3+bKIUGc18rpKpBTKKs+2COWOwBcVTNnXJShPNpQwMu
         nyhgnpKyzIcMrr9fWTGKIYpRXy1lmzxV1foqyo54bZEkx8tX68+SDnpzwYIcdR3mVBfa
         AvhN7gE4rra1om/Ql1NkDttHuhui7wXTWoYaKG5vLbuBInEmbSm7AWkKRuMPI/7kAFxl
         rDzWpdPx7t1QpIBfGmwEP4PkJk7Q1IkHTGU5ytUFPMrZPYSnVvh6mHpoN1LDcfbRBFnn
         oAo2zqjePkEa0lpZtuOzjJVHGRhriFtKX68f0rGzHNQaBEYnwzWTmi/hbdtRHuvtD6Lo
         mJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968376; x=1706573176;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwOTolb94//HSm3DPw2galb3SBW/iq3bnifLRUsxAiA=;
        b=j3nKHqFTh6ljq9hN0x1JWsvFmmLNhYambadlGtoBRFIGvJT4Aie8RzWW5p+vcPDbAp
         Ueylu9tqocXJIJBV8LNUHFeBKHU+9S3DeQgQMqEMOrggTnSwrHgDdMUHaD7J/PPPsHuZ
         lJ9EAGIvIfNxFGod2jqWInQWBvd602RCr/uzCa323HFSbOoCntfn+QzEyNG1qAf5ik+a
         DvUZsENdOPGF51dqdvU6erCijYV1HkYV+aKBWyPqct/yYza9d398UbMLPpSrkwqPZGqj
         WO4X4LFS4y1JcpnFFGc0zwFeI6L0gzCs0lWUOmIYOD1DW0qk2QBRbiwNHCdnA+XTo62z
         JI/A==
X-Gm-Message-State: AOJu0Ywb7kW3dGYjSVBYVxNFFHXdIz07y5qiQxiNq9eEoBE9jbC+7HQN
	sB45aBEIAJ8KaPSPFPyu7SwlxDu27sRxKaX178HVq4ITVE4aw6cCoHbwG4S1HBQuBrnCxD0c8YE
	5Ap4abQ==
X-Google-Smtp-Source: AGHT+IHjfcVREUikq2EhJOVMgG2aOJ8fkYgq/0NXCdElTxfM9ARVkN1aIBFVWXyZn7a7giRwrG2WqwFPaEKr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a25:df84:0:b0:dc2:6605:f6ba with SMTP id
 w126-20020a25df84000000b00dc26605f6bamr370734ybg.2.1705968376320; Mon, 22 Jan
 2024 16:06:16 -0800 (PST)
Date: Mon, 22 Jan 2024 16:06:01 -0800
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
Message-Id: <20240123000604.1211486-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 2/5] perf list: Add output file option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an option to write the perf list output to a specific file. This
can avoid issues with debug output being written into the output
stream.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |   4 +
 tools/perf/builtin-list.c              | 211 +++++++++++++++----------
 2 files changed, 133 insertions(+), 82 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 1b90575ee3c8..3b12595193c9 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -47,6 +47,10 @@ Print PMU events and metrics limited to the specific PMU name.
 --json::
 Output in JSON format.
 
+-o::
+--output=::
+	Output file name. By default output is written to stdout.
+
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 61c2c96cc070..e27a1b1288c2 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -30,6 +30,8 @@
  * functions.
  */
 struct print_state {
+	/** @fp: File to write output to. */
+	FILE *fp;
 	/**
 	 * @pmu_glob: Optionally restrict PMU and metric matching to PMU or
 	 * debugfs subsystem name.
@@ -66,13 +68,15 @@ static void default_print_start(void *ps)
 {
 	struct print_state *print_state = ps;
 
-	if (!print_state->name_only && pager_in_use())
-		printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
+	if (!print_state->name_only && pager_in_use()) {
+		fprintf(print_state->fp,
+			"\nList of pre-defined events (to be used in -e or -M):\n\n");
+	}
 }
 
 static void default_print_end(void *print_state __maybe_unused) {}
 
-static void wordwrap(const char *s, int start, int max, int corr)
+static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 {
 	int column = start;
 	int n;
@@ -82,10 +86,10 @@ static void wordwrap(const char *s, int start, int max, int corr)
 		int wlen = strcspn(s, " \t\n");
 
 		if ((column + wlen >= max && column > start) || saw_newline) {
-			printf("\n%*s", start, "");
+			fprintf(fp, "\n%*s", start, "");
 			column = start + corr;
 		}
-		n = printf("%s%.*s", column > start ? " " : "", wlen, s);
+		n = fprintf(fp, "%s%.*s", column > start ? " " : "", wlen, s);
 		if (n <= 0)
 			break;
 		saw_newline = s[wlen] == '\n';
@@ -104,6 +108,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 {
 	struct print_state *print_state = ps;
 	int pos;
+	FILE *fp = print_state->fp;
 
 	if (deprecated && !print_state->deprecated)
 		return;
@@ -119,30 +124,30 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 
 	if (print_state->name_only) {
 		if (event_alias && strlen(event_alias))
-			printf("%s ", event_alias);
+			fprintf(fp, "%s ", event_alias);
 		else
-			printf("%s ", event_name);
+			fprintf(fp, "%s ", event_name);
 		return;
 	}
 
 	if (strcmp(print_state->last_topic, topic ?: "")) {
 		if (topic)
-			printf("\n%s:\n", topic);
+			fprintf(fp, "\n%s:\n", topic);
 		zfree(&print_state->last_topic);
 		print_state->last_topic = strdup(topic ?: "");
 	}
 
 	if (event_alias && strlen(event_alias))
-		pos = printf("  %s OR %s", event_name, event_alias);
+		pos = fprintf(fp, "  %s OR %s", event_name, event_alias);
 	else
-		pos = printf("  %s", event_name);
+		pos = fprintf(fp, "  %s", event_name);
 
 	if (!topic && event_type_desc) {
 		for (; pos < 53; pos++)
-			putchar(' ');
-		printf("[%s]\n", event_type_desc);
+			fputc(' ', fp);
+		fprintf(fp, "[%s]\n", event_type_desc);
 	} else
-		putchar('\n');
+		fputc('\n', fp);
 
 	if (desc && print_state->desc) {
 		char *desc_with_unit = NULL;
@@ -155,22 +160,22 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 					      ? "%s. Unit: %s" : "%s Unit: %s",
 					    desc, pmu_name);
 		}
-		printf("%*s", 8, "[");
-		wordwrap(desc_len > 0 ? desc_with_unit : desc, 8, pager_get_columns(), 0);
-		printf("]\n");
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, desc_len > 0 ? desc_with_unit : desc, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
 		free(desc_with_unit);
 	}
 	long_desc = long_desc ?: desc;
 	if (long_desc && print_state->long_desc) {
-		printf("%*s", 8, "[");
-		wordwrap(long_desc, 8, pager_get_columns(), 0);
-		printf("]\n");
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
 	}
 
 	if (print_state->detailed && encoding_desc) {
-		printf("%*s", 8, "");
-		wordwrap(encoding_desc, 8, pager_get_columns(), 0);
-		putchar('\n');
+		fprintf(fp, "%*s", 8, "");
+		wordwrap(fp, encoding_desc, 8, pager_get_columns(), 0);
+		fputc('\n', fp);
 	}
 }
 
@@ -184,6 +189,7 @@ static void default_print_metric(void *ps,
 				const char *unit __maybe_unused)
 {
 	struct print_state *print_state = ps;
+	FILE *fp = print_state->fp;
 
 	if (print_state->event_glob &&
 	    (!print_state->metrics || !name || !strglobmatch(name, print_state->event_glob)) &&
@@ -192,27 +198,27 @@ static void default_print_metric(void *ps,
 
 	if (!print_state->name_only && !print_state->last_metricgroups) {
 		if (print_state->metricgroups) {
-			printf("\nMetric Groups:\n");
+			fprintf(fp, "\nMetric Groups:\n");
 			if (!print_state->metrics)
-				putchar('\n');
+				fputc('\n', fp);
 		} else {
-			printf("\nMetrics:\n\n");
+			fprintf(fp, "\nMetrics:\n\n");
 		}
 	}
 	if (!print_state->last_metricgroups ||
 	    strcmp(print_state->last_metricgroups, group ?: "")) {
 		if (group && print_state->metricgroups) {
 			if (print_state->name_only)
-				printf("%s ", group);
+				fprintf(fp, "%s ", group);
 			else if (print_state->metrics) {
 				const char *gdesc = describe_metricgroup(group);
 
 				if (gdesc)
-					printf("\n%s: [%s]\n", group, gdesc);
+					fprintf(fp, "\n%s: [%s]\n", group, gdesc);
 				else
-					printf("\n%s:\n", group);
+					fprintf(fp, "\n%s:\n", group);
 			} else
-				printf("%s\n", group);
+				fprintf(fp, "%s\n", group);
 		}
 		zfree(&print_state->last_metricgroups);
 		print_state->last_metricgroups = strdup(group ?: "");
@@ -223,53 +229,59 @@ static void default_print_metric(void *ps,
 	if (print_state->name_only) {
 		if (print_state->metrics &&
 		    !strlist__has_entry(print_state->visited_metrics, name)) {
-			printf("%s ", name);
+			fprintf(fp, "%s ", name);
 			strlist__add(print_state->visited_metrics, name);
 		}
 		return;
 	}
-	printf("  %s\n", name);
+	fprintf(fp, "  %s\n", name);
 
 	if (desc && print_state->desc) {
-		printf("%*s", 8, "[");
-		wordwrap(desc, 8, pager_get_columns(), 0);
-		printf("]\n");
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, desc, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
 	}
 	if (long_desc && print_state->long_desc) {
-		printf("%*s", 8, "[");
-		wordwrap(long_desc, 8, pager_get_columns(), 0);
-		printf("]\n");
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
 	}
 	if (expr && print_state->detailed) {
-		printf("%*s", 8, "[");
-		wordwrap(expr, 8, pager_get_columns(), 0);
-		printf("]\n");
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, expr, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
 	}
 	if (threshold && print_state->detailed) {
-		printf("%*s", 8, "[");
-		wordwrap(threshold, 8, pager_get_columns(), 0);
-		printf("]\n");
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, threshold, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
 	}
 }
 
 struct json_print_state {
+	/** @fp: File to write output to. */
+	FILE *fp;
 	/** Should a separator be printed prior to the next item? */
 	bool need_sep;
 };
 
-static void json_print_start(void *print_state __maybe_unused)
+static void json_print_start(void *ps)
 {
-	printf("[\n");
+	struct json_print_state *print_state = ps;
+	FILE *fp = print_state->fp;
+
+	fprintf(fp, "[\n");
 }
 
 static void json_print_end(void *ps)
 {
 	struct json_print_state *print_state = ps;
+	FILE *fp = print_state->fp;
 
-	printf("%s]\n", print_state->need_sep ? "\n" : "");
+	fprintf(fp, "%s]\n", print_state->need_sep ? "\n" : "");
 }
 
-static void fix_escape_printf(struct strbuf *buf, const char *fmt, ...)
+static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
 
@@ -318,7 +330,7 @@ static void fix_escape_printf(struct strbuf *buf, const char *fmt, ...)
 		}
 	}
 	va_end(args);
-	fputs(buf->buf, stdout);
+	fputs(buf->buf, fp);
 }
 
 static void json_print_event(void *ps, const char *pmu_name, const char *topic,
@@ -330,60 +342,71 @@ static void json_print_event(void *ps, const char *pmu_name, const char *topic,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
+	FILE *fp = print_state->fp;
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
-	printf("%s{\n", print_state->need_sep ? ",\n" : "");
+	fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
 	if (pmu_name) {
-		fix_escape_printf(&buf, "\t\"Unit\": \"%S\"", pmu_name);
+		fix_escape_fprintf(fp, &buf, "\t\"Unit\": \"%S\"", pmu_name);
 		need_sep = true;
 	}
 	if (topic) {
-		fix_escape_printf(&buf, "%s\t\"Topic\": \"%S\"", need_sep ? ",\n" : "", topic);
+		fix_escape_fprintf(fp, &buf, "%s\t\"Topic\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   topic);
 		need_sep = true;
 	}
 	if (event_name) {
-		fix_escape_printf(&buf, "%s\t\"EventName\": \"%S\"", need_sep ? ",\n" : "",
-				  event_name);
+		fix_escape_fprintf(fp, &buf, "%s\t\"EventName\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   event_name);
 		need_sep = true;
 	}
 	if (event_alias && strlen(event_alias)) {
-		fix_escape_printf(&buf, "%s\t\"EventAlias\": \"%S\"", need_sep ? ",\n" : "",
-				  event_alias);
+		fix_escape_fprintf(fp, &buf, "%s\t\"EventAlias\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   event_alias);
 		need_sep = true;
 	}
 	if (scale_unit && strlen(scale_unit)) {
-		fix_escape_printf(&buf, "%s\t\"ScaleUnit\": \"%S\"", need_sep ? ",\n" : "",
-				  scale_unit);
+		fix_escape_fprintf(fp, &buf, "%s\t\"ScaleUnit\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   scale_unit);
 		need_sep = true;
 	}
 	if (event_type_desc) {
-		fix_escape_printf(&buf, "%s\t\"EventType\": \"%S\"", need_sep ? ",\n" : "",
-				  event_type_desc);
+		fix_escape_fprintf(fp, &buf, "%s\t\"EventType\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   event_type_desc);
 		need_sep = true;
 	}
 	if (deprecated) {
-		fix_escape_printf(&buf, "%s\t\"Deprecated\": \"%S\"", need_sep ? ",\n" : "",
-				  deprecated ? "1" : "0");
+		fix_escape_fprintf(fp, &buf, "%s\t\"Deprecated\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   deprecated ? "1" : "0");
 		need_sep = true;
 	}
 	if (desc) {
-		fix_escape_printf(&buf, "%s\t\"BriefDescription\": \"%S\"", need_sep ? ",\n" : "",
-				  desc);
+		fix_escape_fprintf(fp, &buf, "%s\t\"BriefDescription\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   desc);
 		need_sep = true;
 	}
 	if (long_desc) {
-		fix_escape_printf(&buf, "%s\t\"PublicDescription\": \"%S\"", need_sep ? ",\n" : "",
-				  long_desc);
+		fix_escape_fprintf(fp, &buf, "%s\t\"PublicDescription\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   long_desc);
 		need_sep = true;
 	}
 	if (encoding_desc) {
-		fix_escape_printf(&buf, "%s\t\"Encoding\": \"%S\"", need_sep ? ",\n" : "",
-				  encoding_desc);
+		fix_escape_fprintf(fp, &buf, "%s\t\"Encoding\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   encoding_desc);
 		need_sep = true;
 	}
-	printf("%s}", need_sep ? "\n" : "");
+	fprintf(fp, "%s}", need_sep ? "\n" : "");
 	strbuf_release(&buf);
 }
 
@@ -394,43 +417,53 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
+	FILE *fp = print_state->fp;
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
-	printf("%s{\n", print_state->need_sep ? ",\n" : "");
+	fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
 	if (group) {
-		fix_escape_printf(&buf, "\t\"MetricGroup\": \"%S\"", group);
+		fix_escape_fprintf(fp, &buf, "\t\"MetricGroup\": \"%S\"", group);
 		need_sep = true;
 	}
 	if (name) {
-		fix_escape_printf(&buf, "%s\t\"MetricName\": \"%S\"", need_sep ? ",\n" : "", name);
+		fix_escape_fprintf(fp, &buf, "%s\t\"MetricName\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   name);
 		need_sep = true;
 	}
 	if (expr) {
-		fix_escape_printf(&buf, "%s\t\"MetricExpr\": \"%S\"", need_sep ? ",\n" : "", expr);
+		fix_escape_fprintf(fp, &buf, "%s\t\"MetricExpr\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   expr);
 		need_sep = true;
 	}
 	if (threshold) {
-		fix_escape_printf(&buf, "%s\t\"MetricThreshold\": \"%S\"", need_sep ? ",\n" : "",
-				  threshold);
+		fix_escape_fprintf(fp, &buf, "%s\t\"MetricThreshold\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   threshold);
 		need_sep = true;
 	}
 	if (unit) {
-		fix_escape_printf(&buf, "%s\t\"ScaleUnit\": \"%S\"", need_sep ? ",\n" : "", unit);
+		fix_escape_fprintf(fp, &buf, "%s\t\"ScaleUnit\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   unit);
 		need_sep = true;
 	}
 	if (desc) {
-		fix_escape_printf(&buf, "%s\t\"BriefDescription\": \"%S\"", need_sep ? ",\n" : "",
-				  desc);
+		fix_escape_fprintf(fp, &buf, "%s\t\"BriefDescription\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   desc);
 		need_sep = true;
 	}
 	if (long_desc) {
-		fix_escape_printf(&buf, "%s\t\"PublicDescription\": \"%S\"", need_sep ? ",\n" : "",
-				  long_desc);
+		fix_escape_fprintf(fp, &buf, "%s\t\"PublicDescription\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   long_desc);
 		need_sep = true;
 	}
-	printf("%s}", need_sep ? "\n" : "");
+	fprintf(fp, "%s}", need_sep ? "\n" : "");
 	strbuf_release(&buf);
 }
 
@@ -449,8 +482,12 @@ static bool default_skip_duplicate_pmus(void *ps)
 int cmd_list(int argc, const char **argv)
 {
 	int i, ret = 0;
-	struct print_state default_ps = {};
-	struct print_state json_ps = {};
+	struct print_state default_ps = {
+		.fp = stdout,
+	};
+	struct print_state json_ps = {
+		.fp = stdout,
+	};
 	void *ps = &default_ps;
 	struct print_callbacks print_cb = {
 		.print_start = default_print_start,
@@ -461,6 +498,7 @@ int cmd_list(int argc, const char **argv)
 	};
 	const char *cputype = NULL;
 	const char *unit_name = NULL;
+	const char *output_path = NULL;
 	bool json = false;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &default_ps.name_only, "Dump raw events"),
@@ -471,6 +509,7 @@ int cmd_list(int argc, const char **argv)
 			    "Print longer event descriptions."),
 		OPT_BOOLEAN(0, "details", &default_ps.detailed,
 			    "Print information on the perf event names and expressions used internally by events."),
+		OPT_STRING('o', "output", &output_path, "file", "output file name"),
 		OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
 			    "Print deprecated events."),
 		OPT_STRING(0, "cputype", &cputype, "cpu type",
@@ -497,6 +536,11 @@ int cmd_list(int argc, const char **argv)
 	argc = parse_options(argc, argv, list_options, list_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (output_path) {
+		default_ps.fp = fopen(output_path, "w");
+		json_ps.fp = default_ps.fp;
+	}
+
 	setup_pager();
 
 	if (!default_ps.name_only)
@@ -618,5 +662,8 @@ int cmd_list(int argc, const char **argv)
 	free(default_ps.last_topic);
 	free(default_ps.last_metricgroups);
 	strlist__delete(default_ps.visited_metrics);
+	if (output_path)
+		fclose(default_ps.fp);
+
 	return ret;
 }
-- 
2.43.0.429.g432eaa2c6b-goog


