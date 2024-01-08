Return-Path: <linux-kernel+bounces-19398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E616826C5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA39628314A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B011428D;
	Mon,  8 Jan 2024 11:15:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35614266;
	Mon,  8 Jan 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rMnay-0000kd-E6; Mon, 08 Jan 2024 12:15:04 +0100
Date: Mon, 8 Jan 2024 12:15:04 +0100
From: Florian Westphal <fw@strlen.de>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@openvz.org
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Message-ID: <20240108111504.GA23297@breakpoint.cc>
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> An skb can be added to a neigh->arp_queue while waiting for an arp
> reply. Where original skb's skb->dev can be different to neigh's
> neigh->dev. For instance in case of bridging dnated skb from one veth to
> another, the skb would be added to a neigh->arp_queue of the bridge.
> 
> There is no explicit mechanism that prevents the original skb->dev link
> of such skb from being freed under us. For instance neigh_flush_dev does
> not cleanup skbs from different device's neigh queue. But that original
> link can be used and lead to crash on e.g. this stack:
> 
> arp_process
>   neigh_update
>     skb = __skb_dequeue(&neigh->arp_queue)
>       neigh_resolve_output(..., skb)
>         ...
>           br_nf_dev_xmit
>             br_nf_pre_routing_finish_bridge_slow
>               skb->dev = nf_bridge->physindev
>               br_handle_frame_finish
> 
> So let's improve neigh_flush_dev to also purge skbs when device
> equal to their skb->nf_bridge->physindev gets destroyed.

Can we fix this by replacing physindev pointer with plain
ifindex instead?  There are not too many places that need to
peek into the original net_device struct, so I don't think
the additional dev_get_by_index_rcu() would be an issue.

