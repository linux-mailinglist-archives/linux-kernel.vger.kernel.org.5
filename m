Return-Path: <linux-kernel+bounces-65483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC67854DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B841F23330
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857D15F875;
	Wed, 14 Feb 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEIXjw6n"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428B5C917
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926750; cv=none; b=UPIoGc8VGxXD2NyQ0uzGLJCpU12aDb+5soHd55ankyEvKHFkdnjgyB8dxE8uMYupmdRXxd24tFmh47yIKNz3E0gsi7L0UnFp3RAaQNku2jgccX7pBSdwLPSHtJHysoMfbk5a8NvWclyZhw4PSoEZ+MjuLp9qjOowvvupPJWAnTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926750; c=relaxed/simple;
	bh=dc1KQpY0JaxYBA4PG7k53I+9SMfrAWxXKgE5iyHjJ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1XEHwkB7inQITqK8WuOm589rhPuTZhDLmJ/aSqvpDM9TSvwctcnYxLmaw2DXpPX7z8r2+9o+SZZ/31aNrc/fpW79RlywlDrS1oRSzh8/lKSdCw3T2jkZJ57bFlRAz3S30wcW9NrIX45y2TSeCZhqMbxURGuzarcL+dINw3YwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEIXjw6n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso91235e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707926746; x=1708531546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0ZXpfKsVxZsard92upIgK/guQSZv3oZnwS2SvpnT4A=;
        b=MEIXjw6nY91nWXEVl/kjohanka7g716qRufSWAk+bGomW7W6lELukjL/1Dnt28uRj2
         i+4uo0U3XXf7AoC6ahQtcLD7/6iWyx8acJhcyAgMObz/jwhFdoUmpDm7hK4vcdEmSTdE
         F58ymKXo5cej04qnQaLzjNmZG+Cby9xIqEEjmUTl44RiHEgzHwk6wvViRyIyuR3bF50K
         9zRnbHM9pnhMyYoGArQSiuX+4Mp/DydBwEK/u/lh/uOm6Ha6FCHRmiJnAJdtSpdP+MwC
         8cbHNlKz9kVskBTxtq0kFlFyqsN9nnyE3tCxzjrD3kyWfcApXOwfBeufwI3CA4D8Svh0
         IRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926746; x=1708531546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0ZXpfKsVxZsard92upIgK/guQSZv3oZnwS2SvpnT4A=;
        b=P6DptKqPwplWfBtiSNg/QMrUJBPduyZOzW/N0uGij5ZYDYYTmyL1gqG9UP0poK1NJg
         klLoLIZ25b571Kr6suBOQlIjW592QNI9dkWQEYXAW7GFJVoKlyGcAg15cPP/CmorgDKE
         HTWTgMDVxZqwlMhSDhO5/wUEM9COWxEvdWR5fNqYEhP4TwozieBaqOCItWDa+J/edqv4
         OlneWcoA2cpGDv45iBizWmBWjCZlDsPh2dXCgRa+RcSg3YrG4xohz3F9FI57/pIv30a1
         TD2u/GuTNGaCDTQ5zeHchDBvPYLt8aot53o9FuqgdhliiqogsR27UlqpIDWw18ef+pTz
         gcYw==
X-Forwarded-Encrypted: i=1; AJvYcCXdTEQ64abOgOwAXMCEjGHV8NYujstB4yL9uuTTr9AQFakf+frpg7v8GSfgFq5nyaK6j4DccXyCofPwbDfAQJFSrUbSUT1285RahEKC
X-Gm-Message-State: AOJu0Ywtuzo/Pjvn/qQSZvOFMm+a6FCQw8+KL5WGm2zU2njYWlOdpemM
	Xe07NAsrqXb7Dau3XMkX0Yp2mi3OP5TqT31ZkTQdzxIr7jYAflx7aKJ+FZUMdw==
