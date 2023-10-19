Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13D67CFDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbjJSPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346331AbjJSPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:34:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D2196
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:34:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E52C433CA;
        Thu, 19 Oct 2023 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697729644;
        bh=654sFT0xu88VFa1zlsXNRsh5wpWB9hJtkm4F9iJpGLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKBv64mQqGUlIugdH0YHyshgZ0xHaRCy71gNR6R+5GcbnFhfeu8+iqKJSALyxsuul
         PACcI+/OHGScAv4KHKJSeSsW3r580ZfHdzJ/eHC+iBo5UtNtd6FKLgxGtBlEB8QsZC
         onBb6pBoODe+hc4pHYHMB2tI4x9cHycuGJSC66Ps=
Date:   Thu, 19 Oct 2023 17:34:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <2023101925-kudos-playful-7c5a@gregkh>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
 <2023101823-unhidden-draw-d68c@gregkh>
 <20231018193855.GA32553@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018193855.GA32553@Negi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:38:56PM -0700, Soumya Negi wrote:
> Hi Greg,
> 
> On Wed, Oct 18, 2023 at 03:26:07PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 17, 2023 at 09:36:32PM -0700, Soumya Negi wrote:
> > > vme.c uses printk() to log messages. To improve and standardize message
> > > formatting, use logging mechanisms pr_err()/pr_warn() and
> > > dev_err()/dev_warn() instead. Retain the printk log levels of the
> > > messages during replacement.
> > > 
> > > Issue found by checkpatch.pl
> > > 
> > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > ---
> > >  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
> > >  1 file changed, 94 insertions(+), 81 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > index 6519a7c994a0..e8c2c1e77b7d 100644
> > > --- a/drivers/staging/vme_user/vme.c
> > > +++ b/drivers/staging/vme_user/vme.c
> > > @@ -9,6 +9,8 @@
> > >   * Copyright 2004 Motorola Inc.
> > >   */
> > >  
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > 
> > No, this is a driver, as others have pointed out, always use dev_*()
> > calls instead.
> 
> Some of the pr_ fns can be dev_, but I don't think all can.
> e.g. device NULL-check error messages

I would argue that those are pointless and can be removed and also the
check is probably not needed either.

> Also, there are portions of the driver where we have no access to
> any 'struct device' to feed into dev_.

Then you can fix that :)

thanks,

greg k-h
