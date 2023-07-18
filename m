Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F411A757873
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGRJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjGRJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:50:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D2FB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:50:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 947E72197F;
        Tue, 18 Jul 2023 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689673835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iEDxtyj30km5ZpJrK1zXAqveWhiOtVDMsZ+sZ1ULcc=;
        b=c6TGlZ3DB7nWpNbHzOhXOIZ2HlXgKBtnK6iP0caWJ5bAZI87oOETE0PkaXj+6tKvqtO4yC
        dEAf90W7z21PHLJQ80yDfgKRl4BRq0GWyI+pDOrdu8grq1J8l8zVmW47q4SGjAIX9lzgsK
        lmxDKzIT4qWh4zbT4en29Eci+fYXPQA=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B28772C142;
        Tue, 18 Jul 2023 09:50:34 +0000 (UTC)
Date:   Tue, 18 Jul 2023 11:50:30 +0200
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
Message-ID: <ZLZgZvE35fYCkgOq@alley>
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org>
 <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
 <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley>
 <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
 <ZLGVYg1FAZN7VFxB@alley>
 <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-14 15:42:36, Raul Rangel wrote:
> On Fri, Jul 14, 2023 at 12:35 PM Petr Mladek <pmladek@suse.com> wrote:
> > On Fri 2023-07-14 11:21:09, Raul Rangel wrote:
> > > On Fri, Jul 14, 2023 at 10:38 AM Petr Mladek <pmladek@suse.com> wrote:
> > > > On Mon 2023-07-10 09:30:19, Raul Rangel wrote:
> > > > > On Sun, Jul 9, 2023 at 8:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > > > > On 7/9/23 18:15, Mario Limonciello wrote:
> > > > > > > On 7/9/23 18:46, Randy Dunlap wrote:
> > > > > > >> On 7/7/23 18:17, Raul E Rangel wrote:
> > > > > > >>> Right now we are proxying the `console=XXX` command line args to the
> > > > > > >>> param_setup_earlycon. This is done because the following are
> > > > > > >>> equivalent:
> > > > > > >>>
> > > > > > >>>      console=uart[8250],mmio,<addr>[,options]
> > > > > > >>>      earlycon=uart[8250],mmio,<addr>[,options]

I have finally got the meaning of the above paragraph. I thought that
it was talking about that the format was equivalent. But it was about
that also the effect was equivalent.

> > > > > > >>> In addition, when `earlycon=` or just `earlycon` is specified on the
> > > > > > >>> command line, we look at the SPCR table or the DT to extract the device
> > > > > > >>> options.
> > > > > > >>>
> > > > > > >>> When `console=` is specified on the command line, it's intention is to
> > > > > > >>> disable the console. Right now since we are proxying the `console=`
> > > > > > >>
> > > > > > >> How do you figure this (its intention is to disable the console)?
> > > > > > >
> > > > >
> > > > > https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html
> > > > > says the following:
> > > > > console=
> > > > >     { null | "" }
> > > > >             Use to disable console output, i.e., to have kernel
> > > > >             console messages discarded.
> > > > >             This must be the only console= parameter used on the
> > > > >             kernel command line.
> > > > >
> > > > >         earlycon=       [KNL] Output early console device and options.
> > > > >
> > > > >             When used with no options, the early console is
> > > > >             determined by stdout-path property in device tree's
> > > > >             chosen node or the ACPI SPCR table if supported by
> > > > >             the platform.
> > > >
> > > > Sigh, I wasn't aware of this when we discussed the console= handling.
> > >
> > > It took a bit of digging to figure out what the actual intention was :)
> > >
> > > >
> > > > > The reason this bug showed up is that ChromeOS has set `console=` for a
> > > > > very long time:
> > > > > https://chromium.googlesource.com/chromiumos/platform/crosutils/+/main/build_kernel_image.sh#282
> > > > > I'm not sure on the exact history, but AFAIK, we don't have the ttyX devices.
> > > > >
> > > > > Coreboot recently added support for the ACPI SPCR table which in
> > > > > combination with the
> > > > > `console=` arg, we are now seeing earlycon enabled when it shouldn't be.
> > > >
> > > > But this happens only when both "earlycon" and "console=" parameters
> > > > are used together. Do I get it correctly?
> > >
> > > The bug shows up when an SPCR table is present and the `console=`
> > > parameter is set. No need to specify `earlycon` on the command line.
> >
> > Strange, see below.
> >
> > > > This combination is ambiguous on its own. Why would anyone add
> > > > "earlycon" parameter and wanted to keep it disabled?
> > >
> > > This is not the case I'm hitting. I'm honestly not sure what the
> > > behavior should be in the `earlycon console=` case?
> > >
> > > >
> > > > > > >>> diff --git a/init/main.c b/init/main.c
> > > > > > >>> index aa21add5f7c54..f72bf644910c1 100644
> > > > > > >>> --- a/init/main.c
> > > > > > >>> +++ b/init/main.c
> > > > > > >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *param, char *val,
> > > > > > >>>       for (p = __setup_start; p < __setup_end; p++) {
> > > > > > >>>           if ((p->early && parameq(param, p->str)) ||
> > > > > > >>>               (strcmp(param, "console") == 0 &&
> > > > > > >>> -             strcmp(p->str, "earlycon") == 0)
> > > > > > >>> -        ) {
> > > > > > >>> +             strcmp(p->str, "earlycon") == 0 && val && val[0])) {
> > > > > > >>>               if (p->setup_func(val) != 0)
> > > > > > >>>                   pr_warn("Malformed early option '%s'\n", param);
> > > > > > >>>           }
> >
> This contradicts your first point. We need to call
> `param_setup_earlycon` so it can handle `console=uart,mmio,XXXX`.
> That's why this block of code is here. IMO it's very confusing
> behavior that `earlycon=uart,mmio,XXXX` and `console=uart,mmio,XXXX`
> are the same thing.

