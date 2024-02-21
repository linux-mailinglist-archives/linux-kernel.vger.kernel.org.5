Return-Path: <linux-kernel+bounces-75188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE5285E46B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008061F25CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54ED839F4;
	Wed, 21 Feb 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41RCnjsy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z8D6Mi/H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A633F7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536013; cv=none; b=EmpzULyDG0Tz3bdgp40NyS/N7qvnPC0LQzkMdZUFtrwJt4vz7950khI4o8OBrgMKKLY2FITiwSXU6zhGYm7M42djqkZjn0RJskjxUG7R+FG6tAVS6OOzqpplWfwjBmSwHd1lSBKFkShwN1ZhPSQ1DaF92kfhATVmMuGLMZRP4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536013; c=relaxed/simple;
	bh=++9n50pQO7aqp8TegiEiO0jfaK/HiXc23sT1u5Ch4O0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HBlFVrZw3M/a5nA9Qf4FAxTwuUx3gLDCvtTJz5EDiwutcAQR2nz2mCeEJq1xY4YZlUJVdtqxLP/5z95Ql2SsYv2/37RSm8tIPheGWBhbKgIYMspXrdI5XmWpU1qTSN6Dy5k4sdXxq0xsWBADDWGu00SZZLJpewKwV+TTDFkb+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41RCnjsy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z8D6Mi/H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708536010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ac5Ts2okIGt76uSF8yzJLI8Lv0A+lkmpdYSHwg+CsDI=;
	b=41RCnjsy9GqzjI/EjAsG2Nl9Ul1+jqA2nHNhXS8hB6moxhF9XZeGeXr28VfbaRtQRcw3B/
	HuRljZovpK0SxkJKOTKR0/nnNhuIZmZtZZr1qq7cjnWsk1GyUEw9GzKXkrG5IwTMthyVTM
	YW//30Z+5th12Q7SHF/+UoqybGxQLX1fUcH8djgX56uqUfrXi4kGQaePSU4U3h6I/Oz6Al
	931KK7nl7ymoAHsYKYXbbXTpDZ96WilEUE6nYB7FTR0z1TBAki33izo7q80ebWLijlPjqG
	dtOKJjKMLSmGcXBBJYbdZWx4F3gy7Z1j6T3lo02xozqV2GHGvXZRbdOSkIgeLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708536010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ac5Ts2okIGt76uSF8yzJLI8Lv0A+lkmpdYSHwg+CsDI=;
	b=Z8D6Mi/HPHEfVUXBpyqGEv8BJHjpHfRLCLrF0VnOUNM3m0xGvYWSuXF3WLZAc9UFwC/Ov3
	v2OkPqho2uV/koCA==
To: "Gupta, Nipun" <nipun.gupta@amd.com>, gregkh@linuxfoundation.org,
 maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc: git@amd.com, harpreet.anand@amd.com, pieter.jansen-van-vuuren@amd.com,
 nikhil.agarwal@amd.com, michal.simek@amd.com, abhijit.gangurde@amd.com,
 srivatsa@csail.mit.edu
Subject: Re: [PATCH v7] cdx: add MSI support for CDX bus
In-Reply-To: <929bf3bd-fb5a-4d1d-aa46-a5ce43ce574b@amd.com>
References: <20240202113811.2546311-1-nipun.gupta@amd.com>
 <877cj0a4fj.ffs@tglx> <929bf3bd-fb5a-4d1d-aa46-a5ce43ce574b@amd.com>
Date: Wed, 21 Feb 2024 18:20:09 +0100
Message-ID: <87wmqxg2eu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024 at 18:10, Gupta, Nipun wrote:
> On 2/19/2024 8:26 PM, Thomas Gleixner wrote:
>>> +int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = msi_setup_device_data(dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
>>> +					  0, irq_count - 1);
>>> +	if (ret)
>>> +		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);
>> 
>> Why does this need a special allocation function instead of setting the
>> irq domain of the device and using the generic allocation function
>> directly?
>
> Do you suggest we call msi_setup_device_data() during the 
> cdx_device_add() in the CDX bus where we also assign the IRQ domain to 
> the device; so CDX device driver can directly call 
> msi_domain_alloc_irqs_range() API to allocate the IRQs?

That sounds about right. It avoids doing it in the drivers and does not
require a special function. Maybe an inline wrapper to convert the
simple count to the range required.

>>> +
>>> +#ifdef GENERIC_MSI_DOMAIN_OPS
>>> +	/* Set the device Id to be passed to the GIC-ITS */
>>> +	info->scratchpad[0].ul = dev_id;
>>> +#endif
>> 
>> Is this ever used on a platform which does not have
>> GENERIC_MSI_DOMAIN_OPS ?
>
> This was added to enable the COMPILE_TEST.

Ah. Ok.

Thanks,

        tglx

