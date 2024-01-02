Return-Path: <linux-kernel+bounces-14390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DD7821C69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465E42837E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E23F9F3;
	Tue,  2 Jan 2024 13:15:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77D1F9C4;
	Tue,  2 Jan 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dbb09061c0so928061a34.0;
        Tue, 02 Jan 2024 05:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201329; x=1704806129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QReZnhHYlJFz2JmIbMJwCkkpVHlXNgx6xGbWBriQsbE=;
        b=vp3oazsQ12Q24Re5BqLmzGKQ94XtT7A67zL+XqUdAEALHLfV9cYNrmmD7xIM+ODXC8
         00tb2ggbZRTnwka16kavDzeU19FP/0nPUu5KzyePUhtFpLn4uc7keYA+w2/kBkG6MbdR
         vO6ExwPuTVSPEx9Mjh/f86hTTB0Gl4AEVcqcRAuMcXV3/RVNQBnlPUA1W1OHf92UUBc6
         JykeBRKwUgvp3V2QUTePuZG28FrvU5Q67trBMmrAIJMpgCKhXQrIPiZiqgPItP0B515G
         x9zO3BfmA0KhHb8OnSyDoK0jY7eJi6UMRYsrxZfuGF9Eap7bY4tlw9MVwCPdDGlrjXnz
         Q7VA==
X-Gm-Message-State: AOJu0YyfzjJWwFyrh+U3rlVBZ8HTCy+6cf4BO8VKJWt6w/cYPXRXz8BC
	9cJjaYa3S4T4om4uzSGdpSDH+TjHEo/iXQpNdFE=
X-Google-Smtp-Source: AGHT+IHxrGsgTJgtjUgNO4Rkxlli9sZRwL8OavHORihZa6GS724o1YNIbbPe48VPAFuYgpntSxueVxu/fZdDHPkjuc0=
X-Received: by 2002:a05:6820:1f90:b0:594:8f66:bca8 with SMTP id
 eq16-20020a0568201f9000b005948f66bca8mr18415342oob.0.1704201328730; Tue, 02
 Jan 2024 05:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher>
 <4874693.GXAFRqVoOG@kreacher> <ZY3auVvVzxwTmAX8@linux.intel.com>
 <CAJZ5v0gns5zeLEk39NGwjLy40wzHAHDWYBYapWwQWcJ9jrF-3Q@mail.gmail.com>
 <ZY44KH2wGIUyIZp6@linux.intel.com> <CAJZ5v0jWSH_+wC7P=bBV8uKNp1PBUjkE06Ec6HR1Zd5as8GQ2g@mail.gmail.com>
 <ZZO2v0lQSZLxNV3c@linux.intel.com>
In-Reply-To: <ZZO2v0lQSZLxNV3c@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jan 2024 14:15:17 +0100
Message-ID: <CAJZ5v0gKJp7zuFruZm3z8QJu068kP75ngW1cMh2OftEzTm_4Jw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] async: Introduce async_schedule_dev_nocall()
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Youngmin Nam <youngmin.nam@samsung.com>, linux-kernel@vger.kernel.org, 
	d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 8:10=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Fri, Dec 29, 2023 at 05:36:01PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Dec 29, 2023 at 3:54=E2=80=AFPM Stanislaw Gruszka
> > <stanislaw.gruszka@linux.intel.com> wrote:
> > >
> > > On Fri, Dec 29, 2023 at 02:37:36PM +0100, Rafael J. Wysocki wrote:
> > > > > > +bool async_schedule_dev_nocall(async_func_t func, struct devic=
e *dev)
> > > > > > +{
> > > > > > +     struct async_entry *entry;
> > > > > > +
> > > > > > +     entry =3D kzalloc(sizeof(struct async_entry), GFP_KERNEL)=
;
> > > > >
> > > > > Is GFP_KERNEL intended here ?
> > > >
> > > > Yes, it is.
> > > >
> > > > PM will be the only user of this, at least for now, and it all runs=
 in
> > > > process context.
> > > >
> > > > > I think it's not safe since will
> > > > > be called from device_resume_noirq() .
> > > >
> > > > device_resume_noirq() runs in process context too.
> > > >
> > > > The name is somewhat confusing (sorry about that) and it means that
> > > > hardirq handlers (for the majority of IRQs) don't run in that resum=
e
> > > > phase, but interrupts are enabled locally on all CPUs (this is
> > > > required for wakeup handling, among other things).
> > >
> > > Then my concern would be: if among devices with disabled IRQs are
> > > disk devices? Seems there are disk devices as well, and because
> > > GFP_KERNEL can start reclaiming memory by doing disk IO (write
> > > dirty pages for example), with disk driver interrupts disabled
> > > reclaiming process can not finish.
> > >
> > > I do not see how such possible infinite waiting for disk IO
> > > scenario is prevented here, did I miss something?
> >
> > Well, it is not a concern, because the suspend code already prevents
> > the mm subsystem from trying too hard to find free memory.  See the
> > pm_restrict_gfp_mask() call in enter_state().
>
> So that I missed :-) Thanks for explanations.
>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com> for th=
e series.

Thank you!

