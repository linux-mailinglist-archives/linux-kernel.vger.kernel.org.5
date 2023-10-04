Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA67B8292
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbjJDOmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbjJDOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:42:11 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E993C1;
        Wed,  4 Oct 2023 07:42:07 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 4CE17100092; Wed,  4 Oct 2023 15:42:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696430525; bh=Fa78l7qohJHkl5Gw25F2o3ZIf+b/JdBvbj8O9ydf7rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3TwoBRUOdAHj5cmBTelMsfPgYqzxQrEeL1W2Qpug1KgC5dL//JYVI9eEwNU136//
         ng2ABitSd5qrvWK9S3NTrt0wBBuD293PgVjLX0K5EBBQoGA9ygGfCQDLRrCO6njLDh
         ByIfh+4k5Dy749UkkCNoQwwBBnO0MqzQdTxo6MMYtOkZf4OikisclIz2Sg1VCJkH9g
         ObfUjV8SXX7t9j98FiYmTYZwmjC/Rn+G67j8wi8xVdfcgo0YJn/zJIDLSmWQ/fexok
         hQV1yZjpJbFIEBOmK14Zzav0Ts9OUjzAfv6MjneQKHjw+fNt27WIieHKDdmcyZNhdX
         8j/ZcISlS3zTw==
Date:   Wed, 4 Oct 2023 15:42:05 +0100
From:   Sean Young <sean@mess.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <ZR15vc0chl/gMDgV@gofer.mess.org>
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
 <1647d018-cb4e-7c4a-c80f-c726b1ea3628@gmail.com>
 <ZR0bqBbvM+hHOPXX@gofer.mess.org>
 <1c96b6f1-bb88-0027-a7a0-ec85768c6b90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c96b6f1-bb88-0027-a7a0-ec85768c6b90@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:54:32PM +0300, Ivaylo Dimitrov wrote:
> On 4.10.23 г. 11:00 ч., Sean Young wrote:
> > On Mon, Oct 02, 2023 at 09:16:53AM +0300, Ivaylo Dimitrov wrote:
> > > On 1.10.23 г. 13:40 ч., Sean Young wrote:
> > > > The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> > > > from delays as this is done in process context. Make this work in atomic
> > > > context.
> > > > 
> > > > This makes the driver much more precise.
> > > > 
> > > > Signed-off-by: Sean Young <sean@mess.org>
> > > > Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> > > > ---
> > > >    drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++--------
> > > >    1 file changed, 63 insertions(+), 16 deletions(-)
> > > > 
> > > 
> > > what about the following patch(not a proper one, just RFC)? It achieves the
> > > same (if not better) precision (on n900 at least) without using atomic pwm.
> > > What it does is: create a fifo thread in which we swicth pwm on/off, start
> > > hrtimer that is used to signal thread when to switch pwm.
> > > As signal comes earlier than needed(because hrtimer runs async to the
> > > thread), we do a busy loop wait for the precise time to switch the pwm. At
> > > least on n900, this busy loop is less than 200 us per switch(worst case,
> > > usually it is less than 100 us). That way, even if we have some latency
> > > spike, it is covered by not doing busy loop for that particular pwm switch
> > > and we keep the precise timing.
> > 
> > I think this is a good idea.
> > 
> > > Maybe we shall merge both patches so fifo thread to be used for sleeping
> > > pwms and hrtimer for atomic. I can do that and test it here if you think
> > > that approach makes sense.
> > 
> > Let's try and merge this patch for the next merge window, and worry about
> > the atomic version after that. We've already queued the ir-rx51 removal
> > patches to media_stage so it would be nice to have to revert these patches,
> > and improve pwm-ir-tx for the next kernel release.
> > 
> 
> ir-rx51 is broken without
> https://www.spinics.net/lists/kernel/msg4953300.html, it is also missing a
> call to init_waitqueue_head() in the probe() function. So I have no strong
> opinion on what shall be done with it.

Sure, ok. I guess the pwm-ir-tx driver is less broken in that regard.

In that case I propose we merge the ir-rx51 for the next merge window,
and further fixes to pwm-ir-tx go in when they're ready.

> > This means the thread is always around. How about creating the thread
> > per-tx?
> > 
> 
> Yes, that can be done, just not sure what the overhead would be.
> 
> Also, I think we shall reconsider the way the driver works:
> 
> Imagine we have to pretend we are TV remote that supports NEC protocol (for
> example), especially the "REPEAT CODES" part. Currently, no matter what we
> do, there is no way to get the timings even remotely right, as we have no
> idea what the "warmup" and "complete" delays are. Like, starting thread (if
> needed), hrtimer setup time, completions waiting, contexts switching, etc.

It's not perfect, but the assumption is that those times are going to be
the same or very similar for each tx. So, if the setup/warmup time is the same
and if there is no complete delay, then using usleep() between two txs 
works fine. I think in reality the setup/complete times are extremely
short (time to send usb packet or so), and compared to IR timings this is
insignificant.

Having said that, maybe a different scheme would be nice, which could offer
better precision.
 
> So, I think the correct thing to do is to copy txbuf (as a list of txbufs)
> into pwm_ir in tx function, start pulses generation and return from
> pwm_ir_tx() *immediately*, without waiting for tx to finish. If userspace
> requests submission of another set of pulses while we are still sending the
> current one, well, we accept it, add it to the list and delay the sending
> until the current one is finished. When there is nothing more to send (the
> list is empty), stop the hrtimer (and perhaps the thread)
> 
> I think that way userspace will be able to append as many "repeat" pulses
> with proper timings as it wants (with some sane limits ofc).
> 
> Unless we somehow have API restriction that we shall not return until tx is
> finished.
> 
> Does that make any sense to you?

Two problems:

It's a breaking uapi change: for example lircd and ir-ctl use this for 
calculating the gap between transmits. If we start returning early then
things break.

Secondly, not all drivers can support this, or they would need to support
it using a thread or so, which makes the driver code much more complicated
and we'd have to change nearly every driver.


Sean
