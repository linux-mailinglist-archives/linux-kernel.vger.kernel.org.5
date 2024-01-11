Return-Path: <linux-kernel+bounces-23217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2D82A911
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A152FB249D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7230DF6D;
	Thu, 11 Jan 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="fFUPUwoo"
Received: from smtp2-kfki.kfki.hu (smtp2-kfki.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8733ED;
	Thu, 11 Jan 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 9427FCC011E;
	Thu, 11 Jan 2024 09:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1704961548; x=1706775949; bh=u0UW7/8myK
	HtJHXgBCD28a3PE9JJVEZdRgerC8yUyKI=; b=fFUPUwooXtx5lV+rugbxfhnH2I
	LkYDnO1Sf9leOmc6oeFzoXk/KTIAaJwivyJczmw5bMcZsN+5ofceSkhEjBvRV9Rx
	SNl8ZvGYJGJPM7Uz+tISp/wIJxR1xFSNQJblynHD47uxQbT050DB7bDS5IlYi6jJ
	N18KIlh+8bX1uMWvE=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Thu, 11 Jan 2024 09:25:48 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4D501CC024B;
	Thu, 11 Jan 2024 09:25:46 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id DDB2B343167; Thu, 11 Jan 2024 09:25:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id DAF74343166;
	Thu, 11 Jan 2024 09:25:46 +0100 (CET)
Date: Thu, 11 Jan 2024 09:25:46 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: David Wang <00107082@163.com>
cc: ale.crismani@automattic.com, xiaolinkui@kylinos.cn, 
    Pablo Neira Ayuso <pablo@netfilter.org>, linux-kernel@vger.kernel.org, 
    netfilter-devel@vger.kernel.org
Subject: Re: Performance regression in ip_set_swap on 6.1.69
In-Reply-To: <956ec7cd-16ef-7f72-dad8-dfa2ec5f4d77@netfilter.org>
Message-ID: <0d0b1526-6189-fd0f-747e-cb803936b20a@blackhole.kfki.hu>
References: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com> <20240110102342.4978-1-00107082@163.com> <a4dfc3d9-f028-7ab4-c3a7-11dcbb12e377@netfilter.org> <661cb613.7974.18cf30c4a42.Coremail.00107082@163.com>
 <956ec7cd-16ef-7f72-dad8-dfa2ec5f4d77@netfilter.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Wed, 10 Jan 2024, Jozsef Kadlecsik wrote:

> On Wed, 10 Jan 2024, David Wang wrote:
> 
> > At 2024-01-10 18:35:02, "Jozsef Kadlecsik" <kadlec@netfilter.org> wrote:
> > >On Wed, 10 Jan 2024, David Wang wrote:
> > >
> > >> I confirmed this on 6.7 that this was introduced by commit 
> > >> 28628fa952fefc7f2072ce6e8016968cc452b1ba with following changes:
> > >> 
> > >> 	 static inline void
> > >> 	@@ -1397,6 +1394,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
> > >> 		ip_set(inst, to_id) = from;
> > >> 		write_unlock_bh(&ip_set_ref_lock);
> > >> 	 
> > >> 	+       /* Make sure all readers of the old set pointers are completed. */
> > >> 	+       synchronize_rcu();
> > >> 	+
> > >> 		return 0;
> > >> 	 }
> > >> 
> > >> synchronize_rcu causes the delay, and its usage here is very confusing, 
> > >> there is no reclaimer code after it.
> > >
> > >As I'm seeing just the end of the discussion, please send a full report of 
> > >the problem and how to reproduce it.
> > >
> > 
> > This was reported in 
> > https://lore.kernel.org/lkml/C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com/ 
> > by ale.crismani@automattic.com Just out of interest of performance 
> > issues, I tried to reproduce it with a test stressing ipset_swap:
> > 
> > My test code is as following, it would stress swapping ipset 'foo' with 
> > 'bar'; (foo/bar ipset needs to be created before the test.) With latest 
> > 6.7, the stress would take about 180 seconds to finish, but with 
> > `synchronize_rcu` removed, it only took 3seconds.
> > 
> > 
> > ```
> > unsigned char mbuffer[4096];
> > int main() {
> > 	int err;
> > 	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
> > 	if (sock<0) {
> > 		perror("Fail to create socket");
> > 		return 1;
> > 	}
> > 	struct sockaddr_nl addr = {
> > 		.nl_family = AF_NETLINK,
> > 		.nl_pad = 0,
> > 		.nl_pid = 0,
> > 		.nl_groups = 0
> > 	};
> > 	struct sockaddr raddr = {0};
> > 	socklen_t rsize;
> > 	int seq = 0x12345678;
> > 	err = bind(sock, (struct sockaddr*)&addr, sizeof(addr));
> > 	if (err) {
> > 		perror("Fail to bind");
> > 		return 1;
> > 	}
> > 	err = getsockname(sock, &raddr, &rsize);
> > 	if (err) {
> > 		perror("Fail to getsockname");
> > 		return 1;
> > 	}
> > 	unsigned char buf[64];
> > 	struct nlmsghdr *phdr;
> > 	struct nfgenmsg *pnfg;
> > 	struct nlattr *pnla;
> > 	unsigned int total;
> > 	ssize_t rz;
> > 	struct iovec iovs;
> > 	iovs.iov_base = mbuffer;
> > 	iovs.iov_len = sizeof(mbuffer);
> > 	struct msghdr msg = {0};
> > 	msg.msg_name = &addr;
> > 	msg.msg_namelen = sizeof(addr);
> > 	msg.msg_iov = &iovs;
> > 	msg.msg_iovlen = 1;
> > 
> > 	memset(buf, 0, sizeof(buf));
> > 	total = 0;
> > 	phdr = (struct nlmsghdr*)(buf+total);
> > 	total += sizeof(struct nlmsghdr);
> > 	phdr->nlmsg_type=NFNL_SUBSYS_IPSET<<8|IPSET_CMD_PROTOCOL;
> > 	phdr->nlmsg_seq = seq;
> > 	phdr->nlmsg_flags = NLM_F_REQUEST;
> > 	pnfg = (struct nfgenmsg*)(buf+total);
> > 	total += sizeof(struct nfgenmsg);
> > 	pnfg->nfgen_family=AF_INET;
> >     	pnfg->version= NFNETLINK_V0;
> > 	pnfg->res_id=htons(0);
> > 	pnla = (struct nlattr *)(buf+total);
> > 	pnla->nla_len = 5;
> > 	pnla->nla_type = 1;
> > 	buf[total+sizeof(struct nlattr)]=0x06;
> > 	total+=8;
> > 	phdr->nlmsg_len = total;
> > 	rz = sendto(sock, buf, total, 0, (struct sockaddr*)&addr, sizeof(addr));
> > 	rz = recvmsg(sock, &msg, 0);
> > 
> > 	pnla = (struct nlattr *)(buf+total);
> > 	pnla->nla_len = 8;
> > 	pnla->nla_type = 2;
> > 	char *p = buf+(total+sizeof(struct nlattr));
> > 	p[0]='f'; p[1]='o'; p[2]='o'; p[3]=0;
> > 	total+=8;
> > 	pnla = (struct nlattr *)(buf+total);
> > 	pnla->nla_len = 8;
> > 	pnla->nla_type = 3;
> > 	p = buf+(total+sizeof(struct nlattr));
> > 	p[0]='b'; p[1]='a'; p[2]='r'; p[3]=0;
> > 	total+=8;
> > 	phdr->nlmsg_type = NFNL_SUBSYS_IPSET<<8|IPSET_CMD_SWAP;
> > 	phdr->nlmsg_flags = NLM_F_REQUEST|NLM_F_ACK;
> > 	phdr->nlmsg_len = total;
> > 
> > 	
> > 	for (int i=0; i<10000; i++) {
> > 		// stress swap foo bar
> > 		phdr->nlmsg_seq++;
> > 		sendto(sock, buf, total, 0, (struct sockaddr*)&addr, sizeof(addr));
> > 		recvmsg(sock, &msg, 0);
> > 	}
> > 
> > 	close(sock);
> > 	return 0;
> > }
> > ```
> 
> Thanks, I'll look into it. The race condition fix between swap/destroy and 
> kernel side add/del/test had several versions, either penalizing destroy 
> or swap. Finally swap seemed to be the less intrusive. I'm going to 
> explore other possibilities.

