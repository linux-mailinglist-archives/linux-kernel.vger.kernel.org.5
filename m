Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15507BA820
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjJERcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjJERcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:32:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FE419A4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:28:23 -0700 (PDT)
Received: from [192.168.2.166] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67AC76607334;
        Thu,  5 Oct 2023 18:28:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696526901;
        bh=7WOYOnPo936SlriKU/i8Mk9uJTSewjYiMlJ/Gb48yCo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A7mKszfMS6cci2WZndgsbTaEqM3I+WUX0RgO9Hc5+ptdOr9Xksjgy8Aj1MzNeir+g
         cy4rj2oBy2k+mqhc8/K0jXHkcYSm/8gzre6OfvYCGJMKrK6Yb5UZhQKAv5lD4pzzYl
         zfEnROQkdhCxGzWGTATkb6jp8rXEiPzbLcb19/rsH4Pv/g+hM1KNADfKSqauuOjHdy
         dyXn6sSG2klYogaW6QsERkMCsipNOymnhXSMV/ZwRklbL9r5CvXO7kyaNqTsgeWhvd
         XxC9GOMTB3lLayIGNwShdQYy9zW4kEzi9ZqVCF/hotLIG5L3bItqrKgFhhym308zK+
         mEj476wzE9iZw==
Message-ID: <ccada906-2380-7e98-99e8-e83d9b89fbd1@collabora.com>
Date:   Thu, 5 Oct 2023 20:28:17 +0300
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
 <454c464e-4534-7ec3-6d38-49b7df83c7be@collabora.com>
 <20230926093517.11a172ad@collabora.com>
 <d93375df-215a-2325-ba6d-4616dfed0947@collabora.com>
 <20231003130909.3b470a43@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231003130909.3b470a43@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 14:09, Boris Brezillon wrote:
> Unmap tends to refer to a VM related operation (removing a mapping in
> the CPU or GPU VM), so it's confusing too IMHO. What we do here is
> return pages to the shmem file logic, so they can be reclaimed.
> 
> Given the drm_gem function doing that is called drm_gem_put_pages(),
> maybe rename it drm_gem_shmem_shrinker_put_pages_locked(), and rename
> drm_gem_shmem_swapin_locked() into
> drm_gem_shmem_shrinker_get_pages_locked(), to be consistent.

The swapin is a common term and function naming scheme among DRM
drivers. That name shouldn't be changed.

The drm_gem_shmem_shrinker_put_pages_locked() sounds okay, let's use it.

-- 
Best regards,
Dmitry

