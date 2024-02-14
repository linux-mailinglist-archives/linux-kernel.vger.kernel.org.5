Return-Path: <linux-kernel+bounces-65440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9285854D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5C21C2691D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB305D8E3;
	Wed, 14 Feb 2024 15:41:08 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B38524D2;
	Wed, 14 Feb 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925268; cv=none; b=tB5ilEMnj31OyyUiO+OyGJ+RgQBkrnMVZF/KTwufPVQw42sUBKVdw7Lorr/TYqSqUGDrlUPGHpas/3NjxguyvHOGrjlIy8KZ6l4To4NncZBQj0IZ+bMlvqsQptelSoC2eIK0gKBIs8+gOhUP7zzbsVHpQ6XgvSymzGjE2mdhKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925268; c=relaxed/simple;
	bh=ST5p7KUZmliGQNtDY+m9PGEgOmuSM3XMYbc7Qhd2e7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzFzrW1E0j9WdU7OuKD9Qz1nk6WGXVMGM/xcIVx4bQs3Hi65mKw0RmdnfrquQBJgTSG6WCtZEhPFmEIXyNFhHMc15a+3lJVSEC+W85PPE01zOeI0JPJiBFJTNjypKYcrrCb+xh2avxCgtKM26FGVG5YAVuXzBY81/+mughF8DxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=59030 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1raHNY-001J2z-88; Wed, 14 Feb 2024 16:40:58 +0100
Date: Wed, 14 Feb 2024 16:40:54 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_tables: fix bidirectional offload
 regression
Message-ID: <ZczfBoUtfh9U3p/6@calendula>
References: <20240214144235.70341-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214144235.70341-1-nbd@nbd.name>
X-Spam-Score: -1.9 (-)

On Wed, Feb 14, 2024 at 03:42:35PM +0100, Felix Fietkau wrote:
> Commit 8f84780b84d6 ("netfilter: flowtable: allow unidirectional rules")
> made unidirectional flow offload possible, while completely ignoring (and
> breaking) bidirectional flow offload for nftables.
> Add the missing flag that was left out as an exercise for the reader :)

Thanks for fixing up this, patch is fine.

> Cc: Vlad Buslov <vladbu@nvidia.com>
> Fixes: 8f84780b84d6 ("netfilter: flowtable: allow unidirectional rules")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/netfilter/nft_flow_offload.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> index 397351fa4d5f..ab9576098701 100644
> --- a/net/netfilter/nft_flow_offload.c
> +++ b/net/netfilter/nft_flow_offload.c
> @@ -361,6 +361,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
>  		ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
>  	}
>  
> +	__set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
>  	ret = flow_offload_add(flowtable, flow);
>  	if (ret < 0)
>  		goto err_flow_add;
> -- 
> 2.43.0
> 
> 

