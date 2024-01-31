Return-Path: <linux-kernel+bounces-46664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CDA84429D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A558B2FFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D212AADF;
	Wed, 31 Jan 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNcYy42X"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3C12AAC8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712755; cv=none; b=Wixkme7eyUUT7+2gFk6fXNGdCfCdoFAYDcCAQFY1Qm1n04QOMa6H3IzfOkKVw/gQWwZXrCLgYxPcfL5Lt3IkA9rdPaZMe2jN7hO3AnEv+/7CY98ge5414LenYW8xkORmTDSOnPyMstYWhw0+HyPGlAFx+XvosQDlJO4FMZijBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712755; c=relaxed/simple;
	bh=IaGme7cKVTXOztAUwJT8LItchoS9fjk0q1LpdIIAuqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMfVY4fHIcMb8QvugH4qRfvOqqcguQG7qUFP5eYuN/riIHfR5VHdp9bnbgTU1IOhJlBh2T1Qz3LMaVUOfobA8OaCOiP9cObpEQE31NCjUERYR/ICE6a+WqqWAaMOY6vFWSS2nXvnUFumiceViadLKsy3DzRURlMPtfig8ad9THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNcYy42X; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so28522f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712752; x=1707317552; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfc1sVAcBi3W1QZAoaOQxx00lsYE9L947Born7xdO5w=;
        b=aNcYy42XEs37bTJewWDnYS/nEXzdroDYdUtB5houGhE+4n/U9H0LQVmGrnotScwOoT
         i/tmfQXpfeINRuFVXDX5l6WAkIAxyWOvdfGdKAEvKbEdO1zMhU7JQLjncCIbsWNOJSIv
         Em4Op63HjwuzeDxkKA0zrYPh/RhspXd+7cJdNHiJunuT09oXRB813/yqse19QNm11ncY
         yweVJSdkomXpOincoB/T53iFfnfiIXTnrFcsavOSkD1CdeCKrSw65U1K242JxZIDy4o2
         l4Pi1TUffmKp2NV83t/Qr35Ud1qLj6vts+bPraOFI4AI/RtKKd9comyMkKRdmwQRHd5f
         xdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712752; x=1707317552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfc1sVAcBi3W1QZAoaOQxx00lsYE9L947Born7xdO5w=;
        b=K6RjKZ2JnzMUlkWFcIY6l0mBEZ8WgPiH+bAeJGYbvK6ZJpiqvE1bB/emhljEM6pRYZ
         l1oqOal03sF7tpkQnkndN6gAQY4JWWSZGPKRuyy7kol8iaVdjd1yAdUFV9EX3Pz0T96w
         KoYhd2a4nUgRRpAkTzAqIVJ3OOQN+Q6xInnP1kjV+0SFjtcvjXk4CriFva9iJ+k7cfPu
         4RxA7/BFRoAibojMVJ61Dc/anPwdWheeFm4al+Dy4GSyoyH/Am8nJcRrcLYfKBnZyR3t
         h3B8+9EQ116k102lLFRUCpkWJf1vVk/kYOXFIFVtxwMzD19ZY5HC/T12CQ3keYzUgY7S
         9GAw==
X-Gm-Message-State: AOJu0YwW+fNz/gDPbtfwfRYmlJJtFyzvTSPBu8e7aux38P7tn8so7c3o
	gr4OiZ/LpbrgWRuvf8yPnFGGjcUbF+Uv9XKTLd/NOxooBp7qch6p
X-Google-Smtp-Source: AGHT+IHjSow5xBmPNHOl6q170RsvCViWH9kq/k94KfwJXNWzk6e5BJh6ZxqDpSafBfNRWO/FXJF26A==
X-Received: by 2002:adf:fcc9:0:b0:33a:edcd:6f38 with SMTP id f9-20020adffcc9000000b0033aedcd6f38mr1511983wrs.34.1706712751905;
        Wed, 31 Jan 2024 06:52:31 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0033af9591653sm4842023wro.97.2024.01.31.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:52:31 -0800 (PST)
Message-ID: <8682d7f7ee1a60902b1f3e5529a4adbaf4846aa0.camel@gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links
 removal for dt overlays
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: nuno.sa@analog.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org,  Saravana Kannan <saravanak@google.com>
Date: Wed, 31 Jan 2024 15:55:48 +0100
In-Reply-To: <CAJZ5v0hX4Yv7UVng=O4tZyb_O7D2EcymdEDdSUrVDPk6h51VjA@mail.gmail.com>
References: 
	<20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
	 <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
	 <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
	 <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
	 <CAJZ5v0hX4Yv7UVng=O4tZyb_O7D2EcymdEDdSUrVDPk6h51VjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 15:28 +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 3:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote:
