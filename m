Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5346B770C37
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjHDXIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHDXIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD99E60;
        Fri,  4 Aug 2023 16:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE1062134;
        Fri,  4 Aug 2023 23:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E735C433C8;
        Fri,  4 Aug 2023 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691190498;
        bh=ItNgWvZsaaSJcefInBNG4xFTVdgpVOCz5yLOXVz4LRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vin1i7JwwS34CZFfgaAaeB/1NPLC19qBDLhEDXfIimEQepkSzwf3LrV7NjqpQ9Ja+
         IEiWicBpXiXceuUXCoVCqQxcYnCJwIoxFalYyTwFRXT2ppcrIrfRS0IIHD0QUSFfl/
         WfeDmZmTH9hvZ5Mf4v0HFfUCAgWpjb7ZqIy+P88sESYXdYZRbRWzWo2hg2V2NspeB4
         ikcD5Hwlm3dWWSLlkfIjijHWjgB4K/B+Z+/cYlaxvAM+gKAHaZ6yLAzvmB9AP6kIss
         heIPCPSLho1wSWNPhYbtWzO0HdmSrhW8BsS+bSGdQ2lFDt+WecDCnJNZQj89hava8g
         JJNAd2adt2zOg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 05 Aug 2023 02:08:15 +0300
Message-Id: <CUK4ZW0CCW2O.1KY4H1MBT3M85@wks-101042-mac.ad.tuni.fi>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jonathan McDowell" <noodles@meta.com>,
        "Peter Huewe" <peterhuewe@gmx.de>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo P620 devices
X-Mailer: aerc 0.15.2
References: <20230804170638.GA3705864@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <20230804170638.GA3705864@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 4, 2023 at 8:08 PM EEST, Jonathan McDowell wrote:
> The Lenovo ThinkStation P620 suffers from an irq storm issue like
> various other Lenovo machines, so add an entry for it to
> tpm_tis_dmi_table and force polling.
>
> It is worth noting that 481c2d14627de8ecbb54dd125466e4b4a5069b47
> (tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs) does not
> seem to fix the problem on this machine, but setting
> tpm_tis.interrupts=3D0 on the kernel command line does.
>
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index cc42cf3de960..0cbd745374dc 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -162,6 +162,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[=
] =3D {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
>  		},
>  	},
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "ThinkStation P620",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
> +		},
> +	},
>  	{
>  		.callback =3D tpm_tis_disable_irq,
>  		.ident =3D "UPX-TGL",

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
