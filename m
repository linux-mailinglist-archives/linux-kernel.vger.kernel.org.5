Return-Path: <linux-kernel+bounces-154704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE508ADFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07E41F23F33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030D55E43;
	Tue, 23 Apr 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXQ8UUt9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3B63C8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861656; cv=none; b=hJ0HpFh1L9KgvRb8uvXD47WSUS6ebgKZ2nhZWmV8613hcIeypZk7/cAnggrCTrlIAUA5hPP9LvtMF/Blvc3MY+CBb8wAo1Ry+uQ82tkE6PluBwKXtez7gJlfAS17e4wwjlswtYEvg1wh8MBvw7TDPhaQBexd2e6Y1jAg49VZ9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861656; c=relaxed/simple;
	bh=a1StSV/DuHC2xEPRVESsMkc2H07ehAxDi0sWxQQg81g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnBC5WCPC5xbrVYSDdz3tcNalLhFNkVDWGN3bLje42dhCUO/IGEn5KLZ8nMycxeS8pp6QcPGQW9Szv8MKSA3yLETODFY/NWcvZVM8V6A3lj+XXkWyGkY6M7Juzojyj7fb7T8TmHaKeAJ7DK0vFTJl3w5EZdWSpUfuVkLfKZ4vG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXQ8UUt9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713861653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WBhy2NIZyHBCakG2u3+dlgMj9SbpEWO/Yr2w1puTclg=;
	b=BXQ8UUt9d82HYdhhv6Xbd8ynzk659ExhuoDGHN7wx4UfkjET3iuj75hRVMnduVu8UqgYEc
	NAMCbMvzWUm8kDvAxn9d0yBnoNaCktqOPIQ1yv/GQuiC0TYWdqNQthM+MHvXXKL7O6L/YO
	0Ryh9OqexgYI7Bf7DIWD4+o1TdkNcsU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-siW2lzHFOZGeR7P7D49eQg-1; Tue, 23 Apr 2024 04:40:52 -0400
X-MC-Unique: siW2lzHFOZGeR7P7D49eQg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3450bcc1482so735763f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861651; x=1714466451;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBhy2NIZyHBCakG2u3+dlgMj9SbpEWO/Yr2w1puTclg=;
        b=v9XikzHWKqhA31mT+Qb6vWjumAh5NUFO6OAfOA8zx9lfIr7qS0h+oaZNN+Tso3HWNu
         DQDPf1LB/7ogXBgfWnqg+XABlJ47Z3ci2KvNm5XyAUzVbzrhpJO6wIP6coycLXfjEhdp
         Yt0MlN6xljaEphx+mRwjrsYtGMrrLYzPesWnZvPhSIqIFG2R6Yd9gqeK/Om65nyt0Uon
         dTLbwbc41l9tBQlRDQWMUp+AJ9kL3sIsAnV11H2buEPLJR6CtvEKM4XUmyeBUk75z6Jt
         zKYi8Vi1CCwaho1G+Gk2JKnGLrTpowE+DP8X2IkZS4Ux/+w1oEAcjEFMHdpEAMF738CM
         mBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZYnqcjIcmXGBqDmtIVB3yslT+iFi/bOs1/tcdpsxjQoqgLv4/XIMqOXvWotBAZc+INdhELeEofAl6h86L29zFQDPIjGnhoOSYEH/U
X-Gm-Message-State: AOJu0YxJdRRRr1JgI31V+HzVGT2Yl+hrqESyBbCdX4TDTBPP/LIF/qeG
	G/2IPZdHXyH3pOIhj+qEomZ15/npaUrfsRxuNXJoiR0OCmWDoa+HrHZdpswGv2zw5KfZGGXKgwR
	B+7vKAqpkA05Oa+jjsWfElaSS5vMXXcrYfbnmSwxNbH9CRG2BhJUQoyIhpT9znA==
