Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D67D9D60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjJ0Ptg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjJ0Pte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:49:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BD192
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:49:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so2135744b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698421770; x=1699026570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHk29Z1bkPqek7gCeEpQVU54722xNK+qdY6dXvgVPY8=;
        b=ATrAPvCKwjonLFj9lKdIZimwFmb/SqMTIRYvQbpVDoFLonCY9KcVaQtgjLVByQuja+
         bB1VuSHXg/oDB1txQKVm9Rykz6n/kY4YMs8c9p2RnIkJcPpEda1IVNCoAtUKHZuURHwt
         SM3vpwr16qmbnv+z8SIkzmxBtV5hsZNyabth0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421770; x=1699026570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHk29Z1bkPqek7gCeEpQVU54722xNK+qdY6dXvgVPY8=;
        b=nmmEf8mNqjfHP/CATtI+Lnq3jhJSTJKzwG+ENdwAORKgU3VMW+4lNAL3hkBW/oniqY
         a/+Xqo4/Vhi5tKXoEBUNLQ8dTPGTLNFzDX6Ma0qnQQ/9RKHLtXm5g4LYJI+lSVfi2Wjh
         G9rY61jYdBczJT3L+QNEy0/W158gG++rl0fHSkUo1PwspagQs6CIFB/qU4z5BQNIWyL9
         0LImgQ97yEbXUOnUpup+OyNhVB3w3zaCYJS9YUqrV+Trep7pW6lkmur0WNSCxbrmeWBn
         1UIAEjTKNn6Hw37NdDbSJD7NCJRPOhzigfJTG0eQ0r40XeL/z4jQpuRUKt3R+M2khTNt
         v4Ng==
X-Gm-Message-State: AOJu0YwuVat6eHZmv1KTeuWzNd8K02v3OomD8a9xixi/Jv8F4o6d8eDx
        b6e7Vm7++OR3U6h6SwS82Ts6kA==
X-Google-Smtp-Source: AGHT+IG8CGn3LR7gwK8EOywQp5gX/Xh8ODsLfMiXAYGBvX9k7hXCAhY6wBTnbVquWb7hZb55GSET8g==
X-Received: by 2002:a05:6a00:814:b0:6b2:2a2d:7a26 with SMTP id m20-20020a056a00081400b006b22a2d7a26mr3566629pfk.28.1698421770505;
        Fri, 27 Oct 2023 08:49:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a00078500b006930db1e6cfsm1556618pfu.62.2023.10.27.08.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:49:28 -0700 (PDT)
Date:   Fri, 27 Oct 2023 08:49:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <202310270847.87B9B46EE@keescook>
References: <20231026194033.it.702-kees@kernel.org>
 <ZTrJ/5Jrzz5D62hh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTrJ/5Jrzz5D62hh@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:20:15PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 26, 2023 at 12:40:37PM -0700, Kees Cook wrote:
> > Solve two ergonomic issues with struct seq_buf;
> > 
> > 1) Too much boilerplate is required to initialize:
> > 
> > 	struct seq_buf s;
> > 	char buf[32];
> > 
> > 	seq_buf_init(s, buf, sizeof(buf));
> > 
> > Instead, we can build this directly on the stack. Provide
> > DECLARE_SEQ_BUF() macro to do this:
> > 
> > 	DECLARE_SEQ_BUF(s, 32);
> > 
> > 2) %NUL termination is fragile and requires 2 steps to get a valid
> >    C String (and is a layering violation exposing the "internals" of
> >    seq_buf):
> > 
> > 	seq_buf_terminate(s);
> > 	do_something(s->buffer);
> > 
> > Instead, we can just return s->buffer direction after terminating it
> > in refactored seq_buf_terminate(), now known as seq_buf_str():
> > 
> > 	do_soemthing(seq_buf_str(s));
> 
> ...
> 
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

Yes, I don't know why I did it the smooshed way. Fixed for v3.

> > +static inline char *seq_buf_str(struct seq_buf *s)
> >  {
> >  	if (WARN_ON(s->size == 0))
> > -		return;
> > +		return "";
> 
> I'm wondering why it's a problem to have an empty string?

Well, it's a pathological case where "size" is 0 -- it shouldn't happen
(hence the warn), but it's more robust to return an empty .data string
pointer than a NULL s->buffer or an s->buffer that isn't intended to be
used (i.e. the size == 0).

-- 
Kees Cook
