Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159D806556
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjLFDAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjLFDAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:00:47 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79F1AA;
        Tue,  5 Dec 2023 19:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CRYeTAu4svuvDJpTKsWkQ36MOqp3Y1tO+HPMsezk7QU=; b=UGCB/HMxCuoH0kFgL4hrI3koRN
        ATSArs23UpdraQQVBBYMojJjygn1M1gqfoTIlWDBwto1vZDJhu7MgpKz4D4+Xudb3C1Rpp+3pGN6k
        FD4NljAXVHQq7905LuDDH5T34DBSZa8NGrfJOalyKhAMplJM7FUGPNVZxtapsE1DP4wrT1PpGMe+R
        17NDxSvSIzv1DGg41XUagyV+JVvsIvjk19blOHoeFWDJT3WZTos+LJE4iZiKRqnW+uN3/q9uOtSAD
        ICFYUVuT1SkRdC3xKwHSPHd3ZZDEuO8TvG6SYoZJx48PNXw5/c3R7wi7cCXF/JYG+zyzEmgXS8Wce
        l3MlFD7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAi9X-007Yl3-1L;
        Wed, 06 Dec 2023 03:00:47 +0000
Date:   Wed, 6 Dec 2023 03:00:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg KH <greg@kroah.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231206030047.GL1674809@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
 <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
 <2023120657-henna-spongy-9ef6@gregkh>
 <20231206005542.GJ1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206005542.GJ1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:55:42AM +0000, Al Viro wrote:
> On Wed, Dec 06, 2023 at 08:46:50AM +0900, Greg KH wrote:
> > > >
> > > > But of course, it doesn't always hold true, there are a few minor
> > > > exceptions, but they are rare.
> > > 
> > > $ grep -r \\#include lib | grep asm
> > > 
> > > shows quite a few exceptions, and just in lib/.
> > > 
> > > For example, lib/math/int_log.c includes asm/bug.h.  Is that a case
> > > where lib/math/int_log.c should be #include 'ing linux/bug.h rather
> > > than asm/bug.h?
> > 
> > Probably yes, but we don't normally go back and take coding style fixes
> > for old files like this as it doesn't make much sense to do so.
> > 
> > But, if you are cleaning up the headers for large portions with the goal
> > of faster builds, that's a good reason.
> 
> FWIW, the most common (by far - about 13% of such includes, over drivers/, fs/,
> mm/, net/ and sound/) is asm/unaligned.h.

Why the hell is unaligned.h in asm/*, anyway?

We have 3 variants: arc, parisc and generic (== everything else).
Both arc and parisc instances have an explicit include of
asm-generic/unaligned.h (i.e. the generic variant).

On arc there's also misaligned_fixup() extern or stub, with exactly
one user (in arch/arc/kernel/traps.c).  On parisc there are
externs for handle_unaligned() and check_unaligned() (3 call sites,
all in arch/parisc/kernel/traps.c).

How about we take those into arch/{arc,parisc}/kernel/unaligned.h,
slap #include "unaligned.h" into their traps.c and unaligned.c
(callers and definitions resp.) and strip those from asm/unaligned.h?
At that point we can remove arch/{arc,parisc}/asm/unaligned.h - everything
will pick include/asm-generic/unaligned.h.

Then the next cycle we ask Linus to run the following:
for i in `git grep -l -w asm/unaligned.h`; do
	sed -i -e "s/asm\/unaligned.h/linux\/unaligned.h/" $i
done
git mv include/asm-generic/unaligned.h include/linux/unaligned.h
sed -i -e "/unaligned.h/d" include/asm-generic/Kbuild
right before releasing -rc1 and asm/unaligned.h is gone...

Completely untested delta (for the non-automatic parts, that is) follows:
------------------
arc, parisc: get rid of private asm/unaligned.h

Declarations local to arch/*/kernel/*.c are better off *not* in a public
header - arch/{arc,parisc}/kernel/unaligned.h is just fine for those
bits.

With that done these asm/unaligned.h instances are reduced to include
of asm-generic/unaligned.h and can be removed - unaligned.h is in
mandatory-y in include/asm-generic/Kbuild.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/arc/include/asm/unaligned.h b/arch/arc/include/asm/unaligned.h
deleted file mode 100644
index cf5a02382e0e..000000000000
--- a/arch/arc/include/asm/unaligned.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef _ASM_ARC_UNALIGNED_H
-#define _ASM_ARC_UNALIGNED_H
-
-/* ARC700 can't handle unaligned Data accesses. */
-
-#include <asm-generic/unaligned.h>
-#include <asm/ptrace.h>
-
-#ifdef CONFIG_ARC_EMUL_UNALIGNED
-int misaligned_fixup(unsigned long address, struct pt_regs *regs,
-		     struct callee_regs *cregs);
-#else
-static inline int
-misaligned_fixup(unsigned long address, struct pt_regs *regs,
-		 struct callee_regs *cregs)
-{
-	/* Not fixed */
-	return 1;
-}
-#endif
-
-#endif /* _ASM_ARC_UNALIGNED_H */
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index 9b9570b79362..8e40f0881e02 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -20,6 +20,7 @@
 #include <asm/setup.h>
 #include <asm/unaligned.h>
 #include <asm/kprobes.h>
