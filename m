Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EA57C6A58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjJLKDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjJLKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:03:07 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E93C9;
        Thu, 12 Oct 2023 03:02:57 -0700 (PDT)
Received: from [192.168.42.20] (p5b164245.dip0.t-ipconnect.de [91.22.66.69])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 25D0B2FC0048;
        Thu, 12 Oct 2023 12:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1697104976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKwmlTlHRKLmKTIlMWUJwMtc2osuoYdOh412C/2t6iQ=;
        b=emvbv3gQGIGGlIjZqrO6KJpSevP2m5GZ1j/mOoMNdgl0Ii0JPJjMKTLiUQtGETG7ftbc8s
        4KaYUjuIhNGnqVtihtoiibwvYHkpN5TWNoOtY5R6T0WXxcARr9m7vNnT68dgUUSTPT5AGv
        K/Ua8wtBNYwUvrM886H3LJjjXnN8dzA=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
Date:   Thu, 12 Oct 2023 12:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZSe1GYLplZo5fsAe@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 12.10.23 um 10:58 schrieb Pavel Machek:
> Hi!
>
>> From: Christoffer Sandberg <cs@tuxedo.de>
>>
>> Implement per-key keyboard backlight in the leds sysfs interface for
>> several TUXEDO devices using the ite8291 controller.
>>
>> There are however some known short comings:
>> - The sysfs leds interface does only allow to write one key at a time. The
>> controller however can only update row wise or the whole keyboard at once
>> (whole keyboard update is currently not implemented). This means that even
>> when you want to updated a whole row, the whole row is actually updated
>> once for each key. So you actually write up to 18x as much as would be
>> required.
>> - When you want to update the brightness of the whole keyboard you have to
>> write 126 sysfs entries, which inherently is somewhat slow, especially when
>> using a slider that is live updating the brightness.
>> - While the controller manages up to 126 leds, not all are actually
>> populated. However the unused are not grouped at the end but also in
>> between. To not have dead sysfs entries, this would require manual testing
>> for each implemented device to see which leds are used and some kind of
>> bitmap in the driver to sort out the unconnected ones.
>> - It is not communicated to userspace which led entry controls which key
>> exactly
> Sooner or later, we'll need to support these keyboards.
>
> But this has way too many shortcomings (and we'd be stuck with the
> interface forever).

I had some thoughts on how the current userspace api could be expanded to better 
reflect the capabilities of RGB keyboards. What would be required for such an 
expansion to be considered?

I'm in contact with the KDE folks. Plasma already has a keyboard brightness 
slider, that soon 
https://gitlab.freedesktop.org/upower/upower/-/merge_requests/203 will work with 
multiple kbd_backlight. However the slowness of 126 sysfs entries makes it a 
little bit janky still.

They are also thinking about expanding desktop accent colors to the keyboard 
backlight when it supports RGB.

I have not reached out to the OpenRGB project yet, but is it alive and well and 
under constant development: https://gitlab.com/CalcProgrammer1/OpenRGB. Afaik it 
is currently a userspace only driver interacting directly with hidraw mostly and 
has not yet implemented the sysfs leds interface.

Just listing this to show that there is definitely interest in this.

>
> These days, displays with weird shapes are common. Like rounded
> corners and holes in them. Perhaps this should be better modelled as a
> weird display?

I'm not sure if I can follow you here. Where would this be implemented? Also I 
asume displays asume equal distance between pixels and that columns are straight 
lines perpendicular to rows, which the key backlights have and are not.

Kind regards,

Werner

>
> Best regards,
> 									Pavel
