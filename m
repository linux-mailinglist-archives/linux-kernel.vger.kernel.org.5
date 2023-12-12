Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4531B80F363
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjLLQmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjLLQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:42:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483011710
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:42:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12396C433C7;
        Tue, 12 Dec 2023 16:42:00 +0000 (UTC)
Date:   Tue, 12 Dec 2023 11:42:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231212114242.53b02d11@gandalf.local.home>
In-Reply-To: <20231212110332.6fca52c4@gandalf.local.home>
References: <20231212110332.6fca52c4@gandalf.local.home>
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

On Tue, 12 Dec 2023 11:03:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -7300,9 +7301,25 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	buffer = tr->array_buffer.buffer;
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>  					    tracing_gen_ctx());
> -	if (unlikely(!event))
> +	if (unlikely(!event)) {
> +		/*
> +		 * If the size was greated than what was allowed, then
> +		 * make it smaller and try again.
> +		 */

And I forgot to fix the comment. :-p

-- Steve
