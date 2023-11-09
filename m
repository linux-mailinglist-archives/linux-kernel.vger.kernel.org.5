Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29857E69E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjKILrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjKILrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11819E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699530380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xx9vhxDzXDx3FeqkfjvNzmV81Ex2XQnYZudM398Ndgc=;
        b=URytDEnQ1nl+jc46bmZmfRz+DXeS9RMmj5Xd3JuImzspcs0QxnH57Y+N7XzHjtk6ZRukLh
        s0/qpLDfB0/SiqI/uXdcn1raQizSeThji8CyWbfDrGXQxU2uoYNy2pTPX5rA9o/Gi5hyje
        8qGOJxKHTYHafs9nfJngjrKW5ZynrLQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-de_L-BgkMNy8AafYv3jrVg-1; Thu, 09 Nov 2023 06:46:19 -0500
X-MC-Unique: de_L-BgkMNy8AafYv3jrVg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c749c28651so64417866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530378; x=1700135178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx9vhxDzXDx3FeqkfjvNzmV81Ex2XQnYZudM398Ndgc=;
        b=YGUTczwkX96poCYMtcIMlbyFdDj+tHLdVD46SQBjk5bniYdkSetQxbkuWNdP/rrStv
         hJ9wW2aYYBIfGV5tIn6myyinqx3Ga5bplbnTI9r925GTP98b0YGOVy0DSMdiCy49cjJj
         u30jCvyWtvq7KxzDffnRV1Ce6LygWz2/PX9xIwMi4KU1siiJipozdZsN/frDqxsrYV6W
         KgzEtsBDXIHQpSoAzgwyvaaDQagPJXAxQl9TucTZt0N0oKp40SkZXmKvlILo9g76VWsV
         nhqVkQC0JkMeR/ccGzkIGSufeVevzXzdlqwOQWRHkGG+uTyrgMyPrK4Kk1bBeLvbfF0z
         iu/g==
X-Gm-Message-State: AOJu0Ywn6nHV6bivy9VsC61UdZuE8dcNp8a8dcqTtUIvB74m7eQEMYxc
        KxPBU5Jthf2jMwP4eiYhODsv+amXWDfe19gT8dmnbo0ahmICfMYneYleGx9NXJYuWu53wCBn8ua
        xmp/hu+wJgE8MXVGe++bq6C6rcVL0+w0mLTWYxzQu
X-Received: by 2002:a17:907:3e81:b0:9c3:1d7e:f5b5 with SMTP id hs1-20020a1709073e8100b009c31d7ef5b5mr3869802ejc.20.1699530378469;
        Thu, 09 Nov 2023 03:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJhwyykRuVv/L8SJga/nU+RHtyHjpDDz9uPB8KSXhUziWnNTPl03QiW2qPbkNK9V/EjcEv28gPLcZQdqB8Uds=
X-Received: by 2002:a17:907:3e81:b0:9c3:1d7e:f5b5 with SMTP id
 hs1-20020a1709073e8100b009c31d7ef5b5mr3869785ejc.20.1699530378150; Thu, 09
 Nov 2023 03:46:18 -0800 (PST)
MIME-Version: 1.0
References: <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
 <20231108194051.279435-2-nils@nilsfuhler.de> <CAO-hwJ+b4q+8g=Cg5MRJQT2EsxkFZrK_XgJqmHWm=GBHskhDqQ@mail.gmail.com>
 <87zfzndghj.fsf@sra.uni-hannover.de>
In-Reply-To: <87zfzndghj.fsf@sra.uni-hannover.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 9 Nov 2023 12:46:05 +0100
Message-ID: <CAO-hwJ+xMc2O0d1JJdQt4f3BAd+ASSv9hA4SH+3WS4iTNpU61w@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     ostapyshyn@sra.uni-hannover.de
Cc:     Nils Fuhler <nils@nilsfuhler.de>, davidrevoy@protonmail.com,
        folays@gmail.com, jason.gerecke@wacom.com, jkosina@suse.cz,
        jose.exposito89@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 11:32=E2=80=AFPM <ostapyshyn@sra.uni-hannover.de> wr=
ote:
>
> On 11/8/23 21:34, Benjamin Tissoires wrote:
>
> > Again, you convinced me that this commit was wrong. If people needs to
> > also use an ioctl to "fix" it, then there is something wrong.
>
> I don't think we're on the same page here.  Nobody needs to use an ioctl
> to fix 276e14e6c3.  Rather, the _exact opposite_: the bug reporter used
> an ioctl to remap Eraser to BTN_STYLUS2.  It stopped working after
> 276e14e6c3 and broke his workflow.  He reported it as a regression,
> starting this whole thread.

After more thoughts about Niels' email, the whole thread and a
not-so-good night's sleep, I think I now understand what is the
problem.

And yes, most of the problem comes from that remap *after* the kernel
parsed the device and made a decision based on what was provided to
it.

