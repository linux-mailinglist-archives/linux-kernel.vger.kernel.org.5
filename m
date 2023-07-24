Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439975E6B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGXBWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGXBWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9948B172A;
        Sun, 23 Jul 2023 18:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495C360EEB;
        Mon, 24 Jul 2023 01:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCA7C433C7;
        Mon, 24 Jul 2023 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161669;
        bh=Fz6RXpQ9T59WQ0G81m7lRvqJdxJVsd3sjQGZu9os1Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eo5rYmZUc1Fyrg1SQ7LVE5XEY6hB/gno9bCSqpHt1E/iF/ezeTFolAvlUMCaIzACh
         38+HLL6iizlY7ngcJ2sv7jZzQkyXY+oGtHaHab1vxk5sossn5Y1UmvAh/RE1tlzeue
         2tKjUWFj0tJn9OE+K2v4xfNOubQ0GfCt1EiWhHnUBKeqHrQleFITlhepcgCki/xHpv
         uj5/6ImsUFlWW6qs1AgOHhUMuqQ22KCiD0O1VGh3CGhhKx0aLTF3IU6zkxObmLc0Sq
         yP9qIoW8QLq4csFsjzfR4D8CpPdNvKhiUtWd7A2oXTK9T5ndUTYcPzpAdqqdnSjsGC
         D/SwIjlv6EZ9w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Immad Mir <mirimmad17@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.4 58/58] FS: JFS: Check for read-only mounted filesystem in txBegin
Date:   Sun, 23 Jul 2023 21:13:26 -0400
Message-Id: <20230724011338.2298062-58-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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

From: Immad Mir <mirimmad17@gmail.com>

[ Upstream commit 95e2b352c03b0a86c5717ba1d24ea20969abcacc ]

 This patch adds a check for read-only mounted filesystem
 in txBegin before starting a transaction potentially saving
 from NULL pointer deref.

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_txnmgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ffd4feece0785..ce4b4760fcb1d 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -354,6 +354,11 @@ tid_t txBegin(struct super_block *sb, int flag)
 	jfs_info("txBegin: flag = 0x%x", flag);
 	log = JFS_SBI(sb)->log;
 
+	if (!log) {
+		jfs_error(sb, "read-only filesystem\n");
+		return 0;
+	}
+
 	TXN_LOCK();
 
 	INCREMENT(TxStat.txBegin);
-- 
2.39.2

