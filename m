Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A779DCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjIMAGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjIMAGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:06:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68C10E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:06:40 -0700 (PDT)
Received: from [192.168.2.112] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C2166607186;
        Wed, 13 Sep 2023 01:06:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694563598;
        bh=RYQEfSbXS7icZ90VHcjg9Rfm4OG1Af8Gjmm95/x4NmU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TBTri2Oqslf+5RuTlsy+AOU7f92nLds/RoO7MtlBbljNEHWSpGQw9lGLPGPJzS/uB
         Q0d9tQ/H5E52iRMZlj7RsvCYBXPUIEDC29NZk5LINDnqVrsl6xNfpIc7iig0DLJD5i
         QKFP01nfkFNUqHH2kmbiTcXsyv3wAKAgyKiC9YIV/6wHDY4+F6t4hmi2PVMcLssoMa
         d1C8MWbcIkF82p7qRt3NJ9Vi4Dwtw13bFUTlSeAJdg4uC8JuYgeWJvVUaDDQ/TObnl
         6orjtPjjg7C9zBFOV09qEbxQTc1VDxAwdfrNH+i9YCpTPhfUc/h6se3ZmKPCbVVMRu
         PB1hE4mk48WCA==
Message-ID: <b77955c6-b034-d0f0-f022-7c7523d7bef0@collabora.com>
Date:   Wed, 13 Sep 2023 03:06:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 09/20] drm/shmem-helper: Remove obsoleted is_iomem
 test
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
 <20230903170736.513347-10-dmitry.osipenko@collabora.com>
 <20230905084611.6a404ff1@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230905084611.6a404ff1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 09:46, Boris Brezillon wrote:
> On Sun,  3 Sep 2023 20:07:25 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Everything that uses the mapped buffer should be agnostic to is_iomem.
>> The only reason for the is_iomem test is that we're setting shmem->vaddr
>> to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
>> the obsoleted is_iomem test to clean up the code.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index 2b50d1a7f718..25e99468ced2 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -317,12 +317,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>>  
>>  	if (obj->import_attach) {
>>  		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
>> -		if (!ret) {
>> -			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
>> -				dma_buf_vunmap(obj->import_attach->dmabuf, map);
>> -				return -EIO;
>> -			}
>> -		}
> 
> Given there's nothing to unroll for the dmabuf case, I think it'd be
> good to return directly and skip all the error paths. It would also
> allow you to get rid of one indentation level for the !dmabuf path.
> 
> 	if (obj->import_attach)
> 		return dma_buf_vmap(obj->import_attach->dmabuf, map);
> 
> 	// non-dmabuf vmap logic here...

There is a common error message there that uses the common ret. The
error unwinding could be improved, but then it should be a separate
patch as it's unrelated to the change made here.

-- 
Best regards,
Dmitry

