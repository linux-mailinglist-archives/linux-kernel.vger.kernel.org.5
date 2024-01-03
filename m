Return-Path: <linux-kernel+bounces-15392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C429822B62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EB01C2330A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB518C18;
	Wed,  3 Jan 2024 10:28:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B818B02;
	Wed,  3 Jan 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-593f182f263so2313243eaf.0;
        Wed, 03 Jan 2024 02:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277690; x=1704882490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79MA5mMYhMqlBMT3UdwxVRu7oiSGpObuTnBSyo71O6Q=;
        b=GJnkkyzO9Nl+hrC7LGM/0j+043lAF0/G7gTDoXTjxrkMpO0PE1qVXqZ+W4r68QrGvS
         J5onYYMRWpGeqnFLvDDKHRq77iclp2c3ZSHNfA04SxKsgeMA6iDpzToL/D/doY29cN7y
         aa++dfHSqz5aeXeo4CXA/z+3aqIB4C/xGiZm+LJQjhXprKlLfafKxVIVZr6E+rslr9ka
         cNO44KiotS1MT8RyB6GkCErLSPbPoGcE0jJJPy4LKPtOVVqyCOGddv/39jagaq3tpUou
         QHzkFOxFU8Bqrqa7udttW+R4UeefUu3mESRhRiNZhNFlNnCbbUQun4cm9rIbgkbnWY8u
         DPZQ==
X-Gm-Message-State: AOJu0YxJ7Y5D7aDpdZupRQFLhpdWcTlaaE91hJV+J8xyEzWIY32wbfV5
	iGfX9A0ysv1NgoaYw5BSl2BoHnHAh46MoRs5Yos=
X-Google-Smtp-Source: AGHT+IG90TbSEQfgxYIyKGuzGek/9DmwLWKH58ETmib42la/qr639eT55Rs8z4WHZqU7mBrfv3NkyzUfQJ87Pbl3ul4=
X-Received: by 2002:a4a:da55:0:b0:595:e0dd:9f8a with SMTP id
 f21-20020a4ada55000000b00595e0dd9f8amr3563340oou.1.1704277690051; Wed, 03 Jan
 2024 02:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher>
 <13435856.uLZWGnKmhe@kreacher> <CAPDyKFohQjDzpYpm0QQLM4eTzGOzGfDNKUGHHC-niPBOrtR8BQ@mail.gmail.com>
 <CAJZ5v0jPtYFk=pPE63CGGL0kuc+N_bZqKdgBMC=PMrwqzHBDTg@mail.gmail.com> <CAPDyKFp5BGpVX5WZxD+u4QELD9KEKVGE41q8mPxM8Eg4dP7RLw@mail.gmail.com>
In-Reply-To: <CAPDyKFp5BGpVX5WZxD+u4QELD9KEKVGE41q8mPxM8Eg4dP7RLw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 11:27:59 +0100
Message-ID: <CAJZ5v0h1-E-gAK9PPYi1UR6=WpoU3v8ir8NUAX2D+qVJYm_jcg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Fix possible deadlocks in core
 system-wide PM code
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Youngmin Nam <youngmin.nam@samsung.com>, linux-kernel@vger.kernel.org, 
	d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:17=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 2 Jan 2024 at 14:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jan 2, 2024 at 2:35=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > >
> > > On Wed, 27 Dec 2023 at 21:41, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > It is reported that in low-memory situations the system-wide resume=
 core
