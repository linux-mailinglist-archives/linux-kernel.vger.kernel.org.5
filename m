Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0A76C3F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjHBEMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjHBEMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E91FF0;
        Tue,  1 Aug 2023 21:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C08617BE;
        Wed,  2 Aug 2023 04:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04098C433C8;
        Wed,  2 Aug 2023 04:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690949553;
        bh=oRDqlYxKeqlLyU5/3lOVQMU8zUY7kUC2UF7YN55Pp7Q=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=j3MeXwPoLkoDTiTVpVpUvhlWNbq9xqIBBDJjgS9N9NdoszVvuyktjoeqty2TeaeOi
         mGZT35480DH0f6kzAA46BMwbf34sGP/aKuc8uqhLBnOifAIRuFu2d1sYWcfQ9uDrHx
         ptycVMG9W6HUdZo96svd1Du3joc/mE3/buUsZARak83ns2pxNW4v3YYFh1j89z58AY
         BJzCjl0uD5zRCGaM3iKQIjPeqK3DwbVjGw+NLNzjuMa+WQkK0DI8wW3JArzQlZ5LC8
         cuPhBR6Zu9WYtD8WddRkQJJsdAk5/MWJyyCa1kXnPkLxOm7sfM3iSVvc/Oc0t4f/wi
         HGGQZwwlz3pTw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 02 Aug 2023 07:12:27 +0300
Message-Id: <CUHRL65F6NY5.QU2JG3AV1QFX@suppilovahvero>
Cc:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <daniil.stas@posteo.net>,
        <bitlord0xff@gmail.com>
Subject: Re: [PATCH] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <peterhuewe@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230801211837.30226-1-mario.limonciello@amd.com>
In-Reply-To: <20230801211837.30226-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 2, 2023 at 12:18 AM EEST, Mario Limonciello wrote:
> The TPM RNG functionality is not necessary for entropy when the CPU
> already supports the RDRAND instruction. The TPM RNG functionality
> was previously disabled on a subset of AMD fTPM series, but reports
> continue to show problems on some systems causing stutter root caused
> to TPM RNG functionality.
>
> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
> that claim to have fixed or not. To accomplish this, move the detection
> into part of the TPM CRB registration and add a flag indicating that
> the TPM should opt-out of registration to hwrng.
>
> Cc: stable@vger.kernel.org # 6.1.y+
> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untruste=
d sources")
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> Reported-by: daniil.stas@posteo.net
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> Reported-by: bitlord0xff@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 80 +++++++------------------------------
>  drivers/char/tpm/tpm_crb.c  | 23 +++++++++++
>  include/linux/tpm.h         |  7 ++++
>  3 files changed, 44 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index cf5499e51999b..3154a5ef2611f 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -89,6 +89,14 @@ static void tpm_clk_disable(struct tpm_chip *chip)
>  		chip->ops->clk_enable(chip, false);
>  }
> =20
> +static int tpm_check_flags(struct tpm_chip *chip)
> +{
> +	if (!chip->ops->check_flags)
> +		return 0;
> +
> +	return chip->ops->check_flags(chip);
> +}

Instead of adding a new callback, you should probably do the following
in crb_acpi_add(), and get a much less complicated fix:

1. Call tpm_chip_bootstrap() (see tpm_tis_core_init()).
2. Set TPM_CHIP_FLAG_HWRNG_DISABLED if the conditions have been met.
3. Call tpm_chip_register().

