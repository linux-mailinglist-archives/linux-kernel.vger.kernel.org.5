Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B57BFBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJJMrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJJMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:46:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992299
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:46:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4903C433C8;
        Tue, 10 Oct 2023 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696942018;
        bh=knh9lxB2dNgPZ1euXXn82WdFpZKIB9XIHk6ythKlouc=;
        h=Date:From:To:Cc:Subject:From;
        b=dC0DHgjw3VtLh8cQ3kYe/L78FbRWlOvMsX9oohjbkBB9XPOui28VOa9BETiUJRM3P
         IOkj/tgMvv/GpKQIixGpE+CjJ49llPZWCwsfvJiNrr/uiAPFAhfjYbMHsmxpdYPPT5
         +3iG8hKPjY7TnD8e3DGGjSMwKQ3D4q1zc/Y7YYwdhrGg9teqbSVEUaQL0a/IyXiRx3
         Md2MYGD9nR7kNWd3XHcS9uiZsksC9Pt7SyreonpU/rWUruXeyZ4Jh+v3r38R99of+g
         NaMR28hHJAHMgwyUGFfkhqJ+TiSSMvGVT8eRzyRyr/tdgSOcwqCU6uIuRY5Xyt06se
         jUMWz6hDK4JUg==
Date:   Tue, 10 Oct 2023 06:46:50 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] atags_proc: Add __counted_by for struct buffer and use
 struct_size()
Message-ID: <ZSVHurzo/4aFQcT3@work>
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
 arch/arm/kernel/atags_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 3ec2afe78423..cd09f8ab93e3 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -7,7 +7,7 @@
 
 struct buffer {
 	size_t size;
-	char data[];
+	char data[] __counted_by(size);
 };
 
 static ssize_t atags_read(struct file *file, char __user *buf,
@@ -54,7 +54,7 @@ static int __init init_atags_procfs(void)
 
 	WARN_ON(tag->hdr.tag != ATAG_NONE);
 
-	b = kmalloc(sizeof(*b) + size, GFP_KERNEL);
+	b = kmalloc(struct_size(b, data, size), GFP_KERNEL);
 	if (!b)
 		goto nomem;
 
-- 
2.34.1

