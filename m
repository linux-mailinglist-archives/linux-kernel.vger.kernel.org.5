Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C06D78E304
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjH3XGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbjH3XGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:06:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB8DB4;
        Wed, 30 Aug 2023 16:05:58 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF14F49E;
        Wed, 30 Aug 2023 22:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693428360;
        bh=Bx/zpBUhhZyosNZ2b7fzwuoLB8bEbcqVVp1q3fYfrIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFTCe0YD8qbooPdrMYfHCtKe2HbtToC2TTMwtWHG9+Z1ZdkroT1M0NUlbGajzv2Um
         G9kbQbxzJwEmoE6HREdpAbNP/GQSpTSFblW3dhN/a4e1ri3znK7JuEvuQms36TwE1O
         DnyuQGmaZJY9ibQSEH3mMx/1r/IpzNeafsEukMcA=
Date:   Wed, 30 Aug 2023 23:47:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] media: qcom: camss: Bugfix series
Message-ID: <20230830204732.GQ6477@pendragon.ideasonboard.com>
References: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

I wanted to let you know that I will likely not be able to review this
v3 in a timely manner. v2 was quite fine overall, I trust that you've
taken my review comments into account in this new version. Maybe someone
else could give it another look, in order to get it merged in v6.7 ?

On Wed, Aug 30, 2023 at 04:16:05PM +0100, Bryan O'Donoghue wrote:
> V3:
> - Adds Reviewed-by where indicated - Laurent
> - Adds a new patch for genpd cleanup. TBH I completely missed this so thanks ! - Laurent
> - "media: qcom: camss: Fix V4L2 async notifier error path" stays the same fixes spalt in -next
>   Fixes: 51397a4ec75d ("media: qcom: Initialise V4L2 async notifier later")
> - I like the suggesting of using a common fix for vfe-17x and vfe-480 however, I believe
>   we need to support multiple write-master/RDI => VCs in 17x which currently we only do
>   in vfe-480 so sharing the code between the two here right now, is	n't possible.
> - Included other suggestions on vfe-17x and vfe-480 - Laurent
> - I didn't change the val |= 1 << CSI2_RX_CFG1_VC_MODE to BIT(2)
>   The reason for that is all of the code uses this odd bit-shifting and I'd rather do
>   the conversion from shifting to BIT(x) as a distinct series instead of piecemeal - bod
> 
> V2:
> - Amends commit log for TPG fix to cover dropping of fixed
>   VC when setting up a TPG - Konrad
> 
> - Leaves GENMASK etc out. I'm happy to do a "make it pretty"
>   series later on. - bod
> 
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/Bugfix-series-v2?ref_type=tags
> 
> V1:
> - Drops dt_id = vc * 4 in favour of a patch in a later series - Hans
>   Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/d4c382c5d6ee153b410a01e172b3e811011d0b14
> - Adds Konrad's Acked-by as indicated
> 
> V0:
> This series covers a number of Fixes: all of which are for application to
> stable as well as -next with the exception of the second patch which is a
> fix for a SHA that is still in -next.
> 
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3
> 
> This series is part of a larger set of fixes, improvements developed/found
> when adding a new SoC.
> 
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/lenovo-x13s-v6.5-rc4-x13s-camss-patches
> 
> First pass on that larger series is to get all of the current Fixes: in the
> branch out.
> 
> Andrey Konovalov (1):
>   media: qcom: camss: Fix csid-gen2 for test pattern generator
> 
> Bryan O'Donoghue (9):
>   media: qcom: camss: Fix pm_domain_on sequence in probe
>   media: qcom: camss: Fix V4L2 async notifier error path
>   media: qcom: camss: Fix genpd cleanup
>   media: qcom: camss: Fix vfe_get() error jump
>   media: qcom: camss: Fix VFE-17x vfe_disable_output()
>   media: qcom: camss: Fix VFE-480 vfe_disable_output()
>   media: qcom: camss: Fix missing vfe_lite clocks check
>   media: qcom: camss: Fix invalid clock enable bit disjunction
>   media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater
>     than 3
> 
>  .../platform/qcom/camss/camss-csid-gen2.c     | 11 ++--
>  .../qcom/camss/camss-csiphy-3ph-1-0.c         |  2 +-
>  .../media/platform/qcom/camss/camss-vfe-170.c | 22 +-------
>  .../media/platform/qcom/camss/camss-vfe-480.c | 22 +-------
>  drivers/media/platform/qcom/camss/camss-vfe.c |  5 +-
>  drivers/media/platform/qcom/camss/camss.c     | 55 +++++++++++--------
>  6 files changed, 46 insertions(+), 71 deletions(-)

-- 
Regards,

Laurent Pinchart
