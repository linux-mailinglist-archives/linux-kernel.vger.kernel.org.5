Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2C810EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377146AbjLMKme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjLMKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:42:33 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98051AC;
        Wed, 13 Dec 2023 02:42:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7b701b75f36so262793839f.0;
        Wed, 13 Dec 2023 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702464159; x=1703068959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZRgNeWGWtTYGNKv71Mh1jMa9BIytCfGLi7OUevxvzQ=;
        b=l/tRtV7YnnGIlcsIMsWMd4M3rwMjGIGmgO/9YBWqgqaLqOh7skKoBfYBKxIeA/Io5M
         jokg4zGCdGm5iC60gU0FQ3Hmrk41DC4Mnns+57syOLTFcS9D4Sul5eVhzpwErvQwyqGC
         kW7LBd3XcUgfVGLutu36JxFhhCcYUwEhr4sEj+RA6eMtbqZONN4pPXBDXrrsm3oxcunM
         ND1eBkM7yommF1xGK4j3CJRR1rLP/5GUGTqiz1wUsuaZK0Yz5RbedllzerPyzE8loKDV
         kf5m4SQRwEP6PPFKrSwzRGgcDxwuqVQJVVIMm4JKyfvjW1DX25apQH6GAhzRlcBAoo0W
         5ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464159; x=1703068959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZRgNeWGWtTYGNKv71Mh1jMa9BIytCfGLi7OUevxvzQ=;
        b=QZ5iA9G8GEptrloaPG8t6fwXzMLkuvZi7hCaFm8tJPsmyxNWvIiqHYiN1yCUm0M/dS
         WQAIrVqYbYtoM8LFw+xSm0z8d3QQzjKlbnjtl3Mnt4FePpEYkCnugApZW00/dAUZQ7+h
         7HHASoIWwpdpltCmtta8IVDqnHmhw5RLsmlLUVFGOwlfQCh3DU/q83Ky6pnz/1hT3Wx9
         FUqO8guNPru9zNPdsM9DB2Om5kCKvGr516bQHY3zrlZYNZV6rQkQtoyt+HH+mduPFfAP
         LIqmG2xt5po7EaI5F0Cj8a86GcymuYyTpwxhvv2fgpvN9PqIL68qn8e0cO0o3r6h53rN
         QSLg==
X-Gm-Message-State: AOJu0YzsquBce/DZO0mkxmYRohRTCm2Lo1I8+tO5DDvKXjh7ZuyFeslF
        3tCAc4LRHR2ZzjEJU4jAt7s=
X-Google-Smtp-Source: AGHT+IEWH+PnJ3icKszS+pZricy2BL/GswKpdR64jbTG7pNMSixmN2MzYyNxiFV8F2elcLQA5NAs5A==
X-Received: by 2002:a5e:8e06:0:b0:7b7:51d1:ab82 with SMTP id a6-20020a5e8e06000000b007b751d1ab82mr4380003ion.30.1702464158900;
        Wed, 13 Dec 2023 02:42:38 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c11-20020a6b4e0b000000b0078647b08ab0sm3058186iob.6.2023.12.13.02.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:42:38 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v4 0/5] Fix I/O priority lost in device-mapper
Date:   Wed, 13 Dec 2023 18:42:11 +0800
Message-Id: <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
References: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Jin <hongyu.jin@unisoc.com>

A high-priority task obtains data from the dm-verity device using the
RT IO priority, during the verification, the IO reading FEC and hash
by kworker loses the RT priority and is blocked by the low-priority IO.
dm-crypt has the same problem in the process of writing data.

This is because io_context and blkcg are missing.

Move bio_set_ioprio() into submit_bio():
1. Only call bio_set_ioprio() once to set the priority of original bio,
   the bio that cloned and splited from original bio will auto inherit
   the priority of original bio in clone process.

2. Make the IO priority of the original bio to be passed to dm,
   and the dm target inherits the IO priority as needed.


All changes are based on commit 9bacdd8996c7 ("Merge tag 'for-6.7-rc1-tag'
of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")
on the master branch.


Changes in v5:
  - Rewrite patch 2, add ioprio parameter in dm_io();
  - Modify dm_io() in patch 3 
Changes in v4:
  - Modify commit message by Suggestion
  - Modify patch for dm-crypt
Changes in v3:
  - Split patch for device-mapper
  - Add patch to fix dm-crypy I/O priority question
  - Add block patch to review together
  - Fix some error in v2 patch

Changes in v2:
  - Add ioprio field in struct dm_io_region
  - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
  - Add two interface


Hongyu Jin (5):
  block: Fix bio IO priority setting
  dm: Support I/O priority for dm_io()
  dm-bufio: Support I/O priority
  dm verity: Fix I/O priority lost when read FEC and hash
  dm-crypt: Fix lost ioprio when queuing write bios

 block/blk-core.c                              | 10 +++++
 block/blk-mq.c                                | 11 ------
 drivers/md/dm-bufio.c                         | 39 ++++++++++---------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++--
 drivers/md/dm-integrity.c                     | 12 +++---
 drivers/md/dm-io.c                            | 23 ++++++-----
 drivers/md/dm-kcopyd.c                        |  4 +-
 drivers/md/dm-log.c                           |  4 +-
 drivers/md/dm-raid1.c                         |  6 +--
 drivers/md/dm-snap-persistent.c               |  8 ++--
 drivers/md/dm-verity-fec.c                    |  5 ++-
 drivers/md/dm-verity-target.c                 |  8 +++-
 drivers/md/dm-writecache.c                    |  8 ++--
 drivers/md/persistent-data/dm-block-manager.c |  6 +--
 include/linux/dm-bufio.h                      |  5 +--
 include/linux/dm-io.h                         |  3 +-
 17 files changed, 85 insertions(+), 76 deletions(-)

-- 
2.34.1

