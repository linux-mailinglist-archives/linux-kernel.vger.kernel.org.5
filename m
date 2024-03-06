Return-Path: <linux-kernel+bounces-94600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D28741F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1C9B21ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54401B5BF;
	Wed,  6 Mar 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="besBXsyB"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E9175A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760412; cv=none; b=YxbB4yLHqS591WwKbK4ssbpslX0qCEeYNCVPZrdHQu9bMPwF6oI8U7NOsOEiDki+vTNcJRh7uo0FE+W74magFbcxU4SxMd06QVbKAQLlwyI9oEHi25Daamt0bcj/WfHT03BfXre9bxyO3DHfe06PL63cvjeLMayfUaOnnobxukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760412; c=relaxed/simple;
	bh=mzwfTi6zd7r9LqxFJaZNt/rUdm12xPXdVwOFQ7hS61Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lY5HiL2n/hF81Y+LsIuwWot3mCpXpaCKOckzKUn86IYD/nRxNvkaM7B9cInsdul3FqFCHdlU2xbqYrg0sU27jk8zyMYkZxvyrjp0xAadPCAQaCeyGx5Wtb45TMdoeYGiMS6qUQb2MjSdDd1n+89t2firr/cC022knSf+7gmOFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=besBXsyB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42ef8193ae6so12931cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709760409; x=1710365209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FZuCGcMvxhZgTJoD8ceUikqqJlCEjQzCIvOMDFgMow=;
        b=besBXsyBKQyuJX0ykolBvanUDHXwp23RaQdADo17WrsP3HZO98IOHshc5BkB4FEkxg
         5bSi4kPpQPBr1scJDfi9Wq9h5Pk8eAXQxK0jBW3G+R+W/A1NB3sZmuaFcGn/M/asSbc0
         J0q4yBcAe/tVK8ApfmtmPatKRz2//JST4VJldrXGDkRkjMlqRLbIklZow1YXlT2rsHUD
         hndOe4PnH45ORvNPjBVc6rUTtdms404TDd/kZIxP+v5pfwh5Sm6fRMlnY1XJPSIEQKO/
         cAba24bhTbG4l+1oUtzRE+oZuzTyibqraOytbFGL6GeLZaXZhIbwtKse1rZmj9PNLwge
         QLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760409; x=1710365209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FZuCGcMvxhZgTJoD8ceUikqqJlCEjQzCIvOMDFgMow=;
        b=MitRdS80Gsjs8ffwm1htXC62tWwphB9rLR2PPL/P37BdeZ5DQzkHDLFXnzBA+t0Etl
         wS0ow/kpngKiBPFv6l3yFSDk/Va6QWYOn5TYFjcI3OLbm0hvjjh+oWHTDuMf2YjjZXFr
         AxFqStcbLU3AWl6nRn3OgzZpzq8J4JeER9NzfOAzhNRiAzzheDs5ZK0AMXEWvRTXDcer
         uvfkHdySto8ih+mkoPUc4QmD7FiXgUVQqzHspPEaE/xxcBqOIoqHVIlkB24K6HcWfkOe
         4OM1MEa8r7iOqvxSOwriZUQR7O48PgeABnBWUet8rZHbXZZ4MQeFpN+ya4BlF1g10kTa
         H+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrT54igaj8lwU6nrxlwXZU4X3uxLeO0vQRuUQ1Yyx9h0Qcwtj3q10kYvJCbWVYMtVk3Scu/A4HCGhdcHbI79j8M9FCy45KV++gOQ7X
X-Gm-Message-State: AOJu0Ywi+PnGUhddrs5aOg1YRZmZE2ia/wP3jFK1ECTDwAinxD4emlO8
	D1INmHiSFok1ksDe/IXaaTTK780ihfOFuhBcjW4P3hBqmhivFTvyBo8hAnBZ067y/HMLAr/png0
	wSC85sxyBvQ5HhPGB0hgx26xBZpTMdb7C+vK6
X-Google-Smtp-Source: AGHT+IGFctRgTBcRCjPb80TkapZLv/rVBPcsBN5h6OElKH7bsTSniY6hCCQWMyYS+P/29db0lgO0vfA6VxutKw7SE64=
X-Received: by 2002:a05:622a:148a:b0:42e:f45c:6761 with SMTP id
 t10-20020a05622a148a00b0042ef45c6761mr98953qtx.22.1709760408460; Wed, 06 Mar
 2024 13:26:48 -0800 (PST)
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
 <CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com>
 <ec7705f410bc848e79b8ab878b5fbf7618d9456d.camel@gmail.com>
 <CAJZ5v0iMUOJmm99H6SgfP9179hBsLdyC+1ixJwBxSP0b18V6XA@mail.gmail.com> <86a0f91675197a00bbd921d6e57d2f3c57796e68.camel@gmail.com>
