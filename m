Return-Path: <linux-kernel+bounces-68765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED1857FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33A21F233BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD012F588;
	Fri, 16 Feb 2024 14:52:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B812F580
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095142; cv=none; b=ph0qVBintZhldf+XWUjTljrHLzlGXFXoSS6e395gteI6tER4DSM/7OyLP/1pewh8slq1hsiBL0AYVrZQp7ho9HitMnHErvb5Ug104/AKZC0hJsFuhk6eRuhrjDAlWW+0WH4/0jewJosdGH1TuRw+dKQ43YJPq/brt1h2XErlN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095142; c=relaxed/simple;
	bh=2IrpyuRYoMA+3sNm2EvbC1qb6jML/pyvXXI7FMmGBck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oT04kcm20b5bQsPG0mb3FURiF/ajuXqT3+D2CzznCtD7vrBaZYX4iVPe1XkTVo/XSZ6+sLn9WAGv/qk6BXAkw0bFvslBBGZnGDAUl3vnQj31CuitRw0EL4YGImhptiyc8ipNWs107O6LRsP02VL7J/ps4BUrKwc/BXKoyw7Np1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA99C433F1;
	Fri, 16 Feb 2024 14:52:21 +0000 (UTC)
Date: Fri, 16 Feb 2024 09:53:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Petr Pavlu <petr.pavlu@suse.com>, Sven
 Schnelle <svens@linux.ibm.com>, Thorsten Blum <thorsten.blum@toblux.com>
Subject: [GIT PULL] tracing: Fixes for v6.8-rc4
Message-ID: <20240216095357.6ee66d05@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Tracing fixes for v6.8:

- Fix the #ifndef that didn't have CONFIG_ on HAVE_DYNAMIC_FTRACE_WITH_REGS
  The fix to have dynamic trampolines work with x86 broke arm64 as
  the config used in the #ifdef was HAVE_DYNAMIC_FTRACE_WITH_REGS and not
  CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS which removed the fix that the
  previous fix was to fix.

- Fix tracing_on state
  The code to test if "tracing_on" is set used ring_buffer_record_is_on()
  which returns false if the ring buffer isn't able to be written to.
  But the ring buffer disable has several bits that disable it.
  One is internal disabling which is used for resizing and other
  modifications of the ring buffer. But the "tracing_on" user space
  visible flag should only report if tracing is actually on and not
  internally disabled, as this can cause confusion as writing "1"
  when it is disabled will not enable it.

  Instead use ring_buffer_record_is_set_on() which shows the user space
  visible settings.

- Fix a false positive kmemleak on saved cmdlines
  Now that the saved_cmdlines structure is allocated via alloc_page()
  and not via kmalloc() it has become invisible to kmemleak.
  The allocation done to one of its pointers was flagged as a
  dangling allocation leak. Make kmemleak aware of this allocation
  and free.

- Fix synthetic event dynamic strings.
  A update that cleaned up the synthetic event code removed the
  return value of trace_string(), and had it return zero instead
  of the length, causing dynamic strings in the synthetic event
  to always have zero size.

- Clean up documentation and header files for seq_buf


Please pull the latest trace-v6.8-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.8-rc4

Tag SHA1: 7b84da4c1b4928cbccbb79e3d7a6acb13d6af13a
Head SHA1: 6efe4d18796934b8ada66c1c446510e7f2d9b972


Andy Shevchenko (2):
      seq_buf: Don't use "proxy" headers
      seq_buf: Fix kernel documentation

Petr Pavlu (1):
      tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef

Steven Rostedt (Google) (1):
      tracing: Inform kmemleak of saved_cmdlines allocation

Sven Schnelle (1):
      tracing: Use ring_buffer_record_is_set_on() in tracer_tracing_is_on()

Thorsten Blum (1):
      tracing/synthetic: Fix trace_string() return value

----
 include/linux/seq_buf.h           | 17 ++++++++------
 kernel/trace/ftrace.c             |  2 +-
 kernel/trace/trace.c              |  5 +++-
 kernel/trace/trace_events_synth.c |  3 ++-
 lib/seq_buf.c                     | 49 ++++++++++++++++++++++++---------------
 5 files changed, 47 insertions(+), 29 deletions(-)
