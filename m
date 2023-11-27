Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936D47FA126
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjK0NgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjK0NgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:36:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AD1FB8;
        Mon, 27 Nov 2023 05:36:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0D12F4;
        Mon, 27 Nov 2023 05:36:56 -0800 (PST)
Received: from [10.57.71.110] (unknown [10.57.71.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBB583F5A1;
        Mon, 27 Nov 2023 05:36:07 -0800 (PST)
Message-ID: <3912dd1e-b15b-49a9-9c91-88e00e986efd@arm.com>
Date:   Mon, 27 Nov 2023 13:36:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
From:   Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2023 13:46, Liming Sun wrote:
> This commit enables SDHCI_QUIRK_BROKEN_TIMEOUT_VAL to solve the
> intermittent eMMC timeout issue reported on some cards under eMMC
> stress test.
> 
> Reported error message:
>   dwcmshc MLNXBF30:00: __mmc_blk_ioctl_cmd: data error -110
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 3a3bae6948a8..3c8fe8aec558 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -365,7 +365,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>  #ifdef CONFIG_ACPI
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>  	.ops = &sdhci_dwcmshc_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>  		   SDHCI_QUIRK2_ACMD23_BROKEN,
>  };

__mmc_blk_ioctl_cmd: data error ?
What stresstest are you running that issues ioctl commands?
On which commands does the timeout occur?
Anyway you should be able to increase the timeout in ioctl structure
directly, i.e. in userspace, or does that not work?
