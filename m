Return-Path: <linux-kernel+bounces-97161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81E876646
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEE287055
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412854503D;
	Fri,  8 Mar 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDDIxB+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586A4085D;
	Fri,  8 Mar 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907671; cv=none; b=TUHtYI3KYC7j8tIOkV/QDqmPObdU9Jgf54B4zzHnCFFIYwn+PY5qV1SaCjmf+9aNQVuROKua4PZXC5Y+zc6cnWfstRYp8ZvLQc+OoycdpUxIWr8NJUpxbuh2IG7RhF6fvQFb6K343IXXIm0IaQtnZkQWowxB317u3da5ggcatr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907671; c=relaxed/simple;
	bh=nfuiBwqmn6mGxy6Z9xV6RXzPpifQCqpWBpsuAYw3zeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2YEEX21hUOy7XT0y78xZZslgHtBama8Dt0Wxn3ECDkDGFUVpSn+Y3M8gczMpAb058eY6BHBXwNYM7+MSOuAPkdx2aThbJYn99GtUnqU2rsiaKLIrlZX7/aPoGbZEDINcS0k05rbTHmKc5oCTsmkW8oIGjjcDB1U7vKO4evZJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDDIxB+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E46C433F1;
	Fri,  8 Mar 2024 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709907670;
	bh=nfuiBwqmn6mGxy6Z9xV6RXzPpifQCqpWBpsuAYw3zeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDDIxB+9X+b4mxMok5F4KDupMwgZkuQxRJAFJ53R/PYyH0dgxjD2W5nksl6YJRWkj
	 0S6e0DJHJnS3Yyq4IL5WhEvTUqVmKFIZn7W8B4zdvBnN63PQH8b4T4PuXMI8sLdkZb
	 ZVIj5dj2qy9uWtLt/BeEyKYArKVs8YcNTA+zC4GDqds2/gpxNhOuHkG5ekK+B+1Gx3
	 ypAZ0NdaNgHpEUat33JAN2L7MlEa543TNGuSoeYzQbaYoYeBSE3ZlO1O+SovIx0yQd
	 xKoWFEk379v5hsoijMAoUa6TWovnuNiZHcAbrhDa0MSPG+uFTkwI7fL0KMynFGXvnS
	 8x2cQSpRYJQEw==
Date: Fri, 8 Mar 2024 14:21:05 +0000
From: Mark Brown <broonie@kernel.org>
To: xuhanwu <2433926602@qq.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	xu.hanwu@zxelec.com
Subject: Re: [PATCH] ASoC: soc-pcm: add the judgment of unsupported commands
 for the function soc_pcm_trigger
Message-ID: <c78e86fe-5d0f-49dc-82f8-0e106618800a@sirena.org.uk>
References: <tencent_002E3C6C67928986481018466EEDF8D05706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CO6rGfmqIi+VPQbx"
Content-Disposition: inline
In-Reply-To: <tencent_002E3C6C67928986481018466EEDF8D05706@qq.com>
X-Cookie: Isn't this my STOP?!


--CO6rGfmqIi+VPQbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2024 at 06:07:06PM +0800, xuhanwu wrote:

> Function soc_pcm_trigger, if the parameter cmd does not support the need to return an error (-EINVAL).

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> @@ -1173,6 +1173,9 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  			if (r < 0)
>  				break;
>  		}
> +		break;
> +	default:
> +		return -EINVAL;
>  	}

As can be seen from inspection of the immediately preceeding handling
of start, we're deliberately ignoring half the values in each switch.

--CO6rGfmqIi+VPQbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXrHtAACgkQJNaLcl1U
h9Buggf9Er3lQ+YUmjX3FWMP79cpAvBoNUrZrY7dLRxkY1es5FVy6xz0w5lUTkzh
4NYhi8DlZs4WzV8Ojl8NaclX45m7OIGEZ9+vUQuD1Ut5kUJPyhYW4VU77ilKccP/
G9S41rpKOIA4Yqr6Nk7xRPL8sVxGEIBBkl61Bdayqj0EQLJ1lQ6GQvfZEzRiAii1
WpFR2RvWuGYKVVf8+7jTLRoFlWlzcZMuW57mO3l1R4ubKc/QWEh58sHN6YGt/pal
MKBwCocq36mCnOYGPaELkRe9EOmFw1dMZgrbSNFR4lkZZ9PL7aaIr/D2KpVnauj8
n9NAS/ReBkoqer8CfaIQcO8WFxZEjQ==
=Uh3/
-----END PGP SIGNATURE-----

--CO6rGfmqIi+VPQbx--

