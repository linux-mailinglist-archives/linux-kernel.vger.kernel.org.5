Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C378770547
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjHDPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjHDPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4944B49CB;
        Fri,  4 Aug 2023 08:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82D806209C;
        Fri,  4 Aug 2023 15:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B18C433CA;
        Fri,  4 Aug 2023 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691164351;
        bh=gTe7K81Fy/E2vjahMI33+dObPnl+nUbydfjT/SnxZuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQPFGtNzLnGg3aIvjUJA9gtmk2KqFUP4NGM9a9jSuQ9oWvRODlTupdKxJBokpou5K
         Nq4GyugvHYYwZmKbEMOSStikAyXJXWpcpjRQtkZuzPDV/DEl+d8eGW2Am9+jejQs0S
         uDXpEOoqWhpHpFfbpTuRMEfKeSYcWOuG7ZqX1B4ETlA+tci47Se9U1XlyFchU681s7
         XWxsJhhfdkivGCPPBKM9UKJWyuCVSbLdcoiFCXlYtByjhzWpO/Ku5pjToCsyoZ/ZCr
         U+q+42fwMZcXqhwnHC2Vrl0FNj1ITdqHVzUiHKLIfFId9dJKPrhpRMWjEjRc8N2veA
         JODSip/inIsXA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] rtla/timerlat_aa: Fix previous IRQ delay for IRQs that happens after thread sample
Date:   Fri,  4 Aug 2023 17:52:13 +0200
Message-Id: <a44a3f5c801dcc697bacf7325b65d4a5b0460537.1691162043.git.bristot@kernel.org>
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

timerlat auto-analysis takes note of all IRQs, before or after the
execution of the timerlat thread.

Because we cannot go backward in the trace (we will fix it when
moving to trace-cmd lib?), timerlat aa take note of the last IRQ
execution in the waiting for the IRQ state, and then print it
if it is executed after the expected timer IRQ starting time.

After the thread sample, the timerlat starts recording the next IRQs as
"previous" irq for the next occurrence.

However, if an IRQ happens after the thread measurement but before the
tracing stops, it is classified as a previous IRQ. That is not
wrong, as it can be "previous" for the subsequent activation. What is
wrong is considering it as a potential source for the last activation.

Ignore the IRQ interference that happens after the IRQ starting time for
now. A future improvement for timerlat can be either keeping a list of
previous IRQ execution or using the trace-cmd library. Still, it requires
further investigation - it is a new feature.

Fixes: 27e348b221f6 ("rtla/timerlat: Add auto-analysis core")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_aa.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index baf1efda0581..7093fd5333be 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -545,7 +545,7 @@ static int timerlat_aa_kworker_start_handler(struct trace_seq *s, struct tep_rec
 static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 				     int irq_thresh, int thread_thresh)
 {
-	unsigned long long exp_irq_ts;
+	long long exp_irq_ts;
 	int total;
 	int irq;
 
@@ -562,12 +562,15 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 
 	/*
 	 * Expected IRQ arrival time using the trace clock as the base.
+	 *
+	 * TODO: Add a list of previous IRQ, and then run the list backwards.
 	 */
 	exp_irq_ts = taa_data->timer_irq_start_time - taa_data->timer_irq_start_delay;
-
-	if (exp_irq_ts < taa_data->prev_irq_timstamp + taa_data->prev_irq_duration)
-		printf("  Previous IRQ interference:	\t\t up to  %9.2f us\n",
-			ns_to_usf(taa_data->prev_irq_duration));
+	if (exp_irq_ts < taa_data->prev_irq_timstamp + taa_data->prev_irq_duration) {
+		if (taa_data->prev_irq_timstamp < taa_data->timer_irq_start_time)
+			printf("  Previous IRQ interference:	\t\t up to  %9.2f us\n",
+				ns_to_usf(taa_data->prev_irq_duration));
+	}
 
 	/*
 	 * The delay that the IRQ suffered before starting.
-- 
2.38.1

