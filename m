Return-Path: <linux-kernel+bounces-91113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BD8709B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B1E1F21636
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF37C080;
	Mon,  4 Mar 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu+d5spo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B367BAEF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577364; cv=none; b=kjb6yJUbj9ju4KJ6ErkJBbfopiDHT+4h+ET6BfKXtrpwJUsqm300Me4SHPdtXc6Bm6cqYD3ztsX+ER65A/0kFrzzPqLF87IcNc2byea1caZbKp4kfrat/PmfccM2rnxohpB+AyCo5CWPmdVEumwHT1MOLcEY4ESoCth3NvJ5z2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577364; c=relaxed/simple;
	bh=UxBICEnGoxJN1FLWr1JpuU/MzleQ8XlBL+nMW6Wy8ho=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tIZ78tGt5l+GSPE9Re28Hmc7V6NSjyKbTEn4oxEiIPrI+sQb5y5MZ645xkmF3N510c7IY7BCLQVeNNiMHM+xCss5Ipo1j83QcY3GD9O4KOuvrZP/vhBXRdpZe4d8GyWrK8fdoRojyrv1omvQFU7fezKyYYVmafQmlZSymnpvMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wu+d5spo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60942936e31so85335587b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577361; x=1710182161; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjtFtniifoQlqJRub627DOEGH25VNIzcRPx8GUuqtSw=;
        b=Wu+d5spoQaZo0zgV3uerVsox+G3/Ix+4RXUUDus01I4fpNX5Rh3foluz9zJpwmXXDJ
         wI44DKOaGz2SrcYg9eILyhYbyZRxrY7qDianm6cye33Zt879VpHRcw4sF3afr2/cKSwP
         +VAqVEZPgbVi8T/ismYw55jzNepjD6N69Enx6Sj08H48EagLbjS8ObcYbpxAoyLm0mVD
         Eg1SPvKLBraWnXyWPAdPuDbKbFtbCEURqJ18V1vgkAUe8W1Pe+24om4feP9nW0uGeFOj
         3GQvBnUkmQseiuIDm4Fr4ulFmA/AUSGpBiF3C31DAjl6rcFjbos9JO3t83DrR3kfLiQf
         AlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577361; x=1710182161;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjtFtniifoQlqJRub627DOEGH25VNIzcRPx8GUuqtSw=;
        b=kXC+QCYqli7Dm0m3lN5F+hpYVEIRj6Td0DtLHOcRwyeNyW2MMgrH9h7v+JDDlF7uzE
         jI4hMtguWtPnbjlPp+7oOE0CBGfUb8PWMYd8nDyGb+pvTanNCyMPuVoSCRpIyNXKE9bf
         2k+GNUWJOYIVB9KWQFDB01/USaOD5SBSyAq4/+ELIs7lX831UTRmRtvcX2vYTJpuH3yJ
         8+6TbcnayWZlfXjS+W1Vf5xyzDchUklDOy+RqASBFgh/dRS/aHtZGeEoX9Qg9yqnLiPm
         Du2Tl8xD+/l2fpxbKm93QPzbnTSQDF+y/fA1EYTRm5oAy4a7DxLhJXcB7viM7l3UuSE1
         so8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1Oh5wly+EEgH8+oGeTW2V9H6305A3m4n9yV8bpqBY02hLD6/xPmAKD3fThdX/AlCPPiHEpssZPYwFbmZmRaGHgRaA/t0yT9D4r1o7
X-Gm-Message-State: AOJu0Yw5Hbp36isIMRVqgNa9rrfG9NHlD7Id0/kwwPaRe+Dhul6fZwct
	tpl3klIgwjP4e/vpnPJWlTgq0rHbBCbJ1xQFFbUlKnfmEaoj6mY3iBOfKFI7zjdbDvTOCi46LTU
	NaAFRNw==
