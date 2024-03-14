Return-Path: <linux-kernel+bounces-103739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB887C3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240BD1C226F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301675817;
	Thu, 14 Mar 2024 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMGh2pUV"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140161A38C6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445477; cv=none; b=ieJ6FjygUQo4UbSHsoJEXKyLr4qGOB4lHrWyvIegpI6DWdIbAG1n1629w3k69iN1hgFZPRHKmYIRldbU1UW2Jx5Um77RNBxaIMV202Yw1TPuiRgRCqbsWWjPDLZAQJ0eLIRZwXtYZWDW/5SdxGtNtoVbw4ufhcRzvMghtORQYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445477; c=relaxed/simple;
	bh=f5tL1mvuYvO0AshWdH3WTbV/Ee3Y79O3EkJx8aBJaA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TofbPdHJTraBXcJF1FD00ByjamK0YQKSYTNnDW/MQmFmuqgCkHtJzap/hUagOGrR93JCOEtQPCtuWiknN9huR74cv/jYcTUSnQy60HFbCLVitalioEIZ+DEijdMrAY7Qs6Wgy23DikoAuprgHoigFhcW9IgaTA8xbak+8rbXksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMGh2pUV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so1711cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710445475; x=1711050275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOBjDmVKA5zRB4l04283eg35xpgmUMSDXLAd+siCSCA=;
        b=hMGh2pUVcPCHxxTzf0Jf5MXDEJe/XapQKqErY/0gi6qrJDuxe6gtOQjjLPsOINsZ5R
         ZaQe/51F0ZlckkAr+svObDLGGwRCOpPt4Rzs07shYWIe14TZIW+YV8o4Brd3NLw8nvH9
         QkRjjmcf1klnRDgYgLNBry807F/X0cjKpQZxG6nvVFf++54gDF9RgQjzt6nx0uAAS/MM
         Rtwwk8SxiirQywO3J4NQV0JWqzOZAm0mXLiFkFIDc4js9iqZ+zmtLc8hFGPOQ0z6c6Ny
         0+OZ0iTq6RwneNeUZjV8sSf/rrXhzUtdgNoh4sy4N6kuoHH33eit5/cLR5YddRaLK+bq
         zeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445475; x=1711050275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOBjDmVKA5zRB4l04283eg35xpgmUMSDXLAd+siCSCA=;
        b=Pqzd81HRXlNovEWGlm9SluWtY8c6b/3YMDsem9bjxquYEHBo1mU3hG1GWIQxtzLnAH
         9pb0NQXuBftsbbFGQZ7orhzBcfSQRA1/MNxXej+ey8pLnDyuIFs8D2gOFzU5jw9ljQ1f
         a9hNopagi06wT/+F8UMQwH46MgmOw0lH1VismbL5xlSlE1mJ4VrgYzcSIaJ8jmndeab0
         9pUzk81krsNlfJvJu9XYaEVw0NNrWemnoa04P3LrvFzIsa8OvbFIyfPxQl5od5g0PVjo
         7GzgTb5sAwxlPqMfvDlQM4lRcjh5Q3S1oKf2H40k6xsLFOTQqQS6kVT2JQUlBqKq5nmF
         I7eA==
X-Forwarded-Encrypted: i=1; AJvYcCXuHuJ26hgacHhLtH9c2wnOwPlnFAaa0wdixpwY8EwU7OkzEJ0Ux3tb3YYYtJE+XbiaGpfTyVavZWfAoz5S6BRNFYbiEShbEcyFFyqJ
X-Gm-Message-State: AOJu0Yz3I8itGh5h370Ri+jqMpdVEtFCAMVseSd8sOaHtYMdEiWmN3uz
	XkcAjAYJP/YtmAWdPkSIdtCKKsWLo/BrbpLA+K9V/vrycmhpFxZKaJ0wt5TVpUxfhtPmOIhWggx
	jQtvJJlSuPplCRPG0ma3BM9hs0fpaL4xDb8Cw
