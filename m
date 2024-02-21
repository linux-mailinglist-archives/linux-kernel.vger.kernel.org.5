Return-Path: <linux-kernel+bounces-75238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1C85E50A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2464BB246C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870584FDF;
	Wed, 21 Feb 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grs3g+Tx"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149984FAD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538239; cv=none; b=Ihvw3Oh3AnKLTAYV5EuMdvhDXMM7nKa3ki1ff7NUGo7vjUBoQIcjq5+vWGemaMQCF60r+odlayKTLlrry6DMSUg1hJ39C8Gtl0aIZEZrG/MLWOzsRrr0JkDjsSfqFpdeO0uWjwL7kzX9NEszTbcmhCiRrNb5GqyQ2oEySodOLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538239; c=relaxed/simple;
	bh=snF2AHY120g3OhxA2vENPtcrzHOEEZsmVGU8tDA7DVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL27TfPzIw9a/nxP+/7Ly5NjeEwYiWnz3YbH08xkGQAnmKtjYUBSB2B2ak7HiuSEhOYs8aXWu2ADa6ESkXb6SKCJ9UxCYmuqh1lglRYg02s4dty4ZxZ3B7c6nAytvb47qyK/LDagDIVmaTkNrdDWfoG2AEWW2RQ2n12OZdqrU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grs3g+Tx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso108a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708538236; x=1709143036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNXJGwZ1V9rRdN3pg0jgyM1bnXXSlvPDHdCD030Tkqc=;
        b=grs3g+TxMO16uAGgKnZcudGakRDZfecL5XTEFG9ss2Voo9F35kOIDveQwItKuz7sjv
         0J1V0p81CDM3Qa806IT325Zg78T+3FNFzu9N32yiFuWKB82K6MWq9nLMvwEUn4AoSiVA
         VpmClX0qXO4UKKKuklGinDSGO4JTOOUwSaFHRlUuWC/sEUXd56rKSGu3uKxdGBHRpCXu
         DHCgwgc9ZMj7qBQd1hlaokn24vOFpV4dRBIZiD5jDm4ykztIrTESrhYt5p9fGydmiBvH
         SeOoXC8Zbb0DGjonhK5j+vatUMFvknxmsIG2mY5UBeBMkELd0CHUppSsgHp8Pr8bGKdc
         cLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538236; x=1709143036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNXJGwZ1V9rRdN3pg0jgyM1bnXXSlvPDHdCD030Tkqc=;
        b=ugE6myr+REmENwT7zmVJ/0dMO5ZaLd/CY1C8UayC3dGhKqm3zjGJ0RIsYSnshy0Vez
         47rtyABgV6+fKHTMdxBftYG+ebjFIduzRUAvcqB0Vu2p8ss9YH9lXbz60dWe8dAD6zBj
         jsQAnEoliii2nXaWB6v3uT69GqQhxgWkV3puxot7J6u6uPm2beQ8Y+QXH93f2AZCfbtD
         xZZIUCQnZABrV3Xa1yVDUa+5F2Ry40MEPOizIFxR8wVYrGXnTVfnSDrMHqyEG+VDF8DL
         aObOkoPWsSk9ZoFCWRW2VdEW1MNRCdtf73cZKFiqihDS0BMmZbm9d4rG0dpbrn5WBsSy
         Zyrw==
X-Forwarded-Encrypted: i=1; AJvYcCUY/un72NsD1GGtTWp58t/Z4zPFdgEj58bqJhKkGm099UUy2qafGjgLOG5f7v77rT9iCIA8kGijhVfVCIna7n+jR4ulGD3Ohie/6zEt
X-Gm-Message-State: AOJu0YxuqEt5gvzyjM/gjTdkz4j8d4IY081oCR+E4A0WgyscpTwgj4x2
	VTe1gxvyGbnR8Aq5mwEuxGf5nxdR1692B5krw3k9ijlR1XkpAPTm+DI/BZyFJjt32GDEtfrOFBo
	fDnqA0EvV47jQkpMv7X2tBlnDOp37dX0KWr/n
