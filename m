Return-Path: <linux-kernel+bounces-136891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D350789D972
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD9F28B14C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426D12DDB8;
	Tue,  9 Apr 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="31px0dfs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053EA12DDA2;
	Tue,  9 Apr 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667142; cv=none; b=j4Ex/GTpCChB+fo69gfsyVPtTP60OOaDdAonQqzyoh7GvfPdDJvH1Yh2fFfMwdczsTAQJAFmn1+usiNXO80WPfAwNrXd3aGqqHvCbidEj7FCC43ijDskh6UJNUYVhWIwRrAprJaQMPduiPPydKitLp9tUhIseesB6YJPskUv42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667142; c=relaxed/simple;
	bh=41b/xhD3dPWFH2Cgl+OJc2iALYdSLEci2U9fZ4hnz+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMBd7JliLNXZ3w0OXcrHogihyVtEdzgwqNAuAVEKnhihGEhpmIOBIxufD+fHkYW//8G+l1TUuUzbDPhjuP2ZTr0H+WYHvHGeZZ8AsJDFdDEkCQHdObOyl23a80L1w+mcvOMFtf5GET+04+upoy3ugJgc3wr2r5kW6rzQKwpst2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=31px0dfs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SOiDJKippIgWMoxQU2kFtESoBNJpC+0fpTgJoPzBWVA=; b=31px0dfsxvJWYgtK2EYN81+mgX
	FTvXnHwQnouuYlmxONhKXJKIQIBzamX6wdArIX+b3JEX8ijjRho9B5rP7UVqN/q8ULMDHzJjfWEJm
	DCvhyl78W0cnUJgq7EyfQcMdPO6JdcC70LY4vVKwJ8gaEnwPY0PrA94+2W/Ln2ZqjEvI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruAxM-00CZcj-IP; Tue, 09 Apr 2024 14:52:08 +0200
Date: Tue, 9 Apr 2024 14:52:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lei Chen <lei.chen@smartx.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net:tun: limit printing rate when illegal packet
 received by tun dev
Message-ID: <0e5a96b6-0862-4c00-b07f-7485af232475@lunn.ch>
References: <20240409062407.1952728-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409062407.1952728-1-lei.chen@smartx.com>

On Tue, Apr 09, 2024 at 02:24:05AM -0400, Lei Chen wrote:
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
> 
> Rate limit mechanism can be used to limit the dumping rate.
> @@ -2125,14 +2126,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  					    tun_is_little_endian(tun), true,
>  					    vlan_hlen)) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
> -			pr_err("unexpected GSO type: "
> -			       "0x%x, gso_size %d, hdr_len %d\n",
> -			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -			       tun16_to_cpu(tun, gso.hdr_len));
> -			print_hex_dump(KERN_ERR, "tun: ",
> -				       DUMP_PREFIX_NONE,
> -				       16, 1, skb->head,
> -				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +
> +			if (__ratelimit(&ratelimit)) {

Maybe just use net_ratelimit() rather than add a new ratelimit
variable?

A separate issue, i wounder if rather than pr_err(),
netdev_err(tun->dev, ...) should be used to indicate which TUN device
has been given bad GSO packets?

    Andrew

