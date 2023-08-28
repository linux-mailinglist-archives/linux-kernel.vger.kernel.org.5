Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFF78B669
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjH1R10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjH1R1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:27:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA1103;
        Mon, 28 Aug 2023 10:26:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B8CA5AA;
        Mon, 28 Aug 2023 19:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693243535;
        bh=ssG+wmaauBYkmFohm0LN3Ai/dsIv1Lk5t8fuUcW/ueY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VghHy9QFYH/wYcJxOTD1E+JY/1v2eDBQZIJKqlyw0FtTwTUhmvrzqBd8abTgS8gGv
         ZZtReM92yXAeRUe+HeiAxep9pLa3/XYgvgOrG6YuFpqjKdV774+VvwW6eXtjB+uS6K
         nQqfXYL/0pn8jgLSWmcaDPKo1BmGwngTU/xHnX5A=
Date:   Mon, 28 Aug 2023 20:27:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 9/9] media: qcom: camss: Fix csid-gen2 for test
 pattern generator
Message-ID: <20230828172705.GD14596@pendragon.ideasonboard.com>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
 <20230822200626.1931129-10-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822200626.1931129-10-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for the patch.

On Tue, Aug 22, 2023 at 09:06:26PM +0100, Bryan O'Donoghue wrote:
> From: Andrey Konovalov <andrey.konovalov@linaro.org>
> 
> In the current driver csid Test Pattern Generator (TPG) doesn't work.
> This change:
> - fixes writing frame width and height values into CSID_TPG_DT_n_CFG_0
> - fixes the shift by one between test_pattern control value and the
>   actual pattern.
> - drops fixed VC of 0x0a which testing showed prohibited some test
>   patterns in the CSID to produce output.
> So that TPG starts working, but with the below limitations:
> - only test_pattern=9 works as it should
> - test_pattern=8 and test_pattern=7 produce black frame (all zeroes)
> - the rest of test_pattern's don't work (yavta doesn't get the data)
> - regardless of the CFA pattern set by 'media-ctl -V' the actual pixel
>   order is always the same (RGGB for any RAW8 or RAW10P format in
>   4608x2592 resolution).
> 
> Tested with:
> 
> RAW10P format, VC0:
>  media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>  v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
>  yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video0
> 
> RAW10P format, VC1:
>  media-ctl -V '"msm_csid0":2[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -V '"msm_vfe0_rdi1":0[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -l '"msm_csid0":2->"msm_vfe0_rdi1":0[1]'
>  v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
>  yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video1
> 
> RAW8 format, VC0:
>  media-ctl --reset
>  media-ctl -V '"msm_csid0":0[fmt:SRGGB8/4608x2592 field:none]'
>  media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB8/4608x2592 field:none]'
>  media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>  yavta -B capture-mplane --capture=3 -n 3 -f SRGGB8 -s 4608x2592 /dev/video0
> 
> Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/qcom/camss/camss-csid-gen2.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> index 140c584bfb8b1..6ba2b10326444 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> @@ -355,9 +355,6 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  		u8 dt_id = vc;
>  
>  		if (tg->enabled) {
> -			/* Config Test Generator */
> -			vc = 0xa;
> -
>  			/* configure one DT, infinite frames */
>  			val = vc << TPG_VC_CFG0_VC_NUM;
>  			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
> @@ -370,14 +367,14 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  
>  			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
>  
> -			val = input_format->height & 0x1fff << TPG_DT_n_CFG_0_FRAME_HEIGHT;
> -			val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
> +			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
> +			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
>  			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
>  
>  			val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
>  			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
>  
> -			val = tg->mode << TPG_DT_n_CFG_2_PAYLOAD_MODE;
> +			val = (tg->mode - 1) << TPG_DT_n_CFG_2_PAYLOAD_MODE;
>  			val |= 0xBE << TPG_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
>  			val |= format->decode_format << TPG_DT_n_CFG_2_ENCODE_FORMAT;
>  			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_2(0));

-- 
Regards,

Laurent Pinchart
