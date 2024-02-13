Return-Path: <linux-kernel+bounces-63802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434385349F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80091F24E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF25EE62;
	Tue, 13 Feb 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8Dmtv81"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C05DF22;
	Tue, 13 Feb 2024 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838117; cv=none; b=XiCpCy8r+6gMmY56UDW1lediErcK19EKJX5IPTqPcdXzK2hhwLJSsagP8Ho32nKYaNOLpNAXIEKoVxzfAgq0wAgy92dz5ZKohNPmxNbXWEQF+2uhaijsHns7/XOuKOKtT7ufDm6roOk30xcGni7DTGB0lfx2VTM28ldKJDYGvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838117; c=relaxed/simple;
	bh=fXFCmah43C9aMIn+5teU6Cd/edZQCfiYfF89jrIEcqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxRcHIkuX23Lg9FmFn4VWIop22Zb7xaApY4saXnSgZ+1/zmmIugwxc5Epf5cYP3voWK6xoi6Y6vb9qEp3tCDnM8E3UEj5V35GEEdABhYOiVwt6vJR31SlqrtKMatr1SyYquksRTKvkajkq1hGs6BpsShVYZ6hXJM+Gl6cgbnqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8Dmtv81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED22EC433C7;
	Tue, 13 Feb 2024 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838116;
	bh=fXFCmah43C9aMIn+5teU6Cd/edZQCfiYfF89jrIEcqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8Dmtv81ZcP76/zSKrbRvU33+SY/N/PJY4WzV8EW5uVFBNPqsgkJOgPd9bTm96C64
	 qPaAueqNdetNygWN4sruZd9Z8lbXrIVCSK+wNzfaX0Z+ngt2bGEtAPGbreSHdSm804
	 xTXtCB/1xKGcbw44vNsmR0VYXQOYZ2unnqxZiEakTev2dgKjjssnP3TvVNisiut/xM
	 dLBcLI5FqYhtlOX/BiC1wrNuKyYakSfRTkFuQJBj6ZkeRULfI+5JXoab5kRDamm8X8
	 WwSKGh1vh7owfMC9O3Wq+DAGPr1vuaJAeMaBGtmhn+ew3l1b05CZNuleQ6ykCqWchS
	 CD4Y5yvrAu8OQ==
Date: Tue, 13 Feb 2024 15:28:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dhruva Gole <d-gole@ti.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Message-ID: <69f023bb-2844-496f-9f3f-4e2e80129d33@sirena.org.uk>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MMftTTIZEnYjxm6P"
Content-Disposition: inline
In-Reply-To: <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
X-Cookie: Does not include installation.


--MMftTTIZEnYjxm6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:39:02PM +0000, Tudor Ambarus wrote:
> On 2/9/24 13:51, Th=E9o Lebrun wrote:

> > +		if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP) {
> > +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> > +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> > +

> Would be good to be able to opt out the statistics if one wants it.

> SPI NORs can write with a single write op maximum page_size bytes, which
> is typically 256 bytes. And since there are SPI NORs that can run at 400
> MHz, I guess some performance penalty shouldn't be excluded.

If we can cope with this sort of statistics collection in the networking
fast path we can probably cope with it for SPI too, the immediate
recording is all per CPU so I'd like to see some numbers showing that
it's a problem before worrying about it too much.  Even the people doing
things like saturating CAN buses haven't been raising it as a concern
for the regular SPI data path.  We could add a Kconfig if it's an issue.

--MMftTTIZEnYjxm6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLip8ACgkQJNaLcl1U
h9CTjQf/axznzzZjRR5HlbP310cOtEp7gWYv/5Py4bHDmJOsfZSb/gXBo/joMaRC
+HlD1aUoSw6g6DTwj6u5pD+8hNqmVOeUoM7Wy8b/xbDMAjZAfxM7W+AbtX+WiO0C
UyVGLSvUe4tTDiUJg6xhWQEFG6E8cZl7Sd3/LCcfl7Dy8XM+fQglFdhpnAka5Zqb
N6yB5zHdXBsEbAvUEUdwplckFjqecpAKTXSMyy5PlT7sdcgh8SfNszR0w58d6h2d
HkgYUQxmn0Q9tEZw569UhoR7i/9y/i+nUVTk51A0Byhh6pB58oQXTLwhm5Q2XABQ
vwKjnlRwwfk1sWk5jOz0eG0OiWnhog==
=kMnE
-----END PGP SIGNATURE-----

--MMftTTIZEnYjxm6P--

