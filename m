Return-Path: <linux-kernel+bounces-46583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED048441A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3414A1C21B61
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587C81ACB;
	Wed, 31 Jan 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brTvpFtI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC47F48F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710679; cv=none; b=ZTlhWFrz1MB+BUpRlBG1Hm6eu86iIj3WMPayTLyDrTqgUdQiCLHFEk3AXP5F9Qpgom2ZjeW4mxDps770ldJfl8+bsXPllelsnH5ZmBW5t+dZIp003ZHFmaNdlLQWl93fMVVh6hMwKjZs2WjUpKJXKdm7R4c6osIj3emm3Y/feuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710679; c=relaxed/simple;
	bh=Kf1lT2XvFRfgDgK/IdiJkFZAq++hY9+KixQNfsBllHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhAwu8QlAmT/exPsIbGteFdOr9w1nAgJFVLwPuve1+YFNN1pYmcSfqo1bBcNhmfMDalsSypBXQjnpSkcasFjWj7ZdTKMlYi61cnaiNKnyaQvQhkimZ9yKPfdB7/YQyNRPm2fyBCQY28s3BU6mqS60Lkm86Rh0fXhrA7xYn+AprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brTvpFtI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so5483565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706710676; x=1707315476; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kf1lT2XvFRfgDgK/IdiJkFZAq++hY9+KixQNfsBllHI=;
        b=brTvpFtIZ4llgiTqo/vqFREHfeD9+Jy+hUdR0DeRxIEiBmPWyTORnxMZeuWDsKvMgT
         maKzavyWd8WZ5Ey9RKh6I9VrR/I6b7nWYUbkk899Gze+C0utWsGo3dEzKq7P61jJbl7s
         6cWn9VeDjJsLC+/2og4m0RjZnNBTc9uQgBZJMlOy86cJx5ws1ZUKUIsERxPEBurV3W4L
         ggW9RKRoflLZZLLrlSZ3Md21JC+LBIQ7mZLvii82NWVD0h6R10iEWtqEEE4lsghUF6TP
         IdODqmPn/ybEB3eWL0QU3RJWDlckZ1FgePdYyW5PTimOMzUbo9i1MuqBtkd8nP4QzF6A
         pcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710676; x=1707315476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kf1lT2XvFRfgDgK/IdiJkFZAq++hY9+KixQNfsBllHI=;
        b=pV5NBUIqAzPWrEx/T0VemcXZcIGh4y0GLK4mPNu8ZihyoN9c4yjyZSJpost3ugA4Xy
         opjwNGWz1YF324k6FMShHFh7H+DCrqTKZap8BnF115iFplZcvfhrgTxeokQ5b9yiV5Gr
         QVIvghm0neg8RoMhowhPODKJGFgnup4rFNM6+pkhKkadSiGTJFU0fRFnwwMUoEgGjlLP
         z4iX51QkgEVB5ERKnzZCRBRv3v3ld3kXY+RvLy/mOZEnyAL9z1zRqVRVa65HboSzIsEE
         3f01H6giyqi1ITcsiA3g9AFe4ls7KT3zjJLWvXOk65W5rJ3JTRzpt84qrRUwG5klS6ym
         c+bA==
X-Gm-Message-State: AOJu0Yw58CCS1b/43bJyDAZkXITgsouPKXm8p0KJBuXT8DIXSJ0ZFPfH
	urNSzBk9eotqsVpXOYWw5ARDUyrCqupI3X4BRTPRwo8XdpQbO/Wz
X-Google-Smtp-Source: AGHT+IHchDw78Wwvg6P+H6gGpWtbNVbNaoqYtln3skTRHqErkRItM4Y2KyxFQ02o0mBfLSwMNFKHnA==
X-Received: by 2002:a05:600c:35d2:b0:40e:f88f:c529 with SMTP id r18-20020a05600c35d200b0040ef88fc529mr4305338wmq.9.1706710675246;
        Wed, 31 Jan 2024 06:17:55 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id b26-20020adf9b1a000000b0033924b4d1f9sm13595877wrc.94.2024.01.31.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:17:54 -0800 (PST)
