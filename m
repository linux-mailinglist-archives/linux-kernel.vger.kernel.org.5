Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C17A76E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjITJLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:11:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56A5493;
        Wed, 20 Sep 2023 02:11:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3805C1FB;
        Wed, 20 Sep 2023 02:12:07 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9375C3F5A1;
        Wed, 20 Sep 2023 02:11:28 -0700 (PDT)
Message-ID: <53b1867e-2374-852d-e110-fb51bddd6475@arm.com>
Date:   Wed, 20 Sep 2023 10:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V5 - RESEND 1/3] coresight: etm: Override TRCIDR3.CCITMIN
 on errata affected cpus
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230915093649.435163-1-anshuman.khandual@arm.com>
 <20230915093649.435163-2-anshuman.khandual@arm.com>
 <3cd57606-5a82-8978-b057-8b3cfea8c62d@arm.com>
 <ca5728fb-87fb-0088-4769-3087060182e2@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ca5728fb-87fb-0088-4769-3087060182e2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 07:40, Anshuman Khandual wrote:
> 
> 
> On 9/19/23 16:56, Suzuki K Poulose wrote:
>> Hi Anshuman
>>

>>> +
>>> +static bool etm4_core_reads_wrong_ccitmin(struct etmv4_drvdata *drvdata)
>>> +{
>>> +    /*
>>> +     * Erratum affected cpus will read 256 as the minimum
>>> +     * instruction trace cycle counting threshold whereas
>>> +     * the correct value should be 4 instead. Override the
>>> +     * recorded value for 'drvdata->ccitmin' to workaround
>>> +     * this problem.
>>> +     */
>>> +    return is_midr_in_range_list(read_cpuid_id(), etm_wrong_ccitmin_cpus) &&
>>> +           (drvdata->ccitmin == 256);
>>
>> minor nit: Having looked at this, it feels like, fixing the ccitmin
>> value to 4, could be moved into this function. Otherwise,  we have all
>> the required information about the erratum and the real application of
>> work around is left in the caller, which kind of feels disconnected.
>>
>> So, please could we rename the above function to:
>>
>> static void etm4_fixup_wrong_ccitmin(str..)
>> {
>>    /* Comment as above */
>>     if (....)
>>      drvdata->ccitmin = 4;
>> }
> 
> I will fold in the following change for the patch. Please do let me
> know if this reflects your suggestions accurately. Also planning to
> carry Mike's tag after the change.
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 044aed25979b..5b6a878a2ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1175,7 +1175,7 @@ static struct midr_range etm_wrong_ccitmin_cpus[] = {
>          {},
>   };
>   
> -static bool etm4_core_reads_wrong_ccitmin(struct etmv4_drvdata *drvdata)
> +static void etm4_fixup_wrong_ccitmin(struct etmv4_drvdata *drvdata)
>   {
>          /*
>           * Erratum affected cpus will read 256 as the minimum
> @@ -1184,8 +1184,10 @@ static bool etm4_core_reads_wrong_ccitmin(struct etmv4_drvdata *drvdata)
>           * recorded value for 'drvdata->ccitmin' to workaround
>           * this problem.
>           */
> -       return is_midr_in_range_list(read_cpuid_id(), etm_wrong_ccitmin_cpus) &&
> -              (drvdata->ccitmin == 256);
> +       if (is_midr_in_range_list(read_cpuid_id(), etm_wrong_ccitmin_cpus)) {
> +               if (drvdata->ccitmin == 256)
> +                       drvdata->ccitmin = 4;
> +       }
>   }
>   
>   static void etm4_init_arch_data(void *info)
> @@ -1252,8 +1254,7 @@ static void etm4_init_arch_data(void *info)
>          etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
>          /* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
>          drvdata->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
> -       if (etm4_core_reads_wrong_ccitmin(drvdata))
> -               drvdata->ccitmin = 4;
> +       etm4_fixup_wrong_ccitmin(drvdata);
>   
>          /* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
>          drvdata->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
> 


LGTM, thanks for addressing it quickly

Suzuki

