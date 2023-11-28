Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3D7FC8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345990AbjK1VMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346759AbjK1VLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:11:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004D94C33
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:09:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD36C433B6;
        Tue, 28 Nov 2023 21:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205745;
        bh=tcud/Eg7by764OGVtAfT59O6ABNRuhiQsjaVx3w5b3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnlOH+kMDjSwmvxpWwNHuvkS7B7woBQm3/0H4O0r+5f66IUL5KSHRdcfi+Ghd0D5/
         1AMKdgagF2j7A/GFPAH4a0JKpcFW9+SlkQMwawLIWKS4YJ1YEMpfOwfRN/3G6UpRxL
         sMZkV7boXUkUh3MHYPL82t5a7DznY5FxpFYs+VKtXYi4TaQCtbmiNqDLj/Bj1Uhs2p
         bWWUuG0zuyDHxalponNb6zQVCDu4nvOy11bdpzbl6V7PETQtlTzqqfSIYiT0IHyAQP
         IkmQ3vyO+935in0+OGjmtR+aVxflW1bQISXH6RJmvS7cRMeb7RHxYsaxVC5F0HZM7X
         VgYT3GS8Ix1/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/15] asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation
Date:   Tue, 28 Nov 2023 16:08:35 -0500
Message-ID: <20231128210843.876493-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210843.876493-1-sashal@kernel.org>
References: <20231128210843.876493-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.140
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

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 125b0bb95dd6bec81b806b997a4ccb026eeecf8f ]

We really don't want to do atomic_read() or anything like that, since we
already have the value, not the lock.  The whole point of this is that
we've loaded the lock from memory, and we want to check whether the
value we loaded was a locked one or not.

The main use of this is the lockref code, which loads both the lock and
the reference count in one atomic operation, and then works on that
combined value.  With the atomic_read(), the compiler would pointlessly
spill the value to the stack, in order to then be able to read it back
"atomically".

This is the qspinlock version of commit c6f4a9002252 ("asm-generic:
ticket-lock: Optimize arch_spin_value_unlocked()") which fixed this same
bug for ticket locks.

Cc: Guo Ren <guoren@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/all/CAHk-=whNRv0v6kQiV5QO6DJhjH4KEL36vWQ6Re8Csrnh4zbRkQ@mail.gmail.com/
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/qspinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b138255014..95cfcfb8a3b4d 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -41,7 +41,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !atomic_read(&lock.val);
+	return !lock.val.counter;
 }
 
 /**
-- 
2.42.0

