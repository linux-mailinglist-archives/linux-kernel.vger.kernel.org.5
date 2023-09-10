Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CA799D7A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjIJJYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346158AbjIJJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 05:24:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D3184
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:24:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c34c9cc9b9so23531485ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694337864; x=1694942664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLQPk6FltGaHVPo2bO4DwKNnQF8PfaGK7XRuh8Wc2/U=;
        b=mM16IKYsIrW3y9iJ5IpqHc551/9WuFE63EECOLf6HanKfTnSAzafl/9yzRfJ/GBzoR
         knYRaiMTa8RMqbnlYNAO4eNg6QtlrHn2QB9ZAg5Pe9thAv28r1rPeB0SbNX8blMFXUIE
         cJSbPEjmAa8wUUy6kwC6yxNYlvCnJcXJ4Y0Mh1S5xZVcJ/4NpC4uXyTMaXX989aDUwlL
         SNaRVgfPJ9nJnxwytl/Ew9XVQ3wsv7RBFchhjGvfXT9Jspx2YZlChV/j8XLVUmwaxv86
         OSpMwBIUy1kIOnZpkepB/iK9kEbNLLKvcw3y/RPO2rAhmMSXizLhY+v9zDlkpu1c7hsH
         12cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694337864; x=1694942664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLQPk6FltGaHVPo2bO4DwKNnQF8PfaGK7XRuh8Wc2/U=;
        b=u5mIkxyx5dphKCYvHiQzndFYUndsRm7EMdbW3gNUVijoZfrf9iaqAMVjY/LCkMyei3
         o6Gx+jLF8MJwXmd1RMgpjQ0H/0qX8SZCsYk1XMoHpxoiESnAa4Sy97mpUXs0s8fVh1Bc
         3Qx4je01/rd4h9RpFJkXMqOR7yOQPT5pqgpyFo8nNXgcf+Pp/x0rVa39RbvhUocoYfNS
         Usj++6PuZqvivfXbEr8sdhJapdl/Yx8af4wXsON+ZHMWWSwbD/YGlCc/3bXcW0UdZsUm
         tghl/JVMDuckHhIf+T75QgLxQuRoCZHD79jSbmwzDpFR8HzxS5P+WBez4aIPBGl637gx
         MgKA==
X-Gm-Message-State: AOJu0YyOVh6er5gzM6mkRelsqwHG3zMx3vjzKpfbJWBmsD4CEzX8j18q
        seOTDOU0HXZ+KVyPae2fbKmBYw==
X-Google-Smtp-Source: AGHT+IGCCcoeUP2HGmYk3TwhuPFHuXcfUcwQPz61CbwiEjsQdsu/MqgjxzdXJsJiDQakWbIukYhqig==
X-Received: by 2002:a17:903:1208:b0:1c1:f27e:a55a with SMTP id l8-20020a170903120800b001c1f27ea55amr6642658plh.46.1694337864333;
        Sun, 10 Sep 2023 02:24:24 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.29])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001b05e96d859sm4350982pld.135.2023.09.10.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 02:24:23 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf cs-etm: Fix kernel timestamp handling
Date:   Sun, 10 Sep 2023 17:24:13 +0800
Message-Id: <20230910092413.53538-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timestamp can originate from two sources: the kernel timestamp,
which is recorded in the event PERF_RECORD_AUX, and the Arm CoreSight
hardware trace data.  On some Arm platforms, CoreSight trace data fails
to support timestamp tracing.  This can be due to either a missed
connection between the timer counter and Arm CoreSight or the absence
of support for the virtual timestamp.  If Arm CoreSight fails to support
hardware timestamp tracing, we need to fall back on using the kernel
timestamp.

The current code can support both timestamp sources when synthesizing
samples. However, the decoding flow only relies on the hardware
timestamp.  If the hardware timestamp is zero, it becomes impossible to
decode the trace data.  Consequently, in this case, the commands below
won't output any samples:

    perf record -e cs_etm// --per-thread --timestamp -- ls
    perf script

To fix this issue, this patch unifies the method of resolving time:

1) It renames cs_etm__resolve_sample_time() to the more general name
   cs_etm__resolve_time();
2) It changes the function argument type from 'cs_etm_traceid_queue' to
   'cs_etm_packet_queue';
3) In the end, both the decoding flow and the assignment of timestamps
   to samples call cs_etm__resolve_time() to obtain timestamp.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9729d006550d..fa88e731933d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -400,6 +400,17 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 	etmq->pending_timestamp_chan_id = trace_chan_id;
 }
 
+static u64 cs_etm__resolve_time(struct cs_etm_queue *etmq,
+				struct cs_etm_packet_queue *packet_queue)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+
+	if (!etm->timeless_decoding && etm->has_virtual_ts)
+		return packet_queue->cs_timestamp;
+	else
+		return etm->latest_kernel_timestamp;
+}
+
 static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
 				      u8 *trace_chan_id)
 {
@@ -419,8 +430,7 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
 	/* Acknowledge pending status */
 	etmq->pending_timestamp_chan_id = 0;
 
-	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
-	return packet_queue->cs_timestamp;
+	return cs_etm__resolve_time(etmq, packet_queue);
 }
 
 static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
@@ -1434,18 +1444,6 @@ u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
 		return cs_timestamp;
 }
 
-static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
-					       struct cs_etm_traceid_queue *tidq)
-{
-	struct cs_etm_auxtrace *etm = etmq->etm;
-	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
-
-	if (!etm->timeless_decoding && etm->has_virtual_ts)
-		return packet_queue->cs_timestamp;
-	else
-		return etm->latest_kernel_timestamp;
-}
-
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1454,13 +1452,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	union perf_event *event = tidq->event_buf;
 	struct perf_sample sample = {.ip = 0,};
+	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+	sample.time = cs_etm__resolve_time(etmq, packet_queue);
 
 	sample.ip = addr;
 	sample.pid = thread__pid(tidq->thread);
@@ -1505,6 +1504,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct perf_sample sample = {.ip = 0,};
 	union perf_event *event = tidq->event_buf;
+	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
 	struct dummy_branch_stack {
 		u64			nr;
 		u64			hw_idx;
@@ -1520,7 +1520,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+	sample.time = cs_etm__resolve_time(etmq, packet_queue);
 
 	sample.ip = ip;
 	sample.pid = thread__pid(tidq->prev_packet_thread);
-- 
2.34.1

