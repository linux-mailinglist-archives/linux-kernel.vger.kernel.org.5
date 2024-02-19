Return-Path: <linux-kernel+bounces-70995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92005859F28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A291C20D45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1122F1D;
	Mon, 19 Feb 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umo7MM+1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3322618
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333512; cv=none; b=Ni+x7Lcfo1vVP5gu+xrJONhN280dRgygXte2rvMe3yo9z4fnd2/4XNR6fI63KVqX2PWWJlGXOKupiB7vZZo6XFJbL8U88m8O81/ylAn7ORV/uKNjj6S52vQ7zYLtieFmbpfJT/jOqEYa5k/jV3bvyc67BDTdTaSepJnwFdMK/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333512; c=relaxed/simple;
	bh=eQbzK6udwGnvj1Xh5Im+mUok/MbiejLYuLtoqIi3BAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXjOrPamlgNq+UugnenrGQNH9lDnC/gqew46I/03IRAg5M3F7s4guGaJH3Bebs322nGVwlL7fcXbN2DOnYeR2SZnKJt0H372zSYx+0Ec2jq2O28lprHyI2D1e8ccVintdVvChHHynjCJMqQtkbOhbaNNdIYthtAn4PeMXYR9g+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Umo7MM+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708333510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mvmiQ9Kd1nkve/0Looqf6/3ALADHPkqVvnShGJp77EI=;
	b=Umo7MM+1R9YaEygYEdxsxxaceu2Dfu4URk1UPbEPQXTQ20IstuYEjfnnCDfTYbWO3fQ1iV
	zpnYZkhJSTD56nrC68paGfPoKr8fFyeMwwdzlsAExsE9CYZvRvlBTQv4Cpno3l4m/kt1za
	E2hzqKkT29godyY/OyZqkdnHjier9/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-fPB08JqFP-S7eD72Ch1DCQ-1; Mon, 19 Feb 2024 04:05:07 -0500
X-MC-Unique: fPB08JqFP-S7eD72Ch1DCQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d1896e0d5so242987f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333505; x=1708938305;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvmiQ9Kd1nkve/0Looqf6/3ALADHPkqVvnShGJp77EI=;
        b=Se3enFgZkWHaS7Z7ph0zP4vrGT82vtUKMwnM67NE1wMebR3RmH1SG7BIOVtDB3ftBK
         S4cjM640zGalCmWY28+mBZWAcV8mV6WaZEQXYC0PwKPWcXUs1inzEMpPGrAf36yREP3r
         yaH81imEDou66TUnnYXehykelqavtOfwOqJcx6lyDX1gYN9BZJRIan8R1HTjbNI/xDR2
         6uIgNFp0ZpbrweEZ89SDARRNy5/crfZAoQBBYudj/ZM421DK8qwv74H7GT9ntfALlaT8
         6i5paa5mIJudjJ2izyzS5LYC4DCwTTJCA7cqas4VK78qjThHY6X5JB6vFnutEjN4QjoH
         B8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxHKzzzt0VvjuX2OLFzgmkWtCXfS3vn/GVNsPOppKVkqnsX6jOAc9Rl1t6JVF0HlYfCoOn4zZSUIu6S0ENu+0x7S3IvoiitegRvXsN
X-Gm-Message-State: AOJu0YxDzostcxjTIF8SGuctIZRBEyVQoSoh/SkZ7SVi64Izr9jbWaa9
	KfIttgolXhZiz/8HIhckOuhFFwcfwUAyLn/rCoxD1KnnmI+iowHkCqDY/EgvGxeFOq72bmpx+ob
	2QuUB7aentQJLtxuAUN1Z3ORkqQNS418H/jFmoPXGXUZTXd+gqNfTE7S4QKpIGtVgb7aZVg==
X-Received: by 2002:a5d:5a90:0:b0:33d:4921:6a6c with SMTP id bp16-20020a5d5a90000000b0033d49216a6cmr1928585wrb.1.1708333505759;
        Mon, 19 Feb 2024 01:05:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO72fn2SQV3CDUSdnp9eHGGASTUxZtTjOTPOw8p78etSSZmbkLg9LrLzyLb43w9V2QOv3n0g==
X-Received: by 2002:a5d:5a90:0:b0:33d:4921:6a6c with SMTP id bp16-20020a5d5a90000000b0033d49216a6cmr1928565wrb.1.1708333505400;
        Mon, 19 Feb 2024 01:05:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-135.dyn.eolo.it. [146.241.227.135])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe705000000b0033b8305ffe2sm9703340wrm.87.2024.02.19.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:05:05 -0800 (PST)
Message-ID: <e92bea31ff921ea072de86acc2694621fd11a016.camel@redhat.com>
Subject: Re: [PATCH net 1/2] ioam6: fix write to cloned skb in
 ipv6_hop_ioam()
From: Paolo Abeni <pabeni@redhat.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shuah@kernel.org,  linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Feb 2024 10:05:03 +0100
In-Reply-To: <20240216234356.32243-2-justin.iurman@uliege.be>
References: <20240216234356.32243-1-justin.iurman@uliege.be>
	 <20240216234356.32243-2-justin.iurman@uliege.be>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-17 at 00:43 +0100, Justin Iurman wrote:
> ioam6_fill_trace_data() writes inside the skb payload without ensuring
> it's writeable (e.g., not cloned). This function is called both from the
> input and output path. The output path (ioam6_iptunnel) already does the
> check. This commit provides a fix for the input path, inside
> ipv6_hop_ioam().
>=20
> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Tr=
ace ")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>  net/ipv6/exthdrs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 4952ae792450..f68e5faab3aa 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -943,6 +943,14 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int o=
ptoff)
>  		if (!skb_valid_dst(skb))
>  			ip6_route_input(skb);
> =20
> +		if (skb_cloned(skb)) {
> +			if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
> +				goto drop;

My personal preference would be for using skb_ensure_writable() here,
with write_len =3D=3D optoff + hdr->opt_len.

> +
> +			hdr =3D (struct ioam6_hdr *)(skb_network_header(skb) + optoff);
> +			trace =3D (struct ioam6_trace_hdr *)((u8 *)hdr + sizeof(*hdr));

Note that this can potentially change the network header ptr and the
caller - ip6_parse_tlv() - has cached such value in 'nh'. You also need
to update ip6_parse_tlv() to reload such pointer.

Side note: a bunch of self-tests are apparently stuck after this
series. I think it's an unrelated problem. I'll try to have a better
look.

Cheers,

Paolo


