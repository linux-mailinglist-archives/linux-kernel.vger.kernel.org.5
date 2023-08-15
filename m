Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D046377CAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjHOJ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjHOJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B09B1985
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07ADC60D14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB498C433C8;
        Tue, 15 Aug 2023 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692093538;
        bh=o49vHnAclvN8+OB5maqLkNps+F0O+gxHL+axhoITllw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgASLfmCl2ShSCzf77JrZgWLA0+BTuDtPX8ufU7IcUiT4ZfXRk1yhW0YbyxgK8IVK
         nftz1ubTpoy0nisnhdJxmIJKifmN7poii2LRqHpps2dw1Tubf7csigpCYYBRrtNAfU
         B6R0xA8PTt3t70FMgWVGJnaF1xGOVGX9VyVKBFlrOHy4RFWLfW5nFcxwbPe1tsnqGH
         nAeRZJgPuHj2D2OYolTzyk6ElkjXEWqpzMT958/SS23zZ1GobxNQCrCXEMTgf8uZX+
         IFN1yyyoI2k5VYK89uwe+Jd1YMUxTz5JHZc5tgwe36fObhjPrlheByP8af8yffSYnP
         eT5+lMDV/UhfA==
Date:   Tue, 15 Aug 2023 10:58:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance monitor
 support
Message-ID: <20230815095852.GB11083@willie-the-truck>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-4-gthiagarajan@marvell.com>
 <ZMPg8RNxEeHQNdqb@FVFF77S0Q05N>
 <SN1PR18MB21262B71F310B0AF33C2D2EFDB11A@SN1PR18MB2126.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR18MB21262B71F310B0AF33C2D2EFDB11A@SN1PR18MB2126.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 01:51:00PM +0000, Gowthami Thiagarajan wrote:
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

Please can you be a bit more specific here? Which information is not
provided?

Will
