Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A87E1874
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKFCDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjKFCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:03:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F93E6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 18:03:04 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0ACA16607435;
        Mon,  6 Nov 2023 02:03:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699236182;
        bh=xX6wIIpG/Wv5HUsHMt5+qLudM6Mp/o/MT2hir+b8bLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D35ywBv5iASzkyh/rZJl4h6aiinrXpqjt3tSFXlRoF3TN1lJpoB/HkYmHve2A7qS4
         xHugotys4uc3FBrc76rx1sVTzUuX9elG0F7+tfaOnNgHVjBDkTwfLdTkMXrwj5exOL
         sFiMUxIKhz6IDlkL8O00CnpIGcJ1BLvtsBe++dugML3fBtRZLEdF/nm9w4mPwni7He
         MMvF7+JI6uJYeDPkjFA7iPTGw9svnBwB5iHKzxZ33txcn6ggSXt1zUi3wdblNhuYGV
         dm3LoQTyj/dyEqedBjMrf/Cb8+rdmx4R1PuhRoxByMQB0sjW9jQc7nnLUYxWYo6uDQ
         ruX7NxfY++rAw==
Message-ID: <1228d85a-011b-8b48-61c7-fc760edaf7a1@collabora.com>
Date:   Mon, 6 Nov 2023 05:02:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v18 25/26] drm/virtio: Support shmem shrinking
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-26-dmitry.osipenko@collabora.com>
 <CAAfnVBk3gbxVL+WwY9pi27ts8JGPM=0VuOkTo8KOZcuO634UeQ@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAAfnVBk3gbxVL+WwY9pi27ts8JGPM=0VuOkTo8KOZcuO634UeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/23 01:55, Gurchetan Singh wrote:
> On Sun, Oct 29, 2023 at 4:03 PM Dmitry Osipenko <
> dmitry.osipenko@collabora.com> wrote:
> 
>> Support generic drm-shmem memory shrinker and add new madvise IOCTL to
>> the VirtIO-GPU driver. BO cache manager of Mesa driver will mark BOs as
>> "don't need" using the new IOCTL to let shrinker purge the marked BOs on
>> OOM, the shrinker will also evict unpurgeable shmem BOs from memory if
>> guest supports SWAP file or partition.
>>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 13 +++++-
>>  drivers/gpu/drm/virtio/virtgpu_gem.c    | 35 ++++++++++++++
>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 25 ++++++++++
>>  drivers/gpu/drm/virtio/virtgpu_kms.c    |  8 ++++
>>  drivers/gpu/drm/virtio/virtgpu_object.c | 61 +++++++++++++++++++++++++
>>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 40 ++++++++++++++++
>>  include/uapi/drm/virtgpu_drm.h          | 14 ++++++
>>  7 files changed, 195 insertions(+), 1 deletion(-)
...
> 
> Link to open-source userspace?

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/15278

I'll add it to the commit message

> Also, don't you need a VIRTGPU_PARAM_MADVISE_SUPPORTED or is the plan to
> use a DRM version?

The ioctl() returns error if DRM_VIRTGPU_MADVISE unsupported, extra
flags not needed by userspace

> Overall, the series for a generic shrinker seems useful for a wide variety
> of DRM drivers, such as Panfrost.
> 
> For virtio-gpu, it could be a tad VIRGIL specific: since other context
> types (gfxstream gles, DRM, vk contexts) decrease memory consumption by
> either not allocating shadow buffers for textures/buffers, or using blob
> memory.
> 
> Maybe we need to design with blob in mind, since we expect virgl to be
> deprecated.  On Android, it basically is with ANGLE and native contexts.
> On Linux, Zink looks good too.  Even with memory issues fixed, virgl is
> unattractive compared to those solutions.

We should finish shmem first since started with it, then move to blobs.

My rough idea for the blobs is to use a timer-based approach to avoid
frequent virtio syncing with host that will be bad for performance
otherwise. Virtio-gpu kernel driver will maintain a list of purgeable
blobs and will send the list of idling blobs down to host after a period
of inactivity.

Virgl may be not interesting for CrOS, but Qemu will continue supporting
it. I also expect that today's ARM Chromebooks which use Virgl and only
support GL will continue to use Virgl for the next 4 years.

> Android specific idea: I wonder if we could tie GEM blob buffers usage to
> the lmkd and kill based on that ... ?
> 
> https://source.android.com/docs/core/perf/lmkd
> 
> Is there GEM buffer accounting infrastructure already?

Are you talking about killing a guest APP that uses host blobs when host
is under pressure? I'm not familiar with how arcvm works, but may assume
that it runs a VM per APP. In that case VM is just another process from
the lmkd perspective that will be taken down on OOM, i.e. blob buffers
already should be seen as a part of a VM's memory by lmkd when they
reside in sysmem.

-- 
Best regards,
Dmitry

