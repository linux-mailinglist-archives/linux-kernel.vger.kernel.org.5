Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7527CC3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbjJQM6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjJQM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:58:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EEF1;
        Tue, 17 Oct 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697547488; x=1729083488;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=I32QFltBg3yPBXTGLQ6KOLaePjTdxzeZg3SlmfoCBW0=;
  b=PXMSmTDyrJZGO8k6mHU6vGsSzqTGt2R3yzEbpQqNETcXIZXcp5lgAw4I
   melWZGO1fXinHIATBkRsx4SB+jznNoGWRtA6yxM3wqOTXLmnj3xL1DugZ
   VtuX6whPktwXURUZb6EUKvwaXVRfd1a+0zVxsdDYnYan21MIit/geRpp4
   x6EXuwozrag0ge8CE3trRMjKzLHrmZZbQDOG0r/SgtVgGVXUWq3XA6ljP
   2JQ03QMNzo4MYC3nV7ZqEUEmfOF1WxPE2R1DfNvMkT4pELuB/UIWQ6BDZ
   vX/XshBDYn9p7x1j2jY3NbTJQdbgrhdKefBHe6TcCpiCcA1j23eDZTtUn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388632763"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="388632763"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="749677569"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="749677569"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Oct 2023 05:58:04 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
 <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
 <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
Date:   Tue, 17 Oct 2023 07:58:02 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 20:34:57 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-10-16 at 19:10 -0500, Haitao Huang wrote:
>> On Mon, 16 Oct 2023 16:09:52 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>> [...]
>>
>> > still need to fix the bug mentioned above here.
>> >
>> > I really think you should just go this simple way:
>> >
>> > When you want to take EPC back from VM, kill the VM.
>> >
>>
>> My only concern is that this is a compromise due to current limitation  
>> (no
>> other sane way to take EPC from VMs). If we define this behavior and it
>> becomes a contract to user space, then we can't change in future.
>
> Why do we need to "define such behaviour"?
>
> This isn't some kinda of kernel/userspace ABI IMHO, but only kernel  
> internal
> implementation.  Here VM is similar to normal host enclaves.  You limit  
> the
> resource, some host enclaves could be killed.  Similarly, VM could also  
> be
> killed too.
>
> And supporting VMM EPC oversubscription doesn't mean VM won't be  
> killed.  The VM
> can still be a target to kill after VM's all EPC pages have been swapped  
> out.
>
>>
>> On the other hand, my understanding the reason you want this behavior is
>> to enforce EPC limit at runtime.
>
> No I just thought this is a bug/issue needs to be fixed.  If anyone  
> believes
> this is not a bug/issue then it's a separate discussion.
>

AFAIK, before we introducing max_write() callback in this series, no misc  
controller would possibly enforce the limit when misc.max is reduced. e.g.  
I don't think CVMs be killed when ASID limit is reduced and the cgroup was  
full before limit is reduced.

I think EPC pages to VMs could have the same behavior, once they are given  
to a guest, never taken back by the host. For enclaves on host side, pages  
are reclaimable, that allows us to enforce in a similar way to memcg.

Thanks
Haitao
