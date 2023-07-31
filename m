Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7668B769190
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjGaJWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjGaJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:21:59 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24561213B;
        Mon, 31 Jul 2023 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690795192; x=1722331192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L2gM3sL/YTr00hHFWJoLUZFQJP92yZxImQ45ZJxtXOI=;
  b=WHL0R3KoEjm8SzyTfhk/Yl6tq0jEqOV/ClqPP/FUfSL9y2IF09p7cV8M
   nZ/xkyG07ZiPpU8+woms7AQTeCREa3AtDrF1fEb+nmvlN6BeCD6GbJlZl
   xTiURnblpQcI8oFVGZhFtvwsKJG2UkxSax9ysVVE6UT8zY9ogxDhkmtje
   tirkVSUejqmSFDqd3ZTmbGuY2rUjsDy2/eUgSLBjGMDNEM0bmRzBYcPon
   w7XDItUtcR4a3A4XTv5wi8ggimbQ67Ec1wSTz1lNyd1/CcRGLYKNIY2HZ
   HZJy50bbAbbAvKFNGrT+Iab98R4ogik4FlBZPRrpE+ZARvdeWBv2YmznY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435273443"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435273443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="728232909"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="728232909"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:19:13 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf dlfilter: Add al_cleanup()
Date:   Mon, 31 Jul 2023 12:18:57 +0300
Message-Id: <20230731091857.10681-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091857.10681-1-adrian.hunter@intel.com>
References: <20230731091857.10681-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_dlfilter_fns.al_cleanup() to do addr_location__exit() on
data passed via perf_dlfilter_fns.resolve_address().

Add dlfilter-test-api-v2 to the "dlfilter C API" test to test it.

Update documentation, clarifying that data returned by APIs should not
be dereferenced after filter_event() and filter_event_early() return.

Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt  |  22 +-
 tools/perf/Makefile.perf                    |   2 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c | 377 ++++++++++++++++++++
 tools/perf/include/perf/perf_dlfilter.h     |  11 +-
 tools/perf/tests/dlfilter-test.c            |  38 +-
 tools/perf/util/dlfilter.c                  |  29 ++
 6 files changed, 464 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-test-api-v2.c

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index fb22e3b31dc5..8887cc20a809 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -64,6 +64,12 @@ internal filtering.
 If implemented, 'filter_description' should return a one-line description
 of the filter, and optionally a longer description.
 
+Do not assume the 'sample' argument is valid (dereferenceable)
+after 'filter_event' and 'filter_event_early' return.
+
+Do not assume data referenced by pointers in struct perf_dlfilter_sample
+is valid (dereferenceable) after 'filter_event' and 'filter_event_early' return.
+
 The perf_dlfilter_sample structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -150,7 +156,8 @@ struct perf_dlfilter_fns {
 	const char *(*srcline)(void *ctx, __u32 *line_number);
 	struct perf_event_attr *(*attr)(void *ctx);
 	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
-	void *(*reserved[120])(void *);
+	void (*al_cleanup)(void *ctx, struct perf_dlfilter_al *al);
+	void *(*reserved[119])(void *);
 };
 ----
 
