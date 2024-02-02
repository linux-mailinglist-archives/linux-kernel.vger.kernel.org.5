Return-Path: <linux-kernel+bounces-49733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E024846EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8931F29DA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05907CF02;
	Fri,  2 Feb 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGROfDZC"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748113D51A;
	Fri,  2 Feb 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872199; cv=none; b=qIIewU2RRnQHXoY/ntNu97NAFL7UNmg7MgJfHIlkDx6KB4pSXHh4JoWqprK5cIoan1JXuaOX14ikA81gMzSgSDjSK9JzyXpF9SOtQsEjtGrdW/dStbdadI0g1q70bJkAFBdPIrtNq6Ey8LpUD5VMlIv222Atto5+bbezIJWCAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872199; c=relaxed/simple;
	bh=X6zTdPu7q+ky9bI/TVHh3VIOLYv4cXdGKlT4s4bd32w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UXGKXjg1bkMU4W3jUP82tFlj+YvERF+r4oOGgm7DRDQRaie9Isl1QDCY7xaFJTY7IqNkvuRyNBq+p7EcejOwkCU0z5iwZ04og73mTXm9LffmghWOhZL+xtwseb/JvvPnwSb1nAe/aZj7h9oj23mlbdK9IAmPsBt8jSKaL9wzEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGROfDZC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dfefb490f9so885857b3a.1;
        Fri, 02 Feb 2024 03:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706872197; x=1707476997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0uevE00N2VNORMMvDaYdbLe3Qk40nLjTGjTYBxqzdg=;
        b=ZGROfDZCngVMJOE/9LjcD1tC8bqg/fnvseBhPGBFL9NuLNyUCTFpxs0EgC8gVZpY+R
         epCqUs94TBeE1zIoysEbzTiNfpkyK1swvXpkpCwnf/rGU7tscf6gzavIs0n3g6sa260X
         Ysggf286wcvYt+43T9l35OxMjVBXQXUdjy8b66mNz2/yoof1DQyxIvSj+pN/9oqwC9sa
         DYu8V4n7y8NqUK6w4AUG5t8pbnjrwEZ15po66cCIJQ3ZUTh6igolJsP3BVLw0qOvkYf9
         X+0DTGaZKOy4XiIgmbHawcT4/MQOV1IfDZnE8tgFtj52VHk7ddoS2/720l/8zldW3d9a
         1TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706872197; x=1707476997;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0uevE00N2VNORMMvDaYdbLe3Qk40nLjTGjTYBxqzdg=;
        b=PwBDnPHi7er5IXMxvcvKKDcrb0j3Y6zDfv54bDypvcIczhoAxSy4cKIYsxf0BDh6vo
         8qQ5NGYFXADrzojvVaIN1GBxpUyKAsDwemWKLUqU6TYTGXcBIXsb3fHwDpnSmnp3gcOv
         /DnxAgkdcepvRnlEQJx1GBbqix3Pj9PIEe5xZP8jgo9xoXEHC9eQPGQdM7ss5UDY99Wf
         zEYhkDpln2L3/sH9tH2LfvZA9fc1Wx/ZGpMKZc1WqTIyosQjICZcT6qFi4eu80V/cyTI
         alIoewxeuifSv9OLUIK/5SGC/cMrA6+c9fvJdAvmFDateIfbMzYiGuTgaRcvFpGUGq3w
         uXDA==
X-Gm-Message-State: AOJu0YwPy2JcJ9Fq3/XZkE5r8ziimiLCroqWpwI1doO9P0QWrhjeYMGz
	mdRm568Bhn4+FV2Cphkqj7wm+Yp9peSLGQ8oNzGJ14Y2wdqJYqk+BJd3NlGMC2YAo3pe0XumxRC
	nAa2ut9uBfo/qRGi8+l/WfaKn1Q0CJ+NR
X-Google-Smtp-Source: AGHT+IEBvbL67/vqCyz6cPWgUcOr0lEXVZyb7k2lXlX5zzfi+l8urs03IKU5LF673X8RulQcRszblz1km/qDIITsyuU=
X-Received: by 2002:a62:cecb:0:b0:6db:cace:5f60 with SMTP id
 y194-20020a62cecb000000b006dbcace5f60mr1653975pfg.8.1706872196500; Fri, 02
 Feb 2024 03:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Fri, 2 Feb 2024 19:09:43 +0800
