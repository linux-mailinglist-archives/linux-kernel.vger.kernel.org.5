Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849F680D0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbjLKQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjLKQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:17:44 -0500
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300A2F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:17:19 -0800 (PST)
X-Gm-Message-State: AOJu0YyQeNaCAkI7APjZan9oToMLS4m7M5CK9TgBsQXXOxwJeMiHIrXC
        c8swvOeagxNM9FCc/oTzi7NFZW7L/NNKk5PgesQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khvoinitsky.org;
        s=key1; t=1702311436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tlauZQvcbusLfPAvUuBznCa6z5+JKDd4qAZRVuCWLo=;
        b=rsnW2LhueAD29F4ikRgjp7y9pGnupeJLuF9OiAvQtkfn5ILzPI1v2ZAlxx7wWMHp+Z2JKZ
        zAI+voPYq/yw4GDDLNMXaJ4k6hWBgB8JjMi9+rhHJHxMddXWsjf676/d++CnMmTMOHfGpn
        3y5g6UWHlV57aCtcp9Cx7+agq/a44mU=
X-Google-Smtp-Source: AGHT+IGyoPf6vFddj/69ulbKoPkxMQVt15tDaiD98sW2Bz1vsceLzx0Bj2ynri90sgSIaLbgrGnn5QG7lQMAhaxLLh0=
X-Received: by 2002:a05:6512:2814:b0:50b:f1fc:e181 with SMTP id
 cf20-20020a056512281400b0050bf1fce181mr4733745lfb.5.1702311434406; Mon, 11
 Dec 2023 08:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20230918145042.37368-1-me@khvoinitsky.org> <20230923231522.94060-1-me@khvoinitsky.org>
 <20230923231522.94060-2-me@khvoinitsky.org> <ZXRiiPsBKNasioqH@jekhomev>
 <20231209165648.4rfe4gxubaajrl2z@jekhomev> <20231209182132.i3saw7kcjyykhizu@jekhomev>
In-Reply-To: <20231209182132.i3saw7kcjyykhizu@jekhomev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Mikhail Khvoinitsky <me@khvoinitsky.org>
Date:   Mon, 11 Dec 2023 18:17:02 +0200
X-Gmail-Original-Message-ID: <CAMMabwM2jLvMHvOS151P3M7mQ9mGyAMsMcTS-HoWpeUW_GEFEg@mail.gmail.com>
Message-ID: <CAMMabwM2jLvMHvOS151P3M7mQ9mGyAMsMcTS-HoWpeUW_GEFEg@mail.gmail.com>
Subject: Re: [PATCH] HID: lenovo: Detect quirk-free fw on cptkbd and stop
 applying workaround
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ValdikSS <iam@valdikss.org.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Well, that's unfortunate. As far as I can see, yes, TrackPoint
Keyboard II behaves similarly to 1st gen Trackpoint Keyboard (a.k.a.
Compact) but not quite. The best way would be to make the keyboard not
emulate scrolling at all but not sure if its possible. For cptkbd it
required patching firmware, it might be also the case for 2nd gen.

> Maybe we should map the wheel HID reports to REL_Y/REL_X in
> lenovo_input_mapping_tpIIkbd() to allow libinput to do its wheel emulatio=
n job?

It might work but since emulated wheel events aren't continuous (at
least this is the case with cptkbd), it doesn't make much sense in
comparison with the original implementation =E2=80=94 just ignore the middl=
e
button if scrolling.

I'll try to get the keyboard and check, but at the moment it seems
that the best thing to do is before stopping applying a workaround,
check that it's a Trackpoint Compact keyboard, not anything else. If I
won't be able to find a better solution shortly, I'll make a patch
which makes sure that it's only cptkbd before disabling the
workaround.