@@ -161,7 +168,8 @@ struct perf_dlfilter_fns {
 'args' returns arguments from --dlarg options.
 
 'resolve_address' provides information about 'address'. al->size must be set
-before calling. Returns 0 on success, -1 otherwise.
+before calling. Returns 0 on success, -1 otherwise. Call al_cleanup() (if present,
+see below) when 'al' data is no longer needed.
 
 'insn' returns instruction bytes and length.
 
@@ -171,6 +179,12 @@ before calling. Returns 0 on success, -1 otherwise.
 
 'object_code' reads object code and returns the number of bytes read.
 
+'al_cleanup' must be called (if present, so check perf_dlfilter_fns.al_cleanup != NULL)
+after resolve_address() to free any associated resources.
+
+Do not assume pointers obtained via perf_dlfilter_fns are valid (dereferenceable)
+after 'filter_event' and 'filter_event_early' return.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -197,9 +211,13 @@ struct perf_dlfilter_al {
 	/* Below members are only populated by resolve_ip() */
 	__u8 filtered; /* true if this sample event will be filtered out */
 	const char *comm;
+	void *priv; /* Private data. Do not change */
 };
 ----
 
+Do not assume data referenced by pointers in struct perf_dlfilter_al
+is valid (dereferenceable) after 'filter_event' and 'filter_event_early' return.
+
 perf_dlfilter_sample flags
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a44d16ec11ee..5d6f13abfee8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -381,7 +381,7 @@ ifndef NO_JVMTI
 PROGRAMS += $(OUTPUT)$(LIBJVMTI)
 endif
 
-DLFILTERS := dlfilter-test-api-v0.so dlfilter-show-cycles.so
+DLFILTERS := dlfilter-test-api-v0.so dlfilter-test-api-v2.so dlfilter-show-cycles.so
 DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
 
 # what 'all' will build and 'install' will install, in perfexecdir
diff --git a/tools/perf/dlfilters/dlfilter-test-api-v2.c b/tools/perf/dlfilters/dlfilter-test-api-v2.c
new file mode 100644
index 000000000000..38e593d92920
--- /dev/null
+++ b/tools/perf/dlfilters/dlfilter-test-api-v2.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test v2 API for perf --dlfilter shared object
+ * Copyright (c) 2023, Intel Corporation.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+
+/*
+ * Copy v2 API instead of including current API
+ */
+#include <linux/perf_event.h>
+#include <linux/types.h>
+
+/*
+ * The following macro can be used to determine if this header defines
+ * perf_dlfilter_sample machine_pid and vcpu.
+ */
+#define PERF_DLFILTER_HAS_MACHINE_PID
+
+/* Definitions for perf_dlfilter_sample flags */
+enum {
+	PERF_DLFILTER_FLAG_BRANCH	= 1ULL << 0,
+	PERF_DLFILTER_FLAG_CALL		= 1ULL << 1,
+	PERF_DLFILTER_FLAG_RETURN	= 1ULL << 2,
+	PERF_DLFILTER_FLAG_CONDITIONAL	= 1ULL << 3,
+	PERF_DLFILTER_FLAG_SYSCALLRET	= 1ULL << 4,
+	PERF_DLFILTER_FLAG_ASYNC	= 1ULL << 5,
+	PERF_DLFILTER_FLAG_INTERRUPT	= 1ULL << 6,
+	PERF_DLFILTER_FLAG_TX_ABORT	= 1ULL << 7,
+	PERF_DLFILTER_FLAG_TRACE_BEGIN	= 1ULL << 8,
+	PERF_DLFILTER_FLAG_TRACE_END	= 1ULL << 9,
+	PERF_DLFILTER_FLAG_IN_TX	= 1ULL << 10,
+	PERF_DLFILTER_FLAG_VMENTRY	= 1ULL << 11,
+	PERF_DLFILTER_FLAG_VMEXIT	= 1ULL << 12,
+};
+
+/*
+ * perf sample event information (as per perf script and <linux/perf_event.h>)
+ */
+struct perf_dlfilter_sample {
+	__u32 size; /* Size of this structure (for compatibility checking) */
+	__u16 ins_lat;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
+	__u16 p_stage_cyc;	/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
+	__u64 ip;
+	__s32 pid;
+	__s32 tid;
+	__u64 time;
+	__u64 addr;
+	__u64 id;
+	__u64 stream_id;
+	__u64 period;
+	__u64 weight;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
+	__u64 transaction;	/* Refer PERF_SAMPLE_TRANSACTION in <linux/perf_event.h> */
+	__u64 insn_cnt;	/* For instructions-per-cycle (IPC) */
+	__u64 cyc_cnt;		/* For instructions-per-cycle (IPC) */
+	__s32 cpu;
+	__u32 flags;		/* Refer PERF_DLFILTER_FLAG_* above */
+	__u64 data_src;		/* Refer PERF_SAMPLE_DATA_SRC in <linux/perf_event.h> */
+	__u64 phys_addr;	/* Refer PERF_SAMPLE_PHYS_ADDR in <linux/perf_event.h> */
+	__u64 data_page_size;	/* Refer PERF_SAMPLE_DATA_PAGE_SIZE in <linux/perf_event.h> */
+	__u64 code_page_size;	/* Refer PERF_SAMPLE_CODE_PAGE_SIZE in <linux/perf_event.h> */
+	__u64 cgroup;		/* Refer PERF_SAMPLE_CGROUP in <linux/perf_event.h> */
+	__u8  cpumode;		/* Refer CPUMODE_MASK etc in <linux/perf_event.h> */
+	__u8  addr_correlates_sym; /* True => resolve_addr() can be called */
+	__u16 misc;		/* Refer perf_event_header in <linux/perf_event.h> */
+	__u32 raw_size;		/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
+	const void *raw_data;	/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
+	__u64 brstack_nr;	/* Number of brstack entries */
+	const struct perf_branch_entry *brstack; /* Refer <linux/perf_event.h> */
+	__u64 raw_callchain_nr;	/* Number of raw_callchain entries */
+	const __u64 *raw_callchain; /* Refer <linux/perf_event.h> */
+	const char *event;
+	__s32 machine_pid;
+	__s32 vcpu;
+};
+
+/*
+ * Address location (as per perf script)
+ */
+struct perf_dlfilter_al {
+	__u32 size; /* Size of this structure (for compatibility checking) */
+	__u32 symoff;
+	const char *sym;
+	__u64 addr; /* Mapped address (from dso) */
+	__u64 sym_start;
+	__u64 sym_end;
+	const char *dso;
+	__u8  sym_binding; /* STB_LOCAL, STB_GLOBAL or STB_WEAK, refer <elf.h> */
+	__u8  is_64_bit; /* Only valid if dso is not NULL */
+	__u8  is_kernel_ip; /* True if in kernel space */
+	__u32 buildid_size;
+	__u8 *buildid;
+	/* Below members are only populated by resolve_ip() */
+	__u8 filtered; /* True if this sample event will be filtered out */
+	const char *comm;
+	void *priv; /* Private data (v2 API) */
+};
+
+struct perf_dlfilter_fns {
+	/* Return information about ip */
+	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
+	/* Return information about addr (if addr_correlates_sym) */
+	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
+	/* Return arguments from --dlarg option */
+	char **(*args)(void *ctx, int *dlargc);
+	/*
+	 * Return information about address (al->size must be set before
+	 * calling). Returns 0 on success, -1 otherwise. Call al_cleanup()
+	 * when 'al' data is no longer needed.
+	 */
+	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
+	/* Return instruction bytes and length */
+	const __u8 *(*insn)(void *ctx, __u32 *length);
+	/* Return source file name and line number */
+	const char *(*srcline)(void *ctx, __u32 *line_number);
+	/* Return perf_event_attr, refer <linux/perf_event.h> */
+	struct perf_event_attr *(*attr)(void *ctx);
+	/* Read object code, return numbers of bytes read */
+	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
+	/*
+	 * If present (i.e. must check al_cleanup != NULL), call after
+	 * resolve_address() to free any associated resources. (v2 API)
+	 */
+	void (*al_cleanup)(void *ctx, struct perf_dlfilter_al *al);
+	/* Reserved */
+	void *(*reserved[119])(void *);
+};
+
+struct perf_dlfilter_fns perf_dlfilter_fns;
+
+static int verbose;
+
+#define pr_debug(fmt, ...) do { \
+		if (verbose > 0) \
+			fprintf(stderr, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+static int test_fail(const char *msg)
+{
+	pr_debug("%s\n", msg);
+	return -1;
+}
+
+#define CHECK(x) do { \
+		if (!(x)) \
+			return test_fail("Check '" #x "' failed\n"); \
+	} while (0)
+
+struct filter_data {
+	__u64 ip;
+	__u64 addr;
+	int do_early;
+	int early_filter_cnt;
+	int filter_cnt;
+};
+
+static struct filter_data *filt_dat;
+
+int start(void **data, void *ctx)
+{
+	int dlargc;
+	char **dlargv;
+	struct filter_data *d;
+	static bool called;
+
+	verbose = 1;
+
+	CHECK(!filt_dat && !called);
+	called = true;
+
+	d = calloc(1, sizeof(*d));
+	if (!d)
+		test_fail("Failed to allocate memory");
+	filt_dat = d;
+	*data = d;
+
+	dlargv = perf_dlfilter_fns.args(ctx, &dlargc);
+
+	CHECK(dlargc == 6);
+	CHECK(!strcmp(dlargv[0], "first"));
+	verbose = strtol(dlargv[1], NULL, 0);
+	d->ip = strtoull(dlargv[2], NULL, 0);
+	d->addr = strtoull(dlargv[3], NULL, 0);
+	d->do_early = strtol(dlargv[4], NULL, 0);
+	CHECK(!strcmp(dlargv[5], "last"));
+
+	pr_debug("%s API\n", __func__);
+
+	return 0;
+}
+
+#define CHECK_SAMPLE(x) do { \
+		if (sample->x != expected.x) \
+			return test_fail("'" #x "' not expected value\n"); \
+	} while (0)
+
+static int check_sample(struct filter_data *d, const struct perf_dlfilter_sample *sample)
+{
+	struct perf_dlfilter_sample expected = {
+		.ip		= d->ip,
+		.pid		= 12345,
+		.tid		= 12346,
+		.time		= 1234567890,
+		.addr		= d->addr,
+		.id		= 99,
+		.stream_id	= 101,
+		.period		= 543212345,
+		.cpu		= 31,
+		.cpumode	= PERF_RECORD_MISC_USER,
+		.addr_correlates_sym = 1,
+		.misc		= PERF_RECORD_MISC_USER,
+	};
+
+	CHECK(sample->size >= sizeof(struct perf_dlfilter_sample));
+
+	CHECK_SAMPLE(ip);
+	CHECK_SAMPLE(pid);
+	CHECK_SAMPLE(tid);
+	CHECK_SAMPLE(time);
+	CHECK_SAMPLE(addr);
+	CHECK_SAMPLE(id);
+	CHECK_SAMPLE(stream_id);
+	CHECK_SAMPLE(period);
+	CHECK_SAMPLE(cpu);
+	CHECK_SAMPLE(cpumode);
+	CHECK_SAMPLE(addr_correlates_sym);
+	CHECK_SAMPLE(misc);
+
+	CHECK(!sample->raw_data);
+	CHECK_SAMPLE(brstack_nr);
+	CHECK(!sample->brstack);
+	CHECK_SAMPLE(raw_callchain_nr);
+	CHECK(!sample->raw_callchain);
+
+#define EVENT_NAME "branches:"
+	CHECK(!strncmp(sample->event, EVENT_NAME, strlen(EVENT_NAME)));
+
+	return 0;
+}
+
+static int check_al(void *ctx)
+{
+	const struct perf_dlfilter_al *al;
+
+	al = perf_dlfilter_fns.resolve_ip(ctx);
+	if (!al)
+		return test_fail("resolve_ip() failed");
+
+	CHECK(al->sym && !strcmp("foo", al->sym));
+	CHECK(!al->symoff);
+
+	return 0;
+}
+
+static int check_addr_al(void *ctx)
+{
+	const struct perf_dlfilter_al *addr_al;
+
+	addr_al = perf_dlfilter_fns.resolve_addr(ctx);
+	if (!addr_al)
+		return test_fail("resolve_addr() failed");
+
+	CHECK(addr_al->sym && !strcmp("bar", addr_al->sym));
+	CHECK(!addr_al->symoff);
+
+	return 0;
+}
+
+static int check_address_al(void *ctx, const struct perf_dlfilter_sample *sample)
+{
+	struct perf_dlfilter_al address_al;
+	const struct perf_dlfilter_al *al;
+
+	al = perf_dlfilter_fns.resolve_ip(ctx);
+	if (!al)
+		return test_fail("resolve_ip() failed");
+
+	address_al.size = sizeof(address_al);
+	if (perf_dlfilter_fns.resolve_address(ctx, sample->ip, &address_al))
+		return test_fail("resolve_address() failed");
+
+	CHECK(address_al.sym && al->sym);
+	CHECK(!strcmp(address_al.sym, al->sym));
+	CHECK(address_al.addr == al->addr);
+	CHECK(address_al.sym_start == al->sym_start);
+	CHECK(address_al.sym_end == al->sym_end);
+	CHECK(address_al.dso && al->dso);
+	CHECK(!strcmp(address_al.dso, al->dso));
+
+	/* al_cleanup() is v2 API so may not be present */
+	if (perf_dlfilter_fns.al_cleanup)
+		perf_dlfilter_fns.al_cleanup(ctx, &address_al);
+
+	return 0;
+}
+
+static int check_attr(void *ctx)
+{
+	struct perf_event_attr *attr = perf_dlfilter_fns.attr(ctx);
+
+	CHECK(attr);
+	CHECK(attr->type == PERF_TYPE_HARDWARE);
+	CHECK(attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
+
+	return 0;
+}
+
+static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void *ctx, bool early)
+{
+	struct filter_data *d = data;
+
+	CHECK(data && filt_dat == data);
+
+	if (early) {
+		CHECK(!d->early_filter_cnt);
+		d->early_filter_cnt += 1;
+	} else {
+		CHECK(!d->filter_cnt);
+		CHECK(d->early_filter_cnt);
+		CHECK(d->do_early != 2);
+		d->filter_cnt += 1;
+	}
+
+	if (check_sample(data, sample))
+		return -1;
+
+	if (check_attr(ctx))
+		return -1;
+
+	if (early && !d->do_early)
+		return 0;
+
+	if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, sample))
+		return -1;
+
+	if (early)
+		return d->do_early == 2;
+
+	return 1;
+}
+
+int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	pr_debug("%s API\n", __func__);
+
+	return do_checks(data, sample, ctx, true);
+}
+
+int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	pr_debug("%s API\n", __func__);
+
+	return do_checks(data, sample, ctx, false);
+}
+
+int stop(void *data, void *ctx)
+{
+	static bool called;
+
+	pr_debug("%s API\n", __func__);
+
+	CHECK(data && filt_dat == data && !called);
+	called = true;
+
+	free(data);
+	filt_dat = NULL;
+	return 0;
+}
+
+const char *filter_description(const char **long_description)
+{
+	*long_description = "Filter used by the 'dlfilter C API' perf test";
+	return "dlfilter to test v2 C API";
+}
diff --git a/tools/perf/include/perf/perf_dlfilter.h b/tools/perf/include/perf/perf_dlfilter.h
index a26e2f129f83..16fc4568ac53 100644
--- a/tools/perf/include/perf/perf_dlfilter.h
+++ b/tools/perf/include/perf/perf_dlfilter.h
@@ -91,6 +91,7 @@ struct perf_dlfilter_al {
 	/* Below members are only populated by resolve_ip() */
 	__u8 filtered; /* True if this sample event will be filtered out */
 	const char *comm;
+	void *priv; /* Private data. Do not change */
 };
 
 struct perf_dlfilter_fns {
@@ -102,7 +103,8 @@ struct perf_dlfilter_fns {
 	char **(*args)(void *ctx, int *dlargc);
 	/*
 	 * Return information about address (al->size must be set before
-	 * calling). Returns 0 on success, -1 otherwise.
+	 * calling). Returns 0 on success, -1 otherwise. Call al_cleanup()
+	 * when 'al' data is no longer needed.
 	 */
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	/* Return instruction bytes and length */
@@ -113,8 +115,13 @@ struct perf_dlfilter_fns {
 	struct perf_event_attr *(*attr)(void *ctx);
 	/* Read object code, return numbers of bytes read */
 	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
+	/*
+	 * If present (i.e. must check al_cleanup != NULL), call after
+	 * resolve_address() to free any associated resources.
+	 */
+	void (*al_cleanup)(void *ctx, struct perf_dlfilter_al *al);
 	/* Reserved */
-	void *(*reserved[120])(void *);
+	void *(*reserved[119])(void *);
 };
 
 /*
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 086fd2179e41..da3a9b50b1b1 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Test dlfilter C API. A perf.data file is synthesized and then processed
- * by perf script with a dlfilter named dlfilter-test-api-v0.so. Also a C file
+ * by perf script with dlfilters named dlfilter-test-api-v*.so. Also a C file
  * is compiled to provide a dso to match the synthesized perf.data file.
  */
 
@@ -37,6 +37,8 @@
 
 #define MAP_START 0x400000
 
+#define DLFILTER_TEST_NAME_MAX 128
+
 struct test_data {
 	struct perf_tool tool;
 	struct machine *machine;
@@ -45,6 +47,8 @@ struct test_data {
 	u64 bar;
 	u64 ip;
 	u64 addr;
+	char name[DLFILTER_TEST_NAME_MAX];
+	char desc[DLFILTER_TEST_NAME_MAX];
 	char perf[PATH_MAX];
 	char perf_data_file_name[PATH_MAX];
 	char c_file_name[PATH_MAX];
@@ -215,7 +219,7 @@ static int write_prog(char *file_name)
 	return err ? -1 : 0;
 }
 
-static int get_dlfilters_path(char *buf, size_t sz)
+static int get_dlfilters_path(const char *name, char *buf, size_t sz)
 {
 	char perf[PATH_MAX];
 	char path[PATH_MAX];
@@ -224,12 +228,12 @@ static int get_dlfilters_path(char *buf, size_t sz)
 
 	perf_exe(perf, sizeof(perf));
 	perf_path = dirname(perf);
-	snprintf(path, sizeof(path), "%s/dlfilters/dlfilter-test-api-v0.so", perf_path);
+	snprintf(path, sizeof(path), "%s/dlfilters/%s", perf_path, name);
 	if (access(path, R_OK)) {
 		exec_path = get_argv_exec_path();
 		if (!exec_path)
 			return -1;
-		snprintf(path, sizeof(path), "%s/dlfilters/dlfilter-test-api-v0.so", exec_path);
+		snprintf(path, sizeof(path), "%s/dlfilters/%s", exec_path, name);
 		free(exec_path);
 		if (access(path, R_OK))
 			return -1;
@@ -244,9 +248,9 @@ static int check_filter_desc(struct test_data *td)
 	char *desc = NULL;
 	int ret;
 
-	if (get_filter_desc(td->dlfilters, "dlfilter-test-api-v0.so", &desc, &long_desc) &&
+	if (get_filter_desc(td->dlfilters, td->name, &desc, &long_desc) &&
 	    long_desc && !strcmp(long_desc, "Filter used by the 'dlfilter C API' perf test") &&
-	    desc && !strcmp(desc, "dlfilter to test v0 C API"))
+	    desc && !strcmp(desc, td->desc))
 		ret = 0;
 	else
 		ret = -1;
@@ -284,7 +288,7 @@ static int get_ip_addr(struct test_data *td)
 static int do_run_perf_script(struct test_data *td, int do_early)
 {
 	return system_cmd("%s script -i %s "
-			  "--dlfilter %s/dlfilter-test-api-v0.so "
+			  "--dlfilter %s/%s "
 			  "--dlarg first "
 			  "--dlarg %d "
 			  "--dlarg %" PRIu64 " "
@@ -292,7 +296,7 @@ static int do_run_perf_script(struct test_data *td, int do_early)
 			  "--dlarg %d "
 			  "--dlarg last",
 			  td->perf, td->perf_data_file_name, td->dlfilters,
-			  verbose, td->ip, td->addr, do_early);
+			  td->name, verbose, td->ip, td->addr, do_early);
 }
 
 static int run_perf_script(struct test_data *td)
@@ -321,7 +325,7 @@ static int test__dlfilter_test(struct test_data *td)
 	u64 id = 99;
 	int err;
 
-	if (get_dlfilters_path(td->dlfilters, PATH_MAX))
+	if (get_dlfilters_path(td->name, td->dlfilters, PATH_MAX))
 		return test_result("dlfilters not found", TEST_SKIP);
 
 	if (check_filter_desc(td))
@@ -399,14 +403,18 @@ static void test_data__free(struct test_data *td)
 	}
 }
 
-static int test__dlfilter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static int test__dlfilter_ver(int ver)
 {
 	struct test_data td = {.fd = -1};
 	int pid = getpid();
 	int err;
 
+	pr_debug("\n-- Testing version %d API --\n", ver);
+
 	perf_exe(td.perf, sizeof(td.perf));
 
+	snprintf(td.name, sizeof(td.name), "dlfilter-test-api-v%d.so", ver);
+	snprintf(td.desc, sizeof(td.desc), "dlfilter to test v%d C API", ver);
 	snprintf(td.perf_data_file_name, PATH_MAX, "/tmp/dlfilter-test-%u-perf-data", pid);
 	snprintf(td.c_file_name, PATH_MAX, "/tmp/dlfilter-test-%u-prog.c", pid);
 	snprintf(td.prog_file_name, PATH_MAX, "/tmp/dlfilter-test-%u-prog", pid);
@@ -416,4 +424,14 @@ static int test__dlfilter(struct test_suite *test __maybe_unused, int subtest __
 	return err;
 }
 
+static int test__dlfilter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	int err = test__dlfilter_ver(0);
+
+	if (err)
+		return err;
+	/* No test for version 1 */
+	return test__dlfilter_ver(2);
+}
+
 DEFINE_SUITE("dlfilter C API", dlfilter);
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 798a53d7e6c9..e0f822ebb9b9 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -10,6 +10,8 @@
 #include <subcmd/exec-cmd.h>
 #include <linux/zalloc.h>
 #include <linux/build_bug.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
 
 #include "debug.h"
 #include "event.h"
@@ -63,6 +65,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 	d_al->addr = al->addr;
 	d_al->comm = NULL;
 	d_al->filtered = 0;
+	d_al->priv = NULL;
 }
 
 static struct addr_location *get_al(struct dlfilter *d)
@@ -151,6 +154,11 @@ static char **dlfilter__args(void *ctx, int *dlargc)
 	return d->dlargv;
 }
 
