Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703A7835D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHUWcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF247E4;
        Mon, 21 Aug 2023 15:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63DA761811;
        Mon, 21 Aug 2023 22:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A70DC433C7;
        Mon, 21 Aug 2023 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692657126;
        bh=H8skakv6YVucMh59g7idxop0KkgTdhMqCG9Dz2MfJ6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=exggA+UErTO4RvT3aZOPQfBgZloJ+3bESHr2x9jayiLxserNx3uYES+bY6mzl5M0S
         yo48tFAkt7dFRnjzTd2clBeE3UDZQkkhhnn7uezZosN2WEPFVCtQ7V0fnC378ofHf0
         YsNlEv8nmS5jktqfTO/en7i1FUC7I6p2nU5Nvy4JdehRISvEssC2T3iJO5SpSrM3CX
         NwcaBhi/FkCXE+8rBTxRwjSd0IAfQE/mHDbYc1pYMH6PUzjUuXMdVrjB6xVuQkH2+H
         cai/JJrJlo6uA07pLfkxzWEbKoygMQ1ujEKN/+QlZZb+clzok2/3NpKEZ6wJscaVqv
         XymHvHg3BwLCQ==
Date:   Tue, 22 Aug 2023 07:32:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-Id: <20230822073201.900bcfa52afae3b48755fc6d@kernel.org>
In-Reply-To: <20230821111725.4bfbe7c5@gandalf.local.home>
References: <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230818022645.1948314-1-zhengyejian1@huawei.com>
        <20230818140309.b0a720afa87b05a2b7b27315@kernel.org>
        <20230818094128.7cf1d58b@gandalf.local.home>
        <20230818232301.902ad9319569379ebd7df557@kernel.org>
        <20230818115322.3dfda470@gandalf.local.home>
        <20230819104257.80203c3916509cc9eb9327c1@kernel.org>
        <20230821111725.4bfbe7c5@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 11:17:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 19 Aug 2023 10:42:57 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > >From 92242480285448360c9390a743ea7b3751bb3e61 Mon Sep 17 00:00:00 2001  
> > From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > Date: Thu, 17 Aug 2023 14:08:40 +0900
> > Subject: [PATCH 1/3] tools/virtio-trace: Ignore EAGAIN error on splice()
> > 
> > splice() can return EAGAIN error instead of returning 0 size read.
> > In that case, wait a while and try to call splice() again.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Bah,
> 
> When I pulled in Zheng's patch from patchwork, it included the above
> signed-off-by. I was confused to why it added your SoB.

Oops, I didn't noticed such patchwork behavior. 

> 
> Probably best if we had started this conversation on another thread and
> not hijack the discussion about this patch.

Agreed. Sorry for confusion.


> 
> -- Steve
> 
> 
> > ---
> >  tools/virtio/virtio-trace/trace-agent-rw.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