Urgh, I didn't know that "console=uart*" started early console.
I always thought that it was just another way how to define
the normal console.

(I feel shame as a printk maintainer. But I have never used it.
And this has been the first patch in the related code since
I started watching printk 10 years ago.)

Looking into the history, "earlycon" parameter was added by
the commit 18a8bd949d6adb311 ("serial: convert early_uart to
earlycon for 8250") in 2007. The parameter "console=uart,mmio,XXX"
started the console earlier even before.

The "earlycon" parameter allowed to define the early console
an explicit way on the command line. But it was not strictly
necessary. The same effect could have been achieved by:

static int __init do_early_param(char *param, char *val,
				 const char *unused, void *arg)
{
	struct obs_kernel_param *p;

	for (p = __setup_start; p < __setup_end; p++) {
		if (p->early && strcmp(param, p->str) == 0) {
			if (p->setup_func(val) != 0)
				printk(KERN_WARNING
				       "Malformed early option '%s'\n", param);
		}

		if (strcmp(param, "console") == 0) {
			if (setup_early_serial8250_console(val) != 0)
				printk(KERN_WARNING, "Failed to setup early console");
	}
}

> The reason my patch checks for a NULL or empty val is because
> `param_setup_earlycon` has a special case to handle the
> `earlycon`/`earlycon=` case:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-6.1/drivers/tty/serial/earlycon.c#223
> 
> ```
> /* Just 'earlycon' is a valid param for devicetree and ACPI SPCR. */
> if (!buf || !buf[0]) {
>   if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
>     earlycon_acpi_spcr_enable = true;
>     return 0;
>   } else if (!buf) {
>     return early_init_dt_scan_chosen_stdout();
>   }
> }
> ```

I see. It all makes sense now.

Your patch is good then. Well, would you mind to add a comment into
the code and make the commit message more clear even for dummies like
me?

Something like the patch below. It would be better to split it into
two:

   + 1st shuffling the check and adding the first part of the comment
   + 2nd fixing the case with empty console= options.

I could prepare the patchset. I would keep your SOB for the 2nd patch
if you agreed.

Here is the proposal:

From d2fb7c54bed4c67df229c56fcc1b0af83ada5227 Mon Sep 17 00:00:00 2001
From: Raul E Rangel <rrangel@chromium.org>
Date: Fri, 7 Jul 2023 19:17:25 -0600
Subject: [PATCH] init: Don't proxy the empty console= options to earlycon

Right now we are proxying the `console=XXX` command line args to the
param_setup_earlycon. This is done because the early consoles used to
be enabled via the `console` parameter.

The `earlycon` parameter was added later by the commit 18a8bd949d6adb311
("serial: convert early_uart to earlycon for 8250"). It allowed to
setup the early consoles using another callback. And it was indeed
more self-explanatory and cleaner approach.

As a result, for example, the following parameters have the same effect:

    console=uart[8250],mmio,<addr>[,options]
    earlycon=uart[8250],mmio,<addr>[,options]

Nevertheless, `console` and `earlycon` parameters behave different when
the options do not match an early console. setup_earlycon() accepts only
console names in __earlycon_table. Also the empty options are handled
differently:

  + When `earlycon=` or just `earlycon` is specified on the command line,
    param_setup_earlycon() tries to enable an early console via the SPCR
    table or the device tree.

  + When `console=` is specified on the command line, it's intention is to
    disable the console.

Here comes the problem. The current code calls param_setup_earlycon()
even when `console=` is used with no options. As a result, it might
enable the early console when it is defined in the SPCR table or
a device tree. This is obviously not what users want.

The early console should be enabled via SPCR or DT only when `earlycon`
is used explicitly with no options.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
[pmladek@suse.com: Add comments and more details into the commit message]
---
 init/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index ad920fac325c..3b059e316e62 100644
--- a/init/main.c
+++ b/init/main.c
@@ -733,13 +733,25 @@ static int __init do_early_param(char *param, char *val,
 	const struct obs_kernel_param *p;
 
 	for (p = __setup_start; p < __setup_end; p++) {
-		if ((p->early && parameq(param, p->str)) ||
-		    (strcmp(param, "console") == 0 &&
-		     strcmp(p->str, "earlycon") == 0)
-		) {
+		if (p->early && parameq(param, p->str)) {
 			if (p->setup_func(val) != 0)
 				pr_warn("Malformed early option '%s'\n", param);
 		}
+
+		/*
+		 * Early consoles can be historically enabled also when earlycon
+		 * specific options are passed via console=[earlycon options]
+		 * parameter.
+		 *
+		 * Do not try it with an empty value. "console=" is used to
+		 * disable real normal consoles. While "earlycon" is used to
+		 * enable an early console via SPCR or DT.
+		 */
+		if (strcmp(param, "console") == 0 && val && val[0] &&
+		    strcmp(p->str, "earlycon") == 0) {
+			if (p->setup_func(val) != 0)
+				pr_warn("Failed to setup earlycon via console=%s\n", val);
+		}
 	}
 	/* We accept everything at this stage. */
 	return 0;
-- 
2.35.3

