Return-Path: <linux-kernel+bounces-101605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246F87A947
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EE8285DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0E45BFD;
	Wed, 13 Mar 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIs5qeq9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9074205F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339220; cv=none; b=K/rioY5WyGQZOqxJ/5AVUfXrC70kmEOUNlrxO11RepjM8QmL7stW8gS63+KClDv+DS+CeccjvcC8w1HSmrZGadZTez/rDrdWrPV9vD4lzhr/SjnHuSyt0LkDgKeZWdEQ9J2dUZeiaI6kgeu9H/M9io9kKIw4apnLBk/rHKhHrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339220; c=relaxed/simple;
	bh=1WBBRYOsC8dbpVv7/4w7KnkU6Wkm46ZVmyWNZS65FKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fICb4zxaAH3ZJnxosrgwtk3UcjyFcPNPnlljIX9Mo+t2Sohr/H+Tf0+D7gNiCvyJiUUjwq7VBitPbaBjOz2B58W6B9AN1tvolt1HZfZsAL6f2fa3gvwrk8vKbAzlc0oK7zo+Zi52AwxSwTWNk+V7g4UnJxWNeTeblMF8C9prQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIs5qeq9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso87595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710339217; x=1710944017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S7rzA3Q12yyyNj0yHPuw2b6cR1SlWu1XVF5K5zh5cM=;
        b=KIs5qeq9Gn5BHHH3Bc84KXKzVEfdrKZSofpNy5gIUD0p83xEfdnRyD7W+/P6os9Flj
         NQ0NYKX0bfJuHj8nL9+Mo0Zu/PciH8FSYqjWkzS6eaZEmIWYcybX8pmRQX+d2y8TalMC
         iFYeyPun/VdIUMVSxKF4Klm3StcQNt7SZXu7Xb+jEcM8o5yKGiR9yFW3opmW1koxGTgv
         txk21ZraikygMkGi43ZEEZrbHkak2MDavjvuq33Ww2Jx2vYW7fqP+zcuYlqG/DXe+xhA
         8Ko9t2Wh4Dq8TxZaKaocILC0btyL5G2b9xeLVIbHnKP1RA3HztSgy9vxPAED2LsLFNqC
         1OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710339217; x=1710944017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S7rzA3Q12yyyNj0yHPuw2b6cR1SlWu1XVF5K5zh5cM=;
        b=ThSKyeUppnTNzUn/5HAki9PGM/MuFHuNUnkk14o1tIFeUQQGz2r9XBj+PQKnnWkxUT
         PmyaM0PXQbQPCdDXjlKOG7gBmqcHO/Gri1G28iVVV1SgKVapkTRbha9seuWzWD8spzMG
         MB6GZwaOMNcV6QhF35O7vmwGpR0HL/AUNbmT3xG6rJC6SPVCrxIc7JJNNhNBxAH1RWb/
         tUbY2Uuhaj8rAL6d+vCQA+QLN81CW7OQ6Us4xaMDQYXZ4/+PB4zQu0vEgS73ALYy9DQh
         42i0BQ7R4oq0WwSgvgUgLu84QJTROJIpZU60VqjPXWQFZZWNDjb8UqRTtACy7RpgOyRq
         Be3g==
X-Forwarded-Encrypted: i=1; AJvYcCWkqTTgcI+eUotZWN5n6cuLSsTjxbQZ0cNWhVrdUrXI0TtlvBisGmCheSC50q2aDT2fmNXLoufcH3E6aCeNdDB9gAcmZf6KVi02zkpT
X-Gm-Message-State: AOJu0YwDSnC277K06FRi5NW3TWpbAxyzgVbU3vESZz+Oo+aQuQoQtgVR
	BOyDeL/jzkk4tEvX3sm3fkwr66AAURW26YJ5buOoDfwJg4IsS1qiVwg07LtPXcKph1xR2Vx0q8y
	232x+EFK83oKWDj9E+nQNLx5Xe6pqp8druABk
X-Google-Smtp-Source: AGHT+IGWezW5K3xlgUgzmO8FPKgclsOf/ynFUCVJY/rj65VqiXhUcA0s6QDTTr3YLAp7kN7pUTc5FTJk9XZpVw0QVC4=
X-Received: by 2002:a05:600c:5006:b0:413:e6a1:81b5 with SMTP id
 n6-20020a05600c500600b00413e6a181b5mr145981wmr.7.1710339217325; Wed, 13 Mar
 2024 07:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313132214.48716-1-m.lobanov@rosalinux.ru>
In-Reply-To: <20240313132214.48716-1-m.lobanov@rosalinux.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Mar 2024 15:13:25 +0100
Message-ID: <CANn89iLfExAa7T+0bjyBHdbwrF-77SF+QaMHpy-tg7dYEp0YKQ@mail.gmail.com>
Subject: Re: [PATCH] x_25: Adding a null pointer dereference check to the
 x25_accept() function
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:23=E2=80=AFPM Mikhail Lobanov <m.lobanov@rosalinu=
x.ru> wrote:
>
> To avoid the problem of dereferencing the null pointer in the x25_accept(=
)
> function, you need to add an additional check that the pointer skb is
> not equal to NULL.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
> ---
>  net/x25/af_x25.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index f7a7c7798c3b..91bc5994cef6 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -896,7 +896,7 @@ static int x25_accept(struct socket *sock, struct soc=
ket *newsock, int flags,
>                 goto out2;
>         skb =3D skb_dequeue(&sk->sk_receive_queue);

skb can not be NULL at this point, we hold the socket lock.

Otherwise the bug would be in x25_wait_for_data()

>         rc =3D -EINVAL;
> -       if (!skb->sk)
> +       if (!skb || !skb->sk)
>                 goto out2;
>         newsk            =3D skb->sk;
>         sock_graft(newsk, newsock);
> --
> 2.43.0
>

