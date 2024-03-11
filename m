Return-Path: <linux-kernel+bounces-98663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B2877D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274F41F21EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84A2232A;
	Mon, 11 Mar 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ypRrGTdu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B7846F;
	Mon, 11 Mar 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151364; cv=none; b=L+UNB/UCnLyR7x9EX0kIQaFM6s2ZbTHRqBU/IHHUY94dxIuJNpMJCWd988iWGlaM035gMqidHfKY9dITkUPll+lwc7HWXYdCKNRkPC1RASv7eiwSXQsn1CXzrmfE5+NZSlgFmsVub07PTKdOAoXsloC6PI0jEJf/ISGE6yWQNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151364; c=relaxed/simple;
	bh=Socx3OmMLBtgHrQ/ZyhaEqEqMB7cMWVDA6gC3HFPDKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlmrKZpShIm1gvzmsFAuLwbBFmxZ0+i4qRaB62CNJjSDTvYg3KH1xI8aSG72qWX0LywGyyP+E0/uSIFJgJdKTkNIS6n8dWDLvfM20HJSEGdhX+8mTCPPSUke2MK0H0bN9NKo7K+oZ1cgmg8YSuJ0eU9QAAG31fCliunP13dcwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ypRrGTdu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710151361;
	bh=Socx3OmMLBtgHrQ/ZyhaEqEqMB7cMWVDA6gC3HFPDKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ypRrGTdumQJoXpsy+P8xrogE2RGVYY3t/4rH48LFzV2ywd5Jek8CvNa0lPHm7uoso
	 DG4d/XcqaGzhRAiV9sq/hbxVEy3209rNW+ExJWlQ3MNfSYpbJzCHln0sb7ac9Cm1db
	 ySmdTVcQhtvOwtoBVm/TfhqSYOT8/MfruEE9qzT1mEmfSULFsCMY0R9QHVi7XqtIhy
	 p8DUQ3ezADCDS14C7AY0NqsdtoIOE2XWyAlLLkzrx21r4CLM31IiOSVKLxZzuDmEye
	 wNnaukIP/KVlKY6gqOlpHx8xm29vN9uXQLQZ4XFB4vSkexRb4oDdrCbbj17yZrsdKG
	 +aFtbZvwEUMwg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CDB937811D4;
	Mon, 11 Mar 2024 10:02:40 +0000 (UTC)
Date: Mon, 11 Mar 2024 11:02:38 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 robh@kernel.org, steven.price@arm.com, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 corbet@lwn.net, kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm/panfrost: Replace fdinfo's profiling debugfs
 knob with sysfs
Message-ID: <20240311110238.1082a1f6@collabora.com>
In-Reply-To: <0db9babe-da95-48e2-b577-3e92a81f8303@ursulin.net>
References: <20240306015819.822128-1-adrian.larumbe@collabora.com>
	<20240306015819.822128-2-adrian.larumbe@collabora.com>
	<0db9babe-da95-48e2-b577-3e92a81f8303@ursulin.net>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 08:33:47 +0000
Tvrtko Ursulin <tursulin@ursulin.net> wrote:

> On 06/03/2024 01:56, Adri=C3=A1n Larumbe wrote:
> > Debugfs isn't always available in production builds that try to squeeze
> > every single byte out of the kernel image, but we still need a way to
> > toggle the timestamp and cycle counter registers so that jobs can be
> > profiled for fdinfo's drm engine and cycle calculations.
> >=20
> > Drop the debugfs knob and replace it with a sysfs file that accomplishes
> > the same functionality, and document its ABI in a separate file.
> >=20
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > ---
> >   .../testing/sysfs-driver-panfrost-profiling   | 10 +++++
> >   Documentation/gpu/panfrost.rst                |  9 ++++
> >   drivers/gpu/drm/panfrost/Makefile             |  2 -
> >   drivers/gpu/drm/panfrost/panfrost_debugfs.c   | 21 ----------
> >   drivers/gpu/drm/panfrost/panfrost_debugfs.h   | 14 -------
> >   drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
> >   drivers/gpu/drm/panfrost/panfrost_drv.c       | 41 ++++++++++++++++---
> >   drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
> >   8 files changed, 57 insertions(+), 44 deletions(-)
> >   create mode 100644 Documentation/ABI/testing/sysfs-driver-panfrost-pr=
ofiling
> >   delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
> >   delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-driver-panfrost-profiling =
b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
> > new file mode 100644
> > index 000000000000..1d8bb0978920
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
> > @@ -0,0 +1,10 @@
> > +What:		/sys/bus/platform/drivers/panfrost/.../profiling
> > +Date:		February 2024
> > +KernelVersion:	6.8.0
> > +Contact:	Adrian Larumbe <adrian.larumbe@collabora.com>
> > +Description:
> > +		Get/set drm fdinfo's engine and cycles profiling status.
> > +		Valid values are:
> > +		0: Don't enable fdinfo job profiling sources.
> > +		1: Enable fdinfo job profiling sources, this enables both the GPU's
> > +		   timestamp and cycle counter registers.
> > \ No newline at end of file
> > diff --git a/Documentation/gpu/panfrost.rst b/Documentation/gpu/panfros=
t.rst
> > index b80e41f4b2c5..51ba375fd80d 100644
> > --- a/Documentation/gpu/panfrost.rst
> > +++ b/Documentation/gpu/panfrost.rst
> > @@ -38,3 +38,12 @@ the currently possible format options:
> >  =20
> >   Possible `drm-engine-` key names are: `fragment`, and  `vertex-tiler`.
> >   `drm-curfreq-` values convey the current operating frequency for that=
 engine.
> > +
> > +Users must bear in mind that engine and cycle sampling are disabled by=
 default,
> > +because of power saving concerns. `fdinfo` users and benchmark applica=
tions which
> > +query the fdinfo file must make sure to toggle the job profiling statu=
s of the
> > +driver by writing into the appropriate sysfs node::
> > +
> > +    echo <N> > /sys/bus/platform/drivers/panfrost/[a-f0-9]*.gpu/profil=
ing =20
>=20
> A late thought - how it would work to not output the inactive fdinfo=20
> keys when this knob is not enabled?
>=20
> Generic userspace like gputop already handles that and wouldn't show the=
=20
> stat. Which may be more user friendly than showing stats permanently at=20
> zero. It may be moot once you add the auto-toggle to gputop (or so) but=20
> perhaps worth considering.

I agree with Tvrtko, if the line being printed in fdinfo relies on some
sysfs knob to be valid, we'd rather not print the information in that
case, instead of printing zero.

