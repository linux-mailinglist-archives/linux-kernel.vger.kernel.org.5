Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD22811912
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377966AbjLMQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjLMQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:19:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E7125;
        Wed, 13 Dec 2023 08:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702484387; x=1734020387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nJbcLZdnM2KSRyn7dXwITr56gBVjXirpwEpDYUFkjA4=;
  b=eNYeBoL6NKic5kdZc1b3H83zF0JkS8rCAJt18QJtYmPmtyP7ZVSJKWjz
   aGiN5oeqMK7zYyQ5PlCaEVrDIDhwtPop2CzaL19FmEDENh9Z6XH2cMuOX
   lori9Qj5LcVmnTEgk0oCyN3/zHI+pbJpY2ZeLCjgDrDrJ6914UhMoko4S
   KfDLGGJW4yfVey6GCgCp+DDH3/Y83kWf022AbywAKcQxT2883R7tvXfPB
   qWpv2Vk15TCRFVxrI+bUCz1Sy+QK80Vlb/qXIElma29eJL0AAmJNJzjwm
   1DW9sdA2KCZIQBtA/uffXKwYpWIE/tEP8UAKXaVhACWJGEzpi5UjSffI2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="426112098"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="426112098"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021166835"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1021166835"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:19:46 -0800
Received: from [10.212.117.13] (unknown [10.212.117.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 785BD580DAA;
        Wed, 13 Dec 2023 08:19:43 -0800 (PST)
Message-ID: <95fee418-27bc-4a0c-b438-8d6d770dbefc@linux.intel.com>
Date:   Wed, 13 Dec 2023 11:19:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-2-kan.liang@linux.intel.com>
 <20231208102922.GB769184@leoy-huanghe.lan>
 <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>
 <20231209063440.GE2116834@leoy-yangtze.lan>
 <ee9db34a-2b3d-46b3-ba36-22a22b080d70@linux.intel.com>
 <20231213142414.GH86143@leoy-huanghe.lan>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231213142414.GH86143@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-13 9:24 a.m., Leo Yan wrote:
> On Mon, Dec 11, 2023 at 02:01:37PM -0500, Liang, Kan wrote:
> 
> [...]
> 
>>> I will hold on a bit for the test until this patch set addresses the
>>> concern for the breakage issues on Arm64. Please check my review in
>>> other replies.
>>
>> The reviews in the other replies don't look like break any current usage
>> on Arm64. I think the breakage issue is what you described in this
>> patch, right?
> 
> I mentioned the breakage is in the patch 04, but I think the concern
> is dismissed.
> 
>> If we move the check of "arm_spe_0" to arch/arm/util/pmu.c, it seems we
>> have to move the perf_mem_events_arm[] into arch/arm/util/mem-events.c
>> as well. Is it OK?
> 
> No.  For fixing Arm64 building, please refer:
> 
> https://termbin.com/0dkn


That's great! Thanks a lot!

> 
>> I'm not familiar with ARM and have no idea how those events are
>> organized under arm64 and arm. Could you please send a fix for the
>> building failure on aarch64? I will fold it into the V3.
> 
> After apply the change in above link on the top of your patch set,
> it can build successfully at my side. Hope it's helpful.
> 

Yes, that's help a lot. I will send the V3 shortly.

Thanks,
Kan
