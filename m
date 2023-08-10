Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A572778370
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjHJWHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:07:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F89128;
        Thu, 10 Aug 2023 15:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F18E66860;
        Thu, 10 Aug 2023 22:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B73FC433C7;
        Thu, 10 Aug 2023 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691705269;
        bh=PQiYUbrn+vxUBT9giTaeZQwFIePU9/l3mZVQ1pA+f7U=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Si5Q+VAjW9dkV8N21TrN+4smAXGiYLJMfpT6jNzfaf1F5O7ziz1k5cgrGDAqcVm9V
         IWHdfFz5H2UHFX6A8LtQtmwrPWjDI/wmPBT7Y9F6DX1xgUycPR4AGGVhcOuN/s7x9P
         SN0FpMtTzTGHhiNipDGZYOQlcdxwEII+pGjgPB+AnvspEmZ0XHKFUaFC73hjOvpiiw
         itI1ifN3tLy5N6SR9H7pnCEXryJ7zgP9wElNOFza+P20PUWyCZF0LTX13sGdyXtECu
         Y8VtnAW/9kwE0mz1aP3qlZPTswNvpiAhsmtNBl1ieBj0T+figg8E/23DzQS+SMPqWS
         QqH49A5ezs7KQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 01:07:45 +0300
Message-Id: <CUP7GU9KZ8TD.2R2AI53X2RLTS@suppilovahvero>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for MSI GS66 Stealth
 11UG
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jonathan McDowell" <noodles@meta.com>,
        "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230810091851.GA1088011@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <20230810091851.GA1088011@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 10, 2023 at 12:18 PM EEST, Jonathan McDowell wrote:
> The MSI GS66 Stealth 11UG laptop also suffers from an IRQ problem with
> tpm_tis, causing the TPM to be inaccessible. Add an entry to
> tpm_tis_dmi_table to force polling mode.
>
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index ac4daaf294a3..14dee959ee19 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -130,6 +130,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[=
] =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
>  		},
>  	},
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "MSI GS66 Stealth 11UG",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GS66 Stealth 11UG"),
> +		},
> +	},
>  	{
>  		.callback =3D tpm_tis_disable_irq,
>  		.ident =3D "ThinkPad T490s",
> --=20
> 2.41.0

Thanks, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?h=3Dnext&id=3Dfe59c383eaef3cbcfe2c0404ee449a88c4e01155

BR, Jarkko
