Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2907DAEFB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjJ2WzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJ2WzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:55:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC3D9;
        Sun, 29 Oct 2023 15:54:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2808C433CA;
        Sun, 29 Oct 2023 22:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620098;
        bh=9IB4jibcd1bRPkDCXBfrMALn/uwVsE1uo1hzrNtcqdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnmNtxG86mgc4DTzk2Yyvcd7rQvOi4DY5q+PKC8UpZQYxpOltjlsh5y5+mRec4Fe8
         GMlubFX5u/4qB6EvdiHGIx0dGITqB2Mr3ygHvRo2iq434b10k2nL2LyfP+E50JsPae
         IhlJ6IoM3nYE2tgPW9Exb8IQaDo93rsvUWUEHaaDoRnJ54oN4/6jLY12hpC88uPsDZ
         TWrlQcQ6BSWwIZbi57auT4Yg+j2kGqEDOP6DImLkG2/zXx0tJoIaSUTEeDxwnWYt/6
         im2NJOool3GrWMV4aIbY+akT02qxhQUuagDNsfPuVDP1HbMzEvoPXmQ5OrgoZDKyHR
         5hi2P4eSOIA8Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 10/52] fs/ntfs3: Do not allow to change label if volume is read-only
Date:   Sun, 29 Oct 2023 18:52:57 -0400
Message-ID: <20231029225441.789781-10-sashal@kernel.org>
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

[ Upstream commit e52dce610a2d53bf2b5e94a8843c71cb73a91ea5 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 055c3764af26e..9d84f66e6a458 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -498,7 +498,12 @@ static ssize_t ntfs3_label_write(struct file *file, const char __user *buffer,
 	struct super_block *sb = pde_data(file_inode(file));
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	ssize_t ret = count;
-	u8 *label = kmalloc(count, GFP_NOFS);
+	u8 *label;
+
+	if (sb_rdonly(sb))
+		return -EROFS;
+
+	label = kmalloc(count, GFP_NOFS);
 
 	if (!label)
 		return -ENOMEM;
-- 
2.42.0

