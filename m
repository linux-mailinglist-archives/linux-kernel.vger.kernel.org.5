Return-Path: <linux-kernel+bounces-110305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1B885CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863CC1C2232F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C3212DD85;
	Thu, 21 Mar 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeYmSESZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608D12D752
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037015; cv=none; b=rqdf2R5azPeqEx9c5Gqu6mJaFJE+BZTwsQsw6SrL+oRHvG6U8kgcjVrVQlKMam28O7B2XRjEvof5aEN8jlkqStNLDmgnaiMTeiTMlxAWiQdsryK/NL8aNL30YEuuRfNeU/q42RCGDHOW0GEWgkS9CvzaOIJeEupoIPfXDdwHs98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037015; c=relaxed/simple;
	bh=FdcVwa6jh1vhtevvSVIZ1eIHhvgiOynPZiHgwCY919Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XIKWXh2qcOCp2RwJcuc0py7OUvBkgoJdDmDXdB+Wk92lP1Jh4C9ykxyRMA8IjA7ccKRn13g/2CiEjm9GHbjheNeZgXezxzZs76+ZdGr45YWRZ8C1yPYb184rOirdGtZAdMcPbn9NOE7IWyYNqKzxBu+vVsJC7LkYT91vXCVZU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeYmSESZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so1692207276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711037013; x=1711641813; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o76ugCV3An0K5fdYO1n9nYRvHF1/7Rh4K9YTwb1u+VI=;
        b=HeYmSESZn5x3DIPRLeBucraWCq/bgEFJHR0q2EN4n4ZyOefkgs+t67EjNci57gdvc5
         VunoEHR/CK5PWNDJP0UknfcdcqJBZ19QaDhtOe1IBzhYHAa/ta2Dp9wVUgeVmbFAEGQB
         LGfmDzG7ODXQfpYF/GiAPreieJtOAfwGHfHyJDAGXqyxeR3Sbc3bm8IhzZ+/tzKRQrht
         yqxVqcPYtcElRljCpa0Svli9eee4H+pyU4ayjq317O2krAa1FlwaNhfZTpuIed60Cstn
         N6TlQS5e3Quw4AiPaV7pCxBt5Ptigynp1zHdi1i5DxmmdxibNNKbLBubULfy7CTFEYBC
         friQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037013; x=1711641813;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o76ugCV3An0K5fdYO1n9nYRvHF1/7Rh4K9YTwb1u+VI=;
        b=wvSMfhKLfPqFPSI856m+g1M1rlZqxBtjJYNzCQwnrrKXXhvyJLWACzhcTkPVFQBxTT
         okr7HpSQ+yTgLdHR9T704//j8s0x2JHMqynTGK+edrQP4U2P6R5kp6magDiwEVjTgH+U
         UJBgCfQwxxLv/fieb0axoz87j3q0bY1Zr4JsGC4fLn+5xbbs/hqsJSk6H4rYZHO9IDJd
         Vew9Aj/vxb7H8geevNI8Ee5lJMi6tpr1i5RlOara5KafWQdzCpfTTOb0ll3lylN9N5Kr
         /R/JHPqQBExXnAZPP4jwkQxlvRIFfmeLdbCsr4zTGK4pHgAkj2LYcjqL3ihlsQ6LmkC8
         hHPg==
X-Forwarded-Encrypted: i=1; AJvYcCUE521fMS0tl6ixgDXTg/aS2hyx3ZVdQHvRrCaNYZNRBIAlR3i0jRgLGKJji80TlCkbjCo6d2JNB3RjYqDLIHbrBiz6bwUtBhvDGshI
X-Gm-Message-State: AOJu0YzaVw8zPh20lAfo/wVqV+ABHQS3F1KLGnGmJ1RpTzT2PJopX2M0
	CMSNa2tjDAbsy1o0qKESCd03SeRg6WtHBNOcu3hBKNkauVMokuopOPd3VVRaovRJ2tH33MciSH/
	PASe63A==
X-Google-Smtp-Source: AGHT+IHcmf0pKTCFxGvZtBxL4QRYeWkGCOD1HrG1KWjoNaorGeWkBU+4FeO4sIGsphZtJGzlmt3DLmDqL+/H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c3:b0:dc6:cafd:dce5 with SMTP
 id ck3-20020a05690218c300b00dc6cafddce5mr5443997ybb.12.1711037012790; Thu, 21
 Mar 2024 09:03:32 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:02:57 -0700
In-Reply-To: <20240321160300.1635121-1-irogers@google.com>
Message-Id: <20240321160300.1635121-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v2 10/13] perf dsos: Switch hand code to bsearch
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

Switch to using the bsearch library function rather than having a hand
written binary search. Const-ify some static functions to avoid
compiler warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e4110438841b..23c3fe4f2abb 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -107,13 +107,15 @@ bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 	return args.have_build_id;
 }
 
-static int __dso__cmp_long_name(const char *long_name, struct dso_id *id, struct dso *b)
+static int __dso__cmp_long_name(const char *long_name, const struct dso_id *id,
+				const struct dso *b)
 {
 	int rc = strcmp(long_name, b->long_name);
 	return rc ?: dso_id__cmp(id, &b->id);
 }
 
-static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, struct dso *b)
+static int __dso__cmp_short_name(const char *short_name, const struct dso_id *id,
+				 const struct dso *b)
 {
 	int rc = strcmp(short_name, b->short_name);
 	return rc ?: dso_id__cmp(id, &b->id);
@@ -133,6 +135,19 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 	return rc;
 }
 
+struct dsos__key {
+	const char *long_name;
+	const struct dso_id *id;
+};
+
+static int dsos__cmp_key_long_name_id(const void *vkey, const void *vdso)
+{
+	const struct dsos__key *key = vkey;
+	const struct dso *dso = *((const struct dso **)vdso);
+
+	return __dso__cmp_long_name(key->long_name, key->id, dso);
+}
+
 /*
  * Find a matching entry and/or link current entry to RB tree.
  * Either one of the dso or name parameter must be non-NULL or the
@@ -143,7 +158,11 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 					       struct dso_id *id,
 					       bool write_locked)
 {
-	int low = 0, high = dsos->cnt - 1;
+	struct dsos__key key = {
+		.long_name = name,
+		.id = id,
+	};
+	struct dso **res;
 
 	if (!dsos->sorted) {
 		if (!write_locked) {
@@ -162,23 +181,12 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 		dsos->sorted = true;
 	}
 
-	/*
-	 * Find node with the matching name
-	 */
-	while (low <= high) {
-		int mid = (low + high) / 2;
-		struct dso *this = dsos->dsos[mid];
-		int rc = __dso__cmp_long_name(name, id, this);
+	res = bsearch(&key, dsos->dsos, dsos->cnt, sizeof(struct dso *),
+		      dsos__cmp_key_long_name_id);
+	if (!res)
+		return NULL;
 
-		if (rc == 0) {
-			return dso__get(this);	/* Find matching dso */
-		}
-		if (rc < 0)
-			high = mid - 1;
-		else
-			low = mid + 1;
-	}
-	return NULL;
+	return dso__get(*res);
 }
 
 int __dsos__add(struct dsos *dsos, struct dso *dso)
-- 
2.44.0.396.g6e790dbe36-goog


