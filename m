Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2137758443
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjGRSLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGRSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:11:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BEC99;
        Tue, 18 Jul 2023 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689703900; x=1721239900;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=p4t3OskS0H/cllBsYG2hIF8dKpFFNElLWh827nNWfh8=;
  b=WH9YEgeCHFdiMFn1MUkZOmj/eLN53D+JXx3Som75wqjf03K53X4zcUTs
   3jInRkbZ2rSPgpCkPdsRJRTNy+xoUiRU7juuQS0GuZRD7bvQ4I8aSDVyG
   +9M147Yae+XZMQbIXiw0gf4wZEBPUnxzoUdtxmUn4kUCLUWhRfpm11Nmn
   bb82RyWdjHw8FhZbVzLgAue7FBr49fteTguT2zds8DrXJtH+KLPAXIuPG
   B37GGjtxYH5xAvmMfe+LHhKuE1RsR233m8Dpej9VAaSvntR6vT8dKjc0v
   SAmMSKxI79wIJIWJ0WZE1iy0oHrA+KYgVvl8cqKAFNhRq4IxrL6AD6hlg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432458957"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432458957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 11:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="813860875"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="813860875"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Jul 2023 11:11:37 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
Date:   Tue, 18 Jul 2023 13:11:36 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 09:27:49 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 7/17/23 13:29, Haitao Huang wrote:
>> Under heavy load, the SGX EPC reclaimers (current ksgxd or future EPC
>> cgroup worker) may reclaim the SECS EPC page for an enclave and set
>> encl->secs.epc_page to NULL. But the SECS EPC page is used for EAUG in
>> the SGX #PF handler without checking for NULL and reloading.
>>
>> Fix this by checking if SECS is loaded before EAUG and load it if it was
>> reclaimed.
>
> It would be nice to see a _bit_ more theory of the bug in here.
>
> What is an SECS page and why is it special in a reclaim context?  Why is
> this so hard to hit?  What led you to discover this issue now?  What is
> EAUG?

Let me know if this clarify things.

The SECS page holds global states of an enclave, and all reclaimable pages  
tracked by the SGX EPC reclaimer (ksgxd) are considered 'child' pages of  
the SECS page corresponding to that enclave.  The reclaimer only reclaims  
the SECS page when all its children are reclaimed. That can happen on  
system under high EPC pressure where multiple large enclaves demanding  
much more EPC page than physically available. In a rare case, the  
reclaimer may reclaim all EPC pages of an enclave and it SECS page,  
setting encl->secs.epc_page to NULL, right before the #PF handler get the  
chance to handle a #PF for that enclave. In that case, if that #PF happens  
to require kernel to invoke the EAUG instruction to add a new EPC page for  
the enclave, then a NULL pointer results as current code does not check if  
encl->secs.epc_page is NULL before using it.

The bug is easier to reproduce with the EPC cgroup implementation when a  
low EPC limit is set for a group of enclave hosting processes. Without the  
EPC cgroup it's hard to trigger the reclaimer to reclaim all child pages  
of an SECS page. And it'd also require a machine configured with large RAM  
relative to EPC so no OOM killer triggered before this happens.

Thanks
Haitao

