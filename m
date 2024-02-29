Return-Path: <linux-kernel+bounces-87688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289F86D7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05291F23FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6913C9D6;
	Thu, 29 Feb 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A24Mc9Wi"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D97827E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249214; cv=none; b=NDy51LKKZ6hdwLWpl5SUqyG9P0sq0VfH75I0xMcfXms9E3fUey69FS/jaPNBLskW+RSBbvtE9CILZczV3zdb7fJbp+KmxZtJgheqj852wTxi/KlmaCaQ3/OOfm3OJYDxC1ze/Uau4axmOT+R80YRFmTjT75WQxpf5ljzpCzOf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249214; c=relaxed/simple;
	bh=XY+tF/oyv5RZqs+TYf1m3Rn6En+Ql1F7UgQnTwazuWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftOxHstopHTPbV4+k/rC7YbY1zGLoFhc0HhlAtGCYrKHuhm55fQoSgkEPPJ00znZja7TwLmNCxwXmaHQwO95puJagcyGF6VxSx2S0cMus1JJoYsms1BR8CxfHIw3Umkwr/JAFSxTCP3M761uWVs3I5A03T6D/k7VfvlzIShMB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A24Mc9Wi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42ec412cafdso17161cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709249211; x=1709854011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qC3fdiR3wpO9HRmx8vGtLqu6epk2+GZTHN12FsFnSk=;
        b=A24Mc9WiSVEs5PorukWsU2KUenqSFBj+odxFx72XrNl8qJ7NHq/egTBXeDCf5tgmoE
         ZcREkBetYcmOehfzJr0CAxychPYapTfDhm6KO96lETs1L3GTnkCLEAZvqo9CBcLUVy6n
         qC3OUbov/Ldn15Td33tR3Ti1nQydbh+ntddvI0ubZxVfQume/3pK6uacneS3OCTohta4
         k2yKLeTEdD9WKJxxJu55fQN2PRBZ9sDXsC7YJ6HdffiUmftnyyQAR4Bnx50xQ0vGv/fb
         BGPrKcZfBp2gXheNQTg7t4yPJwW42IIcjtMfew/0tZtHAj5hmgRSCG5thzYxHdZBLYd+
         K9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249211; x=1709854011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qC3fdiR3wpO9HRmx8vGtLqu6epk2+GZTHN12FsFnSk=;
        b=Kz03XnYoTtX/2wjvJ6KThsp2NuqDvCBj91j3h0P4VcnQURrlMY33fj76egvLfEyw6f
         RLDY5d+rx8ZsO4cDWr8Jse/wcZvcbNQlZrIqXvW8GP0xkV4JX/n9pUNkNOTEGnn7wTJ4
         KKOR6nZdkR6MT0fB2h9z+y8BYUffQ3CfEQL9QWmSvA7xPOwLafNb5B1ky/a+CbdYYd9e
         ESQRpqpzLyjU2wyq0G+2q6+mmqZewvuS4wXZrrt/ajcduXjS/nujBD+noUmMSKVp7xR8
         WH/wYvf4x6WGnc5w8WfFvcQYfOtJaNO8ppdSYHkKJLo8qsd5gI4pScH5FFQvs4GDIJA1
         fVFg==
X-Forwarded-Encrypted: i=1; AJvYcCVdydym5yxOyVm4rSGPfNWQi/ErudRpakRmVhFmzoBtePcnd0+ziKvPyVdjHwrt7EnLfnHUOi2ETEilG32ZpxL++B6FbaXNTaHH+B0F
X-Gm-Message-State: AOJu0YwsQwjcICSVHHsKUEFJkCmY31rRtBN26DhjPRwkrYg7+YlD66iM
	ILW3c6d0+HyAc4bCfh5aD2W7EyZceXXRFFhx2Q/5DpVEGTdP3F/13P9+3Schfjf1bZwBKwgjOYM
	31JA6kKcN7QlbVSYgQ+U15VUrzFKABqiRNGig
