Return-Path: <linux-kernel+bounces-131944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F26C898DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A31F2C8D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17301311AB;
	Thu,  4 Apr 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aXjO9lqD"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7812D770;
	Thu,  4 Apr 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254167; cv=none; b=V7NCC9WuQhSHgV00Fbu8+jkmwzBlTZURgE1Kyza01mXhDRX2EX9FYSE2yGeYJ0b8KTpPwQ/Gi0Q68KH/9mn8Rd7pJZoTviGp8PEo6fD0J+ZBMgnSbnRGcgcfNbdx9RDF7T7tPJfs9qrjYfR2pzSNCGLeOTxkTQadEw7VN4rSiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254167; c=relaxed/simple;
	bh=x4eAu7x6Idzvlda3hIQDcIF+4wKEpZYKt9rgpsoqlDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGanmn0Oja3tAD4vJdcFY7PEHaLOWMCPEVQXoAbqznOsQG8+OjH0z7wqH/0QMXVuLG/Rx00y9ZuU5MYl04pibwclTO4O3FaFvle4Y+/b8Zs/sBg2+Rod17pP2SWFEHymXrWKdegshTEBd9GUX1zUy6071bsdSGAFDAwfzVWbTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aXjO9lqD; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434GsQgH030426;
	Thu, 4 Apr 2024 11:08:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=bs9rzbl/ZJsjnoCm4UWhViM7erxeHXkxZ5PmGyvl0I8=; b=aXj
	O9lqDdd0wiA3CPbcfwE1zgxKibz9wZCAF45eIvd6vtwgycbwtv7lyv0QGFfE4DJr
	vw6m0jYaUkAsg2lrBlnV6ycIPOy+/MeOs6X1R+oTIUBgSn7P0rhDlMsNlod9S3Lb
	GU1rtGlIZ6RPInEFZV06FZGsyN1kMGQJiomt5g1zll68zJ72lRV2SDHCyrv4o9b9
	kHJfrhiIWvvGjtsZ4bArg1J5EFSvit2gZBDosRmXMLDknWv2oq0UCqvRfpQKcJH9
	JpHbTbLU/SrQpC252FmyTSnOBjog5E1lUIN4DE6+IyYAdHquRnMlQ8LCBDZj+mw8
	sKf3BAOpyK1EO2G153g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em6kka2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:08:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 11:08:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Apr 2024 11:08:51 -0700
Received: from POWEREDGE.marvell.com (POWEREDGE.marvell.com [10.28.8.3])
	by maili.marvell.com (Postfix) with ESMTP id 32F4D3F7076;
	Thu,  4 Apr 2024 11:08:45 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linux.dev>, <suzuki.poulose@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>, <lcherian@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH V2 2/2] perf: cs-etm: Store previous timestamp in packet queue
Date: Thu, 4 Apr 2024 23:37:31 +0530
Message-ID: <20240404180731.7006-3-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404180731.7006-1-tanmay@marvell.com>
References: <20240404180731.7006-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nkJzkpKjPUXW5Ol3SCC4ytqvRjEW0W77
X-Proofpoint-GUID: nkJzkpKjPUXW5Ol3SCC4ytqvRjEW0W77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_14,2024-04-04_01,2023-05-22_02

Since logic in cs_etm__sample is changed to synthesizing the previous
packet (tidq->prev_packet) instead of current packet (tidq->packet),
the first time this function is called, tidq->prev_packet is NULL
and we return without processing anything.

This is as expected but, in the first call, we would have a valid
timestamp (stored in tidq->packet_queue.cs_timestamp) which belongs
to tidq->packet. This would be lost due to no processing.

Losing this timestamp results in all the synthesized packets being
associated with the next timestamp and not their corresponding one.

To fix this, introduce a new variable (prev_cs_timestamp) to store the
queue's timestamp in cs_etm__sample(). When we start synthesizing the
prev_packet, use this cached value instead of the current timestamp
(cs_timestamp).

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 tools/perf/util/cs-etm.c | 17 +++++++++++++----
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 55db1932f785..d5072c16fcd8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1459,13 +1459,15 @@ u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
 }
 
 static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
-					       struct cs_etm_traceid_queue *tidq)
+					       struct cs_etm_traceid_queue *tidq,
+					       bool instruction_sample)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
 
 	if (!etm->timeless_decoding && etm->has_virtual_ts)
-		return packet_queue->cs_timestamp;
+		return instruction_sample ? packet_queue->prev_cs_timestamp :
+					    packet_queue->cs_timestamp;
 	else
 		return etm->latest_kernel_timestamp;
 }
@@ -1484,7 +1486,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+	sample.time = cs_etm__resolve_sample_time(etmq, tidq, true);
 
 	sample.ip = addr;
 	sample.pid = thread__pid(tidq->thread);
@@ -1560,7 +1562,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+	sample.time = cs_etm__resolve_sample_time(etmq, tidq, false);
 
 	sample.ip = ip;
 	sample.pid = thread__pid(tidq->prev_packet_thread);
@@ -1849,6 +1851,13 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		}
 	}
 
+	/*
+	 * Since we synthesize the prev_packet, store the current timestamp
+	 * here in prev_cs_timestamp so that when we *actually* synthesize
+	 * the prev_packet, we use this timestamp and not the future one.
+	 */
+	tidq->packet_queue.prev_cs_timestamp = tidq->packet_queue.cs_timestamp;
+
 	cs_etm__packet_swap(etm, tidq);
 
 	return 0;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4696267a32f0..333eeb2c06a0 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -205,6 +205,7 @@ struct cs_etm_packet_queue {
 	u32 instr_count;
 	u64 cs_timestamp; /* Timestamp from trace data, converted to ns if possible */
 	u64 next_cs_timestamp;
+	u64 prev_cs_timestamp;
 	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
 };
 
-- 
2.34.1


