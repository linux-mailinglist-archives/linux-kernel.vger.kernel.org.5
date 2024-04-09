Return-Path: <linux-kernel+bounces-137130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D289DD4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549DD1F276B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13350275;
	Tue,  9 Apr 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lausen.nl header.i=@lausen.nl header.b="YX28zyeO"
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9A50A62
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674130; cv=none; b=d+cUtoe05J+WF6mcoHRaTUmsLmfxJcfuDbzVK8J0x4vwcbRLED24lpkizlfny99/ScQBTwOU8ALmxlP2c/csXuoJof2vH6jXHiloOWujYllJrwiE6nyRs4KM0AwziWFSH8giZ5aoGedZsvhEP7yh6zkov6NwvPEkeb4Xuor8zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674130; c=relaxed/simple;
	bh=bSBMOSEIwri42I+EM+PyX9ZK5/mVrNAM53JMXpJiGrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAT/N0gKPMY/+vxT53UFiZ8ds5pkkoNfX5yfrNxvg98OBLpszTP7Nh+52ZhnmObGICngxMgX1KJKkJ1Jh0yIXaSBto4sQ5C0FQrPqYYME1XBmQT6mpBX1f8Tvh9KwFf8yO1NF5JB6cK1uHA8s5HtJjoXBMGF/M5Q1gaQ/HhwdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=fail (0-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=YX28zyeO reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: (qmail 31281 invoked by uid 990); 9 Apr 2024 14:42:05 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 09 Apr 2024 16:42:04 +0200
Message-ID: <18a16fcd-3ae1-48af-94ed-72700a656e8e@lausen.nl>
Date: Tue, 9 Apr 2024 10:41:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gov_power_allocator: Allow binding before cooling
 devices
Content-Language: en-US
To: nikita@trvn.ru, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikita Travkin <nikitos.tr@gmail.com>
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
From: Leonard Lausen <leonard@lausen.nl>
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.348686) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.061313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=bSBMOSEIwri42I+EM+PyX9ZK5/mVrNAM53JMXpJiGrY=;
	b=YX28zyeOtVRG3iXskkpsZdlPIRqBHVYU6I9cNBc3xLfDDE33JZLNx6dw+qLb8GvYKmgv711jor
	+QGFuFRR0+cGrngBvCKAnLs+kgzAsKk4vXkJJNRjWgrM4DZIVPS8ZUZ0/kzCBZAHjLkbWDCYYd/T
	a66wcx6AFaW4geAPdDOVjf2XvrZMj3UmZS1H076oT0/Ro4G3Etz3Zr7LTg8bxlbRpW2hQeYEZlov
	MbbTPyUAapELfJIGPLL8ZFAjlDB+Kbw6iuGfKE03QV5IbtzVLt0ITYiKHAgjpck2xIk/JJu6c3qf
	sH3LfY/6hjeEuytbmU/PFn/GZx4DujcrAsEtL5YgQDdphl5pS+CAAzZW1jRFviZjzDUHVE+LXkod
	YeKhJ+ch+cIZfVZfdoLxSkt0l87oLPO94LSQwbHJa+Y/wEq19q7g3eE6eaU807uZQCAqWSCkbEJJ
	dLBOQ/XnAgElQb5it2xk8Ea3qz4z2AnDK+DrN/gLwGEeETepW5AwJclqvsgP4rimCuDVVKZIGcRZ
	wkKHDaT2eaCWx2Rq77++IqwPJPbqx+XaroVgA1CbIIwGrWziCtaCzgsyZmqtC2BW7UemqJmLjWBT
	eWIxbFMSWSejefQzjqExPUM6/h4599p0e1/+fg0RKrV5JS48xRsswn3JIcQvfgsFLj+d3E0kntey
	U=

Hi Nikita, Hi Łukasz,

thank you for fixing the e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points earlier") and 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()") regressions as part of v6.9-rc3. As the regression was introduced in v6.8, would it be possible to include the fix in a v6.8 patch release?

Thank you
Leonard

#regzbot introduced: 912e97c67cc3f333c4c5df8f51498c651792e658
#regzbot fixed-by: 1057c4c36ef8b236a2e28edef301da0801338c5f


#regzbot introduced: e83747c2f8e3cc5e284e37a8921099f1901d79d8
#regzbot fixed-by: da781936e7c301e6197eb6513775748e79fb2575

On 4/3/24 07:31, Nikita Travkin via B4 Relay wrote:
> Recent changes in IPA made it fail probing if the TZ has no cooling
> devices attached on probe or no trip points defined.
> 
> This series restores prior behavior to:
> 
> - allow IPA to probe before cooling devices have attached;
> - allow IPA to probe when the TZ has no passive/active trip points.
> 
> I've noticed that all thermal zones fail probing with -EINVAL on my
> sc7180 based Acer Aspire 1 since 6.8. This series allows me to bring
> them back.
> 
> Additionally there is a commit that supresses the "sustainable_power
> will be estimated" warning on TZ that have no trip points (and thus IPA
> will not be able to do anything for them anyway). This allowed me to
> notice that some of the TZ with cooling_devices on my platform actually
> lack the sustainable_power value.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> Changes in v2:
> - Split to two changes (Lukasz)
> - Return 0 in allocate_actors_buffer() instead of suppressing -EINVAL
>   (Lukasz)
> - Add a change to supress "sustainable_power will be estimated" warning
>   on "empty" TZ
> - Link to v1: https://lore.kernel.org/r/20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru
> 
> ---
> Nikita Travkin (3):
>       thermal: gov_power_allocator: Allow binding without cooling devices
>       thermal: gov_power_allocator: Allow binding without trip points
>       thermal: gov_power_allocator: Suppress sustainable_power warning without trip_points
> 
>  drivers/thermal/gov_power_allocator.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> ---
> base-commit: 727900b675b749c40ba1f6669c7ae5eb7eb8e837
> change-id: 20240321-gpa-no-cooling-devs-c79ee3288325
> 
> Best regards,

