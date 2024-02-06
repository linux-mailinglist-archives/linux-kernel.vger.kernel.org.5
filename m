Return-Path: <linux-kernel+bounces-54778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A784B396
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657BBB23096
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F80112F5AC;
	Tue,  6 Feb 2024 11:31:07 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56612F36F;
	Tue,  6 Feb 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219066; cv=none; b=UY5Vh07zBi2vOTUwQb0YgWPTc15iZKCvsJeqdLhalitrGxBApJCZBC7AZMJs7soGVF9jyLq3t85WzgKBB7sKrni3MEORwKmYLTo/pc8iH0mfWcVU5lsAUk9TpxfHngQiDesfqtHjEeRQC9lcu4wWoLY9sA68qGuun/MKnS/1hGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219066; c=relaxed/simple;
	bh=+MTWjKiA01gPdqf6LJaUl2DaLuwkdSKtzW+xOsth/nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlaDvA08wDMRitlZyqYGRqdCTDFQlRJ1s7tuI78A8G8RjnYgFLbgLjs0KBKtsyhsgAibmO66wpFlDPz6fCVsQeM51Gr494JHgXWz3iwp1KRuw2GZ0GIsngQAVfbqxrM6UooFwiU40zjXEx4gKzn2www8rLFuaoZhqML/I6myB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=57368 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rXJfH-007LIN-HQ; Tue, 06 Feb 2024 12:31:01 +0100
Date: Tue, 6 Feb 2024 12:30:58 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Michal Kubecek <mkubecek@suse.cz>, andrea.mattiazzo@suse.com,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Eric Dumazet <edumazet@google.com>, coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [netfilter-core] [PATCH net] netfilter: nf_tables: fix pointer
 math issue in nft_byteorder_eval()
Message-ID: <ZcIYcqjcFDqjvRZ3@calendula>
References: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
 <20240206104336.ctigqpkunom2ufmn@lion.mk-sys.cz>
 <20240206111112.GD17626@breakpoint.cc>
 <ZcIYL3Z/rx+/iJg0@calendula>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcIYL3Z/rx+/iJg0@calendula>
X-Spam-Score: -1.9 (-)

On Tue, Feb 06, 2024 at 12:29:51PM +0100, Pablo Neira Ayuso wrote:
> On Tue, Feb 06, 2024 at 12:11:12PM +0100, Florian Westphal wrote:
> > Michal Kubecek <mkubecek@suse.cz> wrote:
> > > I stumbled upon this when the issue got a CVE id (sigh) and I share
> > > Andrea's (Cc-ed) concern that the fix is incomplete. While the fix,
> > > commit c301f0981fdd ("netfilter: nf_tables: fix pointer math issue in
> > > nft_byteorder_eval()") now, fixes the destination side, src is still
> > > a pointer to u32, i.e. we are reading 64-bit values with relative
> > > offsets which are multiples of 32 bits.
> > > 
> > > Shouldn't we fix this as well, e.g. like indicated below?
> > 
> > No, please remove multi-elem support instead, nothing uses this feature.
> 
> See attached patch.
> 
> I posted this:
> 
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20240202120602.5122-1-pablo@netfilter.org/
> 
> I can replace it by the attached patch if you prefer. This can only
> help in the future to microoptimize some set configurations, where
> several byteorder can be coalesced into one single expression.

I have to replace those index 'i' by simply dst instead, this is
obviosly incomplete.

> diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
> index 8cf91e47fd7a..af3412602869 100644
> --- a/net/netfilter/nft_byteorder.c
> +++ b/net/netfilter/nft_byteorder.c
> @@ -43,18 +43,14 @@ void nft_byteorder_eval(const struct nft_expr *expr,
>  
>  		switch (priv->op) {
>  		case NFT_BYTEORDER_NTOH:
> -			for (i = 0; i < priv->len / 8; i++) {
> -				src64 = nft_reg_load64(&src[i]);
> -				nft_reg_store64(&dst64[i],
> -						be64_to_cpu((__force __be64)src64));
> -			}
> +			src64 = nft_reg_load64(&src[i]);
> +			nft_reg_store64(&dst64[i],
> +					be64_to_cpu((__force __be64)src64));
>  			break;
>  		case NFT_BYTEORDER_HTON:
> -			for (i = 0; i < priv->len / 8; i++) {
> -				src64 = (__force __u64)
> -					cpu_to_be64(nft_reg_load64(&src[i]));
> -				nft_reg_store64(&dst64[i], src64);
> -			}
> +			src64 = (__force __u64)
> +				cpu_to_be64(nft_reg_load64(&src[i]));
> +			nft_reg_store64(&dst64[i], src64);
>  			break;
>  		}
>  		break;
> @@ -62,24 +58,20 @@ void nft_byteorder_eval(const struct nft_expr *expr,
>  	case 4:
>  		switch (priv->op) {
>  		case NFT_BYTEORDER_NTOH:
> -			for (i = 0; i < priv->len / 4; i++)
> -				dst[i] = ntohl((__force __be32)src[i]);
> +			dst[i] = ntohl((__force __be32)src[i]);
>  			break;
>  		case NFT_BYTEORDER_HTON:
> -			for (i = 0; i < priv->len / 4; i++)
> -				dst[i] = (__force __u32)htonl(src[i]);
> +			dst[i] = (__force __u32)htonl(src[i]);
>  			break;
>  		}
>  		break;
>  	case 2:
>  		switch (priv->op) {
>  		case NFT_BYTEORDER_NTOH:
> -			for (i = 0; i < priv->len / 2; i++)
> -				d16[i] = ntohs((__force __be16)s16[i]);
> +			d16[i] = ntohs((__force __be16)s16[i]);
>  			break;
>  		case NFT_BYTEORDER_HTON:
> -			for (i = 0; i < priv->len / 2; i++)
> -				d16[i] = (__force __u16)htons(s16[i]);
> +			d16[i] = (__force __u16)htons(s16[i]);
>  			break;
>  		}
>  		break;
> @@ -137,6 +129,9 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
>  	if (err < 0)
>  		return err;
>  
> +	if (priv->size != len)
> +		return -EINVAL;
> +
>  	priv->len = len;
>  
>  	if (len % size != 0)


