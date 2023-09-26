Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068FA7AE694
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjIZHQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:16:43 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8346EB;
        Tue, 26 Sep 2023 00:16:35 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 199A01000B2; Tue, 26 Sep 2023 08:16:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1695712593; bh=q3yvy6U1pA8dk2yNpmmm8FMMggMlyRZgCfRP5FNv19Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJmlZqE1mqfatxA0PE4r+/oQknTKqr1XLSSa10ptK0XHsrdV0UNQYmpZkI7zW9xk1
         N+uxyzsCksaEg+QmhFzV6t2U34i2uqaWG4ddy/3dMkVzLcdjfj8M30p5akR88s4IJc
         yYgvwDnBzd3fr0pY9c3GUpTGEZ/4j0q8zpkCDihmMcu/yF+fm6NmazdnePcEHJ9ara
         6cdzW91KVfnb8tb+D53nSU55qIlPc6i0i+Y7slYYak7h8w6zP7DaErg4Y8y1qnYqvu
         WUZUhN5cyD4kJEaHcFrVVi7lghq74mvMGJkhnZCNzk+s7lao9hRj2FLykvjj4Gad00
         RbSynYpBokk4Q==
Date:   Tue, 26 Sep 2023 08:16:33 +0100
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
Message-ID: <ZRKFUb1vRtn82bgn@gofer.mess.org>
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
 <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 07:06:44PM +0300, Ivaylo Dimitrov wrote:
> On 1.09.23 г. 17:18 ч., Sean Young wrote:
> > The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
> > handled entirely by the generic pwm-ir-tx driver, and in fact the
> > pwm-ir-tx driver has been compatible with ir-rx51 from the start.
> > 
> 
> Unfortunately, pwm-ir-tx does not work on n900. My investigation shows that
> for some reason usleep_range() sleeps for at least 300-400 us more than what
> interval it is requested to sleep. I played with cyclictest from rt-tests
> package and it gives similar results - increasing the priority helps, but I
> was not able to make it sleep for less that 300 us in average. I tried
> cpu_latency_qos_add_request() in pwm-ir-tx, but it made no difference.
> 
> I get similar results on motorola droid4 (OMAP4), albeit there average sleep
> is in 200-300 us range, which makes me believe that either OMAPs have issues
> with hrtimers or the config we use has some issue which leads to scheduler
> latency. Or, something else...

The pwm-ir-tx driver does suffer from this problem, but I was under the
impression that the ir-rx51 has the same problem.

> In either case help is appreciated to dig further trying to find the reason
> for such a big delay.

pwm-ir-tx uses usleep_range() and ir-rx51 uses hrtimers. I thought that
usleep_range() uses hrtimers; however if you're not seeing the same delay
on ir-rx51 then maybe it's time to switch pwm-ir-tx to hrtimers.

I don't have a n900 to test on, unfortunately.

Thanks
Sean
