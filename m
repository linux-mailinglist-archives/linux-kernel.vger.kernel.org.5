Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB2F78B634
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjH1RRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjH1RRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:17:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9DB0;
        Mon, 28 Aug 2023 10:17:17 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A758B5AA;
        Mon, 28 Aug 2023 19:15:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693242954;
        bh=7I2oT/qfOhZ+LY5Cj8rxYMYWuH/EJ8Iitoox3qFnAuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0nP2UPRkm7jeERQDgJccBsokU2+TqK8wWTgNM2kG2ge6Z9uJNBdb17XIyd4BQSu5
         yzEToiY2cjT9wUoNeQ7c9NqzxSF+PDtFvv5vmfs1JKeqxDjhABsD+gLKG2JJZfLdi4
         8yir1Ek0Ni/SycycM0C/EcBYfhaXADq/FSmHpDIw=
Date:   Mon, 28 Aug 2023 20:17:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 5/9] media: qcom: camss: Fix VFE-480
 vfe_disable_output()
Message-ID: <20230828171725.GZ14596@pendragon.ideasonboard.com>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
 <20230822200626.1931129-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822200626.1931129-6-bryan.odonoghue@linaro.org>
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

On Tue, Aug 22, 2023 at 09:06:22PM +0100, Bryan O'Donoghue wrote:
> vfe-480 is copied from vfe-17x and has the same racy idle timeout bug as in
> 17x.
> 
> Fix the vfe_disable_output() logic to no longer be racy and to conform
> to the 17x way of quiescing and then resetting the VFE.

How about dropping the duplicate function and share a single
implementation for the two files ?

> Fixes: 4edc8eae715c ("media: camss: Add initial support for VFE hardware version Titan 480")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../media/platform/qcom/camss/camss-vfe-480.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
> index f70aad2e8c237..a64d660abc538 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
> @@ -334,28 +334,15 @@ static int vfe_disable_output(struct vfe_line *line)
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
>  }
>  

-- 
Regards,

Laurent Pinchart
