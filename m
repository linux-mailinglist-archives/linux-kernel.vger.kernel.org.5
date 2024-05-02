Return-Path: <linux-kernel+bounces-166195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B18B976C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13D61C229D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3585381B;
	Thu,  2 May 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERKrKjzu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65260548E7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641540; cv=none; b=QVB4YaxpMccoDr8exmTnPW+a3xtxyH5gSMvaaWklO0TVpoIEOuGxyG/WVdvZejJghKY1YB5TAU6MOT9KuDahRqwoALcqWs8dhRPmdBF16EVp+qmqAoONTVgTb0BZHAzX/EHOnY1NTALj+VDBxOe/B/L9le76h2LHxDsYQ1zd6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641540; c=relaxed/simple;
	bh=cfSYj5SGr0OLMpCegs5JHy4/QMJJt2V4NsBhaA+XV2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeOx0wDh2eeo+2DFg3GgyJqZc6xHunBuLrI3QyHf1/qb79ln26sj4eIs2wE4Gs1TIS7x0GTlFGCCHoJtgTLcYX91xw2N7sn2c9Q07kXIzNGRa/IEmyzUvhzkX+QkYYxTdR1cJUj2GlDcmoaKLVy5rni+roSEVcdHpiNCeu1dMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERKrKjzu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714641538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IPzyAokYrwlLo4PoxaihCznvfH+Bv10eDq2Sp4y7MzU=;
	b=ERKrKjzuBeUkWB7MDUMftD/XEK6o6ZBVKtcIoWfjFP8vdnUitZ4mIrzlzsCTn1D7S/TE/4
	PQsf+ONhSJV7dkdKLVjdzGGhICGe5KP65avvFPLmQL9Gd85pemyfTR2bkP2YiTja6/f+gA
	kgb44b5J1CZA6gSdBFzi3YEnE3OL6XM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-1bsOwD4NMhO4wBmsyRBD2Q-1; Thu, 02 May 2024 05:18:56 -0400
X-MC-Unique: 1bsOwD4NMhO4wBmsyRBD2Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34d7a7585f3so250229f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714641535; x=1715246335;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPzyAokYrwlLo4PoxaihCznvfH+Bv10eDq2Sp4y7MzU=;
        b=evridFNte6Gw+RN7nzUbV6+8Y501J3NZkVYKCD++fhFtB6ttbw4Y7EDfTF+RUxlGTv
         +54SNoFV9hmLzhUJVM28mjKeajcFpb0LMsVZ98WxIa6VIXQO9ROzTK4DJ4NBIn6OJ5Wv
         EAyMvQ0D3Zypq2Kfgykqme56POixVp7vUzfpweshVswY7JhzuzN3HPUTGS+bDzzDyFLn
         SMLJ+HIYpKfFWsITDlLR/384NllHFk2QPu7kQLOzcyudpAVhyasofUWbiSOKADkaYf8k
         EwhJiIbJFrX9uEfU7ciWEecN/T1r7lzw7Y6zqsoyitsbVzYPWPoNpZSZ4LgHVeqt+TCy
         MDrg==
X-Forwarded-Encrypted: i=1; AJvYcCXsRHD5fdIAmCjNynncgWI4Yc4pZiZl6vQZT+E8il1bk7S9+OxPpWBsXKx66TFCbp4P0NbCemX83UHzX4uImBplkv0ozXnGBEhiVW5u
X-Gm-Message-State: AOJu0YwKu1VCincpQ4N0FcYqrFRSbbaE6koaNo1UxUKE/b8cAUKa2n0w
	hiVJn7eCRE74E3oj0lJeri8R2Y+6cGyMUTXS4FPpaV+JH3oeCoroDfDaUGrMXysCdqq80bX3YPA
	Cz+FiTQt/jFY8SvN6imT+HSwkiqa0JEcefDYlUkRxidoXfTVjMkdqNQLK+oHOsA==
X-Received: by 2002:adf:f450:0:b0:34d:9d4c:53ec with SMTP id f16-20020adff450000000b0034d9d4c53ecmr3609100wrp.5.1714641535471;
        Thu, 02 May 2024 02:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpW3QLesv9QPgHTeU6Qi/PcYR8Eqx1owfuFNJLKRrZq8iHE70b9M7pjLywla+k4XHLcCWE6w==
