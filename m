Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6280DF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjLKXHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjLKXHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:07:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C6D9A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:07:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CCBC433C8;
        Mon, 11 Dec 2023 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702336050;
        bh=BElgQv8/npTSDU2dFL+JufzC4ciRNU6YqmHa3dc12DI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pAyWQ8pgDKHPBv3dj1xjaMrnr2k+U0DA1EpGk7u6/znbiQgAeXsuvQaAMXDMoYA/z
         Xee5VdIeb2OOw460rxC7hL2YxgyXKySTqpi7/hED543BFBQX4d6iLrnt3u6WZWRsVC
         Ykr71wo0h+38RSKjrF0Rg0ejIoTfzmX5Vpce71u4PPTdX21Xqkd+HAlwUKh/jE21gk
         o9BwHHBvs8w15PZC4Yx9y+7h+6yW5sUzkUqVUs0cBoyjLT6Wku555G0l72D08YG28p
         i5X1M7TNN1vvX+cuMG4wfd+ocZyd6NjMXq+N/ZFyyDIm3Xcsg+wfxiZxNxIxkddDez
         yuWFhFuWtY6Mg==
Date:   Tue, 12 Dec 2023 08:07:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] trace_seq: Increase the buffer size to almost two pages
Message-Id: <20231212080726.a8d1f614e65c3b49ff1d9fbd@kernel.org>
In-Reply-To: <20231211132837.24488ec1@gandalf.local.home>
References: <20231209175220.19867af4@gandalf.local.home>
        <20231211214627.cff4ecfead14029ef22cd3ef@kernel.org>
        <20231211132837.24488ec1@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 13:28:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Dec 2023 21:46:27 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > 
> > > By increasing the trace_seq buffer to almost two pages, it can now print
> > > out the first line.
> > > 
> > > This also subtracts the rest of the trace_seq fields from the buffer, so
> > > that the entire trace_seq is now PAGE_SIZE aligned.  
> > 
> > Ok, but I just a bit concern about the memory consumption.
> > Since this is very specific case, can we make it configurable later?
> 
> I was concerned about this too, but it looks like it's allocated and later
> freed in every location except for a couple of instances.
> 
> One is "tracepoint_print_iter" which is used to pipe tracepoints to printk.
> I think we can possibly make that allocated too.
> 
> The other is in ftrace_dump, which I don't think we can easily allocate
> that. Although, we could have it allocated at boot up if
> ftrace_dump_on_oops() is enabled.

Can we reallocate it when we detect such bigger event entry in the path
of trace_marker write? If any issue happens in the reallocation, we will
not finish (commit) such big event in dumping buffer anyway.

> 
> Another KTODO?

Yes, I think so.

Thanks,

> 
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