Message-ID: <CABOYnLxOc6fTOEX4C_=0t4_+Qv9VrUTJUg4g6+JSAg+v34UaRg@mail.gmail.com>
Subject: WARNING in ovl_copy_up_file
To: amir73il@gmail.com, linux-unionfs@vger.kernel.org, miklos@szeredi.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello I found a bug in latest upstream titled "WARNING in
ovl_copy_up_file" with modified syzkaller and maybe is related with
overlays, and I also reproduce it with repro.c and repro.txt

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

kernel: upstream 021533194476035883300d60fbb3136426ac8ea5
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=457249c250b93697
with KASAN enabled
compiler: gcc (Debian 12.2.0-14) 12.2.0

------------[ cut here ]------------
WARNING: CPU: 3 PID: 77145 at fs/overlayfs/copy_up.c:239
ovl_copy_up_file+0x6ca/0x6f0 fs/overlayfs/copy_up.c:332
Modules linked in:
CPU: 3 PID: 77145 Comm: syz-executor.0 Not tainted
6.8.0-rc1-00208-g6af191034c8f-dirty #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ovl_verify_area fs/overlayfs/copy_up.c:239 [inline]
RIP: 0010:ovl_copy_up_file+0x6ca/0x6f0 fs/overlayfs/copy_up.c:332
Code: ff e8 6a 62 47 ff 0f 0b 41 bc fb ff ff ff 48 8b 5c 24 18 e9 7c
ff ff ff 31 ff e8 51 62 47 ff 0f 0b eb 14 31 ff e8 46 62 47 ff <0f> 0b
eb 09 31 ff e8 3b 62 47 ff 0f 0b 41 bc fb ff ff ff e9 1d fb
RSP: 0018:ffff88804417f440 EFLAGS: 00010246
RAX: ffffffff81fb8c4a RBX: 0000000000800000 RCX: ffffc9000c04c000
RDX: ffffffff81fb8c4a RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88804417f570 R08: 000000000000a4dd R09: 000000000000a4de
R10: ffffed102063f949 R11: ffffed102063f949 R12: ffff8881031fca40
R13: 0000000000800000 R14: ffff88804417f4c0 R15: ffffffffffeac000
FS:  00007fd4f579c6c0(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc0bff9d988 CR3: 0000000013cc4000 CR4: 0000000000752ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:865 [inline]
ovl_do_copy_up fs/overlayfs/copy_up.c:978 [inline]
ovl_copy_up_one fs/overlayfs/copy_up.c:1170 [inline]
ovl_copy_up_flags+0x1717/0x2cc0 fs/overlayfs/copy_up.c:1225
ovl_copy_up+0x20/0x30 fs/overlayfs/copy_up.c:1265
ovl_setattr+0xc1/0x370 fs/overlayfs/inode.c:41
notify_change+0x8d2/0x960 fs/attr.c:499
chmod_common+0x1d5/0x330 fs/open.c:648
do_fchmodat fs/open.c:696 [inline]
__do_sys_fchmodat fs/open.c:715 [inline]
__se_sys_fchmodat fs/open.c:712 [inline]
__x64_sys_fchmodat+0xea/0x180 fs/open.c:712
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd4f647cc29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd4f579c0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000010c
RAX: ffffffffffffffda RBX: 00007fd4f659c1f0 RCX: 00007fd4f647cc29
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007fd4f64c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fd4f659c1f0 R15: 00007ffc819fff88
</TASK>
---[ end trace 0000000000000000 ]---

=* repro.c =*
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>
#include <linux/loop.h>

#ifndef __NR_memfd_create
#define __NR_memfd_create 319
#endif

static unsigned long long procid;

static __thread int clone_ongoing;
static __thread int skip_segv;
static __thread jmp_buf segv_env;

static void segv_handler(int sig, siginfo_t* info, void* ctx) {
 if (__atomic_load_n(&clone_ongoing, __ATOMIC_RELAXED) != 0) {
   exit(sig);
 }
 uintptr_t addr = (uintptr_t)info->si_addr;
 const uintptr_t prog_start = 1 << 20;
 const uintptr_t prog_end = 100 << 20;
 int skip = __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) != 0;
 int valid = addr < prog_start || addr > prog_end;
 if (skip && valid) {
   _longjmp(segv_env, 1);
 }
 exit(sig);
}

static void install_segv_handler(void) {
 struct sigaction sa;
 memset(&sa, 0, sizeof(sa));
 sa.sa_handler = SIG_IGN;
 syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
 syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
 memset(&sa, 0, sizeof(sa));
 sa.sa_sigaction = segv_handler;
 sa.sa_flags = SA_NODEFER | SA_SIGINFO;
 sigaction(SIGSEGV, &sa, NULL);
 sigaction(SIGBUS, &sa, NULL);
}

