Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146D27693F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjGaK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGaK6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7819AA;
        Mon, 31 Jul 2023 03:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0996261013;
        Mon, 31 Jul 2023 10:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991C6C116A1;
        Mon, 31 Jul 2023 10:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690801105;
        bh=qT0FWHEOJrdzN0cD4SpSzxce4vu8bOeHDY7Zu5qv6b4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=AQMoRdpolSfHThEn8BXOU1bHFOB1/jptLVMObxOGhYGSh7tW72wHOUzKYJWLE6ey5
         0QApbJrPzdL+9iwJEd/Rb6hUlV7mqBb/2TExXmFTK1ZxAcWIFOZQQOa6cqutLQxIrp
         R4ikXNX57VYAkLjF4qu+LZgg+pDY1cAKfPNkocYbSYaZQnW7H+cJV4S9mebFDErv9s
         OHAQgdLNUNTPS4RSS7vltMXif9XxFvQE5N2AeuOfxdrkkbYjkjf/iMjJfHLkKDQjoA
         4+jukEdFykSe5tmjTCgJRB4s6k9MSM9VYz9DU3Pwlz619GqxaVTfAOPioGPvY1Eb31
         bwq052QEDExFg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 Jul 2023 10:58:21 +0000
Message-Id: <CUGAYUWIYL8Y.1UID37JVB3IIZ@seitikki>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook
 S 15/17 Gen7
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230726180035.14511-1-tiwai@suse.de>
 <CUE1URH8QI55.15YQBHZNSL2UJ@seitikki> <878razdwnh.wl-tiwai@suse.de>
In-Reply-To: <878razdwnh.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jul 29, 2023 at 7:06 AM UTC, Takashi Iwai wrote:
> On Fri, 28 Jul 2023 21:24:30 +0200,
> Jarkko Sakkinen wrote:
> >=20
> > On Wed Jul 26, 2023 at 6:00 PM UTC, Takashi Iwai wrote:
> > > TUXEDO InfinityBook S 15/17 Gen7 suffers from an IRQ problem on
> > > tpm_tis like a few other laptops.  Add an entry for the workaround.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > > Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1213645
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/char/tpm/tpm_tis.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> > > index cc42cf3de960..a98773ac2e55 100644
> > > --- a/drivers/char/tpm/tpm_tis.c
> > > +++ b/drivers/char/tpm/tpm_tis.c
> > > @@ -162,6 +162,14 @@ static const struct dmi_system_id tpm_tis_dmi_ta=
ble[] =3D {
> > >  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> > >  		},
> > >  	},
> > > +	{
> > > +		.callback =3D tpm_tis_disable_irq,
> > > +		.ident =3D "TUXEDO InfinityBook S 15/17 Gen7",
> > > +		.matches =3D {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> > > +			DMI_MATCH(DMI_PRODUCT_NAME, "TUXEDO InfinityBook S 15/17 Gen7"),
> > > +		},
> > > +	},
> > >  	{
> > >  		.callback =3D tpm_tis_disable_irq,
> > >  		.ident =3D "UPX-TGL",
> > > --=20
> > > 2.35.3
> >=20
> > Hi does this occur with the latest linux-next and/or v6.5-rc3?
>
> Not tested yet, but do you have any relevant fix except for the commit
> 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled
> IRQs")?  That commit was already tested, at least.

OK, I will pick this, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
