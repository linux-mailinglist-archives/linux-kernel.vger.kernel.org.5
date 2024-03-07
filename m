Return-Path: <linux-kernel+bounces-95558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD4874F74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72F7283CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26712BE93;
	Thu,  7 Mar 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4rPsAlw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B33233
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815876; cv=none; b=TYNlS0pTD4+zKiLtMQzUAPmYmuvuMJnh/UVJ4kmt+Jim4NoxI/VX5Vz7TpanazBIaxGNfAvZOS0+q5+SvFDhcNb3/EoQfyJgFrLu+u8wTcwT+d3XsQwwaw880dZFdfGjpuxDnkTUdex9huigkgcbPguGf3WQRqzWkVL1GLYo8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815876; c=relaxed/simple;
	bh=CU8nSLKdsapM+hvdUvqbh4xSxQUz7QJ22trHW5nNp+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQa2gM4mmcfpxJCsw4UM+NlxbG/Hxk4Rkrpvh293psBIDd8XX+cC0aVMWEx02cz3JCbqYJWVhZ6JUFQesk5UuajCab0XJVzuba4NDFEAOS8boLea5io+zz8sgQPM44CaKQ3+WSwuEn0yH0e2+rL0jVjtTqPcxmmJc5EO/WT0CaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4rPsAlw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709815875; x=1741351875;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=CU8nSLKdsapM+hvdUvqbh4xSxQUz7QJ22trHW5nNp+U=;
  b=e4rPsAlwEPZrt7c3k459hphtltUIFCz8nKv2ElsvisvCyn3zNpYSbVwL
   rTCCwgbxUybEQI9QPaGb65o040F48Eq0S5b2jXruFlqZ1m7jh6N4ppL3Z
   BoMgW/YLGkBBAkOpneRZ2rdYeIM4ZOgGTSfCfz02U4l8tnpHjgaANyWxg
   7HTOOItdDCV9dxgHRVQ779FDAJ+Og4KMj3KanAW6vl+3dxLncgcEWnQe9
   BA5bQ8sj/hjBtwPdDuhFeoRdcAQnDL8k2g0ZcdftU2t4X17y+hiRApVOS
   +H2xHHAbkL4fs1ikNKCaWyHmKz6Do7bDu9zsIXFk/8/OciVloxHsJQdYw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15126640"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15126640"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:51:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10250327"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:51:10 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] drm/edid: Clean up drm_edid_get_panel_id()
In-Reply-To: <CAD=FV=WvvLFN4U5-EewpXEcT-gz0qO+2SrYdEQpC-+s0DBeBUw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306200353.1436198-1-hsinyi@chromium.org>
 <20240306200353.1436198-3-hsinyi@chromium.org>
 <CAD=FV=WvvLFN4U5-EewpXEcT-gz0qO+2SrYdEQpC-+s0DBeBUw@mail.gmail.com>
Date: Thu, 07 Mar 2024 14:51:08 +0200
Message-ID: <87ttliw6gz.fsf@intel.com>
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
>> drm_edid_get_panel_id() now just directly call edid_extract_panel_id().
>>
>> Merge them into one function.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> ---
>> v4->v5: new
>> ---
>>  drivers/gpu/drm/drm_edid.c | 39 ++++++++++++++++++--------------------
>>  1 file changed, 18 insertions(+), 21 deletions(-)
>
> Personally I wouldn't have objected to this being squashed into patch
> #1, but I'm also OK as you have it.

Ditto.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

--=20
Jani Nikula, Intel

