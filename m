Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8D790925
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjIBS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIBS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:28:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC0E4B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:28:26 -0700 (PDT)
Received: from [192.168.2.205] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D05AB6607285;
        Sat,  2 Sep 2023 19:28:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693679305;
        bh=16VQ2EWyfHrq08hQmOsXZjo53afgTw+mo/8RhowkQ2c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tx6uOIJCIjQW5Me0hvxoAfLLUZU7W8R/FmsBGNuOAFVKodQSurm91/zNrTm4/Qvtp
         Dlt8ReHbCmj/ch8x8VAU8uJ118uQnGxQ7nhR2WrdBnkdQImvRSANQTpPTZP2K7xYsL
         TVOSQJoPgIAKNdS/qtjihuYJIcGWrIdd/efTc9dswYbvLQXlf9Ndnnpwz6HIBmcoZM
         cToMyeQ0YnqGQyRQ3p3t6XzsGsolFKqrvlL/4h/b0a1Pjd5HUK0jn+eTSaY6XfwRE1
         c1bNgV27sjZUujSSjfE0go660sPamIHhXPFmmJu3CRXP4L099VExUgR1ZvAmDF28vP
         exsoma6gymAPQ==
Message-ID: <1a40d9c6-fdbf-1494-00f2-1e37206fc984@collabora.com>
Date:   Sat, 2 Sep 2023 21:28:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v15 02/23] drm/shmem-helper: Use flag for tracking page
 count bumped by get_pages_sgt()
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
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
 <20230827175449.1766701-3-dmitry.osipenko@collabora.com>
 <20230828125518.7b926fc6@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230828125518.7b926fc6@collabora.com>
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

On 8/28/23 13:55, Boris Brezillon wrote:
> On Sun, 27 Aug 2023 20:54:28 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Use separate flag for tracking page count bumped by shmem->sgt to avoid
>> imbalanced page counter during of drm_gem_shmem_free() time. It's fragile
>> to assume that populated shmem->pages at a freeing time means that the
>> count was bumped by drm_gem_shmem_get_pages_sgt(), using a flag removes
>> the ambiguity.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 ++-
>>  drivers/gpu/drm/lima/lima_gem.c        | 1 +
>>  include/drm/drm_gem_shmem_helper.h     | 7 +++++++
>>  3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index 78d9cf2355a5..db20b9123891 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -152,7 +152,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>>  			sg_free_table(shmem->sgt);
>>  			kfree(shmem->sgt);
>>  		}
>> -		if (shmem->pages)
>> +		if (shmem->got_sgt)
>>  			drm_gem_shmem_put_pages(shmem);
> 
> Can't we just move this drm_gem_shmem_put_pages() call in the
> if (shmem->sgt) block?

As you've seen in patch #1, the shmem->sgt may belong to imported dmabuf
and pages aren't referenced in this case.

I agree that the freeing code is confusing. The flags make it a better,
not ideal. Though, the flags+comments solution is good enough to me.
Please let me know if you have more suggestions, otherwise I'll add
comment to the code and keep this patch for v16.

BTW, I realized that the new flag wasn't placed properly in the Lima
driver, causing unbalanced page count in the error path. Will correct it
in v16.

-- 
Best regards,
Dmitry