> > > >=20
> > > > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote:
> > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > >=20
> > > > > For device links, releasing the supplier/consumer devices referen=
ces
> > > > > happens asynchronously in device_link_release_fn(). Hence, the
> > > > > possible
> > > > > release of an of_node is also asynchronous. If these nodes were a=
dded
> > > > > through overlays we have a problem because this does not respect =
the
> > > > > devicetree overlays assumptions that when a changeset is
> > > > > being removed in __of_changeset_entry_destroy(), it must hold the=
 last
> > > > > reference to that node. Due to the async nature of device links t=
hat
> > > > > cannot be guaranteed.
> > > > >=20
> > > > > Given the above, in case one of the link consumer/supplier is par=
t of
> > > > > an overlay node we call directly device_link_release_fn() instead=
 of
> > > > > queueing it. Yes, it might take some significant time for
> > > > > device_link_release_fn() to complete because of synchronize_srcu(=
) but
> > > > > we would need to, anyways, wait for all OF references to be relea=
sed
> > > > > if
> > > > > we want to respect overlays assumptions.
> > > > >=20
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > ---
> > > > > This RFC is a follow up of a previous one that I sent to the
> > > > > devicetree
> > > > > folks [1]. It got rejected because it was not really fixing the r=
oot
> > > > > cause of the issue (which I do agree). Please see the link where =
I
> > > > > fully explain what the issue is.
> > > > >=20
> > > > > I did also some git blaming and did saw that commit
> > > > > 80dd33cf72d1 ("drivers: base: Fix device link removal") introduce=
d
> > > > > queue_work() as we could be releasing the last device reference a=
nd
> > > > > hence
> > > > > sleeping which is against SRCU callback requirements. However, th=
at
> > > > > same
> > > > > commit is now making use of synchronize_srcu() which may take
> > > > > significant time (and I think that's the reason for the work item=
?).
> > > > >=20
> > > > > However, given the dt overlays requirements, I'm not seeing any
> > > > > reason to not be able to run device_link_release_fn() synchronous=
ly if
> > > > > we
> > > > > detect an OVERLAY node is being released. I mean, even if we come=
 up
> > > > > (and I did some experiments in this regard) with some async mecha=
nism
> > > > > to
> > > > > release the OF nodes refcounts, we still need a synchronization p=
oint
> > > > > somewhere.
> > > > >=20
> > > > > Anyways, I would like to have some feedback on how acceptable wou=
ld
> > > > > this
> > > > > be or what else could I do so we can have a "clean" dt overlay
> > > > > removal.
> > > > >=20
> > > > > I'm also including dt folks so they can give some comments on the=
 new
