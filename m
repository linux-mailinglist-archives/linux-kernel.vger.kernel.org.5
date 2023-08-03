Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3A76E3E2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjHCJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjHCJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5782C3AA8;
        Thu,  3 Aug 2023 02:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 217C961CEC;
        Thu,  3 Aug 2023 09:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF5AC433C7;
        Thu,  3 Aug 2023 09:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053323;
        bh=sqPG+ysOgyUlqjDwjPLXOytpQBtxbeKvqrxIv64ng80=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=oaiKDNF0aYuwG4Q9bZZWRNR+xJdDLcKjbEWIVEOI0tgb+Kd8LoX6mD2xGimBL++vg
         haTuZ9DxtLjbyA/+ut+afO3S7dMjgxrhxlIMc/OUVI8GtgOu7s8o9chDnnoGtarLo/
         kRek1OKsFMnb2RAAF8oAxYEx1K3L9vi5GpUul2e3zlnJgEGdHYL0zIzdFauwe9LQc4
         fTUcxEyH3YA7+12CC3j+r4+A8cPwn7ux2v7vc7tuKS0s1+vMwRtruJXKKqKGCGx9Om
         7ZNvHLg/TY5LJD3gjkAUOHi1I4AWUBfqDFOavpATZWOiO2RG46rcWsf3oSld//IaAF
         CiqS1SDodAt0A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 03 Aug 2023 12:01:59 +0300
Message-Id: <CUISDE4L54JX.2KYPM33L74XRT@suppilovahvero>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <peterhuewe@gmx.de>
Cc:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <Jason@zx2c4.com>, <dragonn@op.pl>
Subject: Re: [PATCH 3/3] tpm: Drop CONFIG_HW_RANDOM_TPM
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-4-mario.limonciello@amd.com>
In-Reply-To: <20230803015015.915-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 3, 2023 at 4:50 AM EEST, Mario Limonciello wrote:
> As the behavior of whether a TPM is registered for hwrng can be controlle=
d
> by command line, drop the kernel configuration option.
>
> Cc: Mateusz Schyboll <dragonn@op.pl>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/char/tpm/Kconfig    | 11 -----------
>  drivers/char/tpm/tpm-chip.c |  6 +++---
>  2 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3f..69aaa730dc208 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -27,17 +27,6 @@ menuconfig TCG_TPM
> =20
>  if TCG_TPM
> =20
> -config HW_RANDOM_TPM
> -	bool "TPM HW Random Number Generator support"
> -	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=3Dy && HW_RANDOM=3Dm)
> -	default y
> -	help
> -	  This setting exposes the TPM's Random Number Generator as a hwrng
> -	  device. This allows the kernel to collect randomness from the TPM at
> -	  boot, and provides the TPM randomines in /dev/hwrng.
> -
> -	  If unsure, say Y.
> -
>  config TCG_TIS_CORE
>  	tristate
>  	help
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8fb42232bd7a5..0d69335743469 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -533,7 +533,7 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>  	if (!trust_tpm)
>  		chip->flags |=3D TPM_CHIP_FLAG_HWRNG_DISABLED;
> =20
> -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) =
||
> +	if (tpm_is_firmware_upgrade(chip) ||
>  	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>  		return 0;
> =20
> @@ -639,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
>  	return 0;
> =20
>  out_hwrng:
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) =
&&
> +	if (!tpm_is_firmware_upgrade(chip) &&
>  	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>  		hwrng_unregister(&chip->hwrng);
>  out_ppi:
> @@ -665,7 +665,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>  void tpm_chip_unregister(struct tpm_chip *chip)
>  {
>  	tpm_del_legacy_sysfs(chip);
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) =
&&
> +	if (!tpm_is_firmware_upgrade(chip) &&
>  	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
> --=20
> 2.34.1

I don't understand this but please take it a way from patch set, which
should only contain critical fixes, which this definitely is not.

BR, Jarkko
