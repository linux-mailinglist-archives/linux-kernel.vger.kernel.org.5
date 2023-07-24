Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E075F618
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGXMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjGXMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF8F1BFB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21ED261124
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7062EC433C9;
        Mon, 24 Jul 2023 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690201108;
        bh=45Se94dVdCFvx+5A8Mg8jjIemAM8HzFY/Qq3WqvS/Bk=;
        h=From:To:Cc:Subject:Date:From;
        b=Qc1oPZGLNJH1Km8MPHyzHZaxb8mD43sAp4g8VKyN7oPUXoA75Hf6LrR7WGsX1HzXt
         1FsBi+NbH6djpiLlqWgtc/TYjqomaQziy642wxU0y+M7G/3BAE6ZuUjWE1rsxnMuWz
         tAEFTXkxNvMhw0HK4Qe1zFL8PqOXadTgTBRPXEgk4R6jpu/8K+X8m4NkMr3hEAEFb1
         5e6jX4z/3LIB6a6a491Zm29vnzjnLLV32Csf994rL9ZeJ7Iru7plwB0+sdDH4pQOTm
         /fjrorE1pEtoY+lJVrSJh9LjWc17m1PaT1cA3t7no7xniMNo99DFHyrUSjCmRgIA8O
         G3BmTjZhncoSQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernfs: add stub helper for kernfs_generic_poll()
Date:   Mon, 24 Jul 2023 14:18:16 +0200
Message-Id: <20230724121823.1357562-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

In some randconfig builds, kernfs ends up being disabled, so there is no prototype
for kernfs_generic_poll()

In file included from kernel/sched/build_utility.c:97:
kernel/sched/psi.c:1479:3: error: implicit declaration of function 'kernfs_generic_poll' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                kernfs_generic_poll(t->of, wait);
                ^

Add a stub helper for it, as we have it for other kernfs functions.

Fixes: aff037078ecae ("sched/psi: use kernfs polling functions for PSI trigger polling")
Fixes: 147e1a97c4a0b ("fs: kernfs: add poll file operation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
While the stub was always missing, this only caused problems now that sched/psi.c
calls it unconditionally. The patch that caused it was already merged into v6.5-rc2
---
 include/linux/kernfs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73f5c120def88..2a36f3218b510 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -550,6 +550,10 @@ static inline int kernfs_setattr(struct kernfs_node *kn,
 				 const struct iattr *iattr)
 { return -ENOSYS; }
 
+static inline __poll_t kernfs_generic_poll(struct kernfs_open_file *of,
+					   struct poll_table_struct *pt)
+{ return -ENOSYS; }
+
 static inline void kernfs_notify(struct kernfs_node *kn) { }
 
 static inline int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
-- 
2.39.2

