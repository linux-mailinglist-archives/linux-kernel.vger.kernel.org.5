Return-Path: <linux-kernel+bounces-144101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE08A41CB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0461F213F8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2992C1A2;
	Sun, 14 Apr 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XcslpJkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DC1172C;
	Sun, 14 Apr 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089880; cv=none; b=GqOWbhmm9ihuqc13h+GOa/uXtGVXbRGlnF+To+POTnA++2vHFuPEGtU0IIlQAtmhbCGU2d+qYsB6RveesaHVZAIKLvDEU6veLFG4Dp4yPKrG1FLHpj7+HdtlupNanuElRSzKJuap5w6+IZiZgrd6ZPxezDc1AxXNz+b6w9C+mEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089880; c=relaxed/simple;
	bh=gKVFAu7bX5Wtu28q+2CQOcF6pB1tKN/oXMHkZM9hdkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqMUl+//o2eg4IX2H8H5Vv7L3Wdp2wo8DQkskL9TnYkEw4BbYQdQz2Dxscp9Psyql9GZnTMO4CmsUD/9SWcUQ/8nzEMQa2yOwVDV2YKvjhY1PEYkiDk8z6JOwda/J2tj/OnKoqIJxs8SeaJrEVmsrgiRsRNajmUE8UcVc7VvG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XcslpJkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C40C072AA;
	Sun, 14 Apr 2024 10:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713089879;
	bh=gKVFAu7bX5Wtu28q+2CQOcF6pB1tKN/oXMHkZM9hdkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcslpJknihp9zd2fAIpmnIsTQLQuSQAE4zI856SKRvl7K5YYa6NaKqWtzKSGeFzom
	 XQVVibypLsRkJHaiS/VnFTWITap2y4tF4eX/M2ZDPmLOH4Pf+5uURZmnVF+Hlifi8d
	 YsiyG+uA4e/b0D+fH2iJoplgxrB22tVZLJQZw1yg=
Date: Sun, 14 Apr 2024 12:17:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sumadhura kalyan <opensourcecond@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: Code optimized to use linux BIT
 macro.
Message-ID: <2024041419-rug-undrilled-6628@gregkh>
References: <20240414101258.98358-1-opensourcecond@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414101258.98358-1-opensourcecond@gmail.com>

On Sun, Apr 14, 2024 at 03:42:58PM +0530, sumadhura kalyan wrote:
> Issue found by checkpatch
> 
> Signed-off-by: sumadhura kalyan <opensourcecond@gmail.com>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
> index a0cdd28101f2..d811bfd3bb84 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
> @@ -27,7 +27,7 @@
>  /** Common parameter ID group, used with many types of component. */
>  #define MMAL_PARAMETER_GROUP_COMMON		(0 << 16)
>  /** Camera-specific parameter ID group. */
> -#define MMAL_PARAMETER_GROUP_CAMERA		(1 << 16)
> +#define MMAL_PARAMETER_GROUP_CAMERA		BIT(16)
>  /** Video-specific parameter ID group. */
>  #define MMAL_PARAMETER_GROUP_VIDEO		(2 << 16)
>  /** Audio-specific parameter ID group. */

When looking at the code now, does this change make sense?  Remember,
checkpatch is a guide, not a hard rule.

greg k-h

