Return-Path: <linux-kernel+bounces-152973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93AD8AC6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA65B22346
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AAB502AC;
	Mon, 22 Apr 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="c/S7mFL+"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06551C33;
	Mon, 22 Apr 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774412; cv=none; b=GCdkDiSm8XuhD/GYzPOAaIsqLb/eOFqq28VbL2kqsGHra58nN5hi8Lvky9h1NP7OMUqcGoGpn0aiZfdcrzEKcxHyojwrBRGdlunCOf8pGdrpfXNkHWKFsItAdlR31apcqW0zWmLkyKpxVF7MpToZggLQp8OXYXfg2VH2jQcNKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774412; c=relaxed/simple;
	bh=y37r8XxZzttygEhBfvdyYxE8grygu1uvu5+ykK8tHnk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TlawR0eGuNwdfni3gn+tKAxFqgEq1/al0VyzGXOK7WV+vm7vRDweMD74Wudb5Kg4Zp4jXjzuiE7XMFEsXiA554Ucw1oW/TX0ST+2+4f+AmYHcXxCIteHDxoYBPIFF90ScD3cVb8ib7J7phehBUsIrs6FlSAGGyrEbjs1/YCVwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=c/S7mFL+; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id DD2CA25ACE;
	Mon, 22 Apr 2024 11:26:45 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Mon, 22 Apr 2024 11:26:44 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id A1D67900394;
	Mon, 22 Apr 2024 11:26:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1713774401; bh=y37r8XxZzttygEhBfvdyYxE8grygu1uvu5+ykK8tHnk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=c/S7mFL+JgNg1gjRTl5ehh6B7tYlTW1idzbuAX5bHSOOp9T4lyqUerFVOz4fVjNX3
	 2iwfZDd8prnAKZ+lswrjbDUmbtFoS1c1dB4/c+nQvnHtpb9p8CdQlaeOR6yslo1IAK
	 niJDzGzR8lbSfTQTbkUgNicTfqKQv903EsPUfSe4=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43M8QctX040757;
	Mon, 22 Apr 2024 11:26:39 +0300
Date: Mon, 22 Apr 2024 11:26:38 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Ismael Luceno <iluceno@suse.de>
cc: linux-kernel@vger.kernel.org, Firo Yang <firo.yang@suse.com>,
        Andreas Taschner <andreas.taschner@suse.com>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.com>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        coreteam@netfilter.org
Subject: Re: [PATCH v2] ipvs: Fix checksumming on GSO of SCTP packets
In-Reply-To: <20240421142234.15764-1-iluceno@suse.de>
Message-ID: <5a1b5536-a8ba-4438-9ed2-23819f1846a6@ssi.bg>
References: <20240421142234.15764-1-iluceno@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-2077803110-1713774400=:25471"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-2077803110-1713774400=:25471
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Sun, 21 Apr 2024, Ismael Luceno wrote:

> It was observed in the wild that pairs of consecutive packets would leave
> the IPVS with the same wrong checksum, and the issue only went away when
> disabling GSO.
> 
> IPVS needs to avoid computing the SCTP checksum when using GSO.
> 
> Fixes: 90017accff61 ("sctp: Add GSO support", 2016-06-02)
> Co-developed-by: Firo Yang <firo.yang@suse.com>
> Signed-off-by: Ismael Luceno <iluceno@suse.de>
> Tested-by: Andreas Taschner <andreas.taschner@suse.com>
> CC: Michal Kubeček <mkubecek@suse.com>
> CC: Simon Horman <horms@verge.net.au>
> CC: Julian Anastasov <ja@ssi.bg>
> CC: lvs-devel@vger.kernel.org
> CC: netfilter-devel@vger.kernel.org
> CC: netdev@vger.kernel.org
> CC: coreteam@netfilter.org

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

	As scripts/checkpatch.pl --strict /tmp/file.patch complains
about Co-developed-by and Signed-off-by lines you may want to
send v3...

> ---
> 
> Notes:
>     Changes since v1:
>     * Added skb_is_gso before skb_is_gso_sctp.
>     * Added "Fixes" tag.
> 
>  net/netfilter/ipvs/ip_vs_proto_sctp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> index a0921adc31a9..1e689c714127 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> @@ -126,7 +126,8 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	if (sctph->source != cp->vport || payload_csum ||
>  	    skb->ip_summed == CHECKSUM_PARTIAL) {
>  		sctph->source = cp->vport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
> @@ -174,7 +175,8 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	    (skb->ip_summed == CHECKSUM_PARTIAL &&
>  	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
>  		sctph->dest = cp->dport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
> -- 
> 2.43.0

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-2077803110-1713774400=:25471--


