Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6158C7D5469
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbjJXOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjJXOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:53:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B9B3;
        Tue, 24 Oct 2023 07:53:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE6C433C7;
        Tue, 24 Oct 2023 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698159179;
        bh=nksVzI2sxDyYwDK77Qh9hxtLz14PivSCoDF4mQ1mj4M=;
        h=From:To:Cc:Subject:Date:From;
        b=U16Q1nagA13WjsyrcYED+UgO0KdXjAHJxAU+n3rpd3ZUpmkIBNkBu3gpqgxL+2XnS
         QCfnDZMDDr48vspTq6FbzfRkGKiL5iVVJxn7dPKtacOMB3UIYGdNKeMW9zd3NoVf5Y
         V/BbtVZzMT6VG/GXa0kFIHsDSiQ5Kp8fS+29YN/VyrMTqthZD7upb3D0ly473Oig5L
         abhyJip2bIy7BvNrl7pJ+nGrVEYaSFq8zciCTTTItv7GQZ2xp1bgbq9QrjJvWDyyU/
         vaviig+xb8SZlBmHn9g+T8fxT8/gGiRrzU5YTdlWCUdUHfCLnPwGUw+PeRv48tJL1l
         59OBo/Cb6GHrg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "wuqiang . matt" <wuqiang.matt@bytedance.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for arch_cmpxchg_local()
Date:   Tue, 24 Oct 2023 23:52:54 +0900
Message-Id: <169815917362.8695.13904684741526725648.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
in SH architecture because it does not implement arch_cmpxchg_local().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/sh/include/asm/cmpxchg.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 288f6f38d98f..e920e61fb817 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+#include <asm-generic/cmpxchg-local.h>
+
 #endif /* __ASM_SH_CMPXCHG_H */