X-Google-Smtp-Source: AGHT+IHCt4qa8F771F5HRT5vHNOciOj9DayMfSe/fEjO0ceISNRxm5i1lgjEhoG/E1429wEX5YrZl+WSnAlYAkh1YME=
X-Received: by 2002:a05:622a:9:b0:430:ad98:cc44 with SMTP id
 x9-20020a05622a000900b00430ad98cc44mr59024qtw.12.1710445474828; Thu, 14 Mar
 2024 12:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313210124.2858729-1-linux@roeck-us.net> <CA+GJov5V5+X9FY7MD1Q+eBeEcJeUjQEuK3Qw8LJ0Oho9KtuXtQ@mail.gmail.com>
 <c34e1c68-254f-489b-925f-0e7906b3a89f@roeck-us.net>
In-Reply-To: <c34e1c68-254f-489b-925f-0e7906b3a89f@roeck-us.net>
From: Rae Moar <rmoar@google.com>
Date: Thu, 14 Mar 2024 15:44:23 -0400
Message-ID: <CA+GJov6j7Spi2bPki2Z2rDp+AarkM0dwrXjPKrVksDw0Uo2D0g@mail.gmail.com>
Subject: Re: [PATCH] kunit: time: Add faster unit test with shorter time range
To: Guenter Roeck <linux@roeck-us.net>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	Daniel Diaz <daniel.diaz@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 3:30=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/14/24 12:05, Rae Moar wrote:
> > On Wed, Mar 13, 2024 at 5:01=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> Commit a547c4ce10bd ("kunit: time: Mark test as slow using test
> >> attributes") marked the time unit test as slow. This means it does not
> >> run anymore if slow tests are disabled. This reduces test coverage and
> >> is thus undesirable. At the same time, the test currently covers a ran=
ge
> >> of 160,000 years, which has limited value.
> >>
> >> Add additional test case covering a total range of 1,600 years. This t=
est
> >> takes less than a second to run even on slow systems while still cover=
ing
> >> twice the leap year calculation range of 400 years around the center d=
ate.
> >> This test can run even with slow tests disabled.
> >
> > Hello!
> >
> > I really like this addition of another time range test. This looks good=
 to me.
> >
> > Thanks!
> > -Rae
> >
> > Reviewed-by: Rae Moar <rmoar@google.com>
> >
> >>
> >> Cc: Rae Moar <rmoar@google.com>
> >> Cc: Shuah Khan <skhan@linuxfoundation.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>   kernel/time/time_test.c | 35 +++++++++++++++++++++++++++--------
> >>   1 file changed, 27 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
> >> index 3e5d422dd15c..15c6f3a5e73c 100644
> >> --- a/kernel/time/time_test.c
> >> +++ b/kernel/time/time_test.c
> >> @@ -47,18 +47,18 @@ static void advance_date(long *year, int *month, i=
nt *mday, int *yday)
> >>   }
> >>
> >>   /*
> >> - * Checks every day in a 160000 years interval centered at 1970-01-01
> >> + * Checks every day in a specified interval centered at 1970-01-01
> >>    * against the expected result.
> >>    */
> >> -static void time64_to_tm_test_date_range(struct kunit *test)
> >> +static void time64_to_tm_test_date_range(struct kunit *test, int year=
s)
> >>   {
> >>          /*
> >> -        * 80000 years  =3D (80000 / 400) * 400 years
> >> -        *              =3D (80000 / 400) * 146097 days
> >> -        *              =3D (80000 / 400) * 146097 * 86400 seconds
> >> +        * years        =3D (years / 400) * 400 years
> >
> > This is tiny but if there is another version, I find this comment a
> > bit confusing. Could you change this to maybe be "total seconds =3D"
> > instead of "years =3D" because years is used as a unit on the right sid=
e
> > of the equation?
> >
>
> Good point. "total seconds" might be just as confusing, though.
> How about "total range", "time range", or just "range" ?
>

I see that. Any of those options look fine to me, maybe just "range"?
Whatever you think is best of those.

Thanks!
-Rae

> Thanks,
> Guenter
>

