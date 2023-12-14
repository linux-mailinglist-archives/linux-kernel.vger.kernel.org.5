Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E06813A67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573165AbjLNS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNS52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44535A0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702580254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pl3HqjIcCyU6c5THUJl64ri1en3ap6gGnuAwV6P1ius=;
        b=I3qRxIIHJyubkoodoOrCRlVuBFC3OzjyO8AhHeNu5HdOgWt/T1L4zYXUDtF8yXw/GrtSXh
        GmtozC9lVGbJdhpGCf4DiriflRxJl1byn6VeoBnx1QA++FnhMbDGfAd+79sLPPvGpXaffb
        jCbaqaIlrFVlMnQkev4AjbTm1Li2NfY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-2ALOuAONMTWd4joAU1I4Vg-1; Thu, 14 Dec 2023 13:57:33 -0500
X-MC-Unique: 2ALOuAONMTWd4joAU1I4Vg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9e358994fso11615172b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702580252; x=1703185052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl3HqjIcCyU6c5THUJl64ri1en3ap6gGnuAwV6P1ius=;
        b=RIHzG5LIFgMLu1ylwKNwRHGVoWIh3W/RphHlMS6jHv027v69n6Yd2AFaE2Jd6CTOhN
         cQOP6UvRWtfUtLKc7czJ9FSii41vehNSn5uGS4d6zn+k1rDYCYShaluB226dmI45l0of
         mc+dmOiaskgyMK2QXcQ1cZl/ruK18ScQULHm2Earwkj54+BRMd5duGF5o0nGvlOotNCL
         7v0+JdW4Qs2zIiBWTdebr4CALWk1SQWnm4VupTlS4/r/A/SWhIc6YRqs+REaR2YL1wKP
         /t94QrrFhNhsLUdKdA9g+d0gFg0JnaVBkHiZFYYG4j3CbmjLwrZIjq5O5ij1vohY/pZ8
         hpjw==
X-Gm-Message-State: AOJu0Yx+2+UCsm3QGvih5jZhe4KHdmCUetc6O/zFPKJ0T6H+ldziyJZ0
        aV8nHHiusdzE977RfduxtYZq7DMt8o69hElXx4rRU/uJ3ggdcJBpjYjbFBBs88OBMBISKBc376T
        hHORnuu4Ytl59+PBiKSQhzQRk
X-Received: by 2002:a05:6808:4182:b0:3b9:dcb8:2ad1 with SMTP id dj2-20020a056808418200b003b9dcb82ad1mr11604255oib.112.1702580252371;
        Thu, 14 Dec 2023 10:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIc/zQX7LU/xm/BRS3QmT0M8wjT9iAR291mFBSuyPsGWBGKLM7TSjmQtN7SWzeOZ/FV26rkw==
X-Received: by 2002:a05:6808:4182:b0:3b9:dcb8:2ad1 with SMTP id dj2-20020a056808418200b003b9dcb82ad1mr11604248oib.112.1702580252180;
        Thu, 14 Dec 2023 10:57:32 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id dg1-20020a056214084100b0067ed87e51edsm3466800qvb.36.2023.12.14.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:57:31 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:57:29 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: Re: [PATCH v2] scsi: ufs: qcom: Re-fix for error handling
Message-ID: <rrp3umto2jhti5n6iwhhj2vwub7uh4q2jsbqmlfmvzn6fyp2nr@nzzr4ah4gdd5>
References: <CGME20231214021405epcas1p3cef80b85df56b7bead7f2f2ebd52f4ac@epcas1p3.samsung.com>
 <20231214021401.26474-1-cw9316.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214021401.26474-1-cw9316.lee@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:14:01AM +0900, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> I modified the code to handle errors.
> 
> The error handling code has been changed from the patch below.
> -'commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")'
> 
> This is the case I checked.
> * ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;
> 
> It is unknown whether the above commit was intended to change error handling.
> However, if it is not an intended fix, a patch may be needed.

Can you be a bit specific about what you fixed here in the commit?
Both the subject and the description is vague and sounds like you're
still unsure if this change is a good idea. The review on the prior
patch and this one is indicating that this change is necessary and a
fix, so let's be more confident in the description for future readers.

Write as you please, but something like:

    scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in ufs_qcom_clk_scale_notify()

    In commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")
    the error handling was accidentally changed, resulting in the error of
    ufs_qcom_clk_scale_*() calls not being returned.

    Let's make sure those errors are properly returned.

> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

This deserves a Fixes: tag (I see Mani mentioned that)

> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

I did not provide a Reviewed-by tag in v1, this is not accurate:

    https://lore.kernel.org/linux-arm-msm/m5wjp3yb3qpheyzgipekeagycboifqdpw54nquzqsftufap3yc@kxjwi4y63adj/

Outside of that this looks good, thanks!

> ---
> v1->v2: Remove things already in progress
>  1) ufs_qcom_host_reset -> 'reset_control_deassert' error -> return 0;
>    -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-8-manivannan.sadhasivam@linaro.org/#t
>  2) ufs_qcom_init_lane_clks -> 'ufs_qcom_host_clk_get(tx_lane1_sync_clk)' error -> return 0;
>    -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-2-manivannan.sadhasivam@linaro.org/
> ---
> ---
>  drivers/ufs/host/ufs-qcom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 96cb8b5b4e66..17e24270477d 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1516,9 +1516,11 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  			err = ufs_qcom_clk_scale_up_pre_change(hba);
>  		else
>  			err = ufs_qcom_clk_scale_down_pre_change(hba);
> -		if (err)
> -			ufshcd_uic_hibern8_exit(hba);
>  
> +		if (err) {
> +			ufshcd_uic_hibern8_exit(hba);
> +			return err;
> +		}
>  	} else {
>  		if (scale_up)
>  			err = ufs_qcom_clk_scale_up_post_change(hba);
> -- 
> 2.29.0
> 

