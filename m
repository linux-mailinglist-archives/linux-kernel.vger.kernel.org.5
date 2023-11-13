Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0027E9CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjKMNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjKMNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:18:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D081711
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:18:41 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF94A6602F27;
        Mon, 13 Nov 2023 13:18:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699881520;
        bh=PsIR0GMAaqeUGdkQLSq03TGY+YtcolIVSMRqZDzc4JU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X6iNkjwQ8pObx2Yq1DU9viprvhAzw6KpMX/7M6wC4FvKDGMfxLVcYSFLxI9LSkM00
         Rde7H5LmO6xc6SWwyoprZBk4t9b6gE2W+YfXYZVRz3gS50oZ50MpHUB5IHZ1jmDsop
         xmjdsnRVIkvvADYlsOhztSTId32H6nhE2i/rkKGXYrHZpHEiYUb0s9kvfIOsTP8/z8
         ZikdbAh/HYFzUqB62ESil2c4PqvnnhvxzxYivCwUltf7pykxcKlYLIgbtzAmFSjRUL
         SklX/mE5/zPNykCY/JMvQX5RQ1ybYIIkXmEWdAYCGaW0zkZpeOar30hDaQkJkWvQia
         BnBX7FQ8DMC1g==
Message-ID: <622e2064-095f-d2da-0ad1-887642306020@collabora.com>
Date:   Mon, 13 Nov 2023 16:18:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] drm/virtio: Modify RESOURCE_GET_LAYOUT ioctl
Content-Language: en-US
To:     Julia Zhang <julia.zhang@amd.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Chen Jiqian <Jiqian.Chen@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Honglei Huang <honglei1.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20231110071632.24612-1-julia.zhang@amd.com>
 <20231110071632.24612-3-julia.zhang@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231110071632.24612-3-julia.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 10:16, Julia Zhang wrote:
> Modify RESOURCE_GET_LAYOUT ioctl to handle the use case that query
> correct stride for guest linear resource before it is created.
> 
> Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 26 ++++++++------
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 47 ++++++++++++--------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 35 +++++++++++--------
>  include/uapi/drm/virtgpu_drm.h         |  6 ++--
>  include/uapi/linux/virtio_gpu.h        |  8 ++---
>  5 files changed, 66 insertions(+), 56 deletions(-)

1. Please squash this all into a single patch. For upstream kernel it's
not acceptable to have subsequent commits modifying previous commits. To
commit message add your s-o-b, your co-developed-by tags and a brief
comment explaining changes you've done to the original patch.

Signed-off-by: Daniel Stone <daniels@collabora.com>
Co-developed-by: Julia Zhang <julia.zhang@amd.com> # query correct
stride for guest linear resource before it's created
Signed-off-by: Julia Zhang <julia.zhang@amd.com>

2. Make sure that patch passes `scripts/checkpatch.pl`

3. Add link to the commit message for the relevant Mesa MR that makes
use of the new ioctl. The MR should be already merged or ready to be merged.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/123456

-- 
Best regards,
Dmitry

