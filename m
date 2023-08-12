Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA0977A2C2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHLUrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHLUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437510F2;
        Sat, 12 Aug 2023 13:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C86A62053;
        Sat, 12 Aug 2023 20:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC07C433C8;
        Sat, 12 Aug 2023 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691873226;
        bh=GzC4x0klJbC6IHTc+zGY0OS5suem56P8TLoijYx/vTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MznaNa1n2X0Hi/3u2i6WQwjzoUx+o/AngQujBm86ryw/ZwlIiSu807ptp52kuUf0/
         VKTHWcSz24ZIsWlg6xGsz0UMxm73oEuAFrbtrv+pk6kDRdzHqq3+WokdGV8wPxSPHK
         tCnvbtaUvvT9uWEcBN+xMTCB2onhF5LKOSshUf71Je+Vj7mmi3TdpxCMP/AWKmueih
         B21Tz0zSIBSORnK3LuzxaarOEV8BCG6mh8YTG7Lre/qXJteKJDXG5SjDOJAw1SoN4P
         eOthgOiJYcil279Nfpf8UvAtjiGpZIX5/UKlPMquXI2iwQiGO3U3bX1OcFRJCHOqKf
         zWg7Yee++W7bA==
Date:   Sun, 13 Aug 2023 05:47:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-Id: <20230813054702.22ce16d9191a1f6b84942a1e@kernel.org>
In-Reply-To: <52369719-dbc7-7cb5-f766-877d24c8400c@huawei.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
        <20230811152525.2511f8f0@gandalf.local.home>
        <52369719-dbc7-7cb5-f766-877d24c8400c@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 09:45:52 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> On 2023/8/12 03:25, Steven Rostedt wrote:
> > On Thu, 10 Aug 2023 20:39:05 +0800
> > Zheng Yejian <zhengyejian1@huawei.com> wrote:
> > 
> >> When concurrently splice_read file trace_pipe and per_cpu/cpu*/trace_pipe,
> >> there are more data being read out than expected.
> 
> Sorry, I didn't make clear here. It not just read more but also lost
> some data. My case is that, for example:
>    1) Inject 3 events into ring_buffer: event1, event2, event3;
>    2) Concurrently splice_read through trace_pipes;
>    3) Then actually read out: event1, event3, event3. No event2, but 2 
> event3.
> 
> > 
> > Honestly the real fix is to prevent that use case. We should probably have
> > access to trace_pipe lock all the per_cpu trace_pipes too.
> 
> Yes, we could do that, but would it seem not that effective?
> because per_cpu trace_pipe only read its own ring_buffer and not race
> with ring_buffers in other cpus.

I think Steve said that only one of below is usable.

- Read trace_pipe

or

- Read per_cpu/cpu*/trace_pipe concurrently

And I think this makes sence, especially if you use splice (this *moves*
the page from the ring_buffer to other pipe).

Thank you,


> 
> > 
> > -- Steve
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
