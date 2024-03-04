Return-Path: <linux-kernel+bounces-90332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADD86FDC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE751F209E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A520300;
	Mon,  4 Mar 2024 09:34:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C541B814;
	Mon,  4 Mar 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544850; cv=none; b=WUQRmjYceLixrOwhF1Dd1MkjbMUFOdAlVN9FyQHMsmH0E2XRJYRlvwh13DgsKLpzOCQ3Cur9PX2edqxVAl9KsIYUvYJgYorwfUP4OGfJUk9rgMjxas9GaZqzQfdTJ4b/KnYeokBpyY/9b0HC+4BDcN8zI1aGFXgHccPLHBv5xTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544850; c=relaxed/simple;
	bh=yOvvdN7W5EY5FGe34phRMuayj1yK5cLQ6X6H/fHvR+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLc6wg/9vB/wMm5Faux/GHAdkwbplUEyZylXS3SEBOkM9ZNzMz+jZwe6F6sxCSCr6a0ZLwbDJSpndqpIF58uraWLBGsP9LRFaQ/9S5fpR0I2VIt1yUtZQ4J9jfK7G92QEAUQqk8HHAJyetee/hpHGjF4Jtmn6S7jwO3BJhBggAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64FDD1FB;
	Mon,  4 Mar 2024 01:34:44 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB5A3F762;
	Mon,  4 Mar 2024 01:34:05 -0800 (PST)
Date: Mon, 4 Mar 2024 09:34:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/s390/perf: Register cpumf_pmu with type =
 PERF_TYPE_RAW
Message-ID: <ZeWVi6pua5QVqz_y@FVFF77S0Q05N>
References: <20240304022701.7362-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304022701.7362-1-jialong.yang@shingroup.cn>

On Mon, Mar 04, 2024 at 10:27:01AM +0800, JiaLong.Yang wrote:
> The struct pmu cpumf_pmu has handled generic events. So it need some
> flags to tell core this thing.

It's not necessary to register as PERF_TYPE_RAW in order to handle raw events,
and PERF_TYPE_RAW is not a flag.

Have you encountered a functional problem, or was this found by inspection?

Mark.

> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> index 41ed6e0f0a2a..6ba36cf50091 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
> @@ -1213,7 +1213,7 @@ static int __init cpumf_pmu_init(void)
>  	debug_register_view(cf_dbg, &debug_sprintf_view);
>  
>  	cpumf_pmu.attr_groups = cpumf_cf_event_group();
> -	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", -1);
> +	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", PERF_TYPE_RAW);
>  	if (rc) {
>  		pr_err("Registering the cpum_cf PMU failed with rc=%i\n", rc);
>  		goto out2;
> -- 
> 2.25.1
> 
> 