#define NONFAILING(...)                                  \
 ({                                                     \
   int ok = 1;                                          \
   __atomic_fetch_add(&skip_segv, 1, __ATOMIC_SEQ_CST); \
   if (_setjmp(segv_env) == 0) {                        \
     __VA_ARGS__;                                       \
   } else                                               \
     ok = 0;                                            \
   __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST); \
   ok;                                                  \
 })

static void sleep_ms(uint64_t ms) {
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void use_temporary_dir(void) {
 char tmpdir_template[] = "./syzkaller.XXXXXX";
 char* tmpdir = mkdtemp(tmpdir_template);
 if (!tmpdir)
   exit(1);
 if (chmod(tmpdir, 0777))
   exit(1);
 if (chdir(tmpdir))
   exit(1);
}

static void thread_start(void* (*fn)(void*), void* arg) {
 pthread_t th;
 pthread_attr_t attr;
 pthread_attr_init(&attr);
 pthread_attr_setstacksize(&attr, 128 << 10);
 int i = 0;
 for (; i < 100; i++) {
   if (pthread_create(&th, &attr, fn, arg) == 0) {
     pthread_attr_destroy(&attr);
     return;
   }
   if (errno == EAGAIN) {
     usleep(50);
     continue;
   }
   break;
 }
 exit(1);
}

typedef struct {
 int state;
} event_t;

static void event_init(event_t* ev) {
 ev->state = 0;
}

static void event_reset(event_t* ev) {
 ev->state = 0;
}

static void event_set(event_t* ev) {
 if (ev->state)
   exit(1);
 __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
 syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
 while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
 return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
 uint64_t start = current_time_ms();
 uint64_t now = start;
 for (;;) {
   uint64_t remain = timeout - (now - start);
   struct timespec ts;
   ts.tv_sec = remain / 1000;
   ts.tv_nsec = (remain % 1000) * 1000 * 1000;
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
     return 1;
   now = current_time_ms();
   if (now - start > timeout)
     return 0;
 }
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] = 0;
 int len = strlen(buf);
 int fd = open(file, O_WRONLY | O_CLOEXEC);
 if (fd == -1)
   return false;
 if (write(fd, buf, len) != len) {
   int err = errno;
   close(fd);
   errno = err;
   return false;
 }
 close(fd);
 return true;
}

//% This code is derived from puff.{c,h}, found in the zlib development. The
//% original files come with the following copyright notice:

//% Copyright (C) 2002-2013 Mark Adler, all rights reserved
//% version 2.3, 21 Jan 2013
//% This software is provided 'as-is', without any express or implied
//% warranty.  In no event will the author be held liable for any damages
//% arising from the use of this software.
//% Permission is granted to anyone to use this software for any purpose,
//% including commercial applications, and to alter it and redistribute it
//% freely, subject to the following restrictions:
//% 1. The origin of this software must not be misrepresented; you must not
//%    claim that you wrote the original software. If you use this software
//%    in a product, an acknowledgment in the product documentation would be
//%    appreciated but is not required.
//% 2. Altered source versions must be plainly marked as such, and must not be
//%    misrepresented as being the original software.
//% 3. This notice may not be removed or altered from any source distribution.
//% Mark Adler    madler@alumni.caltech.edu

//% BEGIN CODE DERIVED FROM puff.{c,h}

#define MAXBITS 15
#define MAXLCODES 286
#define MAXDCODES 30
#define MAXCODES (MAXLCODES + MAXDCODES)
#define FIXLCODES 288