> > > > code deadlocks, because async_schedule_dev() executes its argument
> > > > function synchronously if it cannot allocate memory (an not only th=
en)
> > > > and that function attempts to acquire a mutex that is already held.
> > > >
> > > > Address this by changing the code in question to use
> > > > async_schedule_dev_nocall() for scheduling the asynchronous
> > > > execution of device suspend and resume functions and to directly
> > > > run them synchronously if async_schedule_dev_nocall() returns false=
.
> > > >
> > > > Fixes: 09beebd8f93b ("PM: sleep: core: Switch back to async_schedul=
e_dev()")
> > > > Link: https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
> > > > Reported-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > The commit pointed to by the Fixes: tag is the last one that modifi=
ed
> > > > the code in question, even though the bug had been there already be=
fore.
> > > >
> > > > Still, the fix will not apply to the code before that commit.
> > >
> > > An option could be to just do "Cc: stable@vger.kernel.org # v5.7+"
> > > instead of pointing to a commit with a Fixes tag.
> >
> > Right, but one can argue that every commit with a "Cc: stable" tag is
> > a fix, so it should carry a Fixes: tag too anyway.
>
> Yes, certainly. But in this case it's more questionable as it's not
> really fixing the commit it points out.
>
> Note that, I have no strong opinion here, but maybe Greg has a preferred =
way?
>
> >
> > > >
> > > > ---
> > > >  drivers/base/power/main.c |  148 +++++++++++++++++++++------------=
-------------
> > > >  1 file changed, 68 insertions(+), 80 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/base/power/main.c
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > --- linux-pm.orig/drivers/base/power/main.c
> > > > +++ linux-pm/drivers/base/power/main.c
> > > > @@ -579,7 +579,7 @@ bool dev_pm_skip_resume(struct device *d
> > > >  }
> > > >
> > > >  /**
> > > > - * device_resume_noirq - Execute a "noirq resume" callback for giv=
en device.
> > > > + * __device_resume_noirq - Execute a "noirq resume" callback for g=
iven device.
> > > >   * @dev: Device to handle.
> > > >   * @state: PM transition of the system being carried out.
> > > >   * @async: If true, the device is being resumed asynchronously.
> > > > @@ -587,7 +587,7 @@ bool dev_pm_skip_resume(struct device *d
> > > >   * The driver of @dev will not receive interrupts while this funct=
ion is being
> > > >   * executed.
> > > >   */
> > > > -static int device_resume_noirq(struct device *dev, pm_message_t st=
ate, bool async)
> > > > +static void __device_resume_noirq(struct device *dev, pm_message_t=
 state, bool async)
> > > >  {
> > > >         pm_callback_t callback =3D NULL;
> > > >         const char *info =3D NULL;
> > > > @@ -655,7 +655,13 @@ Skip:
> > > >  Out:
> > > >         complete_all(&dev->power.completion);
> > > >         TRACE_RESUME(error);
> > > > -       return error;
> > > > +
> > > > +       if (error) {
> > > > +               suspend_stats.failed_resume_noirq++;
> > > > +               dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> > > > +               dpm_save_failed_dev(dev_name(dev));
> > > > +               pm_dev_err(dev, state, async ? " async noirq" : " n=
oirq", error);
> > > > +       }
> > > >  }
> > > >
> > > >  static bool is_async(struct device *dev)
> > > > @@ -668,11 +674,15 @@ static bool dpm_async_fn(struct device *
> > > >  {
> > > >         reinit_completion(&dev->power.completion);
> > > >
> > > > -       if (is_async(dev)) {
> > > > -               get_device(dev);
> > > > -               async_schedule_dev(func, dev);
> > > > +       if (!is_async(dev))
> > > > +               return false;
> > > > +
> > > > +       get_device(dev);
> > > > +
> > > > +       if (async_schedule_dev_nocall(func, dev))
> > > >                 return true;
> > > > -       }
> > > > +
> > > > +       put_device(dev);
> > > >
> > > >         return false;
> > > >  }
> > > > @@ -680,15 +690,19 @@ static bool dpm_async_fn(struct device *
> > > >  static void async_resume_noirq(void *data, async_cookie_t cookie)
> > > >  {
> > > >         struct device *dev =3D data;
> > > > -       int error;
> > > > -
> > > > -       error =3D device_resume_noirq(dev, pm_transition, true);
> > > > -       if (error)
> > > > -               pm_dev_err(dev, pm_transition, " async", error);
> > > >
> > > > +       __device_resume_noirq(dev, pm_transition, true);
> > > >         put_device(dev);
> > > >  }
> > > >
> > > > +static void device_resume_noirq(struct device *dev)
> > > > +{
> > > > +       if (dpm_async_fn(dev, async_resume_noirq))
> > > > +               return;
> > > > +
> > > > +       __device_resume_noirq(dev, pm_transition, false);
> > > > +}
> > > > +
> > > >  static void dpm_noirq_resume_devices(pm_message_t state)
> > > >  {
> > > >         struct device *dev;
> > > > @@ -698,14 +712,6 @@ static void dpm_noirq_resume_devices(pm_
> > > >         mutex_lock(&dpm_list_mtx);
> > > >         pm_transition =3D state;
> > > >
> > > > -       /*
> > > > -        * Advanced the async threads upfront,
> > > > -        * in case the starting of async threads is
> > > > -        * delayed by non-async resuming devices.
> > > > -        */
> > > > -       list_for_each_entry(dev, &dpm_noirq_list, power.entry)
> > > > -               dpm_async_fn(dev, async_resume_noirq);
> > > > -
> > >
> > > If I understand correctly, this means that we are no longer going to
> > > run the async devices upfront, right?
> >
> > Right.
> >
> > > Depending on how devices get ordered in the dpm_noirq_list, it sounds
> > > like the above could have a negative impact on the total resume time!=
?
> >
> > It could, but it is unclear at this time whether or not it will.
> >
> > > Of course, if all devices would be async capable this wouldn't be a
> > > problem...
> >
> > Sure.
> >
> > So the existing behavior can be restored with the help of an
> > additional device flag, but I didn't decide to add such a flag just
> > yet.
> >
> > I'll probably do it in 6.9, unless the performance impact is serious
> > enough, in which case it can be added earlier.
> >
> > I still would prefer to get to a point at which the suspend and resume
> > paths are analogous (from the async POV) and that's what happens after
> > this patch, so I'd say that IMO it is better to address any
> > performance regressions on top of it.
>
> Fair enough!
>
> [...]
>
> Feel free to add my Reviewed-by for the series!

Thanks!

