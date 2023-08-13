Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7930377AED3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHMXJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 19:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHMXJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 19:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBD1E9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691968094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AUa1QX/mJ1ef9VxwUsegnOGKLjQxThmW1L4mbjRAl5o=;
        b=gAYdFQ/TBCNWCbrOzuFmK2+Vz4ns4QeDYNYSoIHdEwWzBOUq9I1ppLu/Z3O6oLAPjrto7B
        oHPUhRcWo4mL6witR4/r+lAwnuI8zK51jSqK8Stw9KfPN1Rjzej6wJU39mdveEHbMk8jOK
        IU4moGJmi2AdtzCng0wkUDhNr+AQj0A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-A3HtWlPLN6qbJic5X7Uteg-1; Sun, 13 Aug 2023 19:08:12 -0400
X-MC-Unique: A3HtWlPLN6qbJic5X7Uteg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9b820c94fso36457601fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 16:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691968091; x=1692572891;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUa1QX/mJ1ef9VxwUsegnOGKLjQxThmW1L4mbjRAl5o=;
        b=RhEr9BtWMnqQteYx1vcY9Tj1pNqHcmTHuL8hmJvOozbhtQLhtr2BOZfYt2E4bINwVf
         PC72OU3Cf0myP5v1f06yfM74lMh4OYu1sUxsDUlVbDEXaajHy6xXOARrvZpsnYge3gWt
         +IzRpGXTgT7Tjd764Xrw57JOEvX/f+4jtfkVlUJHy/R7GCGmRH/VLuBpA6wIMymmRs+e
         cVQXyt7HPcoJdJgoz2iy796Wu+BdCMuGLzq6utVzadiRtgLCw9PbmDBepBGCtD/dCoeu
         sCnS6yR0c2CclWQL2yHp/ltH3yWVpfc80JSBWyrTkU0sumkK72Ijnx/naDoPOQFi7ckt
         Gq6Q==
X-Gm-Message-State: AOJu0YykKsElkbhO+ZCZFBoHKhd9zCh08htOdXeotQCvcjMnh4ItiPAH
        j9OohZiI55LH18nuFpVVAvvWMfIU8FznaOSlfKv48O/vR9JbazTt5kjEGVgWwLyTAmbyhHOTIVx
        0Ys9bSzCW1QaJNuOZvZDypdT0
X-Received: by 2002:a2e:8503:0:b0:2b7:1005:931b with SMTP id j3-20020a2e8503000000b002b71005931bmr5573395lji.0.1691968090804;
        Sun, 13 Aug 2023 16:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfB6KQC44UtzTvTIQLTU6WSArsFvqwFM/tL9oeOdLXdw+TuyKztZH0mu5DyTnZ3c9/bKtQHw==
X-Received: by 2002:a2e:8503:0:b0:2b7:1005:931b with SMTP id j3-20020a2e8503000000b002b71005931bmr5573379lji.0.1691968090444;
        Sun, 13 Aug 2023 16:08:10 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id jo19-20020a170906f6d300b0099bcd1fa5b0sm5002759ejb.192.2023.08.13.16.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 16:08:09 -0700 (PDT)
Date:   Sun, 13 Aug 2023 19:08:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        allen.hubbe@amd.com, andrew@daynix.com, david@redhat.com,
        dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com,
        gal@nvidia.com, jasowang@redhat.com, leiyang@redhat.com,
        linma@zju.edu.cn, maxime.coquelin@redhat.com,
        michael.christie@oracle.com, mst@redhat.com, rdunlap@infradead.org,
        sgarzare@redhat.com, shannon.nelson@amd.com,
        stable@vger.kernel.org, stable@vger.kernelorg, stefanha@redhat.com,
        wsa+renesas@sang-engineering.com, xieyongji@bytedance.com,
        yin31149@gmail.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20230813190803-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All small, fairly safe changes.

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to f55484fd7be923b740e8e1fc304070ba53675cb4:

  virtio-mem: check if the config changed before fake offlining memory (2023-08-10 15:51:46 -0400)

----------------------------------------------------------------
virtio: bugfixes

just a bunch of bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Allen Hubbe (2):
      pds_vdpa: reset to vdpa specified mac
      pds_vdpa: alloc irq vectors on DRIVER_OK

David Hildenbrand (4):
      virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
      virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
      virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub Block Mode (SBM)
      virtio-mem: check if the config changed before fake offlining memory

Dragos Tatulea (4):
      vdpa: Enable strict validation for netlinks ops
      vdpa/mlx5: Correct default number of queues when MQ is on
      vdpa/mlx5: Fix mr->initialized semantics
      vdpa/mlx5: Fix crash on shutdown for when no ndev exists

Eugenio Pérez (1):
      vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary

Feng Liu (1):
      virtio-pci: Fix legacy device flag setting error in probe

Gal Pressman (1):
      virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()

Hawkins Jiawei (1):
      virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case

Lin Ma (3):
      vdpa: Add features attr to vdpa_nl_policy for nlattr length check
      vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
      vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check

Maxime Coquelin (1):
      vduse: Use proper spinlock for IRQ injection

Mike Christie (3):
      vhost-scsi: Fix alignment handling with windows
      vhost-scsi: Rename vhost_scsi_iov_to_sgl
      MAINTAINERS: add vhost-scsi entry and myself as a co-maintainer

Shannon Nelson (4):
      pds_vdpa: protect Makefile from unconfigured debugfs
      pds_vdpa: always allow offering VIRTIO_NET_F_MAC
      pds_vdpa: clean and reset vqs entries
      pds_vdpa: fix up debugfs feature bit printing

Wolfram Sang (1):
      virtio-mmio: don't break lifecycle of vm_dev

 MAINTAINERS                        |  11 ++-
 drivers/net/virtio_net.c           |   2 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/core/mr.c        | 105 +++++++++++++++------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  26 +++---
 drivers/vdpa/pds/Makefile          |   3 +-
 drivers/vdpa/pds/debugfs.c         |  15 ++-
 drivers/vdpa/pds/vdpa_dev.c        | 176 ++++++++++++++++++++++++----------
 drivers/vdpa/pds/vdpa_dev.h        |   5 +-
 drivers/vdpa/vdpa.c                |   9 +-
 drivers/vdpa/vdpa_user/vduse_dev.c |   8 +-
 drivers/vhost/scsi.c               | 187 ++++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_mem.c        | 168 ++++++++++++++++++++++-----------
 drivers/virtio/virtio_mmio.c       |   5 +-
 drivers/virtio/virtio_pci_common.c |   2 -
 drivers/virtio/virtio_pci_legacy.c |   1 +
 drivers/virtio/virtio_vdpa.c       |   2 +
 17 files changed, 519 insertions(+), 208 deletions(-)

