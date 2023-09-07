Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE205797643
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjIGQFc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjIGQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:04:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB936EA1;
        Thu,  7 Sep 2023 08:53:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42ABC32783;
        Thu,  7 Sep 2023 12:13:53 +0000 (UTC)
Date:   Thu, 7 Sep 2023 08:14:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tze-nan Wu (=?UTF-8?B?5ZCz5r6k5Y2X?=)" <Tze-nan.Wu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "Cheng-Jui Wang (=?UTF-8?B?546L5q2j552/?=)" 
        <Cheng-Jui.Wang@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "Bobule Chang (=?UTF-8?B?5by1?= =?UTF-8?B?5byY576p?=)" 
        <bobule.chang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ring-buffer: Do not read at &event->array[0] if it
 across the page
Message-ID: <20230907081408.6156b6f0@gandalf.local.home>
In-Reply-To: <0944a5f3e10c0eba8b32e51fb941e0dd98ec086d.camel@mediatek.com>
References: <20230905141245.26470-1-Tze-nan.Wu@mediatek.com>
        <20230905123953.3c0b3d7a@gandalf.local.home>
        <3a89d49ae0da6378de83bc68690cf6664d97cb24.camel@mediatek.com>
        <0944a5f3e10c0eba8b32e51fb941e0dd98ec086d.camel@mediatek.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 10:10:57 +0000
Tze-nan Wu (吳澤南) <Tze-nan.Wu@mediatek.com> wrote:

> > Same as my thought,
> > since every time the reader try to access the address in next page,
> > the below condition hold in rb_iter_head_event function:
> > 
> >         if (iter->page_stamp != iter_head_page->page->time_stamp ||
> >                 commit > rb_page_commit(iter_head_page))
> >                         goto reset;
> > 
> > I observe the result by the debug patch provided below:
> > 
> >         @@ -2378,6 +2378,19 @@ rb_iter_head_event(struct
> > ring_buffer_iter *iter)
> >                 commit = rb_page_commit(iter_head_page);
> >                 smp_rmb();
> >         +       if ((iter->head >= 0xFECUL) && commit == 0xFF0UL) {
> >         +               pr_info("rbdbg: cpu = %d, event = 0x%lx,
> > iter-  
> > > head = 0x%lx,\  
> > 
> >         +                       commit = 0xFF0, type = 0x%x, ts =
> > 0x%x,
> > array addr = 0x%lx\n",\
> >         +                       iter->cpu_buffer->cpu, (unsigned
> > long)event, iter->head,\
> >         +                       event->type_len, event->time_delta,
> > (unsigned long)(&(event->array[0])));
> >         +               mdelay(500);
> >         +               pr_info("rbdbg2: cpu = %d, event = 0x%lx,
> > iter-  
> > > head = 0x%lx,\  
> > 
> >         +                       commit = 0xFF0, type = 0x%x, ts =
> > 0x%x,
> > array addr = 0x%lx\n",\
> >         +                       iter->cpu_buffer->cpu, (unsigned
> > long)event, iter->head,\
> >         +                       event->type_len, event->time_delta,
> > (unsigned long)(&(event->array[0])));
> >         +               if (iter->page_stamp != iter_head_page->page-  
> > > time_stamp || commit > rb_page_commit(iter_head_page))  
> > 
> >         +                       pr_info("rbdbg: writer corrupt
> > reader\n");
> >         +       }
> >                 event = __rb_page_index(iter_head_page, iter->head);
> >                 length = rb_event_length(event);
> > 
> > Note that the mdelay(500) in the debug patch can reproduce the issue
> > easier with same test in my environmnet,
> > I am now able to reproduce the issue within 15 minutes if the debug
> > patch on.
> >   
> 
> The debug patch may give something similar to the below log just before
> the invalid access happened, for me it looks like the padding event had
> just corrupted by the writer before the reader invoke rb_event_length
> function on it.
> 
> [  338.156772] cat: [name:ring_buffer&]rbdbg: cpu = 0, event =
> 0x????????????dffc, iter->head = 0xfec, commit = 0xFF0, type = 0x1d, ts
> = 0x0, array addr = 0x????????????e000
> [  338.656796] cat: [name:ring_buffer&]rbdbg2: cpu = 0, event =
> 0x????????????dffc, iter->head = 0xfec, commit = 0xFF0, type = 0x0, ts
> = 0x0, array addr = 0x????????????e000
> [  338.656803] cat: [name:ring_buffer&]rbdbg: writer corrupt reader
> [  338.656810] cat:
> [name:report&]=========================================================
> =========
> [  338.656819] cat: [name:report&]BUG: KASAN: invalid-access in
> rb_event_length
> 
> 
> > > > Since the content data start at address 0x71FFFF8111A17FFC are  
> > > 
> > > 0xFFFFFFC0.  
> > > > event->type will be interpret as 0x0, than the reader will try to  
> > > 
> > > get the  
> > > > length by accessing event->array[0], which is an invalid address:
> > > >     &event->array[0] = 0x71FFFF8111A18000
> > > > 
> > > > Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
> > > > ---
> > > > Following patch may not become a solution, it merely checks if
> > > > the  
> > > 
> > > address  
> > > > to be accessed is valid or not within the rb_event_length before  
> > > 
> > > access.  
> > > > And not sure if there is any side-effect it can lead to.
> > > > 
> > > > I am curious about what a better solution for this issue would
> > > > look  
> > > 
> > > like.  
> > > > Should we address the problem from the writer or the reader?
> > > > 
> > > > Also I wonder if the cause of the issue is exactly as I
> > > > suspected.
> > > > Any Suggestion will be appreciated.  
> > > 
> > > I guess this depends on if you have the fixes or not?
> > >   
> > 
> > yes, I could try to pick the patches that only included in mainline
> > but
> > not in kernel-6.1.52 for ring_buffer.c file,
> > and do the same test to see if the issue is still reproducible.
> >   
> > > > 
> > > > Test below can reproduce the issue in 2 hours on kernel-6.1.24:
> > > >     $cd /sys/kernel/tracing/
> > > >     # make the reader and writer race more through resize the  
> > > 
> > > buffer to 8kb  
> > > >     $echo 8 > buffer_size_kn
> > > >     # enable all events
> > > >     $echo 1 > event/enable
> > > >     # enable trace
> > > >     $echo 1 > tracing_on
> > > >  
> > > >     # write and run a script that keep reading trace
> > > >     $./read_trace.sh
> > > > 
> > > >     ``` read_trace.sh
> > > >        while :
> > > >        do
> > > >            cat /sys/kernel/tracing/trace > /dev/null
> > > >        done
> > > > 
> > > >     ```  
> > > 
> > > Thanks, I'll look at that when I finish debugging the eventfs bug.
> > > 
> > > -- Steve  
> > 
> > Also thank for your reply,
> >   
> 
> And the temporary fix patch in my first mail should have some modified
> as shown below.
> +               if (((unsigned long)event & 0xfffUL) >= PAGE_SIZE - 4)
>                                              ^^^^^^
>                                             PAGE_SIZE-1
> +                       return -1;


Your email is getting really hard to read due to the line wrap formatting.

Anyway, can you try this patch?

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 72ccf75defd0..5b0653378089 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2390,6 +2390,10 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	commit = rb_page_commit(iter_head_page);
 	smp_rmb();
+	/* An event needs to be at least 8 bytes in size */
+	if (iter->head > commit - 8)
+		goto reset;
+
 	event = __rb_page_index(iter_head_page, iter->head);
 	length = rb_event_length(event);
 
