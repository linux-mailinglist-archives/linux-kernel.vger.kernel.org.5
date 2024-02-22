Return-Path: <linux-kernel+bounces-76502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DCF85F806
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E128A186
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EBC60B89;
	Thu, 22 Feb 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUrBL9Ys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0F42068;
	Thu, 22 Feb 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604582; cv=none; b=m/4NW9RPuGPABENDWyYCDuNtLrYcFbe+7XdzWV4NPTbNNwltxmYCk4/iWkdFKmwW375EmH8tIBrzPBEvqXP7ZsF3BXOyjgw0cTHQSU4a/F7Hx8+EImNW7DcBB/CXM9t2Txn2xG7gXxRIEx8EoRmSpGwCNqP+280n8gWSRJ6Sh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604582; c=relaxed/simple;
	bh=6wJgf2HatJEJcszKI88ReQlR4/Yjo4EZ/8w2BnnuKRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8c1nRPgXODUVJrV5zNz5J4p6z0MQuy34dBTvB8/nIVlK5q982XpXpeCGYR3KD0lvqEhJVJ54nNKN9QGZCZZeBvGJCea16B//MgtTD8j1RQ3+gx4u2MWnpPPeDRgPZB2P2km4cuuPpkzkqHn3Cs50cJYXZoAWskIhkOfhwmAEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUrBL9Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E1EC433F1;
	Thu, 22 Feb 2024 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604582;
	bh=6wJgf2HatJEJcszKI88ReQlR4/Yjo4EZ/8w2BnnuKRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUrBL9YsF5oWH8Byth4FYXrrmtWEljPp5c2nrjS9BTKx0UY/qp6I8nyMkqYnAH5ZJ
	 39MTw3gr0pBMsBnNSZa8tiB4murGXLRG1XrB+2AjfsXsiD16SgIzRXZiDnyDa5GbrT
	 HOqChs4nlRBBu4x+OvxkGRyfUthpeGx7QlSYVhmkth9SourBHXvoqEg9viaOgdAt3C
	 qhgTx/BbSQ1ASS1JnUY7DWx+IYREyjGU6LaeAaNhNvQfi67NSnTvGpAHWAIWBBWIG3
	 GcCDhz4rf051fS89Yj1kw+oY/XCAi6yo7mr5pFHy8T+Utimx24dYCpXVE5zd+r6zgC
	 mRMjd1sk4/LYA==
Date: Thu, 22 Feb 2024 12:22:54 +0000
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
Subject: Re: [PATCH v4 3/6] perf: imx_perf: add support for i.MX95 platform
Message-ID: <20240222122253.GB8308@willie-the-truck>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-3-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055811.3035741-3-xu.yang_2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 01:58:08PM +0800, Xu Yang wrote:
> i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> read beat and write beat filter capabilities. This will add support for
> i.MX95 and enhance the driver to support specific filter handling for it.
> 
> Usage:
> 
> For read beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3,axi_mask=ID_MASK,axi_id=ID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=4,axi_mask=ID_MASK,axi_id=ID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=0x00f,axi_id=0x00c/
> 
> For write beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=0x00f,axi_id=0x00c/
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - put soc spefific axi filter events to drvdata according
>    to franks suggestions.
>  - adjust pmcfg axi_id and axi_mask config
> Changes in v3:
>  - no changes
> Changes in v4:
>  - only contain imx95 parts
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 86 +++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index b1a58e9e1617..85aaaef7212f 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -17,9 +17,19 @@
>  #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
>  #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
>  
> +#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
> +#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
> +
>  #define PMCFG2				0x04
>  #define MX93_PMCFG2_ID			GENMASK(17, 0)
>  
> +#define PMCFG3				0x08
> +#define PMCFG4				0x0C
> +#define PMCFG5				0x10
> +#define PMCFG6				0x14
> +#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
> +#define MX95_PMCFG_ID			GENMASK(25, 16)
> +
>  /* Global control register affects all counters and takes priority over local control registers */
>  #define PMGC0		0x40
>  /* Global control register bits */
> @@ -240,6 +250,18 @@ static struct attribute *imx93_ddr_perf_events_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *imx95_ddr_perf_events_attrs[] = {
> +	/* counter2 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
> +	/* counter3 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
> +	/* counter4 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
> +	/* counter5 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
> +	NULL,
> +};
> +
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  PMU_FORMAT_ATTR(counter, "config:8-15");
>  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> @@ -271,8 +293,14 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
>  	.attrs = imx93_ddr_perf_events_attrs,
>  };
>  
> +static const struct imx_ddr_devtype_data imx95_devtype_data = {
> +	.identifier = "imx95",
> +	.attrs = imx95_ddr_perf_events_attrs,
> +};
> +
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
>  	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
> +	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> @@ -410,6 +438,56 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>  
> +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
> +{
> +	u32 pmcfg1, pmcfg, offset = 0;
> +	int event, counter;
> +
> +	event = cfg & 0x000000FF;
> +	counter = (cfg & 0x0000FF00) >> 8;
> +
> +	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
> +
> +	if (counter == 2 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
> +		offset = PMCFG3;
> +	} else if (counter == 2 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> +	}
> +
> +	if (counter == 3 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset = PMCFG4;
> +	} else if (counter == 3 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter == 4 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset = PMCFG5;
> +	} else if (counter == 4 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter == 5 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset = PMCFG6;
> +	} else if (counter == 5 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}

I think this would be much easier to read if you rewrote it as:

	switch (counter) {
	case 2:
		...
		break;
	case 3:


etc.

> +	writel(pmcfg1, pmu->base + PMCFG1);

writel_relaxed()? (since you're already using readl_relaxed()).

> +
> +	if (offset) {
> +		pmcfg = readl_relaxed(pmu->base + offset);
> +		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> +			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> +		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
> +			  FIELD_PREP(MX95_PMCFG_ID, cfg1));
> +		writel(pmcfg, pmu->base + offset);

Similarly.

Will

