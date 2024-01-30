Return-Path: <linux-kernel+bounces-44018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554DA841C45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BBC1C22BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32045006;
	Tue, 30 Jan 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVztop2m"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DB537E0;
	Tue, 30 Jan 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598145; cv=none; b=q/PTmREzEUc71FY5c/oJrCqs0yXLvAhCZ2TwiuqcC1qWFso6v4IMQydni9McrOTgznChzf/A3mok6bYQNtF06Mn/8rGtNQ1jpHPJvCW9giPennhLrMC3gCXmq4NHXyt+mUxGrvNuebzAabiuoJKevvwQQsy5txMR8dWiUi7gJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598145; c=relaxed/simple;
	bh=FT1jnfuKqKM3F718W+//e/OcgVZxuXQALNqZiQba8qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVvpiKr0RHXHhpj+GZsrbBPQrzwCwce7dUT9kOs9OrpbIqHV5mjv22nEvwmOr5q6yRw2cb+wJ7vXhASohdl9fsfbBZ/t+jn9Dgr0wLZVI008Ryfk09hhO7UO4p4P6RybgMzf6PpGkQ6QyljSvN3X+yrcqbqeaPEe5YmjgEdFUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVztop2m; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706598142; x=1738134142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FT1jnfuKqKM3F718W+//e/OcgVZxuXQALNqZiQba8qE=;
  b=kVztop2mTUYi5IlEweHbjthplAzB5j/gp2r/OzHukWHQzSgULrHGixvw
   iys2FhtoBZ/QlHEdunFp1WElpRCW0D6sgEOe/8hnKdogoKyrdM++RpVqu
   9RaWn0EejEa2YS8V+GwOdkv7DpQiOFoiD8XFZpZ9p5Ei+5n260BL3Sh+e
   JepuIgRHmGr8bvkst5q7W2tBsOpEWpDr9aLhP1Nw/IHhLt7PZwUC0CMNE
   f8GQcjZbYN4b5xMGMi5UZjUahGPdJxqHNBYrNvA7Xye76H7aGrFeg64YA
   M98BO3Y8iDLISnYlcZaAg73CBfQHn4yUax/puOqs3hwP5XuwATg5FPThT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="402059455"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="402059455"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3714656"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.115])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:02:20 -0800
Date: Tue, 30 Jan 2024 08:02:17 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 02/10] PM: sleep: stats: Use an array of step failure
 counters
Message-ID: <Zbie+bepNv1xob3J@linux.intel.com>
References: <5770175.DvuYhMxLoT@kreacher>
 <2192653.irdbgypaU6@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2192653.irdbgypaU6@kreacher>

On Mon, Jan 29, 2024 at 05:11:57PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using a set of individual struct suspend_stats fields
> representing suspend step failure counters, use an array of counters
> indexed by enum suspend_stat_step for this purpose, which allows
> dpm_save_failed_step() to increment the appropriate counter
> automatically, so that its callers don't need to do that directly.
> 
> It also allows suspend_stats_show() to carry out a loop over the
> counters array to print their values.
> 
> Because the counters cannot become negative, use unsigned int for
> representing them.
> 
> The only user-observable impact of this change is a different
> ordering of entries in the suspend_stats debugfs file which is not
> expected to matter.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>    * Use one cell less in suspend_stats.step_failures[] to avoid
>      introducing an unused array cell (Stanislaw).
> 
> @Stanislaw: This is different from setting SUSPEND_FREEZE to 0, because
> that would complicate printing in the sysfs attributes and the debugfs
> code, so I've not added the R-by.

LGTM.

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> +	for (step = SUSPEND_FREEZE; step <= SUSPEND_NR_STEPS; step++)
> +		seq_printf(s, "failed_%s: %u\n", suspend_step_names[step],
> +			   suspend_stats.step_failures[step-1]);

Consider (in separate patch) removing SUSPEND_NONE from suspend_step_names[]
and use step-1 for it as well.

Regards
Stanislaw

