Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC577E3259
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjKGApE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 19:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGApC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:45:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12E9C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:44:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC22C433C7;
        Tue,  7 Nov 2023 00:44:57 +0000 (UTC)
Date:   Mon, 6 Nov 2023 19:45:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?xYF1a2Fzeg==?= Bartosik <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH v1 06/12] trace: use TP_printk_no_nl in
 dyndbg:prdbg,devdbg
Message-ID: <20231106194500.123a517e@gandalf.local.home>
In-Reply-To: <20231103131011.1316396-7-lb@semihalf.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
        <20231103131011.1316396-7-lb@semihalf.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 14:10:05 +0100
Łukasz Bartosik <lb@semihalf.com> wrote:

> index ccc5bcb070f9..91dcdbe059c0 100644
> --- a/include/trace/events/dyndbg.h
> +++ b/include/trace/events/dyndbg.h
> @@ -20,20 +20,10 @@ TRACE_EVENT(prdbg,
>  
>  	    TP_fast_assign(
>  			__entry->desc = desc;
> -			/*
> -			 * Each trace entry is printed in a new line.
> -			 * If the msg finishes with '\n', cut it off
> -			 * to avoid blank lines in the trace.
> -			 */
> -			if (len > 0 && (text[len - 1] == '\n'))
> -				len -= 1;
> -
>  			memcpy(__get_str(msg), text, len);
> -			__get_str(msg)[len] = 0;
>  		    ),
>  
> -	    TP_printk("%s.%s %s", __entry->desc->modname,
> -		      __entry->desc->function, __get_str(msg))
> +	    TP_printk_no_nl("%s", __get_str(msg))
>  );
>  

Instead of adding the TP_printk_no_nl() (Which I still do not like), we
could add a:

	__get_str_strip_nl(msg)

That will do the above loop. Which will move the processing to read side
(slow path).

And then we could update libtraceevent to handle that too.

-- Steve
