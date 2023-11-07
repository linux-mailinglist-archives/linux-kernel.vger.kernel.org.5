Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5934B7E4D44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbjKGX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjKGX0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:26:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6D1BE4;
        Tue,  7 Nov 2023 15:24:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460FBC433C8;
        Tue,  7 Nov 2023 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399474;
        bh=0QeHBJN2Gbtm3RGYJj2Ttnw64A1bJVNTHtV4HZxRMnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J2Da6MXzUGGHUSYzAmPT44C9HFRSh8Yyfq9RmE2JZ6TbDAW2T5TcrLsW9hpStmApF
         oDKjsAtsUZmIUW2v9Crqol/GROkV/5+eqgpGUEg6M7EyXyu4mu4ceyiO2sdBXFq5e2
         A4Gc/pCpi0phwaDqbl/juCUDyx27kBapfr2eRKVD4fNiKcM9OU7Goh1q3ayAfmouhR
         AHrwgmRaSkkH7A8QP40+FbBh/7TyPy+MNFMord/jogpNHuhTD+xs3lmlIS7vR93CXw
         NUaifAuoDxCnafj7czdJjM6Q6VI5QZMLOnAIZs4MyQG0bhKvFIxl0r753cP/q/d1Ca
         iu+c20IcTFW1w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 08/11] f2fs: fix error handling of __get_node_page
Date:   Tue,  7 Nov 2023 18:24:09 -0500
Message-ID: <20231107232420.3776419-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232420.3776419-1-sashal@kernel.org>
References: <20231107232420.3776419-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index a010b4bc36d2c..b73d44df9423b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1455,7 +1455,8 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
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

