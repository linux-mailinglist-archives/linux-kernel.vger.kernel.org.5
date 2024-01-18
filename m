Return-Path: <linux-kernel+bounces-30072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ADD8318C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E444285E02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16263241EC;
	Thu, 18 Jan 2024 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIetjBDp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033CF24201
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579093; cv=none; b=E0e93F+iKexpmj9PYZW7m/ZbQMndcs0znbIgHvMpeD/aFauTte4jZmlhmUTqLlLwBZmfyPzNK4AzWD9FfHEvJIdft2YC+1LQNE3+26pX1i1GfEmLPHK2fiRda5DKgBjcCe4xzVeG1sli9rl5DSBeRXKdp17ux1g1uCk+YpLu3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579093; c=relaxed/simple;
	bh=X82cqppfXg1vTXr8GzlQmIMAHtN7MmeahOqytI0aDbM=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:X-Clacks-Overhead:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=mBhU6Z+Ie2YjkHYeGT5OJy607Lw8FGS6ip+Ve1TWva5uxX30gtIM5tK5+bUAnoNWRuVk9bvpHum8pL9YZMuseQ2D8lGb2Z3q6xo12p8daceR+OJFeqLu4j0fl8j+MCqf9VFe+piOrnjqUqxQIPzAKg+r0aZO3wraHNJUqpohZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIetjBDp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705579091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8Qc8s97lzK/6LVP40VLku+QWSyBWBrxtyhvc1y67Ow=;
	b=OIetjBDpayHlHu4C77+NXRFw7uCqMXRb5vF7NZ2WeUxnuhbm3y1onrXxc/4uNgpM+tAiZ7
	eNZHRQGngW2kKIob89U+ifbBrg7Td6MsxUUdWvOz75g2pG8k4blT+6aAO0D1m/noCbglBO
	L+okcYkUinaAdNa0yaz7bohTbVtr94M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-mzX2lsBuPSOWVtf_kZl2Rw-1; Thu, 18 Jan 2024 06:58:09 -0500
X-MC-Unique: mzX2lsBuPSOWVtf_kZl2Rw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2866011bbaso78363166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705579088; x=1706183888;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8Qc8s97lzK/6LVP40VLku+QWSyBWBrxtyhvc1y67Ow=;
        b=gfMOdOXWOnkwzp+qJq2mwV8H3jejxigtZA8Hi4DUJy07Thcgba/UqqHZTXlYizH8Oj
         ObaFIZLR2ilwxFCuEF9h9pmwJ1rTie0kcFYbYHP2YQoYtCoDMIqCX2/yxXi2jxP3isMg
         VoCF9UBHMpHTbPpGRBRHPG0ViejV0Z7tkdn+Ce/AdVZpNJ609oojX1UaX8V8B/xxbe7z
         vfE+Xb4a33NRa5mfewbgByO6pW9SPDAPi+p/42rzwf8j33GaItxro+6f8ucp1AJiWyxL
         RMjDwVVhe5CB79H9FW/S1SSa1hdFo/NnGz8uSNES0sQ6lqoatlvg5ilNkJ0QXSFLUr29
         R0vQ==
X-Gm-Message-State: AOJu0YwFRFQtpyllNLI0FZUXZskmioXo0stgZATriLpiHhNjnLOwSOz1
	6BowFojxMpijZVfBJyOSf1LAVfvSBqJL0bxB6BVNSX2BWdR2gIBZv2yfo8LZe6mpvINeuYshvSA
	8GH6BgpiwmY1uO3rS3sLW3lUOLRdAsmFKq/lL3/QXWGq5U4zCG38kvxWZaqqNuA==
X-Received: by 2002:a17:907:920d:b0:a2b:ebd5:80bd with SMTP id ka13-20020a170907920d00b00a2bebd580bdmr695558ejb.42.1705579088506;
        Thu, 18 Jan 2024 03:58:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGGO5E/Kwhm76zD+5k/fy00eMidLtcdtb5JLMPh23IfsUK5h8/QfmCHB/u1LpIBwuJ9ZoAfQ==
X-Received: by 2002:a17:907:920d:b0:a2b:ebd5:80bd with SMTP id ka13-20020a170907920d00b00a2bebd580bdmr695543ejb.42.1705579088227;
        Thu, 18 Jan 2024 03:58:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cw1-20020a170907160100b00a2dae4e408bsm5484231ejd.15.2024.01.18.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:58:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 57A871088BB0; Thu, 18 Jan 2024 12:58:07 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Boqun
 Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Hao
 Luo <haoluo@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Ronak
 Doshi <doshir@vmware.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
In-Reply-To: <20240118073540.GIobmYpD@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk> <20240112174138.tMmUs11o@linutronix.de>
 <87ttnb6hme.fsf@toke.dk> <20240118073540.GIobmYpD@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 18 Jan 2024 12:58:07 +0100
Message-ID: <878r4m6egg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-01-17 17:37:29 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This is all back-of-the-envelope calculations, of course. Having some
>> actual numbers to look at would be great; I don't suppose you have a
>> setup where you can run xdp-bench and see how your patches affect the
>> throughput?
>
> No but I probably could set it up.

That would be great! Feel free to ping me if you need any pointers to
how we usually do the perf measurements :)

>> I chatted with Jesper about this, and he had an idea not too far from
>> this: split up the XDP and regular stack processing in two stages, each
>> with their individual batching. So whereas right now we're doing
>> something like:
>>=20
>> run_napi()
>>   bh_disable()
>>   for pkt in budget:
>>     act =3D run_xdp(pkt)
>>     if (act =3D=3D XDP_PASS)
>>       run_netstack(pkt)  // this is the expensive bit
>>   bh_enable()
>>=20
>> We could instead do:
>>=20
>> run_napi()
>>   bh_disable()
>>   for pkt in budget:
>>     act =3D run_xdp(pkt)
>>     if (act =3D=3D XDP_PASS)
>>       add_to_list(pkt, to_stack_list)
>>   bh_enable()
>>   // sched point
>>   bh_disable()
>>   for pkt in to_stack_list:
>>     run_netstack(pkt)
>>   bh_enable()
>>=20
>>=20
>> This would limit the batching that blocks everything to only the XDP
>> processing itself, which should limit the maximum time spent in the
>> blocking state significantly compared to what we have today. The caveat
>> being that rearranging things like this is potentially a pretty major
>> refactoring task that needs to touch all the drivers (even if some of
>> the logic can be moved into the core code in the process). So not really
>> sure if this approach is feasible, TBH.
>
> This does not work because bh_disable() does not disable scheduling.
> Scheduling may happen. bh_disable() acquires a lock which is currently
> the only synchronisation point between two say network driver doing
> NAPI. And this what I want to get rid of.
> Regarding expensive bit as in XDP_PASS: This doesn't need locking as per
> proposal, just the REDIRECT piece.

Right, well s/bh_disable()/lock()/; my main point was splitting up the
processing so that the XDP processing itself and the stack activation on
XDP_PASS is not interleaved. This will make it possible to hold the lock
around the whole XDP batch, not just individual packets, and so retain
the performance we gain from amortising expensive operations over
multiple packets.

-Toke


