Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21DD7FC877
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjK1V2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345855AbjK1V1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203EB5FC7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:10:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8373C43395;
        Tue, 28 Nov 2023 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205830;
        bh=xE72HXIwKAip3ryxwzwOu55whYvK78Bis8JAI+KxTPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=of51Kb3Qdv8ebsoO2gVwMLvGEQ40hLEInGBuMsmR72UVJuY7FV+6vZfGnHMsjeB8v
         MGxohrtJ0Cw3uon0NaQ9gZIi7wyLgxzkVBu/tuxWtM2N2ZcXsdfzVGehs2NxCiEM4V
         hEFg6UCvvX16Y65QhTdD9wONk+ZqUOhx36k8pdCChuqa4xyQ1PNVNTghia0h8qQCe+
         FEhI6xoRzSHt0K0f4VUjOOnPgDSjfMUTvErBQfDbtbdN6sOAovtBc6hPXT9CgGczH2
         J1Hsk9pziMu6B4HitRvEWpSGmPVOtZRPb9eMjOUeypoKL3YI8jQ3RlOBkesc7ZRFN1
         DZTyPw4g1kX+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 6/7] asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation
Date:   Tue, 28 Nov 2023 16:10:16 -0500
Message-ID: <20231128211018.877548-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128211018.877548-1-sashal@kernel.org>
References: <20231128211018.877548-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.331
Content-Transfer-Encoding: 8bit
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
index 66260777d6447..c133ed3183150 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -49,7 +49,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !atomic_read(&lock.val);
+	return !lock.val.counter;
 }
 
 /**
-- 
2.42.0

