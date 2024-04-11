Return-Path: <linux-kernel+bounces-139843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D88A085E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6201D28399C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB613D242;
	Thu, 11 Apr 2024 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJNS5Xvh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DE13CABF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816431; cv=none; b=UaYr53hGm4G/cSimzAZA1SxL5OT44cDlm2q3Up1q7m5O1eM4sqG/il9lEakju1dvXlf/QaTRJH21fVouXY9yUmArIhX75RnPY1PuYneYeCXn1WiZriopIHPUBOAqP/QdB0xyo45Etu+GErU0GJ7ATyTBROpdwfHADkSFBY+bCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816431; c=relaxed/simple;
	bh=3QrXsH4rkf8GAhPmF0phCe/NHT9Nq5V7cv+MZiPf1H0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZVl6kqab6Dl22S/DcEiVGK928pLwwc22iJekDG3Q8min6vbfhLSO9oa17ND/mtWdDLUr55AeFbjK3oB1Bb+E8/wACIoo0BROOcv1M2I2PkCSFrcjhtQZzvvgNVwYIbhfhPUYvuXvSSOkT0+v8RaUpixvzOrOR6GEwwd8DdFOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJNS5Xvh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712816428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dV21BWGe2ufgawa50AocOZVeA8TiHinbeJSrkanC5Ds=;
	b=cJNS5XvhMAzctMMH+i9sLDV7LICmQTA+bSraAHtcD1K1y+HPvg8iKs79l9WxkgOUkYy4hC
	swAZMRhqY/T4zhxv7Qnk0jj94h0pIAXPiWs31pB/vF217kxA9tATtRHzHBHfP+QpFcn+yy
	TtnnYYUjvYRMUh83C/BShu0QbwQw2EE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-XIZow07iMkWyPiwPuNuOVQ-1; Thu, 11 Apr 2024 02:20:26 -0400
X-MC-Unique: XIZow07iMkWyPiwPuNuOVQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-346b68157cdso126955f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816425; x=1713421225;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dV21BWGe2ufgawa50AocOZVeA8TiHinbeJSrkanC5Ds=;
        b=oIJggbO2Wl8IeWDUzfUq9Q8N16GeDxdUAvKyz4yWm2yzI+85VImGZr/lZJAMQtbV8e
         TM7Isd+S33CptBWhtsouRQ8b20788fYfX3QyN6kuI7pCOQGOlKHrQ7HMGibbRFIVdkjI
         sBTHyA8J025bQlumAVIyLbf+T1gfxFiffVr2oTczSc2fTyPjWfGtdmCEahX5aajKTW/s
         AZIZqN/4RNYthxYL/lfXUknhiUMlxkNSBZhxuC/Lbs0vNSRvNJWZa5mz/yfWfCKRGOk1
         smc2rLWag5hTTz4wRg4xouJChplyjEHo7TrzO7ey+s4BIf8cS4T/E2U3E1Yd6DE4y2r4
         bdZA==
X-Forwarded-Encrypted: i=1; AJvYcCUT41V+zgM+WZwLmBY8zv40dR/APgfjNLu6NTOcNbcMM1Xj6oYeVOrRpctg7yMgDEaW9Ce1GSFTIY53LSQqDg/2n6d+V00gkPka1xIH
X-Gm-Message-State: AOJu0Ywz3aIAnhFa8HMSUo9cK53Y7ItRocJBTvyiTXGiCRadMzQJnZev
	rzAK4cefP1tcJ3s8HTHNAt+e6zv335VLuYcaQ9A7gN/VfpdOpBniRHzmDPl1yv8qIPrMtqwl3cL
	5PMNgUnr6tLWLZnSem/B6V7qOdxfqpPiSpOBff8oozQgsBuDFi2C4wyfc3WmlxA==
X-Received: by 2002:a05:600c:1c01:b0:416:5339:d114 with SMTP id j1-20020a05600c1c0100b004165339d114mr3213791wms.1.1712816425408;
        Wed, 10 Apr 2024 23:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFy4+7x8xF0IjYiUokCgfKSlSJfkYngQ7+CirLRMXiCIgHUo6eBMLJhw2QhWeXYlVeYM4/fQ==
