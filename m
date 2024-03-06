Return-Path: <linux-kernel+bounces-93696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8787339F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD0B29E18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E85F56B;
	Wed,  6 Mar 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGICokWI"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9F1BDEB;
	Wed,  6 Mar 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719256; cv=none; b=FwhpVGz3fznaCKGNrfJHwFlN5a30koGRfrjL+73+GS5bJU11Aib3yy7aAiOAlMwUG/u8yTvbKdPdwnm4DrSnvuePNhDnlkHl27n7PiMiqCfwQ+W/0StKZr7kquuwNfFIsuw2RoKJ9q18loyVoZbyo9gzzZVtQ0PoB2dH5Ojg9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719256; c=relaxed/simple;
	bh=eyXo6XBvGiED4Nm10bH6a3lfHZSv6CCFhX8Q0vAA3zw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TcNGXFNDuIkw7UbN2U36+orFRK2ZmBYPMm2BL1Zle412Y5tjt4YCaTv96pP1pTztYhYOC17/C34mK9XCV5SVQ11t5lpLZ3GQjG3/X2YgpugJizYv4cMpCdA0vqM2n4SbxpEyqwA4zQmS3VOVlOnOSjKAazYQEfwIDy5SKuMVGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGICokWI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so521463b3a.1;
        Wed, 06 Mar 2024 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709719253; x=1710324053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P6XuHL2icsOlmJQsQovmQEt+M/uIRez0/mhEdqStQbA=;
        b=QGICokWIlFXHmh3cC+VE/Z2w9CdmzcDb2U1MFzG3Rs7RS35fTMG1RfZH+JEh6ZlWZk
         yGUDaYVHAL8b4rfJGT0hBkxwj4aIdiHE+3gz8JFWiZSc6xwSoh8lNltTuhZ8ycQlyr9Q
         n3hh6eYG5TtB9YWDfArzS8IMqhxnyWVxdhVOiUSJ43zdtHxiGwLiG3zEXjJwH/b6rwPk
         4xL/5unf7PlK1C5sbawQFqTg+ZHL2kcJM5CcTqDlvdKR6aiDPMkystFqAw+NWPgAelzG
         XyYmEKRI5c9pGUGR/W0JMmvSIfqvXXjgdYY5tkbtAHTZT51a0kOQSiwrhHYur+qSPFII
         cWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709719253; x=1710324053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6XuHL2icsOlmJQsQovmQEt+M/uIRez0/mhEdqStQbA=;
        b=eEJc93XocLqKOb3LojfJb9UDJHoZaYPOlWhJyEcHM4TcO1HSZoQ1ACleuWaFQyxZCQ
         GFmy1TTcLHq/nUxFgqz9oLFdLBySdroqkVAXAVoeT4ePeZCWpW9JV/+zW32k8jcAzHSp
         O+TIjLnPR4PIf4Ij4/NKetYxnBqvzBMY0kKFGRDQ8uGWk7Ofbibkr9zm36jO6pwgoaQq
         TFLkBBVPP/iJ0VPosU1L+Yk6umCE+StvdVk4tgbxIVQrhsvbCAJrSSEuG4sRMy/vkfe1
         iAiy6WKoHNSneX4M/TLJSwF8cvb8RvYE9dd/ITOBnh1gzb6mkNloekEknk86sSEXGZzr
         ZvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsUNAymxGrRfA7518QDxuOrT+zpvPPz1I6lUW/Z34WXVF1nNKcMpeHTrO7GsHPfQD2JeYkExTd/bhlK9ngJFJrmNc8AatJYaJyzxQvfH6P5kV9Rdnf6NXY73HElnNIOlwJ3/Zg/ZJG3JdroAleICnshlvZQOv6HKdHQuDoGi8CNA==
X-Gm-Message-State: AOJu0Yx79KeAlY5pWiXXE0+QlimLh+G/p4XbuAVzfORnhwSaRgpbh9qj
	aaGLrXMAvtZFzcws70w3MdhOb/Gyn/zYuPEnxhdeCy4dotnw/RBLTA3JO/XAEB9n8bd47dHqkVC
	bqKrX1TMIuM0TArrXXe70MkBoleI=
X-Google-Smtp-Source: AGHT+IGc6H5fXttUgcQWhh133ZM7zWu/ji9TrAUbSLvnPrgxM1UMea3cazqX4RTKlkxsXi0kBcuBqF6KbNnbTYmFoXc=
X-Received: by 2002:a05:6a00:2d9f:b0:6e6:2b5a:60ac with SMTP id
 fb31-20020a056a002d9f00b006e62b5a60acmr6885666pfb.2.1709719251952; Wed, 06
 Mar 2024 02:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Wed, 6 Mar 2024 18:00:40 +0800
Message-ID: <CABOYnLwtfAxS7WoMw-1_uxVe3EYajXRuzZfwaQEk0+7m6-B+ug@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in ip_finish_output
To: pabeni@redhat.com
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, ralf@linux-mips.org, syzkaller-bugs@googlegroups.com, 
	samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I found a new bug titled "KASAN: slab-use-after-free Read in
ip_finish_output=E2=80=9D or =E2=80=9CKASAN: slab-use-after-free in sk_to_f=
ull_sk" and
confirmed it in the latest net and net-next branch. After my simple
analysis, it may be related to the net/rose or AF_PACKET/PF_PACKET
socket.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
kernel: net-next e3350ba4a5b7573d4e14ee1dff8c414646435a04(lastest)
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D4a=
65fa9f077ead01
with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.4=
0

