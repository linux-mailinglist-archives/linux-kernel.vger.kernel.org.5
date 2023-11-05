Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083BC7E142E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjKEP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC9C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699199899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gm8P+4qqkq3fie/1BXBTuSMj+CMA8LATFFDY5rV8ORw=;
        b=DYaYg2Hl89c9uQQF2Pumf8LLtozKK9szOQX4jBDTAgFzv/rw3Fw9OET6yDLUVDuspE+Vtb
        FhPXJmrklZfWxXWbtniTPhFCUBk7oDX45910FuTFbxnSZJOf2GoO761aRpFSVeaVHZcGx1
        0gFFUEhRmX7qhYhZxudA9EiBLHcVoBE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-Pa1qcJw4O4eCELURS1EO3Q-1; Sun, 05 Nov 2023 10:58:18 -0500
X-MC-Unique: Pa1qcJw4O4eCELURS1EO3Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53da5262466so3045592a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 07:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699199897; x=1699804697;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm8P+4qqkq3fie/1BXBTuSMj+CMA8LATFFDY5rV8ORw=;
        b=mcX0FLnNS6r09zkATKxFnFnczqbeWSDKu60n1QT4NUKcWDsndi9OrAIW9EDDrO2t3C
         w2LT0JC6fNsRiRVuXZDyiXxDtbd4OfoeDCNFWdBDzOTA1Gk3t3UTfabZymr1NpI83Koe
         tkS64jyufnVs1HqBIcmcxj5lEofWz8zA+oKI2ClJAK4oZcv6yzZAee0pPu8I2FZTF9CF
         Zx/txDu5jPh/EaYLMFsXcqfwSWIbm76Fiay+VRuVAlIeEuEqz77Kc4adNT9hCO3Awg4K
         EH03bZj2QWXNzOmD8sWEKnW5qk4mEVsibHqBF/ZrMFLuz8mpfuCrdple4I7tt6WiiEC+
         vs9Q==
X-Gm-Message-State: AOJu0YxEU+Fqip5mkRYK/yaBtwnGVdyxDLmDFcKYtL67RoG/EpzRUmjE
        cBInWUIK+zJAK0JBJJTkJCHP7czM5WZjyllnOp13WmcWKOtc9CeWjvBc7HnLu2vz98ZPmp+8zZb
        SdC02vj/PGVqi+r345dBSOOzG
X-Received: by 2002:a17:906:db08:b0:9dd:f5ba:856d with SMTP id xj8-20020a170906db0800b009ddf5ba856dmr3819995ejb.62.1699199897433;
        Sun, 05 Nov 2023 07:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEybgJfekAZesQ+akyhDcdHp9NNqn1nBxIeCP8wqicCb5vXKmYeJbRaNub+H3s331kYxYmE9A==
X-Received: by 2002:a17:906:db08:b0:9dd:f5ba:856d with SMTP id xj8-20020a170906db0800b009ddf5ba856dmr3819966ejb.62.1699199896993;
        Sun, 05 Nov 2023 07:58:16 -0800 (PST)
Received: from redhat.com ([2.55.35.234])
        by smtp.gmail.com with ESMTPSA id qw23-20020a1709066a1700b009dd949b75c7sm2460591ejc.151.2023.11.05.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 07:58:16 -0800 (PST)
Date:   Sun, 5 Nov 2023 10:58:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dtatulea@nvidia.com, eperezma@redhat.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, jasowang@redhat.com,
        leiyang@redhat.com, leon@kernel.org, mst@redhat.com,
        pizhenwei@bytedance.com, sgarzare@redhat.com,
        shannon.nelson@amd.com, shawn.shao@jaguarmicro.com,
        simon.horman@corigine.com, si-wei.liu@oracle.com,
        xieyongji@bytedance.com, xuanzhuo@linux.alibaba.com,
        xueshi.hu@smartx.com
Subject: [GIT PULL] vhost,virtio,vdpa: features, fixes, cleanups
Message-ID: <20231105105806-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 86f6c224c97911b4392cb7b402e6a4ed323a449e:

  vdpa_sim: implement .reset_map support (2023-11-01 09:20:00 -0400)

