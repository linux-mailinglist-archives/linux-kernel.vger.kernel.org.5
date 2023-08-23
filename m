Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFF785F05
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjHWR56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbjHWR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:57:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1F10D3;
        Wed, 23 Aug 2023 10:57:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bec436514so98274b3a.1;
        Wed, 23 Aug 2023 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692813464; x=1693418264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul67fwJ1O3cc6EL+TYVuXzM9+VdxWhJ2dcYpX4ihebs=;
        b=UjCTKYmWfMM5QlCerhDNa3gGARqXeZSE9yZIel9AcGnKqFtMlmFnEEqT/pe2qtOUZI
         EZvmVx6boY0YJnw2myyQooh53NQfJOZE1BHRM1V+GnY7bmImtVcSrYwMQIU/iMU8zdgH
         +jodun1cgt4QNcKcJiNef5L/CLcu/skK0fuEejTXVVn0PDu6CflX+24uxlIOfpBE7T5w
         wpa9er66nTMAUBYvL7CbSvOwmvvSAYyJruHpv42Zg/5nRjmwZBj2Cwy8k+KdM/6hXJ0/
         cCPQBZhc0Nj0PvgAGSuuXePZaNYePVATp1WokpZDuIcwjDpOkS6brFxh1EVueIzOoYvZ
         WfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692813464; x=1693418264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul67fwJ1O3cc6EL+TYVuXzM9+VdxWhJ2dcYpX4ihebs=;
        b=b+y0hYTIw1mL4bvYHRqdz7IX/lAbYv5nY7p4jMHJ9TeFehgnyht9Wwn1h+o9Xe7DtI
         iULsmik7eyrm9LbCb6JPX6WbO/vQWNaSyqXTjE/wp+rm+7uxaMuRrmuhuuFgyEjvWgwi
         ynWrSP8txzRxTAOavnBfTp66rj5R1xnBGaO3Y+5iAo9BbyRjKruR2bhaQN4do4Qh9dn6
         kna4YmPaw0nq3OFPuBwpL6AkbD3swZs4/zUw/l/HYRKC5xX/8EYX98Y+JIcHk1mUYzY5
         jUizoqZrRrZky7l24DZKOIx6AfIbSejHD/mR/dq2uTLue3unLlkPHL16n4JYuV5HJ6Cb
         5jcw==
X-Gm-Message-State: AOJu0Yy2qsCEu8Vx9x3RidhyPAvKf0oP/uNP5dHkk6/7BstJPvxyTne3
        LTmlp89mJq8b7RFoZrbE48E=
X-Google-Smtp-Source: AGHT+IHnU3OvW2ta4ihTGmVmE93zz2KNESgMLB9su0xVggiXewWPWoMaILVMwLO5RnLzB/T/E/tvtg==
X-Received: by 2002:a05:6a00:23c6:b0:68a:406f:8a11 with SMTP id g6-20020a056a0023c600b0068a406f8a11mr10793812pfc.15.1692813464172;
        Wed, 23 Aug 2023 10:57:44 -0700 (PDT)
Received: from penguin ([205.220.129.25])
        by smtp.gmail.com with ESMTPSA id d5-20020aa78145000000b00687a4b70d1esm9752972pfn.218.2023.08.23.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 10:57:43 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:56:52 -0400
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>,
        davidgow@google.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com,
        benjamin.tissoires@redhat.com
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 input_dev_uevent
Message-ID: <ZOZIZCND+L0P1wJc@penguin>
References: <00000000000035beba060371a468@google.com>
 <ijh2qmdtj452nq3idu2tohkrmfwr2qhbhrnyqzxjkkw2lrby53@v2dffcqdohsx>
 <878ra3m5my.fsf@nvidia.com>
 <nqrdxdcvuhvcs2syjfhcp5fbk4ckgzibc3izxknvsrka3kres6@ae65hqx67c4u>
 <ZOYAtI5KttKQnLWs@google.com>
 <y3hfjc227wouzraa4hyltyfd4athig5rmna2uwjqy6v23yzkad@wdmzmochmsve>
 <ZOYd1R3Bx2IToWfb@google.com>
 <87zg2h3d25.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg2h3d25.fsf@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:04:34AM -0700, Rahul Rameshbabu wrote:
