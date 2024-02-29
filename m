Return-Path: <linux-kernel+bounces-87098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ADC86CF84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964A8B212AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D162E410;
	Thu, 29 Feb 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwPsqj5e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210716063C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225013; cv=none; b=q/pmlt3tvd2nP+IpVarPSLyzGgoYEDCWjudsQ9UU+TsDNyHkmOyeDAvMY+cujxsN2PRSlbXwOeaHlLECRhny6Y82TLrDdYs4so5K3tJYLDHjAJSIRaCIHNyGSJ13PlmyGWTu/+ShgJMBz+eG/hEf3NaYHXeeBrg/Pgc+RQOHHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225013; c=relaxed/simple;
	bh=O64Lz4VhVZbPupITA0ycZpRV1MrL3MtI2W4plGilPig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdJl0FGZIBrhIwcP2g2KfmnS8Bm9ZmjI4uiOAQPkGrt++Cynjvn9BJ9Ga8J3ih3OCETOJAc+TtaKbyvco029TwrlJsTr4rfKVbfuuDQfg9hKLKrX5Tzq4GRdzLhhYfGxl/Fka60apNX8Anjz0KsnWz4Sswqfo3QSVVJa65B8ADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwPsqj5e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709225012; x=1740761012;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=O64Lz4VhVZbPupITA0ycZpRV1MrL3MtI2W4plGilPig=;
  b=NwPsqj5e8KhorGVY+7hp72eSGWGseaKpBbcOHKOd1ZNvI7RC+CiaG273
   Y/sJPli/Pg72a1shAW5rjXLSsaoTvJBjg1KiAwvHfWHLom/Zdr6bhdIS8
   cZDtYNMRhpOCeVgd0jOpWfVwrz+I1sbN9QuvaFxuWJijYlR8p4B7lpFus
   dylRcKISAlRu3G+y/bEbgwGcfQQdeT3m/cSVwwqVgq/GduKkVNOOdiX9L
   w+bTJc6ZifRv7KBJlQZtfQkgqjhbXzkKfOhIUiClmghxlAGi4FpywrpbS
   RuOyLMTjFBeLjXXjjb4Ha+PAOEOrSRf3mfnS+CpD2YDZ03AxZ0cEnPg+k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3827678"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3827678"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7828309"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:43:26 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
In-Reply-To: <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240223223958.3887423-1-hsinyi@chromium.org>
 <20240223223958.3887423-2-hsinyi@chromium.org> <87wmqqjmt9.fsf@intel.com>
 <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
 <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
Date: Thu, 29 Feb 2024 18:43:23 +0200
Message-ID: <87bk7z6x1w.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Tue, Feb 27, 2024 at 5:27=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
>>
>> On Tue, Feb 27, 2024 at 1:09=E2=80=AFAM Jani Nikula <jani.nikula@linux.i=
ntel.com> wrote:
>> >
>> > On Fri, 23 Feb 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>> > > It's found that some panels have variants that they share the same p=
anel id
>> > > although their EDID and names are different. Besides panel id, now w=
e need
>> > > the hash of entire EDID base block to distinguish these panel varian=
ts.
>> > >
>> > > Add drm_edid_get_base_block to returns the EDID base block, so calle=
r can
>> > > further use it to get panel id and/or the hash.
>> >
>> > Please reconsider the whole approach here.
>> >
>> > Please let's not add single-use special case functions to read an EDID
>> > base block.
>> >
>> > Please consider reading the whole EDID, using the regular EDID reading
>> > functions, and use that instead.
>> >
>> > Most likely you'll only have 1-2 blocks anyway. And you might consider
>> > caching the EDID in struct panel_edp if reading the entire EDID is too
>> > slow. (And if it is, this is probably sensible even if the EDID only
>> > consists of one block.)
>> >
>> > Anyway, please do *not* merge this as-is.
>> >
>>
>> hi Jani,
>>
>> I sent a v2 here implementing this method:
>> https://lore.kernel.org/lkml/20240228011133.1238439-2-hsinyi@chromium.or=
g/
>>
>> We still have to read edid twice due to:
>> 1. The first caller is in panel probe, at that time, connector is
>> still unknown, so we can't update connector status (eg. update
>> edid_corrupt).
>> 2. It's possible that the connector can have some override
>> (drm_edid_override_get) to EDID, that is still unknown during the
>> first read.
>
> I'll also comment in Hsin-Yi's v2, but given Hsin-Yi's digging and the
> fact that we can't cache the EDID (because we don't yet have a
> "drm_connector"), I'd much prefer Hsin-Yi's solution here from v1 that
> allows reading just the first block. If we try to boot a device with a
> multi-block EDID we're now wastefully reading all the blocks of the
> EDID twice at bootup which will slow boot time.
>
> If you can see a good solution to avoid reading the EDID twice then
> that would be amazing, but if not it seems like we should go back to
> what's here in v1. What do you think? Anyone else have any opinions?

I haven't replied so far, because I've been going back and forth with
this. I'm afraid I don't really like either approach now. Handling the
no connector case in v2 is a bit ugly too. :(

Seems like you only need this to extend the panel ID with a hash. And
panel-edp.c is the only user of drm_edid_get_panel_id(). And EDID quirks
in drm_edid.c could theoretically hit the same problem you're solving.

So maybe something like:

	u32 drm_edid_get_panel_id(struct i2c_adapter *adapter, u32 *hash);

or if you want to be fancy add a struct capturing both id and hash:

	bool drm_edid_get_panel_id(struct i2c_adapter *adapter, struct drm_edid_pa=
nel_id *id);

And put the hash (or whatever mechanism you have) computation in
drm_edid.c. Just hide it all in drm_edid.c, and keep the EDID interfaces
neat.

How would that work for you?


BR,
Jani.


--=20
Jani Nikula, Intel