struct puff_state {
 unsigned char* out;
 unsigned long outlen;
 unsigned long outcnt;
 const unsigned char* in;
 unsigned long inlen;
 unsigned long incnt;
 int bitbuf;
 int bitcnt;
 jmp_buf env;
};
static int puff_bits(struct puff_state* s, int need) {
 long val = s->bitbuf;
 while (s->bitcnt < need) {
   if (s->incnt == s->inlen)
     longjmp(s->env, 1);
   val |= (long)(s->in[s->incnt++]) << s->bitcnt;
   s->bitcnt += 8;
 }
 s->bitbuf = (int)(val >> need);
 s->bitcnt -= need;
 return (int)(val & ((1L << need) - 1));
}
static int puff_stored(struct puff_state* s) {
 s->bitbuf = 0;
 s->bitcnt = 0;
 if (s->incnt + 4 > s->inlen)
   return 2;
 unsigned len = s->in[s->incnt++];
 len |= s->in[s->incnt++] << 8;
 if (s->in[s->incnt++] != (~len & 0xff) ||
     s->in[s->incnt++] != ((~len >> 8) & 0xff))
   return -2;
 if (s->incnt + len > s->inlen)
   return 2;
 if (s->outcnt + len > s->outlen)
   return 1;
 for (; len--; s->outcnt++, s->incnt++) {
   if (s->in[s->incnt])
     s->out[s->outcnt] = s->in[s->incnt];
 }
 return 0;
}
struct puff_huffman {
 short* count;
 short* symbol;
};
static int puff_decode(struct puff_state* s, const struct puff_huffman* h) {
 int first = 0;
 int index = 0;
 int bitbuf = s->bitbuf;
 int left = s->bitcnt;
 int code = first = index = 0;
 int len = 1;
 short* next = h->count + 1;
 while (1) {
   while (left--) {
     code |= bitbuf & 1;
     bitbuf >>= 1;
     int count = *next++;
     if (code - count < first) {
       s->bitbuf = bitbuf;
       s->bitcnt = (s->bitcnt - len) & 7;
       return h->symbol[index + (code - first)];
     }
     index += count;
     first += count;
     first <<= 1;
     code <<= 1;
     len++;
   }
   left = (MAXBITS + 1) - len;
   if (left == 0)
     break;
   if (s->incnt == s->inlen)
     longjmp(s->env, 1);
   bitbuf = s->in[s->incnt++];
   if (left > 8)
     left = 8;
 }
 return -10;
}
static int puff_construct(struct puff_huffman* h, const short* length, int n) {
 int len;
 for (len = 0; len <= MAXBITS; len++)
   h->count[len] = 0;
 int symbol;
 for (symbol = 0; symbol < n; symbol++)
   (h->count[length[symbol]])++;
 if (h->count[0] == n)
   return 0;
 int left = 1;
 for (len = 1; len <= MAXBITS; len++) {
   left <<= 1;
   left -= h->count[len];
   if (left < 0)
     return left;
 }
 short offs[MAXBITS + 1];
 offs[1] = 0;
 for (len = 1; len < MAXBITS; len++)
   offs[len + 1] = offs[len] + h->count[len];
 for (symbol = 0; symbol < n; symbol++)
   if (length[symbol] != 0)
     h->symbol[offs[length[symbol]]++] = symbol;
 return left;
}
static int puff_codes(struct puff_state* s,
                     const struct puff_huffman* lencode,
                     const struct puff_huffman* distcode) {
 static const short lens[29] = {3,  4,  5,  6,   7,   8,   9,   10,  11, 13,
                                15, 17, 19, 23,  27,  31,  35,  43,  51, 59,
                                67, 83, 99, 115, 131, 163, 195, 227, 258};
 static const short lext[29] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2,
                                2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
 static const short dists[30] = {
     1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
     33,   49,   65,   97,   129,  193,  257,  385,   513,   769,
     1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577};
 static const short dext[30] = {0, 0, 0,  0,  1,  1,  2,  2,  3,  3,
                                4, 4, 5,  5,  6,  6,  7,  7,  8,  8,
                                9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
 int symbol;
 do {
   symbol = puff_decode(s, lencode);
   if (symbol < 0)
     return symbol;
   if (symbol < 256) {
     if (s->outcnt == s->outlen)
       return 1;
     if (symbol)
       s->out[s->outcnt] = symbol;
     s->outcnt++;
   } else if (symbol > 256) {
     symbol -= 257;
     if (symbol >= 29)
       return -10;
     int len = lens[symbol] + puff_bits(s, lext[symbol]);
     symbol = puff_decode(s, distcode);
     if (symbol < 0)
       return symbol;
     unsigned dist = dists[symbol] + puff_bits(s, dext[symbol]);
     if (dist > s->outcnt)
       return -11;
     if (s->outcnt + len > s->outlen)
       return 1;
     while (len--) {
       if (dist <= s->outcnt && s->out[s->outcnt - dist])
         s->out[s->outcnt] = s->out[s->outcnt - dist];
       s->outcnt++;
     }
   }
 } while (symbol != 256);
 return 0;
}
static int puff_fixed(struct puff_state* s) {
 static int virgin = 1;
 static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
 static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
 static struct puff_huffman lencode, distcode;
 if (virgin) {
   lencode.count = lencnt;
   lencode.symbol = lensym;
   distcode.count = distcnt;
   distcode.symbol = distsym;
   short lengths[FIXLCODES];
   int symbol;
   for (symbol = 0; symbol < 144; symbol++)
     lengths[symbol] = 8;
   for (; symbol < 256; symbol++)
     lengths[symbol] = 9;
   for (; symbol < 280; symbol++)
     lengths[symbol] = 7;
   for (; symbol < FIXLCODES; symbol++)
     lengths[symbol] = 8;
   puff_construct(&lencode, lengths, FIXLCODES);
   for (symbol = 0; symbol < MAXDCODES; symbol++)
     lengths[symbol] = 5;
   puff_construct(&distcode, lengths, MAXDCODES);
   virgin = 0;
 }
 return puff_codes(s, &lencode, &distcode);
}
static int puff_dynamic(struct puff_state* s) {
 static const short order[19] = {16, 17, 18, 0, 8,  7, 9,  6, 10, 5,
                                 11, 4,  12, 3, 13, 2, 14, 1, 15};
 int nlen = puff_bits(s, 5) + 257;
 int ndist = puff_bits(s, 5) + 1;
 int ncode = puff_bits(s, 4) + 4;
 if (nlen > MAXLCODES || ndist > MAXDCODES)
   return -3;
 short lengths[MAXCODES];
 int index;
 for (index = 0; index < ncode; index++)
   lengths[order[index]] = puff_bits(s, 3);
 for (; index < 19; index++)
   lengths[order[index]] = 0;
 short lencnt[MAXBITS + 1], lensym[MAXLCODES];
 struct puff_huffman lencode = {lencnt, lensym};
 int err = puff_construct(&lencode, lengths, 19);
 if (err != 0)
   return -4;
 index = 0;
 while (index < nlen + ndist) {
   int symbol;
   int len;
   symbol = puff_decode(s, &lencode);
   if (symbol < 0)
     return symbol;
   if (symbol < 16)
     lengths[index++] = symbol;
   else {
     len = 0;
     if (symbol == 16) {
       if (index == 0)
         return -5;
       len = lengths[index - 1];
       symbol = 3 + puff_bits(s, 2);
     } else if (symbol == 17)
       symbol = 3 + puff_bits(s, 3);
     else
       symbol = 11 + puff_bits(s, 7);
     if (index + symbol > nlen + ndist)
       return -6;
     while (symbol--)
       lengths[index++] = len;
   }
 }
 if (lengths[256] == 0)
   return -9;
 err = puff_construct(&lencode, lengths, nlen);
 if (err && (err < 0 || nlen != lencode.count[0] + lencode.count[1]))
   return -7;
 short distcnt[MAXBITS + 1], distsym[MAXDCODES];
 struct puff_huffman distcode = {distcnt, distsym};
 err = puff_construct(&distcode, lengths + nlen, ndist);
 if (err && (err < 0 || ndist != distcode.count[0] + distcode.count[1]))
   return -8;
 return puff_codes(s, &lencode, &distcode);
}
static int puff(unsigned char* dest,
               unsigned long* destlen,
               const unsigned char* source,
               unsigned long sourcelen) {
 struct puff_state s = {
     .out = dest,
     .outlen = *destlen,
     .outcnt = 0,
     .in = source,
     .inlen = sourcelen,
     .incnt = 0,
     .bitbuf = 0,
     .bitcnt = 0,
 };
 int err;
 if (setjmp(s.env) != 0)
   err = 2;
 else {
   int last;
   do {
     last = puff_bits(&s, 1);
     int type = puff_bits(&s, 2);
     err = type == 0 ? puff_stored(&s)
                     : (type == 1 ? puff_fixed(&s)
                                  : (type == 2 ? puff_dynamic(&s) : -1));
     if (err != 0)
       break;
   } while (!last);
 }
 *destlen = s.outcnt;
 return err;
}

//% END CODE DERIVED FROM puff.{c,h}

#define ZLIB_HEADER_WIDTH 2

static int puff_zlib_to_file(const unsigned char* source,
                            unsigned long sourcelen,
                            int dest_fd) {
 if (sourcelen < ZLIB_HEADER_WIDTH)
   return 0;
 source += ZLIB_HEADER_WIDTH;
 sourcelen -= ZLIB_HEADER_WIDTH;
 const unsigned long max_destlen = 132 << 20;
 void* ret = mmap(0, max_destlen, PROT_WRITE | PROT_READ,
                  MAP_PRIVATE | MAP_ANON, -1, 0);
 if (ret == MAP_FAILED)
   return -1;
 unsigned char* dest = (unsigned char*)ret;
 unsigned long destlen = max_destlen;
 int err = puff(dest, &destlen, source, sourcelen);
 if (err) {
   munmap(dest, max_destlen);
   errno = -err;
   return -1;
 }
 if (write(dest_fd, dest, destlen) != (ssize_t)destlen) {
   munmap(dest, max_destlen);
   return -1;
 }
 return munmap(dest, max_destlen);
}

static int setup_loop_device(unsigned char* data,
                            unsigned long size,
                            const char* loopname,
                            int* loopfd_p) {
 int err = 0, loopfd = -1;
 int memfd = syscall(__NR_memfd_create, "syzkaller", 0);
 if (memfd == -1) {
   err = errno;
   goto error;
 }
 if (puff_zlib_to_file(data, size, memfd)) {
   err = errno;
   goto error_close_memfd;
 }
 loopfd = open(loopname, O_RDWR);
 if (loopfd == -1) {
   err = errno;
   goto error_close_memfd;
 }
 if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
   if (errno != EBUSY) {
     err = errno;
     goto error_close_loop;
   }
   ioctl(loopfd, LOOP_CLR_FD, 0);
   usleep(1000);
   if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
     err = errno;
     goto error_close_loop;
   }
 }
 close(memfd);
 *loopfd_p = loopfd;
 return 0;

