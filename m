Return-Path: <linux-kernel+bounces-13161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288C820089
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E440E284833
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55A12B61;
	Fri, 29 Dec 2023 16:36:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AF12B60;
	Fri, 29 Dec 2023 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbc5cd15b6so361934b6e.0;
        Fri, 29 Dec 2023 08:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703867772; x=1704472572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5osr6xfn25Wt0TdDGmPAZn7SDMAzkOWPXYFwHYI1i4=;
        b=v05a3tJjKfXRApfF4MI7GmraruaMjJN0N6i3Nw/OHO4BjLBJe4WhaRMrfvMkxnsZrU
         fgnoPDJhXrPqPTHaQNZtbEMTHLTNK4nhVtXvmG+J1/UBZlQFyqJRgFwWb3xHnG+Gdd99
         129p6TuHUYJdDgpd+yN1jBt4VOylZk7HlPsSX9jISGLpht6auoZ2IFJybj+4m9tJzfIb
         1ScDPbIRv4ioRp38sNXJS2Bhb4K2zRU14jELTPQGvJXx1cqNvRp3u3VH8ii1D9Mjda68
         tW/mQ6EhW/J2KPIofn2jRbhBcNSdEQTIZ5yy/PN5IdBMqrGrAIJJnRnIzQn5L8NyIyvi
         mMag==
X-Gm-Message-State: AOJu0YyoIaMwxX8NstoctBIP+ZxZ75ZnmzEyQoEk80uXm4Ta/oo39+aC
	ciPYZGC2qfojxLhIWroxpqDjXtWCrRmfrj9cTkQ=
X-Google-Smtp-Source: AGHT+IFs9CoXnbyFsUnv7A/DkAc47usxTcTcrUe5GUpFVHU+aw3llxkYsOyxE6COSY8AJNEwPeqiOjViUCTybWo9Bog=
X-Received: by 2002:a4a:dc96:0:b0:594:ad62:bab9 with SMTP id
 g22-20020a4adc96000000b00594ad62bab9mr10280653oou.1.1703867772553; Fri, 29
 Dec 2023 08:36:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher>
 <4874693.GXAFRqVoOG@kreacher> <ZY3auVvVzxwTmAX8@linux.intel.com>
 <CAJZ5v0gns5zeLEk39NGwjLy40wzHAHDWYBYapWwQWcJ9jrF-3Q@mail.gmail.com> <ZY44KH2wGIUyIZp6@linux.intel.com>
In-Reply-To: <ZY44KH2wGIUyIZp6@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 17:36:01 +0100
Message-ID: <CAJZ5v0jWSH_+wC7P=bBV8uKNp1PBUjkE06Ec6HR1Zd5as8GQ2g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] async: Introduce async_schedule_dev_nocall()
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Youngmin Nam <youngmin.nam@samsung.com>, linux-kernel@vger.kernel.org, 
	d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 3:54=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Fri, Dec 29, 2023 at 02:37:36PM +0100, Rafael J. Wysocki wrote:
> > > > +bool async_schedule_dev_nocall(async_func_t func, struct device *d=
ev)
> > > > +{
> > > > +     struct async_entry *entry;
> > > > +
> > > > +     entry =3D kzalloc(sizeof(struct async_entry), GFP_KERNEL);
> > >
> > > Is GFP_KERNEL intended here ?
> >
> > Yes, it is.
> >
> > PM will be the only user of this, at least for now, and it all runs in
> > process context.
> >
> > > I think it's not safe since will
> > > be called from device_resume_noirq() .
> >
> > device_resume_noirq() runs in process context too.
> >
> > The name is somewhat confusing (sorry about that) and it means that
> > hardirq handlers (for the majority of IRQs) don't run in that resume
> > phase, but interrupts are enabled locally on all CPUs (this is
> > required for wakeup handling, among other things).
>
> Then my concern would be: if among devices with disabled IRQs are
> disk devices? Seems there are disk devices as well, and because
> GFP_KERNEL can start reclaiming memory by doing disk IO (write
> dirty pages for example), with disk driver interrupts disabled
> reclaiming process can not finish.
>
> I do not see how such possible infinite waiting for disk IO
> scenario is prevented here, did I miss something?

Well, it is not a concern, because the suspend code already prevents
the mm subsystem from trying too hard to find free memory.  See the
pm_restrict_gfp_mask() call in enter_state().

Otherwise, it would have been a problem for any GFP_KERNEL allocations
made during system-wide suspend-resume, not just in the _noirq phases.

