Return-Path: <linux-kernel+bounces-88045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EAA86DCAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD061F256DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CD69D05;
	Fri,  1 Mar 2024 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D00CdYJs"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFD69974
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280250; cv=none; b=A8g4FqopoRR7JA+A0CldrDWgPKtuviOCEsPthp6nMQAoJHUEzKCzkaV39oHcWVmvZbLO5Kho2e2kmL6hPI1lis0aXcaoSUG2j2ZVm053I9XejjIaBxy5IBt8OlHiFyl4SRLY8fhc7Pb/5rATZEMiW9jUbG3HAVNvXnHtvwA2HaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280250; c=relaxed/simple;
	bh=n4spHHvJLlMGZHVr7fqI5nbP9JLbO0KC62LA3csKOP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puG8cex7Zdl+9C4gbl4fFmZGksiPF1GTYWT4kF16XH/yb8XPsv4HTcyykleC/9ANDHf7eWiomAKxIqEeNdcWjrVT2mxHzMrrzCJQQfl1WmOqTu1j50KMsCexVhyBVE51Ie7elnfAa5IW39BO3AUwRZ4dhzRZR6ZZAL5mvRFD+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D00CdYJs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso8551a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709280246; x=1709885046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X4wFyOx0wdvgK1yfOcV9T4++P8vIrbb+J2WByTndeM=;
        b=D00CdYJsA9JWtnjZ+C9vhCytHtPJvdidm7Kmln0Yh9V3K45PHW9z6eQD5FM/eZaCwG
         1tLHQNUQdSFbLS8kOrs58u5rCu25bpdSeV8r0sOxk+ThaikPu1IkkPcefUYUTQG7jjpZ
         oIkZ0ZXfhTyJuT4sM1pneWLgZ0irXjNn9KWfvvnzdeb8OkRhjmWIjwjShu4FG+9tPiYW
         3pNq6dF4B4LVpoFI3kpxObmQUyfl9P0VoeeIlYDJoaA1XY5HLQkyhwTKmiRcMJ8g14oB
         BhSWHA3X0PojcKTXayhDAwRx96FhThlmBp9NGTJJ14mQriggwzqK1kxTltdq/IBtRBCp
         qmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709280246; x=1709885046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X4wFyOx0wdvgK1yfOcV9T4++P8vIrbb+J2WByTndeM=;
        b=R14nb8vpWZDQo8IxQnn3dB9fiv+M4+MBxuc6iGv1fuAmAatHer050ke6RkIo8NgSwN
         Oj1iegMAGP8OS82qQZJMr7BxDfb1PlKuoY2PS8KgijgAFdtoMSaLFMQSRL0cGdgpTOwp
         nOhl8ZtYKqTlmCxNu7OSSlNboFU08fJLnS6mLevjN38TarfhexhQAuNyM/q5Dj85BFbA
         BUXSlt7EvNl1k3MST57o2KkoH6ivUz2cK2jLU7Rhf+Ym2vPPPbqOeXBlQG6R+/J9/DcT
         q37sFlTrYLiX9ZdaY4Bmqja95CPDTTBTqdcq1Zxs8yE0OKVGIpXZZ/26lBTsLx9CapvS
         BB8A==
X-Forwarded-Encrypted: i=1; AJvYcCUdSBeSWrQravqCTjnOQN8rMeEhO3gXvCPr6Ga2GX0P660dau6/YOWwSle6mJHjwvNdnr49zIeTa1ym4+WpWAy522z1f0aPFfdikuh4
X-Gm-Message-State: AOJu0YxQ7wNSIRu6hWTy28+5FyiL8+GUorkcDCFzkJvMVYUoprnWS5aY
	mK6xbNQOEea6keRsOx+SgizCoJYw9g85wT/UwLwCpphEjc4Xn+p6OCJeG3wgcUD0YBvCgt9mkvd
	22TjQJgcWz/GzUPNsryZGxAUAcAgIIbqFa4oY
X-Google-Smtp-Source: AGHT+IFOvZyHykyduIz94CdHCof11T2iEVmpeMxGsKXRX8OsG8eBWy5K5UWwwoNyQqGC7PCA+EV0NmT93gNYH1arh0I=
X-Received: by 2002:a05:6402:5244:b0:565:4f70:6ed with SMTP id
 t4-20020a056402524400b005654f7006edmr109469edd.6.1709280246294; Fri, 01 Mar
 2024 00:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229213018.work.556-kees@kernel.org> <20240229225910.79e224cf@kernel.org>
In-Reply-To: <20240229225910.79e224cf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:03:55 +0100
Message-ID: <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li <lixiaoyan@google.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 7:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:

> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 118c40258d07..b476809d0bae 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
> >       NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
> >  };
> >
> > +#define      NETDEV_ALIGN            32
>
> Unless someone knows what this is for it should go.
> Align priv to cacheline size.

+2

#define NETDEV_ALIGN    L1_CACHE_BYTES

or a general replacement of NETDEV_ALIGN....

