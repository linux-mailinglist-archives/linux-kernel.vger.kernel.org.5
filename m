Return-Path: <linux-kernel+bounces-73485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27F85C34A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D9C1F24B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A6477A08;
	Tue, 20 Feb 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/CJn6nK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B976C9F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452236; cv=none; b=l3fRnnXBQePQ0l/JVtrZIyD+fCIFErWXFlFBsl7tcDsE6XbOKgh8OyZ9xEWnhObqoYWAJDNUmRUe8AggHTsa9Nlco8L2/PXf9ensSa/sF9SNSocjRPGoF9hP4zDdhgp2f9HkvqXZGbggp2WKa50rIildttJhiI2+94jTugwDztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452236; c=relaxed/simple;
	bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbATFxVz+dszDmZNO5GuXx16cvdyjE6rqEscCV0qdTPqKHoIK84rn3rtpyeDqQ9dBwihM4sbkzdKJNhPOrX9dgzeah5/uXr92MlNeqRbeTrv+PgrK3jB8vU3/T8/fGc+C2FqBhYR8y2+g9rO9gd+e9Z9myqZYSpE3TYvyVNlgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/CJn6nK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-564d311513bso961a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708452233; x=1709057033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
        b=3/CJn6nKud0v2xAGVIYe5baXdR2Ueut4CiNC7Eq+CdK/HTCgeWAhLJNQ9YSZrlihSw
         +mM3X2+RxFG+U4oAPjuPiS8R0LbRn6S4Y8pCTLoqNs7S5v1u7fpkNzSYMtWBn/X9D1PF
         FnxQ3r+ZvdTz2GVJYmvYaB24ijfnD89BV1rH82z0BuzXUvEPhJxWIoC4u3Yt5T72aeTe
         qYIGjYNb8ft5j8LPUvtGqVSAJRSZ2X4VPIe73KRHWHjFKBrKXoWc1FKcuzTcVIt9dF8r
         tL8WYVdqLYYP2Hu+0UL2PZbpsVD3fz/jm2ijVeqMBAnyticRSKwJvQYWyGe0lHn/KMg3
         Ak7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452233; x=1709057033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
        b=m7xQ+oZhGSisApowdwU8oPfImNcrJn6ndkOZI23OItTIWe68OZSJbA7VP6ga4EPcMe
         Wtz3H28Fdq+J0ttE17kgf8Y9pxY/Qzn15Q+0KSDWT6U3eovmGuJcI6w/lHgW4LeEsaHt
         DIN/CkvN4bXvPVUrpzeqlhMe5OurickspwTSlg70ASVW6YfE6tuRT/g3Ch/8FpdOi30C
         fCZXW+gLFqGKQOVhujbFokvKowEBsxmGw4mz+6n5j9uvWsorvwVF9JP+FqGCq27E42NT
         IX2u/+s3ZYlIdFOK+4fDOdVUNnCsvKlTK4bvojqqTOTB6KTsHm6VsxyeJJPbzif3eO04
         5zKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsarf3QrKD2QLUUac/Tp+dehoKab0djHyB7P901I0k6llJu9M1Wh7WQgsOyhu7tKu4m2NcOelk5+gcG0+2OoN8W7xb7reTx1Nip9R5
X-Gm-Message-State: AOJu0Yy0aGF+ZQoNQ6Zy8X2DuVSctZSfE+tbV+QqMby+IhjiWYJq5cen
	7r1E1wV3eq5FlXbVGV4sueYlAxW4UFwwMIdaL+VRwG3LzRi4xZrwo38MOB9NPKGiBdRHoxi3jhD
	rE0dyM/9+8amu5+8B/XPJDDnDCwmGxrfAiIoW
X-Google-Smtp-Source: AGHT+IHw5T91YrU9Maq/ZbuDhD+cF96pVCL0Q7L/zZJ2yh3VVoEnWRHnH3fhRfCS0slaDzwuX66xPIpbpON2ixt2PFU=
X-Received: by 2002:a50:8d12:0:b0:563:f48f:a5bc with SMTP id
 s18-20020a508d12000000b00563f48fa5bcmr441060eds.5.1708452233017; Tue, 20 Feb
 2024 10:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
 <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
 <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
 <278c26d6f4042dc6dadb9742afe11b7fa610f0b2.camel@redhat.com>
 <CANn89iK72hE16sQcGPUFG6Am_V-77PNJOYHgeAA6M+SD5UO13A@mail.gmail.com> <28a1a98c757e4a15b7eecdeae563a17fa5cb45cf.camel@redhat.com>
In-Reply-To: <28a1a98c757e4a15b7eecdeae563a17fa5cb45cf.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 19:03:41 +0100
Message-ID: <CANn89iKn1U14L1u2w3VwenRt0S4QnXJhiA5PvMF0s41d8nS6Tw@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-02-19 at 19:33 +0100, Eric Dumazet wrote:
> > On Mon, Feb 19, 2024 at 7:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > Thanks for the head-up. This later option looks preferable, to avoid
> > > quit a bit of noise with _ONCE annotation. Is there a syzkaller splat=
 I
> > > could look at? if it landed on the ML, I missed it.
> > >
> >
> > Not landed yet, here is the splat :
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.2/24141 is trying to acquire lock:
> > ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> > tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
> > ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> > tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
> >
> > but task is already holding lock:
> > ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
> > include/linux/spinlock.h:351 [inline]
> > ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
> > inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038
>
> [Sorry for the latency]. Yes it looks like that checking the listener
> status will work. I can test and send the formal patch - with the due
> credits! - or do you prefer otherwise?

Sure, please send the formal patch, thank you.

