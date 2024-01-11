Return-Path: <linux-kernel+bounces-23748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43D82B118
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0FFB26778
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5554F8A1;
	Thu, 11 Jan 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZvINUcg+"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B34F89C;
	Thu, 11 Jan 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5huqC
	nkIL02HxyV0BOwNO481k6+3gC9UOJ6p0OtscO0=; b=ZvINUcg+YxT+qYndKhR8G
	uYFaa0GtXgaVQVflIZxMyqG5AAfOg0/5bj5dYt1G52yOj+WkNGUsV286c33Lw3IY
	j79wDrumfoPxm4+8AfAGeRFKz5SrjVfuJh7iwwK9c5ZL/L+d6jM5AmzeDTgreYFZ
	RUpUj7blO617blTtTh4tFA=
Received: from localhost.localdomain (unknown [111.35.187.31])
	by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wDnr0HqAKBluv0XAg--.60630S4;
	Thu, 11 Jan 2024 22:53:38 +0800 (CST)
From: David Wang <00107082@163.com>
To: kadlec@blackhole.kfki.hu
Cc: 00107082@163.com,
	ale.crismani@automattic.com,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	xiaolinkui@kylinos.cn
Subject: Re:Performance regression in ip_set_swap on 6.7.0
Date: Thu, 11 Jan 2024 22:53:30 +0800
Message-Id: <20240111145330.18474-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu>
References: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr0HqAKBluv0XAg--.60630S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArWruFyfKr48Zw1kCF48WFg_yoWfXF43pF
	yrK3W8Jrn5A34kur4jkw4akrZFqan2gr4DW3yfGFy0kF4Yqr4kZFWqgryUuFn5CFykA3yx
	tas8WF12vr1qyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbjjDUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBtiqmVOBleitAABsW

I tested the patch with code stressing swap->destroy->create->add 10000 times, the performance regression still happens, and now it is ip_set_destroy.
(I pasted the test code at the end of this mail)  
time show that most delay is 'off cpu':
	$ time sudo ./stressipset 

	real	2m45.115s
	user	0m0.019s
	sys	0m0.744s