----------------------------------------------------------------
vhost,virtio,vdpa: features, fixes, cleanups

vdpa/mlx5:
	VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
	new maintainer
vdpa:
	support for vq descriptor mappings
	decouple reset of iotlb mapping from device reset

fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dragos Tatulea (14):
      vdpa/mlx5: Expose descriptor group mkey hw capability
      vdpa/mlx5: Create helper function for dma mappings
      vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
      vdpa/mlx5: Take cvq iotlb lock during refresh
      vdpa/mlx5: Collapse "dvq" mr add/delete functions
      vdpa/mlx5: Rename mr destroy functions
      vdpa/mlx5: Allow creation/deletion of any given mr struct
      vdpa/mlx5: Move mr mutex out of mr struct
      vdpa/mlx5: Improve mr update flow
      vdpa/mlx5: Introduce mr for vq descriptor
      vdpa/mlx5: Enable hw support for vq descriptor mapping
      vdpa/mlx5: Make iotlb helper functions more generic
      vdpa/mlx5: Update cvq iotlb mapping on ASID change
      MAINTAINERS: Add myself as mlx5_vdpa driver

Eugenio Pérez (1):
      mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK

Geert Uytterhoeven (1):
      vhost-scsi: Spelling s/preceeding/preceding/g

Greg Kroah-Hartman (1):
      vduse: make vduse_class constant

Michael S. Tsirkin (1):
      Merge branch 'mlx5-vhost' of https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git

Shannon Nelson (1):
      virtio: kdoc for struct virtio_pci_modern_device

Shawn.Shao (1):
      vdpa: Update sysfs ABI documentation

Si-Wei Liu (10):
      vdpa: introduce dedicated descriptor group for virtqueue
      vhost-vdpa: introduce descriptor group backend feature
      vhost-vdpa: uAPI to get dedicated descriptor group id
      vdpa: introduce .reset_map operation callback
      vhost-vdpa: reset vendor specific mapping to initial state in .release
      vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
      vdpa: introduce .compat_reset operation callback
      vhost-vdpa: clean iotlb map during reset for older userspace
      vdpa/mlx5: implement .reset_map driver op
      vdpa_sim: implement .reset_map support

Xuan Zhuo (3):
      virtio: add definition of VIRTIO_F_NOTIF_CONFIG_DATA feature bit
      virtio_pci: add build offset check for the new common cfg items
      virtio_pci: add check for common cfg size

Xueshi Hu (1):
      virtio-balloon: correct the comment of virtballoon_migratepage()

zhenwei pi (1):
      virtio-blk: fix implicit overflow on virtio_max_dma_size

 Documentation/ABI/testing/sysfs-bus-vdpa |   4 +-
 MAINTAINERS                              |   6 +
 drivers/block/virtio_blk.c               |   4 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h       |  32 +++--
 drivers/vdpa/mlx5/core/mr.c              | 213 +++++++++++++++++++------------
 drivers/vdpa/mlx5/core/resources.c       |   6 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c        | 137 +++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  52 ++++++--
 drivers/vdpa/vdpa_user/vduse_dev.c       |  40 +++---
 drivers/vhost/scsi.c                     |   2 +-
 drivers/vhost/vdpa.c                     |  79 +++++++++++-
 drivers/virtio/virtio_balloon.c          |   2 +-
 drivers/virtio/virtio_pci_modern.c       |  36 ++++++
 drivers/virtio/virtio_pci_modern_dev.c   |   6 +-
 drivers/virtio/virtio_vdpa.c             |   2 +-
 include/linux/mlx5/mlx5_ifc.h            |   8 +-
 include/linux/mlx5/mlx5_ifc_vdpa.h       |   7 +-
 include/linux/vdpa.h                     |  41 +++++-
 include/linux/virtio_pci_modern.h        |  35 +++--
 include/uapi/linux/vhost.h               |   8 ++
 include/uapi/linux/vhost_types.h         |   7 +
 include/uapi/linux/virtio_config.h       |   5 +
 22 files changed, 546 insertions(+), 186 deletions(-)

