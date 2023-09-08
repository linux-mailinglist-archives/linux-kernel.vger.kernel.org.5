Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD2799084
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbjIHTsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbjIHTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:48:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421219BA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 12:48:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF89C433C9;
        Fri,  8 Sep 2023 19:44:15 +0000 (UTC)
Date:   Fri, 8 Sep 2023 15:44:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] tracing/synthetic: use union instead of casts
Message-ID: <20230908154417.5172e343@gandalf.local.home>
In-Reply-To: <20230810060538.1350348-2-svens@linux.ibm.com>
References: <20230810060538.1350348-1-svens@linux.ibm.com>
        <20230810060538.1350348-2-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 08:05:36 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -59,6 +59,17 @@ int trace_raw_output_prep(struct trace_iterator *iter,
>  extern __printf(2, 3)
>  void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
>  
> +/* Used to find the offset and length of dynamic fields in trace events */
> +struct trace_dynamic_info {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	u16	offset;
> +	u16	len;
> +#else
> +	u16	len;
> +	u16	offset;
> +#endif
> +};
> +

So this patch broke synthetic events. I found that it works with:

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 12f875e9e69a..4a98e23b0e77 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -65,10 +65,10 @@ struct trace_dynamic_info {
 	u16	offset;
 	u16	len;
 #else
-	u16	len;
 	u16	offset;
+	u16	len;
 #endif
-};
+} __packed;
 
 /*
  * The trace entry - the most basic unit of tracing. This is what

That is, I had to swap the order of len vs offset, and to also be safe, I
added "__packed".

I'm guessing that the BIG ENDIAN is broken too? So I'm going to swap that
as well.

It causes the following test to fail:

 ./ftracetest test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc

Which I didn't notice because I found that test to be broken, and needs this patch:

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
index 213d890ed188..174376ddbc6c 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
-# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README ping:program
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "' >> synthetic_events":README ping:program
 
 fail() { #msg
     echo $1

-- Steve
