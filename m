Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DD80A930
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574475AbjLHQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjLHQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:35:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969311995
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D15C433CA;
        Fri,  8 Dec 2023 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053322;
        bh=Z4H+/v658tdpIUS/M5eM4mkmmspGMz1KhbqU6pOZF5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qErDFEmodD4DDHqqZIhdZcw0R/xgNXnvkXsREwRbPKKokGq2qG2xZUkfREtkgqGnA
         4g84nEMw28/wbN9hRCzkZPhe6Y5ZKK3qerh7amZTHf9IZt+IiARhqVLNQC5j6Z8LoG
         F1Smct9Ycj0BSKp8chdrfrR9LExLy9vL0FIz1AvGHUJb4Dw9KnAlIkDzfl+sELiG3+
         B43QVHxSh3P4pn4Epgg+Cvx/CPHy4DBXdlZkgSFdGN3u8Q+2DjbVyjdupIX7QmqBdV
         Z8klsrgLmfc8dE0QjCKTTOeln31fMuYCkbfVP3mZDbMPdKhvUQ89P81GHQAuV2t2HA
         Vx0ZkALRS12pA==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 5/9] powerpc/kprobes: Use ftrace to determine if a probe is at function entry
Date:   Fri,  8 Dec 2023 22:00:44 +0530
Message-ID: <15f0b3a2e72326423cfb4ce4e89afff540042245.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than hard-coding the offset into a function to be used to
determine if a kprobe is at function entry, use ftrace_location() to
determine the ftrace location within the function and categorize all
instructions till that offset to be function entry.

For functions that cannot be traced, we fall back to using a fixed
offset of 8 (two instructions) to categorize a probe as being at
function entry for 64-bit elfv2.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/kprobes.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index b20ee72e873a..42665dfab59e 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -105,24 +105,22 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 	return addr;
 }
 
-static bool arch_kprobe_on_func_entry(unsigned long offset)
+static bool arch_kprobe_on_func_entry(unsigned long addr, unsigned long offset)
 {
-#ifdef CONFIG_PPC64_ELF_ABI_V2
-#ifdef CONFIG_KPROBES_ON_FTRACE
-	return offset <= 16;
-#else
-	return offset <= 8;
-#endif
-#else
+	unsigned long ip = ftrace_location(addr);
+
+	if (ip)
+		return offset <= (ip - addr);
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
+		return offset <= 8;
 	return !offset;
-#endif
 }
 
 /* XXX try and fold the magic of kprobe_lookup_name() in this */
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	*on_func_entry = arch_kprobe_on_func_entry(offset);
+	*on_func_entry = arch_kprobe_on_func_entry(addr, offset);
 	return (kprobe_opcode_t *)(addr + offset);
 }
 
-- 
2.43.0

