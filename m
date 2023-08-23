Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62A47862D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbjHWV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbjHWV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:56:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6CEE59;
        Wed, 23 Aug 2023 14:56:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68bec4c6b22so286932b3a.2;
        Wed, 23 Aug 2023 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692827768; x=1693432568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdlec6OkejfhXyJVQ4nqDZbY7wcrBeVjlgnKnIanHMs=;
        b=kTrSNZkIv3S6HbAZmwUpDq7mTW1gjmThol4blUtqcsMvzPx0S/pJ7soK/oGl92KvpY
         4X33Ws9xLe38VOupkqRWlWuEwdsLR9Dky7xF5eRyKy1qBC2G9H9JiodmWPrhY0yQpBIS
         XOaw8+ecfPdj/Kv4ZDrcPwuR3GI0e2avV5PG6h1ulR5xHi1df85LaxVouQUD34mKVEwL
         xGbNp9gh1+nMiuyIRV2QcveoPn217J2c6QhkjguHASMZW9XYQXEw/Zf9C1Sdm4B+wwu4
         /QFs6azeoTmS+7ABoTs8p+HTad9XeWKQCyM5BYwf3syPHBaFEcPsQ7ABg8J4MCkiJoNC
         PPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827768; x=1693432568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vdlec6OkejfhXyJVQ4nqDZbY7wcrBeVjlgnKnIanHMs=;
        b=S7La28I92cmsQcVI9GOjLAGAnoVG7rdQkbdyThiaGIEoSmfJw4gmuCT/HOaMA1HgQu
         5d2i/EuTybowoK16IUTfstq8RGOBcOFyvD8PVH3gOhZ7lmRzj48ar/D8SiSVAfDZ2Uic
         uHiEibexN6bI0wNzmeOeVTVHdcP6AvhmNIYM1P0pXQiqiOCl2K87AzG8QRlf0j5ZthUH
         PmesJHfPEDRwBaopBSJ8qzShS1XPg46IbxWiRntz/F9otMOC8/2OdL5G3jkGnl9VyoI1
         wSCB7Ce9wsJK2/F9UFgs6nF5VHTZfwlXS5uF3OfWCBb7VWDZnSaLeZ7BvqityacTiBRf
         3Lvg==
X-Gm-Message-State: AOJu0YxU35ezxofrWu7VwLJmUCRyM53sH373z9B+zSMS/d1JGR0YZzMo
        rZYkLzjj48ipHzGeiVu9UdB7CYcQSiw=
X-Google-Smtp-Source: AGHT+IEkOWgvIsdyH4PYVN5etCF6RxN2hmwSfnLjmmcb5cZA9Oqzmyj1dnnsM/qqF7ZbaX1M8jzYgQ==
X-Received: by 2002:a05:6a20:7da9:b0:133:5f6a:fb6 with SMTP id v41-20020a056a207da900b001335f6a0fb6mr17085737pzj.1.1692827767845;
        Wed, 23 Aug 2023 14:56:07 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id a21-20020aa780d5000000b00689f10adef9sm9968803pfn.67.2023.08.23.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:56:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Xaver Hugl <xaver.hugl@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v9 0/3] dma-fence: Deadline awareness (uabi edition)
Date:   Wed, 23 Aug 2023 14:54:53 -0700
Message-ID: <20230823215458.203366-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This is a re-post of the remaining patches from:
https://patchwork.freedesktop.org/series/114490/

Part of the hold-up of the remaining uabi patches was compositor
support, but now an MR for kwin exists:

  https://invent.kde.org/plasma/kwin/-/merge_requests/4358

The syncobj userspace is:

  https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21973

v1: https://patchwork.freedesktop.org/series/93035/
v2: Move filtering out of later deadlines to fence implementation
    to avoid increasing the size of dma_fence
v3: Add support in fence-array and fence-chain; Add some uabi to
    support igt tests and userspace compositors.
v4: Rebase, address various comments, and add syncobj deadline
    support, and sync_file EPOLLPRI based on experience with perf/
    freq issues with clvk compute workloads on i915 (anv)
v5: Clarify that this is a hint as opposed to a more hard deadline
    guarantee, switch to using u64 ns values in UABI (still absolute
    CLOCK_MONOTONIC values), drop syncobj related cap and driver
    feature flag in favor of allowing count_handles==0 for probing
    kernel support.
v6: Re-work vblank helper to calculate time of _start_ of vblank,
    and work correctly if the last vblank event was more than a
    frame ago.  Add (mostly unrelated) drm/msm patch which also
    uses the vblank helper.  Use dma_fence_chain_contained().  More
    verbose syncobj UABI comments.  Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.
v7: Fix kbuild complaints about vblank helper.  Add more docs.
v8: Add patch to surface sync_file UAPI, and more docs updates.
v9: Repost the remaining patches that expose new uabi to userspace.

Rob Clark (3):
  drm/syncobj: Add deadline support for syncobj waits
  dma-buf/sync_file: Add SET_DEADLINE ioctl
  dma-buf/sw_sync: Add fence deadline support

 drivers/dma-buf/dma-fence.c    |  3 +-
 drivers/dma-buf/sw_sync.c      | 82 ++++++++++++++++++++++++++++++++++
 drivers/dma-buf/sync_debug.h   |  2 +
 drivers/dma-buf/sync_file.c    | 19 ++++++++
 drivers/gpu/drm/drm_syncobj.c  | 64 ++++++++++++++++++++------
 include/uapi/drm/drm.h         | 17 +++++++
 include/uapi/linux/sync_file.h | 22 +++++++++
 7 files changed, 195 insertions(+), 14 deletions(-)

-- 
2.41.0

