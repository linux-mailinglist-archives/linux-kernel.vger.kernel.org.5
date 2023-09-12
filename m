Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B379DA45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjILUuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjILUuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:50:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58588199;
        Tue, 12 Sep 2023 13:50:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7B6C433C8;
        Tue, 12 Sep 2023 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694551817;
        bh=x7nnTrA5RCHsYOnVqf+Mil/a7Ta+GR6SCAIeYqHvIbc=;
        h=From:To:Cc:Subject:Date:From;
        b=IvTGrqTjYpc66HYNpyca1dKQTqvON4oy3Y5oI1mOmwt4kzgpneZ92CxUSpvK68qBJ
         MgupqzBA/1myQM61eLotXPDMMGlno4OoCZm8uVuANMaP7K/E4gYekyVe7ljJs/bUw/
         DNpxVP9/6T+TE/PxrAtUjH3Mf1ugRH1XcoH6Zap+JQwdCnEqjHJQc/kDYszntCOqJ9
         2PXGfpwDsCvHAmDWZZV5vzfv9WmAH7IEdkKhLWwuytX0Z+gSrY+OgOTFStNy87Mkce
         AFOV0AFeScKfpB6eDCkZPpTYbJRZ1BoYtCF5mPdt1GcxjvPi4mRKSb0fmf36gIKZT0
         4mdj6cBp88Y9Q==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] f2fs: set the default compress_level on ioctl
Date:   Tue, 12 Sep 2023 13:50:15 -0700
Message-ID: <20230912205015.2582133-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, we'll get a broken inode.

 # touch $FILE
 # f2fs_io setflags compression $FILE
 # f2fs_io set_coption 2 8 $FILE

[  112.227612] F2FS-fs (dm-51): sanity_check_compress_inode: inode (ino=8d3fe) has unsupported compress level: 0, run fsck to fix

Cc: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca5904129b16..09716127e107 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4005,6 +4005,15 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
 	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
 	F2FS_I(inode)->i_cluster_size = BIT(option.log_cluster_size);
+	/* Set default level */
+	if (F2FS_I(inode)->i_compress_algorithm == COMPRESS_ZSTD)
+		F2FS_I(inode)->i_compress_level = F2FS_ZSTD_DEFAULT_CLEVEL;
+	else
+		F2FS_I(inode)->i_compress_level = 0;
+	/* Adjust mount option level */
+	if (option.algorithm == F2FS_OPTION(sbi).compress_algorithm &&
+	    F2FS_OPTION(sbi).compress_level)
+		F2FS_I(inode)->i_compress_level = F2FS_OPTION(sbi).compress_level;
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (!f2fs_is_compress_backend_ready(inode))
-- 
2.42.0.283.g2d96d420d3-goog

