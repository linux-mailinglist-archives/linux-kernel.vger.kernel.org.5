Return-Path: <linux-kernel+bounces-153754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D688AD2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D74AB25240
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C81DDE9;
	Mon, 22 Apr 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4I54mjy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFD15380C;
	Mon, 22 Apr 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804721; cv=none; b=HpAMKeiLiZd6sNgA70W4aoQ9WfdYvphbjcVoGc6TS+0fWx9kvWFXjmCCspJU2DHc8iox6MbAebhOZWwww/Sh+SqU5Pa9cUb90RGMPXFKmWr6qSc8BoSW/prX618dVFv2r/wTiKmFE6uilfR3IjxG4mbVmm42To/Sll6o47/bnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804721; c=relaxed/simple;
	bh=h8F8EuYbd7584tEXjUGiNOmKoWLUFleWwMYlcYorZjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfAMShxZp1zM7BfR5al+YNDJWbwKfZmR1oQo7NGE31+ZohQNTM6wOVD6qa+30anDD+CRe2cnMK5KFiV3dVMM/1BD9vVHMYRiLfWVeaolUYel8I80qIl6cW097EPXkNBeejhIwgUcZrPvScjHeiUPRCspmC56u4RIJdz5ApaJMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4I54mjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3279C113CC;
	Mon, 22 Apr 2024 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804721;
	bh=h8F8EuYbd7584tEXjUGiNOmKoWLUFleWwMYlcYorZjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4I54mjy3CF/KJobgFwnl6Tz3ZPF2zTZrMBkZQYDrK5PAFniIBGn9Z7mypad214pG
	 hkc5jwBf/5LcpMsPJQ9eqm08syVLqsmLLZLvm5N5lVcdBcRrRktO2AD7521w7wFaOH
	 wmqZnqdNoBFc8D2AQCuApqk8/+rFBFciuxJUMaR+L90ccOUcNG+DpdD3+O1S0WpZfI
	 x9o5Y46czy4qAGmwnvz/YNMcSplOWrh8YfKb7KfUdTFJZBEO2ef/ffjZlPqkFGgu2w
	 mturPN2laKyBDHwoMZcv5qsBwisfxJBVQ2kvq8zAlYo7mMD5j1x/N1Y5vqyulo5xwB
	 y8PCwIDI4mSHw==
Date: Mon, 22 Apr 2024 17:51:53 +0100
From: Will Deacon <will@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, mark.rutland@arm.com, robh+dt@kernel.org,
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
Message-ID: <20240422165153.GA6223@willie-the-truck>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
 <20240415061320.3948707-3-xu.yang_2@nxp.com>
 <20240419154913.GA3983@willie-the-truck>
 <ZiK6G3aM+K92lq0w@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiK6G3aM+K92lq0w@lizhi-Precision-Tower-5810>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Apr 19, 2024 at 02:38:19PM -0400, Frank Li wrote:
> On Fri, Apr 19, 2024 at 04:49:13PM +0100, Will Deacon wrote:
> > On Mon, Apr 15, 2024 at 02:13:15PM +0800, Xu Yang wrote:
> > > In current design, the user of perf app needs to input counter ID to count
> > > events. However, this is not user-friendly since the user needs to lookup
> > > the map table to find the counter. Instead of letting the user to input
> > > the counter, let this driver to manage the counters in this patch.
> > > 
> > > This will be implemented by:
> > >  1. allocate counter 0 for cycle event.
> > >  2. find unused counter from 1-10 for reference events.
> > >  3. allocate specific counter for counter-specific events.
> > > 
> > > In this patch, counter attr will be kept for back-compatible but all the
> > > value passed down by counter=<n> will be ignored. To mark counter-specific
> > > events, counter ID will be encoded into perf_pmu_events_attr.id.
> > > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > 
> > > ---
> > > Changes in v6:
> > >  - new patch
> > > Changes in v7:
> > >  - no changes
> > > Changes in v8:
> > >  - add Rb tag
> > > Changes in v9:
> > >  - keep 'counter' attr for back-compatible
> > > Changes in v10:
> > >  - add some explanation about 'counter' attr in commit message
> > > ---
> > >  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
> > >  1 file changed, 100 insertions(+), 68 deletions(-)
> > 
> > [...]
> > 
> > > @@ -245,8 +249,8 @@ static const struct attribute_group ddr_perf_events_attr_group = {
> > >  	.attrs = ddr_perf_events_attrs,
> > >  };
> > >  
> > > -PMU_FORMAT_ATTR(event, "config:0-7");
> > > -PMU_FORMAT_ATTR(counter, "config:8-15");
> > > +PMU_FORMAT_ATTR(event, "config:0-15");
> > > +PMU_FORMAT_ATTR(counter, "config:16-23");
> > 
> > Although these mappings are advertised in sysfs, I don't think we can
> > change them because userspace could be relying on them. I also can't
> > find any examples of other PMU drivers in the kernel changing these
> > mappings after being merged, so please keep tthem the same.
> > 
> > If you need to expand the properties to be 16-bit, then you'll need to
> > split them into 2x8-bit fields.
> 
> I just see tools/perf/tests/pmu.c: { "krava01", "config:0-1,62-63\n", }
> So I supposed "config:" supported below format
> 
> PMU_FORMAT_ATTR(event, "config:0-7,16-19");
> 
> I just want to confim with you because I have not found other perf driver
> using such format yet.

Oh, wow, that's new syntax for me too! Does the perf tool parse it
properly? (and what happens if an older tool sees the new syntax?)

Will