In-Reply-To: <86a0f91675197a00bbd921d6e57d2f3c57796e68.camel@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 6 Mar 2024 13:26:09 -0800
Message-ID: <CAGETcx_gNWOTsSZMaZu+XU1-5Z60WEcMhw08t4Sn_-YgkCCUmA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Wed, 2024-03-06 at 15:37 +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 6, 2024 at 3:08=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> > >
> > > On Wed, 2024-03-06 at 14:05 +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 6, 2024 at 2:01=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gm=
ail.com> wrote:
> > > > >
> > > > > On Wed, 2024-03-06 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > > > > On Wed, Mar 6, 2024 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nu=
no@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
> > > > > > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link re=
moval")
> > > > > > > > introduces a workqueue to release the consumer and supplier
> > > > > > > > devices
> > > > > > > > used
> > > > > > > > in the devlink.
> > > > > > > > In the job queued, devices are release and in turn, when al=
l the
> > > > > > > > references to these devices are dropped, the release functi=
on of
> > > > > > > > the
> > > > > > > > device itself is called.
> > > > > > > >
> > > > > > > > Nothing is present to provide some synchronisation with thi=
s
> > > > > > > > workqueue
> > > > > > > > in order to ensure that all ongoing releasing operations ar=
e done
> > > > > > > > and
> > > > > > > > so, some other operations can be started safely.
> > > > > > > >
> > > > > > > > For instance, in the following sequence:
> > > > > > > >   1) of_platform_depopulate()
> > > > > > > >   2) of_overlay_remove()
> > > > > > > >
> > > > > > > > During the step 1, devices are released and related devlink=
s are
> > > > > > > > removed
> > > > > > > > (jobs pushed in the workqueue).
> > > > > > > > During the step 2, OF nodes are destroyed but, without any
> > > > > > > > synchronisation with devlink removal jobs, of_overlay_remov=
e() can
> > > > > > > > raise
> > > > > > > > warnings related to missing of_node_put():
> > > > > > > >   ERROR: memory leak, expected refcount 1 instead of 2
> > > > > > > >
> > > > > > > > Indeed, the missing of_node_put() call is going to be done,=
 too
