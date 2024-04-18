Return-Path: <linux-kernel+bounces-150164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1452A8A9B31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A813A1F23720
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715061607B0;
	Thu, 18 Apr 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="VPMuh+U8"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE115FD16;
	Thu, 18 Apr 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446601; cv=none; b=dPI/TLcK/Kp00XxiCVLWKKU/onJaxqozQQwa+PNUbERB5feXmP8mnUNDtGVfzD3nVezvj+vd1wBSM4n6gOlQ8hflDXl/HF97nBeffGIV9szuDUVt7UoPEeNnjujd4BCOPcOdi8fLutS4RH/0TetVML85PZrwbmtAknezgkFqa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446601; c=relaxed/simple;
	bh=WAl7L1iBp86eXNg2Shw1xOHGw0vm5p71Lv8WUKHUN1s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aHh7fq3/ZJvLEX1fLjxhhwMvgblJov0W4VWFzB/6va4IVQr/FtvmF9RmfKBGPASRZxPSb1gDiWULt+cp4uTxtZPfanqPGcV49TptFxKzPouqxEPIUY0atdRt/NE0zlH9nfcUkz/bQGbnsf1FyHZ7fiIlSYo4B3gADorWRtXPuUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=VPMuh+U8; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id F0A0A1836A;
	Thu, 18 Apr 2024 16:23:09 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Thu, 18 Apr 2024 16:23:09 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id BFD95900570;
	Thu, 18 Apr 2024 16:23:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1713446586; bh=WAl7L1iBp86eXNg2Shw1xOHGw0vm5p71Lv8WUKHUN1s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VPMuh+U8F/Dd/e+BkI2TBEssJim6xN25jHmgFlpSmaL9wrwBSHkpkOMSCM5xXPCQw
	 mtKTpzXsmLIvxEEtJKBz6s0S3XbZknzChjrQMGnEdndru2+08SopfQ86HOdVAcQddG
	 3329gWCWZ+MoCyY7jaKvAqFx3TbndwCaosCxiIDM=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43IDMtKa057494;
	Thu, 18 Apr 2024 16:22:57 +0300
Date: Thu, 18 Apr 2024 16:22:55 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next v2 1/2] ipvs: add READ_ONCE barrier for
 ipvs->sysctl_amemthresh
In-Reply-To: <20240418110153.102781-1-aleksandr.mikhalitsyn@canonical.com>
Message-ID: <eb0b4b89-9a1f-0e1b-9744-6eb3396048bd@ssi.bg>
References: <20240418110153.102781-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Thu, 18 Apr 2024, Alexander Mikhalitsyn wrote:

> Cc: Julian Anastasov <ja@ssi.bg>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Suggested-by: Julian Anastasov <ja@ssi.bg>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 143a341bbc0a..daa62b8b2dd1 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c

> @@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  	/* si_swapinfo(&i); */
>  	/* availmem = availmem - (i.totalswap - i.freeswap); */
>  
> -	nomem = (availmem < ipvs->sysctl_amemthresh);
> +	amemthresh = max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
> +	nomem = (availmem < amemthresh);
>  
>  	local_bh_disable();
>  
> @@ -146,8 +148,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  	case 1:
>  		if (nomem) {
>  			ipvs->drop_rate = ipvs->drop_counter
> -				= ipvs->sysctl_amemthresh /
> -				(ipvs->sysctl_amemthresh-availmem);
> +				= amemthresh /
> +				(amemthresh-availmem);

	Thanks, both patches look ok except that the old styling
is showing warnings for this patch:

scripts/checkpatch.pl --strict /tmp/file1.patch

	It would be great if you silence them somehow in v3...

	BTW, est_cpulist is masked with current->cpus_mask of the
sysctl writer process, if that is of any help. That is why I skipped
it but lets keep it read-only for now...

>  			ipvs->sysctl_drop_packet = 2;
>  		} else {
>  			ipvs->drop_rate = 0;
> @@ -156,8 +158,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  	case 2:
>  		if (nomem) {
>  			ipvs->drop_rate = ipvs->drop_counter
> -				= ipvs->sysctl_amemthresh /
> -				(ipvs->sysctl_amemthresh-availmem);
> +				= amemthresh /
> +				(amemthresh-availmem);
>  		} else {
>  			ipvs->drop_rate = 0;
>  			ipvs->sysctl_drop_packet = 1;

Regards

--
Julian Anastasov <ja@ssi.bg>


