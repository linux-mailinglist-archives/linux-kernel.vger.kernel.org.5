Return-Path: <linux-kernel+bounces-35095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D94D838C11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB18328BFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976C5C8F6;
	Tue, 23 Jan 2024 10:32:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43D5C5EC;
	Tue, 23 Jan 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005929; cv=none; b=V3xLMn8klI8vzUFp33jk4TUqibO8NbnTbqC9IgeHbTWOaGyqVOn64M7d9LZ0t+QrDncWXU8v535vnyXmSOUF9RafU6QYTYoh6/Zp0is2mp5Z5Gta0W6qVndPPZFsXm9rnuGsaXP4W0WHrhKIu7HremlxiGMQyoGPtFzigqjPUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005929; c=relaxed/simple;
	bh=tGC1Q+uluHqWv6fRHLJmIy0XADSRJjB5ViL9dFWiGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSqbazLJovXJI4TA368EIrfu5OvmYGHoBO6jINkiUllfIwLIUiGMOIyUktZqVQxCDsRvy0foKSo6tBxDkMJ6u5KW/+KqgyC4ROy2ZHZO5n1VnaxRCnyxCM6oqoOSLbad07R8aB2u5eRqAo3hY0PWTX/UbYBraAzZRKqeXwYT4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB605FEC;
	Tue, 23 Jan 2024 02:32:52 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A1113F5A1;
	Tue, 23 Jan 2024 02:32:05 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	will@kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH 1/1] tools: perf: Expose sample ID / stream ID to python scripts
Date: Tue, 23 Jan 2024 10:31:37 +0000
Message-ID: <20240123103137.1890779-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123103137.1890779-1-ben.gainey@arm.com>
References: <20240123103137.1890779-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf script exposes the evsel_name to python scripts as part of the data
passed to the sample or tracepoint handler function, and it passes the id and
stream_id to the throttled/unthrottled handler functions. This makes matching
throttle events and samples difficult.

To make this possible, this change exposes the sample id and stream_id values
to the script.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/perf/Documentation/perf-script-python.txt        | 4 ++--
 tools/perf/util/scripting-engines/trace-event-python.c | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 6a8581012e162..13e37e9385ee4 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -642,8 +642,8 @@ SUPPORTED FIELDS
 
 Currently supported fields:
 
-ev_name, comm, pid, tid, cpu, ip, time, period, phys_addr, addr,
-symbol, symoff, dso, time_enabled, time_running, values, callchain,
+ev_name, comm, id, stream_id, pid, tid, cpu, ip, time, period, phys_addr,
+addr, symbol, symoff, dso, time_enabled, time_running, values, callchain,
 brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
 weight, transaction, raw_buf, attr, cpumode.
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 860e1837ba969..d88966645b2f4 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -858,6 +858,10 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(evsel__name(evsel)));
 	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->core.attr, sizeof(evsel->core.attr)));
 
+	pydict_set_item_string_decref(dict_sample, "id",
+			PyLong_FromUnsignedLongLong(sample->id));
+	pydict_set_item_string_decref(dict_sample, "stream_id",
+			PyLong_FromUnsignedLongLong(sample->stream_id));
 	pydict_set_item_string_decref(dict_sample, "pid",
 			_PyLong_FromLong(sample->pid));
 	pydict_set_item_string_decref(dict_sample, "tid",
@@ -1306,7 +1310,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(25);
+	t = tuple_new(27);
 
 	tuple_set_d64(t, 0, es->db_id);
 	tuple_set_d64(t, 1, es->evsel->db_id);
@@ -1333,6 +1337,8 @@ static void python_export_sample_table(struct db_export *dbe,
 	tuple_set_d64(t, 22, es->sample->insn_cnt);
 	tuple_set_d64(t, 23, es->sample->cyc_cnt);
 	tuple_set_s32(t, 24, es->sample->flags);
+	tuple_set_d64(t, 25, es->sample->id);
+	tuple_set_d64(t, 26, es->sample->stream_id);
 
 	call_object(tables->sample_handler, t, "sample_table");
 
-- 
2.43.0


