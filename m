Return-Path: <linux-kernel+bounces-73889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F200E85CD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215671C21BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5743D65;
	Wed, 21 Feb 2024 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stgraber.org header.i=@stgraber.org header.b="P8DkBKBF"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88E187F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477009; cv=none; b=moG03q2os/h3iuXcVwsoZr0zpg+ZSooM1rqI16GdSki8A5vcRLUOKgiDaiJtcEHkL3s7q5aEsc0ufzO8kQjK9NNrVmYFF1cO7zPCw6677TUK78/SLqbcuyZceduQemXXfTF2TafGqwYyFKPrS/xlf6uYPNS1tOFnCXml1Id4bF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477009; c=relaxed/simple;
	bh=xeYAZhOW246IBIGqdUQblLQC3/2gYmweYH1S59YwQTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgYW8PXDoBj1za8WkKdwQWV0SK0mj+RbBNdYqwRXA5//VFa/Hz36LTdldQqdGCyDv5D9cjD8XpXBHkGsbLi/5e5LUtgLapctPnnUfFeVBAoVpT/rNG78ibGkUKwpg08DYjLemtlrPK7kumjaVUZcRnlEjfHogw6e4mWLOu9ewFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stgraber.org; spf=pass smtp.mailfrom=stgraber.org; dkim=pass (1024-bit key) header.d=stgraber.org header.i=@stgraber.org header.b=P8DkBKBF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stgraber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgraber.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so168296a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stgraber.org; s=google; t=1708477004; x=1709081804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX8VQ2yvY5jm64ixEzxpA7zZ8qItizLMyqCEU0sfjTg=;
        b=P8DkBKBFRCKCy4Nmr3CCgDwsVe6F7hTEGJ7HTrzyoOWbL5CscOafCJQMkpJw64omfS
         Yp5cVJmb1fe+22ZMeZBUDv15a3Ca1sGX7PjgiS+9mQ6uRmuXlBQ8M8Lia0aC7GDehB6l
         j9a3KNm/1oHZUFrRCKRbfwquMcHpl1Yu+Rkkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708477004; x=1709081804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX8VQ2yvY5jm64ixEzxpA7zZ8qItizLMyqCEU0sfjTg=;
        b=geaiEzWUsMPlLq+/78lOv2AtLzWf/1Uf7K2fBwCaIeD4a/W/GGJV0zQLgGSBCCMdwg
         VwtNxrmSr/1jywubAeUk6bFOsCHh51+9COl18J0LbKlGYZQ2trvGyDFGbuq7ebrWY2DL
         lfN+E1OqPXnxilfe/lf3HaGWxlY6spsuGBMpJm2jT2yv5lb64LXnDOAcxsK727jd+SRj
         Es7ou9dXLLfMmD3ADUI0sNWgbi+S7P2gB937U75ZX6kEkQqqdZz4UO62FgpGg4X2UVQc
         XUzPoVuyk2OZ73NXN2svY7lmRIFlefmEo8Zrr1mgZljjV0AzH5HmVjCyja5YQgWE9ZNq
         RO6A==
X-Forwarded-Encrypted: i=1; AJvYcCW8/TXPWqLdAoM5UnVSyi4I9wLomMxIq8vJTCVUs4/+2GPRpPBtgHhk9lIXqpjksrjUoFtWZlx2K4MvJ8LDWFSI2azVvjZBROjOZ9pL
X-Gm-Message-State: AOJu0Ywk+TaVxumqfL4uK5BYIJSKnMaww/KECb+hrDWLx1MrN/DkZZWB
	OD4uAE0wriBzJSwhUKOerfzieFJv1M4xoUvUPOTDpSMsw1Gh0QsWAec6oyNaBiOCgJvdCOTc74M
	Y0hghL0wx+m1YFIUMT6MmehAOji8HE7Ysa8etQA==
X-Google-Smtp-Source: AGHT+IGNEHl2vLI6LTMxJTetkYWKN/yoUEQ198Nf9O47mLo67mdF+gSNouHECTnwXCvmw42wPe5T3P69ixNrLj0Jqoo=
X-Received: by 2002:aa7:dac3:0:b0:564:d715:1d67 with SMTP id
 x3-20020aa7dac3000000b00564d7151d67mr1838058eds.17.1708477003595; Tue, 20 Feb
 2024 16:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com> <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
In-Reply-To: <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
From: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
Date: Tue, 20 Feb 2024 19:56:32 -0500
Message-ID: <CA+enf=tZx9U8P13jC0z0s4Nt6oJduXRGr3_tUOZvjrkt82n3eg@mail.gmail.com>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	Christian Brauner <christian@brauner.io>, 
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey there,

Sorry, I don't have the time to go through all the details in this
post to provide an adequate response, I'm adding Aleksandr who may be
able to provide more details on what we've been up to (what James
alluded to).

