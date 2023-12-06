Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2B806A64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbjLFJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346881AbjLFJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:11:08 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6711F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:11:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxxSRMO_1701853861;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxxSRMO_1701853861)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:11:11 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, dhavale@google.com,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 0/5] erofs: basic sub-page compressed data support
Date:   Wed,  6 Dec 2023 17:10:52 +0800
Message-Id: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Recently, there are two new cases so that we need to add a preliminary
sub-page block support for compressed files;

 - As Android folks requested, Android ecosystem itself is now switching
   to 16k page size for their arm64 devices.  They needs an option of
   4k-block image compatibility on their new 16k devices;

 - Some arm64 cloud servers use 64k page size for their optimized
   workloads, but 4k-block EROFS container images need to be parsed too.

So this patchset mainly addresses the requirements above with a very
very simple approach as a start: just allocate short-lived temporary
buffers all the time to keep compressed data if sub-page blocks are
identified.  In other words, no inplace/cache decompression for
the preliminary support.

This patchset survives EROFS stress test on my own testfarms.

Thanks,
Gao Xiang

Gao Xiang (5):
  erofs: support I/O submission for sub-page compressed blocks
  erofs: record `pclustersize` in bytes instead of pages
  erofs: fix up compacted indexes for block size < 4096
  erofs: refine z_erofs_transform_plain() for sub-page block support
  erofs: enable sub-page compressed block support

 fs/erofs/decompressor.c |  81 +++++++++------
 fs/erofs/inode.c        |   6 +-
 fs/erofs/zdata.c        | 224 ++++++++++++++++++----------------------
 fs/erofs/zmap.c         |  32 +++---
 4 files changed, 169 insertions(+), 174 deletions(-)

-- 
2.39.3

