Return-Path: <linux-kernel+bounces-103712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92687C34B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A041F214C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9404F74E32;
	Thu, 14 Mar 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qs0NxC+/"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030243AD7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443117; cv=none; b=OCJY4xFNgRHegn9ZfbUgL4RkDZowz0xp98i5HGRKbu/m+X41w4qW6M4tVJAsgCVEvG7clWmvitKEb8fb3Q9+9pWk7YjVNN1nHKJDu2UKwP4pXD6jqCFm2vDCjyHbYKVH0v8yfyXi0wRXV2i8EhdAcQQufpY/kwkPwE/+7lTqxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443117; c=relaxed/simple;
	bh=BVOV+7HgAZGv2ZjMJbzwEfbfwQFctfQ57pFLSILJMZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNvMazhfji4z65efGLw0PcIk2q9eeyKXDD54fw3cwWCv3n8GMSBYF2wRQN0FF86gkpt6crQp8ZIKIR5yvpa7ui+Iiuju2PAPEn6XKqPkZYcCBKy7zcNCui5Uv3Jd5j9QtwAG4IHY53kEfo68IEF7SYzOINVx4mxOHvO0BNDjjjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qs0NxC+/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42ee0c326e8so56271cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710443115; x=1711047915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=depVmA6uSnLT9/3+j2aUB2+F05F8STMINAi2XuQGOKU=;
        b=Qs0NxC+/HkQJHMTivVd1stbSv2rnA81sOXhfkzPUTDeEe/JVum5T6KwBwHf74LkD2s
         bTc4dTzqUswjC0SVsKnjYah1p2aLTuLsWjnHujAVmOYVcIAHmRgtRVdLNOItQoFkTjNA
         FEPbEdvFrK3kwTlwbY0QW6Pp05ol11Lbldy3aaJow7tE24Winwn/c1bVlXFKOjb7oHkO
         y8WTguM4d3WXZ8NGCvSKGNDxNZinhLdS3NM3YX2qTmdzZ1ZEhznjUdMea3OjN9J9ESug
         N0WzGqc+cXTxcx6rvpVdXFiQlJb0k98wcDorSgFzKHG681SSR3OOpfknZMCJWr8vVtbJ
         2s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710443115; x=1711047915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=depVmA6uSnLT9/3+j2aUB2+F05F8STMINAi2XuQGOKU=;
        b=CgSWn6HqZG3B9A4abhPzBeGDtIiFLw9AoNH0UGDfKJfZyFmwE9h8cjGXIUxk13oEEC
         nJKmqPVr4a55X4GhHdlpXsARMzSMLaYJMyMMjsALx00176QsyKIX1JRhX8QiC+f3qiGM
         OGzlJewYPfHRipV6oGv5wgXA53tLsuU/pddKHEYei/B8UjNQUzsSIAYxCiqiovZtaN8V
         uPVWJ4HCH0+dPi1H/YRIzKqvomtIOZo2fB+be9rzcFNGz64Cgm2R0qVS8IJw8NbYMw/i
         0n/7Na+QvKYSdW4vEfHw2RJCG2azeAhKt+OotUqR+Hu5FECVuxh30CJFWLI+GXIXPM9E
         zOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbmcrDfXR15IOGII+0/DNX/SI13xTEdpox5hdA7wGclCIvJd/sVkAfaWuR+LdvAVXB24StuvKcoIStpTYlejZ3m9YH1q0NA235tP4v
X-Gm-Message-State: AOJu0Yy7iNCPamjQmgHad/qu+JbHsMxQNSTKJK0AZmDt0fzUGS2KXild
	cJOKa2CU9ipHk6PDuBLi5Wq4nY/45JUxDAaFlR8Aytg6CHBuoQvCI8WxQDbk3vquX7xQG5id01R
	pUqdlfNVR+k2ZwLHmyJR1cIECKV/ua/1EWCjU
