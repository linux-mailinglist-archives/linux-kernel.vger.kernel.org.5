Return-Path: <linux-kernel+bounces-162574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171708B5D94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8701C21D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34EB82D9C;
	Mon, 29 Apr 2024 15:24:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2A81745;
	Mon, 29 Apr 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404267; cv=none; b=cI73dGlYrC8Ji4TY8vyjmgDzv3v//B0qkqGrpIiYvt0TN8mE9fbRkkOeB1jE7PrMzYdmdW8uoWb8GSL23WkADUvbnCDwks9izY6F8glsCxDVcRBWCQRdPRLyMpZPdNbqZdtUWzUYv5nNRBvi3rEKSWk1JeKCd5H43OhcfjEYJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404267; c=relaxed/simple;
	bh=B4nm6nLK51aoQsLttd3Ekb+C8feSvY1WbvdomQFg9hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERZFARzwV9BMSFPOGdGyRKrxjn/SD+DYpbCxbC7Lw9TxXGDgiA7bsgiuqgApLmTUj+CypyHfpfnaRX6wvR48fqjE5q8/6RXd8UVnew7in7CN3OWCWOSIONmszyIGBukSDSFjYbbNwZzKctyfRSaP9TL2+HqPpAs0YkkUEkNMzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A00892F4;
	Mon, 29 Apr 2024 08:24:51 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D47C3F86F;
	Mon, 29 Apr 2024 08:24:21 -0700 (PDT)
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
Subject: [PATCH 06/17] perf: cs-etm: Create decoders based on the trace ID mappings
Date: Mon, 29 Apr 2024 16:21:51 +0100
Message-Id: <20240429152207.479221-7-james.clark@arm.com>
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

Now that each queue has a unique set of trace ID mappings, use this
list to create the decoders. This also works the same way for
unformatted where a single dummy entry is added into the trace ID list.

Previously each queue would have a decoder created for each traced CPU
on the system but this won't work anymore because CPUs can have
overlapping trace IDs.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 143 +++++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index be858aed26c4..73fc0ab2fb09 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -268,6 +268,10 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
 		int ret;
 		struct cs_etm_queue *etmq = etm->queues.queue_array[i].priv;
 
+		/* Ignore HW_IDs on unformatted queues */
+		if (etmq->formatted_set && !etmq->formatted)
+			continue;
+
 		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,
 						   cpu_metadata);
 		if (ret)
@@ -673,80 +677,58 @@ static void cs_etm__packet_dump(const char *pkt_string)
 }
 
 static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int t_idx,
-					  int m_idx, u32 etmidr)
+					  u64 *metadata, u32 etmidr)
 {
-	u64 **metadata = etm->metadata;
-
-	t_params[t_idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
-	t_params[t_idx].etmv3.reg_ctrl = metadata[m_idx][CS_ETM_ETMCR];
-	t_params[t_idx].etmv3.reg_trc_id = metadata[m_idx][CS_ETM_ETMTRACEIDR];
+	t_params->protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_params->etmv3.reg_ctrl = metadata[CS_ETM_ETMCR];
+	t_params->etmv3.reg_trc_id = metadata[CS_ETM_ETMTRACEIDR];
 }
 
 static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int t_idx,
-					  int m_idx)
+					  u64 *metadata)
 {
-	u64 **metadata = etm->metadata;
-
-	t_params[t_idx].protocol = CS_ETM_PROTO_ETMV4i;
-	t_params[t_idx].etmv4.reg_idr0 = metadata[m_idx][CS_ETMV4_TRCIDR0];
-	t_params[t_idx].etmv4.reg_idr1 = metadata[m_idx][CS_ETMV4_TRCIDR1];
-	t_params[t_idx].etmv4.reg_idr2 = metadata[m_idx][CS_ETMV4_TRCIDR2];
-	t_params[t_idx].etmv4.reg_idr8 = metadata[m_idx][CS_ETMV4_TRCIDR8];
-	t_params[t_idx].etmv4.reg_configr = metadata[m_idx][CS_ETMV4_TRCCONFIGR];
-	t_params[t_idx].etmv4.reg_traceidr = metadata[m_idx][CS_ETMV4_TRCTRACEIDR];
+	t_params->protocol = CS_ETM_PROTO_ETMV4i;
+	t_params->etmv4.reg_idr0 = metadata[CS_ETMV4_TRCIDR0];
+	t_params->etmv4.reg_idr1 = metadata[CS_ETMV4_TRCIDR1];
+	t_params->etmv4.reg_idr2 = metadata[CS_ETMV4_TRCIDR2];
+	t_params->etmv4.reg_idr8 = metadata[CS_ETMV4_TRCIDR8];
+	t_params->etmv4.reg_configr = metadata[CS_ETMV4_TRCCONFIGR];
+	t_params->etmv4.reg_traceidr = metadata[CS_ETMV4_TRCTRACEIDR];
 }
 
 static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int t_idx,