/root@syzkaller:~# ./535
[  168.288592][    C2]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  168.290954][    C2] BUG: KASAN: slab-use-after-free in
ip_finish_output+0x8d/0x330
[  168.293040][    C2] Read of size 1 at addr ffff8880349c4012 by task
swapper/2/0
[  168.295066][    C2]
[  168.296007][    C2] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
6.8.0-rc6-02015-ge3350ba4a5b7 #13
[  168.298646][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/01/2014
[  168.301143][    C2] Call Trace:
[  168.301993][    C2]  <IRQ>
[  168.302726][    C2]  dump_stack_lvl+0xee/0x1e0
[  168.303918][    C2]  print_report+0xc4/0x620
[  168.305260][    C2]  ? __virt_addr_valid+0x67/0x5c0
[  168.306598][    C2]  ? __phys_addr+0xd3/0x150
[  168.308122][    C2]  kasan_report+0xda/0x110
[  168.309283][    C2]  ? ip_finish_output+0x8d/0x330
[  168.310631][    C2]  ? ip_finish_output+0x8d/0x330
[  168.311918][    C2]  ip_finish_output+0x8d/0x330
[  168.313060][    C2]  ip_output+0x144/0x2b0
[  168.313944][    C2]  ip_local_out+0xb8/0x1b0
[  168.314865][    C2]  ipvlan_process_v4_outbound+0x3a0/0x500
[  168.316058][    C2]  ? ipvlan_route_v6_outbound+0x4b0/0x4b0
[  168.317261][    C2]  ? ipvlan_get_L3_hdr+0x91/0xda0
[  168.318312][    C2]  ipvlan_queue_xmit+0xdb3/0x11c0
[  168.319360][    C2]  ? print_usage_bug.part.0+0x550/0x550
[  168.320507][    C2]  ? ipvlan_handle_mode_l3+0x150/0x150
[  168.321671][    C2]  ? validate_xmit_xfrm+0x4c0/0x1320
[  168.322766][    C2]  ? netif_skb_features+0x3ca/0xce0
[  168.323848][    C2]  ipvlan_start_xmit+0x4e/0x160
[  168.324860][    C2]  dev_hard_start_xmit+0x141/0x720
[  168.325923][    C2]  sch_direct_xmit+0x1bd/0xc70
[  168.327068][    C2]  ? ktime_get+0x2c3/0x4c0
[  168.328137][    C2]  ? qdisc_dequeue_head+0x290/0x370
[  168.329317][    C2]  ? dev_watchdog+0x940/0x940
[  168.330387][    C2]  ? tbf_dequeue+0x980/0xdc0
[  168.331454][    C2]  __qdisc_run+0x577/0x1ad0
[  168.332384][    C2]  net_tx_action+0x765/0xd10
[  168.333548][    C2]  __do_softirq+0x21a/0x8de
[  168.334486][    C2]  ? __lock_text_end+0x3/0x3
[  168.335434][    C2]  irq_exit_rcu+0xb7/0x120
[  168.336352][    C2]  sysvec_apic_timer_interrupt+0x95/0xb0
[  168.337665][    C2]  </IRQ>
[  168.338266][    C2]  <TASK>


=3D* repro.c =3D*
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
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
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/capability.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <linux/if_tun.h>
#include <linux/in6.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/tcp.h>
#include <linux/veth.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms) {
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] =3D 0;
  int len =3D strlen(buf);
  int fd =3D open(file, O_WRONLY | O_CLOEXEC);
  if (fd =3D=3D -1)
    return false;
  if (write(fd, buf, len) !=3D len) {
    int err =3D errno;
    close(fd);
    errno =3D err;
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

static void netlink_init(struct nlmsg* nlmsg,
                         int typ,
                         int flags,
                         const void* data,
                         int size) {
  memset(nlmsg, 0, sizeof(*nlmsg));
  struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
  hdr->nlmsg_type =3D typ;
  hdr->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | flags;
  memcpy(hdr + 1, data, size);
  nlmsg->pos =3D (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg,
                         int typ,
                         const void* data,
                         int size) {
  struct nlattr* attr =3D (struct nlattr*)nlmsg->pos;
  attr->nla_len =3D sizeof(*attr) + size;
  attr->nla_type =3D typ;
  if (size > 0)
    memcpy(attr + 1, data, size);
  nlmsg->pos +=3D NLMSG_ALIGN(attr->nla_len);
}

static void netlink_nest(struct nlmsg* nlmsg, int typ) {
  struct nlattr* attr =3D (struct nlattr*)nlmsg->pos;
  attr->nla_type =3D typ;
  nlmsg->pos +=3D sizeof(*attr);
  nlmsg->nested[nlmsg->nesting++] =3D attr;
}

static void netlink_done(struct nlmsg* nlmsg) {
  struct nlattr* attr =3D nlmsg->nested[--nlmsg->nesting];
  attr->nla_len =3D nlmsg->pos - (char*)attr;
}

static int netlink_send_ext(struct nlmsg* nlmsg,
                            int sock,
                            uint16_t reply_type,
                            int* reply_len,
                            bool dofail) {
  if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
    exit(1);
  struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
  hdr->nlmsg_len =3D nlmsg->pos - nlmsg->buf;
  struct sockaddr_nl addr;
  memset(&addr, 0, sizeof(addr));
  addr.nl_family =3D AF_NETLINK;
  ssize_t n =3D sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                     (struct sockaddr*)&addr, sizeof(addr));
  if (n !=3D (ssize_t)hdr->nlmsg_len) {
    if (dofail)
      exit(1);
    return -1;
  }
  n =3D recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
  if (reply_len)
    *reply_len =3D 0;
  if (n < 0) {
    if (dofail)
      exit(1);
    return -1;
  }
  if (n < (ssize_t)sizeof(struct nlmsghdr)) {
    errno =3D EINVAL;
    if (dofail)
      exit(1);
    return -1;
  }
  if (hdr->nlmsg_type =3D=3D NLMSG_DONE)
    return 0;
  if (reply_len && hdr->nlmsg_type =3D=3D reply_type) {
    *reply_len =3D n;
    return 0;
  }
  if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
    errno =3D EINVAL;
    if (dofail)
      exit(1);
    return -1;
  }
  if (hdr->nlmsg_type !=3D NLMSG_ERROR) {
    errno =3D EINVAL;
    if (dofail)
      exit(1);
    return -1;
  }
  errno =3D -((struct nlmsgerr*)(hdr + 1))->error;
  return -errno;
}

static int netlink_send(struct nlmsg* nlmsg, int sock) {
  return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}

static int netlink_query_family_id(struct nlmsg* nlmsg,
                                   int sock,
                                   const char* family_name,
                                   bool dofail) {
  struct genlmsghdr genlhdr;
  memset(&genlhdr, 0, sizeof(genlhdr));
  genlhdr.cmd =3D CTRL_CMD_GETFAMILY;
  netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
               strnlen(family_name, GENL_NAMSIZ - 1) + 1);
  int n =3D 0;
  int err =3D netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
  if (err < 0) {
    return -1;
  }
  uint16_t id =3D 0;
  struct nlattr* attr =3D (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
                                         NLMSG_ALIGN(sizeof(genlhdr)));
  for (; (char*)attr < nlmsg->buf + n;
       attr =3D (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len)))=
 {
    if (attr->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
      id =3D *(uint16_t*)(attr + 1);
      break;
    }
  }
  if (!id) {
    errno =3D EINVAL;
    return -1;
  }
  recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
  return id;
}

static int netlink_next_msg(struct nlmsg* nlmsg,
                            unsigned int offset,
                            unsigned int total_len) {
  struct nlmsghdr* hdr =3D (struct nlmsghdr*)(nlmsg->buf + offset);
  if (offset =3D=3D total_len || offset + hdr->nlmsg_len > total_len)
    return -1;
  return hdr->nlmsg_len;
}

static void netlink_add_device_impl(struct nlmsg* nlmsg,
                                    const char* type,
                                    const char* name,
                                    bool up) {
  struct ifinfomsg hdr;
  memset(&hdr, 0, sizeof(hdr));
  if (up)
    hdr.ifi_flags =3D hdr.ifi_change =3D IFF_UP;
  netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr,
               sizeof(hdr));
  if (name)
    netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
  netlink_nest(nlmsg, IFLA_LINKINFO);
  netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
}

