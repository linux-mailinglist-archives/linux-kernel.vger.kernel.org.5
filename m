Return-Path: <linux-kernel+bounces-162573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B38B5D90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3831F21E17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D58082C8E;
	Mon, 29 Apr 2024 15:24:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6658287D;
	Mon, 29 Apr 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404259; cv=none; b=Qfm8cpytJ5AvO2tOD8z2okjQMhV7F3osKVH/OnuTQKHyojpSe6jQ7tIPQiSHWKFMXL3Mb6sd/pSVVQ9ZUGkU/2UHREz2ZN7wZwhm9BbCjuXXc7NDhuz6aMIwmUUTA2F0BX2vQ6Hiu31kcHoGTm0p4JQSC7dlZRh6oLGajlut0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404259; c=relaxed/simple;
	bh=m2ap/GWDsjhy7jg/hf1RUcQBudohgasIlZ/dQz75a60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMEfppD81z521dyZal3RVZXtbS4CQ95xUiizByFnmkkBJEHOkSmvixpo5O1YPoYyr1jRguH7Rn2XTLqe50KyPo2vRodSsw5HlRG6bTqIcVkODUIUf22f3H9hoi2hSVkVg1RePDq0qt5mjp2/XVhIBaD9t65WE3vnrHYhvnXPhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D5402F4;
	Mon, 29 Apr 2024 08:24:43 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F07793F793;
	Mon, 29 Apr 2024 08:24:10 -0700 (PDT)
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
Subject: [PATCH 05/17] perf: cs-etm: Move traceid_list to each queue
Date: Mon, 29 Apr 2024 16:21:50 +0100
Message-Id: <20240429152207.479221-6-james.clark@arm.com>
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

The global list won't work for per-sink trace ID allocations, so put a
list in each queue where the IDs will be unique to that queue.

To keep the same behavior as before, for version 0 of the HW_ID packets,
copy all the HW_ID mappings into all queues.

This change doesn't effect the decoders, only trace ID lookups on the
Perf side. The decoders are still created with global mappings which
will be fixed in a later commit.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 +--
 tools/perf/util/cs-etm.c                      | 195 ++++++++++--------
 tools/perf/util/cs-etm.h                      |   2 +-
 3 files changed, 126 insertions(+), 99 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e917985bbbe6..0c9c48cedbf1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -388,7 +388,8 @@ cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
+cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
+			      struct cs_etm_packet_queue *packet_queue,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
 {
@@ -398,7 +399,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
 	if (packet_queue->packet_count >= CS_ETM_PACKET_MAX_BUFFER - 1)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
+	if (cs_etm__get_cpu(etmq, trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
 	et = packet_queue->tail;
@@ -436,7 +437,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(packet_queue, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
 					    CS_ETM_RANGE);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
@@ -496,7 +497,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
+				     struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
 	/*
@@ -504,18 +506,19 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
 	 * reset time statistics.
 	 */
 	cs_etm_decoder__reset_timestamp(queue);
-	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					     CS_ETM_DISCONTINUITY);
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
+				 struct cs_etm_packet_queue *queue,
 				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					    CS_ETM_EXCEPTION);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
@@ -527,10 +530,11 @@ cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
+				     struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					     CS_ETM_EXCEPTION_RET);
 }
 
@@ -599,7 +603,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-		resp = cs_etm_decoder__buffer_discontinuity(packet_queue,
+		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
@@ -607,11 +611,11 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(packet_queue, elem,
+		resp = cs_etm_decoder__buffer_exception(etmq, packet_queue, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
-		resp = cs_etm_decoder__buffer_exception_ret(packet_queue,
+		resp = cs_etm_decoder__buffer_exception_ret(etmq, packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e40dfd09d3ed..be858aed26c4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -111,16 +111,18 @@ struct cs_etm_queue {
 	/* Conversion between traceID and index in traceid_queues array */
 	struct intlist *traceid_queues_list;
 	struct cs_etm_traceid_queue **traceid_queues;
+	/* Conversion between traceID and metadata pointers */
+	struct intlist *traceid_list;
 };
 
-/* RB tree for quick conversion between traceID and metadata pointers */
-static struct intlist *traceid_list;
-
 static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
 static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
+static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata);
+static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu);
+static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
@@ -146,12 +148,12 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 	return CS_ETM_PROTO_ETMV3;
 }
 
-static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
+static int cs_etm__get_magic(struct cs_etm_queue *etmq, u8 trace_chan_id, u64 *magic)
 {
 	struct int_node *inode;
 	u64 *metadata;
 
-	inode = intlist__find(traceid_list, trace_chan_id);
+	inode = intlist__find(etmq->traceid_list, trace_chan_id);
 	if (!inode)
 		return -EINVAL;
 
@@ -160,12 +162,12 @@ static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
 	return 0;
 }
 
-int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
+int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu)
 {
 	struct int_node *inode;
 	u64 *metadata;
 
-	inode = intlist__find(traceid_list, trace_chan_id);
+	inode = intlist__find(etmq->traceid_list, trace_chan_id);
 	if (!inode)
 		return -EINVAL;
 
@@ -217,30 +219,86 @@ enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq)
 	return etmq->etm->pid_fmt;
 }
 
