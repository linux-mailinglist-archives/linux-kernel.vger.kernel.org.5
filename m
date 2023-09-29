Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B147B37CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjI2QUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2QUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:20:14 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEA7BE;
        Fri, 29 Sep 2023 09:20:11 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 6408D1000B2; Fri, 29 Sep 2023 17:20:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696004409; bh=NO7U8jxZgUpWr0WrNZxuq6hy5u2FsN8FVLFZSQC6DGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=io8J1gWqNgAp0oYQnqnXaZ0ODjPn8YiBFoeog8mMiW+afnyzuONlL0UGmD40NmA3x
         b5dbj86ikrbxYLBjtnLZlcGCLLbaUEOikPOO6geNK+t5IjAJ1l6hrDJ9rf0LjnANGr
         lCugOdBmh3Lj2GZdb2KblJRDuelBK7zEl/EOCmIQSCjuMUA8SFqDB50K9NJIEHtAGI
         7V/wHYWH7/7o08N66Hk/Tmo+A2nQny1HqHn4rYPPbwj9bhcliogFb8J8OdH1fspeOC
         YD2bpjXh0AGXNv4iwxaf92HcL7aiJ0I2FYvX28GRCQoGKc6EuXCeU0qxh+qsrjkUAB
         F3HxtdV4skF5w==
Date:   Fri, 29 Sep 2023 17:20:09 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     linux-media@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
Message-ID: <ZRb5OWvx3GxYWf9g@gofer.mess.org>
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
 <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
 <ZRKFUb1vRtn82bgn@gofer.mess.org>
 <1715e2bf-5d02-4f20-1476-29a1fdf350b1@gmail.com>
 <ZRM8iLORjKw3z/h5@gofer.mess.org>
 <179c4674-aa5c-0573-6d1f-ea6f2694d156@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179c4674-aa5c-0573-6d1f-ea6f2694d156@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

Just wanted to run an idea by you.

On Fri, Sep 29, 2023 at 11:49:52AM +0300, Ivaylo Dimitrov wrote:
> On 26.09.23 г. 23:18 ч., Sean Young wrote:
> > I've never known of a solution to the pwm-ir-tx driver. If using hrtimers
> > directly improves the situation even a bit, then that would be great.
> 
> The issue with hrtimers is that we cannot use them directly, as
> pwm_apply_state() may sleep, but hrtimer function is called in atomic
> context.

I've also been looking at this problem and came to same conclusion: the
fact that pwm_apply_state() sleeps is a huge problem.

1) The vast majority of pwm drivers don't sleep, or could even be converted
   to spinlocks (e.g pwm-sifive.c could use spinlocks, as far as I can see).

2) Sure, some pwm devices are on i2c busses, so the driver needs to sleep.
   Those devices aren't great for what we're trying to do here, since the
   sleeping may cause delays and affect the generated signal.

What would be ideal here is to have pwm-ir-tx work in atomic context if
a non-sleeping pwm device is used, and another (non-optimal) code path
for sleeping pwm drivers. We could even just refuse to run on sleeping pwm
drivers.

Uwe what do you think of this idea? The pwm api could have a
bool pwm_may_sleep(struct pwm *pwm) function, and pwm_apply_state() does 
not contain might_sleep() - only the driver-specific apply calls might_sleep().

It would be nice if this could all be done at compile time through e.g. a
device tree attribute.

Thanks,

Sean
