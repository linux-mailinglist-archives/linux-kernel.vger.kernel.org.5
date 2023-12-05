Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D526805C41
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbjLEReo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLERem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:34:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482CCA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:34:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9D3C433C8;
        Tue,  5 Dec 2023 17:34:48 +0000 (UTC)
Date:   Tue, 5 Dec 2023 12:35:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Always update snapshot buffer size
Message-ID: <20231205123514.03244a4e@gandalf.local.home>
In-Reply-To: <20231205115223.5256e1a1@gandalf.local.home>
References: <20231205115223.5256e1a1@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 11:52:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> It use to be that only the top level instance had a snapshot buffer (for
> latency tracers like wakeup and irqsoff). The update of the ring buffer
> size would check if the instance was the top level and if so, it would
> also update the snapshot buffer as it needs to be the same as the main
> buffer.
> 
> Now that lower level instances also has a snapshot buffer, they too need
> to update their snapshot buffer sizes when the main buffer is changed,
> otherwise the following can be triggered:
> 
>  # cd /sys/kernel/tracing
>  # echo 1500 > buffer_size_kb
>  # mkdir instances/foo
>  # echo irqsoff > instances/foo/current_tracer
>  # echo 1000 > instances/foo/buffer_size_kb
> 

Bah, this is only a partial patch, in fact it doesn't even fix the issue.
It fixes another issue that this issue is dependent on.

I'll send out a v2 shortly.

-- Steve
