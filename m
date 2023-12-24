Return-Path: <linux-kernel+bounces-10827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FB81DC78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12ED6B2115C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC06EEDC;
	Sun, 24 Dec 2023 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5MqMVfN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BDFBEB;
	Sun, 24 Dec 2023 21:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90282C433C8;
	Sun, 24 Dec 2023 21:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703453281;
	bh=A1472HXqpTmVJtHL1Ggrjktit1tKIeeow4lO8KjXqHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5MqMVfNtz84arwxVWirkYCc7KBXamSU/s0E2cBCLpeIxFM3y9xWlAmEYFnBRA9wz
	 HaLdLPbYI6EOLZHCKoAZ5p/nyfucmBNAb62dO+SBMKCj440G4Nw3cU21sh5VnZH+Fv
	 lRTj4etgC/V55Kyw7Kqiux+P0Iysw2PvzR/I+nMlrfZRI9MSLoHaURVi09midFeocD
	 RxrcOQpHckOkXhZAEItZ5ws63E4fH+Dvc9aHKT8GyX1/ebWeycAYfjIS0xuhxcZUH7
	 S4R8ngAk+dgVvLFYDQuyv5RD2wCe8vMCpGOBXi321vmJe4FKtnkY7ehnNFYc5XT8Fb
	 2hzi/XGZhGgaw==
Date: Sun, 24 Dec 2023 21:27:54 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Simo Sorce <simo@redhat.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: fix some memleaks in gssx_dec_option_array
Message-ID: <20231224212754.GB5962@kernel.org>
References: <20231224082424.3539726-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224082424.3539726-1-alexious@zju.edu.cn>

On Sun, Dec 24, 2023 at 04:24:22PM +0800, Zhipeng Lu wrote:
> The creds and oa->data need to be freed in the error-handling paths after
> there allocation. So this patch add these deallocations in the
> corresponding paths.
> 
> Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS auth")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

...

> diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c

...

> @@ -265,29 +265,41 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
>  
>  		/* option buffer */
>  		p = xdr_inline_decode(xdr, 4);
> -		if (unlikely(p == NULL))
> -			return -ENOSPC;
> +		if (unlikely(p == NULL)) {
> +			err = -ENOSPC

Hi Zhipeng Lu,

unfortunately the line above causes a build failure.

...

