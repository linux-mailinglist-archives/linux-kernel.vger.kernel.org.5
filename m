Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53D7C8825
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjJMO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJMO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:58:34 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68D95;
        Fri, 13 Oct 2023 07:58:32 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8D93A1000C4; Fri, 13 Oct 2023 15:58:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697209110; bh=1WNpZCcvkShVfOmoZ1FtkNn5Y5oSEIRDiZYxsfcBt/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G10jsopKsKYCgKCiyQthEgGH54hFDWr5Q5RLcir9PVaDE7NOSoHx4FBmloL3nGwy5
         NKyDncoxuFMMPyn2BfFHBiHFyng7pVG+ya4mRky75SmUFlznpoKznyUhc4zhm9YHNQ
         /CvBnQXxK6srhJLUyj13EUm9CdyfrJ0bnsDeKHZ6qj3SSQDekNpL5rcFxRPkqHHpCr
         PLQF95mHK66Zm6zMn/gKl/nu8svw8kFRGujcV9A34R1J80Z4d0PRiliX3xeK4bVxL4
         NxXsr7z7OZ2gLundHYyTQy0iyibFWpy0yQ3sTopVU1XpIxMTWs//geZSR4kPp5o5QT
         Wj8tay2uNQ7nA==
Date:   Fri, 13 Oct 2023 15:58:30 +0100
From:   Sean Young <sean@mess.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZSlbFukZKGNpR5PM@gofer.mess.org>
References: <cover.1697193646.git.sean@mess.org>
 <9c0f1616fca5b218336b9321bfefe7abb7e1749f.1697193646.git.sean@mess.org>
 <ZSkvTKr42sUZImiM@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkvTKr42sUZImiM@orome.fritz.box>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:51:40PM +0200, Thierry Reding wrote:
> On Fri, Oct 13, 2023 at 11:46:14AM +0100, Sean Young wrote:
> [...]
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index d2f9f690a9c1..93f166ab03c1 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -267,6 +267,7 @@ struct pwm_capture {
> >   * @get_state: get the current PWM state. This function is only
> >   *	       called once per PWM device when the PWM chip is
> >   *	       registered.
> > + * @atomic: can the driver execute pwm_apply_state in atomic context
> >   * @owner: helps prevent removal of modules exporting active PWMs
> >   */
> >  struct pwm_ops {
> > @@ -278,6 +279,7 @@ struct pwm_ops {
> >  		     const struct pwm_state *state);
> >  	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
> >  			 struct pwm_state *state);
> > +	bool atomic;
> >  	struct module *owner;
> >  };
> 
> As I mentioned earlier, this really belongs in struct pwm_chip rather
> than struct pwm_ops. I know that Uwe said this is unlikely to happen,
> and that may be true, but at the same time it's not like I'm asking
> much. Whether you put this in struct pwm_ops or struct pwm_chip is
> about the same amount of code, and putting it into pwm_chip is much
> more flexible, so it's really a no-brainer.

Happy to change this of course. I changed it and then changed it back after
Uwe's comment, I'll fix this in the next version.

One tiny advantage is that pwm_ops is static const while pwm_chip is
allocated per-pwm, so will need instructions for setting the value. Having
said that, the difference is tiny, it's a single bool.


Sean
