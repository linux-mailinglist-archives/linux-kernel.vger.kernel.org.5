Return-Path: <linux-kernel+bounces-96194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7DF875857
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBA2287BFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C58137C5A;
	Thu,  7 Mar 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WN6RIMTv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A41384A3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843286; cv=none; b=t0ePPik3dTM3EyM88t4cq0etEEOBB5zrNNzezgSsmUGuop/Bg6x9nuQcQHSiDnYlxS0sSuUORSBss4x5Mu5BybpIuJJUeh/JW3DpiJjuEunT5VsNc6C23o4MhZRfNXrP4XmpKprL71pP3ot4AQcAI5JOSQCzWvOVvtaOvcZu1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843286; c=relaxed/simple;
	bh=N9iAxXFSqH7B5Ms78Cze59MmtfuvL/enafxHsGfnODY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/iAYZeFnBC5tHoGFAF80xnU+oowXOBQPnjZ0EZg2LWYqj0ci83vsCNfnU4ItqvX1qV9WdRe8GZRycli52zmkevjmAHsJNTAarGXe5L3h5z9fGid1gmySWq6tFS0bq7W2ts25YqLnOuWHr1MLO1kJlqD/rvFjKDOqq3eCg+PMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WN6RIMTv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709843284; x=1741379284;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=N9iAxXFSqH7B5Ms78Cze59MmtfuvL/enafxHsGfnODY=;
  b=WN6RIMTvKBgZNSUY28ApjzpPyd8a8y0yRJv9VOMwTh1/9pkeAXuZf1kg
   f9vfZCnt8CPGzv3tr1xeMSZ49sLbU9smWAZ3p699Rk8Pw/ohIu7DQV9+u
   PcEjMLhKfJJL8NdMSEHOiUoxcG30ksMxcgtrEfhCdqgQ7AhkFLUR88A7O
   CcDm9BE+Ud2nrJ1suyj7ZK0+A1tqZmr+/oiEG+hQ1kZtgiVXvpsgrvBrr
   JIWYgZaATQAoNPWEmov7FfYsRNzD7jp1SjNReLCGt4ONbCk9IDEICMLZo
   MaHymS3wYkSSrqqlKO7W8I8aROQo76YWxtoVMZmWgt6Et0Eu5T9oA0rqI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="27010944"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="27010944"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 12:28:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10215658"
Received: from tofferse-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.212])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 12:27:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] drm/panel-edp: Fix AUO 0x405c panel naming and
 add a variant
In-Reply-To: <CAJMQK-izRv18V1o7_Q23vWFXQsFgaR74xxZ4Vby0FVtNn21TMg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306200353.1436198-1-hsinyi@chromium.org>
 <20240306200353.1436198-7-hsinyi@chromium.org>
 <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com>
 <87msraw4q6.fsf@intel.com>
 <CAJMQK-izRv18V1o7_Q23vWFXQsFgaR74xxZ4Vby0FVtNn21TMg@mail.gmail.com>
Date: Thu, 07 Mar 2024 22:27:55 +0200
Message-ID: <874jdhwzw4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> On Thu, Mar 7, 2024 at 5:28=E2=80=AFAM Jani Nikula <jani.nikula@linux.int=
el.com> wrote:
>>
>> On Wed, 06 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
>> > Hi,
>> >
>> > On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.=
org> wrote:
>> >>
>> >> @@ -1009,6 +1009,19 @@ static const struct panel_desc auo_b101ean01 =
=3D {
>> >>         },
>> >>  };
>> >>
>> >> +static const struct drm_display_mode auo_b116xa3_mode =3D {
>> >> +       .clock =3D 70589,
>> >> +       .hdisplay =3D 1366,
>> >> +       .hsync_start =3D 1366 + 40,
>> >> +       .hsync_end =3D 1366 + 40 + 40,
>> >> +       .htotal =3D 1366 + 40 + 40 + 32,
>> >> +       .vdisplay =3D 768,
>> >> +       .vsync_start =3D 768 + 10,
>> >> +       .vsync_end =3D 768 + 10 + 12,
>> >> +       .vtotal =3D 768 + 10 + 12 + 6,
>> >> +       .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>> >> +};
>> >> +
>> >>  static const struct drm_display_mode auo_b116xak01_mode =3D {
>> >>         .clock =3D 69300,
>> >>         .hdisplay =3D 1366,
>> >> @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
>> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B=
116XAN06.1"),
>> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B=
116XTN02.5"),
>> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B=
140HAN04.0"),
>> >> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, =
"B116XAK01.0"),
>> >> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, =
"B116XAN04.0"),
>> >> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay,=
 "B116XAK01.0 ",
>> >
>> > Remove the trailing space from the string above now?
>>
>> Maybe it actually needs to be considered part of the name; see my other
>> reply in the earlier patch.
>>
> I randomly checked 3 of the AUO panels that I had a datasheet with,
> and all of them have a white space padding before \n.
> The descriptor of that field is marked as "Reserved for definition",
> unlike other characters, representing the name, which are marked with
> "Manufacture P/N".
>
> For this example, do we still want to consider the white space part of
> the name? I know they didn't follow the spec exactly.

If there's one thing that's for sure, EDIDs are full of stuff like this,
across the board.

Ignoring the whitespace at the end seemed reasonable, initially, to me
too. But the question is, if we start catering for this, what else
should we cater for? Do we keep adding "reasonable" interpretations, or
just go by the spec?


BR,
Jani.


>
>> >
>> > Aside from that:
>> >
>> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>
>> --
>> Jani Nikula, Intel

--=20
Jani Nikula, Intel

