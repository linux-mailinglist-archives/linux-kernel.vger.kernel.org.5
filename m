Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5078262A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjHUJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHUJVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18409C4;
        Mon, 21 Aug 2023 02:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C16D6125C;
        Mon, 21 Aug 2023 09:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F6EC433C8;
        Mon, 21 Aug 2023 09:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692609688;
        bh=wQ823UgFqIqDfWCKZGlZx1bFLqWPzhn5niQXXjayheM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SrueoX1nq4yF7grnCq4ELgdAax8Yyi2NHJninj7vPqDUJL1PJFLCnRM1vBH37vcJJ
         8qHyPhzLfGihfY7lfJ6p6n4AHVetJED6Es+5+JKM7dPYZvjX9ePblyAkHVVLyfI/EF
         m580dod0Cyel63pUEIxLzHViBEfRqnqya1M0gzuJ21YhyE8JOjN8eQZO0mBvWEjzrL
         /oGbTF8Xor1GOLUbWSgSwVizfByTB52PqUJeTwsB9TZFpD/OkUZHZMVapW53dtrziA
         DtJI68HueRZnBepXBfRtmkskbEn2HiVEvOA/ubCTyFTNncM3bCQuOXnWTFfMoAhjDf
         cxm1UzYPH4JOQ==
Date:   Mon, 21 Aug 2023 18:21:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-Id: <20230821182124.a1df7e3bf57e78e761065055@kernel.org>
In-Reply-To: <20230820223301.1a013170@rorschach.local.home>
References: <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230818022645.1948314-1-zhengyejian1@huawei.com>
        <20230818140309.b0a720afa87b05a2b7b27315@kernel.org>
        <20230818094128.7cf1d58b@gandalf.local.home>
        <20230818232301.902ad9319569379ebd7df557@kernel.org>
        <20230818115322.3dfda470@gandalf.local.home>
        <20230819104257.80203c3916509cc9eb9327c1@kernel.org>
        <20230821111954.8ca184e9fba62940825eb0e0@kernel.org>
        <20230820223301.1a013170@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 22:33:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 21 Aug 2023 11:19:54 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Ah, this caused a drop. errno can be EAGAIN even if rlen > 0.
> > I've fixed this and that works.
> > BTW, I think this virtio-trace would be better to move under
> > tools/tracing because it is a tracing tool.
> 
> I'm fine with that, as where it is, I'm very unfamiliar with this tool.
> It is likely not taking advantage of all the tracing tooling we
> have. I actually never even used it.

Actually I also used this after a long time. :P
I think this is a kind of simplest splice support test tool.

What the tool does;

(guest side)
per_cpu/cpu*/trace_pipe_raw
     |
   (splice)
     |
  anon-pipe
     |
   (splice)
     |
  virtio-serial chardev
     |
= virtqueue ===
     |
  named-fifo
(host-side)

So that we can move the traced data (page) from the ring buffer to
virtqueue. Then host tool can read the trace data without copying.
(The host part needs a copy to read or write to file.)
Obviously, this requires some integration work with other tracing
tools, because this is just a "fastest trace-data dumper".

(I think Yoshihiro worked that integration, but it was not updated)

https://lkml.org/lkml/2013/9/12/788

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