> On Wed, 23 Aug, 2023 07:55:17 -0700 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > Hi Maxime,
> >
> > On Wed, Aug 23, 2023 at 03:16:02PM +0200, Maxime Ripard wrote:
> >> Hi Dmitry,
> >> 
> >> On Wed, Aug 23, 2023 at 05:51:00AM -0700, Dmitry Torokhov wrote:
> >> > On Wed, Aug 23, 2023 at 09:44:22AM +0200, Maxime Ripard wrote:
> >> > > On Tue, Aug 22, 2023 at 08:57:41AM -0700, Rahul Rameshbabu wrote:
> >> > > > On Tue, 22 Aug, 2023 11:12:28 +0200 Maxime Ripard <mripard@kernel.org> wrote:
> >> > > > > Hi,
> >> > > > >
> >> > > > > So, we discussed it this morning with Benjamin, and I think the culprit
> >> > > > > is that the uclogic driver will allocate a char array with devm_kzalloc
> >> > > > > in uclogic_input_configured()
> >> > > > > (https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-uclogic-core.c#L149),
> >> > > > > and will assign input_dev->name to that pointer.
> >> > > > >
> >> > > > > When the device is removed, the devm-allocated array is freed, and the
> >> > > > > input framework will send a uevent in input_dev_uevent() using the
> >> > > > > input_dev->name field:
> >> > > > >
> >> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1688
> >> > > > >
> >> > > > > So it's a classic dangling pointer situation.
> >> > > > >
> >> > > > > And even though it was revealed by that patch, I think the issue is
> >> > > > > unrelated. The fundamental issue seems to be that the usage of devm in
> >> > > > > that situation is wrong.
> >> > > > >
> >> > > > > input_dev->name is accessed by input_dev_uevent, which for KOBJ_UNBIND
> >> > > > > and KOBJ_REMOVE will be called after remove.
> >> > > > >
> >> > > > > For example, in __device_release_driver() (with the driver remove hook
> >> > > > > being called in device_remove() and devres_release_all() being called in
> >> > > > > device_unbind_cleanup()):
> >> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1278
> >> > > > >
> >> > > > > So, it looks to me that, with or without the patch we merged recently,
> >> > > > > the core has always sent uevent after device-managed resources were
> >> > > > > freed. Thus, the uclogic (and any other input driver) was wrong in
> >> > > > > allocating its input_dev name with devm_kzalloc (or the phys and uniq
> >> > > > > fields in that struct).
> >> > > > >
> >> > > > > Note that freeing input_dev->name in remove would have been just as bad.
> >> > > > >
> >> > > > > Looking at the code quickly, at least hid-playstation,
> >> > > > > hid-nvidia-shield, hid-logitech-hidpp, mms114 and tsc200x seem to be
> >> > > > > affected by the same issue.
> >> > > > 
> >> > > > I agree with this analysis overall. At least in hid-nvidia-shield, I can
> >> > > > not use devm for allocating the input name string and explicitly free it
> >> > > > after calling input_unregister_device. In this scenario, the name string
> >> > > > would have been freed explicitly after input_put_device was called
> >> > > > (since the input device is not devres managed). input_put_device would
> >> > > > drop the reference count to zero and the device would be cleaned up at
> >> > > > that point triggering KOBJ_REMOVE and firing off that final
> >> > > > input_dev_uevent.
> >> > > > 
> >> > > > I think this can be done for a number of the drivers as a workaround
> >> > > > till this issue is properly resolved. If this seems appropriate, I can
> >> > > > send out a series later in the day. This is just a workaround till the
> >> > > > discussion below converges (which I am interested in).
> >> > > 
> >> > > I'm sorry, I don't know the input framework well enough to understand
> >> > > what you had in mind exactly. Could you send a patch with your
> >> > > suggestion for the hid-nvidia-shield so we can discuss this further?
> >> > > 
> >> > > That being said, I think that the current design around name, phys and
> >> > > uniq is fairly treacherous to drivers and we should aim for a solution
> >> > > that prevents that issue from being possible at all.
> >> > > 
> >> > > I was inclined to go for a char array for each to get rid of the pointer
> >> > > entirely, but Benjamin raised some concerns over the structure size so
> >> > > it's probably not a great solution.
> >> > 
> >> > I think everything is much simpler, with uclogic driver being in the
> >> > wrong here: devm resource needs to be attached to the right device
> >> > (instance of HID) rather than to the input device itself (which should
> >> > never have any driver resources attached since it never has a driver).
> >> > Something like this:
> >> > 
> >> > diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
> >> > index f67835f9ed4c..f234a7c97360 100644
> >> > --- a/drivers/hid/hid-uclogic-core.c
> >> > +++ b/drivers/hid/hid-uclogic-core.c
> >> > @@ -148,7 +148,7 @@ static int uclogic_input_configured(struct hid_device *hdev,
> >> >  
> >> >  	if (suffix) {
> >> >  		len = strlen(hdev->name) + 2 + strlen(suffix);
> >> > -		name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
> >> > +		name = devm_kzalloc(&hdev->dev, len, GFP_KERNEL);
> >> >  		if (name) {
> >> >  			snprintf(name, len, "%s %s", hdev->name, suffix);
> >> >  			hi->input->name = name;
> >> > 
> >> > In general, drivers should attach devm resources they allocate to the
> >> > instance of device they are binding to, and nothing else.
> >> 
> >> I'm not sure that's enough unfortunately. The fundamental issue here
> >> seems to be that input_dev_uevent follows a pointer that can be
> >> allocated by the driver, and will be free'd before the last call to
> >> input_dev_uevent.
> >
> > Yes, this is a fundamental property of C pointers - you should not free
> > them before exiting last code section that may reference them. For input
> > devices it means that pointers should not be freed until after
> > input_unregister_device() is called.
> >
> > I.e. you have sequence like this:
> >
> > 	driver_data = kzalloc(...);
> > 	driver_data->input_name = kstrdup(...);
> > 	driver_data->input_phys = kstrdup(...);
> > 	input = input_allocate_device();
> > 	input->name = driver_data->input_name;
> > 	input->phys = driver_data->input_phys;
> > 	input_register_device(input);
> > 	...
> >
> > 	input_unregister_device(input);
> > 	kfree(driver_data->input_name);
> > 	kfree(driver_data->input_phys);
> > 	kfree(driver_data);
> >
> >
> > devm typically helps with resources being freed at the right time, but
> > for that the managed resources should be attached to the *correct
> > device*, with correct device being one the driver is binding to, not any
> > random device structure.
> >
> >> 
> >> And I think that's true for both devices here
> >
> > Yes, it looks like the shield is also using wrong device.
> 
> This is a problem in shield too. I'll submit a patch. I'll take a look
> at other drivers as well to see if any of them run into this issue.
> 
> 	idev->name = devm_kasprintf(&idev->dev, GFP_KERNEL, "%s %s", hdev->name,
> 				    name_suffix);

I did a quick scan in drivers/hid and it looks like hid-multitouch.c
also has this issue. So that makes 3 - hid-multitouch, uclogic and the
shield drivers.

Thanks.

-- 
Dmitry
