Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623F77A23A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjIOQc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjIOQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:32:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65B2126;
        Fri, 15 Sep 2023 09:32:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 65A1D1FD6E;
        Fri, 15 Sep 2023 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694795560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpItHTky+Eqv5dwD6QZB0z6EvAKtxZt4ST12sqlzEng=;
        b=B2BuSuGiiv2nKOViCgr2oG6r+ecclp63y6ml1K7r2D2GBm/eGj1+Itw5g9QLFDjXxwVp3M
        h0La7AyokHUdlvnrhQAeWSKMpAjd/7s2Thv5pbZovbKIUf5jXFw3ShA4YCR9sd0zcHyYRP
        NfHHrmw4gvRPaN2K0Yy2bNUCKkMdoWc=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AE34F2C142;
        Fri, 15 Sep 2023 16:32:39 +0000 (UTC)
Date:   Fri, 15 Sep 2023 18:32:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Enlin Mu <enlinmu@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Enlin Mu <enlin.mu@outlook.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, enlin.mu@unisoc.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
Message-ID: <ZQSHJ_786kZNjEDX@alley>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de>
 <CAAfh-jPc+UWMcLPFbYy6rYUh4OU36frkVYVbkhNPNX4L6RG5sA@mail.gmail.com>
 <2023091547-mug-unlikable-571f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023091547-mug-unlikable-571f@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-15 11:53:13, Greg KH wrote:
> On Fri, Sep 15, 2023 at 04:46:02PM +0800, Enlin Mu wrote:
> > John Ogness <john.ogness@linutronix.de> 于2023年9月15日周五 16:34写道：
> > >
> > > On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> > > > Sometimes we want to print cpu id of printk() messages to consoles
> > > >
> > > > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > > > index c34173e6c5f1..6700bd9a174f 100644
> > > > --- a/include/linux/threads.h
> > > > +++ b/include/linux/threads.h
> > > > @@ -34,6 +34,9 @@
> > > >  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> > > >       (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> > > >
> > > > +#define CPU_ID_SHIFT 23
> > > > +#define CPU_ID_MASK  0xff800000
> > >
> > > This only supports 256 CPUs. I think it doesn't make sense to try to
> > > squish CPU and Task IDs into 32 bits.
> > Yes, it is not good way,
> > >
> > > What about introducing a caller_id option to always only print the CPU
> > > ID? Or do you really need Task _and_ CPU?
> >    Yes, I need it.Because I need to know which CPU is printing the
> > log, so that I can identify the current system operation, such as load
> > situation and CPU busy/idle status
> 
> The cpu that is printing the log isn't the one that added the log
> message, so I think you will have incorrect data here, right?

We already store some metadata about the caller:

 * All fields are set by the printk code except for @seq, which is
 * set by the ringbuffer code.
 */
struct printk_info {
	u64	seq;		/* sequence number */
	u64	ts_nsec;	/* timestamp in nanoseconds */
	u16	text_len;	/* length of text message */
	u8	facility;	/* syslog facility */
	u8	flags:5;	/* internal record flags */
	u8	level:3;	/* syslog level */
	u32	caller_id;	/* thread id or processor id */

	struct dev_printk_info	dev_info;
};

The 32-bit caller ID is generated using:

static inline u32 printk_caller_id(void)
{
	return in_task() ? task_pid_nr(current) :
		0x80000000 + smp_processor_id();
}

We could add more metadata and always store the CPU ID and something
like:

   [CTXT][ Tpid][  Ccpu]

for example

   [TASK][  T234][    C4]
   [ IRQ][ T4567][   C17]
   [SIRQ][    T5][    C0]
   [ NMI][  T356][  C128]


The biggest problem is that it would change the format of the
ringbuffer so that it would require updating external tools,
working with crashdump, especially crash but there are also
alternative python extensions for gdb.


See below POC of the kernel part. It is not even compile tested. The size
of the buffers is updated by a guess. Comments are not updated, ...

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7d4979d5c3ce..e3e0a9fdc0cf 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -15,7 +15,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
-#define PRINTK_PREFIX_MAX	48
+#define PRINTK_PREFIX_MAX	64
 #else
 #define PRINTK_PREFIX_MAX	32
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7e0b4dd02398..bb393ccbd5e9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -621,16 +621,20 @@ static void append_char(char **pp, char *e, char c)
 		*(*pp)++ = c;
 }
 
