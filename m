Return-Path: <linux-kernel+bounces-47260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC7C844B18
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC71C22730
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985FB3A8C0;
	Wed, 31 Jan 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp/t1pJe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47041364CA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740622; cv=none; b=J8GbPQGN61liMp1kx327kOadPeytiqRrsfx0qncldyGLoJmxUxa+Re9M23SaVb9XLb/VsIaoRYt7AnFZdgkqrjkPgd9j3J+TdrI6hyLn77x/vt2vtmj+5PaXnDK/b5k9fqHlF6j9saAz31fXmP7yVcEnK4U/fag3V6elyyolbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740622; c=relaxed/simple;
	bh=Iu+8D8k16qGF05cFe22hv0MQBwz9+bj5LdTjBKDOWeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtzY5puZ7EBZr7T1ArG8uGgZz9OdGBCTGHLpS9FZOfkbIrfUSrfGCJNpbJfQEa0JFNywhiSELyARdbz34rnzL3cslALVgEw0FiWs+ArIAsBmsJNWCnH5XfF3hZmWbm9ZWdCw9s+uziv3RTdGnFJOigIuYCGggLYOjyHiTdXOLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pp/t1pJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706740618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCoZH7HUiSU0yflw5IfG5DX6qgN8kXKIe4+R5MH+S1U=;
	b=Pp/t1pJe9FkBKxQawWmrE41nXMZG3iXS7rjSYNsC9ZgSdN0u/YJqSKUhL3fnYTkdC+JGNZ
	qJVQbNgVw/ug+VUxAJBPhPSCeNO50GZBNuyQlT1/7Czh0rvBX5v8kdcJwoyZJ6NHKExWM/
	qyFX6oaPLHJFewzKlyYMZI7NBR9VpZ4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-f7E-uu7uNH2xx4uEmEJB5Q-1; Wed, 31 Jan 2024 17:36:56 -0500
X-MC-Unique: f7E-uu7uNH2xx4uEmEJB5Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5110bf1635eso176139e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740615; x=1707345415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCoZH7HUiSU0yflw5IfG5DX6qgN8kXKIe4+R5MH+S1U=;
        b=RnLyBLeZtH6l8dkrScxgg5Zz3hYqR2VmiEcDo+qErgamnJZd23vwsJGmNPkSRkqvEJ
         juc8+sepSHYmvCWKjLgObNmfpPC5K0azJiN6dUo/fs0dRKoVL4gwORvCBqceNWiWU5NR
         7B/KJNjXcKv78Ksvhk6o99e7/nvBDm0Sy0g2N4FuJVxOXxBeuViuLzl7gxFQNrSjwtV1
         0N5xxvrS3t1k5iJdF1vagQk8+dj2NXe0uNSPpywn/Sbq8LF+Hm1eVtU5/0Qj9pDUdwrK
         KsV1OqgkReFJiZvfHg3g4lIz7vvgTleKBJmiJyDf+ElIKSzvgNHeqFQtR00bVgq62krt
         TG8A==
X-Gm-Message-State: AOJu0YzWdoYZnKcLhpYMBnSmqDiZTwT/J5fwF+VWdQy8zCPymwSwRVmF
	uggbAtnWCF95XyDFZKRAgPC9s/0A5Hm9Y2VuNNdkUWmWm6gCWvU6+SBQLphmylImJScFa8sqvcy
	HSke1Wa+j17AiIdKu2X8vv1ezL1HVGMzHfwDp9/nT42qbWMS46Q7HDTZPe0/XGg==
X-Received: by 2002:a19:4f42:0:b0:510:11f4:6741 with SMTP id a2-20020a194f42000000b0051011f46741mr368281lfk.17.1706740615138;
        Wed, 31 Jan 2024 14:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdYe2Nb5HfdKCFeTwFRTgm6BrtfqRQRuKBw02G2lHJDzsRV/wKxyLsFBX60j2fd+FOCZ/FZQ==
X-Received: by 2002:a19:4f42:0:b0:510:11f4:6741 with SMTP id a2-20020a194f42000000b0051011f46741mr368273lfk.17.1706740614525;
        Wed, 31 Jan 2024 14:36:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:15f2:27d8:8291:1cb6:8df6])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm6703708ejb.170.2024.01.31.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:36:53 -0800 (PST)
Date: Wed, 31 Jan 2024 17:36:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, jasowang@redhat.com,
	herbert@gondor.apana.org.au, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, nathan@kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
Message-ID: <20240131173615-mutt-send-email-mst@kernel.org>
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

Cc: stable@vger.kernel.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>



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


