Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A13758FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGSIEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGSIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA8BE;
        Wed, 19 Jul 2023 01:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4305A61228;
        Wed, 19 Jul 2023 08:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E2DC433C8;
        Wed, 19 Jul 2023 08:04:28 +0000 (UTC)
Message-ID: <7dcadd80-ae5c-0e53-d91a-2ee5028e51f5@xs4all.nl>
Date:   Wed, 19 Jul 2023 10:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] media:Fix repeated initialization
Content-Language: en-US
To:     Wang Ming <machel@vivo.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-media@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230705142142.3526-1-machel@vivo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230705142142.3526-1-machel@vivo.com>
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

On 05/07/2023 16:21, Wang Ming wrote:
> If the first report returns NULL,
> there is no need to execute the
> fimc_capture_try_format() function
> again.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  .../media/platform/samsung/exynos4-is/fimc-capture.c   | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
> index a0d43bf892e6..5ce2f04afa1e 100644
> --- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
> +++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
> @@ -825,10 +825,12 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
>  		tfmt->height = mf->height;
>  		ffmt = fimc_capture_try_format(ctx, &tfmt->width, &tfmt->height,
>  					NULL, &fcc, FIMC_SD_PAD_SINK_CAM);
> -		ffmt = fimc_capture_try_format(ctx, &tfmt->width, &tfmt->height,
> -					NULL, &fcc, FIMC_SD_PAD_SOURCE);
> -		if (ffmt && ffmt->mbus_code)
> -			mf->code = ffmt->mbus_code;
> +		if (ffmt) {
> +			ffmt = fimc_capture_try_format(ctx, &tfmt->width, &tfmt->height,
> +				NULL, &fcc, FIMC_SD_PAD_SOURCE);
> +			if (ffmt && ffmt->mbus_code)
> +				mf->code = ffmt->mbus_code;
> +		}

I'm not so sure this is a bug at all. I think (not quite certain) that the
first fimc_capture_try_format() call constrains the width and height to
whatever is the SINK_CAM pad, then further constrains it to that of the
SOURCE pad.

But really, someone from Samsung should take a look as well. Adding Marek and
Sylwester.

Regards,

	Hans

>  		if (mf->width != tfmt->width || mf->height != tfmt->height)
>  			continue;
>  		tfmt->code = mf->code;

