Return-Path: <linux-kernel+bounces-14748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E704D822178
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39071C2172D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2048015AD8;
	Tue,  2 Jan 2024 18:55:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB815E95;
	Tue,  2 Jan 2024 18:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D947C433C7;
	Tue,  2 Jan 2024 18:55:36 +0000 (UTC)
Date: Tue, 2 Jan 2024 13:56:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ubisectech Sirius" <bugreport@ubisectech.com>
Cc: "mhiramat" <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: BUG: unable to handle page fault for address: fffffffffffffff0
 in tracefs_apply_options
Message-ID: <20240102135637.3a21fb10@gandalf.local.home>
In-Reply-To: <b8aea365-a20f-4726-ba7c-46e4229d5e3a.bugreport@ubisectech.com>
References: <b8aea365-a20f-4726-ba7c-46e4229d5e3a.bugreport@ubisectech.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jan 2024 18:54:26 +0800
"Ubisectech Sirius" <bugreport@ubisectech.com> wrote:

> Dear concerned.
> Greetings!
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.Recently, our team has discovered a issue in Linux kernel 6.7.
> technical details:
> 1. Vulnerability Description: BUG: unable to handle page fault for address: fffffffffffffff0 in tracefs_apply_options

This is not a vulnerability, as it requires root privilege to trigger.

Taking off security list and adding LKML and linux-trace-kernel.