X-Received: by 2002:a05:600c:1c01:b0:416:5339:d114 with SMTP id j1-20020a05600c1c0100b004165339d114mr3213765wms.1.1712816424906;
        Wed, 10 Apr 2024 23:20:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-217.dyn.eolo.it. [146.241.235.217])
        by smtp.gmail.com with ESMTPSA id ay21-20020a05600c1e1500b00417da7db6b8sm738907wmb.31.2024.04.10.23.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:20:24 -0700 (PDT)
Message-ID: <504f49cd5322d14d7c0d23d90f1cd7cc41721cf8.camel@redhat.com>
Subject: Re: [PATCH net] crypto: chtls: Fix possible null pointer
 dereferences
From: Paolo Abeni <pabeni@redhat.com>
To: Aleksandr Mishin <amishin@t-argos.ru>, Atul Gupta
 <atul.gupta@chelsio.com>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, Michael Werner
 <werner@chelsio.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
  lvc-project@linuxtesting.org
Date: Thu, 11 Apr 2024 08:20:23 +0200
In-Reply-To: <20240409090507.21441-1-amishin@t-argos.ru>
References: <20240409090507.21441-1-amishin@t-argos.ru>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 12:05 +0300, Aleksandr Mishin wrote:
> In chtls_pass_accept_rpl() and chtls_select_mss() __sk_dst_get() may
> return NULL which is later dereferenced. Fix this bug by adding NULL chec=
k.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Indeed a more describing changelog would be better given the patch
needs to go much fourther then adding a missing check.

> Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  .../chelsio/inline_crypto/chtls/chtls_cm.c    | 24 +++++++++++++------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c =
b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> index 6f6525983130..6d88cbc9fbb0 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> @@ -939,15 +939,15 @@ static void chtls_accept_rpl_arp_failure(void *hand=
le,
>  	sock_put(sk);
>  }
> =20
> -static unsigned int chtls_select_mss(const struct chtls_sock *csk,
> +static bool chtls_select_mss(const struct chtls_sock *csk,
>  				     unsigned int pmtu,
> -				     struct cpl_pass_accept_req *req)
> +				     struct cpl_pass_accept_req *req,
> +					 unsigned int *mtu_idx)

Bad indentation above.

More importantly, what about returning a negative value on failure and
avoid the additional parameter? It should also generate a smaller
diffstat.

>  {
>  	struct chtls_dev *cdev;
>  	struct dst_entry *dst;
>  	unsigned int tcpoptsz;
>  	unsigned int iphdrsz;
> -	unsigned int mtu_idx;
>  	struct tcp_sock *tp;
>  	unsigned int mss;
>  	struct sock *sk;
> @@ -955,6 +955,9 @@ static unsigned int chtls_select_mss(const struct cht=
ls_sock *csk,
>  	mss =3D ntohs(req->tcpopt.mss);
>  	sk =3D csk->sk;
>  	dst =3D __sk_dst_get(sk);
> +	if (!dst)
> +		return false;
> +
>  	cdev =3D csk->cdev;
>  	tp =3D tcp_sk(sk);
>  	tcpoptsz =3D 0;

[...]

>  static unsigned int select_rcv_wscale(int space, int wscale_ok, int win_=
clamp)
> @@ -1016,8 +1019,13 @@ static void chtls_pass_accept_rpl(struct sk_buff *=
skb,
>  	struct sock *sk;
>  	u32 opt2, hlen;
>  	u64 opt0;
> +	struct dst_entry *dst;

Please respect the reverst x-mass tree order.

>  	sk =3D skb->sk;
> +	dst =3D __sk_dst_get(sk);
> +	if (!dst)
> +		return;
> +
>  	tp =3D tcp_sk(sk);
>  	csk =3D sk->sk_user_data;
>  	csk->tid =3D tid;

Thanks,

Paolo


