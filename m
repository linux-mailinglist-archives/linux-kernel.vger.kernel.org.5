Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A87DB115
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJ2X2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjJ2X2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:28:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F72D79;
        Sun, 29 Oct 2023 15:57:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65270C433D9;
        Sun, 29 Oct 2023 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620265;
        bh=jAHUril8lBS0BRD6a5/QOtzXJLQsnqbARQUT4v575to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTiUQRAxiIUAoGVjii4C5OhyuxhLdNtGTXtZfi9ekGSFlnJRvGou5XWEqc2ZNBbFc
         xbaBcxiPp5DHy6USEryhLmFeMup9twRvSTLf3fS4zmHhq0bOzD16LphT5oNF3+ntwm
         Ani2VmvO/E1dFa8SMxmRCf0+elRZnEEO7vkV61ea9/E4jFr+1ryMTOJ75FwntjZYSD
         4F9kGH+En+vMmJb4BM09LQfOp/Om5pRE7WAK5QwCv/aaBoZ15SF7rJ4lJi9npe8Ikr
         MJg3fbNkw/hTgJWcnixsqfwRe5nn6y5yPD/Lt80mMnVHU7x+veS+tTOaoAMbi2j5hs
         vT9ZIcpAKnh7w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 02/39] fs/ntfs3: Add ckeck in ni_update_parent()
Date:   Sun, 29 Oct 2023 18:56:34 -0400
Message-ID: <20231029225740.790936-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
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

[ Upstream commit 87d1888aa40f25773fa0b948bcb2545f97e2cb15 ]

Check simple case when parent inode equals current inode.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index dda13e1f1b330..166c3c49530ec 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3198,6 +3198,12 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		if (!fname || !memcmp(&fname->dup, dup, sizeof(fname->dup)))
 			continue;
 
+		/* Check simple case when parent inode equals current inode. */
+		if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
+			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+			continue;
+		}
+
 		/* ntfs_iget5 may sleep. */
 		dir = ntfs_iget5(sb, &fname->home, NULL);
 		if (IS_ERR(dir)) {
-- 
2.42.0

