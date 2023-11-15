Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CC17EBF81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjKOJbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjKOJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:31:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801D9F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sJa3cuAFB3nxTpzcfZbSmQTYSFzKNLTZRZTj6CnRm9M=; b=BtktUW4LeB6M46Kf3juW4vIyzy
        BQficf+JvtQu8LnIN6VhhAs2aeVaZyZZmAcR5BQdpk5JRzfLM6Cu4nXzTuL88/YAcNSYALtxazSNs
        aDO2h38EzBkqdtB0iAnfPZ/DwXlMBtEJIQzDo/FDbyqzG8t3gQswDvdEF7+HuppPDWZwt8HRTHIZZ
        1/GOibtLiui7ZqE7uElbLM9M9uwJKlthmkQIrdy8PcU884M/BZ60aNuhmMumbuLpvEC7Wu2zcBzLW
        nmsXuU+ZHYNSZJm4tSqZ2MaeEytQTVBydMde8h5nRw5fU4g+VaFpuPJmfTSCrIllMvEIhW8PyMzKK
        JBSHTaEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3CEn-003tNL-07;
        Wed, 15 Nov 2023 09:31:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B18453002BE; Wed, 15 Nov 2023 10:31:08 +0100 (CET)
Date:   Wed, 15 Nov 2023 10:31:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: Re: [PATCH 01/13] perf: Simplify perf_event_alloc() error path
Message-ID: <20231115093108.GA3818@noisy.programming.kicks-ass.net>
References: <20231102150919.719936610@infradead.org>
 <20231102152017.847792675@infradead.org>
 <ZUTprUojg7eHoxQI@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUTprUojg7eHoxQI@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 01:38:05PM +0100, Jiri Olsa wrote:

> > -err_callchain_buffer:
> > -	if (!event->parent) {
> > -		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> > -			put_callchain_buffers();
> > -	}
> 
> hum, so this is now called all the time via __free_event, but it should
> be called only if we passed get_callchain_buffers call.. this could screw
> up nr_callchain_events number eventually no?

Yes, good catch, thanks!

Something like the below should handle that, no?

---
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -628,14 +628,15 @@ struct swevent_hlist {
 	struct rcu_head			rcu_head;
 };
 
-#define PERF_ATTACH_CONTEXT	0x01
-#define PERF_ATTACH_GROUP	0x02
-#define PERF_ATTACH_TASK	0x04
-#define PERF_ATTACH_TASK_DATA	0x08
-#define PERF_ATTACH_ITRACE	0x10
-#define PERF_ATTACH_SCHED_CB	0x20
-#define PERF_ATTACH_CHILD	0x40
-#define PERF_ATTACH_EXCLUSIVE	0x80
+#define PERF_ATTACH_CONTEXT	0x0001
+#define PERF_ATTACH_GROUP	0x0002
+#define PERF_ATTACH_TASK	0x0004
+#define PERF_ATTACH_TASK_DATA	0x0008
+#define PERF_ATTACH_ITRACE	0x0010
+#define PERF_ATTACH_SCHED_CB	0x0020
+#define PERF_ATTACH_CHILD	0x0040
+#define PERF_ATTACH_EXCLUSIVE	0x0080
+#define PERF_ATTACH_CALLCHAIN	0x0100
 
 struct bpf_prog;
 struct perf_cgroup;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5166,10 +5166,8 @@ static void perf_addr_filters_splice(str
 /* vs perf_event_alloc() error */
 static void __free_event(struct perf_event *event)
 {
-	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			put_callchain_buffers();
-	}
+	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
+		put_callchain_buffers();
 
 	kfree(event->addr_filter_ranges);
 
@@ -12065,6 +12063,7 @@ perf_event_alloc(struct perf_event_attr
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
 				goto err;
+			event->attach_state |= PERF_ATTACH_CALLCHAIN;
 		}
 	}
 
