Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5613C7F9212
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjKZKBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:01:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B2FE;
        Sun, 26 Nov 2023 02:01:12 -0800 (PST)
Date:   Sun, 26 Nov 2023 10:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700992869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdIgXoiSPuI8KbNY+MTJ4fyc3kRMyU7BkyVcKl9ISg4=;
        b=T3xVxAsHLzNXChp3J1Omas8E0M+PAXhPWXojTHKs6r9zp4KygGZreXZ01bFrfWKi+wY2Zh
        77pZvfZFy7igGdZq5Hm2hemU3AfvVYQsNZ/IDnBuTR1iqXloXi9hf/sJVXEuNIM+bdH7tl
        //q/61ageAeLJBwUGYf15S81uiCX8TPdaaT3fQx/4XSTyUPtScVWo41gxKroOL4J6oUQ7Q
        j7V/Dche17tD7gviQ7nCuPNlM+JM14nle/6JHvIlPbLC1t6D06kuRd/zZ13aNzStnuiK7p
        tQN6vN3FgUeOIfXCbZtqfTurcumDSa1CxrJMITSLOL+S5JI6NcryDonQtxOO4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700992869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdIgXoiSPuI8KbNY+MTJ4fyc3kRMyU7BkyVcKl9ISg4=;
        b=Bh1dCWWk+evX0j5CCresTrIyXJf6EenkVK+JVPRNOW+g5zTa7XDpUPcPSjCrhwjWPnSj0z
        Wf+9MlGGxo9QdxAA==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Slightly reorder 'struct
 lock_class' to save some memory
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C801258371fc4101f96495a5aaecef638d6cbd8d3=2E17009?=
 =?utf-8?q?88869=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C801258371fc4101f96495a5aaecef638d6cbd8d3=2E170098?=
 =?utf-8?q?8869=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <170099286871.398.7188234415695498800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     51961d4c08b18e4011798bd37f44c1c2c0f9f59e
Gitweb:        https://git.kernel.org/tip/51961d4c08b18e4011798bd37f44c1c2c0f9f59e
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sun, 26 Nov 2023 09:56:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Nov 2023 10:56:56 +01:00

locking/lockdep: Slightly reorder 'struct lock_class' to save some memory

Based on pahole, 2 holes can be combined in the 'struct lock_class'. This
saves 8 bytes in the structure on my x86_64.

On a x86_64 configured with allmodconfig, this saves ~64kb of memory in
'kernel/locking/lockdep.o':

                text         data           bss           dec     filename
  Before:    102,501    1,912,490    11,531,636    13,546,627     kernel/locking/lockdep.o
  After:     102,181    1,912,490    11,466,100    13,480,771     kernel/locking/lockdep.o

because of:

  struct lock_class lock_classes[MAX_LOCKDEP_KEYS];

After the reorder, pahole gives:

  struct lock_class {
          struct hlist_node          hash_entry;           /*     0    16 */
          struct list_head           lock_entry;           /*    16    16 */
          struct list_head           locks_after;          /*    32    16 */
          struct list_head           locks_before;         /*    48    16 */
          /* --- cacheline 1 boundary (64 bytes) --- */
          const struct lockdep_subclass_key  * key;        /*    64     8 */
          lock_cmp_fn                cmp_fn;               /*    72     8 */
          lock_print_fn              print_fn;             /*    80     8 */
          unsigned int               subclass;             /*    88     4 */
          unsigned int               dep_gen_id;           /*    92     4 */
          long unsigned int          usage_mask;           /*    96     8 */
          const struct lock_trace  * usage_traces[10];     /*   104    80 */
          /* --- cacheline 2 boundary (128 bytes) was 56 bytes ago --- */
          const char  *              name;                 /*   184     8 */
          /* --- cacheline 3 boundary (192 bytes) --- */
          int                        name_version;         /*   192     4 */
          u8                         wait_type_inner;      /*   196     1 */
          u8                         wait_type_outer;      /*   197     1 */
          u8                         lock_type;            /*   198     1 */

          /* XXX 1 byte hole, try to pack */

          long unsigned int          contention_point[4];  /*   200    32 */
          long unsigned int          contending_point[4];  /*   232    32 */

          /* size: 264, cachelines: 5, members: 18 */
          /* sum members: 263, holes: 1, sum holes: 1 */
          /* last cacheline: 8 bytes */
  };

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/801258371fc4101f96495a5aaecef638d6cbd8d3.1700988869.git.christophe.jaillet@wanadoo.fr
---
 include/linux/lockdep_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 2ebc323..857d785 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -127,12 +127,12 @@ struct lock_class {
 	unsigned long			usage_mask;
 	const struct lock_trace		*usage_traces[LOCK_TRACE_STATES];
 
+	const char			*name;
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
 	 * to ensure that we check one node only once:
 	 */
 	int				name_version;
-	const char			*name;
 
 	u8				wait_type_inner;
 	u8				wait_type_outer;
