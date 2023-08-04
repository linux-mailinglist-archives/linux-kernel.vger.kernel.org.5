Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728E1770742
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjHDRgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHDRgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542C4EF1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C9BF620D3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20455C433C7;
        Fri,  4 Aug 2023 17:36:04 +0000 (UTC)
Date:   Fri, 4 Aug 2023 13:36:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
Message-ID: <20230804133601.40cb5fe9@gandalf.local.home>
In-Reply-To: <yt9da5v66a4v.fsf@linux.ibm.com>
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230804115033.34c2b5af@gandalf.local.home>
        <yt9da5v66a4v.fsf@linux.ibm.com>
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

On Fri, 04 Aug 2023 18:32:48 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> > Can you show where exactly the above line is?  
> 
> It is:
> 
> (gdb) list *(print_synth_event+0xa68)
> 0x5e4f60 is in print_synth_event (/home/svens/ibmgit/linux/kernel/trace/trace_events_synth.c:410).
> 405                             p = (void *)entry + data_offset;
> 406                             end = (void *)p + len - (sizeof(long) - 1);
> 407
> 408                             trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
> 409
> 410                             for (; *p && p < end; p++)

I think that conditional needs to be swapped. Can you test the following
change and see if the problem disappears?

> 411                                     trace_seq_printf(s, "=> %pS\n", (void *)*p);
> 412                             n_u64++;
> 413
> 414                     } else {

-- Steve

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index dd398afc8e25..1e266e6436a0 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -407,7 +407,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
 
-			for (; *p && p < end; p++)
+			for (; p < end && *p; p++)
 				trace_seq_printf(s, "=> %pS\n", (void *)*p);
 			n_u64++;
 
