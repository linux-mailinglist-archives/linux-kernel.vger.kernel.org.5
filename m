Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F2D76E12E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjHCHXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjHCHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:23:18 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770B30C7;
        Thu,  3 Aug 2023 00:23:14 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeffd.dynamic.kabel-deutschland.de [95.90.239.253])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D8BAA61E5FE05;
        Thu,  3 Aug 2023 09:22:43 +0200 (CEST)
Message-ID: <dcbf7a17-67e3-d97d-bd18-9b0bd917a6cf@molgen.mpg.de>
Date:   Thu, 3 Aug 2023 09:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 3/3] tpm: Drop CONFIG_HW_RANDOM_TPM
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     jarkko@kernel.org, peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jason@zx2c4.com, dragonn@op.pl
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-4-mario.limonciello@amd.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230803015015.915-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mario,


Thank you for the patch.

Am 03.08.23 um 03:50 schrieb Mario Limonciello:
> As the behavior of whether a TPM is registered for hwrng can be controlled
> by command line, drop the kernel configuration option.

Shouldn’t this be left in to be able to set the default without having 
to change the Linux kernel command line?


Kind regards

Paul


> Cc: Mateusz Schyboll <dragonn@op.pl>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/char/tpm/Kconfig    | 11 -----------
>   drivers/char/tpm/tpm-chip.c |  6 +++---
>   2 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3f..69aaa730dc208 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -27,17 +27,6 @@ menuconfig TCG_TPM
>   
>   if TCG_TPM
>   
> -config HW_RANDOM_TPM
> -	bool "TPM HW Random Number Generator support"
> -	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
> -	default y
> -	help
> -	  This setting exposes the TPM's Random Number Generator as a hwrng
> -	  device. This allows the kernel to collect randomness from the TPM at
> -	  boot, and provides the TPM randomines in /dev/hwrng.
> -
> -	  If unsure, say Y.
> -
>   config TCG_TIS_CORE
>   	tristate
>   	help
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8fb42232bd7a5..0d69335743469 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -533,7 +533,7 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>   	if (!trust_tpm)
>   		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
>   
> -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
> +	if (tpm_is_firmware_upgrade(chip) ||
>   	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>   		return 0;
>   
> @@ -639,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
>   	return 0;
>   
>   out_hwrng:
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
> +	if (!tpm_is_firmware_upgrade(chip) &&
>   	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>   		hwrng_unregister(&chip->hwrng);
>   out_ppi:
> @@ -665,7 +665,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>   void tpm_chip_unregister(struct tpm_chip *chip)
>   {
>   	tpm_del_legacy_sysfs(chip);
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
> +	if (!tpm_is_firmware_upgrade(chip) &&
>   	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>   		hwrng_unregister(&chip->hwrng);
>   	tpm_bios_log_teardown(chip);
