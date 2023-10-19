Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5E7D02A9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbjJSTmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjJSTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:42:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC9CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:42:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630A0C433C7;
        Thu, 19 Oct 2023 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697744549;
        bh=IcYvNkduo8XEK3Ilcyifr1Kit0TXp2+8yl9djUAt/+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kf7/OMEA7U8WtqYshNu2sZHSTr7BzhrPJPy7BRb3ZaLRlYcyZQtNNqGK4lA/KUxHv
         dHpW/xeJXjGSZDsru4+9+V6dadQyAYaSdwiGclvlRbP8KiNP/gTRXkD8KHZQDzWNFQ
         6YyWvhvAPIkKzB/qVdXR6iHEgfvaS0EL30wkIftE=
Date:   Thu, 19 Oct 2023 21:42:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <2023101941-poncho-disagree-8c77@gregkh>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
 <2023101823-unhidden-draw-d68c@gregkh>
 <20231018193855.GA32553@Negi>
 <2023101925-kudos-playful-7c5a@gregkh>
 <20231019190618.GA29750@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019190618.GA29750@Negi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:06:18PM -0700, Soumya Negi wrote:
> On Thu, Oct 19, 2023 at 05:34:01PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 18, 2023 at 12:38:56PM -0700, Soumya Negi wrote:
> > > Hi Greg,
> > > 
> > > On Wed, Oct 18, 2023 at 03:26:07PM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Oct 17, 2023 at 09:36:32PM -0700, Soumya Negi wrote:
> > > > > vme.c uses printk() to log messages. To improve and standardize message
> > > > > formatting, use logging mechanisms pr_err()/pr_warn() and
> > > > > dev_err()/dev_warn() instead. Retain the printk log levels of the
> > > > > messages during replacement.
> > > > > 
> > > > > Issue found by checkpatch.pl
> > > > > 
> > > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > > > ---
> > > > >  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
> > > > >  1 file changed, 94 insertions(+), 81 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > > > index 6519a7c994a0..e8c2c1e77b7d 100644
> > > > > --- a/drivers/staging/vme_user/vme.c
> > > > > +++ b/drivers/staging/vme_user/vme.c
> > > > > @@ -9,6 +9,8 @@
> > > > >   * Copyright 2004 Motorola Inc.
> > > > >   */
> > > > >  
> > > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > 
> > > > No, this is a driver, as others have pointed out, always use dev_*()
> > > > calls instead.
> > > 
> > > Some of the pr_ fns can be dev_, but I don't think all can.
> > > e.g. device NULL-check error messages
> > 
> > I would argue that those are pointless and can be removed and also the
> > check is probably not needed either.
> 
> Got it. The pr_() in find_bridge() can't be converted to dev_ so I'll remove 
> the message entirely in another patch.
> 
> I understand that the device-NULL checks should be done on the caller's side. 
> Since empty devices would mean something went wrong, would it be better to
> put in an assertion(..WARN_ON) when removing the check? 

WARN_ON() means "I have no idea what can happen here so I give up",
which is not a good idea in kernel development.  If that every hits,
then your machine will reboot as the huge majority of all Linux systems
in the world run with panic-on-warn enabled.

If it is impossible for something to happen (i.e. you control all
callers) then just do not check for it.  If it happens, you will get a
NULL-dereference which is the same as a WARN_ON() in a way.

No new WARN_ON() should ever be added to the kernel, especially in a
driver.  Handle the condition if it is possible to be hit.  If it can
never be hit, don't even check it.

thanks,

greg k-h
