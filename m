Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ECA79C4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjILE2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjILE2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:28:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F61B8834
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:09:25 -0700 (PDT)
Received: from [192.168.2.112] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E86C6607083;
        Tue, 12 Sep 2023 00:32:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694475138;
        bh=zku9FPqZQ4BrwWJHClmLRwHVmO9XDaBWXmy1+OJPxnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hXycm77pWg7XeNR1ChG9zPOOuBn1yRIZIPb8G4mjVbjBwYX1nirACTsOsliqnXuU5
         2bjV3ovPHyrGyxaA/7n5sIe1ujIg+lVFt3nO3YOc8zWIj89RUIL4ZcTWKeJvwsCzBV
         wlVg1DcxtxR3GbpJL66VZoxjO+7IMk8b88bmUzXt51/E1F53fsorj2gLNoDFPySbb7
         7zyjOtLMSo/ZFHnIJPeVZVDJeczI2TX4bcyierD8kkZHRCOgjNxmNSZXc22+6LfZpn
         1dLzWLhvHDbMeQ8PTCDCceJWMQw3hl2oz2FhvFUbEUlSGjTBXz+1QEd9v3E2J1sJHM
         9SedzEO/6oQRQ==
Message-ID: <b653f475-d1f7-d1b8-e4b4-3a6611e9d70b@collabora.com>
Date:   Tue, 12 Sep 2023 02:32:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 06/20] drm/virtio: Replace drm_gem_shmem_free() with
 drm_gem_object_put()
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
 <20230903170736.513347-7-dmitry.osipenko@collabora.com>
 <20230905092028.182f8ed8@collabora.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230905092028.182f8ed8@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 10:20, Boris Brezillon wrote:
> On Sun,  3 Sep 2023 20:07:22 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Prepare virtio_gpu_object_create() to addition of memory shrinker support
>> by replacing open-coded drm_gem_shmem_free() with drm_gem_object_put() that
>> decrements GEM refcount to 0, which becomes important for drm-shmem because
>> it will start to use GEM's refcount during the shmem's BO freeing time in
>> order to prevent spurious lockdep warning about resv lock ordering vs
>> fs_reclaim code paths.
> 
> I think I'm okay with the change (assuming virtio_gpu_free_object()
> can deal with partially initialized objects), not with the explanation
> :-). I don't really see why we need to take the resv lock in
> drm_gem_shmem_free(). As said in my v15 review, I think we should
> replace the drm_gem_shmem_put_pages() call we have in
> drm_gem_shmem_free() by a call to a new drm_gem_shmem_free_pages()
> helper that does exactly what drm_gem_shmem_put_pages() does without
> the refcounting/locking, because all that should remain at the time
> drm_gem_shmem_free() is called is the implicit pages ref owned by
> shmem->sgt, and there's no risk of other threads accessing the GEM
> object at that point.

Apparently I forgot to drop these drm_gem_object_put() patches by
accident in v16, the drm_gem_shmem_free() doesn't touch resv lock
anymore. Will re-check for v17.

-- 
Best regards,
Dmitry

