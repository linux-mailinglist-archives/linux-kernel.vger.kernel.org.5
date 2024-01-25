Return-Path: <linux-kernel+bounces-39132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8B83CB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFDA29AD38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2DD1BDD6;
	Thu, 25 Jan 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f55GWPuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ptIHAsoH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DB79C7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207803; cv=none; b=Yjm/ezGKtW+YA3JMErOe00z4a0DsZW3AlAgRe1OedOt0shGGF3JGhrNJzRRbNP6SIujsFuWK7t89Flv1LEPb7eQefzFbHb26ek3guJvrfihnOIcRXp8ue4CiMWdsgjW82FvcOiTS3QViBq3uBNfIA7lbhkrpnTEx8svTyEL7ZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207803; c=relaxed/simple;
	bh=qARHZSaqiSGeXojt4AJqXiN8ri9hajGxeuZG3zAdG2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6Ci9eRTg/AQ315Ior5/bianm/8pvyzMIHLQveSBSndnCBYRA0NabxqI5KSdbDBR4r15OyEuQAhD+6NtbTsrndFbAqdGwUsi492/R5Z+rt9YRjnihgikrPdNS35tpDTzCS4ZqSbwn2sLTHx8u7cEk8oci1T/2pFuLSkrVTlPEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f55GWPuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ptIHAsoH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706207799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhnF+EHY7HLjz/LJ6Z3nEGu21jfTqc3vWX3ta02Tmqg=;
	b=f55GWPujlZygppk9QRQdEckKSPIpKY66KMsJMZCUmh9cih0SoFowtAI2M4CAxVcSumbagJ
	MJmkAsKzjxGcCuqCK5/vzUlmUkkJh3SgcLCuFr//RLBwbEkkKFnkYtll05CoPjP6uJjopn
	TTBZ1BlayXJQS6AmNu2Sm925SrWcppsznKGwI3AcxMb195ajz/KGd5lfGMJZNfNztRpzUY
	HAYBcji0+5Ih+nC5Lro0Ap4awA//jlc+sBkZh3aNVpwvdGpIETF2Ll301zrqfCZLNYQNUw
	/W6A5/GNtIlK8ic38T7Tsahe1eR/FSoGHtDVR2FodsaJNU3x6uUDHZFO6OBo0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706207799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhnF+EHY7HLjz/LJ6Z3nEGu21jfTqc3vWX3ta02Tmqg=;
	b=ptIHAsoHLzYkXSOTFSaCQg75j8Q7+xYrwNg30QULiZUO4WWqhMncqCCDe/J8nssLs+CeHT
	a475kB/o74bP/YAQ==
To: Tudor Ambarus <tudor.ambarus@linaro.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 mhocko@suse.com, dianders@chromium.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, willmcvicker@google.com,
 andre.draszik@linaro.org, peter.griffin@linaro.org,
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/irq: fix [-Wvisibility] warnings
In-Reply-To: <20240109141045.3704627-1-tudor.ambarus@linaro.org>
References: <20240109141045.3704627-1-tudor.ambarus@linaro.org>
Date: Thu, 25 Jan 2024 19:36:39 +0100
Message-ID: <87ttn1gszs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 09 2024 at 14:10, Tudor Ambarus wrote:
>  
>  #include <asm/apicdef.h>
>  #include <asm/irq_vectors.h>
> +#include <linux/cpumask.h>

Why does this need the include?

>       44 | void arch_trigger_cpumask_backtrace(const struct cpumask *mask,

That's a pointer so a simple forward declaration should work, no?

Thanks,

        tglx

