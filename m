Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085A7BA0AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjJEOgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbjJEOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC71525F;
        Thu,  5 Oct 2023 06:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99550C4AF75;
        Thu,  5 Oct 2023 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696513532;
        bh=vqu+fFoHGpohKG1mWSUhsvBpzumWkJeROSRoIa9+DVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUYID7x6le67JFoKgGTzvbOTjyJO9NDAdrJ3AEs17CFNCTmHQB3iiehmDUoGRvI16
         RTQK/rSA7fykjZtx5smqscln90NaNT25zQ9duynurs9ANBT1K8US5Tu+y2xCEymowP
         pfOsKPNNJ38+ogNc3HROV3NlPWkeHwb4NOYgcnKpmXLBM7zsS+6Y3ykVnNibdrogC/
         YLJ1XeiljTIxcifJNOLabr9iZ+pQZdGzKl/yptPIb/7yS77O8RR/3KLj3ki3Acv3aJ
         Y39WVOS2TYW5MsSoApmvY+QPjLAUQ1YA5u1nPxPs+BlkipZ8paTR1ejwC7Qyu4y5rw
         KsSnKTuLL0aVw==
Date:   Thu, 5 Oct 2023 14:45:25 +0100
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
Subject: Re: [PATCH v5 7/7] leds: rgb: Update PM8350C lpg_data to support
 two-nvmem PPG Scheme
Message-ID: <20231005134525.GG681678@google.com>
References: <20230929003901.15086-1-quic_amelende@quicinc.com>
 <20230929003901.15086-8-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929003901.15086-8-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023, Anjelique Melendez wrote:

> Update the pm8350c lpg_data struct so that pm8350c devices are treated as
> PWM devices that support two-nvmem PPG scheme.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 910c7cf740cc..8962ea13df29 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1800,11 +1800,13 @@ static const struct lpg_data pm8150l_lpg_data = {
>  static const struct lpg_data pm8350c_pwm_data = {
>  	.triled_base = 0xef00,
>  
> +	.lut_size = 122,
> +
>  	.num_channels = 4,
>  	.channels = (const struct lpg_channel_data[]) {
> -		{ .base = 0xe800, .triled_mask = BIT(7) },
> -		{ .base = 0xe900, .triled_mask = BIT(6) },
> -		{ .base = 0xea00, .triled_mask = BIT(5) },
> +		{ .base = 0xe800, .triled_mask = BIT(7), .sdam_offset = 0x48 },
> +		{ .base = 0xe900, .triled_mask = BIT(6), .sdam_offset = 0x56 },
> +		{ .base = 0xea00, .triled_mask = BIT(5), .sdam_offset = 0x64 },
>  		{ .base = 0xeb00 },
>  	},
>  };
> -- 
> 2.41.0
> 

-- 
Lee Jones [李琼斯]
