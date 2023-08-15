Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2267377D50C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbjHOVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbjHOVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:23:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEDD1FE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:22:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so9925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692134547; x=1692739347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSOhYSRQ4h4iPkpgTIXcKtQre6JjCPrc8K1miC6Gxzg=;
        b=FTeL/vZoeGRFdukGCRZdl7f8rxJWNdjp1O+cwOt0donlOeTqZilCzFZ21H40oxvyoZ
         y0pPeZQ8EFJouEeCEQBG4hzc8C7dn09cHWuR3fRddcDYZ4nMiSbK6bAtqYDZSEZJizjG
         0pUxdgb+qoT6GdzOr5Oon3nWzrMnJ0/RGRG6YbzPN5vIHdTy379DGn3i3IPOWoUAsev3
         F22AI/j5e4nK8tjMpOGbPXPG2kCVMmIsaPoekbE6LEkrGQ1DrTbBOUkBg79lYXUegZjl
         ee3BGSC3y8777Zg2wSYSvoFGHRxWKY7UCEygAlnruk73BcYKhjF8ue1dWXGYrt2B9uOz
         hVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692134547; x=1692739347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSOhYSRQ4h4iPkpgTIXcKtQre6JjCPrc8K1miC6Gxzg=;
        b=cFEOlrZL8aMe3Kn3u3KsAzCLEfXc+a9GvxuPLeiRrT3zuoI8mdaTedTJFCGIKDfDC0
         OYSDVNdQklXktd4qr4KJQtUcoN3eBVkYIvSyLqxiNV5MTXDsrvb2T4e60gmtdgZarb07
         GxYDsFHJX5umcE7sO7wcNNpCoGaQEvW35EcMnlm1clHJvcy+Xdxzh56eDYRa8ZbUrp6p
         zSNsO8UWYpg7WWeUtSv47lqpaX0bl0TwYKcjx82n9483z/L8Eeb8BXgdf8h0Ep4+vppA
         RzisyECqdsnILOPQZfiuEbAuCE5iOU4QEamuQZoagh/KXtDjSstxApZBLWHx9NH6YKcO
         ewCA==
X-Gm-Message-State: AOJu0YzWFWSMsvHLRI6LVVjnfCYUlzB6EmmZJMU5tYIHopelzs+s2C8d
        IJ0srlLBxDDGpe1H7ZD9UnliXA==
X-Google-Smtp-Source: AGHT+IETS12k29aHBpXnNMvbvGSEb4h9NDHK0rRj1j9kK65gpZbL82l3IBd2HTrxSIlAtqpM5A98lQ==
X-Received: by 2002:a05:600c:314a:b0:3f4:fb7:48d4 with SMTP id h10-20020a05600c314a00b003f40fb748d4mr13947wmo.3.1692134547102;
        Tue, 15 Aug 2023 14:22:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:63c2:1adf:83f0:89cc])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003fe2696ccfcsm18968134wmi.23.2023.08.15.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:22:26 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: userfaultfd: remove stale comment about core dump locking
Date:   Tue, 15 Aug 2023 23:22:16 +0200
Message-ID: <20230815212216.264445-1-jannh@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7f3bfab52cab ("mm/gup: take mmap_lock in get_dump_page()"),
which landed in v5.10, core dumping doesn't enter fault handling without
holding the mmap_lock anymore. Remove the stale parts of the comments, but
leave the behavior as-is - letting core dumping block on userfault handling
would be a bad idea and could lead to deadlocks if the dumping process was
handling its own userfaults.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/userfaultfd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1091cb461747..56eaae9dac1a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -428,15 +428,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * FOLL_DUMP case, anon memory also checks for FOLL_DUMP with
 	 * the no_page_table() helper in follow_page_mask(), but the
 	 * shmem_vm_ops->fault method is invoked even during
-	 * coredumping without mmap_lock and it ends up here.
+	 * coredumping and it ends up here.
 	 */
 	if (current->flags & (PF_EXITING|PF_DUMPCORE))
 		goto out;
 
-	/*
-	 * Coredumping runs without mmap_lock so we can only check that
-	 * the mmap_lock is held, if PF_DUMPCORE was not set.
-	 */
 	assert_fault_locked(vmf);
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;

base-commit: f8a7ed854c1a66b1984a64baf0ece09e44552fab
-- 
2.41.0.694.ge786442a9b-goog

