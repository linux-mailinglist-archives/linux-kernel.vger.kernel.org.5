Return-Path: <linux-kernel+bounces-91879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE638717C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2122F1F222D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59627F48E;
	Tue,  5 Mar 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsUMR+fG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD17EF18
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626381; cv=none; b=md9VgTIeCC6VXFr1mL9xGYnMbJAAoUF0z0R92YE4Y7NOxofgaDsBORG6iiZCIjLeoqnh/3phkeEP7yAnJlCwMh2EEVQqg3tSuo37Luzkfqynyaqd9IcTmMynGgKbyBgDTJFGTn9zqi/JvQ2qidowKtoxqql++/a2FAvECH7sQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626381; c=relaxed/simple;
	bh=IxofcRReTS1GVC8uDxeeDlw/tDFak2/5TsEbHr6Ca50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2npSF4YnX2DJsb4GclRAegVAYdtHt2jYxpVQAEWAt/RaMJGAAok0ejwp4Jm2Yyu3HfrVvQ0jcDDSkdKTazxjoKJ7xA8XYgwuuQpYIRm+4/2plgxfPku67TPN/hjU8ntJfaq794ankzp0AnRpH4cZUgXaxZSo8LDRgqscq08nhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsUMR+fG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709626380; x=1741162380;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=IxofcRReTS1GVC8uDxeeDlw/tDFak2/5TsEbHr6Ca50=;
  b=TsUMR+fGwcPgdBWypE3YldNwUS1eSUHfz+IcXEyQYVu7Mzx+OSiH2VQv
   estKYqbj7+V+LdW7TVlXR+1UXrsHRt2U1EH8Ilz70p9kebqqyGQGstXNO
   wMmEqzVuDIWyaKOzmW6ga6/MjfeCfd36onDFxfO+KhpoOgOxC/zHimrjO
   9Sh2YVEK89HEHKm7jldI1RCBFWRL8d2XOzNHU62uMp6nY7lkLzKl2cm1N
   HecRU2/qbv3FQY3Cb8kOPB1ohKg28Tn09sd1d+LF1MiNtoIsKQHTE/HQ4
   FguMYI01nNB5EIq9mA4ClCKBc7SG6gLdRZhFoFff5evbolljZG9wh3+T3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4024630"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4024630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 00:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9465960"
Received: from omakhlou-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.51.143])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 00:12:50 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
In-Reply-To: <CAJMQK-i284bO=dSOZTsgJaMMWDCqXmYB_SDJbhx3U1s-U==S2A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240304195214.14563-1-hsinyi@chromium.org>
 <20240304195214.14563-3-hsinyi@chromium.org> <87a5nd4tsg.fsf@intel.com>
 <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
 <874jdl4k01.fsf@intel.com>
 <CAJMQK-i284bO=dSOZTsgJaMMWDCqXmYB_SDJbhx3U1s-U==S2A@mail.gmail.com>
Date: Tue, 05 Mar 2024 10:12:46 +0200
Message-ID: <871q8p3xmp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> On Mon, Mar 4, 2024 at 4:09=E2=80=AFPM Jani Nikula <jani.nikula@linux.int=
el.com> wrote:
>>
>> On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>> > To clarify:
>> > struct drm_edid currently is only internal to drm_edid.c. So with
>> > change we will have to move it to the header drm_edid.h
>>
>> Absolutely not, struct drm_edid must remain an opaque type. The point is
>> that you ask drm_edid.c if there's a match or not, and the panel code
>> does not need to care what's inside struct drm_edid.
>>
>
> Sorry I might be misunderstanding about the requests here:
>
> If drm_edid should remain opaque, then struct drm_edid remains opaque,
> drm_edid_match() should take struct edid *edid as a parameter? just as
> other exposed functions in drm_edid.

No, it should take struct drm_edid *.

> If panel edp doesn't hold drm_edid returned from
> drm_edid_read_base_block(), what should it use to iterate the
> edp_panels array?

Panel edp can hold a *pointer* to struct drm_edid * without knowing the
full type. This is one of the points of struct drm_edid. Focus more of
the EDID parsing within drm_edid.c instead of having everyone parse it
to varying degrees of correctness.

>
> for (panel =3D edp_panels; panel->panel_id; panel++)
>     if(drm_edid_match(drm_edid, panel->ident))
>         ...
>

BR,
Jani.

--=20
Jani Nikula, Intel

