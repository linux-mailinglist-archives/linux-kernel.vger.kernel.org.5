Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A47780A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376497AbjHRK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376474AbjHRK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751E270C;
        Fri, 18 Aug 2023 03:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84D6165D0C;
        Fri, 18 Aug 2023 10:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA83C433C8;
        Fri, 18 Aug 2023 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356365;
        bh=mMQ7J5RUF1JjN5MTtiE+lcfraVl3bGnc5cuVC7KgcrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KU15X0leS4QoaLFds9vHlaSvTM0c2Snk8ea0scBw6OLrz6GW1rkO59jD5ZZbBFK+Q
         jmUSbBhco/Xrwl9ZxkkpcO453/9q4y6sNV4kckFJZ7EQcCEPKV6k3r82Fs5bX12g5m
         zhuftcyWqroE80/m14lZqkeX++zCKgT1JaECd/HB0q03Ux7Z39LJBEFJmmJ0dqkXFK
         zVpB83NH8Bwo7SJHik6E2hC/rTM6HVcOi/vu+eVDnfMhI9ieEQZmOlj+sbkUrgdZrd
         gp4X2Bz/N+E11WkbfGv0tf+jFJhECOjAdfeZruZtOqkUGze3B/HZiQ5OOic/2YdwEH
         kI4eY4sQNCJWA==
Date:   Fri, 18 Aug 2023 19:59:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/8] Documentation: probes: Add a new ret_ip callback
 parameter
Message-Id: <20230818195918.d0372f968ded553a8ef99932@kernel.org>
In-Reply-To: <CABRcYm+ZuuJJGGk1cQso=4ZN+jBp2g5NODFJYq-TDqzu8KL85A@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
        <169181860742.505132.14215380532909911090.stgit@devnote2>
        <CABRcYm+ZuuJJGGk1cQso=4ZN+jBp2g5NODFJYq-TDqzu8KL85A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 10:57:18 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:36 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Add a new ret_ip callback parameter description.
> >
> > Fixes: cb16330d1274 ("fprobe: Pass return address to the handlers")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Documentation/trace/fprobe.rst |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> > index 40dd2fbce861..a6d682478147 100644
> > --- a/Documentation/trace/fprobe.rst
> > +++ b/Documentation/trace/fprobe.rst
> > @@ -91,9 +91,9 @@ The prototype of the entry/exit callback function are as follows:
> >
> >  .. code-block:: c
> >
> > - int entry_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
> > + int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
> >
> > - void exit_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
> > + void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
> >
> >  Note that the @entry_ip is saved at function entry and passed to exit handler.
> >  If the entry callback function returns !0, the corresponding exit callback will be cancelled.
> > @@ -108,6 +108,10 @@ If the entry callback function returns !0, the corresponding exit callback will
> >          Note that this may not be the actual entry address of the function but
> >          the address where the ftrace is instrumented.
> >
> > +@ret_ip
> > +        This is the return address of the traced function. This can be used
> > +        at both entry and exit.
> 
> Maybe that's just the lack of coffee but I had to think twice to
> understand what this paragraph meant :) On my first pass I thought
> this meant "the address of the return instruction", which made little
> sense since there can of course be multiple "ret"s in a function. I
> like the name in the fprobe code "parent_ip" because I find it conveys
> better that this is an address in the caller of the traced function.
> I'm also fine with this "ret_ip" but I propose we modify the paragraph
> a little bit to something like:
> 
> This is the address that the traced function will return to, somewhere
> in its caller. This can be used at both entry and exit.

Thanks, that makes it more clear. I'll update it.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
