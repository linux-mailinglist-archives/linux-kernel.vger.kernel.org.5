Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66977453E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHHSjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjHHSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:38:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457075868
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D66618D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1EDC433C7;
        Tue,  8 Aug 2023 17:20:32 +0000 (UTC)
Date:   Tue, 8 Aug 2023 13:20:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
Message-ID: <20230808132030.4ddfc90f@gandalf.local.home>
In-Reply-To: <yt9dzg31ppzy.fsf@linux.ibm.com>
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230807215310.068fce2f@gandalf.local.home>
        <yt9da5v1rhqd.fsf@linux.ibm.com>
        <20230808061423.0a12980f@gandalf.local.home>
        <yt9dzg31ppzy.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 16:28:49 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> >> I think the problem is that the code assigns data_offset with:
> >> 
> >> *(u32 *)&entry->fields[*n_u64] = data_offset;
> >> 
> >> but reads it with:
> >> 
> >> offset = (u32)entry->fields[n_u64];
> >> 
> >> which works on LE, but not BE.  
> >
> > Ah, that makes sense. I didn't realize (or forgot) that s390 was BE. My
> > PowerPC box that was BE died years ago, and I have stopped testing BE ever
> > since :-(  
> 
> Ok. If you want something for testing BE i could provide you with an
> s390 linux image + the commandline to run that within qemu. Linux on
> s390 is not much different than other platforms, but you would need an
> s390 cross-compiler.

That's fine. I have you to test the BE code ;-)

> >> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> >> index d6a70aff2410..1f8fe7f2b5b2 100644
> >> --- a/kernel/trace/trace_events_synth.c
> >> +++ b/kernel/trace/trace_events_synth.c
> >> @@ -125,9 +125,22 @@ static bool synth_event_match(const char *system, const char *event,
> >>  		(!system || strcmp(system, SYNTH_SYSTEM) == 0);
> >>  }
> >>  
> >> +struct synth_trace_data {
> >> +	u16 len;
> >> +	u16 offset;
> >> +};  
> >
> > This is actually common throughout the tracing code (as all dynamic fields
> > have this). We should probably make this more generic than just for
> > synthetic events. Although, that would probably break BE user space. Hmm,
> > we could have it be:  
> 
> I'm not familiar with the ftrace code, so I think i would need some more
> time to find all the other locations. Therefore i updated the patch to move
> the structure declaration to trace.h and sent that as a first step.

It's been on my todo list for sometime. Maybe I should just go and do that
part.

-- Steve
