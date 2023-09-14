Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2995A7A10ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjINW0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjINW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:26:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D92100;
        Thu, 14 Sep 2023 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=99CoAk6bYO3uLykrYLqeLZWPc7fH2O4OIlb/qs5LN0w=; b=W3ysK2sCveuzQOn2GvJTUkCc8N
        /6w0USoXiyz1aI+i9sUX/pMdtfJRQsuwWWVqTmf4cNpt/BudNOSjd70CgzNFrn8BCsY6uLRkFZXhr
        DN8k66B2IoGhEIUxOAIUctv3e8W83wyAi3yxOvwnxdsM4HZqwFOBpzQSR8e4W+iq6kjXbwi1YGVFg
        JIjlJr8UPm9l9xL2mDIpH0KdJKc9dldiDioMlkgxQlGicjB+B9rItXtgCSPLWkxBmY7DJqwWhkELK
        rcqpLqqtJdRiO9lUfeco67BasE0I3lTznE9Z0+LKa2H3yQwKgjAS3ZN/Dz2DGOFmcjhZNMc/XDaay
        lch2Z5dw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgunG-008DLP-0u;
        Thu, 14 Sep 2023 22:26:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 663FB30036C; Fri, 15 Sep 2023 00:26:39 +0200 (CEST)
Date:   Fri, 15 Sep 2023 00:26:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mitchell Levy <levymitchell0@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: guard coding style (was: Re: [PATCH v1 05/10] gpio: pca953x:
 Simplify code with cleanup helpers)
Message-ID: <20230914222639.GB5492@noisy.programming.kicks-ass.net>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
 <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org>
 <CAMRc=Merdmv_gFm58y1iHWmYmT=t_OmXyQgOXCxqwr7wsmjjYQ@mail.gmail.com>
 <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
 <CAMJwLczd7oZ3JPqKNW-qOiB0S2WRsqV7TVFWGD=yysK0nmZrSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJwLczd7oZ3JPqKNW-qOiB0S2WRsqV7TVFWGD=yysK0nmZrSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:51:01PM -0700, Mitchell Levy wrote:

> The more I think on this issue, the more I go back and forth. If we
> only had guard(...), the only way to approximate scoped guard would be
> to either just do what the macro does (i.e., a dummy for loop that
> only runs once) or use an anonymous scope, e.g.,
> {
>     guard(...);
>     my_one_statement();
> }
> Since this is how I've previously used std::lock_guard in C++, this
> pattern feels very familiar to me, and the scoped_guard feels almost
> like syntax sugar for this. As such, I feel like including the braces
> is most natural because, as Geert mentioned, it emphasizes the scope
> that "should" (in my brain, at least) be there.

AFAIC the anonymous scope thing doesn't much happen in kernel coding
style -- although I'm sure it's there, the code-base is simply too vast
to not have it *somewhere*.