X-Google-Smtp-Source: AGHT+IFQx3AR+dJ4tRuny2Zl3PYxdt3LuDwruLklz7IHA3o+QvX7gRTt7eytQ7BUceKnARE9I8n+Sw==
X-Received: by 2002:a05:600c:519b:b0:411:e5c1:9b2a with SMTP id fa27-20020a05600c519b00b00411e5c19b2amr161066wmb.2.1707926746115;
        Wed, 14 Feb 2024 08:05:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwwkkMnTjoYEDNabe8vKqZdn5tv9oDKwRWK4zf5GsCOWHcf/AVXcvm52C5bTuLK2NbqXtblzKIkrpdtJeCa9hhed3VVSbYEDUx6curN4LLsKnOqFixNfhl9htsCIwkPiXU4F9B/uqjZhfOYcLix0x2v9gzCQgnkiSDq10Qq3/qTY6TVGv4EbpIJDgJB7McV2I+5xL4HBSW3OkV67lySg/bQm1ulJVesuup+MG96wCqEQmQg0KL2DkkKFKdy+e4quYRaAXr7JCLAgP4jxINha04ZDK/LTDAi35fpr3wdxE=
Received: from localhost ([2a02:168:96c5:1:cead:684f:86ff:5d41])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c4b1600b0040fdb244485sm2291938wmp.40.2024.02.14.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:05:44 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH] security: fix integer overflow in lsm_set_self_attr() syscall
Date: Wed, 14 Feb 2024 17:05:38 +0100
Message-ID: <20240214160538.1086089-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

security_setselfattr() has an integer overflow bug that leads to
out-of-bounds access when userspace provides bogus input:
`lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
redundantly, also against `size`), but there are no checks on
`lctx->ctx_len`.
Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
will then be passed to an LSM module as a buffer length, causing LSM
modules to perform out-of-bounds accesses.

The following reproducer will demonstrate this under ASAN (if AppArmor is
loaded as an LSM):
```
#define _GNU_SOURCE
#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/syscall.h>

struct lsm_ctx {
  uint64_t id;
  uint64_t flags;
  uint64_t len;
  uint64_t ctx_len;
  char ctx[];
};