error_close_loop:
 close(loopfd);
error_close_memfd:
 close(memfd);
error:
 errno = err;
 return -1;
}

static long syz_mount_image(volatile long fsarg,
                           volatile long dir,
                           volatile long flags,
                           volatile long optsarg,
                           volatile long change_dir,
                           volatile unsigned long size,
                           volatile long image) {
 unsigned char* data = (unsigned char*)image;
 int res = -1, err = 0, loopfd = -1, need_loop_device = !!size;
 char* mount_opts = (char*)optsarg;
 char* target = (char*)dir;
 char* fs = (char*)fsarg;
 char* source = NULL;
 char loopname[64];
 if (need_loop_device) {
   memset(loopname, 0, sizeof(loopname));
   snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
   if (setup_loop_device(data, size, loopname, &loopfd) == -1)
     return -1;
   source = loopname;
 }
 mkdir(target, 0777);
 char opts[256];
 memset(opts, 0, sizeof(opts));
 if (strlen(mount_opts) > (sizeof(opts) - 32)) {
 }
 strncpy(opts, mount_opts, sizeof(opts) - 32);
 if (strcmp(fs, "iso9660") == 0) {
   flags |= MS_RDONLY;
 } else if (strncmp(fs, "ext", 3) == 0) {
   bool has_remount_ro = false;
   char* remount_ro_start = strstr(opts, "errors=remount-ro");
   if (remount_ro_start != NULL) {
     char after = *(remount_ro_start + strlen("errors=remount-ro"));
     char before = remount_ro_start == opts ? '\0' : *(remount_ro_start - 1);
     has_remount_ro = ((before == '\0' || before == ',') &&
                       (after == '\0' || after == ','));
   }
   if (strstr(opts, "errors=panic") || !has_remount_ro)
     strcat(opts, ",errors=continue");
 } else if (strcmp(fs, "xfs") == 0) {
   strcat(opts, ",nouuid");
 }
 res = mount(source, target, fs, flags, opts);
 if (res == -1) {
   err = errno;
   goto error_clear_loop;
 }
 res = open(target, O_RDONLY | O_DIRECTORY);
 if (res == -1) {
   err = errno;
   goto error_clear_loop;
 }
 if (change_dir) {
   res = chdir(target);
   if (res == -1) {
     err = errno;
   }
 }

error_clear_loop:
 if (need_loop_device) {
   ioctl(loopfd, LOOP_CLR_FD, 0);
   close(loopfd);
 }
 errno = err;
 return res;
}