+#include "unaligned.h"
 
 void die(const char *str, struct pt_regs *regs, unsigned long address)
 {
diff --git a/arch/arc/kernel/unaligned.c b/arch/arc/kernel/unaligned.c
index 99a9b92ed98d..d2f5ceaaed1b 100644
--- a/arch/arc/kernel/unaligned.c
+++ b/arch/arc/kernel/unaligned.c
@@ -12,6 +12,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <asm/disasm.h>
+#include "unaligned.h"
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define BE		1
diff --git a/arch/arc/kernel/unaligned.h b/arch/arc/kernel/unaligned.h
new file mode 100644
index 000000000000..5244453bb85f
--- /dev/null
+++ b/arch/arc/kernel/unaligned.h
@@ -0,0 +1,16 @@
+struct pt_regs;
+struct callee_regs;
+
+#ifdef CONFIG_ARC_EMUL_UNALIGNED
+int misaligned_fixup(unsigned long address, struct pt_regs *regs,
+		     struct callee_regs *cregs);
+#else
+static inline int
+misaligned_fixup(unsigned long address, struct pt_regs *regs,
+		 struct callee_regs *cregs)
+{
+	/* Not fixed */
+	return 1;
+}
+#endif
+
diff --git a/arch/parisc/include/asm/unaligned.h b/arch/parisc/include/asm/unaligned.h
deleted file mode 100644
index c0621295100d..000000000000
--- a/arch/parisc/include/asm/unaligned.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_PARISC_UNALIGNED_H
-#define _ASM_PARISC_UNALIGNED_H
-
-#include <asm-generic/unaligned.h>
-
-struct pt_regs;
-void handle_unaligned(struct pt_regs *regs);
-int check_unaligned(struct pt_regs *regs);
-
-#endif /* _ASM_PARISC_UNALIGNED_H */
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 1107ca819ac8..7ab0d44ef698 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -47,6 +47,8 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 
+#include "unaligned.h"
+
 #if defined(CONFIG_LIGHTWEIGHT_SPINLOCK_CHECK)
 #include <asm/spinlock.h>
 #endif
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index ce25acfe4889..39cd222366bb 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -15,6 +15,7 @@
 #include <asm/unaligned.h>
 #include <asm/hardirq.h>
 #include <asm/traps.h>
+#include "unaligned.h"
 
 /* #define DEBUG_UNALIGNED 1 */
 
diff --git a/arch/parisc/kernel/unaligned.h b/arch/parisc/kernel/unaligned.h
new file mode 100644
index 000000000000..c1aa4b12e284
--- /dev/null
+++ b/arch/parisc/kernel/unaligned.h
@@ -0,0 +1,3 @@
+struct pt_regs;
+void handle_unaligned(struct pt_regs *regs);
+int check_unaligned(struct pt_regs *regs);
