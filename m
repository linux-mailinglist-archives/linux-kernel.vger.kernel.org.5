Return-Path: <linux-kernel+bounces-107642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2D87FF82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EFB2846D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC108175E;
	Tue, 19 Mar 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EzzNRSuw"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E58173D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858291; cv=none; b=lMEZEKLDgdkVQd43O8LoUeyOwmuekK86+eV0DaruuJ1+udCXd4Oq+tZv1nnfSKe5A9+rLeI+eU2335b0xPJTEHaysjfqazfAUs/2ZE9LT3kPdInl6R29UuOX9jpvFheChp0fBBHfSaSzrGUqdhP9KQBr44caDfDozyv2XuyvGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858291; c=relaxed/simple;
	bh=NHHJrXlB9hNjSotTwcRL1LhW3neHRBwBMXNWZBEdfhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdvGQJ5gEO8GGM+G2GaqFrjHA70u3oS6qCsV/d2jIJf+A5f4fvEi9uc6Z9e6PxFMT97duGFpY1YJhAV1kKbUVxfAUdTN7L0p2b1EyC+ZyzaisAvUfu+8q23nnaeISv/gTQrS6jxFlrRACLyfO2f9SkT5HUyfMkRXdft4CRG7QhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EzzNRSuw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bhEGOsWJuMl/8S2cphWvd/Ki6+bgSDJhb9ru/x72Im4=; b=EzzNRSuw4SjVSXWt/Fpe/K3NAJ
	R/Eh+UG4fixt5z1imxvFM1+6PBYK7xxw7xr8s6Pn6prWaW93MIgYGs4SC4A8ZjmYDo15A0R89IC4Z
	iFY+GSJeNhVbFLCG/flu7Bk1w0MLE81A9IPJZOVdiWeQvVrGcI79LijHLNIOiX80ciS7OtL1GVEtM
	2O/oOGUn8UHwW0BxqqJqm+GF696Ct4640eXyBEeN12uam4Zerjv+C8Msgw/+KWjgmGHvfTW3enPqY
	YZh25IeO+WTR88JCWQGC1I6g+TNKvAGdyw+DMUiRmJRr5CxJ+z4P4Y63lnFlQkLVJOX9FTFwaO+Ms
	pH5dL/uw==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rmaNz-00CWH2-3W; Tue, 19 Mar 2024 15:24:15 +0100
Date: Tue, 19 Mar 2024 11:24:05 -0300
From: Melissa Wen <mwen@igalia.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Arthur Grillo <arthurgrillo@riseup.net>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Fix drm_fixp2int_round() making it add 0.5
Message-ID: <vhh4unbjmesdlspmgzsqaudahxape6fgcrslxe6wma2is4qbmp@7fie4hqgwdrq>
References: <20240316-drm_fixed-v2-1-c1bc2665b5ed@riseup.net>
 <7636b3tjifajvw63ux7xfjz4hjzhgjrf37mqgulneqzb7eukph@i6nnyietvxji>
 <d296d1b2-7dcd-4dd3-a15c-678e29836063@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d296d1b2-7dcd-4dd3-a15c-678e29836063@igalia.com>

On 03/17, Maíra Canal wrote:
> Hi Melissa,
> 
> On 3/17/24 14:50, Melissa Wen wrote:
> > On 03/16, Arthur Grillo wrote:
> > > As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
> > > To round a number, you need to add 0.5 to the number and floor that,
> > > drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.
> > > 
> > > [1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/
> > > 
> > > Fixes: 8b25320887d7 ("drm: Add fixed-point helper to get rounded integer values")
> > > Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > 
> > Great, thanks!
> > 
> > Reviewed-by: Melissa Wen <mwen@igalia.com>
> > 
> > I'll apply to drm-misc-next.
> 
> Shouldn't this patch be applied in drm-misc-fixes?

After discussions on IRC, I applied to drm-misc-next-fixes, since we are
in a merge window.

Thanks,

Melissa

> 
> Best Regards,
> - Maíra
> 
> > 
> > Melissa
> > 
> > > ---
> > > Changes in v2:
> > > - Add Fixes tag (Melissa Wen)
> > > - Remove DRM_FIXED_POINT_HALF (Melissa Wen)
> > > - Link to v1: https://lore.kernel.org/all/20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net/
> > > ---
> > >   include/drm/drm_fixed.h | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
> > > index 0c9f917a4d4b..81572d32db0c 100644
> > > --- a/include/drm/drm_fixed.h
> > > +++ b/include/drm/drm_fixed.h
> > > @@ -71,7 +71,6 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
> > >   }
> > >   #define DRM_FIXED_POINT		32
> > > -#define DRM_FIXED_POINT_HALF	16
> > >   #define DRM_FIXED_ONE		(1ULL << DRM_FIXED_POINT)
> > >   #define DRM_FIXED_DECIMAL_MASK	(DRM_FIXED_ONE - 1)
> > >   #define DRM_FIXED_DIGITS_MASK	(~DRM_FIXED_DECIMAL_MASK)
> > > @@ -90,7 +89,7 @@ static inline int drm_fixp2int(s64 a)
> > >   static inline int drm_fixp2int_round(s64 a)
> > >   {
> > > -	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
> > > +	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
> > >   }
> > >   static inline int drm_fixp2int_ceil(s64 a)
> > > 
> > > ---
> > > base-commit: f89632a9e5fa6c4787c14458cd42a9ef42025434
> > > change-id: 20240315-drm_fixed-c680ba078ecb
> > > 
> > > Best regards,
> > > -- 
> > > Arthur Grillo <arthurgrillo@riseup.net>
> > > 

