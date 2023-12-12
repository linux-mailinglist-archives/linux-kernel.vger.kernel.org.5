Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ABB80FA88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377833AbjLLWrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjLLWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:47:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C36AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:47:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E35C433C7;
        Tue, 12 Dec 2023 22:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702421270;
        bh=fTzQszjJZI1SU83F2DPicXFge7TTPi0j6QJoBbVl1TI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQoT7kHuV6vYeIp2c9J97rMAU/aseRE7+I8zj2u86LxOKPQN1l4BJR9RdO27xHGKh
         bAMyPCc/73mlXUi9IKA+ZnB9OzETYfDcVhTlammymBEyJHwM15dEhUzojsa5nolcjr
         yWtWXwtFNhy5mzf7KKrLDLZ2KkOWER5le/4pWK0RCxipo+VHPi0UGCKgcp0wyHR1uo
         xbNi7X8Ugo4Opw8qTpYwfLVUrUslrclsAr0xLXyNOWR05u+TO9w5++hx59S5vO8Y2T
         +eFu5FGg/fyWaT4J5LYjd0FpZ72mODhtnIubXfkRVjFLSnnZfwXpH9bg/jpNp9jinI
         yPVerbXa1ysiw==
Date:   Wed, 13 Dec 2023 07:47:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Add size check when printing trace_marker
 output
Message-Id: <20231213074746.cd2dbd703bd19fe791c5d44a@kernel.org>
In-Reply-To: <20231212084444.4619b8ce@gandalf.local.home>
References: <20231212084444.4619b8ce@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 08:44:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If for some reason the trace_marker write does not have a nul byte for the
> string, it will overflow the print:
> 
>   trace_seq_printf(s, ": %s", field->buf);
> 
> The field->buf could be missing the nul byte. To prevent overflow, add the
> max size that the buf can be by using the event size and the field
> location.
> 
>   int max = iter->ent_size - offsetof(struct print_entry, buf);
> 
>   trace_seq_printf(s, ": %*s", max, field->buf);
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_output.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index d8b302d01083..e11fb8996286 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1587,11 +1587,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
>  {
>  	struct print_entry *field;
>  	struct trace_seq *s = &iter->seq;
> +	int max = iter->ent_size - offsetof(struct print_entry, buf);
>  
>  	trace_assign_type(field, iter->ent);
>  
>  	seq_print_ip_sym(s, field->ip, flags);
> -	trace_seq_printf(s, ": %s", field->buf);
> +	trace_seq_printf(s, ": %*s", max, field->buf);
>  
>  	return trace_handle_return(s);
>  }
> @@ -1600,10 +1601,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
>  					 struct trace_event *event)
>  {
>  	struct print_entry *field;
> +	int max = iter->ent_size - offsetof(struct print_entry, buf);
>  
>  	trace_assign_type(field, iter->ent);
>  
> -	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
> +	trace_seq_printf(&iter->seq, "# %lx %*s", field->ip, max, field->buf);
>  
>  	return trace_handle_return(&iter->seq);
>  }
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