#define FS_IOC_SETFLAGS _IOW('f', 2, long)
static void remove_dir(const char* dir) {
 int iter = 0;
 DIR* dp = 0;
retry:
 while (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
 }
 dp = opendir(dir);
 if (dp == NULL) {
   if (errno == EMFILE) {
     exit(1);
   }
   exit(1);
 }
 struct dirent* ep = 0;
 while ((ep = readdir(dp))) {
   if (strcmp(ep->d_name, ".") == 0 || strcmp(ep->d_name, "..") == 0)
     continue;
   char filename[FILENAME_MAX];
   snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
   while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
   }
   struct stat st;
   if (lstat(filename, &st))
     exit(1);
   if (S_ISDIR(st.st_mode)) {
     remove_dir(filename);
     continue;
   }
   int i;
   for (i = 0;; i++) {
     if (unlink(filename) == 0)
       break;
     if (errno == EPERM) {
       int fd = open(filename, O_RDONLY);
       if (fd != -1) {
         long flags = 0;
         if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
         }
         close(fd);
         continue;
       }
     }
     if (errno == EROFS) {
       break;
     }
     if (errno != EBUSY || i > 100)
       exit(1);
     if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW))
       exit(1);
   }
 }
 closedir(dp);
 for (int i = 0;; i++) {
   if (rmdir(dir) == 0)
     break;
   if (i < 100) {
     if (errno == EPERM) {
       int fd = open(dir, O_RDONLY);
       if (fd != -1) {
         long flags = 0;
         if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
         }
         close(fd);
         continue;
       }
     }
     if (errno == EROFS) {
       break;
     }
     if (errno == EBUSY) {
       if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW))
         exit(1);
       continue;
     }
     if (errno == ENOTEMPTY) {
       if (iter < 100) {
         iter++;
         goto retry;
       }
     }
   }
   exit(1);
 }
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i = 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) == pid)
     return;
   usleep(1000);
 }
 DIR* dir = opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent = readdir(dir);
     if (!ent)
       break;
     if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd = open(abort, O_WRONLY);
     if (fd == -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) != pid) {
 }
}