+static bool has_priv(struct perf_dlfilter_al *d_al_p)
+{
+	return d_al_p->size >= offsetof(struct perf_dlfilter_al, priv) + sizeof(d_al_p->priv);
+}
+
 static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlfilter_al *d_al_p)
 {
 	struct dlfilter *d = (struct dlfilter *)ctx;
@@ -177,9 +185,29 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 	memcpy(d_al_p, &d_al, min((size_t)sz, sizeof(d_al)));
 	d_al_p->size = sz;
 
+	if (has_priv(d_al_p))
+		d_al_p->priv = memdup(&al, sizeof(al));
+
 	return 0;
 }
 
+static void dlfilter__al_cleanup(void *ctx __maybe_unused, struct perf_dlfilter_al *d_al_p)
+{
+	struct addr_location *al;
+
+	/* Ensure backward compatibility */
+	if (!has_priv(d_al_p) || !d_al_p->priv)
+		return;
+
+	al = d_al_p->priv;
+
+	d_al_p->priv = NULL;
+
+	addr_location__exit(al);
+
+	free(al);
+}
+
 static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
 {
 	struct dlfilter *d = (struct dlfilter *)ctx;
@@ -297,6 +325,7 @@ static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_addr    = dlfilter__resolve_addr,
 	.args            = dlfilter__args,
 	.resolve_address = dlfilter__resolve_address,
+	.al_cleanup      = dlfilter__al_cleanup,
 	.insn            = dlfilter__insn,
 	.srcline         = dlfilter__srcline,
 	.attr            = dlfilter__attr,
-- 
2.34.1

