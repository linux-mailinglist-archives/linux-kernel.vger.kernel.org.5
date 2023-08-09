Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC2775202
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHIEmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIEmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:42:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B58811BCE;
        Tue,  8 Aug 2023 21:42:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930B111FB;
        Tue,  8 Aug 2023 21:43:14 -0700 (PDT)
Received: from [10.163.54.83] (unknown [10.163.54.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A03D3F6C4;
        Tue,  8 Aug 2023 21:42:28 -0700 (PDT)
Message-ID: <86fb0ae5-d840-5ff5-a2a7-fc635a53184a@arm.com>
Date:   Wed, 9 Aug 2023 10:12:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] coresight: etm: Make cycle count threshold user
 configurable
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, Al.Grant@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230808074533.380537-1-anshuman.khandual@arm.com>
 <CAJ9a7Vgs6nP+KEPhjuj4BtWRZrRt-byz1xsa-JRzk3cFGJ+d8w@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAJ9a7Vgs6nP+KEPhjuj4BtWRZrRt-byz1xsa-JRzk3cFGJ+d8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/23 15:49, Mike Leach wrote:
> Hi Anshuman
> 
> On Tue, 8 Aug 2023 at 08:45, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> Cycle counting is enabled, when requested and supported but with a default
>> threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into TRCCCCTLR,
>> representing the minimum interval between cycle count trace packets.
>>
>> This makes cycle threshold user configurable, from the user space via perf
>> event attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT,
>> in case no explicit request. As expected it creates a sysfs file as well.
>>
>> /sys/bus/event_source/devices/cs_etm/format/cc_threshold
>>
>> New 'cc_threshold' uses 'event->attr.config3' as no more space is available
>> in 'event->attr.config1' or 'event->attr.config2'.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
> 
> Please ensure that the e-mail title reflects the "v2" nature of this.
> e.g. [PATCH v2] ....

Right, missed that.

> 
> 
>> - s/treshhold/threshhold
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20230804044720.1478900-1-anshuman.khandual@arm.com/
>>
>>  Documentation/trace/coresight/coresight.rst        |  2 ++
>>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
>>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++++++--
>>  3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
>> index 4a71ea6cb390..a698b07206b5 100644
>> --- a/Documentation/trace/coresight/coresight.rst
>> +++ b/Documentation/trace/coresight/coresight.rst
>> @@ -624,6 +624,8 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
>>     * - timestamp
>>       - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
>>         <coresight-timestamp>`
>> +   * - cc_threshold
>> +     - Cycle count threshold value
>>
>>  How to use the STM module
>>  -------------------------
> 
> The doc elements here need to be in a separate patch in the set and
> additionally sent to doc list and maintainer
> (linux-doc@vger.kernel.org and corbet@lwn.net) to be picked up.

Sure, will do that.

> 
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 5ca6278baff4..09f75dffae60 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -68,6 +68,7 @@ PMU_FORMAT_ATTR(preset,               "config:0-3");
>>  PMU_FORMAT_ATTR(sinkid,                "config2:0-31");
>>  /* config ID - set if a system configuration is selected */
>>  PMU_FORMAT_ATTR(configid,      "config2:32-63");
>> +PMU_FORMAT_ATTR(cc_threshold,  "config3:0-11");
>>
>>
>>  /*
>> @@ -101,6 +102,7 @@ static struct attribute *etm_config_formats_attr[] = {
>>         &format_attr_preset.attr,
>>         &format_attr_configid.attr,
>>         &format_attr_branch_broadcast.attr,
>> +       &format_attr_cc_threshold.attr,
>>         NULL,
>>  };
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 9d186af81ea0..a353c0784bab 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -644,7 +644,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>         struct etmv4_config *config = &drvdata->config;
>>         struct perf_event_attr *attr = &event->attr;
>>         unsigned long cfg_hash;
>> -       int preset;
>> +       int preset, cc_threshold;
>>
>>         /* Clear configuration from previous run */
>>         memset(config, 0, sizeof(struct etmv4_config));
>> @@ -667,7 +667,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>         if (attr->config & BIT(ETM_OPT_CYCACC)) {
>>                 config->cfg |= TRCCONFIGR_CCI;
>>                 /* TRM: Must program this for cycacc to work */
>> -               config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
>> +               cc_threshold = attr->config3 & ETM_CYC_THRESHOLD_MASK;
>> +               if (cc_threshold) {
>> +                       if (cc_threshold < drvdata->ccitmin)
>> +                               config->ccctlr = drvdata->ccitmin;
>> +                       else
>> +                               config->ccctlr = cc_threshold;
>> +               } else {
>> +                       config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
>> +               }
>>         }
>>         if (attr->config & BIT(ETM_OPT_TS)) {
>>                 /*
>> --
>> 2.25.1
>>
> 
> As we are using ccitmin - which I think we must - then we need an
> additional patch in the set that implements the errata workaround
> mentioned by Al, when setting ccitmin in etm4_init_arch_data().
Agreed, I am working on that.

> Perhaps a helper function called from there to read the ID reg unless
> one of the errata cores in which case set to 0x4.
Even on the errata cores, first will read the ID register TRCIDR3 to
ascertain CCITMIN field to be 0x100 (256) before overriding with 0x4.
