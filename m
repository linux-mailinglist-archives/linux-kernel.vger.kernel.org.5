Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B97A059A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjINNav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjINNau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:30:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B51AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:30:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EE7B660734B;
        Thu, 14 Sep 2023 14:30:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698245;
        bh=s4vst/Ez8mUQ4XmFnXcyatF86C+jChenHUTOQpxRlaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FpeatmoC/rpQA8OrdxxYeSUlOGPtksLLxBhfwRgzMQS9Kl4VqEma2uMnZaZE+Uhtg
         p7OTKJe72Xey/UI2zds6wfY+hRnSUjCXPIqX7ZqCMj3LuC9jstK9t0UXhYoP8BNIr+
         tKOay4D3yzf9wWawNrNNFFWsfn1Di1QBybmoig0mSc2PV3mDokVl+e12uvYTydG2T+
         iSWSwYDe87vV5ks2xn5YIHE86Tioh0YZQuUf1Q4b7OzY1e5Rtfa7GkZ4xQAFr1gBJ7
         Q3aHYFrPkTeFe/oufa/TZ50SqibVOxh1uAEMg1X2pea9SCx+24KyZ4aZnT/ldBCuDd
         xsjR/5qN8KZpA==
Date:   Thu, 14 Sep 2023 15:30:41 +0200
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
Subject: Re: [PATCH v16 15/20] drm/shmem-helper: Add memory shrinker
Message-ID: <20230914153041.569f39bb@collabora.com>
In-Reply-To: <20230914152703.78b1ac82@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
        <20230903170736.513347-16-dmitry.osipenko@collabora.com>
        <20230905100306.3564e729@collabora.com>
        <26f7ba6d-3520-0311-35e2-ef5706a98232@collabora.com>
        <20230913094832.3317c2df@collabora.com>
        <aa270715-89ae-2aac-e2e3-018c21e1ff0e@collabora.com>
        <20230914093626.19692c24@collabora.com>
        <21dda0bd-4264-b480-dbbc-29a7744bc96c@collabora.com>
        <20230914102737.08e61498@collabora.com>
        <a89cc9c1-5054-e45f-edec-819fdbfef2b5@collabora.com>
        <20230914135840.5e0e11fe@collabora.com>
        <ca7e905b-2809-fce4-1b56-7909efb1a229@collabora.com>
        <20230914152703.78b1ac82@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 15:27:03 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> You should drop the '&& refcount_read(&shmem->pages_use_count)',
> otherwise you'll never enter this branch (sgt allocation retained
> a ref, so pages_use_count > 0 when ->sgt != NULL).

Sorry for the brain fart. You can drop this extra test because its
redundant (->sgt != NULL implies pages_use_count > 0), but it shouldn't
prevent you from entering the branch.
