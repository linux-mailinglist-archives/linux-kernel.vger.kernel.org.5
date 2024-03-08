Return-Path: <linux-kernel+bounces-96384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ECD875B79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7551E2831B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C5F4FC;
	Fri,  8 Mar 2024 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIkvQnQI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3A568A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857184; cv=none; b=Fkkr+Gpz21rsbwd+v9SpaX3zIxp8r9gtvC8zMjLcKy7XqQV5JhBjyCimViyhmMim+W18ZSLXcaO0QIVwE1u85J6XpjM+5FzXYZiyjwxiwHD0qnUQxisMp49mAen0h4qbl02M4vOHdL071G/f7Vc+YRPUOU49ixZ0SVl83cVODIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857184; c=relaxed/simple;
	bh=FRTaxqQ9z0fdBOTvorH6lKFlBCFvX2RUJshMGjEelbw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=q509FakfstHy3SUA/kzT32VScCjqt2umUlcqvOekMXaoOnkTJWaaaxTFhtOHa0Ehq76XSiyJ4LMWpZMyqz6PBIQbfvuj0MDhKGj33eti02ds6ryQfKUl9OiDJR5FiwZtf0cFfFQ1QHEJWYkTIVSMt6yyyuHXytgpfr/K3LHjfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIkvQnQI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso2539690276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857182; x=1710461982; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=pIkvQnQIWFxNjYJNyjvMsnfG4CsaRWlnjpM/gDrLqTO35Y3Xp+G51s7QoiwSl6XSUx
         CubaXRgY1mqdxO9cImQC1OFCqtVU46K77QWORxLr9j/RlswtREscTEoqIWYcdqLm/y9R
         x2r0r9neCJ2vkXigtbuYXindTKpRd7Byqo6DPKWmVJE4gcgVKiXI8uxfx1D+5OUnvtH7
         JERjBdz+3+qz630bxjMiS8Ui1W27wj0+gZRzmls9eidTIU8P6VyCq3+nwEyJwNltuTma
         r49bl8T1ddDrasTYjfOZFu7wkqTYVEmDm9oo5BHB2+Tc7gvBeInJISOAXZFLd2IzuKxK
         WCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857182; x=1710461982;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=GMoywfwsO92rd9yCyHoUAznwiAC9Lg3DOvEK7yOScEyIYnrYFDvXrQhpxseHBMPfzT
         QzQ+md0CrxwJPQFR0Z6fFXLe5G2+HuSRAkElhC0qIsUJ89U3GPTJesWqFypw/1ZfJxHF
         bo4Cayu90pKYWHwR6zr4eEvlMVlqQj3SzzKfvSdDALgjePfZHJo/bi4XH8+vT3zvx9lJ
         yImyNTe8Df8+ZFlyHlpL+x7NviYxZfoGRk8H2K2dbzodYg32MPBjKfJBcs3MHzHSvGKP
         2ZzKYjVmQqLWKOlgUDOvhV7hmuBcwI31mktDAHpHzX/30TEyiBe7w38ygTATLNf2/LMh
         rRQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Vmax+phVl0bqzEtCtb/bskxp9eoY/P5YGOFEhvKVM2Er8yIdJYRf/IB5Uty4Mht501IWgjp7ozdSt4feYA/AlWuE+9vfMWxvWiWa
X-Gm-Message-State: AOJu0YxleiqnCkBhBBXZs78f0whLx73D5dVDtjeWUyAl42v42pBdPRgD
	dN1VuM247dJkS77wHd6tplUYHVFWMHojRqoD1oeorOH0EnyU6STLXGkZigyJuXcq39LWnt2X5k7
	xNlgm7Q==
X-Google-Smtp-Source: AGHT+IGZxH2VZwUiw1GgVvXnRBpm+B1jZaK1xeAq56iEuY9fI4p8nAEwAgnGzMx47spPAqo13VuXbW27mppI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr4897415ybt.6.1709857182253; Thu, 07 Mar
 2024 16:19:42 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:12 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 3/6] perf list: Allow wordwrap to wrap on commas
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

A raw event encoding may be a block with terms separated by commas. If
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


