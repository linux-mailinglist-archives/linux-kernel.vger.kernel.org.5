Return-Path: <linux-kernel+bounces-62244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFF851D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382811F24AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8C487B0;
	Mon, 12 Feb 2024 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfm8stO0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95508481C2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764361; cv=none; b=LNdFU3/OR+xpdsVuup+wWKZqZSVW6elGNJXI0J94rGtPzuuNcLXQXh3sTQDbEdPZYXfwsOUEpQbwoOqWx71H1Hgu0r+Gfoz3El4tW+zQBI6jOX8POcvp9w+9QnAqGhn4KGXsPOGuy8LAfIfqozrC3sNbpFvk4YVTkcdYQidR1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764361; c=relaxed/simple;
	bh=d/hQVr7HLwaHgpbOrtRFt5ktwlU8Fbwq9EyeSqxfkuQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PHnJV7qXkBQ5Vn1PsQHOIloLiZKIYMrYvbuYVnfdUiw3FKQBF22oC0WDDBi7VzRTaoI2liUWXSnd7q+IrC1MWZa9Ivz0faSIhiSlx+M4T1JYSQp7ceJz3sMTsAMSVkViTrQBeiNai3WSPVCeKj2Bqp1PSOAqwB9iiUuQVKk1XFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfm8stO0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso91259276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764358; x=1708369158; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORLaSbqJ7XxCjGmPCGfASaJCafSHFkQjULJrCBkVFqo=;
        b=nfm8stO0KYzzkP4P+Tp2w0E4WtZJyzqmz/HJXxxURLoqyfbAh4TizitH0krHm4FBJ1
         3/8Bls53sKDsGG9VhF4IEjM8NgdYV0QtHmjqyE+yah5mFw5ahYfi9nt4Knu+Xkvoq4+z
         wYLClti3uaX37SZjZRluHoM0UNS8i9rde3LhQA/4dvQYZUih3VctBUGWh9coP+3EUgoZ
         VppjjN2c8PWmJ9lcy1QILsfJ4Pc9AXAP4ah45JKjPwpOXDlg9Hw495ReiZ/qgx1wGYJj
         ofQz76wHT+4stLCUoAsN5bD7Qa49f24YernNIHZwihw87N2d3S7FNzwXqDP7Wx5bbCWd
         91zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764358; x=1708369158;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORLaSbqJ7XxCjGmPCGfASaJCafSHFkQjULJrCBkVFqo=;
        b=YPDDPwMUIq7WhvHENlBqG01gIDPczNL4hkuMTuAgmXq32zOIHR3PcXy2O7Mjgm44lY
         2SsqVe5V0/7zFNDxmNDxBAw/RY806bvEdt475kJJeGUE7cxiugwXMeqjEVPUgmkkic0S
         o0Qvqgst7nciJpJvgyhXqChhNZN95Ok9Kct6/9v7kzpxIlTyUi4/r9PeNA2GNB0J2HWB
         IeJj7cB4yBwHF1mT9Os1g6/fsxoGMjGnaD1heMpw1lO6Ii1EPxttZgzmxh13PbZabqeR
         djCfRny823aqI0TawCX6HxsbRR13qpzBuG1RflG3yYbWvfBsKFjkCAmE7n0h4h3o0df8
         Zf0g==
X-Forwarded-Encrypted: i=1; AJvYcCVCFHNNtJePZ9g6R33og+cMisenrn4c2PCAH9oSvJ2EloGf05gS6aaydNHvVMu4mbt0XsChf7Ltbt0ixYRdWMZp6XVpXhE84DFVc+6d
X-Gm-Message-State: AOJu0YwMpJEhu7+hwtOaU0iSF5QIs/rimMFEm/Sa3w8DuR67HSmar/uH
	kHb9mV1/rqrbwRArXaPlN5v83CIlP6u//3L1g5PYbm0aHZMaeJBObAKk+wO7p1DOdk4dl5+6ThG
	ddQ7XSQ==
X-Google-Smtp-Source: AGHT+IEgg5F6/JDC9O18WbAqy6Jn09Lk9KedltE8Flre9vl6bkzkS2WkyxJZcH+1HD8YPk9Has0tt+LZbMMt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1027:b0:dc2:550b:a4f4 with SMTP
 id x7-20020a056902102700b00dc2550ba4f4mr1970106ybt.1.1707764358452; Mon, 12
 Feb 2024 10:59:18 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:55 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 5/8] perf test: Rename builtin-test-list and add missed
 header guard
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

builtin-test-list is primarily concerned with shell script
tests. Rename the file to better reflect this and add a missed header
guard.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build                                    | 2 +-
 tools/perf/tests/builtin-test.c                           | 2 +-
 tools/perf/tests/{builtin-test-list.c => tests-scripts.c} | 2 +-
 tools/perf/tests/{builtin-test-list.h => tests-scripts.h} | 4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename tools/perf/tests/{builtin-test-list.c => tests-scripts.c} (99%)
 rename tools/perf/tests/{builtin-test-list.h => tests-scripts.h} (79%)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 53ba9c3e20e0..c7f9d9676095 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 perf-y += builtin-test.o
-perf-y += builtin-test-list.o
+perf-y += tests-scripts.o
 perf-y += parse-events.o
 perf-y += dso-data.o
 perf-y += attr.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4a5973f9bb9b..eff3c62e9b47 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -29,7 +29,7 @@
 #include <subcmd/exec-cmd.h>
 #include <linux/zalloc.h>
 
-#include "builtin-test-list.h"
+#include "tests-scripts.h"
 
 static bool dont_fork;
 const char *dso_to_test;
diff --git a/tools/perf/tests/builtin-test-list.c b/tools/perf/tests/tests-scripts.c
similarity index 99%
rename from tools/perf/tests/builtin-test-list.c
rename to tools/perf/tests/tests-scripts.c
index a65b9e547d82..4ebd841da05b 100644
--- a/tools/perf/tests/builtin-test-list.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -15,7 +15,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include "builtin.h"
-#include "builtin-test-list.h"
+#include "tests-scripts.h"
 #include "color.h"
 #include "debug.h"
 #include "hist.h"
diff --git a/tools/perf/tests/builtin-test-list.h b/tools/perf/tests/tests-scripts.h
similarity index 79%
rename from tools/perf/tests/builtin-test-list.h
rename to tools/perf/tests/tests-scripts.h
index eb81f3aa6683..3a3ec6191848 100644
--- a/tools/perf/tests/builtin-test-list.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef TESTS_SCRIPTS_H
+#define TESTS_SCRIPTS_H
 
 struct script_file {
 	char *dir;
@@ -10,3 +12,5 @@ struct script_file {
 const struct script_file *list_script_files(void);
 /* Get maximum width of description string */
 int list_script_max_width(void);
+
+#endif /* TESTS_SCRIPTS_H */
-- 
2.43.0.687.g38aa6559b0-goog


