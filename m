Return-Path: <linux-kernel+bounces-105487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E498E87DF10
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F46C281FB0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E01CF90;
	Sun, 17 Mar 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jN7nloTI"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1971CF80
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710697933; cv=none; b=cvd2Ic9UaySGkvXSgEteRKG8hzuy0yPmcHHmGuxwh4toNGcCpDTdH18hibRFxZjS/JGojFSiGik7G/QDBLBQcgPv6da3oSAfLpZbczBdSwG6Vh9pJs8x5vAosL5M7YA++SluOJ0me6nKeHGDDm2A6ZKlrGDpvMbeXHuruy/Em9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710697933; c=relaxed/simple;
	bh=v5b5MqaWU+N+lEYv9lQSgXWsCv5YZJEI5sWSdpWP8HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NltUaxhGuqjf+BKNlFMJXaeH1sLtmbf2uX/UPC0mw/qK5s9TyWIr8KaNjYJDm9KYyubVS2TTrnsXe5MWW2eEK6yWr6QSBD6maULbi/O/emYKmPTR37gUKXVvHdej9glCgBdbgUkdN4RdlJGB4CjE74pcHzARV/fwN34CFYHFS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jN7nloTI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=E7j8mQvMMQfMZFz1qf2xhA4dyWrWUCrZPdqVXHb31Ig=; b=jN7nloTIP2HuE1/7CqeC+f9LWf
	c0lXNW3Gua/H+0C10CroABooPqwmASMaLhOuK8WfW+z6hzXAb3AlqN90n2wJYopjSI4AMu9BuFlTj
	aQmeZ8FDuX5xKMx23dpYVSwWLfnMxWfrnTxE0lC+C5mySv6rWIonLEKRnNq8RYo10ofpC+j4Jb/Mz
	jM/YBj/eWx5iL3otaOyAigyt+MEIaF9grGy+kXCAMB8/ASkSKUSiqMV2Au4Y6GkW0pF31lmmM0Mnl
	6AhSVoGz5cl+MTYCZmK+JntycuwhzRpG7ZB6Qrc6tUN4LFsn5hqZbkH0NiZJAJfj4mt4asV68Ja00
	V9Ufkoeg==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rlufY-00Bgjy-8g; Sun, 17 Mar 2024 18:51:36 +0100
Date: Sun, 17 Mar 2024 14:50:42 -0300
From: Melissa Wen <mwen@igalia.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Fix drm_fixp2int_round() making it add 0.5
Message-ID: <7636b3tjifajvw63ux7xfjz4hjzhgjrf37mqgulneqzb7eukph@i6nnyietvxji>
References: <20240316-drm_fixed-v2-1-c1bc2665b5ed@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316-drm_fixed-v2-1-c1bc2665b5ed@riseup.net>

On 03/16, Arthur Grillo wrote:
> As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
> To round a number, you need to add 0.5 to the number and floor that,
> drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.
> 
> [1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/
> 
> Fixes: 8b25320887d7 ("drm: Add fixed-point helper to get rounded integer values")
> Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>

Great, thanks!

Reviewed-by: Melissa Wen <mwen@igalia.com>

I'll apply to drm-misc-next.

Melissa

> ---
> Changes in v2:
> - Add Fixes tag (Melissa Wen)
> - Remove DRM_FIXED_POINT_HALF (Melissa Wen)
> - Link to v1: https://lore.kernel.org/all/20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net/
> ---
>  include/drm/drm_fixed.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
> index 0c9f917a4d4b..81572d32db0c 100644
> --- a/include/drm/drm_fixed.h
> +++ b/include/drm/drm_fixed.h
> @@ -71,7 +71,6 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
>  }
>  
>  #define DRM_FIXED_POINT		32
> -#define DRM_FIXED_POINT_HALF	16
>  #define DRM_FIXED_ONE		(1ULL << DRM_FIXED_POINT)
>  #define DRM_FIXED_DECIMAL_MASK	(DRM_FIXED_ONE - 1)
>  #define DRM_FIXED_DIGITS_MASK	(~DRM_FIXED_DECIMAL_MASK)
> @@ -90,7 +89,7 @@ static inline int drm_fixp2int(s64 a)
>  
>  static inline int drm_fixp2int_round(s64 a)
>  {
> -	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
> +	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
>  }
>  
>  static inline int drm_fixp2int_ceil(s64 a)
> 
> ---
> base-commit: f89632a9e5fa6c4787c14458cd42a9ef42025434
> change-id: 20240315-drm_fixed-c680ba078ecb
> 
> Best regards,
> -- 
> Arthur Grillo <arthurgrillo@riseup.net>
> 

