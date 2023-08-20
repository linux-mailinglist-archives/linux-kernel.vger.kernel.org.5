Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14605781CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjHTGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHTGbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:31:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D4E1FD0C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 23:21:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id XbopquAHDDlJeXbopqqbZP; Sun, 20 Aug 2023 08:21:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692512516;
        bh=ThuLDT8nSHSjGto8PMgzgXI6RaUcGGOKMyvmKUe1mVI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KIM+1Oz8yOvMyHO1jXmfLNpW4XflmDQi1l5spgDjO2FD5ewnDjHNdCSz3yaCi5uBk
         XE3P4EciKMIVcY93nScgoLtLHwq4RIyl0CZV8zl6LzgBJPCmvEpAUkOJS6glcMBxja
         2JVLkMFJa+rHkqD5N71USNUqhgTY6fTx3GycvCHpZIF4t1tfcj17Vt15PzGVv9FDpj
         hCihhB4JMBXpEtMhSNLnibaYThdGoU2eMK85RdFAEKrr0n0L/bLb0CxufijdpaglHB
         N6dfrFsXuVm42SU1mXQl7okSRLJHpvPxI65kgJp+nFK0ux9jT0nM0qWQo1NVvACeDf
         dlXpm9MXJzpRg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 08:21:56 +0200
X-ME-IP: 86.243.2.178
Message-ID: <c2263ee0-2133-6f89-3f16-2ae1129a20df@wanadoo.fr>
Date:   Sun, 20 Aug 2023 08:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tpm_crb: Fix an error handling path in crb_acpi_add()
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <a820eaf8c77ca4fde50fc170f535de4b28c82a2d.1677322706.git.christophe.jaillet@wanadoo.fr>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <a820eaf8c77ca4fde50fc170f535de4b28c82a2d.1677322706.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/02/2023 à 11:58, Christophe JAILLET a écrit :
> Some error paths don't call acpi_put_table() before returning.
> Branch to the correct place instead of doing some direct return.
> 
> Fixes: 4d2732882703 ("tpm_crb: Add support for CRB devices based on Pluton")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/char/tpm/tpm_crb.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 99698ee1a744..f7068bd8b3d0 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -771,12 +771,13 @@ static int crb_acpi_add(struct acpi_device *device)
>   				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
>   				buf->header.length,
>   				ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON);
> -			return -EINVAL;
> +			rc = -EINVAL;
> +			goto out;
>   		}
>   		crb_pluton = ACPI_ADD_PTR(struct tpm2_crb_pluton, buf, sizeof(*buf));
>   		rc = crb_map_pluton(dev, priv, buf, crb_pluton);
>   		if (rc)
> -			return rc;
> +			goto out;
>   	}
>   
>   	priv->sm = sm;

Hi,

polite reminder.

While re-looking at it, the 3rd parameter of crb_map_pluton() (i.e. buf) 
looks unused and could be removed if it makes sense to you.

CJ
