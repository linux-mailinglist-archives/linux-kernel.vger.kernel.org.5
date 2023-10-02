Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1557B5AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjJBTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjJBTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:01:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA75B3;
        Mon,  2 Oct 2023 12:01:50 -0700 (PDT)
Date:   Mon, 02 Oct 2023 19:01:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696273308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5JVuozAWsvYoCCJ91LTdlldPKoE+8ohqohFARoyNwo=;
        b=h8XkvrNMlxZ8jPuDgfBEDxnScR1jtOn/WjRkutzFG66wB332lkBYS9UDLLZY9qkVCaQuEW
        LCAZyoy6NS8W5aSj9Mpkn5TadkNUBMEZPqQi3nbPb5cE8puRUAuOHoScyGIpgK1Flhnw8s
        u7/jKst+/84DlX84OLmm/EkLwi5blkih55DCqJQ2wFZsiQ4MFvR5vyF1oWW5z0zmQUhTz3
        TsMQAl3YgE11/34SEbjwO7IXLrUMPpG5DbkAmsvZlYp/w3hVXQmQyjrLVSyOOAeCsdFzJS
        fv5t42qTFZ69vfgPUkhOYxuVpoO7S+W064hRESIyKN9pj9olQHVa7WRpf3soYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696273308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5JVuozAWsvYoCCJ91LTdlldPKoE+8ohqohFARoyNwo=;
        b=FBt+lmTWi0C4QAfLx2kJaieFps1629b+dnsCPXex9mOE87mDvw0BR2K2eF2AxAAMy6tHBc
        Qj05AMx56uWwhYBQ==
From:   "tip-bot2 for Kir Kolyshkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Move 'struct sched_param' out of
 uapi, to work around glibc/musl breakage
Cc:     Kir Kolyshkin <kolyshkin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230808030357.1213829-1-kolyshkin@gmail.com>
References: <20230808030357.1213829-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Message-ID: <169627330795.3135.16650166898816781742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d844fe65f0957024c3e1b0bf2a0615246184d9bc
Gitweb:        https://git.kernel.org/tip/d844fe65f0957024c3e1b0bf2a061524618=
4d9bc
Author:        Kir Kolyshkin <kolyshkin@gmail.com>
AuthorDate:    Mon, 07 Aug 2023 20:03:57 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 02 Oct 2023 20:48:16 +02:00

sched/headers: Move 'struct sched_param' out of uapi, to work around glibc/mu=
sl breakage

Both glibc and musl define 'struct sched_param' in sched.h, while kernel
has it in uapi/linux/sched/types.h, making it cumbersome to use
sched_getattr(2) or sched_setattr(2) from userspace.

For example, something like this:

	#include <sched.h>
	#include <linux/sched/types.h>

	struct sched_attr sa;

will result in "error: redefinition of =E2=80=98struct sched_param=E2=80=99" =
(note the
code doesn't need sched_param at all -- it needs struct sched_attr
plus some stuff from sched.h).

The situation is, glibc is not going to provide a wrapper for
sched_{get,set}attr, thus the need to include linux/sched_types.h
directly, which leads to the above problem.

Thus, the userspace is left with a few sub-par choices when it wants to
use e.g. sched_setattr(2), such as maintaining a copy of struct
sched_attr definition, or using some other ugly tricks.

OTOH, 'struct sched_param' is well known, defined in POSIX, and it won't
be ever changed (as that would break backward compatibility).

So, while 'struct sched_param' is indeed part of the kernel uapi,
exposing it the way it's done now creates an issue, and hiding it
(like this patch does) fixes that issue, hopefully without creating
another one: common userspace software rely on libc headers, and as
for "special" software (like libc), it looks like glibc and musl
do not rely on kernel headers for 'struct sched_param' definition
(but let's Cc their mailing lists in case it's otherwise).

The alternative to this patch would be to move struct sched_attr to,
say, linux/sched.h, or linux/sched/attr.h (the new file).

Oh, and here is the previous attempt to fix the issue:

  https://lore.kernel.org/all/20200528135552.GA87103@google.com/

While I support Linus arguments, the issue is still here
and needs to be fixed.

[ mingo: Linus is right, this shouldn't be needed - but on the other
         hand I agree that this header is not really helpful to
	 user-space as-is. So let's pretend that
	 <uapi/linux/sched/types.h> is only about sched_attr, and
	 call this commit a workaround for user-space breakage
	 that it in reality is ... Also, remove the Fixes tag. ]

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230808030357.1213829-1-kolyshkin@gmail.com
---
 include/linux/sched.h            | 5 ++++-
 include/uapi/linux/sched/types.h | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index dc37ae7..e4235bb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -63,7 +63,6 @@ struct robust_list_head;
 struct root_domain;
 struct rq;
 struct sched_attr;
-struct sched_param;
 struct seq_file;
 struct sighand_struct;
 struct signal_struct;
@@ -370,6 +369,10 @@ extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
 #endif
=20
+struct sched_param {
+	int sched_priority;
+};
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/type=
s.h
index f2c4589..9066238 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -4,10 +4,6 @@
=20
 #include <linux/types.h>
=20
-struct sched_param {
-	int sched_priority;
-};
-
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
=20
