Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF178FCDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbjIAMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjIAMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:04:14 -0400
Received: from out-239.mta1.migadu.com (out-239.mta1.migadu.com [IPv6:2001:41d0:203:375::ef])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47AFB5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:04:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693569849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aPzD27O+rmaWG0GJE07A/fVAM3U3LHBfOe+kpNzB4EE=;
        b=a9Rk93lqeqlBVXErfMyXhpBTV29nyoxj6EX4GcL9vlEPi6Z9GrZDZU7ufhriwN+JxshOef
        ByjMYSLspDESegVViu8cEXDHIi0dN/uszlf9RcdLW69Z0sbvUaFkkcg3KXS3kML3KHIu4l
        EVXVAG/YzKxiI8TqUQqaZSDO12l0tNM=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, dhowells@redhat.com
Subject: [PATCH v2 0/1] block/null_blk: fix poll request timeout panic
Date:   Fri,  1 Sep 2023 20:03:05 +0800
Message-ID: <20230901120306.170520-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Changes in v2:
 - Improve the commit message a little.
 - Add Tested-by from David Howells and Reviewed-by from Ming Lei.

The 't/io_uring -n4 /dev/nullb0' is easy to trigger poll request timeout,
then panic the kernel.

This patch just fix the kernel panic problem in null_blk driver, the
io_uring poll request timeout problem is fixed by Ming Lei [1].

[1] https://lore.kernel.org/io-uring/20230825090959.1866771-3-ming.lei@redhat.com/

Chengming Zhou (1):
  null_blk: fix poll request timeout handling

 drivers/block/null_blk/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.41.0