static void reset_loop() {
 char buf[64];
 snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
 int loopfd = open(buf, O_RDWR);
 if (loopfd != -1) {
   ioctl(loopfd, LOOP_CLR_FD, 0);
   close(loopfd);
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
 if (symlink("/dev/binderfs", "./binderfs")) {
 }
}

struct thread_t {
 int created, call;
 event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
 struct thread_t* th = (struct thread_t*)arg;
 for (;;) {
   event_wait(&th->ready);
   event_reset(&th->ready);
   execute_call(th->call);
   __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
   event_set(&th->done);
 }
 return 0;
}

static void execute_one(void) {
 int i, call, thread;
 for (call = 0; call < 9; call++) {
   for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
        thread++) {
     struct thread_t* th = &threads[thread];
     if (!th->created) {
       th->created = 1;
       event_init(&th->ready);
       event_init(&th->done);
       event_set(&th->done);
       thread_start(thr, th);
     }
     if (!event_isset(&th->done))
       continue;
     event_reset(&th->done);
     th->call = call;
     __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
     event_set(&th->ready);
     event_timedwait(&th->done, 50);
     break;
   }
 }
 for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
   sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter = 0;
 for (;; iter++) {
   char cwdbuf[32];
   sprintf(cwdbuf, "./%d", iter);
   if (mkdir(cwdbuf, 0777))
     exit(1);
   reset_loop();
   int pid = fork();
   if (pid < 0)
     exit(1);
   if (pid == 0) {
     if (chdir(cwdbuf))
       exit(1);
     setup_test();
     execute_one();
     exit(0);
   }
   int status = 0;
   uint64_t start = current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
       break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000)
       continue;
     kill_and_wait(pid, &status);
     break;
   }
   remove_dir(cwdbuf);
 }
}

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call) {
 intptr_t res = 0;
 switch (call) {
   case 0:
     NONFAILING(memcpy((void*)0x20001040, "./file2\000", 8));
     NONFAILING(syz_mount_image(/*fs=*/0, /*dir=*/0x20001040, /*flags=*/0,
                                /*opts=*/0, /*chdir=*/0, /*size=*/0,
                                /*img=*/0));
     break;
   case 1:
     NONFAILING(memcpy((void*)0x20002080, "./file0\000", 8));
     NONFAILING(syz_mount_image(/*fs=*/0, /*dir=*/0x20002080, /*flags=*/0,
                                /*opts=*/0, /*chdir=*/0, /*size=*/0,
                                /*img=*/0));
     break;
   case 2:
     NONFAILING(memcpy((void*)0x20000040, "./file0\000", 8));
     NONFAILING(memcpy((void*)0x20000000, "overlay\000", 8));
     NONFAILING(memcpy((void*)0x20000100, "workdir", 7));
     NONFAILING(*(uint8_t*)0x20000107 = 0x3d);
     NONFAILING(memcpy((void*)0x20000108, "./file0", 7));
     NONFAILING(*(uint8_t*)0x2000010f = 0x2c);
     NONFAILING(memcpy((void*)0x20000110, "lowerdir", 8));
     NONFAILING(*(uint8_t*)0x20000118 = 0x3d);
     NONFAILING(memset((void*)0x20000119, 46, 1));
     NONFAILING(*(uint8_t*)0x2000011a = 0x2c);
     NONFAILING(memcpy((void*)0x2000011b, "upperdir", 8));
     NONFAILING(*(uint8_t*)0x20000123 = 0x3d);
     NONFAILING(memcpy((void*)0x20000124, "./file2", 7));
     NONFAILING(*(uint8_t*)0x2000012b = 0x2c);
     NONFAILING(*(uint8_t*)0x2000012c = 0x2c);
     syscall(__NR_mount, /*src=*/0ul, /*dst=*/0x20000040ul,
             /*type=*/0x20000000ul, /*flags=*/0ul, /*opts=*/0x20000100ul);
     break;
   case 3:
     NONFAILING(memcpy((void*)0x20000040, "./file1\000", 8));
     res = syscall(__NR_openat, /*fd=*/0xffffff9c, /*file=*/0x20000040ul,
                   /*flags=*/0xa42ul, /*mode=*/0ul);
     if (res != -1)
       r[0] = res;
     break;
   case 4:
     NONFAILING(*(uint32_t*)0x20000000 = 0xfffffe98);
     NONFAILING(*(uint8_t*)0x20000004 = 0x21);
     NONFAILING(*(uint16_t*)0x20000005 = 0);
     syscall(__NR_write, /*fd=*/r[0], /*data=*/0x20000000ul,
             /*size=*/0x800600ul);
     break;
   case 5:
     NONFAILING(memcpy((void*)0x20000080, "./file1\000", 8));
     syscall(__NR_openat, /*fd=*/0xffffff9cul, /*file=*/0x20000080ul,
             /*flags=*/0x20200ul, /*mode=*/0ul);
     break;
   case 6:
     NONFAILING(*(uint32_t*)0x20000300 = 0x18);
     NONFAILING(*(uint8_t*)0x20000304 = 0xf);
     NONFAILING(*(uint16_t*)0x20000305 = 0);
     NONFAILING(*(uint8_t*)0x20000307 = 0);
     NONFAILING(*(uint32_t*)0x20000308 = 0);
     NONFAILING(*(uint64_t*)0x2000030c = 0);
     NONFAILING(*(uint32_t*)0x20000314 = 0);
     syscall(__NR_write, /*fd=*/r[0], /*data=*/0x20000300ul, /*size=*/0x18ul);
     break;
   case 7:
     NONFAILING(memcpy((void*)0x200000c0, "./file0\000", 8));
     res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul,
                   /*file=*/0x200000c0ul, /*flags=*/0ul, /*mode=*/0ul);
     if (res != -1)
       r[1] = res;
     break;
   case 8:
     NONFAILING(memcpy((void*)0x200000c0, "./file1\000", 8));
     syscall(__NR_fchmodat, /*dirfd=*/r[1], /*file=*/0x200000c0ul,
             /*mode=*/0xd00ul);
     break;
 }
}
int main(void) {
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 install_segv_handler();
 for (procid = 0; procid < 4; procid++) {
   if (fork() == 0) {
     use_temporary_dir();
     loop();
   }
 }
 sleep(1000000);
 return 0;
}


