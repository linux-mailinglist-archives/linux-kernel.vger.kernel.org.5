Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4780A4A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573819AbjLHNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjLHNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:43:54 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A851706;
        Fri,  8 Dec 2023 05:43:59 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1d04d286bc0so15536865ad.3;
        Fri, 08 Dec 2023 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702043038; x=1702647838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4aKnVkSJ0FQgNJ9YRJpp058syeE96cbkWwXRYNtv+Fo=;
        b=WOWry/Zw3pv5tXTgQMR5PSIzNnxGnrgFWc8FC482pnLij7oz0GgdOPLrr/L8AZ8Vvu
         0XDWQ58sLSsoG6/3Ok0vMYBlwG+B1K+wAPe6UNVx8dX36+kTkfTdhXs+yeL8p28Jq96t
         gIne8RDsItG9PF3U6HMnpi5dPXeVzfaVEXG1KLCH5FNtRrFn9km2sQFxv34zE7gTFFB8
         BArcefwbCs3tNRSINatCcLv9XPvh2EOlFwzvBfetdFoLPFfdse/8UDKhlkJ1nD+yuHur
         lFgrU3fV57ex+8VPMPJ6nqDS/hDCscUva2ncEYnJoqpW4UUEioguxQqBDx6UTYifsrq5
         Fc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043038; x=1702647838;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aKnVkSJ0FQgNJ9YRJpp058syeE96cbkWwXRYNtv+Fo=;
        b=q7z3ILOIggOWkGtGL1x2F/wz2gxcj1O6UqJE0FHucKm0skFLWTWum3oCJrjkz3UOuL
         kxXBGlnVZisZElGirtrJHR8ZltpNHIP745baBTa4OmvHKUxCV9f2SqA6tOBZsG92Yq2l
         1SfNvBvZd/6vD/0k3WSMy8WiZkImBc2bjpKe+XP60++AAGoNVZ54XJjX1CX2xrMNxu0T
         LMoIMUywpXBfogTwbQ1OyncXVRcIBZzi/ry7QzviI2nl6jiOcn1lMvHHlS2k/uDjE0KA
         W+HKhDfwF4ZeIOKA5+wS0tdXNDCN9poC4NRJqU/zt6GPkxSha0cEvyGiQOeBe90rzAz7
         CGVA==
X-Gm-Message-State: AOJu0Yw7x1v1DufV2a20URog40u/QeEAu45GmRnWO+dx5acswOWldga6
        d58R+5cyuezZPPYDK6gNriHEEmIglEhC0vdGkcI=
X-Google-Smtp-Source: AGHT+IFb4qXgT26j5RH1vJKfTfGCb1cuXrlkWtAiZgRebh53lrwboW0myNTXgb7z6HuuAKg9hSkNcUa5Oo0nYGll4xA=
X-Received: by 2002:a17:90b:381:b0:286:6cc1:2cd1 with SMTP id
 ga1-20020a17090b038100b002866cc12cd1mr58152pjb.91.1702043038305; Fri, 08 Dec
 2023 05:43:58 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Fri, 8 Dec 2023 21:30:00 +0800
Message-ID: <CABOYnLy2PdP0eSs2RnEkUy--xauRZy1butnF7ne5tstW=XUuPQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in nci_close_device
To:     syzbot+4f51fcf4157a3fc6e591@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org, linma@zju.edu.cn,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I reproduce this bug with repro.c and repro.txt
Since I notice the kernel version in the dashboard link is a little
bit old, I also confirmed in the latest upstream
5e3f5b81de80c98338bcb47c233aebefee5a4801 and latest net tree, the
reproducer also trigger the crash like
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=94f93727847d4d81

the report in latest net tree, commit
5e3f5b81de80c98338bcb47c233aebefee5a4801 like
=* report =*
<TASK>
__lock_acquire+0x3f3/0x3b10 kernel/locking/lockdep.c:5085
lock_acquire kernel/locking/lockdep.c:5754 [inline]
lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
__flush_workqueue+0x14b/0x1340 kernel/workqueue.c:3140
nci_close_device+0xcb/0x380 net/nfc/nci/core.c:567
nfc_dev_down+0x19a/0x2d0 net/nfc/core.c:161
nfc_genl_dev_down+0xa1/0xe0 net/nfc/netlink.c:791
genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
__sys_sendmsg+0x117/0x1e0 net/socket.c:2667
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b

