Return-Path: <linux-kernel+bounces-96332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCB875A54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9B51F22C57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79253399F;
	Thu,  7 Mar 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+S//Q6X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D542D050
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850912; cv=none; b=WoojW0lNqQAPU79uoPCStnJrE7QmGPtRYHfWlyX0wWlgLa5N8JtKoZAI61FJAMSuQ/ZHGnjgizNEtQD6Z5n5sDwv0K7GZb2eaeO6sDUjWi68wSjYiSlCjzC3/1nE2O14+6sNPB9lfVLswzN92K4QustIQjQVZT3kg6IVSKv7Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850912; c=relaxed/simple;
	bh=z3yoOduU3u69M13DhP1GKdubXjf7I83rv5ToA3zA3Wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mhVDFoy8HxE5NeWXTd6Www1mPoSxdv8u+WprCWQdBjdX0jsfLqnY/Eqm8TfpjPqxZ+j1BYlYkBtqp0L4ercGnEDACLfwGR5V3kLsBPp658i/Wf4dC5ApcKU2DwodgTe3nlbmobMgPyo5YbDl07erK0SQK1E0DuzKstxdkdGbXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+S//Q6X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709850910; x=1741386910;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=z3yoOduU3u69M13DhP1GKdubXjf7I83rv5ToA3zA3Wc=;
  b=H+S//Q6XIK/2P4fX6D1kRvxv6NAZYT4iRkg/ZNTk9QOusVJLuAhBp1qO
   kbgkiVq5OY/vyfePKrSc1hX2uiXC2c7qCrz67bLC1UDEu6Fi/5eWvFShQ
   bTlDrXPM3DSC4Fasfo/JKzs8d/l00R+wH2eJXH+7fbQboJ2bT77lAom7l
   BEzSmjz/gt1irIaLX0YULdNCrfJq6uQzBy4w6Vw5HhBrIUBhwSCiyhQDh
   asSKJypvKL2wJ3452fmiSZ4N8azs+OWhFLG3WMOX1jaRhmrNcZ492dCTF
   aq2GAOdo0UVcSfnJKp1xQ7YYWYuxjSimO+vAmjVHXMonNi78ETDIFzLe5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4480794"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4480794"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 14:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10823801"
Received: from tofferse-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.212])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 14:35:05 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] drm/panel-edp: Fix AUO 0x405c panel naming and
 add a variant
In-Reply-To: <CAD=FV=UKWd743ZWOgkP4Sn_aq9ca97QygdEcS93=tcGa7r7s8g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306200353.1436198-1-hsinyi@chromium.org>
 <20240306200353.1436198-7-hsinyi@chromium.org>
 <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com>
 <87msraw4q6.fsf@intel.com>
 <CAJMQK-izRv18V1o7_Q23vWFXQsFgaR74xxZ4Vby0FVtNn21TMg@mail.gmail.com>
 <874jdhwzw4.fsf@intel.com>
 <CAD=FV=UKWd743ZWOgkP4Sn_aq9ca97QygdEcS93=tcGa7r7s8g@mail.gmail.com>
Date: Fri, 08 Mar 2024 00:35:01 +0200
Message-ID: <87sf11vffu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
> On Thu, Mar 7, 2024 at 12:28=E2=80=AFPM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
>> If there's one thing that's for sure, EDIDs are full of stuff like this,
>> across the board.
>>
>> Ignoring the whitespace at the end seemed reasonable, initially, to me
>> too. But the question is, if we start catering for this, what else
>> should we cater for? Do we keep adding "reasonable" interpretations, or
>> just go by the spec?
>
> Personally, I don't really care a whole lot either way. If I had to
> make a judgement call I think it's a little cleaner the way Hsin-Yi
> has it where we ignore whitespace at the end. Given that Dmitry also
> suggested ignoring whitespace at the end [1] I guess I'd believe that
> he also feels it's a little cleaner that way. However, If the only way
> to get the patch series landed is to put the space at the end of the
> name in panel-edp.c then I'm OK with that.
>
> In terms of what else we should cater to, I guess we'd have to answer
> that question when it comes up, with a bias against adding more
> special case rules. _Hopefully_ it won't be common that we even need
> this code and it will be the exception rather than the rule that
> panels with incompatible timings have the same panel ID anyway...
>
> In any case, hopefully the above explains my opinion on this. If you
> feel strongly that we should remove the code handling whitespace at
> the end then so be it. If you're on the fence then I guess I'd say
> let's keep it...

No, I don't feel strongly, let's go with this. It's not like it's cast
in stone either.

BR,
Jani.


>
>
> [1] https://lore.kernel.org/lkml/CAA8EJpr7LHvqeGXhbFQ8KNn0LGDuv19cw0i04qV=
Uz51TJeSQrA@mail.gmail.com/

--=20
Jani Nikula, Intel

