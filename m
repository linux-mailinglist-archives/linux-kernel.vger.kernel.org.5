Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EBE804AAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjLEGzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344597AbjLEGzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:55:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EED189;
        Mon,  4 Dec 2023 22:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wSBGOMrJ2rIBXWPc0f3qBJ8q9G+L4w8pT9nIJNShkrs=; b=k2+K10mtCasLCe+nnWQ85q7vXD
        6G42TQ3niROCJsnGSJGgj1RwmKWWK1IwxQugE+FAdWezeLM1xBPkpO3VLZFrpYDzzsKlHs+l1e62H
        6Ur7CbQfkMyK32SgX1Y884319euKaBylwygNO3okacrsZsXQT0ZuWinXSP32U5NUg9kCmeMr5Mu1B
        gWym4/f8rVxBH75FZvrTroZqMN3gHYDlVmzn1LxAMAPZp25l8uU2L5KX6u/CNOQ94iT1kewP/Snhn
        CxA8IHMnnk4GSc/1Alr1vUU1otrYcJ3oWREOdv1ZYKogW7QC2ffK+Vc5LZecVGmgHNLp0SDW6fQMS
        KHEM8H4w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAPLO-006RZK-23;
        Tue, 05 Dec 2023 06:55:46 +0000
Message-ID: <75d52b42-0a26-44d5-b64d-60b762c858b5@infradead.org>
Date:   Mon, 4 Dec 2023 22:55:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: tegra: Protect SID override call under
 CONFIG_IOMMU_API
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        sfr@canb.auug.org.au
References: <20231205060045.7985-1-amhetre@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231205060045.7985-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 22:00, Ashish Mhetre wrote:
> tegra186_mc_client_sid_override() is protected under CONFIG_IOMMU_API.
> Call to this function is being made from tegra186_mc_resume() without
> any protection which is leading to build failure when CONFIG_IOMMU_API
> is not set. Fix this by protecting SID override function call from
> tegra186_mc_resume() under CONFIG_IOMMU_API.
> 
> Fixes: fe3b082a6eb8 ("memory: tegra: Add SID override programming for MC clients")
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/memory/tegra/tegra186.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index d1f1dfb42716..0ff014a9d3cd 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -141,6 +141,7 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>  
>  static int tegra186_mc_resume(struct tegra_mc *mc)
>  {
> +#if IS_ENABLED(CONFIG_IOMMU_API)
>  	unsigned int i;
>  
>  	for (i = 0; i < mc->soc->num_clients; i++) {
> @@ -148,6 +149,7 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
>  
>  		tegra186_mc_client_sid_override(mc, client, client->sid);
>  	}
> +#endif
>  
>  	return 0;
>  }

-- 
~Randy
