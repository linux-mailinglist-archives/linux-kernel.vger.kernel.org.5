Return-Path: <linux-kernel+bounces-106696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6F87F216
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C934C1F21C48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611658AB6;
	Mon, 18 Mar 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if9p+RYV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77D59B45;
	Mon, 18 Mar 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797181; cv=none; b=Qbt8zDd3LDKqJmqMUP0P8nVBqNDzcTgmpt9ZfzrtliE3NQKLiBBy71dX3mbXR/87BCiWRabGzh9v1FG/+ChHPf2NMJ0IxOY6Sx30dKwdsKiv5yQ7KnXLp0N6AV6mnT+NgDaT7mGItKCYfTKERJMKrvnLQdBx2It2T/gJp13+Zrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797181; c=relaxed/simple;
	bh=wQf7oggxp7YSFV0yVBBY0q1aNecnNBr402/Qx96fMWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFBYAmJoBJ0cq3P3TzUnCyWP+tG+oE6hZfSaBinPhhKt40yeH+EOJg5qDOf7C60E6YsyHv+/8ID39UODvtjuVllRg+aHyTcx27gNKJkzP2Dh6Ir0MSnpr0Z93Tibgbe4VAoaOxMFn0uFikp/FVG0yVVMkhUi2+3xLqIMcJ8VhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if9p+RYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F88DC433F1;
	Mon, 18 Mar 2024 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710797181;
	bh=wQf7oggxp7YSFV0yVBBY0q1aNecnNBr402/Qx96fMWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if9p+RYV3g3AScJH/s8XMcO4n9seRUiI49vyDKGTrlBBYc2gEuY/d/xmITjf6OQV0
	 mx9N4tov+UbqPmSx+Mf77gw12/+oic4PrL4+bHFy/hCRnAqOdYlZ23ZtXaPuwO/7FP
	 8CZUiDMkx7WO2+yoDzq9qhlBSH1xYE1CrWs3Vij4zyPTJW3WF9TOyTSG2xvOSGC5F+
	 UyHa3loau8tu8XcZ+JK5kZsNkK6JxJa40fGCs0FpALnGG9HB9fiDybmYuWTAtdvskN
	 gIlMAyzRUbUba/rkyxL39fVT4WmNrBLtJ+u78QqCNbrwCNTXPJxy+7CdxPJAenpAnp
	 G2vBTymgXUsEg==
Date: Mon, 18 Mar 2024 18:26:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"mike.leach@linaro.org" <mike.leach@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH v7 7/8] perf vendor events arm64:: Add i.MX95
 DDR Performance Monitor metrics
Message-ID: <ZfixebFnNViJc-4q@x1>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-7-xu.yang_2@nxp.com>
 <ZfSuw5KbopW0PiPp@x1>
 <DU2PR04MB8822D36B2C8EDF0F36DA19AA8C2D2@DU2PR04MB8822.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB8822D36B2C8EDF0F36DA19AA8C2D2@DU2PR04MB8822.eurprd04.prod.outlook.com>

On Mon, Mar 18, 2024 at 06:18:52AM +0000, Xu Yang wrote:
> Hi Arnaldo,
> 
> > 
> > On Fri, Mar 15, 2024 at 05:55:54PM +0800, Xu Yang wrote:
> > > Add JSON metrics for i.MX95 DDR Performance Monitor.
> > >
> > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > 
> > I'm applying the tools/perf/ patches, that is 7/8 and 8/8, but I noticed
> > that 8/8 has no Reviewed-by tags, is that really the case? If so, can we
> > have them?
> 
> I found IMX93 metrics are still not added until v6, then I add patch 8/8 in v7.
> So it's still waiting for review I think. Sorry for inconvenience.

Ok, so lets wait a bit more for review.

- Arnaldo
 
