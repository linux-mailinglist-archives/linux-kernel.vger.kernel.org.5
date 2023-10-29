Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40A97DAEF9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjJ2WzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ2WzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:55:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEEBC1;
        Sun, 29 Oct 2023 15:54:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED797C433C7;
        Sun, 29 Oct 2023 22:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620097;
        bh=8/W2tMtUn0iLmvzcTTSUm1YwlPPgP6dMcQenQMiVERQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsWyzZq+PRxhc93gpLn9UpkylFVGVd0IAXqaGOOTksBDNXw1SZVGcijwrhm0UTd+J
         gbShrwqFaOKpS73nU1xGfuOohOR00xp9EkCNQpWikEYWrlcmNHCfvhRB449pFvtIfS
         pQwHl3eEqxVBkRp6iGbw9KfVJH7ECSnqsW7NswD4g94Z63YqBS2kNHzHeaFL8gerlw
         N7czYeO6EVXzWb6f7o6GihoYaVgQYqsvSJTq5jMihaSnNUDAcylsbb0G0BFE44kDsj
         CMd8ntPFZ6OFWeW6PcX79UagTvO/SBZ5AMsGSe5e+gtx6Z8rsMS3H/b1Dc95sjGxRw
         dLmLu0ZxoZYJw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 09/52] fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo
Date:   Sun, 29 Oct 2023 18:52:56 -0400
Message-ID: <20231029225441.789781-9-sashal@kernel.org>
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

[ Upstream commit d27e202b9ac416e52093edf8789614d93dbd6231 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 98545060580ac..055c3764af26e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -453,15 +453,23 @@ static struct proc_dir_entry *proc_info_root;
  * ntfs3.1
  * cluster size
  * number of clusters
+ * total number of mft records
+ * number of used mft records ~= number of files + folders
+ * real state of ntfs "dirty"/"clean"
+ * current state of ntfs "dirty"/"clean"
 */
 static int ntfs3_volinfo(struct seq_file *m, void *o)
 {
 	struct super_block *sb = m->private;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 
-	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n", sbi->volume.major_ver,
-		   sbi->volume.minor_ver, sbi->cluster_size,
-		   sbi->used.bitmap.nbits);
+	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n\%zu\n%zu\n%s\n%s\n",
+		   sbi->volume.major_ver, sbi->volume.minor_ver,
+		   sbi->cluster_size, sbi->used.bitmap.nbits,
+		   sbi->mft.bitmap.nbits,
+		   sbi->mft.bitmap.nbits - wnd_zeroes(&sbi->mft.bitmap),
+		   sbi->volume.real_dirty ? "dirty" : "clean",
+		   (sbi->volume.flags & VOLUME_FLAG_DIRTY) ? "dirty" : "clean");
 
 	return 0;
 }
-- 
2.42.0

