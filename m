Return-Path: <linux-kernel+bounces-166421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94D8B9A68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C82286E94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C577F13;
	Thu,  2 May 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1gJ4OIp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF96341B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651357; cv=none; b=gHCqCuUAri44WqPPDLl0TRHH2nxv8KjTY4ZKkTpvLmLD3x5ZjHvIlM4ciAM51Ihr6PXCjZCz2l/9B69tLepExlckTQ8eZg9/LASDxXuxfIJIIyddnH7f329gWP7HNhHk9/UY3nBK7p7QK4VCS6Fq+nR+DG6MnEbs0AtTxhlS56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651357; c=relaxed/simple;
	bh=5LCtxE1foP4p42pbTXYapXqnE7N4+pBu402ePprtg7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNuyiKR/8blcRR1tskrL4f0RYp4AtuHygXrus6jdxUGoPrHOYUVrkOyrBYAqxm16pOTDJWMqqOCzLZhYX+V0sXgLGQAKcuAIEIovFLiXEGQHRwHd06Dmwxm9jYVdgvLbDLCy7+OZH3LUPzyxzY2KywOplqDMhaCBBLvN0A1XtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1gJ4OIp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714651354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XfXBI1UCEocbU9bnKa0OdkUDyFRe6Bw2+hz1Q8popRQ=;
	b=S1gJ4OIpsY/cYbkBBlE3L1xQktd4SwWzRnW538cPkf8n6GIk7AdJ3iib6RT2J9KVD4Jrwk
	gt+dhpKU3uYAWZO+u8D979LXwDKOYXImLgIQ/ANQlD9qNp7IHhcodzbIRgwAFNRggd9fYC
	D16B1J25sMaD5O4KV1MoBnGXOtudobo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-3-O3ajsfPHyu1-BpL3NCkA-1; Thu, 02 May 2024 08:02:33 -0400
X-MC-Unique: 3-O3ajsfPHyu1-BpL3NCkA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d8647f923fso12193831fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 05:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714651351; x=1715256151;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfXBI1UCEocbU9bnKa0OdkUDyFRe6Bw2+hz1Q8popRQ=;
        b=dN+foWHbVmQ0mKhFyY1B8KI0A/6LYfXcgQ7Q0bAkihXo2UrlY/QBPO7HRVbzreqNrd
         y/wmYJ65vPluOtnWr1HAn0k2hiS2Twx5gxMO2c6JqfKW11vaZDxRc68NsZoLRFawzAPR
         8LtBRzM0vN+SALNYKgKMftM/WMHu+9sokidLGRvINXpSsFTYXh4OJiuP0OjTc6LFPa8d
         ADxKdec/vk6wu0CtVbabh3elPSHmKeJ54rW7p7RkPxIjNx7hLPaYE0cK/lBpaHxP91IS
         A33DejwxSN7PuYQVlc2HlVHZyRsrBpKt4h47tY/O/KzFPyyVsWM+jxTqWt5Blg7OmFKv
         xQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHhFgcZgaH2/WUN5+rM2MxRaxT0xNGhzb8G/HQjB7Pz+EJxiJbantjfDkh16GCUCY+l4OV7ip4kiuRW6rj2P6puh4bg+p8j9EFuq/
X-Gm-Message-State: AOJu0YxiqGqAOLCtP58MdAnc+HqQ4JANVBJQY05KvCsPBJAcUPlKzAzi
	OA26ZQMXERRIZL19Np1ZW1BGWecbJWAl+83JFqLzjylL0915EzsqwnE4JuyeYnp1UjXeGqjE0ft
	NgZZoa0zaQD/2jTELRjzMLrLIUfG/4IEv+CZGw8GTuwM8c+D7GYltC7vNGkV60Q==
X-Received: by 2002:a2e:8005:0:b0:2d8:5d78:d4f5 with SMTP id j5-20020a2e8005000000b002d85d78d4f5mr3230866ljg.4.1714651351529;
        Thu, 02 May 2024 05:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcPqJzAlwciurUryFPLth5j5uUrvMbzyjCr5B9NBxCGEVa+xdAr7J6OIi068BtXjl2HFtRKw==
X-Received: by 2002:a2e:8005:0:b0:2d8:5d78:d4f5 with SMTP id j5-20020a2e8005000000b002d85d78d4f5mr3230841ljg.4.1714651351085;
        Thu, 02 May 2024 05:02:31 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510::f71])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b0041b43d2d745sm1735008wmq.7.2024.05.02.05.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 05:02:30 -0700 (PDT)
Message-ID: <cc9eae8f17e3e0ad142c9efa3fe5dff7afe2554c.camel@redhat.com>
Subject: Re: [PATCH net-next v5] net: ti: icssg_prueth: add TAPRIO offload
 support
From: Paolo Abeni <pabeni@redhat.com>
To: MD Danish Anwar <danishanwar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Jan Kiszka
 <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Diogo Ivo
 <diogo.ivo@siemens.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Cochran
 <richardcochran@gmail.com>, Roger Quadros <rogerq@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com, Roger
 Quadros <rogerq@ti.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 02 May 2024 14:02:28 +0200
In-Reply-To: <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
References: <20240429103022.808161-1-danishanwar@ti.com>
	 <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
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

On Thu, 2024-05-02 at 13:59 +0200, Paolo Abeni wrote:
> On Mon, 2024-04-29 at 16:00 +0530, MD Danish Anwar wrote:
> > +static int emac_taprio_replace(struct net_device *ndev,
> > +			       struct tc_taprio_qopt_offload *taprio)
> > +{
> > +	struct prueth_emac *emac =3D netdev_priv(ndev);
> > +	struct tc_taprio_qopt_offload *est_new;
> > +	int ret;
> > +
> > +	if (taprio->cycle_time_extension) {
> > +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not support=
ed");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
> > +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than=
 min supported cycle_time %d",
> > +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
> > +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than=
 max supported entries %d",
> > +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (emac->qos.tas.taprio_admin)
> > +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
>=20
> it looks like 'qos.tas.taprio_admin' is initialized from
> taprio_offload_get(), so it should be free with taprio_offload_free(),
> right?
>=20
> > +
> > +	est_new =3D devm_kzalloc(&ndev->dev,
> > +			       struct_size(est_new, entries, taprio->num_entries),
> > +			       GFP_KERNEL);
> > +	if (!est_new)
> > +		return -ENOMEM;
>=20
> Why are you allocating 'est_new'? it looks like it's not used
> anywhere?!?=20
>=20
> > +
> > +	emac->qos.tas.taprio_admin =3D taprio_offload_get(taprio);
> > +	ret =3D tas_update_oper_list(emac);
> > +	if (ret)
> > +		return ret;
>=20
> Should the above clear 'taprio_admin' on error, as well?=20

Side note: the patch itself is rather big, I guess it would be better
split it. You can make a small series putting the the struct definition
move in a separate patch.=20

Thanks,

Paolo


