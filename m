Return-Path: <linux-kernel+bounces-93928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B11AD87370B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD4B239B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F5612F5B8;
	Wed,  6 Mar 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZqI+KI9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051A130ADC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729629; cv=none; b=ejBVrLRmYyRtqDrWpvU2P+8iNfN1LJZEoGz9Mq068NkYXDVFQPwXYIinjT2xPUJ4jvG2Oh/Ku9VMIa8MCMacbEk7mtOMZEIVE0WBGipNitQj5GlDl1eLRdMPDLawUER8Cinc2Ru93cU87GKouLSDRXtiF5QJ1Zb57m1viqXcylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729629; c=relaxed/simple;
	bh=9V/0lspOmb9T32u1RMsAnMxMJ1V06Y8m+bgWinFW7ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e6bXr+GN4PyU94rZ+CZVl2Beks4FxEV+6J+m3DBKfk4ixLP50ATWY9ieqGPiW1rRlIDcKO+boXX1YIQDH42whWZkgeRGE36bw6P6GggfvEQ1ZMbizS8S5jrARXtlDfwgU/ao4RBLVUliWTkP3hQr5tfqmg0PW/YVHXWxqrdSXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZqI+KI9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709729628; x=1741265628;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=9V/0lspOmb9T32u1RMsAnMxMJ1V06Y8m+bgWinFW7ZQ=;
  b=VZqI+KI9RbaHrtIePWkRkh9dCb0Gq8yPord6eqtsUbNJ/epwZRe8H9R+
   ddxcYzycFuGIHMWpVWI30c1mVdEsX6nygfrs+4UOSx75W+t4pOX2vqxc/
   VS0GTXiicC13TL8kdr3ykUdzTJX2Gv3+GWM3btpfRMkoI0aNsIn8ypdRa
   3xrC54LktOFYvDRYy1R85YBqJrtvmj5PtIes4gfhJ2lKyyJSwlJ633NXu
   9dS+jxdMz6comDOrp3XHO8rFeJhjB1lXED7EXBfXZVDC3d9MsMy6zqGeQ
   GnJqcxX5vzKTLXcuDWgBX0cS6MMB+WRDAroBUAYoOKzIujHCACGWt9KAY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4270460"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4270460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 04:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9678012"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.33.211])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 04:53:43 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
In-Reply-To: <CAJMQK-hE8sWL2rO-N2WZuyXzPhnXZJN4LUL_TwzKGhq_Ozz6Vw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240304195214.14563-1-hsinyi@chromium.org>
 <20240304195214.14563-3-hsinyi@chromium.org> <87a5nd4tsg.fsf@intel.com>
 <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
 <874jdl4k01.fsf@intel.com>
 <CAJMQK-iWHoh6s-hkcNULzZLjMg9UnTuWfjaJ=YfnHU3sQ1NBEg@mail.gmail.com>
 <CAD=FV=UOhTGnhtc9gOQ5C_aAdgVcB+K7NL9RGm4umunF91Wkpg@mail.gmail.com>
 <87y1ax2iu1.fsf@intel.com>
 <CAD=FV=WzLLeEw-b0Kug-Pm-9EYm7eHvmukEUJ8VHnu-4YY3WNQ@mail.gmail.com>
 <CAJMQK-hE8sWL2rO-N2WZuyXzPhnXZJN4LUL_TwzKGhq_Ozz6Vw@mail.gmail.com>
Date: Wed, 06 Mar 2024 14:53:40 +0200
Message-ID: <875xxzzfl7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> On Tue, Mar 5, 2024 at 11:25=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
>> Hmm. As Hsin-Yi pointed out to me offline. Somehow we'll need to get
>> the actual panel ID out. Right now in panel-edp.c we have:
>>
>> dev_warn(dev,
>>   "Unknown panel %s %#06x, using conservative timings\n",
>>   vend, product_id);
>>
>> Where "vend" and "product_id" come from the panel ID of a panel that
>> we didn't recognize. For instance:
>>
>>   Unknown panel BOE 0x0731, using conservative timings
>>
>> We need to still be able to print this message for unrecognized
>> panels. Then when we see field reports including this message we know
>> that somehow we ended up shipping an unrecognized panel.
>>
>> Any suggestions on what abstraction you'd like to see to enable us to
>> print that message if everything is opaque?
>
> Sent v4 here: https://lore.kernel.org/lkml/20240306004347.974304-1-hsinyi=
@chromium.org/
>
> Besides that it still keeps drm_edid_get_panel_id() to be used on the
> kernel warning when no panel is matched, other parts I think are
> following the comments.

Yeah we can keep that for now.

BR,
Jani.


--=20
Jani Nikula, Intel

