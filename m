Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50CE777BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjHJPNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHJPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A8270A;
        Thu, 10 Aug 2023 08:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3847A65FBB;
        Thu, 10 Aug 2023 15:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14DBC433C9;
        Thu, 10 Aug 2023 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691680386;
        bh=LoP06YiAc4DavBKGeMfaU0jWFgL4gcfHgDLbJQX1zBs=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=nraCdVjgCsLTXxNllg/UbFHwhok4uISuGIsTDKMgmIVBfQ3AOgeR7xyLmM4ByFRgG
         W2x9caVS91bafugPOH7uVd5QKoTBBad3qPY/TkYdw44ClrOT0tyibCmGjG0lNQ2ji0
         N9eQrwd4h4baFgaMwziUlEt5Ms6BH6TOm4RvvyI3DdDb3iIeebVWZULUNjW/hnZTvg
         kMiChFJhkP5hgdcuKbN6bLESJXgnUh0l8BIm7/xsl5Nxy4cIrt5XKccrPijl0h+pm0
         F+g72guPKfixISSTgAfSQ2XxGKed3b3fpF5uQsv5XYBtPIqXJCuOs7NgHpdlGw3VTH
         4eDj5471ASUEQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:13:00 +0300
Message-Id: <CUOYNABJ9NIW.6PF43I2S20K3@wks-101042-mac.ad.tuni.fi>
Subject: Re: [PATCH] tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
        <peterhuewe@gmx.de>
Cc:     <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <jsnitsel@redhat.com>, <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.15.2
References: <20230808094836.31473-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230808094836.31473-1-peter.ujfalusi@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 8, 2023 at 12:48 PM EEST, Peter Ujfalusi wrote:
> The patch which made it to the kernel somehow changed the
> match condition from
> DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
> to
> DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL")
>
> Revert back to the correct match condition to disable the
> interrupt mode on the board.
>
> Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalusi@=
linux.intel.com/
> Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON UP=
X-i11")
> ---
>  drivers/char/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index ac4daaf294a3..3c0f68b9e44f 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[]=
 =3D {
>  		.ident =3D "UPX-TGL",
>  		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
>  		},
>  	},
>  	{}

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
