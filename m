Return-Path: <linux-kernel+bounces-42769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B450484066E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B612C1C24399
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20C629EE;
	Mon, 29 Jan 2024 13:13:02 +0000 (UTC)
Received: from lynxeye.de (ns.lynxeye.de [87.118.118.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77264CE2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.118.118.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533981; cv=none; b=WsRi/uTREszhq0yQ9OHde9L+DN9y5KI512UrKEqyIL3803/PK2X14ZwmvKSw9wBiawkYUPxdkobMNyvH8DagUXDUxupbqebKBC1hd3AVmORwDreL02SHOsNngAs9gkqaSsMXKjfURa2gvYBTADmEj/omtSdcwydQfpPFa8Olu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533981; c=relaxed/simple;
	bh=EFeyZNe55OkGXa/T1yJqXJ+LwYv80+YyvZ1pwixNL8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5stKfa1/IqpHB7YyCzOxDyMHp+VtVjUiC/zA/DgiiRaLnDF7gNjbwCOdEtwqxh3lzQgI/JzDs0AOxYQp3oUlKdRaQb702pB5jH4yUc+lLRgCcqRKTzfdSvUWnGTZVK9n2mgzzh/nojC2HoaaZsIZA/PzKM6nGuXxYFbo1Zai/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de; spf=none smtp.mailfrom=lynxeye.de; arc=none smtp.client-ip=87.118.118.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lynxeye.de
Received: by lynxeye.de (Postfix, from userid 501)
	id 1492CE74016; Mon, 29 Jan 2024 14:12:52 +0100 (CET)
X-Spam-Level: 
Received: from [192.168.178.22] (a89-183-231-132.net-htp.de [89.183.231.132])
	by lynxeye.de (Postfix) with ESMTPSA id 813FDE74012;
	Mon, 29 Jan 2024 14:12:50 +0100 (CET)
Message-ID: <8b56a3fa53435d7ad634d87b98bbebe80df337ef.camel@lynxeye.de>
Subject: Re: Re: Uncached buffers from CMA DMA heap on some Arm devices?
From: Lucas Stach <dev@lynxeye.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Maxime Ripard
	 <mripard@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
  Milan Zamazal <mzamazal@redhat.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andrey Konovalov <andrey.konovalov.ynk@gmail.com>, 
 kieran.bingham@ideasonboard.com, Hans de Goede <hdegoede@redhat.com>
Date: Mon, 29 Jan 2024 14:12:50 +0100
In-Reply-To: <20240129120723.GB8131@pendragon.ideasonboard.com>
References: <87bk9ahex7.fsf@redhat.com>
	 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
	 <Zbd8lOgVqfCrGUL7@duo.ucw.cz>
	 <xd5ofun26gfdgn7hig3gipj5rgojqyuouwmii7xecgrbzyliil@y6rufxtwdmrc>
	 <20240129120723.GB8131@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Montag, dem 29.01.2024 um 14:07 +0200 schrieb Laurent Pinchart:
> On Mon, Jan 29, 2024 at 11:32:08AM +0100, Maxime Ripard wrote:
> > On Mon, Jan 29, 2024 at 11:23:16AM +0100, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > That's right and a reality you have to deal with on those small ARM
> > > > systems. The ARM architecture allows for systems that don't enforce
> > > > hardware coherency across the whole SoC and many of the small/cheap=
 SoC
> > > > variants make use of this architectural feature.
> > > >=20
> > > > What this means is that the CPU caches aren't coherent when it come=
s to
> > > > DMA from other masters like the video capture units. There are two =
ways
> > > > to enforce DMA coherency on such systems:
> > > > 1. map the DMA buffers uncached on the CPU
> > > > 2. require explicit cache maintenance when touching DMA buffers wit=
h
> > > > the CPU
> > > >=20
> > > > Option 1 is what you see is happening in your setup, as it is simpl=
e,
> > > > straight-forward and doesn't require any synchronization points.
> > >=20
> > > Yeah, and it also does not work :-).
> > >=20
> > > Userspace gets the buffers, and it is not really equipped to work wit=
h
> > > them. For example, on pinephone, memcpy() crashes on uncached
> > > memory. I'm pretty sure user could have some kind of kernel-crashing
> > > fun if he passed the uncached memory to futex or something similar.
> >=20
> > Uncached buffers are ubiquitous on arm/arm64 so there must be something
> > else going on. And there's nothing to equip for, it's just a memory
> > array you can access in any way you want (but very slowly).
> >=20
> > How does it not work?
>=20
> I agree, this should just work (albeit possibly slowly). A crash is a
> sign something needs to be fixed.
>=20
Optimized memcpy implementations might use unligned access at the edges
of the copy regions, which will in fact not work with uncached memory,
as hardware unaligned access support on ARM(64) requires the bufferable
memory attribute, so you might see aborts in this case.

write-combined mappings are bufferable and thus don't exhibit this
issue.

> > > > Option 2 could be implemented by allocating cached DMA buffers in t=
he
> > > > V4L2 device and then executing the necessary cache synchronization =
in
> > > > qbuf/dqbuf when ownership of the DMA buffer changes between CPU and=
 DMA
> > > > master. However this isn't guaranteed to be any faster, as the cach=
e
> > > > synchronization itself is a pretty heavy-weight operation when you =
are
> > > > dealing with buffer that are potentially multi-megabytes in size.
> > >=20
> > > Yes, cache synchronization can be slow, but IIRC it was on order of
> > > milisecond in the worst case.. and copying megayte images is still
> > > slower than that.
>=20
> Those numbers are platform-specific, you can't assume this to be true
> everywhere.
>=20
Last time I looked at this was on a pretty old platform (Cortex-A9).
There the TLB walks caused by the cache maintenance by virtual address
was causing severe slowdowns, to the point where actually copying the
data performs similar to the cache maintenance within noise margins,
with the significant difference that copying actually causes the data
to be cache hot for the following operations.

Regards,
Lucas

