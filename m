Return-Path: <linux-kernel+bounces-122737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BB88FC43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191EB1F2F729
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B627BB14;
	Thu, 28 Mar 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXgyvBwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872B1E861;
	Thu, 28 Mar 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619875; cv=none; b=Dvax0G97bfo9bb6+fqCO3Jq9rrh3fHi7dcTr6eS7bP5xHuy0tTWj7eSV8FozglJO9pwc5hclY2TRojkeU7Q5jxguvBtX9sYnO9PdawSPa9Pnjbx1A+ySQl9kcIEv9GmkPoLJEycSpE2VsBgBRHcLD1+6DR8C0IypLxFPKSYEYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619875; c=relaxed/simple;
	bh=gAV+gUAqBp1S3zdGcOLRkMbsJPo5TaCr0FKPbsZ46M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyyyZbOtVSeupijBzVhmVyrWn8qL0sMTYmq1HtyRCgVjSeW0nsME/6aK8zyq+VIBjgUj4Jtjyb2JGeP7xjutUWtETpUuIE9mD7fzHCGRTFwZWXtLKnNLSRTCQEg5nRZzXw3ZkC2q0MakOkSCMvVYBkfmvOIx/bx7MggLtu8tHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXgyvBwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8482DC43141;
	Thu, 28 Mar 2024 09:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619875;
	bh=gAV+gUAqBp1S3zdGcOLRkMbsJPo5TaCr0FKPbsZ46M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXgyvBwNntZvsvohR9Dm+YUIE+XMILsRnEWVZYQ38z496oWWeT55HpERyihmNKCeL
	 5NkIvQB1YyeF80qtVNVneOnagDmWOiNMG/Cs9SsTLsmsWBszi65yo9Nm/msBWCZCrd
	 pxDTFHr4wiNgpnZu/Kj17LAVwK+6nvpPZgLXodjaRRHgUEUFMCb/DijwI+Bb/8WtnE
	 C0WfyQ/LHZ8s1PL0o1axUm+p7O+LNQwA83wlEtwhxXAvTeH072vh+OMkwmGBklJrGv
	 MXollRy5sBRX0cMQarT9x8nGbTYZyGn8mB57RGKCUD+AFkW/ooZAcBAdYJRguW5IUl
	 ZrW2Po7qioj3w==
Date: Thu, 28 Mar 2024 17:57:51 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavan Holla <pholla@chromium.org>, abhishekpandit@chromium.org,
	bleung@chromium.org, chrome-platform@lists.linux.dev,
	gregkh@linuxfoundation.org, groeck@chromium.org,
	heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC
 driver
Message-ID: <ZgU_H4zceFlQUz8f@google.com>
References: <03e1941b-0c8a-450d-9b83-76260817d303@kernel.org>
 <20240328023233.2568230-1-pholla@chromium.org>
 <2357d78f-8879-41ca-b0e1-6593400252c8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2357d78f-8879-41ca-b0e1-6593400252c8@kernel.org>

On Thu, Mar 28, 2024 at 09:36:54AM +0100, Krzysztof Kozlowski wrote:
> On 28/03/2024 03:32, Pavan Holla wrote:
> > On Tue, Mar 26, 2024 at 9:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 27/03/2024 04:39, Pavan Holla wrote:
> >>> Hi Krzysztof,
> >>>
> >>> Thanks for the review.
> >>>
> >>> On Tue, Mar 26, 2024 at 1:47 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>> Nothing improved.
> >>>
> >>> Yes. I only added maintainers of drivers/platform/chrome in v2. I am
> >>> still investigating why MODULE_ALIAS() is required.
> >>
> >> Heh, I wrote why. You miss ID table.
> > 
> > This driver is going to be used by the cros_ec_dev.c MFD. The UCSI device doesn’t
> > have an ACPI or OF entry, so I am not sure how I can use MODULE_DEVICE_TABLE
> > here. If I don’t use MODULE_ALIAS(“platform:” DRV_NAME),
> > https://elixir.bootlin.com/linux/latest/source/drivers/mfd/cros_ec_dev.c#L206
> > isn’t able to automatically associate the driver with the device at boot.
> > I haven’t upstreamed the change in cros_ec_dev.c yet, but the code is similar to
> > existing code for drivers/platform/chrome/cros_usbpd_logger.c. There are many
> > other occurrences of the same MODULE_ALIAS pattern:
> 
> Just open other platform drivers and look how it is done there. Or ask
> colleagues. There is absolutely no one in entire Chromium/google who
> ever wrote platform_driver? platform_driver has ID table for matching.
> 
> Otherwise how do you expect this to be matched? How your driver is being
> matched and device bound? By fallback, right? So what is the primary method?

Those platform devices are adding in drivers/mfd/cros_ec_dev.c via
mfd_add_hotplug_devices().

By looking other use cases of mfd_add_hotplug_devices():
$ grep -R --files-with-matches mfd_add_hotplug_devices drivers/mfd/
drivers/mfd/dln2.c
drivers/mfd/cros_ec_dev.c
drivers/mfd/viperboard.c

They also have no ID tables and need MODULE_ALIAS().
- drivers/gpio/gpio-dln2.c
- drivers/i2c/busses/i2c-dln2.c
- drivers/spi/spi-dln2.c
- drivers/iio/adc/dln2-adc.c
- drivers/gpio/gpio-viperboard.c
- drivers/i2c/busses/i2c-viperboard.c
- drivers/iio/adc/viperboard_adc.c

I'm not sure whether using the path results in:
- Lack of device ID table.
- Need MODULE_ALIAS().
in the platform device drivers.  And perhaps it relies on the fallback match?