Could you check that the patch below fixes the performance regression? 
Instead of waiting for the RCU grace period at swapping, call_rcu() is 
used at destroying the set.

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index e8c350a3ade1..912f750d0bea 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -242,6 +242,8 @@ extern void ip_set_type_unregister(struct ip_set_type *set_type);
 
 /* A generic IP set */
 struct ip_set {
+	/* For call_cru in destroy */
+	struct rcu_head rcu;
 	/* The name of the set */
 	char name[IPSET_MAXNAMELEN];
 	/* Lock protecting the set data */
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 4c133e06be1d..cd95f75dd720 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1009,6 +1009,14 @@ find_set(struct ip_set_net *inst, const char *name)
 	return find_set_and_id(inst, name, &id);
 }
 
+static void
+ip_set_destroy_set_rcu(struct rcu_head *head)
+{
+	struct ip_set *set = container_of(head, struct ip_set, rcu);
+
+	ip_set_destroy_set(set);
+}
+
 static int
 find_free_id(struct ip_set_net *inst, const char *name, ip_set_id_t *index,
 	     struct ip_set **set)
@@ -1241,7 +1249,7 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
 
-		ip_set_destroy_set(s);
+		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
 	}
 	return 0;
 out:
@@ -1394,9 +1402,6 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
-	/* Make sure all readers of the old set pointers are completed. */
-	synchronize_rcu();
-
 	return 0;
 }
 

Best regards,
Jozsef
-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

