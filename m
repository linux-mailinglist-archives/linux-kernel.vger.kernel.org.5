Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9678B76E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjH1SoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjH1Snq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:43:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF7BF;
        Mon, 28 Aug 2023 11:43:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 456162D8;
        Mon, 28 Aug 2023 20:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693248141;
        bh=x6pydKoWxISBKKFvFxh0I5hAq48ETBpzI+BwThij+pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBePUj8iBZij8J4Su1ayRS9SeGrIrFltZblRzAF5TAK4g1BnZ9cNlq34RLCZYfzXk
         +0rqdW4iguae7zFhlgIHYgjFPbe3wc4hzOfath7rHtjMOp0ZG5d45tYkvPozsiXOvN
         KToshTdjuGbFWwkV2EUURlNYoQ4xOEWC6VwcY7Nk=
Date:   Mon, 28 Aug 2023 21:43:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/15] media: qcom: camss: Assign the correct number
 of RDIs per VFE
Message-ID: <20230828184352.GL14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-7-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-7-bryan.odonoghue@linaro.org>
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

On Wed, Aug 23, 2023 at 11:44:35AM +0100, Bryan O'Donoghue wrote:
> Each Video Front End - VFE - has a variable number of Raw Data Interfaces -
> RDIs associated with it.
> 
> The CAMSS code started from a naive implementation where a fixed define was
> used as a control in a for(){} loop iterating through RDIs.
> 
> That model scales badly. An attempt was made with  VFE_LINE_NUM_GEN2 and
> VFE_LINE_NUM_GEN1 to differentiate between SoCs but, the problem with that
> is "gen1" and "gen2" have no meaning in the silicon. There is no fixed
> constraint in the silicon between VFE and RDI, it is entirely up to the SoC
> designers how many VFEs are populated and how many RDIs to associate with
> each VFE.
> 
> As an example sdm845 has VFE version 175 and sm8250 VFE version 480.
> sdm845 has 2 VFEs with 4 RDIs and 1 VFE Lite with 4 RDIs.
> sm8250 has 2 VFEs with 3 RDIs and 2 VFE Lite with 4 RDIs.
> 
> Clearly then we need a more granular model to capture the necessary data.
> 
> The defines have gone away to be replaced with per-SoC data but, we haven't
> populated the parameter data with the real values.

I think you forgot to drop the macros from camss-vfe.h.

> 
> Let's call those values out now
> 
> msm8916:
> 1 x VFE
> 3 x RDI per VFE (not 4)
> 
> msm8996:
> 2 x VFE
> 3 x RDI per VFE (not 4)
> 
> sdm660:
> 2 x VFE
> 3 x RDI per VFE (not 4)
> 
> sdm845:
> 2 x VFE
> 4 x RDI per VFE (not 3)
> 1 x VFE Lite
> 4 x RDI per VFE Lite (not 3)
> 
> sm8250:
> 2 x VFE
> 3 x RDI per VFE (not 4)
> 2 x VFE Lite
> 4 x RDI per VFE

Did you mean per VFE Lite here ?

> This more complex and correct mapping was not possible prior to passing
> values via driver data. Now that we have that change in place we can
> correctly map VFEs to RDIs for each VFE.

We could store the value per VFE type (VFE vs. VFE Lite), instead of per
VFE instance, but that would be more complex I suppose, for little gain.
However, if there are more values that depend on the VFE type instead of
the VFE instance, this should be considered.

> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/qcom/camss/camss.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index ce0d86e45fe48..c8b8ad176ee2b 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -124,7 +124,7 @@ static const struct resources vfe_res_8x16[] = {
>  				{ 0 } },
>  		.reg = { "vfe0" },
>  		.interrupt = { "vfe0" },
> -		.line_num = VFE_LINE_NUM_GEN1,
> +		.line_num = 3,
>  	}
>  };
>  
> @@ -265,7 +265,7 @@ static const struct resources vfe_res_8x96[] = {
>  				{ 0 } },
>  		.reg = { "vfe0" },
>  		.interrupt = { "vfe0" },
> -		.line_num = VFE_LINE_NUM_GEN1,
> +		.line_num = 3,
>  	},
>  
>  	/* VFE1 */
> @@ -284,7 +284,7 @@ static const struct resources vfe_res_8x96[] = {
>  				{ 0 } },
>  		.reg = { "vfe1" },
>  		.interrupt = { "vfe1" },
> -		.line_num = VFE_LINE_NUM_GEN1,
> +		.line_num = 3,
>  	}
>  };
>  
> @@ -446,7 +446,7 @@ static const struct resources vfe_res_660[] = {
>  				{ 0 } },
>  		.reg = { "vfe0" },
>  		.interrupt = { "vfe0" },
> -		.line_num = VFE_LINE_NUM_GEN1,
> +		.line_num = 3,
>  	},
>  
>  	/* VFE1 */
> @@ -468,7 +468,7 @@ static const struct resources vfe_res_660[] = {
>  				{ 0 } },
>  		.reg = { "vfe1" },
>  		.interrupt = { "vfe1" },
> -		.line_num = VFE_LINE_NUM_GEN1,
> +		.line_num = 3,
>  	}
>  };
>  
> @@ -627,7 +627,7 @@ static const struct resources vfe_res_845[] = {
>  				{ 384000000 } },
>  		.reg = { "vfe0" },
>  		.interrupt = { "vfe0" },
> -		.line_num = VFE_LINE_NUM_GEN2,
> +		.line_num = 4,
>  	},
>  
>  	/* VFE1 */
> @@ -648,7 +648,7 @@ static const struct resources vfe_res_845[] = {
>  				{ 384000000 } },
>  		.reg = { "vfe1" },
>  		.interrupt = { "vfe1" },
> -		.line_num = VFE_LINE_NUM_GEN2,
> +		.line_num = 4,
>  	},
>  
>  	/* VFE-lite */
> @@ -668,7 +668,7 @@ static const struct resources vfe_res_845[] = {
>  				{ 384000000 } },
>  		.reg = { "vfe_lite" },
>  		.interrupt = { "vfe_lite" },
> -		.line_num = VFE_LINE_NUM_GEN2,
> +		.line_num = 4,
>  	}
>  };
>  
> @@ -796,7 +796,7 @@ static const struct resources vfe_res_8250[] = {
>  				{ 0 } },
>  		.reg = { "vfe0" },
>  		.interrupt = { "vfe0" },
> -		.line_num = 4,
> +		.line_num = 3,
>  	},
>  	/* VFE1 */
>  	{
> @@ -815,7 +815,7 @@ static const struct resources vfe_res_8250[] = {
>  				{ 0 } },
>  		.reg = { "vfe1" },
>  		.interrupt = { "vfe1" },
> -		.line_num = 4,
> +		.line_num = 3,
>  	},
>  	/* VFE2 (lite) */
>  	{

-- 
Regards,

Laurent Pinchart
