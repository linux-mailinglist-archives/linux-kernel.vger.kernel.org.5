Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D2761D36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGYPVy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGYPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:21:52 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21732E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:21:51 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-577497ec6c6so66470477b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298510; x=1690903310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szujVV2fNxJBdwP0iMFABIwD5E3Cm2+QwSS2qKl1XZE=;
        b=WXRK8A8/deJUD/cPgVLA0WQ0/e8+0AjnwPIpTqFtPjPNYK4e8Hzo+MEiW/c+f31/wN
         ADB4ATxV/r0ZJQdg75njQhj7FR/9fRPqMXPbZTXydtgISzwSMdDRrFixSqRVbSlwPecM
         Oabob/zLjX4WI1WknWSXIvTKeXHLRGGCHyXX4Q0G2deND6ZUjUTEakkwIVFN/ag0Mpsz
         NXVidUTmOYIEEW1+8sLmPRwYwQ2iF/1NR2nhGoqqRoxQ6EvYJOzmjFo5/JpdX6w6ESS+
         3M3ZIlMMMztt8Fown6hwmgzCcGsZM7U/rwi420ecesFDM1YflyTaRoKO0YJ8+SHYHJBU
         JVEA==
X-Gm-Message-State: ABy/qLbAk3jUzhwFO+7yFeWNEb83ew9XkMUebNq7D40D+fZsPlSJI8Xs
        y3qLHA0SAcXd79OxoNiHKcC5v3CJWK2HRA==
X-Google-Smtp-Source: APBJJlESQt1y/DQPMtzaJMyeMqLKKUuVAMQiU4ewspNLqowbXGuBsxc02BT9/kUXi2b4Wxljiep+KA==
X-Received: by 2002:a25:a529:0:b0:cfe:9cbd:7186 with SMTP id h38-20020a25a529000000b00cfe9cbd7186mr10375726ybi.12.1690298510032;
        Tue, 25 Jul 2023 08:21:50 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 7-20020a5b0107000000b00d0538bab61asm2257714ybx.65.2023.07.25.08.21.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:21:49 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-583c48a9aa1so34965447b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:21:49 -0700 (PDT)
X-Received: by 2002:a25:f80f:0:b0:d08:a269:8cc3 with SMTP id
 u15-20020a25f80f000000b00d08a2698cc3mr7217042ybd.38.1690298509457; Tue, 25
 Jul 2023 08:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230722180925.1408885-1-hugo@hugovil.com> <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
 <20230725111354.160f32cfba0b53923ac2aae6@hugovil.com>
In-Reply-To: <20230725111354.160f32cfba0b53923ac2aae6@hugovil.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 17:21:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXe7MWpOjeUXjSsdOx0LXmzYCbvDCtt5yEup+1iGe4O=w@mail.gmail.com>
Message-ID: <CAMuHMdXe7MWpOjeUXjSsdOx0LXmzYCbvDCtt5yEup+1iGe4O=w@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

On Tue, Jul 25, 2023 at 5:13 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> On Mon, 24 Jul 2023 18:08:00 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, Jul 22, 2023 at 8:18 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> > > does NOT change the DDRAM address to 00h (home position) like the
> > > standard Hitachi HD44780 controller. As a consequence, the starting
> > > position of the initial string LCD_INIT_TEXT is not guaranteed to be
> > > at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> > > command.
> > >
> > > Extract of DISPLAY_CLEAR command from datasheets of:
> > >
> > >     Hitachi HD44780:
> > >         ... It then sets DDRAM address 0 into the address counter...
> > >
> > >     NewHaven NHD-0220DZW-AG5 datasheet:
> > >         ... This instruction does not change the DDRAM Address
> > >
> > > Move the cursor home after sending DISPLAY_CLEAR command to support
> > > non-standard LCDs.
> > >
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/auxdisplay/hd44780_common.c
> > > +++ b/drivers/auxdisplay/hd44780_common.c
> > > @@ -82,7 +82,15 @@ int hd44780_common_clear_display(struct charlcd *lcd)
> > >         hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
> > >         /* datasheet says to wait 1,64 milliseconds */
> > >         long_sleep(2);
> > > -       return 0;
> > > +
> > > +       /*
> > > +        * The Hitachi HD44780 controller (and compatible ones) reset the DDRAM
> > > +        * address when executing the DISPLAY_CLEAR command, thus the
> > > +        * following call is not required. However, other controllers do not
> > > +        * (e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
> > > +        * unconditionally to support both.
> > > +        */
> > > +       return hd44780_common_home(lcd);
> >
> > Sorry, I haven't tested your patch yet, as my HD44780 display is
> > currently not connected to any system.
> >
> > Your patch LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Note that hd44780_common_home() calls hd44780_common_gotoxy().
> > According to the documentation, both HD44780U and NHD-0220DZW-AG5
> > support the Return Home command (0x02), so that could be a good
> > alternative.
>
> Hi Geert,
> If this is desired, I think maybe it would be best to do it in a
> separate patch. Maybe there is a good reason why hd44780_common_home()

Sure, a separate patch would be fine.

> calls hd44780_common_gotoxy() instead of using Return Home command?

Looks like the Linux driver has always used goto 0/0 instead of Return Home.
Perhaps not all displays support that command? I know mine does.

Willy: do you remember?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
