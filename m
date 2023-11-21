Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41D7F2BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjKULlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:41:18 -0500
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 03:41:13 PST
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CA9C;
        Tue, 21 Nov 2023 03:41:13 -0800 (PST)
Received: from [192.168.42.20] (p5b164862.dip0.t-ipconnect.de [91.22.72.98])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 10D352FC01F8;
        Tue, 21 Nov 2023 12:33:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1700566395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bE/DZ6jSuHVY0GZUKmeiKrvkfUErx6XZ/rLhfW6+yWE=;
        b=thbtr9T8Yuz+G62q4lI97f1h/EewjqDXX3f+f386nsC9W23YpT9QO1b1CmGW1avIKk10yr
        LgJU9QZ5xf26OisbyPn4UmNLt2Z5KKKtMWgIGoP8MPCoaIXc8tabtrq8knuJKvq1vET/yD
        G1Ssnz+cJoo5/oSznGQ/eBl7Oc2uqb4=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
Date:   Tue, 21 Nov 2023 12:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
To:     Pavel Machek <pavel@ucw.cz>,
        Jani Nikula <jani.nikula@linux.intel.com>, hdegoede@redhat.com,
        jikos@kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        linux-input@vger.kernel.org, ojeda@kernel.org,
        linux-leds@vger.kernel.org
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
 <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 20.11.23 um 21:52 schrieb Pavel Machek:
> Hi!
>
>>>> So... a bit of rationale. The keyboard does not really fit into the
>>>> LED subsystem; LEDs are expected to be independent ("hdd led") and not
>>>> a matrix of them.
>>> Makes sense.
>>>
>>>> We do see various strange displays these days -- they commonly have
>>>> rounded corners and holes in them. I'm not sure how that's currently
>>>> supported, but I believe it is reasonable to view keyboard as a
>>>> display with slightly weird placing of pixels.
>>>>
>>>> Plus, I'd really like to play tetris on one of those :-).
>>>>
>>>> So, would presenting them as auxdisplay be acceptable? Or are there
>>>> better options?
>>> It sounds like a fair use case -- auxdisplay are typically simple
>>> character-based or small graphical displays, e.g. 128x64, that may not
>>> be a "main" / usual screen as typically understood, but the concept is
>>> a bit fuzzy and we are a bit of a catch-all.
>>>
>>> And "keyboard backlight display with a pixel/color per-key" does not
>>> sound like a "main" screen, and having some cute effects displayed
>>> there are the kind of thing that one could do in the usual small
>>> graphical ones too. :)
>>>
>>> But if somebody prefers to create new categories (or subcategories
>>> within auxdisplay) to hold these, that could be nice too (in the
>>> latter case, I would perhaps suggest reorganizing all of the existing
>>> ones while at it).
>> One could also reasonably make the argument that controlling the
>> individual keyboard key backlights should be part of the input
>> subsystem. It's not a display per se. (Unless you actually have small
>> displays on the keycaps, and I think that's a thing too.)
> While it would not be completely crazy to do that... I believe the
> backlight is more of a display and less of a keyboard. Plus input
> subystem is very far away from supporting this, and we had no input
> from input people here.
>
> I don't think LED subsystem is right place for this, and I believe
> auxdisplay makes slightly more sense than input.
>
> Unless someone steps up, I'd suggest Werner tries to implement this as
> an auxdisplay. [And yes, this will not be simple task. RGB on LED is
> different from RGB on display. But there are other LED displays, so
> auxdisplay should handle this. Plus pixels are really funnily
> shaped. But displays with missing pixels -- aka holes for camera --
> are common in phones, and I believe we'll get variable pixel densities
> -- less dense over camera -- too. So displays will have to deal with
> these in the end.]

Another idea I want to throw in the mix:

Maybe the kernel is not the right place to implement this at all. RGB stuff is 
not at all standardized and every vendor is doing completely different 
interfaces, which does not fit the kernel userpsace apis desire to be uniformal 
and fixed. e.g. Auxdisplay might fit static setting of RGB values, but it does 
not fit the snake-effect mode, or the raindrops mode, or the 
4-different-colors-in-the-edges-breathing-and-color-cycling mode.

So my current idea: Implement these keyboards as a single zone RGB kbd_backlight 
in the leds interface to have something functional out of the box, but make it 
runtime disable-able if something like 
https://gitlab.com/CalcProgrammer1/OpenRGB wants to take over more fine granular 
control from userspace via hidraw.

Kind regards,

Werner

>
> Best regards,
> 								Pavel
