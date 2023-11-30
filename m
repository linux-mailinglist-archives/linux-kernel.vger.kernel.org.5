Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9761A7FFD77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376888AbjK3VZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376849AbjK3VZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:25:29 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCB10FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:25:34 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d048d38881so5068505ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701379534; x=1701984334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a85qT15pDzdpel5gAuB/Pf8iqGvsBNG0rw6z7GTZ+18=;
        b=kTJ5AfD1oyJZ5xgrDlZ1wWqUF4X2MHy59XeBZO1G+MQvTgxp690SglGE2GDstdGNxg
         adSryWlfdXZXmcA+Xq4n6e72AH60lYqYhvQ9M2Yrk0L/l+j5hLVRCooCVPsv2Haepeix
         HcwReOShiQW2KJEaYHs7ojwRUXVahzvGbIRz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379534; x=1701984334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a85qT15pDzdpel5gAuB/Pf8iqGvsBNG0rw6z7GTZ+18=;
        b=D9PDbQOJUpqMceQFm/Y8TYDOAEXvfMNll7xVnHRluvRQMNi7thZCA8ZuDAZW9+k5q2
         xRYkDamZ0Q9wvdM9PU4eGnhjgPthoHOVtb9jBzQju0JUg1ocnun04ENdqPsezUSHf43r
         yFNta8MPzWqVuca/Iu82+ByMbzJkQvxB0KVopSprM+xbqkZlrqQwq88lGbVT4yETKLOs
         7BPDKSvrD4BINmxfu5ct486kMaxC3DEY6objlsWycVePlo4/7jR/wNh0mMPYb3SvnG+s
         2tGMl/v8zIJS6tNF4w+P8fJCpBVS0c8LlgzBoiXBihqxkPgy/x66/PxRhxYTc0AFjhxT
         QSqw==
X-Gm-Message-State: AOJu0YxkwGlfzbW4Rd0Ge/U0lUkShWLDHxteXmCNJnNaxunk/jmEayj4
        ZvFzgkZRZAfUohtAqSaqdQwxuw==
X-Google-Smtp-Source: AGHT+IGiYA7iwc3ReI+OQGlKYslymufSwvsJah4H2gMq04CzpdkKFgR/kZAc5Za9Ltu7ai3/MUS0Yw==
X-Received: by 2002:a17:902:e88b:b0:1cf:d404:5e7c with SMTP id w11-20020a170902e88b00b001cfd4045e7cmr18459112plg.42.1701379534271;
        Thu, 30 Nov 2023 13:25:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b001cf7c07be50sm1869304plb.58.2023.11.30.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:25:33 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:25:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Michael Cyr <mikecyr@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: replace deprecated strncpy with
 strscpy
Message-ID: <202311301315.BAB096926@keescook>
References: <20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:43:20PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We don't need the NUL-padding behavior that strncpy() provides as vscsi
> is NUL-allocated in ibmvscsis_probe() which proceeds to call
> ibmvscsis_adapter_info():
> |       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);
> 
> ibmvscsis_probe() -> ibmvscsis_handle_crq() -> ibmvscsis_parse_command()
> -> ibmvscsis_mad() -> ibmvscsis_process_mad() -> ibmvscsis_adapter_info()
> 
> Following the same idea, `partition_name` is defiend as:
> |       static char partition_name[PARTITION_NAMELEN] = "UNKNOWN";
> 
> ... which is NUL-padded already, meaning strscpy() is the best option.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.

My only worry here is that I don't see if %NUL termination is _required_
for these variables. (i.e. do we run the risk of truncating these by 1
byte if they're right at the limit?) Are they __nonstring?

I *think* they're %NUL terminated since they follow the same sizing as
the global "partition_name", but I'm not sure.

Can any of the SCSI authors comment on this?

> 
> However, for cap->name let's use strscpy_pad as cap is allocated via
> dma_alloc_coherent():
> |       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
> |                                GFP_ATOMIC);

This is also true for the "info" allocation (it comes out of DMA).

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index 385f812b8793..cd223ef696e5 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -1551,17 +1551,17 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
>  	if (vscsi->client_data.partition_number == 0)
>  		vscsi->client_data.partition_number =
>  			be32_to_cpu(info->partition_number);
> -	strncpy(vscsi->client_data.srp_version, info->srp_version,
> +	strscpy(vscsi->client_data.srp_version, info->srp_version,
>  		sizeof(vscsi->client_data.srp_version));
> -	strncpy(vscsi->client_data.partition_name, info->partition_name,
> +	strscpy(vscsi->client_data.partition_name, info->partition_name,
>  		sizeof(vscsi->client_data.partition_name));
>  	vscsi->client_data.mad_version = be32_to_cpu(info->mad_version);
>  	vscsi->client_data.os_type = be32_to_cpu(info->os_type);
>  
>  	/* Copy our info */
> -	strncpy(info->srp_version, SRP_VERSION,
> +	strscpy(info->srp_version, SRP_VERSION,
>  		sizeof(info->srp_version));
> -	strncpy(info->partition_name, vscsi->dds.partition_name,
> +	strscpy(info->partition_name, vscsi->dds.partition_name,
>  		sizeof(info->partition_name));

Since "info" is from DMA, let's use the _pad variant here just to be
safe.

>  	info->partition_number = cpu_to_be32(vscsi->dds.partition_num);
>  	info->mad_version = cpu_to_be32(MAD_VERSION_1);
> @@ -1645,8 +1645,8 @@ static int ibmvscsis_cap_mad(struct scsi_info *vscsi, struct iu_entry *iue)
>  			 be64_to_cpu(mad->buffer),
>  			 vscsi->dds.window[LOCAL].liobn, token);
>  	if (rc == H_SUCCESS) {
> -		strncpy(cap->name, dev_name(&vscsi->dma_dev->dev),
> -			SRP_MAX_LOC_LEN);
> +		strscpy_pad(cap->name, dev_name(&vscsi->dma_dev->dev),
> +			sizeof(cap->name));

And this is a safe conversion to sizeof():

struct capabilities {
	...
        char name[SRP_MAX_LOC_LEN];


If we can convince ourselves that non of these are __nonstring types,
then I think with the "info" change above, this should be good.

-Kees

-- 
Kees Cook