X-Received: by 2002:adf:f450:0:b0:34d:9d4c:53ec with SMTP id f16-20020adff450000000b0034d9d4c53ecmr3609064wrp.5.1714641534942;
        Thu, 02 May 2024 02:18:54 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510:426c:715f:ad06:c489])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d6981000000b0034d8b0b5329sm772715wru.87.2024.05.02.02.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:18:54 -0700 (PDT)
Message-ID: <ada57e67645c7ebbbebe0c5d6e603113fc1be2e6.camel@redhat.com>
Subject: Re: [PATCH net v4 1/2] net: gro: fix udp bad offset in socket
 lookup by adding {inner_}network_offset to napi_gro_cb
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Richard Gobert
	 <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, alobakin@pm.me, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 11:18:52 +0200
In-Reply-To: <CANn89i+rCK4jmjRUXywpeQeE1PPjNF=kf1_kEOB+UTYzi3MkYw@mail.gmail.com>
References: <20240430143555.126083-1-richardbgobert@gmail.com>
	 <20240430143555.126083-2-richardbgobert@gmail.com>
	 <CANn89i+rCK4jmjRUXywpeQeE1PPjNF=kf1_kEOB+UTYzi3MkYw@mail.gmail.com>
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

On Tue, 2024-04-30 at 18:17 +0200, Eric Dumazet wrote:
> On Tue, Apr 30, 2024 at 4:40=E2=80=AFPM Richard Gobert <richardbgobert@gm=
ail.com> wrote:
> >=20
> > Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("=
udp:
> > additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in =
the
> > complete phase of gro. The functions always return skb->network_header,
> > which in the case of encapsulated packets at the gro complete phase, is
> > always set to the innermost L3 of the packet. That means that calling
> > {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> > gro_list and *_gro_complete) when parsing an encapsulated packet's _out=
er_
> > L3/L4 may return an unexpected value.
> >=20
> > This incorrect usage leads to a bug in GRO's UDP socket lookup.
> > udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. The=
se
> > *_hdr functions return network_header which will point to the innermost=
 L3,
> > resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> > encapsulated packets.
> >=20
> > This patch adds network_offset and inner_network_offset to napi_gro_cb,=
 and
> > makes sure both are set correctly.
> >=20
> > To fix the issue, network_offsets union is used inside napi_gro_cb, in
> > which both the outer and the inner network offsets are saved.
> >=20
> > Reproduction example:
> >=20
> > Endpoint configuration example (fou + local address bind)
> >=20
> >     # ip fou add port 6666 ipproto 4
> >     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 enca=
p fou encap-dport 5555 encap-sport 6666 mode ipip
> >     # ip link set tun1 up
> >     # ip a add 1.1.1.2/24 dev tun1
> >=20
> > Netperf TCP_STREAM result on net-next before patch is applied:
> >=20
> > net-next main, GRO enabled:
> >     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
> >     Recv   Send    Send
> >     Socket Socket  Message  Elapsed
> >     Size   Size    Size     Time     Throughput
> >     bytes  bytes   bytes    secs.    10^6bits/sec
> >=20
> >     131072  16384  16384    5.28        2.37
> >=20
> > net-next main, GRO disabled:
> >     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
> >     Recv   Send    Send
> >     Socket Socket  Message  Elapsed
> >     Size   Size    Size     Time     Throughput
> >     bytes  bytes   bytes    secs.    10^6bits/sec
> >=20
> >     131072  16384  16384    5.01     2745.06
> >=20
> > patch applied, GRO enabled:
> >     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
> >     Recv   Send    Send
> >     Socket Socket  Message  Elapsed
> >     Size   Size    Size     Time     Throughput
> >     bytes  bytes   bytes    secs.    10^6bits/sec
> >=20
> >     131072  16384  16384    5.01     2877.38
> >=20
> > Fixes: 57c67ff4bd92 ("udp: additional GRO support")
>=20
> Nit: I would think the bug was added later in
> a6024562ffd7 ("udp: Add GRO functions to UDP socket")

No need to repost: I'm updating that in PW.

Cheers,

Paolo