> Thanks,
> Xu Yang
> 
> > 
> > - Arnaldo
> > 
> > > ---
> > > Changes in v2:
> > >  - fix wrong AXI_MASK setting
> > >  - remove unnecessary metrics
> > >  - add bandwidth_usage, camera_all, disp_all metrics
> > > Changes in v3:
> > >  - no changes
> > > Changes in v4:
> > >  - add Reviewed-by tag
> > > Changes in v5:
> > >  - fix typo
> > > Changes in v6:
> > >  - remove "counter=X" from each metric
> > > Changes in v7:
> > >  - add RB tag
> > > ---
> > >  .../arch/arm64/freescale/imx95/sys/ddrc.json  |   9 +
> > >  .../arm64/freescale/imx95/sys/metrics.json    | 778 ++++++++++++++++++
> > >  tools/perf/pmu-events/jevents.py              |   1 +
> > >  3 files changed, 788 insertions(+)
> > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
> > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
> > >
> > > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json b/tools/perf/pmu-
> > events/arch/arm64/freescale/imx95/sys/ddrc.json
> > > new file mode 100644
> > > index 000000000000..4dc9d2968bdc
> > > --- /dev/null
> > > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
> > > @@ -0,0 +1,9 @@
> > > +[
> > > +   {
> > > +           "BriefDescription": "ddr cycles event",
> > > +           "EventCode": "0x00",
> > > +           "EventName": "imx95_ddr.cycles",
> > > +           "Unit": "imx9_ddr",
> > > +           "Compat": "imx95"
> > > +   }
> > > +]
> > > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json b/tools/perf/pmu-
> > events/arch/arm64/freescale/imx95/sys/metrics.json
> > > new file mode 100644
> > > index 000000000000..a3ae787d448c
> > > --- /dev/null
> > > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
> > > @@ -0,0 +1,778 @@
> > > +[
> > > +     {
> > > +             "BriefDescription": "bandwidth usage for lpddr5 evk board",
> > > +             "MetricName": "imx95_bandwidth_usage.lpddr5",
> > > +             "MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ +
> > imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (6400 * 1000000 *
> > 4)",
> > > +             "ScaleUnit": "1e2%",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all masters read from ddr",
> > > +             "MetricName": "imx95_ddr_read.all",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all masters write to ddr",
> > > +             "MetricName": "imx95_ddr_write.all",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all a55 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.a55_all",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ +
> > imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all a55 write to ddr (part1)",
> > > +             "MetricName": "imx95_ddr_write.a55_all_1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all a55 write to ddr (part2)",
> > > +             "MetricName": "imx95_ddr_write.a55_all_2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 0 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.a55_0",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 0 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.a55_0",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 1 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.a55_1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 1 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.a55_1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 2 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.a55_2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 2 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.a55_2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 3 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.a55_3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 3 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.a55_3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 4 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.a55_4",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 4 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.a55_4",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 5 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.a55_5",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of a55 core 5 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.a55_5",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
> > > +             "MetricName": "imx95_ddr_read.cortexa_dsu_l3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
> > > +             "MetricName": "imx95_ddr_write.cortexa_dsu_l3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of m33 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.m33",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of m33 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.m33",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of m7 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.m7",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of m7 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.m7",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of sentinel read from ddr",
> > > +             "MetricName": "imx95_ddr_read.sentinel",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of sentinel write to ddr",
> > > +             "MetricName": "imx95_ddr_write.sentinel",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of edma1 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.edma1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of edma1 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.edma1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of edma2 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.edma2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of edma2 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.edma2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of netc read from ddr",
> > > +             "MetricName": "imx95_ddr_read.netc",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of netc write to ddr",
> > > +             "MetricName": "imx95_ddr_write.netc",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of npu read from ddr",
> > > +             "MetricName": "imx95_ddr_read.npu",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of npu write to ddr",
> > > +             "MetricName": "imx95_ddr_write.npu",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of gpu read from ddr",
> > > +             "MetricName": "imx95_ddr_read.gpu",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of gpu write to ddr",
> > > +             "MetricName": "imx95_ddr_write.gpu",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usdhc1 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.usdhc1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usdhc1 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.usdhc1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usdhc2 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.usdhc2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usdhc2 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.usdhc2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usdhc3 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.usdhc3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usdhc3 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.usdhc3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of xspi read from ddr",
> > > +             "MetricName": "imx95_ddr_read.xspi",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of xspi write to ddr",
> > > +             "MetricName": "imx95_ddr_write.xspi",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie1 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.pcie1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie1 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.pcie1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie2 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.pcie2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie2 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.pcie2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie3 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.pcie3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie3 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.pcie3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie4 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.pcie4",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of pcie4 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.pcie4",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usb1 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.usb1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usb1 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.usb1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usb2 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.usb2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of usb2 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.usb2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of vpu codec primary bus read from ddr",
> > > +             "MetricName": "imx95_ddr_read.vpu_primy",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of vpu codec primary bus write to ddr",
> > > +             "MetricName": "imx95_ddr_write.vpu_primy",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of vpu codec secondary bus read from ddr",
> > > +             "MetricName": "imx95_ddr_read.vpu_secndy",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of vpu codec secondary bus write to ddr",
> > > +             "MetricName": "imx95_ddr_write.vpu_secndy",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of jpeg decoder read from ddr",
> > > +             "MetricName": "imx95_ddr_read.jpeg_dec",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of jpeg decoder write to ddr",
> > > +             "MetricName": "imx95_ddr_write.jpeg_dec",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of jpeg encoder read from ddr",
> > > +             "MetricName": "imx95_ddr_read.jpeg_dec",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of jpeg encoder write to ddr",
> > > +             "MetricName": "imx95_ddr_write.jpeg_enc",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all vpu submodules read from ddr",
> > > +             "MetricName": "imx95_ddr_read.vpu_all",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all vpu submodules write to ddr",
> > > +             "MetricName": "imx95_ddr_write.vpu_all",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of cortex m0+ read from ddr",
> > > +             "MetricName": "imx95_ddr_read.m0",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of cortex m0+ write to ddr",
> > > +             "MetricName": "imx95_ddr_write.m0",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of camera edma read from ddr",
> > > +             "MetricName": "imx95_ddr_read.camera_edma",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of camera edma write to ddr",
> > > +             "MetricName": "imx95_ddr_write.camera_edma",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi rd read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isi_rd",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi rd write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isi_rd",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi wr y read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isi_wr_y",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi wr y write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isi_wr_y",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi wr u read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isi_wr_u",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi wr u write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isi_wr_u",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi wr v read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isi_wr_v",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isi wr v write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isi_wr_v",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp input dma1 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isp_in_dma1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp input dma1 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isp_in_dma1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp input dma2 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isp_in_dma2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp input dma2 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isp_in_dma2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp output dma1 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isp_out_dma1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp output dma1 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isp_out_dma1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp output dma2 read from ddr",
> > > +             "MetricName": "imx95_ddr_read.isp_out_dma2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of isp output dma2 write to ddr",
> > > +             "MetricName": "imx95_ddr_write.isp_out_dma2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all camera submodules read from ddr",
> > > +             "MetricName": "imx95_ddr_read.camera_all",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x380\\,axi_id\\=0x200@ +
> > imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ +
> > imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all camera submodules write to ddr (part1)",
> > > +             "MetricName": "imx95_ddr_write.camera_all_1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x200@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all camera submodules write to ddr (part2)",
> > > +             "MetricName": "imx95_ddr_write.camera_all_2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all camera submodules write to ddr (part3)",
> > > +             "MetricName": "imx95_ddr_write.camera_all_3",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of display blitter store read from ddr",
> > > +             "MetricName": "imx95_ddr_read.disp_blit",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of display blitter write to ddr",
> > > +             "MetricName": "imx95_ddr_write.disp_blit",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of display command sequencer read from ddr",
> > > +             "MetricName": "imx95_ddr_read.disp_cmd",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of display command sequencer write to ddr",
> > > +             "MetricName": "imx95_ddr_write.disp_cmd",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all display submodules read from ddr",
> > > +             "MetricName": "imx95_ddr_read.disp_all",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x300\\,axi_id\\=0x300@ +
> > imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all display submodules write to ddr (part1)",
> > > +             "MetricName": "imx95_ddr_write.disp_all_1",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x300\\,axi_id\\=0x300@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     },
> > > +     {
> > > +             "BriefDescription": "bytes of all display submodules write to ddr (part2)",
> > > +             "MetricName": "imx95_ddr_write.disp_all_2",
> > > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
> > > +             "ScaleUnit": "9.765625e-4KB",
> > > +             "Unit": "imx9_ddr",
> > > +             "Compat": "imx95"
> > > +     }
> > > +]
> > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > > index 53ab050c8fa4..be4b541a0820 100755
> > > --- a/tools/perf/pmu-events/jevents.py
> > > +++ b/tools/perf/pmu-events/jevents.py
> > > @@ -284,6 +284,7 @@ class JsonEvent:
> > >            'hisi_sccl,hha': 'hisi_sccl,hha',
> > >            'hisi_sccl,l3c': 'hisi_sccl,l3c',
> > >            'imx8_ddr': 'imx8_ddr',
> > > +          'imx9_ddr': 'imx9_ddr',
> > >            'L3PMC': 'amd_l3',
> > >            'DFPMC': 'amd_df',
> > >            'UMCPMC': 'amd_umc',
> > > --
> > > 2.34.1

