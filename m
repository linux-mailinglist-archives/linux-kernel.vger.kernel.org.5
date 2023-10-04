Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91A7B82BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbjJDOwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242705AbjJDOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:52:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1CC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE50C433C7;
        Wed,  4 Oct 2023 14:52:31 +0000 (UTC)
Date:   Wed, 4 Oct 2023 10:53:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Lowell <nicholas.lowell@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Nicholas Lowell <nlowell@lexmark.com>
Subject: Re: [PATCH v2] trace: tracing_event_filter: fast path when no
 subsystem filters
Message-ID: <20231004105339.5f948a96@gandalf.local.home>
In-Reply-To: <CAFEqNJ2=rt5KaDaAah1t8gGbLViW7VZEDq+81drvuWUz4CKR2w@mail.gmail.com>
References: <20231002144149.1325-1-Nicholas.Lowell@gmail.com>
        <20231003223003.675bd888@gandalf.local.home>
        <CAFEqNJ2=rt5KaDaAah1t8gGbLViW7VZEDq+81drvuWUz4CKR2w@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 10:39:33 -0400
Nick Lowell <nicholas.lowell@gmail.com> wrote:

> > ------------[ cut here ]------------
> >  WARNING: CPU: 5 PID: 944 at kernel/trace/trace_events_filter.c:2423 apply_subsystem_event_filter+0x18c/0x5e0
> >  Modules linked in:
> >  CPU: 5 PID: 944 Comm: trace-cmd Not tainted 6.6.0-rc4-test-00009-gff7cd7446fe5 #102
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >  RIP: 0010:apply_subsystem_event_filter+0x18c/0x5e0
> >  Code: 44 24 08 00 00 00 00 48 8b 6d 00 4c 39 f5 75 bc 48 8b 44 24 18 4c 8b 60 18 4c 89 e5 45 84 ff 75 14 48 85 ed 0f 84 37 ff ff ff <0f> 0b eb 10 e8 4b be fd ff eb b0 4d 85 e4 0f 84 a3 02 00 00 48 8b
> >  RSP: 0018:ffff9b4941607db8 EFLAGS: 00010286
> >  RAX: ffff8b2780a77280 RBX: ffff8b2780a77400 RCX: 0000000000000000
> >  RDX: 0000000000000000 RSI: ffff8b2781c11c38 RDI: ffff8b2781c11c38
> >  RBP: ffff8b28df449030 R08: ffff8b2781c11c38 R09: 0000000000000000
> >  R10: ffff8b2781c11c38 R11: 0000000000000000 R12: ffff8b28df449030
> >  R13: ffffffffaaf64de0 R14: ffffffffaaf66bb8 R15: 0000000000000000
> >  FS:  00007fd221def3c0(0000) GS:ffff8b28f7d40000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 000056117c93e160 CR3: 000000010173a003 CR4: 0000000000170ee0
> >  Call Trace:
> >   <TASK>
> >   ? apply_subsystem_event_filter+0x18c/0x5e0
> >   ? __warn+0x81/0x130
> >   ? apply_subsystem_event_filter+0x18c/0x5e0
> >   ? report_bug+0x191/0x1c0
> >   ? handle_bug+0x3c/0x80
> >   ? exc_invalid_op+0x17/0x70
> >   ? asm_exc_invalid_op+0x1a/0x20
> >   ? apply_subsystem_event_filter+0x18c/0x5e0
> >   ? apply_subsystem_event_filter+0x5b/0x5e0
> >   ? __check_object_size+0x25b/0x2c0
> >   subsystem_filter_write+0x41/0x70
> >   vfs_write+0xf2/0x440
> >   ? kmem_cache_free+0x22/0x350
> >   ksys_write+0x6f/0xf0
> >   do_syscall_64+0x3f/0xc0
> >   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> >  RIP: 0033:0x7fd221ee7ae0
> >
> > -- Steve  
> 
> Is this just informative indicating that there are issues with how
> filters are being used or are you saying there is something else I
> need to do before this patch is approved?
> What version of trace-cmd is that using?

Not sure if it matters, but the above was with trace-cmd v3.2.

So, I guess we need to look a bit deeper at the change.

> @@ -2411,7 +2418,12 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
>  	}
>  
>  	if (!strcmp(strstrip(filter_string), "0")) {
> -		filter_free_subsystem_preds(dir, tr);
> +		/* If nothing was freed, we do not need to sync */
> +		if (!filter_free_subsystem_preds(dir, tr)) {
> +			if(!(WARN_ON_ONCE(system->filter)))
> +				goto out_unlock;

When do we want to skip the below?

The original version just did the "goto out_unlock" before the
"system->filter" check, and that would have caused a memory leak, or just
left the "system->filter" around when unneeded.

In other words, the patch is incorrect in general then.

> +		}
> +
>  		remove_filter_string(system->filter);
>  		filter = system->filter;
>  		system->filter = NULL;

I believe, what you really want here is simply:

	bool sync;

	[..]

	if (!strcmp(strstrip(filter_string), "0")) {
+		sync = filter_free_subsystem_preds(dir, tr);
		remove_filter_string(system->filter);
		filter = system->filter;
		system->filter = NULL;
-		/* Ensure all filters are no longer used */
-		tracepoint_synchronize_unregister();
+		if (sync) {
+			/* Ensure all filters are no longer used */
+			tracepoint_synchronize_unregister();
+		}
		filter_free_subsystem_filters(dir, tr);

Maybe even pass in "sync" to the filter_free_subsystem_filters() to make
sure there were nothing to be freed, and do the WARN_ON_ONCE() then.

		__free_filter(filter);
		goto out_unlock;
	}

-- Steve
