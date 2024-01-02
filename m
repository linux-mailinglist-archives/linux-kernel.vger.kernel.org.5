Return-Path: <linux-kernel+bounces-14444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438B821D25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFA21F21145
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4774FC1D;
	Tue,  2 Jan 2024 13:54:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA3FC0A;
	Tue,  2 Jan 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dbb09061c0so933974a34.0;
        Tue, 02 Jan 2024 05:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704203650; x=1704808450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A63uk52zyqFjYh0llvOCPkiWnPoFw1GC3tZKy5XNsMo=;
        b=MW0IAeRygRq5dqTocG91zY+MczuwXvsfMzH4blgJ3wR3mQXfzjbs8xowFEcjH1CNgw
         hMkLHrkeHkp6oxXkC8Y9/Fc0pCDL3l240vXAupYgY3LCn4XW5hYnR0tnaulJ7sYG03Jf
         ZbcdU2D9BWYpyHDybI0fTsxFLfW4R9amgZLtdmt3vVKqtovpGXjQNZnjzo00v9TLBo27
         58WRyNOo3zSMDZVprsfQB+HMUwEl63uZBdi8PDm4YsVa+eVTQ8CW6282IzRunE5L/Km9
         XhGikFPEWSm/Q8gCq4urtAO8Ouq0kSZQbPIIlKq1HExTqg+fC7KQlpGCsXfxeyBH3t3p
         VbgQ==
X-Gm-Message-State: AOJu0Yx5eyRDC3ivZh/HQwzDxSR/qt77azz55Y7tXMhr/JNzX5Gmannp
	rbPgu61PHLSdSItIIwmn21ywMTOW82T+B+WtNZk=
X-Google-Smtp-Source: AGHT+IE5oQ8Yj0vxAv+YNy2oM4BXp12oVCkG/KKn+KB4ZFH+qy2RF0Sby8ynlTh5t48MFdiywgiEO0IRgIMaOpjRyzI=
X-Received: by 2002:a4a:b38c:0:b0:595:6024:c4f8 with SMTP id
 p12-20020a4ab38c000000b005956024c4f8mr5220413ooo.1.1704203650666; Tue, 02 Jan
 2024 05:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher>
 <13435856.uLZWGnKmhe@kreacher> <CAPDyKFohQjDzpYpm0QQLM4eTzGOzGfDNKUGHHC-niPBOrtR8BQ@mail.gmail.com>
