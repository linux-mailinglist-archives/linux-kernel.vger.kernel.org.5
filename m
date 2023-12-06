Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00393807756
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379046AbjLFSMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjLFSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDF122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701886363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GLvrKoKXfs9q6sXMVVNDve2BGCY9TgxYq7d8xwgVO8=;
        b=YMFD5fUIL70SpZgvY1dFD1TPG6eyvKrP0VBn/vl+Tr/nLuB+7NlAq7KtObFkkVbS2NDoTM
        kblZHrMmw52vThclyOHNZ6kTZoEhFehRXBkzP3+2ho2H0Ao90IcGJq0nlLpHJ/IpqPBMHs
        gVIeGX4KUaGHIiIsdsI+0FFRwJqI5u8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-_8hFoYPSNEuWgiDwTZoYSQ-1; Wed, 06 Dec 2023 13:11:11 -0500
X-MC-Unique: _8hFoYPSNEuWgiDwTZoYSQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b8b8d6f94cso155199b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886270; x=1702491070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GLvrKoKXfs9q6sXMVVNDve2BGCY9TgxYq7d8xwgVO8=;
        b=XjgigE9K+s7ckVr+2jgr542mcZ5UdjiR1CLILr7SsxmHkReatsO5eIgDRlShU0k8bD
         gJ+HmsTQGPQXzC267IqPwjJfaRwsKFPffo2qyJ3e6ptVMjpN+T6u88BeByznbBcSCS+3
         24eOA6lhm2bU2Yec3xum7zJgTTST9QuF8E98zqS6VFiJAMlitQiLwq133oRM8xEZcX3h
         3OmSgZ1jDlybfx9WFl4A0ZDUt+zG5E9nQy1nDbewi6chyEz0o6Ib/UBBrYY7JP1hPuJP
         pTQcLhRkVEZhs4HMu7VhOLLBqJkw3SjpCBGOkWl9xA7JBTvJV/WFrk04BySV6jUqrAEw
         tOHw==
X-Gm-Message-State: AOJu0Yy4HaApwjJPsXpIxJ+yc/qlYf6JaIMsJ+6hiu3JIBp4nf5IL7VD
        5LG3VaYMHfDrUyjXuzTZSChWtG1VHJBlFnuq10qY97//CElwAB9cYg72bHM+bH4dLOjf2FPCTSa
        7YmMkVSgZCYlC7i+SBRqSevdc
X-Received: by 2002:a05:6808:a98:b0:3b8:b063:9b4f with SMTP id q24-20020a0568080a9800b003b8b0639b4fmr1237609oij.65.1701886270651;
        Wed, 06 Dec 2023 10:11:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrWCDztRBTCTdptmOIMb3QLVRY8x4frkDSfMXpFws1PJaXtsjQQA314rFK/H2U63UzkloaQw==
X-Received: by 2002:a05:6808:a98:b0:3b8:b063:9b4f with SMTP id q24-20020a0568080a9800b003b8b0639b4fmr1237600oij.65.1701886270419;
        Wed, 06 Dec 2023 10:11:10 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id p21-20020ac84095000000b004255a974865sm141189qtl.18.2023.12.06.10.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:11:10 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:11:08 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 03/13] scsi: ufs: qcom: Fix the return value when
 platform_get_resource_byname() fails
Message-ID: <zxubx2deqdjkxg774d2mbqo66t7hlapg2vlvrraqawoemlywof@c7rs3mnzjppd>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:44:07PM +0530, Manivannan Sadhasivam wrote:
> The return value should be -ENODEV indicating that the resource is not
> provided in DT, not -ENOMEM. Fix it!
> 
> Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 852179e456f2..778df0a9c65e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1701,7 +1701,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>  		if (!res->resource) {
>  			dev_info(hba->dev, "Resource %s not provided\n", res->name);
>  			if (i == RES_UFS)
> -				return -ENOMEM;
> +				return -ENODEV;
>  			continue;
>  		} else if (i == RES_UFS) {
>  			res_mem = res->resource;
> -- 
> 2.25.1
> 
> 

