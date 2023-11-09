Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C387E6A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjKIL6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjKIL5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:57:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E682D77
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699531016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxgiQfG57B8WYlQaIBGWpOfAz7KPJ/cKr6geqUfke5Q=;
        b=BV04ozt1bDX+AHd02NEvQu29HD4t1u683fV0WuphxJO7QMiWiEgySkA/rTF1XuJnSkTbQN
        K3RTOFdUMFk2u3MXMVui265isNYJY+ETjB9xShQvPirKdX878F8m2qyvOSbPUWkHOhBqs/
        UQkP77If/yOj+nPZzVMyhIKU9vT5XgY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-ddkg78dLO5K5UVv3skO56A-1; Thu, 09 Nov 2023 06:56:55 -0500
X-MC-Unique: ddkg78dLO5K5UVv3skO56A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e293cd8269so66800166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699531014; x=1700135814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxgiQfG57B8WYlQaIBGWpOfAz7KPJ/cKr6geqUfke5Q=;
        b=E5QW0pMWB+pvB6d0J+pJzQMWLadEJMkeigMQSa+Amwu+eTFjs7aqmKAqmhxEF5F0/6
         OzpMXzqQDSdvOI4vBnzTzb5BU5mqFdlJ2WeuwCrwwcKMfqmzeAxMpGe0KWMsmOnQZvJP
         huvwJ5TDetJftmn18l1Qt+xBdlUiPozk6qv8jluKJNNZj9q3K00BuWxdNmKC9waAtyhI
         RpI1DBRJmQLEd/Py9PFLomifMyrOHBd+MLGtxbTi4Zd2jNszQzxqESc8ciswAgkpbY4F
         krGWcjpxMjtHB78D7+ZLE2B4HOkoEqCUq0kD1HINX3ziP2AYndqCfQun55f4kOpTGRQn
         J5Vw==
X-Gm-Message-State: AOJu0YyEY0lOaQq6qMP5JZF9ETa9Y/secIWgoldzhZpJdbFHqJNQN9ty
        FnsMqKLQbjqlAwq8ZRFKG+LFOrE4DjXwpqQDmrFME+gxN5964DGjR8tawmgxYv/YnDfzii+64Pj
        QTfCqIr9Lw3JpIW22WK6+NRbUsYMG/tklhpOmD9nk
X-Received: by 2002:a17:907:72d2:b0:9e0:5d5c:aa6d with SMTP id du18-20020a17090772d200b009e05d5caa6dmr4139560ejc.20.1699531014202;
        Thu, 09 Nov 2023 03:56:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxlrCZEP0Zf3bUap3zbIZY7FqJUmcGsAUa5ALjEfjFj+HW1CWZDvytrHMWS0qZ2D2ZlOhPOClx5L48I6cUeuc=
X-Received: by 2002:a17:907:72d2:b0:9e0:5d5c:aa6d with SMTP id
 du18-20020a17090772d200b009e05d5caa6dmr4139541ejc.20.1699531013829; Thu, 09
 Nov 2023 03:56:53 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
 <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
 <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
 <20231108062306.33f5dcd0@dryade> <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
 <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com>
 <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com> <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
