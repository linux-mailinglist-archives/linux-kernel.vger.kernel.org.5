Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADC778D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjHKLRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHKLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BBDC3;
        Fri, 11 Aug 2023 04:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D80AD64D2F;
        Fri, 11 Aug 2023 11:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008F9C433C7;
        Fri, 11 Aug 2023 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691752667;
        bh=hxQAmB/8S/2RsXJqhNtMpjCrkAM+LtXclZmynSSBuH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/5FA/NqE0ukdB0J5oqhAFGoGR2JvsGJAac9wnhbovyPSMZULqojPxXSiWdeWvR4z
         hi/sPxoCZ8hMFHoepJXuZ+jHhkc3UQ8DSVklePRLzCieplyEuTw0KBXdkaH6aczZZ8
         mIu+RO1dNGvvl3DRopf1PlfjNl4V2gFB1IBMw3ZuONNGNSkL89lS40aBAGVHLwrNId
         MjRWIU111G+3FMx7bNp22NYMhW6kdMUqNKs8iFetCosWM5b3l/7CE96J9iKi9HEA6o
         7IblwZQaFDdadR2KGbQfH+Fs51ZGnu/5F134IbstCnrDUHjbFB7TrZIvOFABXf0pbx
         eQ3yuuCo9ZaCw==
Date:   Fri, 11 Aug 2023 12:17:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     catalin.marinas@arm.com, lpieralisi@kernel.org,
        mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
        corbet@lwn.net, rafael@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
        hejunhao3@huawei.com, linuxarm@huawei.com,
        prime.zeng@hisilicon.com, yangyicong@hisilicon.com,
        zhurui3@huawei.com
Subject: Re: [PATCH] perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk
 for HIP08/09
Message-ID: <20230811111739.GD6993@willie-the-truck>
References: <20230809100654.32036-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809100654.32036-1-yangyicong@huawei.com>
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

On Wed, Aug 09, 2023 at 06:06:54PM +0800, Yicong Yang wrote:
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 25a269d431e4..b854b67b81fc 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -115,6 +115,7 @@
>  #define SMMU_PMCG_PA_SHIFT              12
>  
>  #define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
> +#define SMMU_PMCG_HARDEN_DISABLE        BIT(1)
>  
>  static int cpuhp_state_num;
>  
> @@ -150,6 +151,22 @@ SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_stream_id, config1, 0, 31);
>  SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_span, config1, 32, 32);
>  SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_enable, config1, 33, 33);
>  
> +static int smmu_pmu_apply_event_filter(struct smmu_pmu *smmu_pmu,
> +				       struct perf_event *event, int idx);
> +
> +static inline void smmu_pmu_enable_quirk_hip08_09(struct pmu *pmu)
> +{
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
> +	unsigned int idx;
> +
> +	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
> +		smmu_pmu_apply_event_filter(smmu_pmu, smmu_pmu->events[idx], idx);
> +
> +	writel(SMMU_PMCG_IRQ_CTRL_IRQEN,
> +	       smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
> +	writel(SMMU_PMCG_CR_ENABLE, smmu_pmu->reg_base + SMMU_PMCG_CR);

Can you tail-call smmu_pmu_enable() instead of duplicating it here?

> +static inline void smmu_pmu_disable_quirk_hip08_09(struct pmu *pmu)
> +{
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
> +	unsigned int idx;
> +
> +	/*
> +	 * The global disable of PMU sometimes fail to stop the counting.
> +	 * Harden this by writing an invalid event type to each used counter
> +	 * to forcibly stop counting.
> +	 */
> +	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
> +		writel(0xffff, smmu_pmu->reg_base + SMMU_PMCG_EVTYPER(idx));
> +
> +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_CR);
> +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);

Same things here, but with smmu_pmu_disable()

Will
