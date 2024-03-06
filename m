Return-Path: <linux-kernel+bounces-93614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEA787325A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE95D1C2234F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3B5D91A;
	Wed,  6 Mar 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AewuDwmD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A925C05F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716715; cv=none; b=GpEZ4Q1kR+nCpg7owVsfaPvACuZuEA2SexDmVFm7aY2M2vzbxdQOu9HA4zO/L3J9t/dc3lejt0B0ifnYh9LqG/3zu8P5XHEsPZe9FVX+rekZZQOcCbweB3Cudy8K6P3P3RisCNU59jnQepX6fm0t5GxnTfsSc9YQ+epplF1mxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716715; c=relaxed/simple;
	bh=D34rJ2jpo3Sm8BQKBLjmFR9WHBkOQ9Sy3+mtZWb4xy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BjOLbGASb3zgJvTjZ/GxezoKUrDiSWKAzkslTxFMYBwRunoEjHFY8OZ1NbS13C+mNwf0QvYlDLdHF1QwSD7zjb5F8h2d7h17aqL986ymdUmxsCsrQu+SUq5VVFmD1s3sTB9yMlVrwNwlQV3tRXPejfzg5b+THaH/JZcOBz9Rrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AewuDwmD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709716714; x=1741252714;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=D34rJ2jpo3Sm8BQKBLjmFR9WHBkOQ9Sy3+mtZWb4xy4=;
  b=AewuDwmDTN8N66Y5R9SfgUesvMF2OWWwrHQD+FcWoKG6zc6cmlxJ7WXV
   1fr6bz5XZ3TiQy9sbNbjmKy5kMkodpXAkUiWCclLGrhz7/0FWKcA7UFG8
   XBaK9vXAL2f/oDfsBsaACEFv7xS1G7MN03L3VpAY2M2bP8T7MuMaYFSRx
   EdIFvtwy06QMYllmo6gblY8t41zF3IwQWBBH+PfRvLlck9MFVwfqXwPAc
   tXa6nZTWcmso0z6dx3ielzu/y3bhVzrB23W1Co2trOYwxag9GqxwkXmSC
   /oGaoP/avBMjD+h5eXZlGvXNwuISDCjyumLZv8ZsshYO05J2VGjpX4Ftn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="7260803"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="7260803"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="40677436"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.33.211])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:18:29 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] drm/edid: Match edid quirks with identity
In-Reply-To: <20240306004347.974304-4-hsinyi@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306004347.974304-1-hsinyi@chromium.org>
 <20240306004347.974304-4-hsinyi@chromium.org>
Date: Wed, 06 Mar 2024 11:18:26 +0200
Message-ID: <87plw7zpjx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 05 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> Currently edid quirks are matched by panel id only.
>
> Modify it to match with identity so it's easier to be extended
> for more complex matching if required.
>
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
> v4: new
> Per discussion https://lore.kernel.org/lkml/87a5nd4tsg.fsf@intel.com/
> ---
>  drivers/gpu/drm/drm_edid.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 5e7e69e0e345..93a49b262dbe 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -114,13 +114,15 @@ struct drm_edid_ident_closure {
>  
>  #define EDID_QUIRK(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _quirks) \
>  { \
> -	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
> -					     product_id), \
> +	.ident = { \
> +		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, \
> +						     vend_chr_2, product_id), \
> +	}, \
>  	.quirks = _quirks \
>  }
>  
>  static const struct edid_quirk {
> -	u32 panel_id;
> +	const struct drm_edid_ident ident;
>  	u32 quirks;
>  } edid_quirk_list[] = {
>  	/* Acer AL1706 */
> @@ -2921,16 +2923,17 @@ EXPORT_SYMBOL(drm_edid_duplicate);
>   * @drm_edid: EDID to process
>   *
>   * This tells subsequent routines what fixes they need to apply.
> + *
> + * Return: A u32 represents the quirks to apply.
>   */
>  static u32 edid_get_quirks(const struct drm_edid *drm_edid)
>  {
> -	u32 panel_id = edid_extract_panel_id(drm_edid->edid);
>  	const struct edid_quirk *quirk;
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(edid_quirk_list); i++) {
>  		quirk = &edid_quirk_list[i];
> -		if (quirk->panel_id == panel_id)
> +		if (drm_edid_match_identity(drm_edid, &quirk->ident))
>  			return quirk->quirks;
>  	}

-- 
Jani Nikula, Intel