-					  int m_idx)
+					u64 *metadata)
 {
-	u64 **metadata = etm->metadata;
-
-	t_params[t_idx].protocol = CS_ETM_PROTO_ETE;
-	t_params[t_idx].ete.reg_idr0 = metadata[m_idx][CS_ETE_TRCIDR0];
-	t_params[t_idx].ete.reg_idr1 = metadata[m_idx][CS_ETE_TRCIDR1];
-	t_params[t_idx].ete.reg_idr2 = metadata[m_idx][CS_ETE_TRCIDR2];
-	t_params[t_idx].ete.reg_idr8 = metadata[m_idx][CS_ETE_TRCIDR8];
-	t_params[t_idx].ete.reg_configr = metadata[m_idx][CS_ETE_TRCCONFIGR];
-	t_params[t_idx].ete.reg_traceidr = metadata[m_idx][CS_ETE_TRCTRACEIDR];
-	t_params[t_idx].ete.reg_devarch = metadata[m_idx][CS_ETE_TRCDEVARCH];
+	t_params->protocol = CS_ETM_PROTO_ETE;
+	t_params->ete.reg_idr0 = metadata[CS_ETE_TRCIDR0];
+	t_params->ete.reg_idr1 = metadata[CS_ETE_TRCIDR1];
+	t_params->ete.reg_idr2 = metadata[CS_ETE_TRCIDR2];
+	t_params->ete.reg_idr8 = metadata[CS_ETE_TRCIDR8];
+	t_params->ete.reg_configr = metadata[CS_ETE_TRCCONFIGR];
+	t_params->ete.reg_traceidr = metadata[CS_ETE_TRCTRACEIDR];
+	t_params->ete.reg_devarch = metadata[CS_ETE_TRCDEVARCH];
 }
 
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
-				     struct cs_etm_auxtrace *etm,
-				     bool formatted,
-				     int sample_cpu,
-				     int decoders)
-{
-	int t_idx, m_idx;
-	u32 etmidr;
-	u64 architecture;
-
-	for (t_idx = 0; t_idx < decoders; t_idx++) {
-		if (formatted)
-			m_idx = t_idx;
-		else {
-			m_idx = get_cpu_data_idx(etm, sample_cpu);
-			if (m_idx == -1) {
-				pr_warning("CS_ETM: unknown CPU, falling back to first metadata\n");
-				m_idx = 0;
-			}
-		}
+				     struct cs_etm_queue *etmq)
+{
+	struct int_node *inode;
 
-		architecture = etm->metadata[m_idx][CS_ETM_MAGIC];
+	intlist__for_each_entry(inode, etmq->traceid_list) {
+		u64 *metadata = inode->priv;
+		u64 architecture = metadata[CS_ETM_MAGIC];
+		u32 etmidr;
 
 		switch (architecture) {
 		case __perf_cs_etmv3_magic:
-			etmidr = etm->metadata[m_idx][CS_ETM_ETMIDR];
-			cs_etm__set_trace_param_etmv3(t_params, etm, t_idx, m_idx, etmidr);
+			etmidr = metadata[CS_ETM_ETMIDR];
+			cs_etm__set_trace_param_etmv3(t_params++, metadata, etmidr);
 			break;
 		case __perf_cs_etmv4_magic:
-			cs_etm__set_trace_param_etmv4(t_params, etm, t_idx, m_idx);
+			cs_etm__set_trace_param_etmv4(t_params++, metadata);
 			break;
 		case __perf_cs_ete_magic:
-			cs_etm__set_trace_param_ete(t_params, etm, t_idx, m_idx);
+			cs_etm__set_trace_param_ete(t_params++, metadata);
 			break;
 		default:
 			return -EINVAL;
@@ -2918,6 +2900,42 @@ static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
 	return metadata;
 }
 
+/*
+ * traceid_list is used to create decoders and give them the trace ID
+ * mappings. In unformatted mode just insert one entry for the sample
+ * CPU so the decoder knows which settings to use.
+ */
+static int cs_etm__map_trace_ids_unformatted(struct cs_etm_auxtrace *etm)
+{
+	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
+		int ret;
+		struct cs_etm_queue *etmq;
+		u8 trace_chan_id;
+		u64 *cpu_data;
+
+		etmq = etm->queues.queue_array[i].priv;
+		if (!etmq->formatted_set || etmq->formatted)
+			continue;
+
+		/* Giving it a real ID doesn't do much but can help with debugging */
+		trace_chan_id = CORESIGHT_LEGACY_CPU_TRACE_ID(i);
+		cpu_data = get_cpu_data(etm, i);
+		if (cpu_data == NULL) {
+			pr_warning("CS_ETM: unknown CPU, falling back to first metadata\n");
+			cpu_data = etm->metadata[0];
+		}
+
+		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id, cpu_data);
+		if (ret)
+			return ret;
+
+		ret = cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * Puts a fragment of an auxtrace buffer into the auxtrace queues based
  * on the bounds of aux_event, if it matches with the buffer that's at
@@ -3220,21 +3238,26 @@ static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
 static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_decoder_params d_params;
+	struct cs_etm_trace_params  *t_params;
+	int decoders = intlist__nr_entries(etmq->traceid_list);
 
 	/*
 	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
 	 * needed.
 	 */
-	int decoders = etmq->formatted ? etmq->etm->num_cpu : 1;
+	if (etmq->formatted_set && !etmq->formatted)
+		assert(decoders == 1);
+
+	if (decoders == 0)
+		return 0;
 
 	/* Use metadata to fill in trace parameters for trace decoder */
-	struct cs_etm_trace_params  *t_params = zalloc(sizeof(*t_params) * decoders);
+	t_params = zalloc(sizeof(*t_params) * decoders);
 
 	if (!t_params)
 		goto out_free;
 
-	if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->formatted,
-				      etmq->queue_nr, decoders))
+	if (cs_etm__init_trace_params(t_params, etmq))
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
@@ -3497,6 +3520,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
+	err = cs_etm__map_trace_ids_unformatted(etm);
+	if (err)
+		goto err_free_queues;
+
 	err = cs_etm__create_decoders(etm);
 	if (err)
 		goto err_free_queues;
-- 
2.34.1


