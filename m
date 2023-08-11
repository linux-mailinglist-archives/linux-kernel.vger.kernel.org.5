Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEE6779669
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjHKRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHKRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BEEA;
        Fri, 11 Aug 2023 10:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1A46591F;
        Fri, 11 Aug 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D38C433C8;
        Fri, 11 Aug 2023 17:46:34 +0000 (UTC)
Date:   Fri, 11 Aug 2023 13:46:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Iterate trace_eprobe directly
Message-ID: <20230811134631.3c0c0702@gandalf.local.home>
In-Reply-To: <20230811105102.f7c1a2d08700df1c226f096f@kernel.org>
References: <20230810082523.244397-1-nashuiliang@gmail.com>
        <20230810193204.cae5808af79bbcc80b88ff77@kernel.org>
        <20230811105102.f7c1a2d08700df1c226f096f@kernel.org>
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

On Fri, 11 Aug 2023 10:51:02 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 10 Aug 2023 19:32:04 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 10 Aug 2023 16:25:23 +0800
> > Chuang Wang <nashuiliang@gmail.com> wrote:
> >   
> > > Refer to the description in [1], we can skip "container_of()" following
> > > "list_for_each_entry()" by using "list_for_each_entry()" with
> > > "struct trace_eprobe" and "tp.list".
> > > 
> > > [1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/
> > >   
> > 
> > Good point. BTW, it is better to have 'for_each_eprobe(ep)' if it repeats 3 times.  
> 
> Wait, it is for each trace_eprobe on the trace_probe.
> 
> #define for_each_trace_eprobe_on_trace_probe(ep, _tp)
> 	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)
> 


Do we need it so verbose? Why can't it just be:

 #define for_each_trace_eprobe(ep, tp)

If you are worried about consistency with the for_each_trace_kprobe() then let's call it:

 #define for_each_trace_point_eprobe(ep, tp);

-- Steve
