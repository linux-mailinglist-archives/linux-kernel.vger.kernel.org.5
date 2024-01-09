Return-Path: <linux-kernel+bounces-20752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05A82849A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856C6B2327F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE136B08;
	Tue,  9 Jan 2024 11:12:41 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB337159;
	Tue,  9 Jan 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rNA20-0000Mw-VC; Tue, 09 Jan 2024 12:12:28 +0100
Date: Tue, 9 Jan 2024 12:12:28 +0100
From: Florian Westphal <fw@strlen.de>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@openvz.org
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Message-ID: <20240109111228.GA7664@breakpoint.cc>
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
 <20240108111504.GA23297@breakpoint.cc>
 <a84b2797-2008-45d6-9ca3-c72666d3c419@virtuozzo.com>
 <07490c75-86c3-4488-8adb-7740b14feb30@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07490c75-86c3-4488-8adb-7740b14feb30@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> index f980edfdd2783..105fbdb029261 100644
> --- a/include/linux/netfilter_bridge.h
> +++ b/include/linux/netfilter_bridge.h
> @@ -56,11 +56,15 @@ static inline int nf_bridge_get_physoutif(const struct
> sk_buff *skb)
>  }
> 
>  static inline struct net_device *
> -nf_bridge_get_physindev(const struct sk_buff *skb)
> +nf_bridge_get_physindev_rcu(const struct sk_buff *skb)
>  {
>         const struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
> +       struct net_device *dev;
> 
> -       return nf_bridge ? nf_bridge->physindev : NULL;
> +       if (!nf_bridge || !skb->dev)
> +               return 0;
> +
> +       return dev_get_by_index_rcu(skb->dev->net, nf_bridge->physindev_if);

You could use dev_net(skb->dev), yes.

Or create a preparation patch that does:

-nf_bridge_get_physindev(const struct sk_buff *skb)
+nf_bridge_get_physindev(const struct sk_buff *skb, struct net *net)

(all callers have a struct net available).

No need to rename the function, see below.

> -       br_indev = nf_bridge_get_physindev(oldskb);
> +       rcu_read_lock_bh();
> +       br_indev = nf_bridge_get_physindev_rcu(oldskb);

No need for rcu read lock, all netfilter hooks run inside
rcu_read_lock().

> Does it sound good?

Yes, seems ok to me.

> Or maybe instead we can have extra physindev_if field in addition to
> existing physindev to only do dev_get_by_index_rcu inside
> br_nf_pre_routing_finish_bridge_slow to doublecheck the ->physindev link?
> 
> Sorry in advance if I'm missing anything obvious.

Alternative would be to add a 'br_nf_unreg_serno' that gets incremented
from brnf_device_event(), then store that in nf_bridge_info struct and
compare to current value before net_device deref. If not equal, toss skb.

Problem is that we'd need some indirection to retrieve the current
value, otherwise places like nfnetlink_log() gain a module dependency on
br_netfilter :-(

We'd likely need
const atomic_t *br_nf_unreg_serno __read_mostly;
EXPORT_SYMBOL_GPL(br_nf_unreg_serno);

in net/netfilter/core.c for this, then set/clear the
pointer from br_netfilter_hooks.c.

I can't say/don't know which of the two options is better/worse.

s/struct net_device */int// has the benefit of shrinking nf_bridge_info,
so I'd try that first.

