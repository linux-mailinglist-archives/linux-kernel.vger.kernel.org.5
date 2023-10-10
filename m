Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC17BF05C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379367AbjJJBfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379335AbjJJBfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:35:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A49E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:35:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC5EC433C7;
        Tue, 10 Oct 2023 01:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696901704;
        bh=wdXe14lwor8omxbaXrg8/wjNwruX3BHW4Eu0cZq/Z14=;
        h=From:To:Cc:Subject:Date:From;
        b=jrLMaPinjSOTMq9/ANW0jfGue5KY8WrCmnLLPwaDdYppFmtXviYphlx23ZmkZfDwH
         478+Wuztmd/ne0hZm49iD3DxO290H2LpeBgS686+6794edX8ZfU5itRkLV0/Fb2Kfa
         pyadZNUgldHFjcyU5FNqDC388+h2B9uJWWeNJ1hMLXGmH3sZfLdfK6qZZTyVhvLPro
         PW0or02rSnpTclKKSSveWVGwx8v8W3EBQhoLadUdlt6l9RKhcorhLBaOO21kQmN10b
         cEsSOxsofu0pNLA0vFIKMo3nBxiZZHpRFVm04jLNZ820Ti9JX4EozWodxJx2pwGwdX
         e04uMjHLE6vDA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: let f2fs_precache_extents() traverses in file range
Date:   Tue, 10 Oct 2023 09:34:59 +0800
Message-Id: <20231010013459.115024-1-chao@kernel.org>
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

Rather than in range of [0, max_file_blocks()), since data after EOF
is alwasy zero, it's unnecessary to preload mapping info of the data.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 06d35b8aceef..304d0516d3a4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3263,7 +3263,7 @@ int f2fs_precache_extents(struct inode *inode)
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
-	end = max_file_blocks(inode);
+	end = F2FS_BLK_ALIGN(i_size_read(inode));
 
 	while (map.m_lblk < end) {
 		map.m_len = end - map.m_lblk;
-- 
2.40.1

