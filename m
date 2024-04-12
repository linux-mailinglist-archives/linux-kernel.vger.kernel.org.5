Return-Path: <linux-kernel+bounces-143282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182B8A36B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A711C21784
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821691509B7;
	Fri, 12 Apr 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qSSqkuGp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+6c3ifU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4514F9C6;
	Fri, 12 Apr 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952170; cv=none; b=gVDEauOoCOcPaRioQZeYfqHxK407r46jEr0KuwIWTxgkwxnNEf458oXrPPEuV+1eSjf2lWZYbZQ+qtspkuF3QfVXCPKuWwzVPMQLAGnXBsBktzKZkOuXAtkqvO/pM7aD0+YpEt1BWqMcZyEI8wH/s5k7OcvBAm/C6no0T1pYpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952170; c=relaxed/simple;
	bh=op41Sqyr8uRfLj1kuBiDgqpP5F12Vli+Jni7UAzFnxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ha8S7N8/zNu2BuEaKTuikHZcxdDKs66I2OU5X8gHTF7AFqZbo6IOc2dqgAqRMW/PBdrf+sxvW8UgLf1sQP1zLQauSaI4nTsWtBcMPhNtvHTxqPr2qcU/q+GFIOZDg65gPyXqk8g74iI003Fce8pwuail5Kkm6kkIQ23WO50Fgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qSSqkuGp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+6c3ifU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712952168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fW4TbgGzIIRwzH2FntIEg5O7YLhVW+FYjD5M9RQsevE=;
	b=qSSqkuGpvy4oJWtuxviFmMf9uBQ/v5PZ6bY5p2IrCythD0yQYK3q1Sn+TSs+odu5E/W2us
	bD9kXSlaP+3DVtTOG3FSjQgNDEn14D6bLLmzkaJIUOQvw0SzLi0t/HIyB29FmwQAwkczvI
	c+vvoSz9sftPgkNTTqFWO7d8lo9y0fX0I/ypPJeBm7sVGxFf8Yimpp3upp4cDbvSc+4g6T
	Gjk5zANXyg1YZaJL+GAumuZgDErPh1E1qOvwcksmKgrA3yguvt0POmRfKGQ/7Bz0B1ONUz
	nhPLENsBzVPRzAOWWwHFQs3Eln0Ybt/+pmrWtEDL9V/xgpnvBEezNR5CoTdX+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712952168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fW4TbgGzIIRwzH2FntIEg5O7YLhVW+FYjD5M9RQsevE=;
	b=J+6c3ifUSjkLEaL9IfdBMfoARZZPCAjA+WXQtpVQsGMsAMO8UildIYSdAjxI7dAceD/H1Z
	tj2oTBkv2gu7vbDA==
To: Pavel Machek <pavel@denx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org, maco@android.com,
 christophe.jaillet@wanadoo.fr, sean.anderson@linux.dev
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
In-Reply-To: <ZhmPpo+EI9Ce3bI1@duo.ucw.cz>
References: <20240411095419.532012976@linuxfoundation.org>
 <ZhmPpo+EI9Ce3bI1@duo.ucw.cz>
Date: Fri, 12 Apr 2024 22:02:47 +0200
Message-ID: <87edbaz6vs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 12 2024 at 21:46, Pavel Machek wrote:
>> Thomas Gleixner <tglx@linutronix.de>
>>     timers: Move clearing of base::timer_running under base:: Lock
>
> AFAICT, we don't have those NULL assignments in expire_timers in
> 4.19. Can someone doublecheck this? We also don't support PREEMPT_RT
> there.

This has nothing to do with RT.

But yes, 4.19 has the original bass::running_timer clearing which
happens at the end of handling all expired timer callbacks and that
actually happens with base->lock held.

So right, 4.19 is not affected by this.

Thanks,

        tglx


