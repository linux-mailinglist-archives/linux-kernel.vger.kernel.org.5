Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3310D780DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377704AbjHROXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377726AbjHROXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BAD2D4A;
        Fri, 18 Aug 2023 07:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C72644A5;
        Fri, 18 Aug 2023 14:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5334C433C7;
        Fri, 18 Aug 2023 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692368585;
        bh=BIVXBoe/LM7//z7DoZqVonziikeuqfEuSmQJgwnCYEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hozyRUb2tV6zO4r2iXSPXZLQ5YgedJNQZLq94B8+lc5Hzh+g/t0UPtQOO6T2gB31I
         UDiw0Wl3Cdj8jL3JeNwSNiaQMg4Qz0p9mCYW6AViYXH2C1d9y/yu8JuGvJzeRxQEsS
         fAy8t49eNbpXK1qnNCeshgXwcTMTTPDi17p+43DKkPfpHpfrjpUrXwH5hACtL1+Q95
         XiflnAUpwuLbGIlaPA60uayjEibKmYnNJilmuTEHwQ64+wFawMJrWrWBarJml11OpE
         NPaF5AC1tg6JB43QJTGN8uvCnkOrj4br7OEnpmdsqmnOzC/l2pnavTS0xgwt1fZEBK
         k3nOON5D4dBUA==
Date:   Fri, 18 Aug 2023 23:23:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-Id: <20230818232301.902ad9319569379ebd7df557@kernel.org>
In-Reply-To: <20230818094128.7cf1d58b@gandalf.local.home>
References: <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230818022645.1948314-1-zhengyejian1@huawei.com>
        <20230818140309.b0a720afa87b05a2b7b27315@kernel.org>
        <20230818094128.7cf1d58b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 09:41:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Aug 2023 14:03:09 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Looks good to me. 
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > BTW, this reminds me that splice read support had been introduced for
> > virtio-trace support. I've tested it with/without this patch, but I hit
> > a different issue, which seems like a virtio-serial issue (per-cpu buffers
> > on the guest are spliced correctly, but the data can not be read from host
> > side). Let me investigate it.
> 
> Is virtio-trace using trace_pipe or trace_pipe_raw? Those two are handled
> differently.

It uses trace_pipe_raw. I guess if splice(from trace_pipe_raw to virtio-serial)
returns -1 and errno == EAGAIN, the trace data will be lost?

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
