Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECEE799013
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbjIHTgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbjIHTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:36:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C61FC4;
        Fri,  8 Sep 2023 12:36:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDEFC113C9;
        Fri,  8 Sep 2023 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201726;
        bh=uY/qmFyaXvaAdfAYOYiCEHjFhCYv5lZ7VmTD1xgHoIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdJupR2AihKhrM2bfYC832qeCDdKaJn8zz1aHBYQvmjRSb78olOEwlWSEVfx8gclD
         4FIpiFMvZQEE2yNDXGplOB8uDZNpkheCjNKKchmfmbV2MWPQRnnKTxvKXZIi00VGjl
         a+aTBEMBEbBH2LykPFa1TmSefEpTJM1r9Du9goy8nxCbVHqOELDrvMxTt9J5wiYPkz
         CilQd9yra/UsY0DLw86uhMGDvRv0BdXyiqtpwhr2yzYZfDhDI7Gw6wHmgISWEUkXL6
         qcureB/3oZXoaE6YdZP+imThBInTjGP6AOnGIULb1T/bXGDmH6TNiJd42ucmygfaSV
         ZjKA5JojqNEeg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 20/22] block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
Date:   Fri,  8 Sep 2023 15:34:04 -0400
Message-Id: <20230908193407.3463368-20-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193407.3463368-1-sashal@kernel.org>
References: <20230908193407.3463368-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

[ Upstream commit 168145f617d57bf4e474901b7ffa869337a802e6 ]

bio_iov_iter_get_pages() trims the IO based on the block size of the
block device the IO will be issued to.

However, bcachefs is a multi device filesystem; when we're creating the
bio we don't yet know which block device the bio will be submitted to -
we have to handle the alignment checks elsewhere.

Thus this is needed to avoid a null ptr deref.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Link: https://lore.kernel.org/r/20230813182636.2966159-3-kent.overstreet@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d5cd825d6efc0..54c8d11f09663 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1198,7 +1198,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
 	unsigned len, i = 0;
-	size_t offset, trim;
+	size_t offset;
 	int ret = 0;
 
 	/*
@@ -1223,10 +1223,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
-	trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
-	iov_iter_revert(iter, trim);
+	if (bio->bi_bdev) {
+		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+		iov_iter_revert(iter, trim);
+		size -= trim;
+	}
 
-	size -= trim;
 	if (unlikely(!size)) {
 		ret = -EFAULT;
 		goto out;
-- 
2.40.1

