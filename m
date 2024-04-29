Return-Path: <linux-kernel+bounces-162571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845EE8B5DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63138B2A78B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E384D06;
	Mon, 29 Apr 2024 15:24:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3E82D86;
	Mon, 29 Apr 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404241; cv=none; b=JEO/ffWHc10xaepSwoi+AIEfuQ5YcfSWtr3BdkHPdL7Q0SQuYFp4kysvL3UfsRimIgyJ7vaKvZUsYgdiF65Vv8bmTKtL1lbv59qXhciiSfEhFCpKigd5y/pzyLxTSNeBbVTjs3AKNrmrawS+V6OnARk0WVnbJBCut8XI181Jiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404241; c=relaxed/simple;
	bh=S+3M+P7EydDYx1VSdqESFH1tohdKDaVHTpOBTv5Xols=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ed+DllOqjHNdENPWEhXz7qdoaqDwwm5fEUGWtm4n5/2RgR2Kfn8F0saymUD/WvcDhowJLUiZu9uMw2qsujpsQ74dvl6XIGLhifqqpHanRkoyD2Dl6e4ApGdElcIYs2eEn3hXauezTXic6KT7ihUjWH+Wvk/0z8TZw+wbFUYMmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6695E339;
	Mon, 29 Apr 2024 08:24:25 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 744883F793;
	Mon, 29 Apr 2024 08:23:55 -0700 (PDT)
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
Subject: [PATCH 03/17] perf: cs-etm: Create decoders after both AUX and HW_ID search passes
Date: Mon, 29 Apr 2024 16:21:48 +0100
Message-Id: <20240429152207.479221-4-james.clark@arm.com>
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

Both of these passes gather information about how to create the
decoders. AUX records determine formatted/unformatted, and the HW_IDs
determine the traceID/metadata mappings. Therefore it makes sense to
cache the information and wait until both passes are over until creating
the decoders, rather than creating them at the first HW_ID found. This
will allow a simplification of the creation process where
cs_etm_queue->traceid_list will exclusively used to create the decoders,
rather than the current two methods depending on whether the trace is
formatted or not.

Previously the sample CPU from the AUX record was used to initialize
the decoder CPU, but actually sample CPU == AUX queue index in per-CPU
mode, so saving the sample CPU isn't required. Similarly
formatted/unformatted was used upfront to create the decoders, but now
it's cached until later.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 167 ++++++++++++++++++++++++---------------
 1 file changed, 102 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 32818bd7cd17..f09004c4ba44 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -103,6 +103,7 @@ struct cs_etm_queue {
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
 	u8 pending_timestamp_chan_id;
+	bool formatted;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -738,8 +739,7 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
 
 static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 				       struct cs_etm_queue *etmq,
-				       enum cs_etm_decoder_operation mode,
-				       bool formatted)
+				       enum cs_etm_decoder_operation mode)
 {
 	int ret = -EINVAL;
 
@@ -749,7 +749,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 	d_params->packet_printer = cs_etm__packet_dump;
 	d_params->operation = mode;
 	d_params->data = etmq;
-	d_params->formatted = formatted;
+	d_params->formatted = etmq->formatted;
 	d_params->fsyncs = false;
 	d_params->hsyncs = false;
 	d_params->frame_aligned = true;
@@ -1041,81 +1041,34 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	return ret;
 }
 
-static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
-						bool formatted, int sample_cpu)
+static struct cs_etm_queue *cs_etm__alloc_queue(void)
 {
-	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params  *t_params = NULL;
-	struct cs_etm_queue *etmq;
-	/*
-	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
-	 * needed.
-	 */
-	int decoders = formatted ? etm->num_cpu : 1;
-
-	etmq = zalloc(sizeof(*etmq));
+	struct cs_etm_queue *etmq = zalloc(sizeof(*etmq));
 	if (!etmq)
 		return NULL;
 
 	etmq->traceid_queues_list = intlist__new(NULL);
 	if (!etmq->traceid_queues_list)
-		goto out_free;
-
-	/* Use metadata to fill in trace parameters for trace decoder */
-	t_params = zalloc(sizeof(*t_params) * decoders);
+		free(etmq);
 
-	if (!t_params)
-		goto out_free;
-
-	if (cs_etm__init_trace_params(t_params, etm, formatted, sample_cpu, decoders))
-		goto out_free;
-
-	/* Set decoder parameters to decode trace packets */
-	if (cs_etm__init_decoder_params(&d_params, etmq,
-					dump_trace ? CS_ETM_OPERATION_PRINT :
-						     CS_ETM_OPERATION_DECODE,
-					formatted))
-		goto out_free;
-
-	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
-					    t_params);
-
-	if (!etmq->decoder)
-		goto out_free;
-
-	/*
-	 * Register a function to handle all memory accesses required by
-	 * the trace decoder library.
-	 */
-	if (cs_etm_decoder__add_mem_access_cb(etmq->decoder,
-					      0x0L, ((u64) -1L),
-					      cs_etm__mem_access))
-		goto out_free_decoder;
-
-	zfree(&t_params);
 	return etmq;
