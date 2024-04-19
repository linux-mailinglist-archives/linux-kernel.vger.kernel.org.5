Return-Path: <linux-kernel+bounces-151702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586128AB24E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB91A1F23BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3D130AD3;
	Fri, 19 Apr 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCoVBgtJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C3130A4C;
	Fri, 19 Apr 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541762; cv=none; b=MAqtY/GekxuVAf/PrIG7RG6lTWhpZkkDBmjsYuurMJN1qy17xA8dMBTJv47KIMLn8w68SJQiHf3YecYiS5sStrduh4FY/NHu/XkdQwCk8tzDoiGqQv8Qiq1KTzqWE2BCJ42iBUaW1F3M0DmpM1zTPwDJBLfckph+05WHzU/4Io0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541762; c=relaxed/simple;
	bh=TTsrsLTEbA91sWgljrri+dhf/sihEuA67rqO4RBzqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEANpU6qBHvfiCXar9NEFti90rWAP3EZ8lQBmozYcX530Vh10HetE2HiH61tKQzFr9WT/w8PRmgtB/m5jrmoUeKsWgT0c2khuGFnZ7n5tlN6UL72u+3ewkrtOtFhayIOuQxR4Tplrle8S8OyJCSe2+akxtEdEZ2wB9Js+DI2o2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCoVBgtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133AEC3277B;
	Fri, 19 Apr 2024 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541761;
	bh=TTsrsLTEbA91sWgljrri+dhf/sihEuA67rqO4RBzqZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCoVBgtJvZLBFra+EAciHe3qFAsIm44f6/jXeaY6qe2KozPaU0pjDARbPy0vUaGeM
	 btnGBwql5BxPVWS1O7Sl5Z69AGoWfqK2RELG75fhBxMI5y7BEK4Nc14D1aEyjTBw1k
	 YUOAvI2KuGqPfzVC3Hj6wEBalKYrIa2SzMXZDUGJzdQ+PPGM6YJda5NoO5l/SV4idj
	 baU2F9ULMQ715P4R91YLmDUtKkUexTK+c+/EKfv8bC4+TsssBy1FimQliT+YXDDtS4
	 lrh/JAMUwWWRCS/dc7aG0O/C7Cb/6VSTHTu+asOmexY0rZCxyscsJ+Sr6eLrN8oMlh
	 R0q0rq2A6S2LQ==
Date: Fri, 19 Apr 2024 16:49:13 +0100
From: Will Deacon <will@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: frank.li@nxp.com, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v10 3/8] perf: imx_perf: let the driver manage the
 counter usage rather the user
Message-ID: <20240419154913.GA3983@willie-the-truck>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
 <20240415061320.3948707-3-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415061320.3948707-3-xu.yang_2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 15, 2024 at 02:13:15PM +0800, Xu Yang wrote:
> In current design, the user of perf app needs to input counter ID to count
> events. However, this is not user-friendly since the user needs to lookup
> the map table to find the counter. Instead of letting the user to input
> the counter, let this driver to manage the counters in this patch.
> 
> This will be implemented by:
>  1. allocate counter 0 for cycle event.
>  2. find unused counter from 1-10 for reference events.
>  3. allocate specific counter for counter-specific events.
> 
> In this patch, counter attr will be kept for back-compatible but all the
> value passed down by counter=<n> will be ignored. To mark counter-specific
> events, counter ID will be encoded into perf_pmu_events_attr.id.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v6:
>  - new patch
> Changes in v7:
>  - no changes
> Changes in v8:
>  - add Rb tag
> Changes in v9:
>  - keep 'counter' attr for back-compatible
> Changes in v10:
>  - add some explanation about 'counter' attr in commit message
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
>  1 file changed, 100 insertions(+), 68 deletions(-)

[...]

> @@ -245,8 +249,8 @@ static const struct attribute_group ddr_perf_events_attr_group = {
>  	.attrs = ddr_perf_events_attrs,
>  };
>  
> -PMU_FORMAT_ATTR(event, "config:0-7");
> -PMU_FORMAT_ATTR(counter, "config:8-15");
> +PMU_FORMAT_ATTR(event, "config:0-15");
> +PMU_FORMAT_ATTR(counter, "config:16-23");

Although these mappings are advertised in sysfs, I don't think we can
change them because userspace could be relying on them. I also can't
find any examples of other PMU drivers in the kernel changing these
mappings after being merged, so please keep tthem the same.

If you need to expand the properties to be 16-bit, then you'll need to
split them into 2x8-bit fields.

Will

