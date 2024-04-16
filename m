Return-Path: <linux-kernel+bounces-146561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD48A6742
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0C4282BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0412B86244;
	Tue, 16 Apr 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSgR5i+v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD273FE2A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260214; cv=none; b=rwHHH3wj3L9KvIwMVP3KR+wa82t84EcaiwBIvnbsNXpnNqX89ZXGQPINw7dgWzvXbbIm36nrm4X9PrIOhjWFpQhMWaUF7OXlWC51PaT396NMe5b07miK8PEyVz/5LaC5k2LsYfJFuqbkW2IgSBAPi9zTWFCrtf0dmoXw88Mb2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260214; c=relaxed/simple;
	bh=kxTK5eeqJerMpdWNlVqD3ofPJ7M8H8JJIjEA6XxFD0M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJ3l0ELCvAO1+FN20YXcMrRsgKebsjwcl3t+hHkzbeewFYb0gT7LP6jb+MxVUy04+r4KCj33WQKxlIZnN7VJAweNB8Y/PRIftFiI5KIvfa71N8Vk26MJcHNmQ3ojsoEFcTdi8so/fM3kGedbc8AIiA6Au/3EidTapIPj+4PF2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSgR5i+v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713260211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d6K1HSOBXpj3fBHNyA3haeOiXGnGpt7qXiF/PDawe5Q=;
	b=DSgR5i+vFhy1iJ8bWUsOrOsWcqiVZxsaWLDIZYZibb2eAaDDqx2aSSSeb0xta4ckccwaCy
	bYf4dP8T1OjUEn4s1qhlMxSttL779+cTAwjvYnKoOfTLZefFffa7dWdsOqFi1Wm40yPJsN
	43CwYaB7RExEnYP1nQQRo+UbqMqewHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-aBOEtCddNYCbxEvrxFT8Mw-1; Tue, 16 Apr 2024 05:36:49 -0400
X-MC-Unique: aBOEtCddNYCbxEvrxFT8Mw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3457b0dca26so175434f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260208; x=1713865008;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6K1HSOBXpj3fBHNyA3haeOiXGnGpt7qXiF/PDawe5Q=;
        b=lkT4X37jvssTKgGiBeMDsBW7FgE6d8W9jwTpDM/7Rvg5QVGK0sm3J8ZdiZQHTk/TBu
         1IvcO9y0pUZiArXWhRO+YOXKWnixZCGNa8d9DTDoYPbByy8OAxM9K9DTmi/7/2+q0j2f
         lUo63+j2/QmFNzFj+zmyXCMmnI3jC7YFvM9QVsph6yXsy3xvOO6S+937Sw7BXqvqXh3o
         5S4d/RsVhKABB5ixVAAHA6pq0KAY3xbHGGNd56vyhaLr4keMlkcVrUtqaXZZNV4roAaf
         Sqkuzs23wvIzsLhHsV5gyrjVmhD5zd6zq/QKq9atXEGV1z4E/fXRf5Qf5n9R5wX2oMxH
         HqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoK4LlJ5YzLyHMYVsRpSOxA2EwrcTQMUU3s+w0r34FA74UoXvQJqtq3Cyu8BxuwdnI+0bXk2TgZMzBFzUE2Fdga0GtgLoXZfGXuxVe
X-Gm-Message-State: AOJu0YxbSx1j/VOtrIKg69xr6YctxpL1qZ8xz4ycf4wNGy5796tlaiEW
	X+yT5OJd87lMVTgRBOE0zwNmZN1YPeAOTXybRjOIcPau1ZMrTxNw5/RUsNcwxfxGaPXe+jwYC5c
	Xl+SmPmKv9YbVv12BJmFKiP3PIlwU3p9PPuc8ddM6wKirnd2K0uDd+TdZciUvlg==
X-Received: by 2002:a05:600c:12c8:b0:418:1303:c3d1 with SMTP id v8-20020a05600c12c800b004181303c3d1mr7774276wmd.3.1713260208382;
        Tue, 16 Apr 2024 02:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw4qY7gHO2mn0PPXIBwrMQK1KjT84OU1S5ZwAv83rujj1xs/xKgiXA5twSvoSg66EaYt+OVA==
X-Received: by 2002:a05:600c:12c8:b0:418:1303:c3d1 with SMTP id v8-20020a05600c12c800b004181303c3d1mr7774267wmd.3.1713260208022;
        Tue, 16 Apr 2024 02:36:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0041668053ca9sm1159712wme.0.2024.04.16.02.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:36:47 -0700 (PDT)
Message-ID: <49dafb7c4d4aef2946dac86296c29dc4c9b993d4.camel@redhat.com>
Subject: Re: [PATCH net-next v7 1/3] net: gro: add {inner_}network_offset to
 napi_gro_cb
From: Paolo Abeni <pabeni@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 16 Apr 2024 11:36:46 +0200
In-Reply-To: <20240412155533.115507-2-richardbgobert@gmail.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
	 <20240412155533.115507-2-richardbgobert@gmail.com>
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

On Fri, 2024-04-12 at 17:55 +0200, Richard Gobert wrote:
> This patch adds network_offset and inner_network_offset to napi_gro_cb, a=
nd
> makes sure both are set correctly. In the common path there's only one
> write (skb_gro_reset_offset).
>=20
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Does not apply cleanly to net-next. You have to wait until the net
dependency is merged into net-next before posting.

> ---
>  drivers/net/geneve.c           |  1 +
>  drivers/net/vxlan/vxlan_core.c |  1 +
>  include/net/gro.h              | 18 ++++++++++++++++--
>  net/8021q/vlan_core.c          |  2 ++
>  net/core/gro.c                 |  1 +
>  net/ethernet/eth.c             |  1 +
>  net/ipv4/af_inet.c             |  5 +----
>  net/ipv4/gre_offload.c         |  1 +
>  net/ipv6/ip6_offload.c         |  8 ++++----
>  9 files changed, 28 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 9c18a39b0d0c..a6256ea1f5bc 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -545,6 +545,7 @@ static struct sk_buff *geneve_gro_receive(struct sock=
 *sk,
>  	if (!ptype)
>  		goto out;
> =20
> +	NAPI_GRO_CB(skb)->inner_network_offset =3D hlen;
>  	pp =3D call_gro_receive(ptype->callbacks.gro_receive, head, skb);
>  	flush =3D 0;
> =20
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index 6fb182d9d6e7..9fb93c3953c1 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -754,6 +754,7 @@ static struct sk_buff *vxlan_gpe_gro_receive(struct s=
ock *sk,
> =20
>  	vh =3D vxlan_gro_prepare_receive(sk, head, skb, &grc);
>  	if (vh) {
> +		NAPI_GRO_CB(skb)->inner_network_offset =3D skb_gro_offset(skb);
>  		if (!vxlan_parse_gpe_proto(vh, &protocol))
>  			goto out;
>  		ptype =3D gro_find_receive_by_type(protocol);

What about vxlan_gro_receive? and fou/gue?

Side note: the latter apparently exist mainly to make UDP-related
changes more difficult, can we deprecated them once for all?

Thank,

Paolo


