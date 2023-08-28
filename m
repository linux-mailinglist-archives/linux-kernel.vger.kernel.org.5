Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5878B62B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjH1RQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjH1RPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:15:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A58A7;
        Mon, 28 Aug 2023 10:15:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F290C5AA;
        Mon, 28 Aug 2023 19:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693242851;
        bh=9CcR3k+ZeoGhjHA5toY1lOOIlpjjD+5Lfe/6lzVQeHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLUQTTGF7w9btKRhO8eUPPdc4XjIc+UoZHKrLys93FItNwlwWpsP4oORW5RX0xph3
         T2EV0r4tcg3k7eZt3sXgbn+VdIxeJXvX1XdGuJgrJKIFOCRa6meE52m8JqZVzLW3lX
         ubHhKfhWI+c/t+6UEV6b4aJUZtRdsvOeIFoOyjj8=
Date:   Mon, 28 Aug 2023 20:15:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 4/9] media: qcom: camss: Fix VFE-17x
 vfe_disable_output()
Message-ID: <20230828171541.GY14596@pendragon.ideasonboard.com>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
 <20230822200626.1931129-5-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822200626.1931129-5-bryan.odonoghue@linaro.org>
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

On Tue, Aug 22, 2023 at 09:06:21PM +0100, Bryan O'Donoghue wrote:
> There are two problems with the current vfe_disable_output() routine.
> 
> Firstly we rightly use a spinlock to protect output->gen2.active_num
> everywhere except for in the IDLE timeout path of vfe_disable_output().
> Even if that is not racy "in practice" somehow it is by happenstance not
> by design.
> 
> Secondly we do not get consistent behaviour from this routine. On
> sc8280xp 50% of the time I get "VFE idle timeout - resetting". In this
> case the subsequent capture will succeed. The other 50% of the time, we
> don't hit the idle timeout, never do the VFE reset and subsequent
> captures stall indefinitely.
> 
> Rewrite the vfe_disable_output() routine to
> 
> - Quiesce write masters with vfe_wm_stop()
> - Set active_num = 0
> 
> remembering to hold the spinlock when we do so followed by
> 
> - Reset the VFE
> 
> Testing on sc8280xp and sdm845 shows this to be a valid fix.
> 
> Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

I can't comment on the validity of the fix, but nothing shocks me in the
patch, so I'm fine with it.

> ---
>  .../media/platform/qcom/camss/camss-vfe-170.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
> index 02494c89da91c..ae9137633c301 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
> @@ -500,28 +500,15 @@ static int vfe_disable_output(struct vfe_line *line)
>  	struct vfe_output *output = &line->output;
>  	unsigned long flags;
>  	unsigned int i;
> -	bool done;
> -	int timeout = 0;
> -
> -	do {
> -		spin_lock_irqsave(&vfe->output_lock, flags);
> -		done = !output->gen2.active_num;
> -		spin_unlock_irqrestore(&vfe->output_lock, flags);
> -		usleep_range(10000, 20000);

Now that you don't sleep anymore, I think you can drop the inclusion of
linux/delay.h.

> -
> -		if (timeout++ == 100) {
> -			dev_err(vfe->camss->dev, "VFE idle timeout - resetting\n");
> -			vfe_reset(vfe);
> -			output->gen2.active_num = 0;
> -			return 0;
> -		}
> -	} while (!done);
>  
>  	spin_lock_irqsave(&vfe->output_lock, flags);
>  	for (i = 0; i < output->wm_num; i++)
>  		vfe_wm_stop(vfe, output->wm_idx[i]);
> +	output->gen2.active_num = 0;
>  	spin_unlock_irqrestore(&vfe->output_lock, flags);
>  
> +	vfe_reset(vfe);
> +
>  	return 0;

This function could become void, especially given that its only caller
doesn't check the return value.

>  }
>  
> -- 
> 2.41.0
> 

-- 
Regards,

Laurent Pinchart
