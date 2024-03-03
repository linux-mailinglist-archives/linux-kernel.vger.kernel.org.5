Return-Path: <linux-kernel+bounces-89757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DE86F529
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC231C21341
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97968FC09;
	Sun,  3 Mar 2024 13:35:57 +0000 (UTC)
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F54DF62;
	Sun,  3 Mar 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.87.125.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472957; cv=none; b=ZK+VobdZqtDMmtj9Mw6mSxl/KmP4ueHlwZOsAl+OrFsCk7Khb+brVC9a7ZEVnROt3SmpMx3wY9M0OZ4cSE2kGrQLlB71ffuQFBGGpH9HrUf+uFRuQWxxgZ8arsNizgAvYuIXF/Cet1D7+JcPWyADUnQHigCwmSZn6+ZyuBsb1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472957; c=relaxed/simple;
	bh=rxQYtttE67pvhkuGigdqMY8sxIQ+TwJZKtUgdqVMvOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB4m3tMcXDarDHsgNRNYEumvlvasUmlzc4HvyOVlX5x11RXkGrkxs1hdSOTTsyOjjNq59bu592d3ds1dAsEpf4EGBOEoGkIuHJA/OpqeS1nd6hKTi2JD3ig/HXCIfVERyKyJLkPxDyUxTk3kLLRzL6bMJsxBeMfiERbW0fsYSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=www.linux-watchdog.org; spf=pass smtp.mailfrom=linux-watchdog.org; arc=none smtp.client-ip=185.87.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=www.linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux-watchdog.org
Received: by www.linux-watchdog.org (Postfix, from userid 502)
	id 8C47F40A06; Sun,  3 Mar 2024 14:15:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 8C47F40A06
Date: Sun, 3 Mar 2024 14:15:22 +0100
From: gituser@www.linux-watchdog.org
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: qcom: fine tune the max timeout value
 calculation
Message-ID: <20240303131522.GA28319@www.linux-watchdog.org>
References: <20240116-wdt-v2-1-501c7694c3f0@quicinc.com>
 <2c4f9829-138d-41a5-8810-d13cf749fded@roeck-us.net>
 <67ed3805-40cb-4f00-9d0d-b0fd012d6221@quicinc.com>
 <9f084781-2233-4b36-8b1c-db1fa9a9db49@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f084781-2233-4b36-8b1c-db1fa9a9db49@quicinc.com>
User-Agent: Mutt/1.5.20 (2009-12-10)

Ji Kathiravan,

> 
> On 2/3/2024 12:07 PM, Kathiravan Thirumoorthy wrote:
> >
> >
> >On 1/16/2024 8:32 PM, Guenter Roeck wrote:
> >>On 1/16/24 00:22, Kathiravan Thirumoorthy wrote:
> >>>To determine the max_timeout value, the below calculation is used.
> >>>
> >>>    max_timeout = 0x10000000 / clk_rate
> >>>
> >>>cat /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
> >>>8388
> >>>
> >>>However, this is not valid for all the platforms. IPQ SoCs starting from
> >>>IPQ40xx and recent Snapdragron SoCs also has the bark and bite
> >>>time field
> >>>length of 20bits, which can hold max up to 32 seconds if the clk_rate is
> >>>32KHz.
> >>>
> >>>If the user tries to configure the timeout more than 32s, then the value
> >>>will be truncated and the actual value will not be reflected in the HW.
> >>>
> >>>To avoid this, lets add a variable called max_tick_count in
> >>>the device data,
> >>>which defines max counter value of the WDT controller. Using
> >>>this, max-timeout
> >>>will be calculated in runtime for various WDT contorllers.
> >>>
> >>>With this change, we get the proper max_timeout as below and restricts
> >>>the user from configuring the timeout higher than this.
> >>>
> >>>cat /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
> >>>32
> >>>
> >>>Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> >>
> >>Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> >
> >Guenter / Will, Can this be picked for v6.9? I don't see this in
> >linux- next yet, so please consider this as a gentle reminder!
> 
> 
> Guenter / Will, Gentle Reminder... is this change queued for v6.9?

Yes, it is.

Kind regards,
Wim.


