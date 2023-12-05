Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AB2805F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbjLEUET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjLEUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:04:17 -0500
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D880D3;
        Tue,  5 Dec 2023 12:04:18 -0800 (PST)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 8D69412145;
        Tue,  5 Dec 2023 22:04:14 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 6FDCC12141;
        Tue,  5 Dec 2023 22:04:14 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 72A0E3C07A6;
        Tue,  5 Dec 2023 22:04:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1701806650; bh=if1Au3Kso4PtgZ57NDHCm02PEXoug0YVljYgQd8OzWQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=B0IBC/nIZXtL9KHKzUyJ7BlNnglk6F9O9cnl3ewq9/h4u7ALYJ49kB9FRZ2Te8ui/
         FfJPGx3HqEpigMUfUXXlo202GPsJX0KPAbyCT6WhI3Z2e9X4/A6BA5C/FtWuImxQFh
         rZNAb63WleoaThHHB55qN+unp9AOCFlBgYWeof8w=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 3B5K3wWa090794;
        Tue, 5 Dec 2023 22:04:00 +0200
Date:   Tue, 5 Dec 2023 22:03:58 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     Lev Pantiukhin <kndrvt@yandex-team.ru>
cc:     mitradir@yandex-team.ru, Simon Horman <horms@verge.net.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: add a stateless type of service and a stateless
 Maglev hashing scheduler
In-Reply-To: <20231204152020.472247-1-kndrvt@yandex-team.ru>
Message-ID: <0344ba18-86a4-5014-2046-7c89800195b3@ssi.bg>
References: <20231204152020.472247-1-kndrvt@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811672-652719853-1701795658=:4899"
Content-ID: <d8852bad-3f8e-27d0-bff2-c213cb1c2ffd@ssi.bg>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-652719853-1701795658=:4899
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <108ad218-8a19-ab62-e507-7e0a84f6355d@ssi.bg>


	Hello,

On Mon, 4 Dec 2023, Lev Pantiukhin wrote:

> Maglev Hashing Stateless
> ========================
> 
> Introduction
> ------------
> 
> This patch to Linux kernel provides the following changes to IPVS:
> 
> 1. Adds a new type (IP_VS_SVC_F_STATELESS) of scheduler that computes the
> need for connection entry addition;

	I see the intention to avoid keeping connections.
IPVS still creates connection struct for every packet for the 
IP_VS_CONN_F_ONE_PACKET mode but I'm not sure if this is faster than
keeping conns in hash table. You probably have stats for this.

> 2. Adds a new mhs (Maglev Hashing Stateless) scheduler based on the mh
> scheduler that implements a new algorithm (more details below);
> 3. Adds scheduling for ACK packets;
> 4. Adds destination sorting (more details below).
> 
> This approach shows a significant reduction in CPU usage, even in the
> case of 10% of endpoints constantly flapping. It also makes the L4

	It is crucial what strategy is used to deactivate dests.
MH with setting weight to 0 should not change the lookup table.
But add/remove always lead to problems.

> balancer less vulnerable to DDoS activity.
> 
> The Description of a New Algorithm
> ----------------------------------
> 
> This patch provides a modified version of the Maglev consistent hashing
> scheduling algorithm (scheduler mh). It simultaneously uses two hash
> tables instead of one. One of them is for old destinations, and the other
> (the candidate table) is for new ones. A hash key corresponds to two
> destinations, and if both hash tables point to the same destination, then
> the hash key is called stable; otherwise, it is called unstable. A new
> connection entry is created only in the event of an unstable hash key;
> otherwise, the packet goes through stateless processing. If the hash key
> is unstable:
> 
> * In the case of a SYN packet, it will pick up the destination from the
> newer (candidate) hash table;
> * In the case of an ACK packet, it will use the old hash table.
> 
> Upon changing the set of destinations, mhs populates a new candidate hash
> table and initializes a timer equal to the TCP session timeout. When the
> timer expires, the candidate hash table value is merged into the old hash
> table, and the corresponding hash key again becomes stable. If there are
> changes in the destinations before the timer expires, mhs overwrites the
> candidate hash table without the timer reset. If the set of destinations
> is unchanged, the connection tracking table will be empty.
> 
> IPVS stores destinations in an unordered way, so the same destination set
> may generate different hash tables. To guarantee proper generation of the
> Maglev hash table, the sorting of the destination list was added. This is
> important in the case of destination flaps, which return the candidate
> hash table to its original state. This patch implements sorting via
> simple insertion with linear complexity. However, this complexity may be
> simplified.
> 
> Signed-off-by: Lev Pantiukhin <kndrvt@yandex-team.ru>
> ---
>  include/net/ip_vs.h                  |   6 +
>  include/uapi/linux/ip_vs.h           |   1 +
>  net/netfilter/ipvs/Kconfig           |   9 +
>  net/netfilter/ipvs/Makefile          |   1 +
>  net/netfilter/ipvs/ip_vs_core.c      |  34 +-
>  net/netfilter/ipvs/ip_vs_ctl.c       |  54 +-
>  net/netfilter/ipvs/ip_vs_mhs.c       | 740 +++++++++++++++++++++++++++
>  net/netfilter/ipvs/ip_vs_proto_tcp.c |  18 +-
>  8 files changed, 851 insertions(+), 12 deletions(-)
>  create mode 100644 net/netfilter/ipvs/ip_vs_mhs.c
> 

> diff --git a/include/uapi/linux/ip_vs.h b/include/uapi/linux/ip_vs.h
> index 1ed234e7f251..cc205c1c796c 100644
> --- a/include/uapi/linux/ip_vs.h
> +++ b/include/uapi/linux/ip_vs.h
> @@ -24,6 +24,7 @@
>  #define IP_VS_SVC_F_SCHED1	0x0008		/* scheduler flag 1 */
>  #define IP_VS_SVC_F_SCHED2	0x0010		/* scheduler flag 2 */
>  #define IP_VS_SVC_F_SCHED3	0x0020		/* scheduler flag 3 */
> +#define IP_VS_SVC_F_STATELESS	0x0040		/* stateless scheduling */
>  
>  #define IP_VS_SVC_F_SCHED_SH_FALLBACK	IP_VS_SVC_F_SCHED1 /* SH fallback */
>  #define IP_VS_SVC_F_SCHED_SH_PORT	IP_VS_SVC_F_SCHED2 /* SH use port */
> diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
> index 2a3017b9c001..886b75c48551 100644
> --- a/net/netfilter/ipvs/Kconfig
> +++ b/net/netfilter/ipvs/Kconfig
> @@ -246,6 +246,15 @@ config	IP_VS_MH
>  	  If you want to compile it in kernel, say Y. To compile it as a
>  	  module, choose M here. If unsure, say N.
>  
> +config	IP_VS_MHS
> +	tristate "stateless maglev hashing scheduling"
> +	help
> +	  The usual Maglev consistent hashing scheduling algorithm provides
> +	  Google's Maglev hashing algorithm as an IPVS scheduler.
> +	  This is a modified version of maglev consistent hashing scheduling algorithm.
> +	  It simultaneously uses two hash tables instead of one.
> +	  One of them is for old destinations, and the other is for new ones.

	Looks like MHS implicitly uses the CONFIG_IP_VS_MH_TAB_INDEX