> > > > > > > > late,
> > > > > > > > from the workqueue job execution.
> > > > > > > >
> > > > > > > > Introduce device_link_wait_removal() to offer a way to sync=
hronize
> > > > > > > > operations waiting for the end of devlink removals (i.e. en=
d of
> > > > > > > > workqueue jobs).
> > > > > > > > Also, as a flushing operation is done on the workqueue, the
> > > > > > > > workqueue
> > > > > > > > used is moved from a system-wide workqueue to a local one.
> > > > > > > >
> > > > > > > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link remova=
l")
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > With the below addressed:
> > > > > > >
> > > > > > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > >
> > > > > > > >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> > > > > > > >  include/linux/device.h |  1 +
> > > > > > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > > > index d5f4e4aac09b..48b28c59c592 100644
> > > > > > > > --- a/drivers/base/core.c
> > > > > > > > +++ b/drivers/base/core.c
> > > > > > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void=
);
> > > > > > > >  static void __fw_devlink_link_to_consumers(struct device *=
dev);
> > > > > > > >  static bool fw_devlink_drv_reg_done;
> > > > > > > >  static bool fw_devlink_best_effort;
> > > > > > > > +static struct workqueue_struct *device_link_wq;
> > > > > > > >
> > > > > > > >  /**
> > > > > > > >   * __fwnode_link_add - Create a link between two fwnode_ha=
ndles.
> > > > > > > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struc=
t
> > > > > > > > device
> > > > > > > > *dev)
> > > > > > > >       /*
> > > > > > > >        * It may take a while to complete this work because =
of the
> > > > > > > > SRCU
> > > > > > > >        * synchronization in device_link_release_fn() and if=
 the
> > > > > > > > consumer
> > > > > > > > or
> > > > > > > > -      * supplier devices get deleted when it runs, so put =
it into
> > > > > > > > the
> > > > > > > > "long"
> > > > > > > > -      * workqueue.
> > > > > > > > +      * supplier devices get deleted when it runs, so put =
it into
> > > > > > > > the
> > > > > > > > +      * dedicated workqueue.
> > > > > > > >        */
> > > > > > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > > > > > +     queue_work(device_link_wq, &link->rm_work);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/**
> > > > > > > > + * device_link_wait_removal - Wait for ongoing devlink rem=
oval
> > > > > > > > jobs
> > > > > > > > to
> > > > > > > > terminate
> > > > > > > > + */
> > > > > > > > +void device_link_wait_removal(void)
> > > > > > > > +{
> > > > > > > > +     /*
> > > > > > > > +      * devlink removal jobs are queued in the dedicated w=
ork
> > > > > > > > queue.
> > > > > > > > +      * To be sure that all removal jobs are terminated, e=
nsure
> > > > > > > > that
> > > > > > > > any
> > > > > > > > +      * scheduled work has run to completion.
> > > > > > > > +      */
> > > > > > > > +     flush_workqueue(device_link_wq);
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > > > > > +
> > > > > > > >  static struct class devlink_class =3D {
> > > > > > > >       .name =3D "devlink",
> > > > > > > >       .dev_groups =3D devlink_groups,
> > > > > > > > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > > > > > > >       sysfs_dev_char_kobj =3D kobject_create_and_add("char"=
,
> > > > > > > > dev_kobj);
> > > > > > > >       if (!sysfs_dev_char_kobj)
> > > > > > > >               goto char_kobj_err;
> > > > > > > > +     device_link_wq =3D alloc_workqueue("device_link_wq", =
0, 0);
> > > > > > > > +     if (!device_link_wq)
> > > > > > > > +             goto wq_err;
> > > > > > > >
> > > > > > >
> > > > > > > I can't still agree with this. Why not doing it in
> > > > > > > devlink_class_init()?
> > > > > > > This is
> > > > > > > devlink specific so it makes complete sense to me.
> > > > > >
> > > > > > If you do that in devlink_class_init() and it fails, you essent=
ially
> > > > > > cause the creation of every device link to fail.  IOW, you try =
to live
> > > > > > without device links and pretend that it is all OK.  That won't=
 get
> > > > > > you very far, especially on systems where DT is used.
> > > > > >
> > > > > > Doing it here, if it fails, you prevent the driver model from w=
orking
> > > > > > at all (because one of its necessary components is unavailable)=
, which
> > > > > > arguably is a better choice.
> > > > >
> > > > > That makes sense but then the only thing I still don't fully get =
is why
> > > > > we
> > > > > have
> > > > > a separate devlink_class_init() initcall for registering the devl=
ink
> > > > > class
> > > > > (which can also fail)...
> > > >
> > > > Well, I haven't added it. :-)
> > > >
> > > > > What I take from the above is that we should fail the
> > > > > driver model if one of it's fundamental components fails so I wou=
ld say
> > > > > we
> > > > > should merge devlink_class_init() with device_init() otherwise it=
's a
> > > > > bit
> > > > > confusing (at least to me) and gives the idea that it's ok for th=
e
> > > > > driver
> > > > > model
> > > > > to exist without the links (unless I'm missing some other reason =
for the
> > > > > devlink
> > > > > init function).
> > > >
> > > > +1
> > > >
> > > > Feel free to send a patch along these lines, chances are that it wi=
ll
> > > > be popular. ;-)
> > >
> > > I was actually thinking about that but I think I encountered the reas=
on why
> > > we
> > > have it like this... devices_init() is called from driver_init() and =
there
> > > we
> > > have:
> > >
> > > ...
> > >
> > > devices_init();
> > > buses_init();
> > > classes_init();
> > >
> > > ...
> > >
> > > So classes are initialized after devices which means we can't really =
do
> > > class_register(&devlink_class) from devices_init(). Unless, of course=
, we
> > > re-
> > > order things in driver_init() but that would be a questionable change=
 at the
> > > very least.
> > >
> > > So, while I agree with what you've said, I'm still not sure if mixing
> > > devlink
> > > stuff between devices_init() and devlink_class_init() is the best thi=
ng to
> > > do
> > > given that we already have the case where devlink_class_init() can fa=
il
> > > while
> > > the driver model is up.
> >
> > So why don't you make devlink_class_init() do a BUG() on failure
> > instead of returning an error?  IMO crashing early is better than
> > crashing later or otherwise failing in a subtle way due to a missed
> > dependency.
>
> Well, I do agree with that... Maybe that's something that Herve can sneak=
 in
> this patch? Otherwise, I can later (after this one is applied) send a pat=
ch for
> it.

I'll happily Ack the patch if you want to add a BUG(), but the way
it's written is still pedantically better than putting it in
devices_init(). All errors from devices_init() are ignored and not
even logged by the caller. At least any error from
devlink_class_init() would be logged if initcall_debug is enabled :-)

Oh, btw, I wrote devlink_class_init() as a separate initcall because
it's just another class like any other class that's being registered.

All that said, I think this whole discussion is a pedantic waste of time.

-Saravana

