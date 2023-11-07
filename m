Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2D7E4CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjKGXXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjKGXXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:23:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3401718;
        Tue,  7 Nov 2023 15:23:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B89C433CD;
        Tue,  7 Nov 2023 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399383;
        bh=brWxIczyVCBvO4AyUa+zsOYOVfm9JnL6XsF7XTe1ClA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1EJ0yRLJUMO6Isaj4lW+kzy8zr9AE6x5LZ/9K7OoEohb+TcWwX8WOCys8z7vN0QI
         iHxf+TJCkU8b2UtmUSIhytx/oeIgzojmLG8tXSaygP8jBkxhoLS+dy/Rx8f59+j/g0
         SERiq2CaWopBZwhSd0nmWdpXiq1b6WzYEniork7BvH4opJb8ZgawnKJD33OIRlYcUI
         udmqn3A9OIesYImqZTDELUs51D8GwVAvU232Jp0GBsNR3dziVjZXJV7Dab86YW3su5
         ZHzVOgySAz/IoAGAejleNYzf+MLw6Bbz/dEUXHaKoHl+GMWYfzMF50dqWF7Zz/LE0z
         XeP6rND9qMmQg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 14/18] f2fs: fix error handling of __get_node_page
Date:   Tue,  7 Nov 2023 18:22:08 -0500
Message-ID: <20231107232231.3775605-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232231.3775605-1-sashal@kernel.org>
References: <20231107232231.3775605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 9b4c8dd99fe48721410741651d426015e03a4b7a ]

Use f2fs_handle_error to record inconsistent node block error
and return -EFSCORRUPTED instead of -EINVAL.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 248764badcde8..ed963c56ac32a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1467,7 +1467,8 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 			  ofs_of_node(page), cpver_of_node(page),
 			  next_blkaddr_of_node(page));
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
-	err = -EINVAL;
+	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
+	err = -EFSCORRUPTED;
 out_err:
 	ClearPageUptodate(page);
 out_put_err:
-- 
2.42.0