Message-ID: <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links
 removal for dt overlays
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: nuno.sa@analog.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org,  Saravana Kannan <saravanak@google.com>
Date: Wed, 31 Jan 2024 15:21:11 +0100
In-Reply-To: <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
References: 
	<20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
	 <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
	 <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote:
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > For device links, releasing the supplier/consumer devices references
> > > happens asynchronously in device_link_release_fn(). Hence, the possib=
le
> > > release of an of_node is also asynchronous. If these nodes were added
> > > through overlays we have a problem because this does not respect the
> > > devicetree overlays assumptions that when a changeset is
> > > being removed in __of_changeset_entry_destroy(), it must hold the las=
t
> > > reference to that node. Due to the async nature of device links that
> > > cannot be guaranteed.
> > >=20
> > > Given the above, in case one of the link consumer/supplier is part of
> > > an overlay node we call directly device_link_release_fn() instead of
> > > queueing it. Yes, it might take some significant time for
> > > device_link_release_fn() to complete because of synchronize_srcu() bu=
t
> > > we would need to, anyways, wait for all OF references to be released =
if
> > > we want to respect overlays assumptions.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > This RFC is a follow up of a previous one that I sent to the devicetr=
ee
> > > folks [1]. It got rejected because it was not really fixing the root
> > > cause of the issue (which I do agree). Please see the link where I
> > > fully explain what the issue is.
> > >=20
> > > I did also some git blaming and did saw that commit
> > > 80dd33cf72d1 ("drivers: base: Fix device link removal") introduced
> > > queue_work() as we could be releasing the last device reference and h=
ence
> > > sleeping which is against SRCU callback requirements. However, that s=
ame
> > > commit is now making use of synchronize_srcu() which may take
> > > significant time (and I think that's the reason for the work item?).
> > >=20
> > > However, given the dt overlays requirements, I'm not seeing any
> > > reason to not be able to run device_link_release_fn() synchronously i=
f we
> > > detect an OVERLAY node is being released. I mean, even if we come up
> > > (and I did some experiments in this regard) with some async mechanism=
 to
> > > release the OF nodes refcounts, we still need a synchronization point
> > > somewhere.
> > >=20
> > > Anyways, I would like to have some feedback on how acceptable would t=
his
> > > be or what else could I do so we can have a "clean" dt overlay remova=
l.
> > >=20
> > > I'm also including dt folks so they can give some comments on the new
> > > device_node_overlay_removal() function. My goal is to try to detect w=
hen
> > > an
> > > overlay is being removed (maybe we could even have an explicit flag f=
or
> > > it?) and only directly call device_link_release_fn() in that case.
> > >=20
> > > [1]:
> > > https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-nun=
o.sa@analog.com/
> > > ---
> > > =C2=A0drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > =C2=A01 file changed, 24 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 14d46af40f9a..31ea001f6142 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] =3D {
> > > =C2=A0};
> > > =C2=A0ATTRIBUTE_GROUPS(devlink);
> > >=20
> > > +static bool device_node_overlay_removal(struct device *dev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev_of_node(dev))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of_node, OF_DE=
TACHED))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of_node, OF_OV=
ERLAY))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return false;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > +}
> > > +
> > > =C2=A0static void device_link_release_fn(struct work_struct *work)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_link *link =3D container=
_of(work, struct device_link,
> > > rm_work);
> > > @@ -532,8 +544,19 @@ static void devlink_dev_release(struct device *d=
ev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in device_link=
_release_fn() and if the consumer
> > > or
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get deleted w=
hen it runs, so put it into the
> > > "long"
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * However, if any of the supplier, co=
nsumer nodes is being removed
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * through overlay removal, the expect=
ation in
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * __of_changeset_entry_destroy() is f=
or the node 'kref' to be 1
> > > which
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cannot be guaranteed with the async=
 nature of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * device_link_release_fn(). Hence, do=
 it synchronously for the
> > > overlay
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * case.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link->rm_work);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (device_node_overlay_removal(link->consu=
mer) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_node_overlay=
_removal(link->supplier))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 device_link_release_fn(&link->rm_work);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 queue_work(system_long_wq, &link->rm_work);
> > > =C2=A0}
> > >=20
> > > =C2=A0static struct class devlink_class =3D {
> > >=20
> > > ---
> > > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > > change-id: 20240123-fix-device-links-overlays-5422e033a09b
> > > --
> > >=20
> > > Thanks!
> > > - Nuno S=C3=A1
> > >=20
> >=20
> > Hi Rafael,
> >=20
> > Would be nice to have your feedback on this one or if this is a complet=
e
> > nack...
> > I think calling device_link_release_fn() synchronously is ok but I migh=
t be
> > completely wrong.
>=20
> Well, it sounds like you are expecting me to confirm that what you are
> doing makes sense, but I cannot do that, because I am not sufficiently
> familiar with DT overlays.
>=20

I'm trying to understand if there's no hidden issue by calling it synchrono=
usly.
(don't think there is but this is rather core stuff :)).

From the DT guys, it would be helpful to get feedback on the new
device_node_overlay_removal() helper I'm introducing. The goal is to just d=
o the
sync release in case we detect a node being removed as a result of an overl=
ay
removal.

> You first need to convince yourself that you are not completely wrong.

I mean, the problem is definitely real and if you see the link I pasted in =
the
cover, this will all lead to big splats.

>=20
> > +Cc Saravan as he should also be very familiar with device_links and se=
e if
> > the
> > above fairly simple solution is sane.
> >=20
> > I also don't want to be pushy as I know you guys are all very busy but =
it's
> > (i
> > think) the third time I resend the patch :)
>=20
> Sorry about that, I haven't realized that my input is requisite.
>=20

Yeah, get_mantainers gives me you and Greg but I think you're the main dev =
on
dev_links right?

> So the patch not only calls device_link_release_fn() synchronously,
> but it also calls this function directly and I, personally, wouldn't
> do at least the latter.
>=20

So you mean adding something like adding a new

device_link_release(struct device_link *link) helper
and either call it synchronously from devlink_dev_release() or asynchronous=
ly
from device_link_release_fn()?

I can drop the RFC and send a patch with the above...

- Nuno S=C3=A1


