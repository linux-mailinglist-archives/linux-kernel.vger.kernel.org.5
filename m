Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE623791A58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbjIDPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIDPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:12:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39371B7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 723A160A4A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 15:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DD8C433C7;
        Mon,  4 Sep 2023 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693840367;
        bh=vvfGHYHl5xJjMX5/f31WY7Kz3B/DCsZa1lluG2f5HTY=;
        h=From:To:Cc:Subject:Date:From;
        b=pMvSXDc23f+POmvwTwuhEYS/fiPLUKyv4ziUOUzRmJX2ex+RrGrPNc+LJc8V/1x6k
         AbXy8HtqSJt+H5kShX2tbt7N/k5bDXXnIpcJxaQl+iAM0OQ0fBNebclJvc01cGVWFn
         +ZnJ20TWM2LHCr7iYtAu4pWRwBiOnJGxHGLt6djxsL0KdHJQZXuHa6CVJ3gF+pzMhT
         VkIesIrIV/C/uiKoBztmT+w3FSm2DOHrOQywow1Xox144kRZAZW1LhTdqflZnu+eKR
         OEdyJAJqHN+6u65u1itLYA+kegZJU3Ojyl2csrhYvHqEwz4Cfh/1Su8kO75IspDdM5
         lBL5ZYlApGAug==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: compress: fix to avoid fragment w/ OPU during f2fs_ioc_compress_file()
Date:   Mon,  4 Sep 2023 23:12:42 +0800
Message-Id: <20230904151242.1786219-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If file has both cold and compress flag, during f2fs_ioc_compress_file(),
f2fs will trigger IPU for non-compress cluster and OPU for compress
cluster, so that, data of the file may be fragmented.

Fix it by always triggering OPU for IOs from user mode compression.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2a38d2cc2140..d4b59c57d827 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2665,6 +2665,11 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (f2fs_is_atomic_file(inode))
 		return true;
+	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
+	if (f2fs_compressed_file(inode) &&
+		F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER &&
+		is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
+		return true;
 
 	/* swap file is migrating in aligned write mode */
 	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
-- 
2.40.1

