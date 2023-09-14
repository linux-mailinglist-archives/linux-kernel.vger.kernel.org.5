Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F87A1134
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjINWlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjINWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:41:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C4F1FD6;
        Thu, 14 Sep 2023 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sY6+WRs8v3ZXwrxEQ5TKWY1rAEmHsBMwUCCrGHWwa9w=; b=pBHD5ZtLHgQr7IWGRfTiPluwWh
        8YxeN9vCZe2WEx0WuI4YsQ+Z61IfVYtwFXfXz0ZgpUB+VDxYfxYDEy0DESWVU3gEC0CnDcYq/6kA1
        wq0E6ltyTzuCgAW64+LuGdtflA0tZz3m4dYFEZr03UnhQDIF38qk1P0V2ndHQLAWs7eV6JeC2iSEk
        kQR82HwPUrYvhV5waHJmkx9vZ2Jj89iPVe5TupdWX2/i1mdydO1+0EedVq5sAOMnPRDeorteRt0To
        Lp5pLNvQdI94pQ4NnACdQEQVv9FSbjfCGoti6T7/dwJjU2Xz094LgfWbvUAWH1Pm2XI0pdH700lBE
        548fZf8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgv1J-008EpV-2d;
        Thu, 14 Sep 2023 22:41:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E781D30036C; Fri, 15 Sep 2023 00:41:10 +0200 (CEST)
Date:   Fri, 15 Sep 2023 00:41:10 +0200
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
Message-ID: <20230914224110.GA24799@noisy.programming.kicks-ass.net>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
 <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org>
 <CAMRc=Merdmv_gFm58y1iHWmYmT=t_OmXyQgOXCxqwr7wsmjjYQ@mail.gmail.com>
 <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
 <CAMJwLczd7oZ3JPqKNW-qOiB0S2WRsqV7TVFWGD=yysK0nmZrSQ@mail.gmail.com>
 <20230914222639.GB5492@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914222639.GB5492@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:26:39AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 14, 2023 at 01:51:01PM -0700, Mitchell Levy wrote:
> 
> > The more I think on this issue, the more I go back and forth. If we
> > only had guard(...), the only way to approximate scoped guard would be
> > to either just do what the macro does (i.e., a dummy for loop that
> > only runs once) or use an anonymous scope, e.g.,
> > {
> >     guard(...);
> >     my_one_statement();
> > }
> > Since this is how I've previously used std::lock_guard in C++, this
> > pattern feels very familiar to me, and the scoped_guard feels almost
> > like syntax sugar for this. As such, I feel like including the braces
> > is most natural because, as Geert mentioned, it emphasizes the scope
> > that "should" (in my brain, at least) be there.
> 
> AFAIC the anonymous scope thing doesn't much happen in kernel coding
> style -- although I'm sure it's there, the code-base is simply too vast
> to not have it *somewhere*.

The kernel typical style would be:

	do {
		...
	} while (0)

to create a 'pointless' scope. Apparently this is also what I've done in
some conversions where a conditional lock was involved.