+char printk_caller_ctxt_txt[][] = { "TSK", "IRQ", "SIRQ", "NMI"' };
+
 static ssize_t info_print_ext_header(char *buf, size_t size,
 				     struct printk_info *info)
 {
 	u64 ts_usec = info->ts_nsec;
-	char caller[20];
+	char caller[40];
 #ifdef CONFIG_PRINTK_CALLER
-	u32 id = info->caller_id;
+	struct printk_caller_info *ci = info->caller_info;
 
-	snprintf(caller, sizeof(caller), ",caller=%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+	snprintf(caller, sizeof(caller),
+		 ",caller.ctxt=%s,caller.pid=%d,caller.cpu=%d",
+		 printk_caller_ctxt_txt[ci->ctxt],
+		 ci->pid,ci->cpu);
 #else
 	caller[0] = '\0';
 #endif
@@ -996,11 +1000,16 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
 	VMCOREINFO_OFFSET(prb_data_blk_lpos, next);
 
+	VMCOREINFO_STRUCT_SIZE(printk_caller_info);
+	VMCOREINFO_OFFSET(printk_caller_info, ctxt);
+	VMCOREINFO_OFFSET(printk_caller_info, cpu);
+	VMCOREINFO_OFFSET(printk_caller_info, pid);
+
 	VMCOREINFO_STRUCT_SIZE(printk_info);
 	VMCOREINFO_OFFSET(printk_info, seq);
 	VMCOREINFO_OFFSET(printk_info, ts_nsec);
 	VMCOREINFO_OFFSET(printk_info, text_len);
-	VMCOREINFO_OFFSET(printk_info, caller_id);
+	VMCOREINFO_OFFSET(printk_info, caller_info);
 	VMCOREINFO_OFFSET(printk_info, dev_info);
 
 	VMCOREINFO_STRUCT_SIZE(dev_printk_info);
@@ -1111,7 +1120,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	dest_r.info->level = r->info->level;
 	dest_r.info->flags = r->info->flags;
 	dest_r.info->ts_nsec = r->info->ts_nsec;
-	dest_r.info->caller_id = r->info->caller_id;
+	dest_r.info->caller_info = r->info->caller_info;
 	memcpy(&dest_r.info->dev_info, &r->info->dev_info, sizeof(dest_r.info->dev_info));
 
 	prb_final_commit(&e);
@@ -1329,13 +1338,16 @@ static size_t print_time(u64 ts, char *buf)
 }
 
 #ifdef CONFIG_PRINTK_CALLER
-static size_t print_caller(u32 id, char *buf)
+static size_t print_caller_info(struct printk_caller_info *ci, char *buf)
 {
-	char caller[12];
+	char pid[12];
+	char cpu[12];
 
-	snprintf(caller, sizeof(caller), "%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
-	return sprintf(buf, "[%6s]", caller);
+	snprintf(pid, sizeof(pid), "T%u", ci->pid);
+	snprintf(cpu, sizeof(cpu), "C%u", ci->cpu);
+
+	return sprintf(buf, "[%s][%6s][%6s]",
+		       printk_caller_ctxt_txt[ci->ctxt], pid, cpu);
 }
 #else
 #define print_caller(id, buf) 0
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index fde338606ce8..66be9b47be46 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -431,7 +431,8 @@ static enum desc_state get_desc_state(unsigned long id,
  */
 static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 				 unsigned long id, struct prb_desc *desc_out,
-				 u64 *seq_out, u32 *caller_id_out)
+				 u64 *seq_out,
+				 struct printk_caller_info *ci_out)
 {
 	struct printk_info *info = to_info(desc_ring, id);
 	struct prb_desc *desc = to_desc(desc_ring, id);
@@ -480,8 +481,8 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	}
 	if (seq_out)
 		*seq_out = info->seq; /* also part of desc_read:C */
-	if (caller_id_out)
-		*caller_id_out = info->caller_id; /* also part of desc_read:C */
+	if (caller_info_out)
+		*ci_out = info->caller_info; /* also part of desc_read:C */
 
 	/*
 	 * 1. Guarantee the descriptor content is loaded before re-checking
@@ -1251,14 +1252,22 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	return &db->data[0];
 }
 
+static bool same_caller(struct printk_caller_info *cur_ci,
+			struct printk_caller_info *last_ci)
+{
+	return (cur_ci->cpu == last_ci->cpu &&
+		cur_ci->pid == last_ci->pid &&
+		cur_ci->ctxt == last_ci->ctxt)
 /*
  * Attempt to transition the newest descriptor from committed back to reserved
  * so that the record can be modified by a writer again. This is only possible
  * if the descriptor is not yet finalized and the provided @caller_id matches.
  */
 static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
-					 u32 caller_id, unsigned long *id_out)
+					 struct printk_caller_info *ci,
+					 unsigned long *id_out)
 {
+	struct printk_caller_info last_ci;
 	unsigned long prev_state_val;
 	enum desc_state d_state;
 	struct prb_desc desc;
@@ -1272,8 +1281,8 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
 	 * To reduce unnecessarily reopening, first check if the descriptor
 	 * state and caller ID are correct.
 	 */
-	d_state = desc_read(desc_ring, id, &desc, NULL, &cid);
-	if (d_state != desc_committed || cid != caller_id)
+	d_state = desc_read(desc_ring, id, &desc, NULL, &last_ci);
+	if (d_state != desc_committed || !same_caller(&last_ci, ci))
 		return NULL;
 
 	d = to_desc(desc_ring, id);
@@ -1348,7 +1357,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  *            @r->info->text_len after concatenating.
  */
 bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
-			 struct printk_record *r, u32 caller_id, unsigned int max_size)
+			 struct printk_record *r, struct printk_caller_info *ci, unsigned int max_size)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	struct printk_info *info;
@@ -1359,7 +1368,7 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	local_irq_save(e->irqflags);
 
 	/* Transition the newest descriptor back to the reserved state. */
