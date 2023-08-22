Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77309783EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjHVLcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjHVLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682FE51;
        Tue, 22 Aug 2023 04:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9600265248;
        Tue, 22 Aug 2023 11:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FF1C433CB;
        Tue, 22 Aug 2023 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703889;
        bh=ZkE3D0phJi9dVWs1lWeliBNMdHqs4kAWwch6/Y7lEhY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=EOgdSs5bt6FxYTXUYUEr+R8JtQP1FkD3hnomCWRWNmJz/X/N02sNuvqQuh0eiSCiF
         C5XTT8w62Jh4NlPZQlBTMwud8R42YFKpEK46ju8S4g9ZvUyNCmza6OOACiSniinjm9
         3FD2pW1UONGrtV1FhxiKuwzmDywPgeY8hp5DTCoZmDDhRH6Z9fFobZQ+8+Bu/Ti7uc
         +CjY/2Ow5OPdunWlnc2JInbL9P7lJhiwmklG9t1b2mgUQI9qG+l1g15oswtN/L3aG8
         Q3aYB+SZ06XNFnKBs3At2xP+qgsFg80cwFVtpJ77C2DYuBImjwnICeVB1ZkVGpa4Jv
         jeYe8DuZkYe/w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 14:31:26 +0300
Message-Id: <CUZ1G69D6DVR.10SDRFENHCCAZ@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm_crb: Fix an error handling path in crb_acpi_add()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Matthew Garrett" <mjg59@srcf.ucam.org>
X-Mailer: aerc 0.14.0
References: <a820eaf8c77ca4fde50fc170f535de4b28c82a2d.1677322706.git.christophe.jaillet@wanadoo.fr> <c2263ee0-2133-6f89-3f16-2ae1129a20df@wanadoo.fr> <CUZ1DUXBEAWM.6JDTPLT9I7NM@suppilovahvero>
In-Reply-To: <CUZ1DUXBEAWM.6JDTPLT9I7NM@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rn Tue Aug 22, 2023 at 2:28 PM EEST, Jarkko Sakkinen wrote:
> On Sun Aug 20, 2023 at 9:21 AM EEST, Christophe JAILLET wrote:
> > Le 25/02/2023 =C3=A0 11:58, Christophe JAILLET a =C3=A9crit=C2=A0:
> > > Some error paths don't call acpi_put_table() before returning.
> > > Branch to the correct place instead of doing some direct return.
> > >=20
> > > Fixes: 4d2732882703 ("tpm_crb: Add support for CRB devices based on P=
luton")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > >   drivers/char/tpm/tpm_crb.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > > index 99698ee1a744..f7068bd8b3d0 100644
> > > --- a/drivers/char/tpm/tpm_crb.c
> > > +++ b/drivers/char/tpm/tpm_crb.c
> > > @@ -771,12 +771,13 @@ static int crb_acpi_add(struct acpi_device *dev=
ice)
> > >   				FW_BUG "TPM2 ACPI table has wrong size %u for start method type=
 %d\n",
> > >   				buf->header.length,
> > >   				ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON);
> > > -			return -EINVAL;
> > > +			rc =3D -EINVAL;
> > > +			goto out;
> > >   		}
> > >   		crb_pluton =3D ACPI_ADD_PTR(struct tpm2_crb_pluton, buf, sizeof(*=
buf));
> > >   		rc =3D crb_map_pluton(dev, priv, buf, crb_pluton);
> > >   		if (rc)
> > > -			return rc;
> > > +			goto out;
> > >   	}
> > >  =20
> > >   	priv->sm =3D sm;
> >
> > Hi,
> >
> > polite reminder.
> >
> > While re-looking at it, the 3rd parameter of crb_map_pluton() (i.e. buf=
)=20
> > looks unused and could be removed if it makes sense to you.
>
> This AFAIK went to Linux v6.2 already.

Sorry I overlooked! There was bunch of patches with almost similar name,
so I must have overlooked also back then. Now it is applied.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

