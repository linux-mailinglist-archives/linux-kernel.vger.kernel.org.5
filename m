Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5276C8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjHBIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjHBIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:55:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B5722D4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:55:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DDEE113E;
        Wed,  2 Aug 2023 01:55:55 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 296183F5A1;
        Wed,  2 Aug 2023 01:55:11 -0700 (PDT)
Message-ID: <558cfef3-8ebf-e59f-af20-7a262b2d2de7@arm.com>
Date:   Wed, 2 Aug 2023 09:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] coresight: trbe: Directly use
 ID_AA64DFR0_EL1_TraceBuffer_IMP
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230802063658.1069813-1-anshuman.khandual@arm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230802063658.1069813-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2023 07:36, Anshuman Khandual wrote:
> is_trbe_available() checks for the TRBE support via extracting TraceBuffer
> field value from ID_AA64DFR0_EL1, and ensures that it is implemented. This
> replaces the open encoding '0b0001' with 'ID_AA64DFR0_EL1_TraceBuffer_IMP'
> which is now available via sysreg tools. Functional change is not intended.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
> index 94e67009848a..ebb9108d8e24 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.h
> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
> @@ -24,7 +24,7 @@ static inline bool is_trbe_available(void)
>  	unsigned int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0,
>  								 ID_AA64DFR0_EL1_TraceBuffer_SHIFT);
>  
> -	return trbe >= 0b0001;
> +	return trbe >= ID_AA64DFR0_EL1_TraceBuffer_IMP;
>  }
>  
>  static inline bool is_trbe_enabled(void)

Reviewed-by: James Clark <james.clark@arm.com>

Kind of unrelated to this change, but it seems like a lot of feature
checks like this avoid using any value altogether when it's just 0 or 1.
For example the same check for TRBE in kvm:

  /* Check if we have TRBE implemented and available at the host */
  if (cpuid_feature_extract_unsigned_field(dfr0,
ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
  ...
