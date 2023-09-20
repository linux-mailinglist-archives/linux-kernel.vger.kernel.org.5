Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498C07A8C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjITS4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:56:45 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B5C6;
        Wed, 20 Sep 2023 11:56:39 -0700 (PDT)
Received: from localhost (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 32A5E40F1DFB;
        Wed, 20 Sep 2023 18:56:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 32A5E40F1DFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1695236197;
        bh=VxODT37PlX5ZCRr1cOltUaqq8vMZMOJABM5YiBToizA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l96cjY6mmOxPcAT2xjV6US2bAUmNaGaKqnJAGlHa+7rUq0vr/XFtQn3z0QIXgmrr6
         G/oov4nIlX9KNDqA+a8TsFLJI9SOFXlIdKbVWOW4YULfHOSIFLmX4ZrVdp2tIld8yY
         aKeH6ajB6607YSusjSUXIaaY7H6A2d2dEqiYF4ts=
Date:   Wed, 20 Sep 2023 21:56:36 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: dm-zoned: free dmz->ddev array in dmz_put_zoned_device
Message-ID: <i62wc7w6akvi6g3sg4ji6hughqlj4aiagug2paebv5w3fa7e55@oimtmdzjcfdp>
References: <20230920105119.21276-1-pchelkin@ispras.ru>
 <c7818967-1fea-45da-9713-20de4bcb1c44@suse.de>
 <vdtvo2av3upya6mugjyiqo2hfnn6q4dpofoku6rvrtgmycgbrp@scpcnu3ta7ch>
 <ZQsxvY12z+/yYcR6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQsxvY12z+/yYcR6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 01:54PM, Mike Snitzer wrote:
> On Wed, Sep 20 2023 at 10:35P -0400,
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> 
> > On 23/09/20 04:06PM, Hannes Reinecke wrote:
> > > On 9/20/23 12:51, Fedor Pchelkin wrote:
> > > > Commit 4dba12881f88 ("dm zoned: support arbitrary number of devices")
> > > > made the pointers to additional zoned devices to be stored in a
> > > > dynamically allocated dmz->ddev array. However, this array is not freed.
> > > > 
> > > > Free it when cleaning up zoned device information inside
> > > > dmz_put_zoned_device(). Assigning NULL to dmz->ddev elements doesn't make
> > > > sense there as they are not supposed to be reused later and the whole dmz
> > > > target structure is being cleaned anyway.
> > > > 
> > > > Found by Linux Verification Center (linuxtesting.org).
> > > > 
> > > > Fixes: 4dba12881f88 ("dm zoned: support arbitrary number of devices")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > > > ---
> > > >   drivers/md/dm-zoned-target.c | 8 +++-----
> > > >   1 file changed, 3 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> > > > index ad8e670a2f9b..e25cd9db6275 100644
> > > > --- a/drivers/md/dm-zoned-target.c
> > > > +++ b/drivers/md/dm-zoned-target.c
> > > > @@ -753,12 +753,10 @@ static void dmz_put_zoned_device(struct dm_target *ti)
> > > >   	struct dmz_target *dmz = ti->private;
> > > >   	int i;
> > > > -	for (i = 0; i < dmz->nr_ddevs; i++) {
> > > > -		if (dmz->ddev[i]) {
> > > > +	for (i = 0; i < dmz->nr_ddevs; i++)
> > > > +		if (dmz->ddev[i])
> > > >   			dm_put_device(ti, dmz->ddev[i]);
> > > > -			dmz->ddev[i] = NULL;
> > > > -		}
> > > > -	}
> > > > +	kfree(dmz->ddev);
> > > >   }
> > > >   static int dmz_fixup_devices(struct dm_target *ti)
> > > 
> > > Hmm. I'm not that happy with it; dmz_put_zoned_device() is using dm_target
> > > as an argument, whereas all of the functions surrounding the call sites is
> > > using the dmz_target directly.
> > > 
> > > Mind to modify the function to use 'struct dmz_target' as an argument?
> > 
> > dm_target is required inside dmz_put_zoned_device() for dm_put_device()
> > calls. I can't see a way for referencing it via dmz_target. Do you mean
> > passing additional second argument like
> >   dmz_put_zoned_device(struct dmz_target *dmz, struct dm_target *ti) ?
> 
> No, what you did is fine.  Not sure what Hannes is saying given only
> passing dm_target has symmetry with dm_get_zoned_device (and
> dmz_fixup_devices).
> 
> > BTW, I also think it can be renamed to dmz_put_zoned_devices().
> 
> I've renamed like you suggested and added a newline to
> dmz_put_zoned_devices() and staged this fix in linux-next for
> upstream inclusion before 6.6 final releases.
> 

Okay, thanks.

> Mike
