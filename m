Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69F579BB20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbjIKUzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjIKJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:26:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A95CD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:25:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fc49ccbf2so175168b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694424355; x=1695029155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVX9WeWGptEOVbuDunuTR7x+0VEpx5JzgLCEo/pvZQ8=;
        b=DbOajRgy2xFmheWiYFJNiF/VqFWhMN7MqRf1KIZ/fq6Bs63joSkDy1w3+5EvoBQV28
         yGKKd4Iz+CS2aFASp+sR9WS7RBZb2YXCzIvyFiFhI711CORejhkt7/lsD9FkZ6v5rlDF
         5r5nbSVGp8nhXVcii06hLJqTdphitOJg5pyHMtNSvteWcTfXQv6E+YO24oXzlMs3LkRY
         Z4ZayDdRe1KGQ5wD+LADkzCR2ikO2nvW5/Cbn9MHDJ0o8Smu9BDAk/q2vdON1YmnKMZp
         F+kaH/lHExQy1jGBPgC2OVX73tuHvdULyq7oNaZk0o/Cf2+P03iVOJsh0QFA/tJs8AgI
         fONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424355; x=1695029155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVX9WeWGptEOVbuDunuTR7x+0VEpx5JzgLCEo/pvZQ8=;
        b=v3MbaasQ90jVBPd/CuyS4X7ehqcYifi1xe2GcVPQXYAisYHLTlzx/0yDHM1U3SEru/
         38E7l2wZ0xIBdMkib8KLPXFDdL4W+cmCQrseaqTOjfjkrx4FZpm9PY+dLRrOcckXyzsc
         6Z3fZBU6nMaAY4rhhgUJLki0VAz4Wi0np1v6QeYBpvXxqEIoDA5WuTnKwG+lWXIaWvJH
         fyyQgRi0XBWujh1fr+RdUP3ocI+OUxh2U0lYYBJkKZ3YoAdKXSVUV4SIBQB0i427Hipl
         OcjAA+dVsqNNcp5QTVnbL8+pYY1vavBMOZLq4HjTgjgMKeBCAwCLwOuJAGaP1X4tIIPF
         uPjQ==
X-Gm-Message-State: AOJu0Yxfmg1jpItyEJxS8UAml1CoeshMeVg9U7Qb6a3UiOb3FiE5RO+j
        hF7fMJjbqTTwXCd49crxG91c5Q==
X-Google-Smtp-Source: AGHT+IFA8N2LVaGnVCnfvNYWcDqv3xveqW6PwXfspm7irjG2TpwEtxpwFLm2nXmkPtV/jExbnj34Wg==
X-Received: by 2002:a05:6a20:5498:b0:145:3bd9:1377 with SMTP id i24-20020a056a20549800b001453bd91377mr11799129pzk.5.1694424355065;
        Mon, 11 Sep 2023 02:25:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001b89466a5f4sm5964623pll.105.2023.09.11.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:25:54 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 0/4] cleanups for lockless slab shrink
Date:   Mon, 11 Sep 2023 17:25:13 +0800
Message-Id: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is some cleanups for lockless slab shrink, I dropped the
[PATCH v2 5/5] which is more related to the main lockless patch.

This series is based on the v6.6-rc1.

Comments and suggestions are welcome.

Thanks,
Qi

Changlog in v3 -> v4:
 - rebase onto the v6.6-rc1

Changlog in part 1 v2 -> part 1 v3:
 - drop [PATCH v2 5/5]
 - collect Acked-by
 - rebase onto the next-20230823

Changlog in part 1 v1 -> part 1 v2:
 - fix compilation warning in [PATCH 1/5]
 - rename synchronize_shrinkers() to ttm_pool_synchronize_shrinkers()
   (pointed by Christian König)
 - collect Reviewed-by

Changlog in v4 -> part 1 v1:
 - split from the previous large patchset
 - fix comment format in [PATCH v4 01/48] (pointed by Muchun Song)
 - change to use kzalloc_node() and fix typo in [PATCH v4 44/48]
   (pointed by Dave Chinner)
 - collect Reviewed-bys
 - rebase onto the next-20230815

Qi Zheng (4):
  mm: move some shrinker-related function declarations to mm/internal.h
  mm: vmscan: move shrinker-related code into a separate file
  mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
  drm/ttm: introduce pool_shrink_rwsem

 drivers/gpu/drm/ttm/ttm_pool.c |  17 +-
 include/linux/shrinker.h       |  20 -
 mm/Makefile                    |   4 +-
 mm/internal.h                  |  28 ++
 mm/shrinker.c                  | 694 ++++++++++++++++++++++++++++++++
 mm/shrinker_debug.c            |  18 +-
 mm/vmscan.c                    | 701 ---------------------------------
 7 files changed, 743 insertions(+), 739 deletions(-)
 create mode 100644 mm/shrinker.c

-- 
2.30.2

