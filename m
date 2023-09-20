Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B997A799E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjITKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjITKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:46:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A774CE9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:46:33 -0700 (PDT)
Date:   Wed, 20 Sep 2023 12:46:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695206791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wAGWwRdw1kc9xidRjeEttNJpxiDPA74+rQRMxWuGmyM=;
        b=oTVlk4LAF19nJfppSVBUcHMXzk89PFb9Nq4zyZwJRRQwx1Ci2fvDIQCH7MA8nmjibQOFn1
        dAMuCstKal7Dv3xOmWiJZgkY6FhLFPXL2LZaLDNpEaKtXbuzSAwLpOIMjzE/2QXn+b5EmW
        cCLXWBq8/xOF8Q2kM2VxXsrjT2Gj/FvQjBlsGRTZQgIJ1LN789VvWO0YpaBUhPAPmYj0xI
        FtdyHNmiA2diwGbRrFrHVPZmlaWHj3Sl+K1NWW0ixBzrq1nEakTbf8j1JCuDL3fQi9WBHx
        HCraghRVCM4s0MvNqD5hiSS0B3EadMQp9+P8lwvtBMrGrjSEHF0bJ+BS7PtINA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695206791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wAGWwRdw1kc9xidRjeEttNJpxiDPA74+rQRMxWuGmyM=;
        b=JyuIEQ8PNwF+Njx/kSLOBh6hV1YwB69q7QARgBXmFfQSrZSHeULCI8i/6hlzqFb/DjokzM
        6tsv4JcMRNf7GKCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH REPOST] seqlock: Do the lockdep annotation before locking in
 do_write_seqcount_begin_nested()
Message-ID: <20230920104627._DTHgPyA@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was brought up by Tetsuo that the following sequence
   write_seqlock_irqsave()
   printk_deferred_enter()

could lead to a deadlock if the lockdep annotation within
write_seqlock_irqsave() triggers. The problem is that the sequence
counter is incremented before the lockdep annotation is performed. The
lockdep splat would then attempt to invoke printk() but the reader side,
of the same seqcount, could have a tty_port::lock acquired waiting for
the sequence number to become even again.

The other lockdep annotations come before the actual locking because "we
want to see the locking error before it happens". There is no reason why
seqcount should be different here.

Do the lockdep annotation first then perform the locking operation (the
sequence increment).

Fixes: 1ca7d67cf5d5a ("seqcount: Add lockdep functionality to seqcount/seqlock structures")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Closes: https://lore.kernel.org/20230621130641.-5iueY1I@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The previous submission was in
    https://lore.kernel.org/r/20230623171232.892937-2-bigeasy@linutronix.de

The mm bits in the referenced thread have been merged as of -rc1.

 include/linux/seqlock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -512,8 +512,8 @@ do {									\
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
 
 /**
