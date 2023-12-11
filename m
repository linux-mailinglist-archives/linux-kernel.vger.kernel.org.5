Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2C80C69D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjLKKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjLKKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:31:50 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFCB91;
        Mon, 11 Dec 2023 02:31:54 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so2208981a12.3;
        Mon, 11 Dec 2023 02:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702290714; x=1702895514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+6fsL71+uqPJMFUKBQnGfk6sHtlVXXB4hFF4cRC+os=;
        b=QevlyOPqAsu9yuuqT7KMiVUdvKI+4d7mI0Art9SOfzJvP42CBt/V7erm7TomnInFM1
         QzsAhH9lTKHxih38rsgx4vS0oBW+TRwy5FViIIQRf+CZnWKa+UOcKAeKPgaymp0dToor
         qAzT61QgDu5qcaw25lEwKqrFvMDT+spiApNgB6saghKJR1d/iwPUXtFRIPiQd6wt2tAH
         L6AVtkz2pkKifU4p8CB0GMg7+gcGRhugn2oAGKxJGorbxUvHgntdBcpLrhydKZ9Q5ua3
         hXOWauaKXOXfPpztJgOomDAxzgzliCXG+5ar0nRjLZLqsSKfe2quTRicoiVBxkbFL7W6
         HI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290714; x=1702895514;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+6fsL71+uqPJMFUKBQnGfk6sHtlVXXB4hFF4cRC+os=;
        b=CiZqX/OmLB9EDT6d34XOgCQPl0+KpTXiJDD8IFRxYRrQMl81v7UAluxNr+6pB9Nrwx
         XYrXYOIlAGejSXTihU4BA8I8CFMah7PMSfXPCo7agcTBuMLtqkIVreRpscCdj+QpUfM9
         ZmXHB2E28H8VYkHSdsF5/0OdJFbLY5VvIk+P4zGL6rTWa1qM+irYVg4uIWhtyWpU7bIp
         zyK5VfB5FnAgvvSK5l02kMK2SkVyPfBFuMuDTtE44p2TkPXAN6yQdo1RmJc9BU+99aoI
         MEirTj1pgfQAPHKtwUmOzdqIq93zBrUdOpEaW+KbOFsCsLQDrLhwpy8WyLREoflKlfSq
         ncBQ==
X-Gm-Message-State: AOJu0Yw5DdSzinfEXCKeMCyxr+X+uTauIkNuhw1rNvhZW+RH8YeGqRES
        QSqmHLHjXzouki6Psko+OY6AY0pfGDeKbudwfEs=
X-Google-Smtp-Source: AGHT+IGZNfoMdg7yuyb1iBqRQtZgj9jNPyOGUMp9O5m3KkuOKSy5kM5KKzQE9EflbJJRbAv6s1Iloi5G33IVKvatAFo=
X-Received: by 2002:a05:6a20:8f1a:b0:190:de0:ea78 with SMTP id
 b26-20020a056a208f1a00b001900de0ea78mr1876270pzk.95.1702290714102; Mon, 11
 Dec 2023 02:31:54 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Mon, 11 Dec 2023 18:31:41 +0800
Message-ID: <CABOYnLxrKDpgoBTEPyu0wVe1aiB8LQrMqBRuXtggxippB5NDAw@mail.gmail.com>
Subject: general protection fault in dccp_write_xmit
To:     davem@davemloft.net
Cc:     Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
        pabeni@redhat.com, kuniyu@amazon.com, leitao@debian.org,
        willemb@google.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello I found a bug in net/dccp in the lastest upstream linux 6.7.rc5
and lastest net tree
titled general protection fault in dccp_write_xmit

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei Lee <xrivendell7@gmail.com>

kernel: net.git c3e041425af9068e3ec9d90c536de2a2ba97ba2b
Kernel config: https://github.com/google/syzkaller/commits/17e6d52686f8a56935991f1b066798279f76504a

in the lastest net tree commit, the crash like:

