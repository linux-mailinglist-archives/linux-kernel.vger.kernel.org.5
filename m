Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DDC77CFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbjHOPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbjHOPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:53:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999B310DC;
        Tue, 15 Aug 2023 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ECHZrurJON4WZoiSdgmS3Hhl01hn78x2bdMjyrbyfdA=; b=iLTAuNY1SNaHtDDTg8HunkYTTX
        b8vj9K41Q8xK/LIg31roE1GKQbthOc6vzkgEqOiHNGPEvl8iUIQ6YzcMkSL5y96cMJca+8kuBIlZ9
        jvTFEa07IpoXll/Lpeib6GJlOhOlsP/0QDfKnlmBoXm1ntjyWV6Tq3oWRYJ40VbyhQu3gwikVxJSB
        7lyIq7HhECIu34DE29tAY7MkFfGEssbkonPtIT8zV45Tcs7TI6RIBz0cjTCHYQddZtOTsAJ2TSALL
        7WmnVe1nNlRTg0DUHjUb68DO+gex6vPfl8L8wUmfPKtjpmbx/3iGoaDqkMjgOtd6WRqCpCBIXJY/M
        VuH9z1TQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVwLm-00Bw7l-1d;
        Tue, 15 Aug 2023 15:52:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 201A9300137;
        Tue, 15 Aug 2023 17:52:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFDEF203BFBFB; Tue, 15 Aug 2023 17:52:53 +0200 (CEST)
Date:   Tue, 15 Aug 2023 17:52:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <20230815155253.GK212435@hirez.programming.kicks-ass.net>
References: <20230809131442.25524-1-brgl@bgdev.pl>
 <20230809131442.25524-2-brgl@bgdev.pl>
 <CACRpkdavsv3nJnhtdqW8ANAVfxbgHdM-SpcfOv4p_t-7EOaOHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdavsv3nJnhtdqW8ANAVfxbgHdM-SpcfOv4p_t-7EOaOHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:04:32AM +0200, Linus Walleij wrote:
> On Wed, Aug 9, 2023 at 3:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use macros defined in linux/cleanup.h to automate resource lifetime
> > control in the gpio-simulator.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> (...)
> > -       mutex_lock(&chip->lock);
> > +       guard(mutex)(&chip->lock);
> (...)
> > -       mutex_lock(&chip->lock);
> > -       ret = !!test_bit(offset, chip->value_map);
> > -       mutex_unlock(&chip->lock);
> > +       scoped_guard(mutex, &chip->lock)
> > +               ret = !!test_bit(offset, chip->value_map);
> 
> This is really neat. When I grep:ed around in linux-next this seemed like
> the first user of the scoped guards, so maybe Peter Z want to take a look?

Looks about right.

> I bet there is other code using it coming for this next merge window as
> well, but this is really the first that will land in linux-next as it seems.

There's more people starting to use it indeed.

There should be some in tip/sched/core as well. I have more pending, but
got side-tracked a bit with other things :/