In-Reply-To: <CAPDyKFohQjDzpYpm0QQLM4eTzGOzGfDNKUGHHC-niPBOrtR8BQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jan 2024 14:53:59 +0100
Message-ID: <CAJZ5v0jPtYFk=pPE63CGGL0kuc+N_bZqKdgBMC=PMrwqzHBDTg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Fix possible deadlocks in core
 system-wide PM code
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Youngmin Nam <youngmin.nam@samsung.com>, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com, 
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:35=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Wed, 27 Dec 2023 at 21:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that in low-memory situations the system-wide resume cor=
e
> > code deadlocks, because async_schedule_dev() executes its argument
> > function synchronously if it cannot allocate memory (an not only then)
> > and that function attempts to acquire a mutex that is already held.
> >
> > Address this by changing the code in question to use
> > async_schedule_dev_nocall() for scheduling the asynchronous
> > execution of device suspend and resume functions and to directly
> > run them synchronously if async_schedule_dev_nocall() returns false.
> >
> > Fixes: 09beebd8f93b ("PM: sleep: core: Switch back to async_schedule_de=
v()")
> > Link: https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
> > Reported-by: Youngmin Nam <youngmin.nam@samsung.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > The commit pointed to by the Fixes: tag is the last one that modified
> > the code in question, even though the bug had been there already before=
.
> >
> > Still, the fix will not apply to the code before that commit.
>
> An option could be to just do "Cc: stable@vger.kernel.org # v5.7+"
> instead of pointing to a commit with a Fixes tag.

Right, but one can argue that every commit with a "Cc: stable" tag is
a fix, so it should carry a Fixes: tag too anyway.

> >
> > ---
> >  drivers/base/power/main.c |  148 +++++++++++++++++++++----------------=
---------
> >  1 file changed, 68 insertions(+), 80 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/main.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/base/power/main.c
> > +++ linux-pm/drivers/base/power/main.c
> > @@ -579,7 +579,7 @@ bool dev_pm_skip_resume(struct device *d
> >  }
> >
> >  /**
> > - * device_resume_noirq - Execute a "noirq resume" callback for given d=
evice.
> > + * __device_resume_noirq - Execute a "noirq resume" callback for given=
 device.
> >   * @dev: Device to handle.
> >   * @state: PM transition of the system being carried out.
> >   * @async: If true, the device is being resumed asynchronously.
> > @@ -587,7 +587,7 @@ bool dev_pm_skip_resume(struct device *d
> >   * The driver of @dev will not receive interrupts while this function =
is being
> >   * executed.
> >   */
> > -static int device_resume_noirq(struct device *dev, pm_message_t state,=
 bool async)
> > +static void __device_resume_noirq(struct device *dev, pm_message_t sta=
te, bool async)
> >  {
> >         pm_callback_t callback =3D NULL;
> >         const char *info =3D NULL;
> > @@ -655,7 +655,13 @@ Skip:
> >  Out:
> >         complete_all(&dev->power.completion);
> >         TRACE_RESUME(error);
> > -       return error;
> > +
> > +       if (error) {
> > +               suspend_stats.failed_resume_noirq++;
> > +               dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> > +               dpm_save_failed_dev(dev_name(dev));
> > +               pm_dev_err(dev, state, async ? " async noirq" : " noirq=
", error);
> > +       }
> >  }
> >
> >  static bool is_async(struct device *dev)
> > @@ -668,11 +674,15 @@ static bool dpm_async_fn(struct device *
> >  {
> >         reinit_completion(&dev->power.completion);
> >
> > -       if (is_async(dev)) {
> > -               get_device(dev);
> > -               async_schedule_dev(func, dev);
> > +       if (!is_async(dev))
> > +               return false;
> > +
> > +       get_device(dev);
> > +
> > +       if (async_schedule_dev_nocall(func, dev))
> >                 return true;
> > -       }
> > +
> > +       put_device(dev);
> >
> >         return false;
> >  }
> > @@ -680,15 +690,19 @@ static bool dpm_async_fn(struct device *
> >  static void async_resume_noirq(void *data, async_cookie_t cookie)
> >  {
> >         struct device *dev =3D data;
> > -       int error;
> > -
> > -       error =3D device_resume_noirq(dev, pm_transition, true);
> > -       if (error)
> > -               pm_dev_err(dev, pm_transition, " async", error);
> >
> > +       __device_resume_noirq(dev, pm_transition, true);
> >         put_device(dev);
> >  }
> >
> > +static void device_resume_noirq(struct device *dev)
> > +{
> > +       if (dpm_async_fn(dev, async_resume_noirq))
> > +               return;
> > +
> > +       __device_resume_noirq(dev, pm_transition, false);
> > +}
> > +
> >  static void dpm_noirq_resume_devices(pm_message_t state)
> >  {
> >         struct device *dev;
> > @@ -698,14 +712,6 @@ static void dpm_noirq_resume_devices(pm_
> >         mutex_lock(&dpm_list_mtx);
> >         pm_transition =3D state;
> >
> > -       /*
> > -        * Advanced the async threads upfront,
> > -        * in case the starting of async threads is
> > -        * delayed by non-async resuming devices.
> > -        */
> > -       list_for_each_entry(dev, &dpm_noirq_list, power.entry)
> > -               dpm_async_fn(dev, async_resume_noirq);
> > -
>
> If I understand correctly, this means that we are no longer going to
> run the async devices upfront, right?

Right.

> Depending on how devices get ordered in the dpm_noirq_list, it sounds
> like the above could have a negative impact on the total resume time!?

It could, but it is unclear at this time whether or not it will.

> Of course, if all devices would be async capable this wouldn't be a
> problem...

Sure.

So the existing behavior can be restored with the help of an
additional device flag, but I didn't decide to add such a flag just
yet.

I'll probably do it in 6.9, unless the performance impact is serious
enough, in which case it can be added earlier.

I still would prefer to get to a point at which the suspend and resume
paths are analogous (from the async POV) and that's what happens after
this patch, so I'd say that IMO it is better to address any
performance regressions on top of it.

> >         while (!list_empty(&dpm_noirq_list)) {
> >                 dev =3D to_device(dpm_noirq_list.next);
> >                 get_device(dev);
> > @@ -713,17 +719,7 @@ static void dpm_noirq_resume_devices(pm_
> >
> >                 mutex_unlock(&dpm_list_mtx);
> >
> > -               if (!is_async(dev)) {
> > -                       int error;
> > -
> > -                       error =3D device_resume_noirq(dev, state, false=
);
> > -                       if (error) {
> > -                               suspend_stats.failed_resume_noirq++;
> > -                               dpm_save_failed_step(SUSPEND_RESUME_NOI=
RQ);
> > -                               dpm_save_failed_dev(dev_name(dev));
> > -                               pm_dev_err(dev, state, " noirq", error)=
;
> > -                       }
> > -               }
> > +               device_resume_noirq(dev);
> >
> >                 put_device(dev);
> >
> > @@ -751,14 +747,14 @@ void dpm_resume_noirq(pm_message_t state
> >  }
> >
> >  /**
> > - * device_resume_early - Execute an "early resume" callback for given =
device.
> > + * __device_resume_early - Execute an "early resume" callback for give=
n device.
> >   * @dev: Device to handle.
> >   * @state: PM transition of the system being carried out.
> >   * @async: If true, the device is being resumed asynchronously.
> >   *
> >   * Runtime PM is disabled for @dev while this function is being execut=
ed.
> >   */
> > -static int device_resume_early(struct device *dev, pm_message_t state,=
 bool async)
> > +static void __device_resume_early(struct device *dev, pm_message_t sta=
te, bool async)
> >  {
> >         pm_callback_t callback =3D NULL;
> >         const char *info =3D NULL;
> > @@ -811,21 +807,31 @@ Out:
> >
> >         pm_runtime_enable(dev);
> >         complete_all(&dev->power.completion);
> > -       return error;
> > +
> > +       if (error) {
> > +               suspend_stats.failed_resume_early++;
> > +               dpm_save_failed_step(SUSPEND_RESUME_EARLY);
> > +               dpm_save_failed_dev(dev_name(dev));
> > +               pm_dev_err(dev, state, async ? " async early" : " early=
", error);
> > +       }
> >  }
> >
> >  static void async_resume_early(void *data, async_cookie_t cookie)
> >  {
> >         struct device *dev =3D data;
> > -       int error;
> > -
> > -       error =3D device_resume_early(dev, pm_transition, true);
> > -       if (error)
> > -               pm_dev_err(dev, pm_transition, " async", error);
> >
> > +       __device_resume_early(dev, pm_transition, true);
> >         put_device(dev);
> >  }
> >
> > +static void device_resume_early(struct device *dev)
> > +{
> > +       if (dpm_async_fn(dev, async_resume_early))
> > +               return;
> > +
> > +       __device_resume_early(dev, pm_transition, false);
> > +}
> > +
> >  /**
> >   * dpm_resume_early - Execute "early resume" callbacks for all devices=
.
> >   * @state: PM transition of the system being carried out.
> > @@ -839,14 +845,6 @@ void dpm_resume_early(pm_message_t state
> >         mutex_lock(&dpm_list_mtx);
> >         pm_transition =3D state;
> >
> > -       /*
> > -        * Advanced the async threads upfront,
> > -        * in case the starting of async threads is
> > -        * delayed by non-async resuming devices.
> > -        */
> > -       list_for_each_entry(dev, &dpm_late_early_list, power.entry)
> > -               dpm_async_fn(dev, async_resume_early);
> > -
>
> Ditto.
>
> >         while (!list_empty(&dpm_late_early_list)) {
> >                 dev =3D to_device(dpm_late_early_list.next);
> >                 get_device(dev);
> > @@ -854,17 +852,7 @@ void dpm_resume_early(pm_message_t state
> >
> >                 mutex_unlock(&dpm_list_mtx);
> >
> > -               if (!is_async(dev)) {
> > -                       int error;
> > -
> > -                       error =3D device_resume_early(dev, state, false=
);
> > -                       if (error) {
> > -                               suspend_stats.failed_resume_early++;
> > -                               dpm_save_failed_step(SUSPEND_RESUME_EAR=
LY);
> > -                               dpm_save_failed_dev(dev_name(dev));
> > -                               pm_dev_err(dev, state, " early", error)=
;
> > -                       }
> > -               }
> > +               device_resume_early(dev);
> >
> >                 put_device(dev);
> >
> > @@ -888,12 +876,12 @@ void dpm_resume_start(pm_message_t state
> >  EXPORT_SYMBOL_GPL(dpm_resume_start);
> >
> >  /**
> > - * device_resume - Execute "resume" callbacks for given device.
> > + * __device_resume - Execute "resume" callbacks for given device.
> >   * @dev: Device to handle.
> >   * @state: PM transition of the system being carried out.
> >   * @async: If true, the device is being resumed asynchronously.
> >   */
> > -static int device_resume(struct device *dev, pm_message_t state, bool =
async)
> > +static void __device_resume(struct device *dev, pm_message_t state, bo=
ol async)
> >  {
> >         pm_callback_t callback =3D NULL;
> >         const char *info =3D NULL;
> > @@ -975,20 +963,30 @@ static int device_resume(struct device *
> >
> >         TRACE_RESUME(error);
> >
> > -       return error;
> > +       if (error) {
> > +               suspend_stats.failed_resume++;
> > +               dpm_save_failed_step(SUSPEND_RESUME);
> > +               dpm_save_failed_dev(dev_name(dev));
> > +               pm_dev_err(dev, state, async ? " async" : "", error);
> > +       }
> >  }
> >
> >  static void async_resume(void *data, async_cookie_t cookie)
> >  {
> >         struct device *dev =3D data;
> > -       int error;
> >
> > -       error =3D device_resume(dev, pm_transition, true);
> > -       if (error)
> > -               pm_dev_err(dev, pm_transition, " async", error);
> > +       __device_resume(dev, pm_transition, true);
> >         put_device(dev);
> >  }
> >
> > +static void device_resume(struct device *dev)
> > +{
> > +       if (dpm_async_fn(dev, async_resume))
> > +               return;
> > +
> > +       __device_resume(dev, pm_transition, false);
> > +}
> > +
> >  /**
> >   * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
> >   * @state: PM transition of the system being carried out.
> > @@ -1008,27 +1006,17 @@ void dpm_resume(pm_message_t state)
> >         pm_transition =3D state;
> >         async_error =3D 0;
> >
> > -       list_for_each_entry(dev, &dpm_suspended_list, power.entry)
> > -               dpm_async_fn(dev, async_resume);
> > -
>
> Ditto.
>
> >         while (!list_empty(&dpm_suspended_list)) {
> >                 dev =3D to_device(dpm_suspended_list.next);
> > +
> >                 get_device(dev);
> > -               if (!is_async(dev)) {
> > -                       int error;
> >
> > -                       mutex_unlock(&dpm_list_mtx);
> > +               mutex_unlock(&dpm_list_mtx);
> >
> > -                       error =3D device_resume(dev, state, false);
> > -                       if (error) {
> > -                               suspend_stats.failed_resume++;
> > -                               dpm_save_failed_step(SUSPEND_RESUME);
> > -                               dpm_save_failed_dev(dev_name(dev));
> > -                               pm_dev_err(dev, state, "", error);
> > -                       }
> > +               device_resume(dev);
> > +
> > +               mutex_lock(&dpm_list_mtx);
> >
> > -                       mutex_lock(&dpm_list_mtx);
> > -               }
> >                 if (!list_empty(&dev->power.entry))
> >                         list_move_tail(&dev->power.entry, &dpm_prepared=
_list);
> >
>
> Other than the potential issue I pointed out, the code as such looks good=
 to me!

Thank you!

