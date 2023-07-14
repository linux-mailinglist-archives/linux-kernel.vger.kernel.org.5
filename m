Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81A753323
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjGNHZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjGNHZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:25:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EB271F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:25:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so2683083e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689319524; x=1689924324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2Wu6QIlizBtEokw90LPWWON38SIdYdvvEsVMj5xrKM=;
        b=ggD3NGEx9VLtwxoCk9j9fiIuZJtmLVG2+D9Am2YHr1VsM384ZapAjgjAhCkE0/HHCN
         oA149LFWsngBRuUQO/9pD1rgI6DpL2fxDzk3JC5xC/YF0Gz7xg+dxAckSW+hp7DzjSh/
         ksfHz0nYeaZ94hkS4dKK6uXVS64tmxK32eJcehkByczO/C5HpBqYkNoyN2k2pRRjOLzL
         VdYd3tjOBNXwpEwzlPW2Di7jOEpfS4pqKKi+JyLNLj4fpeCwig23brBge0G0nN7yglvs
         ZH4D9kMRv9YzBPBbS3gpk7MuXsucddJcs+nxKmWSz1vUTc7r6lIQTdkDmlhsrCUFig5A
         FydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689319524; x=1689924324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2Wu6QIlizBtEokw90LPWWON38SIdYdvvEsVMj5xrKM=;
        b=XVR2BeAvZ8kGmsULE4AjLZwe7rGhTdG2m2SOLkBahnAWUTd6Wsp/o1TZ64AXYMF4A4
         mwcShcO8RJjY1uvTnvErGxbBZFJXJu0rlfCH5rPc/xTxAQs9NfR2pgXVQoWpERP7Z6fA
         p5grwA0fq8UlPtUyUa0jlEkpbj+YChI19KaZN6Ow5AW7yiC68/H9mDgy4okXYLxHPwBh
         87BFK3CSYBtbYIgXP7ytkachwEd5QJYkUgxfBfpGCa4zWXWa/UIeq9wDa0w4R1ErXMl+
         864mcWYneevzehc6TxOGhZ6ooQYsCMXR5zMK+fDAxAcx04oxpfVBBxvT1zg6N0SQZjqN
         bonw==
X-Gm-Message-State: ABy/qLYCCt+nSQVVWfh1xdLR93g0ojS6S3CEYjvRX89ntrf121T4b75B
        CUDVhT/3zYx2uBjRCBOFCqrjFA==
X-Google-Smtp-Source: APBJJlFxFh9/7o0h24xSGD4XN7JrlwTI+CHcMTm73B48WcJZw7o9GcGGqI/o0/Fk1zCXlaqCGH1LSQ==
X-Received: by 2002:a05:6512:304a:b0:4f3:b588:48d0 with SMTP id b10-20020a056512304a00b004f3b58848d0mr3285807lfb.14.1689319524098;
        Fri, 14 Jul 2023 00:25:24 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id i14-20020a056512006e00b004fb77d6cab3sm1380615lfo.261.2023.07.14.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:25:23 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, gost.dev@samsung.com,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v9 0/2] ublk: enable zoned storage support
Date:   Fri, 14 Jul 2023 09:25:08 +0200
Message-ID: <20230714072510.47770-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first patch does some
house cleaning in preparation for the last patch. The last patch adds support
for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET
 - REQ_OP_ZONE_APPEND

A user space component based on ubdsrv is available for testing [1] with the
"loop" target.

Read/write and zone operations are tested with zenfs [2].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The implementation of zone append requires ublk user copy feature, and therefore
the series is based on branch for-next (6afa337a3789) of [3].

Changes for v9
 - Move setup of IO descriptor for zoned operations into separate function
 - Fix an issue in `ublk_report_zones()` where zone report size was set to `remaining_zones` instead of `zones_in_request`
 - Do not truncate bufsize to `queue_max_segments` pages in `ublk_alloc_report_buffer()`
 - Do not change signature of `ublk_dev_param_basic_apply()` (not needed)

[1] https://github.com/metaspace/ubdsrv/tree/acc072e077bceea390bae14b6ccb8087f6d0cf1a
[2] https://github.com/westerndigitalcorporation/zenfs
[3] https://git.kernel.dk/linux.git

Andreas Hindborg (2):
  ublk: add helper to check if device supports user copy
  ublk: enable zoned storage support

 drivers/block/ublk_drv.c      | 342 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  36 +++-
 2 files changed, 360 insertions(+), 18 deletions(-)


base-commit: 3261ea42710e9665c9151006049411bd23b5411f
-- 
2.41.0

