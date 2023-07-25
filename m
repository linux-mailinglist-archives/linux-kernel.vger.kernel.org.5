Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752CE761D11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjGYPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjGYPOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:14:02 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97731BD9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BV1xB/2XbmJZJAGcy1cpgotCP6ChotEIwq9HRVIEYeY=; b=NWkwQWiG7sj2qpHxVC3/1m2x2L
        YABumZgyt/lBp/yaJkXDEUZmKPwiq1wkTqiRXuUsBNn7wqAFIpmBqnjLN3hvLTbmO+olrTeKrb7E/
        B71F01nH7+lh+Vt80zSa6WCxWbtkHmXbMKMcQoe9iNhuobr//Ox/PzODxIhMc1oBIEc0=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:39448 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qOJjX-0003j2-87; Tue, 25 Jul 2023 11:13:55 -0400
Date:   Tue, 25 Jul 2023 11:13:54 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20230725111354.160f32cfba0b53923ac2aae6@hugovil.com>
In-Reply-To: <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
References: <20230722180925.1408885-1-hugo@hugovil.com>
        <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 18:08:00 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> On Sat, Jul 22, 2023 at 8:18 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> > does NOT change the DDRAM address to 00h (home position) like the
> > standard Hitachi HD44780 controller. As a consequence, the starting
> > position of the initial string LCD_INIT_TEXT is not guaranteed to be
> > at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> > command.
> >
> > Extract of DISPLAY_CLEAR command from datasheets of:
> >
> >     Hitachi HD44780:
> >         ... It then sets DDRAM address 0 into the address counter...
> >
> >     NewHaven NHD-0220DZW-AG5 datasheet:
> >         ... This instruction does not change the DDRAM Address
> >
> > Move the cursor home after sending DISPLAY_CLEAR command to support
> > non-standard LCDs.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/auxdisplay/hd44780_common.c
> > +++ b/drivers/auxdisplay/hd44780_common.c
> > @@ -82,7 +82,15 @@ int hd44780_common_clear_display(struct charlcd *lcd)
> >         hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
> >         /* datasheet says to wait 1,64 milliseconds */
> >         long_sleep(2);
> > -       return 0;
> > +
> > +       /*
> > +        * The Hitachi HD44780 controller (and compatible ones) reset the DDRAM
> > +        * address when executing the DISPLAY_CLEAR command, thus the
> > +        * following call is not required. However, other controllers do not
> > +        * (e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
> > +        * unconditionally to support both.
> > +        */
> > +       return hd44780_common_home(lcd);
> 
> Sorry, I haven't tested your patch yet, as my HD44780 display is
> currently not connected to any system.
> 
> Your patch LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Note that hd44780_common_home() calls hd44780_common_gotoxy().
> According to the documentation, both HD44780U and NHD-0220DZW-AG5
> support the Return Home command (0x02), so that could be a good
> alternative.

Hi Geert,
If this is desired, I think maybe it would be best to do it in a
separate patch. Maybe there is a good reason why hd44780_common_home()
calls hd44780_common_gotoxy() instead of using Return Home command?

Hugo.


> 
> >  }
> >  EXPORT_SYMBOL_GPL(hd44780_common_clear_display);
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
