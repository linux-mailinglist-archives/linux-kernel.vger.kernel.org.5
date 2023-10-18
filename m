Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFF7CD45C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjJRGVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjJRGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:21:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAF63245;
        Tue, 17 Oct 2023 23:19:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1BDC433C8;
        Wed, 18 Oct 2023 06:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697609953;
        bh=IH6EcdEgGPUVYzbdSUQ9rvp1MDv+kNGyVu7PhFgRdoM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=U6xrjCg+DAIZLu3YLViHoKLLRjPcep7yYsGCnLeVBqbAnWhLL5JNXQUkob2SoWmVd
         dARotGYrICb63g7QBD+3HLRqjzmS4wvp4ZxA2x42G1a9CuCy+gBMOfUsxs34l4MS1g
         aVSslStjDoBypHWs8LPaaVV6fblihup70boMV4Y2ASpCo+l3y7KJbxWh12WfO+CO/c
         0WEqfQXmZ10AN33FXPVSudz50lvqsZpgaufo17Pva2tP7xC9pZGExbwgffN0uYz3/5
         MYlXSnsi0wNBS+MV0v5YpC5GI0JnZowECt6INKlzt4HJ9tCe8p0WbYrfeAZhNwle0y
         W2mvztS839Rng==
Message-ID: <bf18eb83-8cbd-46b3-b3d5-ba3527d16bc8@kernel.org>
Date:   Wed, 18 Oct 2023 15:19:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pata_lagacy: Handle failed ATA timing computation in
 opti82c46x_set_piomode
Content-Language: en-US
To:     Haonan Li <lihaonan1105@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1a0c4378-29b2-43b4-982b-0d92dfb8ed4f@kernel.org>
 <20231018005220.2551586-1-lihaonan1105@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231018005220.2551586-1-lihaonan1105@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 09:52, Haonan Li wrote:
> The function opti82c46x_set_piomode utilizes the ata_timing_compute()
> to determine the appropriate ATA timings for a given device. However,
> in certain conditions where the ata_timing_find_mode() function does
> not find a valid mode, ata_timing_compute() returns an error (-EINVAL),
> leaving the tp struct uninitialized.
> 
> This patch checks the return value of ata_timing_compute() and print
> err message. This avoids any potential use of uninitialized `tp`
> struct in the opti82c46x_set_piomode function.
> 
> Signed-off-by: Haonan Li <lihaonan1105@gmail.com>

Please do not send patches in reply to something else. Also, this is a v2 of a
previous patch so the patch title prefix should indicate that and a change log
should be present after the "---" below.

> ---
>  drivers/ata/pata_legacy.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index 448a511cbc17..3c7163f97aaf 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -579,12 +579,19 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	clock = 1000000000 / khz[sysclk];
>  
>  	/* Get the timing data in cycles */
> -	ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000);
> +	if (ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000)) {
> +		dev_err(ap->dev, "adev: unknown mode %d\n", adev->pio_mode);
> +		return;
> +	}
>  
>  	/* Setup timing is shared */
>  	if (pair) {
>  		struct ata_timing tp;
> -		ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000);
> +
> +		if (ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000)) {
> +			dev_err(ap->dev, "pair: unknown mode %d\n", pair->pio_mode);
> +			return;
> +		}
>  
>  		ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
>  	}

-- 
Damien Le Moal
Western Digital Research

