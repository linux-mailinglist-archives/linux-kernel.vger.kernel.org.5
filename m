Return-Path: <linux-kernel+bounces-154964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D28AE3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AA5281A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3D7E58E;
	Tue, 23 Apr 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYdUuJSH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4D6E617
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871077; cv=none; b=EZxmhTpGeKbXqj8yi4K3DyQTEFMLKLhqg9ZAajP/9stARzDspO5iNUt4dIpwMTAwCPGOqcjhsfKe7D/DGPKhgADKAGjjFopPMbfgpekWgDZvF8KEAyq+r9b6HMvJdjkQWYzD874P06fCx/D8tN3flVmBboctiQFUzG2OidQbzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871077; c=relaxed/simple;
	bh=WBlYJbDM420376pxHCSgY3J8I6hmPvxhxfia3JcpKqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaPyjIAO4W/cDiEWGcX6Yjm86FBJz1+d6iSTtN0AJ2gcdfN37+4AuuoFMVG2dqpBC2UX1ic3zdMhSMoAHBkfXZZDoOkIcRwTSos79bEadAbswbdkYQNbAKQQ5S5cgz5890iXkLwfsg5oXTq5q/J4tu7+f6ouk7mn3ZmlB1mK5Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYdUuJSH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so16571a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713871074; x=1714475874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFS7RXq9qBhiwLT5zm2qX4wTBz1ICyONtrvH1XkqVug=;
        b=AYdUuJSHTNIL9PeNTroij4pmIoLgbEgRuIvGJr3s8qEjgTA7AYNbl66Q14cnVnnruN
         GSRz3o+bEB1rtFjJwSMmu9kUybfhn1QWdk0TBkMCuvwUAlp1zAWyzUkDNfry/lMHWrYi
         nrpy5rcBF0U48dg8Ugao871kSwgGJxHdhFa92rqVN/uHswpqXZn894BYVdO9yzhGRDb3
         w9vnN543QQlyQpxL7cFCO2LIvrYtbc0AGjTXNyz2LBlvLY4UfPJFiU9FLTI6g3zbC3SZ
         MxmGe0ibll69EM/KJF9c6fE0k9iEWb2i75ZUd6DmrF0vTYuso5N3oxzIEncQr/RkSKGr
         rPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871074; x=1714475874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFS7RXq9qBhiwLT5zm2qX4wTBz1ICyONtrvH1XkqVug=;
        b=Gs0RTBkvBA5KW48R+jSbwCkmd4nkvyAnPztMySRu9galR7jmSf0rdDJC10B8zLbDH0
         uhH6CjpcKfiuEq6HpafMaMtOmDpg2Y8wbJqCiWKfy9Hrz+1mw3Pey1R8KMlUtkEiePUX
         b2KPxF4gDvwuJdrLMP/Ow8I9i2ESI+6plHMDZ+lORCf7C6jU4zTaoMj5VBhQoJ27YPek
         o9b6cUeciAOmZzbTXPSCAta8Jao7qj/yFPySqYMf2JPqgYrrTQbi8lK3D/GTCvQIUNhc
         LtHnRcMCoxE5wlDCH78kyIfnyadaodWWWonKsb6dRr90Wse6G6UCqh81SAiL+XTc1jMY
         ShwA==
X-Forwarded-Encrypted: i=1; AJvYcCXqkjhoIrkN+t0P0Kg6njdJFbdgwS9wmRz5Fxn+5Uz7KtbrFwBZWcIiPyOHcJMvAsXnvUc8VzEwQggtwUzg35I15oFqbhyIvEvCi3/t
X-Gm-Message-State: AOJu0Yy6dFEeFmwbqWkMYckWdTOsq8gry/+sYrY0FSgw1cZKRVtoPNuz
	dUw325Y803rFcAYsKilLLK2I5wfW2xBPLpuld628A00X//gvtXAH8eiGKlE4SxypfIBpvq1rwGF
	lenVzW6mw474SJ+sY9DqGRIUNJwIyWMmnywlP
X-Google-Smtp-Source: AGHT+IElhRef4erNceR0B1a4VbiksSXys1972fOis+BIviNNsr++R2H7gn6Pfe0eqSlTR0M5DlODJyasKv8DYku/sVc=
X-Received: by 2002:aa7:d290:0:b0:571:fee3:594c with SMTP id
 w16-20020aa7d290000000b00571fee3594cmr149127edq.4.1713871074171; Tue, 23 Apr
 2024 04:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name> <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
In-Reply-To: <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 13:17:40 +0200
Message-ID: <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 12:25=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote=
:
>
> On 23.04.24 12:15, Eric Dumazet wrote:
> > On Tue, Apr 23, 2024 at 11:41=E2=80=AFAM Felix Fietkau <nbd@nbd.name> w=
rote:
> >>
> >> When forwarding TCP after GRO, software segmentation is very expensive=
,
> >> especially when the checksum needs to be recalculated.
> >> One case where that's currently unavoidable is when routing packets ov=
er
> >> PPPoE. Performance improves significantly when using fraglist GRO
> >> implemented in the same way as for UDP.
> >>
> >> Here's a measurement of running 2 TCP streams through a MediaTek MT762=
2
> >> device (2-core Cortex-A53), which runs NAT with flow offload enabled f=
rom
> >> one ethernet port to PPPoE on another ethernet port + cake qdisc set t=
o
> >> 1Gbps.
> >>
> >> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> >> rx-gro-list on:  770 Mbit/s, CPU 40% idle
> >
> > Hi Felix
> >
> > changelog is a bit terse, and patch complex.
> >
> > Could you elaborate why this issue
> > seems to be related to a specific driver ?
> >
> > I think we should push hard to not use frag_list in drivers :/
> >
> > And GRO itself could avoid building frag_list skbs
> > in hosts where forwarding is enabled.
> >
> > (Note that we also can increase MAX_SKB_FRAGS to 45 these days)
>
> The issue is not related to a specific driver at all. Here's how traffic
> flows: TCP packets are received on the SoC ethernet driver, the network
> stack performs regular GRO. The packet gets forwarded by flow offloading
> until it reaches the PPPoE device. PPPoE does not support GSO packets,
> so the packets need to be segmented again.
> This is *very* expensive, since data needs to be copied and checksummed.

gso segmentation does not copy the payload, unless the device has no
SG capability.

I guess something should be done about that, regardless of your GRO work,
since most ethernet devices support SG these days.

Some drivers use header split for RX, so forwarding to  PPPoE
would require a linearization anyway, if SG is not properly handled.

>
> So in my patch, I changed the code to build fraglist GRO instead of
> regular GRO packets, whenever there is no local socket to receive the
> packets. This makes segmenting very cheap, since the original skbs are
> preserved on the trip through the stack. The only cost is an extra
> socket lookup whenever NETIF_F_FRAGLIST_GRO is enabled.

A socket lookup in multi-net-namespace world is not going to work generical=
ly,
but I get the idea now.

