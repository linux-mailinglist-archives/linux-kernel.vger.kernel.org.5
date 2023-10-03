Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EFB7B64E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbjJCJBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjJCJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:01:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CEAAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:01:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 447B26607079;
        Tue,  3 Oct 2023 10:00:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696323658;
        bh=cvW64htWBwkbZa50ehWwGHppuYY384nnu1olxbLOfrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lqsfHalCz/aFw0YXCDQqUQrDpgV1BVfV9FUbldI+Vn06NWEt0/oE9DpNqCi0NV613
         Zzv5Ow+cc+O3QQG7+dqsPgK2Aot/H30/KoH3vPb9vjhzuEJh4D+bKBtTI4Krngkx2B
         SNf1Z9OpJPONNAcaDwMAmFLV8DVRYz1JAhoR8bCLY/x6oT4TVyTvLrnOhBkYzQ0HWj
         YurT6ILG14bLcU57gj5zKdhPt2SBMXYXJB3tNEcbpIVIHQFmRpf5o+GB9Ym8FK5F17
         W6i4ktGWuDT6mJrDi4sQ2oAsxFIRaLMiFA6TDg3GFrMOjpf9qaeiqs7TPqSlvLn21r
         203pqcOgXn6bQ==
Date:   Tue, 3 Oct 2023 11:00:55 +0200
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
Subject: Re: [PATCH v17 13/18] drm/shmem-helper: Add memory shrinker
Message-ID: <20231003110055.346fd94c@collabora.com>
In-Reply-To: <bbbd82a5-41bf-4ca3-476d-e5039e94631b@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
        <20230914232721.408581-14-dmitry.osipenko@collabora.com>
        <20230915104633.0d5c3932@collabora.com>
        <454c464e-4534-7ec3-6d38-49b7df83c7be@collabora.com>
        <20230926093517.11a172ad@collabora.com>
        <bbbd82a5-41bf-4ca3-476d-e5039e94631b@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Tue, 3 Oct 2023 03:31:32 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 9/26/23 10:35, Boris Brezillon wrote:
> >>>> +	__drm_gem_shmem_release_pages(shmem);    
> >>> Make sure you drop the implicit pages_use_count ref the sgt had, this
> >>> way you can still tie the necessity to drop the pages to sgt != NULL in
> >>> drm_gem_shmem_free().    
> >> This will require further refcnt re-initialization when pages are
> >> restored if it's dropped to zero. I don't see how this will improve
> >> anything.  
> > Sorry to disagree, but I do think it matters to have a clear ownership
> > model, and if I look at the code (drm_gem_shmem_get_pages_sgt_locked()),
> > the sgt clearly owns a reference to the pages it points to.  
> 
> It creates too much unnecessary trouble because, again, pages_use_count
> can't drop to zero easily.

Not saying pages_use_count should drop to zero, I'm just saying the
reference that was owned by the sgt should be released when this sgt is
freed, no matter if this sgt destruction is triggered by a GEM eviction,
or because the GEM object is freed entirely.

> Shrinker doesn't own the refcnt and not
> allowed to touch it.

I'm not asking the shrinker to own a reference on the pages either.
It's really the sgt that owns this reference.

> The pages_use_count is then used by things like
> mmap() and etc that use get_pages(), which can be invoked for evicted GEM.

Yes, and I still have a hard time seeing how this interferes with what
I'm suggesting to be honest.

> 
> I'd prefer to keep refcounting as is, don't see how to implement your
> suggestion.

Can you be more specific? I don't really see what the problem is with
decrementing pages_use_count when you free the sgt (eviction), and
re-incrementing it when the sgt is restored (swapin).

Regards,

Boris
