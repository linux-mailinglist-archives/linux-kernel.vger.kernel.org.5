Return-Path: <linux-kernel+bounces-68605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72D857D07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6CA1C24525
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5E1292E7;
	Fri, 16 Feb 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXlgCRLx"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E977F25
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088422; cv=none; b=tnr9kQylzKPsoVBLHMJYT3Tp+qpvONj6qGQCli5c8Vn7FGB4mjEN5GG1qrSPj4EffE9G79szAjxqrFUuNpwPcfy9dda56ZLocWZlvzmzGXmb2eCRsvz7ANAqlq6eg9ZoTteewCNLeYBolfsT/MkRBo+0KWK5/elgZmCXnKy2oWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088422; c=relaxed/simple;
	bh=Q9FiHqnCHL3E9ZvpPaMJlycI3lYQXhzRD9PL8gpGn8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7deCAsWKzk2A8wQBouVKOimJpoVv8HOAdS3TmKUBd2WcBFpOnz1N//r6PtB8zhltnShcqlAwY56SBsY0K2GuKLaI1h4tDkn4RBIzEU8OUk8mlRcyrrDgvtQQexNkBhhrPp2ZsYW6eE2YBbMp+UC32JLYFVrlNKI/sFbK3p73gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXlgCRLx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so8725a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708088419; x=1708693219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj9qHpnR2tZ5jt/5wBKldh4E6F0wiDuhfNceA+AIwtM=;
        b=PXlgCRLxxS/FGlYm89xP7uMKPvWqH+M1p3ZP8ZMWF46ULy7hA0GhUT38lVg+j2pMn2
         kJn8UWHcuBcm1/nD4UGjCjfIKvsHkQpDh4kNkKhCu2eeBejlM9ZIXijxfyGgRp2OBGJf
         HaKHXLehSdttdDs5Ppt9LwR6Pq9WLgAEDcC/R3BwMGgNzVJxP6fMwfFGN8/QSbmL83+a
         67BoT+Q4Zm3pnBe6ZAHb0y4fyyWJwZzx/LWfvrCQ2Rfbz+401LXH/z6APb2rahajrAta
         CFsWH5YbXvC+j2Q8LnLEc4LE1dFgGwCNkUwyXKWCm7xJ5yintfQTVAdHEq6HW1xTymfK
         KD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088419; x=1708693219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj9qHpnR2tZ5jt/5wBKldh4E6F0wiDuhfNceA+AIwtM=;
        b=b2ab4OaBcj8qSSCyGPLrgRraFescqG4+E1Ro2u9M9hblv+DFqbeIOgSLV92tPcJ2/2
         2jelmBE3fXa0rXd74+9YL4uotDDrvvWna3UwRqrOYzNzo4IHfq+6RhAvXwu+xfVdhw2I
         esDR1hwwX9oFwHHyrNvLOnGkzWPQ/Fws/BkocKufFyPwOXMcNqHHeoSliQ/wM2GNmGEU
         2pCTePdX+RTYdti4gwxmCzIuibd4u91Te0x4FMjG+blwomqNTrqDSs9CgTNxpEMOrEI4
         YcQA0ZLKuFZ3FbpNtpNsDTig/AREf6OfORr1Bt6L+uj41ZsHmLKOw3pv8ErXtzECrkWW
         LhUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+ts8zzofz3joGZNjEGTRHGgVa6LTlSKTWLZUkXJNyVmCG6mt5kluZZ6ok7VfKOulSaOAUSlMmo/pq5AJFlyLbtmH4N2+biCU5MRs2
X-Gm-Message-State: AOJu0Ywp6BSsh106cvexoQxF+UgDGYoXBmQQ0XvkWpuIhQk4e8f9GDtv
	/egFG49H1UgpNGKGDQ5+LIfsUhORTfQBmTpXWNBzydqWy5Q6Z4ie9yrKGWM0w8AfcdqYnfpgNPE
	9h9Cx9fD194BjGSt5aMtd63Fi8UmXhU3gUoFY
X-Google-Smtp-Source: AGHT+IH6t+rDZIwMBeUCKDrzESqhamtknUSblj4Qf/L6XceYjvRS/fJdntgggy1qv/Xtpgu1kSWQXxNC+O2zfyJrCdY=
X-Received: by 2002:a50:d65a:0:b0:560:e82e:2cc4 with SMTP id
 c26-20020a50d65a000000b00560e82e2cc4mr188151edj.3.1708088418945; Fri, 16 Feb
 2024 05:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216125443.2107244-1-colin.i.king@gmail.com>
In-Reply-To: <20240216125443.2107244-1-colin.i.king@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 14:00:04 +0100
Message-ID: <CANn89iJM=fVSkzz9HRU+HXYm+R+owKqah0TT8sY-soEXf2HiNA@mail.gmail.com>
Subject: Re: [PATCH][next] net: tcp: Remove redundant initialization of
 variable len
To: Colin Ian King <colin.i.king@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:54=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> The variable len being initialized with a value that is never read, an
> if statement is initializing it in both paths of the if statement.
> The initialization is redundant and can be removed.
>
> Cleans up clang scan build warning:
> net/ipv4/tcp_ao.c:512:11: warning: Value stored to 'len' during its
> initialization is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  net/ipv4/tcp_ao.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 87db432c6bb4..3afeeb68e8a7 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -509,9 +509,9 @@ static int tcp_ao_hash_header(struct tcp_sigpool *hp,
>                               bool exclude_options, u8 *hash,
>                               int hash_offset, int hash_len)
>  {
> -       int err, len =3D th->doff << 2;
>         struct scatterlist sg;
>         u8 *hdr =3D hp->scratch;
> +       int err, len;
>
>         /* We are not allowed to change tcphdr, make a local copy */
>         if (exclude_options) {
> --
> 2.39.2
>

Cc Dmitry Safonov

Dmitry, can you take a look ?

Thanks !