X-Google-Smtp-Source: AGHT+IEktmZVvF+0wuNG6LuojM35/lrKEucTCjdOrXSsH80WO0UsBXYMx+SQkUnWkF0MZD1gbs52XWfV2Ay0LUHivmI=
X-Received: by 2002:ac8:7778:0:b0:430:a909:fb32 with SMTP id
 h24-20020ac87778000000b00430a909fb32mr117698qtu.13.1710443115035; Thu, 14 Mar
 2024 12:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313210124.2858729-1-linux@roeck-us.net>
In-Reply-To: <20240313210124.2858729-1-linux@roeck-us.net>
From: Rae Moar <rmoar@google.com>
Date: Thu, 14 Mar 2024 15:05:03 -0400
Message-ID: <CA+GJov5V5+X9FY7MD1Q+eBeEcJeUjQEuK3Qw8LJ0Oho9KtuXtQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: time: Add faster unit test with shorter time range
To: Guenter Roeck <linux@roeck-us.net>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	Daniel Diaz <daniel.diaz@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 5:01=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Commit a547c4ce10bd ("kunit: time: Mark test as slow using test
> attributes") marked the time unit test as slow. This means it does not
> run anymore if slow tests are disabled. This reduces test coverage and
> is thus undesirable. At the same time, the test currently covers a range
> of 160,000 years, which has limited value.
>
> Add additional test case covering a total range of 1,600 years. This test
> takes less than a second to run even on slow systems while still covering
> twice the leap year calculation range of 400 years around the center date=
.
> This test can run even with slow tests disabled.

Hello!

I really like this addition of another time range test. This looks good to =
me.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>

>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  kernel/time/time_test.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
> index 3e5d422dd15c..15c6f3a5e73c 100644
> --- a/kernel/time/time_test.c
> +++ b/kernel/time/time_test.c
> @@ -47,18 +47,18 @@ static void advance_date(long *year, int *month, int =
*mday, int *yday)
>  }
>
>  /*
> - * Checks every day in a 160000 years interval centered at 1970-01-01
> + * Checks every day in a specified interval centered at 1970-01-01
>   * against the expected result.
>   */
> -static void time64_to_tm_test_date_range(struct kunit *test)
> +static void time64_to_tm_test_date_range(struct kunit *test, int years)
>  {
>         /*
> -        * 80000 years  =3D (80000 / 400) * 400 years
> -        *              =3D (80000 / 400) * 146097 days
> -        *              =3D (80000 / 400) * 146097 * 86400 seconds
> +        * years        =3D (years / 400) * 400 years

This is tiny but if there is another version, I find this comment a
bit confusing. Could you change this to maybe be "total seconds =3D"
instead of "years =3D" because years is used as a unit on the right side
of the equation?

> +        *              =3D (years / 400) * 146097 days
> +        *              =3D (years / 400) * 146097 * 86400 seconds
>          */
> -       time64_t total_secs =3D ((time64_t) 80000) / 400 * 146097 * 86400=
;
> -       long year =3D 1970 - 80000;
> +       time64_t total_secs =3D ((time64_t) years) / 400 * 146097 * 86400=
;
> +       long year =3D 1970 - years;
>         int month =3D 1;
>         int mdday =3D 1;
>         int yday =3D 0;
> @@ -85,8 +85,27 @@ static void time64_to_tm_test_date_range(struct kunit =
*test)
>         }
>  }
>
> + /*
> +  * Checks every day in a 1600 years interval centered at 1970-01-01
> +  * against the expected result.
> +  */
> +static void time64_to_tm_test_date_range_1600(struct kunit *test)
> +{
> +       time64_to_tm_test_date_range(test, 800);
> +}
> +
> + /*
> +  * Checks every day in a 160000 years interval centered at 1970-01-01
> +  * against the expected result.
> +  */
> +static void time64_to_tm_test_date_range_160000(struct kunit *test)
> +{
> +       time64_to_tm_test_date_range(test, 80000);
> +}
> +
>  static struct kunit_case time_test_cases[] =3D {
> -       KUNIT_CASE_SLOW(time64_to_tm_test_date_range),
> +       KUNIT_CASE(time64_to_tm_test_date_range_1600),
> +       KUNIT_CASE_SLOW(time64_to_tm_test_date_range_160000),
>         {}
>  };
>
> --
> 2.39.2
>

