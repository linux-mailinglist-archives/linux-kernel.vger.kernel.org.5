Return-Path: <linux-kernel+bounces-95557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4C874F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27971C23C81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A512BEAC;
	Thu,  7 Mar 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ay5X698g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6C2AD17
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815826; cv=none; b=PcnIiIe9aCxUhXqJ/N+TZdPXjwR0ayJOpikrU9NW+7K4AYtf5Z9uqZDMW4084KpOPPKQoUXuJHcGZKLdNLUj52S9/Wito/+Hhr+309KVpIywRvanKI1g0XXbf9WSn01jUorZvjWpbaxXuPrsZAs9fvIjGzzW+lpew7l2leSxnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815826; c=relaxed/simple;
	bh=jzkff/wKLotiv67Et0hWHzDfFfcMuH5uRmfmuTq23Ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXEjTJ0dnaA9M4eJLzHo5BWcNB2YhjVLtTW9SK5Crh1jbNa8ddjOCktfi6AAA3susxhGokzu1VH/bms/EI3WsjHFIrdZItNIxZLTL0+0108iFEgsAnODPJNr9VWKvA8FKSEr/QYHw7aVnggxvcrzIM1AONcQagxTbgQ1wtuN/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ay5X698g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709815824; x=1741351824;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jzkff/wKLotiv67Et0hWHzDfFfcMuH5uRmfmuTq23Ok=;
  b=Ay5X698ghn+5b9qWQNYCWDZRptUU//TMevSaQmEbQ2PWK35o5ZArlncn
   wEmHSfynRfd58rsjdAx7kI4Svu0vnTipBf1ASX2b/JpuhN9R5CmUoctv/
   orPcEaz2933fi/eE0ti9gbor3sgMBFpZaE7T5/MK1P6gwuMzULZuOmdiQ
   eATKlSOFD6ADOvx9IgyhnSmAmbcmYTEAi3Xn7arjlYX81olN2HjuYrPlZ
   5OnrAD+UpNI1PEWgousT38uhDwEfEAReJYSLSe5nVXmU6KugkM48WChVI
   OmdGTSvZkGXjbStsMuNGxyuRofH8cjjR2oY4+4q46bb4EiNlEOJk2JlDr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4338592"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4338592"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10029673"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:50:20 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] drm_edid: Add a function to get EDID base block
In-Reply-To: <CAD=FV=XcMRLvSU+_QrNMSOo4JH0hPmA-F3HFjOBj=QwHHQy_mA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306200353.1436198-1-hsinyi@chromium.org>
 <20240306200353.1436198-2-hsinyi@chromium.org>
 <CAD=FV=XcMRLvSU+_QrNMSOo4JH0hPmA-F3HFjOBj=QwHHQy_mA@mail.gmail.com>
Date: Thu, 07 Mar 2024 14:50:17 +0200
Message-ID: <87wmqew6ie.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 06 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
>>
>> @@ -2764,58 +2764,71 @@ static u32 edid_extract_panel_id(const struct ed=
id *edid)
>>  }
>>
>>  /**
>> - * drm_edid_get_panel_id - Get a panel's ID through DDC
>> - * @adapter: I2C adapter to use for DDC
>> + * drm_edid_get_panel_id - Get a panel's ID from EDID
>> + * @drm_edid: EDID that contains panel ID.
>>   *
>> - * This function reads the first block of the EDID of a panel and (assu=
ming
>> + * This function uses the first block of the EDID of a panel and (assum=
ing
>>   * that the EDID is valid) extracts the ID out of it. The ID is a 32-bi=
t value
>>   * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that=
's
>>   * supposed to be different for each different modem of panel.
>>   *
>> + * Return: A 32-bit ID that should be different for each make/model of =
panel.
>> + *         See the functions drm_edid_encode_panel_id() and
>> + *         drm_edid_decode_panel_id() for some details on the structure=
 of this
>> + *         ID.
>> + */
>> +u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
>> +{
>
> I'd leave it up to Jani, but I'd wonder whether we need to confirm
> drm_edid->size here is at least as big as the base block. In other
> words: is there ever any chance that someone would have allocated a
> struct drm_edid but not actually read a full base block into it?

On the one hand, I've tried to make all the drm_edid based interfaces
handle all the cases (drm_edid =3D=3D NULL, drm_edid->edid =3D=3D NULL,
drm_edid->size < required) gracefully, but on the other hand, panel-edp
is the only user and this would go boom for you quickly if you passed in
a bogus drm_edid.

Adding the checks is definitely not wrong, but I'm not insisting.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>
> In any case:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

--=20
Jani Nikula, Intel

