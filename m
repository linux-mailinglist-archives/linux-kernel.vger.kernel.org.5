Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3317CF72C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbjJSLlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjJSLk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:40:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D1BE;
        Thu, 19 Oct 2023 04:40:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9bda758748eso973134966b.2;
        Thu, 19 Oct 2023 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697715655; x=1698320455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQbYmJmwIs6r+Dbv/KSZdaRjCezMRBGYvovR08iAwH0=;
        b=VtCtt9+lFDCcx38NBwRpO5b3nR7RQ7tNjxgadsxWqw8HaM9NEGgVHXcvR8jBYaNOe3
         +xSsEi6FrRQUyH3/CQXvU4alUBnua0PAqRn5MK/Y4kHy4H11W5X9G/b+Q5SFGm7e6JgA
         NMkym2yWxqmjvZXO1z6Om/0Ungtnn3KwR9uNi4k2v+9Su6GGYUaOwCGbyidYqdVwD/NO
         7XQkCq0l9DWB7CUULbEQaRIDrhsGqf2aE06zn/U4tr3jtSGKXudAZxSmio7eDdkQKYlT
         3ntvM/cDubWYTrZdDjzxgmtSuN7FAFiKuIspJhiYxLs+xMGQXX6F+TBVCT1Hv23iwe7W
         5CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697715655; x=1698320455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQbYmJmwIs6r+Dbv/KSZdaRjCezMRBGYvovR08iAwH0=;
        b=jLeOsBTqQcxc5maOk+WSaEqCNGaws+MtrvXJBiplb+Bb0YdjWkiNDqR/5rgG6lyWgD
         I6yoq+zyj6IcpP39XHjEaRjxhfLMpEIdt/oLa6S0YzMVPbxBXGDF+B6DWWxRynyQsmlf
         sVr3jHWSpJjvvrRkdqyBwgh2YZqdwRbizcvbqH6myf9YbZoG7nBBIpz4FcuqwPx3BLT5
         MhppBFJWH8dgDbPwfu164dySixIGijxE4ciCyGhygHGF0ArQgaIkQKg9BgJk9zXAwYPu
         98hXFx3FENlkU3KNjrMretVDYkT6u0yP22gQ1Y8r988hJ7OH/HR6bXb4c10tK3iE7+U4
         vRIQ==
X-Gm-Message-State: AOJu0YzyjFX48kabV8CbSAgzrGcZuBoNIFD2VPLJLXp2w8qYvzA2FYCR
        tYSU6gN0B6uCd6ZjeF9hIg==
X-Google-Smtp-Source: AGHT+IEeA1tO05DglDmd90NPT5dBRNdiwc7EdZy0bFNJpeP4Kun43dIdtjhTHzs4e3AkFQBwvevGfg==
X-Received: by 2002:a17:906:d552:b0:9c6:64be:a3c9 with SMTP id cr18-20020a170906d55200b009c664bea3c9mr1425251ejc.39.1697715654778;
        Thu, 19 Oct 2023 04:40:54 -0700 (PDT)
