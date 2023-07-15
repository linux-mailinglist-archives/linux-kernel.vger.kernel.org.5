Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA97548CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGONmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGONmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC092700;
        Sat, 15 Jul 2023 06:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD8D60B86;
        Sat, 15 Jul 2023 13:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418A1C433C8;
        Sat, 15 Jul 2023 13:42:03 +0000 (UTC)
Date:   Sat, 15 Jul 2023 09:42:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] tracing: Add free_trace_iter_content() helper
 function
Message-ID: <20230715094201.34a41f17@rorschach.local.home>
In-Reply-To: <d8aeab6c-338e-dcdd-75c6-7ae4eb9c9887@huawei.com>
References: <20230713114510.04c452ca@gandalf.local.home>
        <20230713114700.450e7a17@gandalf.local.home>
        <d8aeab6c-338e-dcdd-75c6-7ae4eb9c9887@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Sat, 15 Jul 2023 13:15:32 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> > @@ -6709,7 +6723,12 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
> >   	}
> >   
> >   	trace_seq_init(&iter->seq);
> > -	iter->trace = tr->current_trace;
> > +
> > +	iter->trace = kzalloc(sizeof(*iter->trace), GFP_KERNEL);
> > +	if (!iter->trace)
> > +		goto fail;  
> 
> Hi, Steve, 'ret' may need to be set before `goto fail`:
>    ret = -ENOMEM;
> 

As I mentioned to Masami, this hunk of the patch didn't belong.
Something got mixed up in the commit. This patch even depends on the
previous patch to remove the allocation completely.

-- Steve
