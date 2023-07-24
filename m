Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC33875E6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGXBYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGXBXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE001703;
        Sun, 23 Jul 2023 18:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D8A60F24;
        Mon, 24 Jul 2023 01:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D10C433C8;
        Mon, 24 Jul 2023 01:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161667;
        bh=n9zCeCBaqI73vhP4arOKe07oo3onC9y88+7PEr7qHYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGDyxjr+7XV+xzAAE5s4gHVtVSYPikOW8fakTWAuT9HoKS3Z4P8mz9c4h7Wk4y/7W
         pXrm0nDajb1prXmKzJSFx3nd4wUz1ApZeRwdjSpkCWnaA6oqYHHpoTdfBUlmztKb74
         EkKiPLTA1DcUOq14S/0emVeA6gYf92hW1lgW8B/gURC1KwpXi4wxm+nOKNr63Mp4MT
         8odj53V79eI6YJIT5V+oBFcriCrrdg2CZ73HPssUmrK/D1js5PhxD/ctQrL9/t6JPA
         w9OVNarmyiGkXQ5l3iLS3sFelUh9T9R1P4yHW7kx84Rd4tS2x/1jOYRgDgkxHGAjKR
         oEfEfllpZ5krw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Immad Mir <mirimmad17@gmail.com>,
        syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        brauner@kernel.org, dchinner@redhat.com, keescook@chromium.org,
        linux@treblig.org, jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.4 57/58] FS: JFS: Fix null-ptr-deref Read in txBegin
Date:   Sun, 23 Jul 2023 21:13:25 -0400
Message-Id: <20230724011338.2298062-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

[ Upstream commit 47cfdc338d674d38f4b2f22b7612cc6a2763ba27 ]

 Syzkaller reported an issue where txBegin may be called
 on a superblock in a read-only mounted filesystem which leads
 to NULL pointer deref. This could be solved by checking if
 the filesystem is read-only before calling txBegin, and returning
 with appropiate error code.

Reported-By: syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=be7e52c50c5182cc09a09ea6fc456446b2039de3

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index b29d68b5eec53..f370c76051205 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -799,6 +799,11 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EROFS;
+	}
+
 	tid = txBegin(ip->i_sb, 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
-- 
2.39.2

