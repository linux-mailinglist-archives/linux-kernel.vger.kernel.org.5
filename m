Return-Path: <linux-kernel+bounces-97912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF397877188
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D31F216D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E040873;
	Sat,  9 Mar 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eM0Mv0rC"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C03BBD4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709992276; cv=none; b=u0EOvsz3AoHGeKpcF19jn06RHH9jWFKRWdv4CUR8dIJHe6LB3oXJlNkQY4fZ6Z5xdvtyqf44voCn0xIf+w90ODuZyAL30Q7OXpofa4/M2X2zOqnidlQXPI9Dcpd4i90mNtiU05O5jQBGaGoqAeucZyctipyXPqDYOYdI/SmN60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709992276; c=relaxed/simple;
	bh=3l5OYOzOQ/vB4Y/VGcrwpNgMlmBP5V1Ml/YaGCtT0pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBn6ewHlC9FMgDN56RYEW2ZEJ1j/iHBenqemH/ycf3JVTjyWaLqHd+EwZ8npb5tVGJ+p5zhlpzhKChcrXM2qf0AMm4DDUd995/RdywWJk5T3NoqT31ZJ8Gf4Fg8kZKGNaSLMUg1AnkzRwqb/hLSyyq7ZjWWMngrxSDK+qeGyFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eM0Mv0rC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so3520a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709992273; x=1710597073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te496QxdZUYg4ch4iSRnEXCjitC5gIqnzUY0BMOOYY0=;
        b=eM0Mv0rC/KKtFUrJcixD8FCbeD8wM6RJoF4RQEqP3r9OaDsUQRtfCjX67S+CmGd7ez
         Miy6yZ0cRAwJz1t/Rm/RUG/6EKp8mB5rFKKk28xqIXakSGUJWq55gDQDqT2qhkvIo/ct
         RP0yDcTmB/gSx6xjTtgnqIFfNl4KGPTQlRyqCo0PBRnFehbB5+GXRKjZpYpfXmoWHnhj
         gohyW11941qtAxeKl1OtGXJR4xt3oiV2t2XvbjOGYx+lIjjdrJf6CzhAstFEEHhGpncw
         uo9UoG91C3WQzbWSbqlNCKx9koCOZOnsLHCkzrmaPBjWFOLJpYCvtin5A1W4ZWfjnHxE
         KwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709992273; x=1710597073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te496QxdZUYg4ch4iSRnEXCjitC5gIqnzUY0BMOOYY0=;
        b=YJaEZk0/vbJTCRg+iJZUYwRvgF2ZEY3uDNIT/mrakK+QVgVflxIUA2mwNqXom285DB
         2fNl7ke/UruYkr1Wpee3Muqw6RbleeY+707axt4b/9VVRyOiOd3c13iMIf/KuVartEPU
         JiI2t4qHYP7ohPHjkFOKrgEAggYzyeQAYbLOXz6FsjNU0OYtUKfQcFgba+k9bNDV8k1R
         PqqtmqGE9Akq+XqgTjBCI4oeIGh+Q8aft+Dgrk877tzfmC8aqGzl43ka/eV+sRZV19Br
         qMcGkzW4Ets+YDN2Akd33pcUZzxIt8DQBeRCL+OiW8DU1nuONa7lyzrPMF9ySYCnKaKs
         5m8w==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ0iNDAfhgWCR2qeU+9OhNmbL8Acqs3kJzRDD5vGIpxrmwXv7EYzUrygsmlX5tGzZKI3wRw6DRkGIcrARueUCqg5ofglEfvrAIV3p
X-Gm-Message-State: AOJu0Yw6V97lAv4dSOMZL2QcbWlOI/DC85I9SpMtLOgWJ5khoPwacBcQ
	qBKyMaCYEiJnTy4qPbWfv06QXW8Ha82U3w6+2VwMHk8WkhV/lGwPgtUzL9De4vf+9dneoQVDza7
	HCmEGJvFPvK/+OrvfEwv7W7/wd0f3QczzHIqd
X-Google-Smtp-Source: AGHT+IENA+pdgSTpoEoapZTEank+4tXhBFYnvcx3nutGJQOCKuqd441+JVEO6pyirOLVoJkVtcCKjl3A60S0s7Qtflg=
X-Received: by 2002:a05:6402:1b06:b0:568:3c0c:1755 with SMTP id
 by6-20020a0564021b0600b005683c0c1755mr79029edb.6.1709992273123; Sat, 09 Mar
 2024 05:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_DC4901C65DB41D86CD613F3ACC41EA143808@qq.com>
In-Reply-To: <tencent_DC4901C65DB41D86CD613F3ACC41EA143808@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 Mar 2024 14:50:59 +0100
Message-ID: <CANn89iJRXjYTojFyHN6s1Qu9Vkkk6RwxPF=bAKPjOg9zT-GupA@mail.gmail.com>
Subject: Re: [PATCH] net: mark racy access on sk->sk_rcvbuf
To: linke li <lilinke99@qq.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 2:35=E2=80=AFPM linke li <lilinke99@qq.com> wrote:
>
> sk->sk_rcvbuf can be changed by other threads. Mark this as benign using
> READ_ONCE.
>
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
>
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  net/core/sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5e78798456fd..4c5524e70534 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -551,7 +551,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff =
*skb,
>
>         skb->dev =3D NULL;
>
> -       if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
> +       if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
>                 atomic_inc(&sk->sk_drops);
>                 goto discard_and_relse;

OK, but what about __sock_queue_rcv_skb() in the same file ?

