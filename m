Return-Path: <linux-kernel+bounces-22487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B3829E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A921F231B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16C4CB4C;
	Wed, 10 Jan 2024 16:23:01 +0000 (UTC)
Received: from smtp2-kfki.kfki.hu (smtp2-kfki.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F74CB3D;
	Wed, 10 Jan 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=netfilter.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 0089DCC0120;
	Wed, 10 Jan 2024 17:14:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Wed, 10 Jan 2024 17:14:30 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 17D41CC011E;
	Wed, 10 Jan 2024 17:14:30 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 11436343167; Wed, 10 Jan 2024 17:14:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id 0F06C343166;
	Wed, 10 Jan 2024 17:14:30 +0100 (CET)
Date: Wed, 10 Jan 2024 17:14:30 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: David Wang <00107082@163.com>
cc: ale.crismani@automattic.com, xiaolinkui@kylinos.cn, pablo@netfilter.org, 
    linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: Performance regression in ip_set_swap on 6.1.69
In-Reply-To: <661cb613.7974.18cf30c4a42.Coremail.00107082@163.com>
Message-ID: <956ec7cd-16ef-7f72-dad8-dfa2ec5f4d77@netfilter.org>
References: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com> <20240110102342.4978-1-00107082@163.com> <a4dfc3d9-f028-7ab4-c3a7-11dcbb12e377@netfilter.org> <661cb613.7974.18cf30c4a42.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Wed, 10 Jan 2024, David Wang wrote:

> At 2024-01-10 18:35:02, "Jozsef Kadlecsik" <kadlec@netfilter.org> wrote:
> >On Wed, 10 Jan 2024, David Wang wrote:
> >
> >> I confirmed this on 6.7 that this was introduced by commit 
> >> 28628fa952fefc7f2072ce6e8016968cc452b1ba with following changes:
> >> 
> >> 	 static inline void
> >> 	@@ -1397,6 +1394,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
> >> 		ip_set(inst, to_id) = from;
> >> 		write_unlock_bh(&ip_set_ref_lock);
> >> 	 
> >> 	+       /* Make sure all readers of the old set pointers are completed. */
> >> 	+       synchronize_rcu();
> >> 	+
> >> 		return 0;
> >> 	 }
> >> 
> >> synchronize_rcu causes the delay, and its usage here is very confusing, 
> >> there is no reclaimer code after it.
> >
> >As I'm seeing just the end of the discussion, please send a full report of 
> >the problem and how to reproduce it.
> >
> 
> This was reported in 
> https://lore.kernel.org/lkml/C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com/ 
> by ale.crismani@automattic.com Just out of interest of performance 
> issues, I tried to reproduce it with a test stressing ipset_swap:
> 
> My test code is as following, it would stress swapping ipset 'foo' with 
> 'bar'; (foo/bar ipset needs to be created before the test.) With latest 
> 6.7, the stress would take about 180 seconds to finish, but with 
> `synchronize_rcu` removed, it only took 3seconds.
> 
> 
> ```
> unsigned char mbuffer[4096];
> int main() {
> 	int err;
> 	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
> 	if (sock<0) {
> 		perror("Fail to create socket");
> 		return 1;
> 	}
> 	struct sockaddr_nl addr = {
> 		.nl_family = AF_NETLINK,
> 		.nl_pad = 0,
> 		.nl_pid = 0,
> 		.nl_groups = 0
> 	};
> 	struct sockaddr raddr = {0};
> 	socklen_t rsize;
> 	int seq = 0x12345678;
> 	err = bind(sock, (struct sockaddr*)&addr, sizeof(addr));
> 	if (err) {
> 		perror("Fail to bind");
> 		return 1;
> 	}
> 	err = getsockname(sock, &raddr, &rsize);
> 	if (err) {
> 		perror("Fail to getsockname");
> 		return 1;
> 	}
> 	unsigned char buf[64];
> 	struct nlmsghdr *phdr;
> 	struct nfgenmsg *pnfg;
> 	struct nlattr *pnla;
> 	unsigned int total;
> 	ssize_t rz;
> 	struct iovec iovs;
> 	iovs.iov_base = mbuffer;
> 	iovs.iov_len = sizeof(mbuffer);
> 	struct msghdr msg = {0};
> 	msg.msg_name = &addr;
> 	msg.msg_namelen = sizeof(addr);
> 	msg.msg_iov = &iovs;
> 	msg.msg_iovlen = 1;
> 
> 	memset(buf, 0, sizeof(buf));
> 	total = 0;
> 	phdr = (struct nlmsghdr*)(buf+total);
> 	total += sizeof(struct nlmsghdr);
> 	phdr->nlmsg_type=NFNL_SUBSYS_IPSET<<8|IPSET_CMD_PROTOCOL;
> 	phdr->nlmsg_seq = seq;
> 	phdr->nlmsg_flags = NLM_F_REQUEST;
> 	pnfg = (struct nfgenmsg*)(buf+total);
> 	total += sizeof(struct nfgenmsg);
> 	pnfg->nfgen_family=AF_INET;
>     	pnfg->version= NFNETLINK_V0;
> 	pnfg->res_id=htons(0);
> 	pnla = (struct nlattr *)(buf+total);
> 	pnla->nla_len = 5;
> 	pnla->nla_type = 1;
> 	buf[total+sizeof(struct nlattr)]=0x06;
> 	total+=8;
> 	phdr->nlmsg_len = total;
> 	rz = sendto(sock, buf, total, 0, (struct sockaddr*)&addr, sizeof(addr));
> 	rz = recvmsg(sock, &msg, 0);
> 
> 	pnla = (struct nlattr *)(buf+total);
> 	pnla->nla_len = 8;
> 	pnla->nla_type = 2;
> 	char *p = buf+(total+sizeof(struct nlattr));
> 	p[0]='f'; p[1]='o'; p[2]='o'; p[3]=0;
> 	total+=8;
> 	pnla = (struct nlattr *)(buf+total);
> 	pnla->nla_len = 8;
> 	pnla->nla_type = 3;
> 	p = buf+(total+sizeof(struct nlattr));
> 	p[0]='b'; p[1]='a'; p[2]='r'; p[3]=0;
> 	total+=8;
> 	phdr->nlmsg_type = NFNL_SUBSYS_IPSET<<8|IPSET_CMD_SWAP;
> 	phdr->nlmsg_flags = NLM_F_REQUEST|NLM_F_ACK;
> 	phdr->nlmsg_len = total;
> 
> 	
> 	for (int i=0; i<10000; i++) {
> 		// stress swap foo bar
> 		phdr->nlmsg_seq++;
> 		sendto(sock, buf, total, 0, (struct sockaddr*)&addr, sizeof(addr));
> 		recvmsg(sock, &msg, 0);
> 	}
> 
> 	close(sock);
> 	return 0;
> }
> ```

Thanks, I'll look into it. The race condition fix between swap/destroy and 
kernel side add/del/test had several versions, either penalizing destroy 
or swap. Finally swap seemed to be the less intrusive. I'm going to 
explore other possibilities.

Best regards,
Jozsef
-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

