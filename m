Return-Path: <linux-kernel+bounces-92277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CF871DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8932A1F2A7B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB75B685;
	Tue,  5 Mar 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlD6TEj+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109305822F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638230; cv=none; b=rMJ3t8sMPYiwY5n9X513qRWJDyNw/J8yQEc3+SAQ7/yt01GGb2yOv67pijcczxnbyDlVsbRo1/5AN1GYNncnPMc83+gDtSsZRhu67D3s+2Rf3Y7p6EO3rHcHBKMaNmjR7zcr2hqQPiyuITJuSNF6S+QEd/EfA0c4aaJp5GgQ/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638230; c=relaxed/simple;
	bh=VTSl2wdf4yJetzl7H9Gvd1vCLYSt9TtuKh93OEuuwYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMsY60IN92LxXwOeg4Emy1Ukaw+NYpIXi9qTOW/mwENdRWW6tXPJBlL2rMmoW8K+I69vbPCWVFHFOI9T3L/cXUqYggNi+50Eb7jmVE06EUFDN3l7NzBMBYPQYVRcSrKPnL0f7fhy+0jK4F1ISbtxydtqmFquFnh1f/PkK0YyTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlD6TEj+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709638227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VTSl2wdf4yJetzl7H9Gvd1vCLYSt9TtuKh93OEuuwYo=;
	b=hlD6TEj+QIQPa1McL1iJD0BoAR8IfHZ39qOlubPUc1Y3NTnQlwChZTmzlrA9lWnF7roRz7
	ML7HbwvFEp7niL7BVLXUx6Qi7pmwwiVrLbmCMXZeQHXm5BuZWeZdto++G4uq258QV8WzmP
	gDUUHqe6IazdEyr14i/vPBkD2w6Bnes=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-kmFK700VPZC4z2GStRKidg-1; Tue, 05 Mar 2024 06:30:24 -0500
X-MC-Unique: kmFK700VPZC4z2GStRKidg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5131e2433d7so1746268e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638223; x=1710243023;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTSl2wdf4yJetzl7H9Gvd1vCLYSt9TtuKh93OEuuwYo=;
        b=fjLW9HboN4fkRKDiEH8u0qNiHmqDzqW3XMm4kmMNkUMfgX3YJ7e1+EjQxmBKsSOr6L
         jFhXTlNgsHqimEd/ba3kirXZ3a2eXDLloAGc9M0rX+cKly+28/+sBu7ISxkeURWV37al
         NAL0Dytmz48XYBL7g4LPjr2DxDt3PVFI2DqgQQ9aWtA6NlR674RZFo4p8IYWWu5l353H
         unl2BIm6ENS3GS9qhHt8o+zGNkc8iQLp8oLks1ptGfKaRXho7N3VsVtB6V1epT67Kcua
         rtolk7zr7oksKG0s+kDJ6OyyjjEUaPzmP+TRaUpXQ9smj99xW1NYzD7s6tjgAKUmxGZS
         O5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/S6zIzyOfCGSQA5eX2Jzivbkupqq2PD964F36weEEG/4jVa/UjOUcGa5NDfvxpyh/Ae5au0sTeU2Hc1DpduFeZ1zEfYfORieSKBzQ
X-Gm-Message-State: AOJu0YxtMqp7GjDrnqJAWAkf03muHm97+TncSttz7vmtENWH6gJqT2Ee
	xindHzRdCugptNne9/4F4o6ANd+IZuRChX6c7nUCUZ68/kVVU0woMnFfLK6Pbe3TTrFeAHVzHz1
	R9rfNuDQDXmLbC75MeSUjrnhLhip+IBsXldj9uzMhJdrvo+qsahKUth1qeUwUcQ==
X-Received: by 2002:a05:6512:747:b0:513:2cf8:8a19 with SMTP id c7-20020a056512074700b005132cf88a19mr5167108lfs.5.1709638222935;
        Tue, 05 Mar 2024 03:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3DygI6KTM/Ds0/4ckxbgxJalqBOCQG/QN+wZROW+qfifPd2gOD/p9aL2y5etU7mMYrUHzjA==
X-Received: by 2002:a05:6512:747:b0:513:2cf8:8a19 with SMTP id c7-20020a056512074700b005132cf88a19mr5167089lfs.5.1709638222476;
        Tue, 05 Mar 2024 03:30:22 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c451000b00412ee12d4absm1291426wmo.31.2024.03.05.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:30:22 -0800 (PST)
Message-ID: <81a5d191894e6a7741d3c266079f3404def2bb07.camel@redhat.com>
Subject: Re: [PATCH net-next v3 0/9] MT7530 DSA Subdriver Improvements Act
 III
From: Paolo Abeni <pabeni@redhat.com>
To: Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, Bartel Eerdekens
 <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=
 <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Date: Tue, 05 Mar 2024 12:30:20 +0100
In-Reply-To: <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
References: 
	<20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
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

On Fri, 2024-03-01 at 12:42 +0200, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> This is the third patch series with the goal of simplifying the MT7530 DS=
A
> subdriver and improving support for MT7530, MT7531, and the switch on the
> MT7988 SoC.
>=20
> I have done a simple ping test to confirm basic communication on all swit=
ch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.
>=20
> MT7621 Unielec, MCM MT7530:
>=20
> rgmii-only-gmac0-mt7621-unielec-u7621-06-16m.dtb
> gmac0-and-gmac1-mt7621-unielec-u7621-06-16m.dtb
>=20
> tftpboot 0x80008000 mips-uzImage.bin; tftpboot 0x83000000 mips-rootfs.cpi=
o.uboot; tftpboot 0x83f00000 $dtb; bootm 0x80008000 0x83000000 0x83f00000
>=20
> MT7622 Bananapi, MT7531:
>=20
> gmac0-and-gmac1-mt7622-bananapi-bpi-r64.dtb
>=20
> tftpboot 0x40000000 arm64-Image; tftpboot 0x45000000 arm64-rootfs.cpio.ub=
oot; tftpboot 0x4a000000 $dtb; booti 0x40000000 0x45000000 0x4a000000
>=20
> MT7623 Bananapi, standalone MT7530:
>=20
> rgmii-only-gmac0-mt7623n-bananapi-bpi-r2.dtb
> gmac0-and-gmac1-mt7623n-bananapi-bpi-r2.dtb
>=20
> tftpboot 0x80008000 arm-zImage; tftpboot 0x83000000 arm-rootfs.cpio.uboot=
; tftpboot 0x83f00000 $dtb; bootz 0x80008000 0x83000000 0x83f00000
>=20
> This patch series is the continuation of the patch series linked below.
>=20
> https://lore.kernel.org/r/20230522121532.86610-1-arinc.unal@arinc9.com
>=20
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

@Russell, I see you went through some patches; my understanding is that
there are no objection to this series in the current form. The series
LGTM, so I'm going to apply it: I think it would a pity if it should
miss this cycle.

Cheers,

Paolo


