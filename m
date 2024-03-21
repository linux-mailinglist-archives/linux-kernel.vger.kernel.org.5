Return-Path: <linux-kernel+bounces-110300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73F885CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F34428249C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6910D12CD8C;
	Thu, 21 Mar 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mdb7spP3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A6712BF23
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037001; cv=none; b=EnIsenZJnO4SUSgamAaKKBSKtW5f3XJNBBMlAQykbP3lURQpQUeAsPBAl2+Zi/nafJVXawMohBNXHAeieUNsD5//LcCLLZ+yGrJa4XDQMfeL/j7MteWjbuzfhPALY+/WTnu1Ltxl2g2XBWh3MMP3tV0Z9iIEuzCGfPS7AmY20Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037001; c=relaxed/simple;
	bh=9LrrlqsVcKRB6YFnDGI9TYjo4HpRppL0r92IM1Tgoh4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SaWWpXPPj+99gKBe4PPgW5PqvYKQI+sDZlcpLwwaoRCZ46FU70Cn2UXtiobKpUREsMFdAnh4SdzPp+BeXU5S3EfCWxWDN+zc2Xp4QXdGctO9WA5cl+t13Z6vuEZTTB9EA9rA5lDljI+en9acdP0B5QbfCWZWEE5gW92MxlTr808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mdb7spP3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd944567b6cso1494676276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711036999; x=1711641799; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9mbEbN1xeqzONkxcGNMMjxISnrWiZEkSSQzXGtcTD4=;
        b=Mdb7spP32sGQEDm0u4BJmuQ50CiiR95D5hOAsmq/iCi7OoJ9z/PgZ1jrDduIWvcnEq
         LzRn2L+Ebl0pEsVYiDeKbRBAr2fXSgS6JKwEya501VjjDNbHnnR7akVowIJ4FwMGjFXK
         hbKiaDwC1/iMznYYWQFGYFmD72sF8Qx8Kbd170XdHHt6pfssaud2oDGlimZ2+wWlPhua
         8s0D2DLmJTNwQZcU3YuHc97CU1Y6AJcaKfw0OYcMh1odkbIx5pOf8gw1wPqnk40ttePL
         AGH22U7ixF7dpWifcrknw6ylwxXI3oMzaz3jClY3C+msJJ6SP4hhzobQ+kWMcj4acE5U
         pwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036999; x=1711641799;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9mbEbN1xeqzONkxcGNMMjxISnrWiZEkSSQzXGtcTD4=;
        b=lyzEaiE0AF3i7YYgb92FOsbPDGY7oc58rmbMIra95bCLQ2GItmghM4ai4R0e3NSHou
         Fo/NZavk/65mvtflfivbiBXDp2H3UhpwT0666WY904drCt1uEUiVkKG4LofVw83rqsw6
         m+8fkoaKjGZnJhRV8d45ufA3KlafP0FSikdIaNjkz1LPL3sJcJg1bjDd9Kl2+HsEYyon
         5oReu8BmzXTayoRcuGjL6+BF7/WfbYfDe9fWLFKhmSvGYVFm2Gr+Hj/2LMXkPr9SGKzE
         EIQ+J8VyEtvq1Cmdc14sSIoYpC+zihC5WSmqyIPRAHkUfXU9SknOtebwi7x+Gqby9QKk
         hUZw==
X-Forwarded-Encrypted: i=1; AJvYcCVNeWvQ3ZprNIorjjgnCK1EbuM5ATgky03QUmEXPBDn0YtXeb54cI8lKLowlXJY2zwqeBhUdnHhQQa7vQM1PXn9g9lybD/QpKNVpAno
X-Gm-Message-State: AOJu0Yw28sT9Ng5IfKTYsOfzxQmjcjKIRJpgNJRypMLCLsKACnIAfDdu
	OIehG07CkYKiAuVNIa7EVPX3UFdviApU+844Tch0WAbouL4+sxBtOrTQZiuFVKIyBZGPq9t/Cdm
	khm8dwQ==
X-Google-Smtp-Source: AGHT+IFBX1i5W9iuhZeU/Z7RRN7eMO4Lx043+kbxsvY/o3kqCbqP8YT6t16ykoQnFPFDSBxq5mrS0mombbJY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:218c:b0:dcc:4785:b51e with SMTP
 id dl12-20020a056902218c00b00dcc4785b51emr969569ybb.12.1711036998640; Thu, 21
 Mar 2024 09:03:18 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:02:52 -0700