On Sat, 9 Dec 2023 at 20:21, Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> On Sat, Dec 09, 2023 at 06:56:48PM +0200, Yauhen Kharuzhy wrote:
> > On Sat, Dec 09, 2023 at 02:50:16PM +0200, Yauhen Kharuzhy wrote:
> > > On Sun, Sep 24, 2023 at 01:58:30AM +0300, Mikhail Khvainitski wrote:
> > > > Built-in firmware of cptkbd handles scrolling by itself (when middl=
e
> > > > button is pressed) but with issues: it does not support horizontal =
and
> > > > hi-res scrolling and upon middle button release it sends middle but=
ton
> > > > click even if there was a scrolling event. Commit 3cb5ff0220e3 ("HI=
D:
> > > > lenovo: Hide middle-button press until release") workarounds last
> > > > issue but it's impossible to workaround scrolling-related issues
> > > > without firmware modification.
> > > >
> > > > Likely, Dennis Schneider has reverse engineered the firmware and
> > > > provided an instruction on how to patch it [1]. However,
> > > > aforementioned workaround prevents userspace (libinput) from knowin=
g
> > > > exact moment when middle button has been pressed down and performin=
g
> > > > "On-Button scrolling". This commit detects correctly-behaving patch=
ed
> > > > firmware if cursor movement events has been received during middle
> > > > button being pressed and stops applying workaround for this device.
> > > >
> > > > Link: https://hohlerde.org/rauch/en/elektronik/projekte/tpkbd-fix/ =
[1]
> > >
> > > This patch breaks a scrolling at my ThinkPad TrackPoint Keyboard II: =
it
> > > starts to report middle-button push/release events with scrolling eve=
nts
> > > between. A support for this keyboard was added in
> > > 24401f291dcc4f2c18b9e2f65763cbaadc7a1528 "HID: lenovo: Add support fo=
r
> > > ThinkPad TrackPoint Keyboard II" commit.
> >
> > I figured this out.
> >
> > This keyboard can emit REL_Y/REL_X events between of middle-button
> > events (if user was moving a cursor and press middle button without of
> > stopping this), so this algorithm does a false-positive detection and s=
witches
> > the workaround off like for patched firmware:
> >
> > Event: time 1702140625.854777, type 2 (EV_REL), code 1 (REL_Y), value 2
> > Event: time 1702140625.854777, -------------- SYN_REPORT ------------
> > Event: time 1702140625.870769, type 1 (EV_KEY), code 274 (BTN_MIDDLE), =
value 1
> > Event: time 1702140625.870769, -------------- SYN_REPORT ------------
> > Event: time 1702140625.870771, type 2 (EV_REL), code 1 (REL_Y), value 2
> > Event: time 1702140625.870771, -------------- SYN_REPORT ------------
> > Event: time 1702140625.970780, type 2 (EV_REL), code 8 (REL_WHEEL), val=
ue -1
> > Event: time 1702140625.970780, -------------- SYN_REPORT ------------
> > Event: time 1702140626.058800, type 2 (EV_REL), code 8 (REL_WHEEL), val=
ue -1
> > Event: time 1702140626.058800, -------------- SYN_REPORT ------------
> > Event: time 1702140630.462974, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e ffa000fb
> > Event: time 1702140630.462974, type 1 (EV_KEY), code 274 (BTN_MIDDLE), =
value 0
> > Event: time 1702140630.462974, -------------- SYN_REPORT ------------
>
> Maybe we should map the wheel HID reports to REL_Y/REL_X in
> lenovo_input_mapping_tpIIkbd() to allow libinput to do its wheel emulatio=
n job?
> I tried this but I am not familiar with HID drivers and had no success.
>
>
> >
> >
> > >
> > > There is an evtest output below:
> > >
> > > Without of commit:
> > >
> > > Middle-button click:
> > > Event: time 1702122290.593300, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 1
> > > Event: time 1702122290.593300, -------------- SYN_REPORT ------------
> > > Event: time 1702122290.593312, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 0
> > > Event: time 1702122290.593312, -------------- SYN_REPORT ------------
> > >
> > > Vertical scrolling:
> > > Event: time 1702122300.441627, type 2 (EV_REL), code 8 (REL_WHEEL), v=
alue -1
> > > Event: time 1702122300.441627, -------------- SYN_REPORT ------------
> > > Event: time 1702122300.565663, type 2 (EV_REL), code 8 (REL_WHEEL), v=
alue -1
> > > Event: time 1702122300.565663, -------------- SYN_REPORT ------------
> > >
> > > Horizontal scrolling:
> > > Event: time 1702122307.845969, type 2 (EV_REL), code 6 (REL_HWHEEL), =
value -1
> > > Event: time 1702122307.845969, -------------- SYN_REPORT ------------
> > > Event: time 1702122307.981954, type 2 (EV_REL), code 6 (REL_HWHEEL), =
value -1
> > > Event: time 1702122307.981954, -------------- SYN_REPORT ------------
> > >
> > >
> > >
> > > After commit:
> > >
> > > Middle-button click:
> > > Event: time 1702125091.290045, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue ffa000fb
> > > Event: time 1702125091.290045, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 1
> > > Event: time 1702125091.290045, -------------- SYN_REPORT ------------
> > > Event: time 1702125092.626118, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue ffa000fb
> > > Event: time 1702125092.626118, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 0
> > > Event: time 1702125092.626118, -------------- SYN_REPORT ------------
> > >
> > >
> > > Vscroll:
> > > Event: time 1702125286.653639, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue ffa000fb
> > > Event: time 1702125286.653639, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 1
> > > Event: time 1702125286.653639, -------------- SYN_REPORT ------------
> > > Event: time 1702125287.929689, type 2 (EV_REL), code 8 (REL_WHEEL), v=
alue -1
> > > Event: time 1702125287.929689, -------------- SYN_REPORT ------------
> > > Event: time 1702125288.037688, type 2 (EV_REL), code 8 (REL_WHEEL), v=
alue -1
> > > Event: time 1702125288.037688, -------------- SYN_REPORT ------------
> > > Event: time 1702125290.481787, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue ffa000fb
> > > Event: time 1702125290.481787, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 0
> > > Event: time 1702125290.481787, -------------- SYN_REPORT ------------
> > >
> > > Hscroll:
> > > Event: time 1702125293.841920, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue ffa000fb
> > > Event: time 1702125293.841920, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 1
> > > Event: time 1702125293.841920, -------------- SYN_REPORT ------------
> > > Event: time 1702125294.761952, type 2 (EV_REL), code 6 (REL_HWHEEL), =
value -1
> > > Event: time 1702125294.761952, -------------- SYN_REPORT ------------
> > > Event: time 1702125294.893967, type 2 (EV_REL), code 6 (REL_HWHEEL), =
value -1
> > > Event: time 1702125294.893967, -------------- SYN_REPORT ------------
> > > Event: time 1702125296.134006, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue ffa000fb
> > > Event: time 1702125296.134006, type 1 (EV_KEY), code 274 (BTN_MIDDLE)=
, value 0
> > > Event: time 1702125296.134006, -------------- SYN_REPORT ------------
> >
> > --
> > Yauhen Kharuzhy
>
> --
> Yauhen Kharuzhy
