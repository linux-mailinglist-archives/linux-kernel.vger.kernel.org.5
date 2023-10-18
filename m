Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D897CE81E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjJRTtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJRTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:48:58 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6931A134;
        Wed, 18 Oct 2023 12:48:53 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B6A7741538;
        Wed, 18 Oct 2023 19:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658532;
        bh=d70wFwXulEx1BEkYka3RH1xY2ngWeBIL+MztFYjvhlc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=uTajf4Lrk/Y6l0PMtoBHSezRxbtL6I+9Etz56AKlRR7JWdgBtA2AgEQV3/Rupk25Y
         ymMXoaB4O00xU2p3kpxyx2gU5OaaISsp8UuLCHRKhfRSD1NURNzXc6lXvCvSMrsJmn
         QAqHgB7jlEbrrtctV3GBhbpeyca3C/g7+TjFn/HbzMP5OcomVDbqC0OrNWOKLinqMa
         j5gX5NDorx+NHXgRr+k0onATTxnDpnpuyJHWX7vAewtsnEUG3UfckFGZ43VEaAwH/D
         9z3KGo7fSjqHSw3K7YImQN2LOrPLrcufRaZ9wwG+Li4hqFbonl0VojHt4v5oB84EHT
         WTftckTLnLf5g==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH RT 07/12] locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
Date:   Wed, 18 Oct 2023 15:48:28 -0400
Message-Id: <20231018194833.651674-8-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


It was brought up by Tetsuo that the following sequence:

   write_seqlock_irqsave()
   printk_deferred_enter()

could lead to a deadlock if the lockdep annotation within
write_seqlock_irqsave() triggers.

The problem is that the sequence counter is incremented before the lockdep
annotation is performed. The lockdep splat would then attempt to invoke
printk() but the reader side, of the same seqcount, could have a
tty_port::lock acquired waiting for the sequence number to become even again.

The other lockdep annotations come before the actual locking because "we
want to see the locking error before it happens". There is no reason why
seqcount should be different here.

Do the lockdep annotation first then perform the locking operation (the
sequence increment).

Fixes: 1ca7d67cf5d5a ("seqcount: Add lockdep functionality to seqcount/seqlock structures")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230920104627._DTHgPyA@linutronix.de

Closes: https://lore.kernel.org/20230621130641.-5iueY1I@linutronix.de
(cherry picked from commit 41b43b6c6e30a832c790b010a06772e793bca193)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee6..2c5d0102315d 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -516,8 +516,8 @@ do {									\
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
 
 /**
-- 
2.34.1

