Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320777FD1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjK2JHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2JHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:07:36 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874A85;
        Wed, 29 Nov 2023 01:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1701248857; bh=MxUryVoPVuqc8qu9wP86kz9GHNHSIGe1UNdivmza+6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9c8t25hLZJsozRtTBaNhLoj/t99xeMdmAkcekGME2psqMNdAm4GTkYl70HG+PNre
         QVSy4PdC2FGq8SB0t2Qypdg7k3hDSSTFc8sPTIrP+ZD9X+y3MN20zQvY0WIeZoo3dR
         q/45oByqYGu9kkAdUrc36gEhASWcTT3gMIPWch+r82uIaf5t1XEdL3U9KdLnB9k4D1
         qwC0aPIWgcc7M2R2Em2i8U1P0UOhAdRx/ZfHygKqsmFC68hKE+97pjYWd2In9RjeO4
         cxm/v+W+bz3YX3uMlYqK5dM1lmiT86XEluXCSn+ATD31jjvxTrqdy+Lal8HDTMaell
         kI0+G7Hj4I1bA==
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 373ED100100; Wed, 29 Nov 2023 09:07:37 +0000 (GMT)
Date:   Wed, 29 Nov 2023 09:07:37 +0000
From:   Sean Young <sean@mess.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZWb_WR1T9HiQuiBs@gofer.mess.org>
References: <cover.1700323916.git.sean@mess.org>
 <ab49d3c11dd3fa432459cc8e11a77127f1a803dd.1700323916.git.sean@mess.org>
 <ZWCm8_S7epYQwZiG@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWCm8_S7epYQwZiG@orome.fritz.box>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 02:36:51PM +0100, Thierry Reding wrote:
> On Sat, Nov 18, 2023 at 04:16:18PM +0000, Sean Young wrote:
> [...]
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index c4b066f7c5097..495aba06c64c3 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -286,6 +286,7 @@ struct pwm_ops {
> >   * @npwm: number of PWMs controlled by this chip
> >   * @of_xlate: request a PWM device given a device tree PWM specifier
> >   * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
> > + * @atomic: can the driver execute pwm_apply_cansleep in atomic context
> 
> I'm a little reluctant to suggest that we rename this to might_sleep as
> well because it would require that we audit each and every driver to set
> this properly, since by default all devices have so far been defaulting
> to "might_sleep". But then again, I think that's something that we're
> going to need to do at some point anyway.
> 
> In the interim, I think we could keep it like this and address this as a
> follow-up.

Yes, I agree that the name atomic is not ideal. However, calling it
might_sleep means we have to touch every driver. That's not impossible,
but not ideal either.

For now, I'll leave it as is.


Sean
