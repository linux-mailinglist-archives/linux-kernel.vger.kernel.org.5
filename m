Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1D7A10FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjINWab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:30:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE1026B7;
        Thu, 14 Sep 2023 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mE3JHIhCLP538vF70ApFyIxbj6/Ip+yfsU0HW7Q8ym0=; b=gI4E7ch3g1U549Ro0Oc9WWvqBo
        T+/9TjEGJIBe1n6qnhLWqqgGt7lTeRzzUyvCk5Lchww5EJSi53/MDYaY+4ljE99oyea6qKyng+pNW
        PRoqoON2DIMhRkyNtEEoE5BYYgbWr3B+JHNDRXMb41kWMQmwLmFYbZTRMNuhwsWK6yXUZJvDrVBkq
        sslFIFI0GpZeCu/7R7HzZHBl/yqkuQ2Cwz4oYAW4QBH7mgYKUkHehgmoqh/X3/gvxBoFl2LnLY7n8
        yUKaWKmVc7f2EDY2nEALf+U9M9cOoMv5fyFxNhobmMg+1SX06aEFCB/n9Qny52I4yfEB/89eTLBFh
        6My42hlg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qguqm-008ENg-2g;
        Thu, 14 Sep 2023 22:30:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA31630008D; Fri, 15 Sep 2023 00:30:17 +0200 (CEST)
Date:   Fri, 15 Sep 2023 00:30:17 +0200
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
Message-ID: <20230914223017.GC5492@noisy.programming.kicks-ass.net>
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

> > > > +     scoped_guard(mutex, &chip->i2c_lock)
> > > > +             ret = regmap_read(chip->regmap, inreg, &reg_val);
> > >
> > > I can't say I'm thrilled about the lack of curly braces.  I was also
> > > surprised to discover that checkpatch nor gcc W=1 complain about the
> > > indentation change.

So in my kernel/events/core.c changes (that I still need to re-post and
aren't yet upstream) I have found a single instance where I've done the
same lack of curlies:

	scoped_guard (rcu)
		pmu = idr_find(&pmu_idr, type);

clearly self-consistency mandates I should not object to this style.

That said, I see the argument for having them, they do more clearly
demarcate the scope.

As with everything, small variations in style are bound to happen from
one maintainer to another... (or one self to itself over time).
