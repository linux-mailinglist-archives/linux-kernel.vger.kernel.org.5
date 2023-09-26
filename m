Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F97AF4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjIZUSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjIZUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:18:29 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5698120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:18:22 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id E979E1000B2; Tue, 26 Sep 2023 21:18:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1695759496; bh=T2t6tUV8F3RVHU1NTNGqT5xpfoZaTbVdG1BjZ0eXs5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPjwXYcjtXvLSniQ86lo5+xTlypyv4zAqmj+uztkYev+AEyI6GDQFsBV4FpN+6E9h
         dYIJ33tUeCJWG/DXqk1vajUIKdUTys4INNIVAMcykCeiHPxsGoNBTd1DEDjpfeImKh
         1LWROf7Sk2j4Bdh0rGx/9jg3KZrLqEZCbSlrRZ6MUW4vcsOtC95Ktwlqg5qfCwis/H
         Ve2d/qmWEd3JXm0YmYkd/vyn7t2Dy5wvGeIlw0ed1daTMe19aBbCJNNwYgKWQASKog
         J7ytGkPbUAuDR1XLprXZ1wzig+zhfz2EoEq/qWwvqviy4zYAV2qxfBTtxfaX4s96Ja
         Tzk/e6bII+G5w==
Date:   Tue, 26 Sep 2023 21:18:16 +0100
From:   Sean Young <sean@mess.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     linux-media@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
Message-ID: <ZRM8iLORjKw3z/h5@gofer.mess.org>
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
 <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
 <ZRKFUb1vRtn82bgn@gofer.mess.org>
 <1715e2bf-5d02-4f20-1476-29a1fdf350b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1715e2bf-5d02-4f20-1476-29a1fdf350b1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 03:43:18PM +0300, Ivaylo Dimitrov wrote:
> On 26.09.23 г. 10:16 ч., Sean Young wrote:
> > On Mon, Sep 25, 2023 at 07:06:44PM +0300, Ivaylo Dimitrov wrote:
> > > On 1.09.23 г. 17:18 ч., Sean Young wrote:
> > > > The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
> > > > handled entirely by the generic pwm-ir-tx driver, and in fact the
> > > > pwm-ir-tx driver has been compatible with ir-rx51 from the start.
> > > > 
> > > 
> > > Unfortunately, pwm-ir-tx does not work on n900. My investigation shows that
> > > for some reason usleep_range() sleeps for at least 300-400 us more than what
> > > interval it is requested to sleep. I played with cyclictest from rt-tests
> > > package and it gives similar results - increasing the priority helps, but I
> > > was not able to make it sleep for less that 300 us in average. I tried
> > > cpu_latency_qos_add_request() in pwm-ir-tx, but it made no difference.
> > > 
> > > I get similar results on motorola droid4 (OMAP4), albeit there average sleep
> > > is in 200-300 us range, which makes me believe that either OMAPs have issues
> > > with hrtimers or the config we use has some issue which leads to scheduler
> > > latency. Or, something else...
> > 
> > The pwm-ir-tx driver does suffer from this problem, but I was under the
> > impression that the ir-rx51 has the same problem.
> > 
> 
> Could you elaborate on the "pwm-ir-tx driver does suffer from this problem"?
> Where do you see that?

So on a raspberry pi (model 3b), if I use the pwm-ir-tx driver, I get random
delays of up to 100us. It's a bit random and certainly depends on the load.

I'm measuring using a logic analyzer.

There have been reports by others on different machines with random delays
and/or transmit failures (as in the receiver occassionally fails to decode
the IR). I usually suggest they use the gpio-ir-tx driver, which does work
as far as I know (the signal looks perfect with a logic analyzer).

So far I've taken the view that the driver works ok for most situations,
since IR is usually fine with upto 100us missing here or there.

The gpio-ir-tx driver works much better because it does the entire send 
under spinlock - obviously that has its own problems, because an IR transmit
can be 10s or even 100s of milliseconds.

I've never known of a solution to the pwm-ir-tx driver. If using hrtimers
directly improves the situation even a bit, then that would be great.

> ir-rx51 does not suffer from the same problem (albeit it has its own one,
> see bellow)
> 
> > > In either case help is appreciated to dig further trying to find the reason
> > > for such a big delay.
> > 
> > pwm-ir-tx uses usleep_range() and ir-rx51 uses hrtimers. I thought that
> > usleep_range() uses hrtimers; however if you're not seeing the same delay
> > on ir-rx51 then maybe it's time to switch pwm-ir-tx to hrtimers.
> > 
> 
> usleep_range() is backed by hrtimers already, however the difference comes
> from how hrtimer is used in ir-rx51: it uses timer callback function that
> gets called in softirq context, while usleep_range() puts the task in
> TASK_UNINTERRUPTIBLE state and then calls schedule_hrtimeout_range(). For
> some reason it takes at least 200-400 us (on average) even on OMAP4 to
> switch back to TASK_RUNNING state.
> 
> The issue with ir-rx51 and the way it uses hrtimers is that it calls
> pwm_apply_state() from hrtimer function, which is not ok, per the comment
> here
> https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/pwm/core.c#L502
> 
> I can make pwm-ir-tx switch to hrtimers, that's not an issue, but I am
> afraid that there is some general scheduler or timers (or something else)
> issue that manifests itself with usleep_range() misbehaving.

If we can switch pwm-ir-tx to hrtimers, that would be great.

The ir-rx51 removal patches have already been queued to media_staging;
we may have to remove them from there if we can't solve this problem.

> > I don't have a n900 to test on, unfortunately.
> > 
> 
> I have and once I have an idea what's going on will port pwm-ir-tx to
> hrtimers, if needed. Don't want to do it now as I am afraid the completion I
> will have to use will have the same latency problems as usleep_range()

That would be fantastic. Please do keep us up to date with how you are
getting on. Like I said, it would be nice to this resolved before the next
merge window.

Thanks,
Sean
