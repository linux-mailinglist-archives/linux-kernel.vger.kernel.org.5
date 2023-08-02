Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8476DB59
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjHBXPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjHBXPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:15:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AA92D4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:14:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f74a8992so59273b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691018088; x=1691622888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylEeZzjseBtSPCtVB3RUxTfZrmeKosSCVcNPL4AOd1c=;
        b=Vf3klu2RjfF1l/38FwCWQBmtLVi7E5Qkj1LacqoxtuteT0PFLCHVmzgfKGNPhTvghF
         mBVL2MLDK2qsQKFNnTMXAgJhKm6p4UI4D4nw8zaDYHB7zxQ8/k02KhJxfC0hHODT0ED9
         bIu787qEshkXc4UQyoIv9plv1KNN/kZ2/mDOp0VG1mxI2zsoJJ/aa17xPIdgJG1ju0ei
         cbuCx5DCBFnibtAE2ZrohwExJ4Nq3WhKquuC/urcDJcHNf3IsIqfB1lXnkcPgxIbNnVy
         o18RR9u5n9XX+TpWWFG7CRaNQmg5GhjatQlYKI/CD7dAdeyo/zB7gwIa7y0BL1SkWGOW
         lwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691018088; x=1691622888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylEeZzjseBtSPCtVB3RUxTfZrmeKosSCVcNPL4AOd1c=;
        b=LBzgxy5vsYup4aKNY42nrJUtAnKNm+vqribKEnuy+pm2qCKACj7RN6Jdna+etvuz44
         SGX8vrfpiKelj3SeeP1pKcbnBTGFHBuZscMTj0HylifxwjRlivY4SgSVqydkAj1uJ/h8
         R+TQRa45uCSZbab/7/NaBPwJJf7vxFyEikg49yoHBuOfgx14n2ja5wg4YygSRaBZbl0E
         4M2lQjZzQ7edj9qEjNdR88JdYbQgny3dxjnHf8EjyqTvHe053G3Pz3rV/qsFiSQ9ZfIV
         V2tKMsdzLgTG/O5HJO0kAN8hwfWAFuTkAq2U5xzrjsJSgGhSPMS+Vh5zYvU96cpKbdQT
         Qw/Q==
X-Gm-Message-State: ABy/qLZBXGl9TEDaiivG0QCdWOmR4moZ2w2YY2rn/SxIJluTeblZi6Kc
        Fk5a7zQNhCcOTt6ApYng9PTGFQ==
X-Google-Smtp-Source: APBJJlFEwmUbCv4gMOLlkqyYly2gJhLv1fKLxPIHqi1C5oqFrxUfqzTS21eiSE64nFreokd1sHx3zw==
X-Received: by 2002:a05:6a20:4320:b0:123:3ec2:360d with SMTP id h32-20020a056a20432000b001233ec2360dmr19011183pzk.5.1691018087873;
        Wed, 02 Aug 2023 16:14:47 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s6-20020aa78d46000000b006871859d9a1sm8588086pfe.7.2023.08.02.16.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:14:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     brauner@kernel.org, arnd@arndb.de
Subject: [PATCHSET v2] Add io_uring support for waitid
Date:   Wed,  2 Aug 2023 17:14:37 -0600
Message-Id: <20230802231442.275558-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds support for IORING_OP_WAITID, which is an async variant of
the waitid(2) syscall. Rather than have a parent need to block waiting
on a child task state change, it can now simply get an async notication
when the requested state change has occured.

Patches 1..4 are purely prep patches, and should not have functional
changes. They split out parts of do_wait() into __do_wait(), so that
the prepare-to-wait and sleep parts are contained within do_wait().

Patch 5 adds io_uring support.

I wrote a few basic tests for this, which can be found in the
'waitid' branch of liburing:

https://git.kernel.dk/cgit/liburing/log/?h=waitid

Also spun a custom kernel for someone to test it, and no issues reported
so far.

 include/linux/io_uring_types.h |   2 +
 include/uapi/linux/io_uring.h  |   2 +
 io_uring/Makefile              |   2 +-
 io_uring/cancel.c              |   5 +
 io_uring/io_uring.c            |   3 +
 io_uring/opdef.c               |   9 +
 io_uring/waitid.c              | 313 +++++++++++++++++++++++++++++++++
 io_uring/waitid.h              |  15 ++
 kernel/exit.c                  | 132 +++++++-------
 kernel/exit.h                  |  30 ++++
 10 files changed, 453 insertions(+), 60 deletions(-)

The code can also be found here:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-waitid

Changes since v1:
- Rebase on io_uring-futex again, as that saw changes.
- Add compat handling of siginfo (Arnd)
- Add reviewed-by to patches 1+2
- Minor cleanups

-- 
Jens Axboe


