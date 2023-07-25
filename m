Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59E6761D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjGYP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:28:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A3E19AF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yHIDH3l8nS0DiflUh1G8237ylog4AjfhZXROuCwR23k=; b=CzyeVHbb52nYoy0qM1pgd5syCt
        F7BJYzK9MlDXL3P33HWcbVEqPRO+gNOrCmSWLRewddXvoV2d3RcwnP1In/+dLvEMZ0HBJtFcmDR8l
        1sl15GKFuslbG74AmstMA0zC8jIy/03ysGMijlh7uQTsSIZeto391l26ifk5kVc3RYddXW8DqBpwH
        ZfgQeQZD/8EjHzwy42NZhtfxxnRCvlEXv91EykXHRMKlBfWglOsk8V+EtobkZBy7awp/HVx0T1iMR
        q6+H4fbqj9HRO7MsPneDJhmBYJOSQ3ljDg1OZ3bP7NdXweN/FD2kQZQW0p+TavDe5Dyrb9EBjMiIR
        B7kr5b9g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOJxc-007vLu-0g;
        Tue, 25 Jul 2023 15:28:28 +0000
Message-ID: <d35eddd6-0089-bbe8-c2f9-416941dcbed6@infradead.org>
Date:   Tue, 25 Jul 2023 08:28:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v3 1/2] soc: hisilicon: Support HCCS driver on
 Kunpeng SoC
Content-Language: en-US
To:     Huisong Li <lihuisong@huawei.com>, xuwei5@hisilicon.com,
        arnd@arndb.de, krzk@kernel.org, sudeep.holla@arm.com
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, wanghuiqiang@huawei.com,
        tanxiaofei@huawei.com, liuyonglong@huawei.com
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230725075706.48939-1-lihuisong@huawei.com>
 <20230725075706.48939-2-lihuisong@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230725075706.48939-2-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/25/23 00:57, Huisong Li wrote:
> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
> new file mode 100644
> index 000000000000..87a1f15cbedb
> --- /dev/null
> +++ b/drivers/soc/hisilicon/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Hisilicon SoC drivers"
> +	depends on ARCH_HISI || COMPILE_TEST
> +
> +config KUNPENG_HCCS
> +	tristate "HCCS driver on Kunpeng SoC"
> +	depends on ACPI
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  The Huawei Cache-Coherent System (HCCS) is a bus protocol standard

Just curious: what makes it a standard?

> +	  for ensuring cache coherent on HiSilicon SoC. The performance of

	                     coherence

> +	  the application may be affected if some hccs ports are in non-full

	                                          HCCS

> +	  lane status, have a large number of CRC errors and so on.
> +
> +	  Say M here if you want to include support for querying the health
> +	  status and port information of HCCS on Kunpeng SoC.
> +
> +endmenu

thanks.
-- 
~Randy
