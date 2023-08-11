Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657BC778D39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjHKLOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHKLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C7BC3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88CBB6703D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3721DC433C7;
        Fri, 11 Aug 2023 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691752459;
        bh=gpFkNrRX0fSFng6Hp3kg8rIpvCPmAJMeifUV263exfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VhN1imDLjGETpv+Nar9ywdaM399k7zTmoWzlGQFPkzB0oPfB4tEoewMkB1dS6uy+Y
         YtYOr0M1PrpgCV+mn12Z5fNiAdcxeoHOaqJKVVvCowghPxUz79ooObXRv5+bnA8Asv
         6FVBlCXzhwAjt/NbvZQoWdywaHAkTXYdVM3R6DO+RhhLLVD5RYAL+Ry8yI1D+/R36T
         6kHSCWaH9fSsENkI6HJen0Gx17SpAuzEDtukoA8IfAkIcJ/kxD2HIsHWf9U/WTga5W
         XfXIcbqw4kP3LR76RAG8SZcXxsGuL94L9EeXQInWf13nhoOwlgdZlvPHYxpYk83cSm
         SICNbIq0w7lSQ==
Date:   Fri, 11 Aug 2023 12:14:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     jonathan.cameron@huawei.com, mark.rutland@arm.com,
        hejunhao3@huawei.com, prime.zeng@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH] drivers/perf: hisi: Schedule perf session according to
 locality
Message-ID: <20230811111414.GC6993@willie-the-truck>
References: <20230808125147.2080-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808125147.2080-1-yangyicong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 08:51:47PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PCIe PMUs locate on different NUMA node but currently we don't
> consider it and likely stack all the sessions on the same CPU:
> 
> [root@localhost tmp]# cat /sys/devices/hisi_pcie*/cpumask
> 0
> 0
> 0
> 0
> 0
> 0
> 
> This can be optimize a bit to use a local CPU for the PMU.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index e10fc7cb9493..60ecf469782b 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -665,7 +665,7 @@ static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>  	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
>  
>  	if (pcie_pmu->on_cpu == -1) {
> -		pcie_pmu->on_cpu = cpu;
> +		pcie_pmu->on_cpu = cpumask_local_spread(0, dev_to_node(&pcie_pmu->pdev->dev));
>  		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));

Hmm, this is a bit weird now, because the interrupt is affine to a different
CPU from the one you've chosen. Are you sure that's ok? When the offline
notifier picks a new target, it moves the irq as well.

Will
