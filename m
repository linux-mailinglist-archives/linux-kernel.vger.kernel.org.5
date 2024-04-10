Return-Path: <linux-kernel+bounces-138909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8D89FBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4391C21CED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0716F0E9;
	Wed, 10 Apr 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hztov4Vi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769631E878;
	Wed, 10 Apr 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763955; cv=none; b=CkmtlIp7JkCNQer5QB2yRfHCRA+EE1uMyXOWee/SjiXCI+CH7hAoYuv6AXFMUm5+FKVqax2feClSMRKZTkwy181E1k/3sWpp38yyeoxhHfW46rbsXfOhIJPB4Rn5wAkWSxyifUzfiwu06SpCHeQdmJ3dyCvdcx1cU87OmCSScJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763955; c=relaxed/simple;
	bh=Iws5TST+OzZUPfFNgljptP+ZHHp7PyVhznvweeW0O3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrXEVQoxKJYPovdGpwE5LZ0bNA+YfJokKOUIMA6IzE0sS+CqUsKuZhjqe4knKSGFArZBZ4hgyoWlTXvo+HZolatSYS6xzHxfbTLNs0w39jhWL47Zwiov7Xtw2PQ5QwIzQtcYIQLl21/cHumO8pf0314JkfdkGZI9g1RqTnrNfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hztov4Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9686BC433C7;
	Wed, 10 Apr 2024 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712763955;
	bh=Iws5TST+OzZUPfFNgljptP+ZHHp7PyVhznvweeW0O3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hztov4Vi8VkLznfPfx81BXFAyzQZRGXg8qs8z09Njupjvxnx0lq8moLtVwrtZ4ugW
	 PC8HjJtzouaE2i7H0Fns76YObHbCk/NIkxZi/v36frgl5gP0eRQU6Yy7FjaIqmZeAs
	 yNY4mKMoX/OlZUES+oyLQeYbXzLk0cWgTsFnn7t3QV1WdJLLJuUAVd7YTMtMU8Z6XV
	 uXmd1hMQlpO7+R0QCk1KOHaVrg4BK2KNNGvLQuukpT85ZEkIGDSmtDjxdF08TxWyci
	 FgVLt/uUPuyMo/JzX/4rG9ptLVA+EK4KPlPluLZ+tn/CzS8LgW5E+NzCSeU7Q5n+76
	 +mWkohOqm0IwQ==
Date: Wed, 10 Apr 2024 16:45:47 +0100
From: Will Deacon <will@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
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
	"acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH v8 3/8] perf: imx_perf: let the driver manage
 the counter usage rather the user
Message-ID: <20240410154546.GA25225@willie-the-truck>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-3-xu.yang_2@nxp.com>
 <20240409152627.GA23621@willie-the-truck>
 <DU2PR04MB882209413AB62531713166B38C062@DU2PR04MB8822.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB882209413AB62531713166B38C062@DU2PR04MB8822.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 10, 2024 at 07:39:46AM +0000, Xu Yang wrote:
> > On Fri, Mar 22, 2024 at 02:39:25PM +0800, Xu Yang wrote:
> > > In current design, the user of perf app needs to input counter ID to count
> > > events. However, this is not user-friendly since the user needs to lookup
> > > the map table to find the counter. Instead of letting the user to input
> > > the counter, let this driver to manage the counters in this patch.
> > 
> > I think we still have to support the old interface so that we don't break
> > those existing users (even if the driver just ignores whatever counter ID
> > is provided in a backwards-compatible way).
> > 
> > > This will be implemented by:
> > >  1. allocate counter 0 for cycle event.
> > >  2. find unused counter from 1-10 for reference events.
> > >  3. allocate specific counter for counter-specific events.
> > >
> > > In this patch, counter attribute is removed too. To mark counter-specific
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
> > > ---
> > >  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
> > >  1 file changed, 99 insertions(+), 69 deletions(-)
> > >
> > > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> > > index 0017f2c9ef91..b728719b494c 100644
> > > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > > @@ -245,14 +249,12 @@ static const struct attribute_group ddr_perf_events_attr_group = {
> > >       .attrs = ddr_perf_events_attrs,
> > >  };
> > >
> > > -PMU_FORMAT_ATTR(event, "config:0-7");
> > > -PMU_FORMAT_ATTR(counter, "config:8-15");
> > > +PMU_FORMAT_ATTR(event, "config:0-15");
> > 
> > Sadly, this is a user-visible change so I think it will break old tools,
> > won't it?
> 
> For imx ddr pmu, most of the people will use metrics rather event itself,
> and we have speficy the format of event parameters in metrics table.
> The parameters is also updated in this patchset.
> 
> And to easy use for user, the counter should be hidden (transparent) to
> user after I had talk with Frank. Then, the user need't to look up the event
> table to find which counter to use. 
> 
> So this patchset will basically not break the usage of perf tools and will
> improve practicality.

Sorry, but I don't agree. The original commit adding this driver
(55691f99d417) gives the following examples in the commit message:

For example:
      perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_trans_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
      perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_trans_filt,counter=3,axi_mask=ID_MASK,axi_id=ID/
      perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt,counter=4,axi_mask=ID_MASK,axi_id=ID/

I don't think these will work any more if we apply this patch.

Will

