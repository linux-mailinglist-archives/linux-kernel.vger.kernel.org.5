Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41BA7AB26F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjIVMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjIVMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:50:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87794;
        Fri, 22 Sep 2023 05:50:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F5DC433C8;
        Fri, 22 Sep 2023 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695387002;
        bh=xCBIRsurVeVVeQpsNZBwynvGXg5d5UV4Dr22oeCKBHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a9Hq6mkkP9g0G+/1CpfRpe6A2V29UGp+HroLtkOUbjL4UhNI56ROtYigf+1xWiu6K
         mHmSgQS2VNJF+QxCpcqH9uZd+lBVcoMiSrPPxaGQ9wHsti4EWACeTaHfVsib6riRFs
         LFVcTMnhD7n+lU2FX11feyLx41cPCCddGZhmmvZAJVbvsCLyiXJVzykr39J7+fERkx
         swxss2UBGaR1apHxpPaCuj91Uip+WEZa5oBbmCxVAc1Y1XvErk2nVFvJP2bvtNw5R3
         FY5gtwRXJ4AEja2qzAXVTp7cg10BqKn+Hau4DvC6YtPZ9ybuZeQJfD4pCBC40RZYk/
         VKWX3tXKQOOpg==
Message-ID: <ea28de69-8b9d-8ff8-b7fc-eb780123f055@kernel.org>
Date:   Fri, 22 Sep 2023 05:50:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] scsi: core: cleanup scsi_dev_queue_ready()
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922093842.2646157-1-haowenchao2@huawei.com>
 <20230922093842.2646157-2-haowenchao2@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230922093842.2646157-2-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/22 2:38, Wenchao Hao wrote:
> This is just a cleanup for scsi_dev_queue_ready() to avoid
> redundant goto and if statement, it did not change the origin
> logic.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  drivers/scsi/scsi_lib.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index ca5eb058d5c7..f3e388127dbd 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1254,28 +1254,29 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
>  	int token;
>  
>  	token = sbitmap_get(&sdev->budget_map);
> -	if (atomic_read(&sdev->device_blocked)) {
> -		if (token < 0)
> -			goto out;
> +	if (token < 0)
> +		return -1;

This is changing how this function works...

>  
> -		if (scsi_device_busy(sdev) > 1)
> -			goto out_dec;
> +	/*
> +	 * device_blocked is not set at mostly time, so check it first
> +	 * and return token when it is not set.
> +	 */
> +	if (!atomic_read(&sdev->device_blocked))
> +		return token;

...because you reversed the tests order.

>  
> -		/*
> -		 * unblock after device_blocked iterates to zero
> -		 */
> -		if (atomic_dec_return(&sdev->device_blocked) > 0)
> -			goto out_dec;
> -		SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
> -				   "unblocking device at zero depth\n"));
> +	/*
> +	 * unblock after device_blocked iterates to zero
> +	 */
> +	if (scsi_device_busy(sdev) > 1 ||
> +	    atomic_dec_return(&sdev->device_blocked) > 0) {

And here too, you are changing how the function works. The atomic_dec may not be
done if the first condition is true.

> +		sbitmap_put(&sdev->budget_map, token);
> +		return -1;
>  	}
>  
> +	SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
> +			 "unblocking device at zero depth\n"));
> +
>  	return token;
> -out_dec:
> -	if (token >= 0)
> -		sbitmap_put(&sdev->budget_map, token);
> -out:
> -	return -1;
>  }
>  
>  /*

-- 
Damien Le Moal
Western Digital Research

