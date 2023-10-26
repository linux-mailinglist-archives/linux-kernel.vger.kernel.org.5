Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0736A7D8919
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjJZTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjJZTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:45:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E081AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:45:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E66C433C7;
        Thu, 26 Oct 2023 19:45:03 +0000 (UTC)
Date:   Thu, 26 Oct 2023 15:44:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
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
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Message-ID: <20231026154459.1603d750@gandalf.local.home>
In-Reply-To: <20231026194033.it.702-kees@kernel.org>
References: <20231026194033.it.702-kees@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 12:40:37 -0700
Kees Cook <keescook@chromium.org> wrote:

> @@ -81,16 +88,20 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>   *
>   * After this function is called, s->buffer is safe to use
>   * in string operations.
> + *
> + * Returns @s->buf after making sure it is terminated.
>   */
> -static inline void seq_buf_terminate(struct seq_buf *s)
> +static inline char *seq_buf_str(struct seq_buf *s)

Looking at show_buffer() (below), I wonder if this should be:

static inline const char *seq_buf_str() ?

I mean, it can be modified, but do we want to allow that?

-- Steve


>  {
>  	if (WARN_ON(s->size == 0))
> -		return;
> +		return "";
>  
>  	if (seq_buf_buffer_left(s))
>  		s->buffer[s->len] = 0;
>  	else
>  		s->buffer[s->size - 1] = 0;
> +
> +	return s->buffer;
>  }
>  
>  /**
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d629065c2383..2539cfc20a97 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3828,15 +3828,6 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
>  	return false;
>  }
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
>  static DEFINE_STATIC_KEY_FALSE(trace_no_verify);
>  
