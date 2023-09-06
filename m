Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C484F794031
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbjIFPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIFPUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E611733
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694013597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBGwnY8IJ4oOi26b7B4Xq+aeBiWJN7rJ48RnXu/dAI8=;
        b=FbWw5Jm6nbFlVJblQAhQevalVz0btcp63Fi4TLqQrk28P6NRdeyLiTWb1EY24FJ9+VT03c
        U8Ke1d0gX7SB03aKiYoBMr6Jl8eP2KQzZMcTYDOS8zTwwa4Ykfrkb4hyjYh6wsQw/S07CY
        hVRXzeeYiW5HOq2DL2IiHI6S5krNvDI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-880jPllFOUiZ7JMzM687AQ-1; Wed, 06 Sep 2023 11:19:55 -0400
X-MC-Unique: 880jPllFOUiZ7JMzM687AQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52a0f6f7a3bso1614044a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013594; x=1694618394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBGwnY8IJ4oOi26b7B4Xq+aeBiWJN7rJ48RnXu/dAI8=;
        b=Jp37BzJXBT+Z1q/5C5Aiq5QI/EU17eHn0cNCkc+Ex3T8QpxmEG4W4XlBo/LeaXVxH9
         MblFoCV6WGggxwBnlP+7pRxZZITiF9WRcSWiKiRRfyOsTSHcf8Q62ABs1tkATOVTI07L
         B0Gz2Uq+Mol9t0e+OrEQe9GCe6zkLElLS4D5yFv13HduMn0/WwxIpJ9j1Bqs4RymLRY2
         0Jk+3HwzUprl0w2Rml7ZaqavQtt3Mfi//dufyxnmLhNslNWNf7dTz3jlpy1+cp8lp7Vr
         xUjXfyE2h8owjaKhwD753BWcrBZwvrW23kixXFB6wj+KIjK8icUp//hghjRwPhOBRhh6
         OlFQ==
X-Gm-Message-State: AOJu0Yx/9xvSMzoS/QFEvLmzKn36hPf7utzQSU/ZPYl9wK/Fem2CezCJ
        iQaku9ZHZ58+r0Wm5fS9iGZLdFkZzRXFmotD44Yw6XcVOlJqPu7Cfo7+7qfkj4bE0g+thPKLLOw
        WVkMXfc0jbrNLYitQUwHj8Q5T
X-Received: by 2002:aa7:d704:0:b0:523:2e23:a0bf with SMTP id t4-20020aa7d704000000b005232e23a0bfmr3399260edq.11.1694013594559;
        Wed, 06 Sep 2023 08:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQRje1BTiQeDC0pKG0JIZJVNX1y7mzl6y7CEgKpmM02h2Jahwy26ejPbhXZUuWRDSrUFQtQg==
X-Received: by 2002:aa7:d704:0:b0:523:2e23:a0bf with SMTP id t4-20020aa7d704000000b005232e23a0bfmr3399238edq.11.1694013594219;
        Wed, 06 Sep 2023 08:19:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7ce11000000b00522572f323dsm8504731edv.16.2023.09.06.08.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 08:19:53 -0700 (PDT)
Message-ID: <f95da7ff-06dd-2c0e-d563-7e5ad61c3bcc@redhat.com>
Date:   Wed, 6 Sep 2023 17:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/1] backlight: hid_bl: Add VESA VCP HID backlight
 driver
Content-Language: en-US, nl
To:     Julius Zint <julius@zint.sh>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <20230820094118.20521-1-julius@zint.sh>
 <20230820094118.20521-2-julius@zint.sh>
 <f2e1ab9e-e691-42e1-a600-42744f692922@t-8ch.de>
 <9a5364de-28e1-1d4a-1d3a-d6dcedb7e659@zint.sh>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9a5364de-28e1-1d4a-1d3a-d6dcedb7e659@zint.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julius,

On 9/4/23 21:02, Julius Zint wrote:
> 
> 
> On Mon, 4 Sep 2023, Thomas Weißschuh wrote:
> 
>> +Cc Hans who ins involved with the backlight subsystem
>>
>> Hi Julius,
>>
>> today I stumbled upon a mail from Hans [0], which explains that the
>> backlight subsystem is not actually a good fit (yet?) for external
>> displays.
>>
>> It seems a new API is in the works that would better fit, but I'm not
>> sure about the state of this API. Maybe Hans can clarify.
>>
>> This also ties back to my review question how userspace can figure out
>> to which display a backlight devices applies. So far it can not.
>>
>> [0] https://lore.kernel.org/lkml/7f2d88de-60c5-e2ff-9b22-acba35cfdfb6@redhat.com/
>>
> 
> Hi Thomas,
> 
> thanks for the hint. I will make sure to give this a proper read and
> see, if it fits my use case better then the current backlight subsystem.

Note the actual proposal for the new usespace API for display brightness
control is here:

https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/

I have finished / stabilized the backlight code refactor which I landed
in 6.1, which is a prerequisite for the above proposal. But I have not
been able to make time to actually implement the above proposal; and
I don't know when I will be able to make time for this.

> Especially since I wasnt able to properly address your other review
> comments for now. You are right that the name should align better with
> the kernel module and also, that it is possible for multiple displays to
> be attached.
> 
> In its current state, this would mean that you could only control the
> backlight for the first HID device (enough for me :-).
> 
> The systemd-backlight@.service uses not only the file name, but also the
> full bus path for storing/restoring backlights. I did not yet get around
> to see how the desktops handle brightness control, but since the
> systemd-backlight@.service already uses the name, its important to stay
> the same over multiple boots.
> 
> I would be able to get a handle on the underlying USB device and use the
> serial to uniquely (and persistently) name the backlight. But it does
> feel hacky doing it this way.

So mutter (gnome-shell compositor library) has a similar issue when saving
monitor layouts and I can tell you beforehand that monitor serial numbers
by themselves are not unique enough. Some models just report 123456789
as serial and if you have a dual-monitor setup with 2 such monitors
and name the backlight class device <serial>-vcp-hid or something like that
you will still end up with 2 identical names.

To avoid this when saving monitor layouts mutter saves both the port
to which the monitor is attached (e.g. DP-1 DP-2) and the serialnumber
and on startup / monitor hotplug when it checks to see if it has saved
layout info for the monitor it checks the port+serialnr combination.

So what I think you should do is figure out a way to map which
VCP HID device maps to which drm-connector and then use
the connector-name + serial-nr to generate the backlight device name.

We will need the mapping the a drm-connector object anyway for
the new brightness API proposal from above.

Note this does NOT solve the fact that registering a new backlight
class device for an external monitor on a laptop will hopelessly
confuse userspace, see:

https://lore.kernel.org/lkml/7f2d88de-60c5-e2ff-9b22-acba35cfdfb6@redhat.com/

Regards,

Hans


