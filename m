Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBBC78BB93
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjH1Xgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjH1XgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:36:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95764CF1;
        Mon, 28 Aug 2023 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693265734; x=1724801734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hakGVM12/9hmPDK7z9Z5LVI5JCPqWQ5AkH+gJkXzxwo=;
  b=MutGZTPwBwGrxvCs+KuCoNlEEA7p+fZ3PIJUUYMuQS1lQ1glngIveLuF
   g9Y1D7hwZ+gZ7OvyyZx7cHy1bnUcg3rh6mvLPfQqVaiwFdPT/1g4Ilndx
   KbyDRa3bIUUQwHtn+as+cfBQk4jMO+6D8GXzvCKJKCipPZmNN9puL6/fd
   yTNZAyfzQ22/coUnBp+c20ww7/LxaryTP61nhagMCH42hJxokPibYE8W0
   Rp+jZQMfGS75dv73tVmGTxgglurhInEupSq5lN2y1JwBQF9k9bMH1paAg
   02gULXvQv3N1c7dMPIerOzmWQoaJwHfrS3nJDDUn+wCUSbPeyVRMPfICp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="377958774"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="377958774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 16:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="862018513"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="862018513"
Received: from yjie-desk1.jf.intel.com (HELO [10.24.100.126]) ([10.24.100.126])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 16:35:23 -0700
Message-ID: <9665af79-d439-e05a-5333-62f71a2ac55c@linux.intel.com>
Date:   Mon, 28 Aug 2023 16:35:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] cpufreq: intel_pstate: set stale CPU frequency to
 minimum
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>, gregkh@linuxfoundation.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <001d01d9d3a7$71736f50$545a4df0$@telus.net>
 <CAJZ5v0g=TEY0+dL9AGh1cYNnwQ=L6G8CRxXVD0AyWsaK5aDsdA@mail.gmail.com>
Content-Language: en-US
From:   Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <CAJZ5v0g=TEY0+dL9AGh1cYNnwQ=L6G8CRxXVD0AyWsaK5aDsdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,LOTS_OF_MONEY,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 04:46, Rafael J. Wysocki wrote:
> On Sun, Aug 20, 2023 at 10:46 PM Doug Smythies <dsmythies@telus.net> wrote:
>>
>> The intel_pstate CPU frequency scaling driver does not
>> use policy->cur and it is 0.
>> When the CPU frequency is outdated arch_freq_get_on_cpu()
>> will default to the nominal clock frequency when its call to
>> cpufreq_quick_getpolicy_cur returns the never updated 0.
>> Thus, the listed frequency might be outside of currently
>> set limits. Some users are complaining about the high
>> reported frequency, albeit stale, when their system is
>> idle and/or it is above the reduced maximum they have set.
>>
>> This patch will maintain policy_cur for the intel_pstate
>> driver at the current minimum CPU frequency.
>>
>> Reported-by: Yang Jie <yang.jie@linux.intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>> ---
>>
>> v1 -> v2:
>>     * v1 was a completely different approach, programming around
>>       the issue rather than fixing it at the source.
>>       reference:
>>       https://patchwork.kernel.org/project/linux-pm/patch/006901d9be8c$f4439930$dccacb90$@telus.net/
>>     * v2 does not fix an issue with the intel_cpufreq CPU scaling
>>       driver (A.K.A. the intel_pstate driver in passive mode) and
>>       the schedutil CPU frequency scaling governor when HWP is enabled
>>       where limit changes are not reflected in the stale listed frequencies.
>>       A fix for that will be some future patch.
>>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index 8ca2bce4341a..08284dee583a 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>                          intel_pstate_clear_update_util_hook(policy->cpu);
>>                  intel_pstate_hwp_set(policy->cpu);
>>          }
>> +       /* policy current is never updated with the intel_pstate driver
>> +        * but it is used as a stale frequency value. So, keep it within
>> +        * limits.
>> +        */
>> +       policy->cur = policy->min;
>>
>>          mutex_unlock(&intel_pstate_limits_lock);
>>
>> --
> 
> Applied as 6.6 material, with some mailer-induced white space damage
> fixed and the new comment adjusted to the kernel coding style.
> 
> Thanks!

Hi Doug and Rafael,

Thank you for making the fix happen.

Hi Greg,

Will this be picked to the stable linux-6.1.y and linux-6.4.y kernel, it 
could benefit to users there.

Thanks,
~Keyon

