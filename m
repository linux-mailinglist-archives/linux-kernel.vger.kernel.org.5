Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6F783809
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjHVCid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjHVCi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F1D184
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E27764372
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673DCC433C7;
        Tue, 22 Aug 2023 02:38:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYHI1-001bZF-1S;
        Mon, 21 Aug 2023 22:38:41 -0400
Message-ID: <20230822023841.262172484@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Aug 2023 22:38:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <vnagarnaik@google.com>, <shuah@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 1/8] tracing: Fix cpu buffers unavailable due to record_disabled missed
References: <20230822023803.605698724@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

Trace ring buffer can no longer record anything after executing
following commands at the shell prompt:

  # cd /sys/kernel/tracing
  # cat tracing_cpumask
  fff
  # echo 0 > tracing_cpumask
  # echo 1 > snapshot
  # echo fff > tracing_cpumask
  # echo 1 > tracing_on
  # echo "hello world" > trace_marker
  -bash: echo: write error: Bad file descriptor

The root cause is that:
  1. After `echo 0 > tracing_cpumask`, 'record_disabled' of cpu buffers
     in 'tr->array_buffer.buffer' became 1 (see tracing_set_cpumask());
  2. After `echo 1 > snapshot`, 'tr->array_buffer.buffer' is swapped
     with 'tr->max_buffer.buffer', then the 'record_disabled' became 0
     (see update_max_tr());
  3. After `echo fff > tracing_cpumask`, the 'record_disabled' become -1;
Then array_buffer and max_buffer are both unavailable due to value of
'record_disabled' is not 0.

To fix it, enable or disable both array_buffer and max_buffer at the same
time in tracing_set_cpumask().

Link: https://lkml.kernel.org/r/20230805033816.3284594-2-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Cc: <vnagarnaik@google.com>
Cc: <shuah@kernel.org>
Fixes: 71babb2705e2 ("tracing: change CPU ring buffer state from tracing_cpumask")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..b0e8eb6ea8ac 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5277,11 +5277,17 @@ int tracing_set_cpumask(struct trace_array *tr,
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 	}
 	arch_spin_unlock(&tr->max_lock);
-- 
2.40.1
