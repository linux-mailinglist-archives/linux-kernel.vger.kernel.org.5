Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF627FACF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjK0WG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjK0WGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:06:55 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDD21AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:06:59 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r7jkh-0001Ad-1s;
        Mon, 27 Nov 2023 22:06:52 +0000
Date:   Mon, 27 Nov 2023 22:06:50 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] ubi: don't decrease ubi->ref_count on detach error
Message-ID: <ZWUS-mjWIcIFXvY5@makrotopia.org>
References: <9857609999c5b7196417474938a7a09892cd1612.1701104870.git.daniel@makrotopia.org>
 <771902199.32600.1701116758852.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771902199.32600.1701116758852.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Mon, Nov 27, 2023 at 09:25:58PM +0100, Richard Weinberger wrote:
> > If attempting to detach a UBI device while it is still busy, detaching
> > is refused. However, the reference counter is still being decreased
> > despite the error. Rework detach function to only decrease the refcnt
> > once all conditions for detachment are met.
> > 
> > Fixes: cdfa788acd13 ("UBI: prepare attach and detach functions")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Good catch! Did you find this by review or while testing?

I was working on simplifying the NVMEM-on-UBI code which includes
attaching UBI via MTD notifiers. You and others had rightously
criticized the sketchy situation of the 'remove' handler which has now
lead me to rework that part of my patches, which made me end up looking
at the ref_count logic and error path at some point it popped into my
eyes that this can't be right.

> 
> > ---
> > drivers/mtd/ubi/build.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> > index 7d4ff1193db6f..f47987ee9a31b 100644
> > --- a/drivers/mtd/ubi/build.c
> > +++ b/drivers/mtd/ubi/build.c
> > @@ -1099,16 +1099,16 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
> > 
> > 	spin_lock(&ubi_devices_lock);
> > 	put_device(&ubi->dev);
> > -	ubi->ref_count -= 1;
> > -	if (ubi->ref_count) {
> > +	if (ubi->ref_count > 1) {
> 
> Is there a specific reason why you have modified the check to test only
> for ref_count being positive?

My idea was to really change only what I meant to change and make
that change the least intrusive possible.

> If rec_counts turns negative, due to a bug, we could still stop it here.

... here and in every other pleace where we touch it?
Adding new sanity checks to the code probably doesn't hurt but goes
beyond the scope of fixing this very bug, so I'll only do it there for
now.

> 
> > 		if (!anyway) {
> > 			spin_unlock(&ubi_devices_lock);
> > 			return -EBUSY;
> > 		}
> > 		/* This may only happen if there is a bug */
> > 		ubi_err(ubi, "%s reference count %d, destroy anyway",
> > -			ubi->ubi_name, ubi->ref_count);
> > +			ubi->ubi_name, ubi->ref_count - 1);
> > 	}
> > +	ubi->ref_count -= 1;
> 
> Please add there an ubi_asert() which tests whether ref_count is really zero.
> ...just to be more bullet proof.

That makes sense, now that it became clear that ref_count wasn't
trustable for more than a decade, let's better make sure it is now.
