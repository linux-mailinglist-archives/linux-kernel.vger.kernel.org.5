Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7437550FF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGPTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGPTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:30:32 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134810C8;
        Sun, 16 Jul 2023 12:30:23 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so7839383a12.1;
        Sun, 16 Jul 2023 12:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689535822; x=1692127822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYgTh4UluVTTQv27Q2ko0QEvRe4/XHgdd+kzU79fnVQ=;
        b=EJIQTv0K5PWMAg95jSR91rtam0EY5dRXgeOr6suNt3qran9oY+c/OJOA85mNIWEZpc
         Ft1qpb+f5rneKZQIGSnFng2TwsF05ml74x8nIin8UaCer+w3WRXqIkruiEfQAx3oA+mV
         o+xTo/7PGU6TmEuOk0r0MdVV5OVUOpM6JhLWDaPxeHfG6no7E6l9TygE9HFEQ2siWnUK
         N+6BFzlvV0NTjdOLLTK2k7UD+DH9s8BdjHtPX0rUGD8c8u+1G5FDuEE19vXmkN8HdsZB
         wjF+xqBDYLi3PUWSeCtCfhT/IDAaGh/W3FhhZsdP7auB99y55B7gZK77yPIGEXN1yhW9
         zxMQ==
X-Gm-Message-State: ABy/qLaCoeltpg2FVicjCAGpMU9porgbPM4Bj7jgRX8XpYNoko78w592
        IPfdaxF6dN9WFB5dPyA4uCPXi9udr+OBarsX
X-Google-Smtp-Source: APBJJlFbFBmIatukk4wR0sEnnn06fxBdrEH6eEw3rDI6U9lb/4+hi3X9YdulVLhtSzmkSly9eU7itw==
X-Received: by 2002:a05:6402:524e:b0:51d:cf7b:c9f0 with SMTP id t14-20020a056402524e00b0051dcf7bc9f0mr10707316edd.12.1689535821755;
        Sun, 16 Jul 2023 12:30:21 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7cc06000000b00521953ce6e0sm119846edt.93.2023.07.16.12.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 12:30:20 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     linux-rt-users@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH] tracing/timerlat: Add latency threshold
Date:   Sun, 16 Jul 2023 22:30:00 +0300
Message-ID: <20230716193000.231406-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timerlat tracer generates a huge amount of traces.
This affects the performance of the system and
the delays we are trying to measure with timerlat.
However, we are often interested in spikes of delay
rather than small values.

The patch effectively filters out irrelevant traces
before they are generated and produces more reliable
data.

This patch helped to debug a very big problem
and find this solution:
https://lore.kernel.org/lkml/20221208075604.811710-1-junxiao.chang@intel.com/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/trace/timerlat-tracer.rst |  1 +
 kernel/trace/trace_osnoise.c            | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index 53a56823e903..71b1c63ca403 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -68,6 +68,7 @@ directory. The timerlat configs are:
 
  - cpus: CPUs at which a timerlat thread will execute.
  - timerlat_period_us: the period of the timerlat thread.
+ - timerlat_threshold_ns: filter out timer latencies below the threshold
  - stop_tracing_us: stop the system tracing if a
    timer latency at the *irq* context higher than the configured
    value happens. Writing 0 disables this option.
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..43284a1e8bea 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -346,6 +346,7 @@ static struct osnoise_data {
 	u64	stop_tracing_total;	/* stop trace in the final operation (report/thread) */
 #ifdef CONFIG_TIMERLAT_TRACER
 	u64	timerlat_period;	/* timerlat period */
+	u64	timerlat_threshold_ns;
 	u64	print_stack;		/* print IRQ stack if total > */
 	int	timerlat_tracer;	/* timerlat tracer */
 #endif
@@ -358,6 +359,7 @@ static struct osnoise_data {
 #ifdef CONFIG_TIMERLAT_TRACER
 	.print_stack			= 0,
 	.timerlat_period		= DEFAULT_TIMERLAT_PERIOD,
+	.timerlat_threshold_ns		= 0,
 	.timerlat_tracer		= 0,
 #endif
 };
@@ -597,6 +599,10 @@ static void trace_timerlat_sample(struct timerlat_sample *sample)
 	struct osnoise_instance *inst;
 	struct trace_buffer *buffer;
 
+	if (osnoise_data.timerlat_threshold_ns &&
+	    sample->timer_latency < osnoise_data.timerlat_threshold_ns)
+		return;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		buffer = inst->tr->array_buffer.buffer;
@@ -2663,6 +2669,11 @@ static struct trace_min_max_param timerlat_period = {
 	.min	= &timerlat_min_period,
 };
 
+static struct trace_min_max_param timerlat_threshold = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.timerlat_threshold_ns,
+};
+
 static const struct file_operations timerlat_fd_fops = {
 	.open		= timerlat_fd_open,
 	.read		= timerlat_fd_read,
@@ -2759,6 +2770,12 @@ static int init_timerlat_tracefs(struct dentry *top_dir)
 	if (!tmp)
 		return -ENOMEM;
 
+	tmp = tracefs_create_file("timerlat_threshold_ns", TRACE_MODE_WRITE,
+				  top_dir, &timerlat_threshold,
+				  &trace_min_max_fops);
+	if (!tmp)
+		return -ENOMEM;
+
 	retval = osnoise_create_cpu_timerlat_fd(top_dir);
 	if (retval)
 		return retval;
-- 
2.41.0

