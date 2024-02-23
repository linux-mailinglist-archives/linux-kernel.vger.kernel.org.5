Return-Path: <linux-kernel+bounces-78960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3123861B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678711F21ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631241419B3;
	Fri, 23 Feb 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpWDTU88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E24C8C;
	Fri, 23 Feb 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712146; cv=none; b=dTL+YCqmN0WjDLCZv5Vn0W8D6dTNHCG7/bLzHtadV6UFEWRqGgsmMKZyb+yJ3KXqfLvbnPF7NXb5a/ZNv4/T3OL7xES6ln1yTcQbLUDNMhTQlJe+dYqPOwvGyKRiKmruO3hJg4PFRKHmKKb+NcAIy7/PnNvqv+JSVXHWEKfDJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712146; c=relaxed/simple;
	bh=qL3O5yBmHIcp4OFTSD22SaNMNSh4DEFGM7j4NFlupJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwJIVONfkliFak3NZonqLvqOc6jhR40R/ofjYAfhQGKEOUC7KsKog9DNnTC/m4XzX7igJyp+0VfAbMRk/rK283UKwcdJOdh8JcQZbjQLXdXgPQ6dVvg5jrAI0p4ES/scf/fQug8ed2doZzbAZybfh8AYGXiNJGfPxguqj045/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpWDTU88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4013C433F1;
	Fri, 23 Feb 2024 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708712146;
	bh=qL3O5yBmHIcp4OFTSD22SaNMNSh4DEFGM7j4NFlupJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpWDTU88qgW68ykgUBwVe7363w9Mdx7jdvRfZFA1vFH/HEfhuHnoLOxBhpDxNECdP
	 ucWnjM54vIGZtblrWKrVvCIdIxBZoj9f5Q8lGm8D590qDUZuVTxNgDQBaUInxGqNxh
	 L8GcLFhBIxfgkT2GToC8DtPytOS/flph9Zl0PTgf7DX/QRP1RUeI04sOnig/u6iSnR
	 PkzxhH/Jb93Fb51PCiMfhg1e41GUZL1Tdy/BtcOXOM0Qri0CQrRt7ioN0B0ShIHpcq
	 +v39nKbb+ofKmmtoJK0uaodk3hcph339l92DDyhw3eiA3xUBr3Yd9ZmA59kfTrd/OM
	 lsY8/yDLcLKHg==
Date: Fri, 23 Feb 2024 18:15:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 6/6] ASoC: cs-amp-lib: Add KUnit test for calibration
 helpers
Message-ID: <ZdjgzqyrNOysFldQ@finisterre.sirena.org.uk>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
 <20240223153910.2063698-7-rf@opensource.cirrus.com>
 <ZdjMIVYp7Qb/Tt9d@finisterre.sirena.org.uk>
 <956f2b88-8b52-45b3-a27d-fa8e75a02642@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="taWa+zNeeuI9vMOx"
Content-Disposition: inline
In-Reply-To: <956f2b88-8b52-45b3-a27d-fa8e75a02642@opensource.cirrus.com>
X-Cookie: You might have mail.


--taWa+zNeeuI9vMOx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2024 at 05:02:03PM +0000, Richard Fitzgerald wrote:

> Can you skip this patch and take the others (assuming you are happy with
> them) and I'll fixup and resubmit this test later.

The series is already in CI without this patch.

--taWa+zNeeuI9vMOx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXY4MsACgkQJNaLcl1U
h9AlgAf/XjfgmirxL71nShnAv5faVLtI8hjyefwEoWIwfU+iwvUSw1RQaHZtrV+Y
da0wvY1xm5SKIdWaeXkrHzcvuDaOilA6viztm1+anb/Lbgd7py/07HirJAJvxO4x
mgmsW4T8gh8f5chQBlTD6di8aQlnCiB2ZoVHNzxX5CpkjY8iLF3x1uJOHCgCZAPM
wklV2oYIYNrYv65Scq+eLcIKeHf/nn1n9kAQPNSg+ZBxMyJEOnSZp+F7bCPQY79J
eU4MDMbXXo0TFP4GeuVyOlM1ezHFM453e9P0BRIyBDyOOjYsY7AvKpTczu9q1SiG
5jFK7bNwnFPzaYC8B8xxp6ObMoJMrQ==
=vAW4
-----END PGP SIGNATURE-----

--taWa+zNeeuI9vMOx--

