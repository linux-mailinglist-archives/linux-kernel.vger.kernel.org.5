Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC595759AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGSQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGSQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D401734;
        Wed, 19 Jul 2023 09:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 335C261788;
        Wed, 19 Jul 2023 16:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB56C433CA;
        Wed, 19 Jul 2023 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783771;
        bh=K6oAnsvQEIZrftCXh7mBn5FA+pVc8rhUAGklED1yUHw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qZv8/kh4Iyuuiswu7oyZwUcv4dJT5RoNFpwxVuluWlCwCWmretLUk5PaKDIhLDoBR
         j902l4VPO1zqp8LwQm0lCqOiPKrAzD88mBt8H/3HsjOnXfwPOau7uGUwOyJXJ8FPdH
         ErbPXrOPlV3q/wjdLlC68hlxxNlKjHjaHuHdJGCEUdjAuaQLrbjH9N6CNqITucpcgE
         K6EzBQV/GhH1UsrcxCeyAw1jTqSI8O3eV4OCzu6HqKyPXYvyr1A/UqiPIwIdudQaTJ
         yLmvBN2oR94w8cW7zvq7I4rlg311Ez1B4W3U4Fkv3lOhC6fnGPce7rWM0hkRTyEwDO
         is0D+7MER80lg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 16:22:30 +0000
Subject: [PATCH v4 1/4] fs/9p: remove unnecessary and overrestrictive check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v4-1-a3cd1cd32af2@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=K6oAnsvQEIZrftCXh7mBn5FA+pVc8rhUAGklED1yUHw=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkuA3YMIjmuoMKqeY2BsmWo6nZ5varMUeKrXq1A
 ZgW9vAkk0SJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLgN2AAKCRCI/9X7Sl//
 mLVmD/0YVO3O0CHQoWPMnoGtCl1BrCJgi4NkTHU1J4rP0H9hKOJ8OUaephCEQ1KU3WZzKEKMK/b
 uYtwMcqyqd+PX70SbCMFlQhZxsiiNOvDtUpaOVC89rTozUMorggCYvVr95NmQ80HlViSHCadvIX
 K4i1W+sMcga84ViNqDgt+mFn0urJ6z44hs6skVwcIDDImceU9lunAM2BejqtK3w0AFkMXEzqnOX
 SdMeV03rF6zVFwK7/7xACx+dx0MJVlC/UP6o7KLTTkoU0Nzr4hB4ZqaCy61b8vMqUln7lVRxZaZ
 jk0zwMV+5XN0KBN7eb6WtzDeURR97FOLTww1chVWjIaO2W8mNc4z16eSuDHMTk7ZlxkTM6avVSv
 Kqb7YDf5brbCHsuQb/FjwBM1Fq44newsqNlWNVbSIhrRczmt4xD1eRU+B6mfr59IvMOcW5jPEiR
 kzuQevXCHkBmxgMLUXg0cLPCSr8non0kUbz1NQAkU6Ba5mLopt8keYqdr7DeH2blqkUKdRfLp6q
 BHaw4Yjh+y/g62WWlkuHNOfSngAdz4T8tse1IQVoKMbsUiXt9Iof6lBMRPhCLnIGoF/K3pIcLDc
 +mdwaVFmkNp3LYDpIzCwjgUoIYp2gGOZLJsVW0/izToqd0mxVBlXPYXrOgb+ANu0prCENGMgOZ2
 gwFRnjJFnsjC0zw==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates a check for shared that was overrestrictive and
prevented read-only mmaps when writeback caches weren't enabled.

Cc: stable@vger.kernel.org
Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Closes: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 2996fb00387f..9b61b480a9b0 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -505,9 +505,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
-		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
-		if (vma->vm_flags & VM_MAYSHARE)
-			return -ENODEV;
+		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");
 		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}

-- 
2.39.2

