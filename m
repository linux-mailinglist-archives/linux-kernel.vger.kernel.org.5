Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919197E0325
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbjKCMsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:48:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F19CE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:48:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5570C433C7;
        Fri,  3 Nov 2023 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699015715;
        bh=OogBIZR4ZyTsmzPlBhZjRPRCtrTTw2tdeKdpttcq/eI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MHbjb/g1M4ksYSJjVAhfLgP2SZ0twH1NkfVvwdtuNMA5qIf59TCyDLjog4QrQ5mAF
         FJDF4X4wCGi1OQypa57ijcy4kuVU7PRqU+6tkUlfHDONSx8fy0KpQ/yAdr8ybXZO2f
         7QvxyNgxQVlc93IiQo7lnnyLtO0U8FnTcjMeSHbbpca6SpVEV1398z58i5c9eTK+de
         OiAgMHO0+Iq3DAHWpS+mJ64Qceu35RoKIOY+laZkshRiRx8HIM/7SN2v4EY06VHM69
         nyJ9Q8od4gmX9I7o8m0WZ45YLjUe39f126HVrVi834Cqo4YTGGy42AqwW7bjVy2Q4G
         kE+LLuK6bKuZg==
Message-ID: <4f06d727-d424-44f8-bd80-53c452b289d3@kernel.org>
Date:   Fri, 3 Nov 2023 13:48:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race between of_iommu_configure() and iommu_probe_device()
To:     Hector Martin <marcan@marcan.st>, iommu@lists.linux.dev,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <a36ddb05-9e5f-dfae-81e2-0da5e4925743@marcan.st>
Content-Language: en-US
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <a36ddb05-9e5f-dfae-81e2-0da5e4925743@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.11.2023 12:55, Hector Martin wrote:
> I just hit a crash in of_iommu_xlate() -> apple_dart_of_xlate() because
> dev->iommu was NULL. of_iommu_xlate() first calls iommu_fwspec_init
> which calls dev_iommu_get(), which allocates that member if NULL. That
> means it got freed in between, but the only thing that can do that is
> dev_iommu_free(), which is called from __iommu_probe_device() in the
> error path. That is serialized via a static lock, but not against the
> xlate stuff.
> 
> I think the specific sequence of events was as follows:
> 
> - IOMMU driver has not probed yet
> - Device driver tries to probe, and gets deferred via of_iommu_xlate()
> -> driver_deferred_probe_check_state() because there are no IOMMU ops yet
> - IOMMU driver probes
> - IOMMU driver registration triggers device probes
> - IOMMU device probe fails, because there is no fwnode/OF data yet (e.g.
> apple_dart_probe_device returns ENODEV if dev_iommu_priv_get() returns
> NULL, and that is set in apple_dart_of_xlate())
> - __iommu_probe_device is in the error exit path, and at this exact
> point a parallel device probe is running of_iommu_xlate()
> - of_iommu_xlate() calls iommu_fwspec_init(), which ensures dev->iommu
> is non-NULL, which at this point it is
> - immediately after that, __iommu_probe_device() calls dev_iommu_free()
> since it is in the process of erroring out. This frees and sets
> dev->iommu to NULL.
> - of_iommu_xlate() calls ops->of_xlate()
> - apple_dart_of_xlate() calls dev_iommu_priv_set(), which crashes
> because dev->iommu is now NULL.
> 
> As far as I can tell it's not just the specific driver xlate call
> setting priv that's the problem here, but there is one big race between
> the entire fwspec codepath (accessing dev->iommu->fwspec) and
> __iommu_probe_device() (allocating and freeing dev->iommu).
> 
> Thinking about this whole thing is making my brain hurt. Thoughts? How
> do we fix this?
FWIW I've been getting inexplicable boot-time crashes that sometimes
spew out a fraction of a log line like:

[x.yyyyyyyy] addr.iommu

on some Qualcomm devices every now and then for quite some time..
Not very common though. Might be this, might be something else..

Konrad