CPU: 1 PID: 8151 Comm: 096 Not tainted 6.7.0-rc4-00151-gc3e041425af9 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ccid_hc_tx_send_packet home/dubbo/net/net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x66/0x1d0 home/dubbo/net/net/dccp/output.c:356
Code: 00 48 85 c0 49 89 c4 0f 84 03 01 00 00 e8 12 1d 0d f8 41 80 3e
00 0f 85 45 01 00 00 48 8b 9d f0 08 00 00 48 89 d8 48 c1 e8 03 <42> 80
3c 28 00 0f 85 1f 01 00 00 48 8b 1b 48 8d bb b0 00 00 00 48
RSP: 0018:ffffc90010fcf878 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88814ea6a540 RSI: ffffffff897ab2ce RDI: ffff8881555b8b40
RBP: ffff8881555b8b40 R08: 0000000000000001 R09: fffffbfff23317ec
R10: ffffffff9198bf67 R11: 0000000000000001 R12: ffff88814c691700
R13: dffffc0000000000 R14: ffffed102aab7286 R15: ffff8881555b9430
FS:  00007f74af0706c0(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 0000000154391000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dccp_sendmsg+0x968/0xcc0 home/dubbo/net/net/dccp/proto.c:801
 inet_sendmsg+0x9d/0xe0 home/dubbo/net/net/ipv4/af_inet.c:847
 sock_sendmsg_nosec home/dubbo/net/net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 home/dubbo/net/net/socket.c:745
 ____sys_sendmsg+0x2b0/0x880 home/dubbo/net/net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 home/dubbo/net/net/socket.c:2638
 __sys_sendmmsg+0x1a1/0x450 home/dubbo/net/net/socket.c:2724
 __do_sys_sendmmsg home/dubbo/net/net/socket.c:2753 [inline]
 __se_sys_sendmmsg home/dubbo/net/net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 home/dubbo/net/net/socket.c:2750
 do_syscall_x64 home/dubbo/net/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x3f/0x110 home/dubbo/net/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x4368e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74af0701e8 EFLAGS: 00000213 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f74af0706c0 RCX: 00000000004368e9
RDX: 0000000000000001 RSI: 0000000020000200 RDI: 0000000000000006
RBP: 00007f74af070220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000048000 R11: 0000000000000213 R12: ffffffffffffffb0
R13: 0000000000000000 R14: 00007ffecb287a30 R15: 00007ffecb287b18
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ccid_hc_tx_send_packet home/dubbo/net/net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x66/0x1d0 home/dubbo/net/net/dccp/output.c:356
Code: 00 48 85 c0 49 89 c4 0f 84 03 01 00 00 e8 12 1d 0d f8 41 80 3e
00 0f 85 45 01 00 00 48 8b 9d f0 08 00 00 48 89 d8 48 c1 e8 03 <42> 80
3c 28 00 0f 85 1f 01 00 00 48 8b 1b 48 8d bb b0 00 00 00 48
RSP: 0018:ffffc90010fcf878 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88814ea6a540 RSI: ffffffff897ab2ce RDI: ffff8881555b8b40
RBP: ffff8881555b8b40 R08: 0000000000000001 R09: fffffbfff23317ec
R10: ffffffff9198bf67 R11: 0000000000000001 R12: ffff88814c691700
R13: dffffc0000000000 R14: ffffed102aab7286 R15: ffff8881555b9430
FS:  00007f74af0706c0(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 0000000154391000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
Rebooting in 86400 seconds..
----------------
Code disassembly (best guess):
   0: 00 48 85              add    %cl,-0x7b(%rax)
   3: c0 49 89 c4           rorb   $0xc4,-0x77(%rcx)
   7: 0f 84 03 01 00 00     je     0x110
   d: e8 12 1d 0d f8        call   0xf80d1d24
  12: 41 80 3e 00           cmpb   $0x0,(%r14)
  16: 0f 85 45 01 00 00     jne    0x161
  1c: 48 8b 9d f0 08 00 00  mov    0x8f0(%rbp),%rbx
  23: 48 89 d8              mov    %rbx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 28 00        cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f: 0f 85 1f 01 00 00     jne    0x154
  35: 48 8b 1b              mov    (%rbx),%rbx
  38: 48 8d bb b0 00 00 00  lea    0xb0(%rbx),%rdi
  3f: 48                    rex.W



=* repro.c =*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/futex.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
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

static void event_init(event_t* ev) { ev->state = 0; }

static void event_reset(event_t* ev) { ev->state = 0; }

static void event_set(event_t* ev) {
  if (ev->state) exit(1);
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
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE)) return 1;
    now = current_time_ms();
    if (now - start > timeout) return 0;
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
  if (fd == -1) return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static void kill_and_wait(int pid, int* status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid) return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent) break;
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

