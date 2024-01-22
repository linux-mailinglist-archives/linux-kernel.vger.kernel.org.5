Return-Path: <linux-kernel+bounces-32574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DE2835D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA997286806
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D538F9C;
	Mon, 22 Jan 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ5e7zTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD63717F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913716; cv=none; b=qKdg0Doyoid6K2wGdbGyPEV6Yb5p7p7jckLDx3pLPJwhhpA56r+yqmcEn1rGoL0m22JH0TZRrj1P+7hY/m+fJYiXdN8YA4lrjpl1qnP3bLaEOahx1/T8/j6G0sGI7vxnABGXaNbEWr59K6tUFI0rHRJZNzkeX9Y83wB4BS0nV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913716; c=relaxed/simple;
	bh=RbUr3CBB8JAWdnVgirl7B1Rad7j/N8G1Y0BLkXdKk6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRIndQVIo0B8+LCJGg0mung4wxKW34sH3U52G50bLkFj7ARHLqBIgS5FbhPr9k2BIg/V54LQHyk78DzdYvTGOmyLrBxJau1DMInjjVw0gUpq9AAHma2jKbhg+3iPC1M7BoGvyN3l9ZN5xX0aBHEucpTJQmWDeGl9xG3W9DcFhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ5e7zTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51193C433F1;
	Mon, 22 Jan 2024 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705913715;
	bh=RbUr3CBB8JAWdnVgirl7B1Rad7j/N8G1Y0BLkXdKk6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZ5e7zTK6udMaSZDG2BEngv+O8fjiipXH0Qn102yD+6LGOGjOS92X/Dr6/HrdBTya
	 0mkECPSMXCfTHpplBmsYGL0E4/juPEshQMWfNPOVZTJFYLy++IEUQspzPXQadPKxRo
	 I5w+1ko7wiX8t2dwTGNvFx7UUfKi9YiVxvBpn1FncMW+nTwvubRdqUySqWrcIPZUEK
	 f63ZIiJD9XJwUMm+Tv5mNIZkF2Byb4olycNhSy5DQ8qd8bISn/7cOVfz1AWRD+o6gW
	 ysHIWH5LrrfEx1WGVU4BYD0Q3ifrSyEFV4oHGg8KD3A5eoDhQ+ebiUEdnIEEMRECCx
	 VP7tGZIXCp89g==
Date: Mon, 22 Jan 2024 08:55:11 +0000
From: Conor Dooley <conor@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	conor.dooley@microchip.com, robh@kernel.org, sudeep.holla@arm.com,
	pierre.gondois@arm.com, suagrfillet@gmail.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: cacheinfo: add init_cache_level()
Message-ID: <20240122-jawline-handling-e190c90ddcfc@spud>
References: <20240122013510.55788-1-cuiyunhui@bytedance.com>
 <20240122-boxcar-conical-c728a709aa5c@spud>
 <CAEEQ3wmX7_VP-YM9NkesAhd+5zetw79AW9bo0YO7KGAeJX4eRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nIAUbLZo0rcUTOrB"
Content-Disposition: inline
In-Reply-To: <CAEEQ3wmX7_VP-YM9NkesAhd+5zetw79AW9bo0YO7KGAeJX4eRQ@mail.gmail.com>


--nIAUbLZo0rcUTOrB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 04:32:15PM +0800, yunhui cui wrote:
> Hi Conor,
>=20
> On Mon, Jan 22, 2024 at 4:09=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Jan 22, 2024 at 09:35:10AM +0800, Yunhui Cui wrote:
> > > When cacheinfo_sysfs_init() is executed, the general weak function
> > > init_cache_level() returns -ENOENT, causing failure to add the "cache"
> > > node to /sys/devices/system/cpu/cpux/. Implement the init_cache_level=
()
> > > function on RISC-V to fix it.
> >
> > If you recall correctly, I asked you to explain how to reproduce this
> > when you sent the patch.
>=20
> In fact, the reason has been explained in the commit log. As for how
> to reproduce it, you can check whether there is a "cache" node in
> /sys/devices/system/cpu/cpux/ on the riscv platform.

That's the thing - I tried to reproduce this several times and either:
a) The system had cache information in DT and the directory was
   created. If I hot unplugged and re-plugged the directory was
   re-created.
b) The system had no cache information in DT and the directory was never
   created.

You said in your original report that you came across this problem in
qemu - can you share the qemu command required to reproduce please?

Thanks,
Conor.

--nIAUbLZo0rcUTOrB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa4tbgAKCRB4tDGHoIJi
0qEhAQDf5GOioL30XSblHzIsxeUnJiWtW0IHNKk1vqhH6mJ/LgEA/5Zh6G4uESUe
I4oY4M92ei01+uox27pgiVLu4CQ6FQU=
=x05X
-----END PGP SIGNATURE-----

--nIAUbLZo0rcUTOrB--

