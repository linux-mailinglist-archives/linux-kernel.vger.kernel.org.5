Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A260C777BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbjHJPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjHJPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B362686;
        Thu, 10 Aug 2023 08:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE35765F37;
        Thu, 10 Aug 2023 15:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82363C433C8;
        Thu, 10 Aug 2023 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691680089;
        bh=PA7j74qL/UgGep611+zX3UVfAs2lsTR/6dXOwVVek+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iesVk1Bxw3h6zERnfxs/qN70BPjAwMNYoUO7k8e4lFgdbDpXYAx5CbsgO/e4Yr2v3
         XsaftaIKdfb1k5dS23ZHLU1/eFIC0h8wYo7KXQtzzg0yob/g6wIdLZkcpzMjoPbdtv
         2+T0dmOLjWs4hZ20hPELAJx2sKQAhhnJ9L6CKJuK9g9ZFQ4AG/y6vO6c0lrpWiV2Yx
         U6+qPrBCgSVQWQLIkM1A9Nd2vocfO39JdqwgaBLBQyxI2BZ5SKnvQ/nP+0nVS56r7T
         WhYMwZglnhHXjfBZ87yyBv769vdh+OgcIJjEiboVlatqm3AuyGEi2P3efQ2qoCQqwQ
         5+QZcoM7HsAdw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:08:04 +0300
Message-Id: <CUOYJI68K3KG.39YM92JXBEIQ9@wks-101042-mac.ad.tuni.fi>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo Thinkpad E14
 Gen 2 and 13s-IML
X-Mailer: aerc 0.15.2
References: <20230807140125.18486-1-tiwai@suse.de>
 <CUMJWFCIG9EI.13F7LU8TYAUE1@seitikki> <87il9qhxjq.wl-tiwai@suse.de>
In-Reply-To: <87il9qhxjq.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 8, 2023 at 9:12 AM EEST, Takashi Iwai wrote:
> On Mon, 07 Aug 2023 21:14:20 +0200,
> Jarkko Sakkinen wrote:
> >=20
> > On Mon Aug 7, 2023 at 2:01 PM UTC, Takashi Iwai wrote:
> > > Like other Lenovo laptops, Thinkpad E14 Gen 2 and Thinkpad 13s-IML
> > > also require to disable the tpm_tis interrupts for avoiding a boot
> > > hang.
> > >
> > > Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > > Cc: <stable@vger.kernel.org> # v6.4+
> > > Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1213779
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > >
> > > ---
> > >  drivers/char/tpm/tpm_tis.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> > > index a98773ac2e55..0633823dc515 100644
> > > --- a/drivers/char/tpm/tpm_tis.c
> > > +++ b/drivers/char/tpm/tpm_tis.c
> > > @@ -130,6 +130,22 @@ static const struct dmi_system_id tpm_tis_dmi_ta=
ble[] =3D {
> > >  			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
> > >  		},
> > >  	},
> > > +	{
> > > +		.callback =3D tpm_tis_disable_irq,
> > > +		.ident =3D "ThinkPad E14 Gen 2",
> > > +		.matches =3D {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad E14 Gen 2"),
> > > +		},
> > > +	},
> > > +	{
> > > +		.callback =3D tpm_tis_disable_irq,
> > > +		.ident =3D "ThinkBook 13s-IML",
> > > +		.matches =3D {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ThinkBook 13s-IML"),
> > > +		},
> > > +	},
> > >  	{
> > >  		.callback =3D tpm_tis_disable_irq,
> > >  		.ident =3D "ThinkPad T490s",
> > > --=20
> > > 2.35.3
> >=20
> > As almost all issues are with Lenovo, I would instead just put:
> >=20
> > 	{
> > 		.callback =3D tpm_tis_disable_irq,
> > 		.matches =3D {
> > 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > 		},
> > 	},
> >=20
> > And delete the existing entries with vendor as "LENOVO".
>
> Yeah, that will relieve pains better, too.

Please do it if possible then :-)

BR, Jarkko
