Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243197BFC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjJJNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJJNAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:00:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798BD1BC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:00:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73107C433C9;
        Tue, 10 Oct 2023 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696942801;
        bh=Xi+Z6sMFlQ/asWuwXVb1mQI8aYoKAasoVIf0fri5JUU=;
        h=Date:From:To:Cc:Subject:From;
        b=fG2qWorUWCfvQAcOdg2BtGbv9Ro/K0B2CpaODoS/VnH9d1Bet0rngO4Io+dDpjVP+
         xWEeIBTjpNic9yaaI0woBajR4QdJvM7htlnYU95Xy+b+dWPiDRtOzdFoWFNbHGJmGX
         jmTIBA72fAJPmxZmwZ6Nxx2gFhjRkcOaKLXGDedAo6tWBD/JxLZ0NR9aEkEjJX5HOw
         pIa+ZKnY0cG2xrcPx6nOz/ZuRjwXweE0onrNwFHyXr/8Goo2WFFtFHdmdJFUnlP/2D
         8EVzEEDBVdK45ixmVGgQvtNo5YFccXrQ0B3xmoUrBzrmyF7B225nBkSc8Pd2jaXkqA
         Drz3Xk1UTpdiA==
Date:   Tue, 10 Oct 2023 06:59:44 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] afs: Add __counted_by for struct afs_acl and use
 struct_size()
Message-ID: <ZSVKwBmxQ1amv47E@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/afs/internal.h | 2 +-
 fs/afs/xattr.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 469a717467a4..e263a58b82ba 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1116,7 +1116,7 @@ extern void afs_fs_inline_bulk_status(struct afs_operation *);
 
 struct afs_acl {
 	u32	size;
-	u8	data[];
+	u8	data[] __counted_by(size);
 };
 
 extern void afs_fs_fetch_acl(struct afs_operation *);
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 9048d8ccc715..8b42cac51660 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -75,7 +75,7 @@ static bool afs_make_acl(struct afs_operation *op,
 {
 	struct afs_acl *acl;
 
-	acl = kmalloc(sizeof(*acl) + size, GFP_KERNEL);
+	acl = kmalloc(struct_size(acl, data, size), GFP_KERNEL);
 	if (!acl) {
 		afs_op_nomem(op);
 		return false;
-- 
2.34.1

