Return-Path: <linux-kernel+bounces-24848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B443082C361
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD211C224C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C36C73172;
	Fri, 12 Jan 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0lePuOed";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZaIzkr80"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972AB73169
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705076041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ygxv8Ru5TbyzMKF/Xst0+SpbVCu6NSH7oSmorHjV188=;
	b=0lePuOedlNKaxSu4plGB1eRHEWwHwPzdyzLPXhnW0E3QG+Glks7Asnooot636ljJu18MEj
	6PCwyt1dKCdfAtZtjTTzlxcFScaAxSQFuUbb0HCFOGXUmpXqVI0Do8/qI2AiYoW55ejDFP
	FG75gP+pzIwokb2eJbli4zXrgdiMmTT3apROw9pjgoUjUSLL72QJKsA0w9ZuwYsRYbEKEy
	15VXSDieIo/8SQUljwmvdzNnBOTUFGTlkE5LcLGhSAvCvVlnPsAGuJOxV5dN3iOzb4NHRl
	+4HUbEmB0izdZlIl2ojC9W+p90IkEGgP/vh4sYysT6+61KI71t6mtnY8usTFpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705076041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ygxv8Ru5TbyzMKF/Xst0+SpbVCu6NSH7oSmorHjV188=;
	b=ZaIzkr80DeMtyLRbqsZ3p6hgeUHLsHNZpHOdAfwcl0WlOIHhBenay5IA1D9gMDHIgNsuyM
	oyKr0u8wD+ntoOCg==
To: Simone Weiss <simone.weiss@elektrobit.com>
Cc: simone.weiss@elektrobit.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix UBSAN warning for subtracting ktime_t
In-Reply-To: <20231219124434.870613-1-simone.weiss@elektrobit.com>
References: <20231219124434.870613-1-simone.weiss@elektrobit.com>
Date: Fri, 12 Jan 2024 17:14:00 +0100
Message-ID: <878r4uil6f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 19 2023 at 13:44, Simone Weiss wrote:
> UBSAN: Undefined behaviour in kernel/time/hrtimer.c:612:10
> signed integer overflow:
> 9223372036854775807 - -51224496 cannot be represented in type
> 'long long int'

Some explanation about the context and why the offset is < 0 would be
helpful.

> +/*
> + * Sub two ktime values and do a safety check for overflow:
> + */
> +ktime_t ktime_sub_safe(const ktime_t lhs, const ktime_t rhs)
> +{
> +	ktime_t res = ktime_sub_unsafe(lhs, rhs);
> +
> +	if (lhs > 0 && rhs < 0 && res < 0)
> +		res = ktime_set(KTIME_SEC_MAX, 0);
> +	else if (lhs < 0 && rhs > 0 && res > 0)
> +		res = ktime_set(-KTIME_SEC_MAX, 0);

Looking at the use cases, the lhs < 0 case would be a bug because the
expiry values are strictly >= 0.

> +
> +	return res;
> +}
> +EXPORT_SYMBOL_GPL(ktime_sub_safe);

That export is needed because? The only usage is in this file so this
can be static, no?

Thanks,

        tglx

