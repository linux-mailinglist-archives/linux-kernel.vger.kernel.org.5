Return-Path: <linux-kernel+bounces-102502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBBD87B304
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A19C1C238CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDE51C49;
	Wed, 13 Mar 2024 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OF7EDGDB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F42570
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362900; cv=none; b=AFrVcvB50YlRAukD3J55WcBGxLP1+MdrSkVWLX5wfCUgZwQeQl34f0J5TijbiD3cV2uC9833eLGAuykVXG4h3NsFamxwzaymAMZCFHIKw2awPRIltfpKW2arh5MWwu4LtJz4jtz1upVd7wFmGYuy2u/4E86rhnyj7MyDOGaowgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362900; c=relaxed/simple;
	bh=Qs82lcXumefYXpExMq3K66hhPd5zaxuwF7JwqNXx9iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/98g8vYb39eJmP/UhSWoAVdUqnpt93ypMsdL6sWdq1g40P2xdJwE+bTjpcebAOGXPxhaZt5L+jOsZPAZ7MD8u49ulUwOco8Ek8T8flLkld0ST6ifOncNya4VzhVp/xKaMuEIeYfqIQMxLc+x3HIuU6Y6ZvcW2Ae3mmbXl5T824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OF7EDGDB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45606c8444so28504466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710362897; x=1710967697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PPuXpkeGm2u0OvGSXHyAWpUcDKXz5BztlE6+aKXcrYM=;
        b=OF7EDGDBmmuyTKI5wyvojDoVQbgQkPFxMtFPvlzVtQMfv04STtxyHTCY6ZI0mt2frT
         1KimqT+tw1aJotnLGnPfqY0BAV3azV0zA6RPZ7Zc/FXC9NrvOgzcKahk/H9UgFdBkH9w
         kG408dtdZTcwDA5xO5NGhW1nGL5qIlsYayKGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710362897; x=1710967697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPuXpkeGm2u0OvGSXHyAWpUcDKXz5BztlE6+aKXcrYM=;
        b=lZSPooVs67foFWe4LY7SY4S7R3T9E70Z9nWl8sUp+r560vAc4GdYmMaJUaes6LC+0b
         I/f+7VpXeK8d7UVSOYKvR3AjhwRSJg5JIsqJoUCEiZUb8Xq4MGeo9JoewNS9KWnHLvA/
         sW9Px/3+gzVsKUKVVHhJKsIy0HEL/kpl/aziynkFlRqr3CKxLZw5ATmlk3FzOq8QKS+3
         uGHAPxpBzq2ad7BIUgGd/AFgeK1NrOUgEqnId0araD6+xrIvibbYFd+U7NMvZ5elfsXe
         Y3Hp8EzBm/kAQq0LDD17Q1kMNRbnMoky6nZdgnflsQ5/oThZSjc6TwAX4j5l0me7AOyn
         2auw==
X-Forwarded-Encrypted: i=1; AJvYcCUYvXi/fCwVQ6653Lsb4pOHj88KcxINLAFQfVsrn52SSJjv3Ga6fkgoQKRwLTbJTY0k8Ghg9gqa0d00rQQqbCNP6mNXYEAW6PaToQHL
X-Gm-Message-State: AOJu0YyUcUPKwpcKi2oXG+s5xWdx/X+XRnyB6CSB3xaBDSH/KsSNXkYT
	mRM7DZPM532fneC0jFb2KwXhgbWMrr9uICin/vc5yqoELWB1qbdMYrAJEegeZYhSHcLRigK2qK7
	1kj4WEA==
X-Google-Smtp-Source: AGHT+IFjHSMIcPKkFkeZwbjZG++1+POOej0GxqU36zH57K1TpJeqPI60BU08G1SlCGPu56ZG7Gyejw==
X-Received: by 2002:a17:907:1606:b0:a45:efb1:d4d8 with SMTP id cw6-20020a170907160600b00a45efb1d4d8mr11647230ejd.53.1710362896810;
        Wed, 13 Mar 2024 13:48:16 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id lx9-20020a170906af0900b00a4638693bbfsm3455ejb.116.2024.03.13.13.48.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 13:48:16 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so319466a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:48:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+hzmHoTSffLxHAAl3t88RTPTrLMx2ndgGpSShGk/oI5EJngeoQA21eUY5eq0tEP7qdXqg1Bs4MvGJ/53T97sR21MV5j5ujrHO9zra
X-Received: by 2002:a17:906:dacc:b0:a45:e270:609c with SMTP id
 xi12-20020a170906dacc00b00a45e270609cmr11079476ejb.23.1710362895736; Wed, 13
 Mar 2024 13:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
In-Reply-To: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 13:47:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
Message-ID: <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 18:10, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus, few patches for you - plus a simple merge conflict with VFS
> changes:

The conflicts are trivial.

The "make random bcachefs code be a library function" stuff I looked
at, decided is senseless, and ended up meaning that I'm not pulling
this without a lot more explanation (and honestly, I don't think the
explanations would hold water).

That "stdio_redirect_printf()" and darray_char stuff is just
horrendous interfaces with no explanations. The interfaces are
disgusting.

Keep it in your own code where it belongs, don't try to make it some
generic library thing.

And if you *do* make it a library thing, it needs to be

 (a) much more explained

 (b) have much saner naming, and fewer disgusting and completely
nonsensical interfaces ("DARRAY()").

And no, finding one other filesystem to share this kind of code is not
sufficient to try to claim it's a sane interface and sane naming.

But the main dealbreaker is the insane math.

And dammit, we talked about the idiotic "mean and variance" garbage
long ago. It was wrong back then, it's *still* wrong.

You didn't explain why it couldn't use the *much* simpler MAD (median
absolute deviation) instead of using variance.

That bad decision directly results in that pointless use of overly
complex 128-bit math.

I called it insanely over-engineered back then, and as far as I can
tell, absolutely *NOTHING* has changed apart from some slight type
name details.

As long as you made it some kind of bcachefs-only thing, I don't mind.

But now you're trying to push this garbage as some kind of generic
library code that others would use, and that immediately means that I
*do* mind insanely overengineered interfaces.

The time_stats stuff otherwise looks at leask like a sane interface
with names and uses, but the use of that horrendous infrastructure
scuttles it.

              Linus

