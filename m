Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D453D7E5F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKHUfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB24D10D5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699475663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFXXJ4iJ1CFY4HPtPmC8ieq/tgarKy+p6y1wSuxcM04=;
        b=blLBBNaBPeBc/KLQuG2jpdqVlf5RQhE03/XNLB22/jeWGQT4WMoVHvQNf9I1iYBvMhwP/4
        j0hQv9YSQZNkIwAQyDdJQWT9sneasbWKg6yrsM+MdOxtGzEj124ceydb1g7V4AGEIt//ZY
        O8HI9EVJuhdpRdjlev2p+JbiuZAzBw8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Ia7l1zzIM064-VjzNRa1EQ-1; Wed, 08 Nov 2023 15:34:21 -0500
X-MC-Unique: Ia7l1zzIM064-VjzNRa1EQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bca0b9234so9282266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 12:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699475660; x=1700080460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFXXJ4iJ1CFY4HPtPmC8ieq/tgarKy+p6y1wSuxcM04=;
        b=sP7mvJdQgLM9122ANvhYTp5wlM7E6P7foyAxrJR7orARR9kzIU02dUP4e1dheUaCq3
         1XwwpdRCLVAJOEpwcuMqRrZLriuRbgXe0lNT9F/5hMDKic4MtSi3SEBeBeS/bBaGtyNj
         NxiZ3ZzfIrOxKc9O+NDM82GU17Ityy4dpyW8YOIqFMgXBO9vi29skTVq0CayV7GmS5ZW
         1x9H3N7wUllNTjVQwr5LsTB6VbczO/xKdbSwuEj3/Ax27NcgZBhpxvKBx7Q72jSWf4vn
         cTbXAUTPrYZP9Zma00I0eqmubNzX0tXN0/vmwqwjn7/sxLxFX6eLsQh95uw7KST00VRD
         dEaA==
X-Gm-Message-State: AOJu0Yz0usKzL5DI5IKDAqhEvfisHtIJv5KoWWXi6p7zlGXlS1LQYLin
        3oVeyzA7tA5JOijdOFq40FjH4GWaOAJPn8h84oie6i4j7I7EPYON7Blvcn7g76EWnbaMPACD3Gx
        BP34/cLMq91sEBn10xDnmcj9kq7ky5eVNFOVc9AoJ
X-Received: by 2002:a17:907:c5c6:b0:9e3:b88c:d735 with SMTP id ts6-20020a170907c5c600b009e3b88cd735mr3049345ejc.61.1699475660012;
        Wed, 08 Nov 2023 12:34:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtgzC0Ez0CFIIAF50p/Vlbu8Dk51oR/oGP9e+6leQLD9WcjLWGWl4lB5teFMNB3Aq1UUudO2YSVbK6KmGeqro=
X-Received: by 2002:a17:907:c5c6:b0:9e3:b88c:d735 with SMTP id
 ts6-20020a170907c5c600b009e3b88cd735mr3049329ejc.61.1699475659712; Wed, 08
 Nov 2023 12:34:19 -0800 (PST)
MIME-Version: 1.0
References: <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
 <20231108194051.279435-2-nils@nilsfuhler.de>
In-Reply-To: <20231108194051.279435-2-nils@nilsfuhler.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 8 Nov 2023 21:34:07 +0100
Message-ID: <CAO-hwJ+b4q+8g=Cg5MRJQT2EsxkFZrK_XgJqmHWm=GBHskhDqQ@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     Nils Fuhler <nils@nilsfuhler.de>
Cc:     davidrevoy@protonmail.com, folays@gmail.com,
        jason.gerecke@wacom.com, jkosina@suse.cz,
        jose.exposito89@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ostapyshyn@sra.uni-hannover.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 8:41=E2=80=AFPM Nils Fuhler <nils@nilsfuhler.de> wro=
te:
>
> Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
>
> > So, to me:
> > - 276e14e6c3993317257e1787e93b7166fbc30905 is wrong: this is a
> > firmware bug (reporting invert through eraser) and should not be
> > tackled at the generic level, thus it should be reverted
>
> Surely that can't be the solution.  [1] is not a specification but a
> suggestion that many manufacturers seem to follow.  Apparently, there
> are devices that directly report "erasing" for the upper button,
> skipping the whole "intent to erase" business.  A questionable decision,
> but clearly intended.

How many of such devices do we have? Are they all UGTablet like the
XP-PEN? Are they behaving properly on Windows without a proprietary
driver?
We can try to make the code work based on suppositions, but this is
the first time I see such a behavior, so I'd prefer fix it when I see
it rather than adding complexity in the driver where changing anything
is hard. I'm writing regression tests for that exact same purpose.

>
> The evdev input protocol represents the erasing action as BTN_TOUCH with
> BTN_TOOL_RUBBER being active.  Previously, it was assumed that there is
> an Invert usage that would toggle BTN_TOOL_RUBBER.  XP-Pen Artist 24
> (and possibly other devices) does not have Invert in its report
> descriptor, resulting in missing BTN_TOOL_RUBBER.  BTN_TOUCH without an
> active tool has no meaning in the input stream.
>
> 276e14e6c3 adds a quirk for this and sends the required BTN_TOOL_RUBBER
> events *only* for styli not doing it themselves via Invert.  In fact,
> 276e14e6c3 does not even affect the "two-eraser" XP-Pen Artist Pro 16
> Gen 2 and all other devices having Invert in their report descriptors.
> The quirk is not set, the behavior is unchanged [2].

