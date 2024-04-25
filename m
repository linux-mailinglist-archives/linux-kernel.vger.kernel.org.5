Return-Path: <linux-kernel+bounces-159141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AFA8B29D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FB41C21686
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424A39847;
	Thu, 25 Apr 2024 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzsWM7X4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FF631;
	Thu, 25 Apr 2024 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077076; cv=none; b=If+X7nva/sJYryWZMxb3GvjUBw0gMXqUoUuFmwTNR2xibRg9ld34bieydSRxy5M9h0jtwKhiN94K/whDihze/+EaxU6Z6su1eeNOdj7CyqrIjJx6/4M7PEEzNVb/J3GITWyHnV9LmCz1nJI7d2HjkeV2fszAsbtIv2z+3EkLDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077076; c=relaxed/simple;
	bh=Os/ETrNyhqvrY0Al2gTdoVvSC4IYDspRfev++Ei3nXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeS3pZxGflTswBskb4NGiE5PPzs9v6y4dA2xsz+HC3MSwMdnqbCdhkIhWGGvkWifcJiDXYkiSZHbz60UW4MfsmnyNu/VbAuerlvkqVsA9AaCBgcaD+7B58tumIo0Ibvf6ZuFTLqsvGkU+Y4jMW6xKWSZA4uBqugdbLON5YPFbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzsWM7X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46694C113CC;
	Thu, 25 Apr 2024 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714077076;
	bh=Os/ETrNyhqvrY0Al2gTdoVvSC4IYDspRfev++Ei3nXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzsWM7X4G54YvQRbsLkWUUuW6W5vNovWQIF0gpDFSwm8vrb06tXukhWaR9DOs7DH0
	 Yr5kjn+9GEiX7dhQUX5uQ99bp2nao4usQL1XHDdayCCq/QAu65OxNga/zSJ6ntYBLx
	 RASjvV9bPVVLDV7ezYeSTx2/gHWJ35Q+dl6zWAwxjeo1FocK4ZETUyL5NjXYe34si5
	 tmIPafoKkN+yukJiHFQzHfedK1JOalgAsH6bOsU3wHSa/WrMXkfxrd9fh9IY6UfA1c
	 MZPh2qYpzmXD4rfligEiNvnWgX5Dv23v/LVhK6fsWp2OmHhsDr3fF8o3X0Qf8WNO5l
	 PlyPoKTwPrjuA==
Received: by pali.im (Postfix)
	id DD30070C; Thu, 25 Apr 2024 22:31:13 +0200 (CEST)
Date: Thu, 25 Apr 2024 22:31:13 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
Message-ID: <20240425203113.eokpgdjj6hmxhdj3@pali>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240425201213.apwdxazbdbjddtpr@pali>
 <d31486b6-d71d-4985-adb1-2425f19b0b5c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d31486b6-d71d-4985-adb1-2425f19b0b5c@app.fastmail.com>
User-Agent: NeoMutt/20180716

On Thursday 25 April 2024 14:27:32 Lyndon Sanche wrote:
> On Thu, Apr 25, 2024, at 2:12 PM, Pali Rohár wrote:
> > On Thursday 25 April 2024 11:27:57 Lyndon Sanche wrote:
> >> +int thermal_init(void)
> >> +{
> >> +	int ret;
> >> +	int supported_modes;
> >> +
> >> +	ret = thermal_get_supported_modes(&supported_modes);
> >> +
> >> +	if (ret != 0 || supported_modes == 0)
> >> +		return -ENXIO;
> >> +
> >> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> >> +	if (!thermal_handler)
> >> +		return -ENOMEM;
> >> +	thermal_handler->profile_get = thermal_platform_profile_get;
> >> +	thermal_handler->profile_set = thermal_platform_profile_set;
> >> +
> >> +	if ((supported_modes >> DELL_QUIET) & 1)
> >> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> >> +	if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
> >> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> >> +	if ((supported_modes >> DELL_BALANCED) & 1)
> >> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> >> +	if ((supported_modes >> DELL_PERFORMANCE) & 1)
> >> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> >> +
> >> +	platform_profile_register(thermal_handler);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +void thermal_cleanup(void)
> >> +{
> >> +	platform_profile_remove();
> >> +	kfree(thermal_handler);
> >> +}
> >> +
> >>  static struct led_classdev mute_led_cdev = {
> >>  	.name = "platform::mute",
> >>  	.max_brightness = 1,
> >> @@ -2266,6 +2480,11 @@ static int __init dell_init(void)
> >>  		mute_led_registered = true;
> >>  	}
> >>  
> >> +	// Do not fail module if thermal modes not supported,
> >> +	// just skip
> >> +	if (thermal_init() != 0)
> >> +		pr_warn("Unable to setup platform_profile, skipping");
> >
> > I think that -ENOMEM error should be failure of the loading the driver.
> > It does not make sense to continue of memory allocation failed.
> >
> > On the other hand when the thermal modes are not support (e.g. old
> > Latitude models) then there should not be a warning message. It is
> > expected that on systems without thermal modes the setup fails.
> 
> Thank you for your feedback.
> 
> I agree with your suggestion. -ENOMEM would indicate something bigger is amiss. I can add a check:
> 
> If -ENOMEM, fail driver.
> If anything other error, skip, but do not show a message.
> 
> Lyndon

Maybe you can simplify it more. thermal_init() could return 0 also for
the case when thermal modes are not supported. And dell_init() then can
unconditionally fail when thermal_init() returns non-zero value. It has
benefit that in case thermal_init() is extended in future for some other
fatal error, it would not be required to update also caller to handle
another error (and not just ENOMEM).

