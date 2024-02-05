Return-Path: <linux-kernel+bounces-52443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3A849846
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1410D2884F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2518037;
	Mon,  5 Feb 2024 10:59:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573A418029;
	Mon,  5 Feb 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130795; cv=none; b=o/a3CRveONQv4ScFa+8PkzZwyHJlI4ahPkHvwguwu3Ud4EcjYrCwo+P028pTy88Hu3SnFSxRRDYGW/jJhSMIVWfGpAWOa+edsZOGM7geMZSzkhMban82lNsuIizQy8cs6/ebfURuWYuBioSnAu2vE5iqKBeh2uMLz4zcGjLWjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130795; c=relaxed/simple;
	bh=Ax1Wfs8fMfncrJJBBuNS3ZuGYCCrru7PPsf60KUJ6Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/S5yiR+Lk5YPzgl6j0TJiFg4hgDbrrp5EBMSOhToi0neqEO7St+QvpAC8Z5PO4tl7zH8BZEjlEcIgiVqUTmmG4jdv+/J1/bCiH69M/3anibiDMIhfAuz1ZhozUfs/Dp4x1NoV+0RApvYyZL2amT3quG2fmjaTnKjREN5Wk2Vv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 155581FB;
	Mon,  5 Feb 2024 03:00:35 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D063F762;
	Mon,  5 Feb 2024 02:59:50 -0800 (PST)
Date: Mon, 5 Feb 2024 10:59:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] perf: make pmu_bus const
Message-ID: <ZcC_nzYhFnnnvkux@FVFF77S0Q05N>
References: <20240204-bus_cleanup-events-v1-1-c779d1639c3a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-events-v1-1-c779d1639c3a@marliere.net>

On Sun, Feb 04, 2024 at 10:29:39AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pmu_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 59b332cce9e7..decd994bfca4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11434,7 +11434,7 @@ static const struct attribute_group *pmu_dev_groups[] = {
>  };
>  
>  static int pmu_bus_running;
> -static struct bus_type pmu_bus = {
> +static const struct bus_type pmu_bus = {
>  	.name		= "event_source",
>  	.dev_groups	= pmu_dev_groups,
>  };
> 
> ---
> base-commit: fdd041028f2294228e10610b4fca6a1a83ac683d
> change-id: 20240204-bus_cleanup-events-765165264090
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

