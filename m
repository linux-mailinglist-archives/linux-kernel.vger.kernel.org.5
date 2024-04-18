Return-Path: <linux-kernel+bounces-149735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E8C8A9530
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2E6281F91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03971586EE;
	Thu, 18 Apr 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY6jqDJQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470201E489
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429704; cv=none; b=NLqb2r8RVhbWwvwiqUgdDVSf32d5wWAOebwuGpAZzgWeUF3MCy5ZX8a7bncWN7SpaT5HEnN8QLguScKHpwYfKECKXcAq2YokSQOzgzYsFyIO5yDcpZn5Csfy2ZOHIe0IohTuMZ1EL9LPmYhZoxJp8/iPZPq7uHe9b+aYCuOyfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429704; c=relaxed/simple;
	bh=mmIqQThqr4X7osoH9eo1/TXkO6YWjRUHZTNxbSl+WsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+rGtQC7grVcp/037+9OUnzSIiPl0ut6KypuH+dpNH2uR3XdoHbUbkwZo+1YKunvoXPbR9i2T3peTKtBtxlvM0q4pvg1tB60jCMyt62Tn4jgCDLsxC9dISUvxGC0Jl1oLSiiE6xN4Bmv4+G8LWo60cv5Owr0CSDLp+oxarngk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cY6jqDJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713429702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cFbNEihV6/PeFco2xXBFktNQkAiNk5YHzWf5yzHaxsM=;
	b=cY6jqDJQYCkfFEHfMxf3C1JEXn13Ex1T8wyZEr8m9aRdvOphh2PBs/jx6fXg566/1OUJOf
	NrlhIAiJyDjDWcq3QhtQZynNl3PHMHMoR1qvgAVRs083BtoXLpZ2Z4NCD8BWUZI6wzD4RQ
	Ktgq33x24NjJVTflrH8oAGgBV2g02ko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-zn0m0t2MOFuMOVlNO4GcPQ-1; Thu, 18 Apr 2024 04:41:40 -0400
X-MC-Unique: zn0m0t2MOFuMOVlNO4GcPQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-349a31b3232so61690f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429699; x=1714034499;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFbNEihV6/PeFco2xXBFktNQkAiNk5YHzWf5yzHaxsM=;
        b=c/15k65RpYr2lKTYeWnxsSgVRmz6M1yGVuIirpXOBLaWkHF04a6baB1SVaj6lFcYav
         1AdNFxau95BbiIi99kZojTIF5PRnwp51STGF72E3/mkzqCfzHx8IKel7eegojF9tEPix
         zxV1rqbXR8lyjh4lxDBqwIAv/EtkNakXrXQ/hiCFl4QRQDMNLl3UFCrlNxk/Zrh5pfDt
         CL2dNrR/o7RUfqHwB+sYtGAZxdnIK9dnqGe7Exv9lCMswSjEs4QNAKhMTN57pdXVEWCa
         vasgArxkE3wtVTlKrltyH1cDQiZV0pkyhdO41V5VQVC+mmzG5tsV0s8fTRWuNo3I7RXb
         /CLg==
X-Forwarded-Encrypted: i=1; AJvYcCXO6g8m8B56G66puK0NTWNtbTxGsLdFnxdOCslN+2Yb05/N94WhnWQIr3j0HQYuQWzpuQzvUZvhybnJOHXpZ849qtFPg59+3u0zsCg0
X-Gm-Message-State: AOJu0Yzi1kpTJGS/Zi2M9fL9V79CCQtZdjQaK9x7k+EeTvySNppUQn5f
	msajw+acLvQDj93yIg6VvC+qGm9i1jERJpEGq1eLTPyMCEi9twomMNojyirmWcGUQAZrJ6SfhGf
	6HUK5MRe+TIf8gyXXxBuuxtjEQdwGWI5YUbEIsBVChHCGNC15nqy/FmEb4VLv6Q==
X-Received: by 2002:a05:600c:5101:b0:416:a773:7d18 with SMTP id o1-20020a05600c510100b00416a7737d18mr1402689wms.0.1713429699260;
        Thu, 18 Apr 2024 01:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfngHXsqhmDGA5ZOpni6b28iBCu2HjDMpd0f+o+x8UrP8gVaEfXo9RZoNzJS/VxTpzMyivA==
X-Received: by 2002:a05:600c:5101:b0:416:a773:7d18 with SMTP id o1-20020a05600c510100b00416a7737d18mr1402665wms.0.1713429698844;
        Thu, 18 Apr 2024 01:41:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm1901310wmo.36.2024.04.18.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:41:38 -0700 (PDT)
Message-ID: <90c5d1b6747d7699ebec50168672f1c435269e7f.camel@redhat.com>
Subject: Re: [net-next PATCH v5 2/4] test: hsr: Move common code to
 hsr_common.sh file
From: Paolo Abeni <pabeni@redhat.com>
To: Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,  Oleksij Rempel
 <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Simon Horman <horms@kernel.org>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Jiri
 Pirko <jiri@resnulli.us>, Dan Carpenter <dan.carpenter@linaro.org>,  Ziyang
 Xuan <william.xuanziyang@huawei.com>, Shigeru Yoshida
 <syoshida@redhat.com>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 linux-kernel@vger.kernel.org
Date: Thu, 18 Apr 2024 10:41:36 +0200
In-Reply-To: <20240415124928.1263240-3-lukma@denx.de>
References: <20240415124928.1263240-1-lukma@denx.de>
	 <20240415124928.1263240-3-lukma@denx.de>
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

On Mon, 2024-04-15 at 14:49 +0200, Lukasz Majewski wrote:
> Some of the code already present in the hsr_ping.sh test program can be
> moved to a separate script file, so it can be reused by other HSR
> functionality (like HSR-SAN) tests.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  tools/testing/selftests/net/hsr/hsr_common.sh | 96 +++++++++++++++++++
>  tools/testing/selftests/net/hsr/hsr_ping.sh   | 93 +-----------------
>  2 files changed, 99 insertions(+), 90 deletions(-)
>  create mode 100644 tools/testing/selftests/net/hsr/hsr_common.sh
>=20
> diff --git a/tools/testing/selftests/net/hsr/hsr_common.sh b/tools/testin=
g/selftests/net/hsr/hsr_common.sh
> new file mode 100644
> index 000000000000..822165391573
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_common.sh
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Common code for HSR testing scripts
> +
> +ret=3D0
> +ksft_skip=3D4
> +
> +sec=3D$(date +%s)
> +rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
> +ns1=3D"ns1-$rndh"
> +ns2=3D"ns2-$rndh"
> +ns3=3D"ns3-$rndh"

Since you are touching the initialization code, please move it to using
the lib.sh helpers. The above will become:

setup_ns ns1 ns2 ns3

> +
> +cleanup()
> +{
> +	local netns
> +	for netns in "$ns1" "$ns2" "$ns3" ;do
> +		ip netns del $netns
> +	done
> +}

And this:

	cleanup_all_ns


Thanks,

Paolo