> +
>  /**
>   * tpm_chip_start() - power on the TPM
>   * @chip:	a TPM chip to use
> @@ -510,70 +518,6 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chi=
p)
>  	return 0;
>  }
> =20
> -/*
> - * Some AMD fTPM versions may cause stutter
> - * https://www.amd.com/en/support/kb/faq/pa-410
> - *
> - * Fixes are available in two series of fTPM firmware:
> - * 6.x.y.z series: 6.0.18.6 +
> - * 3.x.y.z series: 3.57.y.5 +
> - */
> -#ifdef CONFIG_X86
> -static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> -{
> -	u32 val1, val2;
> -	u64 version;
> -	int ret;
> -
> -	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
> -		return false;
> -
> -	ret =3D tpm_request_locality(chip);
> -	if (ret)
> -		return false;
> -
> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val1, NULL);
> -	if (ret)
> -		goto release;
> -	if (val1 !=3D 0x414D4400U /* AMD */) {
> -		ret =3D -ENODEV;
> -		goto release;
> -	}
> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_1, &val1, NULL);
> -	if (ret)
> -		goto release;
> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_2, &val2, NULL);
> -
> -release:
> -	tpm_relinquish_locality(chip);
> -
> -	if (ret)
> -		return false;
> -
> -	version =3D ((u64)val1 << 32) | val2;
> -	if ((version >> 48) =3D=3D 6) {
> -		if (version >=3D 0x0006000000180006ULL)
> -			return false;
> -	} else if ((version >> 48) =3D=3D 3) {
> -		if (version >=3D 0x0003005700000005ULL)
> -			return false;
> -	} else {
> -		return false;
> -	}
> -
> -	dev_warn(&chip->dev,
> -		 "AMD fTPM version 0x%llx causes system stutter; hwrng disabled\n",
> -		 version);
> -
> -	return true;
> -}
> -#else
> -static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_X86 */
> -
>  static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, boo=
l wait)
>  {
>  	struct tpm_chip *chip =3D container_of(rng, struct tpm_chip, hwrng);
> @@ -588,7 +532,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *da=
ta, size_t max, bool wait)
>  static int tpm_add_hwrng(struct tpm_chip *chip)
>  {
>  	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) =
||
> -	    tpm_amd_is_rng_defective(chip))
> +	    tpm_is_rng_disabled(chip))
>  		return 0;
> =20
>  	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> @@ -670,6 +614,10 @@ int tpm_chip_register(struct tpm_chip *chip)
>  	if (rc)
>  		return rc;
> =20
> +	rc =3D tpm_check_flags(chip);
> +	if (rc)
> +		return rc;
> +
>  	tpm_sysfs_add_device(chip);
> =20
>  	tpm_bios_log_setup(chip);
> @@ -719,7 +667,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  {
>  	tpm_del_legacy_sysfs(chip);
>  	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) =
&&
> -	    !tpm_amd_is_rng_defective(chip))
> +	    !tpm_is_rng_disabled(chip))
>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 1a5d09b185134..5614b68ef1905 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -463,6 +463,28 @@ static bool crb_req_canceled(struct tpm_chip *chip, =
u8 status)
>  	return (cancel & CRB_CANCEL_INVOKE) =3D=3D CRB_CANCEL_INVOKE;
>  }
> =20
> +static int crb_check_flags(struct tpm_chip *chip)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D crb_request_locality(chip, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> +	if (ret)
> +		goto release;
> +
> +	if (val =3D=3D 0x414D4400U /* AMD */)
> +		chip->flags |=3D TPM_CHIP_FLAG_HWRNG_DISABLED;
> +
> +release:
> +	crb_relinquish_locality(chip, 0);
> +
> +	return ret;
> +}
> +
>  static const struct tpm_class_ops tpm_crb =3D {
>  	.flags =3D TPM_OPS_AUTO_STARTUP,
>  	.status =3D crb_status,
> @@ -476,6 +498,7 @@ static const struct tpm_class_ops tpm_crb =3D {
>  	.relinquish_locality =3D crb_relinquish_locality,
>  	.req_complete_mask =3D CRB_DRV_STS_COMPLETE,
>  	.req_complete_val =3D CRB_DRV_STS_COMPLETE,
> +	.check_flags =3D crb_check_flags,
>  };
> =20
>  static int crb_check_resource(struct acpi_resource *ares, void *data)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6a1e8f1572551..aeb84944b0ca4 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -82,6 +82,7 @@ struct tpm_class_ops {
>  	int (*request_locality)(struct tpm_chip *chip, int loc);
>  	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
>  	void (*clk_enable)(struct tpm_chip *chip, bool value);
> +	int (*check_flags)(struct tpm_chip *chip);
>  };
> =20
>  #define TPM_NUM_EVENT_LOG_FILES		3
> @@ -283,6 +284,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	=3D BIT(6),
>  	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		=3D BIT(7),
>  	TPM_CHIP_FLAG_SUSPENDED			=3D BIT(8),
> +	TPM_CHIP_FLAG_HWRNG_DISABLED		=3D BIT(9),
>  };
> =20
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> @@ -417,6 +419,11 @@ static inline u32 tpm2_rc_value(u32 rc)
>  	return (rc & BIT(7)) ? rc & 0xff : rc;
>  }
> =20
> +static inline bool tpm_is_rng_disabled(struct tpm_chip *chip)
> +{
> +	return chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED;
> +}

Please open code to the call sites.

Wrapping a flag check is not very useful and makes the bug fix
only more complex.

> +
>  #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> =20
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
> --=20
> 2.34.1

BR, Jarkko
