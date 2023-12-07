Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCF808A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjLGO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjLGO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:27:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABDE121;
        Thu,  7 Dec 2023 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701959239; x=1733495239;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=sLuugWaEbM0JX5UOBlaJagk+PbTKVLSdxFEXIxg228A=;
  b=csYNRD/VMDK16jamsdbXmFzKJLzk/t/WCf2rZcgW0BlPLw+RO1AnywF9
   aEpPGx6Lr9R2LTy6K61kNLvPFjm4qFsdu3r/bxwon6f0aaeC4idXlCZDZ
   ffget5me487T/IQNHyg1vLyGSaEpW3bMtOC/0FPRNqRYg6A+TfGunxcqm
   Z4XYLCiBcNjnyxLp1jctebf+8nWammxVJKMFOOWQ8Q4Ly97Hovn/YtaMb
   YhUpHORdV6mfKDpXOWDRvoNGXooja9Zew0ACV+XGNiGrsJbsgsgs2N1ZT
   aKvpMAdqoCnw2U/y6O4X02YGVQCyb2nAYcsDo5aRQyNtUa6JDEUtM4LZG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="398116354"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="398116354"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806030928"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="806030928"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:27:18 -0800
Received: from [10.212.103.45] (kliang2-mobl1.ccr.corp.intel.com [10.212.103.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4085B580D4F;
        Thu,  7 Dec 2023 06:27:16 -0800 (PST)
Message-ID: <c5e76546-c3e9-494b-a43c-3c088ad77167@linux.intel.com>
Date:   Thu, 7 Dec 2023 09:27:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] perf mem: Add mem_events into the supported perf_pmu
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org,
        irogers@google.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <20231206201324.184059-2-kan.liang@linux.intel.com>
 <13272300-1d7e-92e8-020e-54d9cfd12ca7@amd.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <13272300-1d7e-92e8-020e-54d9cfd12ca7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-07 9:21 a.m., Ravi Bangoria wrote:
> Hi Kan,
> 
>> +void perf_pmu__arch_init(struct perf_pmu *pmu)
>> +{
>> +	if (strcmp(pmu->name, "arm_spe_0"))
> 
> if (!strcmp(...))
> 
>> +	if (x86__is_amd_cpu()) {
>> +		if (strcmp(pmu->name, "ibs_op"))
> 
> Ditto.
> 

Thanks Ravi. I will fix it in V2.

Thanks,
Kan
