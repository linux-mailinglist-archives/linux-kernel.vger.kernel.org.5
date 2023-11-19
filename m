Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE8D7F049C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 07:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjKSG6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 01:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 01:58:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51171B9;
        Sat, 18 Nov 2023 22:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700377112; x=1731913112;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=4aWdhgEHLG1+pCPYPu0Vac7LkPPBWPXoqmf8wWjR+ZE=;
  b=RZPu/2aRia4RKWKWxOsb/V7Jdztx1y/SS2Eeu1GMK0F8+XozmEBw4tMB
   SXSJsvd1spLpQg9pZzU8htp3dkk/e0bI6ClekZp8ybl1H7jy5340HXDs2
   HNkebp7+Dt8P9eNTN0XiVizWxjfAfDX7hI7ZT+7mg0N1Ks2f60tPA4xje
   ipZSw31SxPwIx+OAQXVt1Lvoc/e25HRy2Sv8ZbklMeDI9PDd/PPTAjJDC
   IsAjmdPzMiWlJHnDo5XUIerE4Bon0jMfaOikuAZ7EJ4hsdEb09enIWb3m
   /dyN4XYNGRGG3odWpz/TlhvwZAyJvi3ivQgPqqWDTAkU3Q1rRBmE1lNOy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="376515909"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="376515909"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 22:58:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="765977299"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="765977299"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.8.180]) ([10.93.8.180])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 22:58:27 -0800
Message-ID: <e35a14f9-5e82-4dc1-9705-52dc856778b5@linux.intel.com>
Date:   Sun, 19 Nov 2023 14:58:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/16] KVM: TDX: Pass size to reclaim_page()
From:   Binbin Wu <binbin.wu@linux.intel.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
 <31552f714f2fd8178f9467e9afaaf28ba3de3c7b.1699368363.git.isaku.yamahata@intel.com>
 <13937cd6-8dfa-493c-932c-71f878f447ef@linux.intel.com>
In-Reply-To: <13937cd6-8dfa-493c-932c-71f878f447ef@linux.intel.com>
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



On 11/19/2023 2:42 PM, Binbin Wu wrote:
>
>
> On 11/7/2023 11:00 PM, isaku.yamahata@intel.com wrote:
>> @@ -1597,7 +1600,7 @@ static int tdx_sept_drop_private_spte(struct 
>> kvm *kvm, gfn_t gfn,
>>            * The HKID assigned to this TD was already freed and cache
>>            * was already flushed. We don't have to flush again.
>>            */
>> -        err = tdx_reclaim_page(hpa);
>> +        err = tdx_reclaim_page(hpa, level);
>>           if (KVM_BUG_ON(err, kvm))
>>               return -EIO;
>>           tdx_unpin(kvm, pfn);
>> @@ -1630,7 +1633,7 @@ static int tdx_sept_drop_private_spte(struct 
>> kvm *kvm, gfn_t gfn,
>>           pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err, NULL);
>>           return -EIO;
>>       }
>> -    tdx_clear_page(hpa);
>> +    tdx_clear_page(hpa, PAGE_SIZE);
> Should here be KVM_HPAGE_SIZE(level) instead of  PAGE_SIZE?

OK, please ignore this comment, I see this is handled by the following 
patch.

>
>>       tdx_unpin(kvm, pfn);
>>       return 0;
>>   }
>> @@ -1742,7 +1745,7 @@ static int tdx_sept_free_private_spt(struct kvm 
>> *kvm, gfn_t gfn,
>>        * already flushed. We don't have to flush again.
>>        */
>>       if (!is_hkid_assigned(kvm_tdx))
>> -        return tdx_reclaim_page(__pa(private_spt));
>> +        return tdx_reclaim_page(__pa(private_spt), PG_LEVEL_4K);
>>         /*
>>        * free_private_spt() is (obviously) called when a shadow page 
>> is being
>
>

