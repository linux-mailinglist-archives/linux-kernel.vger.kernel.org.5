Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9E808EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443251AbjLGRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjLGRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:21:36 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32C7510EB;
        Thu,  7 Dec 2023 09:21:43 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9F96220B74C0;
        Thu,  7 Dec 2023 09:21:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F96220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701969702;
        bh=YtdJ7UMxZsFLwYU4tFxDRYnaE/64yQgCMEsvib3m/bA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SwQ29+jQn81AXayokr2pp0BtZhIxiNZLohtr1pGCfUd5cHIiKBqOTzMrhajI2L7sJ
         LC5CqjpvrzCSTLd6zMnxyCijH1CCC7Z6gfygOav9C+Lyz2EZ2o+WSSG2C7rvqoFtFO
         dugTR38i6ArC229yb8b0IweRDZtwvubXeqBkgjQE=
Message-ID: <8362bf44-f933-4a7e-9e56-a7c425a2ba5a@linux.microsoft.com>
Date:   Thu, 7 Dec 2023 18:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mhkelley58@gmail.com" <mhkelley58@gmail.com>,
        "Cui, Dexuan" <decui@microsoft.com>
Cc:     "cascardo@canonical.com" <cascardo@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
 <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
 <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
 <7b725783f1f9102c176737667bfec12f75099961.camel@intel.com>
 <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
 <59bdfee24a9c0f7656f7c83e65789d72ab203edc.camel@intel.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <59bdfee24a9c0f7656f7c83e65789d72ab203edc.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 13:58, Huang, Kai wrote:
>>
>> That's how it currently works - all the enlightenments are in hypervisor/paravisor
>> specific code in arch/x86/hyperv and drivers/hv and the vm is not marked with
>> X86_FEATURE_TDX_GUEST.
> 
> And I believe there's a reason that the VM is not marked as TDX guest.
Yes, as Elena said:
"""
OK, so in your case it is a decision of L1 VMM not to set the TDX_CPUID_LEAF_ID
to reflect that it is a tdx guest and it is on purpose because you want to 
drop into a special tdx guest, i.e. partitioned guest. 
"""
TDX does not provide a means to let the partitioned guest know that it needs to
cooperate with the paravisor (e.g. because TDVMCALLs are routed to L0) so this is
exposed in a paravisor specific way (cpuids in patch 1).

> 
>>
>> But without X86_FEATURE_TDX_GUEST userspace has no unified way to discover that an
>> environment is protected by TDX and also the VM gets classified as "AMD SEV" in dmesg.
>> This is due to CC_ATTR_GUEST_MEM_ENCRYPT being set but X86_FEATURE_TDX_GUEST not.
> 
> Can you provide more information about what does _userspace_ do here?

I gave one usecase in a different email. A workload scheduler like Kubernetes might want to
place a workload in a confidential environment, and needs a way to determine that a VM is
TDX protected (or SNP protected) to make that placement decision.

> 
> What's the difference if it sees a TDX guest or a normal non-coco guest in
> /proc/cpuinfo?
> 
> Looks the whole purpose of this series is to make userspace happy by advertising
> TDX guest to /proc/cpuinfo.  But if we do that we will have bad side-effect in
> the kernel so that we need to do things in your patch 2/3.
> 

Yes, exactly. It's unifying the two approaches so that userspace doesn't have to
care.

> That doesn't seem very convincing.

Why not? 
The whole point of the kernel is to provide a unified interface to userspace and
abstract away these small differences. Yes it requires some kernel code to do,
thats not a reason to force every userspace to implement its own logic. This is
what the flags in /proc/cpuinfo are for.

> Is there any other way that userspace can
> utilize, e.g., any HV hypervisor/paravisor specific attributes that are exposed
> to userspace?
> 

There are no HV hyper-/para-visor attributes exposed to userspace directly, but
userspace can poke at the same cpuid bits as in patch 1 to make this determination.
Not great for confidential computing adoption.

