Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453408076A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378586AbjLFRcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378425AbjLFRcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:32:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91E7D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:32:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68788C433C8;
        Wed,  6 Dec 2023 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701883976;
        bh=XEf6tIDOSMPHN/MSARI80obGogkE99GvYNfgujy4bHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W58MNNTIrWqXAVyrXcuSgrRioprROjVZ1gnyAlVTMR+oAz51Sw3z1yxDxfhlVuO9Z
         Wxykyc+RerDlupvdQWC10OELAMzqOhIvXJzdyskjZqNG4bDsbHTfdmGWjTwMqHzkTu
         taeU3SbnzPW8JD5A2/ipbc9bO5znelpN2dO3TIjGZnKZ7jcSldf4TKB1DHsIncpt5Y
         TdQUPFiP0BsjQ3te/SEcDHiR2tkMDfWUuxH8qhbpM2NNg5Isa2mW1yPy0F/5L7W+kG
         X5JFPrgVt7mnM3NWLGJ1gvKOPvy4sqQop/W/4dy7xSKXMRQvXQEV57fQRyYRhmH9Pt
         fm97nMHyYv6tQ==
Date:   Wed, 6 Dec 2023 17:32:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: temperature: mlx90635 MLX90635 IR
 Temperature sensor
Message-ID: <20231206173248.7eb5a4a8@jic23-huawei>
In-Reply-To: <CAKv63uuBjkqffEzVsJcsMKK3wYoShJ0gNU_X+=KrU1zicTVdEw@mail.gmail.com>
References: <cover.1701168726.git.cmo@melexis.com>
        <c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
        <20231204142224.51f2ccdf@jic23-huawei>
        <CAKv63usxdfOviH=M6iUiNTtBFZVOseWUGz63Q-oJniBDFvTpSQ@mail.gmail.com>
        <20231204170623.0c0cd598@jic23-huawei>
        <CAKv63uuBjkqffEzVsJcsMKK3wYoShJ0gNU_X+=KrU1zicTVdEw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 20:56:39 +0100
Crt Mori <cmo@melexis.com> wrote:

> On Mon, 4 Dec 2023 at 18:06, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 4 Dec 2023 16:34:30 +0100
> > Crt Mori <cmo@melexis.com> wrote:
> >  
> > > On Mon, 4 Dec 2023 at 15:22, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >  
> ...
> > > While in Sleep Step mode, the EEPROM is powered down, but the cache
> > > buffers those values. Still when you try to write or read a volatile
> > > register (which should not be prevented by cache enabled as per my
> > > opinion, but code says differently) in that mode, it returns -EBUSY
> > > (as we discovered by code), so this kind of manipulation is needed to
> > > enable write and read operations from volatile registers.  
> >
> > So the cache trick is just meant for the eeprom?  Can you use two regmaps.
> > (I've seen similar done for devices with different ways of reading which
> > this 'kind of' corresponds to).
> > One to cover the eeprom and the other the registers that always work.
> > That should let you separately control if they are in caching state or
> > not.
> > Or just read the eeprom into a manually created cache on boot?
> >  
> 
> It did not seem correct to create a manual cache, since regcache does
> this job. I tried two separated regmaps, but when I tried to
> initialize them I got into kernel panic/crash, so I could not get it
> working on same device. Do you have any device in mind I could
> template this against?

I'm not sure which device I was thinking of, but grepping and looking for
likely targets got me
https://elixir.bootlin.com/linux/latest/source/drivers/mfd/madera-spi.c#L90
which registers one regmap for 32bit registers and one for 16 bit registers
as the devices have two non overlapping ranges.

Not sure why it would crash (as opposed to one trampling on the other) but
maybe there is something tied more tightly to the device than I think.

> 
> ...
> > > "invalid" data (shouldn't differ much, but I wanted to prevent that as
> > > it might be 0).  
> >
> > ok.  Just give a little bit more of that detail.  I'd not understood
> > intent is to ensure one trigger -> one measurement.  
> 
> OK.
> > >  
> ...
> > >
> > > Burst is from 90632 terminology (and our chip register map), but maybe
> > > more general would be "trigger_measurement"?  
> >
> > ok. But why only if in SLEEP_STEP?
> >  
> 
> Because in continuous mode (other mode used here) the measurement
> table is constantly updated, so trigger is not useful and would only
> slow down the reading. And I did not want to block the data retrieval
> when person wants to read the data fast.

Fair enough - add a comment so reader can easily follow that.

> 
> > >  
> > > > > +static int mlx90635_get_refresh_rate(struct mlx90635_data *data,
> > > > > +                                  unsigned int *refresh_rate)
> > > > > +{
> > > > > +     unsigned int reg;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > > > +             regcache_cache_only(data->regmap, false);  
> > > >
> > > > Definitely needs a comment on why this is needed in this case.
> > > >  
> > >
> > > Here and below (where we turn it back to true?), but then I assume in
> > > all other instances as well? Maybe a more general comment in the
> > > sleep_step mode function?  
> >
> > If we keep this, then yes I think we need comments on these - even if
> > it's as simple as 'not accessing an eeprom register so we want to
> > talk to the device'.  
> 
> OK, then this is an option if I cannot make two regmaps work.
> 
> > >  
> > > > > +  
> ...
> > > changed we should end up in correct state. I can wrap a mutex around
> > > though.  
> >
> > Assuming regcache_cache_only() isn't refcounted, you could end up with a
> > second copy of this racing through and accessing the data after the
> > first one turned the cache back on so the -EBUSY your mentioned.
> >  
> 
> True. I will use mutex then for this action.

