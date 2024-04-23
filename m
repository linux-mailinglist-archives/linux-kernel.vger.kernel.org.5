Return-Path: <linux-kernel+bounces-155251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C18AE779
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BA71C2349D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340F135A61;
	Tue, 23 Apr 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqMNts0R"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DB13540A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877692; cv=none; b=obf4bDfOOEribcWfVa8v9HTEfA51T0DlyiY4XpF5lbSjsFt41naqQkDY9fqjamo1NPRRUIhPfXdqhXTQTBIhiB86bHOspVHLYkMhPq7WFH63EjxGVK4QNsyjA2uVQJ2keqwvy10Ahy2Yca0Ti8qjh/ShauQi8qg7VdkI9fHwlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877692; c=relaxed/simple;
	bh=DIofB15Qivmzs709LA/UCNNp98ddCcOIPZm7noqNGaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTr/zuIhpxGYfmHeCCGgi15UwR7dTJo3KNiqK0gHDMcleM7mBDGKWSe2fy393PeTEokV4VMgG1jpPP5nvYw0OOh/TGoWEqbJTQP7WU+HmpcTrD6FVURyyDnN1FoNVEnvXU+nnFY4evodqTJDB7NKAPc1PyJLZeEs9IF+V1mBIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqMNts0R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so13300a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713877689; x=1714482489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIofB15Qivmzs709LA/UCNNp98ddCcOIPZm7noqNGaU=;
        b=YqMNts0RkTxGf4PE44Pbu18mzP0+E5GwVdik9HxBvAYppbNLpSd/s7gl5tHUkfDviL
         3gITSn+zH27wtApquJeXJ7I+43T53MVseBejuDEpQ4EhyQAC/Ab3SnxKL58CxJdPlpcf
         wq5I5Gn2HmAbElbQVFTJGOa6JNbKxE+uNY3xW5Nqr/45xpy0UNqIkOrRJziKjtVSLjon
         WnOhvLS8T0BsvIPzhoXeSCEwnC/4qRayfxfn0f8qQ4M5sfyl5a0rgVf2Rv0jyB6/ebrm
         89PzHiHnUaQKQM1U+NzzUcK+XksjSju2svGQeccwfAHwNfyDdjYJEqopV9go68d+Dy6r
         bjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877689; x=1714482489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIofB15Qivmzs709LA/UCNNp98ddCcOIPZm7noqNGaU=;
        b=prsZApvEk3SLgVpwsQuuxyfTNNIzkXfkhXvdOH9aVw8kndJZAL0DagTmHpr11YNQ7K
         YcaFFZl30T52UT+wZjzdc7lCAKTQGhy52c3kwgY9tC+zYevbWhtQoTSUKDkB+GzAN+8p
         LsZck05WiE8Js465PppDTWs7g2teTYnP94kM3f3WISAICXOXFtYRHO/h/ShgjZR2ienB
         i2i8t7nB8YcFiA1b+VUj3IIupgSp1NT0+ebATOSrQBKrMD1HQ+WCNGGpFlpCCULIp2SE
         86Wu6AgDnCLVWQx+oKoDECsx2N9+IUDL4AsYE5aC8NYwzvDKlu+wyxI1Qzv1SJUTzEDI
         KRuA==
X-Forwarded-Encrypted: i=1; AJvYcCXxHzUDaGtVaRFP97SqnJHqlFWTfVC1Xvw2lQqO9FiKj7TqroPDdJcHDO5P91No0Fk5lXRe998Ax/VEd459W7P2ID1VfIgTLa3nWfBM
X-Gm-Message-State: AOJu0Yy2m5i+ouPv8sBVWSRw573EEgqs4eh2U8DDCFPPOownkMHYTQXt
	45nMrhVCbg3ACFDlD0r2173c97cSGK55xJ4zdUEafEbSckx2vLqEchV8NOouu8Jl/s6ubIwbUyO
	20rbQHKSI28eOuFj7WuIj1gj+C9Gyv6CW98vK
X-Google-Smtp-Source: AGHT+IG1CqMYXDb6MmvohfvHnHDpajO9sP+RZzdX7WxKkEgj20SOdwCh4rNvJCngR9zCOPE9b1XHP8y3Qyb/r0YiJug=
X-Received: by 2002:aa7:df98:0:b0:572:2611:6f38 with SMTP id
 b24-20020aa7df98000000b0057226116f38mr18681edy.2.1713877688658; Tue, 23 Apr
 2024 06:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name> <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name> <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name> <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
 <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
In-Reply-To: <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 15:07:54 +0200
Message-ID: <CANn89iLD1JW078L9hkex+WZdAcA5unC5_J=JjUG1ypZM_syFtg@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:23=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 23.04.24 14:11, Eric Dumazet wrote:
> > On Tue, Apr 23, 2024 at 1:55=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wr=
ote:
> >>
> >> In the world of consumer-grade WiFi devices, there are a lot of chipse=
ts
> >> with limited or nonexistent SG support, and very limited checksum
> >> offload capabilities on Ethernet. The WiFi side of these devices is
> >> often even worse. I think fraglist GRO is a decent fallback for the
> >> inevitable corner cases.
> >
> > What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST_GRO =
already ?
> >
> > Many of these devices are probably using NAT.
>
> In my tests, nftables NAT works just fine, both with and without
> flowtable offloading. I didn't see anything in netfilter that would have
> a problem with this.

This is great !

