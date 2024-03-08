Return-Path: <linux-kernel+bounces-97218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070FA876720
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292551C217E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3571DDEC;
	Fri,  8 Mar 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LKu7UM+b"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE931D558
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910920; cv=none; b=tADEJ32vrYiX3ol+lCET0GfyVTjYNdBNz34Sh/c5Gnp2D12Bw/Co16+UFxLQjey+ZqRFNuifjNapZSfLqKRRaQ58vaDNpBIzgvZ5H96HwOJCk20For+LJpiBhAAcCRVHLB0XPQfJYUEdP0KT/wvtqnQfosNZyf/7gCt3wnY7fxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910920; c=relaxed/simple;
	bh=rJzYSeO0H4v56T2ViP7YycjjefILvdxT+aXh7NvK4nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIUhjLcLr4HBHRUzUh/jt81g3+JRDs0NUWRJBFLyB3/jM+rkhRRn0+x6v1vnnpfWad/B850brzaqlF2XgfYM/2RqnCYc9s0qfdtvJb8pRvLodA8hDUeAAuAEm4maVApicvhpAwAzxkMJcy+9AHyepecKqbkCoQaI2R6tSaH1+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LKu7UM+b; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709910917;
	bh=rJzYSeO0H4v56T2ViP7YycjjefILvdxT+aXh7NvK4nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LKu7UM+bb/Gu7eYxmvTIwgpjMqUMGT/0M7KixOm1Oi0/XLcX74YUmmYrxnuUdDaxM
	 IHBEBfqfTnWVF/bkFAhrB9Zdh1RyzIhxr7wwOyw3ygJw0lGJrmsubp73i9qTi+MBXE
	 /wHv86WS7L+q1ND66rMWY1gcqgut6ZjluLCT1J+YjbYaAcWZpSBVblDzoekcJH2uSt
	 TTsja37AkbIZQKhhON1qky2uZ3tF1XMhQcLaNaovAslLVbqztHroX9YtrJM0+GJTGx
	 CMMbwxr0e5ntf1cGZ9Fuii+vqCGcGmd8b5BJ+QjtX07FLCLQeRq4GNL2uIO3i7PiHy
	 VbT51AtWXvkCQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 78FE137820F2;
	Fri,  8 Mar 2024 15:15:16 +0000 (UTC)
Date: Fri, 8 Mar 2024 16:15:15 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Steven
 Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mihail
 Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH] drm/panthor: Add support for performance counters
Message-ID: <20240308161515.1d74fd55@collabora.com>
In-Reply-To: <ZesYErFVdqLyjblW@e110455-lin.cambridge.arm.com>
References: <20240305165820.585245-1-adrian.larumbe@collabora.com>
	<ZesYErFVdqLyjblW@e110455-lin.cambridge.arm.com>
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

On Fri, 8 Mar 2024 13:52:18 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> Hi Adri=C3=A1n,
>=20
> Thanks for the patch and appologies for taking a bit longer to respond,
> I was trying to gather some internal Arm feedback before replying.
>=20
> On Tue, Mar 05, 2024 at 04:58:16PM +0000, Adri=C3=A1n Larumbe wrote:
> > This brings in support for Panthor's HW performance counters and queryi=
ng
> > them from UM through a specific ioctl(). The code is inspired by existi=
ng
> > functionality for the Panfrost driver, with some noteworthy differences:
> >=20
> >  - Sample size is now reported by the firmware rather than having to re=
ckon
> >  it by hand
> >  - Counter samples are chained in a ring buffer that can be accessed
> >  concurrently, but only from threads within a single context (this is
> >  because of a HW limitation).
> >  - List of enabled counters must be explicitly told from UM
> >  - Rather than allocating the BO that will contain the perfcounter valu=
es
> >  in the render context's address space, the samples ring buffer is mapp=
ed
> >  onto the MCU's VM.
> >  - If more than one thread within the same context tries to dump a samp=
le,
> >  then the kernel will copy the same frame to every single thread that w=
as
> >  able to join the dump queue right before the FW finished processing the
> >  sample request.
> >  - UM must provide a BO handle for retrieval of perfcnt values rather
> >  than passing a user virtual address.
> >=20
> > The reason multicontext access to the driver's perfcnt ioctl interface
> > isn't tolerated is because toggling a different set of counters than the
> > current one implies a counter reset, which also messes up with the ring
> > buffer's extraction and insertion pointers. This is an unfortunate
> > hardware limitation. =20
>=20
> There are a few issues that we would like to improve with this patch.
>=20
> I'm not sure what user space app has been used for testing this (I'm gues=
sing
> gputop from igt?) but whatever is used it needs to understand the counters
> being exposed.

We are using perfetto to expose perfcounters.

> In your patch there is no information given to the user space
> about the layout of the counters and / or their order. Where is this being
> planned to be defined?

That's done on purpose. We want to keep the kernel side as dumb as
possible so we don't have to maintain a perfcounter database there. All
the kernel needs to know is how much data it should transfer pass to
userspace, and that's pretty much it.

> Long term, I think it would be good to have details
> about the counters available.

The perfcounter definitions are currently declared in mesa (see the G57
perfcounter definitions for instance [1]). Mesa also contains a perfetto
datasource for Panfrost [2].

>=20
> The other issue we can see is with the perfcnt_process_sample() and its
> handling of threshold event and overflows. If the userspace doesn't sample
> quick enough and we cross the threshold we are going to lose samples and
> there is no mechanism to communicate to user space that the values they
> are getting have gaps. I believe the default mode for the firmware is to
> give you counter values relative to the last read value, so if you drop
> samples you're not going to make any sense of the data.

If we get relative values, that's indeed a problem. I thought we were
getting absolute values though, in which case, if you miss two 32-bit
wraparounds, either your sampling rate is very slow, or events occur at
a high rate.

>=20
> The third topic that is worth discussing is the runtime PM. Currently your
> patch will increment the runtime PM usage count when the performance
> counter dump is enabled, which means you will not be able to instrument
> your power saving modes. It might not be a concern for the current users
> of the driver, but it is worth discussing how to enable that workflow
> for future.

I guess we could add a flags field to drm_panthor_perfcnt_config and
declare a DRM_PANTHOR_PERFCNT_CFG_ALLOW_GPU_SUSPEND flag to support this
use case.

[1]https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/panfrost/perf/G=
57.xml?ref_type=3Dheads
[2]https://gitlab.freedesktop.org/mesa/mesa/-/tree/main/src/panfrost/ds?ref=
_type=3Dheads

