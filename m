Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABED7A8AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjITRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjITRyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:54:54 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0723A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:54:08 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-773ac11de71so1060285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232448; x=1695837248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMUjbe6jAZJm7ZNBEI2GzRHbQh/3nvCFD3HmyB44o2Y=;
        b=hlvSnpF4u88GmTjJ8lm/jLC96GYu14FicJMjfuTX2muFscIFIPrDx5z2TyKp57N423
         AkcgUec2+FLbCraex8R3uL+5kRWcdZC7v2bf0NCrsZpigU/VbSdi+TJE4vqN4/jNXmqx
         vGLSzpBikmWwwhgEwVqDcgQ0f1ssak4+CJPoYRWQlh/idOep8nlnkl5DMo9kMi+SyUsc
         FaB4waQDjqzHvGJyB9fxY9mjpKWnuY9qutzXJotTwVn/uX33wNkx824He/yiMUUTO9o6
         fU8oc8TnDy1lfLpOiJ5Nvv11wLQvIdcu6Iw2tArds1rq1zg1gHkt34l2ZZpZtkTz7Qlg
         64gQ==
X-Gm-Message-State: AOJu0Yww7fhkl5C4zr/rzU4tgxYx8YK8HJkSPIsittDpdEVNeFPHWrV1
        DTMTvkJCn49krs18oTtbTJl/2VFsTKApHOiHww==
X-Google-Smtp-Source: AGHT+IEak9SOm9Pps/WpGIUms89fzDOBjAMtv3am2s1xZcN9i58NixmmmksMVtNi4wnk9/5qJ6K1AQ==
X-Received: by 2002:a05:620a:3890:b0:76f:19fd:5058 with SMTP id qp16-20020a05620a389000b0076f19fd5058mr2422766qkn.78.1695232447730;
        Wed, 20 Sep 2023 10:54:07 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a159500b007710052789dsm4986047qkk.94.2023.09.20.10.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:54:07 -0700 (PDT)
Date:   Wed, 20 Sep 2023 13:54:05 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Hannes Reinecke <hare@suse.de>, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: dm-zoned: free dmz->ddev array in dmz_put_zoned_device
Message-ID: <ZQsxvY12z+/yYcR6@redhat.com>
References: <20230920105119.21276-1-pchelkin@ispras.ru>
 <c7818967-1fea-45da-9713-20de4bcb1c44@suse.de>
 <vdtvo2av3upya6mugjyiqo2hfnn6q4dpofoku6rvrtgmycgbrp@scpcnu3ta7ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vdtvo2av3upya6mugjyiqo2hfnn6q4dpofoku6rvrtgmycgbrp@scpcnu3ta7ch>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20 2023 at 10:35P -0400,
Fedor Pchelkin <pchelkin@ispras.ru> wrote:

> On 23/09/20 04:06PM, Hannes Reinecke wrote:
> > On 9/20/23 12:51, Fedor Pchelkin wrote:
> > > Commit 4dba12881f88 ("dm zoned: support arbitrary number of devices")
> > > made the pointers to additional zoned devices to be stored in a
> > > dynamically allocated dmz->ddev array. However, this array is not freed.
> > > 
> > > Free it when cleaning up zoned device information inside
> > > dmz_put_zoned_device(). Assigning NULL to dmz->ddev elements doesn't make
> > > sense there as they are not supposed to be reused later and the whole dmz
> > > target structure is being cleaned anyway.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org).
> > > 
> > > Fixes: 4dba12881f88 ("dm zoned: support arbitrary number of devices")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > > ---
> > >   drivers/md/dm-zoned-target.c | 8 +++-----
> > >   1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> > > index ad8e670a2f9b..e25cd9db6275 100644
> > > --- a/drivers/md/dm-zoned-target.c
> > > +++ b/drivers/md/dm-zoned-target.c
> > > @@ -753,12 +753,10 @@ static void dmz_put_zoned_device(struct dm_target *ti)
> > >   	struct dmz_target *dmz = ti->private;
> > >   	int i;
> > > -	for (i = 0; i < dmz->nr_ddevs; i++) {
> > > -		if (dmz->ddev[i]) {
> > > +	for (i = 0; i < dmz->nr_ddevs; i++)
> > > +		if (dmz->ddev[i])
> > >   			dm_put_device(ti, dmz->ddev[i]);
> > > -			dmz->ddev[i] = NULL;
> > > -		}
> > > -	}
> > > +	kfree(dmz->ddev);
> > >   }
> > >   static int dmz_fixup_devices(struct dm_target *ti)
> > 
> > Hmm. I'm not that happy with it; dmz_put_zoned_device() is using dm_target
> > as an argument, whereas all of the functions surrounding the call sites is
> > using the dmz_target directly.
> > 
> > Mind to modify the function to use 'struct dmz_target' as an argument?
> 
> dm_target is required inside dmz_put_zoned_device() for dm_put_device()
> calls. I can't see a way for referencing it via dmz_target. Do you mean
> passing additional second argument like
>   dmz_put_zoned_device(struct dmz_target *dmz, struct dm_target *ti) ?

No, what you did is fine.  Not sure what Hannes is saying given only
passing dm_target has symmetry with dm_get_zoned_device (and
dmz_fixup_devices).

> BTW, I also think it can be renamed to dmz_put_zoned_devices().

I've renamed like you suggested and added a newline to
dmz_put_zoned_devices() and staged this fix in linux-next for
upstream inclusion before 6.6 final releases.

Mike
