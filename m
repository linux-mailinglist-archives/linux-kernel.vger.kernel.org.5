Return-Path: <linux-kernel+bounces-149743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801208A954A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92501F21BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78123158A05;
	Thu, 18 Apr 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKD6jw9g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBB7B3FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430070; cv=none; b=BPT5VKISRLTVMAz+9w+QVxS9wgW/jXOGsrUyD3TTIaPDIxBuZS2j8fUvhOAT/firwPzdae0VSIB0rKkR2izJzvZ9vRtNN6jasjPOInSNQHWpp5hB0Dp7bm3CephCN6Hs8LPUe3KPY9Rz0yRP1wwg/3dMtjLLeetkClqBJxWgLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430070; c=relaxed/simple;
	bh=GfBYlvdAGTCQ1bE/wGtCuDXFAP0eWOuU/lTVLOOfC5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMkVoULZkr9DYvEtQiRexdRCFwTb14LLpw0CHg3ZKGpG9pvRv6hEn7jHiNVTu/l2KxJAuRbDjynhH2WKVZN+KrkSE2bsBbE47VpUnJfjWhBgSSs2r89Bwkaaq4dXfvfufnm02foiwxZYg7jFPvSdWZavcL67EE1ETh7nOhitqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKD6jw9g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713430068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c+bxT+WHkhQSYYDIJ6Aj+zyB0rRNxM4fAFl1TIin11Y=;
	b=XKD6jw9gsf8sj39ocJ6EeCoXtJmOjMfSl1KygVDvutPqypcRmCRFh8UyFrMK6+9L/akTD2
	cbia35pJ4pug+4UbW78NdB2WNht33ApIR+/FaxZ/CZnDGkOroQ5A9onKkHaVqE5rRIm11J
	fCfgh0HPpKx3TrU/Kg5IUQ+Z8x7sQwU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Yr51UAU4Mt2c52nwUt0zIw-1; Thu, 18 Apr 2024 04:47:46 -0400
X-MC-Unique: Yr51UAU4Mt2c52nwUt0zIw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-348973b648fso109151f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430065; x=1714034865;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+bxT+WHkhQSYYDIJ6Aj+zyB0rRNxM4fAFl1TIin11Y=;
        b=T/nEjGZJq4SkEHsoNE5VYUN8imtNWdmXPoKdg6D/jut7lZCrSTrLup5A13u4jRRIJn
         2HgTtgIZxvzpP2VgfRJGU8llePBKWC/cQ/25m8uJHjqe5K5kYAw/bFjHhIijomwDLu1K
         v2Y4WnUTeFfKjBI1cXjIPIKf/BdgjFddVsBY/czWpwxPQGXg7177sPGruwOR776aTivo
         UOG0aF3mNzf5gTe2a7t1u7MSpwF+LG0ZE6TU3z5vDkFMFfYEEcsEwxd9+082k267vh57
         kVMzlsnT7bdgiGeuq40r6pa0Ik5znAoUB6ndVNRozfiGyJ0JvVJnuQ3RIb/YK5ivIfho
         nknQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgHn3j3AKgnBxNpp/6RUhjXFGcitff67UwoeP+wDwFZx3Bxu90AIOt62sDT35T1DeKoe9Y9D93cwMLLC9PhueJwWt87j+LyW94G95W
X-Gm-Message-State: AOJu0YxdRkUIVjf0O497DUFpGF5Zx/Na48NQ0mxq3t3MprJYQcD/Korg
	tpGZkU7BY6dzOObea6/7PYyLUKxBP/lBgr4yJh1KDmYFZM3nfrwU3Dnk9CCqFzL+qRw7jkAWB+y
	si29GG+nyO50MAghS7M0PjUyL4OiuJyRdauz5TUW3wvN135f5O9REb+QWffWfZQ==
X-Received: by 2002:a05:600c:1c91:b0:418:9a5b:d51 with SMTP id k17-20020a05600c1c9100b004189a5b0d51mr1597147wms.0.1713430064949;
        Thu, 18 Apr 2024 01:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuX9Onk+JFsKlfGWkDC5OFvrhLuJ7rcnieRMoInGdDbO7Ygp2ZtjuTFhV7kCUsNUGl3mDQTg==
X-Received: by 2002:a05:600c:1c91:b0:418:9a5b:d51 with SMTP id k17-20020a05600c1c9100b004189a5b0d51mr1597136wms.0.1713430064564;
        Thu, 18 Apr 2024 01:47:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b0041896d2a05fsm1916295wmq.5.2024.04.18.01.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:47:44 -0700 (PDT)
Message-ID: <497b3f9b6d91a076c67f959ba878583a91b03cf5.camel@redhat.com>
Subject: Re: [net-next PATCH v5 1/4] net: hsr: Provide RedBox support
 (HSR-SAN)
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
Date: Thu, 18 Apr 2024 10:47:42 +0200
In-Reply-To: <20240415124928.1263240-2-lukma@denx.de>
References: <20240415124928.1263240-1-lukma@denx.de>
	 <20240415124928.1263240-2-lukma@denx.de>
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

On Mon, 2024-04-15 at 14:49 +0200, Lukasz Majewski wrote:
> Introduce RedBox support (HSR-SAN to be more precise) for HSR networks.
> Following traffic reduction optimizations have been implemented:
> - Do not send HSR supervisory frames to Port C (interlink)
> - Do not forward to HSR ring frames addressed to Port C
> - Do not forward to Port C frames from HSR ring
> - Do not send duplicate HSR frame to HSR ring when destination is Port C
>=20
> The corresponding patch to modify iptable2 sources has already been sent:
> https://lore.kernel.org/netdev/20240308145729.490863-1-lukma@denx.de/T/
>=20
> Testing procedure:
> ------------------
> The EVB-KSZ9477 has been used for testing on net-next branch
> (SHA1: 5fc68320c1fb3c7d456ddcae0b4757326a043e6f).
>=20
> Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for ports 1/2
> (with HW offloading for ksz9477) was created. Port 3 has been used as
> interlink port (single USB-ETH dongle).
>=20
> Configuration - RedBox (EVB-KSZ9477):
> if link set lan1 down;ip link set lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 ver=
sion 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 sup=
ervision 45 version 1
> ip link set lan4 up;ip link set lan5 up
> ip link set lan3 up
> ip addr add 192.168.0.11/24 dev hsr1
> ip link set hsr1 up
>=20
> Configuration - DAN-H (EVB-KSZ9477):
>=20
> ip link set lan1 down;ip link set lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 ver=
sion 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45 ver=
sion 1
> ip link set lan4 up;ip link set lan5 up
> ip addr add 192.168.0.12/24 dev hsr1
> ip link set hsr1 up
>=20
> This approach uses only SW based HSR devices (hsr1).
>=20
> --------------          -----------------       ------------
> DAN-H  Port5 | <------> | Port5         |       |
>        Port4 | <------> | Port4   Port3 | <---> | PC
>              |          | (RedBox)      |       | (USB-ETH)
> EVB-KSZ9477  |          | EVB-KSZ9477   |       |
> --------------          -----------------       ------------

The above description is obsoleted by follow-up tests, right?

Thanks,

Paolo


