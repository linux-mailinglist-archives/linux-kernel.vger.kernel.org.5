Return-Path: <linux-kernel+bounces-84772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3386AB62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029F228AA48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E03376FE;
	Wed, 28 Feb 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naRbPE7d"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97937163
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112786; cv=none; b=j14RJ/AC6WSzKiOSJTTQjC7MNSJLAMRbb22f+LGzG54BGFDoU+FXfB2cDEzlBxAej8EBNpEyJvB2MsLD3U96TBL6VxLimoHRuDj53fvEnHIUHIGiimBexrfW/AyG7KC/NOEavufHLtZdcUgfIaokDQ5+Tf4DUMonhWVXx2SU7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112786; c=relaxed/simple;
	bh=+vEw4yu6BEkpuISizXp9gDSi/jYKQJzYyDhQ1Lqpquo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB1zQ0t8Qw4UNFjdRXdZ8UU2JSkouMT6BYyCLmiJjfoACAhCTJvWq3QjgTKJ8NRrg9Y1/p02F3PAQY2+/fCZeLsl+161/B7MgJwIj6UM/Jz+VX09smHC+vs1sS4/gQjbVnEk7fw9s2YR9dRJSAtovdBI5ruI9VilIm2Ggcnw4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naRbPE7d; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so7491a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709112783; x=1709717583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymxFlaSd/RjrNJLnLxB6/F9mhAatakD+Om7yj8a55aY=;
        b=naRbPE7dzObWXC8d4DtcztCTQGvfAFfdIoD2/kP3p1KRd7D25GBfFgZ02ghlsq3h2E
         bETBw4KzrLWgm3sKDopwyjsOIbM3BDOfZkT090CQrrYn/tfHbwCy/8ldnkn2bzubvjav
         wvdTQz7fU0wdvzF0dPkC1lRU9nc5030YTRZAFIvFlE+kpblfoPuDcs9kRL/H7QnqryE1
         uad2QT63g53z8EvszWzNT2Vb3gaWLVopAQHzJzy6+K2N9flWI/voIMpKJMpGZqBm8lAD
         Rif+MouBzx0fV28WWIwB8xKjQKbpTKrvUKzCdl4NgRvBV3N9YCJKewkskIXNTch8Z+3n
         lICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112783; x=1709717583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymxFlaSd/RjrNJLnLxB6/F9mhAatakD+Om7yj8a55aY=;
        b=pirkq93h4WewRIS4SLlsOL3AZvJk05TSLs49En4P1LFmgl6BGc+62ZOztc5Seqj4gz
         BOtk8NyB8DqSqeyys382ZHomfKEHd5n61lmgrr8COc2vJKpwaCLeo5p0xvQ05BNm2S+k
         RjeDBLpwglY78IY62sRbf50bQkdyJCQoE0L+N+7fcXS57WBQPC6hZPXggLpo9/rvzYiJ
         40pFv7P3J/zqjs4YAq8H4RfnopRWumOTgpTKGW5gvcOVSu4WyGUgIWnzu1zRvrlDMbgg
         HJwK7dLpxFUtwwCe1EPp2t/CR1vZIAzlYFFw7F0WcexVDB6dNgT+4D3yXIvxo8YkCNh+
         ibNA==
X-Forwarded-Encrypted: i=1; AJvYcCVxMkt9i9987sB2bAEaTASXmBvyhjbcDEYyDanYm6Xi87mux+iSXMUZKOKBJ9wC/kLQTJOoo1iLlV4lWV47IlLEAUAuik2SzSK/WOvE
X-Gm-Message-State: AOJu0YzaQVk2/W7i3rC2ICRVGp9ttPvlwb7NJz2zk5FkBH/+F7Xgn2mB
	Lb88enpHbItyeKlkE13FtGR5bAsJLJiYqyT7AXqTqhqSksRnH3rsxW06TUkruHiZ0tQjLfhRFRt
	MSRCRe048kt5xx/s95PNCiAI1OkEoYZ9E+cmv
X-Google-Smtp-Source: AGHT+IE1vhzjptOnLco79eT13kIH9gOiLX5epU1Ic/wFr3bjjDPwaQ7D/xo/TLfIQwXl4BIoxNKwwY6jIhEIlmf1qjA=
X-Received: by 2002:a50:c052:0:b0:565:4b98:758c with SMTP id
 u18-20020a50c052000000b005654b98758cmr41097edd.4.1709112782171; Wed, 28 Feb
 2024 01:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
 <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com> <bc168824-25dd-7541-1a34-38b1a3c00489@os.amperecomputing.com>
In-Reply-To: <bc168824-25dd-7541-1a34-38b1a3c00489@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 10:32:47 +0100
Message-ID: <CANn89iKFPjSQhXRcyb+EDQiH0xJG1WdWVGXXLK6iOcMpM2zKyQ@mail.gmail.com>
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
To: "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, corbet@lwn.net, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	yangtiezhu@loongson.cn, atenart@kernel.org, kuniyu@amazon.com, 
	wuyun.abel@bytedance.com, leitao@debian.org, alexander@mihalicyn.com, 
	dhowells@redhat.com, paulmck@kernel.org, joel.granados@gmail.com, 
	urezki@gmail.com, joel@joelfernandes.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	patches@amperecomputing.com, shijie@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:08=E2=80=AFAM Lameter, Christopher
<cl@os.amperecomputing.com> wrote:
>
> On Tue, 27 Feb 2024, Eric Dumazet wrote:
>
> >> sk_prot->memory_allocated points to global atomic variable:
> >> atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
> >>
> >> If increasing the per-cpu cache size from 1MB to e.g. 16MB,
> >> changes to sk->sk_prot->memory_allocated can be further reduced.
> >> Performance may be improved on system with many cores.
> >
> > This looks good, do you have any performance numbers to share ?
> >
> > On a host with 384 threads, 384*16 ->  6 GB of memory.
>
> Those things also come with corresponding memories of a couple of TB...
>
> > With this kind of use, we might need a shrinker...
>
> Yes. No point of keeping the buffers around if the core stops doing
> networking. But to be done at times when there is no contention please.

I yet have to see the 'contention'  ?

I usually see one on the zone spinlock or memcg ones when
allocating/freeing pages, not on the tcp_memory_allocated atomic

We can add caches for sure, we had a giant one before my patch, and
this was a disaster really,
for workloads with millions of TCP sockets.

