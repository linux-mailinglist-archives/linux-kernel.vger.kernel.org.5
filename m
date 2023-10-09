Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB367BE8AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378015AbjJIRtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377934AbjJIRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:49:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF51DB;
        Mon,  9 Oct 2023 10:49:10 -0700 (PDT)
Date:   Mon, 09 Oct 2023 17:49:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696873748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QWdXMdn/ZA+CKPOIzbK9ahmLd6E9Xf93k/1EC4YxxVA=;
        b=jQoHI9EBuZgka37wd6bL90rYdONSLZg2pOdQnOEDpuaZOPQ5rVgoRYuEaTXcmzhtSS7vlI
        QcLid9d8b8LXIqIGjr00FMU8eFwVlh9npm16YD0ZEg8OIyMXnqZADEBL5b3dmU2pDb1otb
        s+wGLUxxykySzKP/FWj2BuLS92CCAC15NNyDIZOQ0o0pjTn3HZoBi8k+GapyGrOIb4jJKy
        Ij1Atb2sKIsPFEQ2xhtukXBmNXAuEzcH1sof9O6E1NCxX+V1DkZefRGvIZPp4bRiboznXw
        uNp4IqgdymccInwpLW/O8owRFfvO9u6qKFUNWRUV5tIC6Lu1Q9zBoDhZJp9a/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696873748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QWdXMdn/ZA+CKPOIzbK9ahmLd6E9Xf93k/1EC4YxxVA=;
        b=XqwL/fk8g+76WdVThZg7spTjGRXiY2kac9gi4qAIoDuOB8qk/MYpAHOgDLNowiOlH9lNKC
        rZWQ15Xx16ApQNCQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Introduce arch_sync_try_cmpxchg()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169687374799.3135.12810563510258476664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     636d6a8b850a2bb8462b5f743c9db9aa4d735cda
Gitweb:        https://git.kernel.org/tip/636d6a8b850a2bb8462b5f743c9db9aa4d735cda
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 25 Sep 2023 16:55:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 18:14:25 +02:00

locking/atomic/x86: Introduce arch_sync_try_cmpxchg()

Introduce the arch_sync_try_cmpxchg() macro to improve code using
sync_try_cmpxchg() locking primitive. The new definitions use existing
__raw_try_cmpxchg() macros, but use its own "lock; " prefix.

The new macros improve assembly of the cmpxchg loop in
evtchn_fifo_unmask() from drivers/xen/events/events_fifo.c from:

 57a:	85 c0                	test   %eax,%eax
 57c:	78 52                	js     5d0 <...>
 57e:	89 c1                	mov    %eax,%ecx
 580:	25 ff ff ff af       	and    $0xafffffff,%eax
 585:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
 58c:	81 e1 ff ff ff ef    	and    $0xefffffff,%ecx
 592:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
 596:	89 44 24 08          	mov    %eax,0x8(%rsp)
 59a:	8b 74 24 08          	mov    0x8(%rsp),%esi
 59e:	8b 44 24 04          	mov    0x4(%rsp),%eax
 5a2:	f0 0f b1 32          	lock cmpxchg %esi,(%rdx)
 5a6:	89 04 24             	mov    %eax,(%rsp)
 5a9:	8b 04 24             	mov    (%rsp),%eax
 5ac:	39 c1                	cmp    %eax,%ecx
 5ae:	74 07                	je     5b7 <...>
 5b0:	a9 00 00 00 40       	test   $0x40000000,%eax
 5b5:	75 c3                	jne    57a <...>
 <...>

to:

 578:	a9 00 00 00 40       	test   $0x40000000,%eax
 57d:	74 2b                	je     5aa <...>
 57f:	85 c0                	test   %eax,%eax
 581:	78 40                	js     5c3 <...>
 583:	89 c1                	mov    %eax,%ecx
 585:	25 ff ff ff af       	and    $0xafffffff,%eax
 58a:	81 e1 ff ff ff ef    	and    $0xefffffff,%ecx
 590:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
 594:	89 44 24 08          	mov    %eax,0x8(%rsp)
 598:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
 59c:	8b 44 24 04          	mov    0x4(%rsp),%eax
 5a0:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
 5a4:	89 44 24 04          	mov    %eax,0x4(%rsp)
 5a8:	75 30                	jne    5da <...>
 <...>
 5da:	8b 44 24 04          	mov    0x4(%rsp),%eax
 5de:	eb 98                	jmp    578 <...>

The new code removes move instructions from 585: 5a6: and 5a9:
and the compare from 5ac:. Additionally, the compiler assumes that
cmpxchg success is more probable and optimizes code flow accordingly.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index d536365..5612648 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,12 +221,18 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
+#define __sync_try_cmpxchg(ptr, pold, new, size)			\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock; ")
+
 #define __try_cmpxchg_local(ptr, pold, new, size)			\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
 
 #define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+#define arch_sync_try_cmpxchg(ptr, pold, new) 				\
+	__sync_try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
+
 #define arch_try_cmpxchg_local(ptr, pold, new)				\
 	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
 
