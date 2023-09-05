Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31A792C69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjIER3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjIER1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:27:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC494850B;
        Tue,  5 Sep 2023 09:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C6B8B81107;
        Tue,  5 Sep 2023 16:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACD7C433C7;
        Tue,  5 Sep 2023 16:39:34 +0000 (UTC)
Date:   Tue, 5 Sep 2023 12:39:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc:     <mhiramat@kernel.org>, <bobule.chang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <cheng-jui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ring-buffer: Do not read at &event->array[0] if it
 across the page
Message-ID: <20230905123953.3c0b3d7a@gandalf.local.home>
In-Reply-To: <20230905141245.26470-1-Tze-nan.Wu@mediatek.com>
References: <20230905141245.26470-1-Tze-nan.Wu@mediatek.com>
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

On Tue, 5 Sep 2023 22:12:45 +0800
Tze-nan Wu <Tze-nan.Wu@mediatek.com> wrote:

> While reading from the tracing/trace, the ftrace reader rarely encounters
> a KASAN invalid access issue.
> It is likely that the writer has disrupted the ring_buffer that the reader
> is currently parsing. the kasan report is as below:

What kernel are you using? There's been recent fixes that handle the race
between reading the last entry and the writer adding to it. This looks like
you may have hit that bug.

> 
> [name:report&]BUG: KASAN: invalid-access in rb_iter_head_event+0x27c/0x3d0
> [name:report&]Read of size 4 at addr 71ffff8111a18000 by task xxxx
> [name:report_sw_tags&]Pointer tag: [71], memory tag: [0f]
> [name:report&]
> CPU: 2 PID: 380 Comm: xxxx
> Call trace:
> dump_backtrace+0x168/0x1b0
> show_stack+0x2c/0x3c
> dump_stack_lvl+0xa4/0xd4
> print_report+0x268/0x9b0
> kasan_report+0xdc/0x148
> kasan_tag_mismatch+0x28/0x3c
> __hwasan_tag_mismatch+0x2c/0x58
> rb_event_length() [inline]
> rb_iter_head_event+0x27c/0x3d0
> ring_buffer_iter_peek+0x23c/0x6e0
> __find_next_entry+0x1ac/0x3d8
> s_next+0x1f0/0x310
> seq_read_iter+0x4e8/0x77c
> seq_read+0xf8/0x150
> vfs_read+0x1a8/0x4cc
> 
> In some edge cases, ftrace reader could access to an invalid address,
> specifically when reading 4 bytes beyond the end of the currently page.
> While issue happened, the dump of rb_iter_head_event is shown as below:
> 
>     in function rb_iter_head_event:
>           - iter->head = 0xFEC
>           - iter->next_event = 0xFEC
>           - commit = 0xFF0
>           - read_stamp = 0x2955AC46DB0
>           - page_stamp = 0x2955AC2439A
>           - iter->head_page->page = 0x71FFFF8111A17000
>           - iter->head_page->time_stamp = 0x2956A142267
>           - iter->head_page->page->commit = 0xFF0
>           - the content in iter->head_page->page
>                 0x71FFFF8111A17FF0: 01010075 00002421 0A123B7C FFFFFFC0
> 
> In rb_iter_head_event, reader will call rb_event_length with argument
> (struct ring_buffer_event *event = 0x71FFFF8111A17FFC).

As the commit is considered the end of buffer, it should never read past
that, which the above appears to be doing. That's why I think it hit that
race.

> Since the content data start at address 0x71FFFF8111A17FFC are 0xFFFFFFC0.
> event->type will be interpret as 0x0, than the reader will try to get the
> length by accessing event->array[0], which is an invalid address:
>     &event->array[0] = 0x71FFFF8111A18000
> 
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
> ---
> Following patch may not become a solution, it merely checks if the address
> to be accessed is valid or not within the rb_event_length before access.
> And not sure if there is any side-effect it can lead to.
> 
> I am curious about what a better solution for this issue would look like.
> Should we address the problem from the writer or the reader?
> 
> Also I wonder if the cause of the issue is exactly as I suspected.
> Any Suggestion will be appreciated.

I guess this depends on if you have the fixes or not?

> 
> Test below can reproduce the issue in 2 hours on kernel-6.1.24:
>     $cd /sys/kernel/tracing/
>     # make the reader and writer race more through resize the buffer to 8kb
>     $echo 8 > buffer_size_kn
>     # enable all events
>     $echo 1 > event/enable
>     # enable trace
>     $echo 1 > tracing_on
>  
>     # write and run a script that keep reading trace
>     $./read_trace.sh
> 
>     ``` read_trace.sh
>        while :
>        do
>            cat /sys/kernel/tracing/trace > /dev/null
>        done
> 
>     ```

Thanks, I'll look at that when I finish debugging the eventfs bug.

-- Steve
