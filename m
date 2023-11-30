Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC97FFD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376831AbjK3VMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjK3VMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:12:43 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52AC4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:12:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d05212a7c5so583525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701378769; x=1701983569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMtD4zdAr6X+H2Qpe4emJrdJbxSyHd1ONAvar3QH9oM=;
        b=ZxjbbZ7v3ERljlXrOCR6AGCmGn3s2F6tauVzLoYjiY0soTCy1vwYq32XAVwpWoNXuQ
         ayN+Hxaag9GIbyNfTLpN6FG8FNmJcfpDgp5OVjn74F58oaaEdnQsoD8T2vQmGPE7tA+r
         KfQ9L/DHX8gJi8oTPVlyb0SLAuSrjJrd2TB04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378769; x=1701983569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMtD4zdAr6X+H2Qpe4emJrdJbxSyHd1ONAvar3QH9oM=;
        b=Yc9V2NIe0+mLreAdDQ1dU5EHrlpI6G04VeCXh9IRBnTFDfHManbn2j5AHfh83a9U3o
         aOlQfInIl3aCNG9deT7rd2s7D5/2ai1hFTPuWWktW/8bioDko0vYopCjwiWbHeWDg6WY
         MU6efOFjjO3FKe7AUWDZe0NBkcJzViZjQou540v6MrA4SQ6+2C/+xRnwfA21AysUy3gT
         kfKACFwIil88/wWPmSqIR16dA0Mp7W3uz3D41cZbIru7i4aoRkaAimUBQKVkridCVgY+
         lJv7OteXKaCvzMbbPb6D8zjD5DMJ4JT66CEl6nYo43pi0G4s4zfzOBv/QkR167zmTsa7
         gU3w==
X-Gm-Message-State: AOJu0Yym4+lQwWvFuki/kX4t9RdveyGiOoy+PXOVuaaU+4RHppsuL5dY
        0wSso08QnKiUjtA8K9uCUnIx2Q==
X-Google-Smtp-Source: AGHT+IHMg694k+Ua8hT0yYfpkQVJFEGdgYslaiV8JFgLgJF7PWf5jrslfVimHv+aZAMpIBLCJYRxCQ==
X-Received: by 2002:a17:902:7409:b0:1cf:a2e7:f851 with SMTP id g9-20020a170902740900b001cfa2e7f851mr23180716pll.32.1701378769265;
        Thu, 30 Nov 2023 13:12:49 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902b48900b001bf044dc1a6sm1867755plr.39.2023.11.30.13.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:12:48 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:12:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvfc: replace deprecated strncpy with strscpy
Message-ID: <202311301311.717549FB@keescook>
References: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-v1-1-5a4909688435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-v1-1-5a4909688435@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:04:33PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect these fields to be NUL-terminated as the property names from
> which they are derived are also NUL-terminated.
> 
> Moreover, NUL-padding is not required as our destination buffers are
> already NUL-allocated and any future NUL-byte assignments are redundant
> (like the ones that strncpy() does).
> ibmvfc_probe() ->
> |       struct ibmvfc_host *vhost;
> |       struct Scsi_Host *shost;
> ...
> | 	shost = scsi_host_alloc(&driver_template, sizeof(*vhost));
> ... **side note: is this a bug? Looks like a type to me   ^^^^^**

I think this is the "privsize", so *vhost is correct, IIUC.

> ...
> |	vhost = shost_priv(shost);

I.e. vhost is a part of the shost allocation

> 
> ... where shost_priv() is:
> |       static inline void *shost_priv(struct Scsi_Host *shost)
> |       {
> |       	return (void *)shost->hostdata;
> |       }
> 
> .. and:
> scsi_host_alloc() ->
> | 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);

As seen here. :)

> 
> And for login_info->..., NUL-padding is also not required as it is
> explicitly memset to 0:
> |	memset(login_info, 0, sizeof(*login_info));
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, this conversion looks correct to me too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
> index ce9eb00e2ca0..e73a39b1c832 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -1455,7 +1455,7 @@ static void ibmvfc_gather_partition_info(struct ibmvfc_host *vhost)
>  
>  	name = of_get_property(rootdn, "ibm,partition-name", NULL);
>  	if (name)
> -		strncpy(vhost->partition_name, name, sizeof(vhost->partition_name));
> +		strscpy(vhost->partition_name, name, sizeof(vhost->partition_name));
>  	num = of_get_property(rootdn, "ibm,partition-no", NULL);
>  	if (num)
>  		vhost->partition_number = *num;
> @@ -1498,13 +1498,15 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
>  	login_info->async.va = cpu_to_be64(vhost->async_crq.msg_token);
>  	login_info->async.len = cpu_to_be32(async_crq->size *
>  					    sizeof(*async_crq->msgs.async));
> -	strncpy(login_info->partition_name, vhost->partition_name, IBMVFC_MAX_NAME);
> -	strncpy(login_info->device_name,
> -		dev_name(&vhost->host->shost_gendev), IBMVFC_MAX_NAME);
> +	strscpy(login_info->partition_name, vhost->partition_name,
> +		sizeof(login_info->partition_name));
> +
> +	strscpy(login_info->device_name,
> +		dev_name(&vhost->host->shost_gendev), sizeof(login_info->device_name));
>  
>  	location = of_get_property(of_node, "ibm,loc-code", NULL);
>  	location = location ? location : dev_name(vhost->dev);
> -	strncpy(login_info->drc_name, location, IBMVFC_MAX_NAME);
> +	strscpy(login_info->drc_name, location, sizeof(login_info->drc_name));
>  }
>  
>  /**
> 
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-ccfce3255d58
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
