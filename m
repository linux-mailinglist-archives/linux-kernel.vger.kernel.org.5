Return-Path: <linux-kernel+bounces-155382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55C8AE99F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A136F1F220CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4384FC5;
	Tue, 23 Apr 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnMWwYMr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170F17BA8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882866; cv=none; b=nRkzVIkwR9eK9EdMj3/ipXfxoY5YXLfEFXSqsiWAEemPp5PI3GD+WDTkmhoy4jzAbxq4KhNF26XRfyej+h/MQVWFEs93QZ1LHaUVutijuOAwfZqI8zmWytTAsUQqTKDBTqSRObZ5UwoM9z7p8raleOnggckdWPaKymXrPGmh/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882866; c=relaxed/simple;
	bh=lDYxbZe00LIEbZybUVITUvkhRFCHEVCyVrjLZoKn2iY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOA+JZXm0siYx6r/wKr9UjfQgFGTKaiAsG2yoVhR1xJM2blvbr36dwP3RnF6C0Q1ATu4zrHiQe4OtNvFuoGk23MuZn+EMx07TLEQSGByUwf09raz6llSVEp/NgWTbfUTVXOMk5IJhqsMUZxI0ZMQQEO46Z0zTaQ5OX1vWIle+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnMWwYMr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713882863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lDYxbZe00LIEbZybUVITUvkhRFCHEVCyVrjLZoKn2iY=;
	b=BnMWwYMr/1Ik6ieMqambxar2J4JbgzjDbZJKE6tVwJ1eTD0vL1ixtXA4T5WDHAtR17sLuq
	htWjF2n15Qbf+yU2Cw2ZwJ6TZwqUaUJaaCnNa73OjYHF1dNmdk0KeNdzPiWnCO2GJuX4QF
	oEfYqqPJZlawyrbHX8QAmJkAn0ReHnE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-SCjL2gV_MWazcJwF0QQJFA-1; Tue, 23 Apr 2024 10:34:22 -0400
X-MC-Unique: SCjL2gV_MWazcJwF0QQJFA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-418265e9717so7070905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882861; x=1714487661;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDYxbZe00LIEbZybUVITUvkhRFCHEVCyVrjLZoKn2iY=;
        b=JHHeNtkv9veVhkRboFnL2k5qXnrGnraMsTj6HsoB/O1nsDJcJ7tgccg7iz7LEIkvFU
         qgGGHk8JdoFO3+CDTOhx6yJsueZPlohv82tdEY9pDnVX+AihtHQ07jWXuQSAI2Kfwp8k
         TLPYzfLlV8MMfWZHSLYV9nMjMNRJvCb8ZBSMPIwVdfVtNCsN0mNhvL9jhpVJwwbFdxaB
         3Ju9k3jbQBGokgwbFLkB93LMYqy3LwVUh1DCaU4/V3n20z8PJp5I5E8DYTCCOHE2GEbY
         v2WwFnc2dKefv0JR8l4ayHcLdDwi2c++4GBCmVxe6EQf6paSaQsDRQCc9GooZZrh8Io6
         91Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVHhPu3QGqyw/0enHNOkulpHFO6XDchRYVNHEqYHuVRH07dtz4p/WvEafuvKP88hgZb8lUnRktQ4ui2Cuonxaf9TLvrCeFycnz76PcI
X-Gm-Message-State: AOJu0Yyeq73YuO5lguwGtRslMONFQiiJHwiOl4PS2gY9Xw7AefGhk+2D
	w2rWRUvguEU6cdTdhctM1MV4gmx0TQqcQySZ21WQIjbduqPLKHGXArjtnNravlRku20RX4X2o8m
	dnb590ZyINCnZffNTPmUbcb6EVarxdouQkB5KbqKzhq2yvM+RptkX0E/CBA9lldmG0QIbyA==
X-Received: by 2002:a05:600c:468f:b0:418:9941:ca28 with SMTP id p15-20020a05600c468f00b004189941ca28mr9276389wmo.2.1713882860803;
        Tue, 23 Apr 2024 07:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECBzY2aCyHwzfs2M7WEwMKd0aw7jGZsTEjB8hYHm0d1EKaF+MAJ/aLX1XSvQmhcmMGiUyt9g==
X-Received: by 2002:a05:600c:468f:b0:418:9941:ca28 with SMTP id p15-20020a05600c468f00b004189941ca28mr9276370wmo.2.1713882860423;
        Tue, 23 Apr 2024 07:34:20 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b004183e983d97sm20248859wmb.39.2024.04.23.07.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:34:19 -0700 (PDT)
Message-ID: <97f10c8b5b615eac8f65d67ef10928d97b6b760d.camel@redhat.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 16:34:18 +0200
In-Reply-To: <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
References: <20240423094117.93206-1-nbd@nbd.name>
	 <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
	 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
	 <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
	 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
	 <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
	 <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
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

On Tue, 2024-04-23 at 14:23 +0200, Felix Fietkau wrote:
> On 23.04.24 14:11, Eric Dumazet wrote:
> > On Tue, Apr 23, 2024 at 1:55=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wr=
ote:
> > >=20
> > > In the world of consumer-grade WiFi devices, there are a lot of chips=
ets
> > > with limited or nonexistent SG support, and very limited checksum
> > > offload capabilities on Ethernet. The WiFi side of these devices is
> > > often even worse. I think fraglist GRO is a decent fallback for the
> > > inevitable corner cases.
> >=20
> > What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST_GRO =
already ?
> >=20
> > Many of these devices are probably using NAT.
>=20
> In my tests, nftables NAT works just fine, both with and without=20
> flowtable offloading. I didn't see anything in netfilter that would have=
=20
> a problem with this.

I see you handle explicitly NAT changes in __tcpv4_gso_segment_csum(),
like the current UDP code.=20

The TCP header has many other fields that could be updated affecting
the TCP csum.
Handling every possible mutation looks cumbersome and will likely
reduce the performance benefits.

What is your plan WRT other TCP header fields update?

Strictly WRT the patch, I guess it deserves to be split in series,
moving UDP helpers in common code and possibly factoring out more
helpers with separate patches.

e.g. in __tcpv4_gso_segment_csum() is quite similar=20
__udpv4_gso_segment_csum() - even too much, as the tcp csum should be
always be updated when the ports or addresses change ;)

Cheers,

Paolo





