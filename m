Return-Path: <linux-kernel+bounces-44264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE39841F99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0EE1F23EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194260895;
	Tue, 30 Jan 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiwKMwvC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9F6086C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607244; cv=none; b=Vl3sexDkI5cOArM3nw52tzoFA75MNcRnes7Giul3oU6rWlZDzgEsbiYf9/oZ9u8g+iLUIUhYrXWUdF/C7eQFE+3ZBprseKGO8gmsQ7PeeFLvb9EfGrXH1+pDj2D3bjQ1eQhR1eZbgXLnz8y2ONkxid9RJ30gy7E7we3ArLL8AqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607244; c=relaxed/simple;
	bh=ao2RpjY2LUNCgOWr5x3nVgPbi1Y3RKtOP0oAO1Yt0Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQVPk6NA7G30aCsfKpV6j0Acpm5AcKHMTbtB00FYNF6yN5IYxj+fuO3bC845197bYW7Ya3BIGQSJjQiLl5RmHsgNcGUedamr8+gGt7b8JbKeUSvY/1iG0o2BbfXUDF6MNOLts0pm+t+zRFJhriDySpo5OTx9WlKYltSPPC1QnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiwKMwvC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706607241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RW0RbQB0EYajyK8CwONcbCPbbzJZdg/vugpHX26+14A=;
	b=OiwKMwvCABx/WFw4w694HeiCNaStb7+lc7PYkHtow/VO9Hx13PlusAAkv70VyCSC74oBSh
	loNx4IMJAP5k7Y+fABKS4HaanmBhy+P3ouB2s6JGzqdlB4eL3sfCWEtHUWfyH9y0dJek86
	EZUt56pCtXmUBqBqr2kx/JKPu9++vIk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-6ke0meXOMGiIuA4ooPuXUg-1; Tue, 30 Jan 2024 04:34:00 -0500
X-MC-Unique: 6ke0meXOMGiIuA4ooPuXUg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3377bf95b77so57763f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607239; x=1707212039;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RW0RbQB0EYajyK8CwONcbCPbbzJZdg/vugpHX26+14A=;
        b=DZBGcgSYJeMgxaD5LHjG/4oBs2NJ6LmBVbL5NN7M9alDkoOCsId5gZwxIGRlyyOEsG
         zxrXvjUVi/Hq1HfRVaxdRexzx6RGns7yIcZskuWA6dL3S0ckcxxxpy9xp8x4wKD2+bvH
         z7IDEDt7fgmmFmqv1603zNuQgvvSnrXS2UhZZQe+//f3OT2w8ZVxUh918j9TNCtU+y2c
         z+GUQUimjp2sFB4h1c7TXUXPJmk76DJ758+xUgrix1fHLynnLBZP4QAmteEh4w8cCiiE
         0V69FL21a55cLXtMhhC9IoLWIrYZ24W5w/w1vEcTGaoyyAlnrmdZ9HUPji9U5OWMR8pl
         kB2Q==
X-Gm-Message-State: AOJu0Yz/PnhW7oEwFYmlyaEF5oV3ubmyXw565Ev+/D1mYI212F+7Hkt9
	haRGi/oNZu3ux1ei7l1kbU3ogKQmsXueahkJaqcWGD657XfByVfbqH1NmVmIpt+n8LmXSHhMRbc
	yhkf35wEE6RBDo/a4bX4iaAz3bUXq6ZP81E+/oBSNO7Ll28G2cn7GLIuPTU1lyA==
X-Received: by 2002:a5d:64e9:0:b0:33a:e3ac:330d with SMTP id g9-20020a5d64e9000000b0033ae3ac330dmr7668224wri.1.1706607238630;
        Tue, 30 Jan 2024 01:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLNFm/YJsv0yhq41SJvBod3BaJJkAQJdGWiDbGfLliJBSE416Qvk5KFIb1PwqDlaUsVt9b8g==
X-Received: by 2002:a5d:64e9:0:b0:33a:e3ac:330d with SMTP id g9-20020a5d64e9000000b0033ae3ac330dmr7668209wri.1.1706607238251;
        Tue, 30 Jan 2024 01:33:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b00337d4eed87asm10313643wrb.115.2024.01.30.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:33:57 -0800 (PST)
Message-ID: <cff078e234e94593fb3fcfce9732d7988ead42d3.camel@redhat.com>
Subject: Re: [PATCH net-next v6 2/2] net: add netmem to skb_frag_t
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Date: Tue, 30 Jan 2024 10:33:56 +0100
In-Reply-To: <20240123221749.793069-3-almasrymina@google.com>
References: <20240123221749.793069-1-almasrymina@google.com>
	 <20240123221749.793069-3-almasrymina@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I'm sorry for the late feedback.

On Tue, 2024-01-23 at 14:17 -0800, Mina Almasry wrote:
> @@ -845,16 +863,24 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct=
 *napi, unsigned int len,
>  }
>  EXPORT_SYMBOL(__napi_alloc_skb);
> =20
> -void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int =
off,
> -		     int size, unsigned int truesize)
> +void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, netmem_ref netme=
m,
> +			    int off, int size, unsigned int truesize)
>  {
>  	DEBUG_NET_WARN_ON_ONCE(size > truesize);
> =20
> -	skb_fill_page_desc(skb, i, page, off, size);
> +	skb_fill_netmem_desc(skb, i, netmem, off, size);
>  	skb->len +=3D size;
>  	skb->data_len +=3D size;
>  	skb->truesize +=3D truesize;
>  }
> +EXPORT_SYMBOL(skb_add_rx_frag_netmem);
> +
> +void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int =
off,
> +		     int size, unsigned int truesize)
> +{
> +	skb_add_rx_frag_netmem(skb, i, page_to_netmem(page), off, size,
> +			       truesize);
> +}
>  EXPORT_SYMBOL(skb_add_rx_frag);

Out of sheer ignorance, I'm unsure if the compiler will always inline
the above skb_add_rx_frag_netmem() call. What about moving this helper
to the header file?

> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 1184d40167b8..145ef22b2b35 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -636,9 +636,14 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
>  		for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++)
>  			msize +=3D skb_frag_size(&skb_shinfo(skb)->frags[i]);
> =20
> +		if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]))) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}

I feel like the following has been already discussed, but I could not
find the relevant reference... Are all frags constrained to carry the
same memref type? If not it would be better to move this check inside
the previous loop, it's already traversing all the skb frags, it should
not add measurable overhead.

Thanks!

Paolo


