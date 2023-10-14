Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7B7C937A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjJNIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:31:51 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129FBB;
        Sat, 14 Oct 2023 01:31:49 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id C3E3F1000C4; Sat, 14 Oct 2023 09:31:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697272307; bh=XsNGeilpUplKizUnx/qOZo3xjouGfDpjsPn9CRnokek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijIzx2jp1WzMQE8iElh52WDBYVSbJDBeO1DyETXybgvzCjWPMwTQS+kVSG6n01uIC
         JregG6Q8mt6N3OHGp5WlfhmpQ5mweHFRlpXKZOAUCjCfsMEMYxzZtdc6sByDkXo711
         hw5OlA+64xysXPTSEPrvog3wnoYHQduGR2IdTxb+bQcqkyc3fIPqBvL9DGii1Qh38f
         6slXu0E8lJAkO2BkUYb2b3lFSZeedXhzPIVlHT6FRuNrYgDqk9Veuh+87MDNB6Ha5e
         BkW1ctXpq4VRFh4IC/R9ZRg3dJNT9skMTn8XXbNnY5/M4edMabuCoutNWzQ6k6x4CL
         Yu3FZ/rbjCuuw==
Date:   Sat, 14 Oct 2023 09:31:47 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZSpR8+vTxTi0/nQK@gofer.mess.org>
References: <cover.1697193646.git.sean@mess.org>
 <9c0f1616fca5b218336b9321bfefe7abb7e1749f.1697193646.git.sean@mess.org>
 <ZSkvTKr42sUZImiM@orome.fritz.box>
 <ZSlbFukZKGNpR5PM@gofer.mess.org>
 <ZSljioc2OfPfxVeB@orome.fritz.box>
 <20231013180449.mcdmklbsz2rlymzz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013180449.mcdmklbsz2rlymzz@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 13, 2023 at 08:04:49PM +0200, Uwe Kleine-König wrote:
> On Fri, Oct 13, 2023 at 05:34:34PM +0200, Thierry Reding wrote:
> > On Fri, Oct 13, 2023 at 03:58:30PM +0100, Sean Young wrote:
> > > On Fri, Oct 13, 2023 at 01:51:40PM +0200, Thierry Reding wrote:
> > > > On Fri, Oct 13, 2023 at 11:46:14AM +0100, Sean Young wrote:
> > > > [...]
> > > > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > > > index d2f9f690a9c1..93f166ab03c1 100644
> > > > > --- a/include/linux/pwm.h
> > > > > +++ b/include/linux/pwm.h
> > > > > @@ -267,6 +267,7 @@ struct pwm_capture {
> > > > >   * @get_state: get the current PWM state. This function is only
> > > > >   *	       called once per PWM device when the PWM chip is
> > > > >   *	       registered.
> > > > > + * @atomic: can the driver execute pwm_apply_state in atomic context
> > > > >   * @owner: helps prevent removal of modules exporting active PWMs
> > > > >   */
> > > > >  struct pwm_ops {
> > > > > @@ -278,6 +279,7 @@ struct pwm_ops {
> > > > >  		     const struct pwm_state *state);
> > > > >  	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > >  			 struct pwm_state *state);
> > > > > +	bool atomic;
> > > > >  	struct module *owner;
> > > > >  };
> > > > 
> > > > As I mentioned earlier, this really belongs in struct pwm_chip rather
> > > > than struct pwm_ops. I know that Uwe said this is unlikely to happen,
> > > > and that may be true, but at the same time it's not like I'm asking
> > > > much. Whether you put this in struct pwm_ops or struct pwm_chip is
> > > > about the same amount of code, and putting it into pwm_chip is much
> > > > more flexible, so it's really a no-brainer.
> > > 
> > > Happy to change this of course. I changed it and then changed it back after
> > > Uwe's comment, I'll fix this in the next version.
> > > 
> > > One tiny advantage is that pwm_ops is static const while pwm_chip is
> > > allocated per-pwm, so will need instructions for setting the value. Having
> > > said that, the difference is tiny, it's a single bool.
> > 
> > Yeah, it's typically a single assignment, so from a code point of view
> > it should be pretty much the same. I suppose from an instruction level
> > point of view, yes, this might add a teeny-tiny bit of overhead.
> > 
> > On the other hand it lets us do interesting things like initialize
> > chip->atomic = !regmap_might_sleep() for those drivers that use regmap
> > and then not worry about it any longer.

Sure.

> > Given that, I'm also wondering if we should try to keep the terminology
> > a bit more consistent. "Atomic" is somewhat overloaded because ->apply()
> > and ->get_state() are part of the "atomic" PWM API (in the sense that
> > applying changes are done as a single, atomic operation, rather than in
> > the sense of "non-sleeping" operation).

Good point.

> > So pwm_apply_state_atomic() is then doubly atomic, which is a bit weird.
> > On the other hand it's a bit tedious to convert all existing users to
> > pwm_apply_state_might_sleep().
> > 
> > Perhaps as a compromise we can add pwm_apply_state_might_sleep() and
> > make pwm_apply_state() a (deprecated) alias for that, so that existing
> > drivers can be converted one by one.
> 
> To throw in my green for our bike shed: I'd pick
> 
> 	pwm_apply_state_cansleep()
> 
> to match what gpio does (with gpiod_set_value_cansleep()). (Though I
> have to admit that semantically Thierry's might_sleep is nicer as it
> matches might_sleep().)

I have to agree here. "can" is shorter and clearer than "might", since
"can" expresses capability. Having said that the mixture of nomenclature is
not great, so there is very little between them.

> If we don't want to have an explicit indicator for the atomic/fast
> variant (again similar to the gpio framework), maybe we can drop
> "_state" which I think is somehow redundant and go for:
> 
> 	pwm_apply (fast)
> 	pwm_apply_cansleep (sleeping)
> 	pwm_apply_state (compat alias for pwm_apply_cansleep())
> 
> (maybe replace cansleep with might_sleep).

This is very nice. :) There are callsites in 15 files, might as well rename
it and do away with pwm_apply_state()

> Similar for pwm_get_state()
> we could use the opportunity and make
> 
> 	pwm_get()
> 
> actually call ->get_state() and introduce
> 
> 	pwm_get_lastapplied()
> 
> with the semantic of todays pwm_get_state(). Do we need a
> pwm_get_cansleep/might_sleep()?

Not all drivers implement .get_state(), how would we handle those?


Thanks,

Sean
