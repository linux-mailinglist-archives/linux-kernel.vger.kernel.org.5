Return-Path: <linux-kernel+bounces-94064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8233C873954
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386192862A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50C1339A5;
	Wed,  6 Mar 2024 14:37:45 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A854130E49;
	Wed,  6 Mar 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735865; cv=none; b=nhSFlilhfucJCPkp88sL5EpXyCky2LW4MR5GauaHMDeAVaDm0FYKpBkk6p0Y8ouUzH9MzG72X3esgJ1A0hTQcFz7d70J94bKvFImqntWboVPVL8MsK4tHpPjsWzR8fSFlNdI12kY65T0D0vo+5F92ycgPX6hH0S6MAzicziXSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735865; c=relaxed/simple;
	bh=3quhGH9tRRzDyM893G7Ej0KTtLDqQs5jmRyNqLZXplU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJYOZ8JgqcCHstOTDOWHlQOX6n90KWG7ed24+6gKDelKnR639na2jFeWuvt7yPvf6BUJ+MEpFUxgFkcRSl/J6Fgwd6SzpLQUb6fX5BzxrO/SBV8gkiLayii8nQ1YfryktbOUXAaJoT6P+ElSYDOgM9cVPcqzGBVxerdAxh+Xiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4ea48972cso1071246a34.0;
        Wed, 06 Mar 2024 06:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735862; x=1710340662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4TvgA99Cj14OD7qvEjRfXxwKyvogxN2g18elv8KQlI=;
        b=SvmxOLZW+V8dT4UVRdwF1jP4qCOc0Jfzes5mHM/tTeJznEFh3Yfm6Nu/zRQc8eMveh
         JiDtoLsbqyvlsHsrEwcYTEJu6pH84KN65Rlo2UgrEv/0rRufdgap4E7L8k+VSlKXU9e/
         6BdDuaqcMUx8+hHFp3Rsd6aDSCje3FWWS6eUfZFBxSMrTRuegDeHD1CFiCWVW63SFS5M
         SDIKrWjuvJnRFOhNmpI5wAJnflY6m+nmhh755GLYpqWHl8VsOa+D4s4kCpQB1VtNVN1O
         IVcYBuKLLr528dZzuuI8awEVJrsLw5/6mqPUUrDEgciectcALFp08QAlVZckbrLNqubh
         Vpow==
X-Forwarded-Encrypted: i=1; AJvYcCVgpZiFI7BT+z8Cnrxj2sfPXiiEUv83+N/oAmNGXT0Jhvfv/k2bHvdeWTUS+NKw3vgA8Si1Lf/2uGmmVY2CzMTQ4TlimLExzWE9WQtOnsOVZvM73On3rjy3ZUppdGMe+fHM47fKQPhUXY/eINP3l1IkZhUS87Grjz5O1IR2j8Tq2w==
X-Gm-Message-State: AOJu0YzP7kLOCwWjsJwXkCgx50cjGjMTa/Z6aN2OlwlTHeQUTZdiS83D
	acfxIBw1co9dGM7ry1Vj2yo59hRsBM8hEBOMCJ05P/lrOCJLBSCRG7aS20/hq6LCXLmpWi5lvbR
	MhsIm85nQPnWfjbkHQ9KRVFfra+Y=
X-Google-Smtp-Source: AGHT+IE4CvLALom7jyYW9CpPmCJzqwXZJ2apnm0WOpLLE+9EKTV5/4/63dmdzQ5kj3Up2QlL8St0VXJxw0fI41VL5kw=
X-Received: by 2002:a05:6870:55c6:b0:220:bd4d:674d with SMTP id
 qk6-20020a05687055c600b00220bd4d674dmr4193559oac.5.1709735862383; Wed, 06 Mar
 2024 06:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085007.169771-1-herve.codina@bootlin.com>
 <20240306085007.169771-2-herve.codina@bootlin.com> <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
 <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
 <ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
 <CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com> <ec7705f410bc848e79b8ab878b5fbf7618d9456d.camel@gmail.com>
In-Reply-To: <ec7705f410bc848e79b8ab878b5fbf7618d9456d.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 15:37:30 +0100
Message-ID: <CAJZ5v0iMUOJmm99H6SgfP9179hBsLdyC+1ixJwBxSP0b18V6XA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 3:08=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Wed, 2024-03-06 at 14:05 +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 6, 2024 at 2:01=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> > >
> > > On Wed, 2024-03-06 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 6, 2024 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
> > > > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link remova=
l")
> > > > > > introduces a workqueue to release the consumer and supplier dev=
ices
> > > > > > used
> > > > > > in the devlink.
> > > > > > In the job queued, devices are release and in turn, when all th=
e
> > > > > > references to these devices are dropped, the release function o=
f the
> > > > > > device itself is called.
> > > > > >
> > > > > > Nothing is present to provide some synchronisation with this wo=
rkqueue
> > > > > > in order to ensure that all ongoing releasing operations are do=
ne and
> > > > > > so, some other operations can be started safely.
> > > > > >
> > > > > > For instance, in the following sequence:
> > > > > >   1) of_platform_depopulate()
> > > > > >   2) of_overlay_remove()
> > > > > >
> > > > > > During the step 1, devices are released and related devlinks ar=
e
> > > > > > removed
> > > > > > (jobs pushed in the workqueue).
> > > > > > During the step 2, OF nodes are destroyed but, without any
> > > > > > synchronisation with devlink removal jobs, of_overlay_remove() =
can
> > > > > > raise
> > > > > > warnings related to missing of_node_put():
> > > > > >   ERROR: memory leak, expected refcount 1 instead of 2
> > > > > >
> > > > > > Indeed, the missing of_node_put() call is going to be done, too=
 late,
