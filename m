Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D93758DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGSGSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGSGSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78B1FC0;
        Tue, 18 Jul 2023 23:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2C3960F89;
        Wed, 19 Jul 2023 06:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11382C433C7;
        Wed, 19 Jul 2023 06:18:40 +0000 (UTC)
Message-ID: <21e13f35-5caf-6d60-c388-3386e3540834@xs4all.nl>
Date:   Wed, 19 Jul 2023 08:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: aspeed: Fix memory overwrite if timing is
 1600x900
Content-Language: en-US
To:     Jammy Huang <orbit.huang@gmail.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jammy Huang <jammy_huang@aspeedtech.com>
References: <20230717095111.1957-1-jammy_huang@aspeedtech.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230717095111.1957-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jammy,

On 17/07/2023 11:51, Jammy Huang wrote:
> When capturing 1600x900, system could crash when system memory usage is
> tight.
> 
> The way to reproduce this issue:
> 1. Use 1600x900 to display on host
> 2. Mount ISO through 'Virtual media' on OpenBMC's web
> 3. Run script as below on host to do sha continuously
>   #!/bin/bash
>   while [ [1] ];
>   do
> 	find /media -type f -printf '"%h/%f"\n' | xargs sha256sum
>   done
> 4. Open KVM on OpenBMC's web
> 
> The size of macro block captured is 8x8. Therefore, we should make sure
> the height of src-buf is 8 aligned to fix this issue.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Your email address you sent this from differs from your SoB. Can you post
again from the correct email address? Checkpatch complains about this.

Regards,

	Hans

> ---
>  v2 changes
>   - Add how to reproduce this issue.
> ---
>  drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index 374eb7781936..14594f55a77f 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -1130,7 +1130,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>  static void aspeed_video_set_resolution(struct aspeed_video *video)
>  {
>  	struct v4l2_bt_timings *act = &video->active_timings;
> -	unsigned int size = act->width * act->height;
> +	unsigned int size = act->width * ALIGN(act->height, 8);
>  
>  	/* Set capture/compression frame sizes */
>  	aspeed_video_calc_compressed_size(video, size);
> @@ -1147,7 +1147,7 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>  		u32 width = ALIGN(act->width, 64);
>  
>  		aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | act->height);
> -		size = width * act->height;
> +		size = width * ALIGN(act->height, 8);
>  	} else {
>  		aspeed_video_write(video, VE_CAP_WINDOW,
>  				   act->width << 16 | act->height);
> 
> base-commit: 2605e80d3438c77190f55b821c6575048c68268e

