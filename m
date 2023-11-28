Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B67FC847
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376475AbjK1VK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345990AbjK1VJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:09:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1036D35B7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A87C433AB;
        Tue, 28 Nov 2023 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205650;
        bh=NIfe/80VxkWywy3Sjc64uWaEIYL+wACbsDegDV8ILKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfYMZKU53MRv14g2kREnWPTzG21QS3sTQq8vdrCNMmC4lb32aIWHKG0E/RxtNreqc
         hLjnluYAgNTnZPVQ/BiQ8MrEGCCcNZHojIOxq2M9a7IP1acT6cC45vT/Od7ju5Nnh/
         FQ9H+521cJZttKhMD/UjQ495+uTR46Wud6oBEokBDgJWl95JXpmG+IcADNXIy+IKpo
         Ast5ARY5uydJwyYghBVpICTDRktRgF1K/Bq6XPLWswdSsjkd7IWWFBjGELXDVA5UBR
         0cKu1ZexyyNH5OX1I6s3n3Pj6rrzPNs9IN6BjxKXFaAuNRoj7T0DMI+4FLRJFvlcjD
         tmhhvcPv8Musw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 34/40] asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation
Date:   Tue, 28 Nov 2023 16:05:40 -0500
Message-ID: <20231128210615.875085-34-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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
index 995513fa26904..0655aa5b57b29 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -70,7 +70,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !atomic_read(&lock.val);
+	return !lock.val.counter;
 }
 
 /**
-- 
2.42.0

