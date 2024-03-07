Return-Path: <linux-kernel+bounces-95111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78471874949
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331822866CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D3651B2;
	Thu,  7 Mar 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMwsRt69"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE664AAA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799267; cv=none; b=A6gRfYWgQlpi3AX0T2BpNQco6ZaoNFBSM4oGsm9dvXK25NXjm7QRc9+yXkVEcdNSKsZJ+Ty8+0u4wqXPpViNysIFbHZQWcuBK2L+R30vatqLqUp+Y5X2utPcrYVPFefsjyOPJij38p6M6fTTr8+yJyJ268D9aT49kqUWHqEHLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799267; c=relaxed/simple;
	bh=4FGMDKoOkBBxkj1JqFSRgh1cfE5NtnWchNm4jvP3s8Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g1aGoqsXpIuRA0/fexJjp1XCRBkKObNa3GsIWYhm3grTuLlDu5vfwHwoIqGaHxc/J537o6kqqlhoszuVBunKeQ4LekiIFX96IAXtabhbJtJcBXZuVHyfqAMe8PBJYrsaC5kxA4zJWh3DNlIYmVjbRMDMve4U2RR6rMfvmi2uwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qMwsRt69; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso1047981276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709799265; x=1710404065; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAckeiwvch0FsitNqCYbJ5gbjBFcfyBaGMXWdwxHN00=;
        b=qMwsRt69Pi3UVSG2s1h1r9OHqUTd7Yr970cndzvUvXwd1i2knRshfuuoft1bUc2J59
         Jbx2nzjcOsojY5wqE19ZG2AN7KNOf4cMRQyjMrvXIBcZZAQAsojHmkDpqKQpktMuqUpk
         EED507Xre6mfqs9r+TyuD83IAAQoWUZTnjz8pKfFMtRxF64AJTNZpcE9dzHeYuoj/WZL
         Eb3ILvi+vXj4+CWY5YdKb41k3i0yeaV/zDNob951ctW8JQ/misq5YkwBLuE9qwll9ath
         0xCFriUXUFX9YkzTzTTH7Cwaonqd6+R80dShiZHelGj6hVPxKt2Qg1iTNf0YQJse/FRa
         +fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799265; x=1710404065;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAckeiwvch0FsitNqCYbJ5gbjBFcfyBaGMXWdwxHN00=;
        b=vcQ0+NwuP7C5LEZ7Brvi2/f1lUWNK1oV5BPh5WmaQOdP8f/dJdddBl6Ys4oF/HoJyv
         OL+8Yf3rv6MyQhPLkGBJgFcuDkZqjRSMA0NUjCX3gexnexmYlhNEsFpjLUadvTiDTIB1
         zGz8IhqXGm+TFAXTm7OAnEKw59FW/5FuOlngBwJkL23UVZ8WmRT04uTXWGNzOa9ZIE2E
         ynsHQOAJOrbwHjbeZXAAn14EAjarZgl3d+8fJPRaJ8c93FrBm+3kK7E7PT0fk38//+8M
         8/dI68ioLgrU60Ev+cJ29X8iUAe2C7Y12VIH4y9zaBfd/KBqjPhClVwwvTA1I+gHz2wr
         gDQA==
X-Forwarded-Encrypted: i=1; AJvYcCVAj7B19aCR0R3tmBeG034QxzzBz0/tVNjh3SLMFiTvDUQjplOsVF25+wRleFm7EzLXVjSawMf4x4fhguH00NnFJcHFZld/oJrmz/3k
X-Gm-Message-State: AOJu0YxPAeoDX6NULj/SLjLdXn4eiAW9HE15cGfLCsQHdYILNAoTnVl1
	YBtwtH2lvuZE64VWZgtP0jBgj1iF9py4hXf5vOStO9u4TYWMjizdh3oTBCGPQoZ37Rv+kmmaKdt
	qXNfSsg==
X-Google-Smtp-Source: AGHT+IEkQ7xYzGPHdIbXejmdwpipGr9wIfLLFPDjQ1Rf+7YZ69qmawid4SieE8nfYfC1s4yP6jWLx+fz8wiX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a25:2688:0:b0:dc6:eea0:1578 with SMTP id
 m130-20020a252688000000b00dc6eea01578mr4298880ybm.13.1709799264869; Thu, 07
 Mar 2024 00:14:24 -0800 (PST)
Date: Thu,  7 Mar 2024 00:14:08 -0800
In-Reply-To: <20240307081412.3933750-1-irogers@google.com>
Message-Id: <20240307081412.3933750-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307081412.3933750-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 3/6] perf list: Allow wordwrap to wrap on commas
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

A raw event encoding may be lock with terms separated by commas. If
wrapping such a string it would be useful to break at the commas, so
add this ability to wordwrap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 02bf608d585e..e0fe3d178d63 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -22,6 +22,7 @@
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <linux/zalloc.h>
+#include <ctype.h>
 #include <stdarg.h>
 #include <stdio.h>
 
@@ -76,26 +77,38 @@ static void default_print_start(void *ps)
 
 static void default_print_end(void *print_state __maybe_unused) {}
 
+static const char *skip_spaces_or_commas(const char *str)
+{
+	while (isspace(*str) || *str == ',')
+		++str;
+	return str;
+}
+
 static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 {
 	int column = start;
 	int n;
 	bool saw_newline = false;
+	bool comma = false;
 
 	while (*s) {
-		int wlen = strcspn(s, " \t\n");
+		int wlen = strcspn(s, " ,\t\n");
+		const char *sep = comma ? "," : " ";
 
 		if ((column + wlen >= max && column > start) || saw_newline) {
-			fprintf(fp, "\n%*s", start, "");
+			fprintf(fp, comma ? ",\n%*s" : "\n%*s", start, "");
 			column = start + corr;
 		}
-		n = fprintf(fp, "%s%.*s", column > start ? " " : "", wlen, s);
+		if (column <= start)
+			sep = "";
+		n = fprintf(fp, "%s%.*s", sep, wlen, s);
 		if (n <= 0)
 			break;
 		saw_newline = s[wlen] == '\n';
 		s += wlen;
+		comma = s[0] == ',';
 		column += n;
-		s = skip_spaces(s);
+		s = skip_spaces_or_commas(s);
 	}
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog


