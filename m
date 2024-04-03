Return-Path: <linux-kernel+bounces-129646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67738896DBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2381628B291
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC4E1411FD;
	Wed,  3 Apr 2024 11:11:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0C135A5F;
	Wed,  3 Apr 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142669; cv=none; b=jjpxzGTGllgvs5ohmNJV7uvZ/u47ABW1LlN4DoHUBH3ASZz1NJaZ6mLJx/y8E3B0N1wd8R5eX9HF1NKRsAmXzzHvjQGHbFsRssEv8AtwCdjgefzgwFJecU+3nxsWS9/d2bNLQux8nt+dVNBnXbIUFR6XCfdUDWG9ibB+pxiRn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142669; c=relaxed/simple;
	bh=4opd2k4sbfLMWscrK+GbvLjqo3mlUG1uBclog3IJ87M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzoJt6xVj6Mn5jrzCzsKImNvVUmyzwuBVdEFBYdFKI3fCOJBgituvMMZL5QynwZ9OBGAQe7X3+0kWntJjhhgYeGzBNyfT3+JEgrYO2QTBvFq1RKdUhZgh+vYgfwXwOwVxd+0sZKIj31TFqK0zSbFRf8K8MlYFaht/n+rF5+18hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C4A1595;
	Wed,  3 Apr 2024 04:11:38 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 874A53F64C;
	Wed,  3 Apr 2024 04:11:05 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:10:57 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/9] perf: Avoid explicit cpumask var allocation from
 stack
Message-ID: <Zg05QZKkI9nsN0pO@FVFF77S0Q05N>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
 <ZgvoMunpbaE-x3jV@FVFF77S0Q05N>
 <190FE91C35AB9AE8+ZgwKuORh3VzTkfeJ@centos8>
 <ZgwZL679Tc1S3AxH@FVFF77S0Q05N>
 <6D6795E4D37BB843+Zg0yU8SCf+sMNYqp@centos8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D6795E4D37BB843+Zg0yU8SCf+sMNYqp@centos8>

On Wed, Apr 03, 2024 at 06:41:23PM +0800, Dawei Li wrote:
> On Tue, Apr 02, 2024 at 03:41:51PM +0100, Mark Rutland wrote:
> > Looking at this case, the only reason we need the mask is because it made the
> > logic a little easier to write. All we really want is to choose some CPU in the
> > intersection of two masks ignoring a specific CPU, and there was no helper
> > function to do that.
> > 
> > We can add a new helper to do that for us, which would avoid redundant work to
> > manipulate the entire mask, and it would make the existing code simpler.  I had
> > a series a few years back to add cpumask_any_and_but():
> > 
> >   https://lore.kernel.org/lkml/1486381132-5610-1-git-send-email-mark.rutland@arm.com/
> 
> Sounds a perfect idea!
> 
> Actually I am re-implementing new series on top of your seven-years-late-yet-still-helpful
> patch, with minor update on it:
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 1c29947db848..121f3ac757ff 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -388,6 +388,29 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
>         return i;
>  }
> 
> +/**
> + * cpumask_any_and_but - pick a "random" cpu from *mask1 & *mask2, but not this one.
> + * @mask1: the first input cpumask
> + * @mask2: the second input cpumask
> + * @cpu: the cpu to ignore
> + *
> + * Returns >= nr_cpu_ids if no cpus set.
> + */
> +static inline
> +unsigned int cpumask_any_and_but(const struct cpumask *mask1,
> +                                const struct cpumask *mask2,
> +                                unsigned int cpu)
> +{
> +       unsigned int i;
> +
> +       cpumask_check(cpu);
> +       i = cpumask_first_and(mask1, mask2);
> +       if (i != cpu)
> +               return i;
> +
> +       return cpumask_next_and(cpu, mask1, mask2);
> +}
> +
>  /**
>   * cpumask_nth - get the Nth cpu in a cpumask
>   * @srcp: the cpumask pointer
> 
> Change from your original version:
> 1 Moved to cpumask.h, just like other helpers.
> 2 Return value converted to unsigned int.
> 3 Remove EXPORT_SYMBOL, for obvious reason.

That's exactly how I rebased it locally, so that looks good to me!

> I will respin V2 as a whole as soon as possible.

Great!

Thanks,
Mark.