X-Received: by 2002:a05:600c:3ca4:b0:41a:bb50:92bb with SMTP id bg36-20020a05600c3ca400b0041abb5092bbmr696569wmb.0.1713861650915;
        Tue, 23 Apr 2024 01:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuYGM+Izwbr16myDEMQ3YHgPrdTyUYh8tJVaQzd3+LFEzph55+XImIQrAxk2Nx1xsGhnoCdQ==
X-Received: by 2002:a05:600c:3ca4:b0:41a:bb50:92bb with SMTP id bg36-20020a05600c3ca400b0041abb5092bbmr696555wmb.0.1713861650500;
        Tue, 23 Apr 2024 01:40:50 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b0041892e839bcsm19505308wms.33.2024.04.23.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:40:49 -0700 (PDT)
Message-ID: <6123223eaf54ea6f492c896d81551315a1e38f66.camel@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mt7530: simplify core
 operations
From: Paolo Abeni <pabeni@redhat.com>
To: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, Daniel
 Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com,  erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 23 Apr 2024 10:40:47 +0200
In-Reply-To: <20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-2-3b5fb249b004@arinc9.com>
References: 
	<20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-0-3b5fb249b004@arinc9.com>
	 <20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-2-3b5fb249b004@arinc9.com>
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

On Thu, 2024-04-18 at 08:35 +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> The core_rmw() function calls core_read_mmd_indirect() to read the
> requested register, and then calls core_write_mmd_indirect() to write the
> requested value to the register. Because Clause 22 is used to access Clau=
se
> 45 registers, some operations on core_write_mmd_indirect() are
> unnecessarily run. Get rid of core_read_mmd_indirect() and
> core_write_mmd_indirect(), and run only the necessary operations on
> core_write() and core_rmw().
>=20
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  drivers/net/dsa/mt7530.c | 108 +++++++++++++++++++----------------------=
------
>  1 file changed, 43 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 64b1f6320b9a..e0cb194019f8 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -74,116 +74,94 @@ static const struct mt7530_mib_desc mt7530_mib[] =3D=
 {
>  	MIB_DESC(1, 0xb8, "RxArlDrop"),
>  };
> =20
> -/* Since phy_device has not yet been created and
> - * phy_{read,write}_mmd_indirect is not available, we provide our own
> - * core_{read,write}_mmd_indirect with core_{clear,write,set} wrappers
> - * to complete this function.
> - */
> -static int
> -core_read_mmd_indirect(struct mt7530_priv *priv, int prtad, int devad)
> +static void
> +mt7530_mutex_lock(struct mt7530_priv *priv)
> +{
> +	if (priv->bus)
> +		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +}
> +
> +static void
> +mt7530_mutex_unlock(struct mt7530_priv *priv)
> +{
> +	if (priv->bus)
> +		mutex_unlock(&priv->bus->mdio_lock);
> +}
> +
> +static void
> +core_write(struct mt7530_priv *priv, u32 reg, u32 val)
>  {
>  	struct mii_bus *bus =3D priv->bus;
> -	int value, ret;
> +	int ret;
> +
> +	mt7530_mutex_lock(priv);
> =20
>  	/* Write the desired MMD Devad */
>  	ret =3D bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
> -			 MII_MMD_CTRL, devad);
> +			 MII_MMD_CTRL, MDIO_MMD_VEND2);
>  	if (ret < 0)
>  		goto err;
> =20
>  	/* Write the desired MMD register address */
>  	ret =3D bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
> -			 MII_MMD_DATA, prtad);
> +			 MII_MMD_DATA, reg);
>  	if (ret < 0)
>  		goto err;
> =20
>  	/* Select the Function : DATA with no post increment */
>  	ret =3D bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
> -			 MII_MMD_CTRL, devad | MII_MMD_CTRL_NOINCR);
> +			 MII_MMD_CTRL, MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR);
>  	if (ret < 0)
>  		goto err;

What about a possible follow-up, moving the above writes in a separate
helper (say, 'core_select_register' or the like) and reusing it here
and in core_rmw() ?

Not blocking this series, I'm applying it.

Thanks,

Paolo


