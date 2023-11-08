Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E067E4FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjKHFXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHFXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:23:14 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9111D79;
        Tue,  7 Nov 2023 21:23:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so85677991fa.0;
        Tue, 07 Nov 2023 21:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699420989; x=1700025789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzF+451R8y+xuy+CamSX2ULAd2IoaXVNFoZ9osNmLG4=;
        b=ffws+i/dKB/FZ5HErlF6B/SdQ4kLTjZ52rJ++Hat96Z5PQo+6585Y4saMvl1MMs/t2
         z8yhltcSF7mKPRRNWYljeykcn02tZRwf7ktOrmID2zu4AtNOGXd+Z4+OMkIFAWzG975i
         CobOi+vSqO71CSOJp3YnAXYowMb0YubzUdq8U3jWJn+b0kBRN1IP3gZuUF1+Ivg44XTY
         zvDR1PnGewIJuO7tHMU9yHlUQ8QUGts2mVt8wiE5jtVC+2oXcXgf2tvKRruLVQtnyA6+
         VJ2Hv4IFOdkKQsUFu9Mw7dHugr9fCKiJB8lSRg4AZiCGSMRyX7UnI6v5Ud3gQJoandQB
         HUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699420989; x=1700025789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzF+451R8y+xuy+CamSX2ULAd2IoaXVNFoZ9osNmLG4=;
        b=WM2B0kjL5qtylJ/X7N6Md5V8Xe3XtVb0QsxXjO7tGtg8Vu03cA9gSzh0p9c6WPbBcA
         r5+injPPn6Afs67O5Yv1cRDH0kVTqpWyzIDJxpc9yOpmz6Go1jPM4bN/OihkN/hN6zsT
         XVwZhaLo3YzMWS9YGZXZ2XvtA2e8sfGmd6W6s+QgLgYtRQkn3CvvdEZbeRI0MCzzK3mq
         z8rL50js9GBJchmbYi3wj5/ChbflW/rpZ4NqUG6lHA5V9IBh0iP22MhiDGKBiTiTOmq5
         4XgfTtYcXPsXhiWZ9BqvfIOOqWl7eD+4ZLjqDnybSUHaqaD443+tJCJ92e7bJmBtdSas
         WQ5g==
X-Gm-Message-State: AOJu0YyDrxuV4SaEEIFNeAtQz2RJc4yEO0rUweK/H94VRqcwHQ5KRgkr
        ynxIKZ6iUCVtmpGn7O1OwYo=
X-Google-Smtp-Source: AGHT+IH0O5NqZWNqq4cBBrDKcxHwZ4nqZ6hHR0ksIO48cB9ybs7Qle5QCvqyop6Mo/RSLFB577P0aQ==
X-Received: by 2002:a2e:3204:0:b0:2c7:fa5:6db9 with SMTP id y4-20020a2e3204000000b002c70fa56db9mr700762ljy.48.1699420989265;
        Tue, 07 Nov 2023 21:23:09 -0800 (PST)
Received: from dryade ([2a01:e0a:848:d9e0:bea:1748:a163:872b])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b004064ac107cfsm17686515wmq.39.2023.11.07.21.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 21:23:09 -0800 (PST)
Date:   Wed, 8 Nov 2023 06:23:06 +0100
From:   Eric GOUYER <folays@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        David Revoy <davidrevoy@protonmail.com>, jkosina@suse.cz,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Requesting your attention and expertise regarding a
 Tablet/Kernel issue
Message-ID: <20231108062306.33f5dcd0@dryade>
In-Reply-To: <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
 <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
 <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
 <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, below I re-send my email which bounced due to exceeding 100k
(hid-recorder traces included), so I re-send it without them, for some
book-keeping.

I had originally replied-to-all, so mainteners involved should have
received those traces just before (I hope).

Best Regards,

-----8<-----8<-----8<-----8<

Hello, I have the same tablet than OP (David) :
- XP-Pen Artist Pro 16 Gen 2
- on Ubuntu 23.10 linux-image-generic 6.5.0.10.12

I am not (yet ?) encountering the problem described above since I guess
that my kernel is before the suspected regression.

Here below I included much detail, but you can TL;DR + jump at the five
hid-recorder traces below.

