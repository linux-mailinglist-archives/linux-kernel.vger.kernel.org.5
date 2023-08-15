Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4772177CD50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjHONYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbjHONYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:24:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E65FD10C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:24:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F058F143D;
        Tue, 15 Aug 2023 06:25:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DCF43F6C4;
        Tue, 15 Aug 2023 06:24:18 -0700 (PDT)
Date:   Tue, 15 Aug 2023 14:24:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance monitor
 support
Message-ID: <ZNt8f1Ui13SoxOUT@FVFF77S0Q05N>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-4-gthiagarajan@marvell.com>
 <ZMPg8RNxEeHQNdqb@FVFF77S0Q05N>
 <SN1PR18MB21262B71F310B0AF33C2D2EFDB11A@SN1PR18MB2126.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR18MB21262B71F310B0AF33C2D2EFDB11A@SN1PR18MB2126.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 01:51:00PM +0000, Gowthami Thiagarajan wrote:
> > -----Original Message-----
> > From: Mark Rutland <mark.rutland@arm.com>
> > Sent: Friday, July 28, 2023 9:08 PM
> > To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> > Cc: will@kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> > Goutham <sgoutham@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com>; George Cherian
> > <gcherian@marvell.com>; Linu Cherian <lcherian@marvell.com>
> > Subject: [EXT] Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance monitor support
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Fri, Jun 30, 2023 at 05:33:48PM +0530, Gowthami Thiagarajan wrote:

> > > +static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
> > > +{

> > > +	if (!event->attr.disabled)
> > > +		return -EINVAL;
> > 
> > Why?
> Just checks the default disabled attribute.

Why does it matter?

What's the problem with opening an event which is *not* disabled?

[...]

> > > +static int tad_pmu_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct tad_region *regions;
> > > +	struct tad_pmu *tad_pmu;
> > > +	struct resource *res;
> > > +	u32 tad_pmu_page_size;
> > > +	u32 tad_page_size;
> > > +	u32 tad_cnt;
> > > +	int i, ret;
> > > +	char *name;
> > > +
> > > +	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
> > > +	if (!tad_pmu)
> > > +		return -ENOMEM;
> > > +
> > > +	platform_set_drvdata(pdev, tad_pmu);
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	if (!res) {
> > > +		dev_err(&pdev->dev, "Mem resource not found\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	ret = device_property_read_u32(dev, "marvell,tad-page-size", &tad_page_size);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = device_property_read_u32(dev, "marvell,tad-pmu-page-size",
> > > +				       &tad_pmu_page_size);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
> > > +		return ret;
> > > +	}
> > 
> > Why do you think these properties are necessary?
> > 
> > These should almost certainly be provided by IO resources, and shouldn't need a
> > custom property.
> 
> IO resources don't provide all the information in this case. Need to vary these values
> at different boot times. So, kept these custom properties.

I think the only rason the information is missing is that your DT binding isn't quite right.

Later on you do:

+       for (i = 0; i < tad_cnt && res->start < res->end; i++) {
+               regions[i].base = devm_ioremap(&pdev->dev,
+                                              res->start,
+                                              tad_pmu_page_size);
+               if (IS_ERR(regions[i].base)) {
+                       dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
+                       return -ENOMEM;
+               }
+               res->start += tad_page_size;
+       }

... which means you're splitting one reg entry into multiple mappings, whereas
you could have multiple reg entries, one per TAD page.

Thanks,
Mark.
