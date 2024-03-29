Return-Path: <linux-kernel+bounces-123967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0689106E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB0FB22EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD430182AF;
	Fri, 29 Mar 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elWZyTp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0203B647;
	Fri, 29 Mar 2024 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711676255; cv=none; b=crWMHPZW/SLLJUZYABRh5k73GKgLx6FR8LDpy+9lISr7F3upVHG1r8N67MvlwiNwkhxAF6HA51FInNo8ugU6nOI4e61Pv+orzfgT7Z2g2XWHnaPVytQ5Y0qJAp8nDInr+TMQJIo3sKextJSEGywdRdZ24hxSQONTWNX0r/yNfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711676255; c=relaxed/simple;
	bh=9nz+rq79FM47XfedCdMTofsLshSMR9RI7+JLZHL2fsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1wlnJ72R4BQiUs/AAGKnBkGEzzjnvTPxQHHP3QX1YoT9OFtU1iaiXJht3tr2Bc3lTWayFfTPLPUD7KESigs6vidBOtMPmb1KAFQ4t99U01Sp/KWDSxxejpQKSvdiTWZx6hSou0GtDi15JDWNXZYfyAAdJMdQ0teJ7hA8Ssg2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elWZyTp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C3AC433C7;
	Fri, 29 Mar 2024 01:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711676254;
	bh=9nz+rq79FM47XfedCdMTofsLshSMR9RI7+JLZHL2fsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elWZyTp4vpKASFETT+6ImZhX4cArtFmT4SgVYcT66iw5UG3zM2j8ZRY2C6iWskFTE
	 N1MHX2jRiHGin7GDzsKQQPYsEYYRd2dul8yjTL98n6i4nDmdWAxSGld1lyUs/c72Rk
	 aI1buygy+Rim0+oBHPyxLOLanFLG6xHd8Whivir+GaTFMxVw4dK/km3ThPRQohIGEF
	 gNi3Vj/q2cbPXR7O3bkFuC4Iahb8YBF8DTUWhULkMv2SDRg1aorF+TBLuzjVkrnrVV
	 N8ATa5eezwfWDVqA7GQFyjTfwAl9yZr2jUeiZjB6uiNAAVqPruy9I1kPcGn8sRAM8T
	 TrC6EWqS9oI8Q==
Date: Fri, 29 Mar 2024 09:37:30 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavan Holla <pholla@chromium.org>, abhishekpandit@chromium.org,
	bleung@chromium.org, chrome-platform@lists.linux.dev,
	gregkh@linuxfoundation.org, groeck@chromium.org,
	heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC
 driver
Message-ID: <ZgYbWjnFbrPWYY2j@google.com>
References: <03e1941b-0c8a-450d-9b83-76260817d303@kernel.org>
 <20240328023233.2568230-1-pholla@chromium.org>
 <2357d78f-8879-41ca-b0e1-6593400252c8@kernel.org>
 <ZgU_H4zceFlQUz8f@google.com>
 <d71c51ab-e59e-409e-bafd-22c1528c6774@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71c51ab-e59e-409e-bafd-22c1528c6774@kernel.org>

On Thu, Mar 28, 2024 at 01:16:36PM +0100, Krzysztof Kozlowski wrote:
> On 28/03/2024 10:57, Tzung-Bi Shih wrote:
> > By looking other use cases of mfd_add_hotplug_devices():
> > $ grep -R --files-with-matches mfd_add_hotplug_devices drivers/mfd/
> > drivers/mfd/dln2.c
> > drivers/mfd/cros_ec_dev.c
> > drivers/mfd/viperboard.c
> > 
> > They also have no ID tables and need MODULE_ALIAS().
> > - drivers/gpio/gpio-dln2.c
> > - drivers/i2c/busses/i2c-dln2.c
> > - drivers/spi/spi-dln2.c
> > - drivers/iio/adc/dln2-adc.c
> > - drivers/gpio/gpio-viperboard.c
> > - drivers/i2c/busses/i2c-viperboard.c
> > - drivers/iio/adc/viperboard_adc.c
> 
> So if there is a bug in some driver, you are allowed to add it? :) There
> is plenty of poor examples, so what I was suggesting to look for good
> examples. I agree that itself might be a tricky task.
> 
> > I'm not sure whether using the path results in:
> > - Lack of device ID table.
> > - Need MODULE_ALIAS().
> > in the platform device drivers.  And perhaps it relies on the fallback match?
> 
> Guys, think for a sec. If you are adding module alias being equivalent
> to platform ID table entry, then why you are not using the platform ID
> table entry in the first? That's the entire point.
> 
> So to repeat myself:
> If you need it, usually it means your device ID table is wrong (e.g.
> misses either entries or MODULE_DEVICE_TABLE()).
> 
> MODULE_ALIAS() is not a substitute for incomplete ID table.

Thanks.  I see.

Yet another example in: drivers/mfd/max8997.c and drivers/rtc/rtc-max8997.c.

We should be able to use a platform_device_id, MODULE_DEVICE_TABLE(), and
`.id_table` for matching.

If that works, I think we need to turn most MODULE_ALIAS() use cases in
drivers/platform/chrome/ to this way afterward.

