Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76B753D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjGNOWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjGNOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893749B;
        Fri, 14 Jul 2023 07:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BA061D27;
        Fri, 14 Jul 2023 14:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF5AC433C7;
        Fri, 14 Jul 2023 14:22:18 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:22:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [PATCH 2/2] tracing: Add free_trace_iter_content() helper
 function
Message-ID: <20230714102217.35e2153c@gandalf.local.home>
In-Reply-To: <20230714174757.4ab9157a2edb32d35224edfb@kernel.org>
References: <20230713114510.04c452ca@gandalf.local.home>
        <20230713114700.450e7a17@gandalf.local.home>
        <20230714174757.4ab9157a2edb32d35224edfb@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 17:47:57 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > @@ -6709,7 +6723,12 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
> >  	}
> >  
> >  	trace_seq_init(&iter->seq);
> > -	iter->trace = tr->current_trace;
> > +
> > +	iter->trace = kzalloc(sizeof(*iter->trace), GFP_KERNEL);
> > +	if (!iter->trace)
> > +		goto fail;
> > +
> > +	*iter->trace = *tr->current_trace;  
> 
> Hmm, you allocate iter->trace here (again)

Bah, that looks like it got out of sync with the previous patch (which
removed that). That's not suppose to be there.

I'll fix this an send out a v2. Thanks for catching that!

-- Steve
