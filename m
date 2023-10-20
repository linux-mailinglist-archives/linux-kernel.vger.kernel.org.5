Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A87D0A63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjJTIRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjJTIRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:17:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2ED4C;
        Fri, 20 Oct 2023 01:17:18 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697789837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsqPwfyurPJ1VtPXLRho0qj1rZQk0nk+5pGX9DJXsUY=;
        b=yCDqz2C29mZoRx932kaYG/ZhAG+T28J8Z8tiBn/ERJKT+VoRx/II02b0dO6pWnBWut+AVS
        hMqo2Rl9H8hpQ8Rr8rGQTbIspcTW8HxDFLTPn4ZD1BNCb294xDstbsTWG2Rc0pEkFgCvIg
        b2CPTMvYr3qVg6mOHt3DG/Jv4jH/e0c/7W9y5tVws5I7r8yUIfP2lCpTjWzb0MbhzoVmQT
        giS7ICUIQ4GYUFwbMV/TxS3a3kdVkDdyEBxcT7DZaKNmNqr1WK9Boc7UDhkrHBgDcK6AwL
        lZxCHxGdNMPlDpnqNSd3i0+iYEQWA4caxLWpJX4YkulvSnlXKOGN9gKWfEdQRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697789837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsqPwfyurPJ1VtPXLRho0qj1rZQk0nk+5pGX9DJXsUY=;
        b=NStoGS8HezU5E7a5aR4Dsk3/dfk5hW1lWESEhqL98dFElSs6vlwqCJJn09Yb6nQNhuTo2m
        wMjYotDHN1KiB6Dw==
From:   "tip-bot2 for Ben Wolsieffer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Don't include process in key on no-MMU
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
Message-ID: <169778983624.3135.4029741609341875607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a684725f587b45955bfc0eadc5ebb36b6dbfb8b6
Gitweb:        https://git.kernel.org/tip/a684725f587b45955bfc0eadc5ebb36b6db=
fb8b6
Author:        Ben Wolsieffer <ben.wolsieffer@hefring.com>
AuthorDate:    Thu, 19 Oct 2023 16:45:49 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 10:12:16 +02:00

futex: Don't include process in key on no-MMU

On no-MMU, all futexes are treated as private because there is no need
to map a virtual address to physical to match the futex across
processes. This doesn't quite work though, because private futexes
include the current process's mm_struct as part of their key. This makes
it impossible for one process to wake up a shared futex being waited on
in another process.

This patch fixes this bug by excluding the mm_struct from the key. With
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
