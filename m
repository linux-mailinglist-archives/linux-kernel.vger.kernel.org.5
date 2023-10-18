Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7537CE5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJRSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjJRSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:07:08 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52A98;
        Wed, 18 Oct 2023 11:07:06 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c9de3f66e5so45894825ad.3;
        Wed, 18 Oct 2023 11:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652426; x=1698257226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrVNpldIVMbJ31U5GicUDQImVQDnAmtVa3pZenzgslU=;
        b=Zesu69hk1JF4GTv2MpmGLWXpnZg587Z8fjA8BWItcyxNNXOSSNqy8PSGRdsobLOST+
         FfkyY0FZB98Zb8IBpgixvAuKVPUw/OrWKQr1CB9zHXEXfQOx2+gM6AKylfiwd687glJT
         1yMqi76t1pYaAs8grOtXMFD8FzYak0zUfYdnoopScghXpR2gpqRwcxZjR16Pec9A//jd
         PdtabpXFgB53M0vtfMT7VPp+wnpvMkeWeEROli31SX4BfF/RS/aMVQkD+MFELD1qjY1v
         Su+4NWsSse1VGgiGu4zOJUyteVl+NjiV4fD9TUGyTsLIv9YecEXdWYD0B9rXB+WVeRJk
         OJLA==
X-Gm-Message-State: AOJu0YyCcZevD9oxB789QOq1SHL+0nTCOe+1H6dTtctWp1HQmy1LOUyC
        pQUKClWktmQcspeHE3byAig=
X-Google-Smtp-Source: AGHT+IE3xynYwSzjoJPaxIqNH+qjE5Fjj2DqgiQfDlxkWIj5W+hUHlbLJkvIdjzQ36YJ9uFO7hV//g==
X-Received: by 2002:a17:902:fb0e:b0:1c9:d61a:f4a4 with SMTP id le14-20020a170902fb0e00b001c9d61af4a4mr87761plb.60.1697652426063;
        Wed, 18 Oct 2023 11:07:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id ju14-20020a170903428e00b001c9cb2fb8d8sm233098plb.49.2023.10.18.11.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:07:05 -0700 (PDT)
Message-ID: <d62c3e97-bddf-4fd4-9099-2ff6954938b3@acm.org>
Date:   Wed, 18 Oct 2023 11:07:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] scsi: core: cleanup scsi_dev_queue_ready()
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
References: <20231018113746.1940197-1-haowenchao2@huawei.com>
 <20231018113746.1940197-2-haowenchao2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231018113746.1940197-2-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 04:37, Wenchao Hao wrote:
> This is just a cleanup for scsi_dev_queue_ready() to avoid
> redundant goto and if statement, it did not change the origin
> logic.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   drivers/scsi/scsi_lib.c | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index aca57c3ab626..cf3864f72093 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1251,28 +1251,26 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
>   	int token;
>   
>   	token = sbitmap_get(&sdev->budget_map);
> -	if (atomic_read(&sdev->device_blocked)) {
> -		if (token < 0)
> -			goto out;
> +	if (token < 0)
> +		return -1;
>   
> -		if (scsi_device_busy(sdev) > 1)
> -			goto out_dec;
> +	if (!atomic_read(&sdev->device_blocked))
> +		return token;
>   
> -		/*
> -		 * unblock after device_blocked iterates to zero
> -		 */
> -		if (atomic_dec_return(&sdev->device_blocked) > 0)
> -			goto out_dec;
> -		SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
> -				   "unblocking device at zero depth\n"));
> +	/*
> +	 * Only unblock if no other commands are pending and
> +	 * if device_blocked has decreased to zero
> +	 */
> +	if (scsi_device_busy(sdev) > 1 ||
> +	    atomic_dec_return(&sdev->device_blocked) > 0) {
> +		sbitmap_put(&sdev->budget_map, token);
> +		return -1;
>   	}
>   
> +	SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
> +			 "unblocking device at zero depth\n"));
> +
>   	return token;
> -out_dec:
> -	if (token >= 0)
> -		sbitmap_put(&sdev->budget_map, token);
> -out:
> -	return -1;
>   }
>   
>   /*

Thanks for having made this function easier to read.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