-
-out_free_decoder:
-	cs_etm_decoder__free(etmq->decoder);
-out_free:
-	intlist__delete(etmq->traceid_queues_list);
-	free(etmq);
-
-	return NULL;
 }
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
-			       unsigned int queue_nr,
-			       bool formatted,
-			       int sample_cpu)
+			       unsigned int queue_nr, bool formatted)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
+	if (etmq && formatted != etmq->formatted) {
+		pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
+		return -EINVAL;
+	}
+
 	if (list_empty(&queue->head) || etmq)
 		return 0;
 
-	etmq = cs_etm__alloc_queue(etm, formatted, sample_cpu);
+	etmq = cs_etm__alloc_queue();
 
 	if (!etmq)
 		return -ENOMEM;
@@ -1123,7 +1076,9 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
+	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
 	etmq->offset = 0;
+	etmq->formatted = formatted;
 
 	return 0;
 }
@@ -2843,7 +2798,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		 * formatted in piped mode (true).
 		 */
 		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					  idx, true, -1);
+					  idx, true);
 		if (err)
 			return err;
 
@@ -3048,8 +3003,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 		idx = auxtrace_event->idx;
 		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
-		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					   idx, formatted, sample->cpu);
+
+		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx, formatted);
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
@@ -3233,6 +3188,84 @@ static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
 	return 0;
 }
 
+/*
+ * Use the data gathered by the peeks for HW_ID (trace ID mappings) and AUX
+ * (formatted or not) packets to create the decoders.
+ */
+static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
+{
+	struct cs_etm_decoder_params d_params;
+
+	/*
+	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
+	 * needed.
+	 */
+	int decoders = etmq->formatted ? etmq->etm->num_cpu : 1;
+
+	/* Use metadata to fill in trace parameters for trace decoder */
+	struct cs_etm_trace_params  *t_params = zalloc(sizeof(*t_params) * decoders);
+
+	if (!t_params)
+		goto out_free;
+
+	if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->formatted,
+				      etmq->queue_nr, decoders))
+		goto out_free;
+
+	/* Set decoder parameters to decode trace packets */
+	if (cs_etm__init_decoder_params(&d_params, etmq,
+					dump_trace ? CS_ETM_OPERATION_PRINT :
+						     CS_ETM_OPERATION_DECODE))
+		goto out_free;
+
+	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
+					    t_params);
+
+	if (!etmq->decoder)
+		goto out_free;
+
+	/*
+	 * Register a function to handle all memory accesses required by
+	 * the trace decoder library.
+	 */
+	if (cs_etm_decoder__add_mem_access_cb(etmq->decoder,
+					      0x0L, ((u64) -1L),
+					      cs_etm__mem_access))
+		goto out_free_decoder;
+
+	zfree(&t_params);
+	return 0;
+
+out_free_decoder:
+	cs_etm_decoder__free(etmq->decoder);
+out_free:
+	zfree(&t_params);
+	return -EINVAL;
+}
+
+static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
+{
+	struct auxtrace_queues *queues = &etm->queues;
+
+	for (unsigned int i = 0; i < queues->nr_queues; i++) {
+		bool empty = list_empty(&queues->queue_array[i].head);
+		struct cs_etm_queue *etmq = queues->queue_array[i].priv;
+		int ret;
+
+		/*
+		 * Don't create decoders for empty queues, mainly because
+		 * etmq->formatted is unknown for empty queues.
+		 */
+		if (empty)
+			continue;
+
+		ret = cs_etm__create_queue_decoders(etmq);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int cs_etm__process_auxtrace_info_full(union perf_event *event,
 				       struct perf_session *session)
 {
@@ -3396,6 +3429,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
+	err = cs_etm__queue_aux_records(session);
+	if (err)
+		goto err_free_queues;
+
 	/*
 	 * Map Trace ID values to CPU metadata.
 	 *
@@ -3418,7 +3455,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	 * flags if present.
 	 */
 
-	/* first scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
+	/* Scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
 	aux_hw_id_found = 0;
 	err = perf_session__peek_events(session, session->header.data_offset,
 					session->header.data_size,
@@ -3436,7 +3473,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
-	err = cs_etm__queue_aux_records(session);
+	err = cs_etm__create_decoders(etm);
 	if (err)
 		goto err_free_queues;
 
-- 
2.34.1