> On Mon, Nov 6, 2023 at 9:06=E2=80=AFPM Illia Ostapyshyn
> <ostapyshyn@sra.uni-hannover.de> wrote:
> >
> > On 11/6/23 17:59, Benjamin Tissoires wrote:
> > =20
> > > If the pen has 2 buttons, and an eraser side, it would be a
> > > serious design flow for XPPEN to report both as eraser.
> > >
> > > Could you please use sudo hid-recorder from hid-tools[1] on any
> > > kernel version and send us the logs here?
> > > I'll be able to replay the events locally, and understand why the
> > > kernel doesn't work properly.
> > >
> > > And if there is a design flaw that can be fixed, we might even be
> > > able to use hid-bpf to change it :) =20
> >
> > My wild guess is that XP-Pen 16 Artist Pro reports :
> > - (1) an Eraser usage without Invert for the upper button
> > - (2) and Eraser with Invert for the eraser tip.

I think you will agree with below traces that :
- (1) : correct (it reports invert=3D0 eraser=3D1 tipSwitch=3D1)
- (2) : no, for the rubber tip, it reports invert=3D1 eraser=3D0 tipSwitch=
=3D1

> > A device-specific driver could work with that, but
> > there seems to be no way to incorporate two different erasers
> > (thus, allowing userspace to map them to different actions
> > arbitrarily) in the generic driver currently. =20
>=20
> That's exactly why I want to see the exact event flow. We can not do
> "wild guesses" unfortunately (not meaning any offenses).
> And I am very suspicious about the fact that the stylus reports 2
> identical erasers. Because in the past David seemed to be able to have
> 2 distincts behaviors for the 2 "buttons" (physical button and eraser
> tail).

