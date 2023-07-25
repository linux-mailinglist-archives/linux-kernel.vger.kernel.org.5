Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E2761EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjGYQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGYQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:42:56 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A479DE4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:42:54 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36PGgdrn007324;
        Tue, 25 Jul 2023 18:42:39 +0200
Date:   Tue, 25 Jul 2023 18:42:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
Message-ID: <ZL/7f8Q6xnoJVakk@1wt.eu>
References: <20230722180925.1408885-1-hugo@hugovil.com>
 <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
 <20230725111354.160f32cfba0b53923ac2aae6@hugovil.com>
 <CAMuHMdXe7MWpOjeUXjSsdOx0LXmzYCbvDCtt5yEup+1iGe4O=w@mail.gmail.com>
 <ZL/sDSDYXWFDGbcX@1wt.eu>
 <CAMuHMdW0-FcDo-S_DGq+AkWkhB66n_VTow5v2riw8fwmknjddQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW0-FcDo-S_DGq+AkWkhB66n_VTow5v2riw8fwmknjddQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 05:58:45PM +0200, Geert Uytterhoeven wrote:
> > One thing I'm having in mind is that this LCD supported horizontal
> > scrolling to show the off-screen columns. I'm wondering if the gotoxy()
> > and home() did the same thing regarding this. Maybe gotoxy() scrolled
> > back to 0,0 while home() just moved the cursor to the visible home
> > without scrolling back, in which case it could make a difference.
> 
> Indeed, at least according to the real HD44780 documentation,
> Return Home also resets the scrolling.

OK, thanks for checking!

> > I would suggest that we just stick to the specs and see if anyone reports
> > any trouble. There are so many compatible devices nowadays that possibly
> > implement only a subset of the original controller that we should really
> > stick to what is clearly understood by everyone and not rely on some old
> > conclusions about vague observations made by me 25 years ago!
> 
> OK. Given this patch is also a workaround for an incomplete
> implementation, let's keep hd44780_common_home() as-is.

OK, works for me.

Thanks,
Willy
