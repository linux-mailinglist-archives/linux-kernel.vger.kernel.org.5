Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4267DAEEF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjJ2WzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjJ2Wy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:54:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F4DB;
        Sun, 29 Oct 2023 15:54:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C36C433CB;
        Sun, 29 Oct 2023 22:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620095;
        bh=XpEB7QllHM+SGHwR2XRaJkTltVnlwDvLC5E/fzWUslg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrdRMUn0NeTfdvoTXO0y0T5V5mVDNy46JXiTJcN9/U4Fqzgbf+IutxujJCulcydFq
         C+ifKmx0lIFbgPpk7BBp88BUkuRFlv6+BUi/bnRvcO6dQFw2PQ5548a3Vata/ShCVX
         vgt0lzLGSi4atizGlC5G1H6FcXEk0Hb5cn2VKWHcsS8e4gXncBWE+MmA3hVqdwPudU
         uUrcuUVEZ2sx4CNV89GeMJinAX/XHDeSFDM4+a51ySQxKXEuFPUgjMiCyVyzqLWInH
         rFJmjgKMEG+w64nA+A7oUFmkIMvHXV3PA6miVd30m69jlmCCda2ul/BaFCtmwiGoxl
         KoSllFruRo3KQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 07/52] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date:   Sun, 29 Oct 2023 18:52:54 -0400
Message-ID: <20231029225441.789781-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 91a4b1ee78cb100b19b70f077c247f211110348f ]

Reported-by: syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs_fs.h |  2 ++
 fs/ntfs3/super.c   | 26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 629403ede6e5f..788567d71d939 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,9 +42,11 @@ enum utf16_endian;
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
+#define MAXIMUM_SHIFT_BYTES_PER_MFT	12
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
 
 #define MAXIMUM_BYTES_PER_INDEX		4096
+#define MAXIMUM_SHIFT_BYTES_PER_INDEX	12
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)
 
 /* NTFS specific error code when fixup failed. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d3c78e2a49cbe..18a8bc73b8e2d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -901,9 +901,17 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		goto out;
 	}
 
-	sbi->record_size = record_size =
-		boot->record_size < 0 ? 1 << (-boot->record_size) :
-					(u32)boot->record_size << cluster_bits;
+	if (boot->record_size >= 0) {
+		record_size = (u32)boot->record_size << cluster_bits;
+	} else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
+		record_size = 1u << (-boot->record_size);
+	} else {
+		ntfs_err(sb, "%s: invalid record size %d.", hint,
+			 boot->record_size);
+		goto out;
+	}
+
+	sbi->record_size = record_size;
 	sbi->record_bits = blksize_bits(record_size);
 	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
 
@@ -920,9 +928,15 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		goto out;
 	}
 
-	sbi->index_size = boot->index_size < 0 ?
-				  1u << (-boot->index_size) :
-				  (u32)boot->index_size << cluster_bits;
+	if (boot->index_size >= 0) {
+		sbi->index_size = (u32)boot->index_size << cluster_bits;
+	} else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
+		sbi->index_size = 1u << (-boot->index_size);
+	} else {
+		ntfs_err(sb, "%s: invalid index size %d.", hint,
+			 boot->index_size);
+		goto out;
+	}
 
 	/* Check index record size. */
 	if (sbi->index_size < SECTOR_SIZE || !is_power_of_2(sbi->index_size)) {
-- 
2.42.0

