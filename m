Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14E7D87D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjJZRyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZRy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:54:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F711C2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:54:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so1191529b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698342867; x=1698947667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PH4To2XC/mAdafvdYkXrnZQKmMWSFuDB+0O1v3ZBMMM=;
        b=WswyT0SXZ4yP0jLVlHwGGpScfs9brAGWAApUKlnSX6Kj2x3gm9x6u9WkUSP/fCZDHN
         3nHBfmO6g8JOjwPCbgabLfNiEtRk5Lyk79a8ojVdVtJFeWEM1mpgk+qzeNcKBW/WFqUz
         KBfUQGMeeNMNFJYZCrXtT63mPXMlLR+CLjfhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342867; x=1698947667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH4To2XC/mAdafvdYkXrnZQKmMWSFuDB+0O1v3ZBMMM=;
        b=vK2kOEpe6Rl8lKNaJGfgicgRrbJev1n3q9XatPPUxJovojQ9YHPu5KXjiAJzROt0Fo
         cNj5n2OE83nAClo6o6+ezInptWvYTS6RK9AwYBxvc3J9A8rBVT0G0X7zcjUi+dax2znU
         l/FiutmuR8HMajxJQbQh54LEUw8dQFmKnMzGyCL8vW8p1gXn2UCDkFz/ZrGByV/+mnaS
         TaP1JA9+VGrMmYbkSBwXPlofXI29EInAuS4FQYzZFId4IDto8hagqmX6rEPUiE92vvN0
         byx+6SMEeUqmljPr05zQX1qt2wfTbpGw0N/udw+o0FOVObfDTLKKH2zRPPWOX0S9Mzq/
         14uA==
X-Gm-Message-State: AOJu0Yws+uQ7JwdVX8Rb1s39Ld9Lul8ewLFpt2vUfLik/bF7lHSct53I
        4jbCRVf2/H2FlRzQsCkv+0EGCQ==
X-Google-Smtp-Source: AGHT+IHPldXzCYr2GtKzgmeUyMQzPuw89d4LlnFsDJQ3LKstlYL7sGCqgtmQsPPCHgq9B0OyDqT+aw==
X-Received: by 2002:a05:6300:8086:b0:154:a1e4:b676 with SMTP id ap6-20020a056300808600b00154a1e4b676mr619359pzc.4.1698342867000;
        Thu, 26 Oct 2023 10:54:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b22-20020a631b56000000b00578afd8e012sm8698997pgm.92.2023.10.26.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:54:26 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:54:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_cstr()
Message-ID: <202310261050.A621A7F121@keescook>
References: <20231026170722.work.638-kees@kernel.org>
 <20231026133850.138d5415@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026133850.138d5415@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:38:50PM -0400, Steven Rostedt wrote:
> On Thu, 26 Oct 2023 10:07:28 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > Solve two ergonomic issues with struct seq_buf:
> 
> "ergonomic"? Does it cause carpal tunnel? ;-)
> 
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
> > in refactored seq_buf_terminate(), now known as seq_buf_cstr():
> > 
> > 	do_soemthing(seq_buf_cstr(s));
> 
> Do we really need to call it _cstr? Why not just have seq_buf_str() ?
> 
> I mean, this is C, do we need to state that in the name too?

I'm fine either way. I did that just to make the distinction between our
length-managed string of characters interface (seq_buf), and the
%NUL-terminated string of characters (traditionally called "C String" in
other languages). And it was still shorter than "seq_buf_terminate(s);
s->buffer" ;)

> BTW, I'm perfectly fine with this change, just the naming I have issues
> with.

Cool; thanks for looking at it!

-- 
Kees Cook