Our proposal is effectively bumping the in-kernel kuid_t/kgid_t from
uint32 to uint64, which allows for individual user namespaces to get a
full usable uint32 uid/gid range in the kernel. Obviously any kind of
data persistence needs some mapping (VFS idmap) and there are a bunch
of other corner cases as to how this is all exposed to userspace.

The idea around this stuff started back at Plumbers / Kernel summit
all the way back in 2019 with a bit of refinement on the idea on and
off ever since.
We now have a functional patchset and example userspace code at:
 - https://github.com/mihalicyn/isolated-userns
 - https://github.com/mihalicyn/linux/commits/isolated_userns

If you don't mind watching a video, we have a reasonably detailed talk
on the topic as well as demo and useful audience questions and
feedback from FOSDEM here: https://www.youtube.com/watch?v=3DmOLzSzpVwHU

After talking about this with folks at a number of LPC / kernel summit
/ FOSDEM by this point, our next step is going to be an RFC patchset,
I think at this point we just want the cgroupfs issue sorted out
before sending that out.

I'll try to set some time to go through your full e-mail later this
week if Alex doesn't get to it first!

St=C3=A9phane

On Tue, Feb 20, 2024 at 7:26=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Feb 19, 2024 at 09:26:25AM -0500, James Bottomley wrote:
> > On Sat, 2024-02-17 at 15:56 -0500, Kent Overstreet wrote:
> > > AKA - integer identifiers considered harmful
> > >
> > > Any time you've got a namespace that's just integers, if you ever end
> > > up needing to subdivide it you're going to have a bad time.
> > >
> > > This comes up all over the place - for another example, consider
> > > ioctl numbering, where keeping them organized and collision free is a
> > > major headache.
> > >
> > > For UIDs, we need to be able to subdivide the UID namespace for e.g.
> > > containers and mounting filesystems as an unprivileged user - but
> > > since we just have an integer identifier, this requires complicated
> > > remapping and updating and maintaining a global table.
> > >
> > > Subdividing a UID to create new permissions domains should be a
> > > cheap, easy operation, and it's not.
> > >
> > > The solution (originally from plan9, of course) is - UIDs shouldn't
> > > be numbers, they should be strings; and additionally, the strings
> > > should be paths.
> > >
> > > Then, if 'alice' is a user, 'alice.foo' and 'alice.bar' would be
> > > subusers, created by alice without any privileged operations or
> > > mucking with outside system state, and 'alice' would be superuser
> > > w.r.t. 'alice.foo' and 'alice.bar'.
> > >
> > > What's this get us?
> >
> > I would have to say that changing kuid for a string doesn't really buy
> > us anything except a load of complexity for no very real gain.
> > However, since the current kuid is u32 and exposed uid is u16 and there
> > is already a proposal to make use of this somewhat in the way you
> > envision,
>
> Got a link to that proposal?
>
> > there might be a possibility to re-express kuid as an array
> > of u16s without much disruption.  Each adjacent pair could represent
> > the owner at the top and the userns assigned uid underneath.  That
> > would neatly solve the nesting problem the current upper 16 bits
> > proposal has.
>
> At a high level, there's no real difference between a variable length
> integer, or a variable length array of integers, or a string.
>
> But there's real advantages to getting rid of the string <-> integer
> identifier mapping and plumbing strings all the way through:
>
>  - creating a new sub-user can be done with nothing more than the new
>    username version of setuid(); IOW, we can start a new named subuser
>    for e.g. firefox without mucking with _any_ system state or tables
>
>  - sharing filesystems between machines is always a pita because
>    usernames might be the same but uids never are - let's kill that off,
>    please
>
> Doing anything as big as an array of integers is going to be a major
> compatibiltiy break anyways, so we might as well do it right.
>
> Either way we're going to need a mapping to 16 bit uids for
> compatibility; doing this right gives userspace an incentive to get
> _off_ that compatibility layer so we're not dealing with that impedence
> mismatch forever.
>
> > However, neither proposal would get us out of the problem of mount
> > mapping because we'd have to keep the filesystem permission check on
> > the owning uid unless told otherwise.
>
> Not sure I follow?
>
> We're always going to need mount mapping, but if the mount mapping is
> just "usernames here get mapped to this subtree of the system username
> namespace", then that potentially simplifies things quite a bit - the
> mount mapping is no longer a _table_.
>
> And it wouldn't have to be administrator assigned. Some administrator
> assignment might be required for the username <-> 16 bit uid mapping,
> but if those mappings are ephemeral (i.e. if we get filesystems
> persistently storing usernames, which is easy enough with xattrs) then
> that just becomes "reserve x range of the 16 bit uid space for ephemeral
> translations".



--=20
St=C3=A9phane