Received: from p183 ([46.53.252.19])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090651cf00b009a168ab6ee2sm3362348ejk.164.2023.10.19.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:40:54 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:52 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <50ad206e-8a6a-4223-8050-0880e2b1581c@p183>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <ZTDUYSBS7AO9pAgm@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTDUYSBS7AO9pAgm@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:01:53AM +0200, Willy Tarreau wrote:
> On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > On Thu, Oct 19, 2023 at 07:46:42AM +0200, Christoph Hellwig wrote:
> > > On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> > > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > > [1] and as such we should prefer more robust and less ambiguous string
> > > > interfaces.
> > > 
> > > If we want that we need to stop pretendening direct manipulation of
> > > nul-terminate strings is a good idea.  I suspect the churn of replacing
> > > one helper with another, maybe slightly better, one probably
> > > introduces more bugs than it fixes.
> > > 
> > > If we want to attack the issue for real we need to use something
> > > better.
> > > 
> > > lib/seq_buf.c is a good start for a lot of simple cases that just
> > > append to strings including creating complex ones.  Kent had a bunch
> > > of good ideas on how to improve it, but couldn't be convinced to
> > > contribute to it instead of duplicating the functionality which
> > > is a bit sad, but I think we need to switch to something like
> > > seq_buf that actually has a counted string instead of all this messing
> > > around with the null-terminated strings.
> > 
> > When doing more complex string creation, I agree. I spent some time
> > doing this while I was looking at removing strcat() and strlcat(); this
> > is where seq_buf shines. (And seq_buf is actually both: it maintains its
> > %NUL termination _and_ does the length counting.) The only thing clunky
> > about it was initialization, but all the conversions I experimented with
> > were way cleaner using seq_buf.
> (...)
> 
> I also agree. I'm using several other schemes based on pointer+length in
> other projects and despite not being complete in terms of API (due to the
> slow migration of old working code), over time it proves much easier to
> use and requires far less controls.
> 
> With NUL-teminated strings you need to perform checks for each and every
> operation. When the length is known and controlled, most often you can
> get rid of many tests on intermediate operations and perform a check at
> the end, thus you end up with less "if" and "goto fail" in the code,
> because the checks are no longer for "not crashing nor introducing
> vulnerabilities", but just "returning a correct result", which can often
> be detected more easily.
> 
> Another benefit I found by accident is that when you need to compare some
> tokens against multiple ones (say some keywords for example), it becomes
> much faster than strcmp()-based if/else series because in this case you
> start by comparing lengths instead of comparing contents. And when your
> macros allow you to constify string constants, the compiler will replace
> long "if" series with checks against constant values, and may even arrange
> them as a tree since all are constants, sometimes mixing with the first
> char as the discriminator. Typically on the test below I observe a 10x
> speedup at -O3 and ~5x at -O2 when I convert this:
> 
> 	if (!strcmp(name, "host") ||
> 	    !strcmp(name, "content-length") ||
> 	    !strcmp(name, "connection") ||
> 	    !strcmp(name, "proxy-connection") ||
> 	    !strcmp(name, "keep-alive") ||
> 	    !strcmp(name, "upgrade") ||
> 	    !strcmp(name, "te") ||
> 	    !strcmp(name, "transfer-encoding"))
> 		return 1;
> 
> to this:
> 
> 	if (isteq(name, ist("host")) ||
> 	    isteq(name, ist("content-length")) ||
> 	    isteq(name, ist("connection")) ||
> 	    isteq(name, ist("proxy-connection")) ||
> 	    isteq(name, ist("keep-alive")) ||
> 	    isteq(name, ist("upgrade")) ||
> 	    isteq(name, ist("te")) ||
> 	    isteq(name, ist("transfer-encoding")))
> 		return 1;
> 
> The code is larger but when compiled at -Os, it instead becomes smaller.
> 
> Another interesting property I'm using in the API above, that might or
> might not apply there is that for most archs we care about, functions
> can take a struct of two words passed as registers, and can return
> such a struct as a pair of registers as well. This allows to chain
> functions by passing one function's return as the argument to another
> one, which is what users often want to do to avoid intermediate
> variables.

Chaining should be nice cherry on top for very specific cases but certainly
not promoted or advertised. Deleting intermediate variables promotes
implementation-defined behaviour because of unspecified order of evaluation
of function arguments. Second, debuggers still operate with lines in mind,
so jumping to the next statement written like this

	f(g(), h())

can be problematic. Intermediate variables are much less of a problem now
that -Wdeclaration-after-statement has been finally abolished! They don't
consume LOC anymore.

> All this to say that length-based strings do offer quite a lot of
> benefits over the long term.

As long as they are named kstring :-) Or std_string, he-he.
