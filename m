Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648BE79C7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjILHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjILHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:07:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08110C9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:07:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C098566072FB;
        Tue, 12 Sep 2023 08:07:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694502434;
        bh=0bDv/Gse7UVvtEQH3mZnutrtEjAlK95RuXH2e30TfrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KRtSmH7QnR8S7UkJfPXEyGU0kP6vvA48GzbleYQdWBENY+H4A31CYTxK69tTr2dX+
         i01d7HYh3ihwij7//xslYBZL5J1WFKvONp6qmIYw2cz84CFypEwOEQrOryRGWFuyIc
         UxJ56XMQp5X5rdoXlCHnX+PZ0co/PQZez3LDqkJecbNYoBm9i+zeqNTl9+saowwmBz
         n3GZgxyokdntSmj9zAxhZTlonyX2HgaIYSCKv3J9ml1ARtSJU7K8yi5MA0dVz6iOVK
         3Ey0yu6xTgGhDepjWopuzQycPrtUPgtFh1AQCejr3WkemwQZ8GiWiiInLiNgKocJXU
         GI1E+jcz92LEw==
Date:   Tue, 12 Sep 2023 09:07:10 +0200
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
Subject: Re: [PATCH v16 02/20] drm/shmem-helper: Use flag for tracking page
 count bumped by get_pages_sgt()
Message-ID: <20230912090710.72e998e6@collabora.com>
In-Reply-To: <297f5209-603e-a50d-c27b-8e50d23f86de@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
        <20230903170736.513347-3-dmitry.osipenko@collabora.com>
        <20230905094050.3c918a43@collabora.com>
        <297f5209-603e-a50d-c27b-8e50d23f86de@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 02:41:58 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 9/5/23 10:40, Boris Brezillon wrote:
> > On Sun,  3 Sep 2023 20:07:18 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> Use separate flag for tracking page count bumped by shmem->sgt to avoid
> >> imbalanced page counter during of drm_gem_shmem_free() time. It's fragile
> >> to assume that populated shmem->pages at a freeing time means that the
> >> count was bumped by drm_gem_shmem_get_pages_sgt(), using a flag removes
> >> the ambiguity.
> >>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >>  drivers/gpu/drm/drm_gem_shmem_helper.c | 11 ++++++++++-
> >>  drivers/gpu/drm/lima/lima_gem.c        |  1 +
> >>  include/drm/drm_gem_shmem_helper.h     |  7 +++++++
> >>  3 files changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> index 6693d4061ca1..848435e08eb2 100644
> >> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> @@ -152,8 +152,10 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
> >>  			sg_free_table(shmem->sgt);
> >>  			kfree(shmem->sgt);
> >>  		}
> >> -		if (shmem->pages)
> >> +		if (shmem->pages) {
> >>  			drm_gem_shmem_put_pages(shmem);
> >> +			drm_WARN_ON(obj->dev, !shmem->got_pages_sgt);
> >> +		}  
> > 
> > Already mentioned in v15, but I keep thinking the following:
> > 
> > 		if (shmem->sgt) {
> > 			// existing code in the preceding
> > 			// if (shmem->sgt) branch
> > 			...
> > 
> > 			/*
> > 			 * Release the implicit pages ref taken in
> > 			 * drm_gem_shmem_get_pages_sgt_locked().
> > 			 */
> > 			drm_gem_shmem_put_pages(shmem);
> > 		}
> > 
> > does exactly the same without requiring the addition of a new field.  
> 
> I'll factor out these "flag" patches into separate patchset since they
> cause too many questions.

So patch 1 and 2 in this series right?

> This is a fix for a minor bug that existed for
> many years

I'm not denying the fact there's a bug, but I'm convinced this can be
fixed without adding new flags. If there's something wrong with the
suggested solution, I'd be interested to hear more about it.

> and is difficult to trigger in practice, it can wait.

Triggering it with a real fault is hard, but you can manually fake
errors at any point in the initialization process and check what
happens.

> 
> For now will be better to focus on finishing and landing the refcnt and
> shrinker patches, the rest of drm-shmem core improvements can be done
> afterwards.
> 

Sounds good to me.
