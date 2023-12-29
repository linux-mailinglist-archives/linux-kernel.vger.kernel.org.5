Return-Path: <linux-kernel+bounces-13101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CF81FFB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39BB1C217A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913ED11713;
	Fri, 29 Dec 2023 13:37:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0D11C89;
	Fri, 29 Dec 2023 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbb09061c0so702450a34.0;
        Fri, 29 Dec 2023 05:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703857067; x=1704461867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drT8s+9Lo4+5xk7ZxtQR2sSrDLvVgTHuFaCMfu3pdag=;
        b=jjjdrYmlt83Gxk3/lJbyEgIGy5auA5McVadTlVL3n4SJQqq95Eo5/TzyxkZB0TI2lE
         Z3SzGkvNGiG6cSMiH9xFsD8QcuqP/5MiP8rJt+ftWRxPaCtElntDIPRM796ODSz48l0j
         y+g++xfj2M+QTmQuQ7aWdxXm3FuZ9PMKdCK+5O35x60JNnGWk2Zhbp4nMpUaeZzg4soQ
         OjxHh8Yb7vAIOw3UyMFi/beCZRmJN6Z04ElIT7GLxLDlw4bDE4sMiccN9iT4tpe+G+h/
         m5xHJ9NQft4R04hvEB534sfzV29BaVnTarQ/qp3CblNRuC+16r5L3URwbef6s34/0JbU
         S/DA==
X-Gm-Message-State: AOJu0YwS3u/Lk0dKXGLTWFFPtorC8bqiHBxgtErDtHxOg87Fh91Mlqxj
	wHHpv5xXNGHLk6KcK1EqnpjEebzl5iiCL9SIr24=
X-Google-Smtp-Source: AGHT+IGEah4smnh3673Ggbi7LnWBwdysNZv3gQ/XZQ6XmhmEhR2aGnlwdVeSk4oAdq7B71RVy2rkTd8yfY0wZSTVa1s=
X-Received: by 2002:a05:6820:2801:b0:594:cb36:b255 with SMTP id
 dm1-20020a056820280100b00594cb36b255mr7180554oob.1.1703857067610; Fri, 29 Dec
 2023 05:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher>
 <4874693.GXAFRqVoOG@kreacher> <ZY3auVvVzxwTmAX8@linux.intel.com>
In-Reply-To: <ZY3auVvVzxwTmAX8@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 14:37:36 +0100
Message-ID: <CAJZ5v0gns5zeLEk39NGwjLy40wzHAHDWYBYapWwQWcJ9jrF-3Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] async: Introduce async_schedule_dev_nocall()
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Youngmin Nam <youngmin.nam@samsung.com>, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com, 
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 8:02=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Wed, Dec 27, 2023 at 09:38:23PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In preparation for subsequent changes, introduce a specialized variant
> > of async_schedule_dev() that will not invoke the argument function
> > synchronously when it cannot be scheduled for asynchronous execution.
> >
> > The new function, async_schedule_dev_nocall(), will be used for fixing
> > possible deadlocks in the system-wide power management core code.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |   12 ++++++++----
> >  include/linux/async.h     |    2 ++
> >  kernel/async.c            |   29 +++++++++++++++++++++++++++++
> >  3 files changed, 39 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/kernel/async.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/kernel/async.c
> > +++ linux-pm/kernel/async.c
> > @@ -244,6 +244,35 @@ async_cookie_t async_schedule_node(async
> >  EXPORT_SYMBOL_GPL(async_schedule_node);
> >
> >  /**
> > + * async_schedule_dev_nocall - A simplified variant of async_schedule_=
dev()
> > + * @func: function to execute asynchronously
> > + * @dev: device argument to be passed to function
> > + *
> > + * @dev is used as both the argument for the function and to provide N=
UMA
> > + * context for where to run the function.
> > + *
> > + * If the asynchronous execution of @func is scheduled successfully, r=
eturn
> > + * true. Otherwise, do nothing and return false, unlike async_schedule=
_dev()
> > + * that will run the function synchronously then.
> > + */
> > +bool async_schedule_dev_nocall(async_func_t func, struct device *dev)
> > +{
> > +     struct async_entry *entry;
> > +
> > +     entry =3D kzalloc(sizeof(struct async_entry), GFP_KERNEL);
>
> Is GFP_KERNEL intended here ?

Yes, it is.

PM will be the only user of this, at least for now, and it all runs in
process context.

> I think it's not safe since will
> be called from device_resume_noirq() .

device_resume_noirq() runs in process context too.

The name is somewhat confusing (sorry about that) and it means that
hardirq handlers (for the majority of IRQs) don't run in that resume
phase, but interrupts are enabled locally on all CPUs (this is
required for wakeup handling, among other things).