> 2. stack dump: 
> [ 1938.699609][ T8046] BUG: unable to handle page fault for address: fffffffffffffff0
> [ 1938.702696][ T8046] #PF: supervisor read access in kernel mode
> [ 1938.704647][ T8046] #PF: error_code(0x0000) - not-present page
> [ 1938.706699][ T8046] PGD 8f7a067 P4D 8f7a067 PUD 8f7c067 PMD 0
> [ 1938.708939][ T8046] Oops: 0000 [#1] PREEMPT SMP KASAN
> [ 1938.710819][ T8046] CPU: 0 PID: 8046 Comm: poc Not tainted 6.7.0-rc8-g610a9b8f49fb #4
> [ 1938.713729][ T8046] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [ 1938.717282][ T8046] RIP: 0010:tracefs_apply_options.isra.0 (fs/tracefs/inode.c:224 fs/tracefs/inode.c:337)
> [ 1938.720778][ T8046] Code: 24 1c 41 89 47 08 4c 8b bb 60 ff ff ff 4c 89 ff 48 83 ef 10 74 31 48 89 7c 24 08 e8 c7 61 f8 fe 48 8b 7c 24 08 e8 2d b5 30 ff <49> 8b 47 f0 31 ff 83 e0 02 49 89 c7 48 89 c6 e8 e9 5d f8 fe 4d 85
> All code
> ========
>  0: 24 1c and $0x1c,%al
>  2: 41 89 47 08 mov %eax,0x8(%r15)
>  6: 4c 8b bb 60 ff ff ff mov -0xa0(%rbx),%r15
>  d: 4c 89 ff mov %r15,%rdi
>  10: 48 83 ef 10 sub $0x10,%rdi
>  14: 74 31 je 0x47
>  16: 48 89 7c 24 08 mov %rdi,0x8(%rsp)
>  1b: e8 c7 61 f8 fe call 0xfffffffffef861e7
>  20: 48 8b 7c 24 08 mov 0x8(%rsp),%rdi
>  25: e8 2d b5 30 ff call 0xffffffffff30b557
>  2a:* 49 8b 47 f0 mov -0x10(%r15),%rax <-- trapping instruction
>  2e: 31 ff xor %edi,%edi
>  30: 83 e0 02 and $0x2,%eax
>  33: 49 89 c7 mov %rax,%r15
>  36: 48 89 c6 mov %rax,%rsi
>  39: e8 e9 5d f8 fe call 0xfffffffffef85e27
>  3e: 4d rex.WRB
>  3f: 85 .byte 0x85
> Code starting with the faulting instruction
> ===========================================
>  0: 49 8b 47 f0 mov -0x10(%r15),%rax
>  4: 31 ff xor %edi,%edi
>  6: 83 e0 02 and $0x2,%eax
>  9: 49 89 c7 mov %rax,%r15
>  c: 48 89 c6 mov %rax,%rsi
>  f: e8 e9 5d f8 fe call 0xfffffffffef85dfd
>  14: 4d rex.WRB
>  15: 85 .byte 0x85
> [ 1938.728026][ T8046] RSP: 0018:ffff8880228dfca0 EFLAGS: 00010246
> [ 1938.730241][ T8046] RAX: 0000000000000000 RBX: ffff888020c4cf00 RCX: ffffffff8261a573
> [ 1938.733108][ T8046] RDX: dffffc0000000000 RSI: ffffffff8261a569 RDI: fffffffffffffff0
> [ 1938.736001][ T8046] RBP: ffff88801140d6a0 R08: ffffffff81457a74 R09: ffffed100451bf86
> [ 1938.738918][ T8046] R10: 0000000000000003 R11: 0000000000000002 R12: ffff88801140d7b8
> [ 1938.741677][ T8046] R13: ffff888020c4ce88 R14: ffff88801140d730 R15: 0000000000000000
> [ 1938.744445][ T8046] FS: 00007f35440c2640(0000) GS:ffff88802d200000(0000) knlGS:0000000000000000
> [ 1938.747704][ T8046] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1938.750058][ T8046] CR2: fffffffffffffff0 CR3: 000000001885e000 CR4: 0000000000750ef0
> [ 1938.753025][ T8046] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1938.755888][ T8046] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1938.758848][ T8046] PKRU: 55555554
> [ 1938.760125][ T8046] Call Trace:
> [ 1938.761327][ T8046] <TASK>
> [ 1938.762430][ T8046] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [ 1938.764058][ T8046] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
> [ 1938.765504][ T8046] ? page_fault_oops (arch/x86/mm/fault.c:703)
> [ 1938.767316][ T8046] ? search_extable (lib/extable.c:115)
> [ 1938.770094][ T8046] ? dump_pagetable (arch/x86/mm/fault.c:635)
> [ 1938.771836][ T8046] ? pgtable_bad (arch/x86/mm/fault.c:122)
> [ 1938.773468][ T8046] ? preempt_count_add (kernel/sched/core.c:5841)
> [ 1938.775301][ T8046] ? preempt_count_sub (kernel/sched/core.c:5865)
> [ 1938.777117][ T8046] ? search_module_extables (kernel/module/main.c:3243 (discriminator 3))
> [ 1938.779095][ T8046] ? fixup_exception (arch/x86/mm/extable.c:305)
> [ 1938.780930][ T8046] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:761)
> [ 1938.783041][ T8046] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:819)
> [ 1938.784770][ T8046] ? do_kern_addr_fault (arch/x86/mm/fault.c:1227)
> [ 1938.785242][ T8046] ? exc_page_fault (arch/x86/mm/fault.c:1503 arch/x86/mm/fault.c:1561)
> [ 1938.786979][ T8046] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)
> [ 1938.788858][ T8046] ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:93 kernel/locking/spinlock_debug.c:117)
> [ 1938.789530][ T8046] ? tracefs_apply_options.isra.0 (fs/tracefs/inode.c:224 fs/tracefs/inode.c:337)
> [ 1938.790145][ T8046] ? tracefs_apply_options.isra.0 (fs/tracefs/inode.c:224 fs/tracefs/inode.c:337)
> [ 1938.790957][ T8046] ? tracefs_apply_options.isra.0 (fs/tracefs/inode.c:224 fs/tracefs/inode.c:337)
> [ 1938.791740][ T8046] ? tracefs_apply_options.isra.0 (./include/linux/rcupdate.h:301 ./include/linux/rcupdate.h:747 fs/tracefs/inode.c:239 fs/tracefs/inode.c:337)
> [ 1938.792510][ T8046] tracefs_remount (fs/tracefs/inode.c:356)
> [ 1938.793134][ T8046] ? tracefs_apply_options.isra.0 (fs/tracefs/inode.c:344)
> [ 1938.793925][ T8046] legacy_reconfigure (fs/fs_context.c:685 (discriminator 4))
> [ 1938.794573][ T8046] reconfigure_super (fs/super.c:1144)
> [ 1938.795218][ T8046] ? fs_umode_to_dtype (fs/fs_context.c:678)
> [ 1938.795881][ T8046] path_mount (fs/namespace.c:2885 fs/namespace.c:3656)
> [ 1938.796501][ T8046] ? finish_automount (fs/namespace.c:3591)
> [ 1938.797066][ T8046] ? putname (fs/namei.c:275)
> [ 1938.797455][ T8046] __x64_sys_mount (fs/namespace.c:3678 fs/namespace.c:3886 fs/namespace.c:3863 fs/namespace.c:3863)
> [ 1938.797914][ T8046] ? copy_mnt_ns (fs/namespace.c:3863)
> [ 1938.798356][ T8046] ? syscall_enter_from_user_mode (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:77 kernel/entry/common.c:111)
> [ 1938.798899][ T8046] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 1938.799329][ T8046] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 1938.799882][ T8046] RIP: 0033:0x7f3543fe1f29
> [ 1938.800302][ T8046] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
> All code
> ========
>  0: 00 c3 add %al,%bl
>  2: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>  9: 00 00 00
>  c: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
>  11: 48 89 f8 mov %rdi,%rax
>  14: 48 89 f7 mov %rsi,%rdi
>  17: 48 89 d6 mov %rdx,%rsi
>  1a: 48 89 ca mov %rcx,%rdx
>  1d: 4d 89 c2 mov %r8,%r10
>  20: 4d 89 c8 mov %r9,%r8
>  23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
>  28: 0f 05 syscall
>  2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instruction
>  30: 73 01 jae 0x33
>  32: c3 ret
>  33: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f71
>  3a: f7 d8 neg %eax
>  3c: 64 89 01 mov %eax,%fs:(%rcx)
>  3f: 48 rex.W
> Code starting with the faulting instruction
> ===========================================
>  0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
>  6: 73 01 jae 0x9
>  8: c3 ret
>  9: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f47
>  10: f7 d8 neg %eax
>  12: 64 89 01 mov %eax,%fs:(%rcx)
>  15: 48 rex.W
> [ 1938.801974][ T8046] RSP: 002b:00007ffd26d393d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [ 1938.802718][ T8046] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3543fe1f29
> [ 1938.803413][ T8046] RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000000
> [ 1938.804106][ T8046] RBP: 00007ffd26d39420 R08: 0000000020000140 R09: 0000000000000000
> [ 1938.804951][ T8046] R10: 0000000002200022 R11: 0000000000000246 R12: 000055a88be16280
> [ 1938.806036][ T8046] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 1938.807052][ T8046] </TASK>
> [ 1938.807455][ T8046] Modules linked in:
> [ 1938.807986][ T8046] CR2: fffffffffffffff0
> [ 1938.808524][ T8046] ---[ end trace 0000000000000000 ]---
> 3. Attachment description: Attached to the email were a POC file of the vulnerability and a configuration my Linux kernel.
> Thank you for taking the time to read this email and we look forward to working with you further.
>  Ubisectech Sirius Team
>  Web: www.ubisectech.com
>  Email: bugreport@ubisectech.com