configuration. May be we should note it here.

> +
>  config	IP_VS_SED
>  	tristate "shortest expected delay scheduling"
>  	help
> diff --git a/net/netfilter/ipvs/Makefile b/net/netfilter/ipvs/Makefile
> index bb5d8125c82a..ffe9977397e0 100644
> --- a/net/netfilter/ipvs/Makefile
> +++ b/net/netfilter/ipvs/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_IP_VS_LBLCR) += ip_vs_lblcr.o
>  obj-$(CONFIG_IP_VS_DH) += ip_vs_dh.o
>  obj-$(CONFIG_IP_VS_SH) += ip_vs_sh.o
>  obj-$(CONFIG_IP_VS_MH) += ip_vs_mh.o
> +obj-$(CONFIG_IP_VS_MHS) += ip_vs_mhs.o
>  obj-$(CONFIG_IP_VS_SED) += ip_vs_sed.o
>  obj-$(CONFIG_IP_VS_NQ) += ip_vs_nq.o
>  obj-$(CONFIG_IP_VS_TWOS) += ip_vs_twos.o
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index a2c16b501087..6aaf762c0a1d 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -449,6 +449,7 @@ ip_vs_schedule(struct ip_vs_service *svc, struct sk_buff *skb,
>  	__be16 _ports[2], *pptr, cport, vport;
>  	const void *caddr, *vaddr;
>  	unsigned int flags;
> +	bool need_state;
>  
>  	*ignored = 1;
>  	/*
> @@ -525,7 +526,11 @@ ip_vs_schedule(struct ip_vs_service *svc, struct sk_buff *skb,
>  	if (sched) {
>  		/* read svc->sched_data after svc->scheduler */
>  		smp_rmb();
> -		dest = sched->schedule(svc, skb, iph);
> +		/* we use distinct handler for stateless service */
> +		if (svc->flags & IP_VS_SVC_F_STATELESS)

	Sometimes scheduler can be changed for svc, we should see
if this should be per-scheduler flag somewhere in struct ip_vs_scheduler
or simply to check for present schedule_sl. But probably in the end, it
should go as a svc flag as you use it now.

> +			dest = sched->schedule_sl(svc, skb, iph, &need_state);
> +		else
> +			dest = sched->schedule(svc, skb, iph);
>  	} else {
>  		dest = NULL;
>  	}
> @@ -534,9 +539,11 @@ ip_vs_schedule(struct ip_vs_service *svc, struct sk_buff *skb,
>  		return NULL;
>  	}
>  
> -	flags = (svc->flags & IP_VS_SVC_F_ONEPACKET
> -		 && iph->protocol == IPPROTO_UDP) ?
> -		IP_VS_CONN_F_ONE_PACKET : 0;
> +	/* We use IP_VS_SVC_F_ONEPACKET flag to create no state */
> +	flags = ((svc->flags & IP_VS_SVC_F_ONEPACKET &&
> +		  iph->protocol == IPPROTO_UDP) ||
> +		 (svc->flags & IP_VS_SVC_F_STATELESS && !need_state))
> +		? IP_VS_CONN_F_ONE_PACKET : 0;
>  
>  	/*
>  	 *    Create a connection entry.
> @@ -563,7 +570,10 @@ ip_vs_schedule(struct ip_vs_service *svc, struct sk_buff *skb,
>  		      IP_VS_DBG_ADDR(cp->daf, &cp->daddr), ntohs(cp->dport),
>  		      cp->flags, refcount_read(&cp->refcnt));
>  
> -	ip_vs_conn_stats(cp, svc);
> +	if (!(svc->flags & IP_VS_SVC_F_STATELESS) ||
> +	    (svc->flags & IP_VS_SVC_F_STATELESS && need_state)) {
> +		ip_vs_conn_stats(cp, svc);

	So, here we do not know if it is a new connection...
Then lets check IP_VS_HDR_NEW_CONN via new function ip_vs_iph_new_conn,
we should create it like ip_vs_iph_inverse and ip_vs_iph_icmp.
See below.

> +	}
>  	return cp;
>  }
>  
> @@ -1915,6 +1925,7 @@ ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state
>  	int ret, pkts;
>  	struct sock *sk;
>  	int af = state->pf;
> +	struct ip_vs_service *svc;
>  
>  	/* Already marked as IPVS request or reply? */
>  	if (skb->ipvs_property)
> @@ -1990,6 +2001,19 @@ ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state
>  	cp = INDIRECT_CALL_1(pp->conn_in_get, ip_vs_conn_in_get_proto,
>  			     ipvs, af, skb, &iph);
>  
> +	/* Don't use expired connection in stateless service case;
> +	 * otherwise reuse can maintain the number connection entries
> +	 */
> +	if (cp && cp->dest) {
> +		svc = rcu_dereference(cp->dest->svc);
> +
> +		if ((svc->flags & IP_VS_SVC_F_STATELESS) &&
> +		    !(timer_pending(&cp->timer) && time_after(cp->timer.expires, jiffies))) {
> +			__ip_vs_conn_put(cp);
> +			cp = NULL;
> +		}
> +	}

	Do we need special treatment here? Is it possible to see
connections that do not expire? At least, it will advance its timer
and it is impossible to see unexpired timer.

