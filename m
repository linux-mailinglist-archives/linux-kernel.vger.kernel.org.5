Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C877C162
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjHNUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjHNUQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD1013E;
        Mon, 14 Aug 2023 13:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4620F6135C;
        Mon, 14 Aug 2023 20:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD79FC433C7;
        Mon, 14 Aug 2023 20:16:26 +0000 (UTC)
Date:   Mon, 14 Aug 2023 16:16:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
        laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-ID: <20230814161625.4a0ad49a@gandalf.local.home>
In-Reply-To: <CAHk-=wgBRFisXK0ATFsKCSsCjMNne4aJqRszAY=ex0viUkkrqQ@mail.gmail.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
        <20230811152525.2511f8f0@gandalf.local.home>
        <b5dbdbeb-be3a-3434-0909-0697d8cb15bf@huawei.com>
        <20230812211317.6d015e1d@rorschach.local.home>
        <CAHk-=wgBRFisXK0ATFsKCSsCjMNne4aJqRszAY=ex0viUkkrqQ@mail.gmail.com>
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

On Sun, 13 Aug 2023 09:41:33 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So if somebody really *really* want sendfile to work for this case, then you
> 
>  (a) do need to fix the race in tracing_splice_read_pipe (which you
> should do anyway, since you can obviously always use splice() itself,
> not sendfile()).
> 
> AND
> 
>  (b) figure out when 'splice_write()' will always succeed fully and
> convince people that we can do that "extended version" of sendfile().
> 

No big deal. I really don't care about splicing trace_pipe anyway. That was
added by others, but the trace_pipe_raw is what really should be used.

Zheng's race needs to be fixed regardless, but I just wanted to make sure
this wasn't some kind of hidden regression, as there were patches to
trace_pipe to make sendfile get fixed in the past.

a29054d9478d0 ("tracing: Fix crash from reading trace_pipe with sendfile")

But that too was triggered by cat. If cat no longer uses sendfile for
trace_pipe, I'm fine with it.

-- Steve
