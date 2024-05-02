Return-Path: <linux-kernel+bounces-166305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20788B98D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633FD281625
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46458ABC;
	Thu,  2 May 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="aBfG9AzH"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21557333;
	Thu,  2 May 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645793; cv=none; b=dqWHpJHzz3oHzMOA8m96bMFEXpzCw8j1x/m8Ec9f3jQG32dNwSy426bEfVnt5TDkpeXfV0Ht2jnu4LnxyvzDK+SbWh2LpxJTeH5glBAa9uBBtm0ag5qCJBaepqD5Wo9Pg36DkTcmhq2SUyu8pZSE9igLHOYkdjzY8RIL4KG5PZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645793; c=relaxed/simple;
	bh=O+x6zlED+zDMOemCx1e2RcNkUseJEOjblAholmx+D/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvp0X5/1xKqVlFq3drSd4d+UCuXQgc7rCmLpBVIRFMbTuZHtjiTXD4Y31w0bvwsGoWSwQ9zNHxPY0VmUcrenyqPozzuZy3OIWEHZ3Ss/kMa4iNYeDd9IsyMG304jAcQn44bdRbZ3Ys9+4alqv7wiXF1jP8W4i4DdzWY+fpFG3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=aBfG9AzH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PPcqclq5JazTzzPM+WzlgQe+U+YyPREGD6xfGzxYCAg=; t=1714645792; x=1715250592; 
	b=aBfG9AzHudapO//64X1AkPDh+zAuauV8WXkqxFw6QJajcqMlxmXj1NsfJiM4jgMGyv4NKeRCXzQ
	asRC2vusRcSeo2WGs2X1M87fOwbFZiltCKTF/n6X+7zPutdo1U65y/Gx9+BMcFSlzWRXt3YrEBfMa
	ey2F5rFA78hjLZl0EB/ETb4KlsESAJHUU/QsFc/Td0oqQ81eFIAaTOv0WArDi7u8VkVXNzrOnQG5s
	eNYHtGtVIQmVx2ENofhbHPwsQapDgxY81NPdW/8lJJcvZIHLe8sq/3AHkvBSwSNAm1n4eu3Y1DkQ9
	Ll31B0FOWzaOOJPAEo1t+hgUp2HiDq1nL+ew==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2ThE-00000001zK7-1ayC; Thu, 02 May 2024 12:29:48 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2ThE-000000007k2-0fxW; Thu, 02 May 2024 12:29:48 +0200
Message-ID: <b00e0adc72815e465cf32fc5505445cfceeeca84.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@quicinc.com, Rob
 Herring <robh@kernel.org>, Rob Landley <rob@landley.net>
Date: Thu, 02 May 2024 12:29:47 +0200
In-Reply-To: <72ec7831604326e852eb228072b1d817bab829fb.camel@physik.fu-berlin.de>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
	 <72ec7831604326e852eb228072b1d817bab829fb.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Wed, 2024-05-01 at 19:18 +0200, John Paul Adrian Glaubitz wrote:
> Hi Oreoluwa,
>=20
> On Tue, 2024-04-23 at 16:31 -0700, Oreoluwa Babatunde wrote:
> > The unflatten_device_tree() function contains a call to
> > memblock_alloc(). This is a problem because this allocation is done
> > before any of the reserved memory is set aside in paging_init().
> > This means that there is a possibility for memblock to allocate from
> > any of the memory regions that are supposed to be set aside as reserved=
.
> >=20
> > Hence, move the call to paging_init() to be earlier in the init
> > sequence so that the reserved memory regions are set aside before any
> > allocations are done using memblock.
>=20
> I was just about to merge your patch when I ran a git blame on the code i=
n
> arch/sh/kernel/setup.c and noticed the following commit by Rich Felker:
>=20
> commit eb6b6930a70faefe04479a71088cc10366782d9a
> Author: Rich Felker <dalias@libc.org>
> Date:   Mon Jul 31 01:27:50 2017 -0400
>=20
>     sh: fix memory corruption of unflattened device tree
>    =20
>     unflatten_device_tree() makes use of memblock allocation, and
>     therefore must be called before paging_init() migrates the memblock
>     allocation data to the bootmem framework. Otherwise the record of the
>     allocation for the expanded device tree will be lost, and will
>     eventually be clobbered when allocated for another use.
>    =20
>     Signed-off-by: Rich Felker <dalias@libc.org>
>=20
> It looks like that the call to unflatten_device_tree() before paging_init=
()
> is intentional and needed for the device tree to be preserved in memory
> after running paging_init().
>=20
> @Geert: Do you have any comments on this patch?
> @Rob: Could you test this patch on your J2 board and report back?

I'm skipping this patch for v6.10 now for the aforementioned reasons.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

