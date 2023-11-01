Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D207DDD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjKAHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjKAHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:34:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E710C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:34:48 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y5kGq6dQN4QsMy5kGqtze1; Wed, 01 Nov 2023 08:34:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698824085;
        bh=CUdWnEJWzIujOVoGrv8Tkry7Mv7CTElz64mfshxJTJQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rJi92MvQ6mOofN5slXRMyPFe3eAjkqxdtVFn5nwLllDJ+SRifvbmwtuEFGh4PPrEn
         XZWig7/H5tOvyCLvUIML3ki8dAAF2l0LUTdLYo8z2wVm+BUy9adyNQqPE4JoLsE6a8
         XMHapwAXB05kVyIwSUqO+Bd5czGQDKAaBT5e1dgV8q8bC4Dtd8kQ/d7M5lmGERnauj
         Wr8Ub8z1xif6MnldgrdRNc9BlTzFP/muHFP1NRDGZlijltNomGTYCd47eIYcGpCyw7
         hKDH4HBfuWDCZoEf9to4JnB6aY9PBfPs08i8H+hpHt78XsVzqMXmmsjlWs5C0UuAzd
         AkH/uIyBP60MQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 08:34:45 +0100
X-ME-IP: 86.243.2.178
Message-ID: <2a534333-b5f6-4b1d-b4b8-a1a71f91c3ff@wanadoo.fr>
Date:   Wed, 1 Nov 2023 08:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Content-Language: fr
To:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Yun Zhou <yun.zhou@windriver.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-trace-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
References: <20231027155634.make.260-kees@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231027155634.make.260-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/10/2023 à 17:56, Kees Cook a écrit :
> Solve two ergonomic issues with struct seq_buf;
> 
> 1) Too much boilerplate is required to initialize:
> 
> 	struct seq_buf s;
> 	char buf[32];
> 
> 	seq_buf_init(s, buf, sizeof(buf));
> 
> Instead, we can build this directly on the stack. Provide
> DECLARE_SEQ_BUF() macro to do this:
> 
> 	DECLARE_SEQ_BUF(s, 32);
> 
> 2) %NUL termination is fragile and requires 2 steps to get a valid
>     C String (and is a layering violation exposing the "internals" of
>     seq_buf):
> 
> 	seq_buf_terminate(s);
> 	do_something(s->buffer);
> 
> Instead, we can just return s->buffer directly after terminating it in
> the refactored seq_buf_terminate(), now known as seq_buf_str():
> 
> 	do_something(seq_buf_str(s));
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Yun Zhou <yun.zhou@windriver.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: linux-trace-kernel@vger.kernel.org
> Link: https://lore.kernel.org/r/20231026194033.it.702-kees@kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3
>   - fix commit log typos
>   - improve code style for DECLARE_SEQ_BUF (shevchenko)
>   - const-ify seq_bug_str() return (rostedt)
> v2 - https://lore.kernel.org/lkml/20231026194033.it.702-kees@kernel.org
> v1 - https://lore.kernel.org/lkml/20231026170722.work.638-kees@kernel.org
> ---
>   include/linux/seq_buf.h | 21 +++++++++++++++++----
>   kernel/trace/trace.c    | 11 +----------
>   lib/seq_buf.c           |  4 +---
>   3 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 8483e4b2d0d2..5fb1f12c33f9 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -21,9 +21,18 @@ struct seq_buf {
>   	size_t			len;
>   };
>   
> +#define DECLARE_SEQ_BUF(NAME, SIZE)			\
> +	char __ ## NAME ## _buffer[SIZE] = "";		\
> +	struct seq_buf NAME = {				\
> +		.buffer = &__ ## NAME ## _buffer,	\
                          ~~~
Is the & needed here?

CJ

> +		.size = SIZE,				\
> +	}
> +
>   static inline void seq_buf_clear(struct seq_buf *s)
>   {
>   	s->len = 0;
> +	if (s->size)
> +		s->buffer[0] = '\0';
>   }
>   
>   static inline void
> @@ -69,8 +78,8 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>   }
>   
>   /**
> - * seq_buf_terminate - Make sure buffer is nul terminated
> - * @s: the seq_buf descriptor to terminate.
> + * seq_buf_str - get %NUL-terminated C string from seq_buf
> + * @s: the seq_buf handle
>    *
>    * This makes sure that the buffer in @s is nul terminated and
>    * safe to read as a string.
> @@ -81,16 +90,20 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>    *
>    * After this function is called, s->buffer is safe to use
>    * in string operations.
> + *
> + * Returns @s->buf after making sure it is terminated.
>    */
> -static inline void seq_buf_terminate(struct seq_buf *s)
> +static inline const char *seq_buf_str(struct seq_buf *s)
>   {
>   	if (WARN_ON(s->size == 0))
> -		return;
> +		return "";
>   
>   	if (seq_buf_buffer_left(s))
>   		s->buffer[s->len] = 0;
>   	else
>   		s->buffer[s->size - 1] = 0;
> +
> +	return s->buffer;
>   }
>   
>   /**
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d629065c2383..2539cfc20a97 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3828,15 +3828,6 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
>   	return false;
>   }
>   
> -static const char *show_buffer(struct trace_seq *s)
> -{
> -	struct seq_buf *seq = &s->seq;
> -
> -	seq_buf_terminate(seq);
> -
> -	return seq->buffer;
> -}
> -
>   static DEFINE_STATIC_KEY_FALSE(trace_no_verify);
>   
>   static int test_can_verify_check(const char *fmt, ...)
> @@ -3976,7 +3967,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
>   		 */
>   		if (WARN_ONCE(!trace_safe_str(iter, str, star, len),
>   			      "fmt: '%s' current_buffer: '%s'",
> -			      fmt, show_buffer(&iter->seq))) {
> +			      fmt, seq_buf_str(&iter->seq.seq))) {
>   			int ret;
>   
>   			/* Try to safely read the string */
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index b7477aefff53..23518f77ea9c 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -109,9 +109,7 @@ void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
>   	if (s->size == 0 || s->len == 0)
>   		return;
>   
> -	seq_buf_terminate(s);
> -
> -	start = s->buffer;
> +	start = seq_buf_str(s);
>   	while ((lf = strchr(start, '\n'))) {
>   		int len = lf - start + 1;
>   