> > > > > > from the workqueue job execution.
> > > > > >
> > > > > > Introduce device_link_wait_removal() to offer a way to synchron=
ize
> > > > > > operations waiting for the end of devlink removals (i.e. end of
> > > > > > workqueue jobs).
> > > > > > Also, as a flushing operation is done on the workqueue, the wor=
kqueue
> > > > > > used is moved from a system-wide workqueue to a local one.
> > > > > >
> > > > > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > > ---
> > > > >
> > > > > With the below addressed:
> > > > >
> > > > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > > >
> > > > > >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> > > > > >  include/linux/device.h |  1 +
> > > > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > index d5f4e4aac09b..48b28c59c592 100644
> > > > > > --- a/drivers/base/core.c
> > > > > > +++ b/drivers/base/core.c
> > > > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > > > >  static void __fw_devlink_link_to_consumers(struct device *dev)=
;
> > > > > >  static bool fw_devlink_drv_reg_done;
> > > > > >  static bool fw_devlink_best_effort;
> > > > > > +static struct workqueue_struct *device_link_wq;
> > > > > >
> > > > > >  /**
> > > > > >   * __fwnode_link_add - Create a link between two fwnode_handle=
s.
> > > > > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct de=
vice
> > > > > > *dev)
> > > > > >       /*
> > > > > >        * It may take a while to complete this work because of t=
he SRCU
> > > > > >        * synchronization in device_link_release_fn() and if the
> > > > > > consumer
> > > > > > or
> > > > > > -      * supplier devices get deleted when it runs, so put it i=
nto the
> > > > > > "long"
> > > > > > -      * workqueue.
> > > > > > +      * supplier devices get deleted when it runs, so put it i=
nto the
> > > > > > +      * dedicated workqueue.
> > > > > >        */
> > > > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > > > +     queue_work(device_link_wq, &link->rm_work);
> > > > > >  }
> > > > > >
> > > > > > +/**
> > > > > > + * device_link_wait_removal - Wait for ongoing devlink removal=
 jobs
> > > > > > to
> > > > > > terminate
> > > > > > + */
> > > > > > +void device_link_wait_removal(void)
> > > > > > +{
> > > > > > +     /*
> > > > > > +      * devlink removal jobs are queued in the dedicated work =
queue.
> > > > > > +      * To be sure that all removal jobs are terminated, ensur=
e that
> > > > > > any
> > > > > > +      * scheduled work has run to completion.
> > > > > > +      */
> > > > > > +     flush_workqueue(device_link_wq);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > > > +
> > > > > >  static struct class devlink_class =3D {
> > > > > >       .name =3D "devlink",
> > > > > >       .dev_groups =3D devlink_groups,
> > > > > > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > > > > >       sysfs_dev_char_kobj =3D kobject_create_and_add("char", de=
v_kobj);
> > > > > >       if (!sysfs_dev_char_kobj)
> > > > > >               goto char_kobj_err;
> > > > > > +     device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0=
);
> > > > > > +     if (!device_link_wq)
> > > > > > +             goto wq_err;
> > > > > >
> > > > >
> > > > > I can't still agree with this. Why not doing it in devlink_class_=
init()?
> > > > > This is
> > > > > devlink specific so it makes complete sense to me.
> > > >
> > > > If you do that in devlink_class_init() and it fails, you essentiall=
y
> > > > cause the creation of every device link to fail.  IOW, you try to l=
ive
> > > > without device links and pretend that it is all OK.  That won't get
> > > > you very far, especially on systems where DT is used.
> > > >
> > > > Doing it here, if it fails, you prevent the driver model from worki=
ng
> > > > at all (because one of its necessary components is unavailable), wh=
ich
> > > > arguably is a better choice.
> > >
> > > That makes sense but then the only thing I still don't fully get is w=
hy we
> > > have
> > > a separate devlink_class_init() initcall for registering the devlink =
class
> > > (which can also fail)...
> >
> > Well, I haven't added it. :-)
> >
> > > What I take from the above is that we should fail the
> > > driver model if one of it's fundamental components fails so I would s=
ay we
> > > should merge devlink_class_init() with device_init() otherwise it's a=
 bit
> > > confusing (at least to me) and gives the idea that it's ok for the dr=
iver
> > > model
> > > to exist without the links (unless I'm missing some other reason for =
the
> > > devlink
> > > init function).
> >
> > +1
> >
> > Feel free to send a patch along these lines, chances are that it will
> > be popular. ;-)
>
> I was actually thinking about that but I think I encountered the reason w=
hy we
> have it like this... devices_init() is called from driver_init() and ther=
e we
> have:
>
> ...
>
> devices_init();
> buses_init();
> classes_init();
>
> ...
>
> So classes are initialized after devices which means we can't really do
> class_register(&devlink_class) from devices_init(). Unless, of course, we=
 re-
> order things in driver_init() but that would be a questionable change at =
the
> very least.
>
> So, while I agree with what you've said, I'm still not sure if mixing dev=
link
> stuff between devices_init() and devlink_class_init() is the best thing t=
o do
> given that we already have the case where devlink_class_init() can fail w=
hile
> the driver model is up.

So why don't you make devlink_class_init() do a BUG() on failure
instead of returning an error?  IMO crashing early is better than
crashing later or otherwise failing in a subtle way due to a missed
dependency.

