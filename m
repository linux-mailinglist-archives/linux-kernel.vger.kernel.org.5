Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA12759760
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGSNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGSNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C51A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1D1A6162A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E81C433C7;
        Wed, 19 Jul 2023 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689774654;
        bh=jxSEIgFFgOG/2+9mEHtdiwLWFjzU1BfBqEW1cWXN2HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYhfHhirwP+IqwIhtU2G4WJc0ZWbF9nXm9soVIzoHF02McjRI5GfC4rG3jm1QGQqK
         l6ClKF/zYBPX8v4gRfU+iVV5QIgUu8rOxTXTpgGJkCjzBhlm3o0e/2gbPwemooAV/w
         P/dG6uMokDNnTvmy8FoFRWUZkuT3DeIPRrSsiG+ymqYVzw40smpQpCZq8xA8AQUbJS
         1VL5x+GKGDxSnyeeTWU0dg5FhGlyMNw9E5U6FCR3SzNmJ8Uc9MEC2zabXxqcAOUkdN
         GHYyLWi+3p/v6kcmtDlvg17QZGXqt9VCrKZ6NIrCrulw1pXNOqyjKjFAVsGEgrm3sO
         zaJI1dpPRHsOA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: remove unneeded check condition in __f2fs_setxattr()
Date:   Wed, 19 Jul 2023 21:50:46 +0800
Message-Id: <20230719135047.2947030-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719135047.2947030-1-chao@kernel.org>
References: <20230719135047.2947030-1-chao@kernel.org>
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

It has checked return value of write_all_xattrs(), remove unneeded
following check condition.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 71bfa2391ab4..9cc1ca75b2da 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -757,7 +757,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	if (!error && S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 
 same:
-- 
2.40.1