---------------------------
diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index c44f4b47b945..fe41da005970 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -2,7 +2,10 @@
 #ifndef _LINUX_SEQ_BUF_H
 #define _LINUX_SEQ_BUF_H
 
-#include <linux/fs.h>
+#include <linux/bug.h>
+#include <linux/minmax.h>
+#include <linux/seq_file.h>
+#include <linux/types.h>
 
 /*
  * Trace sequences are used to allow a function to call several other functions
@@ -10,7 +13,7 @@
  */
 
 /**
- * seq_buf - seq buffer structure
+ * struct seq_buf - seq buffer structure
  * @buffer:	pointer to the buffer
  * @size:	size of the buffer
  * @len:	the amount of data inside the buffer
@@ -77,10 +80,10 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 }
 
 /**
- * seq_buf_str - get %NUL-terminated C string from seq_buf
+ * seq_buf_str - get NUL-terminated C string from seq_buf
  * @s: the seq_buf handle
  *
- * This makes sure that the buffer in @s is nul terminated and
+ * This makes sure that the buffer in @s is NUL-terminated and
  * safe to read as a string.
  *
  * Note, if this is called when the buffer has overflowed, then
@@ -90,7 +93,7 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  * After this function is called, s->buffer is safe to use
  * in string operations.
  *
- * Returns @s->buf after making sure it is terminated.
+ * Returns: @s->buf after making sure it is terminated.
  */
 static inline const char *seq_buf_str(struct seq_buf *s)
 {
@@ -110,7 +113,7 @@ static inline const char *seq_buf_str(struct seq_buf *s)
  * @s: the seq_buf handle
  * @bufp: the beginning of the buffer is stored here
  *
- * Return the number of bytes available in the buffer, or zero if
+ * Returns: the number of bytes available in the buffer, or zero if
  * there's no space.
  */
 static inline size_t seq_buf_get_buf(struct seq_buf *s, char **bufp)
@@ -132,7 +135,7 @@ static inline size_t seq_buf_get_buf(struct seq_buf *s, char **bufp)
  * @num: the number of bytes to commit
  *
  * Commit @num bytes of data written to a buffer previously acquired
- * by seq_buf_get.  To signal an error condition, or that the data
+ * by seq_buf_get_buf(). To signal an error condition, or that the data
  * didn't fit in the available space, pass a negative @num value.
  */
 static inline void seq_buf_commit(struct seq_buf *s, int num)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c060d5b47910..83ba342aef31 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5331,7 +5331,7 @@ static int register_ftrace_function_nolock(struct ftrace_ops *ops);
  * not support ftrace_regs_caller but direct_call, use SAVE_ARGS so that it
  * jumps from ftrace_caller for multiple ftrace_ops.
  */
-#ifndef HAVE_DYNAMIC_FTRACE_WITH_REGS
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 #else
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9ff8a439d674..8198bfc54b58 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -39,6 +39,7 @@
 #include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/panic_notifier.h>
+#include <linux/kmemleak.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
@@ -1532,7 +1533,7 @@ void disable_trace_on_warning(void)
 bool tracer_tracing_is_on(struct trace_array *tr)
 {
 	if (tr->array_buffer.buffer)
-		return ring_buffer_record_is_on(tr->array_buffer.buffer);
+		return ring_buffer_record_is_set_on(tr->array_buffer.buffer);
 	return !tr->buffer_disabled;
 }
 
@@ -2339,6 +2340,7 @@ static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
 	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
 
 	kfree(s->map_cmdline_to_pid);
+	kmemleak_free(s);
 	free_pages((unsigned long)s, order);
 }
 
@@ -2358,6 +2360,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 		return NULL;
 
 	s = page_address(page);
