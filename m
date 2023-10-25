Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE587D7073
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjJYPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjJYPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:10:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E9137;
        Wed, 25 Oct 2023 08:10:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF730C433C8;
        Wed, 25 Oct 2023 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698246610;
        bh=5IYSi5+bv6T/9zvQT8Sr8Kgq7nbfEkg9R5LoZUk+XAU=;
        h=From:To:Cc:Subject:Date:From;
        b=gjGWXXpJ4opxVzp6XpAqBXTeF7mKMiSEJlrJqIFXaX5gcglzWSaH80LqX4kMqgSRx
         hCnsQOzvR0GeAEvadoWLZhEZXerhE1neV1XnVYBt5Hm0tP1vt057m9a52vfjKol2o8
         vqfksNkgWpb4IJX5T59ovh0XfEdiw55MCRR2Fu5tU7YIH63seMYFD6RK/7NDW/oVaF
         5bD7InamCessTl1Kv4Q9T15zoJhDEk5l5b5AFxKSK0Te71cBo4+3MrInyimoNOkL3K
         Mz2pl2MkddNq4nFowS+OpLNK5Ls6AXJHf8MwqZHCoim6YxobkZCVgBLpoBeTt57MTX
         2fbK5niGJgO7A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "wuqiang . matt" <wuqiang.matt@bytedance.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] locking/atomic: sh: Use generic_cmpxchg_local for arch_cmpxchg_local()
Date:   Thu, 26 Oct 2023 00:10:05 +0900
Message-Id: <169824660459.24340.14614817132696360531.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use __generic_cmpxchg_local() for arch_cmpxchg_local() implementation
in SH architecture because it does not implement arch_cmpxchg_local().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/sh/include/asm/cmpxchg.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 288f6f38d98f..5d617b3ef78f 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -71,4 +71,13 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+#include <asm-generic/cmpxchg-local.h>
+
+#define arch_cmpxchg_local(ptr, o, n) ({				\
+	(__typeof__(*ptr))__generic_cmpxchg_local((ptr),		\
+						  (unsigned long)(o),	\
+						  (unsigned long)(n),	\
+						  sizeof(*(ptr)));	\
+})
+
 #endif /* __ASM_SH_CMPXCHG_H */

