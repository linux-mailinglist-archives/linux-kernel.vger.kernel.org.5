Return-Path: <linux-kernel+bounces-100755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5199E879CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756D71C218EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3714290A;
	Tue, 12 Mar 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BuGcgAz/"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6701428F9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274850; cv=none; b=QHSKWKuZ5WF4XftTgVS4DZiwq/EbgIx9zH+iKvjA5tRO8HXdmrk+gQ/XvPjcRu8kxwxJfaRNGWBb5EwlAsn77mRvFgmDbJfpIjxroKz/SJhB1yvcou9pZN8KUBJqiTd8G57v9ZT/v4DskXtmDZsv70fgjEfoMpru3YoJA7RUxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274850; c=relaxed/simple;
	bh=OyWl1cmu7+Um2tcdp43uUqVjRwW6tLs2iGcg+du7MjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3dLEyuXNM2+J0zVuPDB90dIsEOKMp4+evg5yWvvwaKJYcAenZUEtz0jzLkkkQ7TqFIFVZuBwTCBVQaUMWvDxAgczbvfidRww91W/Ek/dZ5yITmYHcf5qMJY+x78wLqwFB6WZsa64ZIvUJpetl7sz0Cutz+Nn+UW1zo/h36y2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BuGcgAz/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7p1Aoph4ZgLWzYWso2TK9JVclNCOZfe1dQUQ/eub1jw=; b=BuGcgAz/hqiodR7GSUqeqGuuK0
	NHMB8BbzeuUKXgv3Efkq3GI2TZQX7L9CsThfPBkKfIvUxkIt2EbacI+5IBk3X1KvhR4pBX8rDIDn3
	lOG0N2FmWeIFnPuYu5TaWq3xA2bn0QAQJT/kRRuyfSRHPqa7TTaXgJWCA+/A9LLjTzClSRHl3BPqc
	QIX5m4JDPBfytGxQN3LynE6Z0666IYuzrahkuYpfJ2wNrv24YDDI0rLbX1IkBUO58+qRusiu79sgn
	L1NejqussGoy0u6jaWtFm4Ibg6QpWmmnXjLeKVRNIhbTr64KgLaCrZQgQoXJfHYjtMPPsOSp4rjQ6
	2ZMdcdOA==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rk8bw-009VmP-OA; Tue, 12 Mar 2024 21:20:33 +0100
Date: Tue, 12 Mar 2024 17:20:20 -0300
From: Melissa Wen <mwen@igalia.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
	Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH 2/7] drm/vkms: Add comments
Message-ID: <m67sdxj6emgtfupt3q3amjatjbscgboamzqxawwoki4j2pdofn@hwq6dijquv6q>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <20240306-louis-vkms-conv-v1-2-5bfe7d129fdd@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-louis-vkms-conv-v1-2-5bfe7d129fdd@riseup.net>

On 03/06, Arthur Grillo wrote:
Hi,

can you describe better the scope of your changes? Limiting the scope
in the commit message and also describing in the body a summary of what
you are documenting and reasons.

Thanks,

Melissa

> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  drivers/gpu/drm/vkms/vkms_formats.c | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 44d9b9b3bdc3..55ed3f598bd7 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -577,6 +577,18 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
>  		},
>  		.y_offset = 0,
>  	};
> +
> +	/*
> +	 * Those matrixies were generated using the colour python framework
> +	 *
> +	 * Below are the function calls used to generate eac matrix, go to
> +	 * https://colour.readthedocs.io/en/develop/generated/colour.matrix_YCbCr.html
> +	 * for more info:
> +	 *
> +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
> +	 *                                  is_legal = False,
> +	 *                                  bits = 8) * 2**32).astype(int)
> +	 */
>  	static struct conversion_matrix yuv_bt601_full = {
>  		.matrix = {
>  			{ 4294967296, 0,           6021544149 },
> @@ -585,6 +597,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
>  		},
>  		.y_offset = 0,
>  	};
> +
> +	/*
> +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
> +	 *                                  is_legal = True,
> +	 *                                  bits = 8) * 2**32).astype(int)
> +	 */
>  	static struct conversion_matrix yuv_bt601_limited = {
>  		.matrix = {
>  			{ 5020601039, 0,           6881764740 },
> @@ -593,6 +611,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
>  		},
>  		.y_offset = 16,
>  	};
> +
> +	/*
> +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
> +	 *                                  is_legal = False,
> +	 *                                  bits = 8) * 2**32).astype(int)
> +	 */
>  	static struct conversion_matrix yuv_bt709_full = {
>  		.matrix = {
>  			{ 4294967296, 0,          6763714498 },
> @@ -601,6 +625,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
>  		},
>  		.y_offset = 0,
>  	};
> +
> +	/*
> +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
> +	 *                                  is_legal = True,
> +	 *                                  bits = 8) * 2**32).astype(int)
> +	 */
>  	static struct conversion_matrix yuv_bt709_limited = {
>  		.matrix = {
>  			{ 5020601039, 0,          7729959424 },
> @@ -609,6 +639,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
>  		},
>  		.y_offset = 16,
>  	};
> +
> +	/*
> +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
> +	 *                                  is_legal = False,
> +	 *                                  bits = 8) * 2**32).astype(int)
> +	 */
>  	static struct conversion_matrix yuv_bt2020_full = {
>  		.matrix = {
>  			{ 4294967296, 0,          6333358775 },
> @@ -617,6 +653,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
>  		},
>  		.y_offset = 0,
>  	};
> +
> +	/*
> +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
> +	 *                                  is_legal = True,
> +	 *                                  bits = 8) * 2**32).astype(int)
> +	 */
>  	static struct conversion_matrix yuv_bt2020_limited = {
>  		.matrix = {
>  			{ 5020601039, 0,          7238124312 },
> @@ -625,6 +667,11 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
>  		},
>  		.y_offset = 16,
>  	};
> +
> +	/*
> +	 * The next matrices are just the previous ones, but with the first and
> +	 * second columns swapped
> +	 */
>  	static struct conversion_matrix yvu_bt601_full = {
>  		.matrix = {
>  			{ 4294967296, 6021544149,  0 },
> 
> -- 
> 2.43.0
> 

