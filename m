Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C777C58EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjJKQOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjJKQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:14:19 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5CC8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:14:16 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id qZAlq9fb1IBlVqbqGq9s27; Wed, 11 Oct 2023 16:13:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id qbqhqmhDtivKvqbqhqwzEW; Wed, 11 Oct 2023 16:14:15 +0000
X-Authority-Analysis: v=2.4 cv=R8oQpPdX c=1 sm=1 tr=0 ts=6526c9d7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=V7xphIdJqzxAJ2XP6soA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IglXiu7clxmjc6NnMmyD4jz2gwc1+yZr7itwJnzvAag=; b=xt/Tb6mHGkEDAh4cK7S1dC9YrF
        Ndo23soGJTyTAu3uPEpBks1653WuqTh2RNwMKZBwa/ZscUhiKV5rrGUcELLkvzCHlxV7LwGGz9lle
        Rt1XSM4N3QugUJxGUlk0KGEc89mdad7gJ/wwviLO7zJ91SyJzF1Fon6J2fRVewGEsGemkGKNYiclv
        k2T39BjJcRgXe9Y7ZV5j0qNYvnM2mK7lQ9m85tPw8EIk9/rCGsKMIfSGppfDRXMwQLBevv+qmScCo
        y66LDAm+8vUF4TB+o4sXQ0nROLR3mid6Lf7MbYslf6jnqu7tH8M9AKzrrRjWtmGLtT3L5EzLvzQ4c
        +rL4Io2w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:58052 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qqbqg-002zCK-1C;
        Wed, 11 Oct 2023 11:14:14 -0500
Message-ID: <0d63e8aa-5836-40e7-8f8a-2be10fbaac4a@embeddedor.com>
Date:   Wed, 11 Oct 2023 10:13:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] dma-buf: Fix NULL pointer dereference in
 dma_fence_enable_sw_signaling()
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arvind Yadav <Arvind.Yadav@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZSarP0/+hG8/87//@work> <202310110903.FE533CBCD@keescook>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310110903.FE533CBCD@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qqbqg-002zCK-1C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:58052
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIHvX/MDIBntnIKmNn4Ici2/2RP3oWxsnWDviqRFOPeVZVXbYe9putvwxzM657VyrKTrsejmNXbEsHS2lUSOajReQr/Nw9NdEHj6nIp0LtbZ6QKNHs+R
 6XWnYV2rbuxEIWznaJSf24+venM8sRx4o4AaiQWcWoyCOIZYAsR/lQ77cY8l4MoPgA68K4KQjtAq0DJ+q0FFv0HgVAVfgRSWMsXlLRKXq2ac+2/RW5at96zn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 10:03, Kees Cook wrote:
> On Wed, Oct 11, 2023 at 08:03:43AM -0600, Gustavo A. R. Silva wrote:
>> Currently, a NULL pointer dereference will happen in function
>> `dma_fence_enable_sw_signaling()` (at line 615), in case `chain`
>> is not allocated in `mock_chain()` and this function returns
>> `NULL` (at line 86). See below:
>>
>> drivers/dma-buf/st-dma-fence-chain.c:
>>   86         chain = mock_chain(NULL, f, 1);
>>   87         if (!chain)
>>   88                 err = -ENOMEM;
>>   89
>>   90         dma_fence_enable_sw_signaling(chain);
> 
> Instead of the larger patch, should line 88 here just do a "return
> -ENOMEM" instead?

Nope. I would have to add a `goto` to skip `dma_fence_enable_sw_signaling(chain)`.

I originally thought of that, but as other _signaling() functions have
sanity-checks inside, I decided to go with that solution.

This bug has been there since Sep 2022. So, adding a sanity check inside that
function should prevent any other issue of this same kind to enter the codebase
and stay there for years.

--
Gustavo

> 
> -Kees
> 
>>
>> drivers/dma-buf/dma-fence.c:
>>   611 void dma_fence_enable_sw_signaling(struct dma_fence *fence)
>>   612 {
>>   613         unsigned long flags;
>>   614
>>   615         spin_lock_irqsave(fence->lock, flags);
>> 			       ^^^^^^^^^^^
>> 				    |
>> 			  NULL pointer reference
>> 			  if fence == NULL
>>
>>   616         __dma_fence_enable_signaling(fence);
>>   617         spin_unlock_irqrestore(fence->lock, flags);
>>   618 }
>>
>> Fix this by adding a NULL check before dereferencing `fence` in
>> `dma_fence_enable_sw_signaling()`. This will prevent any other NULL
>> pointer dereference when the `fence` passed as an argument is `NULL`.
>>
>> Addresses-Coverity: ("Dereference after null check")
>> Fixes: d62c43a953ce ("dma-buf: Enable signaling on fence for selftests")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/dma-buf/dma-fence.c | 9 ++++++++-
>>   include/linux/dma-fence.h   | 2 +-
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index 8aa8f8cb7071..4d2f13560d0f 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -607,14 +607,21 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
>>    * This will request for sw signaling to be enabled, to make the fence
>>    * complete as soon as possible. This calls &dma_fence_ops.enable_signaling
>>    * internally.
>> + *
>> + * Returns 0 on success and a negative error value when @fence is NULL.
>>    */
>> -void dma_fence_enable_sw_signaling(struct dma_fence *fence)
>> +int dma_fence_enable_sw_signaling(struct dma_fence *fence)
>>   {
>>   	unsigned long flags;
>>   
>> +	if (!fence)
>> +		return -EINVAL;
>> +
>>   	spin_lock_irqsave(fence->lock, flags);
>>   	__dma_fence_enable_signaling(fence);
>>   	spin_unlock_irqrestore(fence->lock, flags);
>> +
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL(dma_fence_enable_sw_signaling);
>>   
>> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
>> index ebe78bd3d121..1e4025e925e6 100644
>> --- a/include/linux/dma-fence.h
>> +++ b/include/linux/dma-fence.h
>> @@ -399,7 +399,7 @@ int dma_fence_add_callback(struct dma_fence *fence,
>>   			   dma_fence_func_t func);
>>   bool dma_fence_remove_callback(struct dma_fence *fence,
>>   			       struct dma_fence_cb *cb);
>> -void dma_fence_enable_sw_signaling(struct dma_fence *fence);
>> +int dma_fence_enable_sw_signaling(struct dma_fence *fence);
>>   
>>   /**
>>    * dma_fence_is_signaled_locked - Return an indication if the fence
>> -- 
>> 2.34.1
>>
>>
> 
