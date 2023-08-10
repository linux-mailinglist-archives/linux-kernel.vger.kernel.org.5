Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E118777F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjHJRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHJRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EFAC1;
        Thu, 10 Aug 2023 10:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F2163C56;
        Thu, 10 Aug 2023 17:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60FFC433C8;
        Thu, 10 Aug 2023 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691688921;
        bh=YwX3wVOuwREy+Nchdv0hP99Kg3aAymCQeLk99JQyD7M=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=d3uIy2jVnlFrhKjZMVIRwOSMbeA4D8RdLuCXnqOr05lrYmR3AyrGNzwdIk+FDq/rA
         CxQwF4QFTugsbXMh8fcSwsavyde78w2UiTxZmyfTvYh9otBJ23D7wdY9MgTH5sqWSO
         eFhqLorQbk42hnJTKtOCGcn8teGYup5C+Jpf9+ee+/ce0ZswAKQMtZIMShgabKUmIz
         d6KitcahmYmxhze1TEnzS6OUg08JVYA2NzS9tsndm+++WclFz9OeDRSsECRzuANlZw
         jIeWsGmIZkPh+izjl64awbMaC7gZ20lweusJK1YieC3OjPbZTJ67K2aD9mE4R8oFtQ
         bsag5YVvRT18w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:35:16 +0300
Message-Id: <CUP1O7LTI58J.1VQMCH1YS0EXR@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo Thinkpad E14
 Gen 2 and 13s-IML
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.14.0
References: <20230807140125.18486-1-tiwai@suse.de>
 <CUMJWFCIG9EI.13F7LU8TYAUE1@seitikki> <87il9qhxjq.wl-tiwai@suse.de>
 <CUOYJI68K3KG.39YM92JXBEIQ9@wks-101042-mac.ad.tuni.fi>
 <87ttt7rkpq.wl-tiwai@suse.de>
In-Reply-To: <87ttt7rkpq.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 10, 2023 at 6:16 PM EEST, Takashi Iwai wrote:
> On Thu, 10 Aug 2023 17:08:04 +0200,
> Jarkko Sakkinen wrote:
> >=20
> > On Tue Aug 8, 2023 at 9:12 AM EEST, Takashi Iwai wrote:
> > > On Mon, 07 Aug 2023 21:14:20 +0200,
> > > Jarkko Sakkinen wrote:
> > > >=20
> > > > On Mon Aug 7, 2023 at 2:01 PM UTC, Takashi Iwai wrote:
> > > > > Like other Lenovo laptops, Thinkpad E14 Gen 2 and Thinkpad 13s-IM=
L
> > > > > also require to disable the tpm_tis interrupts for avoiding a boo=
t
> > > > > hang.
> > > > >
> > > > > Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > > > > Cc: <stable@vger.kernel.org> # v6.4+
> > > > > Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1213779
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > >
> > > > > ---
> > > > >  drivers/char/tpm/tpm_tis.c | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_ti=
s.c
> > > > > index a98773ac2e55..0633823dc515 100644
> > > > > --- a/drivers/char/tpm/tpm_tis.c
> > > > > +++ b/drivers/char/tpm/tpm_tis.c
> > > > > @@ -130,6 +130,22 @@ static const struct dmi_system_id tpm_tis_dm=
i_table[] =3D {
> > > > >  			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
> > > > >  		},
> > > > >  	},
> > > > > +	{
> > > > > +		.callback =3D tpm_tis_disable_irq,
> > > > > +		.ident =3D "ThinkPad E14 Gen 2",
> > > > > +		.matches =3D {
> > > > > +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > > > +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad E14 Gen 2"),
> > > > > +		},
> > > > > +	},
> > > > > +	{
> > > > > +		.callback =3D tpm_tis_disable_irq,
> > > > > +		.ident =3D "ThinkBook 13s-IML",
> > > > > +		.matches =3D {
> > > > > +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > > > +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ThinkBook 13s-IML"),
> > > > > +		},
> > > > > +	},
> > > > >  	{
> > > > >  		.callback =3D tpm_tis_disable_irq,
> > > > >  		.ident =3D "ThinkPad T490s",
> > > > > --=20
> > > > > 2.35.3
> > > >=20
> > > > As almost all issues are with Lenovo, I would instead just put:
> > > >=20
> > > > 	{
> > > > 		.callback =3D tpm_tis_disable_irq,
> > > > 		.matches =3D {
> > > > 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > > 		},
> > > > 	},
> > > >=20
> > > > And delete the existing entries with vendor as "LENOVO".
> > >
> > > Yeah, that will relieve pains better, too.
> >=20
> > Please do it if possible then :-)
>
> Do you mean that I should resubmit a new patch?
> Honestly speaking, it'd be easier if you can do it directly.
> I'm merely a sort of messenger, I don't own / test the device by
> myself...
>
> But if inevitably required, I can resubmit a patch, of course.

I'll submit a patch asap, and cc you. I put the conclusions
to the description.

BR, Jarkko
