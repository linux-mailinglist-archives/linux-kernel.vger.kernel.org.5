Return-Path: <linux-kernel+bounces-94208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F8873B59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BB01C209B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159481361C6;
	Wed,  6 Mar 2024 15:57:02 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6460912;
	Wed,  6 Mar 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740621; cv=none; b=FNbQJgz2dVLIbhozGAK2rVbiNFE7Wy2jDLc79e6mgJfQxdow06WtftK0E3tVNc3f8zhkHOXZeZzgN6NUBym3Wrpr5kiOZ+EyQEmAtNShRnFbLuwVh3U2JCqvw3htDT9uu0J9TLT3O6K3Ad2jNxW0gwCaFs/h6oNI79zxntN3miM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740621; c=relaxed/simple;
	bh=4tghISU+9PtSjWtX/KooJvAfp+afRTcd2Wim7+281EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3fnhn+SqQpRPkCjVpcJk7kKElfpovxu33CdVAQJWT500Dpd5VPSseM4T7eJ3LfSrGWtxXd5+Gzl6uFjlKAs3i9VGnXo/0rFSToiAT6Fw+xLtgU7gnI1CeRPo/hbl3InZRhNsvXhO64u+d0kY04ifh3PdX6sgyeAMQQZPupY3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-220ce420472so1347446fac.1;
        Wed, 06 Mar 2024 07:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740619; x=1710345419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRuYu3pgVDn4yl5odBwmAdoeGMF5J7JUGXQ//zks9Lo=;
        b=caIkFuJjjXDO/al/axSusjbPiXmNNt3mzhGkUieoiXW90xWxq0v/0W4pKvI2xfUQRM
         a7YOFhY6kd2MM+3+NoDaVLgbSKaxXp4+eMveJLzae5phMVGBbgstmYUuDUvWh48da8jl
         x8MOjDFepXKxQXs4DXjRt10wz5zczX/XeUE6buQZTjVIdPVDRWuds8aI2JjaU2Id1Zf8
         v6r5N/TvY3Pxhhwna0Uj9Momr7AOcggC+hHdIOqX7FcgSEmKGsDDZhEXPzs9VJkabcjv
         YRbBShnhkblHMXs498jj53GpeLbFaGxwzEcYkg+PtjPZPab2Yr5QCPO91KETeZC6Y03i
         bjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2T2/rJcCyAMW3lFrqSlJ6aK8MN8aUqRIu7CDisTdZZyItHdpfyO+l99n7bf9rR+cl5Smx649y2fXnwzd52XyyUu43/mpZsj0RegLuRhlB2sOqsDzqS4S/FXG8KKv3AGW/ppe+DsrDsiJEG6Z4v4QlH361jFzLIHJLdTD+2NhJAw==
X-Gm-Message-State: AOJu0YyF3NvROZjWzy/q6GkfQeLoa64NEaQB7naVxrCWzVpJY+n8I1P3
	wH1gQ1LFEWTZ6ktQqiMD3alGTMy7waMsNYu5TXsSEQHKXsbK+UxwdDN60u240/3rDffc1+uqtj8
	YloACJiYIHU84iKAu7bt86VecMhI=
X-Google-Smtp-Source: AGHT+IEsBZ3LiBc38I6NvmS8TqLDiRTOWQTra2Xy4MwzY0sHI3hzoucfdrgc0TI/rKjp4G4ZH/bvtO8MllvCteIq4ac=
X-Received: by 2002:a05:6870:d681:b0:21e:ad52:3029 with SMTP id
 z1-20020a056870d68100b0021ead523029mr4049265oap.0.1709740619125; Wed, 06 Mar
 2024 07:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085007.169771-1-herve.codina@bootlin.com>
 <20240306085007.169771-2-herve.codina@bootlin.com> <CAJZ5v0gENrBFfJ3FDJ=m0-veFbue_Bw168+k2cs7v2u9MtCT8Q@mail.gmail.com>
 <20240306162447.2a843a11@bootlin.com>
In-Reply-To: <20240306162447.2a843a11@bootlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 16:56:47 +0100
Message-ID: <CAJZ5v0hYxhoLEEJ=MXPNFWpp7bidx_832RdOAgzx4m=aM0YzXg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:24=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> Hi Rafael,
>
> On Wed, 6 Mar 2024 13:48:37 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Wed, Mar 6, 2024 at 9:51=E2=80=AFAM Herve Codina <herve.codina@bootl=
in.com> wrote:
> > >
> > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > introduces a workqueue to release the consumer and supplier devices u=
sed
> > > in the devlink.
> > > In the job queued, devices are release and in turn, when all the
> > > references to these devices are dropped, the release function of the
> > > device itself is called.
> > >
> > > Nothing is present to provide some synchronisation with this workqueu=
e
> > > in order to ensure that all ongoing releasing operations are done and
> > > so, some other operations can be started safely.
> > >
> > > For instance, in the following sequence:
> > >   1) of_platform_depopulate()
> > >   2) of_overlay_remove()
> > >
> > > During the step 1, devices are released and related devlinks are remo=
ved
> > > (jobs pushed in the workqueue).
> > > During the step 2, OF nodes are destroyed but, without any
> > > synchronisation with devlink removal jobs, of_overlay_remove() can ra=
ise
> > > warnings related to missing of_node_put():
> > >   ERROR: memory leak, expected refcount 1 instead of 2
> > >
> > > Indeed, the missing of_node_put() call is going to be done, too late,
> > > from the workqueue job execution.
> > >
> > > Introduce device_link_wait_removal() to offer a way to synchronize
> > > operations waiting for the end of devlink removals (i.e. end of
> > > workqueue jobs).
> > > Also, as a flushing operation is done on the workqueue, the workqueue
> > > used is moved from a system-wide workqueue to a local one.
> > >
> > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> >
> > No, it is not fixed by this patch.
>
> Was explicitly asked by Saravana on v1 review:
> https://lore.kernel.org/linux-kernel/CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e=
36wJEEnHDve+Avg@mail.gmail.com/

Well, I don't think this is a valid request, sorry.

> The commit 80dd33cf72d1 introduces the workqueue and so some asynchronous=
 tasks
> on removal.
> This patch and the next one allows to re-sync execution waiting for jobs =
in
> the workqueue when it is needed.

I get this, but still, this particular individual patch by itself
doesn't fix anything.  Do you agree with this?

If somebody applies this patch without the next one in the series,
they will not get any change in behavior, so the tag is at least
misleading.

You can claim that the next patch on top of this one fixes things, so
adding a Fixes tag to the other patch would be fine.

There is an explicit dependency between them (the second patch is not
even applicable without the first one, or if it is, the resulting code
won't compile anyway), but you can make a note to the maintainer that
they need to go to -stable together.

> >
> > In fact, the only possibly observable effect of this patch is the
> > failure when the allocation of device_link_wq fails AFAICS.
> >
> > > Cc: stable@vger.kernel.org
> >
> > So why?
>
> Cc:stable is needed as this patch is a prerequisite of patch 2 (needed
> to fix the asynchronous workqueue task issue).

Dependencies like this can be expressed in "Cc: stable" tags.
Personally, I'd do it like this:

Cc: stable@vger.kernel.org # 5.13: Depends on the first patch in the series

