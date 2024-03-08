Return-Path: <linux-kernel+bounces-96626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813C875F14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990291C22166
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C850A6B;
	Fri,  8 Mar 2024 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+FqdOrx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C61D699
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885241; cv=none; b=h/v6otxc45eWvJZQEYgiUYScWidwaXmsL8feoVoFWSkIs4C8xYWSmzFoTbTQin4iZsaomcY+da6auR7uUfmJlaZwifvGByOH2WKIQJtu+plZBFL1D7DelC9XBQsGITfCX/w6+1iH2FzyFAHuJ2lgfzfU3ChLzLRfEfNJ9/mCUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885241; c=relaxed/simple;
	bh=jDdOt/2/1csh8uzSIdh6Wlj1K1r1Sr6v5MZdPU3LtjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dkSZwbcTYJiQZVKtiR/ck8CuiGbR+np7GzFj7sZGkQtXwjj3QfDx1TBIq4m08oz0w0Xgyni79Pq+lzV27BEWDuYyvoZfUoE8MlcI76+LP4YBK5mqokwX6/hHvYNRXtjax4cukgcVOXKF6davY1Up3uus/6kpL66/07nojDcDKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+FqdOrx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709885240; x=1741421240;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jDdOt/2/1csh8uzSIdh6Wlj1K1r1Sr6v5MZdPU3LtjA=;
  b=A+FqdOrxY5HZwlrQ00xB4Y5qSoZQYgGRpnyn5Vv9Ia0c7oZM77iWp1ZB
   vPdqrraL8RCYgG+6HIhlO1R6G4vK+UqmMAa/DcBEO+aqSiXWn/T4tZQde
   LJjxVpILZoe/UHLz8OOBp77wJpJjYOS8KwzgforkTZtMcQckBJFeQURRy
   55am00vEzxmHw8KwWMilErjIGFOtrnqLj4qSOQcvqlkvwMc3RG6KlKts7
   QiAqLX3cJHlHocHlzgAnNftwcy5s4Ylp5b8PS3E05gu4zgYWKTzkiJO/3
   QYIazrrFmp0k4STbstrCyPzZdloATyo22X/6ABy70Zjqc2CWmLnM6magC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="7541014"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="7541014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="33538663"
Received: from tofferse-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.212])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:07:15 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] drm/edid: Add a function to match EDID with
 identity
In-Reply-To: <20240307230653.1807557-3-hsinyi@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240307230653.1807557-1-hsinyi@chromium.org>
 <20240307230653.1807557-3-hsinyi@chromium.org>
Date: Fri, 08 Mar 2024 10:07:11 +0200
Message-ID: <87jzmduoy8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 07 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> Create a type drm_edid_ident as the identity of an EDID. Currently it
> contains panel id and monitor name.
>
> Create a function that can match a given EDID and an identity:
> 1. Reject if the panel id doesn't match.
> 2. If name is not null in identity, try to match it in the detailed timing
>    blocks. Note that some panel vendors put the monitor name after
>    EDID_DETAIL_MONITOR_STRING.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

The series seems good to go. Thanks Hsin-Yi and Douglas for the
constructive collaboration! I believe the end result is better now.

Thanks,
Jani.

-- 
Jani Nikula, Intel