static void netlink_add_device(struct nlmsg* nlmsg,
                               int sock,
                               const char* type,
                               const char* name) {
  netlink_add_device_impl(nlmsg, type, name, false);
  netlink_done(nlmsg);
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_veth(struct nlmsg* nlmsg,
                             int sock,
                             const char* name,
                             const char* peer) {
  netlink_add_device_impl(nlmsg, "veth", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_nest(nlmsg, VETH_INFO_PEER);
  nlmsg->pos +=3D sizeof(struct ifinfomsg);
  netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_xfrm(struct nlmsg* nlmsg, int sock, const char* nam=
e) {
  netlink_add_device_impl(nlmsg, "xfrm", name, true);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  int if_id =3D 1;
  netlink_attr(nlmsg, 2, &if_id, sizeof(if_id));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_hsr(struct nlmsg* nlmsg,
                            int sock,
                            const char* name,
                            const char* slave1,
                            const char* slave2) {
  netlink_add_device_impl(nlmsg, "hsr", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  int ifindex1 =3D if_nametoindex(slave1);
  netlink_attr(nlmsg, IFLA_HSR_SLAVE1, &ifindex1, sizeof(ifindex1));
  int ifindex2 =3D if_nametoindex(slave2);
  netlink_attr(nlmsg, IFLA_HSR_SLAVE2, &ifindex2, sizeof(ifindex2));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_linked(struct nlmsg* nlmsg,
                               int sock,
                               const char* type,
                               const char* name,
                               const char* link) {
  netlink_add_device_impl(nlmsg, type, name, false);
  netlink_done(nlmsg);
  int ifindex =3D if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_vlan(struct nlmsg* nlmsg,
                             int sock,
                             const char* name,
                             const char* link,
                             uint16_t id,
                             uint16_t proto) {
  netlink_add_device_impl(nlmsg, "vlan", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_attr(nlmsg, IFLA_VLAN_ID, &id, sizeof(id));
  netlink_attr(nlmsg, IFLA_VLAN_PROTOCOL, &proto, sizeof(proto));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int ifindex =3D if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_macvlan(struct nlmsg* nlmsg,
                                int sock,
                                const char* name,
                                const char* link) {
  netlink_add_device_impl(nlmsg, "macvlan", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  uint32_t mode =3D MACVLAN_MODE_BRIDGE;
  netlink_attr(nlmsg, IFLA_MACVLAN_MODE, &mode, sizeof(mode));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int ifindex =3D if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_geneve(struct nlmsg* nlmsg,
                               int sock,
                               const char* name,
                               uint32_t vni,
                               struct in_addr* addr4,
                               struct in6_addr* addr6) {
  netlink_add_device_impl(nlmsg, "geneve", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_attr(nlmsg, IFLA_GENEVE_ID, &vni, sizeof(vni));
  if (addr4)
    netlink_attr(nlmsg, IFLA_GENEVE_REMOTE, addr4, sizeof(*addr4));
  if (addr6)
    netlink_attr(nlmsg, IFLA_GENEVE_REMOTE6, addr6, sizeof(*addr6));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

#define IFLA_IPVLAN_FLAGS 2
#define IPVLAN_MODE_L3S 2
#undef IPVLAN_F_VEPA
#define IPVLAN_F_VEPA 2

static void netlink_add_ipvlan(struct nlmsg* nlmsg,
                               int sock,
                               const char* name,
                               const char* link,
                               uint16_t mode,
                               uint16_t flags) {
  netlink_add_device_impl(nlmsg, "ipvlan", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_attr(nlmsg, IFLA_IPVLAN_MODE, &mode, sizeof(mode));
  netlink_attr(nlmsg, IFLA_IPVLAN_FLAGS, &flags, sizeof(flags));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int ifindex =3D if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_device_change(struct nlmsg* nlmsg,
                                  int sock,
                                  const char* name,
                                  bool up,
                                  const char* master,
                                  const void* mac,
                                  int macsize,
                                  const char* new_name) {
  struct ifinfomsg hdr;
  memset(&hdr, 0, sizeof(hdr));
  if (up)
    hdr.ifi_flags =3D hdr.ifi_change =3D IFF_UP;
  hdr.ifi_index =3D if_nametoindex(name);
  netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
  if (new_name)
    netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
  if (master) {
    int ifindex =3D if_nametoindex(master);
    netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
  }
  if (macsize)
    netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
  int err =3D netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static int netlink_add_addr(struct nlmsg* nlmsg,
                            int sock,
                            const char* dev,
                            const void* addr,
                            int addrsize) {
  struct ifaddrmsg hdr;
  memset(&hdr, 0, sizeof(hdr));
  hdr.ifa_family =3D addrsize =3D=3D 4 ? AF_INET : AF_INET6;
  hdr.ifa_prefixlen =3D addrsize =3D=3D 4 ? 24 : 120;
  hdr.ifa_scope =3D RT_SCOPE_UNIVERSE;
  hdr.ifa_index =3D if_nametoindex(dev);
  netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
               sizeof(hdr));
  netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
  netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
  return netlink_send(nlmsg, sock);
}

static void netlink_add_addr4(struct nlmsg* nlmsg,
                              int sock,
                              const char* dev,
                              const char* addr) {
  struct in_addr in_addr;
  inet_pton(AF_INET, addr, &in_addr);
  int err =3D netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr))=
;
  if (err < 0) {
  }
}

static void netlink_add_addr6(struct nlmsg* nlmsg,
                              int sock,
                              const char* dev,
                              const char* addr) {
  struct in6_addr in6_addr;
  inet_pton(AF_INET6, addr, &in6_addr);
  int err =3D netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr=
));
  if (err < 0) {
  }
}

static struct nlmsg nlmsg;

#define DEVLINK_FAMILY_NAME "devlink"

#define DEVLINK_CMD_PORT_GET 5
#define DEVLINK_ATTR_BUS_NAME 1
#define DEVLINK_ATTR_DEV_NAME 2
#define DEVLINK_ATTR_NETDEV_NAME 7

static struct nlmsg nlmsg2;

static void initialize_devlink_ports(const char* bus_name,
                                     const char* dev_name,
                                     const char* netdev_prefix) {
  struct genlmsghdr genlhdr;
  int len, total_len, id, err, offset;
  uint16_t netdev_index;
  int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
  if (sock =3D=3D -1)
    exit(1);
  int rtsock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
  if (rtsock =3D=3D -1)
    exit(1);
  id =3D netlink_query_family_id(&nlmsg, sock, DEVLINK_FAMILY_NAME, true);
  if (id =3D=3D -1)
    goto error;
  memset(&genlhdr, 0, sizeof(genlhdr));
  genlhdr.cmd =3D DEVLINK_CMD_PORT_GET;
  netlink_init(&nlmsg, id, NLM_F_DUMP, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + =
1);
  netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + =
1);
  err =3D netlink_send_ext(&nlmsg, sock, id, &total_len, true);
  if (err < 0) {
    goto error;
  }
  offset =3D 0;
  netdev_index =3D 0;
  while ((len =3D netlink_next_msg(&nlmsg, offset, total_len)) !=3D -1) {
    struct nlattr* attr =3D (struct nlattr*)(nlmsg.buf + offset + NLMSG_HDR=
LEN +
                                           NLMSG_ALIGN(sizeof(genlhdr)));
    for (; (char*)attr < nlmsg.buf + offset + len;
         attr =3D (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len)=
)) {
      if (attr->nla_type =3D=3D DEVLINK_ATTR_NETDEV_NAME) {
        char* port_name;
        char netdev_name[IFNAMSIZ];
        port_name =3D (char*)(attr + 1);
        snprintf(netdev_name, sizeof(netdev_name), "%s%d", netdev_prefix,
                 netdev_index);
        netlink_device_change(&nlmsg2, rtsock, port_name, true, 0, 0, 0,
                              netdev_name);
        break;
      }
    }
    offset +=3D len;
    netdev_index++;
  }
error:
  close(rtsock);
  close(sock);
}

#define DEV_IPV4 "172.20.20.%d"
#define DEV_IPV6 "fe80::%02x"
#define DEV_MAC 0x00aaaaaaaaaa

static void netdevsim_add(unsigned int addr, unsigned int port_count) {
  write_file("/sys/bus/netdevsim/del_device", "%u", addr);
  if (write_file("/sys/bus/netdevsim/new_device", "%u %u", addr, port_count=
)) {
    char buf[32];
    snprintf(buf, sizeof(buf), "netdevsim%d", addr);
    initialize_devlink_ports("netdevsim", buf, "netdevsim");
  }
}

#define WG_GENL_NAME "wireguard"
enum wg_cmd {
  WG_CMD_GET_DEVICE,
  WG_CMD_SET_DEVICE,
};
enum wgdevice_attribute {
  WGDEVICE_A_UNSPEC,
  WGDEVICE_A_IFINDEX,
  WGDEVICE_A_IFNAME,
  WGDEVICE_A_PRIVATE_KEY,
  WGDEVICE_A_PUBLIC_KEY,
  WGDEVICE_A_FLAGS,
  WGDEVICE_A_LISTEN_PORT,
  WGDEVICE_A_FWMARK,
  WGDEVICE_A_PEERS,
};
enum wgpeer_attribute {
  WGPEER_A_UNSPEC,
  WGPEER_A_PUBLIC_KEY,
  WGPEER_A_PRESHARED_KEY,
  WGPEER_A_FLAGS,
  WGPEER_A_ENDPOINT,
  WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
  WGPEER_A_LAST_HANDSHAKE_TIME,
  WGPEER_A_RX_BYTES,
  WGPEER_A_TX_BYTES,
  WGPEER_A_ALLOWEDIPS,
  WGPEER_A_PROTOCOL_VERSION,
};
enum wgallowedip_attribute {
  WGALLOWEDIP_A_UNSPEC,
  WGALLOWEDIP_A_FAMILY,
  WGALLOWEDIP_A_IPADDR,
  WGALLOWEDIP_A_CIDR_MASK,
};

static void netlink_wireguard_setup(void) {
  const char ifname_a[] =3D "wg0";
  const char ifname_b[] =3D "wg1";
  const char ifname_c[] =3D "wg2";
  const char private_a[] =3D
      "\xa0\x5c\xa8\x4f\x6c\x9c\x8e\x38\x53\xe2\xfd\x7a\x70\xae\x0f\xb2\x0f=
\xa1"
      "\x52\x60\x0c\xb0\x08\x45\x17\x4f\x08\x07\x6f\x8d\x78\x43";
  const char private_b[] =3D
      "\xb0\x80\x73\xe8\xd4\x4e\x91\xe3\xda\x92\x2c\x22\x43\x82\x44\xbb\x88=
\x5c"
      "\x69\xe2\x69\xc8\xe9\xd8\x35\xb1\x14\x29\x3a\x4d\xdc\x6e";
  const char private_c[] =3D
      "\xa0\xcb\x87\x9a\x47\xf5\xbc\x64\x4c\x0e\x69\x3f\xa6\xd0\x31\xc7\x4a=
\x15"
      "\x53\xb6\xe9\x01\xb9\xff\x2f\x51\x8c\x78\x04\x2f\xb5\x42";
  const char public_a[] =3D
      "\x97\x5c\x9d\x81\xc9\x83\xc8\x20\x9e\xe7\x81\x25\x4b\x89\x9f\x8e\xd9=
\x25"
      "\xae\x9f\x09\x23\xc2\x3c\x62\xf5\x3c\x57\xcd\xbf\x69\x1c";
  const char public_b[] =3D
      "\xd1\x73\x28\x99\xf6\x11\xcd\x89\x94\x03\x4d\x7f\x41\x3d\xc9\x57\x63=
\x0e"
      "\x54\x93\xc2\x85\xac\xa4\x00\x65\xcb\x63\x11\xbe\x69\x6b";
  const char public_c[] =3D
      "\xf4\x4d\xa3\x67\xa8\x8e\xe6\x56\x4f\x02\x02\x11\x45\x67\x27\x08\x2f=
\x5c"
      "\xeb\xee\x8b\x1b\xf5\xeb\x73\x37\x34\x1b\x45\x9b\x39\x22";
  const uint16_t listen_a =3D 20001;
  const uint16_t listen_b =3D 20002;
  const uint16_t listen_c =3D 20003;
  const uint16_t af_inet =3D AF_INET;
  const uint16_t af_inet6 =3D AF_INET6;
  const struct sockaddr_in endpoint_b_v4 =3D {
      .sin_family =3D AF_INET,
      .sin_port =3D htons(listen_b),
      .sin_addr =3D {htonl(INADDR_LOOPBACK)}};
  const struct sockaddr_in endpoint_c_v4 =3D {
      .sin_family =3D AF_INET,
      .sin_port =3D htons(listen_c),
      .sin_addr =3D {htonl(INADDR_LOOPBACK)}};
  struct sockaddr_in6 endpoint_a_v6 =3D {.sin6_family =3D AF_INET6,
                                       .sin6_port =3D htons(listen_a)};
  endpoint_a_v6.sin6_addr =3D in6addr_loopback;
  struct sockaddr_in6 endpoint_c_v6 =3D {.sin6_family =3D AF_INET6,
                                       .sin6_port =3D htons(listen_c)};
  endpoint_c_v6.sin6_addr =3D in6addr_loopback;
  const struct in_addr first_half_v4 =3D {0};
  const struct in_addr second_half_v4 =3D {(uint32_t)htonl(128 << 24)};
  const struct in6_addr first_half_v6 =3D {{{0}}};
  const struct in6_addr second_half_v6 =3D {{{0x80}}};
  const uint8_t half_cidr =3D 1;
  const uint16_t persistent_keepalives[] =3D {1, 3, 7, 9, 14, 19};
  struct genlmsghdr genlhdr =3D {.cmd =3D WG_CMD_SET_DEVICE, .version =3D 1=
};
  int sock;
  int id, err;
  sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
  if (sock =3D=3D -1) {
    return;
  }
  id =3D netlink_query_family_id(&nlmsg, sock, WG_GENL_NAME, true);
  if (id =3D=3D -1)
    goto error;
  netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_a, strlen(ifname_a) + 1);
  netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_a, 32);
  netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_a, 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
               sizeof(endpoint_b_v4));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[0], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
               sizeof(first_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
               sizeof(first_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v6,
               sizeof(endpoint_c_v6));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[1], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
               sizeof(second_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
               sizeof(second_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  err =3D netlink_send(&nlmsg, sock);
  if (err < 0) {
  }
  netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_b, strlen(ifname_b) + 1);
  netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_b, 32);
  netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_b, 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
               sizeof(endpoint_a_v6));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[2], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
               sizeof(first_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
               sizeof(first_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v4,
               sizeof(endpoint_c_v4));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[3], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
               sizeof(second_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
               sizeof(second_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  err =3D netlink_send(&nlmsg, sock);
  if (err < 0) {
  }
  netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_c, strlen(ifname_c) + 1);
  netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_c, 32);
  netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_c, 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
               sizeof(endpoint_a_v6));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[4], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
               sizeof(first_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
               sizeof(first_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
               sizeof(endpoint_b_v4));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[5], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
               sizeof(second_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
               sizeof(second_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  err =3D netlink_send(&nlmsg, sock);
  if (err < 0) {
  }

error:
  close(sock);
}

static void initialize_netdevices(void) {
  char netdevsim[16];
  sprintf(netdevsim, "netdevsim%d", (int)procid);
  struct {
    const char* type;
    const char* dev;
  } devtypes[] =3D {
      {"ip6gretap", "ip6gretap0"}, {"bridge", "bridge0"}, {"vcan", "vcan0"}=
,
      {"bond", "bond0"},           {"team", "team0"},     {"dummy", "dummy0=
"},
      {"nlmon", "nlmon0"},         {"caif", "caif0"},     {"batadv", "batad=
v0"},
      {"vxcan", "vxcan1"},         {"veth", 0},           {"wireguard", "wg=
0"},
      {"wireguard", "wg1"},        {"wireguard", "wg2"},
  };
  const char* devmasters[] =3D {"bridge", "bond", "team", "batadv"};
  struct {
    const char* name;
    int macsize;
    bool noipv6;
  } devices[] =3D {
      {"lo", ETH_ALEN},
      {"sit0", 0},
      {"bridge0", ETH_ALEN},
      {"vcan0", 0, true},
      {"tunl0", 0},
      {"gre0", 0},
      {"gretap0", ETH_ALEN},
      {"ip_vti0", 0},
      {"ip6_vti0", 0},
      {"ip6tnl0", 0},
      {"ip6gre0", 0},
      {"ip6gretap0", ETH_ALEN},
      {"erspan0", ETH_ALEN},
      {"bond0", ETH_ALEN},
      {"veth0", ETH_ALEN},
      {"veth1", ETH_ALEN},
      {"team0", ETH_ALEN},
      {"veth0_to_bridge", ETH_ALEN},
      {"veth1_to_bridge", ETH_ALEN},
      {"veth0_to_bond", ETH_ALEN},
      {"veth1_to_bond", ETH_ALEN},
      {"veth0_to_team", ETH_ALEN},
      {"veth1_to_team", ETH_ALEN},
      {"veth0_to_hsr", ETH_ALEN},
      {"veth1_to_hsr", ETH_ALEN},
      {"hsr0", 0},
      {"dummy0", ETH_ALEN},
      {"nlmon0", 0},
      {"vxcan0", 0, true},
      {"vxcan1", 0, true},
      {"caif0", ETH_ALEN},
      {"batadv0", ETH_ALEN},
      {netdevsim, ETH_ALEN},
      {"xfrm0", ETH_ALEN},
      {"veth0_virt_wifi", ETH_ALEN},
      {"veth1_virt_wifi", ETH_ALEN},
      {"virt_wifi0", ETH_ALEN},
      {"veth0_vlan", ETH_ALEN},
      {"veth1_vlan", ETH_ALEN},
      {"vlan0", ETH_ALEN},
      {"vlan1", ETH_ALEN},
      {"macvlan0", ETH_ALEN},
      {"macvlan1", ETH_ALEN},
      {"ipvlan0", ETH_ALEN},
      {"ipvlan1", ETH_ALEN},
      {"veth0_macvtap", ETH_ALEN},
      {"veth1_macvtap", ETH_ALEN},
      {"macvtap0", ETH_ALEN},
      {"macsec0", ETH_ALEN},
      {"veth0_to_batadv", ETH_ALEN},
      {"veth1_to_batadv", ETH_ALEN},
      {"batadv_slave_0", ETH_ALEN},
      {"batadv_slave_1", ETH_ALEN},
      {"geneve0", ETH_ALEN},
      {"geneve1", ETH_ALEN},
      {"wg0", 0},
      {"wg1", 0},
      {"wg2", 0},
  };
  int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
  if (sock =3D=3D -1)
    exit(1);
  unsigned i;
  for (i =3D 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
    netlink_add_device(&nlmsg, sock, devtypes[i].type, devtypes[i].dev);
  for (i =3D 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
    char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
    sprintf(slave0, "%s_slave_0", devmasters[i]);
    sprintf(veth0, "veth0_to_%s", devmasters[i]);
    netlink_add_veth(&nlmsg, sock, slave0, veth0);
    sprintf(slave1, "%s_slave_1", devmasters[i]);
    sprintf(veth1, "veth1_to_%s", devmasters[i]);
    netlink_add_veth(&nlmsg, sock, slave1, veth1);
    sprintf(master, "%s0", devmasters[i]);
    netlink_device_change(&nlmsg, sock, slave0, false, master, 0, 0, NULL);
    netlink_device_change(&nlmsg, sock, slave1, false, master, 0, 0, NULL);
  }
  netlink_add_xfrm(&nlmsg, sock, "xfrm0");
  netlink_device_change(&nlmsg, sock, "bridge_slave_0", true, 0, 0, 0, NULL=
);
  netlink_device_change(&nlmsg, sock, "bridge_slave_1", true, 0, 0, 0, NULL=
);
  netlink_add_veth(&nlmsg, sock, "hsr_slave_0", "veth0_to_hsr");
  netlink_add_veth(&nlmsg, sock, "hsr_slave_1", "veth1_to_hsr");
  netlink_add_hsr(&nlmsg, sock, "hsr0", "hsr_slave_0", "hsr_slave_1");
  netlink_device_change(&nlmsg, sock, "hsr_slave_0", true, 0, 0, 0, NULL);
  netlink_device_change(&nlmsg, sock, "hsr_slave_1", true, 0, 0, 0, NULL);
  netlink_add_veth(&nlmsg, sock, "veth0_virt_wifi", "veth1_virt_wifi");
  netlink_add_linked(&nlmsg, sock, "virt_wifi", "virt_wifi0",
                     "veth1_virt_wifi");
  netlink_add_veth(&nlmsg, sock, "veth0_vlan", "veth1_vlan");
  netlink_add_vlan(&nlmsg, sock, "vlan0", "veth0_vlan", 0, htons(ETH_P_8021=
Q));
  netlink_add_vlan(&nlmsg, sock, "vlan1", "veth0_vlan", 1, htons(ETH_P_8021=
AD));
  netlink_add_macvlan(&nlmsg, sock, "macvlan0", "veth1_vlan");
  netlink_add_macvlan(&nlmsg, sock, "macvlan1", "veth1_vlan");
  netlink_add_ipvlan(&nlmsg, sock, "ipvlan0", "veth0_vlan", IPVLAN_MODE_L2,=
 0);
  netlink_add_ipvlan(&nlmsg, sock, "ipvlan1", "veth0_vlan", IPVLAN_MODE_L3S=
,
                     IPVLAN_F_VEPA);
  netlink_add_veth(&nlmsg, sock, "veth0_macvtap", "veth1_macvtap");
  netlink_add_linked(&nlmsg, sock, "macvtap", "macvtap0", "veth0_macvtap");
  netlink_add_linked(&nlmsg, sock, "macsec", "macsec0", "veth1_macvtap");
  char addr[32];
  sprintf(addr, DEV_IPV4, 14 + 10);
  struct in_addr geneve_addr4;
  if (inet_pton(AF_INET, addr, &geneve_addr4) <=3D 0)
    exit(1);
  struct in6_addr geneve_addr6;
  if (inet_pton(AF_INET6, "fc00::01", &geneve_addr6) <=3D 0)
    exit(1);
  netlink_add_geneve(&nlmsg, sock, "geneve0", 0, &geneve_addr4, 0);
  netlink_add_geneve(&nlmsg, sock, "geneve1", 1, 0, &geneve_addr6);
  netdevsim_add((int)procid, 4);
  netlink_wireguard_setup();
  for (i =3D 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
    char addr[32];
    sprintf(addr, DEV_IPV4, i + 10);
    netlink_add_addr4(&nlmsg, sock, devices[i].name, addr);
    if (!devices[i].noipv6) {
      sprintf(addr, DEV_IPV6, i + 10);
      netlink_add_addr6(&nlmsg, sock, devices[i].name, addr);
    }
    uint64_t macaddr =3D DEV_MAC + ((i + 10ull) << 40);
    netlink_device_change(&nlmsg, sock, devices[i].name, true, 0, &macaddr,
                          devices[i].macsize, NULL);
  }
  close(sock);
}
static void initialize_netdevices_init(void) {
  int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
  if (sock =3D=3D -1)
    exit(1);
  struct {
    const char* type;
    int macsize;
    bool noipv6;
    bool noup;
  } devtypes[] =3D {
      {"nr", 7, true},
      {"rose", 5, true, true},
  };
  unsigned i;
  for (i =3D 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++) {
    char dev[32], addr[32];
    sprintf(dev, "%s%d", devtypes[i].type, (int)procid);
    sprintf(addr, "172.30.%d.%d", i, (int)procid + 1);
    netlink_add_addr4(&nlmsg, sock, dev, addr);
    if (!devtypes[i].noipv6) {
      sprintf(addr, "fe88::%02x:%02x", i, (int)procid + 1);
      netlink_add_addr6(&nlmsg, sock, dev, addr);
    }
    int macsize =3D devtypes[i].macsize;
    uint64_t macaddr =3D 0xbbbbbb +
                       ((unsigned long long)i << (8 * (macsize - 2))) +
                       (procid << (8 * (macsize - 1)));
    netlink_device_change(&nlmsg, sock, dev, !devtypes[i].noup, 0, &macaddr=
,
                          macsize, NULL);
  }
  close(sock);
}

#define MAX_FDS 30

static long syz_genetlink_get_family_id(volatile long name,
                                        volatile long sock_arg) {
  int fd =3D sock_arg;
  if (fd < 0) {
    fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
    if (fd =3D=3D -1) {
      return -1;
    }
  }
  struct nlmsg nlmsg_tmp;
  int ret =3D netlink_query_family_id(&nlmsg_tmp, fd, (char*)name, false);
  if ((int)sock_arg < 0)
    close(fd);
  if (ret < 0) {
    return -1;
  }
  return ret;
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
  if (symlink("/dev/binderfs", "./binderfs")) {
  }
}

static void loop();

static void sandbox_common() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setsid();
  struct rlimit rlim;
  rlim.rlim_cur =3D rlim.rlim_max =3D (200 << 20);
  setrlimit(RLIMIT_AS, &rlim);
  rlim.rlim_cur =3D rlim.rlim_max =3D 32 << 20;
  setrlimit(RLIMIT_MEMLOCK, &rlim);
  rlim.rlim_cur =3D rlim.rlim_max =3D 136 << 20;
  setrlimit(RLIMIT_FSIZE, &rlim);
  rlim.rlim_cur =3D rlim.rlim_max =3D 1 << 20;
  setrlimit(RLIMIT_STACK, &rlim);
  rlim.rlim_cur =3D rlim.rlim_max =3D 128 << 20;
  setrlimit(RLIMIT_CORE, &rlim);
  rlim.rlim_cur =3D rlim.rlim_max =3D 256;
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
  static const sysctl_t sysctls[] =3D {
      {"/proc/sys/kernel/shmmax", "16777216"},
      {"/proc/sys/kernel/shmall", "536870912"},
      {"/proc/sys/kernel/shmmni", "1024"},
      {"/proc/sys/kernel/msgmax", "8192"},
      {"/proc/sys/kernel/msgmni", "1024"},
      {"/proc/sys/kernel/msgmnb", "1024"},
      {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
  };
  unsigned i;
  for (i =3D 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
    write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid) {
  if (pid < 0)
    exit(1);
  int status =3D 0;
  while (waitpid(-1, &status, __WALL) !=3D pid) {
  }
  return WEXITSTATUS(status);
}

static void drop_caps(void) {
  struct __user_cap_header_struct cap_hdr =3D {};
  struct __user_cap_data_struct cap_data[2] =3D {};
  cap_hdr.version =3D _LINUX_CAPABILITY_VERSION_3;
  cap_hdr.pid =3D getpid();
  if (syscall(SYS_capget, &cap_hdr, &cap_data))
    exit(1);
  const int drop =3D (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
  cap_data[0].effective &=3D ~drop;
  cap_data[0].permitted &=3D ~drop;
  cap_data[0].inheritable &=3D ~drop;
  if (syscall(SYS_capset, &cap_hdr, &cap_data))
    exit(1);
}

static int do_sandbox_none(void) {
  if (unshare(CLONE_NEWPID)) {
  }
  int pid =3D fork();
  if (pid !=3D 0)
    return wait_for_loop(pid);
  setup_common();
  sandbox_common();
  drop_caps();
  initialize_netdevices_init();
  if (unshare(CLONE_NEWNET)) {
  }
  write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
  initialize_netdevices();
  setup_binderfs();
  loop();
  exit(1);
}

static void kill_and_wait(int pid, int* status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i =3D 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
      return;
    usleep(1000);
  }
  DIR* dir =3D opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent =3D readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =
=3D=3D 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd =3D open(abort, O_WRONLY);
      if (fd =3D=3D -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) !=3D pid) {
  }
}

static void setup_test() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

static void close_fds() {
  for (int fd =3D 3; fd < MAX_FDS; fd++)
    close(fd);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
  int iter =3D 0;
  for (;; iter++) {
    int pid =3D fork();
    if (pid < 0)
      exit(1);
    if (pid =3D=3D 0) {
      setup_test();
      execute_one();
      close_fds();
      exit(0);
    }
    int status =3D 0;
    uint64_t start =3D current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[4] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffff=
ff,
                 0x0};

void execute_one(void) {
  intptr_t res =3D 0;
  res =3D syscall(__NR_socket, /*domain=3D*/0x11ul, /*type=3D*/3ul, /*proto=
=3D*/0x300);
  if (res !=3D -1)
    r[0] =3D res;
  *(uint32_t*)0x20006ffc =3D 0x200;
  syscall(__NR_setsockopt, /*fd=3D*/r[0], /*level=3D*/0x107, /*optname=3D*/=
0xf,
          /*optval=3D*/0x20006ffcul, /*optlen=3D*/0xe50fb6c50bc849c9ul);
  res =3D syscall(__NR_socket, /*domain=3D*/0x10ul, /*type=3D*/3ul, /*proto=
=3D*/0);
  if (res !=3D -1)
    r[1] =3D res;
  *(uint64_t*)0x20001340 =3D 0;
  *(uint32_t*)0x20001348 =3D 0;
  *(uint64_t*)0x20001350 =3D 0x20000800;
  *(uint64_t*)0x20000800 =3D 0;
  *(uint64_t*)0x20000808 =3D 0;
  *(uint64_t*)0x20000810 =3D 0;
  *(uint64_t*)0x20000818 =3D 0;
  *(uint64_t*)0x20000820 =3D 0;
  *(uint64_t*)0x20000828 =3D 0;
  *(uint64_t*)0x20000830 =3D 0x200001c0;
  memcpy((void*)0x200001c0,
         "\x8f\xc2\x86\x98\x2d\xf8\x34\x00\x25\x8d\x0b\xce\x45\x0d\xcb\x27\=
x3c"
         "\x88\x0f\x76\x6d\x6d\x47\xbf\x05\xa0\x14\x6a\x7a\xb1\xcc\xa6\x71\=
x44"
         "\x75\xe7\x55\xea\xe9\xcc\x4c\x43\x05",
         43);
  *(uint64_t*)0x20000838 =3D 0x2b;
  *(uint64_t*)0x20000840 =3D 0;
  *(uint64_t*)0x20000848 =3D 0;
  *(uint64_t*)0x20000850 =3D 0;
  *(uint64_t*)0x20000858 =3D 0;
  *(uint64_t*)0x20000860 =3D 0;
  *(uint64_t*)0x20000868 =3D 0;
  *(uint64_t*)0x20001358 =3D 7;
  *(uint64_t*)0x20001360 =3D 0;
  *(uint64_t*)0x20001368 =3D 0;
  *(uint32_t*)0x20001370 =3D 0;
  *(uint32_t*)0x20001378 =3D 0;
  *(uint64_t*)0x20001380 =3D 0;
  *(uint32_t*)0x20001388 =3D 0;
  *(uint64_t*)0x20001390 =3D 0;
  *(uint64_t*)0x20001398 =3D 0;
  *(uint64_t*)0x200013a0 =3D 0;
  *(uint64_t*)0x200013a8 =3D 0;
  *(uint32_t*)0x200013b0 =3D 0;
  *(uint32_t*)0x200013b8 =3D 0;
  *(uint64_t*)0x200013c0 =3D 0;
  *(uint32_t*)0x200013c8 =3D 0;
  *(uint64_t*)0x200013d0 =3D 0;
  *(uint64_t*)0x200013d8 =3D 0;
  *(uint64_t*)0x200013e0 =3D 0;
  *(uint64_t*)0x200013e8 =3D 0;
  *(uint32_t*)0x200013f0 =3D 0;
  *(uint32_t*)0x200013f8 =3D 0;
  syscall(__NR_sendmmsg, /*fd=3D*/r[0], /*mmsg=3D*/0x20001340ul, /*vlen=3D*=
/3ul,
          /*f=3D*/0x40000ul);
  res =3D syscall(__NR_socket, /*domain=3D*/0x10ul, /*type=3D*/0x803ul, /*p=
roto=3D*/0);
  if (res !=3D -1)
    r[2] =3D res;
  memcpy((void*)0x20000700, "TIPCv2\000", 7);
  syz_genetlink_get_family_id(/*name=3D*/0x20000700, /*fd=3D*/r[2]);
  *(uint32_t*)0x20000200 =3D 0x14;
  res =3D syscall(__NR_getsockname, /*fd=3D*/r[2], /*addr=3D*/0x20001480ul,
                /*addrlen=3D*/0x20000200ul);
  if (res !=3D -1)
    r[3] =3D *(uint32_t*)0x20001484;
  *(uint64_t*)0x20000000 =3D 0;
  *(uint32_t*)0x20000008 =3D 0;
  *(uint64_t*)0x20000010 =3D 0x20000140;
  *(uint64_t*)0x20000140 =3D 0x20000500;
  memcpy((void*)0x20000500,
         "\x3c\x00\x00\x00\x10\x00\x01\x44\x00\xee\xff\xff\xff\xff\x07\x1a\=
xf7"
         "\x00\x00\x00",
         20);
  *(uint32_t*)0x20000514 =3D r[3];
  memcpy((void*)0x20000518,
         "\x01\x00\x00\x00\x01\x00\x00\x00\x1c\x00\x12\x00\x0c\x00\x01\x00\=
x62"
         "\x72\x69\x64\x67\x65",
         22);
  *(uint64_t*)0x20000148 =3D 0x3c;
  *(uint64_t*)0x20000018 =3D 1;
  *(uint64_t*)0x20000020 =3D 0;
  *(uint64_t*)0x20000028 =3D 0;
  *(uint32_t*)0x20000030 =3D 0;
  syscall(__NR_sendmsg, /*fd=3D*/r[2], /*msg=3D*/0x20000000ul, /*f=3D*/0ul)=
;
  *(uint64_t*)0x200007c0 =3D 0;
  *(uint32_t*)0x200007c8 =3D 0;
  *(uint64_t*)0x200007d0 =3D 0x20000080;
  *(uint64_t*)0x20000080 =3D 0x20000180;
  memcpy((void*)0x20000180,
         "\x60\x00\x00\x00\x24\x00\x0b\x0e\x00\x00\x00\x00\x00\x80\x00\x00\=
x00"
         "\x00\x00\x00",
         20);
  *(uint32_t*)0x20000194 =3D r[3];
  memcpy(
      (void*)0x20000198,
      "\x00\x00\x00\x00\xff\xff\xff\xff\x00\x00\x00\x45\x08\x00\x01\x00\x74=
\x62"
      "\x66\x00\x34\x00\x02\x00\x08\x00\x06\x00\xa4\x23\x00\x00\x28\x00\x01=
",
      35);
  *(uint64_t*)0x20000088 =3D 0x60;
  *(uint64_t*)0x200007d8 =3D 1;
  *(uint64_t*)0x200007e0 =3D 0;
  *(uint64_t*)0x200007e8 =3D 0;
  *(uint32_t*)0x200007f0 =3D 0;
  syscall(__NR_sendmsg, /*fd=3D*/r[1], /*msg=3D*/0x200007c0ul, /*f=3D*/0ul)=
;
  *(uint16_t*)0x20000040 =3D 0x11;
  *(uint16_t*)0x20000042 =3D htobe16(0);
  *(uint32_t*)0x20000044 =3D r[3];
  *(uint16_t*)0x20000048 =3D 1;
  *(uint8_t*)0x2000004a =3D 0;
  *(uint8_t*)0x2000004b =3D 6;
  memset((void*)0x2000004c, 170, 5);
  *(uint8_t*)0x20000051 =3D 0;
  memset((void*)0x20000052, 0, 2);
  syscall(__NR_bind, /*fd=3D*/r[0], /*addr=3D*/0x20000040ul, /*addrlen=3D*/=
0x14ul);
  memcpy((void*)0x20000280,
         "\x41\x03\x09\x5c\xf2\x1d\x48\x04\x07\x02\x02\x00\xc5\x2c\xf7\xc2\=
x59"
         "\x75\xe0\x05\xb0\x2f\x08\x00\xeb\x2b\x2f\xf0\xda\xc8\x89\x7c\x6b\=
x11"
         "\x87\x77\xfa\xff\xff\xff\x30\x66\x09\x0c\xb6\x00\xc5\x47\x1d\x13\=
x0a"
         "\x66\x32\x1a\x54\xe7\xdf\x30\x5f\x80\xa8\x81\x61\xb6\xfd\x8f\x24\=
x28"
         "\x6a\x57\xc3\xfe\xff\xff",
         74);
  syscall(__NR_sendto, /*fd=3D*/r[0], /*buf=3D*/0x20000280ul, /*len=3D*/0x5=
c13ul,
          /*f=3D*/0x806ul, /*addr=3D*/0ul, /*addrlen=3D*/0x2ful);
}
int main(void) {
  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  do_sandbox_none();
  return 0;
}

=3D* repro.txt =3D*
r0 =3D socket$packet(0x11, 0x3, 0x300)
setsockopt$packet_int(r0, 0x107, 0xf,
&(0x7f0000006ffc)=3D0x4000000000000200, 0xe50fb6c50bc849c9)
r1 =3D socket(0x10, 0x3, 0x0)
sendmmsg$inet(r0, &(0x7f0000001340)=3D[{{0x0, 0x0,
&(0x7f0000000800)=3D[{0x0}, {0x0}, {0x0},
{&(0x7f00000001c0)=3D"8fc286982df83400258d0bce450dcb273c880f766d6d47bf05a01=
46a7ab1cca6714475e755eae9cc4c4305",
0x2b}, {0x0}, {0x0}, {0x0}], 0x7}}, {{0x0, 0x0, 0x0}}, {{0x0, 0x0,
0x0}}], 0x3, 0x40000)
r2 =3D socket(0x10, 0x803, 0x0)
syz_genetlink_get_family_id$tipc2(&(0x7f0000000700), r2)
getsockname$packet(r2, &(0x7f0000001480)=3D{0x11, 0x0, <r3=3D>0x0, 0x1,
0x0, 0x6, @broadcast}, &(0x7f0000000200)=3D0x14)
sendmsg$nl_route(r2, &(0x7f0000000000)=3D{0x0, 0x0,
&(0x7f0000000140)=3D{&(0x7f0000000500)=3DANY=3D[@ANYBLOB=3D"3c0000001000014=
400eeffffffff071af7000000",
@ANYRES32=3Dr3, @ANYBLOB=3D"01000000010000001c0012000c000100627269646765"],
0x3c}}, 0x0)
sendmsg$nl_route_sched(r1, &(0x7f00000007c0)=3D{0x0, 0x0,
&(0x7f0000000080)=3D{&(0x7f0000000180)=3DANY=3D[@ANYBLOB=3D"6000000024000b0=
e000000000080000000000000",
@ANYRES32=3Dr3, @ANYBLOB=3D"00000000ffffffff0000004508000100746266003400020=
008000600a4230000280001"],
0x60}}, 0x0)
bind$packet(r0, &(0x7f0000000040)=3D{0x11, 0x0, r3, 0x1, 0x0, 0x6, @dev}, 0=
x14)
sendto$inet6(r0,
&(0x7f0000000280)=3D"4103095cf21d480407020200c52cf7c25975e005b02f0800eb2b2f=
f0dac8897c6b118777faffffff3066090cb600c5471d130a66321a54e7df305f80a88161b6f=
d8f24286a57c3feffff",
0x5c13, 0x806, 0x0, 0x2f)

See aslo https://gist.github.com/xrivendell7/865a5d95635b9dde886a3f3eb156b7=
f9

BTW, I make a simple analysis for this bug, because there is a similar
bug related to net/rose
https://syzkaller.appspot.com/bug?extid=3D677921bcd8c3a67a3df3 do not
respone so far, and in the same fuzzing instance, I aslo triggered bug
titled "KASAN: null-ptr-deref Read in rose_transmit_link=E2=80=9D and "KASA=
N:
slab-use-after-free Read in mini_qdisc_pair_swap=E2=80=9D. When analysis th=
e
repro.txt above, I notice this syscall
getsockname$packet(r2, &(0x7f0000001480)=3D{0x11, 0x0, <r3=3D>0x0, 0x1,
0x0, 0x6, @broadcast}, &(0x7f0000000200)=3D0x14)
the r3 socket is a AF_PACKET.
and also in the repro.txt of bug =E2=80=9CKASAN: slab-use-after-free Read i=
n
mini_qdisc_pair_swap=E2=80=9D below:
r0 =3D socket$nl_route(0x10, 0x3, 0x0)
r1 =3D socket(0x11, 0x800000003, 0x0)
bind(r1, &(0x7f0000000080)=3D@generic=3D{0x11,
"0000010000000000080044944eeba71a4976e252922cb18f6e2e2aba000000012e0b383600=
5404b0e0301a4ce875f2e3ff5f163ee340b7679500800000000000000101013c5811039e157=
75027ecce66fd792bbf0e5bf5ff1b0816f3f6db1c0001000000000000004974000000000000=
0006ad8e5ecc326d3a09ffc2c654"},
0x80)
getsockname$packet(r1, &(0x7f0000000040)=3D{0x11, 0x0, <r2=3D>0x0, 0x1,
0x0, 0x6, @dev}, &(0x7f0000000140)=3D0x14)
sendmsg$nl_route_sched(r0, &(0x7f00000001c0)=3D{0x0, 0x0,
&(0x7f0000000180)=3D{&(0x7f0000000200)=3D@newtfilter=3D{0x3c, 0x2c, 0xd27,
0x0, 0x0, {0x0, 0x0, 0x0, r2, {}, {0x0, 0xffff}, {0x2}},
[@filter_kind_options=3D@f_basic=3D{{0xa}, {0xc, 0x2,
[@TCA_BASIC_CLASSID=3D{0x8, 0x1, {0x0, 0xffff}}]}}]}, 0x3c}}, 0x0)
r3 =3D socket$nl_route(0x10, 0x3, 0x0)
r4 =3D socket(0x11, 0x800000003, 0x0)
bind(r4, &(0x7f0000000180)=3D@generic=3D{0x11,
"0000010000000000080044944eeba72e2aba000000012e0b3836005404b0e0301a08000000=
e3ff5f163ee340b7679500800000000000000101013c5811039e15775027ecce66fd792bbf0=
e5bf5ff1b0816f3f6db1c000100000000000000497400000000000000065ecc326d3a09ffc2=
c65400"},
0x80)
sendmsg$nl_route_sched(r0, &(0x7f0000000fc0)=3D{&(0x7f0000000240)=3D{0x10,
0x0, 0x0, 0x4}, 0xc,
&(0x7f0000000f80)=3D{&(0x7f0000000b80)=3D@newtaction=3D{0x3ec, 0x30, 0x800,
0x70bd25, 0x25dfdbfc, {}, [{0x3d8, 0x1, [@m_xt=3D{0x298, 0x6, 0x0, 0x0,
{{0x7}, {0x1b0, 0x2, 0x0, 0x1, [@TCA_IPT_TARG=3D{0x10f, 0x6, {0x1,
'filter\x00', 0x2, 0x81,
"0f6a0e0e9afe6ddcc31e0e668f77ddf9119e50d18216aeb5aa9f203e3cc53be5b5e38b3bd0=
7de80b47aefdbc0f9ccccfb2992b045d841cb60de6b62120e990b2dce06b27b76e8dc05282f=
f99b491baece2e95564344b923fc333ba942160fcfb32e390a058ac445fa3fdbf222646ad90=
17c991b55724092280ccf4e7587ed5488546b6d1b76d6266d776c5f4d3e271f54aa8c666f98=
69f1efbc141f93536baf54e445006cde67ae19b5a108d2b42d60258ad757bdb366664d51fef=
d60c0f34be08a4d782871a0fe790d97afcf333a1b0b2a8855831183d8158c4ad18f1abcf915=
7b95700ea"}},
@TCA_IPT_TARG=3D{0x4a, 0x6, {0x1ff, 'filter\x00', 0x0, 0xfff,
"218cac2617fc60c1ab2a4db8719d2d06f442070848ab99e8745c05db95b2ffa0"}},
@TCA_IPT_TARG=3D{0x46, 0x6, {0x0, 'mangle\x00', 0x0, 0x8000,
"602fb37f5a77780427fe2d2b98797d28cd1b381186073dedb8845115"}},
@TCA_IPT_HOOK=3D{0x8, 0x2, 0x4}]}, {0xc2, 0x6,
"5f6c37010c0403cc9b6816f199e64cbd31209b4f9ae1ef492ccf689a4bf45834ebc4b552a2=
54c39ea0145114b3ab87ae5902b061ff0d7d0884c4ef3898c749a30087dd7a337ab1029659c=
7aded68b95b1d70d2f1e0160a7be432ca197cd9d9ab377f84fccba0de883f107e5bb42d49ac=
edfc21ebbbba51340fa03a8d8256f88597ab465c3e05aa4b95283104da7f194717b52cf3a42=
a62763d9f5e3903e2b6eae1ff4dbadab08f9d7cbe8424e35d6eee461472fe778afa2cc012cc=
17862c"},
{0xc, 0x7, {0x0, 0x1}}, {0xc, 0x8, {0x4, 0x2}}}}, @m_ct=3D{0x13c, 0x14,
0x0, 0x0, {{0x7}, {0x4c, 0x2, 0x0, 0x1, [@TCA_CT_PARMS=3D{0x18, 0x1,
{0x400, 0xfffffe01, 0x4, 0x5, 0x3ff}}, @TCA_CT_NAT_IPV6_MIN=3D{0x14,
0xb, @dev=3D{0xfe, 0x80, '\x00', 0x42}}, @TCA_CT_LABELS_MASK=3D{0x14, 0x8,
"13b512d82312f916d67fdbd5b16d3237"}, @TCA_CT_ACTION=3D{0x6, 0x3,
0x23}]}, {0xcb, 0x6,
"cf98aefc95d61dfa6782891a5719a3b681816fb6c044d6c8d89eff2059c7964d8e81f70391=
62904b509c86c781358268a18d72be977577b1537729daf78cf6ef23a4ff31ebb423f245d3b=
450010d037143aaf848f11f3bb849900ef8c1e358fb30568cc604e194a413ba6a7e22051d17=
d6f912153ca7a2a592831f1bd6fc25da70cde15360d10a034504727bc06a576479cde3cd6b5=
905dbcce6c631d2b0f476a1a9373d37cf20c8b32da1111379ca5897892f996fd80252607fc1=
9370ff7aee4b20c486a04cc7"},
{0xc, 0x7, {0x0, 0x1}}, {0xc, 0x8, {0x2}}}}]}]}, 0x3ec}, 0x1, 0x0,
0x0, 0x40000}, 0x200580c0)
getsockname$packet(r4, &(0x7f0000000000)=3D{0x11, 0x0, <r5=3D>0x0, 0x1,
0x0, 0x6, @dev}, &(0x7f0000000140)=3D0x14)
sendmsg$nl_route_sched(r3, &(0x7f0000000200)=3D{0x0, 0x0,
&(0x7f0000000080)=3D{&(0x7f0000000040)=3D@gettclass=3D{0x24, 0x29, 0x1, 0x0=
,
0x0, {0x0, 0x0, 0x0, r5, {0x0, 0xffff}, {0x0, 0xffff}}}, 0x24}}, 0x0)
pipe(&(0x7f0000000200)=3D{<r6=3D>0xffffffffffffffff, <r7=3D>0xfffffffffffff=
fff})
r8 =3D socket$inet_udp(0x2, 0x2, 0x0)
setsockopt$inet6_mreq(0xffffffffffffffff, 0x29, 0x0,
&(0x7f0000000000)=3D{@mcast2}, 0x14)
close(r8)
socket$inet(0x10, 0x2, 0x0)
r9 =3D socket(0x11, 0x800000003, 0x0)
bind(r9, &(0x7f0000000080)=3D@generic=3D{0x11,
"0000010000000000080025944eeba71a4976e252922c000000002aba000000012e0b383600=
5404b0e0301a4ce875f2e0ff5f163ee340b7679500800000000000000101013c5891039e157=
75027ecce66fd792bbf0e5bf5ff1b0816f3f6db1c0001000000000000004974000000000000=
0006ad8e5ecc326d3a09ffc2c654"},
0x80)
getsockname$packet(r9, &(0x7f0000000100)=3D{0x11, 0x0, <r10=3D>0x0, 0x1,
0x0, 0x6, @dev}, &(0x7f0000000140)=3D0x14)
sendmsg$nl_route_sched(0xffffffffffffffff, &(0x7f0000000280)=3D{0x0,
0x0, &(0x7f00000002c0)=3D{&(0x7f0000000300)=3DANY=3D[@ANYBLOB=3D"d008000024=
00ffffff7f00000000ffffa6fffff7",
@ANYRES32=3Dr10, @ANYBLOB=3D"0000000bf1ffffff000000000800010063627100a40802=
0004040600030000000500000000700300fdffffffffff00001f00000005000000000100000=
00000100083000000fdffffff07000000084900000100000002000000cf000000feffffff08=
00003326f6000180000003000000090000000200000000274a49ef6949a7bb0000000500000=
00100000004000000ff7f000000000000000400000002000004000000ff0f0000f44f350001=
000000010400005eb768350100000008000000ffffffffc38d00001f0000000400088306000=
00000000100f7ffffff030000000080ffff050000000600000006000000a900000000000000=
c0000000c0ffffff08000000018000000101000006000000b30000000000002005000000010=
4000004000000070000000800000001010000c22e0000c0ffffff0500000004000000060000=
000900000008000000f7ffffff0800000003000000080000000400000001030080040000000=
400000000100000040000000700000009000000fcffffff0100000001000000090000000002=
0000060e0000080000000200000002000000090000000800000007000000ab000000fb00000=
007000000ff0100000800000001040000070000000300000009000000ff07000008000000ff=
ff0000a90100000900000005000000200000000500000001000000070000008eb7000000000=
080010000000000000007000000fffffffffcffffff01f0ffff000000003f00000003000000=
000100000080000000800000030000000500000005000000ffffffff0700000015ba0000040=
00000070000000300000003000000ffffffff04000000554f00006ff8000007000000030000=
00000200000600000008000000b300000006000000000000000007000001010000030000000=
080000000040000730a000001000080010000009e0c00000008000001000080000000000000=
00004000000000fefffff67d000006000000ff0100000200000000000000400000004000000=
0ed000000010001000e0a05000000000000020000040000000600000002000000ff7f000001=
00000001000000060000007f000000020000000004000004000000090000009000000008000=
000b67c0000040000000400000005000000f50a0000ffff0000060000008ff9ffff07000000=
1eaaffff3f0000008000000000000000ff0c0000ff7f0000030000007f0000002d000000080=
0000000010000ff070000ffffffff2bab000002000000ace800000500000000000000e1bf93=
4d070000001f000d00030000000400000007000000090000000500000003000000020000008=
7d400000200000008000000000100007f0000000e000000080000000200000007000000ffff=
ff7f06000000000000000500000001000000820000001f0000000004000001000000fafffff=
f0500000006000000070000000300000010000500810306009fff04000800000004040600d9=
0b0000ff00000005000000040000001ba2cc3b00000080010000003f000000ff0f002011524=
97303008000be060000fffffffffffeffff7f000000ff0000008100000000db040009000000=
070000000300000000000000060000008f5e000001000000000200000600000001010000020=
0000007000000000000e0318900000104000000080000060000000400000008000000040000=
0002000000c00000000800000008000000f7ffffff05000000810000004d00000001000080e=
b0700001f000000090000000597000001000000000000000000000002000000ffff00000100=
000002000000000000e0a000000040000000ff000000f7ffffff05000000090000000700000=
00600000028080000030000000600000004000000be00000003000000070000000500000038=
080000faffffffffffffff47b5554d001000008100000007000000ffffffff0400000001000=
00002000000566b00002000000004000000020000008b01000001000000ffff000004000000=
ff0f0000050000002000000003000000e40d000007000000f8ffffff200000003f000000387=
f00000700000007000000c10a00000900000004000000040000000000000000800000010000=
8009000000370b000000000080ff07000006000000bb7900000400000002000000ffffff7f0=
300000000000000090000000700000005000000000000807f0000000900000008000000fad4=
ffffff01000001010000010000003f0000000400000020f2ffff01000100ffff00000100000=
00200000008000000fbfffffff9ffffff040000004d00000006000000020000000200000007=
0000004e0d0000000200000800000035000000300e000007000000000400000200000001800=
00020000000f2ffffff070000000500000000010000fffffeff090000000008000007000000=
0800000009000000ff7f0000090000000400000004000000000000000600000005000000010=
0000009000000080000007e0700000300000000800000bf16000002000006000000ffee0000=
000100000000000000001000000100000000000000000000007f00000010080000000000000=
100008002000000080000000101000003000000ffffff7ffffffffff7ffffff060000000300=
0000a6060000ff0300000700000001800000090000000200000000000000040000000080fff=
f00020000070000000500000001000100000000800000af06060000002b0a00000500000001=
0000000500000009000000040000000500000002000000ffffff7ff30000000800000002000=
000ffff0000ff070000810000004000000075fc000009000000fbffffff0500000000000000=
810000000100000080000000d05e0000020000001f00000000000000ff010000451e00002d0=
0000000000000ff0000001000030008001000ff070000010000001800010039"],
0x3}}, 0x0)
write$binfmt_misc(r7, &(0x7f0000000000)=3DANY=3D[], 0xfffffecc)
splice(r6, 0x0, r8, 0x0, 0x4ffe0, 0x0)

notice the similar getsockname$packet(r4, &(0x7f0000000000)=3D{0x11,
0x0, <r5=3D>0x0, 0x1, 0x0, 0x6, @dev}, &(0x7f0000000140)=3D0x14) also
related to net/rose.
So I believe it maybe also the same bug realted to net/rose
AF_PACKET/PF_PACKET socket cluster.
If such a security warning is indeed caused, I think it is necessary
to fix it quickly.

I hope it helps.
Best regards.
xingwei Lee

