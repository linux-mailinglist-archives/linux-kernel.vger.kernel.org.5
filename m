Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA55F7E762F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjKJBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjKJBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:01:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E903C02
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:01:45 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c115026985so1588268b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699578104; x=1700182904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stZ19W6CJSbCLcY9VmpuxNK8sKYrFkpIrrgdntoQjIs=;
        b=gf4rrhYN++xG1ndnYejDbP+TsdAJt7IxWhl6py8IAor8s4XP4i1cftgYD95w8h+xaq
         6mrvBvHPRpz+poiT0T0UbgEp2dLGYZhkChHVcroENcbWKxTPjlAzRZJ7TEJ+vLpTfm8X
         wq5FmnUWBOUrJK4O1F+hxml3jpZPRjGe8/GmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699578104; x=1700182904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stZ19W6CJSbCLcY9VmpuxNK8sKYrFkpIrrgdntoQjIs=;
        b=jfY2M634obH3WXCoOCnYAZYPMM68vahDZH684FetV7uCxejVpA2vLwQ11VUB6vRHP3
         dJg/mpuXiVxWBiUm8U2qD2jY3j8xzj6Eksgsdrd8oKdwMd/qD5G9F/cmG+uZxYn9v+Mn
         eAc1mDTHxOAMklozhgRKcYRcAZ9AEht9YpGgAjirXjHbf+kEukPdWGRVutpzPg7zpazr
         ihc3DHnAlGaJksTaTVzTDPCsraq5/3vFTHxAWYNWxqlQxbvX33GtFP5HEaHPnLDS4sOk
         xUS+RF7lWZ3PrLMLy/MjZHmJrWATPXZOaE2HTzoNDkDEBNMSbgCHm8Ua/sJkJbYRBfIn
         Ivxw==
X-Gm-Message-State: AOJu0YzsnAGFB/LpPpccfVQ5UTumkZPltF1XtGo9EKsYp5Y49zE07IR5
        Xkw/AkN0WsVQfsnSOiBLfPzLcw==
X-Google-Smtp-Source: AGHT+IEg994sPolTlXgtVmMaxyLSJhNiIosQ5Sy2AaGuC5XZ3trJ7jZHBLbJ4oVxmrGK7yjkIopj4A==
X-Received: by 2002:a05:6a21:18d:b0:17e:2afd:407b with SMTP id le13-20020a056a21018d00b0017e2afd407bmr8802325pzb.9.1699578104522;
        Thu, 09 Nov 2023 17:01:44 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:e584:25c0:d29c:54c])
        by smtp.gmail.com with UTF8SMTPSA id y25-20020a634959000000b0059b2316be86sm5324028pgk.46.2023.11.09.17.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 17:01:44 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
Date:   Thu,  9 Nov 2023 17:01:35 -0800
Message-ID: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is version 9 of the patch series to introduce
block-level provisioning mechanism (original [1]), which is useful for
provisioning space across thinly provisioned storage architectures (loop
devices backed by sparse files, dm-thin devices, virtio-blk). This
series has minimal changes over v8[2], with a couple of patches dropped
(suggested by Dave).

This patch series is rebased from the linux-dm/dm-6.5-provision-support
[3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final 
patch in the series is a blktest (suggested by Dave in 4) which was used
to test out the provisioning flow for loop devices on sparse files on an
ext4 filesystem.

[1] Original: https://lore.kernel.org/lkml/20220915164826.1396245-1-sarthakkukreti@google.com/
[2] v8 (last series): https://lore.kernel.org/lkml/20231007012817.3052558-1-sarthakkukreti@chromium.org/
[3] linux-dm/dm-6.5-provision-suppport tree:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.5-provision-support
(with the last two WIP patches for dm-thinpool dropped as per discussion with
maintainers).
[4] https://lore.kernel.org/lkml/ZSXono3GkXhgrZ1T@dread.disaster.area/

Changes from v8:
- Dropped fallocate() bugfix: merged separately.
- Dropped patch for unshare intent (suggested by Dave).
- More comments in loop device patch to point out the implementation
  constraint and how it affects filesystems with copy-on-write
  semantics.
- Added blktest "loop/010" (rebased on top of ) for testing.

Sarthak Kukreti (4):
  block: Introduce provisioning primitives
  dm: Add block provisioning support
  loop: Add support for provision requests
  loop/010: Add test for mode 0 fallocate on loop devices

 block/blk-core.c              |  5 ++++
 block/blk-lib.c               | 51 +++++++++++++++++++++++++++++++++++
 block/blk-merge.c             | 18 +++++++++++++
 block/blk-settings.c          | 19 +++++++++++++
 block/blk-sysfs.c             |  9 +++++++
 block/bounce.c                |  1 +
 block/fops.c                  |  5 ++++
 drivers/block/loop.c          | 39 ++++++++++++++++++++++++---
 drivers/md/dm-crypt.c         |  4 ++-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-table.c         | 23 ++++++++++++++++
 drivers/md/dm.c               |  7 +++++
 include/linux/bio.h           |  6 +++--
 include/linux/blk_types.h     |  5 +++-
 include/linux/blkdev.h        | 16 +++++++++++
 include/linux/device-mapper.h | 17 ++++++++++++
 16 files changed, 219 insertions(+), 7 deletions(-)

-- 
2.39.2

