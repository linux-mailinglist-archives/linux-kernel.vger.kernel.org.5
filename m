Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E37F862E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjKXWcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjKXWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:32:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8710E2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:32:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7070AC433CA;
        Fri, 24 Nov 2023 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700865166;
        bh=SruwsS2l79TbUPDZT8+hJEb5a4kT01b9VD/LZ7J5AKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/lnFaSVMQiMkEsslwmzjqzy22MQXd8r9dOLxCa7TLWnoQvJK3pQYuE+Q6CrbEoyR
         39RMK7baBkVlSAzMhxWIcg0mYsY1sVWkYmD7FkCurSO46YSXqsjEIDzPqOUbgXsK63
         FrjQ75lmSpZu6ETzAaNH/vz7tuQvdYh2RmvwuKVhJT3Osmh1h/AU7TIvg2inx3mdMd
         ZSEbZeLhQldnmaE5WqzqY3UPniXAsGIpPw26G6aZrTQOnaTyR73iSfEFzIgSYztgH1
         740u66mQXDlK06o2pQUyCJzQf3vn4xdoPoqlU1Bn+bD2I/HX6a0CQkejm6GKWo+zh0
         jjdqFVncadX3A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/7] x86: Add a comment about the "magic" behind shadow sti before mwait
Date:   Fri, 24 Nov 2023 23:32:21 +0100
Message-ID: <20231124223226.24249-3-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124223226.24249-1-frederic@kernel.org>
References: <20231124223226.24249-1-frederic@kernel.org>
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

Add a note to make sure we never miss and break the requirements behind
it.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index bae83810505b..920426d691ce 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -87,6 +87,15 @@ static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
+/*
+ * Re-enable interrupts right upon calling mwait in such a way that
+ * no interrupt can fire _before_ the execution of mwait, ie: no
+ * instruction must be placed between "sti" and "mwait".
+ *
+ * This is necessary because if an interrupt queues a timer before
+ * executing mwait, it would otherwise go unnoticed and the next tick
+ * would not be reprogrammed accordingly before mwait ever wakes up.
+ */
 static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
-- 
2.42.1

