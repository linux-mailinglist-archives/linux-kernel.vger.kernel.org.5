Return-Path: <linux-kernel+bounces-86734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40D86C9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB8E1C20D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB317E111;
	Thu, 29 Feb 2024 13:11:12 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB167C71;
	Thu, 29 Feb 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212272; cv=none; b=FY+Ucn/f9KhBfB3bKJNSJ8VgchVAUfMXpuqhdCiGs0UCyJIHcCNDzsLUlfJke3Y5KpCyAgGJbfOZpmm49XnsnqUbd1KlfzOCnerTZFpyRQrXOarzg031vWJ4rX1ig59iFruzRbfL+JgDoLSM7GYAEs3yD6o7Ecu0+LS10DfM/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212272; c=relaxed/simple;
	bh=LVt5hPd25B281TRLtTutKKX5US2y0TKwkmdiBT+P8IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV4QJLr/TCwE/Hwn3Vmvk9qq4BQ1XD+H0eIMh2Dq2insDPqC78Bven9iFzFCAYPKKLuwyQbLMF8h5aHDvAS+2bNzKlc9Sqk8iSiT+acetNCmsQ1Mxsmh/6itv0f7DiUm2QRWjET1ZaUH10QR4E2TNq/2mGOqJxSy1pZh2BpDLU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e447c39525so170507a34.0;
        Thu, 29 Feb 2024 05:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212270; x=1709817070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvvRk2gFQ4DOAmG0ZAXvnWf5WKlifEzlcrpvhWJNSEM=;
        b=B9u5nsnhVRdwgQgYkwj/bMb3uBgedQDw5bQC0QiuLLv6+5x148uc1eM6K1TmRG1IZI
         khb7cj07NEUCGo2/WW4XEE5dTIbmgJUMRKUt36QHDYsgatXE7QAJUP/5iQRfx8Shouxh
         Dzpu7NHOTT73NzBJH9H2C3rZSxQkBzunD9F8U9PjW/Ktk6P03CjqDAEcLhBapYPU/MPA
         5uLo78EYhLAEPVbWES7lozLDtxNLZXFU5MJ8jkFJv6U0BtTxe2qJYnm8FrlQMdUGWSz4
         zYxNqoQU9ED6S9m3U4Xu2+A+nGF96bdqys7AJ6EhAhx0ZcfWqoPU+dfPFDXLTlskY2Kc
         5ysw==
X-Forwarded-Encrypted: i=1; AJvYcCXZJcD+ESU2VsoOVwqd8fDifnXEiyrwbcZAcmmAPIQg+IqQNkX+EOksyFS2T2eXX5EbCeYPecS8HMTlFkavS65vkBoSXOOWhi92ENI0IIdo1CEYPKmsl7/DOGNIINrN1QBcYlftufUN+/ukFTbQOi/KXftnbU5qWG7JVhN+qVqY/w==
X-Gm-Message-State: AOJu0YwBqiZrLUWHN2fSK1laOMha7UQJX5RFttrcbx+/Op1lcfop8yr3
	VeGwl+fMEOaahdKrus8wBl7979+zRlk41P0+wfMweniI5pkKodaDbbq/KjPIaMwI3MuEpZSylHS
	EVQasvo+j+v6BhScTbggyIlPUmvI=
X-Google-Smtp-Source: AGHT+IHi3c3RgO2A1VH16z4qbN2kTgJY1571Ukf5IEcJB1p5nBjZ6clv6ctv3wxEJuFdMZE7W4nhzwDuQXoFachzwOc=
X-Received: by 2002:a4a:d091:0:b0:5a0:4216:c5f0 with SMTP id
 i17-20020a4ad091000000b005a04216c5f0mr1921598oor.0.1709212269855; Thu, 29 Feb
 2024 05:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229105204.720717-1-herve.codina@bootlin.com>
 <20240229105204.720717-2-herve.codina@bootlin.com> <9cc3d11bc3e1bb89a1c725f865d0c8d1494111c5.camel@gmail.com>
 <CAJZ5v0hGfqrczS1Si8Bu67vTSkTKO_gO7ftO2R7CQxGKGWsbAA@mail.gmail.com> <af8a97f3a187cc403b6184948d3e335ee83f44ec.camel@gmail.com>
