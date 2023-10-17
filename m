Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD47CD0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjJQXgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjJQXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:36:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D3B0;
        Tue, 17 Oct 2023 16:36:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0809C433C8;
        Tue, 17 Oct 2023 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697585810;
        bh=vWDxX5Zfp3qv9pYv4nE5+avCskI58/L69mzMGCW3v4g=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=h2kg+QHGDrbxf0pir+DJUzTxg/YtnHssBSxqcJ6qkto8Y0zFc9boBKiKC8waR/8zj
         JeMOaFgZ27RedCfglkjVDgDQJo9oJJaLhGYuzeTHdbaBYkzkLbxjIRhA7zvm/vfWdM
         tQ5k1qI4rPRvKdkw59f/yxI0Sd+EMhuLOJHeLZQsZEHtWLll5dQfzIyRNrgLqh0sR/
         LEp5nlZlMSwbAnI+LBaUExp2JfBR4N5wI7GEEJRv4wWmOnrkWlf+AcPRNtuAY0Z2PP
         YIHp/SBX4XQuQ15dW8HTGFB7IonsiJO+Dkb3A8bLaNVChf+6i4wVtmQKYGaE1khd6p
         TSgZaWf1J5EWQ==
Message-ID: <1a0c4378-29b2-43b4-982b-0d92dfb8ed4f@kernel.org>
Date:   Wed, 18 Oct 2023 08:36:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pata_lagacy: Handle failed ATA timing computation in
 opti82c46x_set_piomode
Content-Language: en-US
To:     Haonan Li <lihaonan1105@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231017233234.2170437-1-lihaonan1105@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231017233234.2170437-1-lihaonan1105@gmail.com>
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

On 10/18/23 08:32, Haonan Li wrote:
> The function opti82c46x_set_piomode utilizes the ata_timing_compute()
> to determine the appropriate ATA timings for a given device. However,
> in certain conditions where the ata_timing_find_mode() function does
> not find a valid mode, ata_timing_compute() returns an error (-EINVAL),
> leaving the tp struct uninitialized.
> 
> This patch checks the return value of ata_timing_compute().
> This avoids any potential use of uninitialized `tp` struct in the
> opti82c46x_set_piomode function.
> 
> Signed-off-by: Haonan Li <lihaonan1105@gmail.com>
> ---
>  drivers/ata/pata_legacy.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index 448a511cb..d94c365cb 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -579,12 +579,16 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	clock = 1000000000 / khz[sysclk];
>  
>  	/* Get the timing data in cycles */
> -	ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000);
> +	if (ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000)) {
> +		return;
> +	}

You need a message here to tell the user something is wrong. See pata_amd.c for
an example.

>  
>  	/* Setup timing is shared */
>  	if (pair) {
>  		struct ata_timing tp;
> -		ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000);
> +		if (ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000)) {
> +			return;
> +		}

Same here. And while at it, please add a blank line after the declaration and
before your change.

>  
>  		ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
>  	}

-- 
Damien Le Moal
Western Digital Research