=* repro.c =*
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/capability.h>
#include <linux/falloc.h>
#include <linux/futex.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_link.h>
#include <linux/in6.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/veth.h>
#include <net/if.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/swap.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
static unsigned long long procid;
static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }
static uint64_t current_time_ms(void) {
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}
static void use_temporary_dir(void) {
char tmpdir_template[] = "./syzkaller.XXXXXX";
char* tmpdir = mkdtemp(tmpdir_template);
if (!tmpdir) exit(1);
if (chmod(tmpdir, 0777)) exit(1);
if (chdir(tmpdir)) exit(1);
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
#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len) \
*(type*)(addr) = \
htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
(((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))
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
struct nlmsg {
char* pos;
int nesting;
struct nlattr* nested[8];
char buf[4096];
};
static void netlink_init(struct nlmsg* nlmsg, int typ, int flags,
const void* data, int size) {
memset(nlmsg, 0, sizeof(*nlmsg));
struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
hdr->nlmsg_type = typ;
hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
memcpy(hdr + 1, data, size);
nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
}
static void netlink_attr(struct nlmsg* nlmsg, int typ, const void* data,
int size) {
struct nlattr* attr = (struct nlattr*)nlmsg->pos;
attr->nla_len = sizeof(*attr) + size;
attr->nla_type = typ;
if (size > 0) memcpy(attr + 1, data, size);
nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}
static int netlink_send_ext(struct nlmsg* nlmsg, int sock, uint16_t reply_type,
int* reply_len, bool dofail) {
if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting) exit(1);
struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
struct sockaddr_nl addr;
memset(&addr, 0, sizeof(addr));
addr.nl_family = AF_NETLINK;
ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
(struct sockaddr*)&addr, sizeof(addr));
if (n != (ssize_t)hdr->nlmsg_len) {
if (dofail) exit(1);
return -1;
}
n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
if (reply_len) *reply_len = 0;
if (n < 0) {
if (dofail) exit(1);
return -1;
}
if (n < (ssize_t)sizeof(struct nlmsghdr)) {
errno = EINVAL;
if (dofail) exit(1);
return -1;
}
if (hdr->nlmsg_type == NLMSG_DONE) return 0;
if (reply_len && hdr->nlmsg_type == reply_type) {
*reply_len = n;
return 0;
}
if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
errno = EINVAL;
if (dofail) exit(1);
return -1;
}
if (hdr->nlmsg_type != NLMSG_ERROR) {
errno = EINVAL;
if (dofail) exit(1);
return -1;
}
errno = -((struct nlmsgerr*)(hdr + 1))->error;
return -errno;
}
static int netlink_query_family_id(struct nlmsg* nlmsg, int sock,
const char* family_name, bool dofail) {
struct genlmsghdr genlhdr;
memset(&genlhdr, 0, sizeof(genlhdr));
genlhdr.cmd = CTRL_CMD_GETFAMILY;
netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
strnlen(family_name, GENL_NAMSIZ - 1) + 1);
int n = 0;
int err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
if (err < 0) {
return -1;
}
uint16_t id = 0;
struct nlattr* attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
NLMSG_ALIGN(sizeof(genlhdr)));
for (; (char*)attr < nlmsg->buf + n;
attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
id = *(uint16_t*)(attr + 1);
break;
}
}
if (!id) {
errno = EINVAL;
return -1;
}
recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
return id;
}
const int kInitNetNsFd = 201;
static int runcmdline(char* cmdline) {
int ret = system(cmdline);
if (ret) {
}
return ret;
}
#define MAX_FDS 30
static long syz_init_net_socket(volatile long domain, volatile long type,
volatile long proto) {
int netns = open("/proc/self/ns/net", O_RDONLY);
if (netns == -1) return netns;
if (setns(kInitNetNsFd, 0)) return -1;
int sock = syscall(__NR_socket, domain, type, proto);
int err = errno;
if (setns(netns, 0)) exit(1);
close(netns);
errno = err;
return sock;
}
static long syz_genetlink_get_family_id(volatile long name,
volatile long sock_arg) {
int fd = sock_arg;
if (fd < 0) {
fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
if (fd == -1) {
return -1;
}
}
struct nlmsg nlmsg_tmp;
int ret = netlink_query_family_id(&nlmsg_tmp, fd, (char*)name, false);
if ((int)sock_arg < 0) close(fd);
if (ret < 0) {
return -1;
}
return ret;
}
static void mount_cgroups(const char* dir, const char** controllers,
int count) {
if (mkdir(dir, 0777)) {
return;
}
char enabled[128] = {0};
int i = 0;
for (; i < count; i++) {
if (mount("none", dir, "cgroup", 0, controllers[i])) {
continue;
}
umount(dir);
strcat(enabled, ",");
strcat(enabled, controllers[i]);
}
if (enabled[0] == 0) {
if (rmdir(dir) && errno != EBUSY) exit(1);
return;
}
if (mount("none", dir, "cgroup", 0, enabled + 1)) {
if (rmdir(dir) && errno != EBUSY) exit(1);
}
if (chmod(dir, 0777)) {
}
}
static void mount_cgroups2(const char** controllers, int count) {
if (mkdir("/syzcgroup/unified", 0777)) {
return;
}
if (mount("none", "/syzcgroup/unified", "cgroup2", 0, NULL)) {
if (rmdir("/syzcgroup/unified") && errno != EBUSY) exit(1);
return;
}
if (chmod("/syzcgroup/unified", 0777)) {
}
int control = open("/syzcgroup/unified/cgroup.subtree_control", O_WRONLY);
if (control == -1) return;
int i;
for (i = 0; i < count; i++)
if (write(control, controllers[i], strlen(controllers[i])) < 0) {
}
close(control);
}
static void setup_cgroups() {
const char* unified_controllers[] = {"+cpu", "+io", "+pids"};
const char* net_controllers[] = {"net", "net_prio", "devices", "blkio",
"freezer"};
const char* cpu_controllers[] = {"cpuset", "cpuacct", "hugetlb", "rlimit",
"memory"};
if (mkdir("/syzcgroup", 0777)) {
return;
}
mount_cgroups2(unified_controllers,
sizeof(unified_controllers) / sizeof(unified_controllers[0]));
mount_cgroups("/syzcgroup/net", net_controllers,
sizeof(net_controllers) / sizeof(net_controllers[0]));
mount_cgroups("/syzcgroup/cpu", cpu_controllers,
sizeof(cpu_controllers) / sizeof(cpu_controllers[0]));
write_file("/syzcgroup/cpu/cgroup.clone_children", "1");
write_file("/syzcgroup/cpu/cpuset.memory_pressure_enabled", "1");
}
static void setup_cgroups_loop() {
int pid = getpid();
char file[128];
char cgroupdir[64];
snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/unified/syz%llu", procid);
if (mkdir(cgroupdir, 0777)) {
}
snprintf(file, sizeof(file), "%s/pids.max", cgroupdir);
write_file(file, "32");
snprintf(file, sizeof(file), "%s/cgroup.procs", cgroupdir);
write_file(file, "%d", pid);
snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/cpu/syz%llu", procid);
if (mkdir(cgroupdir, 0777)) {
}
snprintf(file, sizeof(file), "%s/cgroup.procs", cgroupdir);
write_file(file, "%d", pid);
snprintf(file, sizeof(file), "%s/memory.soft_limit_in_bytes", cgroupdir);
write_file(file, "%d", 299 << 20);
snprintf(file, sizeof(file), "%s/memory.limit_in_bytes", cgroupdir);
write_file(file, "%d", 300 << 20);
snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/net/syz%llu", procid);
if (mkdir(cgroupdir, 0777)) {
}
snprintf(file, sizeof(file), "%s/cgroup.procs", cgroupdir);
write_file(file, "%d", pid);
}
static void setup_cgroups_test() {
char cgroupdir[64];
snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/unified/syz%llu", procid);
if (symlink(cgroupdir, "./cgroup")) {
}
snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/cpu/syz%llu", procid);
if (symlink(cgroupdir, "./cgroup.cpu")) {
}
snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/net/syz%llu", procid);
if (symlink(cgroupdir, "./cgroup.net")) {
}
}
static void setup_common() {
if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
}
}
static void setup_binderfs() {
if (mkdir("/dev/binderfs", 0777)) {
}
if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
}
}
static void loop();
static void sandbox_common() {
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setsid();
int netns = open("/proc/self/ns/net", O_RDONLY);
if (netns == -1) exit(1);
if (dup2(netns, kInitNetNsFd) < 0) exit(1);
close(netns);
struct rlimit rlim;
rlim.rlim_cur = rlim.rlim_max = (200 << 20);
setrlimit(RLIMIT_AS, &rlim);
rlim.rlim_cur = rlim.rlim_max = 32 << 20;
setrlimit(RLIMIT_MEMLOCK, &rlim);
rlim.rlim_cur = rlim.rlim_max = 136 << 20;
setrlimit(RLIMIT_FSIZE, &rlim);
rlim.rlim_cur = rlim.rlim_max = 1 << 20;
setrlimit(RLIMIT_STACK, &rlim);
rlim.rlim_cur = rlim.rlim_max = 128 << 20;
setrlimit(RLIMIT_CORE, &rlim);
rlim.rlim_cur = rlim.rlim_max = 256;
setrlimit(RLIMIT_NOFILE, &rlim);
if (unshare(CLONE_NEWNS)) {
}
if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
}
if (unshare(CLONE_NEWIPC)) {
}
if (unshare(0x02000000)) {
}
if (unshare(CLONE_NEWUTS)) {
}
if (unshare(CLONE_SYSVSEM)) {
}
typedef struct {
const char* name;
const char* value;
} sysctl_t;
static const sysctl_t sysctls[] = {
{"/proc/sys/kernel/shmmax", "16777216"},
{"/proc/sys/kernel/shmall", "536870912"},
{"/proc/sys/kernel/shmmni", "1024"},
{"/proc/sys/kernel/msgmax", "8192"},
{"/proc/sys/kernel/msgmni", "1024"},
{"/proc/sys/kernel/msgmnb", "1024"},
{"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
};
unsigned i;
for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
write_file(sysctls[i].name, sysctls[i].value);
}
static int wait_for_loop(int pid) {
if (pid < 0) exit(1);
int status = 0;
while (waitpid(-1, &status, __WALL) != pid) {
}
return WEXITSTATUS(status);
}
static void drop_caps(void) {
struct __user_cap_header_struct cap_hdr = {};
struct __user_cap_data_struct cap_data[2] = {};
cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
cap_hdr.pid = getpid();
if (syscall(SYS_capget, &cap_hdr, &cap_data)) exit(1);
const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
cap_data[0].effective &= ~drop;
cap_data[0].permitted &= ~drop;
cap_data[0].inheritable &= ~drop;
if (syscall(SYS_capset, &cap_hdr, &cap_data)) exit(1);
}
static int do_sandbox_none(void) {
if (unshare(CLONE_NEWPID)) {
}
int pid = fork();
if (pid != 0) return wait_for_loop(pid);
setup_common();
sandbox_common();
drop_caps();
if (unshare(CLONE_NEWNET)) {
}
write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
setup_binderfs();
loop();
exit(1);
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
if (strcmp(ep->d_name, ".") == 0 || strcmp(ep->d_name, "..") == 0) continue;
char filename[FILENAME_MAX];
snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
}
struct stat st;
if (lstat(filename, &st)) exit(1);
if (S_ISDIR(st.st_mode)) {
remove_dir(filename);
continue;
}
int i;
for (i = 0;; i++) {
if (unlink(filename) == 0) break;
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
if (errno != EBUSY || i > 100) exit(1);
if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW)) exit(1);
}
}
closedir(dp);
for (int i = 0;; i++) {
if (rmdir(dir) == 0) break;
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
if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW)) exit(1);
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
static void setup_loop() { setup_cgroups_loop(); }
static void setup_test() {
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
setup_cgroups_test();
write_file("/proc/self/oom_score_adj", "1000");
if (symlink("/dev/binderfs", "./binderfs")) {
}
}
static void close_fds() {
for (int fd = 3; fd < MAX_FDS; fd++) close(fd);
}
#define SWAP_FILE "./swap-file"
#define SWAP_FILE_SIZE (128 * 1000 * 1000)
static void setup_swap() {
swapoff(SWAP_FILE);
unlink(SWAP_FILE);
int fd = open(SWAP_FILE, O_CREAT | O_WRONLY | O_CLOEXEC, 0600);
if (fd == -1) {
exit(1);
return;
}
fallocate(fd, FALLOC_FL_ZERO_RANGE, 0, SWAP_FILE_SIZE);
close(fd);
char cmdline[64];
sprintf(cmdline, "mkswap %s", SWAP_FILE);
if (runcmdline(cmdline)) {
exit(1);
return;
}
if (swapon(SWAP_FILE, SWAP_FLAG_PREFER) == 1) {
exit(1);
return;
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
close_fds();
}
static void execute_one(void);
#define WAIT_FLAGS __WALL
static void loop(void) {
setup_loop();
int iter = 0;
for (;; iter++) {
char cwdbuf[32];
sprintf(cwdbuf, "./%d", iter);
if (mkdir(cwdbuf, 0777)) exit(1);
int pid = fork();
if (pid < 0) exit(1);
if (pid == 0) {
if (chdir(cwdbuf)) exit(1);
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
remove_dir(cwdbuf);
}
}
uint64_t r[4] = {0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x0};
void execute_call(int call) {
intptr_t res = 0;
switch (call) {
case 0:
memcpy((void*)0x20000080, "/dev/virtual_nci\000", 17);
res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul,
/*file=*/0x20000080ul, /*flags=*/2ul, /*mode=*/0ul);
if (res != -1) r[0] = res;
break;
case 1:
res = syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0, /*arg=*/0x200000c0ul);
if (res != -1) r[1] = *(uint32_t*)0x200000c0;
break;
case 2:
res = -1;
res = syz_init_net_socket(/*domain=*/0x10, /*type=*/3, /*proto=*/0x10);
if (res != -1) r[2] = res;
break;
case 3:
memcpy((void*)0x20000100, "nfc\000", 4);
res = -1;
res = syz_genetlink_get_family_id(/*name=*/0x20000100, /*fd=*/r[2]);
if (res != -1) r[3] = res;
break;
case 4:
*(uint64_t*)0x20000140 = 0;
*(uint32_t*)0x20000148 = 0;
*(uint64_t*)0x20000150 = 0x20000180;
*(uint64_t*)0x20000180 = 0x200001c0;
*(uint32_t*)0x200001c0 = 0x1c;
*(uint16_t*)0x200001c4 = r[3];
*(uint16_t*)0x200001c6 = 1;
*(uint32_t*)0x200001c8 = 0;
*(uint32_t*)0x200001cc = 0;
*(uint8_t*)0x200001d0 = 2;
*(uint8_t*)0x200001d1 = 0;
*(uint16_t*)0x200001d2 = 0;
*(uint16_t*)0x200001d4 = 8;
*(uint16_t*)0x200001d6 = 1;
*(uint32_t*)0x200001d8 = r[1];
*(uint64_t*)0x20000188 = 0x1c;
*(uint64_t*)0x20000158 = 1;
*(uint64_t*)0x20000160 = 0;
*(uint64_t*)0x20000168 = 0;
*(uint32_t*)0x20000170 = 0;
syscall(__NR_sendmsg, /*fd=*/r[2], /*msg=*/0x20000140ul, /*f=*/0ul);
break;
case 5:
STORE_BY_BITMASK(uint8_t, , 0x20000280, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000280, 0, 4, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000280, 2, 5, 3);
*(uint8_t*)0x20000281 = 0;
*(uint8_t*)0x20000282 = 0;
*(uint8_t*)0x20000283 = 0;
*(uint8_t*)0x20000284 = 0;
*(uint8_t*)0x20000285 = 0;
syscall(__NR_write, /*fd=*/r[0], /*data=*/0x20000280ul, /*len=*/6ul);
break;
case 6:
STORE_BY_BITMASK(uint8_t, , 0x20000340, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000340, 0, 4, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000340, 2, 5, 3);
*(uint8_t*)0x20000341 = 1;
*(uint8_t*)0x20000342 = 0;
*(uint8_t*)0x20000343 = 0;
*(uint32_t*)0x20000344 = 0;
*(uint8_t*)0x20000348 = 0;
*(uint8_t*)0x20000349 = 0;
*(uint16_t*)0x2000034a = 0;
*(uint8_t*)0x2000034c = 0;
*(uint16_t*)0x2000034d = 0;
*(uint8_t*)0x2000034f = 0;
*(uint32_t*)0x20000350 = 0;
syscall(__NR_write, /*fd=*/r[0], /*data=*/0x20000340ul, /*len=*/0x14ul);
break;
case 7:
STORE_BY_BITMASK(uint8_t, , 0x20000400, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000400, 0, 4, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000400, 2, 5, 3);
*(uint8_t*)0x20000401 = 0;
*(uint8_t*)0x20000402 = 0;
*(uint8_t*)0x20000403 = 0;
syscall(__NR_write, /*fd=*/r[0], /*data=*/0x20000400ul, /*len=*/4ul);
break;
case 8:
*(uint64_t*)0x20000440 = 0;
*(uint32_t*)0x20000448 = 0;
*(uint64_t*)0x20000450 = 0x20000480;
*(uint64_t*)0x20000480 = 0x200004c0;
*(uint32_t*)0x200004c0 = 0x24;
*(uint16_t*)0x200004c4 = r[3];
*(uint16_t*)0x200004c6 = 1;
*(uint32_t*)0x200004c8 = 0x123;
*(uint32_t*)0x200004cc = 0;
*(uint8_t*)0x200004d0 = 3;
*(uint8_t*)0x200004d1 = 0;
*(uint16_t*)0x200004d2 = 0;
*(uint16_t*)0x200004d4 = 8;
*(uint16_t*)0x200004d6 = 1;
*(uint32_t*)0x200004d8 = r[1];
*(uint16_t*)0x200004dc = 8;
*(uint16_t*)0x200004de = 3;
*(uint32_t*)0x200004e0 = -1;
*(uint64_t*)0x20000488 = 0x24;
*(uint64_t*)0x20000458 = 1;
*(uint64_t*)0x20000460 = 0;
*(uint64_t*)0x20000468 = 0;
*(uint32_t*)0x20000470 = 0;
syscall(__NR_sendmsg, /*fd=*/r[2], /*msg=*/0x20000440ul, /*f=*/0ul);
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
setup_cgroups();
setup_swap();
for (procid = 0; procid < 4; procid++) {
if (fork() == 0) {
use_temporary_dir();
do_sandbox_none();
}
}
sleep(1000000);
return 0;
}


=* repro.txt =*
r0 = openat$nci(0xffffffffffffff9c, &(0x7f0000000080), 0x2,
0x0)ioctl$IOCTL_GET_NCIDEV_IDX(r0, 0x0, &(0x7f00000000c0)=<r1=>0x0)r2
= syz_init_net_socket$nl_generic(0x10, 0x3, 0x10)r3 =
syz_genetlink_get_family_id$nfc(&(0x7f0000000100),
r2)sendmsg$NFC_CMD_DEV_UP(r2, &(0x7f0000000140)={0x0, 0x0,
&(0x7f0000000180)={&(0x7f00000001c0)={0x1c, r3, 0x1, 0x0, 0x0, {},
[@NFC_ATTR_DEVICE_INDEX={0x8, 0x1, r1}]}, 0x1c}}, 0x0)write$nci(r0,
&(0x7f0000000280)=@NCI_OP_CORE_RESET_RSP, 0x6)write$nci(r0,
&(0x7f0000000340)=@NCI_OP_CORE_INIT_RSP, 0x14)write$nci(r0,
&(0x7f0000000400)=@NCI_OP_RF_DISCOVER_MAP_RSP,
0x4)sendmsg$NFC_CMD_START_POLL(r2, &(0x7f0000000440)={0x0, 0x0,
&(0x7f0000000480)={&(0x7f00000004c0)={0x24, r3, 0x1, 0x123, 0x0,
{0x3}, [@NFC_ATTR_DEVICE_INDEX={0x8, 0x1, r1},
@NFC_ATTR_PROTOCOLS={0x8, 0x3, 0xffffffff}]}, 0x24}}, 0x0)
