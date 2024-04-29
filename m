Return-Path: <linux-kernel+bounces-162572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339288B5DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E748B2D0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660384D27;
	Mon, 29 Apr 2024 15:24:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E620C81AD0;
	Mon, 29 Apr 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404248; cv=none; b=Ud+CzXvcBoEE7n1ZFS4qCOZdvIXPgzVJwEWVo0CSk38bo93amzL09OLqKfYcv7CmpTev4iHOwwve/IV9wJFVla7BpceIEBzSzopbIMtDtXTrtzKRJyEMOj9rLkbbomCFXEPJOSx7cXwTKkQoxrMh0v2jnrZApHmw2JIzK7aDeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404248; c=relaxed/simple;
	bh=m5MKYq+sbY/RyNjY39bpEhwKF6st/PRM8qPP5HXfLKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOdXLzi21w2Tuq8+ETp0mnpLGnf0hhT5BJo0kFYxaDu18e27iOPPI9dH0u0iakLBlT2apTCS7LI3walQnzOr1jTBp+4cWjmhQn3Ggzp2kNYmfRsCfkUgiLdwMCyf/6x7h66F/+n+N6Rrv6fqQeXOcH6rKZVdN/OtTVlQOAd3lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21F92F4;
	Mon, 29 Apr 2024 08:24:32 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 306063F793;
	Mon, 29 Apr 2024 08:24:03 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@linaro.org
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 04/17] perf: cs-etm: Allocate queues for all CPUs
Date: Mon, 29 Apr 2024 16:21:49 +0100
Message-Id: <20240429152207.479221-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429152207.479221-1-james.clark@arm.com>
References: <20240429152207.479221-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make cs_etm__setup_queue() setup a queue even if it's empty, and
pre-allocate queues based on the max CPU that was recorded. In per-CPU
mode aux queues are indexed based on CPU ID even if all CPUs aren't
recorded, sparse queue arrays aren't used.

This will allow HW_IDs to be saved even if no aux data was received in
that queue without having to call cs_etm__setup_queue() from two
different places.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 55 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f09004c4ba44..e40dfd09d3ed 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -104,6 +104,7 @@ struct cs_etm_queue {
 	unsigned int queue_nr;
 	u8 pending_timestamp_chan_id;
 	bool formatted;
+	bool formatted_set;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -1056,16 +1057,11 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
-			       unsigned int queue_nr, bool formatted)
+			       unsigned int queue_nr)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
-	if (etmq && formatted != etmq->formatted) {
-		pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
-		return -EINVAL;
-	}
-
-	if (list_empty(&queue->head) || etmq)
+	if (etmq)
 		return 0;
 
 	etmq = cs_etm__alloc_queue();
@@ -1078,7 +1074,6 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	etmq->queue_nr = queue_nr;
 	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
 	etmq->offset = 0;
-	etmq->formatted = formatted;
 
 	return 0;
 }
@@ -2791,17 +2786,6 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		if (err)
 			return err;
 
-		/*
-		 * Knowing if the trace is formatted or not requires a lookup of
-		 * the aux record so only works in non-piped mode where data is
-		 * queued in cs_etm__queue_aux_records(). Always assume
-		 * formatted in piped mode (true).
-		 */
-		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					  idx, true);
-		if (err)
-			return err;
-
 		if (dump_trace)
 			if (auxtrace_buffer__get_data(buffer, fd)) {
 				cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
@@ -2918,7 +2902,6 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	struct perf_record_auxtrace *auxtrace_event;
 	union perf_event auxtrace_fragment;
 	__u64 aux_offset, aux_size;
-	__u32 idx;
 	bool formatted;
 
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
@@ -2985,6 +2968,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 	if (aux_offset >= auxtrace_event->offset &&
 	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
+		struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
+
 		/*
 		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
 		 * based on the sizes of the aux event, and queue that fragment.
@@ -3001,10 +2986,14 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		if (err)
 			return err;
 
-		idx = auxtrace_event->idx;
 		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
-
-		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx, formatted);
+		if (etmq->formatted_set && formatted != etmq->formatted) {
+			pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
+			return -EINVAL;
+		}
+		etmq->formatted = formatted;
+		etmq->formatted_set = true;
+		return 0;
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
@@ -3256,6 +3245,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
 		 * Don't create decoders for empty queues, mainly because
 		 * etmq->formatted is unknown for empty queues.
 		 */
+		assert(empty == !etmq->formatted_set);
 		if (empty)
 			continue;
 
@@ -3275,10 +3265,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu;
+	int num_cpu, max_cpu = 0;
 	int err = 0;
 	int aux_hw_id_found;
-	int i, j;
+	int i;
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 
@@ -3309,7 +3299,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	 * required by the trace decoder to properly decode the trace due
 	 * to its highly compressed nature.
 	 */
-	for (j = 0; j < num_cpu; j++) {
+	for (int j = 0; j < num_cpu; j++) {
 		if (ptr[i] == __perf_cs_etmv3_magic) {
 			metadata[j] =
 				cs_etm__create_meta_blk(ptr, &i,
@@ -3333,6 +3323,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 			err = -ENOMEM;
 			goto err_free_metadata;
 		}
+
+		if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
+			max_cpu = metadata[j][CS_ETM_CPU];
 	}
 
 	/*
@@ -3362,10 +3355,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	 */
 	etm->pid_fmt = cs_etm__init_pid_fmt(metadata[0]);
 
-	err = auxtrace_queues__init(&etm->queues);
+	err = auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);
 	if (err)
 		goto err_free_etm;
 
+	for (unsigned int j = 0; j < etm->queues.nr_queues; ++j) {
+		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[j], j);
+		if (err)
+			goto err_free_queues;
+	}
+
 	if (session->itrace_synth_opts->set) {
 		etm->synth_opts = *session->itrace_synth_opts;
 	} else {
@@ -3487,7 +3486,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	zfree(&etm);
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */
-	for (j = 0; j < num_cpu; j++)
+	for (int j = 0; j < num_cpu; j++)
 		zfree(&metadata[j]);
 	zfree(&metadata);
 err_free_traceid_list:
-- 
2.34.1


