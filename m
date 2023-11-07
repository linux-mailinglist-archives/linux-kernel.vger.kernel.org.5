Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8557E3629
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjKGIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjKGIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9AFD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699344004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fS33WX/TP1PBbgnGRlYS4ZqDoFTuXKV4PZ845SjCyEc=;
        b=YA2lBfx7Wrd6i8FuWBzkq4X7pJVh541adBHrnb3yUmUAnW/g3b89YC89YPMa6SKzDzxy0S
        ILZhK8saSBPDiwXMywkvdWKH/L3aguSIray4rptfuA9laMyQOKFSMjR6PL5nyl91oFqylK
        SJ+MC9rPfWBK6WfbcFX16iupp/33oP8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-1_8S739kOQ6q5yGm9A9SSg-1; Tue, 07 Nov 2023 03:00:03 -0500
X-MC-Unique: 1_8S739kOQ6q5yGm9A9SSg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9dd489c98e7so256513666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 00:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344002; x=1699948802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS33WX/TP1PBbgnGRlYS4ZqDoFTuXKV4PZ845SjCyEc=;
        b=MP6pXTlEKEm0k967ai5f9TY0kmmJrRYRqcwL2aar89yMFkk63UGlvDJSw9qDaZaAOy
         /zlTlu7BiesfIS1OeJ565KLFJmMblKQWZJdtZ+Xz9eNEOrw970TVGR+hjHTDwqaO0Q7A
         mC40xq+80bMFjdwdMmTgqbYQUyL8sS0Jf0wOSo3ycmgyqVhQbs0FxbtHwV/BEbyPjwLK
         sEjz09zsdSoTp5K96lzElo8LOroO34urADWUHcknTiFma4ciAy9uqcdlNkEm2Qc2XmFi
         Sl4ykOP6/EHGxfWxC+JRvnnjilur6azhfr3ttNxKPtprCHoOFHgisTqF0YrqatsKd3+D
         t0Hg==
X-Gm-Message-State: AOJu0YzBffoLIWeRmdSLZfA4tjSCF7aVbkz9p7bbG8jN+1fjPU4LDmmb
        Er6AvMyinSRfz2lWciroU9BVQDcBEvSyAvS0DstQTEMPR69wWsNFPiNnOMJulbO0c0ZgfdmA/l3
        3rTd5BjUGgJhI4kfpYnZ6y13OAfS0j5jcuANl1Lef
X-Received: by 2002:a17:907:1392:b0:9d6:e1b5:1afa with SMTP id vs18-20020a170907139200b009d6e1b51afamr10270530ejb.46.1699344002158;
        Tue, 07 Nov 2023 00:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA8+5QQSDmxCU+xJTHQaQQA6ateLho1sCb2m5X93a+V/hkk0uakR0CKeLROgbnj7bo4pQQdVBXLsuog22tlTw=
X-Received: by 2002:a17:907:1392:b0:9d6:e1b5:1afa with SMTP id
 vs18-20020a170907139200b009d6e1b51afamr10270509ejb.46.1699344001694; Tue, 07
 Nov 2023 00:00:01 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de> <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com> <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
In-Reply-To: <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 7 Nov 2023 08:59:50 +0100
Message-ID: <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
Cc:     David Revoy <davidrevoy@protonmail.com>, jkosina@suse.cz,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 9:06=E2=80=AFPM Illia Ostapyshyn
<ostapyshyn@sra.uni-hannover.de> wrote:
>
> On 11/6/23 17:59, Benjamin Tissoires wrote:
>
> > If the pen has 2 buttons, and an eraser side, it would be a serious
> > design flow for XPPEN to report both as eraser.
> >
> > Could you please use sudo hid-recorder from hid-tools[1] on any kernel
> > version and send us the logs here?
> > I'll be able to replay the events locally, and understand why the
> > kernel doesn't work properly.
> >
> > And if there is a design flaw that can be fixed, we might even be able
> > to use hid-bpf to change it :)
>
> My wild guess is that XP-Pen 16 Artist Pro reports an Eraser usage
> without Invert for the upper button and Eraser with Invert for the
> eraser tip.  A device-specific driver could work with that, but there
> seems to be no way to incorporate two different erasers (thus, allowing
> userspace to map them to different actions arbitrarily) in the generic
> driver currently.

