Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987787DB19F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjJ2X5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjJ2X5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:57:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342404231;
        Sun, 29 Oct 2023 15:59:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F110C433C9;
        Sun, 29 Oct 2023 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620365;
        bh=pt3OFPe5XCJhIqZLC3h4VkJBZJFyvIu2/H5vJBzxskI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agi1fNL+U8/7Wsuf6JfvJTO6Tcu3xdqH/WdBLrOIa8sBc7DO0IiiMpyuMDbyGW5L1
         Wz4WBZWsjckGvJwtVW5b2DEHrQauj3TUKmJ9jUzLOX2zVkSl5dPvUAExuv/taXNb0s
         0LS0590DSL24Z8us4WtjGMwqfctb6+XZ7JuOykAMiabIHmKJlBnzxxYQYFpD+vsvpu
         q1Jfdf/oEDI9HPG9poMyyu6vG2+JMFn24wodWYhLQ2d1Fl3NAe2AD4tNyDLewVRFk5
         7/jRBuI7fAoLKRkRn27SHLzJDZjRgmda1Os+Db0t+MILBsclhq53jQSMLsdOnuGBD6
         I44p5J7NwPMKw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 06/28] fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
Date:   Sun, 29 Oct 2023 18:58:41 -0400
Message-ID: <20231029225916.791798-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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

[ Upstream commit 32e9212256b88f35466642f9c939bb40cfb2c2de ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 73a56d7ac84b7..b02778cbb1d34 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2100,7 +2100,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		if (i == idx)
+		if (i == idx || !pg)
 			continue;
 		unlock_page(pg);
 		put_page(pg);
-- 
2.42.0

