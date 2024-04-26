Return-Path: <linux-kernel+bounces-159694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B68B324B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A701F22D90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822B713D244;
	Fri, 26 Apr 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS1nYXQA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8B13CAB6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120132; cv=none; b=ZTlyFSUbVtI75khuU+lx4qOrRS2unHTmfpKp/MSYOXg21CabCUE7qlvtVMYAdhlvL9Ugw7x+gkTQxjHTkfDfzPBRPipLHEbRmTQOh+pLLLpppKEodE+4++fRUQx3yIWdoEudybxbxE06jEw/410TSgfplQwe2e9iz0MZvbrpAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120132; c=relaxed/simple;
	bh=WA61/ui+nH82rqHb2wTcm08Cd71Jxu6Am2DFhgmVISI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcRXzk+RDwZM1wrGT0l7O8RfKhPkog8l1m47p4Bjj8F7mbObkmRctbjoXzJxpm/UHUn4nbIKRvHfCH/x93RaQAa10YEAkVk4m0dUYmH0TnEQqOUJ32Cy20faSGiNP4AA1wU2zE2e/3ZXtRJzdmKkf0tG+Ihqp+X7UKonf/HDFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BS1nYXQA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714120130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WCXftq/Pi/FoSY2yQL7BvthvUBhdUHFKfL7FdTt4ESE=;
	b=BS1nYXQAyeXhzRKg1iJHvLxtG6/oomlfxehcZgXnRV6+yxQx6XqIGBspxXNyCgvLFiSAEh
	yIvhO2P+3OsylKjD/agLQnAKz0meS71UnEQwLvy8QqAYce2yA2bQfrLhADrNTZAFaiknfd
	bgMLBs7TnZtcyFPB5HmpaGfU+FzgQUU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-8KG4PDFPPd2DJkOj8DLYRg-1; Fri, 26 Apr 2024 04:28:48 -0400
X-MC-Unique: 8KG4PDFPPd2DJkOj8DLYRg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4188cfbabf6so2492055e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714120127; x=1714724927;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCXftq/Pi/FoSY2yQL7BvthvUBhdUHFKfL7FdTt4ESE=;
        b=SttGi8uSFGkFT5NBz/QqR2GqHrLHF4DzXGrhguK8IwiAee3SMN1jAUIR0lZlvgxo+F
         yr/shrjKY2nhHHrjbL07kYRGvueTtJOtrjdRFYI3a/Jze+HEwHOG36wHYYf+PRpXFs05
         kYpAHPqa/H1SKY7CW3dKcFfA8erWMVRiOmGP7uZTZvFgvmW6qy8a0+4Hu7xeUsCqmVHL
         cm6wPwWHgh+jrJnDoROizXZEnWWtBeBrAq4UmBkJc3kQ/xT8ueVciqiO4P9vrRrNVzlH
         LTM1lrtq8nEDpDOPEOx+EkHePCgzGyysxvdB90uoHJl9bRcmQJhAMx2matgx2p9P5SEQ
         ZKsg==
X-Forwarded-Encrypted: i=1; AJvYcCVlKW97p/jm/NDvtJcCY4MNxZOK+g9JX15NLKcn0VKEJS8di3SvgXp6B1fJ2d3fRc5tfgNXMXEwnfpRLHquyrYj2U9vppQXvSSz8jHw
X-Gm-Message-State: AOJu0YxcryuCweZH6NlJYd/4gcewYLbhikP/ZEKsCNNEEOhluZq3vDHa
	9VaPCZC7vUbOdQlcnvig7nfutjwo0xNUP+vRt0pbkVoOxgmf05su1HKDM5fX+/+z/zZboDB2T0m
	yov8R02xRIFj2v2VdMre86Eqcsq3/M1zGcPNFTCvSBtrNB+CtzoAhUysYvWVOvQ==
X-Received: by 2002:a05:600c:3b24:b0:418:ef65:4b5f with SMTP id m36-20020a05600c3b2400b00418ef654b5fmr1286847wms.3.1714120127429;
        Fri, 26 Apr 2024 01:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElo2ipPUo/eJFVuG7iQA8h2xs4TnqRvMnNjJIhqB4/V/M4QZwkvwCzEbrvt/XF6M7KiDMihA==
X-Received: by 2002:a05:600c:3b24:b0:418:ef65:4b5f with SMTP id m36-20020a05600c3b2400b00418ef654b5fmr1286827wms.3.1714120127068;
        Fri, 26 Apr 2024 01:28:47 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm21665797wri.103.2024.04.26.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:28:46 -0700 (PDT)
Message-ID: <5a95fea4156b492eb19124bb33b21be81766c617.camel@redhat.com>
Subject: Re: [PATCH v3 net-next v3 2/6] net: add support for segmenting TCP
 fraglist GSO packets
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:28:45 +0200
In-Reply-To: <20240426065143.4667-3-nbd@nbd.name>
References: <20240426065143.4667-1-nbd@nbd.name>
	 <20240426065143.4667-3-nbd@nbd.name>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 08:51 +0200, Felix Fietkau wrote:
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 65 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  3 ++
>  2 files changed, 68 insertions(+)
>=20
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fab0973f995b..c493e95e09a5 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -28,6 +28,68 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsign=
ed int ts_seq,
>  	}
>  }
> =20
> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> +				     __be32 *oldip, __be32 *newip,
> +				     __be16 *oldport, __be16 *newport)
> +{
> +	struct tcphdr *th;
> +	struct iphdr *iph;
> +
> +	if (*oldip =3D=3D *newip && *oldport =3D=3D *newport)
> +		return;
> +
> +	th =3D tcp_hdr(seg);
> +	iph =3D ip_hdr(seg);
> +
> +	inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
> +	inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false);
> +	*oldport =3D *newport;
> +
> +	csum_replace4(&iph->check, *oldip, *newip);
> +	*oldip =3D *newip;
> +}
> +
> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *seg=
s)
> +{
> +	struct sk_buff *seg;
> +	struct tcphdr *th, *th2;
> +	struct iphdr *iph, *iph2;
> +
> +	seg =3D segs;
> +	th =3D tcp_hdr(seg);
> +	iph =3D ip_hdr(seg);
> +	th2 =3D tcp_hdr(seg->next);
> +	iph2 =3D ip_hdr(seg->next);
> +
> +	if (!(*(u32 *)&th->source ^ *(u32 *)&th2->source) &&
> +	    iph->daddr =3D=3D iph2->daddr && iph->saddr =3D=3D iph2->saddr)
> +		return segs;

As mentioned in previous revisions, I think a problem with this
approach is that the stack could make other changes to the TCP header
after the GRO stage, that are unnoticed here and could cause csum
corruption, if the egress device does not recompute the packet csum.

Cheers,

Paolo


