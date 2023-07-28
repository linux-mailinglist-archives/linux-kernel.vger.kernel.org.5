Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8C767643
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjG1TYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1TYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D36BF;
        Fri, 28 Jul 2023 12:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE15621DD;
        Fri, 28 Jul 2023 19:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BD5C433C8;
        Fri, 28 Jul 2023 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690572273;
        bh=kCVSSQB7vzNjIBbdRo2kjKff5xvX1ePhErKmi0IDngs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvsknU0ortHAV8r9efa6lSuatJdKZSr7TxPdDwjl0Uj6FiCwjbXW9J95WkeXKSYbo
         Q6n/T7Q49Omyb1t/1+cZ6Ae7AlMhPmrKgwJnMfZhlUSMjcBpy4uhnFaVLwHKZsSUPO
         JNuCjsUSYrB0IF9KsdgrGlK4mdqjI28g35kouVxQivRyXNcFCsC8tn87ekhI6JcQwO
         kuXbiq1MLdj+e093tMTxG/NPbBCGuNI3sbPDuFf0ooKfM9k8urykiHYP1N8mGbx25O
         eUZn0l2QV03bUS+D5pPmw/6YpNyezCH2Au4nexK1yYnqjknq75hE70p9PiNHg5iKKX
         xO9RWDIj63HkA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 19:24:30 +0000
Message-Id: <CUE1URH8QI55.15YQBHZNSL2UJ@seitikki>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>, "Peter Huewe" <peterhuewe@gmx.de>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook
 S 15/17 Gen7
X-Mailer: aerc 0.14.0
References: <20230726180035.14511-1-tiwai@suse.de>
In-Reply-To: <20230726180035.14511-1-tiwai@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 26, 2023 at 6:00 PM UTC, Takashi Iwai wrote:
> TUXEDO InfinityBook S 15/17 Gen7 suffers from an IRQ problem on
> tpm_tis like a few other laptops.  Add an entry for the workaround.
>
> Cc: stable@vger.kernel.org
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1213645
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index cc42cf3de960..a98773ac2e55 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -162,6 +162,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[=
] =3D {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
>  		},
>  	},
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "TUXEDO InfinityBook S 15/17 Gen7",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TUXEDO InfinityBook S 15/17 Gen7"),
> +		},
> +	},
>  	{
>  		.callback =3D tpm_tis_disable_irq,
>  		.ident =3D "UPX-TGL",
> --=20
> 2.35.3

Hi does this occur with the latest linux-next and/or v6.5-rc3?

BR, Jarkko
