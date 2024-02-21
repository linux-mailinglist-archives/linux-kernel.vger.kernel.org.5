Return-Path: <linux-kernel+bounces-73929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5785CDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B07B281716
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44955244;
	Wed, 21 Feb 2024 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC7M6ECg"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37F1FDD;
	Wed, 21 Feb 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480891; cv=none; b=c4JfLtDLjofbuDEQB6CAuo0VPIYAQobn++Avn1GJB1g2d4n8MMaQV1M5Z3gr6O++A2mXu1yCNqT+OdYp3QOOyzLH27SvSDJJKYQZFP6VbaLOtR4zgxVS0qd8NgZgFvatTfYhrXEK2PbcLUx0obarR+/IkndgW6+RrDxcHzAx6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480891; c=relaxed/simple;
	bh=mLYufBarS+anA/5cTEM92vcNh7G3ytXILJ+fGEiq25s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbxMcaM9Q4c7pM3vtR2TBWacpL9DfC3socbs8GApA3h5MBumRW4lCVNItF3+EdTtWs3cXFKUQ4FI00AnVZSdXRfFbEHGcuJtKwSiRphaw0tNLJ4DBa63lnFrzK9aOcTdihyWcDT7A2JeKTAuKuSbFF9nhanG2Tgmid60V2+yBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC7M6ECg; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21e9589d4ffso58602fac.1;
        Tue, 20 Feb 2024 18:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708480889; x=1709085689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gv63IFLi2zDTh48OgfLa/wNUqIS6t0y+R/igyPXNzg=;
        b=MC7M6ECg4TH4AVpM1VCSHYC4MSlBZuPk6+m5iNb5XeXbFF21eeqMc21qX0QsS/pI7p
         oN9p8mva11U+inzBlsFErY1Z336uOjBuJ/5+urUEQb2GdaTgvUfMHMZM1swBv6epb+DQ
         LZ5Gp+Ut+XlW9abb2hQUhmGjtt17zW1u5pnWwFRGjFHKoMDgGXhJ8q1afjXQiIyBqXTn
         3JWKEX9FgxYU4LItTve6BHRQst/nUMltwWjZGRnOISvuXijDtFydQ92QvOyVhafYdnUT
         cmHKMqowoV+kXa95HHv50MRZmM7H9L3FeQzJcSIYM6Zd0v/wVCo1MkYp5BqAfEvOtQGR
         MHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480889; x=1709085689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gv63IFLi2zDTh48OgfLa/wNUqIS6t0y+R/igyPXNzg=;
        b=JzySk0m4sSRvqwmFds30kY9nAeX3Mvy0IjPYKoAS+4imjYKOOI2bdkV/r6+dY5Zk52
         n1GxCGe0h+eB0VeoY144Sp4oklhjvk/doZgGwUq0U6Yxx4W501wqt+/XYFnqo5Y0Z2Qv
         Q3oZIFqOyibjdPnwrTFuF5KZSpu5fbM4B1JSAQoifvJ486v344gk65YdhEcnclNGHWKX
         jSk2YTrWNQeR1D8Ge6MImxRFXAzSWyqGR0noUXjT+kmw4iXBTIq0ztJqcnm7knNpsz16
         8wXr2Bb3WA9BZVoRe8hCmSL9I56Jj4TiQmAkdYSPg5qXjywKaudn0+XeZpmlp4UyXFLV
         D2fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHtTZkQjGjhbKjrnuADw0TdzGiUHma0XKv3/zJt6Xh9UNgiUzS6mqyqumcPOHPdnXD6A0ujZO34NS+eaQBi2cPC91JMhUgPY8uLcja77E/do1CQaVR+DSWFkmmPnF6DyGLPxQhHwtq
X-Gm-Message-State: AOJu0Yzes4RDBV28Uegu+s1IIwNHVM9Fjo7xy6ssKTpXYY4kb7QYQTW2
	1r3FI3YPndzdgVxhf7FzOegoV1aWGD2ir1tM8ep1JuXTuWnqBuOqJGPt5HlwZhpupxfLeLIKg3I
	6kSUAGsnxF+3db1uJQwONBxRr4qo=
X-Google-Smtp-Source: AGHT+IExEGk1SZ5Vc6bP3hXb0hJMFYaLJSbgus97zoLXvJ8X0jQV/+2nWxIQMmLBoRccBZHA3yya5lghfADnDmtkGFw=
X-Received: by 2002:a05:6870:55ca:b0:21e:8f75:95a2 with SMTP id
 qk10-20020a05687055ca00b0021e8f7595a2mr9881270oac.12.1708480888711; Tue, 20
 Feb 2024 18:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219074634.2039-1-xuewen.yan@unisoc.com> <ZdTXWrB8dascOIM_@slm.duckdns.org>
In-Reply-To: <ZdTXWrB8dascOIM_@slm.duckdns.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 21 Feb 2024 10:01:17 +0800
Message-ID: <CAB8ipk9R3hRSTTEEBn8nvOcTZGBtaDQfomXiQwji+DTKgLghwQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Control the frequency of intensive warning
 through cmdline
To: Tejun Heo <tj@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jiangshanlai@gmail.com, corbet@lwn.net, 
	paulmck@kernel.org, rdunlap@infradead.org, peterz@infradead.org, 
	yanjiewtw@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun

Thanks for the reply!

On Wed, Feb 21, 2024 at 12:46=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Feb 19, 2024 at 03:46:34PM +0800, Xuewen Yan wrote:
> > +#ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
> > +static unsigned int wq_cpu_intensive_warning_per_count =3D 4;
> > +module_param_named(cpu_intensive_warning_per_count, wq_cpu_intensive_w=
arning_per_count, uint, 0644);
> > +#endif
>
> wq_cpu_intensive_warning_nth is probably shorter and more idiomatic.
>
> > @@ -1202,7 +1206,7 @@ static void wq_cpu_intensive_report(work_func_t f=
unc)
> >                * exponentially.
> >                */
> >               cnt =3D atomic64_inc_return_relaxed(&ent->cnt);
> > -             if (cnt >=3D 4 && is_power_of_2(cnt))
> > +             if (wq_cpu_intensive_warning_per_count && !(cnt % wq_cpu_=
intensive_warning_per_count))
>
> But aren't you mostly interested in the first report? Note that these eve=
nts
> can be very high frequency and reporting every nth event can lead to a lo=
t
> of constant warnings. Wouldn't it make sense to keep the exponential back=
off
> while allowing adjusting the initial threshold?

Yes, it makes sense to keep the exponential backoff,
but this may result in not being able to see the warning when the
threshold is exceeded for the first time.

Or what do you think about changing it to the following?

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d741..e783b68ce597 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1202,7 +1202,8 @@ static void wq_cpu_intensive_report(work_func_t func)
                 * exponentially.
                 */
                cnt =3D atomic64_inc_return_relaxed(&ent->cnt);
-               if (cnt >=3D 4 && is_power_of_2(cnt))
+               if (cnt =3D=3D wq_cpu_intensive_warning_nth ||
+                   (cnt > wq_cpu_intensive_warning_nth && is_power_of_2(cn=
t)))
                        printk_deferred(KERN_WARNING "workqueue: %ps
hogged CPU for >%luus %llu times, consider switching to WQ_UNBOUND\n",
                                        ent->func, wq_cpu_intensive_thresh_=
us,
                                        atomic64_read(&ent->cnt));

When the cnt reaches the threshold for the first time, a warning can
be printed immediately.
When it exceeds the threshold, keep the exponential backoff.

Thanks!
BR
--
xuewen

>
> Thanks.
>
> --
> tejun

