Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5108118FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjLMQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjLMQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:17:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEE4D0;
        Wed, 13 Dec 2023 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702484273; x=1734020273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7B2DphUlGbzEdI7JKraMwKjte3e4u4RUHtQDmI5dL+g=;
  b=k8aKKpX9liLK7PKx+uytSVoed39nKMl5doB3Yj/pQgYo9o4x4BSEHpeG
   h5y0PO6gIiSgHqgUvsvsFbGw3hLDhrqR8y+Q+UtryXw/SZcITnwLBIfDW
   R6oWPpkRew7w68A9aTzGfHLRgESKLczlGSOyvibmdliilEswYeI1hp5eK
   C905rwi+3r26eRWxH20JAzSUf8XKMTPxFy9haIYJ2pemzCBT2EMyPiZaL
   rfv9Ezts6cJ/LAmm+CzgmRYyyBaZDk55W6P4aBRoi1Dzfk/LbciCHTB4C
   JGep+S9wPc8bGARJHHf1zzV+n+Z5ykD54JSB4CBH/SD/p7glw3I5lMjDu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16539013"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="16539013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:17:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="839933861"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="839933861"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:17:50 -0800
Received: from [10.212.117.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.117.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 65E1C580BF0;
        Wed, 13 Dec 2023 08:17:48 -0800 (PST)
Message-ID: <64c2808e-ac2b-41c0-9e98-61b22e3031c1@linux.intel.com>
Date:   Wed, 13 Dec 2023 11:17:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] perf mem: Clean up perf_mem_events__name()
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
 <20231207192338.400336-4-kan.liang@linux.intel.com>
 <20231209054809.GB2116834@leoy-yangtze.lan>
 <3b67c2de-741d-4d5e-8c8f-87b8b9e08825@linux.intel.com>
 <20231213133336.GA3895246@leoy-yangtze.lan>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231213133336.GA3895246@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-13 8:33 a.m., Leo Yan wrote:
>>> I am a bit suspect if we really need the field '.aux_event', the
>>> '.aux_event' field is only used for generating event string.
>> No, it stores the event encoding for the extra event.
>> ARM doesn't need it, so it's 0.
> I searched a bit and confirmed '.aux_event' is only used in
> util/mem-events.c and for 'perf record'.
> 
> I failed to connect the code with "it stores the event encoding for the
> extra event".  Could you elaborate a bit for this?

The details of the reason of introducing the mem_load aux event can be
found here.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61b985e3e775a3a75fda04ce7ef1b1aefc4758bc

A mem_load_aux event is a new requirement for SPR. For the other Intel
platforms, a single mem_load event is good enough to collect the data
source information. But for SPR, we have to group both the mem_load
event and the mem_load_aux event when collecting the data source
information. In the group, the mem_load_aux event must be the leader
event. But for the sample read case, only the sampling of the mem_load
make sense. So the is_mem_loads_aux_event() is introduced to switch the
sampling event to the mem_load event. Here is the perf tool patch.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a57d40832dc8366bc517bcbbfdb1d7fb583735b

The .aux_event is to store the event encoding of the mem_load_aux event.
If it's the leader of a sampling read group, we should use the second
event as a sampling event.

Thanks,
Kan
