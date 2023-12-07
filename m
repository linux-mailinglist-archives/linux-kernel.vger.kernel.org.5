Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE1807DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443017AbjLGBUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443070AbjLGBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:19:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC572717
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d7e7e10231so1135197b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911935; x=1702516735; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8H+bNeEtWU1LavaiurMFyUQR8Mkuge7Y4hPyfLNkgoY=;
        b=p986j8BiVZznnSFdjjwJL0viUUTHwH/1bXQMcX3QrrGVIwMVAcU57x+dsHTM8wmmkP
         4IRGqVcBI5E0+hDC9z8kAW4WJpTjYrX/HtKXkVqQyRUTwtsZP6tMgfrK0AL/x6iBQ4P2
         mW4uVVfCAF2P4CMnVvGGiLiNmieTUK7calFSEIprWkzOYWvqZzFxpI5xg2hanzVIsPfP
         TaZMmfrdRTEns3tJcuIrU3ZWrTUW0Y7f7DyMh9kl7f7WRniRm8c6JFKNJ1QczzyV6EW6
         NgORjDATjEffWGE22JUnQPNvC213StCjLjGvAxc9+HyRrMAFh7GBeObFw0xVnb2QPa5f
         YjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911935; x=1702516735;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8H+bNeEtWU1LavaiurMFyUQR8Mkuge7Y4hPyfLNkgoY=;
        b=FGD9E8TyrJEszfctiAjdYd0I7NS433HKOUYmz98sVhK8nBffgApIsWju5UgYlYm8rQ
         KSznpcq5Jc83imYbAVkFIFlewjWxZBr8JEoWmR3wxES4ug/mCr7X9ZVv/ZwowVPo44ef
         qDwUkbqZg3nq8cV9VSk+wLRkjgNpCrZRYlxFnV2JcgFbA/Qj+a4xbhtvZ8KFXQ5ygLF0
         kTZiUK8AQbnjH4NxUuXfHG1Detp9SVvCWjz2KPKmpRtrClzNuY3J0LTqsfmYKOBTqOs4
         b7htJD3Voj9bT4H52HFGrFwCxEV30ExbRv/H3dxzdfkaNWZR1bGoPpvGQfek/f6fdI+v
         TeEg==
X-Gm-Message-State: AOJu0YzvKz05ktKcLRkSe7vnMkp6jwWffm0Fy3Q9VKOH2xHH4s8vkMin
        1lBTL4nLKtMwTRkiUvjeSmxKIMLLWynV
X-Google-Smtp-Source: AGHT+IFWSCeO7cK5in14tf6uiuvvG62oc0OtrdqaDb8jak/NrNzbFXQWU2rIqDdf5/M4F5qWGfl5dAjHwGhE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b8c:b0:5d8:ef49:748 with SMTP id
 en12-20020a05690c2b8c00b005d8ef490748mr105333ywb.5.1701911935482; Wed, 06 Dec
 2023 17:18:55 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:12 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-39-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 38/47] perf dsos: Add dsos__for_each_dso
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.43.0.rc2.451.g8631bc7472-goog

