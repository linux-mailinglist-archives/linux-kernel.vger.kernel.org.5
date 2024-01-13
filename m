Return-Path: <linux-kernel+bounces-25349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92E82CE1A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EACC1C211DE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D0C5684;
	Sat, 13 Jan 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="lVUHu3iz"
Received: from smtp0-kfki.kfki.hu (smtp0-kfki.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3520610C;
	Sat, 13 Jan 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id CD147674010C;
	Sat, 13 Jan 2024 19:24:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1705170250; x=1706984651; bh=fU3zSMxyPs
	5N6FWRf4OU+oIXIA/uCyN8WF6CVbHS8Sc=; b=lVUHu3izXK68uXjlxaRhIqFrI8
	rgeVXmjV3QczwxIgjoqv3Kbb47Yhu2nAsMigMIVoNe9YTxwrZ7UyAxW/4yP2uZFH
	DMz+q5ppWf1o57t4VxPZUfVTtT1wTssXyAUBxIV0zWa+yOg//I+fnnKuB0G8Eh81
	3acxztAzhDegHBv4k=
X-Virus-Scanned: Debian amavisd-new at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
	by localhost (smtp0.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Sat, 13 Jan 2024 19:24:10 +0100 (CET)
Received: from mentat.rmki.kfki.hu (host-94-248-211-167.kabelnet.hu [94.248.211.167])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 7F5376740101;
	Sat, 13 Jan 2024 19:24:09 +0100 (CET)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id C08D175A; Sat, 13 Jan 2024 19:24:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mentat.rmki.kfki.hu (Postfix) with ESMTP id BBB68932;
	Sat, 13 Jan 2024 19:24:07 +0100 (CET)
Date: Sat, 13 Jan 2024 19:24:07 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: David Wang <00107082@163.com>
cc: ale.crismani@automattic.com, linux-kernel@vger.kernel.org, 
    netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
    xiaolinkui@kylinos.cn
Subject: Re:Performance regression in ip_set_swap on 6.7.0
In-Reply-To: <20240111145330.18474-1-00107082@163.com>
Message-ID: <d5c24887-b2d4-bcc-f5a4-bd3d2670d16@blackhole.kfki.hu>
References: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu> <20240111145330.18474-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-deepspam: dunno 30%

On Thu, 11 Jan 2024, David Wang wrote:

> I tested the patch with code stressing swap->destroy->create->add 10000 
> times, the performance regression still happens, and now it is 
> ip_set_destroy. (I pasted the test code at the end of this mail)
> time show that most delay is 'off cpu':
> 	$ time sudo ./stressipset 
> 
> 	real	2m45.115s
> 	user	0m0.019s
> 	sys	0m0.744s
> 
> Most time, callstack stuck in rcu_barrier:
> 	$ sudo cat /proc/2158/stack
> 	[<0>] rcu_barrier+0x1f6/0x2d0
> 	[<0>] ip_set_destroy+0x84/0x1d0 [ip_set]
> 	[<0>] nfnetlink_rcv_msg+0x2ac/0x2f0 [nfnetlink]
> 	[<0>] netlink_rcv_skb+0x57/0x100
> 	[<0>] netlink_unicast+0x19a/0x280
> 	[<0>] netlink_sendmsg+0x250/0x4d0
> 	[<0>] __sys_sendto+0x1be/0x1d0
> 	[<0>] __x64_sys_sendto+0x20/0x30
> 	[<0>] do_syscall_64+0x42/0xf0
> 	[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> perf_event_open profiling show similiar call signature for rcu_call and synchronize_rcu
> 
> 	ip_set_destroy(49.651% 2133/4296)
> 	    rcu_barrier(80.684% 1721/2133)
> 		wait_for_completion(79.198% 1363/1721)
> 		    schedule_timeout(94.864% 1293/1363)
> 			schedule(96.520% 1248/1293)
> 			    __schedule(97.436% 1216/1248)
> 			    preempt_count_add(0.240% 3/1248)
> 			    srso_return_thunk(0.160% 2/1248)
> 			    preempt_count_sub(0.160% 2/1248)
> 			srso_return_thunk(0.077% 1/1293)
> 		    _raw_spin_unlock_irq(1.027% 14/1363)
> 		    _raw_spin_lock_irq(0.514% 7/1363)
> 		    __cond_resched(0.220% 3/1363)
> 		    srso_return_thunk(0.147% 2/1363)
> 
> 	ip_set_swap(79.842% 709/888)  (this profiling was captured when synchronize_rcu is used in ip_set_swap)
> 	    synchronize_rcu(74.330% 527/709)
> 		__wait_rcu_gp(89.184% 470/527)
> 		    wait_for_completion(86.383% 406/470)
> 			schedule_timeout(91.133% 370/406)
> 			    schedule(95.135% 352/370)
> 			_raw_spin_unlock_irq(3.202% 13/406)
> 			_raw_spin_lock_irq(0.739% 3/406)
> 			srso_return_thunk(0.246% 1/406)
> 		    _raw_spin_unlock_irq(7.021% 33/470)
> 		    __call_rcu_common.constprop.0(3.830% 18/470)
> 		rcu_gp_is_expedited(3.036% 16/527)
> 		__cond_resched(0.569% 3/527)
> 		srso_return_thunk(0.190% 1/527)
> 
> They all call wait_for_completion, which may sleep on something on 
> purpose, I guess...

That's OK because ip_set_destroy() calls rcu_barrier() which is needed to 
handle flush in list type of sets.

However, rcu_barrier() with call_rcu() together makes multiple destroys 
one after another slow. But rcu_barrier() is needed for list type of sets 
only and that can be handled separately. So could you test the patch 
below? According to my tests it is even a little bit faster than the 
original code before synchronize_rcu() was added to swap.
  
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
index 4c133e06be1d..3bf9bb345809 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1182,6 +1182,14 @@ ip_set_destroy_set(struct ip_set *set)
 	kfree(set);
 }
 
+static void
+ip_set_destroy_set_rcu(struct rcu_head *head)
+{
+	struct ip_set *set = container_of(head, struct ip_set, rcu);
+
+	ip_set_destroy_set(set);
+}
+
 static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			  const struct nlattr * const attr[])
 {
@@ -1193,8 +1201,6 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	if (unlikely(protocol_min_failed(attr)))
 		return -IPSET_ERR_PROTOCOL;
 
-	/* Must wait for flush to be really finished in list:set */
-	rcu_barrier();
 
 	/* Commands are serialized and references are
 	 * protected by the ip_set_ref_lock.
@@ -1206,8 +1212,10 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	 * counter, so if it's already zero, we can proceed
 	 * without holding the lock.
 	 */
-	read_lock_bh(&ip_set_ref_lock);
 	if (!attr[IPSET_ATTR_SETNAME]) {
+		/* Must wait for flush to be really finished in list:set */
+		rcu_barrier();
+		read_lock_bh(&ip_set_ref_lock);
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
 			if (s && (s->ref || s->ref_netlink)) {
@@ -1228,6 +1236,9 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 		inst->is_destroyed = false;
 	} else {
 		u32 flags = flag_exist(info->nlh);
+		u16 features = 0;
+
+		read_lock_bh(&ip_set_ref_lock);
 		s = find_set_and_id(inst, nla_data(attr[IPSET_ATTR_SETNAME]),
 				    &i);
 		if (!s) {
@@ -1238,10 +1249,14 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			ret = -IPSET_ERR_BUSY;
 			goto out;
 		}
+		features = s->type->features;
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
-
-		ip_set_destroy_set(s);
+		if (features & IPSET_TYPE_NAME) {
+			/* Must wait for flush to be really finished  */
+			rcu_barrier();
+		}
+		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
 	}
 	return 0;
 out:
@@ -1394,9 +1409,6 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
-	/* Make sure all readers of the old set pointers are completed. */
-	synchronize_rcu();
-
 	return 0;
 }
 
@@ -2357,6 +2369,9 @@ ip_set_net_exit(struct net *net)
 
 	inst->is_deleted = true; /* flag for ip_set_nfnl_put */
 
+	/* Wait for call_rcu() in destroy */
+	rcu_barrier();
+
 	nfnl_lock(NFNL_SUBSYS_IPSET);
 	for (i = 0; i < inst->ip_set_max; i++) {
 		set = ip_set(inst, i);


Best regards,
Jozsef
-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

