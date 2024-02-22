Return-Path: <linux-kernel+bounces-76494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836B85F7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AFF1C22C26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F5A605CD;
	Thu, 22 Feb 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxynINXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FEF4776E;
	Thu, 22 Feb 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604327; cv=none; b=EDLg7nzsaGHbxviNts+58FUsr1uuuOirDrYkpL+tR5bxoikSPwZz0zXRvZmj63S4YT1ncOEMTCsNY23MALyC92b+7dLCRBdU8HhHPcfcXUe0DFugKvZK956PuZaMmin5uMofEY39Cwbx/F+BJP+SqR9CEYrj/cDDiqIUXSIkTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604327; c=relaxed/simple;
	bh=lXEIG8Yh0DgsjWjqS6TtqjvsNB92LqQdH9NNSBnF+H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Blx2Kjzs0a8OCyYUGrHjl7dQhO41J+drkFg6bJCMbcWUDRIdLfPyUJtYJ3Au1IuP3MorOqAcaE6fetjEkSKyEzIQfQoWfFjTlXmoN9L0+tKUiXIPpix0XwYM3IOOEQM7AlqNjw6U8xOuKf1xi+Mx1oeY3YWPf9sxgMr835N95Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxynINXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDA3C433C7;
	Thu, 22 Feb 2024 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604327;
	bh=lXEIG8Yh0DgsjWjqS6TtqjvsNB92LqQdH9NNSBnF+H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxynINXWm88A4QHPt46s7Sap1xtFkJICI62sepLQMB5exKnWDLhsI3Mjc+tr+D7TV
	 5SBcizXDvqkcdnYuyhilXvjJ6LLXFyz896yZnfT6UUstgFDPL1xRHvyYwRUIlpuYXn
	 u12EPPruDXaCRei662gS2j1++JDz2qSRKj4TIspDUjOQd/2gyWy2ILDDsAvIDr8iLq
	 bxx1C/eqiKDse3dCLMh3O3wwTJRZLO8VyT3y3GYcZd2324S1Jtut7FMCQS1EF5X+0P
	 t/5iWs9lSDKNL7tK33NUOEdUAvSmqYHgA27gsSOZCdu3W0RIo9IshLQj2X90A/LUCQ
	 4RaQ76tY7Luog==
Date: Thu, 22 Feb 2024 12:18:38 +0000
From: Will Deacon <will@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, linux-imx@nxp.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 2/6] perf: imx_perf: refactor driver for imx93
Message-ID: <20240222121838.GA8308@willie-the-truck>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-2-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055811.3035741-2-xu.yang_2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 01:58:07PM +0800, Xu Yang wrote:
> This driver is initinally used to support imx93 Soc and now it's time to
> add support for imx95 Soc. However, some macro definitions and events are
> different on these two Socs. For preparing imx95 supports, this will
> refactor driver for imx93.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - new patch
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 121 ++++++++++++++++++++++---------
>  1 file changed, 87 insertions(+), 34 deletions(-)

[...]

> @@ -476,12 +490,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	hwc->idx = counter;
>  	hwc->state |= PERF_HES_STOPPED;
>  
> +	/* read trans, write trans, read beat */
> +	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
>  
> -	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> -
>  	return 0;

This change looks like more than just refactoring and should probably be a
separate patch. Is it a bug fix for the existing code?

> +static int ddr_perf_add_events(struct ddr_pmu *pmu)
> +{
> +	int i, ret;
> +	struct attribute **attrs = pmu->devtype_data->attrs;
> +	struct device *pmu_dev = pmu->pmu.dev;
> +
> +	if (!attrs)
> +		return 0;
> +
> +	for (i = 0; attrs[i]; i++) {
> +		ret = sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i], "events");
> +		if (ret) {
> +			dev_warn(pmu->dev, "i.MX9 DDR Perf add events failed (%d)\n", ret);
> +			return ret;

Can you use the '.is_visible' callback in 'struct attribute_group' to avoid
having to manipulate sysfs directly like this? For example, create separate
groups for the imx93 and imx95-specific events and only make them visible
if we're on the appropriate hardware.

Will