=* repro.txt =*
syz_mount_image$fuse(0x0, &(0x7f0000001040)='./file2\x00', 0x0, 0x0,
0x0, 0x0, 0x0)
syz_mount_image$fuse(0x0, &(0x7f0000002080)='./file0\x00', 0x0, 0x0,
0x0, 0x0, 0x0)
mount$overlay(0x0, &(0x7f0000000040)='./file0\x00', &(0x7f0000000000),
0x0, &(0x7f0000000100)={[{@workdir={'workdir', 0x3d, './file0'}},
{@lowerdir={'lowerdir', 0x3d, '.'}}, {@upperdir={'upperdir', 0x3d,
'./file2'}}], [], 0x2c})
r0 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file1\x00', 0xa42, 0x0)
write$P9_RXATTRCREATE(r0, &(0x7f0000000000)={0xfffffffffffffe98}, 0x800600)
openat$dir(0xffffff9c, &(0x7f0000000080)='./file1\x00', 0x20200, 0x0)
write$P9_RLCREATE(r0, &(0x7f0000000300)={0x18}, 0x18)
r1 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00', 0x0, 0x0)
fchmodat(r1, &(0x7f00000000c0)='./file1\x00', 0xd00)


See aslo https://gist.github.com/xrivendell7/86a9486e8e1e703c4f4453abec064fb5

I hope it helps.

Best regards.
xingwei Lee