In-Reply-To: <20240321160300.1635121-1-irogers@google.com>
Message-Id: <20240321160300.1635121-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v2 05/13] perf dso: Move dso functions out of dsos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move dso and dso_id functions to dso.c to match the struct
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 61 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h  |  4 +++
 tools/perf/util/dsos.c | 61 ------------------------------------------
 3 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6e2a7198b382..ad562743d769 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1269,6 +1269,67 @@ static void dso__set_long_name_id(struct dso *dso, const char *name, struct dso_
 		__dsos__findnew_link_by_longname_id(root, dso, NULL, id);
 }
 
+static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	if (a->maj > b->maj) return -1;
+	if (a->maj < b->maj) return 1;
+
+	if (a->min > b->min) return -1;
+	if (a->min < b->min) return 1;
+
+	if (a->ino > b->ino) return -1;
+	if (a->ino < b->ino) return 1;
+
+	/*
+	 * Synthesized MMAP events have zero ino_generation, avoid comparing
+	 * them with MMAP events with actual ino_generation.
+	 *
+	 * I found it harmful because the mismatch resulted in a new
+	 * dso that did not have a build ID whereas the original dso did have a
+	 * build ID. The build ID was essential because the object was not found
+	 * otherwise. - Adrian
+	 */
+	if (a->ino_generation && b->ino_generation) {
+		if (a->ino_generation > b->ino_generation) return -1;
+		if (a->ino_generation < b->ino_generation) return 1;
+	}
+
+	return 0;
+}
+
+bool dso_id__empty(struct dso_id *id)
+{
+	if (!id)
+		return true;
+
+	return !id->maj && !id->min && !id->ino && !id->ino_generation;
+}
+
+void dso__inject_id(struct dso *dso, struct dso_id *id)
+{
+	dso->id.maj = id->maj;
+	dso->id.min = id->min;
+	dso->id.ino = id->ino;
+	dso->id.ino_generation = id->ino_generation;
+}
+
+int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (dso_id__empty(a) || dso_id__empty(b))
+		return 0;
+
+	return __dso_id__cmp(a, b);
+}
+
+int dso__cmp_id(struct dso *a, struct dso *b)
+{
+	return __dso_id__cmp(&a->id, &b->id);
+}
+
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 {
 	dso__set_long_name_id(dso, name, NULL, name_allocated);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3d4faad8d5dc..2c295438226d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -238,6 +238,9 @@ static inline void dso__set_loaded(struct dso *dso)
 	dso->loaded = true;
 }
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b);
+bool dso_id__empty(struct dso_id *id);
+
 struct dso *dso__new_id(const char *name, struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
@@ -245,6 +248,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+void dso__inject_id(struct dso *dso, struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d43f64939b12..f816927a21ff 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -41,67 +41,6 @@ void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	if (a->maj > b->maj) return -1;
-	if (a->maj < b->maj) return 1;
-
-	if (a->min > b->min) return -1;
-	if (a->min < b->min) return 1;
-
-	if (a->ino > b->ino) return -1;
-	if (a->ino < b->ino) return 1;
-
-	/*
-	 * Synthesized MMAP events have zero ino_generation, avoid comparing
-	 * them with MMAP events with actual ino_generation.
-	 *
-	 * I found it harmful because the mismatch resulted in a new
-	 * dso that did not have a build ID whereas the original dso did have a
-	 * build ID. The build ID was essential because the object was not found
-	 * otherwise. - Adrian
-	 */
-	if (a->ino_generation && b->ino_generation) {
-		if (a->ino_generation > b->ino_generation) return -1;
-		if (a->ino_generation < b->ino_generation) return 1;
-	}
-
-	return 0;
-}
-
-static bool dso_id__empty(struct dso_id *id)
-{
-	if (!id)
-		return true;
-
-	return !id->maj && !id->min && !id->ino && !id->ino_generation;
-}
-
-static void dso__inject_id(struct dso *dso, struct dso_id *id)
-{
-	dso->id.maj = id->maj;
-	dso->id.min = id->min;
-	dso->id.ino = id->ino;
-	dso->id.ino_generation = id->ino_generation;
-}
-
-static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	/*
-	 * The second is always dso->id, so zeroes if not set, assume passing
-	 * NULL for a means a zeroed id
-	 */
-	if (dso_id__empty(a) || dso_id__empty(b))
-		return 0;
-
-	return __dso_id__cmp(a, b);
-}
-
-int dso__cmp_id(struct dso *a, struct dso *b)
-{
-	return __dso_id__cmp(&a->id, &b->id);
-}
-
 bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 {
 	struct list_head *head = &dsos->head;
-- 
2.44.0.396.g6e790dbe36-goog


