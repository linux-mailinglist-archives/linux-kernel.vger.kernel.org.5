Return-Path: <linux-kernel+bounces-51802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059D848F6D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D98A1F21B8E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181F23758;
	Sun,  4 Feb 2024 16:52:58 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D92374C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065578; cv=none; b=qfRNejrjm673AgvQa1hLOhPi/Ncz+pZe4/JCvDe3AvPAzXFaBKuZTO0Op2otk5EBo4jpb+5ksyBUguyXIICgwJHPiGWy07lQFmsNZNyaET1DNASmbm3np4PsbTUZKyn7R2SB7d8SdVOvhCEmgoHBgDBu87Sm1+X8NEml7WWIXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065578; c=relaxed/simple;
	bh=K/E7ETvaj+X2Ti4ARxVdVCWTPlLP+cEd+P8iXxNB+9U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofOPwKhbPLBWtk21aWYIzSXuoYnA2G19AH2hQh6gYgZEXQqJV4jfg21ewxc/j7Css7b5/iRUoQrsk8so//ifDy6VwR/AvDTKQIdRE42Aib2R7wvlHCUfXQtbkXnzMic5YfHPGKJu5BOmmOyWvfpeKhYqeXtbCeGIt0/GrIFpepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id d5fb6ba5-c37d-11ee-b3cf-005056bd6ce9;
	Sun, 04 Feb 2024 18:52:54 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:52:52 +0200
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Joel Stanley <joel@jms.id.au>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>, Huisong Li <lihuisong@huawei.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/39] soc: Add SoC driver for Cirrus ep93xx
Message-ID: <Zb_A5H5kkxw1oiQv@surfacebook.localdomain>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-8-d953846ae771@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-ep93xx-v7-8-d953846ae771@maquefel.me>

Thu, Jan 18, 2024 at 11:20:51AM +0300, Nikita Shubin kirjoitti:
> Add an SoC driver for the ep93xx. Currently there is only one thing
> not fitting into any other framework, and that is the swlock setting.
> 
> Used for clock settings, pinctrl and restart.

..

> +static struct auxiliary_device *ep93xx_adev_alloc(struct device *parent, const char *name,
> +						  struct ep93xx_map_info *info)
> +{
> +	struct ep93xx_regmap_adev *rdev;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev)
> +		return ERR_PTR(-ENOMEM);

Use __free() ?
(You already included cleanup.h for other cases, why not using it here?)

> +	rdev->map = info->map;
> +	rdev->base = info->base;
> +	rdev->lock = &info->lock;
> +	rdev->write = ep93xx_regmap_write;
> +	rdev->update_bits = ep93xx_regmap_update_bits;
> +
> +	adev = &rdev->adev;
> +	adev->name = name;
> +	adev->dev.parent = parent;
> +	adev->dev.release = ep93xx_adev_release;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(adev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return adev;
> +}

..

> +	model = (enum ep93xx_soc_model)(uintptr_t)of_device_get_match_data(dev);

I believe Rob wants to get rid of of_device.h or at least of this call (see his
patches to convert this API to use device_get_match_data() instead).

-- 
With Best Regards,
Andy Shevchenko



