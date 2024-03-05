Return-Path: <linux-kernel+bounces-92483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03AF87210E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31EF1C2188C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8188614C;
	Tue,  5 Mar 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX3Kxns3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED255676A;
	Tue,  5 Mar 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647427; cv=none; b=EbOKYWp+v0XnkrAF6h59oBs/vcfgbYKQ2i+X6x8gtdql7P+IM8RJfSuEzIY/43zurazvGkosIzzeIaawX1SHB6tIxFhjblM8XoXe7LQ9psSyDMr3jemIzVOHQmuOC2EfB9l3NFlAZsuXcbQwvcTbTpYHd6nInHlTA/jtsEygf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647427; c=relaxed/simple;
	bh=ymm/tCYJBGRSxMO026DOxEtdikssct9RdJGK+HdpgC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZXZeEKi/LzFUr2PxGVEjbLYnpf5xeYvCUUkpEFOxREmdL3lw9BHGnj1dLJV4xizXlwM5ikK3TsSGdQCC28Tv27VawCPY8o53Y5SbjXTQaUqFKmk1DHpba42lsnocgzCfHqKGOnN6Wuq3fRNeLprYXFMBU9tRyNbyWP4AlQYRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX3Kxns3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138EAC433C7;
	Tue,  5 Mar 2024 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709647426;
	bh=ymm/tCYJBGRSxMO026DOxEtdikssct9RdJGK+HdpgC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YX3Kxns3q3sqQpiHyFalxrQ7o1dsQHXt++TqgrLbMeyut3viAdUKHwiCPBDJ+ZCNi
	 Hs0fbDi+gfyAQRE0YOA1BmkfXx3MhZ/Zi2DPOoBHPHa9IFJx6XY9d4Fk9K5S1GFN1X
	 opvMDaZJ4UEYLztj6immcMI7IshNqAF8wR/aqzX5wfs3iwAXr6nXQIBLMcDl0mJs59
	 UQTYFhEjSMgqIVLODNoOGkmv3MyolTlCbMEhmjQGz96kiOSSDhZbT4P6/I9Fltx67z
	 VpVtXw7LEV+LwCNMEBVoorC6XL6NbpKnMloHUt46p9wbT08NkXX4iasuu5N70/6I0U
	 J+2mKV5oEB2vw==
Date: Tue, 5 Mar 2024 14:03:43 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/21] rxrpc: Do zerocopy using
 MSG_SPLICE_PAGES and page frags
Message-ID: <20240305140343.GH2357@kernel.org>
References: <20240304084322.705539-1-dhowells@redhat.com>
 <20240304084322.705539-15-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304084322.705539-15-dhowells@redhat.com>

On Mon, Mar 04, 2024 at 08:43:11AM +0000, David Howells wrote:

..

> diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
> index ef0849c8329c..e540501a20ad 100644
> --- a/net/rxrpc/rxkad.c
> +++ b/net/rxrpc/rxkad.c
> @@ -145,16 +145,17 @@ static int rxkad_init_connection_security(struct rxrpc_connection *conn,
>  /*
>   * Work out how much data we can put in a packet.
>   */
> -static int rxkad_how_much_data(struct rxrpc_call *call, size_t remain,
> -			       size_t *_buf_size, size_t *_data_size, size_t *_offset)
> +static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t remain, gfp_t gfp)
>  {
> -	size_t shdr, buf_size, chunk;
> +	struct rxrpc_txbuf *txb;
> +	size_t shdr, space;
> +
> +	remain = min(remain, 65535 - sizeof(struct rxrpc_wire_header));
>  
>  	switch (call->conn->security_level) {
>  	default:
> -		buf_size = chunk = min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
> -		shdr = 0;
> -		goto out;
> +		space = min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
> +		return rxrpc_alloc_data_txbuf(call, space, 0, GFP_KERNEL);

Hi David,

should gfp be used here in place of GFP_KERNEL?

>  	case RXRPC_SECURITY_AUTH:
>  		shdr = sizeof(struct rxkad_level1_hdr);
>  		break;
> @@ -163,17 +164,15 @@ static int rxkad_how_much_data(struct rxrpc_call *call, size_t remain,
>  		break;
>  	}
>  
> -	buf_size = round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN);
> -
> -	chunk = buf_size - shdr;
> -	if (remain < chunk)
> -		buf_size = round_up(shdr + remain, RXKAD_ALIGN);
> +	space = min_t(size_t, round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN), remain + shdr);
> +	space = round_up(space, RXKAD_ALIGN);
>  
> -out:
> -	*_buf_size = buf_size;
> -	*_data_size = chunk;
> -	*_offset = shdr;
> -	return 0;
> +	txb = rxrpc_alloc_data_txbuf(call, space, RXKAD_ALIGN, GFP_KERNEL);

Likewise, here too.

Flagged by Smatch.

> +	if (txb) {
> +		txb->offset += shdr;
> +		txb->space -= shdr;
> +	}
> +	return txb;

nit: I think this would be a more idiomatic construction.
     (Completely untested!)

	if (!txb)
		return NULL;

	txb->offset += shdr;
	txb->space -= shdr;

	return txb;

>  }
>  
>  /*

..

