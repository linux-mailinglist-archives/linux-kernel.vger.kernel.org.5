Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB890791368
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbjIDI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjIDI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:28:34 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69607126
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:28:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1756A60002;
        Mon,  4 Sep 2023 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693816102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1tg0DEdbRVfpiEp2gPgVWZAfvgOXilZ2u3vG2u4UKQ=;
        b=UYc8lyQbE8zR9m+WA07Iwq7a5URwXnqxaxmNBqU0AiS05zsuuEs9UbhBQr9v3OO9uTcak3
        LwGedNk4yaCWVp16a325cRb+tCAi6WilHGYSrvAdAeLBHCGkFUYTbHXB9QLduBBdbelbms
        4Yx8sSISw2bkdmu7IQChDu1kfoXHHPHPfRcAO2qY5XcWWAZC9RN5L4VzPBjgAoeUbJlYjT
        5xzFCntykCNX3rSeUiGcSxvm2CbMIk2s837u+6qng0l3UDCsq4KCO4DJVOYQq6oOEO61bS
        dCuHABXDdXoGkp5F+3827CKzO7CzwTdWnFOvELDgRLmV6n8uG7LCezmrBzbPmw==
Date:   Mon, 4 Sep 2023 10:28:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] mtd: Changes for v6.6-rc1
Message-ID: <20230904102819.54d95098@xps-13>
In-Reply-To: <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
References: <20230901184136.73b2833e@xps-13>
        <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

torvalds@linux-foundation.org wrote on Sat, 2 Sep 2023 11:59:55 -0700:

> On Fri, 1 Sept 2023 at 09:42, Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
> >
> > Core MTD changes:
> > * Use refcount to prevent corruption
> > * Call external _get and _put in right order
> > * Fix use-after-free in mtd release
> > * Explicitly include correct DT includes
> > * Clean refcounting with MTD_PARTITIONED_MASTER
> > * mtdblock: make warning messages ratelimited
> > * dt-bindings: Add SEAMA partition bindings =20
>=20
> Ok, so the above list isa fairly reasonable, but then:
>=20
> > MTD device driver changes:
> > * spear_smi: Use helper function devm_clk_get_enabled()
> > * maps: fix -Wvoid-pointer-to-enum-cast warning
> > * docg3: Remove unnecessary (void*) conversions
> > * physmap-core, spear_smi, st_spi_fsm, lpddr2_nvm, lantiq-flash, plat-r=
am:
> >   - Use devm_platform_get_and_ioremap_resource() =20
> [...]
>=20
> This is not a "summary of changes". The above is basically just a
> re-organized shortlog.
>=20
> What I want a merge message to be is to be an _overview_ of what the
> merge brings in, and it's why I ask peopel to summarize what they have
> worked on in the pull request.
>=20
> But when the "summary" is just a list of every single detail, it's no
> longer a summary. It doesn't give an overview of what has changed.
> It's not useful to an outsider as a way to see "this is what the merge
> brings in".
>=20
> End result: I might as well just use "git shortlog", and it would
> probably be about as readable as this is. In fact, I get the strong
> feeling that this was auto-generated from something very much akin to
> "git shortlog", just edited to combine multiple commits that just did
> the same thing to several drivers.
>=20
> Please - this is meant for *humans*. If it is just another form of
> "git shortlog", then the automated version is *better*, because I can
> use "git shortlog" to look at one particular driver (or a particular
> set of drivers), so having a static version of "git shortlog" that has
> been slightly munged to another format is actually _inferior_.
>=20
> No, what the merge message should be is a general overview of "this is
> the big picture". Not just a list of every single change, just by
> sub-area.
>=20
> For example, you list "Use devm_platform_get_and_ioremap_resource" not
> just for individual drivers (nobody cares!), you do it *twice*,
> because you've split up MTD drivers from raw NAND controller drivers.
>=20
> And then you separately list "Use helper function
> devm_clk_get_optional_enabled" from that list too, _and_ you then list
> "Use devm_platform_ioremap_resource_byname()" for the brcm nand
> driver.
>=20
> Not to mention individually lising "Fix alignment with open
> parenthesis" and "Fix the spacing" and "Fix wrong indentation" and
> "Fix a typo" for the Qcom driver.
>=20
> See why I'm frustrated? This has been going on for some time, but it's
> gett9ing *worse*. This is absolutely ridiculous. I could try to make a
> summary of it all, but honestly, now it feels like just complete
> wasted time.
>=20
> So I pulled this, looked at the "summary" in the fag, and decided that
> it's just not worth it, and unpulled it.
>=20
> Please give me a *summary* of what has changed. A list of *important&
> things. Not a list of pointless typo fixes.

Back in 2020, you complained about one of my pull requests with:

> You didn't even mention the stm32 controller change, which seems to be
> the biggest individual thing in here..

And indeed that was a mistake on my side, but I received that comment
as a request for a more detailed list of what had been touched. That's
likely an over interpretation, but it lead me to be more exhaustive so
the "you did not mention <this>" would no longer happen.

About your request today, I totally get why you would like something
more meaningful, but I don't know how to do it. Sometimes I get series
which have a goal and I could definitely try to capture that goal in
the summary rather than listing the patches. But then, what about the
endless list of miscellaneous patches to fix the style, the W=3D1
warnings, various robot complains... Because this is what I mostly get
currently, and I believe there is no way you'll prefer something like
this:
* Fix misc typos
* Fix misc style fixes
* Update to newer API's
Or maybe it is as long as the patches are trivial?

I believe among the load of PR you receive there must be other
subsystems than mtd which receive a lot of miscellaneous changes like
that, don't hesitate to share a couple which look useful yet
concise enough to you.

Thanks anyway for pulling.

Kind regards,
Miqu=C3=A8l
