Return-Path: <linux-kernel+bounces-99982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C8787902D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91821C208BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E377F1F;
	Tue, 12 Mar 2024 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtjdwQoI"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05177F11;
	Tue, 12 Mar 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233937; cv=none; b=JoKdFUqDA/Wk6ms1480GI5KA6xurQW1HMjH2TtFB9wEwJrbTy8+aM5vzLMkaYzA4wVNReeI0YYeipBqGDgncqx0W5fy66bJfxlhfuLG77Sfg9qEOZJTR7Nglwf8IxgcHDVeqxLitWCKV9mtG3/rfCnOVS5rGK6QEq+QnG9nuu9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233937; c=relaxed/simple;
	bh=IgGDXvXnPgHsdTCOD9BRPW+VYmAQesSaJeyq28PdSjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChDYQxG36T3JWPJ4DBvdzjfgM5qaU70AksOIexDIUds8JGLkyUQJYCge1aOa0JeGSVP/5S9RwPMdLs+Iomb4KbVcTtzLWJUxlIk0V3GPUNU+GRFexVWqxMDNilmRd8ZW5PtKLS28HyZFIHXDCpFyq9u8NWhJrlGHrEf+YJrZeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtjdwQoI; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46444dac18so43664366b.0;
        Tue, 12 Mar 2024 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710233934; x=1710838734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evzEvBJepbXE0zhqomdwTyF3Gg2aETOcoMQgudr1UBY=;
        b=EtjdwQoIgn7n9c6fjObFuAdSuUv3tk/tQAGcRRQMH7lkSlEQ5sUkflFIhzEI8xhzNI
         gsZguOv8yhyZokg2+q5CGzyTaSfJygm1Ow7oWIfiHCy6mLLzLIqBtxYcGb0CcBR5OzS7
         aox4GTM+2nPBx6lLXZoGeuP5DLKnjjGYroY04jhqhkSgt+9iolZS2leYIYaWbFx4g6Hd
         dIvWoc2/j0nzK0HxlZ7ZiKiT+RzPl77dMIkrwHwAj5Yl02wsNr+DsXVjL+1H6d3XBkDd
         1CqPjd5aN44USMl6o/v7jfa+T9PJ/TQS0DTEyIgo9W8K7e0ttamwsO65iajMj+1Ux5zi
         Lr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710233934; x=1710838734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evzEvBJepbXE0zhqomdwTyF3Gg2aETOcoMQgudr1UBY=;
        b=fPT5R+Mr7DiEV2Fcj6eXPn1aVKgQPVt0sOYtmze1Iu0zP6RkQlGzjEiPXb+KuzSqld
         D7a3WqXmC3n9qBsPniSsFBjMXJcH2cv1PS7pBi01AMOemhPi+TEWTLL9Z08uHC/MBPZ/
         aZWRSob9PRuqLxex3+gukUGMUGPGO8gyabhwnlUP6T2+K5MB6OcVG/CzGlNyRzWYbnVR
         Qh/dgj+qXI5s19c2p2oOEZ+TAzV2G6SNYoQEeiFOCGVdZ1tLBLBBA1tXAsm1hhlolkuF
         wGWpms0QB7NUFMAeGKF7hSjda0e+KeZRY4goxmBwb8Xewk2l4UfQkQwRKM9eFBH2xGoL
         mWiA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ16KSgEH/nKJYX1ZEI4bESjsjAblZovNWMcrUySshYZzt+yZMfB/gFBsR2u4FEgz22J0uUQh5QjwHrmlreyED/1LYh79kGXq1ZSS7OhE6oXAm2Qq2VYu4RtwAQ1byqd3YcVQ/JqPnPw==
X-Gm-Message-State: AOJu0Yxh9P3RVqs4blDbv6NYrtzj8PcArvGlyX3G7Icmt6e9ebYIdQX7
	/hYhNR3sj+q3sJpNVTcQtHAGBZ3MKq8kemubPuKo66L1cQDHlHRyH4iwmiXBnqBh3eWWaK2qH7s
	FVi7MFrcc1GzfF82b4OZ/6BfWmQI=
X-Google-Smtp-Source: AGHT+IF9JvJrb2/FplmixKFLcqdSBjT9Yznq++16jQFKdM0wr5aJDcwS8Gg5cNV8XDSYVFmVcsh9iBFWdXJxB+WlOIw=
X-Received: by 2002:a17:906:d10d:b0:a3f:ce8:1234 with SMTP id
 b13-20020a170906d10d00b00a3f0ce81234mr5101278ejz.68.1710233933409; Tue, 12
 Mar 2024 01:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
 <20240307024034.1548605-3-gnstark@salutedevices.com> <CAHp75VfkTxRtMc_SpXoyoVjiWxm=c6_1VjeiRFUo4C7kH4HmUA@mail.gmail.com>
 <5ef5fb8d-f1be-4c8e-92fe-f40b68478228@salutedevices.com> <b7147fb3-fbe1-4063-823d-31f77b8ac801@csgroup.eu>
In-Reply-To: <b7147fb3-fbe1-4063-823d-31f77b8ac801@csgroup.eu>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Mar 2024 10:58:16 +0200
Message-ID: <CAHp75Ve_4oM7PkNsWAQZ1XEBQ8knROjdjyh17YLdSeXw7M6juA@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: George Stark <gnstark@salutedevices.com>, "pavel@ucw.cz" <pavel@ucw.cz>, 
	"lee@kernel.org" <lee@kernel.org>, "vadimp@nvidia.com" <vadimp@nvidia.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>, 
	"hdegoede@redhat.com" <hdegoede@redhat.com>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"will@kernel.org" <will@kernel.org>, "longman@redhat.com" <longman@redhat.com>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "nikitos.tr@gmail.com" <nikitos.tr@gmail.com>, 
	"kabel@kernel.org" <kabel@kernel.org>, 
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"kernel@salutedevices.com" <kernel@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 7:41=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 12/03/2024 =C3=A0 01:01, George Stark a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de gnstark@salutedevices.com.
> > D=C3=A9couvrez pourquoi ceci est important =C3=A0
> > https://aka.ms/LearnAboutSenderIdentification ]
> > On 3/7/24 13:34, Andy Shevchenko wrote:
> >> On Thu, Mar 7, 2024 at 4:40=E2=80=AFAM George Stark
> >> <gnstark@salutedevices.com> wrote:

..

> >>> Signed-off-by: George Stark <gnstark@salutedevices.com>
> >>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>
> >>>   Hello Christophe. Hope you don't mind I put you SoB tag because you
> >>> helped alot
> >>>   to make this patch happen.
> >>
> >> You also need to figure out who should be the author of the patch and
> >> probably add a (missing) Co-developed-by. After all you should also
> >> follow the correct order of SoBs.
> >
> > Thanks for the review.
> > I explained in the other letter as I see it. So I'd leave myself
> > as author and add appropriate tag with Christophe's name.
> > BTW what do you mean by correct SoB order?
> > Is it alphabetical order or order of importance?

> The correct order is to first have the Author's SoB.

At the last one is submitters. So, if it's the same person, which one
should go first?

--=20
With Best Regards,
Andy Shevchenko

