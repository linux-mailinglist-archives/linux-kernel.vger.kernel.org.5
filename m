Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAC7A10D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjINWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjINWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:18:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3372D49;
        Thu, 14 Sep 2023 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q/TYaYSuVqsQSjwryAM4z4+U7qrtWTJeyMiMA4yjJmI=; b=seN2zUIEhbEiw4+xT7dHrB+HiQ
        X6laKSRDDOLQp8xPDa/26qm6dqmYB0UjEnG4UGF84bdOaaUI5O7pLWWvNDVUbeDpjlsfafAZvR0B/
        vjLjqWu/u5tsyQD0YhLTqYI69gjWOcsW9E4dh4FUNOLo82OkUAZHIuGZllArz0Es70Y3vTtJUhOu6
        lJ0olPbtWblPpRDMiGJXhE4euSXyNbnCL7PiWuLBOwLuAjC31y0PabEHTzMZ5ndA5QfrNprlV5J0T
        SREXT1YZ2qYjVUVl22yGmhVTL6zwfrbwwxTDMOezUNm2yaT1JaoDxLDW5gfMF2lpGXrMQyXxs2D9J
        OPI9Gfzw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qguet-005XBo-5G; Thu, 14 Sep 2023 22:17:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC29230036C; Fri, 15 Sep 2023 00:17:58 +0200 (CEST)
Date:   Fri, 15 Sep 2023 00:17:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: guard coding style (was: Re: [PATCH v1 05/10] gpio: pca953x:
 Simplify code with cleanup helpers)
Message-ID: <20230914221758.GA5492@noisy.programming.kicks-ass.net>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
 <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org>
 <CAMRc=Merdmv_gFm58y1iHWmYmT=t_OmXyQgOXCxqwr7wsmjjYQ@mail.gmail.com>
 <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:47:07AM +0200, Geert Uytterhoeven wrote:

> > Only compound statements need curly braces in the kernel and it has
> > been like this forever. I don't really see a need to make it an
> > exception.

Kernel coding style is a little different from what C demands.
Specifically, kernel style demands { } for anything multi-line.

Specifically:

	for (;;) {
		/* a comment */
		foo();
	}

or

	for (;;) {
		foo(a, very, long,
		    arg, chain);
	}

do both warrant a pile of curlies in kernel style where C does not
demand it.

> > That being said - I don't think the coding style for guard has ever
> > been addressed yet, so maybe bring it up with Peter Zijlstra?
> 
> That's a good idea!
> 
> I see Peter always used curly braces (but he didn't have any
> single-statement blocks, except for one with an "if", and we do tend
> to use curly braces in "for"-statements containing a single "if", too),
> but he does put a space after the "scoped_guard", as is also
> shown in the template in include/linux/cleanup.h:
> 
>     scoped_guard (name, args...) { }:
> 

Right, per scope_guard being a for loop I added the extra space. Our
coding style does;

	if (cond) { }

	while (cond) { }

	for (;;) { }

etc.. so I too did:

	scoped_guard (name, args...) { }

> Then, "guard" does not get a space (but it is funny syntax
> anyway, with the double set of parentheses ;-).  The template in
> include/linux/cleanup.h doesn't match actual usage as it lacks the
> second set of parentheses:
> 
>     guard(name):
> 
> Peter: care to comment?
> Or do you have a different bikeshed to paint today? ;-)

For guard I read the first pair as if it were a C++ template, that is, I
pretend, it is actually written like:

	guard<name>(args..);

Both are 'odd' in numerous ways and inconsistent vs where the 'args...'
go, but alas, we're trying to wrangle this inside the constraints
imposed upon us by C and CPP our dear pre-processor.



