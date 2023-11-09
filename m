Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650607E6568
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjKIIis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjKIIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:38:47 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5952D5A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:38:44 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D57A820008;
        Thu,  9 Nov 2023 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699519123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4opqU/Z6a24vHtgPOkghLbFyCc/8KcYTc6s60E7F5I=;
        b=RhcVrG2F1Hxfyp+NjKD/SAzO29Nha82Z0erelDshJk08xr+xueghlAuzO3lUE2RC2Tt083
        eBLufb6AYsCDlOhMOIHK6MZngWiho/bRhg5rm/Zji43vHvfZMgNuCTgsoUYuBncHUjwY7G
        lbvaj3h0clGBI7oZSUV7gkTDc1DiqfT3Rl/FiPZXrnsZut7EhUVG8enauZMzs6S/c16GJl
        QrPr7VJINus08VnVFf6DVT8pujwmVNdNUygZPDqD+ZfbTIMtXIp3SIGltri1rMcklJxS4H
        sjGVKwXy3VzAmw9WNNiukLm5aqCgmb8ezVf3FgnLkef7zGujkh+Nq3F1wd4Qgw==
Date:   Thu, 9 Nov 2023 09:38:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [RFC PATCH 82/86] treewide: mtd: remove cond_resched()
Message-ID: <20231109093836.42a0e006@xps-13>
In-Reply-To: <20231108122116.5e2c11be@gandalf.local.home>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-26-ankur.a.arora@oracle.com>
        <20231108172827.1fc0bd89@xps-13>
        <ZUu4JHLMwC4s7QvS@casper.infradead.org>
        <20231108122116.5e2c11be@gandalf.local.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

rostedt@goodmis.org wrote on Wed, 8 Nov 2023 12:21:16 -0500:

> On Wed, 8 Nov 2023 16:32:36 +0000
> Matthew Wilcox <willy@infradead.org> wrote:
>=20
> > On Wed, Nov 08, 2023 at 05:28:27PM +0100, Miquel Raynal wrote: =20
> > > > --- a/drivers/mtd/nand/raw/nand_legacy.c
> > > > +++ b/drivers/mtd/nand/raw/nand_legacy.c
> > > > @@ -203,7 +203,13 @@ void nand_wait_ready(struct nand_chip *chip)
> > > >  	do {
> > > >  		if (chip->legacy.dev_ready(chip))
> > > >  			return;
> > > > -		cond_resched();
> > > > +		/*
> > > > +		 * Use a cond_resched_stall() to avoid spinning in
> > > > +		 * a tight loop.
> > > > +		 * Though, given that the timeout is in milliseconds,
> > > > +		 * maybe this should timeout or event wait?   =20
> > >=20
> > > Event waiting is precisely what we do here, with the hardware access
> > > which are available in this case. So I believe this part of the comme=
nt
> > > (in general) is not relevant. Now regarding the timeout I believe it =
is
> > > closer to the second than the millisecond, so timeout-ing is not
> > > relevant either in most cases (talking about mtd/ in general).   =20
> >=20
> > I think you've misunderstood what Ankur wrote here.  What you're
> > currently doing is spinning in a very tight loop.  The comment is
> > suggesting you might want to msleep(1) or something to avoid burning CPU
> > cycles.  It'd be even better if the hardware could signal you somehow,
> > but I bet it can't.

Well, I think I'm aligned with the change and the first sentence in the
comment, but not with the second sentence which I find not relevant.

Maybe I don't understand what "maybe this should timeout" and Ankur
meant "sleeping" there, but for me a timeout is when you bail out with
an error. If sleeping is advised, then why not using a more explicit
wording? As for hardware events, in this case it is not relevant, as
you noticed, so I asked this part of the sentence to be dropped.

This is a legacy part of the core but is still part of the core. In
general I don't mind treewide changes to be slightly generic and I will
not be bothered too much with the device drivers changes, but the core
is more important to my eyes.

> Oh how I wish we could bring back the old PREEMPT_RT cpu_chill()...
>=20
> #define cpu_chill()	msleep(1)

:')

Thanks,
Miqu=C3=A8l
