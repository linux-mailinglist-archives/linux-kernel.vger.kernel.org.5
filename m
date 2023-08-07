Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12A772E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjHGTO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C36C10F3;
        Mon,  7 Aug 2023 12:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3228662179;
        Mon,  7 Aug 2023 19:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8ABC433C8;
        Mon,  7 Aug 2023 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691435663;
        bh=YLygv1jz0ItPr9sKEjOdeVJHuuSFuvGgES9+tIv2Dzk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=pz4kyLNAU/YGow5VaNzkzlG3y6Y1bs9NTwM2T1r46it8+3ROEFqI47CyKC/tTL65B
         E/XpNY/UAem2dnMtCerVKGg05LOqD+pfGlFW6pqC/c6KnZtIsn04G9Be7PgwBowsdb
         GhvUsr/CoBc1w90aj+NK8qRsqavcaJv8dFZlI0TY1hvVQpgLOiktv2TZcp8yuMEuD3
         TuW3fH4PecFCWY3bd7xo3ptdfYm8AaMN4uq6jI6oCe0YIrToQAtpahesaDdxfZbny+
         Pfeg6wQf33zcMUlpUv/4mZtxAFzF0hEYE7cJCcEqENpm3R1zKaYvuICUvzkRWh2kaH
         o5hoG5AWwpTfQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Aug 2023 19:14:20 +0000
Message-Id: <CUMJWFCIG9EI.13F7LU8TYAUE1@seitikki>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo Thinkpad E14
 Gen 2 and 13s-IML
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230807140125.18486-1-tiwai@suse.de>
In-Reply-To: <20230807140125.18486-1-tiwai@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 7, 2023 at 2:01 PM UTC, Takashi Iwai wrote:
> Like other Lenovo laptops, Thinkpad E14 Gen 2 and Thinkpad 13s-IML
> also require to disable the tpm_tis interrupts for avoiding a boot
> hang.
>
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Cc: <stable@vger.kernel.org> # v6.4+
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1213779
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> ---
>  drivers/char/tpm/tpm_tis.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index a98773ac2e55..0633823dc515 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -130,6 +130,22 @@ static const struct dmi_system_id tpm_tis_dmi_table[=
] =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
>  		},
>  	},
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "ThinkPad E14 Gen 2",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad E14 Gen 2"),
> +		},
> +	},
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "ThinkBook 13s-IML",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ThinkBook 13s-IML"),
> +		},
> +	},
>  	{
>  		.callback =3D tpm_tis_disable_irq,
>  		.ident =3D "ThinkPad T490s",
> --=20
> 2.35.3

As almost all issues are with Lenovo, I would instead just put:

	{
		.callback =3D tpm_tis_disable_irq,
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
		},
	},

And delete the existing entries with vendor as "LENOVO".

BR, Jarkko
