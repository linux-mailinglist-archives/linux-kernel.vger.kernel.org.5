Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86EC782694
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjHUJyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjHUJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE035A1;
        Mon, 21 Aug 2023 02:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9FF61046;
        Mon, 21 Aug 2023 09:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432BDC433C7;
        Mon, 21 Aug 2023 09:53:55 +0000 (UTC)
Message-ID: <edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl>
Date:   Mon, 21 Aug 2023 11:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v0 8/9] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE
 when VC is greater than 3
Content-Language: en-US, nl
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
 <20230814141007.3721197-9-bryan.odonoghue@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230814141007.3721197-9-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

On 14/08/2023 16:10, Bryan O'Donoghue wrote:
> VC_MODE = 0 implies a two bit VC address.
> VC_MODE = 1 is required for VCs with a larger address than two bits.

This explains the second chunk in the patch below, but it doesn't explain
why dt_id is now suddenly vc * 4 instead of vc.

I don't feel comfortable merging this patch since I'm not sure if that
dt_id change was perhaps an error.

If the change IS correct, then please reply and provide a better commit
log.

Regards,

	Hans

> 
> Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-csid-gen2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> index 45c7986d4a8d0..9ac253111e572 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> @@ -352,7 +352,7 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  		phy_sel = csid->phy.csiphy_id;
>  
>  	if (enable) {
> -		u8 dt_id = vc;
> +		u8 dt_id = vc * 4;
>  
>  		if (tg->enabled) {
>  			/* Config Test Generator */
> @@ -449,6 +449,8 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
>  
>  	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
> +	if (vc > 3)
> +		val |= 1 << CSI2_RX_CFG1_VC_MODE;
>  	val |= 1 << CSI2_RX_CFG1_MISR_EN;
>  	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
>  

