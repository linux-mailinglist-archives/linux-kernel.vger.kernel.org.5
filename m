Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA27F3EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKVHLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjKVHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:11:05 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FD1A4;
        Tue, 21 Nov 2023 23:11:00 -0800 (PST)
Received: from [10.0.3.168] (unknown [93.240.169.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2625861E5FE01;
        Wed, 22 Nov 2023 08:10:35 +0100 (CET)
Message-ID: <c9a92192-ee28-4bbf-a02d-1df0d5822027@molgen.mpg.de>
Date:   Wed, 22 Nov 2023 08:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
To:     Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Hermin,


Thank you for your patch.

It’d be great if you removed the dot/period from the end of the commit 
message summary/title.

Am 22.11.23 um 07:55 schrieb Hermin Anggawijaya:
> Before sending a command to attempt the self test, the TPM
> may need to be started, otherwise the self test returns
> TPM2_RC_INITIALIZE value causing a log as follows:
> "tpm tpm0: A TPM error (256) occurred attempting the self test".

Please document on what platform this happens.

> Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
> ---
>   drivers/char/tpm/tpm2-cmd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 93545be190a5..0530f3b5f86a 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -737,15 +737,15 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>   	if (rc)
>   		goto out;
>   
> +	rc = tpm2_startup(chip);
> +	if (rc && rc != TPM2_RC_INITIALIZE)
> +		goto out;
> +
>   	rc = tpm2_do_selftest(chip);
>   	if (rc && rc != TPM2_RC_INITIALIZE)
>   		goto out;
>   
>   	if (rc == TPM2_RC_INITIALIZE) {
> -		rc = tpm2_startup(chip);
> -		if (rc)
> -			goto out;
> -
>   		rc = tpm2_do_selftest(chip);
>   		if (rc)
>   			goto out;


Kind regards,

Paul
