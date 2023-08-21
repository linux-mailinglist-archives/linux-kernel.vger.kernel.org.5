Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65AE78367C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjHUXvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHUXvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172AE4;
        Mon, 21 Aug 2023 16:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96AE6143D;
        Mon, 21 Aug 2023 23:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB915C433C7;
        Mon, 21 Aug 2023 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692661861;
        bh=t8ZC1/hEix5LDwCxrMqOZDOEQvYXb18PrM5aegQ/9M0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XeZHg0GL0LyHsXU67Kyyw/C9OwjpLxNFumDun+LeQWvzGmytze4PXp7u8J6SVg11S
         HdskExZxok3W1zxlENFQCefXioQfdANw1aBFFQ9qZLGabTGTZQ7Ahu7cQiCEaNoVAE
         1EfyQqGgFVd5ndMQKSm2KigxjOyGQfZDFO1RXxUPiVMOBhSjjXcDeXSu/Q4jnLOYYq
         6Vecqwxk/SkKBDXtI5e4zbUVoQsRIJuITb6LmifURT7IZXSdKwHEq0pzMgUj8ESC4p
         1J0xxJLYRHKcYdWgIrW3PQhNp/2J+kDZisymhtFB8bwQ22IJAW29GJfQNaYlkc6jvp
         KWI4mZP5jdpww==
Date:   Tue, 22 Aug 2023 08:50:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-Id: <20230822085057.f4d5fa6499bb3ab2a297657c@kernel.org>
In-Reply-To: <20230821112703.23b1964b@gandalf.local.home>
References: <169262755804.106231.8245792908363050528.stgit@devnote2>
        <20230822001639.7a3cbedc3ad6e3938ee76e16@kernel.org>
        <20230821112703.23b1964b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 11:27:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 22 Aug 2023 00:16:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > BTW, even with this fix, blocking splice still causes a strange behavior.
> > If I set '400' to buffer_size_kb (so 100 pages) and '1' to buffer_percent,
> > splice always returns 8192 (2 pages) to read. But I expected that should
> > return 4096 (1 page). This means splice() waits longer than I thought.
> > 
> > I think the fullfilled percentage calculation will be a bit wrong.
> 
> Note, the percentage is when to wake up the task. If between the wakeup and
> the read/splice, another ring buffer page gets filled more, then it will
> give that as well. The buffer_percent is just how long to wait, not for how
> much to read.

Yes, but I used the trace_marker as Zheng did for testing, and I saw the
buffer is filled more than 4096 bytes via tracefs/per_cpu/cpu*/stats.

> 
> Now if you test this with just adding enough to fill one page, and it
> doesn't wake up the reader, then that would be a bug.

Yes.

Run trace_agent with 1% buffer_percent == 1 page;

 # echo 400 > /sys/kernel/tracing/buffer_size_kb
 # echo 1 > /sys/kernel/tracing/buffer_percent
 # trace-agent &

Ready to read in the host side,

$ for i in `seq 0 7`; do cat trace-path-cpu$i.out > trace-data.$i & done
$ echo 1 > agent-ctl-path.in

Write events on per-cpu buffer in the guest
 # for i in `seq 1 1000`; do echo "test event data $i" | tee /sys/kernel/tracing/trace_marker > /dev/null; done 

But trace_agent doesn't wake up. The data is still there.

 # grep bytes /sys/kernel/tracing/per_cpu/cpu*/stats 
/sys/kernel/tracing/per_cpu/cpu0/stats:bytes: 5936
/sys/kernel/tracing/per_cpu/cpu1/stats:bytes: 5584
/sys/kernel/tracing/per_cpu/cpu2/stats:bytes: 6368
/sys/kernel/tracing/per_cpu/cpu3/stats:bytes: 4704
/sys/kernel/tracing/per_cpu/cpu4/stats:bytes: 5972
/sys/kernel/tracing/per_cpu/cpu5/stats:bytes: 5620
/sys/kernel/tracing/per_cpu/cpu6/stats:bytes: 6588
/sys/kernel/tracing/per_cpu/cpu7/stats:bytes: 3496

And write more events via trace_marker again

 # for i in `seq 1001 2000`; do echo "test event data $i" | tee /sys/kernel/tracing/trace_marker > /dev/null; done 

The data is read;

 # grep bytes /sys/kernel/tracing/per_cpu/cpu*/stats 
/sys/kernel/tracing/per_cpu/cpu0/stats:bytes: 3220
/sys/kernel/tracing/per_cpu/cpu1/stats:bytes: 3960
/sys/kernel/tracing/per_cpu/cpu2/stats:bytes: 2420
/sys/kernel/tracing/per_cpu/cpu3/stats:bytes: 2024
/sys/kernel/tracing/per_cpu/cpu4/stats:bytes: 2912
/sys/kernel/tracing/per_cpu/cpu5/stats:bytes: 1064
/sys/kernel/tracing/per_cpu/cpu6/stats:bytes: 5004
/sys/kernel/tracing/per_cpu/cpu7/stats:bytes: 2684

I think this full_hit() function is somewhat wrong.

static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int full)
{
...
        return (dirty * 100) > (full * nr_pages);
}

Ah, I also found a mistake on this patch too.

Thanks, 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
