Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4F76E3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjHCI7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjHCI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D20E58;
        Thu,  3 Aug 2023 01:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9AE461CE1;
        Thu,  3 Aug 2023 08:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F44EC433C8;
        Thu,  3 Aug 2023 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053186;
        bh=B1vzxq/kRKyZ43zAZmPOBu+yETrjQdKBLQMnoE5XNf8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=DLj0UTfwxlU82JisgfMzfjOyDChvMMqerlTzeenac245A11drO+yIHXeXYFWoegJn
         KcK0FMW852YYfgGmnvwaWEwzYvGyAeU8/lASqjVQVmLVhRhYfEmHhNJzfsA78VNkWZ
         GFvCIZKGTaj9UORaIuKuJ6NJu9gVORcGz64h3ZkSgHUyDbHpVu4bxiCPJeuD7AQV99
         J9TX5B2KJE/OfjCBFVbWcerkZVG9OE8dtXCsh59ewha8k/g8PPZMgN7kSBoepQBVpE
         dPU7wDMF7FMhcX3P0RGzf9us1IJD43vTZ4AxFZ+e1qMSiLIhG7GwhA27tuKnbhbMhq
         3H5wW4SMLBIdQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 03 Aug 2023 11:59:41 +0300
Message-Id: <CUISBN0W36B2.1DXXNNGS6P7JC@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <Jason@zx2c4.com>, <dragonn@op.pl>
Subject: Re: [PATCH 1/3] tpm: Add a missing check for
 TPM_CHIP_FLAG_HWRNG_DISABLED
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <peterhuewe@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-2-mario.limonciello@amd.com>
In-Reply-To: <20230803015015.915-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 3, 2023 at 4:50 AM EEST, Mario Limonciello wrote:
> If the TPM is opted out of hwrng the error handling for
> tpm_chip_register() needs to know this so it doesn't try to clean
> up an uninitialized chip->hwrng.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e904aae9771be..8f61b784810d6 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -629,7 +629,8 @@ int tpm_chip_register(struct tpm_chip *chip)
>  	return 0;
> =20
>  out_hwrng:
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) =
&&
> +	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>  		hwrng_unregister(&chip->hwrng);
>  out_ppi:
>  	tpm_bios_log_teardown(chip);
> --=20
> 2.34.1

Please add a fixes tag.

BR, Jarkko
