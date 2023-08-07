Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8D772820
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjHGOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHGOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:46:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5210DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691419606; x=1722955606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JNLS8jFBfRx4CXMitXxjjSQjaruvMYX/p2Luw7f8D3s=;
  b=anX2q+tsTubMmUz0cIQqbR7zJcbV+c+MPlX8BxKfglkrs8Z1Wkenh7fM
   +JlFhSB7g5dnzz6TFMpBlRmOCgiHnm9RTWlgglcakqlLZWni0cMaT7beN
   P+QaDDt9YA1fNYq1unjx2MJb4A1VIgGGyg5dYeASIu2W59Msuw0lTKS8V
   /5CAQbVo29UEL2JSG41JsPpEVi2pH+Tsi4MqoqyvNs7eByYt6ovJcEbTQ
   yff6syCdl5e7YQDybMlXRBw+OK0xaT0aPMG3VzrJAh8YEA0NKoPRX/3cA
   9JOkuMYcwrSZRMWmSXed4LSE6PnhfS054MFPqqHJf8FXvkU17id1BjrTn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368018482"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="368018482"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="680827500"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="680827500"
Received: from abhatia-mobl2.amr.corp.intel.com (HELO [10.212.249.113]) ([10.212.249.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:46:45 -0700
Message-ID: <f410c645-b1d1-2bc1-1271-0653eedb74e3@intel.com>
Date:   Mon, 7 Aug 2023 07:46:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Content-Language: en-US
To:     kirill.shutemov@linux.intel.com, Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, seanjc@google.com, pbonzini@redhat.com,
        isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
References: <cover.1690369495.git.kai.huang@intel.com>
 <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
 <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/23 04:41, kirill.shutemov@linux.intel.com wrote:
> On Wed, Jul 26, 2023 at 11:25:13PM +1200, Kai Huang wrote:
>> @@ -20,6 +21,9 @@
>>  #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
>>  #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
>>  
>> +#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
>> +#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
> Is there any explantion how these error codes got chosen? Looks very
> arbitrary and may collide with other error codes in the future.

If they collide, we can just fix it then.

So, please, do comment what the limitations are and what must be avoided
in the future, but I don't think we need to go mucking with this at all.