-static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
+static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
+					u8 trace_chan_id, u64 *cpu_metadata)
 {
-	struct int_node *inode;
-
 	/* Get an RB node for this CPU */
-	inode = intlist__findnew(traceid_list, trace_chan_id);
+	struct int_node *inode = intlist__findnew(etmq->traceid_list, trace_chan_id);
 
 	/* Something went wrong, no need to continue */
 	if (!inode)
 		return -ENOMEM;
 
-	/*
-	 * The node for that CPU should not be taken.
-	 * Back out if that's the case.
-	 */
-	if (inode->priv)
-		return -EINVAL;
+	/* Disallow re-mapping a different traceID to metadata pair. */
+	if (inode->priv) {
+		u64 *curr_cpu_data = inode->priv;
+		u8 curr_chan_id;
+		int err;
+
+		if (curr_cpu_data[CS_ETM_CPU] != cpu_metadata[CS_ETM_CPU]) {
+			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+			return -EINVAL;
+		}
+
+		/* check that the mapped ID matches */
+		err = cs_etm__metadata_get_trace_id(&curr_chan_id, curr_cpu_data);
+		if (err)
+			return err;
 
-	/* All good, associate the traceID with the metadata pointer */
+		if (curr_chan_id != trace_chan_id) {
+			pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
+			return -EINVAL;
+		}
+
+		/* Skip re-adding the same mappings if everything matched */
+		return 0;
+	}
+
+	/* Not one we've seen before, associate the traceID with the metadata pointer */
 	inode->priv = cpu_metadata;
 
 	return 0;
 }
 
