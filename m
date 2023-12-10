Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8B580BA65
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjLJLgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjLJLgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:36:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541DFE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:36:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2476C433C7;
        Sun, 10 Dec 2023 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702208166;
        bh=hIUlpOJ3aDB7nGkcog2qFsHcADMxnRlMDotLaomis/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6wvItDiHuOzned+j4BhIjpFIQoZDWqwoE4wwGaR4Fw+eY5+AkRtDWnwteNFlwMrv
         +CaTN0Kh7EwMjhsSMWh/CfmCoTSjUstW04Q4ro+besEvfsC0nVcfwpr256ctyDlolw
         QCKDXMbUs5vv2nMM4qA7zii7GlhNcLsokDcrr8yVYiHm9OLgW6xznggE816B5fwOnb
         o/8/3pCllvh2sUfJolQ+l0fVepwd1uImEVX8aMmesN5mM8e61tuCJROLZI5Pl1XUrO
         xOK08NqPz5D2euciBnLvdkzhWYo2cVrDSUTy+0hPQoWwhowAezT3QysEst52Hq92Tn
         GYBWdA36GuvXw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4/6] f2fs: don't set FI_PREALLOCATED_ALL for partial write
Date:   Sun, 10 Dec 2023 19:35:45 +0800
Message-Id: <20231210113547.3412782-4-chao@kernel.org>
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

In f2fs_preallocate_blocks(), if it is partial write in 4KB, it's not
necessary to call f2fs_map_blocks() and set FI_PREALLOCATED_ALL flag.

Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5c2f99ada6be..1a3c29a9a6a0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4561,13 +4561,14 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
-	/* Do not preallocate blocks that will be written partially in 4KB. */
 	map.m_lblk = F2FS_BLK_ALIGN(pos);
 	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
-	if (map.m_len > map.m_lblk)
-		map.m_len -= map.m_lblk;
-	else
-		map.m_len = 0;
+
+	/* Do not preallocate blocks that will be written partially in 4KB. */
+	if (map.m_len <= map.m_lblk)
+		return 0;
+
+	map.m_len -= map.m_lblk;
 	map.m_may_create = true;
 	if (dio) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
-- 
2.40.1