Thanks for the report and supplying the reproducer, which I was able to use
to create a simple program that triggers it as well. That is this:

#define BUF_SIZE 256

#define getdents64(fd, dirp, count) syscall(SYS_getdents64, fd, dirp, count)

#define TDIR "/tmp/file0"

int main(void)
{
	char buf[BUF_SIZE];
	int ret;
	int fd;
	int n;

	ret = mkdir(TDIR, 0777);
	if (ret < 0)
		perror("mkdir");
	ret = mount(NULL, TDIR, "tracefs", 0, NULL);
	if (ret < 0)
		perror("mount tracefs 1");

	fd = openat(AT_FDCWD, TDIR, O_RDONLY);
	if (fd < 0)
		perror("openat");

	n = getdents64(fd, buf, BUF_SIZE);
	if (n < 0)
		perror("getdents64");

	ret = mount(NULL, TDIR, NULL, MS_NOSUID|MS_REMOUNT|MS_RELATIME|MS_LAZYTIME,
		    "gid=1000");
	if (ret < 0)
		perror("mount tracefs 2");

	return 0;
}


I originally had BUF_SIZE 32K which was big enough to read all the files in
that getdents64() at once, and it did not trigger. I then lowered it to
256, and then I was able to hit the bug. It appears that the bug is
triggered when getdents64 doesn't read all the events. Looking deeper into
it looks like the implementation of getdents64 will insert a "cursor" into
the list of subdirs.

What happens is this:

  getdents64() doesn't finish, which leaves the "cursor" dentry in the
  subdirs of the parent. But this dentry does not have an inode attached to
  it.

Then when the mount happens and the gid is set, it walks the dentry tree
and needs to do something extra for eventfs, so it checks the dentry inode
flags:

        while (next != &this_parent->d_subdirs) {
                struct tracefs_inode *ti;
                struct list_head *tmp = next;
                struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
                next = tmp->next;

                spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);

                change_gid(dentry, gid);

                /* If this is the events directory, update that too */
                ti = get_tracefs(dentry->d_inode);
                if (ti && (ti->flags & TRACEFS_EVENT_INODE))
                        eventfs_update_gid(dentry, gid);

But because dentry is a cursor, it does not have any d_inode, and the above
will crash.

This is the fix to the bug:

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 62524b20964e..c29387a36bc8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -219,10 +219,13 @@ static void set_gid(struct dentry *parent, kgid_t gid)
 
 		change_gid(dentry, gid);
 
-		/* If this is the events directory, update that too */
-		ti = get_tracefs(dentry->d_inode);
-		if (ti && (ti->flags & TRACEFS_EVENT_INODE))
-			eventfs_update_gid(dentry, gid);
+		/* Note, getdents() can add a cursor dentry with no inode */
+		if (dentry->d_inode) {
+			/* If this is the events directory, update that too */
+			ti = get_tracefs(dentry->d_inode);
+			if (ti && (ti->flags & TRACEFS_EVENT_INODE))
+				eventfs_update_gid(dentry, gid);
+		}
 
 		if (!list_empty(&dentry->d_subdirs)) {
 			spin_unlock(&this_parent->d_lock);


-- Steve


