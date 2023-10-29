Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52587DAEFD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjJ2Wz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjJ2WzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:55:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5597FF;
        Sun, 29 Oct 2023 15:54:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE1C433C7;
        Sun, 29 Oct 2023 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620099;
        bh=3ecTuxaFxXd+4WzH7yZUfyWhqhdE2zoYnEaqwcm2F1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftYWzWF5NlFV5fa/Hii9tnMigbGoXy2nl3p9xaX0MNuxgGhDXt9fVRtyf9UzO17mT
         olwFHYtw+eujgLigw40G5lBA9qEstS0RAAGrYbMpXPSv4mkJJETf7oVmZO/7TqMZpI
         HvQFLxqeLOddUp+aPeG6pshpkjwS8QE9UYQoOLbdQgIyN1x3XmqMpfQe61KTyn2RlI
         P8RlNZmUEIWACjJ5FAfxjNZoQw7CE8yqUzHkFlQKrQ7vGQK8CrNUwF1h/RYtjse647
         RoKdXUWYN2d2/EWZAt1/v3bUDqaBDkCxMDwWCT9a6WQp00/baqvw+gpXNwn5Zmb/8U
         BmxzRlUB2jKXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 11/52] fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
Date:   Sun, 29 Oct 2023 18:52:58 -0400
Message-ID: <20231029225441.789781-11-sashal@kernel.org>
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

[ Upstream commit 32e9212256b88f35466642f9c939bb40cfb2c2de ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f34d6472ddbd..05fb3dbe39076 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2148,7 +2148,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		if (i == idx)
+		if (i == idx || !pg)
 			continue;
 		unlock_page(pg);
 		put_page(pg);
-- 
2.42.0

