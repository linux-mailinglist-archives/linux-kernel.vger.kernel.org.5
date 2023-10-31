Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82F7DCAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJaKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJaKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:21:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6AA83
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:21:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4697FC433C7;
        Tue, 31 Oct 2023 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698747677;
        bh=gUeRSs5+yXnf0S9xCXa02DoNW17WbzA5LXC/a2PvNWs=;
        h=From:To:Cc:Subject:Date:From;
        b=jTufno9V3ryoUZgaMPBKh6Pqz1x6lKEIKqtD05wojBYkcK0XuphW2MGNmeNskeRxn
         KwV8BBq/WRwMe9M/zTcXhm9NJnTv8OAra9Pm1Ptl9MNXw4Bqg+Fw64LKzu9Z+8vD/q
         DLcw/ML+D27+ih/zb9E66nLwaRvTOuOlxfJUTCSH0/OXRhlfMxI/RuB7HeAN3X+C0X
         ZumIXgFablpFe3809dUhmuy5giuOa5Ta9CIXEe5Aa9F4OFSLhqyml8TuSHmKUYBXmv
         nJNE7bvvl5hQ6bZzE6ZVEvuEdKT/ldij+6q/1rlF6EqC0CeQ/0Ndg7tJ3/8F6tA751
         0txdy0G0KMbdw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     bp@alien8.de
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86: Let AS_WRUSS depend on X86_64
Date:   Tue, 31 Oct 2023 11:21:11 +0100
Message-ID: <20231031102111.32142-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 18e66b695e78 ("x86/shstk: Add Kconfig option for shadow
stack"), AS_WRUSS is set even in 32-bit .configs. It is due to how
Kbuild works. .config is not considered during make oldconfig (and other
make *config), so standard (64-bit) gcc is invoked from 'as-instr'
Kbuild tests. And such gcc indeed reports that wruss is supported, so
AS_WRUSS=y is set.

Provided the wruss instruction is 64-bit only (and used in pure 64-bit
X86_USER_SHADOW_STACK), it has little sense to have AS_WRUSS=y set on
32-bit.

Therefore, make the whole test dependent on X86_64 to ensure it's set
only on 64-bit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>
Cc: John Allen <john.allen@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/Kconfig.assembler | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 8ad41da301e5..a5b5241711e3 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -27,5 +27,6 @@ config AS_GFNI
 
 config AS_WRUSS
 	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
+	depends on X86_64
 	help
 	  Supported by binutils >= 2.31 and LLVM integrated assembler
-- 
2.42.0