+	kmemleak_alloc(s, size, 1, GFP_KERNEL);
 	memset(s, 0, sizeof(*s));
 
 	/* Round up to actual allocation */
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e7af286af4f1..c82b401a294d 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -441,8 +441,9 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	if (is_dynamic) {
 		union trace_synth_field *data = &entry->fields[*n_u64];
 
+		len = fetch_store_strlen((unsigned long)str_val);
 		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
-		data->as_dynamic.len = fetch_store_strlen((unsigned long)str_val);
+		data->as_dynamic.len = len;
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 010c730ca7fc..f3f3436d60a9 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -13,16 +13,26 @@
  * seq_buf_init() more than once to reset the seq_buf to start
  * from scratch.
  */
-#include <linux/uaccess.h>
-#include <linux/seq_file.h>
+
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/hex.h>
+#include <linux/minmax.h>
+#include <linux/printk.h>
 #include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/sprintf.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 
 /**
  * seq_buf_can_fit - can the new data fit in the current buffer?
  * @s: the seq_buf descriptor
  * @len: The length to see if it can fit in the current buffer
  *
- * Returns true if there's enough unused space in the seq_buf buffer
+ * Returns: true if there's enough unused space in the seq_buf buffer
  * to fit the amount of new data according to @len.
  */
 static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
@@ -35,7 +45,7 @@ static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
  * @m: the seq_file descriptor that is the destination
  * @s: the seq_buf descriptor that is the source.
  *
- * Returns zero on success, non zero otherwise
+ * Returns: zero on success, non-zero otherwise.
  */
 int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
 {
@@ -50,9 +60,9 @@ int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
  * @fmt: printf format string
  * @args: va_list of arguments from a printf() type function
  *
- * Writes a vnprintf() format into the sequencce buffer.
+ * Writes a vnprintf() format into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow.
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
 {
@@ -78,7 +88,7 @@ int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
  *
  * Writes a printf() format into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow.
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 {
@@ -94,12 +104,12 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 EXPORT_SYMBOL_GPL(seq_buf_printf);
 
 /**
- * seq_buf_do_printk - printk seq_buf line by line
+ * seq_buf_do_printk - printk() seq_buf line by line
  * @s: seq_buf descriptor
  * @lvl: printk level
  *
  * printk()-s a multi-line sequential buffer line by line. The function
- * makes sure that the buffer in @s is nul terminated and safe to read
+ * makes sure that the buffer in @s is NUL-terminated and safe to read
  * as a string.
  */
 void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
@@ -139,7 +149,7 @@ EXPORT_SYMBOL_GPL(seq_buf_do_printk);
  * This function will take the format and the binary array and finish
  * the conversion into the ASCII string within the buffer.
  *
- * Returns zero on success, -1 on overflow.
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
 {
@@ -167,7 +177,7 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
  *
  * Copy a simple string into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_puts(struct seq_buf *s, const char *str)
 {
@@ -196,7 +206,7 @@ EXPORT_SYMBOL_GPL(seq_buf_puts);
  *
  * Copy a single character into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_putc(struct seq_buf *s, unsigned char c)
 {
@@ -212,7 +222,7 @@ int seq_buf_putc(struct seq_buf *s, unsigned char c)
 EXPORT_SYMBOL_GPL(seq_buf_putc);
 
 /**
- * seq_buf_putmem - write raw data into the sequenc buffer
+ * seq_buf_putmem - write raw data into the sequence buffer
  * @s: seq_buf descriptor
  * @mem: The raw memory to copy into the buffer
  * @len: The length of the raw memory to copy (in bytes)
@@ -221,7 +231,7 @@ EXPORT_SYMBOL_GPL(seq_buf_putc);
  * buffer and a strcpy() would not work. Using this function allows
  * for such cases.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
 {
@@ -249,7 +259,7 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
  * raw memory into the buffer it writes its ASCII representation of it
  * in hex characters.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 		       unsigned int len)
@@ -297,7 +307,7 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
  *
  * Write a path name into the sequence buffer.
  *
- * Returns the number of written bytes on success, -1 on overflow
+ * Returns: the number of written bytes on success, -1 on overflow.
  */
 int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 {
@@ -332,6 +342,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
  * or until it reaches the end of the content in the buffer (@s->len),
  * whichever comes first.
  *
+ * Returns:
  * On success, it returns a positive number of the number of bytes
  * it copied.
  *
@@ -382,11 +393,11 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
  * linebuf size is maximal length for one line.
  * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
  *	separating space
- * 2 - spaces separating hex dump and ascii representation
- * 32 - ascii representation
+ * 2 - spaces separating hex dump and ASCII representation
+ * 32 - ASCII representation
  * 1 - terminating '\0'
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
 		     int rowsize, int groupsize,