X-Google-Smtp-Source: AGHT+IHYOjFVH6Dr/OVAJoImhoh7qAf1dpmY1zuEGfYpsOK5zEd5Lo7cjpUXgoE1elXkFnURIrd50lVYOvz6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a05:690c:3386:b0:609:2570:f06f with SMTP
 id fl6-20020a05690c338600b006092570f06fmr2734889ywb.0.1709577361605; Mon, 04
 Mar 2024 10:36:01 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:20 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/13] perf dsos: Remove __dsos__findnew_link_by_longname_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function was only called in dsos.c with the dso parameter as
NULL. Remove the function and specialize for the dso being NULL case
removing other unused functions along the way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 51 +++++++++---------------------------------
 tools/perf/util/dsos.h |  6 -----
 2 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1495ab1cd7a0..e4110438841b 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -119,11 +119,6 @@ static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, stru
 	return rc ?: dso_id__cmp(id, &b->id);
 }
 
-static int dso__cmp_short_name(struct dso *a, struct dso *b)
-{
-	return __dso__cmp_short_name(a->short_name, &a->id, b);
-}
-
 static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 {
 	const struct dso *a = *((const struct dso **)va);
@@ -143,20 +138,21 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
  * Either one of the dso or name parameter must be non-NULL or the
  * function will not work.
  */
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked)
+static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
+					       const char *name,
+					       struct dso_id *id,
+					       bool write_locked)
 {
 	int low = 0, high = dsos->cnt - 1;
 
 	if (!dsos->sorted) {
 		if (!write_locked) {
+			struct dso *dso;
+
 			up_read(&dsos->lock);
 			down_write(&dsos->lock);
-			dso = __dsos__findnew_link_by_longname_id(dsos, dso, name, id,
-								  /*write_locked=*/true);
+			dso = __dsos__find_by_longname_id(dsos, name, id,
+							  /*write_locked=*/true);
 			up_write(&dsos->lock);
 			down_read(&dsos->lock);
 			return dso;
@@ -166,9 +162,6 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		dsos->sorted = true;
 	}
 
-	if (!name)
-		name = dso->long_name;
-
 	/*
 	 * Find node with the matching name
 	 */
@@ -178,31 +171,13 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		int rc = __dso__cmp_long_name(name, id, this);
 
 		if (rc == 0) {
-			/*
-			 * In case the new DSO is a duplicate of an existing
-			 * one, print a one-time warning & put the new entry
-			 * at the end of the list of duplicates.
-			 */
-			if (!dso || (dso == this))
-				return dso__get(this);	/* Find matching dso */
-			/*
-			 * The core kernel DSOs may have duplicated long name.
-			 * In this case, the short name should be different.
-			 * Comparing the short names to differentiate the DSOs.
-			 */
-			rc = dso__cmp_short_name(dso, this);
-			if (rc == 0) {
-				pr_err("Duplicated dso name: %s\n", name);
-				return NULL;
-			}
+			return dso__get(this);	/* Find matching dso */
 		}
 		if (rc < 0)
 			high = mid - 1;
 		else
 			low = mid + 1;
 	}
-	if (dso)
-		__dsos__add(dsos, dso);
 	return NULL;
 }
 
@@ -240,12 +215,6 @@ int dsos__add(struct dsos *dsos, struct dso *dso)
 	return ret;
 }
 
-static struct dso *__dsos__findnew_by_longname_id(struct dsos *dsos, const char *name,
-						struct dso_id *id, bool write_locked)
-{
-	return __dsos__findnew_link_by_longname_id(dsos, NULL, name, id, write_locked);
-}
-
 struct dsos__find_id_cb_args {
 	const char *name;
 	struct dso_id *id;
@@ -279,7 +248,7 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
 		return args.res;
 	}
-	res = __dsos__findnew_by_longname_id(dsos, name, id, write_locked);
+	res = __dsos__find_by_longname_id(dsos, name, id, write_locked);
 	return res;
 }
 
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index d1497b11d64c..6c13b65648bc 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -36,12 +36,6 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked);
-
 size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
 size_t dsos__fprintf(struct dsos *dsos, FILE *fp);
-- 
2.44.0.278.ge034bb2e1d-goog


