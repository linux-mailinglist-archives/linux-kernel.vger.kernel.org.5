Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9A7C9BEA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjJOVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjJOVZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:25:10 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389AA1;
        Sun, 15 Oct 2023 14:25:08 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 7DEEE10006C; Sun, 15 Oct 2023 22:25:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697405106; bh=bEsPWlV0d3DdW9md1Bi6AvCyqdcvpm/SuqajVVIis+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hj4tjheVmnfxVhyB40FmH5NWLbFdlcIrn2T8zehCWhlaCBdb+1qAfgIfhv45qpU5E
         he6Lui8HAUtblU0BWLY1sl6tKbKYts9ma9ubHI+ubhW/Xwfaf4i9qokGv00TG+yV0e
         qkBDtGQSg+HehEdZsqdjbE8q8oLftMtAiCB+K9KQ/sqvY18LRqneZtnv9O/GivRZvH
         HDH/d2YTVmDYMrTpIdHsS87vj+X1Ovh+Rv4PAP5aXx0NizkphXb4Tqc7pcE9UDbRil
         eefjUHepOevTV87Plz83rHwU5J1W4Vlf7LUbIpFk8fG6lvJ9nV7x1Zya7vU3LLb+7V
         +L0YxHOatcRIw==
Date:   Sun, 15 Oct 2023 22:25:06 +0100
From:   Sean Young <sean@mess.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <ZSxYsg/ianhkUDvY@gofer.mess.org>
References: <cover.1697193646.git.sean@mess.org>
 <1560b474f7d426bc77100665c14c3a29c3af3e75.1697193646.git.sean@mess.org>
 <e47d4d33-4689-915d-3169-5c122075df05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e47d4d33-4689-915d-3169-5c122075df05@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 09:31:34AM +0300, Ivaylo Dimitrov wrote:
> On 13.10.23 г. 13:46 ч., Sean Young wrote:
> > This makes the driver much more precise.
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >   drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
> >   1 file changed, 76 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> > index c5f37c03af9c..3e801fa8ee2c 100644
> > --- a/drivers/media/rc/pwm-ir-tx.c
> > +++ b/drivers/media/rc/pwm-ir-tx.c
> > @@ -10,6 +10,8 @@
> >   #include <linux/slab.h>
> >   #include <linux/of.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/completion.h>
> >   #include <media/rc-core.h>
> >   #define DRIVER_NAME	"pwm-ir-tx"
> > @@ -17,8 +19,14 @@
> >   struct pwm_ir {
> >   	struct pwm_device *pwm;
> > -	unsigned int carrier;
> > -	unsigned int duty_cycle;
> > +	struct hrtimer timer;
> > +	struct completion completion;
> 
> what about 'struct completion tx_done'?

Agreed, that's much better.

> > +	struct pwm_state *state;
> > +	uint carrier;
> > +	uint duty_cycle;
> 
> With my c++ developer hat on, I think either 'u32' or 'unsigned int' is more
> proper type for carrier and duty_cycle. Both s_tx_duty_cycle and
> s_tx_carrier are declared with second parameter of type u32, maybe that's
> what have to be used all over the place if you are to change from 'unsigned
> int'. But better leave as it is, pwm_set_relative_duty_cycle() takes
> 'unsigned int' anyway.

I much prefer the rust way of u64/u32/u16/u8/usize and simply no int/short/long
types at all. int is useful when your compiler needs to work on weird
architectures with non-power-of-two register sizes like the pdp-9 (18 bits
anyone?), but on contemporary cpus there is really no need for int: int is
always a 32 bit value.

So I'm all for banishing int in every form, but for now the kernel uses
unsigned int and u32 interchangably, so it's hard to be consistent with this.

> > +	uint *txbuf;
> > +	uint txbuf_len;
> > +	uint txbuf_index;
> 
> OTOH, it is (*tx_ir)(struct rc_dev *dev, unsigned *txbuf, unsigned n), so
> maybe you should use 'unsigned' or 'unsigned int' for those.
> 
> I know at the end all those will be compiled to same type, but still :)

Maybe it's time for tx_ir to be defined with u32 types and do away with
this madness.

However, as it stands I agree with your points. I guess it's best to be
consistent with the apis this driver implements/uses.

Thanks,

Sean
