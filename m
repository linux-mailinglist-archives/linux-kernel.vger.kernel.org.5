Return-Path: <linux-kernel+bounces-46689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD38442B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA516287F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25E84A3C;
	Wed, 31 Jan 2024 15:10:54 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40984A26
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713853; cv=none; b=mLxzEdgQIuv6Hd3op5DhGQEQNQFNq8QeWd64bVYJMzrWQlsi6u0SKOqgMmKJx6etHc1S6IRFkAJ69i9Flq5RYmhy2oEA6Igr2gJp7Y1CLE+YsQFYVkv0l4HxMb3xpoBr/3B5boZBjBOIsRy/awATmjkB10hjam9w8M2/3hOoUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713853; c=relaxed/simple;
	bh=Ngh5Q9gLqH9jbkh7Ivxp599539tcEoIDKQzODAf0I6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWRA7krzKiE5o4kbQEZujTR5cT8O75WfAPSjot61QdDXaGK3jby/PUKDA+b6vkahaVNjw4iDEcLEMHof4rQahl7dWJ3n1GNdhUVnqwYCBCFPF5zNfAYPj2GPoY8jRnlThEygP3rXKeNJ/8n7Hlr+ME4C4NlLwezo0tT0K3zBlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-214309bbbf0so155730fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713850; x=1707318650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlZn7lHYbzZv8GhrCvDRI0P+2pJPKtuk6+3fANZ28es=;
        b=jBucpMTp9ABY65SUn59/YwsG5bxDi+r4U8deA4G2PipUt/P6/cilHJo91YOxIFmiRL
         1W8ifi5ZMzQoCPBOc8O1U0Pr6IpyeVijgYR0+M4u0qD+DNnKCsMg902+X+MXLdHoMvYW
         qTSIz9XC9d75lN7UDSo1wxUlT6ea3YxxU/o6VDjfiCm/gjfv23I4vu04Btj8m6WMDWgA
         wwmSQjwXFtwA619+43oIMLJrXqjPVl7m9RHQH3PCiVjtdmd8m4uAtXu7PgHIjXuKqbhG
         BFPc9RkQq4ho34R3PhF/poJicWrcEIbJ96LY1Q53/MWpJR7sgFUqCutXeX7ovyL6+OjY
         1a5g==
X-Gm-Message-State: AOJu0YxGTX6mvdki6MrzNfEbb2eFp8TEgykWwmLqBn1yKNOigyRQD+8R
	c7vVbw1399C931LjYCbNIdC66gFZk+nTO9Xa7nRYzOUmO+YcgLY9I62DNoA9NLCyR23vsyMP6pU
	Bpuwy73pnuyZ3nK8tKsoNwBNCj0k=
X-Google-Smtp-Source: AGHT+IHHH7H08QbHsON9qKFXbXkwbK9km+ja0EOUKKYEvd8fMwKyZVdVL5XheQjK6/qXwr3gyA8398Rgq5NiMk0B3zI=
X-Received: by 2002:a05:6870:71c3:b0:218:a906:6b6 with SMTP id
 p3-20020a05687071c300b00218a90606b6mr1960749oag.4.1706713850553; Wed, 31 Jan
 2024 07:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
 <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
 <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
 <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
 <CAJZ5v0hX4Yv7UVng=O4tZyb_O7D2EcymdEDdSUrVDPk6h51VjA@mail.gmail.com> <8682d7f7ee1a60902b1f3e5529a4adbaf4846aa0.camel@gmail.com>
In-Reply-To: <8682d7f7ee1a60902b1f3e5529a4adbaf4846aa0.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 16:10:39 +0100
Message-ID: <CAJZ5v0hW60++hhKG=yBE7+rB9qt2m+tO_WAf=YFhNU2-y3VHFw@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links removal
 for dt overlays
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, nuno.sa@analog.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:52=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Wed, 2024-01-31 at 15:28 +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 31, 2024 at 3:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
com> wrote:
> > >
> > > On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote:
> > > > >
> > > > > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote:
> > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > >
> > > > > > For device links, releasing the supplier/consumer devices refer=
ences
> > > > > > happens asynchronously in device_link_release_fn(). Hence, the
> > > > > > possible
> > > > > > release of an of_node is also asynchronous. If these nodes were=
 added
> > > > > > through overlays we have a problem because this does not respec=
t the
> > > > > > devicetree overlays assumptions that when a changeset is
> > > > > > being removed in __of_changeset_entry_destroy(), it must hold t=
he last
> > > > > > reference to that node. Due to the async nature of device links=
 that
> > > > > > cannot be guaranteed.
> > > > > >
> > > > > > Given the above, in case one of the link consumer/supplier is p=
art of
> > > > > > an overlay node we call directly device_link_release_fn() inste=
ad of
> > > > > > queueing it. Yes, it might take some significant time for
> > > > > > device_link_release_fn() to complete because of synchronize_src=
u() but
> > > > > > we would need to, anyways, wait for all OF references to be rel=
eased
> > > > > > if
> > > > > > we want to respect overlays assumptions.
> > > > > >
> > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > ---
> > > > > > This RFC is a follow up of a previous one that I sent to the
> > > > > > devicetree
> > > > > > folks [1]. It got rejected because it was not really fixing the=
 root
> > > > > > cause of the issue (which I do agree). Please see the link wher=
e I
> > > > > > fully explain what the issue is.
> > > > > >
> > > > > > I did also some git blaming and did saw that commit
> > > > > > 80dd33cf72d1 ("drivers: base: Fix device link removal") introdu=
ced
> > > > > > queue_work() as we could be releasing the last device reference=
 and
