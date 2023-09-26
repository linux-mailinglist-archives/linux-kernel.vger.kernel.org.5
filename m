Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC66F7AE6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjIZHh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjIZHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:37:53 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDDC8DC;
        Tue, 26 Sep 2023 00:37:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2D61380A3;
        Tue, 26 Sep 2023 07:37:46 +0000 (UTC)
Date:   Tue, 26 Sep 2023 10:37:44 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Sean Young <sean@mess.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-media@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
Message-ID: <20230926073744.GA5285@atomide.com>
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
 <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
 <ZRKFUb1vRtn82bgn@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRKFUb1vRtn82bgn@gofer.mess.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sean Young <sean@mess.org> [230926 07:16]:
> On Mon, Sep 25, 2023 at 07:06:44PM +0300, Ivaylo Dimitrov wrote:
> > On 1.09.23 г. 17:18 ч., Sean Young wrote:
> > > The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
> > > handled entirely by the generic pwm-ir-tx driver, and in fact the
> > > pwm-ir-tx driver has been compatible with ir-rx51 from the start.
> > > 
> > 
> > Unfortunately, pwm-ir-tx does not work on n900. My investigation shows that
> > for some reason usleep_range() sleeps for at least 300-400 us more than what
> > interval it is requested to sleep. I played with cyclictest from rt-tests
> > package and it gives similar results - increasing the priority helps, but I
> > was not able to make it sleep for less that 300 us in average. I tried
> > cpu_latency_qos_add_request() in pwm-ir-tx, but it made no difference.
> > 
> > I get similar results on motorola droid4 (OMAP4), albeit there average sleep
> > is in 200-300 us range, which makes me believe that either OMAPs have issues
> > with hrtimers or the config we use has some issue which leads to scheduler
> > latency. Or, something else...
> 
> The pwm-ir-tx driver does suffer from this problem, but I was under the
> impression that the ir-rx51 has the same problem.
> 
> > In either case help is appreciated to dig further trying to find the reason
> > for such a big delay.
> 
> pwm-ir-tx uses usleep_range() and ir-rx51 uses hrtimers. I thought that
> usleep_range() uses hrtimers; however if you're not seeing the same delay
> on ir-rx51 then maybe it's time to switch pwm-ir-tx to hrtimers.

Maybe using fsleep() fixes this issue? See commit c6af13d33475 ("timer: add
fsleep for flexible sleeping"), and Documentation/timers/timers-howto.rst.

The long wake-up time for an idle state could explain the values. I think
Ivaylo already tested with most cpuidle states disabled via sysfs though.

> I don't have a n900 to test on, unfortunately.

If you want one for development, the maemo folks cc:ed here likely have
some available devices.

Regards,

Tony
