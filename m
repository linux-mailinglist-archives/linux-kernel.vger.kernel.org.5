Return-Path: <linux-kernel+bounces-47003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63468447CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145621C235A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D338F8F;
	Wed, 31 Jan 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZN8QliN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210233715E;
	Wed, 31 Jan 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728214; cv=none; b=TvlH+fsSQDcg08Hb/fUDjcLMN0AxEN7UeB8MZnuXXv1GGzTm7IbSJzyTnFGvxfTZAiB9d51Ntvzdo0utEq6YIgxMvAob4hgSWUuxAUzkEgat1EUIo3PVDV7povMB8o3oU6R88B6ERaXgfoPExeEymA/TjIbLbPspxt8b10bzzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728214; c=relaxed/simple;
	bh=YuGBlaaDD6uC/KXsWtFTjEBqEGYGFxartz53V+KSBQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOfo0pcl0fbKhtoCRdH8e+HZCURH6LMIz/VwJkm5myrVnI2sT+shwNYO0JIL7EhvRzcA8u5FtMEjd1CHchtc52lr7zvteooki0qjKpqbvv9MI1VkQbqTafRb/XsEq1EewXRoBLECkSEi6Wllwb4Y5tDT02vyjx6vwbHc1yFcj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZN8QliN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE521C433F1;
	Wed, 31 Jan 2024 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706728213;
	bh=YuGBlaaDD6uC/KXsWtFTjEBqEGYGFxartz53V+KSBQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZN8QliNA2knu33YvywVNAsuKerSk0V11V6U2pfWg1KSPUQq0x3NY8psX+IU6uQw2
	 7uHgK95gmRPhnEgKK1DymD2ss8Su/LxCV98VMotPQz8LtS1/VjIthbdFRbuqShAH3z
	 ZeoiXhxlmeB8NU4KKrCqmeUO5kO+cCe476SZ6Ux29lc9M9Nzx7ob1/q3bzVfoh3X5F
	 Bt5smSIC7nCg13w+SRXqRa7MxZoTUwTlOIDuNSSz7n9cB6IKWlTRw/oPcjVw1n6MuF
	 MxHR6UMVHG1JP273RiNj/Gvoyo1fH76JluEr+4e2WsBufIaUdYC4Qv1Rhu2HwMsE5O
	 grkcvAk+7yk2A==
Date: Wed, 31 Jan 2024 12:10:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com,
	herbert@gondor.apana.org.au, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
Message-ID: <20240131191011.GA679548@dev-arch.thelio-3990X>
References: <20240130112740.882183-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130112740.882183-1-pizhenwei@bytedance.com>

On Tue, Jan 30, 2024 at 07:27:40PM +0800, zhenwei pi wrote:
> sizeof(struct virtio_crypto_akcipher_session_para) is less than
> sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
> stack variable leads stack overflow. Clang reports this issue by
> commands:
> make -j CC=clang-14 mrproper >/dev/null 2>&1
> make -j O=/tmp/crypto-build CC=clang-14 allmodconfig >/dev/null 2>&1
> make -j O=/tmp/crypto-build W=1 CC=clang-14 drivers/crypto/virtio/
>   virtio_crypto_akcipher_algs.o
> 
> Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
> Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net/
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

I can confirm this resolves the warning for me as well.

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

I suspect Guenter should have a formal Reported-by tag. Should this be
CC'd for stable@ as well?

Cheers,
Nathan

> ---
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 2621ff8a9376..de53eddf6796 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -104,7 +104,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
>  }
>  
>  static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
> -		struct virtio_crypto_ctrl_header *header, void *para,
> +		struct virtio_crypto_ctrl_header *header,
> +		struct virtio_crypto_akcipher_session_para *para,
>  		const uint8_t *key, unsigned int keylen)
>  {
>  	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
> @@ -128,7 +129,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  
>  	ctrl = &vc_ctrl_req->ctrl;
>  	memcpy(&ctrl->header, header, sizeof(ctrl->header));
> -	memcpy(&ctrl->u, para, sizeof(ctrl->u));
> +	memcpy(&ctrl->u.akcipher_create_session.para, para, sizeof(*para));
>  	input = &vc_ctrl_req->input;
>  	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>  
> -- 
> 2.34.1
> 

