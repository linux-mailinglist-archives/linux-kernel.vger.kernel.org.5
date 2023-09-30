Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C387B43AA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjI3UrO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Sep 2023 16:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3UrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:47:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C82C4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:47:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88057C433C8;
        Sat, 30 Sep 2023 20:47:09 +0000 (UTC)
Date:   Sat, 30 Sep 2023 16:47:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Subject: [GIT PULL] tracing: Fixes for v6.6-rc3
Message-ID: <20230930164707.4d0e3c33@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beau Belgrave <beaub@linux.microsoft.com>, Clément Léger <cleger@rivosinc.com>

Linus,

Tracing fixes for v6.6-rc3:

- Make sure 32 bit applications using user events have aligned access when
  running on a 64 bit kernel.

- Add cond_resched in the loop that handles converting enums in print_fmt
  string is trace events.

- Fix premature wake ups of polling processes in the tracing ring buffer. When
  a task polls waiting for a percentage of the ring buffer to be filled, the
  writer still will wake it up at every event. Add the polling's percentage to
  the "shortest_full" list to tell the writer when to wake it up.

- For eventfs dir lookups on dynamic events, an event system's only event could
  be removed, leaving its dentry with no children. This is totally legitimate.
  But in eventfs_release() it must not access the children array, as it is only
  allocated when the dentry has children.


Please pull the latest trace-v6.6-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.6-rc3

Tag SHA1: 805f65c2b5fbd7357e47a1808fcad8629dda9f07
Head SHA1: 2598bd3ca8dcf5bbca1161ee5b271b432398da37


Beau Belgrave (1):
      tracing/user_events: Align set_bit() address for all archs

Clément Léger (1):
      tracing: relax trace_event_eval_update() execution with cond_resched()

Steven Rostedt (Google) (2):
      ring-buffer: Update "shortest_full" in polling
      eventfs: Test for dentries array allocated in eventfs_release()

----
 fs/tracefs/event_inode.c         |  2 +-
 kernel/trace/ring_buffer.c       |  3 +++
 kernel/trace/trace_events.c      |  1 +
 kernel/trace/trace_events_user.c | 58 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 8 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5f1714089884..8c8d64e76103 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -421,7 +421,7 @@ static int eventfs_release(struct inode *inode, struct file *file)
 	if (WARN_ON_ONCE(!dlist))
 		return -EINVAL;
 
-	for (i = 0; dlist->dentries[i]; i++) {
+	for (i = 0; dlist->dentries && dlist->dentries[i]; i++) {
 		dput(dlist->dentries[i]);
 	}
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28daf0ce95c5..515cafdb18d9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1137,6 +1137,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	if (full) {
 		poll_wait(filp, &work->full_waiters, poll_table);
 		work->full_waiters_pending = true;
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
 	} else {
 		poll_wait(filp, &work->waiters, poll_table);
 		work->waiters_pending = true;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 91951d038ba4..f49d6ddb6342 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_fields(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 6f046650e527..b87f41187c6a 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -127,8 +127,13 @@ struct user_event_enabler {
 /* Bit 7 is for freeing status of enablement */
 #define ENABLE_VAL_FREEING_BIT 7
 
-/* Only duplicate the bit value */
-#define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
+/* Bit 8 is for marking 32-bit on 64-bit */
+#define ENABLE_VAL_32_ON_64_BIT 8
+
+#define ENABLE_VAL_COMPAT_MASK (1 << ENABLE_VAL_32_ON_64_BIT)
+
+/* Only duplicate the bit and compat values */
+#define ENABLE_VAL_DUP_MASK (ENABLE_VAL_BIT_MASK | ENABLE_VAL_COMPAT_MASK)
 
 #define ENABLE_BITOPS(e) (&(e)->values)
 
@@ -174,6 +179,30 @@ struct user_event_validator {
 	int			flags;
 };
 
+static inline void align_addr_bit(unsigned long *addr, int *bit,
+				  unsigned long *flags)
+{
+	if (IS_ALIGNED(*addr, sizeof(long))) {
+#ifdef __BIG_ENDIAN
+		/* 32 bit on BE 64 bit requires a 32 bit offset when aligned. */
+		if (test_bit(ENABLE_VAL_32_ON_64_BIT, flags))
+			*bit += 32;
+#endif
+		return;
+	}
+
+	*addr = ALIGN_DOWN(*addr, sizeof(long));
+
+	/*
+	 * We only support 32 and 64 bit values. The only time we need
+	 * to align is a 32 bit value on a 64 bit kernel, which on LE
+	 * is always 32 bits, and on BE requires no change when unaligned.
+	 */
+#ifdef __LITTLE_ENDIAN
+	*bit += 32;
+#endif
+}
+
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 				   void *tpdata, bool *faulted);
 
@@ -482,6 +511,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	unsigned long *ptr;
 	struct page *page;
 	void *kaddr;
+	int bit = ENABLE_BIT(enabler);
 	int ret;
 
 	lockdep_assert_held(&event_mutex);
@@ -497,6 +527,8 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
 		return -EBUSY;
 
+	align_addr_bit(&uaddr, &bit, ENABLE_BITOPS(enabler));
+
 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
 				    &page, NULL);
 
@@ -515,9 +547,9 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(ENABLE_BIT(enabler), ptr);
+		set_bit(bit, ptr);
 	else
-		clear_bit(ENABLE_BIT(enabler), ptr);
+		clear_bit(bit, ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
@@ -849,6 +881,12 @@ static struct user_event_enabler
 	enabler->event = user;
 	enabler->addr = uaddr;
 	enabler->values = reg->enable_bit;
+
+#if BITS_PER_LONG >= 64
+	if (reg->enable_size == 4)
+		set_bit(ENABLE_VAL_32_ON_64_BIT, ENABLE_BITOPS(enabler));
+#endif
+
 retry:
 	/* Prevents state changes from racing with new enablers */
 	mutex_lock(&event_mutex);
@@ -2377,7 +2415,8 @@ static long user_unreg_get(struct user_unreg __user *ureg,
 }
 
 static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
-				   unsigned long uaddr, unsigned char bit)
+				   unsigned long uaddr, unsigned char bit,
+				   unsigned long flags)
 {
 	struct user_event_enabler enabler;
 	int result;
@@ -2385,7 +2424,7 @@ static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
 
 	memset(&enabler, 0, sizeof(enabler));
 	enabler.addr = uaddr;
-	enabler.values = bit;
+	enabler.values = bit | flags;
 retry:
 	/* Prevents state changes from racing with new enablers */
 	mutex_lock(&event_mutex);
@@ -2415,6 +2454,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	struct user_event_mm *mm = current->user_event_mm;
 	struct user_event_enabler *enabler, *next;
 	struct user_unreg reg;
+	unsigned long flags;
 	long ret;
 
 	ret = user_unreg_get(ureg, &reg);
@@ -2425,6 +2465,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	if (!mm)
 		return -ENOENT;
 
+	flags = 0;
 	ret = -ENOENT;
 
 	/*
@@ -2441,6 +2482,9 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 		    ENABLE_BIT(enabler) == reg.disable_bit) {
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
 
+			/* We must keep compat flags for the clear */
+			flags |= enabler->values & ENABLE_VAL_COMPAT_MASK;
+
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
 				user_event_enabler_destroy(enabler, true);
 
@@ -2454,7 +2498,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	/* Ensure bit is now cleared for user, regardless of event status */
 	if (!ret)
 		ret = user_event_mm_clear_bit(mm, reg.disable_addr,
-					      reg.disable_bit);
+					      reg.disable_bit, flags);
 
 	return ret;
 }
