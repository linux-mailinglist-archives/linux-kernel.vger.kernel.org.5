Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278617BC9A8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbjJGTtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 15:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbjJGTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 15:49:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DDBA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 12:49:44 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7400F66072BB;
        Sat,  7 Oct 2023 20:49:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696708182;
        bh=jxn4oc/yI6t62r9mg5ChscM72pMr3cCvBu3CCP7Cs/g=;
        h=From:To:Cc:Subject:Date:From;
        b=liqlmvSZT4yO6UtBzTcdCt/d6abZsK75MrkAEpI+A9MbqIPxv5WBFmvQh7Cbms9Ip
         TYs9H636XezCKy0ebIHYapixbk57d02cwRdRKyDEY0zl6XwOhKAvGs5sbaFWvDSBnQ
         xSLtyBxKlgVoq0t/Z7hB/o3fUOy840AngfP3X+ZNL1daTAfcVwcv5Sx+kyXOOaQo8f
         8QZRE517bHDxxejGN/p7h3P18xybpXr+LPLwW/UBi9uXyFKSLw77G3Zd0i/2BPfTi4
         bWRZ+KQQ9xKsWvgF7LF9PsTP2FYoRlp1FHlCvLVS4ij58LEKoNELAXP3eBbxFZuVcW
         f08VvYRj2I8iA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v1 0/1]  Support passing VirtIO-GPU fences to host for waiting
Date:   Sat,  7 Oct 2023 22:47:46 +0300
Message-ID: <20231007194747.788934-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today's VirtIO-GPU driver always has to wait for in-fences on the guest
side, creating bottleneck for workloads that produce lots of job submissions
or require lower submission latency. This bottleneck is caused by a need
to do extra round trips between host and guest for the fence signalling.

The solution is to move fence signalling and waiting entierly to the host
side, where it can be done more efficiently, without holding the guest side.
The proposed patch introduces new "fence passing" VirtIO-GPU protocol
feature, which extends VIRTIO_GPU_CMD_SUBMIT_3D with array of in-fence IDs
that are passed from guest to host along with the 3D commands. Host then
takes the in-fence IDs and passes them to virglrender, where the fence IDs
are resolved into sync file fences and handled (waited) by a corresponding
virglrender context.

The patch is RFC because we want to do more testing with crosvm and
CrOS first, support fence-passing for Venus and virtio-wl. The new
virglrender experimental fence-passing API already has been merged [1]
and crosvm support began to pick it up [2]. Qemu patch is available at [3].

Fence passing was tested using WIP amdgpu and intel native contexts,
where it proved to be useful by increasing FPS up to 3x times.

[1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1138
[2] https://chromium-review.googlesource.com/c/crosvm/crosvm/+/4679609
[3] https://gitlab.freedesktop.org/digetx/qemu/-/commits/native-context-iris

Dmitry Osipenko (1):
  drm/virtio: Support fence-passing feature

 drivers/gpu/drm/virtio/virtgpu_drv.c    |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h    | 11 ++-
 drivers/gpu/drm/virtio/virtgpu_fence.c  | 15 +++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 11 ++-
 drivers/gpu/drm/virtio/virtgpu_kms.c    |  8 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c | 99 ++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  7 +-
 include/uapi/drm/virtgpu_drm.h          |  3 +
 include/uapi/linux/virtio_gpu.h         | 11 ++-
 9 files changed, 152 insertions(+), 14 deletions(-)

-- 
2.41.0

