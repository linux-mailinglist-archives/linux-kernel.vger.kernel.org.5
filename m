Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD77D89B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjJZUdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:33:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BCB191
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:33:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCF0C433C8;
        Thu, 26 Oct 2023 20:33:19 +0000 (UTC)
Date:   Thu, 26 Oct 2023 16:33:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20231026163317.4516369a@gandalf.local.home>
In-Reply-To: <ZTrJ/5Jrzz5D62hh@smile.fi.intel.com>
References: <20231026194033.it.702-kees@kernel.org>
        <ZTrJ/5Jrzz5D62hh@smile.fi.intel.com>
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

On Thu, 26 Oct 2023 23:20:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > +#define DECLARE_SEQ_BUF(NAME, SIZE)					\
> > +	char __ ## NAME ## _buffer[SIZE] = "";				\
> > +	struct seq_buf NAME = { .buffer = &__ ## NAME ## _buffer,	\
> > +				.size = SIZE }  
> 
> Hmm... Wouldn't be more readable to have it as
> 
> #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> 	char __ ## NAME ## _buffer[SIZE] = "";		\
> 	struct seq_buf NAME = {				\
> 		.buffer = &__ ## NAME ## _buffer,	\
> 		.size = SIZE,				\
> 	}
> 
> ?

I agree with the above.

> 
> ...
> 
> > +static inline char *seq_buf_str(struct seq_buf *s)
> >  {
> >  	if (WARN_ON(s->size == 0))
> > -		return;
> > +		return "";  
> 
> I'm wondering why it's a problem to have an empty string?

Not sure what you mean? With s->size = 0, s->buffer may not have been
assigned. That shouldn't be the case, but it does make it more robust.

-- Steve


> 
> >  	if (seq_buf_buffer_left(s))
> >  		s->buffer[s->len] = 0;
> >  	else
> >  		s->buffer[s->size - 1] = 0;
> > +
> > +	return s->buffer;
> >  }  
> 