X-Google-Smtp-Source: AGHT+IGieBwCGp1ECmxryncPYyi3r957SefzYuTlHBgpp8Lk7jz3qwLnAxBAaJ10d7ZTmmPhPmfgf1P51pspPyb5g/s=
X-Received: by 2002:a50:9fc1:0:b0:563:afb0:28a with SMTP id
 c59-20020a509fc1000000b00563afb0028amr238422edf.0.1708538235826; Wed, 21 Feb
 2024 09:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221164112.846409-1-vilasbhat@google.com> <20240221121420.2e32fd00@gandalf.local.home>
In-Reply-To: <20240221121420.2e32fd00@gandalf.local.home>
From: Vilas Bhat <vilasbhat@google.com>
Date: Wed, 21 Feb 2024 09:57:03 -0800
Message-ID: <CAJNZHTTeFJvCjxUX_e_RVtJWcXW=1cjdF8EqvojnObm7jiyLKg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: add tracepoint for runtime_status changes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Saravana Kannan <saravanak@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 9:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 21 Feb 2024 16:41:10 +0000
> Vilas Bhat <vilasbhat@google.com> wrote:
>
>
> > diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
> > index 3c716214dab1..f1dc4e95dbce 100644
> > --- a/include/trace/events/rpm.h
> > +++ b/include/trace/events/rpm.h
> > @@ -101,6 +101,42 @@ TRACE_EVENT(rpm_return_int,
> >               __entry->ret)
> >  );
> >
> > +#define RPM_STATUS_STRINGS \
> > +     { RPM_INVALID, "RPM_INVALID" }, \
> > +     { RPM_ACTIVE, "RPM_ACTIVE" }, \
> > +     { RPM_RESUMING, "RPM_RESUMING" }, \
> > +     { RPM_SUSPENDED, "RPM_SUSPENDED" }, \
> > +     { RPM_SUSPENDING, "RPM_SUSPENDING" }
> > +
> > +/*
> > + * ftrace's __print_symbolic requires that all enum values be wrapped =
in the
> > + * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in th=
e ftrace
> > + * ring buffer.
> > + */
> > +TRACE_DEFINE_ENUM(RPM_INVALID);
> > +TRACE_DEFINE_ENUM(RPM_ACTIVE);
> > +TRACE_DEFINE_ENUM(RPM_RESUMING);
> > +TRACE_DEFINE_ENUM(RPM_SUSPENDED);
> > +TRACE_DEFINE_ENUM(RPM_SUSPENDING);
>
> You could do what everyone else does:
>
> #define RPM_STATUS_STRINGS                      \
>         EM( RPM_INVALID, "RPM_INVALID" )        \
>         EM( RPM_ACTIVE, "RPM_ACTIVE" )          \
>         EM( RPM_RESUMING, "RPM_RESUMING" )      \
>         EM( RPM_SUSPENDED, "RPM_SUSPENDED" )    \
>         EMe( RPM_SUSPENDING, "RPM_SUSPENDING" )
>
> #undef EM
> #undef EMe
> #define EM(a, b)        TRACE_DEFINE_ENUM(a);
> #define EMe(a, b)       TRACE_DEFINE_ENUM(a);
>
> RPM_STATUS_STRINGS
>
> #undef EM
> #undef EMe
> #define EM(a, b)        { a, b },
> #define EMe(a, b)       { a, b }
>

Thanks for the comment, Steven. I did notice both methods of defining
enum values for tracepoints and chose this method because it felt
clearer. Could you clarify on why the method you suggested is
preferred?

> > +
> > +TRACE_EVENT(rpm_status,
> > +     TP_PROTO(struct device *dev, enum rpm_status status),
> > +     TP_ARGS(dev, status),
> > +
> > +     TP_STRUCT__entry(
> > +             __string(name,  dev_name(dev))
> > +             __field(int,    status)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __assign_str(name, dev_name(dev));
> > +             __entry->status =3D status;
> > +     ),
> > +
> > +     TP_printk("%s status=3D%s", __get_str(name),
> > +             __print_symbolic(__entry->status, RPM_STATUS_STRINGS))
>
> This will be what you want with that last redefine of EM*()
>
> -- Steve
>
>
> > +);
> > +
> >  #endif /* _TRACE_RUNTIME_POWER_H */
> >
> >  /* This part must be outside protection */
>