int main(void) {
  size_t size = sizeof(struct lsm_ctx);
  struct lsm_ctx *ctx = malloc(size);
  ctx->id = 104/*LSM_ID_APPARMOR*/;
  ctx->flags = 0;
  ctx->len = size;
  ctx->ctx_len = -sizeof(struct lsm_ctx);
  syscall(
    460/*__NR_lsm_set_self_attr*/,
    /*attr=*/  100/*LSM_ATTR_CURRENT*/,
    /*ctx=*/   ctx,
    /*size=*/  size,
    /*flags=*/ 0
  );
}
```

(I'm including an ASAN splat in the patch notes sent to the list.)

Fixes: a04a1198088a ("LSM: syscalls for current process attributes")
Signed-off-by: Jann Horn <jannh@google.com>
---
ASAN splat from the reproducer:
==================================================================
BUG: KASAN: slab-out-of-bounds in do_setattr (security/apparmor/lsm.c:860) 
Read of size 1 at addr ffff888006163abf by task setselfattr/548

CPU: 0 PID: 548 Comm: setselfattr Not tainted 6.8.0-rc4-00014-g7e90b5c295ec-dirty #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:107) 
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488) 
[...]
kasan_report (mm/kasan/report.c:603) 
[...]
do_setattr (security/apparmor/lsm.c:860) 
[...]
apparmor_setselfattr (security/apparmor/lsm.c:935) 
security_setselfattr (security/security.c:4038) 
__x64_sys_lsm_set_self_attr (security/lsm_syscalls.c:55) 
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
RIP: 0033:0x7f29a170ff59
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 c3                	add    %al,%bl
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 07 6f 0c 00 	mov    0xc6f07(%rip),%rcx        # 0xc6f41
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 07 6f 0c 00 	mov    0xc6f07(%rip),%rcx        # 0xc6f17
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
RSP: 002b:00007ffd41c781a8 EFLAGS: 00000202 ORIG_RAX: 00000000000001cc
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f29a170ff59
RDX: 0000000000000020 RSI: 000056518c581260 RDI: 0000000000000064
RBP: 00007ffd41c781c0 R08: 00000000000a3330 R09: 000056518c581260
R10: 0000000000000000 R11: 0000000000000202 R12: 000056518bd95060
R13: 00007ffd41c782a0 R14: 0000000000000000 R15: 0000000000000000
</TASK>

Allocated by task 548 on cpu 0 at 61.045304s:
kasan_save_stack (mm/kasan/common.c:48) 
kasan_save_track (mm/kasan/common.c:68) 
__kasan_kmalloc (mm/kasan/common.c:372 mm/kasan/common.c:389) 
__kmalloc (./include/linux/kasan.h:211 mm/slub.c:3981 mm/slub.c:3994) 
load_elf_binary (./include/linux/slab.h:594 fs/binfmt_elf.c:880) 
bprm_execve (fs/exec.c:1783 fs/exec.c:1825 fs/exec.c:1877 fs/exec.c:1853) 
do_execveat_common.isra.0 (fs/exec.c:1984) 
__x64_sys_execve (fs/exec.c:2129 (discriminator 1)) 
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 

Freed by task 548 on cpu 0 at 61.045380s:
kasan_save_stack (mm/kasan/common.c:48) 
kasan_save_track (mm/kasan/common.c:68) 
kasan_save_free_info (mm/kasan/generic.c:643 (discriminator 1)) 
poison_slab_object (mm/kasan/common.c:243) 
__kasan_slab_free (mm/kasan/common.c:257 (discriminator 1)) 
kfree (mm/slub.c:4299 (discriminator 3) mm/slub.c:4409 (discriminator 3)) 
load_elf_binary (fs/binfmt_elf.c:896 (discriminator 1)) 
bprm_execve (fs/exec.c:1783 fs/exec.c:1825 fs/exec.c:1877 fs/exec.c:1853) 
do_execveat_common.isra.0 (fs/exec.c:1984) 
__x64_sys_execve (fs/exec.c:2129 (discriminator 1)) 
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 

The buggy address belongs to the object at ffff888006163a80
which belongs to the cache kmalloc-32 of size 32
The buggy address is located 31 bytes to the right of
allocated 32-byte region [ffff888006163a80, ffff888006163aa0)

The buggy address belongs to the physical page:
page:0000000021a8da3a refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6163
flags: 0x100000000000800(slab|node=0|zone=1)
page_type: 0xffffffff()
raw: 0100000000000800 ffff888001042500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff888006163980: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
ffff888006163a00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff888006163a80: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
^
ffff888006163b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff888006163b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


 security/security.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index 3aaad75c9ce8..7035ee35a393 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/overflow.h>
 #include <net/flow.h>
 
 /* How many LSMs were built into the kernel? */
@@ -4015,6 +4016,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 	struct security_hook_list *hp;
 	struct lsm_ctx *lctx;
 	int rc = LSM_RET_DEFAULT(setselfattr);
+	u64 required_len;
 
 	if (flags)
 		return -EINVAL;
@@ -4027,8 +4029,9 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 	if (IS_ERR(lctx))
 		return PTR_ERR(lctx);
 
-	if (size < lctx->len || size < lctx->ctx_len + sizeof(*lctx) ||
-	    lctx->len < lctx->ctx_len + sizeof(*lctx)) {
+	if (size < lctx->len ||
+	    check_add_overflow(sizeof(*lctx), lctx->ctx_len, &required_len) ||
+	    lctx->len < required_len) {
 		rc = -EINVAL;
 		goto free_out;
 	}

base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
-- 
2.43.0.687.g38aa6559b0-goog


