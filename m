Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAF80BA64
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjLJLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjLJLgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:36:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3B10B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:36:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8620BC433C8;
        Sun, 10 Dec 2023 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702208171;
        bh=Iri4gOpboj6iTV2Mhz6ZedWpHWCjZ25WFJYUfWjqqLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbTG84Pgti9Rg9nuZefYagaar6MmND/pXxRIOKNqNqT7kT9DvjLj816128RaHnyWA
         1t856A8+B9XNMgz1U6jkxsyJZfSbbXH5LsaHkzIxLMHS94A6dr2KUzJHxhqUCpESI6
         2oifUZYES9vTPlrjTDMTkq8Xws9JxGq29abvtKfa+B84E/5BReFxri9KwO907sef/O
         YW7ozaSjlb5xmxfpYfqPd9dhbQJ2Nhwx6D+Gbcan9V3Pqy9AdGjLWVzv/dUHAtFEoq
         Auxeql1cK/woKVsSH7GMCnjm0ClHQnpn5xteCEPDbhx8FLCdeL+73O6coYb8KAqZsB
         awUKW8/7XI8QA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 6/6] f2fs: fix to update iostat correctly in f2fs_filemap_fault()
Date:   Sun, 10 Dec 2023 19:35:47 +0800
Message-Id: <20231210113547.3412782-6-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210113547.3412782-1-chao@kernel.org>
References: <20231210113547.3412782-1-chao@kernel.org>
MIME-Version: 1.0
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

In f2fs_filemap_fault(), it fixes to update iostat info only if
VM_FAULT_LOCKED is tagged in return value of filemap_fault().

Fixes: 8b83ac81f428 ("f2fs: support read iostat")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8af4b29c3e1a..0626da43fa84 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -42,7 +42,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 
 	ret = filemap_fault(vmf);
-	if (!ret)
+	if (ret & VM_FAULT_LOCKED)
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
 					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
 
-- 
2.40.1