+static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id,
+				   u64 *cpu_metadata)
+{
+	/* Version 0 trace IDs are global so save them into every queue */
+	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
+		int ret;
+		struct cs_etm_queue *etmq = etm->queues.queue_array[i].priv;
+
+		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,
+						   cpu_metadata);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int cs_etm__process_trace_id_v0(struct cs_etm_auxtrace *etm, int cpu,
+				       u64 hw_id)
+{
+	int err;
+	u64 *cpu_data;
+	u8 trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
+
+	cpu_data = get_cpu_data(etm, cpu);
+	if (cpu_data == NULL)
+		return -EINVAL;
+
+	err = cs_etm__map_trace_id_v0(etm, trace_chan_id, cpu_data);
+	if (err)
+		return err;
+
+	/*
+	 * if we are picking up the association from the packet, need to plug
+	 * the correct trace ID into the metadata for setting up decoders later.
+	 */
+	return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
+}
+
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
 {
 	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
@@ -324,17 +382,13 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 {
 	struct cs_etm_auxtrace *etm;
 	struct perf_sample sample;
-	struct int_node *inode;
 	struct evsel *evsel;
-	u64 *cpu_data;
 	u64 hw_id;
 	int cpu, version, err;
-	u8 trace_chan_id, curr_chan_id;
 
 	/* extract and parse the HW ID */
 	hw_id = event->aux_output_hw_id.hw_id;
 	version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
-	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
 
 	/* check that we can handle this version */
 	if (version > CS_AUX_HW_ID_CURR_VERSION) {
@@ -362,43 +416,7 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 		return -EINVAL;
 	}
 
-	/* See if the ID is mapped to a CPU, and it matches the current CPU */
-	inode = intlist__find(traceid_list, trace_chan_id);
-	if (inode) {
-		cpu_data = inode->priv;
-		if ((int)cpu_data[CS_ETM_CPU] != cpu) {
-			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
-			return -EINVAL;
-		}
-
-		/* check that the mapped ID matches */
-		err = cs_etm__metadata_get_trace_id(&curr_chan_id, cpu_data);
-		if (err)
-			return err;
-		if (curr_chan_id != trace_chan_id) {
-			pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
-			return -EINVAL;
-		}
-
-		/* mapped and matched - return OK */
-		return 0;
-	}
-
-	cpu_data = get_cpu_data(etm, cpu);
-	if (cpu_data == NULL)
-		return err;
-
-	/* not one we've seen before - lets map it */
-	err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
-	if (err)
-		return err;
-
-	/*
-	 * if we are picking up the association from the packet, need to plug
-	 * the correct trace ID into the metadata for setting up decoders later.
-	 */
-	err = cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
-	return err;
+	return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
 }
 
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
@@ -851,6 +869,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 
 static void cs_etm__free_queue(void *priv)
 {
+	struct int_node *inode, *tmp;
 	struct cs_etm_queue *etmq = priv;
 
 	if (!etmq)
@@ -858,6 +877,14 @@ static void cs_etm__free_queue(void *priv)
 
 	cs_etm_decoder__free(etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
+
+	/* First remove all traceID/metadata nodes for the RB tree */
+	intlist__for_each_entry_safe(inode, tmp, etmq->traceid_list)
+		intlist__remove(etmq->traceid_list, inode);
+
+	/* Then the RB tree itself */
+	intlist__delete(etmq->traceid_list);
+
 	free(etmq);
 }
 
@@ -880,19 +907,12 @@ static void cs_etm__free_events(struct perf_session *session)
 static void cs_etm__free(struct perf_session *session)
 {
 	int i;
-	struct int_node *inode, *tmp;
 	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 	cs_etm__free_events(session);
 	session->auxtrace = NULL;
 
-	/* First remove all traceID/metadata nodes for the RB tree */
-	intlist__for_each_entry_safe(inode, tmp, traceid_list)
-		intlist__remove(traceid_list, inode);
-	/* Then the RB tree itself */
-	intlist__delete(traceid_list);
-
 	for (i = 0; i < aux->num_cpu; i++)
 		zfree(&aux->metadata[i]);
 
@@ -1050,9 +1070,24 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 
 	etmq->traceid_queues_list = intlist__new(NULL);
 	if (!etmq->traceid_queues_list)
-		free(etmq);
+		goto out_free;
+
+	/*
+	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
+	 * has to be made for each packet that gets decoded, optimizing access
+	 * in anything other than a sequential array is worth doing.
+	 */
+	etmq->traceid_list = intlist__new(NULL);
+	if (!etmq->traceid_list)
+		goto out_free;
 
 	return etmq;
+
+out_free:
+	intlist__delete(etmq->traceid_queues_list);
+	free(etmq);
+
+	return NULL;
 }
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
@@ -2202,7 +2237,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 					      PERF_IP_FLAG_TRACE_END;
 		break;
 	case CS_ETM_EXCEPTION:
-		ret = cs_etm__get_magic(packet->trace_chan_id, &magic);
+		ret = cs_etm__get_magic(etmq, packet->trace_chan_id, &magic);
 		if (ret)
 			return ret;
 
@@ -3119,7 +3154,8 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
 }
 
 /* map trace ids to correct metadata block, from information in metadata */
-static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
+static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm, int num_cpu,
+					  u64 **metadata)
 {
 	u64 cs_etm_magic;
 	u8 trace_chan_id;
@@ -3141,7 +3177,7 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
 			/* unknown magic number */
 			return -EINVAL;
 		}
-		err = cs_etm__map_trace_id(trace_chan_id, metadata[i]);
+		err = cs_etm__map_trace_id_v0(etm, trace_chan_id, metadata[i]);
 		if (err)
 			return err;
 	}
@@ -3272,23 +3308,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 
-	/*
-	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
-	 * has to be made for each packet that gets decoded, optimizing access
-	 * in anything other than a sequential array is worth doing.
-	 */
-	traceid_list = intlist__new(NULL);
-	if (!traceid_list)
-		return -ENOMEM;
-
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
 	metadata = zalloc(sizeof(*metadata) * num_cpu);
-	if (!metadata) {
-		err = -ENOMEM;
-		goto err_free_traceid_list;
-	}
+	if (!metadata)
+		return -ENOMEM;
 
 	/* Start parsing after the common part of the header */
 	i = CS_HEADER_VERSION_MAX;
@@ -3467,7 +3492,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
 	/* otherwise, this is a file with metadata values only, map from metadata */
 	else
-		err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+		err = cs_etm__map_trace_ids_metadata(etm, num_cpu, metadata);
 
 	if (err)
 		goto err_free_queues;
@@ -3489,7 +3514,5 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	for (int j = 0; j < num_cpu; j++)
 		zfree(&metadata[j]);
 	zfree(&metadata);
-err_free_traceid_list:
-	intlist__delete(traceid_list);
 	return err;
 }
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4696267a32f0..f4f69f7cc0f3 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -252,7 +252,7 @@ enum cs_etm_pid_fmt {
 
 #ifdef HAVE_CSTRACE_SUPPORT
 #include <opencsd/ocsd_if_types.h>
-int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
 enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
 int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
 			    u8 trace_chan_id, ocsd_ex_level el);
-- 
2.34.1


