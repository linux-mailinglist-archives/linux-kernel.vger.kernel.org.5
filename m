Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FA87CE5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjJRSKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjJRSKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:10:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E42798
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:10:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AC1C433C8;
        Wed, 18 Oct 2023 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697652642;
        bh=LHAZNYWjlZE9o69WQzFu8+hQ8gDUBGEq47VgG8s8Jbo=;
        h=From:Date:Subject:To:Cc:From;
        b=d0NBQx/8FT0zlB+fVZUbNnWE/GyAwzzz7pIV+Dwma+/2ur8BYFMvKqPaXK0g+aC7k
         YBJVOzNaTz1DHqUKaYKtJyRRqs7LX64eod8ISgBjcZtt6WRJ1lh0csPAddtxZILqVD
         KH8fLCCEPUVZB3FKUQleCdKdFdvKLN4aS1tSeIWg2wfdrIKQinxiypcohiDmoIzTE6
         sU+cn3arw3tF62wk26PoJm8PVoYHYwUHB+pL0B2PXJAADRblAlOruQxD+F0gwD3fuv
         voo+23LmG60T4KDOrg2uh94e+PdZjzPVzSvnxW1XBEEAdw44g1BfP0ckogdqHE9coj
         htOWjJ8BuMkGw==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 18 Oct 2023 11:10:31 -0700
Subject: [PATCH] eventfs: Use ERR_CAST() in eventfs_create_events_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-ftrace-fix-clang-randstruct-v1-1-338cb214abfb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJYfMGUC/x3MQQqEMAxA0atI1hNoK4rOVYZZ1Bg1IJ0hrSKId
 ze4/PD4J2RW4Qzv6gTlXbL8koV/VUBLTDOjjNYQXKi98x1ORSMxTnIgrQZQYxpz0Y0KOhraru+
 bUEcCO/yVzT33z/e6bhnL/RptAAAA
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     keescook@chromium.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=nathan@kernel.org;
 h=from:subject:message-id; bh=LHAZNYWjlZE9o69WQzFu8+hQ8gDUBGEq47VgG8s8Jbo=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkG8gtn+x73+DjpvvHTQGGfrms5qe6ib3NTH/5dYsv6e
 1MS01a2jlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRpxkM/9N3rpAIVniru/n1
 zDihy8cf228q/74i7JGmWcvNc7s/Jl9j+MNb9fT7wmWy626JpE1h/3/Q+ovP4dfuoRysIREXG2d
 3L+EAAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang and CONFIG_RANDSTRUCT_FULL=y, there is an error
due to a cast in eventfs_create_events_dir():

  fs/tracefs/event_inode.c:734:10: error: casting from randomized structure pointer type 'struct dentry *' to 'struct eventfs_inode *'
    734 |                 return (struct eventfs_inode *)dentry;
        |                        ^
  1 error generated.

Use the ERR_CAST() function to resolve the error, as it was designed for
this exact situation (casting an error pointer to another type).

Closes: https://github.com/ClangBuiltLinux/linux/issues/1947
Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1ccd100bc565..9f19b6608954 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -731,7 +731,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 		return NULL;
 
 	if (IS_ERR(dentry))
-		return (struct eventfs_inode *)dentry;
+		return ERR_CAST(dentry);
 
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)

---
base-commit: 5ddd8baa4857709b4e5d84b376d735152851955b
change-id: 20231018-ftrace-fix-clang-randstruct-0cb6899523ac

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

