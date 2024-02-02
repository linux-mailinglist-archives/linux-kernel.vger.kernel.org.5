Return-Path: <linux-kernel+bounces-49255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273A8467E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C679128390D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEC179A1;
	Fri,  2 Feb 2024 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBv5Y8X7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B13C6AB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854587; cv=none; b=UvfmExpoXMOj84kXg2tAh4Dyx3nF7eY0X1hm8usgtXcXasfQVASk6PtcGdTsX3q7mEHRPDeoPnrbZ4/9YMlwoSlXDeL+w+hzcuL7L7Y9R6852MbVVEDeH0KL8/pdwh8P+mbW7y/tHWOGzDm8MYD76VCKuJmjjGUMa4vEVz4b8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854587; c=relaxed/simple;
	bh=5pE1qvK1fYTNOeSBYi4QQe4IkMxKf3KSLXZ7xDFk9OI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KfB0e5xI5sncKWuADkGKXpEDYCVMCk89Vv+pu1VaTUHfqEJ8aoTgMMZhmKNDLyNDq9mG9tYt+Eysrljm3sJZ3+PpuXN5At2iHLa9ErfWHFY3qUCE5tKMAackmOQ0dMcyHKWrjYYSOytzxmIxVirUBkyEhPXEisbtrAdTyNGK70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBv5Y8X7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60411f95c44so23830247b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854584; x=1707459384; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9mbHm8cDPd1+y5BhdsOmJ6AdIbzp48vKITNdXoTURk=;
        b=HBv5Y8X7qkyqO2E2xUF1JYzCfLMBo7isiRnG8XNKC3P3jirWpos2Ma9nEfcSJ3NdIP
         oWUlCPBoUUMLNh9tlga5z1nlUP5OuCO4MRrMlU78T2bdRxPXi8NO6XbkuuS3llUF7WgE
         5RdnmhEHUmlMEDFWOSs4MhLp1d5n1SSScm/0Q3RBr9xtbgcw63fR9Bgsx6miGL09DYRC
         swUhSITkxGdmjNCUGO3tClbTPYC9Tbwj40grsVJgn/uiKJ1SfEUldCi9onDh97d23GK3
         w02SYCuOz9gS5r6LQ4x/yZSjmKLlKziGYbnBSqldoxSnDP9NCn4ljlCCiaDCVkJ9U80l
         VV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854584; x=1707459384;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9mbHm8cDPd1+y5BhdsOmJ6AdIbzp48vKITNdXoTURk=;
        b=hzNIr/jGP/ZN+3tBMaYWjl47XwwYRri7sn9+dbE4D/fM539bB/spFvR2VLwfRAbWUL
         ntKWCF7YmivnWRNIK/C/fgQK/ckKgyk8Q1NRUI2WnKK3kdloWkvZrXKlnTdQU/I/cB3R
         Bi+IDdSRT00JtUHYnQO/PWlR6VWcwOEDKMo7szqiAyOuL1r/O4Axpovoee97r1XEhvMC
         PWxEG+XMAl4H13wMvcNXlWGnFOn9ByB/j/tAOA/fcajUqwt5B5lr1cxwhRrRbGY0TxZd
         uQ9wNcyVHtdgfa1UHZFcm5FpanhLJziT/fFI+CO+z9WueXFOv+Yr336ghGf13fnq+Ozt
         IAkg==
X-Gm-Message-State: AOJu0YxiEJPY+9X231J3BOZ2lT2V1Lp9YUzqHlNLmqb0APpB0fEVDojv
	3nG0wuLAguCNi4Pkd7x+w8Qstjp92QrRNesGD7ulQEhdorANXqpwAaSvWG7kOrARSZslr5wqq1m
	ftNOhMA==
X-Google-Smtp-Source: AGHT+IG163EvUGQUAZNOn7Xi/xgRPwQFzquMZLOTAecY+sWXLeKyZIgSQJEVq0A0behbxKOD9Di6rzML01g+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:690c:f85:b0:5f9:abfe:243c with SMTP id
 df5-20020a05690c0f8500b005f9abfe243cmr1171029ywb.3.1706854583718; Thu, 01 Feb
 2024 22:16:23 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:23 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 16/25] perf dsos: Add dsos__for_each_dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