In-Reply-To: <af8a97f3a187cc403b6184948d3e335ee83f44ec.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 14:10:58 +0100
Message-ID: <CAJZ5v0jwXiJU6SMwHZUJ0RVhGTmiwX1ijx4UcgbYdM6SnftSfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Introduce device_link_wait_removal()
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

On Thu, Feb 29, 2024 at 2:03=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Thu, 2024-02-29 at 14:01 +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 29, 2024 at 12:13=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:
> > >
> > > Hi,
> > >
> > > Just copy pasting my previous comments :)
> > >
> > > On Thu, 2024-02-29 at 11:52 +0100, Herve Codina wrote:
> > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > introduces a workqueue to release the consumer and supplier devices=
 used
> > > > in the devlink.
> > > > In the job queued, devices are release and in turn, when all the
> > > > references to these devices are dropped, the release function of th=
e
> > > > device itself is called.
> > > >
> > > > Nothing is present to provide some synchronisation with this workqu=
eue
> > > > in order to ensure that all ongoing releasing operations are done a=
nd
> > > > so, some other operations can be started safely.
> > > >
> > > > For instance, in the following sequence:
> > > >   1) of_platform_depopulate()
> > > >   2) of_overlay_remove()
> > > >
> > > > During the step 1, devices are released and related devlinks are re=
moved
> > > > (jobs pushed in the workqueue).
> > > > During the step 2, OF nodes are destroyed but, without any
> > > > synchronisation with devlink removal jobs, of_overlay_remove() can =
raise
> > > > warnings related to missing of_node_put():
> > > >   ERROR: memory leak, expected refcount 1 instead of 2
> > > >
> > > > Indeed, the missing of_node_put() call is going to be done, too lat=
e,
> > > > from the workqueue job execution.
> > > >
> > > > Introduce device_link_wait_removal() to offer a way to synchronize
> > > > operations waiting for the end of devlink removals (i.e. end of
> > > > workqueue jobs).
> > > > Also, as a flushing operation is done on the workqueue, the workque=
ue
> > > > used is moved from a system-wide workqueue to a local one.
> > > >
> > > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> > > >  include/linux/device.h |  1 +
> > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index d5f4e4aac09b..80d9430856a8 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > >  static void __fw_devlink_link_to_consumers(struct device *dev);
> > > >  static bool fw_devlink_drv_reg_done;
> > > >  static bool fw_devlink_best_effort;
> > > > +static struct workqueue_struct *device_link_wq;
> > > >
> > > >  /**
> > > >   * __fwnode_link_add - Create a link between two fwnode_handles.
> > > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device=
 *dev)
> > > >       /*
> > > >        * It may take a while to complete this work because of the S=
RCU
> > > >        * synchronization in device_link_release_fn() and if the con=
sumer
> > > > or
> > > > -      * supplier devices get deleted when it runs, so put it into =
the
> > > > "long"
> > > > -      * workqueue.
> > > > +      * supplier devices get deleted when it runs, so put it into =
the
> > > > +      * dedicated workqueue.
> > > >        */
> > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > +     queue_work(device_link_wq, &link->rm_work);
> > > >  }
> > > >
> > > > +/**
> > > > + * device_link_wait_removal - Wait for ongoing devlink removal job=
s to
> > > > terminate
> > > > + */
> > > > +void device_link_wait_removal(void)
> > > > +{
> > > > +     /*
> > > > +      * devlink removal jobs are queued in the dedicated work queu=
e.
> > > > +      * To be sure that all removal jobs are terminated, ensure th=
at any
> > > > +      * scheduled work has run to completion.
> > > > +      */
> > > > +     drain_workqueue(device_link_wq);
> > > > +}
> > >
> > > I'm still not convinced we can have a recursive call into devlinks re=
moval
> > > so I
> > > do think flush_workqueue() is enough. I will defer to Saravana though=
..
> >
> > AFAICS, the difference betwee flush_workqueue() and drain_workqueue()
> > is the handling of the case when a given work item can queue up itself
> > again.  This does not happen here.
>
>
> Yeah, that's also my understanding...

Moreover, IIUC this is called after dropping the last reference to the
device link in question and so after queuing up the link removal work.
Because that work does not requeue itself, flush_workqueue() is
sufficient to ensure that the removal work has been completed.

If anyone thinks that it may not be sufficient, please explain to me
why you think so.  Otherwise, don't do stuff to prevent things you
cannot explain.

