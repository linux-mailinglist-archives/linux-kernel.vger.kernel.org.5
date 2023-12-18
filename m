Return-Path: <linux-kernel+bounces-4058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EDC817758
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3231C25A29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D849899;
	Mon, 18 Dec 2023 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctCwMkUl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E554495DE;
	Mon, 18 Dec 2023 16:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AA2C433C8;
	Mon, 18 Dec 2023 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916601;
	bh=J/3JV2I9kr4Id3RR7S0OZ0p3hPKbHcI0ACFCqAAjYhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctCwMkUl8RjBgk7E+AfYrhbTUBKJGKlElMZCpHnHBM3W5LWHgTlw0YZaYwFXsyS1T
	 nrLCRuLiKq5QUqA0ldhicvv119rYKFrRXgsE4KaR+h7avDdZz/+pG1aKsVUZ+SJ/wF
	 KfJXE422LuafZvaivT6mM1rS+vNFNOxrYJ4K4FYqcSt8ti+oQwN/p0Auagk1DBegSq
	 lLMh3MD1d1qoK2Q74WbCcSWS73bYkTmxsXhH5PH/0e9o+bBzhy1fLyAIbYLzwHlBPh
	 Mieq6gAxIir4aqYGRhfiwKyt8M2oIMCno0F+nf135+87jBDYouT5pEw3j/yfP3qytt
	 b2tnyLM6tbkzA==
Date: Mon, 18 Dec 2023 16:23:16 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
	jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	lcherian@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-af: Add new devlink param to
 configure maximum usable NIX block LFs
Message-ID: <20231218162316.GG6288@kernel.org>
References: <20231215120149.160122-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215120149.160122-1-sumang@marvell.com>

On Fri, Dec 15, 2023 at 05:31:49PM +0530, Suman Ghosh wrote:
> On some silicon variants the number of available CAM entries are
> less. Reserving one entry for each NIX-LF for default DMAC based pkt
> forwarding rules will reduce the number of available CAM entries
> further. Hence add configurability via devlink to set maximum number of
> NIX-LFs needed which inturn frees up some CAM entries.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> @@ -1964,8 +1977,21 @@ static int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>  
>  	return 0;
>  
> -free_mem:
> +free_cntr_refcnt:
> +	kfree(mcam->cntr_refcnt);
> +free_entry_cntr_map:
> +	kfree(mcam->entry2cntr_map);
> +free_cntr_map:
> +	kfree(mcam->cntr2pfvf_map);
> +free_cntr_bmap:
> +	kfree(mcam->counters.bmap);
> +free_entry_map:
> +	kfree(mcam->entry2pfvf_map);
> +free_bmap_reverse:
> +	kfree(mcam->bmap_reverse);
> +free_bmap:
>  	kfree(mcam->counters.bmap);
> +
>  	return -ENOMEM;
>  }
>  

Hi Suman,

I realise that this patch has been accepted.
But I believe there is a double-free problem above
as mcam->counters.bmap may be freed twice.
And mcam->bmap seems to be leaked.

Perhaps the last part of the unwind ladder should be:

free_bmap:
	kfree(mcam->bmap);

Double-free flagged by Smatch and Coccinelle.

