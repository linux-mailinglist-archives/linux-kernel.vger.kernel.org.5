Return-Path: <linux-kernel+bounces-55559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF2B84BE1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FB628B1F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC714294;
	Tue,  6 Feb 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="yY8Dgzxg"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75E1426D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247858; cv=none; b=NUU1qEoMB+CZaApvXUhOF7rVg8iuDIL9EUJEQGLSZdZZXrWYAbAJ+vxrDNw8ImXrf0IqVzL7jsVEoH9BxFIvnjASW6lt7/+GgRbbMIAzM+74WECqT60Rb6yViV3YaOmqNNb6i31YgAlEcEBm/133FvLGT/wn1hQkd8DiGaHJjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247858; c=relaxed/simple;
	bh=6rmWwm/oqL7OlZNTMJN0TyMIFYLRfmnKwIL3Eq1jxNU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=DRN/DfbUGemumzbAvJI7C2V1bihjCzzpayzcAduzeiFpRwlwwO0Rz4iiMN83AfmXySnnWy7j8qR6V19vRp+DiaeVZshYhFuXYfL3LE9QIEkltkgcMXUtUc8gGSD4bNQuY+ZC8/svNhAVdLC4nAiQMDMBQ1S7uB1075KdzfyjQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yY8Dgzxg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1930949276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707247856; x=1707852656; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P2pXgFZ7VZHAujwFvoa3TGYPhnyYOkf0Sm/y9qXV7I4=;
        b=yY8DgzxgQWj7/1shOWNtiwohMuGfkap8OqCobuS0ZQMktA/86dIRPSgqfnPfrOu90r
         RQA2C9Psbw4gWO1WuQjragKruKAmo6SpPMPV0MGCUPVHOsTiRv8re4h7no1V64e/kixY
         lGca40UDYeEWucaWr4GkUHvFvtwhRiQsSwdH76b84ON6dJfiHg2MNBOAjFCaFBcw3mGe
         d17eJyoc4+etuHoKsqlRumN2RAgNt/BQEyMBILlunguz71pPprFD4MfMFshRjB4jFVat
         Zte0l9BvgCxZr0KoSUINDyk/2B7RsAb6PhEXTczL+/uQ0lFs5kbuzKcje+d0+89z2t5t
         qPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707247856; x=1707852656;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2pXgFZ7VZHAujwFvoa3TGYPhnyYOkf0Sm/y9qXV7I4=;
        b=WA0+SFDNlIg4g5V1Bht5FyV77R1smPmJ7XoeEl4PmO3rNubEBqdBckF4DEyhkLotV+
         kve20RzvRNlTG819nT81bcQmA0eQxSOdKTaf4UsDyyhn8Devd7pW1KIMIF3lGQQmaRpH
         YRrUFnAM/gKsVkq4BMd11FfAdI5RishE/tIADpDqKHExyddNphI9yvtnYsqmVHVuTXJQ
         cgv6plxNbh0mvsEIe+V/ToUaFCTdjA6l7sa09cuwwcxjUzlrjM8YgWO5EnexZqOOeqHu
         gRHHdyPjNQbUdksfyBVKS5j3vTW8P5mjLrC9pjB8zD2XvgUbRDFG1TFW6XexmGyuLTif
         NqAQ==
X-Gm-Message-State: AOJu0Yy2OYGUobjZPeBuX9d0zjxcjTDSx0MxCRvjlQ5qxnasmPGfgXwh
	M+s6yE38qYoCBQWFJWnapkX7rFWB+plNTOBVahtdKR17xVN/j2Yk1y0nm6vhCzdE9QCa7UwPFLJ
	TVMn7RA==
X-Google-Smtp-Source: AGHT+IF/rv4lJZS00WI1VhZxEz0z5+57W+Sly2m0aDbKqFNJdKrPa7sP5Y27O7ccoF1QH0X0Ei/i1stoHi4u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7842:a360:67f8:5683])
 (user=irogers job=sendgmr) by 2002:a05:6902:248a:b0:dc6:d1d7:d03e with SMTP
 id ds10-20020a056902248a00b00dc6d1d7d03emr114761ybb.8.1707247855931; Tue, 06
 Feb 2024 11:30:55 -0800 (PST)
Date: Tue,  6 Feb 2024 11:30:52 -0800
Message-Id: <20240206193052.2804468-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1] perf list: For metricgroup only list include description
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If perf list is invoked with 'metricgroups' include the description
unless it is invoked with flags to exclude it. Make the description of
metricgroup dumping dependent on the desc flag in print_state as with
metrics.

Before:
```
$ perf list metricgroups
List of pre-defined events (to be used in -e or -M):

Metric Groups:

Backend
Bad
BadSpec
..
```

After:
```
$ perf list metricgroups
List of pre-defined events (to be used in -e or -M):

Metric Groups:

Backend [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
Bad [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
BadSpec
..
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 61c2c96cc070..11ba6fc1ea40 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -202,17 +202,24 @@ static void default_print_metric(void *ps,
 	if (!print_state->last_metricgroups ||
 	    strcmp(print_state->last_metricgroups, group ?: "")) {
 		if (group && print_state->metricgroups) {
-			if (print_state->name_only)
+			if (print_state->name_only) {
 				printf("%s ", group);
-			else if (print_state->metrics) {
-				const char *gdesc = describe_metricgroup(group);
+			} else {
+				const char *gdesc = print_state->desc
+					? describe_metricgroup(group)
+					: NULL;
+				const char *print_colon = "";
+
+				if (print_state->metrics) {
+					print_colon = ":";
+					putchar('\n');
+				}
 
 				if (gdesc)
-					printf("\n%s: [%s]\n", group, gdesc);
+					printf("%s%s [%s]\n", group, print_colon, gdesc);
 				else
-					printf("\n%s:\n", group);
-			} else
-				printf("%s\n", group);
+					printf("%s%s\n", group, print_colon);
+			}
 		}
 		zfree(&print_state->last_metricgroups);
 		print_state->last_metricgroups = strdup(group ?: "");
-- 
2.43.0.594.gd9cf4e227d-goog