> > > > > device_node_overlay_removal() function. My goal is to try to dete=
ct
> > > > > when
> > > > > an
> > > > > overlay is being removed (maybe we could even have an explicit fl=
ag
> > > > > for
> > > > > it?) and only directly call device_link_release_fn() in that case=
.
> > > > >=20
> > > > > [1]:
> > > > > https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1=
-nuno.sa@analog.com/
> > > > > ---
> > > > > =C2=A0drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > > > =C2=A01 file changed, 24 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > index 14d46af40f9a..31ea001f6142 100644
> > > > > --- a/drivers/base/core.c
> > > > > +++ b/drivers/base/core.c
> > > > > @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] =3D=
 {
> > > > > =C2=A0};
> > > > > =C2=A0ATTRIBUTE_GROUPS(devlink);
> > > > >=20
> > > > > +static bool device_node_overlay_removal(struct device *dev)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev_of_node(dev))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return false;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of_node, O=
F_DETACHED))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return false;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of_node, O=
F_OVERLAY))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return false;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > > > +}
> > > > > +
> > > > > =C2=A0static void device_link_release_fn(struct work_struct *work=
)
> > > > > =C2=A0{
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_link *link =3D conta=
iner_of(work, struct
> > > > > device_link,
> > > > > rm_work);
> > > > > @@ -532,8 +544,19 @@ static void devlink_dev_release(struct devic=
e
> > > > > *dev)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in device_=
link_release_fn() and if the
> > > > > consumer
> > > > > or
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get delet=
ed when it runs, so put it into the
> > > > > "long"
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * However, if any of the supplier=
, consumer nodes is being
> > > > > removed
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * through overlay removal, the ex=
pectation in
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * __of_changeset_entry_destroy() =
is for the node 'kref' to be 1
> > > > > which
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cannot be guaranteed with the a=
sync nature of
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * device_link_release_fn(). Hence=
, do it synchronously for the
> > > > > overlay
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * case.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link->rm_wo=
rk);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (device_node_overlay_removal(link->c=
onsumer) ||
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_node_ove=
rlay_removal(link->supplier))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 device_link_release_fn(&link->rm_work);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 queue_work(system_long_wq, &link->rm_work);
> > > > > =C2=A0}
> > > > >=20
> > > > > =C2=A0static struct class devlink_class =3D {
> > > > >=20
> > > > > ---
> > > > > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > > > > change-id: 20240123-fix-device-links-overlays-5422e033a09b
> > > > > --
> > > > >=20
> > > > > Thanks!
> > > > > - Nuno S=C3=A1
> > > > >=20
> > > >=20
> > > > Hi Rafael,
> > > >=20
> > > > Would be nice to have your feedback on this one or if this is a com=
plete
> > > > nack...
> > > > I think calling device_link_release_fn() synchronously is ok but I =
might
> > > > be
> > > > completely wrong.
> > >=20
> > > Well, it sounds like you are expecting me to confirm that what you ar=
e
> > > doing makes sense, but I cannot do that, because I am not sufficientl=
y
> > > familiar with DT overlays.
> > >=20
> >=20
> > I'm trying to understand if there's no hidden issue by calling it
> > synchronously.
> > (don't think there is but this is rather core stuff :)).
> >=20
> > From the DT guys, it would be helpful to get feedback on the new
> > device_node_overlay_removal() helper I'm introducing. The goal is to ju=
st do
> > the
> > sync release in case we detect a node being removed as a result of an
> > overlay
> > removal.
> >=20
> > > You first need to convince yourself that you are not completely wrong=
.
> >=20
> > I mean, the problem is definitely real and if you see the link I pasted=
 in
> > the
> > cover, this will all lead to big splats.
> >=20
> > >=20
> > > > +Cc Saravan as he should also be very familiar with device_links an=
d see
> > > > if
> > > > the
> > > > above fairly simple solution is sane.
> > > >=20
> > > > I also don't want to be pushy as I know you guys are all very busy =
but
> > > > it's
> > > > (i
> > > > think) the third time I resend the patch :)
> > >=20
> > > Sorry about that, I haven't realized that my input is requisite.
> > >=20
> >=20
> > Yeah, get_mantainers gives me you and Greg but I think you're the main =
dev
> > on
> > dev_links right?
> >=20
> > > So the patch not only calls device_link_release_fn() synchronously,
> > > but it also calls this function directly and I, personally, wouldn't
> > > do at least the latter.
> > >=20
> >=20
> > So you mean adding something like adding a new
> >=20
> > device_link_release(struct device_link *link) helper
> > and either call it synchronously from devlink_dev_release() or
> > asynchronously
> > from device_link_release_fn()?
> >=20
> > I can drop the RFC and send a patch with the above...
>=20
> No, IMV devlink_dev_release() needs to be called via
> device_link_put_kref(), but it may run device_link_release_fn()
> directly if the link is marked in a special way or something like
> this.

Sorry, I'm not totally getting this. I'm directly calling
device_link_release_fn() from  devlink_dev_release(). We should only get in=
to
devlink_dev_release() after all the references are dropped right (being it =
the
release callback for the link class)?

device_node_overlay_removal() is my way to see if the link "is marked in a
special way" as you put it. This checks if one of the supplier/consumer is
marked as an OVERLAY and if it's being removed (I think that OF_DETACHED te=
lls
us that but some feedback from DT guys will be helpful).

Alternatively, I could just check the OF_OVERLAY flag when the link is bein=
g
created and have a new variable in struct device_link to flag the synchrono=
us
release. Disadvantage is that in this way even a sysfs unbind or module unl=
oad
(without necessarily removing the overly) would lead to a synchronous relea=
se
which can actually make sense (now that I think about it). Because if someo=
ne
does some crazy thing like "echo device > unbind" and then removes the over=
lay
we could still hit the overly removal path before device_link_release_fn()
completed.

- Nuno S=C3=A1