To better abstract the dsos internals, add dsos__for_each_dso that
does a callback on each dso. This also means the read lock can be
correctly held.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 25 +++++++-----
 tools/perf/util/build-id.c  | 76 ++++++++++++++++++++-----------------
 tools/perf/util/dsos.c      | 16 ++++++++
 tools/perf/util/dsos.h      |  8 +---
 tools/perf/util/machine.c   | 40 +++++++++++--------
 5 files changed, 100 insertions(+), 65 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ef73317e6ae7..ce5e28eaad90 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1187,23 +1187,28 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 					       process_build_id, machine);
 }
 
+static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
+{
+	struct guest_session *gs = data;
+	struct perf_inject *inject = container_of(gs, struct perf_inject, guest_session);
+
+	if (!dso->has_build_id)
+		return 0;
+
+	return synthesize_build_id(inject, dso, gs->machine_pid);
+
+}
+
 static int guest_session__add_build_ids(struct guest_session *gs)
 {
 	struct perf_inject *inject = container_of(gs, struct perf_inject, guest_session);
-	struct machine *machine = &gs->session->machines.host;
-	struct dso *dso;
-	int ret;
 
 	/* Build IDs will be put in the Build ID feature section */
 	perf_header__set_feat(&inject->session->header, HEADER_BUILD_ID);
 
-	dsos__for_each_with_build_id(dso, &machine->dsos.head) {
-		ret = synthesize_build_id(inject, dso, gs->machine_pid);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return dsos__for_each_dso(&gs->session->machines.host.dsos,
+				  guest_session__add_build_ids_cb,
+				  gs);
 }
 
 static int guest_session__ksymbol_event(struct perf_tool *tool,
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a617b1917e6b..a6d3c253f19f 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -327,48 +327,56 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	return write_padded(fd, name, name_len + 1, len);
 }
 
-static int machine__write_buildid_table(struct machine *machine,
-					struct feat_fd *fd)
+struct machine__write_buildid_table_cb_args {
+	struct machine *machine;
+	struct feat_fd *fd;
+	u16 kmisc, umisc;
+};
+
+static int machine__write_buildid_table_cb(struct dso *dso, void *data)
 {
-	int err = 0;
-	struct dso *pos;
-	u16 kmisc = PERF_RECORD_MISC_KERNEL,
-	    umisc = PERF_RECORD_MISC_USER;
+	struct machine__write_buildid_table_cb_args *args = data;
+	const char *name;
+	size_t name_len;
+	bool in_kernel = false;
 
-	if (!machine__is_host(machine)) {
-		kmisc = PERF_RECORD_MISC_GUEST_KERNEL;
-		umisc = PERF_RECORD_MISC_GUEST_USER;
-	}
+	if (!dso->has_build_id)
+		return 0;
 
-	dsos__for_each_with_build_id(pos, &machine->dsos.head) {
-		const char *name;
-		size_t name_len;
-		bool in_kernel = false;
+	if (!dso->hit && !dso__is_vdso(dso))
+		return 0;
 
-		if (!pos->hit && !dso__is_vdso(pos))
-			continue;
+	if (dso__is_vdso(dso)) {
+		name = dso->short_name;
+		name_len = dso->short_name_len;
+	} else if (dso__is_kcore(dso)) {
+		name = args->machine->mmap_name;
+		name_len = strlen(name);
+	} else {
+		name = dso->long_name;
+		name_len = dso->long_name_len;
+	}
 
-		if (dso__is_vdso(pos)) {
-			name = pos->short_name;
-			name_len = pos->short_name_len;
-		} else if (dso__is_kcore(pos)) {
-			name = machine->mmap_name;
-			name_len = strlen(name);
-		} else {
-			name = pos->long_name;
-			name_len = pos->long_name_len;
-		}
+	in_kernel = dso->kernel || is_kernel_module(name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
+	return write_buildid(name, name_len, &dso->bid, args->machine->pid,
+			     in_kernel ? args->kmisc : args->umisc, args->fd);
+}
 
-		in_kernel = pos->kernel ||
-				is_kernel_module(name,
-					PERF_RECORD_MISC_CPUMODE_UNKNOWN);
-		err = write_buildid(name, name_len, &pos->bid, machine->pid,
-				    in_kernel ? kmisc : umisc, fd);
-		if (err)
-			break;
+static int machine__write_buildid_table(struct machine *machine, struct feat_fd *fd)
+{
+	struct machine__write_buildid_table_cb_args args = {
+		.machine = machine,
+		.fd = fd,
+		.kmisc = PERF_RECORD_MISC_KERNEL,
+		.umisc = PERF_RECORD_MISC_USER,
+	};
+
+	if (!machine__is_host(machine)) {
+		args.kmisc = PERF_RECORD_MISC_GUEST_KERNEL;
+		args.umisc = PERF_RECORD_MISC_GUEST_USER;
 	}
 
-	return err;
+	return dsos__for_each_dso(&machine->dsos, machine__write_buildid_table_cb, &args);
 }
 
 int perf_session__write_buildid_table(struct perf_session *session,
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d269e09005a7..d43f64939b12 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -433,3 +433,19 @@ struct dso *dsos__find_kernel_dso(struct dsos *dsos)
 	up_read(&dsos->lock);
 	return res;
 }
+
+int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data)
+{
+	struct dso *dso;
+
+	down_read(&dsos->lock);
+	list_for_each_entry(dso, &dsos->head, node) {
+		int err;
+
+		err = cb(dso, data);
+		if (err)
+			return err;
+	}
+	up_read(&dsos->lock);
+	return 0;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a7c7f723c5ff..317a263f0e37 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -23,12 +23,6 @@ struct dsos {
 	struct rw_semaphore lock;
 };
 
-#define dsos__for_each_with_build_id(pos, head)	\
-	list_for_each_entry(pos, head, node)	\
-		if (!pos->has_build_id)		\
-			continue;		\
-		else
-
 void dsos__init(struct dsos *dsos);
 void dsos__exit(struct dsos *dsos);
 
@@ -55,4 +49,6 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
 
 struct dso *dsos__find_kernel_dso(struct dsos *dsos);
 
+int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8d0ea17e432a..f1186a5bb73c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1561,16 +1561,14 @@ int machine__create_kernel_maps(struct machine *machine)
 	return ret;
 }
 
-static bool machine__uses_kcore(struct machine *machine)
+static int machine__uses_kcore_cb(struct dso *dso, void *data __maybe_unused)
 {
-	struct dso *dso;
-
-	list_for_each_entry(dso, &machine->dsos.head, node) {
-		if (dso__is_kcore(dso))
-			return true;
-	}
+	return dso__is_kcore(dso) ? 1 : 0;
+}
 
-	return false;
+static bool machine__uses_kcore(struct machine *machine)
+{
+	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL) != 0 ? true : false;
 }
 
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
@@ -3136,16 +3134,28 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 	return sym->name;
 }
 
+struct machine__for_each_dso_cb_args {
+	struct machine *machine;
+	machine__dso_t fn;
+	void *priv;
+};
+
+static int machine__for_each_dso_cb(struct dso *dso, void *data)
+{
+	struct machine__for_each_dso_cb_args *args = data;
+
+	return args->fn(dso, args->machine, args->priv);
+}
+
 int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv)
 {
-	struct dso *pos;
-	int err = 0;
+	struct machine__for_each_dso_cb_args args = {
+		.machine = machine,
+		.fn = fn,
+		.priv = priv,
+	};
 
-	list_for_each_entry(pos, &machine->dsos.head, node) {
-		if (fn(pos, machine, priv))
-			err = -1;
-	}
-	return err;
+	return dsos__for_each_dso(&machine->dsos, machine__for_each_dso_cb, &args);
 }
 
 int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
-- 
2.43.0.594.gd9cf4e227d-goog


