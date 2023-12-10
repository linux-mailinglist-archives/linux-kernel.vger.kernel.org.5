Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C480BA66
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjLJLgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjLJLf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:35:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E4FD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:36:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A48C433CA;
        Sun, 10 Dec 2023 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702208164;
        bh=VE5AOlHytLIsYFQS7gWhjGZv4ckuyxkhp1hOk55UcyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdPbIg6hNIf4BrSLKKH6gkTlFHSLALJrVqs3hKrjjDzV1Z7N4lyErMKyrSrhPqF7d
         iDT98jSa2Mz2myBQzmpz0LGNxShqhREACRFoJFP8z9mMvMC4j7W5fVpKMk9dvkoEht
         ZBJYvH5X4Eb4MjaeI0gwVC6rd7/wMWDI09mb4LImSzt8t/LBzhR1tibOn1tVzB831a
         kyx429rqHwieBBykrwNU6dE2nr8JRecr3bFGyPcb873PK3V2sKqqhhLxiSkvC9A+Cf
         qdJCcEvhTGnogiltiFqOifxY4+RzPMm8+eZanbGQJTjrsqQF0hP6+oDYrsX8KmHQnS
         /RHhQZ8M3q9aw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 3/6] f2fs: fix to check compress file in f2fs_move_file_range()
Date:   Sun, 10 Dec 2023 19:35:44 +0800
Message-Id: <20231210113547.3412782-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210113547.3412782-1-chao@kernel.org>
References: <20231210113547.3412782-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_move_file_range() doesn't support migrating compressed cluster
data, let's add the missing check condition and return -EOPNOTSUPP
for the case until we support it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 156b0ff05a3b..5c2f99ada6be 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2813,6 +2813,11 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = -EINVAL;
 	if (pos_in + len > src->i_size || pos_in + len < pos_in)
 		goto out_unlock;
-- 
2.40.1

