Return-Path: <linux-kernel+bounces-108541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EE880C05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481EAB22AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77902209F;
	Wed, 20 Mar 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE7D2BU/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D32BD01;
	Wed, 20 Mar 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919755; cv=none; b=GnFgWCTm2w4jsQ0eNawJzGVRJa2XHiGJvz01M2SAGXLqB9vlvzAGcyWsESusJ0TW2kPYRR8XPoPwG0XoQ8h9o7j6NTCIW+ZwGgXomh8B39VaCe+5dTtaZC51ejEuBK9W4BCkw6YTebULMTL878Vryotn5Wxw74utoEVapctxOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919755; c=relaxed/simple;
	bh=SIJLQWAZttGxLBgmyLL6igS6AuPkYTJuC02fay6r37E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBWjF23BquCbWAL6CvAJIhC6e+RXN3T9Ckv3Hh9ZwuMJab2b3Yz+N7amFKbatu7mD0BlnpG2akyd2ca9Yty1XUwfIcdO8eXlHsOnd8qAnmGFnmqq2+hiPFelTG0Eg0gWmZgScosXFWgev4IxnDcgkE1zOsBt2NDklcRbI175/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE7D2BU/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710919753; x=1742455753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIJLQWAZttGxLBgmyLL6igS6AuPkYTJuC02fay6r37E=;
  b=jE7D2BU/YpudfW/7il6RsJ/u0w0j+jDWDYtjQObqMiLBj1KtXdXJHiYL
   Kdh9zAGLPTwj3bbnpxdloZy0wEHg4mDyxPEWwMniIGTlBbtfV2UNdUsqr
   LiTiuhZ0nK3Ed/vA4eR+HDnPwUOxvWIcwTPtsqWac5CTnizB72+grqCm0
   oRTnWWpgPLqj0MS+G80wHjuyQXyfIsN2cACaTNK0JZk7OM9WSrXS1agp9
   6Oo9dXKn+sJFnJDngwzRT0mipGS80MZDVHFOUNySfqzRezInUyZbGsy0E
   /i+usOi6tdJBrlSbizdq2Hxa7mG22ebW+Oarieh9Hg3vpv7yht6VJl0a+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9598536"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="9598536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:29:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="51507652"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:29:04 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6E3E911F853;
	Wed, 20 Mar 2024 09:29:01 +0200 (EET)
Date: Wed, 20 Mar 2024 07:29:01 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	laurent.pinchart@ideasonboard.com, shengnan.wang@mediatek.com,
	yaya.chang@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	jacopo.mondi@ideasonboard.com, 10572168@qq.com,
	hverkuil-cisco@xs4all.nl, heiko@sntech.de, jernej.skrabec@gmail.com,
	macromorgan@hotmail.com, linus.walleij@linaro.org,
	hdegoede@redhat.com, tomi.valkeinen@ideasonboard.com,
	gerald.loacker@wolfvision.net, andy.shevchenko@gmail.com,
	bingbu.cao@intel.com, dan.scally@ideasonboard.com,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 2/2] media: i2c: Add GC05A2 image sensor driver
Message-ID: <ZfqQPTgqzOw7tATK@kekkonen.localdomain>
References: <20240316025253.2300-1-zhi.mao@mediatek.com>
 <20240316025253.2300-3-zhi.mao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316025253.2300-3-zhi.mao@mediatek.com>

Hi Zhi,

Thanks for the set.

On Sat, Mar 16, 2024 at 10:52:53AM +0800, Zhi Mao wrote:
> +static int gc05a2_set_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct gc05a2 *gc05a2 =
> +		container_of(ctrl->handler, struct gc05a2, ctrls);
> +	int ret = 0;
> +	s64 exposure_max;
> +	struct v4l2_subdev_state *state;
> +	const struct v4l2_mbus_framefmt *format;
> +
> +	state = v4l2_subdev_get_locked_active_state(&gc05a2->sd);
> +	format = v4l2_subdev_state_get_format(state, 0);
> +
> +	if (ctrl->id == V4L2_CID_VBLANK) {
> +		/* Update max exposure while meeting expected vblanking */
> +		exposure_max = format->height + ctrl->val - GC05A2_EXP_MARGIN;
> +		__v4l2_ctrl_modify_range(gc05a2->exposure,
> +					 gc05a2->exposure->minimum,
> +					 exposure_max, gc05a2->exposure->step,
> +					 exposure_max);
> +	}
> +
> +	/*
> +	 * Applying V4L2 control value only happens
> +	 * when power is on for streaming.
> +	 */
> +	if (!pm_runtime_get_if_in_use(gc05a2->dev))

This should be pm_runtime_get_if_active(). Please assume it takes a single
argument (the device)---see commit
c0ef3df8dbaef51ee4cfd58a471adf2eaee6f6b3.

The same comment applies to the GC08A3 if it uses autosuspend, please post
a new patch for that.

-- 
Kind regards,

Sakari Ailus