That's exactly why I want to see the exact event flow. We can not do
"wild guesses" unfortunately (not meaning any offenses).
And I am very suspicious about the fact that the stylus reports 2
identical erasers. Because in the past David seemed to be able to have
2 distincts behaviors for the 2 "buttons" (physical button and eraser
tail).

>
>
> > Generally speaking, relying on X to fix your hardware is going to be a
> > dead end. When you switch to wayland, you'll lose all of your fixes,
> > which isn't great.
>
> > AFAIU, the kernel now "merges" both buttons, which is a problem. It
> > seems to be a serious regression. This case is also worrying because I
> > added regression tests on hid, but I don't have access to all of the
> > various tablets, so I implemented them from the Microsoft
> > specification[0]. We need a special case for you here.
>
> The issue preventing David from mapping HID_DG_ERASER to BTN_STYLUS2 is
> that the hidinput_hid_event is not compatible with hidinput_setkeycode.
> If usage->code is no longer BTN_TOUCH after remapping, it won't be
> released when Eraser reports 0.  A simple fix is:

I must confess, being the one who refactored everything, I still don't
believe this is as simple as it may seem. I paged out all of the
special cases, and now, without seeing the event flow I just can not
understand why this would fix the situation.

And BTW, if you have a tool affected by 276e14e6c3, I'd be curious to
get a hid-recorder sample for it so I can get regression tests for it.

>
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1589,7 +1589,7 @@ void hidinput_hid_event(struct hid_device *hid,
> struct hid_field *field, struct
>                         /* value is off, tool is not rubber, ignore */
>                         return;
>                 else if (*quirks & HID_QUIRK_NOINVERT &&
> -                        !test_bit(BTN_TOUCH, input->key)) {
> +                        !test_bit(usage->code, input->key)) {

I don't want to be rude, but this feels very much like black magic,
especially because there is a comment just below and it is not
updated. So either the explanation was wrong, or it's not explaining
the situation (I also understand that this is not a formal submission,
so maybe that's the reason why the comment is not updated).

>                         /*
>                          * There is no invert to release the tool, let hi=
d_input
>                          * send BTN_TOUCH with scancode and release the t=
ool after.
>
> This change alone fixes David's problem and the right-click mapping in
> hwdb works again.  However, the tool switches to rubber for the remapped
> eraser (here BTN_STYLUS2) events, both for devices with and without
> Invert.  This does no harm but is not useful either.  A cleaner solution
> for devices without Invert would be to omit the whole tool switching
> logic in this case:
>
> @@ -1577,6 +1577,9 @@ void hidinput_hid_event(struct hid_device *hid,
> struct hid_field *field, struct
>
>         switch (usage->hid) {
>         case HID_DG_ERASER:
> +               if (*quirks & HID_QUIRK_NOINVERT && usage->code !=3D BTN_=
TOUCH)
> +                       break;
> +
>                 report->tool_active |=3D !!value;
>
> Remapping Invert does not work anyway as the Invert tool is hardcoded in
> hidinput_hid_event.  Even worse, I guess (not tested) trying to do so
> would mask BTN_TOOL_RUBBER from dev->keybit and could cause weird
> behavior similar to one between 87562fcd1342 and 276e14e6c3.  This
> raises the question: should users be able to remap Invert after all?
>

The kernel is supposed to transfer what the device is. So if it says
this is an eraser, we should not try to change it. Users can then
tweak their own device if they wish through hid-bpf or through
libinput quirks, but when you install a fresh kernel without tweaks,
we should be as accurate as possible.

My main concern is that now we have a device which exports 2 different
interactions as being the same. So either the firmware is wrong, and
we need to quirk it, or the kernel is wrong and merges both, and this
needs fixes as well.

Once every interaction on the device gets its own behavior, userspace
can do whatever they want. It's not the kernel's concern anymore.

BTW, David, were you able to do a revert of 276e14e6c3?

Cheers,
Benjamin

