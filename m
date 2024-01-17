Return-Path: <linux-kernel+bounces-28976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F748305CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B091F25F03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D651EA76;
	Wed, 17 Jan 2024 12:44:06 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8B1DFE6;
	Wed, 17 Jan 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495446; cv=none; b=I03z3ochrIAiUzd8ocqUcRbGGsFUL0BbrH0wUDzvbQFkf9b5Qx97ibwogW1FlrQwXkU/KwDthleqiKGl4o4wFGOAmx9EVkrWhNXibqRE7KIZPBmSLQfrm9MEiAMPxusFUk1LVszK9toH4abjmyLBT/qZhNmCNWxIZJou/k8Nc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495446; c=relaxed/simple;
	bh=giAza7e6lB0scwLEi7BWSLsTb0Ii7ZIpXI4+tJX8w1o=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Score; b=OR/MHIhr3ujF3esGy0kGO1rF5qDoPv5LaorJSrHGvjbX3FfAzl/9K4SOoZ6nKxU9hTn+xrS8IzH6Y70vJPHkBHK+eACAydxtYjlz2Oq/c0f3tMcsOPpd9Sr43v9J8zVcyH8mzacge5oJ5cGsBmbaloac5dPEjpUDDZEzloe9sTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=34294 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rQ5Gn-00DsBF-Fq; Wed, 17 Jan 2024 13:43:51 +0100
Date: Wed, 17 Jan 2024 13:43:48 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, David Ahern <dsahern@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Kees Cook <keescook@chromium.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev, kernel@openvz.org
Subject: Re: [PATCH v3 0/4] netlink: bridge: fix nf_bridge->physindev use
 after free
Message-ID: <ZafLhL9U3f/i07BU@calendula>
References: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
X-Spam-Score: -1.9 (-)

On Thu, Jan 11, 2024 at 11:06:36PM +0800, Pavel Tikhomirov wrote:
> Code processing skb from neigh->arp_queue can access its
> nf_bridge->physindev, which can already be freed, leading to crash.
> 
> So, as Florian suggests, we can put physinif on nf_bridge and peek into
> the original device with dev_get_by_index_rcu(), so that we can be sure
> that device is not freed under us.
> 
> This is a second attempt to fix this issue, first attempt:
> 
> "neighbour: purge nf_bridged skb from foreign device neigh"
> https://lore.kernel.org/netdev/20240108085232.95437-1-ptikhomirov@virtuozzo.com/

I have applied this series to nf.git

I have added a Fixed: tag sufficiently old to the patch fix so it can
reach -stable at some point.

My understanding is that this problem has been always there for
br_netfilter.

