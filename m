Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4A7DD593
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376544AbjJaRyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347017AbjJaRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95FF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6i1b+NqFN3idrUVla2WD0jWUDHt8ESgZlQ4YQJ+PSW0=;
        b=jT4ujSKsGJrfmeh4Wu+BU0phHRThuxFQCxeHQ10nppQIeaobrdR05q44lC3aOiGPbEOHsW
        B5Qk9XGCHlQ7OfUI5B9WWBPSGCMSdqRPDlPNBP4InQglznxySw6hQhY6Zzpomy6CCq+hT3
        AJQJ/fS/mtoBrjW1HhKGAEHW6RsN1V4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-IEEY26DBMV2KryHaovPTFg-1; Tue, 31 Oct 2023 13:54:02 -0400
X-MC-Unique: IEEY26DBMV2KryHaovPTFg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-786d9d4d9a6so519965439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774842; x=1699379642;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i1b+NqFN3idrUVla2WD0jWUDHt8ESgZlQ4YQJ+PSW0=;
        b=XeQw4A6ytvi8bsY9hYxCaVMVUZcoXiLbbVZ0JDs9ATIuj8M+4UePyQn/WNhNXvQHUJ
         qDv1FK6AaaCkaAy6KS0vpBG33pvP1ahfJu1QpSJXjOB3ZiHLTkdWdC4U9xjEQ7UOFduo
         Yk47FTBEwCiWu9QR0765xGwkQbr9AljyhqPoseWQ3T6+1DSFmkQaePDPuxZK0hs71ItD
         MJlRIqXDxK2ff56lZMob243kWlLiHlYxP8PTDLnRPcnY1aCiUwVe+JhFgY38p//+CGGb
         0LrSPzdjbCyf1YVV8dQOwNjy+SP7OcYEy084B8hhNR2lVFiX70AmiX22I1QFgjWwWh9z
         58SA==
X-Gm-Message-State: AOJu0Yzv6MVTou6xHdQKjb1TrXhabOLlDS0E47705dDb+WWBa83/bTfG
        uLNDtGUdf1QHso8EpQJlWmlO0pH4D1iDRCT4VCyIvsL3PGyLwdOrhLSgqEycbeRpZ/wUPLQN9jJ
        vYZVh6SqHtntiwrHFMN9sE10Q
X-Received: by 2002:a05:6e02:1e02:b0:357:478f:a744 with SMTP id g2-20020a056e021e0200b00357478fa744mr20841439ila.10.1698774842196;
        Tue, 31 Oct 2023 10:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqNLrmD1DbceRc+jSWlRoG0eBcGRRttHnkk7FnwUxTiUjDcMRPRNnHFhMkT7x6yE6JJxJLMA==
X-Received: by 2002:a05:6e02:1e02:b0:357:478f:a744 with SMTP id g2-20020a056e021e0200b00357478fa744mr20841429ila.10.1698774841988;
        Tue, 31 Oct 2023 10:54:01 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id fn25-20020a056638641900b0042b3bb542aesm458221jab.168.2023.10.31.10.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:54:01 -0700 (PDT)
Date:   Tue, 31 Oct 2023 11:54:00 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v6.7-rc1
Message-ID: <20231031115400.570e00d1.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit b6cd17050bc0817c79924f23716198b2e935556e:

  Merge tag 'vfio-v6.6-rc4' of https://github.com/awilliam/linux-vfio (2023-09-27 09:33:55 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.7-rc1

for you to fetch changes up to 2b88119e35b00d8cb418d86abbace3b90a993bd7:

  vfio/mtty: Enable migration support (2023-10-24 15:03:10 -0600)

----------------------------------------------------------------
VFIO updates for v6.7

 - Add support for "chunk mode" in the mlx5-vfio-pci variant driver,
   which allows both larger device image sizes for migration, beyond
   the previous 4GB limit, and also read-ahead support for improved
   migration performance. (Yishai Hadas)

 - A new bus master control interface for the CDX bus driver where
   there is no in-band mechanism to toggle device DMA as there is
   through config space on PCI devices. (Nipun Gupta)

 - Add explicit alignment directives to vfio data structures to
   reduce the chance of breaking 32-bit userspace.  In most cases
   this is transparent and the remaining cases where data structures
   are padded work within the existing rules for extending data
   structures within vfio.  (Stefan Hajnoczi)

 - Resolve a bug in the cdx bus driver noted when compiled with clang
   where missing parenthesis result in the wrong operation.
   (Nathan Chancellor)

 - Resolve errors reported by smatch for a function when dealing
   with invalid inputs. (Alex Williamson)

 - Add migration support to the mtty vfio/mdev sample driver for
   testing and integration purposes, allowing CI of migration without
   specific hardware requirements.  Also resolve many of the short-
   comings of this driver relative to implementation of the vfio
   interrupt ioctl along the way. (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (4):
      Merge branch 'mlx5-vfio' of https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux into v6.7/vfio/next
      vfio: Fix smatch errors in vfio_combine_iova_ranges()
      vfio/mtty: Overhaul mtty interrupt handling
      vfio/mtty: Enable migration support

Nathan Chancellor (1):
      vfio/cdx: Add parentheses between bitwise AND expression and logical NOT

Nipun Gupta (3):
      cdx: add support for bus mastering
      vfio: add bus master feature to device feature ioctl
      vfio-cdx: add bus mastering device feature support

Stefan Hajnoczi (3):
      vfio: trivially use __aligned_u64 for ioctl structs
      vfio: use __aligned_u64 in struct vfio_device_gfx_plane_info
      vfio: use __aligned_u64 in struct vfio_device_ioeventfd

Yishai Hadas (9):
      net/mlx5: Introduce ifc bits for migration in a chunk mode
      vfio/mlx5: Wake up the reader post of disabling the SAVING migration file
      vfio/mlx5: Refactor the SAVE callback to activate a work only upon an error
      vfio/mlx5: Enable querying state size which is > 4GB
      vfio/mlx5: Rename some stuff to match chunk mode
      vfio/mlx5: Pre-allocate chunks for the STOP_COPY phase
      vfio/mlx5: Add support for SAVING in chunk mode
      vfio/mlx5: Add support for READING in chunk mode
      vfio/mlx5: Activate the chunk mode functionality

 drivers/cdx/cdx.c                       |  32 ++
 drivers/cdx/controller/cdx_controller.c |   4 +
 drivers/cdx/controller/mcdi_functions.c |  58 +++
 drivers/cdx/controller/mcdi_functions.h |  13 +
 drivers/gpu/drm/i915/gvt/kvmgt.c        |   2 +-
 drivers/vfio/cdx/main.c                 |  57 ++-
 drivers/vfio/cdx/private.h              |   2 +
 drivers/vfio/pci/mlx5/cmd.c             | 103 ++--
 drivers/vfio/pci/mlx5/cmd.h             |  28 +-
 drivers/vfio/pci/mlx5/main.c            | 283 ++++++++---
 drivers/vfio/vfio_main.c                |  10 +
 include/linux/cdx/cdx_bus.h             |  18 +
 include/linux/mlx5/mlx5_ifc.h           |  15 +-
 include/uapi/linux/vfio.h               |  47 +-
 samples/vfio-mdev/mbochs.c              |   2 +-
 samples/vfio-mdev/mdpy.c                |   2 +-
 samples/vfio-mdev/mtty.c                | 829 +++++++++++++++++++++++++++++---
 17 files changed, 1309 insertions(+), 196 deletions(-)