> +
>  	if (!iph.fragoffs && is_new_conn(skb, &iph) && cp) {
>  		int conn_reuse_mode = sysctl_conn_reuse_mode(ipvs);
>  		bool old_ct = false, resched = false;
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 143a341bbc0a..fda321edbd9c 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -960,6 +960,43 @@ void ip_vs_stats_free(struct ip_vs_stats *stats)
>  	}
>  }
>  
> +static int __ip_vs_mh_compare_dests(struct list_head *a, struct list_head *b)
> +{
> +	struct ip_vs_dest *dest_a = list_entry(a, struct ip_vs_dest, n_list);
> +	struct ip_vs_dest *dest_b = list_entry(b, struct ip_vs_dest, n_list);
> +	unsigned int i = 0;
> +	__be32 diff;
> +
> +	switch (dest_a->af) {
> +	case AF_INET:
> +		return (int)(dest_a->addr.ip - dest_b->addr.ip);
> +
> +	case AF_INET6:
> +		for (; i < ARRAY_SIZE(dest_a->addr.ip6); i++) {
> +			diff = dest_a->addr.ip6[i] - dest_b->addr.ip6[i];
> +			if (diff)
> +				return (int)diff;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct list_head *
> +__ip_vs_find_insertion_place(struct list_head *new, struct list_head *head)
> +{
> +	struct list_head *p = head;
> +	int ret;
> +
> +	while ((p = p->next) != head) {
> +		ret = __ip_vs_mh_compare_dests(new, p);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return p->prev;
> +}
> +
>  /*
>   *	Update a destination in the given service
>   */
> @@ -1038,7 +1075,10 @@ __ip_vs_update_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest,
>  	spin_unlock_bh(&dest->dst_lock);
>  
>  	if (add) {
> -		list_add_rcu(&dest->n_list, &svc->destinations);
> +		/* sorting of dests list */
> +		list_add_rcu(&dest->n_list,
> +			     __ip_vs_find_insertion_place(&dest->n_list,
> +							  &svc->destinations));

	About the sorting of dests. There is no guarantee that sorting
prevents hash mismatch on reconfiguration. In MH, ip_vs_mh_permutate()
independently calculates primary offset for every dest (ds->perm)
and later ip_vs_mh_populate() walks all dests in the order they are
added (probably reverse order). Every dest gets chance to occupy
primary slots in the table based on its weight. As the hash functions
often result in collision, the next dests in the list has less chance
to occupy their primary slots.

	So, the strategy of admin should be newly added dests to
be considered last in the list. If list is sorted, this even complicates
the addition of new servers because if they are inserted in the
middle of the list they will disturb the hashing for the next dests
in the list.

	In any case, the adding/deleting of dest is considered a
disturbing operation for MH but MH allowed weight to be safely changed
to 0 without reordering the lookup table, thanks to last_weight.

	In short, with sorting or no, it is enough to add the dests
in the same order to duplicate the lookup table on reconfiguration.
Sorting helps only if we add dests by hand in different order.
Or may be I'm wrong?

>  		svc->num_dests++;
>  		sched = rcu_dereference_protected(svc->scheduler, 1);
>  		if (sched && sched->add_dest)
> @@ -1276,7 +1316,9 @@ static void __ip_vs_unlink_dest(struct ip_vs_service *svc,
>  				struct ip_vs_dest *dest,
>  				int svcupd)
>  {
> -	dest->flags &= ~IP_VS_DEST_F_AVAILABLE;
> +	/* dest must be available from trash for stateless service */
> +	if (!(svc->flags & IP_VS_SVC_F_STATELESS))
> +		dest->flags &= ~IP_VS_DEST_F_AVAILABLE;

	Not nice, see below

>  
>  	/*
>  	 *  Remove it from the d-linked destination list.
> @@ -1440,6 +1482,10 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
>  	svc->port = u->port;
>  	svc->fwmark = u->fwmark;
>  	svc->flags = u->flags & ~IP_VS_SVC_F_HASHED;
> +	if (!strcmp(u->sched_name, "mhs")) {
> +		svc->flags |= IP_VS_SVC_F_STATELESS;
> +		svc->flags &= ~IP_VS_SVC_F_PERSISTENT;
> +	}

	Should be part of ip_vs_mhs_init_svc, we can return -EINVAL
there if IP_VS_SVC_F_PERSISTENT is set. Or to avoid stateless mode
in such case with all consequences:

	if (!(svc->flags & IP_VS_SVC_F_PERSISTENT))
		svc->flags |= IP_VS_SVC_F_STATELESS;

	Can we work in different mode if we can not set 
IP_VS_SVC_F_STATELESS due to some flags?

	But in any case ip_vs_mhs_done_svc() should clear 
IP_VS_SVC_F_STATELESS because ip_vs_edit_service() can be
changing the scheduler.

>  	svc->timeout = u->timeout * HZ;
>  	svc->netmask = u->netmask;
>  	svc->ipvs = ipvs;
> @@ -1578,6 +1624,10 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
>  	 * Set the flags and timeout value
>  	 */
>  	svc->flags = u->flags | IP_VS_SVC_F_HASHED;
> +	if (!strcmp(u->sched_name, "mhs")) {
> +		svc->flags |= IP_VS_SVC_F_STATELESS;
> +		svc->flags &= ~IP_VS_SVC_F_PERSISTENT;
> +	}

	Will be done in ip_vs_mhs_init_svc

>  	svc->timeout = u->timeout * HZ;
>  	svc->netmask = u->netmask;
>  
> diff --git a/net/netfilter/ipvs/ip_vs_mhs.c b/net/netfilter/ipvs/ip_vs_mhs.c
> new file mode 100644
> index 000000000000..ab19ac0f5b02
> --- /dev/null
> +++ b/net/netfilter/ipvs/ip_vs_mhs.c
> @@ -0,0 +1,740 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* IPVS:	Stateless Maglev Hashing scheduling module
> + *
> + * Authors:	Lev Pantiukhin <kndrvt@yandex-team.ru>
> + *
> + */
> +
> +/* The mh algorithm is to assign a preference list of all the lookup
> + * table positions to each destination and populate the table with
> + * the most-preferred position of destinations. Then it is to select
> + * destination with the hash key of source IP address through looking
> + * up a the lookup table.
> + * The mhs algorithm is modificated stateless version of mh algorithm.
> + * It uses 2 look up tables and chooses one of 2 destinations.
> + *
> + * The mh algorithm is detailed in:
> + * [3.4 Consistent Hasing]
> +https://www.usenix.org/system/files/conference/nsdi16/nsdi16-paper-eisenbud.pdf
> + *
> + */
> +
> +#define KMSG_COMPONENT "IPVS"
> +#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +
> +#include <linux/ip.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/skbuff.h>
> +
> +#include <net/ip_vs.h>
> +
> +#include <linux/siphash.h>
> +#include <linux/bitops.h>
> +#include <linux/gcd.h>
> +
> +#include <linux/list_sort.h>
> +
> +#define IP_VS_SVC_F_SCHED_MH_FALLBACK       IP_VS_SVC_F_SCHED1 /* MH fallback */
> +#define IP_VS_SVC_F_SCHED_MH_PORT           IP_VS_SVC_F_SCHED2 /* MH use port */
> +
> +struct ip_vs_mhs_lookup {
> +	struct ip_vs_dest __rcu    *dest;    /* real server (cache) */
> +};
> +
> +struct ip_vs_mhs_dest_setup {
> +	unsigned int offset; /* starting offset */
> +	unsigned int skip;    /* skip */
> +	unsigned int perm;    /* next_offset */
> +	int turns;    /* weight / gcd() and rshift */
> +};
> +
> +/* Available prime numbers for MH table */
> +static int primes[] = {251, 509, 1021, 2039, 4093,
> +					   8191, 16381, 32749, 65521, 131071};
> +
> +/* For IPVS MH entry hash table */
> +#ifndef CONFIG_IP_VS_MH_TAB_INDEX
> +#define CONFIG_IP_VS_MH_TAB_INDEX	12
> +#endif
> +#define IP_VS_MH_TAB_BITS		(CONFIG_IP_VS_MH_TAB_INDEX / 2)
> +#define IP_VS_MH_TAB_INDEX		(CONFIG_IP_VS_MH_TAB_INDEX - 8)
> +#define IP_VS_MH_TAB_SIZE               primes[IP_VS_MH_TAB_INDEX]
> +
> +struct ip_vs_mhs_state {
> +	struct rcu_head rcu_head;
> +	struct ip_vs_mhs_lookup *lookup;
> +	struct ip_vs_mhs_dest_setup *dest_setup;
> +	hsiphash_key_t hash1, hash2;
> +	int gcd;
> +	int rshift;
> +};
> +
> +struct ip_vs_mhs_two_states {
> +	struct ip_vs_mhs_state *first;
> +	struct ip_vs_mhs_state *second;
> +	ktime_t *timestamps;
> +	ktime_t unstable_timeout;
> +};
> +
> +struct ip_vs_mhs_two_dests {
> +	struct ip_vs_dest *dest;
> +	struct ip_vs_dest *new_dest;
> +	bool unstable;
> +};
> +
> +static inline bool
> +ip_vs_mhs_is_new_conn(const struct sk_buff *skb, struct ip_vs_iphdr *iph)
> +{
> +	switch (iph->protocol) {
> +	case IPPROTO_TCP: {
> +		struct tcphdr _tcph, *th;
> +
> +		th = skb_header_pointer(skb, iph->len, sizeof(_tcph), &_tcph);
> +		if (!th)
> +			return false;
> +		return th->syn;
> +	}
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline void
> +generate_hash_secret(hsiphash_key_t *hash1, hsiphash_key_t *hash2)
> +{
> +	hash1->key[0] = 2654435761UL;
> +	hash1->key[1] = 2654435761UL;
> +
> +	hash2->key[0] = 2654446892UL;
> +	hash2->key[1] = 2654446892UL;
> +}
> +
> +/* Returns hash value for IPVS MH entry */
> +static inline unsigned int
> +ip_vs_mhs_hashkey(int af, const union nf_inet_addr *addr, __be16 port,
> +		  hsiphash_key_t *key, unsigned int offset)
> +{
> +	unsigned int v;
> +	__be32 addr_fold = addr->ip;
> +
> +#ifdef CONFIG_IP_VS_IPV6
> +	if (af == AF_INET6)
> +		addr_fold = addr->ip6[0] ^ addr->ip6[1] ^
> +				addr->ip6[2] ^ addr->ip6[3];
> +#endif
> +	v = (offset + ntohs(port) + ntohl(addr_fold));
> +	return hsiphash(&v, sizeof(v), key);
> +}
> +
> +/* Reset all the hash buckets of the specified table. */
> +static void ip_vs_mhs_reset(struct ip_vs_mhs_state *s)
> +{
> +	int i;
> +	struct ip_vs_mhs_lookup *l;
> +	struct ip_vs_dest *dest;
> +
> +	l = &s->lookup[0];
> +	for (i = 0; i < IP_VS_MH_TAB_SIZE; i++) {
> +		dest = rcu_dereference_protected(l->dest, 1);
> +		if (dest) {
> +			ip_vs_dest_put(dest);
> +			RCU_INIT_POINTER(l->dest, NULL);
> +		}
> +		l++;
> +	}
> +}
> +
> +/* Update timestamps with new lookup table */
> +static void
> +ip_vs_mhs_update_timestamps(struct ip_vs_mhs_two_states *states)
> +{
> +	unsigned int offset = 0;
> +
> +	while (offset < IP_VS_MH_TAB_SIZE) {
> +		if (states->first->lookup[offset].dest ==
> +			states->second->lookup[offset].dest) {
> +			if (states->timestamps[offset]) {
> +				/* stabilization */
> +				states->timestamps[offset] = (ktime_t)0;
> +			}
> +		} else {
> +			if (!states->timestamps[offset]) {
> +				/* destabilization */
> +				states->timestamps[offset] = ktime_get();
> +			}
> +		}
> +		++offset;

	Can't we use jiffies? At least to call ktime_get() once?

> +	}
> +}
> +
> +static int
> +ip_vs_mhs_permutate(struct ip_vs_mhs_state *s, struct ip_vs_service *svc)
> +{
> +	struct list_head *p;
> +	struct ip_vs_mhs_dest_setup *ds;
> +	struct ip_vs_dest *dest;
> +	int lw;
> +
> +	/* If gcd is smaller then 1, number of dests or
> +	 * all weight of dests are zero. So, skip
> +	 * permutation for the dests.
> +	 */
> +	if (s->gcd < 1)
> +		return 0;
> +
> +	/* Set dest_setup for the dests permutation */
> +	p = &svc->destinations;
> +	ds = &s->dest_setup[0];
> +	while ((p = p->next) != &svc->destinations) {
> +		dest = list_entry(p, struct ip_vs_dest, n_list);
> +
> +		ds->offset = ip_vs_mhs_hashkey(svc->af, &dest->addr, dest->port,
> +					       &s->hash1, 0) %
> +			     IP_VS_MH_TAB_SIZE;
> +		ds->skip = ip_vs_mhs_hashkey(svc->af, &dest->addr, dest->port,
> +					     &s->hash2, 0) %
> +			   (IP_VS_MH_TAB_SIZE - 1) + 1;
> +		ds->perm = ds->offset;
> +
> +		lw = atomic_read(&dest->weight);
> +		ds->turns = ((lw / s->gcd) >> s->rshift) ?: (lw != 0);
> +		ds++;
> +	}
> +	return 0;
> +}
> +
> +static int
> +ip_vs_mhs_populate(struct ip_vs_mhs_state *s, struct ip_vs_service *svc)
> +{
> +	int n, c, dt_count;
> +	unsigned long *table;
> +	struct list_head *p;
> +	struct ip_vs_mhs_dest_setup *ds;
> +	struct ip_vs_dest *dest, *new_dest;
> +
> +	/* If gcd is smaller then 1, number of dests or
> +	 * all last_weight of dests are zero. So, skip
> +	 * the population for the dests and reset lookup table.
> +	 */
> +	if (s->gcd < 1) {
> +		ip_vs_mhs_reset(s);
> +		return 0;
> +	}
> +
> +	table = kcalloc(BITS_TO_LONGS(IP_VS_MH_TAB_SIZE), sizeof(unsigned long),
> +			GFP_KERNEL);

	MH uses bitmap_zalloc for this...

> +	if (!table)
> +		return -ENOMEM;
> +
> +	p = &svc->destinations;
> +	n = 0;
> +	dt_count = 0;
> +	while (n < IP_VS_MH_TAB_SIZE) {
> +		if (p == &svc->destinations)
> +			p = p->next;
> +
> +		ds = &s->dest_setup[0];
> +		while (p != &svc->destinations) {
> +			/* Ignore added server with zero weight */
> +			if (ds->turns < 1) {
> +				p = p->next;
> +				ds++;
> +				continue;
> +			}
> +
> +			c = ds->perm;
> +			while (test_bit(c, table)) {
> +				/* Add skip, mod s->tab_size */

	IP_VS_MH_TAB_SIZE, no s->tab_size

> +				ds->perm += ds->skip;
> +				if (ds->perm >= IP_VS_MH_TAB_SIZE)
> +					ds->perm -= IP_VS_MH_TAB_SIZE;
> +				c = ds->perm;
> +			}
> +
> +			__set_bit(c, table);
> +
> +			dest = rcu_dereference_protected(s->lookup[c].dest, 1);
> +			new_dest = list_entry(p, struct ip_vs_dest, n_list);
> +			if (dest != new_dest) {
> +				if (dest)
> +					ip_vs_dest_put(dest);
> +				ip_vs_dest_hold(new_dest);
> +				RCU_INIT_POINTER(s->lookup[c].dest, new_dest);
> +			}
> +
> +			if (++n == IP_VS_MH_TAB_SIZE)
> +				goto out;
> +
> +			if (++dt_count >= ds->turns) {
> +				dt_count = 0;
> +				p = p->next;
> +				ds++;
> +			}
> +		}
> +	}
> +
> +out:
> +	kfree(table);

	bitmap_free

> +	return 0;
> +}
> +
> +/* Assign all the hash buckets of the specified table with the service. */
> +static int
> +ip_vs_mhs_reassign(struct ip_vs_mhs_state *s, struct ip_vs_service *svc)
> +{
> +	int ret;
> +
> +	if (svc->num_dests > IP_VS_MH_TAB_SIZE)
> +		return -EINVAL;
> +
> +	if (svc->num_dests >= 1) {
> +		s->dest_setup = kcalloc(svc->num_dests,
> +					sizeof(struct ip_vs_mhs_dest_setup),
> +					GFP_KERNEL);
> +		if (!s->dest_setup)
> +			return -ENOMEM;
> +	}
> +
> +	ip_vs_mhs_permutate(s, svc);
> +
> +	ret = ip_vs_mhs_populate(s, svc);
> +	if (ret < 0)
> +		goto out;
> +
> +	IP_VS_DBG_BUF(6, "MHS: %s(): reassign lookup table of %s:%u\n",
> +		      __func__,
> +		      IP_VS_DBG_ADDR(svc->af, &svc->addr),
> +		      ntohs(svc->port));
> +
> +out:
> +	if (svc->num_dests >= 1) {
> +		kfree(s->dest_setup);
> +		s->dest_setup = NULL;
> +	}
> +	return ret;
> +}
> +
> +static int
> +ip_vs_mhs_gcd_weight(struct ip_vs_service *svc)
> +{
> +	struct ip_vs_dest *dest;
> +	int weight;
> +	int g = 0;
> +
> +	list_for_each_entry(dest, &svc->destinations, n_list) {
> +		weight = atomic_read(&dest->weight);
> +		if (weight > 0) {
> +			if (g > 0)
> +				g = gcd(weight, g);
> +			else
> +				g = weight;
> +		}
> +	}
> +	return g;
> +}
> +
> +/* To avoid assigning huge weight for the MH table,
> + * calculate shift value with gcd.
> + */
> +static int
> +ip_vs_mhs_shift_weight(struct ip_vs_service *svc, int gcd)
> +{
> +	struct ip_vs_dest *dest;
> +	int new_weight, weight = 0;
> +	int mw, shift;
> +
> +	/* If gcd is smaller then 1, number of dests or
> +	 * all weight of dests are zero. So, return
> +	 * shift value as zero.
> +	 */
> +	if (gcd < 1)
> +		return 0;
> +
> +	list_for_each_entry(dest, &svc->destinations, n_list) {
> +		new_weight = atomic_read(&dest->weight);
> +		if (new_weight > weight)
> +			weight = new_weight;
> +	}
> +
> +	/* Because gcd is greater than zero,
> +	 * the maximum weight and gcd are always greater than zero
> +	 */
> +	mw = weight / gcd;
> +
> +	/* shift = occupied bits of weight/gcd - MH highest bits */
> +	shift = fls(mw) - IP_VS_MH_TAB_BITS;
> +	return (shift >= 0) ? shift : 0;
> +}
> +
> +static ktime_t
> +ip_vs_mhs_get_unstable_timeout(struct ip_vs_service *svc)
> +{
> +	struct ip_vs_proto_data *pd;
> +	u64 tcp_to, tcp_fin_to;
> +
> +	pd = ip_vs_proto_data_get(svc->ipvs, IPPROTO_TCP);
> +	tcp_to = pd->timeout_table[IP_VS_TCP_S_ESTABLISHED];
> +	tcp_fin_to = pd->timeout_table[IP_VS_TCP_S_FIN_WAIT];
> +	return ns_to_ktime(jiffies64_to_nsecs(max(tcp_to, tcp_fin_to)));
> +}
> +
> +static void
> +ip_vs_mhs_state_free(struct rcu_head *head)
> +{
> +	struct ip_vs_mhs_state *s;
> +
> +	s = container_of(head, struct ip_vs_mhs_state, rcu_head);
> +	kfree(s->lookup);
> +	kfree(s);
> +}
> +
> +static int
> +ip_vs_mhs_init_svc(struct ip_vs_service *svc)
> +{
> +	struct ip_vs_mhs_state *s0, *s1;
> +	struct ip_vs_mhs_two_states *states;
> +	ktime_t *tss;
> +	int ret;

	Scheduler is assigned to virtual service in 2 cases:

- common case: new service is created, no dests

- rare case: scheduler is changed for existing service with
present dests in svc->destinations

	See when ip_vs_bind_scheduler() is called

	So, when ip_vs_mhs_init_svc() is called, for the common case,
we will build empty states->first table. As result, we will start 
initially with unstable period of 15 mins. But it is hard to tell when all
initial dests are added if we want to avoid it.

> +
> +	/* Allocate timestamps */
> +	tss = kcalloc(IP_VS_MH_TAB_SIZE, sizeof(ktime_t), GFP_KERNEL);
> +	if (!tss)
> +		return -ENOMEM;
> +
> +	/* Allocate the first MH table for this service */
> +	s0 = kzalloc(sizeof(*s0), GFP_KERNEL);
> +	if (!s0) {
> +		kfree(tss);
> +		return -ENOMEM;
> +	}
> +
> +	s0->lookup = kcalloc(IP_VS_MH_TAB_SIZE, sizeof(struct ip_vs_mhs_lookup),
> +			     GFP_KERNEL);
> +	if (!s0->lookup) {
> +		kfree(tss);
> +		kfree(s0);
> +		return -ENOMEM;
> +	}
> +
> +	generate_hash_secret(&s0->hash1, &s0->hash2);
> +	s0->gcd = ip_vs_mhs_gcd_weight(svc);
> +	s0->rshift = ip_vs_mhs_shift_weight(svc, s0->gcd);
> +
> +	IP_VS_DBG(6,
> +		  "MHS: %s(): The first lookup table (memory=%zdbytes) allocated\n",
> +		  __func__,
> +		  sizeof(struct ip_vs_mhs_lookup) * IP_VS_MH_TAB_SIZE);
> +
> +	/* Assign the first lookup table with current dests */
> +	ret = ip_vs_mhs_reassign(s0, svc);
> +	if (ret < 0) {
> +		kfree(tss);
> +		ip_vs_mhs_reset(s0);
> +		ip_vs_mhs_state_free(&s0->rcu_head);
> +		return ret;
> +	}
> +
> +	/* Allocate the second MH table for this service */
> +	s1 = kzalloc(sizeof(*s1), GFP_KERNEL);
> +	if (!s1) {
> +		kfree(tss);
> +		ip_vs_mhs_reset(s0);
> +		ip_vs_mhs_state_free(&s0->rcu_head);
> +		return -ENOMEM;
> +	}
> +	s1->lookup = kcalloc(IP_VS_MH_TAB_SIZE, sizeof(struct ip_vs_mhs_lookup),
> +			     GFP_KERNEL);
> +	if (!s1->lookup) {
> +		kfree(tss);
> +		ip_vs_mhs_reset(s0);
> +		ip_vs_mhs_state_free(&s0->rcu_head);
> +		kfree(s1);
> +		return -ENOMEM;
> +	}
> +
> +	s1->hash1 = s0->hash1;
> +	s1->hash2 = s0->hash2;
> +	s1->gcd = s0->gcd;
> +	s1->rshift = s0->rshift;
> +
> +	IP_VS_DBG(6,
> +		  "MHS: %s(): The second lookup table (memory=%zdbytes) allocated\n",
> +		  __func__,
> +		  sizeof(struct ip_vs_mhs_lookup) * IP_VS_MH_TAB_SIZE);
> +
> +	/* Assign the second lookup table with current dests */
> +	ret = ip_vs_mhs_reassign(s1, svc);
> +	if (ret < 0) {
> +		kfree(tss);
> +		ip_vs_mhs_reset(s0);
> +		ip_vs_mhs_state_free(&s0->rcu_head);
> +		ip_vs_mhs_reset(s1);
> +		ip_vs_mhs_state_free(&s1->rcu_head);

	Too much things to release, probably, a common release point
will look less risky.

> +		return ret;
> +	}
> +
> +	/* Allocate, initialize and attach states */
> +	states = kcalloc(1, sizeof(struct ip_vs_mhs_two_states), GFP_KERNEL);
> +	if (!states) {
> +		kfree(tss);
> +		ip_vs_mhs_reset(s0);
> +		ip_vs_mhs_state_free(&s0->rcu_head);
> +		ip_vs_mhs_reset(s1);
> +		ip_vs_mhs_state_free(&s1->rcu_head);
> +		return -ENOMEM;
> +	}
> +
> +	states->first = s0;
> +	states->second = s1;
> +	states->timestamps = tss;
> +	states->unstable_timeout = ip_vs_mhs_get_unstable_timeout(svc);
> +	svc->sched_data = states;
> +	return 0;
> +}
> +
> +static void
> +ip_vs_mhs_done_svc(struct ip_vs_service *svc)
> +{
> +	struct ip_vs_mhs_two_states *states = svc->sched_data;
> +
> +	kfree(states->timestamps);

	Freeing in done_svc is not RCU safe. You can call
ip_vs_mhs_reset but RCU callback should free 'states'.
And we can not run many RCU callbacks in parallel because their
execution order is not guaranteed. So, single call_rcu for
states should be used where we should free the first/second states
and also timestamps and finally 'states'.

> +
> +	/* Got to clean up the first lookup entry here */
> +	ip_vs_mhs_reset(states->first);
> +
> +	call_rcu(&states->first->rcu_head, ip_vs_mhs_state_free);
> +	IP_VS_DBG(6,
> +		  "MHS: The first MH lookup table (memory=%zdbytes) released\n",
> +		  sizeof(struct ip_vs_mhs_lookup) * IP_VS_MH_TAB_SIZE);
> +
> +	/* Got to clean up the second lookup entry here */
> +	ip_vs_mhs_reset(states->second);
> +
> +	call_rcu(&states->second->rcu_head, ip_vs_mhs_state_free);
> +	IP_VS_DBG(6,
> +		  "MHS: The second MH lookup table (memory=%zdbytes) released\n",
> +		  sizeof(struct ip_vs_mhs_lookup) * IP_VS_MH_TAB_SIZE);
> +
> +	kfree(states);
> +}
> +
> +static int
> +ip_vs_mhs_dest_changed(struct ip_vs_service *svc,
> +		       struct ip_vs_dest *dest)
> +{
> +	struct ip_vs_mhs_two_states *states = svc->sched_data;
> +	struct ip_vs_mhs_state *s1 = states->second;
> +	int ret;
> +
> +	s1->gcd = ip_vs_mhs_gcd_weight(svc);
> +	s1->rshift = ip_vs_mhs_shift_weight(svc, s1->gcd);
> +
> +	/* Assign the lookup table with the updated service */
> +	ret = ip_vs_mhs_reassign(s1, svc);
> +
> +	ip_vs_mhs_update_timestamps(states);
> +	states->unstable_timeout = ip_vs_mhs_get_unstable_timeout(svc);
> +	IP_VS_DBG(6,
> +		  "MHS: %s: set unstable timeout: %llu",
> +		  __func__,
> +		  ktime_divns(states->unstable_timeout,
> +			      NSEC_PER_SEC));
> +	return ret;
> +}
> +
> +/* Helper function to get port number */
> +static inline __be16
> +ip_vs_mhs_get_port(const struct sk_buff *skb, struct ip_vs_iphdr *iph)
> +{
> +	__be16 _ports[2], *ports;
> +
> +	/* At this point we know that we have a valid packet of some kind.
> +	 * Because ICMP packets are only guaranteed to have the first 8
> +	 * bytes, let's just grab the ports.  Fortunately they're in the
> +	 * same position for all three of the protocols we care about.
> +	 */
> +	switch (iph->protocol) {
> +	case IPPROTO_TCP:
> +	case IPPROTO_UDP:
> +	case IPPROTO_SCTP:
> +		ports = skb_header_pointer(skb, iph->len, sizeof(_ports),
> +					   &_ports);
> +		if (unlikely(!ports))
> +			return 0;
> +
> +		if (likely(!ip_vs_iph_inverse(iph)))
> +			return ports[0];
> +		else
> +			return ports[1];
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/* Get ip_vs_dest associated with supplied parameters. */
> +static inline void
> +ip_vs_mhs_get(struct ip_vs_service *svc,
> +	      struct ip_vs_mhs_two_states *states,
> +	      struct ip_vs_mhs_two_dests *dests,
> +	      const union nf_inet_addr *addr,
> +	      __be16 port)
> +{
> +	unsigned int hash;
> +	ktime_t timestamp;
> +
> +	hash = ip_vs_mhs_hashkey(svc->af, addr, port, &states->first->hash1,
> +				 0) % IP_VS_MH_TAB_SIZE;
> +	dests->dest = rcu_dereference(states->first->lookup[hash].dest);
> +	dests->new_dest = rcu_dereference(states->second->lookup[hash].dest);
> +	timestamp = states->timestamps[hash];
> +
> +	/* only unstable hashes have non-zero value */
> +	if (timestamp > 0) {
> +		/* unstable */
> +		if (timestamp + states->unstable_timeout > ktime_get()) {
> +			/* timer didn't expire */
> +			dests->unstable = true;
> +			return;
> +		}
> +		/* unstable -> stable */
> +		if (dests->dest)
> +			ip_vs_dest_put(dests->dest);
> +		if (dests->new_dest)
> +			ip_vs_dest_hold(dests->new_dest);
> +		dests->dest = dests->new_dest;
> +		RCU_INIT_POINTER(states->first->lookup[hash].dest,
> +				 dests->new_dest);
> +		states->timestamps[hash] = (ktime_t)0;

	These operations are not SMP safe, many readers may try to
switch to stable state at the same time. May be some xchg operation
for timestamps[] can help. But it also races with reconfiguration,
i.e. ip_vs_mhs_update_timestamps(), ip_vs_mhs_populate(), etc.
As it is a rare condition, spin_lock_bh(&state->lock) will help instead.
You should revalidate states->timestamps[hash] under lock.

> +	}
> +	/* stable */
> +	dests->unstable = false;
> +}
> +
> +/* Stateless Maglev Hashing scheduling */
> +static struct ip_vs_dest *
> +ip_vs_mhs_schedule(struct ip_vs_service *svc,
> +		   const struct sk_buff *skb,
> +		   struct ip_vs_iphdr *iph,
> +		   bool *need_state)
> +{
> +	struct ip_vs_mhs_two_dests dests;
> +	struct ip_vs_dest *final_dest = NULL;
> +	struct ip_vs_mhs_two_states *states = svc->sched_data;
> +	__be16 port = 0;
> +	const union nf_inet_addr *hash_addr;
> +
> +	*need_state = false;
> +	hash_addr = ip_vs_iph_inverse(iph) ? &iph->daddr : &iph->saddr;
> +
> +	if (svc->flags & IP_VS_SVC_F_SCHED_MH_PORT)
> +		port = ip_vs_mhs_get_port(skb, iph);
> +
> +	ip_vs_mhs_get(svc, states, &dests, hash_addr, port);
> +	IP_VS_DBG_BUF(6,
> +		      "MHS: %s(): source IP address %s:%u --> server %s and %s\n",
> +		      __func__,
> +		      IP_VS_DBG_ADDR(svc->af, hash_addr),
> +		      ntohs(port),
> +		      dests.dest
> +		      ? IP_VS_DBG_ADDR(dests.dest->af, &dests.dest->addr)
> +		      : "NULL",
> +		      dests.new_dest
> +		      ? IP_VS_DBG_ADDR(dests.new_dest->af,
> +				       &dests.new_dest->addr)
> +		      : "NULL");
> +
> +	if (!dests.dest && !dests.new_dest) {
> +		/* Both dests is NULL */
> +		return NULL;
> +	}
> +
> +	if (!(dests.dest && dests.new_dest)) {
> +		/* dest is NULL or new_dest is NULL,
> +		 * so we send all packets to singular available dest
> +		 * and create state
> +		 */
> +		if (dests.new_dest) {
> +			/* dest is NULL */
> +			final_dest = dests.new_dest;
> +		} else {
> +			/* new_dest is NULL */
> +			final_dest = dests.dest;

	In two cases we return dests.dest without checking
for IP_VS_DEST_F_AVAILABLE, even, you keep the flag set after dest is
removed which is not nice. If we do not want to fallback, in this case
we should return NULL, eg. for ACK. Any traffic should stop if 
!IP_VS_DEST_F_AVAILABLE and if weight=0 only established connections should
work. As for IP_VS_DEST_F_OVERLOAD, if used, it should lead to allocating
connection to fallback server, something not suitable for every scheduler.

> +		}
> +		*need_state = true;
> +		IP_VS_DBG(6,
> +			  "MHS: %s(): One dest, need_state=%s\n",
> +			  __func__,
> +			  *need_state ? "true" : "false");
> +	} else if (dests.unstable) {
> +		/* unstable */
> +		if (iph->protocol == IPPROTO_TCP) {
> +			/* TCP */
> +			*need_state = true;

	Looks like we can use iph.hdr_flags & IP_VS_HDR_NEW_CONN instead 
of ip_vs_mhs_is_new_conn. IP_VS_HDR_NEW_CONN can be set where we
call is_new_conn in ip_vs_in_hook:

	if (!iph.fragoffs && is_new_conn(skb, &iph))
		iph.hdr_flags |= IP_VS_HDR_NEW_CONN;
	if (iph.hdr_flags & IP_VS_HDR_NEW_CONN && cp) {

> +			if (ip_vs_mhs_is_new_conn(skb, iph)) {
> +				/* SYN packet */
> +				final_dest = dests.new_dest;
> +				IP_VS_DBG(6,
> +					  "MHS: %s(): Unstable, need_state=%s, SYN packet\n",
> +					  __func__,
> +					  *need_state ? "true" : "false");
> +			} else {
> +				/* Not SYN packet */
> +				final_dest = dests.dest;
> +				IP_VS_DBG(6,
> +					  "MHS: %s(): Unstable, need_state=%s, not SYN packet\n",
> +					  __func__,
> +					  *need_state ? "true" : "false");
> +			}
> +		} else if (iph->protocol == IPPROTO_UDP) {
> +			/* UDP */
> +			final_dest = dests.new_dest;
> +			IP_VS_DBG(6,
> +				  "MHS: %s(): Unstable, need_state=%s, UDP packet\n",
> +				  __func__,
> +				  *need_state ? "true" : "false");
> +		}
> +	} else {
> +		/* stable */
> +		final_dest = dests.dest;
> +		IP_VS_DBG(6,
> +			  "MHS: %s(): Stable, need_state=%s\n",
> +			  __func__,
> +			  *need_state ? "true" : "false");
> +	}
> +	return final_dest;
> +}
> +
> +/* IPVS MHS Scheduler structure */
> +static struct ip_vs_scheduler ip_vs_mhs_scheduler = {
> +	.name =                "mhs",
> +	.refcnt =        ATOMIC_INIT(0),
> +	.module =        THIS_MODULE,
> +	.n_list =        LIST_HEAD_INIT(ip_vs_mhs_scheduler.n_list),
> +	.init_service =        ip_vs_mhs_init_svc,
> +	.done_service =        ip_vs_mhs_done_svc,
> +	.add_dest =        ip_vs_mhs_dest_changed,
> +	.del_dest =        ip_vs_mhs_dest_changed,
> +	.upd_dest =        ip_vs_mhs_dest_changed,
> +	.schedule_sl =        ip_vs_mhs_schedule,
> +};
> +
> +static int __init
> +ip_vs_mhs_init(void)
> +{
> +	return register_ip_vs_scheduler(&ip_vs_mhs_scheduler);
> +}
> +
> +static void __exit
> +ip_vs_mhs_cleanup(void)
> +{
> +	unregister_ip_vs_scheduler(&ip_vs_mhs_scheduler);
> +	rcu_barrier();
> +}
> +
> +module_init(ip_vs_mhs_init);
> +module_exit(ip_vs_mhs_cleanup);
> +MODULE_DESCRIPTION("Stateless Maglev hashing ipvs scheduler");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Lev Pantiukhin <kndrvt@yandex-team.ru>");
> diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> index 7da51390cea6..31a8c1bfc863 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> @@ -38,7 +38,7 @@ tcp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
>  		  struct ip_vs_iphdr *iph)
>  {
>  	struct ip_vs_service *svc;
> -	struct tcphdr _tcph, *th;
> +	struct tcphdr _tcph, *th = NULL;
>  	__be16 _ports[2], *ports = NULL;
>  
>  	/* In the event of icmp, we're only guaranteed to have the first 8
> @@ -47,11 +47,8 @@ tcp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
>  	 */
>  	if (likely(!ip_vs_iph_icmp(iph))) {
>  		th = skb_header_pointer(skb, iph->len, sizeof(_tcph), &_tcph);
> -		if (th) {
> -			if (th->rst || !(sysctl_sloppy_tcp(ipvs) || th->syn))
> -				return 1;
> +		if (th)
>  			ports = &th->source;
> -		}
>  	} else {
>  		ports = skb_header_pointer(
>  			skb, iph->len, sizeof(_ports), &_ports);
> @@ -74,6 +71,17 @@ tcp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
>  	if (svc) {
>  		int ignored;
>  
> +		if (th) {
> +			/* If sloppy_tcp or IP_VS_SVC_F_STATELESS is true,
> +			 * all SYN packets are scheduled except packets
> +			 * with set RST flag.
> +			 */
> +			if (!sysctl_sloppy_tcp(ipvs) &&
> +			    !(svc->flags & IP_VS_SVC_F_STATELESS) &&
> +			    (!th->syn || th->rst))
> +				return 1;
> +		}

	Probably same can be done for sctp_conn_schedule()

> +
>  		if (ip_vs_todrop(ipvs)) {
>  			/*
>  			 * It seems that we are very loaded.
> -- 
> 2.17.1

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-652719853-1701795658=:4899--

