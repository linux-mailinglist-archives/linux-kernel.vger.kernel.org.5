Return-Path: <linux-kernel+bounces-164347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D68B7C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379D6284227
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03225176FD8;
	Tue, 30 Apr 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0DtPFPR"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CBC175560
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493848; cv=none; b=TSJVvtddMPD10Hq9IDvFFQCAuhct5oxIegkWKiSzQwxnt4TQebrJl3pyjv1WAwy5Vda8pIDRW0L86w+dBSLd53RTmg9X0S5yfmHUdVwUQNnJLs2zdGhF0zuuLh8Ty6OUZZjJqtqwmr7GU18BmqHEFOwsmTP31Tl+4tAZS9zo0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493848; c=relaxed/simple;
	bh=LraMHHXJexRBUmE1VurNANOUEO48WRtFBWGyBVFbjow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkXxCfNVF34JxRxmX/TEIYXqdCvuxPIZ2pSppxLgiTKJ7eXXKBgnQnn/2gLMbm5ju5QzhmjQyD6w9yJzPxho2CBUs7qhL6zWgOmUmnSHd8Bg7PEFodIvjqS0Zz8iyTv1s19ESxrS90r1owfnHRrVbYX5lxmA0gMNBK4Nb7ZhxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0DtPFPR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so19604a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714493845; x=1715098645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y2yaLrjizI/E7+QoCpiUksG1NRgVzp6GL1mOLadyuw=;
        b=Q0DtPFPRGwPWtQI8P64KfqJZyIPk7wmNo0otTEnGVXZ824G7S3gznOpe5chChhfA/A
         ckerHK8rUXdkJ0CSJ+0YMpi18Uue+x7gls9zmFoMC+oYoJ19mDu1c3kWKPZvw5dusDLi
         wz87HXDJE+zSoA9vd9++V9jHFky3PbfbUPBtMj2TCmflRg8tnQd9Kps2r9GK8k+eSi7O
         sHVoYHSw2Q2PL5c0faZweYVnpN14AUEuYTfgenp5/bl/UWsBkPOhHtNr/jq0WPhg4rSG
         akcn4+cRFd1BqRaNzH3EAM5Fw3byMMJmECJ/dI43Ey2K/cEp/OMI9XBoS2FGwWb7hv29
         IRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714493845; x=1715098645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y2yaLrjizI/E7+QoCpiUksG1NRgVzp6GL1mOLadyuw=;
        b=gJUHIQr7aSjMh4mRn0zyFUyAUgDWFF8TQ8oa6jj3C3kVy9eiz9Dsu1Qn0/bLmUaY4t
         wscPKMlJGhtk3fCFu7kDJrAqVjV/4lK87y8uTwMmQ5pqWzfGwOquwgeNlptAsvwRFohN
         Ozfg1PdvABokIM0ufKGErNPfVvGdVTyaywKfWFy/U9eP7mr+UOVCFIdRmaaz9xgqLKYR
         ijUdBaNjkjeAHJdV4iTkSKRdoRHzmvegPyvAc6w8W0qLOFPDSgdb39eEoSXa3NNIJR9g
         VQWeSCIhTMyDiudbgu3xGmFf1HnH7C53zRC/iaP4nq9VVrZ2SYaBTWDSv5fXazwQ1jHa
         d7ig==
X-Forwarded-Encrypted: i=1; AJvYcCWobnXgfAfvzr7AYzgwkIERES3ARpwEIcNYyfag7znP2J5Nuedi226F27j9Nbg5Mwa6eD0cNVWpRKxAa0aBz9SO8djqgW37xj8h/nJS
X-Gm-Message-State: AOJu0YxrJvApJVSVYU34JhMxMVaCcsB8/pjcClx7I/Od5WbGBPGceHiL
	HkXYHq7ARltq4wR8F/nu9oNr5Xv73TNApadUuEy2/96PxuAf6s7dCGBwO3272KgfNJEyxdSbATC
	PpyGYOpmNF/3NCWcdJbZ9lk5evyfNQW6OqBmO
X-Google-Smtp-Source: AGHT+IESU/dM6bmUJHhsZuFMldZvd/0hvPQeOKCaupEW5EKIhrkDWKnIVGQ+X5UtN6WFUU3eiNTaiDTZpR3WH0Q+gq4=
X-Received: by 2002:a05:6402:174c:b0:572:7d63:d7ee with SMTP id
 v12-20020a056402174c00b005727d63d7eemr217656edx.4.1714493844670; Tue, 30 Apr
 2024 09:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430143555.126083-1-richardbgobert@gmail.com> <20240430143555.126083-2-richardbgobert@gmail.com>
In-Reply-To: <20240430143555.126083-2-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 18:17:10 +0200
Message-ID: <CANn89i+rCK4jmjRUXywpeQeE1PPjNF=kf1_kEOB+UTYzi3MkYw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net: gro: fix udp bad offset in socket lookup
 by adding {inner_}network_offset to napi_gro_cb
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com, alobakin@pm.me, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:40=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("ud=
p:
> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in th=
e
> complete phase of gro. The functions always return skb->network_header,
> which in the case of encapsulated packets at the gro complete phase, is
> always set to the innermost L3 of the packet. That means that calling
> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer=
_
> L3/L4 may return an unexpected value.
>
> This incorrect usage leads to a bug in GRO's UDP socket lookup.
> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> *_hdr functions return network_header which will point to the innermost L=
3,
> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> encapsulated packets.
>
> This patch adds network_offset and inner_network_offset to napi_gro_cb, a=
nd
> makes sure both are set correctly.
>
> To fix the issue, network_offsets union is used inside napi_gro_cb, in
> which both the outer and the inner network offsets are saved.
>
> Reproduction example:
>
> Endpoint configuration example (fou + local address bind)
>
>     # ip fou add port 6666 ipproto 4
>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap =
fou encap-dport 5555 encap-sport 6666 mode ipip
>     # ip link set tun1 up
>     # ip a add 1.1.1.2/24 dev tun1
>
> Netperf TCP_STREAM result on net-next before patch is applied:
>
> net-next main, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.28        2.37
>
> net-next main, GRO disabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.01     2745.06
>
> patch applied, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.01     2877.38
>
> Fixes: 57c67ff4bd92 ("udp: additional GRO support")

Nit: I would think the bug was added later in
a6024562ffd7 ("udp: Add GRO functions to UDP socket")

> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

