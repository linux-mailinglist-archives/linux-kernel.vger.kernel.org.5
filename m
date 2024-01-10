Return-Path: <linux-kernel+bounces-22172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E4829A73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396981C21A07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0746422;
	Wed, 10 Jan 2024 12:33:23 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B848780;
	Wed, 10 Jan 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ddec302e68so222551a34.0;
        Wed, 10 Jan 2024 04:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890000; x=1705494800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdVwVLgR6l9w9IUJl5rXBB1+lz8z25YXeBpy/UgGLXk=;
        b=sOeUVJh6BzF99F1fRi7w/Xf1tW2GrpDg/t3sVSKSs716k7HmxnAgU4ncmH9Kgtg4SU
         t6Z3nQ3NTxNzRi6iR0JKzeZSX63n2vWevzFNP5fjKo5FwFIQDKZ87XchwyAf368rw3E8
         X8hsq6j6OHRomhRJB6QqL6xynX7EyJqVaxIoI5yTWTowrV1OSmRdre8ALgnuDPcnfnKA
         wcLp0u6kK88tOFgI2tMOXgVwvkYR6UC5SCip/os6Cl6IZ83vjhzuL9J169T1Bh8qqy09
         AZOT/gS3i93cE/wWxdePj2lCq0umI+kfPceXNq1nIEXd83hzLqn5vJNXULgVPUVuECpB
         Jqpw==
X-Gm-Message-State: AOJu0Yzzm5ZjUkJkX6lrZYXjAC43uBAHtp5VL+2aBEgZNYRMXraWjvat
	qtmhdLW6H1tUVB2w+R54YwSU/4rmEgqHE8/cUh4FDzgY
X-Google-Smtp-Source: AGHT+IF7fEzV7PsxnHE9QKfxhElr11n1sr60mh+14CNFMczJEcSD/pXhmfHL4ULKPM37t3VEg3FswyH2DzSzW6VdFZg=
X-Received: by 2002:a05:6820:2e02:b0:598:9a35:71f1 with SMTP id
 ec2-20020a0568202e0200b005989a3571f1mr1216376oob.0.1704889999119; Wed, 10 Jan
 2024 04:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10423008.nUPlyArG6x@kreacher> <ZZ5zcBBEv7qupIdE@linux.intel.com>
In-Reply-To: <ZZ5zcBBEv7qupIdE@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 13:33:07 +0100
Message-ID: <CAJZ5v0gp6uETgLNHxDnSd4h_0ois7J2AC7soJJVv18B99GmxcQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 11:37=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Tue, Jan 09, 2024 at 05:59:22PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
> > system-wide PM code"), the resume of devices that were allowed to resum=
e
> > asynchronously was scheduled before starting the resume of the other
> > devices, so the former did not have to wait for the latter unless
> > functional dependencies were present.
> >
> > Commit 7839d0078e0d removed that optimization in order to address a
> > correctness issue, but it can be restored with the help of a new device
> > power management flag, so do that now.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > I said I'd probably do this in 6.9, but then I thought more about it
> > and now I think it would be nice to have 6.8-rc1 without a suspend
> > performance regression and the change is relatively straightforward,
> > so here it goes.
> >
> > ---
> >  drivers/base/power/main.c |  117 +++++++++++++++++++++++++------------=
---------
> >  include/linux/pm.h        |    1
> >  2 files changed, 65 insertions(+), 53 deletions(-)
> >
> > Index: linux-pm/include/linux/pm.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/pm.h
> > +++ linux-pm/include/linux/pm.h
> > @@ -681,6 +681,7 @@ struct dev_pm_info {
> >       bool                    wakeup_path:1;
> >       bool                    syscore:1;
> >       bool                    no_pm_callbacks:1;      /* Owned by the P=
M core */
> > +     bool                    in_progress:1;  /* Owned by the PM core *=
/
> >       unsigned int            must_resume:1;  /* Owned by the PM core *=
/
> >       unsigned int            may_skip_resume:1;      /* Set by subsyst=
ems */
>
> Not related to the patch, just question: why some types here are
> unsigned int :1 others bool :1 ?

No particular reason.

I think I will change them all to bool in the future.

> >   * dpm_resume_early - Execute "early resume" callbacks for all devices=
.
> >   * @state: PM transition of the system being carried out.
> > @@ -845,18 +845,28 @@ void dpm_resume_early(pm_message_t state
> >       mutex_lock(&dpm_list_mtx);
> >       pm_transition =3D state;
> >
> > +     /*
> > +      * Trigger the resume of "async" devices upfront so they don't ha=
ve to
> > +      * wait for the "non-async" ones they don't depend on.
> > +      */
> > +     list_for_each_entry(dev, &dpm_late_early_list, power.entry)
> > +             dpm_async_fn(dev, async_resume_early);
> > +
> >       while (!list_empty(&dpm_late_early_list)) {
> >               dev =3D to_device(dpm_late_early_list.next);
> > -             get_device(dev);
> >               list_move_tail(&dev->power.entry, &dpm_suspended_list);
> >
> > -             mutex_unlock(&dpm_list_mtx);
> > +             if (!dev->power.in_progress) {
>
> I would consider different naming just to make clear this
> is regarding async call, in_progress looks too generic for me.

OK, what about async_in_progress?

> Fine if you think otherwise, in general patch LGTM:
>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Thanks!

