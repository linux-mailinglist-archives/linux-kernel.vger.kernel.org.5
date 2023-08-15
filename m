Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B339377CB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjHOLU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbjHOLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:20:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1A310D1;
        Tue, 15 Aug 2023 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692098399; x=1723634399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qm/7PUJgD2GtLjakOUE9w5ebw7RFNAUnnoCg+I7YeA8=;
  b=k0ywIq7Rpq76Rf4sCx484AM4FP/Kmj5raSjva4XbhJkSFAtKAQLTUPBY
   Ub+Kl+/lwGuEQIGW7Uv4V24wIcfLnillZgGd6slQZfXDReTVqqf6ANMaD
   4cutUKBmdzCi458DOxBfkwKtIpS2CBcIGZpMgYfbLbfpxrnpglR7SeHNm
   bzxzEBx9YmmHyEYmSfXdH1tQQdHcVxpW8WCZFEBCahooNJMtbrnBMBN5A
   zNGRRAIBrlNzrmftRKkpXtXy7EvFDifppDCf1XwrNKO9OWfQE8Yn4zDCe
   IQ+DNKuMoV5Q+kKdJNT0xi1q3C5WcdBLu97NqTDDk90RRgCG4aM18Jl1i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436151038"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436151038"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710677837"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="710677837"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:19:56 -0700
Message-ID: <b3c90331-f1c3-bdb7-5fca-cbf6441bedf6@intel.com>
Date:   Tue, 15 Aug 2023 14:19:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH V2 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
References: <20230815014057.13589-1-wenchao.chen@unisoc.com>
 <e66ee2ba-1668-cb88-f7ac-7c7722387fe7@intel.com>
 <CA+Da2qyuh-WcXdj2emkWcUkqH57W4p6aei8wijFw5fA7og0eaA@mail.gmail.com>
 <a241ac07-c9d5-ba76-44da-267006713365@intel.com>
 <CA+Da2qxf0o4C-yQZ4EirSRZCGs7a+BZLdxpmXeVM1zsMxG9rmQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+Da2qxf0o4C-yQZ4EirSRZCGs7a+BZLdxpmXeVM1zsMxG9rmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/23 13:55, Wenchao Chen wrote:
> On Tue, Aug 15, 2023 at 6:37 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 15/08/23 13:29, Wenchao Chen wrote:
>>> On Tue, Aug 15, 2023 at 2:21 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 15/08/23 04:40, Wenchao Chen wrote:
>>>>> Change in v2:
>>>>> - add mmc_sd_switch() and mmc_send_status() to the header file
>>>>> - split up core changes from host driver changes
>>>>> - Use pr_debug instead of dev_info and dev_dbg
>>>>> - Optimize the best sampled value algorithm
>>>>
>>>> What about hooking ->set_ios() as Ulf suggested?
>>>>
>>>
>>> I've tried that, but it's not a good way to do it.
>>> We found that sdhci_runtime_resume_host() calls ->set_ios, but we
>>> don't want to do that.
>>
>> Given that sdhci_sprd_runtime_resume() calls sdhci_runtime_resume_host(),
>> it should be possible to determine when to tune, right?
>>
> 
> You mean like this? For example:
> static int sdhci_sprd_runtime_resume(struct device *dev)
> {
> ...
> sprd_host->need_hs_tuning = false;
> sdhci_runtime_resume_host(host, 1);
> sprd_host->need_hs_tuning = true;

Yes

> ...
> }
> 
>>> We just need SD HS mode tuning at mmc_sd_init_card().
>>>
>>>>>
>>>>> Wenchao Chen (2):
>>>>>   mmc: core: Add host specific tuning support for SD HS mode
>>>>>   mmc: sdhci-sprd: Add SD HS mode online tuning
>>>>>
>>>>>  drivers/mmc/core/sd.c         |  12 +++
>>>>>  drivers/mmc/core/sd_ops.c     |   1 +
>>>>>  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++++
>>>>>  include/linux/mmc/host.h      |   8 ++
>>>>>  4 files changed, 173 insertions(+)
>>>>>
>>>>
>>