-	d = desc_reopen_last(desc_ring, caller_id, &id);
+	d = desc_reopen_last(desc_ring, ci, &id);
 	if (!d) {
 		local_irq_restore(e->irqflags);
 		goto fail_reopen;
@@ -1377,11 +1386,11 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	e->id = id;
 
 	/*
-	 * desc_reopen_last() checked the caller_id, but there was no
+	 * desc_reopen_last() checked the caller_info, but there was no
 	 * exclusive access at that point. The descriptor may have
 	 * changed since then.
 	 */
-	if (caller_id != info->caller_id)
+	if (!match(ci, &info->caller_info)
 		goto fail;
 
 	if (BLK_DATALESS(&d->text_blk_lpos)) {
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 18cd25e489b8..9934353965d4 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -6,6 +6,18 @@
 #include <linux/atomic.h>
 #include <linux/dev_printk.h>
 
+#define PRINTK_CTXT_TASK	0
+#define PRINTK_CTXT_HARDIRQ	1
+#define PRINTK_CTXT_SOFTIRQ	2
+#define PRINTK_CTXT_NMI		3
+
+
+struct printk_caller_info {
+	u32	ctxt:2;		/* context */
+	u32	cpu:24;		/* CPU number */
+	u32	pid;		/* PID of the process */
+};
+
 /*
  * Meta information about each stored message.
  *
@@ -19,8 +31,7 @@ struct printk_info {
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
-	u32	caller_id;	/* thread id or processor id */
-
+	struct printk_caller_info caller_info;
 	struct dev_printk_info	dev_info;
 };
 
