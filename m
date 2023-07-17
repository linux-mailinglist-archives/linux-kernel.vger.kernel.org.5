Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6CE75602D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGQKNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGQKNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:13:09 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [IPv6:2001:41d0:203:375::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79FBA1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:13:07 -0700 (PDT)
Message-ID: <4484c007-132c-ce47-fa71-87f33c87fe07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689588785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhICywX3fVkCJ86sYt3LvPZzY1iAlblXfymNZlBpmrw=;
        b=XwHWkvZRCita7MPpewrQ8rumN5+Pc1F7tz1mSxw9pQ9rJ9ret+y78/wFAo1JHkpgveJxyx
        IhyWGqBUJ5fghhqZWI5/KipHrgfu0JbA1ly62TMgrKeIjhjqV8/blZLN5R2SwP+k3JF5+9
        xi5KB5x+pk1EABp3RM1YQFYbEK2IIDI=
Date:   Mon, 17 Jul 2023 18:12:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/8] drm/etnaviv: Using the size_t variable to store
 the number of pages
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
 <20230623100822.274706-2-sui.jingfeng@linux.dev>
 <4f80b175f94eaf386354d1f3425208ca6cf20482.camel@pengutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <4f80b175f94eaf386354d1f3425208ca6cf20482.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023/7/17 17:43, Lucas Stach wrote:
> Hi Jingfeng,
>
> Am Freitag, dem 23.06.2023 um 18:08 +0800 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Because the etnaviv_gem_new_private() function receives the size_t argument
>> for the number of pages. And the number of pages should be unsigned.
>>
>> Note that Most 32-bit architectures use "unsigned int" size_t,
>> and all 64-bit architectures use "unsigned long" size_t.
>> So, let's keep the argument and parameter consistent.
>>
> This explanation doesn't add up. npages is just that: a number of
> pages. Why would it make sense to use size_t here?

Because the 'size' variable in the etnaviv_gem_prime_import_sg_table() 
function is declared

as size_t type. On 64-bit machine, size_t is actually is 64-bit wide and 
it is *unsigned*.

While 'int' is actually 32-bit wide(at both 32-bit system and 64-bit 
system) and it is *signed*,

So, my point (argument) is that


1) This patch help to avoid the unnecessary 64 bit to 32 bit conversion.

2) The kvmalloc_array() function also accept  size_t type (see the 
prototype of  kvmalloc_array function include/linux/slab.h)


So my patch do helps to keep the code style consistent.


> If you want to be consistent I would have expected this change to
> switch things to unsigned int,

This may introduce a truncate operation (from a 64-bit to 32-bit), which 
is necessary.

And when you pass the 'npages' parameter to kvmalloc_array() function,

The compiler probably has to do the integer promotion (from a 32-bit to 
64-bit) for you.


> as you did in the second patch of this
> series.
>
> Regards,
> Lucas
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> index 3524b5811682..b003481adc2b 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> @@ -114,7 +114,8 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>>   {
>>   	struct etnaviv_gem_object *etnaviv_obj;
>>   	size_t size = PAGE_ALIGN(attach->dmabuf->size);
>> -	int ret, npages;
>> +	size_t npages = size / PAGE_SIZE;
>> +	int ret;
>>   
>>   	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
>>   				      &etnaviv_gem_prime_ops, &etnaviv_obj);
>> @@ -123,8 +124,6 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>>   
>>   	lockdep_set_class(&etnaviv_obj->lock, &etnaviv_prime_lock_class);
>>   
>> -	npages = size / PAGE_SIZE;
>> -
>>   	etnaviv_obj->sgt = sgt;
>>   	etnaviv_obj->pages = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
>>   	if (!etnaviv_obj->pages) {
