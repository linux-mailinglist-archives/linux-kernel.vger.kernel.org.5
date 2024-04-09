Return-Path: <linux-kernel+bounces-137110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD489DD16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2BD282EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389244DA03;
	Tue,  9 Apr 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lausen.nl header.i=@lausen.nl header.b="wc7nePo9"
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B84AED6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673772; cv=none; b=Z7nBNntX965HjpL4h5DF+Fc/Yrd1sDaErHMHMR08ZJgabAiewlaqeEYXgAgTkWO77U0C8+dDuh+REnAVSx1EPoL4CMs+Y45D5nLfK0zr9SPa6oz48Z24IaWOBgH8nQ+gsrs0G1zqV8s57455LEPWFJ35+QfbFqTiBZsEYRuSPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673772; c=relaxed/simple;
	bh=WcBHAO835OpZ7Wucwr0AFDAB7jKmJePuFUm5drOOGgY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5cbEa2Txy886QOMetnJBuurTS6p0wULfubHKKngcUnJaFN03nV+z6HoWHQQmInsTFsAqv5SMGEOiPdt/MAk8oMguo0FWjJWSnBWA4UE9zw7IzXahMf5Xw3b/doUKVo4XMilzUDJeylu4gBFxbJ26FQjUx7ea6NDBIlphquqSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=fail (0-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=wc7nePo9 reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: (qmail 31948 invoked by uid 990); 9 Apr 2024 14:42:46 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 09 Apr 2024 16:42:45 +0200
Message-ID: <594fdc5a-3b09-40df-98a0-43671665e55f@lausen.nl>
Date: Tue, 9 Apr 2024 10:42:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leonard Lausen <leonard@lausen.nl>
Subject: Re: [PATCH v2 0/3] gov_power_allocator: Allow binding before cooling
 devices
To: nikita@trvn.ru, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikita Travkin <nikitos.tr@gmail.com>, regressions@lists.linux.dev
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
Content-Language: en-US
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.490661) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.919338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=WcBHAO835OpZ7Wucwr0AFDAB7jKmJePuFUm5drOOGgY=;
	b=wc7nePo90m4/dEoTfQqKRpWsmcKs0wrORamLnVXUa+5xU/Q5UTKc+dEJf2/6JMP8Oq+MDKmaXn
	4T4kIzD7nx1SHCpEN5kgcMkdBjCPA5cPw3VKx7Ky8Dbfr4/TR9SaByXns6eNSIGoQh7RFAZtKAgM
	8cd1y79tJ9wzE+8elKX+AJ+K77aNKdGg6is/swfkZkmbMJ7xf27NLPXNWcUcGBv6WoTTURFRxsIo
	o/WMrHzgDQ5bqDGPWjeDOglanQ/04/MBVEMrlzFX69eQy7xmAKp6aDTtVVfp8P1Eg4YoydjTTETl
	0XxES+ZBu4zto8ChIkWj+sgMf2+usyre1KfJ22Er48QFK0/kaZuYpE5W3rMIZ24wEgTCaz1w4zh5
	xDjs4jXVtOeCEfgYYGRA3NuUqxyGmF3ROhn07xGkhjj9gjaSv8rnxKD5yD4CR4zltHthl5ZxzfI0
	rYy7ES5LgnXtGiGXhlSutcj797widsU0CCkg9GrbCnBdxMkJG3YKW2OI8NYIxLt76c/rP75veTqf
	yGCpGPvSt1vsXeVM4axHgxA7pOpaDeH0PXE6QoG3DGK1vqHw5413/bfqvH57y45ILAyNSHa+ANVQ
	rSfa7pwFIcUm5dg3FERSNjDzW9zoK0IO1H4gkF2opDRcWm2A3dZ5ILKT6EkQqLWfD1m7nJ2WFfKr
	Y=

Hi Nikita, Hi Łukasz,

thank you for fixing the e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points earlier") and 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()") regressions as part of v6.9-rc3. As the regression was introduced in v6.8, would it be possible to include the fix in a v6.8 patch release?

Thank you
Leonard

(Resending with regressions@lists.linux.dev in CC)

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

