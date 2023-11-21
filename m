Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1117F3214
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjKUPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjKUPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:15:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4871595
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:15:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E39C433C8;
        Tue, 21 Nov 2023 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700579754;
        bh=o0D6VcCQZpUAwPWm8y5zZoRGK+djRokQuhzQmDc1Ots=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBxIKDa855ZF2oYvMAHfBA2AvBeRZ62tqOpz8pVOxERO8DX69gyhW+e9uVJbKIKEt
         oyCQKUjuxoOU2iXDlti9IrDaj0eVX86fI0wigkMFcstMzdOqeIOz1Oka1ClE8WYkML
         TFQxNGTJVI/03aveXtVufVZEPI2sWy1ka1aD4t2xdmVWa2CVIJkrwVB9a2fvStgYsW
         8gAhcYPM3SjkKlBVw8AQMS0pK5d7VfHTqrbYgd4GBOKRsNOMnwwUgSfVgsqW4RpBFD
         N0F/FLf896AEroD6V0BWf2aJhxKlLUGLJcnc1ozI35y5XX8Xf3TItZUiA+WvDm1RkR
         b1M9wHZ8LHWQQ==
Date:   Tue, 21 Nov 2023 15:15:49 +0000
From:   Lee Jones <lee@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux LEDs <linux-leds@vger.kernel.org>,
        Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Pavel Machek <pavel@ucw.cz>,
        Johannes =?iso-8859-1?Q?Pen=DFel?= <johannes.penssel@gmail.com>
Subject: Re: Fwd: sysfs: cannot create duplicate filename
 .../system76_acpi::kbd_backlight/color
Message-ID: <20231121151549.GA173820@google.com>
References: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
 <ZT25-gUmLl8MPk93@debian.me>
 <dc6264c4-d551-4913-a51b-72c22217f15a@traphandler.com>
 <ZUjnzB2RL2iLzIQG@debian.me>
 <87sf50pm34.wl-tiwai@suse.de>
 <b9d4ab02-fe49-48ab-bf74-0c7a578e891a@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9d4ab02-fe49-48ab-bf74-0c7a578e891a@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Thorsten Leemhuis wrote:

> Takashi, Jean-Jacques Hiblot, Lee,
> 
> On 20.11.23 14:53, Takashi Iwai wrote:
> > On Mon, 06 Nov 2023 14:19:08 +0100,
> > Bagas Sanjaya wrote:
> >> On Sat, Nov 04, 2023 at 01:01:56PM +0100, Jean-Jacques Hiblot wrote:
> >>> On 29/10/2023 02:48, Bagas Sanjaya wrote:
> >>>> On Thu, Oct 26, 2023 at 02:55:06PM +0700, Bagas Sanjaya wrote:
> >>>>> The culprit seems to be commit c7d80059b086c4986cd994a1973ec7a5d75f8eea, which introduces a new 'color' attribute for led sysfs class devices. The problem is that the system76-acpi platform driver tries to create the exact same sysfs attribute itself for the system76_acpi::kbd_backlight device, leading to the conflict. For testing purposes, I've just rebuilt the kernel with the system76-apci color attribute renamed to kb_color, and that fixes the issue.
> >>>>
> >>>> Jean-Jacques Hiblot, would you like to take a look on this regression,
> >>>> since you authored the culprit?
> >
> >>> The offending commit stores the color in struct led_classdev and exposes it
> >>> via sysfs. It was part of a series that create a RGB leds from multiple
> >>> single-color LEDs. for this series, we need the color information but we
> >>> don't really need to expose it it via sysfs. In order to fix the issue, we
> >>> can remove the 'color' attribute from the sysfs.
> >>
> >> OK, see you in the patch!
> > 
> > Is there a patch available?
> 
> Not that I know of. Could not find anything on lore either.
> 
> > This bug hits for a few Logitech keyboard models, too, and it makes
> > 6.6 kernel unsable for them, as hid-lg-g15 driver probe fails due to
> > this bug:
> >   https://bugzilla.kernel.org/show_bug.cgi?id=218155
> > 
> > We need a quick fix for 6.6.x.
> 
> Given that Jean-Jacques Hiblot (the author of the culprit) and Lee (who
> committed it and sent it to Linus) know about this for a while already
> without doing anything about it, I wonder if someone should just send a
> revert to Linus (unless of course that is likely to introduce a
> regression on its own).

You seem to have gone from DEFCON 4 to DEFCON 2 there.  The middle step
is to submit a patch to fix the issue and follow the usual patch flow.

-- 
Lee Jones [李琼斯]
