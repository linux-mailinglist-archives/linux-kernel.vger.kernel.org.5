Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE57542A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjGNSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjGNSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:35:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF57C6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:35:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 661D11F750;
        Fri, 14 Jul 2023 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689359719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHajigjE8Zj5hYsO2T5/4B97MCKf6SCqwG/F6l2pIA0=;
        b=XZVrxXEf4irlDQc0dxfOUQPU7D0bCFiIHpPFTMi+h0hPXBlaJLB2+KVgiq/+6Ir3zmj4ai
        a9/B9M9hKwgHrShCHBZQ2pW8bF0IxyV233yZVyMd4KHLXnIiiOBCr5VOUT/4S6rI4KrWgW
        nvClssMqZ1qFyZRGAjdIHWRffNQYnMA=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C03D2C145;
        Fri, 14 Jul 2023 18:35:18 +0000 (UTC)
Date:   Fri, 14 Jul 2023 20:35:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kramasub@chromium.org, Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
Message-ID: <ZLGVYg1FAZN7VFxB@alley>
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org>
 <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
 <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley>
 <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I am sorry I sent the first mail too early by mistake.
(Friday evening effect).

On Fri 2023-07-14 11:21:09, Raul Rangel wrote:
> On Fri, Jul 14, 2023 at 10:38 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2023-07-10 09:30:19, Raul Rangel wrote:
> > > On Sun, Jul 9, 2023 at 8:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > >
> > > >
> > > >
> > > > On 7/9/23 18:15, Mario Limonciello wrote:
> > > > > On 7/9/23 18:46, Randy Dunlap wrote:
> > > > >>
> > > > >>
> > > > >> On 7/7/23 18:17, Raul E Rangel wrote:
> > > > >>> Right now we are proxying the `console=XXX` command line args to the
> > > > >>> param_setup_earlycon. This is done because the following are
> > > > >>> equivalent:
> > > > >>>
> > > > >>>      console=uart[8250],mmio,<addr>[,options]
> > > > >>>      earlycon=uart[8250],mmio,<addr>[,options]
> > > > >>>
> > > > >>> In addition, when `earlycon=` or just `earlycon` is specified on the
> > > > >>> command line, we look at the SPCR table or the DT to extract the device
> > > > >>> options.
> > > > >>>
> > > > >>> When `console=` is specified on the command line, it's intention is to
> > > > >>> disable the console. Right now since we are proxying the `console=`
> > > > >>
> > > > >> How do you figure this (its intention is to disable the console)?
> > > > >
> > >
> > > https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html
> > > says the following:
> > > console=
> > >     { null | "" }
> > >             Use to disable console output, i.e., to have kernel
> > >             console messages discarded.
> > >             This must be the only console= parameter used on the
> > >             kernel command line.
> > >
> > >         earlycon=       [KNL] Output early console device and options.
> > >
> > >             When used with no options, the early console is
> > >             determined by stdout-path property in device tree's
> > >             chosen node or the ACPI SPCR table if supported by
> > >             the platform.
> >
> > Sigh, I wasn't aware of this when we discussed the console= handling.
> 
> It took a bit of digging to figure out what the actual intention was :)
> 
> >
> > > The reason this bug showed up is that ChromeOS has set `console=` for a
> > > very long time:
> > > https://chromium.googlesource.com/chromiumos/platform/crosutils/+/main/build_kernel_image.sh#282
> > > I'm not sure on the exact history, but AFAIK, we don't have the ttyX devices.
> > >
> > > Coreboot recently added support for the ACPI SPCR table which in
> > > combination with the
> > > `console=` arg, we are now seeing earlycon enabled when it shouldn't be.
> >
> > But this happens only when both "earlycon" and "console=" parameters
> > are used together. Do I get it correctly?
> 
> The bug shows up when an SPCR table is present and the `console=`
> parameter is set. No need to specify `earlycon` on the command line.

Strange, see below.

> > This combination is ambiguous on its own. Why would anyone add
> > "earlycon" parameter and wanted to keep it disabled?
> 
> This is not the case I'm hitting. I'm honestly not sure what the
> behavior should be in the `earlycon console=` case?
> 
> >
> > > > >>> diff --git a/init/main.c b/init/main.c
> > > > >>> index aa21add5f7c54..f72bf644910c1 100644
> > > > >>> --- a/init/main.c
> > > > >>> +++ b/init/main.c
> > > > >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *param, char *val,
> > > > >>>       for (p = __setup_start; p < __setup_end; p++) {
> > > > >>>           if ((p->early && parameq(param, p->str)) ||
> > > > >>>               (strcmp(param, "console") == 0 &&
> > > > >>> -             strcmp(p->str, "earlycon") == 0)
> > > > >>> -        ) {
> > > > >>> +             strcmp(p->str, "earlycon") == 0 && val && val[0])) {
> > > > >>>               if (p->setup_func(val) != 0)
> > > > >>>                   pr_warn("Malformed early option '%s'\n", param);
> > > > >>>           }

My understanding is that this code in do_early_param() allows to call
param_setup_earlycon() with the @val defined via console=val.
It reduces cut&paste on the kernel command line.

It should never enable an early console when "earlycon" is not defined
on the command line. Otherwise, console=uart[8250],mmio,<addr>[,options]
would always enable earlycon as well.

If the "earlycon" is not defined on the command line then
we should never call param_setup_earlycon() in the first place.

Or the behavior is even more crazy than I thought.

> >
> >     + "console" enables the default console which might be overridden
> >       by ACPI SPCR and devicetree
> 
> That's what this patch fixes. You need to specify `earlycon` in order
> to get the ACPI SPCR or DT console.

It sounds strange. earlycon is needed only for debugging. While
ACPI SPRC or DT should define the preferred console by the platform.

There are three levels of preference:

   + console= parameter defines the user preferred. It overrides
     everything.

   + ACPI SPCR or DT should define the preferred console by
     platform. It will be used when there is no user preference.

   + Kernel registers the first initialized console with tty driver
     when the is no preferred console by the user, ACPI SPCR, or DT.

As I said, I would expect that early console is enabled only when
earlycon parameter is defined on the command line.

In each case, it seems that acpi_parse_spcr() and of_console_check()
call add_preferred_console() even when earlycon is not defined
on the commandline.

> I don't see the `console` (without the =) documented:
> https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html.
> I'm guessing this is an undocumented "feature" that snuck in while the
> `earlycon` stuff was being added.

Honestly, I do not see where the "console" without '=' is handled.
console_setup() does not check if the @str parameter is NULL.


Anyway, the behavior already is complicated. But it might still
make some sense when:

   + "earlycon" parameter would try to call param_setup_earlycon()
     with @val from "console=val" parameter. It reduces cut&paste.

   + "console=" causes that "ttynull" driver gets preferred. Which might
       cause that no console driver gets registered at all. [*]

But seems to be yet another level of craziness when "console" or
"console=" would affect whether the early console will try
to be defined via ACPI SPCR or not.

I believe that this patch solves the problem. But it looks
like a workaround which makes the logic even more tricky/hacky.


IMHO, the right fix is to make sure that param_setup_earlycon()
should get called only when "earlycon" is defined on the commandline.

Best Regards,
Petr
