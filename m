Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C787AE2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIZAhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjIZAhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:37:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC6109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:37:28 -0700 (PDT)
Received: from [192.168.2.47] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADFE06607243;
        Tue, 26 Sep 2023 01:37:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695688645;
        bh=Awnj1HSyG7f4LqqDwPj+Y+XJIJXRPsKOZA+pJHfGHi4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VPEP6kAqHgihHX6Y5wkrwMDH0KClVvOCpYGfCA1LoxlHg97uVlJh/hAiRDkxxB2ql
         wRTOPQFe0TxbJyDG+qLQ934ehIw2pJOWKDqB2lA4AbBbCt+MLgy5lL0gp/stGnNrVe
         5vvyP0SeJDE9ZRYaPGgCANmzvsLdl/3TYwPBFoGdNCnTxqO3jpqcQPJOZMo+Hr1i/Z
         s6RncAYU+wElW629MX1xdnA1+0gBb5jN2oZwm6tz9EKvVCSFzGH/oRjoangxPd05ML
         SuQL+Ibij6hxwqvniV4zuBwS1bm0fo8i6hHzzc7NfvM/eghDseAAleTep+RHNMIOx3
         oE2SFqjnNSgNQ==
Message-ID: <64e8708a-bb73-96ae-90af-f7b51317613b@collabora.com>
Date:   Tue, 26 Sep 2023 03:37:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v17 13/18] drm/shmem-helper: Add memory shrinker
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
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
 <20230914232721.408581-14-dmitry.osipenko@collabora.com>
 <20230915104633.0d5c3932@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230915104633.0d5c3932@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 11:46, Boris Brezillon wrote:
>> -static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>> +static int
>> +drm_gem_shmem_acquire_pages(struct drm_gem_shmem_object *shmem, bool init)
>>  {
>>  	struct drm_gem_object *obj = &shmem->base;
>>  	struct page **pages;
>>  
>>  	dma_resv_assert_held(shmem->base.resv);
>>  
>> -	if (refcount_inc_not_zero(&shmem->pages_use_count))
>> +	if (shmem->madv < 0) {
>> +		drm_WARN_ON(obj->dev, shmem->pages);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (shmem->pages) {
>> +		drm_WARN_ON(obj->dev, !shmem->evicted);
>>  		return 0;
>> +	}
>> +
>> +	if (drm_WARN_ON(obj->dev, !(init ^ refcount_read(&shmem->pages_use_count))))
>> +		return -EINVAL;
> OOC, why do we care? Is there any difference between initial and re-pin
> that make the page allocation impossible? Feels like, if there's a
> check to do, it should be done in the caller instead, and you can drop
> the init param here.

This is a sanity check that addresses additional refcnt tracking
complexity imposed by shrinker.

This function is used by both init and re-pin that is invoked from
several places in the code. It's not trivial to move that check to the
callers.

-- 
Best regards,
Dmitry

