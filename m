Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6278FB90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbjIAKBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIAKBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:01:00 -0400
X-Greylist: delayed 1378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 03:00:55 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07573E8;
        Fri,  1 Sep 2023 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ydi8mZaxlyEhZyopVQIX6MFy2rmjbC3NGl5RHFVk6hA=; b=HuXZ1FebH0eNnm+buBJHJuNm4n
        NtDPpaHAW459V0lsjmkPnOnLcySQubiDcGImV4RBrwWOkOX2pXw8139LbU0G1KXvAxy3Uu2AdjH+i
        Q74Ia37xb/CB5ILYTAV53tqgYBG/D7S8D3kAGnaT81sj/5MbTHRPTgcss3Z1ej0w4z3tPmnP1r7HO
        1giFVsCNwos+q01uHmJiNZPcUz219cUPDV0zgoJukc0ghGUnjrWolJ+Eur39qCzpvQfHY46jpwNDk
        FqFbyuffMsFg2UOFWrI7XmQDeUpbWraIYW6XR7eOVPWbz6BA0xStPS2PV+rTQ5dgwD6anb3DBBseN
        6ExG/GEg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qc0b9-008FtQ-1f;
        Fri, 01 Sep 2023 12:37:51 +0300
Message-ID: <55b5f086-22c9-e25c-bb25-f1a74906f5dc@kapsi.fi>
Date:   Fri, 1 Sep 2023 12:37:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dma_buf/sync_file: Enable signaling for fences when
 querying status
Content-Language: en-US
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20230725074611.3309115-1-cyndis@kapsi.fi>
In-Reply-To: <20230725074611.3309115-1-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 10:46, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> dma_fence_get_status is not guaranteed to return valid information
> on if the fence has been signaled or not if SW signaling has not
> been enabled for the fence. To ensure valid information is reported,
> enable SW signaling for fences before getting their status.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/dma-buf/sync_file.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> index af57799c86ce..57f194b8477f 100644
> --- a/drivers/dma-buf/sync_file.c
> +++ b/drivers/dma-buf/sync_file.c
> @@ -267,6 +267,7 @@ static int sync_fill_fence_info(struct dma_fence *fence,
>   	strscpy(info->driver_name, fence->ops->get_driver_name(fence),
>   		sizeof(info->driver_name));
>   
> +	dma_fence_enable_sw_signaling(fence);
>   	info->status = dma_fence_get_status(fence);
>   	while (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
>   	       !test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
> @@ -307,6 +308,7 @@ static long sync_file_ioctl_fence_info(struct sync_file *sync_file,
>   	 * info->num_fences.
>   	 */
>   	if (!info.num_fences) {
> +		dma_fence_enable_sw_signaling(sync_file->fence);
>   		info.status = dma_fence_get_status(sync_file->fence);
>   		goto no_fences;
>   	} else {

Any thoughts?

Mikko
