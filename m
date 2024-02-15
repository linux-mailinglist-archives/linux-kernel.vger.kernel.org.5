Return-Path: <linux-kernel+bounces-67064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF238565A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62401F210F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0102F131E51;
	Thu, 15 Feb 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhdf2j7e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7764A131727;
	Thu, 15 Feb 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006440; cv=none; b=FXJZiziTBEiJhX6LTiDSj+0Ngeb8Pmdk0QPGo/ZqQsX9a+0NOm3h8P+OVz6Rv1zydHMk6ll+PDJdvUsVFKqBx6xv+0ectdAVUe8OH433hbMfbppMhL2UfiF4c2HQfkwXj+eTKk//e+BVEubDa2F2vdX175Zo8hYfA6XKfV1nFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006440; c=relaxed/simple;
	bh=kQtfjGGHL//RaWDiYtL8dqPa6sivLw8vj+nf2o9x1CE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WFDb2c+LDFS3M4xtksxDJqSow9nu9w74DXScVSVC7HPlrKbtflTxA3YxqfiTLKJzIz1coCj2FnXGlBnBujQ3tftqH4dbKufjoF64hGosYBh6VYC7l+gTW2r2vDArByw4MI130tLPhJHY/GecMGDLiM2qB32MMFTmnBrLKnB1asQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhdf2j7e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708006439; x=1739542439;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=kQtfjGGHL//RaWDiYtL8dqPa6sivLw8vj+nf2o9x1CE=;
  b=Rhdf2j7e7l4i4S0cKLYFUeQoleabgVjaQY3Rm+f3can2FL8sgPD9KYjZ
   W8a10O4evRN8mPS3dbepLfI9tTAfpn4euQa766g9FgRpxJmybsLxQDRzu
   1tqmPrb7oTMNRbTMurHHF0wcuE2vJUpHB3hymDTkRbuRdqHhWQ4z3CpTj
   4uHNc7qExPAI4+45reGiP3vI2pUdvrp9HC3+AUpSGzxa354tkcY25PSPr
   suSIqQYShMuoAjJqCFzKUKMlUak9rxOeBqyAeh/TC+h8ix4n0k3ql2EGO
   fblBmDnkDb/c5+YDASfFv3oZJEuPnaxpyOs5yyv+UZPdkuf5vxaJ7t9oq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5905629"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5905629"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8149317"
Received: from kraszkow-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:13:52 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Mario
 Limonciello
 <mario.limonciello@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>, Hans de Goede <hdegoede@redhat.com>, "open
 list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 amd-gfx@lists.freedesktop.org, "open list:USB SUBSYSTEM"
 <linux-usb@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Melissa Wen <mwen@igalia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v6 3/5] drm: Add support to get EDID from ACPI
In-Reply-To: <Zc1JEg5mC0ww_BeU@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240214215756.6530-1-mario.limonciello@amd.com>
 <20240214215756.6530-4-mario.limonciello@amd.com>
 <Zc1JEg5mC0ww_BeU@intel.com>
Date: Thu, 15 Feb 2024 16:13:50 +0200
Message-ID: <877cj56cip.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Feb 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Wed, Feb 14, 2024 at 03:57:54PM -0600, Mario Limonciello wrote:
>> +static int
>> +drm_do_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t =
len)
>> +{
>> +	struct drm_connector *connector =3D data;
>> +	struct drm_device *ddev =3D connector->dev;
>> +	struct acpi_device *acpidev =3D ACPI_COMPANION(ddev->dev);
>> +	unsigned char start =3D block * EDID_LENGTH;
>> +	void *edid;
>> +	int r;
>> +
>> +	if (!acpidev)
>> +		return -ENODEV;
>> +
>> +	switch (connector->connector_type) {
>> +	case DRM_MODE_CONNECTOR_LVDS:
>> +	case DRM_MODE_CONNECTOR_eDP:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>
> We could have other types of connectors that want this too.
> I don't see any real benefit in having this check tbh. Drivers
> should simply notset the flag on connectors where it won't work,
> and only the driver can really know that.

Agreed.

>>  const struct drm_edid *drm_edid_read(struct drm_connector *connector)
>>  {
>> +	const struct drm_edid *drm_edid =3D NULL;
>> +
>>  	if (drm_WARN_ON(connector->dev, !connector->ddc))
>>  		return NULL;
>>=20=20
>> -	return drm_edid_read_ddc(connector, connector->ddc);
>> +	if (connector->acpi_edid_allowed)
>
> That should probably be called 'prefer_acpi_edid' or something
> since it's the first choice when the flag is set.
>
> But I'm not so sure there's any real benefit in having this
> flag at all. You anyway have to modify the driver to use this,
> so why not just have the driver do the call directly instead of
> adding this extra detour via the flag?

Heh, round and round we go [1].


BR,
Jani.

[1] https://lore.kernel.org/r/87sf23auxv.fsf@intel.com


--=20
Jani Nikula, Intel

