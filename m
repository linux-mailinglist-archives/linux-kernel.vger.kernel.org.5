Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63780E780
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbjLLJZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjLLJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:25:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A885CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:25:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAE7C433C8;
        Tue, 12 Dec 2023 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702373129;
        bh=ZasmtT7TxADK9iKWNQUX4f/H8ytsR1Wy0D+0pd2020k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPqZu26ngIhYAQXLvflLS7BxjC/5LWpSacX2uAK0MXS4GkVZE8VhgAtf/Usm3LtBF
         piG+WAXZhXkni2D22yDexjWcqtk2bsoGLqd5Mn84QLtFsI1ystxZf6fxDOEaBGhGX+
         TSapg9F+J0kXAG2CDs0D9TY/I4ByKq1pjrgXt7g4p3Feu3IUO/7r9Jfp0SUam3D2DG
         3UGRs9ZVyRIePQ5+EjeueXPbbugxyAQk46sGvB+SPC49TLyFTo4y9WMyq8E9eAbHqp
         7ZyDc0pqwR/n7YQoAavaraO3HLm88w+P3iBXX61LIQDnOPBceJLuMJbO70LLjCDKKq
         WPHNl2DkKRDZw==
Date:   Tue, 12 Dec 2023 09:25:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     mark.rutland@arm.com, Ganapatrao.Kulkarni@cavium.com,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] drivers/perf: Fix some null pointer dereference issues
 in thunderx2_pmu.c
Message-ID: <20231212092523.GC28174@willie-the-truck>
References: <20231211090347.265240-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211090347.265240-1-chentao@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 05:03:47PM +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/perf/thunderx2_pmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 1edb9c03704f..07edb174a0d7 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -742,6 +742,8 @@ static int tx2_uncore_pmu_register(
>  
>  	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
>  			"%s", name);
> +	if (!tx2_pmu->pmu.name)
> +		return -ENOMEM;
>  
>  	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);

AFAICT, perf_pmu_register() will WARN and return NULL, so I'm not sure what
we gain from the additional check.

>  }
> @@ -881,6 +883,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
>  		return NULL;
>  	}
>  
> +	if (!tx2_pmu->name) {
> +		dev_err(dev, "PMU type %d: Fail to allocate memory\n", type);
> +		devm_kfree(dev, tx2_pmu);
> +		return NULL;
> +	}

In the _highly_ unlikely even that devm_kasprintf() failed to allocate,
shouldn't we get a splat from the allocator? I don't think it's useful
to print another message.

Will
