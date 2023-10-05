Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471277BA3D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbjJEP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJEP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86649158FF;
        Thu,  5 Oct 2023 06:57:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E97BC4AF76;
        Thu,  5 Oct 2023 13:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696513119;
        bh=F8uLKRMaqIMTxEEJ0Tsvy4TdC8fIt8Vx4EseGKGLtPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5SUr0VxoNw+IMG3d+fiAzkAjXm8HBBlx+hHso1qsYXmPAT8O0zA5EIrAoa5dOJ29
         AWqrQ1SeDYDcKFHNGuFBhsqnVDdUleFpRpShtXXR0py1kMq2uz6CGz+9swRsrXhoS4
         H4cHn7bEHfyCivvLnm4J8Pq6RWsQEJSOAW74mSjKLRQjk6Ty1JpwvMe0NRhs5H1c0b
         rakipOaXlBZbpQ2A+U0LubipL2oLp7e7rqiH4/hSMqB5BDVc4DtSXSZJRmlsDxfKIL
         C8vGeYTbMHHJC5BGs6Xr05XC1yLPcN+o7LITZ7NemOphJSzQgjghmJPadPGiVSjx4s
         dBbAkOEUYMRxg==
Date:   Thu, 5 Oct 2023 14:38:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH v5 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data
 to support PPG
Message-ID: <20231005133832.GE681678@google.com>
References: <20230929003901.15086-1-quic_amelende@quicinc.com>
 <20230929003901.15086-6-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929003901.15086-6-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023, Anjelique Melendez wrote:

> Update the pmi632 lpg_data struct so that pmi632 devices use PPG
> for LUT pattern.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 4d87686f916c..a6cea6bd7167 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1660,11 +1660,13 @@ static const struct lpg_data pm8994_lpg_data = {
>  static const struct lpg_data pmi632_lpg_data = {
>  	.triled_base = 0xd000,
>  
> +	.lut_size = 64,
> +
>  	.num_channels = 5,
>  	.channels = (const struct lpg_channel_data[]) {
> -		{ .base = 0xb300, .triled_mask = BIT(7) },
> -		{ .base = 0xb400, .triled_mask = BIT(6) },
> -		{ .base = 0xb500, .triled_mask = BIT(5) },
> +		{ .base = 0xb300, .triled_mask = BIT(7), .sdam_offset = 0x48 },
> +		{ .base = 0xb400, .triled_mask = BIT(6), .sdam_offset = 0x56 },
> +		{ .base = 0xb500, .triled_mask = BIT(5), .sdam_offset = 0x64 },
>  		{ .base = 0xb600 },
>  		{ .base = 0xb700 },
>  	},
> -- 
> 2.41.0
> 

-- 
Lee Jones [李琼斯]
