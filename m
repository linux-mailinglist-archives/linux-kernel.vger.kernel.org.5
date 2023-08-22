Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B170E7841E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbjHVNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjHVNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8B18B;
        Tue, 22 Aug 2023 06:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB9862274;
        Tue, 22 Aug 2023 13:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32749C43142;
        Tue, 22 Aug 2023 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692710544;
        bh=8f1xuEvwUyr4BzbIAvQIfSMXVJQby2xz/NDa3h2g9HE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=JhIJXRloUMZX1/B6p6lWe+IsPQjLswHXXgg8kpeO2YVkOVjmN3YIpYFZk9atGpiye
         37DrG45RXIp/1mxVUqCBcR9w3EKThIyelrWpGnRFp9qUChBvatHmQrwf5pr6jhK2Pt
         ECHqlTHdjkCsbfYAntga7/AlbccjbWawfNX30GK2CrE3024puGWfvvPDkWG4bpUZ2f
         d8mUWK7WsZRXZrY18+jNQHDc2eoZF1d+jiTxVUc0mIwEJyuVBKmlRMQ1RMzxF9MVy5
         mFgBGS0x56oEjqzTTH6yY9kharuDnUU83wE1av52jJaS/MaZVx7HzHYiXckkCCdez0
         smK94fTqhfQ5g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 16:22:21 +0300
Message-Id: <CUZ3T3G99JG2.29X1G67HRO9QT@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, "Todd Brandt" <todd.e.brandt@intel.com>,
        "Patrick Steinhardt" <ps@pks.im>, "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>
X-Mailer: aerc 0.14.0
References: <20230821140230.1168-1-mario.limonciello@amd.com>
In-Reply-To: <20230821140230.1168-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 21, 2023 at 5:02 PM EEST, Mario Limonciello wrote:
> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
> reported systems the TPM doesn't reply at bootup and returns back the
> command code. This makes the TPM fail probe.
>
> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, check
> the chip vendor and if it's not AMD don't run the checks.
>
> Cc: stable@vger.kernel.org
> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Check x86 vendor for AMD
> ---
>  drivers/char/tpm/tpm_crb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 9eb1a18590123..7faf670201ccc 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -465,8 +465,12 @@ static bool crb_req_canceled(struct tpm_chip *chip, =
u8 status)
> =20
>  static int crb_check_flags(struct tpm_chip *chip)
>  {
> +	int ret =3D 0;
> +#ifdef CONFIG_X86
>  	u32 val;
> -	int ret;
> +
> +	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
> +		return ret;
> =20
>  	ret =3D crb_request_locality(chip, 0);
>  	if (ret)
> @@ -481,6 +485,7 @@ static int crb_check_flags(struct tpm_chip *chip)
> =20
>  release:
>  	crb_relinquish_locality(chip, 0);
> +#endif

Looks much better but the main question here is that is this combination
possible:

1. AMD CPU
2. Non-AMD fTPM (i.e. manufacturer property differs)

BR, Jarkko
