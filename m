Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD17EB7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjKNUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjKNUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A95FF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699993488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AMPhiKJAbm8zeR4hjWFuhSxhTnmbxSsETxgcPx+yeuk=;
        b=YM1vd3Asu9A1W2EpkiiJnYki3LIHZ7HpeNfVj2ATQPQbb24MK7EHgXyuBMuVH315pCVYV6
        TYMfVhHUXq05FkWIuFkLCQyr/GMh8H8wAPMqenENqbSjNVLe0QFapNWygLaNwDu+qp74Uh
        8BqYMOiw8yxYgn4vbAdWvhLVdqf1Brs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-EYI3diCvPAmQkOiaL-ICiQ-1; Tue, 14 Nov 2023 15:24:47 -0500
X-MC-Unique: EYI3diCvPAmQkOiaL-ICiQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40a48806258so27802515e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993482; x=1700598282;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMPhiKJAbm8zeR4hjWFuhSxhTnmbxSsETxgcPx+yeuk=;
        b=b0HpnOiRXmWCCD8uLREpMFwtsFNM8FTjy9L/peEtqH16RWhtgGDD44ER+tjawyCH2p
         /wtHDzyBe5BxbLq+0bud4pw6afYmG1cOJxErLrcJHAkrWEwdiPBH+o6nWgaButgN0zCg
         eE1KYPnKZqmDe5eZlhEQQ105lNx1YM7VS9S9Q8JDrSxWlQqNN4DCAM0zyeuex9wUzxU9
         SO9rGoNV88JXRUA5TAZo1ZtmQ/GYzM+oiFcyBTnrKvVIB77I/Fwo0mojFN1H6nRzBTUR
         /NCFvQuRgJqMBxENLpFvwsI+r+IkYcz2F/03wuo02fOM6b/D+ALvrA9GUm8JhpMxG7nK
         IZqA==
X-Gm-Message-State: AOJu0YwftCwmED0em7w8N+XaqUtvm6biSxEZHHvO7fanNgMmpZgnlE89
        3SgIWScJcj4yD782ZNHd+glMqVOzWzWNvwcfGhNWC9geVnhoZBD0EEykrAnA6mJF4R7vRYK4cTS
        U7iZBq5AQUwxkIMf/h4yX9K7o
X-Received: by 2002:a05:600c:3b15:b0:40a:49c1:94d9 with SMTP id m21-20020a05600c3b1500b0040a49c194d9mr8706178wms.27.1699993482661;
        Tue, 14 Nov 2023 12:24:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8mSpIgY64wNwqmPqSR229VYTqr3lkVUkbVTKDvrSUJWsccUbrWwL5VGr9Xp2Iyf3uhHqJvg==
X-Received: by 2002:a05:600c:3b15:b0:40a:49c1:94d9 with SMTP id m21-20020a05600c3b1500b0040a49c194d9mr8706157wms.27.1699993482303;
        Tue, 14 Nov 2023 12:24:42 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:44fb:a682:dfbc:c3ae:7cff])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0040849ce7116sm18662069wmb.43.2023.11.14.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:24:41 -0800 (PST)
Date:   Tue, 14 Nov 2023 15:24:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair.francis@wdc.com, bjorn@rivosinc.com, cleger@rivosinc.com,
        dan.carpenter@linaro.org, eperezma@redhat.com,
        jakub@cloudflare.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com
Subject: [GIT PULL] vhost,virtio,vdpa,firmware: bugfixes
Message-ID: <20231114152436-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 86f6c224c97911b4392cb7b402e6a4ed323a449e:

  vdpa_sim: implement .reset_map support (2023-11-01 09:20:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to e07754e0a1ea2d63fb29574253d1fd7405607343:

  vhost-vdpa: fix use after free in vhost_vdpa_probe() (2023-11-01 09:31:16 -0400)

----------------------------------------------------------------
vhost,virtio,vdpa,firmware: bugfixes

bugfixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Björn Töpel (1):
      riscv, qemu_fw_cfg: Add support for RISC-V architecture

Dan Carpenter (1):
      vhost-vdpa: fix use after free in vhost_vdpa_probe()

Jakub Sitnicki (1):
      virtio_pci: Switch away from deprecated irq_set_affinity_hint

Michael S. Tsirkin (1):
      virtio_pci: move structure to a header

Stefano Garzarella (1):
      vdpa_sim_blk: allocate the buffer zeroed

 drivers/firmware/Kconfig               |  2 +-
 drivers/firmware/qemu_fw_cfg.c         |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c   |  4 ++--
 drivers/vhost/vdpa.c                   |  1 -
 drivers/virtio/virtio_pci_common.c     |  6 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  7 ++++---
 include/linux/virtio_pci_modern.h      |  7 -------
 include/uapi/linux/virtio_pci.h        | 11 +++++++++++
 8 files changed, 22 insertions(+), 18 deletions(-)

