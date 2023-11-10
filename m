Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556DD7E81B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjKJSco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbjKJSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:31:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E53A20C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:59:04 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E28566073EF;
        Fri, 10 Nov 2023 14:59:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699628342;
        bh=SQb2j6nDMO+EiuEwHZDxGZzthkvFJAlHjbUlz+IdTNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YH+nfkgLbkWQkV37II3bYdZcSxqLDwOFcTSgy7M/3n5WqMe4lphFWoXyhqvonc1RG
         OW7e5fBKPttqYaSSLUxUqqcc+TNzF5VwADvhL28pA4+KpvuQ+EZB7A3cLHm63evqlG
         ajV1CVKB+iXnG2EsczpWQAq7oyXBpLvnTYovGgz6cEnIU9xeNQm/N5YRqyjsITHjMc
         BAYaGIu20tYV+MlsSB0r6BMQ/9i/eW6r0pifvYA+ICQf7MXsiGfbESbwN9Mf0/09zo
         SzVHoOfpbmrbD7P+z8MTWwR2ixJK8Zvx1Q1xc98tFkfOLq+AItBtNT1eokLkaQ/HLa
         luLbtD3iwJL6Q==
Date:   Fri, 10 Nov 2023 15:58:58 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 19/26] drm/shmem-helper: Add common memory shrinker
Message-ID: <20231110155858.4c92f05d@collabora.com>
In-Reply-To: <20231029230205.93277-20-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-20-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 02:01:58 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> @@ -238,6 +308,20 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
>  	if (refcount_dec_not_one(&shmem->pages_use_count))
>  		return;
>  
> +	/*
> +	 * Destroying the object is a special case because acquiring
> +	 * the obj lock can cause a locking order inversion between
> +	 * reservation_ww_class_mutex and fs_reclaim.
> +	 *
> +	 * This deadlock is not actually possible, because no one should
> +	 * be already holding the lock when GEM is released.  Unfortunately
> +	 * lockdep is not aware of this detail.  So when the refcount drops
> +	 * to zero, we pretend it is already locked.
> +	 */
> +	if (!kref_read(&shmem->base.refcount) &&
> +	    refcount_dec_and_test(&shmem->pages_use_count))
> +		return drm_gem_shmem_free_pages(shmem);

Uh, with get/put_pages() being moved to the create/free_gem()
hooks, we're back to a situation where pages_use_count > 0 when we
reach gem->refcount == 0, which is not nice. We really need to patch
drivers so they dissociate GEM creation from the backing storage
allocation/reservation + mapping of the BO in GPU VM space.

