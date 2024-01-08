Return-Path: <linux-kernel+bounces-19326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E5826B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DA31F223FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D013AFB;
	Mon,  8 Jan 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7OS9Q6v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97913ACF;
	Mon,  8 Jan 2024 10:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB47C433C7;
	Mon,  8 Jan 2024 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704708932;
	bh=Kf/qCr4Qci8o35dgE+0WQtM/PNggO9XZmnL3OFyD1p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7OS9Q6vfGOss9TTQ24Jm6unqxb6WgKnOVxwjxO0z2C6gOAuuahgC7asS+zh5KDPs
	 ZYJXs9J1SHAawdLcyUGmByrnTy/yuCUTxRVC9k29jGF98a1UA/s2g1YJythdBgDo5i
	 ezF920k4/H4fxAJtmlGMIo7xCB3mYOz9T298h4NKCYdN7Be25DmPSwHI0ccjxiz5YI
	 +cAtKLbRsYBqB2OeRh/crdACtO/cOBikxUCmhhfTKmqp6THM0PHuhkGd6mg8AFycGq
	 Giwi/GhkL0z/6kJTawsWmk33vcFh4/hhx+t6j6mK/8I28LMffcgAru1wU3YbRy+fr+
	 4YghGB4Y0PLrw==
Date: Mon, 8 Jan 2024 11:15:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, Melissa Wen <melissa.srw@gmail.com>, 
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 7/7] drm/vkms: Create KUnit tests for YUV conversions
Message-ID: <5z66ivuhfrzrnuzt6lwjfm5fuozxlgqsco3qb5rfzyf6mil5ms@2svqtlcncyjj>
References: <20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net>
 <20240105-vkms-yuv-v1-7-34c4cd3455e0@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dpvlnf5scujd26i"
Content-Disposition: inline
In-Reply-To: <20240105-vkms-yuv-v1-7-34c4cd3455e0@riseup.net>


--6dpvlnf5scujd26i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arthur,

On Fri, Jan 05, 2024 at 01:35:08PM -0300, Arthur Grillo wrote:
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index b654b6661a20..11df990a0fa9 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -440,3 +440,7 @@ void *get_pixel_write_function(u32 format)
>  		return NULL;
>  	}
>  }
> +
> +#ifdef CONFIG_DRM_VKMS_KUNIT_TESTS
> +#include "tests/vkms_format_test.c"
> +#endif

I assume this is due to testing a static function?

If so, the preferred way nowadays is to use EXPORT_SYMBOL_IF_KUNIT or
EXPORT_SYMBOL_FOR_TESTS_ONLY if it's DRM/KMS only.

Maxime

--6dpvlnf5scujd26i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZZvLQQAKCRDj7w1vZxhR
xbrTAP40M9aPjegihpQi0Im0Y+t3vvZIDGnzyfpW1jnSv6xx1wD+Ky1UTLcjzx9S
p6LaI6fOs9AqPeduZ4J+cWOl3mJ2PgI=
=ZL3g
-----END PGP SIGNATURE-----

--6dpvlnf5scujd26i--

