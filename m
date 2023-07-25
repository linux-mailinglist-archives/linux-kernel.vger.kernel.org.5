Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF2761D76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGYPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGYPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:37:01 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99AF2BB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:36:59 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36PFajrR006568;
        Tue, 25 Jul 2023 17:36:45 +0200
Date:   Tue, 25 Jul 2023 17:36:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
Message-ID: <ZL/sDSDYXWFDGbcX@1wt.eu>
References: <20230722180925.1408885-1-hugo@hugovil.com>
 <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
 <20230725111354.160f32cfba0b53923ac2aae6@hugovil.com>
 <CAMuHMdXe7MWpOjeUXjSsdOx0LXmzYCbvDCtt5yEup+1iGe4O=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXe7MWpOjeUXjSsdOx0LXmzYCbvDCtt5yEup+1iGe4O=w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Jul 25, 2023 at 05:21:36PM +0200, Geert Uytterhoeven wrote:
> Hi Hugo,
> 
> On Tue, Jul 25, 2023 at 5:13 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Mon, 24 Jul 2023 18:08:00 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sat, Jul 22, 2023 at 8:18 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >
> > > > The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> > > > does NOT change the DDRAM address to 00h (home position) like the
> > > > standard Hitachi HD44780 controller. As a consequence, the starting
> > > > position of the initial string LCD_INIT_TEXT is not guaranteed to be
> > > > at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> > > > command.
> > > >
> > > > Extract of DISPLAY_CLEAR command from datasheets of:
> > > >
> > > >     Hitachi HD44780:
> > > >         ... It then sets DDRAM address 0 into the address counter...
> > > >
> > > >     NewHaven NHD-0220DZW-AG5 datasheet:
> > > >         ... This instruction does not change the DDRAM Address
> > > >
> > > > Move the cursor home after sending DISPLAY_CLEAR command to support
> > > > non-standard LCDs.
> > > >
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/auxdisplay/hd44780_common.c
> > > > +++ b/drivers/auxdisplay/hd44780_common.c
> > > > @@ -82,7 +82,15 @@ int hd44780_common_clear_display(struct charlcd *lcd)
> > > >         hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
> > > >         /* datasheet says to wait 1,64 milliseconds */
> > > >         long_sleep(2);
> > > > -       return 0;
> > > > +
> > > > +       /*
> > > > +        * The Hitachi HD44780 controller (and compatible ones) reset the DDRAM
> > > > +        * address when executing the DISPLAY_CLEAR command, thus the
> > > > +        * following call is not required. However, other controllers do not
> > > > +        * (e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
> > > > +        * unconditionally to support both.
> > > > +        */
> > > > +       return hd44780_common_home(lcd);
> > >
> > > Sorry, I haven't tested your patch yet, as my HD44780 display is
> > > currently not connected to any system.
> > >
> > > Your patch LGTM, so
> > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >
> > > Note that hd44780_common_home() calls hd44780_common_gotoxy().
> > > According to the documentation, both HD44780U and NHD-0220DZW-AG5
> > > support the Return Home command (0x02), so that could be a good
> > > alternative.
> >
> > Hi Geert,
> > If this is desired, I think maybe it would be best to do it in a
> > separate patch. Maybe there is a good reason why hd44780_common_home()
> 
> Sure, a separate patch would be fine.
> 
> > calls hd44780_common_gotoxy() instead of using Return Home command?
> 
> Looks like the Linux driver has always used goto 0/0 instead of Return Home.
> Perhaps not all displays support that command? I know mine does.
> 
> Willy: do you remember?

Indeed, this vaguely reminds me something. I've been using an old 2x40
salvaged from a fax in the late 80s, originally all reverse-engineered
under DOS. When I implemented Linux support for it 10 years later, I
ported my working code there and we started to adapt to other said
compatible models and fixed certain things that were specific to my
model or that were incorrect in my initial analysis. But I remember that
we broke several times the support for mine while trying to match the
available specs more closely.

Several times we had something related to the initialization, where it
wouldn't always initialize well. But maybe that's because we were calling
what became hd44780_common_home() while during the init code it's possible
that we need at least one call to gotoxy(), I don't really know.

One thing I'm having in mind is that this LCD supported horizontal
scrolling to show the off-screen columns. I'm wondering if the gotoxy()
and home() did the same thing regarding this. Maybe gotoxy() scrolled
back to 0,0 while home() just moved the cursor to the visible home
without scrolling back, in which case it could make a difference.

I would suggest that we just stick to the specs and see if anyone reports
any trouble. There are so many compatible devices nowadays that possibly
implement only a subset of the original controller that we should really
stick to what is clearly understood by everyone and not rely on some old
conclusions about vague observations made by me 25 years ago!

Thanks,
Willy