static void setup_test() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
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
  for (call = 0; call < 10; call++) {
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
      if (!event_isset(&th->done)) continue;
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
    int pid = fork();
    if (pid < 0) exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000) continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[5] = {0xffffffffffffffff, 0xffffffffffffffff, 0x0,
                 0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call) {
  intptr_t res = 0;
  switch (call) {
    case 0:
      res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/0x803ul,
                    /*proto=*/0);
      if (res != -1) r[0] = res;
      break;
    case 1:
      res = syscall(__NR_socket, /*domain=*/0xaul, /*type=*/1ul, /*proto=*/0);
      if (res != -1) r[1] = res;
      break;
    case 2:
      memcpy((void*)0x200001c0,
             "wg1\000\000\000\000\000\000\000\000\000\000\000\000\000", 16);
      res = syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0x8933,
                    /*arg=*/0x200001c0ul);
      if (res != -1) r[2] = *(uint32_t*)0x200001d0;
      break;
    case 3:
      *(uint64_t*)0x20000340 = 0;
      *(uint32_t*)0x20000348 = 0;
      *(uint64_t*)0x20000350 = 0x20002840;
      *(uint64_t*)0x20002840 = 0x20000080;
      *(uint32_t*)0x20000080 = 0x2c;
      *(uint16_t*)0x20000084 = 0x14;
      *(uint16_t*)0x20000086 = 1;
      *(uint32_t*)0x20000088 = 0;
      *(uint32_t*)0x2000008c = 0;
      *(uint8_t*)0x20000090 = 0xa;
      *(uint8_t*)0x20000091 = 0;
      *(uint8_t*)0x20000092 = 0;
      *(uint8_t*)0x20000093 = 0;
      *(uint32_t*)0x20000094 = r[2];
      *(uint16_t*)0x20000098 = 0x14;
      *(uint16_t*)0x2000009a = 2;
      *(uint8_t*)0x2000009c = 0xfe;
      *(uint8_t*)0x2000009d = 0x80;
      memset((void*)0x2000009e, 0, 13);
      *(uint8_t*)0x200000ab = 0xbb;
      *(uint64_t*)0x20002848 = 0x2c;
      *(uint64_t*)0x20000358 = 1;
      *(uint64_t*)0x20000360 = 0;
      *(uint64_t*)0x20000368 = 0;
      *(uint32_t*)0x20000370 = 0;
      syscall(__NR_sendmsg, /*fd=*/r[0], /*msg=*/0x20000340ul, /*f=*/0ul);
      break;
    case 4:
      res = syscall(__NR_socket, /*domain=*/0xaul, /*type=*/6ul, /*proto=*/0);
      if (res != -1) r[3] = res;
      break;
    case 5:
      *(uint16_t*)0x20000000 = 0xa;
      *(uint16_t*)0x20000002 = htobe16(0);
      *(uint32_t*)0x20000004 = htobe32(0);
      *(uint64_t*)0x20000008 = htobe64(0);
      *(uint64_t*)0x20000010 = htobe64(0xa0211fffe000000);
      *(uint32_t*)0x20000018 = 0;
      syscall(__NR_connect, /*fd=*/r[3], /*addr=*/0x20000000ul,
              /*addrlen=*/0x1cul);
      break;
    case 6:
      res = syscall(__NR_dup, /*oldfd=*/r[3]);
      if (res != -1) r[4] = res;
      break;
    case 7:
      *(uint64_t*)0x20000200 = 0;
      *(uint32_t*)0x20000208 = 0;
      *(uint64_t*)0x20000210 = 0;
      *(uint64_t*)0x20000218 = 0;
      *(uint64_t*)0x20000220 = 0;
      *(uint64_t*)0x20000228 = 0;
      *(uint32_t*)0x20000230 = 0;
      *(uint32_t*)0x20000238 = 0;
      syscall(__NR_sendmmsg, /*fd=*/r[4], /*mmsg=*/0x20000200ul, /*vlen=*/1ul,
              /*f=*/0x48000ul);
      break;
    case 8:
      syscall(__NR_shutdown, /*fd=*/r[3], /*how=*/0ul);
      break;
    case 9:
      *(uint16_t*)0x20000000 = 0xa;
      *(uint16_t*)0x20000002 = htobe16(0);
      *(uint32_t*)0x20000004 = htobe32(0);
      *(uint64_t*)0x20000008 = htobe64(0);
      *(uint64_t*)0x20000010 = htobe64(0xa0211fffe000000);
      *(uint32_t*)0x20000018 = 0;
      syscall(__NR_connect, /*fd=*/r[3], /*addr=*/0x20000000ul,
              /*addrlen=*/0x1cul);
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
  loop();
  return 0;
}



=* repro.txt =*

r0 = socket(0x10, 0x803, 0x0)
r1 = socket$inet6(0xa, 0x1, 0x0)
ioctl$ifreq_SIOCGIFINDEX_wireguard(r1, 0x8933,
&(0x7f00000001c0)={'wg1\x00', <r2=>0x0})
sendmsg$nl_route(r0, &(0x7f0000000340)={0x0, 0x0,
&(0x7f0000002840)={&(0x7f0000000080)=@ipv6_newaddr={0x2c, 0x14, 0x1,
0x0, 0x0, {0xa, 0x0, 0x0, 0x0, r2}, [@IFA_LOCAL={0x14, 0x2,
@remote}]}, 0x2c}}, 0x0)
r3 = socket$inet6(0xa, 0x6, 0x0)
connect$inet6(r3, &(0x7f0000000000)={0xa, 0x0, 0x0, @loopback={0x0,
0xa0211fffe000000}}, 0x1c)
r4 = dup(r3)
sendmmsg$inet6(r4, &(0x7f0000000200)=[{{0x0, 0x0, 0x0}}], 0x1, 0x48000)
shutdown(r3, 0x0)
connect$inet6(r3, &(0x7f0000000000)={0xa, 0x0, 0x0, @loopback={0x0,
0xa0211fffe000000}}, 0x1c)


Please see also
https://gist.github.com/xrivendell7/93aebd97f6d43b735e45a66e8650c2ad
