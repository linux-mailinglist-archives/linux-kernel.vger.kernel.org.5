Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAEF7F3206
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjKUPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:12:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429D895
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700579562; x=1732115562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UHpTeDv4W4xErJiobPFpgTVqwJBD6wRH0+X56USKiH8=;
  b=TJpZ/nTietd7PBe01UfLMbIk8s1VHCmG7xwDW9s4LuIIRNhzP28kmHXC
   6v/wwNxtZfxSnLIcIRkIXmHyMqx5TO5FQbxB2rZBRUqFFzWBFgeZDsACO
   vC6+/4IOukAw+/dtU9VuqFrJqLvbpnHtY0BP9a+/tWRMC1hyazJudHvQp
   VKXK8Heoic6760+tOyZRMnZOVb7PplX+SIBXdR13h01Xr8N2+4lzAoxV1
   9aoPygUcqVNOpi8CzlGclV7T+968LDOZe745WVknXDQLjshCvTqdoFjRh
   46kRb7oLKDQMMb6UBQh+5rUFEq7dzB69ujQZ88/sRg50vHw037xsVEfwB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13402306"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13402306"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910478383"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="910478383"
Received: from aantonov-mobl1.ger.corp.intel.com (HELO [10.252.40.154]) ([10.252.40.154])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:11:19 -0800
Message-ID: <0a2beede-bbbf-4f80-8f9d-7c92737e983d@linux.intel.com>
Date:   Tue, 21 Nov 2023 16:11:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix NULL pointer dereference issue
 in upi_fill_topology()
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kyle.meyer@hpe.com, alexey.v.bayduraev@linux.intel.com
References: <20231115151327.1874060-1-alexander.antonov@linux.intel.com>
 <ceb47045-3188-49ff-85b2-b37c9d0721e1@linux.intel.com>
 <50ce6fce-c2fc-4392-b405-5c9a7a93f061@linux.intel.com>
 <7caf86b8-f050-4d0f-8aba-e2d725a0ab64@linux.intel.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
In-Reply-To: <7caf86b8-f050-4d0f-8aba-e2d725a0ab64@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/20/2023 10:21 PM, Liang, Kan wrote:
>
> On 2023-11-20 2:49 p.m., Alexander Antonov wrote:
>> On 11/15/2023 8:00 PM, Liang, Kan wrote:
>>> On 2023-11-15 10:13 a.m., alexander.antonov@linux.intel.com wrote:
>>>> From: Alexander Antonov <alexander.antonov@linux.intel.com>
>>>>
>>>> The NULL dereference happens inside upi_fill_topology() procedure in
>>>> case of disabling one of the sockets on the system.
>>>>
>>>> For example, if you disable the 2nd socket on a 4-socket system then
>>>> uncore_max_dies() returns 3 and inside pmu_alloc_topology() memory will
>>>> be allocated only for 3 sockets and stored in type->topology.
>>>> In discover_upi_topology() memory is accessed by socket id from
>>>> CPUNODEID
>>>> registers which contain physical ids (from 0 to 3) and on the line:
>>>>
>>>>       upi = &type->topology[nid][idx];
>>>>
>>>> out-of-bound access will happen and the 'upi' pointer will be passed to
>>>> upi_fill_topology() where it will be dereferenced.
>>>>
>>>> To avoid this issue update the code to convert physical socket id to
>>>> logical socket id in discover_upi_topology() before accessing memory.
>>>>
>>>> Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology
>>>> discovery for Icelake Server")
>>>> Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
>>>> Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
>>>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>>>> ---
>>>>    arch/x86/events/intel/uncore_snbep.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/uncore_snbep.c
>>>> b/arch/x86/events/intel/uncore_snbep.c
>>>> index 8250f0f59c2b..49bc27ab26ad 100644
>>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>>> @@ -5596,7 +5596,7 @@ static int discover_upi_topology(struct
>>>> intel_uncore_type *type, int ubox_did, i
>>>>        struct pci_dev *ubox = NULL;
>>>>        struct pci_dev *dev = NULL;
>>>>        u32 nid, gid;
>>>> -    int i, idx, ret = -EPERM;
>>>> +    int i, idx, lgc_pkg, ret = -EPERM;
>>>>        struct intel_uncore_topology *upi;
>>>>        unsigned int devfn;
>>>>    @@ -5614,8 +5614,13 @@ static int discover_upi_topology(struct
>>>> intel_uncore_type *type, int ubox_did, i
>>>>            for (i = 0; i < 8; i++) {
>>>>                if (nid != GIDNIDMAP(gid, i))
>>>>                    continue;
>>>> +            lgc_pkg = topology_phys_to_logical_pkg(i);
>>>> +            if (lgc_pkg < 0) {
>>>> +                ret = -EPERM;
>>>> +                goto err;
>>>> +            }
>>> In the snbep_pci2phy_map_init(), there are similar codes to find the
>>> logical die id. Can we factor a common function for both of them?
>>>
>>> Thanks,
>>> Kan
>> Hi Kan,
>>
>> Thank you for your comment.
>> Yes, I think we can factor out the common loop where GIDNIDMAP is being
>> checked.
>> But inside snbep_pci2phy_map_init() we have a bit different procedure which
>> also does the following:
>>
>> if (topology_max_die_per_package() > 1)
>>      die_id = i;
>>
>> I think that having this code, at least, in our case could bring us to the
>> same issue which we are trying to fix. But of course we could
>> parametrize this checking.
> The topology_max_die_per_package() > 1 means there are more that 1 die
> in a socket. AFAIK, it only happens on the Cascade Lake AP.
>
> Did you observe it in the ICX?
>
> Thanks,
> Kan
No, I didn't observe it on ICX. Seems for now we have it only on CLX-AP

Thanks,
Alexander
>
>> What do you think?
>>
>> Thanks,
>> Alexander
>>>>                for (idx = 0; idx < type->num_boxes; idx++) {
>>>> -                upi = &type->topology[nid][idx];
>>>> +                upi = &type->topology[lgc_pkg][idx];
>>>>                    devfn = PCI_DEVFN(dev_link0 + idx,
>>>> ICX_UPI_REGS_ADDR_FUNCTION);
>>>>                    dev =
>>>> pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
>>>>                                      ubox->bus->number,
>>>> @@ -5626,6 +5631,7 @@ static int discover_upi_topology(struct
>>>> intel_uncore_type *type, int ubox_did, i
>>>>                            goto err;
>>>>                    }
>>>>                }
>>>> +            break;
>>>>            }
>>>>        }
>>>>    err:
>>>>
>>>> base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