Most time, callstack stuck in rcu_barrier:
	$ sudo cat /proc/2158/stack
	[<0>] rcu_barrier+0x1f6/0x2d0
	[<0>] ip_set_destroy+0x84/0x1d0 [ip_set]
	[<0>] nfnetlink_rcv_msg+0x2ac/0x2f0 [nfnetlink]
	[<0>] netlink_rcv_skb+0x57/0x100
	[<0>] netlink_unicast+0x19a/0x280
	[<0>] netlink_sendmsg+0x250/0x4d0
	[<0>] __sys_sendto+0x1be/0x1d0
	[<0>] __x64_sys_sendto+0x20/0x30
	[<0>] do_syscall_64+0x42/0xf0
	[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

perf_event_open profiling show similiar call signature for rcu_call and synchronize_rcu

	ip_set_destroy(49.651% 2133/4296)
	    rcu_barrier(80.684% 1721/2133)
		wait_for_completion(79.198% 1363/1721)
		    schedule_timeout(94.864% 1293/1363)
			schedule(96.520% 1248/1293)
			    __schedule(97.436% 1216/1248)
			    preempt_count_add(0.240% 3/1248)
			    srso_return_thunk(0.160% 2/1248)
			    preempt_count_sub(0.160% 2/1248)
			srso_return_thunk(0.077% 1/1293)
		    _raw_spin_unlock_irq(1.027% 14/1363)
		    _raw_spin_lock_irq(0.514% 7/1363)
		    __cond_resched(0.220% 3/1363)
		    srso_return_thunk(0.147% 2/1363)

	ip_set_swap(79.842% 709/888)  (this profiling was captured when synchronize_rcu is used in ip_set_swap)
	    synchronize_rcu(74.330% 527/709)
		__wait_rcu_gp(89.184% 470/527)
		    wait_for_completion(86.383% 406/470)
			schedule_timeout(91.133% 370/406)
			    schedule(95.135% 352/370)
			_raw_spin_unlock_irq(3.202% 13/406)
			_raw_spin_lock_irq(0.739% 3/406)
			srso_return_thunk(0.246% 1/406)
		    _raw_spin_unlock_irq(7.021% 33/470)
		    __call_rcu_common.constprop.0(3.830% 18/470)
		rcu_gp_is_expedited(3.036% 16/527)
		__cond_resched(0.569% 3/527)
		srso_return_thunk(0.190% 1/527)

They all call wait_for_completion, which may sleep on something on purpose, I guess...(Maybe rcu is not a good choice here?)


I made another test with 'synchronize_rcu' removed from ip_set_swap and no 'call_rcu' in ip_set_destroy, the performance is much better:
	$ time sudo ./stressipset 

	real	0m2.203s
	user	0m0.037s
	sys	0m0.188s


Here is my test code, it is very ugly...(I have no knowledge of netfilter messaging protocol, and just hack it out with the help of strace.)
And I was lazy, before run the test, foo/bar netset is needed:

	ipset create foo hash:net
	ipset create bar hash:net

Here come the ugly code, should be able to compile with gcc.

	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/types.h>
	#include <sys/socket.h>
	#include <unistd.h>
	#include <arpa/inet.h>
	#include <linux/netlink.h>
	#include <linux/netfilter/nfnetlink.h>
	#include <linux/netfilter/ipset/ip_set.h>
	#include <string.h>

	unsigned char mbuffer[4096];
	unsigned char buf[128]; // cmd buffer  for swap
	unsigned char dbuf[128]; // cmd buffer for destroy
	unsigned char cbuf[128]; // cmd buffer for create
	unsigned char abuf[128]; // cmd buffer for add
	int main() {
		int err;
		int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
		if (sock<0) {
			perror("Fail to create socket");
			return 1;
		}
		struct sockaddr_nl addr = {
			.nl_family = AF_NETLINK,
			.nl_pad = 0,
			.nl_pid = 0,
			.nl_groups = 0
		};
		struct sockaddr raddr = {0};
		socklen_t rsize;
		int seq = 0x12345678;
		err = bind(sock, (struct sockaddr*)&addr, sizeof(addr));
		if (err) {
			perror("Fail to bind");
			return 1;
		}
		err = getsockname(sock, &raddr, &rsize);
		if (err) {
			perror("Fail to getsockname");
			return 1;
		}
		struct nlmsghdr *phdr;
		struct nfgenmsg *pnfg;
		struct nlattr *pnla;
		unsigned int total;
		ssize_t rz;
		struct iovec iovs;
		iovs.iov_base = mbuffer;
		iovs.iov_len = sizeof(mbuffer);
		struct msghdr msg = {0};
		msg.msg_name = &addr;
		msg.msg_namelen = sizeof(addr);
		msg.msg_iov = &iovs;
		msg.msg_iovlen = 1;

		memset(buf, 0, sizeof(buf));
		total = 0;
		phdr = (struct nlmsghdr*)(buf+total);
		total += sizeof(struct nlmsghdr);
		phdr->nlmsg_type=NFNL_SUBSYS_IPSET<<8|IPSET_CMD_PROTOCOL;
		phdr->nlmsg_seq = seq;
		phdr->nlmsg_flags = NLM_F_REQUEST;
		pnfg = (struct nfgenmsg*)(buf+total);
		total += sizeof(struct nfgenmsg);
		pnfg->nfgen_family=AF_INET;
		pnfg->version= NFNETLINK_V0;
		pnfg->res_id=htons(0);
		pnla = (struct nlattr *)(buf+total);
		pnla->nla_len = 5;
		pnla->nla_type = 1;
		buf[total+sizeof(struct nlattr)]=0x06;
		total+=8;
		phdr->nlmsg_len = total;
		rz = sendto(sock, buf, total, 0, (struct sockaddr*)&addr, sizeof(addr));
		rz = recvmsg(sock, &msg, 0);

		int sz = total;
		// build swap
		pnla = (struct nlattr *)(buf+total);
		pnla->nla_len = 8;
		pnla->nla_type = 2;
		char *p = buf+(total+sizeof(struct nlattr));
		p[0]='f'; p[1]='o'; p[2]='o'; p[3]=0;
		total+=8;
		pnla = (struct nlattr *)(buf+total);
		pnla->nla_len = 8;
		pnla->nla_type = 3;
		p = buf+(total+sizeof(struct nlattr));
		p[0]='b'; p[1]='a'; p[2]='r'; p[3]=0;
		total+=8;
		phdr->nlmsg_type = NFNL_SUBSYS_IPSET<<8|IPSET_CMD_SWAP;
		phdr->nlmsg_flags = NLM_F_REQUEST|NLM_F_ACK;
		phdr->nlmsg_len = total;

		// build destroy
		char bar[] = "\x62\x61\x72\x00";
		memcpy(dbuf, buf, sz);
		total = sz;
		struct nlmsghdr *phdr_d = (struct nlmsghdr*)dbuf;
		pnla = (struct nlattr *)(dbuf+total);
		pnla->nla_len = 8;
		pnla->nla_type = 2;
		memcpy(dbuf+(total+sizeof(struct nlattr)), bar, sizeof(bar));
		total+=pnla->nla_len;
		phdr_d->nlmsg_type = NFNL_SUBSYS_IPSET<<8|IPSET_CMD_DESTROY;
		phdr_d->nlmsg_flags = NLM_F_REQUEST|NLM_F_ACK;
		phdr_d->nlmsg_len = total;

		// build create
		memcpy(cbuf, buf, sz);
		total = sz;
		struct nlmsghdr *phdr_c = (struct nlmsghdr*)cbuf;
		pnla = (struct nlattr *)(cbuf+total);
		pnla->nla_len = 8;
		pnla->nla_type = 2;
		memcpy(cbuf+(total+sizeof(struct nlattr)), bar, sizeof(bar));
		total+=(pnla->nla_len+3)/4*4;
		char hashnet[] = "\x68\x61\x73\x68\x3a\x6e\x65\x74\x00";
		pnla = (struct nlattr *)(cbuf+total);
		pnla->nla_len = 13;
		pnla->nla_type = 3;
		memcpy(cbuf+(total+sizeof(struct nlattr)), hashnet, sizeof(hashnet));
		total+=(pnla->nla_len+3)/4*4;
		pnla = (struct nlattr *)(cbuf+total);
		pnla->nla_len = 5;
		pnla->nla_type = 4;
		cbuf[total+sizeof(struct nlattr)]=6;
		total+=(pnla->nla_len+3)/4*4;
		pnla = (struct nlattr *)(cbuf+total);
		pnla->nla_len = 5;
		pnla->nla_type = 5;
		cbuf[total+sizeof(struct nlattr)]=2;
		total+=(pnla->nla_len+3)/4*4;
		pnla = (struct nlattr *)(cbuf+total);
		pnla->nla_len = 4;
		pnla->nla_type = NLA_F_NESTED|0x7;
		total+=(pnla->nla_len+3)/4*4;

		phdr_c->nlmsg_type = NFNL_SUBSYS_IPSET<<8|IPSET_CMD_CREATE;
		phdr_c->nlmsg_flags = NLM_F_REQUEST|NLM_F_ACK;
		phdr_c->nlmsg_len = total;

		// build add 
		memcpy(abuf, buf, sz);
		total = sz;
		struct nlmsghdr *phdr_a = (struct nlmsghdr*)abuf;
		pnla = (struct nlattr *)(abuf+total);
		pnla->nla_len = 8;
		pnla->nla_type = 2;
		memcpy(abuf+(total+sizeof(struct nlattr)), bar, sizeof(bar));
		total+=(pnla->nla_len+3)/4*4;
		char ip[] = "\x0c\x00\x01\x80\x08\x00\x01\x40\x0a\x01\x00\x00\x05\x00\x03\x00\x10\x00\x00\x00\x08\x00\x09\x40\x00\x00\x00\x00";
		pnla = (struct nlattr *)(abuf+total);
		pnla->nla_len = 32;
		pnla->nla_type = NLA_F_NESTED|0x7;
		memcpy(abuf+(total+sizeof(struct nlattr)), ip, sizeof(ip));
		total+=(pnla->nla_len+3)/4*4;
		phdr_a->nlmsg_type = NFNL_SUBSYS_IPSET<<8|IPSET_CMD_ADD;
		phdr_a->nlmsg_flags = NLM_F_REQUEST|NLM_F_ACK;
		phdr_a->nlmsg_len = total;

		
		for (int i=0; i<10000; i++) {
			// swap foo bar
			seq++;
			phdr->nlmsg_seq = seq;
			sendto(sock, buf, phdr->nlmsg_len, 0, (struct sockaddr*)&addr, sizeof(addr));
			recvmsg(sock, &msg, 0);
			err=*(short*)(mbuffer+(sizeof(struct nlmsghdr)-2)); if (err) { printf("fail to swap %d\n", err); break; }
			// destroy bar
			seq++;
			phdr_d->nlmsg_seq = seq;
			sendto(sock, dbuf, phdr_d->nlmsg_len, 0, (struct sockaddr*)&addr, sizeof(addr));
			recvmsg(sock, &msg, 0);
			err=*(short*)(mbuffer+(sizeof(struct nlmsghdr)-2)); if (err) { printf("fail to destroy\n"); break; }
			// create bar
			seq++;
			phdr_c->nlmsg_seq = seq;
			sendto(sock, cbuf, phdr_c->nlmsg_len, 0, (struct sockaddr*)&addr, sizeof(addr));
			recvmsg(sock, &msg, 0);
			err=*(short*)(mbuffer+(sizeof(struct nlmsghdr)-2)); if (err) { printf("fail to create\n"); break; }
			// add bar
			seq++;
			phdr_a->nlmsg_seq = seq;
			sendto(sock, abuf, phdr_a->nlmsg_len, 0, (struct sockaddr*)&addr, sizeof(addr));
			recvmsg(sock, &msg, 0);
			err=*(short*)(mbuffer+(sizeof(struct nlmsghdr)-2)); if (err) { printf("fail to add\n"); break; }
		}

		close(sock);
		return 0;
	}


Thanks
David


