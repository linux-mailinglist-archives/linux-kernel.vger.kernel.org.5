Return-Path: <linux-kernel+bounces-49922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EBA847188
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622ED1C25ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BA7E0E5;
	Fri,  2 Feb 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRqdA5E5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC4812;
	Fri,  2 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882335; cv=none; b=P8Br4j7he0nZTJRBergRSsHsl+O7qRjL+WLleL8T9yZiCHKC83ACwj6X71Zm58PR+mrx+W5DtNWpofJV+gtrKwPv6nZvqPc+DzRFU6FfC8bCTu/nrsPdXbadYhVTz4B8LFR97i1cKjyGjV7Y6z7/h/0X8c1zrGLw26ma5oS05QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882335; c=relaxed/simple;
	bh=tgr1j4EzwrF68qG4xANL4ri8EhdYwVBBDxE0H3P5pG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ttYdgngpxSt36TcyMWskM6g3lvhOzIMUU1NaKqpre/OKpFsR5rv0F7Y5d8jK2SVU/nNLFGh5TUDHA0NTCpZR73ieuPh6k13A5Yc8hYqUaRNy2NQAvNY/nD/5AsrnbI8it7Ob+qhewxB/jRfqd2nXddQfldr+QKyD4G4tyK0LvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRqdA5E5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706882331; x=1738418331;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tgr1j4EzwrF68qG4xANL4ri8EhdYwVBBDxE0H3P5pG4=;
  b=cRqdA5E5VvMEvq1BnxJvqo/0+XuTeypYw/6SkWC7hI7l2UTAaBbEqHb/
   IDXLKDKRLwMWnpXWVWnFegXha6L6joMtRw0lipMT5HxBYGKLMh6vOIilT
   C8/Cx80WE/sZWP+nOt/UaDmUP26O7IVvgIZ1MKoYQBEo3VYvAXorKjdxT
   95iN4sTo+y7Q+U1L4z1Ca1K8ZIHCETy0FzjYABQhEtbIfrB2CR7imm1q5
   gceqk+txJYEXFZQ9iIcO3lQKg/DSJBi/fhlrpA55AusyVt/l6U9CYjwQH
   JaDkNylCFcgmFAfCfPXZQ0zNQUJLOiudZ0NeBpeDwQGVMDY6vTLHuXB0L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="22645136"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="22645136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="31182993"
Received: from mmermeza-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.59.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:58:43 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, Jonathan Corbet
 <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St?=
 =?utf-8?Q?=C3=BCbner?=
 <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: Re: [PATCH v5 15/44] drm/connector: hdmi: Compute bpc and
 format automatically
In-Reply-To: <vydlftxen23kd2odwegxbtpaz73sy2lgpv7nlynfjr3p2xvc2b@7lkdkaw3gp5q>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-15-6538e19d634d@kernel.org>
 <CAPY8ntBQ+qY9441-rMzq_JAoYAaY_r+E-ADv7Wry0tJNTzKpwg@mail.gmail.com>
 <jlkoofv7nszj2uqmo2672yo4wjd3yjqarge2l2hxofixcchu6a@j72pa4iybitd>
 <CAPY8ntAmXyKtebMeM7rLtgRR+QwL1H+UCwSO=bLBQN4TsgwsDg@mail.gmail.com>
 <vydlftxen23kd2odwegxbtpaz73sy2lgpv7nlynfjr3p2xvc2b@7lkdkaw3gp5q>
Date: Fri, 02 Feb 2024 15:58:39 +0200
Message-ID: <87y1c3dl2o.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 01 Feb 2024, Maxime Ripard <mripard@kernel.org> wrote:
> We've discussed that on IRC today. I'm not sure there was a conclusion
> other than "well this doesn't seem right". I think we should at least
> provide different EDIDs depending on the connector type indeed, but
> there was also a few discussions that arose:
>
>   - Is it useful to have embedded EDIDs in the kernel at all, and could
>     we just get rid of it?
>
>   - Should we expose those EDIDs to userspace, and what happens to the
>     compositor when we do?
>
>   - The current way to generate those EDIDs isn't... optimal? Should we
>     get rid of that as well?
>
> Anyway, all of those issues have been here for a while so I don't really
> expect this series to fix that.

IMO the direction should be towards deprecating and removing the builtin
firmware EDIDs from the kernel instead of adding more or expanding on
them. They were only ever meant to be the immediate aid to get something
on screen so the user could provide a proper EDID via userspace.

BR,
Jani.


-- 
Jani Nikula, Intel

