Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB57D9D69
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbjJ0Puv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJ0Pus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:50:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9768CE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:50:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1636718b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698421846; x=1699026646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XAYQa3ufeYpImNNDp7qPpU7hHfY982hDiKyd9DINVw=;
        b=G9PlaRf190e9ZoCeBEdFIcQvKCnRCcxb3iXxMOzH7hNkn6yW6sDMMuraO/1+2BP8Cd
         nv54el58uu6RQ0M4gJNHUKP2zUAFtTA1+HhTRsbN6Ok1TbuQDfgaWlhlQCtLwlpKjWqs
         ByTR4qOuW5J5lFsZIxElNvRqwsy2ti76Z7avQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421846; x=1699026646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XAYQa3ufeYpImNNDp7qPpU7hHfY982hDiKyd9DINVw=;
        b=bFi+1atS3bcKuLWvOhbbQrf9rEUlbwLuTz5aAK1mOY1tG8Dsll1GZs9MlVMfCuXdnx
         OgCnQPZ9s7gvNRYQ0WVbaGeELtLlca34r+qgdSauTU0YDzIp9fGlFiBjdjxhRjYSEfuN
         wnqxq45sEtYypz5rjqeEI5Gb66qe07BeYJ1hHxtkqCRc271gupZ8LMMF4Ca5SUg+r/zW
         9i8Q7AE3JQ/DBYcCzsnj5wHHtWucku2aQQY4h5UAvia99t2g5uNHXljyY4Aq7wxKBO8x
         aiJTRWsJB01qqpKxMKGe5miTrLxJsY96RDyWSMaXQ07k7JxcieqLYFyRZhxY5rZD0n2w
         ovcg==
X-Gm-Message-State: AOJu0YyLPgT9FDwB/67lLz+AWeHsJUgVD8uNRyZsY+YLUHNC+V3z1aJe
        EhCYg7koq0FsTed4geZ1egtOeQ==
X-Google-Smtp-Source: AGHT+IHLDmn+AjLaF61rtsmuDfAYVnkIvtlWqCwVQhYl6dmEc/RCPXxVQIOdEbbpEEe95zK+/gUeVw==
X-Received: by 2002:a05:6a00:28c9:b0:6b3:80f8:7e91 with SMTP id ci9-20020a056a0028c900b006b380f87e91mr6843699pfb.9.1698421846306;
        Fri, 27 Oct 2023 08:50:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a63384f000000b0056c2f1a2f6bsm1249776pgn.41.2023.10.27.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:50:45 -0700 (PDT)
Date:   Fri, 27 Oct 2023 08:50:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Message-ID: <202310270849.14B83B56D@keescook>
References: <20231026194033.it.702-kees@kernel.org>
 <20231027045451.GA7838@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027045451.GA7838@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 06:54:51AM +0200, Christoph Hellwig wrote:
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
> 
> DECLARE_SEQ_BUF_ONSTACK maybe?  But otherwise this looks like a good
> concept.

It's usable for globals too... also it's a shorter name as-is. :)

-- 
Kees Cook
