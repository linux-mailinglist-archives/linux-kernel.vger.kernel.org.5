Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3509C7B179D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjI1Jjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjI1JjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01593CD9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:38:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-323168869daso9890724f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893938; x=1696498738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DgaQdL1mkt6AjgMQAIJbcwnwZB2QgHQP1PAcp2gZrY=;
        b=Al2ZTuBpmCd0Jaq48qpIzRb37H2hz0AxyMzIATjaa8+jqb2oxsi+JfGdSTPsLE4BTJ
         e1kDXgjQXCPS9WzHBu2d33MkbqBZTtp2Gmp52lOGPk9tCfd3mUsguqZXBlwqI5MIvdca
         FATkG1y2lixypu+HHlzF07oFOOqy/ObrZKeF/L0BuHMYf0dwQr62gpCeDFp927LrSQsE
         7vLIn8yKBkWztoiUV2Ccj7qNYCnwvjkAPGViTFw9opuhujcE5flwmZg9Znp5p2utFO6P
         2wnAKLOdSgK4uph2NHtwb3ZixYUT/dt11oJkiyPsxMRUz77UWH/ykTzP34jAif81q/FB
         EfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893938; x=1696498738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DgaQdL1mkt6AjgMQAIJbcwnwZB2QgHQP1PAcp2gZrY=;
        b=CfvZYqWzpxUGb94keHdHhu59EiObMRZ73CiGzs9VES4jX2fWJELZ6pc3BcuBOnsvyM
         icsREF4ENho9InuQCnNxu6/7aSuBWQ+Upvg48Sdh/bUcEY2V8rfuEXZ6PSSx/EM+/tqt
         DraKmjHjbD7R/Hc8xwZh/tgeC6985TpjZiGrIi18bVHA9LPWw/ncPOfS9ysHoM3k8Ft8
         CjOYOZGgbXD/gmqOari97hprOV/dv5K85e07nRvK6017mRO3hdlZQWoYl7ZVbaYkgzXP
         Jlx4X/igZ7tKzjCdsNc72+76sUd/MGzETseBCQrXKVNoRC6j61Sdv7m5rZjZBqjCQtj1
         OVXA==
X-Gm-Message-State: AOJu0Yzmhohg8j9b0bC2d50XDrm6kM3Ku6w+6IuqTwEYLmrYHzAvoNhZ
        wx9vNoLUJ4DjZtgiFp9LECuaSQ==
X-Google-Smtp-Source: AGHT+IFoFu//qWf+2YKVQsH9YQI2JLonYDwjIcCmCaPKPhTJZjW9JQmcHydqb1bvOIeqR+dHCuqbtQ==
X-Received: by 2002:adf:e78d:0:b0:317:ef76:b778 with SMTP id n13-20020adfe78d000000b00317ef76b778mr801971wrm.63.1695893938243;
        Thu, 28 Sep 2023 02:38:58 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:38:57 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/5] drbd: rename worker to sender
Date:   Thu, 28 Sep 2023 11:38:47 +0200
Message-ID: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some more refactoring commits from out-of-tree drbd.
Intended for 6.7.

Christoph Böhmwalder (5):
  drbd: Rename per-connection "worker" thread to "sender"
  drbd: Add new per-resource "worker" thread
  drbd: Move connection independent work from "sender" to "worker"
  drbd: Keep connection threads running while connection is up only
  drbd: Get rid of conn_reconfig_start() and conn_reconfig_done()

 drivers/block/drbd/Makefile                   |  2 +-
 drivers/block/drbd/drbd_int.h                 | 12 ++--
 drivers/block/drbd/drbd_main.c                | 21 +++---
 drivers/block/drbd/drbd_nl.c                  | 48 +++-----------
 drivers/block/drbd/drbd_receiver.c            |  2 +-
 drivers/block/drbd/drbd_req.c                 |  7 +-
 .../drbd/{drbd_worker.c => drbd_sender.c}     | 64 ++++++++++++++++---
 drivers/block/drbd/drbd_state.c               | 31 ++-------
 drivers/block/drbd/drbd_state.h               |  1 -
 9 files changed, 95 insertions(+), 93 deletions(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (97%)


base-commit: aa511ff8218b3fb328181fbaac48aa5e9c5c6d93
-- 
2.41.0

