Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468D67F1135
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjKTLCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjKTLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:02:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19AF85
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:02:36 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10D5A66022D1;
        Mon, 20 Nov 2023 11:02:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700478155;
        bh=/sm0Hj2RnfQif68Ay2Vo+hONdmo2lESCVcj5nMYwWi4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ntQl3n5IMwfCZ3084QNrJMZsOK/EBeDt0XucBu+b79iwkcv+LaGRHYZuD195NE9bY
         Ytw5WalbvLao8VSihuYK9sZkbLo9gJaPI2xjtaaKoKKbluix9Xk6U+cyG2mt80q5OE
         FgBBuCxWjNf2blvKRpekmPxiFmW03sEIL2NBUTSpi/14MKckTETARYnPimEGE3nCBs
         9YKlRgR3MMNn9AVoOz2j0aIx7H7KQkVK8sakbpEah+aW0uEXqMtDvKnTZbeIcGc5JA
         bmaH2+TV7nkxKmaN+rxAbif1x1XT+3LBtN6+/SUk41a/rvzWiCq1uGfQki18H14ap+
         iEj3Nyy0hA9yw==
Message-ID: <bd2308d6-38e5-6042-3da8-fb436f67a88e@collabora.com>
Date:   Mon, 20 Nov 2023 14:02:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v18 11/26] drm/shmem-helper: Prepare drm_gem_shmem_free()
 to shrinker addition
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
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-12-dmitry.osipenko@collabora.com>
 <20231110111601.5d6bd1ab@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231110111601.5d6bd1ab@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 13:16, Boris Brezillon wrote:
> On Mon, 30 Oct 2023 02:01:50 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Prepare drm_gem_shmem_free() to addition of memory shrinker support
>> to drm-shmem by adding and using variant of put_pages() that doesn't
>> touch reservation lock. Reservation shouldn't be touched because lockdep
>> will trigger a bogus warning about locking contention with fs_reclaim
>> code paths that can't happen during the time when GEM is freed and
>> lockdep doesn't know about that.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 35 +++++++++++++-------------
>>  1 file changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index 08b5a57c59d8..24ff2b99e75b 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -128,6 +128,22 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
>>  }
>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
>>  
>> +static void
>> +drm_gem_shmem_free_pages(struct drm_gem_shmem_object *shmem)
>> +{
>> +	struct drm_gem_object *obj = &shmem->base;
>> +
>> +#ifdef CONFIG_X86
>> +	if (shmem->map_wc)
>> +		set_pages_array_wb(shmem->pages, obj->size >> PAGE_SHIFT);
>> +#endif
>> +
>> +	drm_gem_put_pages(obj, shmem->pages,
>> +			  shmem->pages_mark_dirty_on_put,
>> +			  shmem->pages_mark_accessed_on_put);
>> +	shmem->pages = NULL;
>> +}
>> +
>>  /**
>>   * drm_gem_shmem_free - Free resources associated with a shmem GEM object
>>   * @shmem: shmem GEM object to free
>> @@ -142,8 +158,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>>  	if (obj->import_attach) {
>>  		drm_prime_gem_destroy(obj, shmem->sgt);
>>  	} else {
>> -		dma_resv_lock(shmem->base.resv, NULL);
>> -
>>  		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
>>  
>>  		if (shmem->sgt) {
>> @@ -157,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>>  
> If you drop the dma_resv_lock/unlock(), you should also replace the
> drm_gem_shmem_put_pages_locked() by a drm_gem_shmem_free_pages() in this
> commit.

drm_gem_shmem_put_pages_locked() is exported by a later patch of this
series, it's not worthwhile to remove this function

-- 
Best regards,
Dmitry

