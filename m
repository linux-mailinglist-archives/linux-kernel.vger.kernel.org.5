Return-Path: <linux-kernel+bounces-84713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCC86AA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE63B1C23D17
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D202D634;
	Wed, 28 Feb 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6S2HM7Y"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F42E84F;
	Wed, 28 Feb 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110738; cv=none; b=I3I6t416e+xw/LaxqChkdH/9YeRGqnclH1ldTE52rJufNhUgBUPiciQ9geOfvJ1/Da56rLqsV/jcMqMmSFEdhP9J2jaHMLXRjOc6d6B0GllFWSiTaM9rZBT1c1HqLy0czXCoFwZtk7DBgO/67htuxlLWFAgrHU+hdnVGCZ8XaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110738; c=relaxed/simple;
	bh=yIUst7+3ODvs408zwYXRT1jR3LK2s1xhcE0dmgtWszk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jO5wostoCxouUsJFR9eXPIhYjjPNki+xCIvt84ouzChUCEmWWIcsjMTu1iwTarq03WZ2EsydD9lhVVvnNTF6ADzebwg+OF4fuah9Eidtwy26VLIjluybukUquEQLwH0KwxzJRPVnrW0El9aDD1IvonbpjLd27xwXNgJomUT8MZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6S2HM7Y; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2305589a2so74281721fa.1;
        Wed, 28 Feb 2024 00:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709110735; x=1709715535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A3lAAmSMgn6GRalT76bIAGFZOne7C/ohlC8xFZVbW0=;
        b=O6S2HM7YPGgSZ1jLbxp3gFn1gZbYJMSPnj0DzE0MCZIXRvpSaxwkLEiidvOhPUo55v
         qBmqhDBFkAJGKx12+wHsNOFXG+2wx1Ji974+uKbKBYO+fI7dfsOu2b3XGCyClITqxSB0
         OPebrZ75j0f+AYi9P87lQ1ee676lEWHKqzDszT/p64k371FmLUgbEgn/FGzqlnCEJTd/
         aawouxEd2agFDo6om0Vspzp3Bi9qeRlrXDF7VOmA8/rdGndD030UwNrVgP4EyFTWE50j
         +FO5RnvUi3jmUBljipXLp7oxFpdOOeI4SmYgHIaLdyles1GRkO95wr0pN15hay8AP/ln
         +wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110735; x=1709715535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A3lAAmSMgn6GRalT76bIAGFZOne7C/ohlC8xFZVbW0=;
        b=h946UpZ73QSPfIHODn+qq1lMNTQ1f6DpEgKEahj/ypW2BXP/Hb1RNYDivH2GcQHKHX
         ODmpdMdwWfY8sfbJk86bcLjrgaFZ1mTMsLPlOKL+tNooT6pAtvALlcL0TLmK9S6lg6BC
         2beg+CiIi+4a3FDrDTqGVjpWLt8j6nBbx0vHkNIC14V4DBHEvjF8+y8MBzwRIEsPxh2O
         qLza32hN0dLtJzua5rFQiyUSZqIBYrneylJ6vuKsOb465XBEEazo/EA/EK44RVSj7stP
         DnrYGXNBQBBar5Ypcj6urJD1Ys7PP+8Cf528mkZ2nMVStYSRfb0YWYxeLRTTzJD+bpsM
         ztCg==
X-Forwarded-Encrypted: i=1; AJvYcCU5+TIOtpZkaWl8gomgBRR4q7OxxdkRK+jaMcCB24LwuITbnwrw91Gu/j8BRxOVPIjJra5SwwCRLwEta1HvuZL/Ro0JrhlqvCpqGGBw4M7KA5cTl1UdoU0Ss073m/r4Pbv2dbve
X-Gm-Message-State: AOJu0Yxm6SI1BFftRaGgkMeCY1xiAOb7eorwOy5yaml1Vwbiy5ne/EP8
	/14crMn08haIZUOOXzwy4zgkSdafAsY9VVYTqYyQCGINYMFUYRG6FOsSywHZGcZtEOtAfhFVbLf
	UFNQY1MnRuLiRYnEkK17PC1W53htFM980a6HL2g==
X-Google-Smtp-Source: AGHT+IGjoGQ3AM7Hcs5ExQngiiirhwlBbCJykaS19J2G8iJ062O1vqW4F5tgSKrBFW0xw9SvKOS5NLf9pfO6X2Uik30=
X-Received: by 2002:a05:6512:318e:b0:512:fe1f:d3c1 with SMTP id
 i14-20020a056512318e00b00512fe1fd3c1mr6031414lfe.58.1709110734603; Wed, 28
 Feb 2024 00:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228074308.3623984-2-zegao@tencent.com> <CANn89iLQ8r3e7=RP9F7wO=b+bZbGucbuitOswkVwmijbd1Fzig@mail.gmail.com>
In-Reply-To: <CANn89iLQ8r3e7=RP9F7wO=b+bZbGucbuitOswkVwmijbd1Fzig@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 28 Feb 2024 16:58:43 +0800
Message-ID: <CAD8CoPD-TSt_twgkiHKw_rON9VSRON3vJfxaDLd9rz3PTPOWiQ@mail.gmail.com>
Subject: Re: [RFC PATCH] net, sock.h: Make sure accesses to a fullsock when it
 is indeed one
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>, Honglin Li <honglinli@tencent.com>, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Feb 28, 2024 at 8:46=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrot=
e:
> >
> > We know a pointer that has type struct sock* can actually points to
> > one of some different sock types which have different memory layouts,
> > take req_to_sk() for example, and whether a sock is full or not
> > depends upon ->sk_state which is a shared field among them so that we
> > see some repeated code pattern similar to this:
> >
> >         if (sk && sk fullsock(sk) && sk->field_not_shared)
> >
> > which seems to have no problem at the first glance, but it is actually
> > unsound in a way that ->field_not_shared is likely uninitialized (or
> > unmapped) when it's not a full sock, and a compiler is free to reorder
> > accesses to fields of a struct sock when it can, that is, it could
> > reorder accesses to ->field_not_shared across ->sk_state or load them
> > all before the branch test, which leads to unexpected behavior, althoug=
h
> > most of them won't do this.
> >
> > So leave a barrier() in between and force the compiler to keep the
> > obvious program order.
> >
> > Cc: Honglin Li <honglinli@tencent.com>
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >
> > IIUC, casting a pointer to refer to a bigger object in size is
> > technically UB, which may lead to unsound code. From the POV of
> > a compiler, when it is allowed to assume that one struct member
> > is valid, they all are through a pointer, and thus it's likely
> > for the compiler to do such optimizations and reorder what we
> > want to keep in order.
> >
> > Note this is not a typical way to use barrier(), which only
> > acts an ok fix to what's already unsound, at least IMO.
> >
> > Comments are welcome, since I'm not an expert in C and I know
> > most of compilers won't do this reorder, but I'm being pessimistic
> > here.
>
> Well, my suggestion is to have evidence first...

Fair point!  my initial purpose is to raise my question here to check if
there is UB here and see if C experts have insights on this.

> We are not going to add barriers just because we do not trust
> compilers handling of sequence points.

Makes sense to me as well if this is indeed not an issue here.

Thanks,
        -- Ze

