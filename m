Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC537F2B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjKULDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjKULCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:02:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EAD12A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:02:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FEAC433C7;
        Tue, 21 Nov 2023 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700564567;
        bh=D95mbRblCMWeYJLiRZDpTrg3IzqlzL2itexEnPpACs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHW3bXaQHQyogTErvaupup66ZDutgOZjpLD2uqavwDk8ZHtXfqn86ki3zOeL1Mqq0
         r9ymHCZ4rtxQDZN/mM0RfNtzIr4vl5wwsWHrF6/p+BV5G+Sf42lbpNGOnfT9Y67GK6
         6niJjqfYBlWpexF6j9sPu8RxdV2z3Ry1MH2lKwLy4x6vDwSjdhgIqAP4WccAfzAr+P
         /PgzETPBAAWSb1MI+67V58b5YV3vW9BvnyWerA0CPAtKK6LbWkNvDK0N2rs+4ZF3tf
         lN5nt74e6BDIRAZviDhOK73h+fJshfTkcOgb/BPFvb8s8p3CcaWdE2GG+ONvtPzr41
         AlNHFr4g/Dhiw==
Date:   Tue, 21 Nov 2023 11:02:42 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ryosuke Saito <ryosuke.saito@linaro.org>
Cc:     jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, masahisa.kojima@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: replace cpu_relax() with timeout handling
 for register checks
Message-ID: <20231121110242.GA269041@kernel.org>
References: <20231117081002.60107-1-ryosuke.saito@linaro.org>
 <20231119185337.GE186930@vergenet.net>
 <5027002.31r3eYUQgx@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5027002.31r3eYUQgx@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:19:48AM +0900, Ryosuke Saito wrote:
> [Resend again after removing an HTML format. Sorry for that.]
> 
> Hi Simon-san,
> 
> On Mon, Nov 20, 2023 at 3:53 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Nov 17, 2023 at 05:10:02PM +0900, Ryosuke Saito wrote:
> > > The cpu_relax() loops have the potential to hang if the specified
> > > register bits are not met on condition. The patch replaces it with
> > > usleep_range() and netsec_wait_while_busy() which includes timeout
> > > logic.
> > >
> > > Additionally, if the error condition is met during interrupting DMA
> > > transfer, there's no recovery mechanism available. In that case, any
> > > frames being sent or received will be discarded, which leads to
> > > potential frame loss as indicated in the comments.
> > >
> > > Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> > > ---
> > >  drivers/net/ethernet/socionext/netsec.c | 35 ++++++++++++++++---------
> > >  1 file changed, 23 insertions(+), 12 deletions(-)
> >
> > ...
> >
> > > @@ -1476,9 +1483,13 @@ static int netsec_reset_hardware(struct netsec_priv 
> *priv,
> > >       netsec_write(priv, NETSEC_REG_DMA_MH_CTRL, MH_CTRL__MODE_TRANS);
> > >       netsec_write(priv, NETSEC_REG_PKT_CTRL, value);
> > >
> > > -     while ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> > > -             NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0)
> > > -             cpu_relax();
> > > +     usleep_range(100000, 120000);
> > > +
> > > +     if ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> > > +                      NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
> > > +             dev_warn(priv->dev,
> > > +                      "%s: trans comp timeout.\n", __func__);
> > > +     }
> >
> > Hi Saito-san,
> >
> > could you add some colour to how the new code satisfies the
> > requirements of the hardware?  In particular, the use of
> > usleep_range(), and the values passed to it.
> 
> 
> For the h/w requirements, I followed U-Boot upstream:
> https://elixir.bootlin.com/u-boot/latest/source/drivers/net/sni_netsec.c
> 
> It has the same function as well, netsec_reset_hardware(), and the 
> corresponding potion is the following read-check loop:
> 
> 1012         value = 100;
> 1013         while ((netsec_read_reg(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) 
> &
> 1014                 NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
> 1015                 udelay(1000);
> 1016                 if (--value == 0) {
> 1017                         value = netsec_read_reg(priv, 
> NETSEC_REG_MODE_TRANS_COMP_STATUS);
> 1018                         pr_err("%s:%d timeout! val=%x\n", __func__, 
> __LINE__, value);
> 1019                         break;
> 1020                 }
> 1021         }
> 
> The maximum t/o = 1000us * 100 + read time

Hi Saito-san,

Thanks for the clarification.

I think that in lieu of more information about the hw, modeling the
code on a known working (or at least thought to be working) implementation
is good.

Reviewed-by: Simon Horman <horms@kernel.org>