In-Reply-To: <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 9 Nov 2023 12:56:41 +0100
Message-ID: <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Nov 9, 2023 at 1:32=E2=80=AFAM David Revoy <davidrevoy@protonmail.c=
om> wrote:
>
> Hi Benjamin,
>
> > Alright, I made quite some progress so far:
> > - regressions tests have been written (branch wip/xp-pen of my fork on
> > freedesktop[0])
> > that branch can not go in directly as it just adds the tests, and
> > thus is failing
> > - I made the fixes through HID-BPF[1]
> >
> > Anyone using those 2 tablets and using Fedora should be able to just
> > grab the artifact at [2], uncompress it and run `sudo ./install.sh --ve=
rbose`.
> > This will install the bpf programs in /lib/firmware/hid/bpf/ and will
> > automatically load them when the device is connected.
> >
> > For those not using Fedora, the binary might work (or not, not sure),
> > but you can always decompress it, and check if running
> > `udev-hid-bpf_0.1.0/bin/udev-hid-bpf --version` returns the correct
> > version or just fails. If you get "udev-hid-bpf 0.1.0", then running
> > `sudo ./install.sh --verbose` should work, as long as the kernel has
> > CONFIG_HID_BPF set to 'Y'.
> > [...]
> > [0] https://gitlab.freedesktop.org/bentiss/hid/-/tree/wip/xp-pen?ref_ty=
pe=3Dheads
> > [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_reques=
ts/27
> > [2] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/jobs/51350589=
/artifacts/raw/udev-hid-bpf_0.1.0.tar.xz
>
> Thank you for this package.
>
> I was able to test it even though the link in (2) at the bottom of your e=
mail returned a blank page. I was able to find my way after manually visiti=
ng gitlab.freedesktop.org [1] and then manually downloading the article fro=
m 51350589. I unzipped it and ran `sudo ./install.sh --verbose`. Everything=
 looks like it was successful [2]. I then rebooted my Fedora 38 'Linux work=
station 6.5.8-200.fc38.x86_64' kernel (the one I blamed in my post) and tes=
ted both tablets.

Weird that you had to manually retrieve it. It works here, but maybe
because I am logged in on gitlab.fd.o.

Also, just FYI, you shouldn't have to reboot. Just unplug/replug and
you are good. In the same way, if you uninstall the package, you can
just unplug/replug to not have the programs loaded.

>
> Here are my observation:
>
> XPPEN Artist Pro 24
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Nothing changed for this device (it's the one with two buttons and no 'er=
aser tip'). Nor my hwdb/udev rules or `xsetwacom set "UGTABLET 24 inch PenD=
isplay eraser" button 1 3` affects the upper button of the stylus: if I hol=
d it hover the canvas, Krita switch the tool and cursor for an eraser. If I=
 click on the canvas with the pen tip while holding the upper button presse=
d, I get the right-click Pop-up Palette (but not all the time, probably Kri=
ta has hard time to triage Eraser or Right-click).

As I mentioned in another reply, the more I think of it, the more I
think I should get rid of the "eraser mode". In that Artist Pro 24 I
can detect it through the same mechanics as the HID_QUIRK_NOINVERT
from Illia's patch. But instead of trying to force the device into the
eraser mode, we should just say "this is actually BUTTON_STYLUS_2".

So I'm going to amend the bpf program to do this and hopefully you
won't need the hwdb/udev rule at all.

>
> XPPEN Artist Pro 16 (Gen2)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Something changed. `xsetwacom set "UGTABLET Artist Pro 16 (Gen2) eraser" =
button 1 3` successfully affected the upper button of the stylus. Now if I =
click it while hovering the canvas, Krita shows the right click Pop-up Pale=
tte.

I'm surprised you need to teach the wacom driver that BTN_STYLUS_2 is
the right click.

> On the downside; the real eraser tip when I flip the stylus bugs. When I =
flip the stylus on eraser hovering the canvas, Krita shows the Eraser icon =
and switch tool. As soon as I draw with the eraser tip, Krita will also sho=
w a right-click color palette and with also not a 100% consistency, as if t=
he event were mixed.

I'll investigate. Maybe I messed up with my event flow patch.

But just to be sure, you don't have a custom configuration in place
for that tablet device?

Cheers,
Benjamin

>
> [1] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/artifacts
> [2] https://www.peppercarrot.com/extras/temp/2023-11-09_screenshot_005214=
_net.jpg
>
>
> On Wednesday, November 8th, 2023 at 19:21, Benjamin Tissoires <benjamin.t=
issoires@redhat.com> wrote:
>
>
> > On Wed, Nov 8, 2023 at 10:34=E2=80=AFAM Benjamin Tissoires
> > benjamin.tissoires@redhat.com wrote:
> >
> > > On Wed, Nov 8, 2023 at 10:23=E2=80=AFAM Jos=C3=A9 Exp=C3=B3sito jose.=
exposito89@gmail.com wrote:
> > >
> > > > Hi Benjamin,
> > > >
> > > > On Wed, Nov 08, 2023 at 10:04:30AM +0100, Benjamin Tissoires wrote:
> > > > [...]
> > > >
> > > > > > So, the behavior probably breaks the specs, but sincerely I'm h=
appy to
> > > > > > have the "eraser" button independent of the "rubber eraser", wh=
ich
> > > > > > makes the stylus a somewhat 4-buttons stylus (tip, button1, but=
ton2,
> > > > > > rubber), and I would like to keep this.
> > > > >
> > > > > Yes, and I'd like to keep it that way, even if 6.6 and 6.5.8
> > > > > apparently broke it.
> > > > >
> > > > > So, to me:
> > > > > - 276e14e6c3993317257e1787e93b7166fbc30905 is wrong: this is a
> > > > > firmware bug (reporting invert through eraser) and should not be
> > > > > tackled at the generic level, thus it should be reverted
> > > > > - both of these tablets are forwarding the useful information, bu=
t not
> > > > > correctly, which confuses the kernel
> > > > > - I should now be able to write regression tests
> > > > > - I should be able to provide HID-BPF fixes for those tablets so =
that
> > > > > we can keep them working with or without
> > > > > 276e14e6c3993317257e1787e93b7166fbc30905
> > > > > reverted (hopefully)
> > > > > - problem is I still don't have the mechanics to integrate the HI=
D-BPF
> > > > > fixes directly in the kernel tree, so maybe I'll have to write a
> > > > > driver for XP-Pen while these internals are set (it shouldn't
> > > > > interfere with the HID-BPF out of the tree).
> > > >
> > > > I already added support for a few XP-Pen devices on the UCLogic dri=
ver
> > > > and I was planning to start working on this one during the weekend =
in
> > > > my DIGImend fork (to simplify testing).
> > > >
> > > > Let me know if you prefer to add it yourself or if you want me to p=
ing
> > > > you in the DIGImend discussion.
> > >
> > > So far, I really have to work on this now. It's a good use case for
> > > HID-BPF and it's a regression that I'd like to be fixed ASAP.
> > > I'd appreciate any reviews :)
> >
> >
> > Alright, I made quite some progress so far:
> > - regressions tests have been written (branch wip/xp-pen of my fork on
> > freedesktop[0])
> > that branch can not go in directly as it just adds the tests, and
> > thus is failing
> > - I made the fixes through HID-BPF[1]
> >
> > Anyone using those 2 tablets and using Fedora should be able to just
> > grab the artifact at [2], uncompress it and run `sudo ./install.sh --ve=
rbose`.
> > This will install the bpf programs in /lib/firmware/hid/bpf/ and will
> > automatically load them when the device is connected.
> >
> > For those not using Fedora, the binary might work (or not, not sure),
> > but you can always decompress it, and check if running
> > `udev-hid-bpf_0.1.0/bin/udev-hid-bpf --version` returns the correct
> > version or just fails. If you get "udev-hid-bpf 0.1.0", then running
> > `sudo ./install.sh --verbose` should work, as long as the kernel has
> > CONFIG_HID_BPF set to 'Y'.
> >
> > > Also, good to know that I can probably piggyback on hid-uclogic for
> > > fixing those 2 devices in the kernel.
> >
> >
> > Next step will be to fix them using a kernel driver, but it seems that
> > the uclogic driver is doing more than just report descriptor fixups,
> > so maybe I'll have to use a different driver.
> > But the point is, in theory, if you are affected by those bugs, using
> > the udev-hid-bpf should fix the issue, and this should also be
> > resilient to further kernel updates.
> >
> > I'd appreciate testing when I got the full kernel series up and ready,
> > of course.
> >
> > Cheers,
> > Benjamin
> >
> > [0] https://gitlab.freedesktop.org/bentiss/hid/-/tree/wip/xp-pen?ref_ty=
pe=3Dheads
> > [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_reques=
ts/27
> > [2] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/jobs/51350589=
/artifacts/raw/udev-hid-bpf_0.1.0.tar.xz
>

