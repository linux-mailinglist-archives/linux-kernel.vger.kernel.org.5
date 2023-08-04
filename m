Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63E2770546
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjHDPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjHDPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:52:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2351734;
        Fri,  4 Aug 2023 08:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705ED62083;
        Fri,  4 Aug 2023 15:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2A1C433CB;
        Fri,  4 Aug 2023 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691164348;
        bh=KWFM/wiu6viTEVt5MroQSNcNFMjFUslvuCwH+sOEIdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guS2WrnT5Gzk/90BbYDxqcVbWMgYW8V90YnB6WynP11+/qFch/c9QWZ1cuhnuT9um
         aZNEXD9uliUtEE7BofkP1RRNXHkncNZgeAGKCoHGmdZbK71nGEKHnkaOO4kaxG8csm
         83vMPQUb2xK2hfF1rtUjoHrADY6JeGkm0sAkSnGLdPOgBb86AHCRtPyZCCFqgzePbf
         hfUHPS1gP1iCjQVT4b/F1dFy5KM1YQaRpAbMXIIttrXnWmQXo2FZ3ply7eeDzAmvyG
         RUTMMnR4mk/X68gPXYl5Tw6DUgbojAxLyZvEv72jjymmJs4ZNYSVxiX6xfqpTSaXAQ
         8reUbJiOl5Sqg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/3] rtla/timerlat_aa: Fix negative IRQ delay
Date:   Fri,  4 Aug 2023 17:52:12 +0200
Message-Id: <a066fb667c7136d86dcddb3c7ccd72587db3e7c7.1691162043.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1691162043.git.bristot@kernel.org>
References: <cover.1691162043.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When estimating the IRQ timer delay, we are dealing with two different
clock sources: the external clock source that timerlat uses as a reference
and the clock used by the tracer. There are also two moments: the time
reading the clock and the timer in which the event is placed in the
buffer (the trace event timestamp).

If the processor is slow or there is some hardware noise, the difference
between the timestamp and the external clock, read can be longer than the
IRQ handler delay, resulting in a negative time.

If so, set IRQ to start delay as 0. In the end, it is less near-zero and relevant
then the noise.

Fixes: 27e348b221f6 ("rtla/timerlat: Add auto-analysis core")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_aa.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index dec5b4c4511e..baf1efda0581 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -338,7 +338,23 @@ static int timerlat_aa_irq_handler(struct trace_seq *s, struct tep_record *recor
 		taa_data->timer_irq_start_time = start;
 		taa_data->timer_irq_duration = duration;
 
-		taa_data->timer_irq_start_delay = taa_data->timer_irq_start_time - expected_start;
+		/*
+		 * We are dealing with two different clock sources: the
+		 * external clock source that timerlat uses as a reference
+		 * and the clock used by the tracer. There are also two
+		 * moments: the time reading the clock and the timer in
+		 * which the event is placed in the buffer (the trace
+		 * event timestamp). If the processor is slow or there
+		 * is some hardware noise, the difference between the
+		 * timestamp and the external clock read can be longer
+		 * than the IRQ handler delay, resulting in a negative
+		 * time. If so, set IRQ start delay as 0. In the end,
+		 * it is less relevant than the noise.
+		 */
+		if (expected_start < taa_data->timer_irq_start_time)
+			taa_data->timer_irq_start_delay = taa_data->timer_irq_start_time - expected_start;
+		else
+			taa_data->timer_irq_start_delay = 0;
 
 		/*
 		 * not exit from idle.
-- 
2.38.1

