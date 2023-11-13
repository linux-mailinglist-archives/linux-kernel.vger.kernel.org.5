Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25D87E9408
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjKMBYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKMBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:24:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926D107;
        Sun, 12 Nov 2023 17:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699838656; x=1731374656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7NF1VAn04m70hM7l1JYUh8nmuapEk9MhlGOiinLGEbw=;
  b=HVvo4x3iUWhj1hLncg5UDUnuGxmqBBA33tWc50Hkb2XjwYhZmcAzpYBQ
   wcX/rGGgHZ3SoDY49u+4hzZJlOrCX1nkv/3D2gNLDpToSBTiohFF6NB73
   V3Mqcf37gSTjjkA18BNcO6IJJtLpkLfwF7+ZRvFhUmXNdS7oJ/AtF+Bm0
   Dc82+LQgmZZ0EdhOoEl2kJo9LHYQoEdQutf5OQvVEM16NFLqKsGExuTFu
   tFlY7717Ma48dkx2A9Q9AqizoNVyMe8awWGqJFYAGWWqxoyE40FyzoPRd
   YkmlbXigEOupBgeHPp2Hauu4d3wnQuncRUekTFPb2SnlGIkkq5bj5QYzr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="476586188"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="476586188"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 17:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="5331058"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.20.184]) ([10.93.20.184])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 17:24:14 -0800
Message-ID: <96cd6313-6ce4-4d4e-8dd9-78666704b267@linux.intel.com>
Date:   Mon, 13 Nov 2023 09:24:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/26] KVM: x86/pmu: Apply "fast" RDPMC only to Intel
 PMUs
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
References: <20231110021306.1269082-1-seanjc@google.com>
 <20231110021306.1269082-8-seanjc@google.com>
 <5d0c1946-0b22-4983-868b-db7f79fe16bc@linux.intel.com>
 <ZU5DZ110JPvcmZp0@google.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ZU5DZ110JPvcmZp0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/2023 10:51 PM, Sean Christopherson wrote:
> On Fri, Nov 10, 2023, Dapeng Mi wrote:
>> On 11/10/2023 10:12 AM, Sean Christopherson wrote:
>>> Move the handling of "fast" RDPMC instructions, which drop bits 63:31 of
>> 63:32?
> Oof, yeah.
>
>>> @@ -55,12 +59,17 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
>>>    	}
>>>    }
>>> +static u32 intel_rdpmc_get_masked_idx(struct kvm_pmu *pmu, u32 idx)
>> inline?
> No, for functions that are visible only to the local compilation unit, there's
> no reason to use "inline".  "inline" is just a hint, and modern compilers are
> smart enough to inline functions when appropriate without a hint, e.g. gcc and
> clang inline this on all my configurations.  Compilers may also ignore the hint,
> e.g. KASAN=y tends to produce some really amusing results.
>
> A longer explanation/rant here: https://lore.kernel.org/all/ZAdfX+S323JVWNZC@google.com

Got it. Thanks explanation.

