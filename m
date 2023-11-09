Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301747E69E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjKILs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKILs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B321FEA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699530487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouPBDpRxc5cEOBjMwovayc5MQYZY8bX6UAk2LVNeErc=;
        b=D1fQEBkBj092blq5H3oBQe5bMuTG8+NfrxvnZi0D7HZ1UZ5AFdISZaYDMOgKUEn4CimkSr
        cEnYmaoELRh55AVHvNePM+q5nO+MckM3gN9l6xuRAW6sJZNz8FZhE4fHGnp/nS+FZoa4iB
        kMGJeqyW0g3XfTJDnSOrmqplLlIWjoI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Rub7SUkXOb6zXCJO2G1_Mg-1; Thu, 09 Nov 2023 06:48:06 -0500
X-MC-Unique: Rub7SUkXOb6zXCJO2G1_Mg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9e1020e2996so61764166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530484; x=1700135284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouPBDpRxc5cEOBjMwovayc5MQYZY8bX6UAk2LVNeErc=;
        b=ALtZWS6mtiejbK7ZscUZ/J3Ia5QDw/6lVPTAaZuIB2ERpjtn4iKL9Cn0GHZ9cNDktu
         u8nI0xnPGiiR9QNXYO/Rtg6+JU5XztTxUpPeJWAk7D/xVvfuRUiPBCuaFHWS+yAPLcLw
         2c+pJoR5slk3yncMtBk899myoUDplUiS9naF4kJb4o4+nO2Gre3GvhytsSQAMWyVeZL5
         2tykGmzVpJZOovx7KonXO85KP6+iQH1XguYAKqi9+Giw7Mn9jfQu4FWx9uX060kfbGdu
         bn+IrI36FNBD7hAJzdGktbcCtjz20C06jRUdhGoLtAqrQzdreBiWT1SFH9Z7ZiHl2VEw
         H5kA==
X-Gm-Message-State: AOJu0YxCXVVtV82ML46QvOkny0KCf3dtYFlIH9lHtRBi1RKJtI2REu7X
        M/qX/4XQrxQA4vnjW3TUORlXZ5PyNXWPTrkU54YQiaLKj/bhbG36C2W9lT4VXR6QS4KTqkbUwd6
        Ilb7B7jN3G9C164XDQ/v8QuJnlks05djIHS4Td7BUxWRKJBfU
X-Received: by 2002:a17:907:ea6:b0:9e1:46a2:b827 with SMTP id ho38-20020a1709070ea600b009e146a2b827mr4357065ejc.29.1699530484714;
        Thu, 09 Nov 2023 03:48:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAEH2uL1uOIqy1J9TKIH6vxPugMmWZqnXzhJ/jMbyp5T5l5mx/gtw6f5M2GYsMMlZS84z6zB97BjxSfj21T/8=
X-Received: by 2002:a17:907:ea6:b0:9e1:46a2:b827 with SMTP id
 ho38-20020a1709070ea600b009e146a2b827mr4357043ejc.29.1699530484394; Thu, 09
 Nov 2023 03:48:04 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de> <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
 <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
 <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com> <A01KgwZWh8vP1ux3J92E572eCVMfYPzBcHLuuGfSTYntQMVErkqIcPhJtWRxJsinbI_AfHvD_GcnGvQ1kFtxR36ozCPj_VH8Ys8OlA02MZQ=@protonmail.com>
In-Reply-To: <A01KgwZWh8vP1ux3J92E572eCVMfYPzBcHLuuGfSTYntQMVErkqIcPhJtWRxJsinbI_AfHvD_GcnGvQ1kFtxR36ozCPj_VH8Ys8OlA02MZQ=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 9 Nov 2023 12:47:52 +0100
Message-ID: <CAO-hwJJ3jxoWq0bcAZkVrDTySdYrkHs30NDGdMwTp2KPbJDmEg@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>, jkosina@suse.cz,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 12:19=E2=80=AFAM David Revoy <davidrevoy@protonmail.=
com> wrote:
>
> > BTW, David, were you able to do a revert of 276e14e6c3?
>
> I'm sorry Benjamin: I did some research on how to build a kernel [1], on =
how to revert a commit (easy, I know a bit of Git), and started following i=
t step by step. Result: I failed and concluded that it probably requires to=
o much computer knowledge compared to what I can do now. I'm afraid I won't=
 be able to build a custom kernel for testing.

No worries. And I'm actually happy, because you definitely fit into
the HID-BPF model where I want to fix a user's device without
requiring kernel compilation, and fixing the device in a reliable way
that we can do the general fix without impacting the reporter.

Cheers,
Benjamin