>
> > Sorry but I tend to disagree. Relying on the ioctl EVIOCSKEYCODE for
> > tuning the behavior of a state machine is just plain wrong. When
> > people do that, they are doing it at the wrong level and introducing
> > further bugs.
> >
> > The whole pen and touch HID protocols rely on a state machine. You
> > just can not change the meaning of it because your hardware maker
> > produced a faulty hardware.
> >
> > [...]
> >
> > In the same way, if you remap Tip Switch to KEY-A, you won't get
> > clicks from your pen. Assuming you can do that with any event on any
> > HID device is just plain wrong.
> > That ioctl is OK-ish for "remapping" simple things like keys. In our
> > case, the whole firmware follows a state machine, so we can not change
> > it. It has to be remapped in a later layer, in libinput, your
> > compositor, or in your end user application.
>
> I don't disagree.  Forbidding EVIOCSKEYCODE ioctls for pen and touch HID
> is a legitimate way to resolve this (an appealing one too -- accounting
> for it in hidinput_hid_event might be a hellish task).

I think it would be best not to require the need for the ioctl in the
first place.

Looking at David's blog, I'm starting to wonder if we actually need to
report BTN_TOOL_RUBBER after all in the case where there is no Invert
usage.

>
> Should we forbid remapping Eraser too?  If your answer is yes, then we
> can finish this conversation here and leave the code as it is now,
> because __the regression__ is a user not being able to use an ioctl to
> remap Eraser after 276e14e6c3.  Otherwise, if we do make an exemption for
> David's Eraser, the fix is as simple as replacing BTN_TOUCH with
> usage->code on line 1594 of hid-input.c.
>
> > How many of such devices do we have? Are they all UGTablet like the
> > XP-PEN? Are they behaving properly on Windows without a proprietary
> > driver?
> >
> > [...]
> >
> > I might buy the "invertless" devices are a thing if I can get more
> > data about it. So far there are only 2 of them, and they add extra
> > complexity in the code when we can just patch the devices to do the
> > right thing.
>
> There might or might not be more devices like this in the wild.  It looks
> like BarrelSwitch2 was added only 2013 [1], which is why so many styli
> use Eraser for the second button.  Setting two bits for a single button
> just to adhere to Microsoft's *recommendation* is nice for compatibility,
> but I can imagine vendors taking a shortcut and omitting Invert
> altogether.  The HID specification alone just lists the usages and says
> nothing about how they relate to each other.

Right. So maybe instead of trying to force the "no Invert" pens into
the "oh, this looks like an eraser", maybe we should remap in that
case the eraser usage into a secondary barrel switch.
We then need to filter the proximity out event that is sent when the
user presses it, but all in all it should be doable (hopefully).


>
> XP-Pen Artist 24 does work on Windows with the generic driver.  The
> Eraser engages as soon as the button is pressed, without touching the
> screen.

OK, thanks for the confirmation.

I just had a meeting with Peter Hutterer, and he told me it would be
best if the kernel doesn't follow the entire "this button is an eraser
mode". But that requires some filtering of the events because some
hardware (like the Artist 24 here) partially implements the
"specification" by sending a proximity out event when the button is
pressed.

So my idea would be to do that change in HID-BPF, so that it's only
included when libinput supports it (no regressions then), and we can
actually change the heuristics more easily than having to patch the
kernel.

I'd also need to get the behavior of:
- stylus is in range -> second button is pressed -> stylus touches the
surface with the button still pressed -> button is released -> stylus
leaves the surface and goes out of proximity.
- stylus is in range -> stylus touches the surface without any button
pressed -> second button is pressed -> stylus leaves the surface and
goes out of proximity
- stylus is in range -> stylus touches the surface without any button
pressed -> second button is pressed -> second button is released ->
stylus leaves the surface and goes out of proximity

And probably some other weird corner cases.

If we get the "eraser" event being set to 0/1 when the button is
pressed whether the stylus touches the surface or not, it would be
simple enough to change the purpose of the button in HID-BPF and
filter the eventual prox out events.


>
> > New hardware isn't supposed to be supported on an old kernel and is
> > not considered as a regression. However, David mentioned that the
> > device was "working" on 6.5.0 but broke in 6.5.8 with the patch
> > mentioned above. This is a regression that needs to be tackled.
> > Especially because it was introduced in 6.6 but backported into 6.5.
>
> To make sure we're talking about the same thing:
>
> 1. "Broke" in this context means that the ioctl remapping from Eraser to
>    right-click stopped working.

Yeah, you're correct. This isn't a regression, it's a user tempering
with the kernel and the kernel can't deal with it.
But the use case is still valid. It's the way it was done that was wrong.

>
> 2. XPPen 16 Pro Gen2 is a whole different topic, untouched by 276e14e6c3.

I still need to figure out what is wrong after my HID-BPF changes. But
yeah, it is orthogonal.

Cheers,
Benjamin

>
> [1] https://www.usb.org/sites/default/files/hutrr46e.txt
>