The Pen, hardware-wise, has the following possibilities :
- The (main) pressure tip
- The "bottom" button (nearest of the main pressure tip)
- The "top" button (farthest of the main tip
- The "back" pressure tip (it has pressure!) somewhat called rubber

All of those works I think -natively- on my kernel version, without
external 3rd-party kernel modules.

It works especially on Blender, where I can :
- click (or paint) with main pressure-tip
- middle-click (to pan viewport) with "bottom" button + move main tip
- right-click with "top" button
- erase with backside pressure-tip

I installed a .deb from the official website [1] which does not contain
kernel modules, and seems to only contains :
- a udev rule to, I think, chmod 0666 to input character devices
- a Qt app to configure some behavior, only userland-side.

I think I observed that before running the Qt app, there was only 3
xinput devices, and after launching it, there were 4 more (7 total).

Blender would not receive pen input without lanching the Qt app.
Indeed, the "first" 3 /dev/input/event* associated to the pen are
chmod'ed too restrictively (0660) for an underprivileged user.

Anyway, after running the Qt App, 4 *ANOTHER* /dev/input/event* pops,
correctly chmod'ed (thanks to the udev rules), and Blender works.

My best guess would be that the first 3 very-native /dev/input/
devices are somewhat "raw", and that the Qt app feeds those inputs to
the Qt app's configured pressure curve + remap the button to the input
as chosen by the user.

Here is the dmesg before launching the Qt App :
-----8<-----8<-----8<-----8<
usb 3-9: new full-speed USB device number 64 using xhci_hcd
usb 3-9: New USB device found, idVendor=3D28bd, idProduct=3D095b,
bcdDevice=3D 0.00
usb 3-9: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
usb 3-9: Product: Artist Pro 16 (Gen2)
usb 3-9: Manufacturer: UGTABLET
usb 3-9: SerialNumber: 00000
input: UGTABLET Artist Pro 16 (Gen2) Mouse as
/devices/pci0000:00/0000:00:02.1/0000:04:00.0/0000:05:08.0/0000:07:00.0/
0000:08:0c.0/0000:69:00.0/usb3/3-9/3-9:1.0/0003:28BD:095B.009E/input/input1=
96
input: UGTABLET Artist Pro 16 (Gen2) Keyboard as
/devices/pci0000:00/0000:00:02.1/0000:04:00.0/0000:05:08.0/0000:07:00.0/
0000:08:0c.0/0000:69:00.0/usb3/3-9/3-9:1.0/0003:28BD:095B.009E/input/input1=
97
hid-generic 0003:28BD:095B.009E: input,hidraw4: USB HID v1.00 Mouse
[UGTABLET Artist Pro 16 (Gen2)] on usb-0000:69:00.0-9/input0
input: UGTABLET Artist Pro 16 (Gen2) as
/devices/pci0000:00/0000:00:02.1/0000:04:00.0/0000:05:08.0/0000:07:00.0/
0000:08:0c.0/0000:69:00.0/usb3/3-9/3-9:1.1/0003:28BD:095B.009F/input/input1=
98
hid-generic 0003:28BD:095B.009F: input,hidraw7: USB HID v1.00 Device
[UGTABLET Artist Pro 16 (Gen2)] on usb-0000:69:00.0-9/input1
hid-generic 0003:28BD:095B.00A0: hiddev0,hidraw12: USB HID v1.00 Device
[UGTABLET Artist Pro 16 (Gen2)] on usb-0000:69:00.0-9/input2
-----8<-----8<-----8<-----8<

This make "sudo xinput" reports 3 new devices :
UGTABLET Artist Pro 16 (Gen2) Mouse id=3Dx [slave pointer (n)]
UGTABLET Artist Pro 16 (Gen2) Keyboard id=3Dy [slave keyboard (n+1)]
UGTABLET Artist Pro 16 (Gen2) id=3Dz [slave keyboard (n+1)]
(sorry I've masked the id to prevent confusion, I did not run "xinput"
at the same time/power cycle than "dmesg")

Running the Qt App makes "sudo xinput" report 4 new devices :
XP-Pen Mouse id=3Dxc [slave pointer (n)]
XP-Pen Eraser id=3Dxa [slave keyboard (n+1)]
XP-Pen Pen id=3Dxb [slave keyboard (n+1)] << only this chmod'ed 0666
XP-Pen Mouse id=3Dxd [slave keyboard (n+1)]

And... it suffices to make Blender works without configuring anything.

Anyway, besides this user experience / userland Qt app, here are some
five hid-recorder traces ;
I re-used the terminology appearing in the traces :
- "barrel" : the "bottom" button nearest of the main tip
- "erase" : the farther "top" button, just above "barrel"
- "back" : the "rubber" secondary pressure tip at the back of the pen

(1) hidraw7_inRange_contact_move_lift_outOfRange
I "contact" the main tip, move it, and lift it out or range.

(2) hidraw7_inRange_contact_barrelPress\
_move_barrelRelease_lift_outOfRange
I "contact" the main tip, press "barrel" (which is the button nearest
of the tip), move the pen, release the button, move it out of range.

(3) hidraw7_inRange_contact_erasePress\
_move_eraseRelease_lift_outOfRange
The same than above, except that I instead use the "erase" button,
i.e. the button just above ("vertically speaking") of the "main" button.

(4) hidraw7_inRange_contact_BOTHbarrelAnderasePress_move_\
BOTHbarrelAnderaseRelease_lift_outOfRange
That's just plain stupid, and uncomfortable to do, but it's just to
show an example of the capability of the hardware ;
In this one, I'm doing the same than above, except I stupidly press BOTH
buttons.
It means that I "contact" the main tip, press both barrel+erase, move
the pen, release both button, lift it out of range.

(5) hidraw7_inRange_contact_backPress_move_backRelease_lift_outOfRange
Back to non-stupid tests, here I am using the "rubber" (which has
pressure !), i.e. I use the back of the pen.
I contact it, press the rubber to have some pressure, move it, release
the pressure, move the pen ouf of contact and out of range.

Reading those traces, I think I observed some (to me) very logical
behavior ;

I agree that the Pen is possibly not acting in respect of the
specification, by the fact that... the spec does not differentiate the
"eraser" 2nd button, versus the "backside" rubber pressure tip.

The traces shows that :
- In range [0 - 1] is correctly reported, both for main tip + rubber tip
- Tip Pressure [0 - n] is correctly reported, for both pressure tips

- Tip Switch [0 - 1] is correctly set to ONE for all traces, when the
  in-range tip goes to contact. (either main tip or rubber tip)

- Barrel Switch [0 - 1] is correctly set to ONE only when pressing
  button down, and of course only when using the main tip

- Invert [0 - 1] is set to ONE when (and only) using the back rubber
  tip, and the ERASE button (2nd button) does NOT set it, so "INVERT"

- Eraser [0 - 1] is set to ONE ONLY when pressing the 2nd top button,
  and of :
  - ONLY when using the main itp
  - and if you were to instead use the "back" of the pen (rubber tip),
    then you will have invert=3D1 + eraser=3D0

The main extract of those is, I think, that :
- eraser "top" button is completely independent of the back "rubber"
- eraser "top" button NEVER concerns itself to set invert=3D1
- backside "rubber" pressure tip will set invert=3D1, but leave eraser=3D0

So, the behavior probably breaks the specs, but sincerely I'm happy to
have the "eraser" button independent of the "rubber eraser", which
makes the stylus a somewhat 4-buttons stylus (tip, button1, button2,
rubber), and I would like to keep this.

Best Regards,

[1] https://www.xp-pen.fr/download-1027.html ; the .deb Qt app

--=20
Eric GOUYER
