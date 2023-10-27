Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74C7D9460
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJ0J5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345535AbjJ0J52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:57:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656CE9D;
        Fri, 27 Oct 2023 02:57:26 -0700 (PDT)
Date:   Fri, 27 Oct 2023 09:57:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698400644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9QXnNJdPkKLz3x6SPpOv5gxnlzTrafB+QAcDcSFVjbk=;
        b=C1xmK7ui4CY0ifg/pkoMHUlFFFDTvIkclp8t/4z5Ew/8T6xtrNMoojFxKBhEhtpbPFqdZr
        r0VCkGcRe/e7Qi2fUyKf4IwMV9fznJ59+820mM6ft0OvFjH52yC3nmmQR3B/11OndXDE2P
        KwSQwCI3S9zwNojvj7OViAYbp68fSLHQe5d+Yv8SF4ZaTA9195zQbv8FKSVWg+xR2eUTOj
        iz8seTCHVGihsh8/BpTDzE2khhIkQWhh1QX7tGu3YRmt1hFFM5WetteXS5EqbHJ2GAvmGT
        QEUtlrrQLkkVF/7fy4mZtfPrUjg1r31pfbe/ygZcHUOnJpqAhvvlrlzf6iFEBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698400644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9QXnNJdPkKLz3x6SPpOv5gxnlzTrafB+QAcDcSFVjbk=;
        b=cwpyQoIYONl9qCZTaN3dW+o64q+PKt+0okWnMPZI8uOFAWTDKZtis1AQONPiGpNVN2EtYk
        YtjTDeGDUQVG0BDA==
From:   "tip-bot2 for Ben Wolsieffer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Don't include process MM in futex key on no-MMU
Cc:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, andrealmeid@igalia.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231019204548.1236437-2-ben.wolsieffer@hefring.com>
References: <20231019204548.1236437-2-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Message-ID: <169840064334.3135.17333452924302036818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c73801ae4f22b390228ebf471d55668e824198b6
Gitweb:        https://git.kernel.org/tip/c73801ae4f22b390228ebf471d55668e824=
198b6
Author:        Ben Wolsieffer <ben.wolsieffer@hefring.com>
AuthorDate:    Thu, 19 Oct 2023 16:45:49 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 27 Oct 2023 11:53:42 +02:00

futex: Don't include process MM in futex key on no-MMU

On no-MMU, all futexes are treated as private because there is no need
to map a virtual address to physical to match the futex across
processes. This doesn't quite work though, because private futexes
include the current process's mm_struct as part of their key. This makes
it impossible for one process to wake up a shared futex being waited on
in another process.

Fix this bug by excluding the mm_struct from the key. With
a single address space, the futex address is already a unique key.

Fixes: 784bdf3bb694 ("futex: Assume all mappings are private on !MMU systems")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20231019204548.1236437-2-ben.wolsieffer@hefri=
ng.com
---
 kernel/futex/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index ade7c73..52695c5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -252,7 +252,17 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags,=
 union futex_key *key,
 	 *        but access_ok() should be faster than find_vma()
 	 */
 	if (!fshared) {
-		key->private.mm =3D mm;
+		/*
+		 * On no-MMU, shared futexes are treated as private, therefore
+		 * we must not include the current process in the key. Since
+		 * there is only one address space, the address is a unique key
+		 * on its own.
+		 */
+		if (IS_ENABLED(CONFIG_MMU))
+			key->private.mm =3D mm;
+		else
+			key->private.mm =3D NULL;
+
 		key->private.address =3D address;
 		return 0;
 	}