X-Google-Smtp-Source: AGHT+IFTp3iCHULEe6WvtnD0a3CSDWgwwezmvxtlg72qf7OTNzFNIfW9Lodil24Jm8e+rucPSssirLGptHIFDo/AUd8=
X-Received: by 2002:a05:622a:6:b0:42e:8e9e:3a1f with SMTP id
 x6-20020a05622a000600b0042e8e9e3a1fmr91697qtw.10.1709249210646; Thu, 29 Feb
 2024 15:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130174126.688486-1-herve.codina@bootlin.com>
 <20231130174126.688486-2-herve.codina@bootlin.com> <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
 <20240223101115.6bf7d570@bootlin.com> <cdf0a9facd95a2b7ee618e6130dedb9aabf4ed09.camel@gmail.com>
In-Reply-To: <cdf0a9facd95a2b7ee618e6130dedb9aabf4ed09.camel@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 29 Feb 2024 15:26:14 -0800
Message-ID: <CAGETcx9x55moTrvcDCup_K0DU305TtjK4Nvjf_drfipyowKb=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:41=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Fri, 2024-02-23 at 10:11 +0100, Herve Codina wrote:
> > Hi Saravana,
> >
> > On Tue, 20 Feb 2024 16:31:13 -0800
> > Saravana Kannan <saravanak@google.com> wrote:
> >
> > ...
> >
> > > > +void device_link_wait_removal(void)
> > > > +{
> > > > +       /*
> > > > +        * devlink removal jobs are queued in the dedicated work qu=
eue.
> > > > +        * To be sure that all removal jobs are terminated, ensure =
that
> > > > any
> > > > +        * scheduled work has run to completion.
> > > > +        */
> > > > +       drain_workqueue(fw_devlink_wq);
> > >
> > > Is there a reason this needs to be drain_workqueu() instead of
> > > flush_workqueue(). Drain is a stronger guarantee than we need in this
> > > case. All we are trying to make sure is that all the device link
> > > remove work queued so far have completed.
> >
> > I used drain_workqueue() because drain_workqueue() allows for jobs alre=
ady
> > present in a workqueue to re-queue a job and drain_workqueue() will wai=
t
> > also for this new job completion.
> >
> > I think flush_workqueue() doesn't wait for this chain queueing.
> >
> > In our case, my understanding was that device_link_release_fn() calls
> > put_device() for the consumer and the supplier.
> > If refcounts reaches zero, devlink_dev_release() can be called again
> > and re-queue a job.
> >
>
> Looks sensible. The only doubt (that Saravana mays know better) is that I=
'm not
> sure put_device() on a supplier or consumer can actually lead to
> devlink_dev_release(). AFAIU, a consumer or a supplier should not be a de=
vice
> from the devlink class. Hence, looking at device_release(), I'm not sure =
it can
> happen unless for some odd reason someone is messing with devlinks in .re=
move()
> or .type->remove().

The case we are trying to fix here involves a supplier or a consumer
device (say Device-A) being device_del(). When that happens, all the
device links to/from the device are deleted by a call to
device_links_purge() since a device link can't exist without both the
supplier and consumer existing.

The problem you were hitting is that the device link deletion code
does the put_device(Device-A) in a workqueue. You change is to make
sure to wait until that has completed. To do that, you only need to
wait for the device link deletion work (already queued before
returning from device_del()) to finish. You don't need to wait for
anything more.

I read up on drain_workqueue() before I made my comments. The point I
was trying to make is that there could be some unrelated device link
deletions that you don't need to wait on.

But taking a closer look[1], it looks like drain_workqueue() might
actually cause bugs because while a workqueue is being drained, if
another unrelated device link deletion is trying to queue work, that
will get ignored.

Reply to rest of the emails in this thread here:

Nuno,

Sorry if I messed up who sent the first patch, but I did dig back to
your v1. But I could be wrong.

If devlink_dev_release() could have done the work synchronously, we'd
have done it in the first place. It's actually a bug because
devlink_dev_release() gets called in atomic context but the
put_device() on the supplier/consumer can do some sleeping work.

-Saravana

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/workqueue.c#n1727

