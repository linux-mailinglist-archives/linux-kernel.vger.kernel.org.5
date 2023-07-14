Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332CC753FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjGNQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjGNQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:38:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFABB30EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:38:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 86D401F747;
        Fri, 14 Jul 2023 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689352702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WFfkLeMA7JU5LDVotJAeiQUyypNJsj7GRSVRQRb4/o=;
        b=efa8ZjY51WJsgYDxce5yB34dgbZxZ+TH6YmjThTNpBddOW8P8FSg9zhbKjMPFsHt0DS3p1
        FtMUKc/D7RqbdaYR1LYxbctcrILrWngNpuOzDxyElJLxWGV20Y2pKQDbixLFUpPV1LqX8A
        2jNq9clCfMRSgoYkkCX5bnsU7Pm88mg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D24C2C142;
        Fri, 14 Jul 2023 16:38:21 +0000 (UTC)
Date:   Fri, 14 Jul 2023 18:38:21 +0200
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
Message-ID: <ZLF5_dJyQgzNnrnO@alley>
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org>
 <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
 <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-10 09:30:19, Raul Rangel wrote:
> On Sun, Jul 9, 2023 at 8:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> >
> >
> > On 7/9/23 18:15, Mario Limonciello wrote:
> > > On 7/9/23 18:46, Randy Dunlap wrote:
> > >>
> > >>
> > >> On 7/7/23 18:17, Raul E Rangel wrote:
> > >>> Right now we are proxying the `console=XXX` command line args to the
> > >>> param_setup_earlycon. This is done because the following are
> > >>> equivalent:
> > >>>
> > >>>      console=uart[8250],mmio,<addr>[,options]
> > >>>      earlycon=uart[8250],mmio,<addr>[,options]
> > >>>
> > >>> In addition, when `earlycon=` or just `earlycon` is specified on the
> > >>> command line, we look at the SPCR table or the DT to extract the device
> > >>> options.
> > >>>
> > >>> When `console=` is specified on the command line, it's intention is to
> > >>> disable the console. Right now since we are proxying the `console=`
> > >>
> > >> How do you figure this (its intention is to disable the console)?
> > >
> 
> https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html
> says the following:
> console=
>     { null | "" }
>             Use to disable console output, i.e., to have kernel
>             console messages discarded.
>             This must be the only console= parameter used on the
>             kernel command line.
> 
>         earlycon=       [KNL] Output early console device and options.
> 
>             When used with no options, the early console is
>             determined by stdout-path property in device tree's
>             chosen node or the ACPI SPCR table if supported by
>             the platform.

Sigh, I wasn't aware of this when we discussed the console= handling.

> The reason this bug showed up is that ChromeOS has set `console=` for a
> very long time:
> https://chromium.googlesource.com/chromiumos/platform/crosutils/+/main/build_kernel_image.sh#282
> I'm not sure on the exact history, but AFAIK, we don't have the ttyX devices.
>
> Coreboot recently added support for the ACPI SPCR table which in
> combination with the
> `console=` arg, we are now seeing earlycon enabled when it shouldn't be.

But this happens only when both "earlycon" and "console=" parameters
are used together. Do I get it correctly?

This combination is ambiguous on its own. Why would anyone add
"earlycon" parameter and wanted to keep it disabled?

> > >>> diff --git a/init/main.c b/init/main.c
> > >>> index aa21add5f7c54..f72bf644910c1 100644
> > >>> --- a/init/main.c
> > >>> +++ b/init/main.c
> > >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *param, char *val,
> > >>>       for (p = __setup_start; p < __setup_end; p++) {
> > >>>           if ((p->early && parameq(param, p->str)) ||
> > >>>               (strcmp(param, "console") == 0 &&
> > >>> -             strcmp(p->str, "earlycon") == 0)
> > >>> -        ) {
> > >>> +             strcmp(p->str, "earlycon") == 0 && val && val[0])) {
> > >>>               if (p->setup_func(val) != 0)
> > >>>                   pr_warn("Malformed early option '%s'\n", param);
> > >>>           }

Huh, this is getting more and more complicated.

You know, it is already bad that:

    + "console" enables the default console which might be overridden
      by ACPI SPCR and devicetree

    + "console=" causes that "ttynull" console is preferred,
	  it might cause that no console is registered at all

    + both "earlyconsole" and "earlyconsole=" cause that
          
     consoles is enabled 
   

It is already bad that "earlycon" and "console" handle the empty value
a different way. But this makes it even worse. The behaviour
would depend on a subtle difference whether "console" or
"console=" is used.



> > >>
> > >
> >
> > --
> > ~Randy
