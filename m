Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3527D89A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbjJZUUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjJZUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:20:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC5618A;
        Thu, 26 Oct 2023 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698351625; x=1729887625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9QFfqFoHIzmszUDwJhsesLvCTOCbL+5vMd7tK5kcmY=;
  b=BnCE+LEOLOcSwoBeKNmQubx5+Qm9mwakWzBQ25+QvERtD3kRQq0Yy0oE
   lQU6TaD8rmRiisarnIhTEoEznHth899zl9y7nqpN31b86emmaZGIaqM+D
   uCTr272F5fzr7R8q1YxKu5bW06AfC1EFRBzVPPPwE0JcSADkytoRB4j8E
   b/DJpBNhrZ5Z36tYpJgOBcWanfypyDSg5d/HsfsBGCd+kwSOEGsntEvjc
   XmVsZt2mV+zrrwl7CgQQrjKs4q9kr8m7qF51Y439Sgb3aRpFhCHGNWUe4
   ek30wExogg0TP1nheLVq/ZL0wetYnlX3edmMisvUqmofL/3x6Vql4EU1s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="384845878"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="384845878"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="762964629"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="762964629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:20:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qw6pz-00000008xA2-2pRF;
        Thu, 26 Oct 2023 23:20:15 +0300
Date:   Thu, 26 Oct 2023 23:20:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <ZTrJ/5Jrzz5D62hh@smile.fi.intel.com>
References: <20231026194033.it.702-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026194033.it.702-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:40:37PM -0700, Kees Cook wrote:
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
>    C String (and is a layering violation exposing the "internals" of
>    seq_buf):
> 
> 	seq_buf_terminate(s);
> 	do_something(s->buffer);
> 
> Instead, we can just return s->buffer direction after terminating it
> in refactored seq_buf_terminate(), now known as seq_buf_str():
> 
> 	do_soemthing(seq_buf_str(s));

...

> +#define DECLARE_SEQ_BUF(NAME, SIZE)					\
> +	char __ ## NAME ## _buffer[SIZE] = "";				\
> +	struct seq_buf NAME = { .buffer = &__ ## NAME ## _buffer,	\
> +				.size = SIZE }

Hmm... Wouldn't be more readable to have it as

#define DECLARE_SEQ_BUF(NAME, SIZE)			\
	char __ ## NAME ## _buffer[SIZE] = "";		\
	struct seq_buf NAME = {				\
		.buffer = &__ ## NAME ## _buffer,	\
		.size = SIZE,				\
	}

?

...

> +static inline char *seq_buf_str(struct seq_buf *s)
>  {
>  	if (WARN_ON(s->size == 0))
> -		return;
> +		return "";

I'm wondering why it's a problem to have an empty string?

>  	if (seq_buf_buffer_left(s))
>  		s->buffer[s->len] = 0;
>  	else
>  		s->buffer[s->size - 1] = 0;
> +
> +	return s->buffer;
>  }

-- 
With Best Regards,
Andy Shevchenko