Yes. That quirk only affects the device clearly not following the
specification. Which is why it wasn't noticed that it was wrong.

>
> As Illia already described, the *real problem* is the missing
> compatibility of the whole hidinput_hid_event state machine with
> hidinput_setkeycode, invoked from userspace via the EVIOCSKEYCODE ioctl.
> In David's case, this is done by hwdb.

Sorry but I tend to disagree. Relying on the ioctl EVIOCSKEYCODE for
tuning the behavior of a state machine is just plain wrong. When
people do that, they are doing it at the wrong level and introducing
further bugs.

The whole pen and touch HID protocols rely on a state machine. You
just can not change the meaning of it because your hardware maker
produced a faulty hardware.
The correct solution is to submit a fix here, so that everyone gets
the benefit of it. But that fix can now be a HID-BPF program, which
will be eventually integrated in the kernel tree as soon as I manage
to get enough time to work on it.

>
> This has been the case at least since the refactoring and even affects
> styli *completely* adhering to [1]: remapping Invert to something other
> than BTN_TOOL_RUBBER borks the device.  If you replay the recording [3]
> (with or without 276e14e6c3) and remap [4] 0xd003c (Invert) to something
> other than BTN_TOOL_RUBBER, you can observe that:

In the same way, if you remap Tip Switch to KEY-A, you won't get
clicks from your pen. Assuming you can do that with any event on any
HID device is just plain wrong.
That ioctl is OK-ish for "remapping" simple things like keys. In our
case, the whole firmware follows a state machine, so we can not change
it. It has to be remapped in a later layer, in libinput, your
compositor, or in your end user application.

>
> (1) Remapped Invert does not trigger the event it was remapped to -- this
>     is due to hardcoded BTN_TOOL_RUBBER and BTN_TOUCH in hidinput_hid_eve=
nt
>
> (2) After triggering Invert once, BTN_TOOL_PEN and BTN_TOUCH never appear
>     in the event stream again -- remapping Invert masks BTN_TOOL_RUBBER,
>     causing it to get permanently stuck in report->tool.
>
> 276e14e6c3 does extend this issue onto Eraser remappings for devices
> without Invert, resulting in this regression.  However, the solution is
> to fix 276e14e6c3 (and the whole function, while we're at it), not to
> revert it.

Again, you convinced me that this commit was wrong. If people needs to
also use an ioctl to "fix" it, then there is something wrong.

>
> > - both of these tablets are forwarding the useful information, but not
> > correctly, which confuses the kernel
> > - I should now be able to write regression tests
> > - I should be able to provide HID-BPF fixes for those tablets so that
> > we can keep them working with or without
> > 276e14e6c3993317257e1787e93b7166fbc30905
> > reverted (hopefully)
> > - problem is I still don't have the mechanics to integrate the HID-BPF
> > fixes directly in the kernel tree, so maybe I'll have to write a
> > driver for XP-Pen while these internals are set (it shouldn't
> > interfere with the HID-BPF out of the tree).
>
> As you can see, there is no need for rewriting anything.  The generic
> solution for "invertless" digitizers is already in place and has no
> impact on other devices.  IMHO, it would be wiser to fix the regression
> by making hidinput_hid_event compatible with EVIOCSKEYCODE, than to miss
> the point of what is actually broken and write device-specific drivers.

EVIOCSKEYCODE is called by userspace *after* the kernel parsed the
device and is ready to accept events. There is no way we can make this
consistent with the event stream. If you need to call that ioctl to
fix your device, it's a bug in the kernel, and it needs to be fixed
there before being presented to the userspace.

I might buy the "invertless" devices are a thing if I can get more
data about it. So far there are only 2 of them, and they add extra
complexity in the code when we can just patch the devices to do the
right thing.

>
> [1] https://learn.microsoft.com/en-us/windows-hardware/design/component-g=
uidelines/windows-pen-states
>
> [2] David confirms it in his blog post: "I now know it is there for a
>     long time, because even with the "old" kernel, my newer XPPen 16 Pro
>     (gen2) also reacts this way."
>     https://www.davidrevoy.com/article995/how-a-kernel-update-broke-my-st=
ylus-need-help

New hardware isn't supposed to be supported on an old kernel and is
not considered as a regression. However, David mentioned that the
device was "working" on 6.5.0 but broke in 6.5.8 with the patch
mentioned above. This is a regression that needs to be tackled.
Especially because it was introduced in 6.6 but backported into 6.5.

Cheers,
Benjamin

>
> [3] https://dl.uni-h.de/?t=3D6b2cabd8f15ac8ff281b52e25920c0a9
>
> [4] https://github.com/iostapyshyn/evmap is a handy EVIOCSKEYCODE wrapper
>     for remapping.
>