>
> [1] https://docs.fedoraproject.org/en-US/quick-docs/kernel-build-custom/#=
_building_a_vanilla_upstream_kernel
>
>
> On Tuesday, November 7th, 2023 at 08:59, Benjamin Tissoires <benjamin.tis=
soires@redhat.com> wrote:
>
>
> > On Mon, Nov 6, 2023 at 9:06=E2=80=AFPM Illia Ostapyshyn
> > ostapyshyn@sra.uni-hannover.de wrote:
> >
> > > On 11/6/23 17:59, Benjamin Tissoires wrote:
> > >
> > > > If the pen has 2 buttons, and an eraser side, it would be a serious
> > > > design flow for XPPEN to report both as eraser.
> > > >
> > > > Could you please use sudo hid-recorder from hid-tools[1] on any ker=
nel
> > > > version and send us the logs here?
> > > > I'll be able to replay the events locally, and understand why the
> > > > kernel doesn't work properly.
> > > >
> > > > And if there is a design flaw that can be fixed, we might even be a=
ble
> > > > to use hid-bpf to change it :)
> > >
> > > My wild guess is that XP-Pen 16 Artist Pro reports an Eraser usage
> > > without Invert for the upper button and Eraser with Invert for the
> > > eraser tip. A device-specific driver could work with that, but there
> > > seems to be no way to incorporate two different erasers (thus, allowi=
ng
> > > userspace to map them to different actions arbitrarily) in the generi=
c
> > > driver currently.
> >
> >
> > That's exactly why I want to see the exact event flow. We can not do
> > "wild guesses" unfortunately (not meaning any offenses).
> > And I am very suspicious about the fact that the stylus reports 2
> > identical erasers. Because in the past David seemed to be able to have
> > 2 distincts behaviors for the 2 "buttons" (physical button and eraser
> > tail).
> >
> > > > Generally speaking, relying on X to fix your hardware is going to b=
e a
> > > > dead end. When you switch to wayland, you'll lose all of your fixes=
,
> > > > which isn't great.
> > >
> > > > AFAIU, the kernel now "merges" both buttons, which is a problem. It
> > > > seems to be a serious regression. This case is also worrying becaus=
e I
> > > > added regression tests on hid, but I don't have access to all of th=
e
> > > > various tablets, so I implemented them from the Microsoft
> > > > specification[0]. We need a special case for you here.
> > >
> > > The issue preventing David from mapping HID_DG_ERASER to BTN_STYLUS2 =
is
> > > that the hidinput_hid_event is not compatible with hidinput_setkeycod=
e.
> > > If usage->code is no longer BTN_TOUCH after remapping, it won't be
> > > released when Eraser reports 0. A simple fix is:
> >
> >
> > I must confess, being the one who refactored everything, I still don't
> > believe this is as simple as it may seem. I paged out all of the
> > special cases, and now, without seeing the event flow I just can not
> > understand why this would fix the situation.
> >
> > And BTW, if you have a tool affected by 276e14e6c3, I'd be curious to
> > get a hid-recorder sample for it so I can get regression tests for it.
> >
> > > --- a/drivers/hid/hid-input.c
> > > +++ b/drivers/hid/hid-input.c
> > > @@ -1589,7 +1589,7 @@ void hidinput_hid_event(struct hid_device *hid,
> > > struct hid_field field, struct
> > > / value is off, tool is not rubber, ignore */
> > > return;
> > > else if (*quirks & HID_QUIRK_NOINVERT &&
> > > - !test_bit(BTN_TOUCH, input->key)) {
> > > + !test_bit(usage->code, input->key)) {
> >
> >
> > I don't want to be rude, but this feels very much like black magic,
> > especially because there is a comment just below and it is not
> > updated. So either the explanation was wrong, or it's not explaining
> > the situation (I also understand that this is not a formal submission,
> > so maybe that's the reason why the comment is not updated).
> >
> > > /*
> > > * There is no invert to release the tool, let hid_input
> > > * send BTN_TOUCH with scancode and release the tool after.
> > >
> > > This change alone fixes David's problem and the right-click mapping i=
n
> > > hwdb works again. However, the tool switches to rubber for the remapp=
ed
> > > eraser (here BTN_STYLUS2) events, both for devices with and without
> > > Invert. This does no harm but is not useful either. A cleaner solutio=
n
> > > for devices without Invert would be to omit the whole tool switching
> > > logic in this case:
> > >
> > > @@ -1577,6 +1577,9 @@ void hidinput_hid_event(struct hid_device *hid,
> > > struct hid_field *field, struct
> > >
> > > switch (usage->hid) {
> > > case HID_DG_ERASER:
> > > + if (*quirks & HID_QUIRK_NOINVERT && usage->code !=3D BTN_TOUCH)
> > > + break;
> > > +
> > > report->tool_active |=3D !!value;
> > >
> > > Remapping Invert does not work anyway as the Invert tool is hardcoded=
 in
> > > hidinput_hid_event. Even worse, I guess (not tested) trying to do so
> > > would mask BTN_TOOL_RUBBER from dev->keybit and could cause weird
> > > behavior similar to one between 87562fcd1342 and 276e14e6c3. This
> > > raises the question: should users be able to remap Invert after all?
> >
> >
> > The kernel is supposed to transfer what the device is. So if it says
> > this is an eraser, we should not try to change it. Users can then
> > tweak their own device if they wish through hid-bpf or through
> > libinput quirks, but when you install a fresh kernel without tweaks,
> > we should be as accurate as possible.
> >
> > My main concern is that now we have a device which exports 2 different
> > interactions as being the same. So either the firmware is wrong, and
> > we need to quirk it, or the kernel is wrong and merges both, and this
> > needs fixes as well.
> >
> > Once every interaction on the device gets its own behavior, userspace
> > can do whatever they want. It's not the kernel's concern anymore.
> >
> > BTW, David, were you able to do a revert of 276e14e6c3?
> >
> > Cheers,
> > Benjamin
>

