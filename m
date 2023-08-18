Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00F0781492
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbjHRVMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbjHRVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:11:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954134214;
        Fri, 18 Aug 2023 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rJjjg0/ZnxDlYEL8zqvSbEB/tj+r89an8hC6WCMDSRI=; b=S9U6VOK0v4D5Zj/tx99KZIfRg6
        gwZUuZzuoBGkJODS231x4AmgAaGewCyUW/oTXzNDTcKDzmTK4X62mM/fSj5zBKM4WVGG+zGcjzZqe
        f6gW/h8Js+vKI1QclS80gLkR3awxYcFVQ3xgu2jCKepesOsFxRK253vX3MRc1zjcalnUu/1nNhQCH
        yG0A/KClEUXQ3CGXhkX14t1s3az3mVir8kSRckiyvJfthbYSE2aDPz1e8wgh/4OfTG8H7GyoBwAvn
        YCvTIXLZazdHvoCxRDy3yjNAy0ycRQzov9nDX9CCLPjFPNGjVHZKIRgwcD/RpRaxf9PXCZgS+52vs
        Tcv58muA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qX6kq-00A2Xb-1Y;
        Fri, 18 Aug 2023 21:11:36 +0000
Message-ID: <51f4b571-a5b2-b1bb-b990-fe2c4c5387bf@infradead.org>
Date:   Fri, 18 Aug 2023 14:11:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V4 1/3] coresight: etm: Override TRCIDR3.CCITMIN on errata
 affected cpus
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230818112051.594986-1-anshuman.khandual@arm.com>
 <20230818112051.594986-2-anshuman.khandual@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230818112051.594986-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/18/23 04:20, Anshuman Khandual wrote:
> This work arounds errata 1490853 on Cortex-A76, and Neoverse-N1, errata
> 1491015 on Cortex-A77, errata 1502854 on Cortex-X1, and errata 1619801 on
> Neoverse-V1, based affected cpus, where software read for TRCIDR3.CCITMIN
> field in ETM gets an wrong value.
> 
> If software uses the value returned by the TRCIDR3.CCITMIN register field,
> then it will limit the range which could be used for programming the ETM.
> In reality, the ETM could be programmed with a much smaller value than what
> is indicated by the TRCIDR3.CCITMIN field and still function correctly.
> 
> If software reads the TRCIDR3.CCITMIN register field, corresponding to the
> instruction trace counting minimum threshold, observe the value 0x100 or a
> minimum cycle count threshold of 256. The correct value should be 0x4 or a
> minimum cycle count threshold of 4.
> 
> This work arounds the problem via storing 4 in drvdata->ccitmin on affected
> systems where the TRCIDR3.CCITMIN has been 256, thus preserving cycle count
> threshold granularity.
> 
> These errata information has been updated in arch/arm64/silicon-errata.rst,
> but without their corresponding configs because these have been implemented
> directly in the driver.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst   | 10 ++++++
>  .../coresight/coresight-etm4x-core.c          | 36 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 7e307022303a..591fab73ee79 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1131,6 +1131,39 @@ static void cpu_detect_trace_filtering(struct etmv4_drvdata *drvdata)
>  	drvdata->trfcr = trfcr;
>  }
>  
> +/*
> + * The following errata on applicable cpu ranges, affect the CCITMIN filed
> + * in TCRIDR3 register. Software read for the field returns 0x100 limiting
> + * the cycle threshold granularity, where as the right value should have

                                       whereas

> + * been 0x4, which is well supported in the hardware.
> + */
> +static struct midr_range etm_wrong_ccitmin_cpus[] = {
> +	/* Erratum #1490853 - Cortex-A76 */
> +	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 4, 0),
> +	/* Erratum #1490853 - Neoverse-N1 */
> +	MIDR_RANGE(MIDR_NEOVERSE_N1, 0, 0, 4, 0),
> +	/* Erratum #1491015 - Cortex-A77 */
> +	MIDR_RANGE(MIDR_CORTEX_A77, 0, 0, 1, 0),
> +	/* Erratum #1502854 - Cortex-X1 */
> +	MIDR_REV(MIDR_CORTEX_X1, 0, 0),
> +	/* Erratum #1619801 - Neoverse-V1 */
> +	MIDR_REV(MIDR_NEOVERSE_V1, 0, 0),
> +	{},
> +};
> +
> +static bool etm4_core_reads_wrong_ccitmin(struct etmv4_drvdata *drvdata)
> +{
> +	/*
> +	 * Erratum affected cpus will read 256 as the minimum
> +	 * instruction trace cycle counting threshold where as

	                                              whereas

> +	 * the correct value should be 4 instead. Override the
> +	 * recorded value for 'drvdata->ccitmin' to workaround
> +	 * this problem.
> +	 */

-- 
~Randy
