Return-Path: <linux-kernel+bounces-31817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6783350E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E335AB219B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48530FC0E;
	Sat, 20 Jan 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhzW/aRL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BBFBEF
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761710; cv=none; b=mCboCwFqt4JVP7Z5hECDYrzfxf8Fqij946J4JZuz4M2oONR5Ts4HTeuVgszORf/933EPstTgMXKAPZDteVNMhtQV5U9uLGJ+kFPETIWkA0eglsV+6H+7JobDhvsgLyChMrfKNyPz7SdYa/KyFErf/4QQucJ+1Pve9cFRHmrOQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761710; c=relaxed/simple;
	bh=S6BPwrXGE2thBcbHwFqMBAxcppB+4NWQZehPC54KYU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/4qkzox2o38dk8Eop90TX5zsPchJQrQb0g0m/GzI79TqpqPpeB/nqurnZ0cDqQvTU0AYOGJZGw9Xd+6unMHUb8KJqxxJOx1O1QTqGmfElLdGd018ktFRiA+kCyCeCpXyInL7H+Nx/UNnaJkKnyIAopc0ECTqopmScEAxyiDhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhzW/aRL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705761707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6BPwrXGE2thBcbHwFqMBAxcppB+4NWQZehPC54KYU4=;
	b=dhzW/aRLClVUYhbHnI2aO56wLCbT3Tz9013Z8NNu117BOKSQmq/qwxf9FtFiiu+j0nxsGC
	AlntYgCXArJCXamHZ1Xb+Phnp68xxPlXz7woP4YKI+3Tys07NqkcvGRwXl0K5R1bVSJCnk
	KaWqMNVW+L/z5rhKlT4ESy40JVLK3Tk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-z6ttGDDbNPaqUWQQELDGOg-1; Sat, 20 Jan 2024 09:41:46 -0500
X-MC-Unique: z6ttGDDbNPaqUWQQELDGOg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2b047e8f9fso89315266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 06:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705761705; x=1706366505;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6BPwrXGE2thBcbHwFqMBAxcppB+4NWQZehPC54KYU4=;
        b=TDcuYCFhV9PNGUlsEuuGWQ2bVhJKDSW/0TaX/KhEuCWqLCrYJc8KRyUSwDiiGcqWia
         wPWGwXkHy/vXf9BeqfzV4xP/IcCKPkYWsFcs6DcVWEyUoEUkvZpyYUdpdX30V+rgFRF6
         HydaqShqn7pxFL0vMPsljdgr9TKZkjqtWzIgMM8LRveepTCzaAfEiYYkWM0xl/Oq0jdH
         AoLpSVAaD6ah5tK0R/QX47wsZC1GCn3wNEcKQ0BX/XjP1JYw4Wy5eqpE5hEnn2iR2F3g
         hXPfCxj1NJ5aqG2DvYPORw6v9kTRdlqRaa8W6T7VBGT7pCOz/iNeGLQkEbxEhx90f3wP
         kAGg==
X-Gm-Message-State: AOJu0YxEpMpvBFTM8qOTm7tZMKveNW0f6K40I1UFbZKwdAecw4rmlTwc
	4nCaXb3qKs0WsVUdNZKbQDY9BHxHBdxTtV3OYVUxKPFrrP+1EV7+qyn+NfaRx2QGCQTuOC7pmTe
	RvEvdaC5bYAUxfOf3BNnXMXVCT+L99Xh1lPqZ25crBPTzr2J8Dia7wuSZ7h9VzQ==
X-Received: by 2002:a17:906:5a98:b0:a23:1163:24be with SMTP id l24-20020a1709065a9800b00a23116324bemr712781ejq.95.1705761705069;
        Sat, 20 Jan 2024 06:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuDY3A8O2vrfwcZAM0M1PYEeHPFP2ngva2JatE0cp7cV6iv0XZ5IXfV5wLy0eR3UWBYZ1gsg==
X-Received: by 2002:a17:906:5a98:b0:a23:1163:24be with SMTP id l24-20020a1709065a9800b00a23116324bemr712749ejq.95.1705761704712;
        Sat, 20 Jan 2024 06:41:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id vh3-20020a170907d38300b00a2e7d1b6042sm5542040ejc.196.2024.01.20.06.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 06:41:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 827D01088FD4; Sat, 20 Jan 2024 15:41:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo
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
In-Reply-To: <20240118083730.5e0166aa@kernel.org>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk> <20240112174138.tMmUs11o@linutronix.de>
 <87ttnb6hme.fsf@toke.dk> <20240117180447.2512335b@kernel.org>
 <87bk9i6ert.fsf@toke.dk> <20240118083730.5e0166aa@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 20 Jan 2024 15:41:43 +0100
Message-ID: <87o7dg3w48.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 18 Jan 2024 12:51:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> I do agree that conceptually it makes a lot of sense to encapsulate the
>> budget like this so drivers don't have to do all this state tracking
>> themselves. It does appear that drivers are doing different things with
>> the budget as it is today, though. For instance, the intel drivers seem
>> to divide the budget over all the enabled RX rings(?); so I'm wondering
>> if it'll be possible to unify drivers around a more opaque NAPI poll API?
>
> We can come up with APIs which would cater to multi-queue cases.
> Bigger question is what is the sensible polling strategy for those,
> just dividing the budget seems, hm, crude.

Right, agreed, though I don't have a good answer for what else to do off
the top of my head...

-Toke