> > > > > > hence
> > > > > > sleeping which is against SRCU callback requirements. However, =
that
> > > > > > same
> > > > > > commit is now making use of synchronize_srcu() which may take
> > > > > > significant time (and I think that's the reason for the work it=
em?).
> > > > > >
> > > > > > However, given the dt overlays requirements, I'm not seeing any
> > > > > > reason to not be able to run device_link_release_fn() synchrono=
usly if
> > > > > > we
> > > > > > detect an OVERLAY node is being released. I mean, even if we co=
me up
> > > > > > (and I did some experiments in this regard) with some async mec=
hanism
> > > > > > to
> > > > > > release the OF nodes refcounts, we still need a synchronization=
 point
> > > > > > somewhere.
> > > > > >
> > > > > > Anyways, I would like to have some feedback on how acceptable w=
ould
> > > > > > this
> > > > > > be or what else could I do so we can have a "clean" dt overlay
> > > > > > removal.
> > > > > >
> > > > > > I'm also including dt folks so they can give some comments on t=
he new
> > > > > > device_node_overlay_removal() function. My goal is to try to de=
tect
> > > > > > when
> > > > > > an
> > > > > > overlay is being removed (maybe we could even have an explicit =
flag
> > > > > > for
> > > > > > it?) and only directly call device_link_release_fn() in that ca=
se.
> > > > > >
> > > > > > [1]:
> > > > > > https://lore.kernel.org/linux-devicetree/20230511151047.1779841=
-1-nuno.sa@analog.com/
> > > > > > ---
> > > > > >  drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > index 14d46af40f9a..31ea001f6142 100644
> > > > > > --- a/drivers/base/core.c
> > > > > > +++ b/drivers/base/core.c
> > > > > > @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] =
=3D {
> > > > > >  };
> > > > > >  ATTRIBUTE_GROUPS(devlink);
> > > > > >
> > > > > > +static bool device_node_overlay_removal(struct device *dev)
> > > > > > +{
> > > > > > +     if (!dev_of_node(dev))
> > > > > > +             return false;
> > > > > > +     if (!of_node_check_flag(dev->of_node, OF_DETACHED))
> > > > > > +             return false;
> > > > > > +     if (!of_node_check_flag(dev->of_node, OF_OVERLAY))
> > > > > > +             return false;
> > > > > > +
> > > > > > +     return true;
> > > > > > +}
> > > > > > +
> > > > > >  static void device_link_release_fn(struct work_struct *work)
> > > > > >  {
> > > > > >       struct device_link *link =3D container_of(work, struct
> > > > > > device_link,
> > > > > > rm_work);
> > > > > > @@ -532,8 +544,19 @@ static void devlink_dev_release(struct dev=
ice
> > > > > > *dev)
> > > > > >        * synchronization in device_link_release_fn() and if the
> > > > > > consumer
> > > > > > or
> > > > > >        * supplier devices get deleted when it runs, so put it i=
nto the
> > > > > > "long"
> > > > > >        * workqueue.
> > > > > > +      *
> > > > > > +      * However, if any of the supplier, consumer nodes is bei=
ng
> > > > > > removed
> > > > > > +      * through overlay removal, the expectation in
> > > > > > +      * __of_changeset_entry_destroy() is for the node 'kref' =
to be 1
> > > > > > which
> > > > > > +      * cannot be guaranteed with the async nature of
> > > > > > +      * device_link_release_fn(). Hence, do it synchronously f=
or the
> > > > > > overlay
> > > > > > +      * case.
> > > > > >        */
> > > > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > > > +     if (device_node_overlay_removal(link->consumer) ||
> > > > > > +         device_node_overlay_removal(link->supplier))
> > > > > > +             device_link_release_fn(&link->rm_work);
> > > > > > +     else
> > > > > > +             queue_work(system_long_wq, &link->rm_work);
> > > > > >  }
> > > > > >
> > > > > >  static struct class devlink_class =3D {
> > > > > >
> > > > > > ---

[cut]

> > No, IMV devlink_dev_release() needs to be called via
> > device_link_put_kref(), but it may run device_link_release_fn()
> > directly if the link is marked in a special way or something like
> > this.
>
> Sorry, I'm not totally getting this. I'm directly calling
> device_link_release_fn() from  devlink_dev_release(). We should only get =
into
> devlink_dev_release() after all the references are dropped right (being i=
t the
> release callback for the link class)?

OK, I got confused somehow, sorry.

It should work.

I kind of don't like adding OF-specific code to the driver core, but
if this is fine with Greg, it can be done.  It should depend on
CONFIG_OF_OVERLAY, though.

I would like a comment to be added to device_link_release_fn() to
explain why the overlay case needs synchronous execution in there.

> device_node_overlay_removal() is my way to see if the link "is marked in =
a
> special way" as you put it. This checks if one of the supplier/consumer i=
s
> marked as an OVERLAY and if it's being removed (I think that OF_DETACHED =
tells
> us that but some feedback from DT guys will be helpful).
>
> Alternatively, I could just check the OF_OVERLAY flag when the link is be=
ing
> created and have a new variable in struct device_link to flag the synchro=
nous
> release. Disadvantage is that in this way even a sysfs unbind or module u=
nload
> (without necessarily removing the overly) would lead to a synchronous rel=
ease
> which can actually make sense (now that I think about it). Because if som=
eone
> does some crazy thing like "echo device > unbind" and then removes the ov=
erlay
> we could still hit the overly removal path before device_link_release_fn(=
)
> completed.

This sounds more complicated than the current patch.

