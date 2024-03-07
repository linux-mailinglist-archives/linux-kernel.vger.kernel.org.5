Return-Path: <linux-kernel+bounces-95596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E75874FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FCB283C75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C812C7F3;
	Thu,  7 Mar 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCS/fRzT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B538126F3E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818137; cv=none; b=LiPgq3P1wjUXtYv9IEZala/e7H6aN3e9IyhXoiX3lox7EaUOMYw9V/3dn6JgNiv1Cv2FPWW/1Kk/X2123/pXLXRSrMJ5Xn1/hSRKvuvKYe9M+B9zRcDF2XaRV++cPTfvlvXUv95vyMNl6bI+GnVtSPmjsl/TiCNO73jpeMYTuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818137; c=relaxed/simple;
	bh=yjdIRk7sd3qilCPNdIe1vadTlkaMwe9EisUimCP9pyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQ2djpP9iZTotq2rRt+gNYEswLdvK/SgQEr6lMB0wF1uWpQ0nB4JSHOx7+5ofmAkoPYpFFJPqfGd631m05xfmOvnBNUaKrZaZV/d1+2xEY1b9Lfc7/wdg+Riw5T0jElMuOCn7kJgW5GUXVwUQPAC8bT3LOBYhDT5i4h7RXhPznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCS/fRzT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709818136; x=1741354136;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=yjdIRk7sd3qilCPNdIe1vadTlkaMwe9EisUimCP9pyw=;
  b=XCS/fRzTsAsNU+dKE5mPnEbPyeSH4vGMSOB5Ok9jz96d6RY9WGCOdl5K
   1kBAN9io+QrDqdjAKKvnOprwJS2+ll7N+Vqjc4UiaxqzqmmbvIP0cS2jn
   42FJKovS1rvq0R95jb5zjvp6lzE2ECOAiBYNmyrVru4XxE1umDyT1K9Bu
   CS4N0SaXPtawPfwhuWW4V8Ayq0v+ZCOMWaOmuJAJKgZYFMioFgweUZhHE
   sIL1wvvL4gUwUZavNMZ7+Vr4V4Yh7ib4ymmy3D7N+c0GQseYNJaYbwcp4
   AW+/exCfrqNqB2u4z0UutdV6I2tTqhHrYT/PIe6tLr7sZS9QyRpgaUSgV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4338656"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4338656"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:28:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="33260982"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:28:51 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] drm/panel-edp: Fix AUO 0x405c panel naming and
 add a variant
In-Reply-To: <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306200353.1436198-1-hsinyi@chromium.org>
 <20240306200353.1436198-7-hsinyi@chromium.org>
 <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com>
Date: Thu, 07 Mar 2024 15:28:49 +0200
Message-ID: <87msraw4q6.fsf@intel.com>
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
>> @@ -1009,6 +1009,19 @@ static const struct panel_desc auo_b101ean01 =3D {
>>         },
>>  };
>>
>> +static const struct drm_display_mode auo_b116xa3_mode =3D {
>> +       .clock =3D 70589,
>> +       .hdisplay =3D 1366,
>> +       .hsync_start =3D 1366 + 40,
>> +       .hsync_end =3D 1366 + 40 + 40,
>> +       .htotal =3D 1366 + 40 + 40 + 32,
>> +       .vdisplay =3D 768,
>> +       .vsync_start =3D 768 + 10,
>> +       .vsync_end =3D 768 + 10 + 12,
>> +       .vtotal =3D 768 + 10 + 12 + 6,
>> +       .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>> +};
>> +
>>  static const struct drm_display_mode auo_b116xak01_mode =3D {
>>         .clock =3D 69300,
>>         .hdisplay =3D 1366,
>> @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116=
XAN06.1"),
>>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116=
XTN02.5"),
>>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140=
HAN04.0"),
>> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B1=
16XAK01.0"),
>> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B1=
16XAN04.0"),
>> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B=
116XAK01.0 ",
>
> Remove the trailing space from the string above now?

Maybe it actually needs to be considered part of the name; see my other
reply in the earlier patch.

>
> Aside from that:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

--=20
Jani Nikula, Intel

